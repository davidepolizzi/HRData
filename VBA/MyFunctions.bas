Attribute VB_Name = "MyFunctions"
Option Explicit

Function MyDateAdd(myInterval As String, myNumber As Double, myDate As Date) As Date

MyDateAdd = DateAdd(myInterval, myNumber, myDate)

End Function

Function MyRand(Optional lowb As Long = 0, Optional upb As Long = 1) As Long
Randomize
MyRand = Int((upb - lowb + 1) * Rnd + lowb)
End Function



