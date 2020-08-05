Attribute VB_Name = "InitialSetUp"
Option Explicit

Public lsEmp As ListObject, lsFName As ListObject, lsLName As ListObject, lsDep As ListObject, lsRace As ListObject, lsAct As ListObject, lsPerf As ListObject
Public varEmp As Variant, varPerf As Variant
Public FNameCoutn As Long, LNameCoutn As Long, DepCoutn As Long
'Public lr As ListRow
'Public Const dtStart As Date = #1/1/2015#
'Public Const totEmp As Long = 1000
'Public Const pctChange As Single = 0.05
'Public Const periods As Byte = 4
'Public Const bolGenderBias As Boolean = True
'Public Const bolRaceBias As Boolean = True

Public dtStart As Date
Public totEmp As Long
Public pctChange As Single
Public periods As Byte
Public bolGenderBias As Boolean
Public bolRaceBias As Boolean

Public perCount As Byte
Public depArray(1 To 10, 1 To 3)

Sub Main()

Randomize
Dim i As Long
Set lsEmp = Sheet1.Range("tbl_Employee").ListObject
Set lsFName = Sheet3.Range("tbl_FirstName").ListObject
Set lsLName = Sheet3.Range("tbl_LastName").ListObject
Set lsDep = Sheet2.Range("tbl_DepID").ListObject
Set lsRace = Sheet2.Range("tbl_RaceID").ListObject
Set lsAct = Sheet6.Range("tbl_Action").ListObject
Set lsPerf = Sheet8.Range("tbl_Perf").ListObject

Erase depArray
FNameCoutn = lsFName.ListRows.count
LNameCoutn = lsLName.ListRows.count
DepCoutn = WorksheetFunction.Min((totEmp / 30), 10)

If lsEmp.ListRows.count >= 1 Then lsEmp.DataBodyRange.Delete
If lsAct.ListRows.count >= 1 Then lsAct.DataBodyRange.Delete
If lsPerf.ListRows.count >= 1 Then lsPerf.DataBodyRange.Delete
'Create initial Emp List
Application.StatusBar = "Making Employees"
For i = 1 To totEmp
    Call MakeEmp(i)
Next i

GenerateAttrition
For perCount = 0 To periods
    GenerateRating (DateAdd("d", -1, DateAdd("yyyy", perCount + 1, dtStart)))
Application.StatusBar = "Generating Ratings period " & perCount & "/" & periods
Next perCount

'periods start from 1 as they relay on two years of top performance. Year 0 and year 1 and following loops
For perCount = 1 To periods
    CheckPromotion (Year(dtStart) + perCount) '(DateAdd("d", -1, DateAdd("yyyy", perCount + 1, dtStart)))
Application.StatusBar = "Generating Promotions period " & perCount & "/" & periods
Next perCount


'Add manager
'CreateHierarchy

MsgBox "DONE"
End Sub

Sub SetParameters()
dtStart = CDate("1/1/" & UF.txt_StartYear)  '#1/1/2015#
totEmp = UF.txt_Emp '1000
pctChange = UF.txt_Change / 100 '0.05
periods = UF.txt_Period '4
bolGenderBias = UF.cb_Gender
bolRaceBias = UF.cb_Race

End Sub
