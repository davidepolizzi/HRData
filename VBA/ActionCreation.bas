Attribute VB_Name = "ActionCreation"
Option Explicit

Sub AddAction(fdActionID As Byte, fdEmp As Long, fdDate As Date, Optional fdTermDt As Date = #12/31/9999#)
Dim lrAct As ListRow

If fdDate > fdTermDt Then Exit Sub
Set lrAct = lsAct.ListRows.Add

With lrAct
    .Range(1, lsAct.ListColumns("ActionID").Index) = fdActionID
    .Range(1, lsAct.ListColumns("EmpID").Index) = fdEmp
    .Range(1, lsAct.ListColumns("EffectiveDt").Index) = fdDate
End With

End Sub

Sub GenerateAttrition()
Dim empCount As Long
Dim lrFlow
Dim termDt As Date

For perCount = 0 To periods
        For empCount = 0 To lsEmp.ListRows.count * pctChange
            Set lrFlow = lsEmp.ListRows(Int(lsEmp.ListRows.count * Rnd + 1))
            With lrFlow
                'assign a termination date starts from startdate tp June, and a SD of 90 days
                termDt = Int(WorksheetFunction.Norm_Inv(Rnd, dtStart + 180 + (perCount * 365.25), 90))
                If termDt > .Range(1, lsEmp.ListColumns("EngDt").Index) Then
                    .Range(1, lsEmp.ListColumns("TermDt").Index) = termDt
                    Call AddAction(90 + Round(Rnd()), .Range(1, lsEmp.ListColumns("EmpID").Index), termDt)
                End If
            End With
            EmpCreation.MakeEmp WorksheetFunction.Max(lsEmp.ListColumns("EmpID").DataBodyRange.Value2) + 1, WorksheetFunction.Max(dtStart, Int(WorksheetFunction.Norm_Inv(Rnd, dtStart + 180 + (perCount * 365.25), 90)))
        Next empCount
Next perCount
End Sub

Sub GenerateRating(perfYear As Date)
Dim arrPerf()
Dim empCount As Long
Dim totEmp As Long
Dim N As Long
Dim temp As Variant
Dim J As Long
Dim perfLr As ListRow
Dim empLr As ListRow

totEmp = lsEmp.ListRows.count
ReDim arrPerf(lsEmp.ListRows.count - 1)

For empCount = 0 To totEmp
    Select Case empCount
    Case Is < (totEmp * 0.1)
        arrPerf(empCount) = 5
    Case Is < totEmp * 0.3
        arrPerf(empCount) = 4
    Case Is < totEmp * 0.7
        arrPerf(empCount) = 3
    Case Is < totEmp * 0.9
        arrPerf(empCount) = 2
    Case Is < totEmp
        arrPerf(empCount) = 1
    Case Else
    End Select
Next empCount

Randomize
For N = 0 To totEmp - 1
    J = CLng((totEmp - 1) * Rnd)
    If N <> J Then
        temp = arrPerf(N)
        arrPerf(N) = arrPerf(J)
        arrPerf(J) = temp
    End If
Next N

empCount = 0
For Each empLr In lsEmp.ListRows
    If empLr.Range(1, lsEmp.ListColumns("EngDt").Index) < perfYear And (empLr.Range(1, lsEmp.ListColumns("TermDt").Index) > perfYear Or empLr.Range(1, lsEmp.ListColumns("TermDt").Index) = "") Then
        Set perfLr = lsPerf.ListRows.Add
            With perfLr
                .Range(1, lsPerf.ListColumns("EmpID").Index) = empLr.Range(1, lsEmp.ListColumns("EmpID").Index)
                'add gender bias
                If empLr.Range(1, lsEmp.ListColumns("GenderID").Index) = 1 And bolGenderBias Then
                    .Range(1, lsPerf.ListColumns("Rating").Index) = WorksheetFunction.Min(5, arrPerf(empCount) + WorksheetFunction.Max(0, Round(Rnd() - 0)))
                Else
                    .Range(1, lsPerf.ListColumns("Rating").Index) = arrPerf(empCount)
                End If
                .Range(1, lsPerf.ListColumns("PerfDate").Index) = perfYear
            End With
    End If
empCount = empCount + 1
Next empLr

End Sub

Sub CheckPromotion(promYear As Integer)
'---------------
Dim i As Long
Set lsEmp = Sheet1.Range("tbl_Employee").ListObject
Set lsFName = Sheet3.Range("tbl_FirstName").ListObject
Set lsLName = Sheet3.Range("tbl_LastName").ListObject
Set lsDep = Sheet2.Range("tbl_DepID").ListObject
Set lsRace = Sheet2.Range("tbl_RaceID").ListObject
Set lsAct = Sheet6.Range("tbl_Action").ListObject
Set lsPerf = Sheet8.Range("tbl_Perf").ListObject
'-----------------
Dim bytCurYear  As Byte
Dim bytPreYear As Byte
Dim ixEmpID As Byte
Dim ixRating As Byte
Dim ixPerfDate As Byte
Dim sglBias As Single

Dim lrEmp As ListRow
varPerf = lsPerf.DataBodyRange


ixEmpID = lsPerf.ListColumns("EmpId").Index
ixRating = lsPerf.ListColumns("Rating").Index
ixPerfDate = lsPerf.ListColumns("PerfDate").Index


For Each lrEmp In lsEmp.ListRows
    For i = LBound(varPerf) To UBound(varPerf)
        If varPerf(i, ixEmpID) = lrEmp.Range(1, lsEmp.ListColumns("EmpID").Index) Then
            If DatePart("YYYY", varPerf(i, ixPerfDate)) = promYear Then bytCurYear = varPerf(i, ixRating)
            If DatePart("YYYY", varPerf(i, ixPerfDate)) = promYear - 1 Then bytPreYear = varPerf(i, ixRating)
        End If
    Next i
Dim temp As Double
    'add gender bias
    sglBias = 0
    If lrEmp.Range(1, lsEmp.ListColumns("RaceId").Index) = 1 And bolRaceBias Then sglBias = 0.15
    If ((bytCurYear + bytPreYear) / 10) + WorksheetFunction.RoundUp(Rnd() - 0.3, 0) / 5 > (0.8 - sglBias) Then
        Call AddAction(30, lrEmp.Range(1, lsEmp.ListColumns("EmpID").Index), Int(WorksheetFunction.Norm_Inv(Rnd, DateSerial(promYear + 1, 6, 30), 90)), lrEmp.Range(1, lsEmp.ListColumns("TermDt").Index))
    End If
Next lrEmp
End Sub

Sub test()
Call CheckPromotion(2011)
End Sub

