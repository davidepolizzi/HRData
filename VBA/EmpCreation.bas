Attribute VB_Name = "EmpCreation"
Option Explicit

Sub MakeEmp(id As Long, Optional EngDt As Date)
Dim lrEmp As ListRow

Dim depID As Byte
depID = Int((DepCoutn) * Rnd + 1)
  
Dim GenderID As Byte
GenderID = Round(Rnd(), 0)

'Dim EngDt As Date
If EngDt = 0 Then EngDt = WorksheetFunction.Max(dtStart, Int(WorksheetFunction.Norm_Inv(Rnd, dtStart, 365)))

Dim DOB As Date
'normal distribution mean: eng date - 40 years, stdev 10 years. at least 20 years at time of engagement
DOB = WorksheetFunction.Min(EngDt - 7300, Int(WorksheetFunction.Norm_Inv(Rnd, EngDt - 14600, 3650)))

Dim MgrID As Long
Dim Level As Byte
If depArray(depID, 1) = 0 Then
    depArray(depID, 1) = id
    depArray(depID, 2) = 1
    MgrID = id
    Level = 1
ElseIf depArray(depID, 2) > 5 Then
    depArray(depID, 1) = depArray(depID, 3)
    depArray(depID, 2) = 1
    MgrID = depArray(depID, 3)
Else
    depArray(depID, 3) = id
    depArray(depID, 2) = depArray(depID, 2) + 1
    MgrID = depArray(depID, 1)
End If

    Set lrEmp = lsEmp.ListRows.Add
    With lrEmp
        .Range(1, lsEmp.ListColumns("EmpID").Index) = id
        .Range(1, lsEmp.ListColumns("GenderID").Index) = GenderID
        .Range(1, lsEmp.ListColumns("EmpName").Index) = EmpName(GenderID)
        .Range(1, lsEmp.ListColumns("DepID").Index) = depID
        .Range(1, lsEmp.ListColumns("RaceID").Index) = Int(5 * Rnd + 1)
        .Range(1, lsEmp.ListColumns("EngDt").Index) = EngDt
        .Range(1, lsEmp.ListColumns("DOB").Index) = DOB
        .Range(1, lsEmp.ListColumns("MgrID").Index) = MgrID
    End With

    Call ActionCreation.AddAction(10, id, EngDt)
End Sub

Function EmpName(GenderID As Byte) As String
Dim strName As String

strName = lsLName.ListRows(Int((LNameCoutn) * Rnd + 1)).Range.Value2
strName = strName & ", "
strName = strName & lsFName.ListRows(Int((FNameCoutn) * Rnd + 1)).Range(1, GenderID + 1).Value2
strName = strName & " " & Chr(Int((90 - 65 + 1) * Rnd + 65))
EmpName = strName
End Function

'Sub CreateHierarchy()
'Dim Emps() As Variant
'Dim EmpsHead() As Variant
'Dim cDeps As Byte
'Dim lrE As ListRow
'
'Emps() = lsEmp.DataBodyRange.Value2
'For cDeps = 1 To WorksheetFunction.Max(lsEmp.ListColumns("DepID").DataBodyRange.Value2)
'    For Each lrE In lsEmp.ListRows
'        If lrE.Range(1, lsEmp.ListColumns("DepID").Index) = cDeps Then
'
'
'
'    Next lrE
'
'Next cDeps
'End Sub
