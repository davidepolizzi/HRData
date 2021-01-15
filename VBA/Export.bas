Attribute VB_Name = "Export"
Option Explicit

Sub ExportMain(Optional exAll As Boolean = False)
Dim t As ListObject
If collFixTables.Count = 0 Or collGeneratedTables.Count = 0 Then Call InitialSetUp.SetTables

If MsgBox("The export files will be generated. Any existing file will with the standard name will be overwritten." & vbNewLine & _
    "Do you want to continue?", vbYesNo, "Possible Overwrite") <> vbYes Then
    MsgBox "No file has been exported"
    Exit Sub
End If

For Each t In collGeneratedTables
    Call SaveToCSV(t)
Next t

If exAll Then
    For Each t In collFixTables
        Call SaveToCSV(t)
    Next t
End If
End Sub

Sub SaveToCSV(tblName As ListObject)
Dim myCSVFileName As String
Dim myWB As Workbook
Dim tempWB As Workbook
Dim rngToSave As Range

Application.DisplayAlerts = False
On Error GoTo err

Set myWB = ThisWorkbook
myCSVFileName = myWB.Path & "\" & tblName.Name & ".csv"
tblName.Range.Copy
Set tempWB = Application.Workbooks.Add(1)

With tempWB
   .Sheets(1).Range("A1").PasteSpecial xlPasteValuesAndNumberFormats
   .SaveAs Filename:=myCSVFileName, FileFormat:=xlCSV, CreateBackup:=False
   .Close
End With
Exit Sub
err:  Application.DisplayAlerts = True
Debug.Print "Issue in the export", tblName.Name
End Sub

