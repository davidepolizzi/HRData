Attribute VB_Name = "InitialSetUp"
Option Explicit

Public lsEmp As ListObject, lsAct As ListObject, lsPerf As ListObject
Public lsFName As ListObject, lsLName As ListObject, lsDep As ListObject, lsRace As ListObject, lsGender As ListObject, lsActID As ListObject
Public varEmp As Variant, varPerf As Variant
Public FNameCoutn As Long, LNameCoutn As Long, DepCount As Long

Public dtStart As Date
Public totEmp As Long
Public pctChange As Single
Public periods As Byte
Public bolGenderBias As Boolean
Public bolRaceBias As Boolean

Public perCount As Byte
Public depArray(1 To 10, 1 To 3)
Public collFixTables As New Collection
Public collGeneratedTables As New Collection

Sub Main()

If collFixTables.Count = 0 Or collGeneratedTables.Count = 0 Then Call SetTables
Randomize
Dim i As Long

Erase depArray
FNameCoutn = lsFName.ListRows.Count
LNameCoutn = lsLName.ListRows.Count
DepCount = WorksheetFunction.Min((totEmp / 30), 10)

If lsEmp.ListRows.Count >= 1 Then lsEmp.DataBodyRange.Delete
If lsAct.ListRows.Count >= 1 Then lsAct.DataBodyRange.Delete
If lsPerf.ListRows.Count >= 1 Then lsPerf.DataBodyRange.Delete
'Create initial Emp List
Application.StatusBar = "Making Employees"
For i = 1 To totEmp
    Call MakeEmp(i)
Next i


Call SetPayRate
''Add Pay rate 100/level
''adjust pay rate based on eng date & DOB?
''adjust based on department?

GenerateAttrition  ''influence attrition based on payrate?
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


End Sub

Sub SetParameters()
dtStart = CDate("1/1/" & UF.txt_StartYear)  '#1/1/2015#
totEmp = UF.txt_Emp '1000
pctChange = UF.txt_Change / 100 '0.05
periods = UF.txt_Period '4
bolGenderBias = UF.cb_Gender
bolRaceBias = UF.cb_Race

End Sub

Sub SetTables()
Set lsFName = Sheet3.Range("tbl_FirstName").ListObject
collFixTables.Add lsFName

Set lsLName = Sheet3.Range("tbl_LastName").ListObject
collFixTables.Add lsLName

Set lsDep = Sheet2.Range("tbl_DepID").ListObject
collFixTables.Add lsDep

Set lsRace = Sheet2.Range("tbl_RaceID").ListObject
collFixTables.Add lsRace

Set lsGender = Sheet2.Range("tbl_GenderID").ListObject
collFixTables.Add lsGender

Set lsGender = Sheet2.Range("tbl_ActID").ListObject
collFixTables.Add lsActID

Set lsEmp = Sheet1.Range("tbl_Employee").ListObject
collGeneratedTables.Add lsEmp

Set lsAct = Sheet6.Range("tbl_Action").ListObject
collGeneratedTables.Add lsAct

Set lsPerf = Sheet8.Range("tbl_Perf").ListObject
collGeneratedTables.Add lsPerf

End Sub
