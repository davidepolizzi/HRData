VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} UF 
   Caption         =   "HR Data Parameters"
   ClientHeight    =   8175
   ClientLeft      =   180
   ClientTop       =   708
   ClientWidth     =   13776
   OleObjectBlob   =   "UF.frx":0000
   StartUpPosition =   1  'CenterOwner
End
Attribute VB_Name = "UF"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub btn_Reset_Click()
txt_Emp.Value = 500
txt_Change.Value = 2
txt_Period.Value = 2
txt_StartYear.Value = 2015
cb_Gender = False
cb_Race = False
End Sub

Private Sub btn_Submit_Click()
Dim dbltimer As Double
dbltimer = Timer()
Call InitialSetUp.SetParameters

Me.Hide

InitialSetUp.Main
MsgBox "Done data creation. Time elapsed: " & Timer() - dbltimer
Sheet4.Activate

If UF.cb_Export Then UFExport.Show

End Sub



Private Sub spn_Change_Change()
txt_Change.Value = (spn_Change.Value / 1)
End Sub

Private Sub spn_Emp_Change()
txt_Emp.Value = spn_Emp.Value
End Sub

Private Sub spn_Period_Change()
txt_Period.Value = spn_Period.Value
End Sub

Private Sub spn_StartYear_Change()
txt_StartYear.Value = spn_StartYear.Value
End Sub
