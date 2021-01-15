VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} UFExport 
   Caption         =   "Export Parameters"
   ClientHeight    =   4335
   ClientLeft      =   132
   ClientTop       =   552
   ClientWidth     =   6768
   OleObjectBlob   =   "UFExport.frx":0000
   StartUpPosition =   1  'CenterOwner
End
Attribute VB_Name = "UFExport"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub btn_Submit_Click()
Call Export.ExportMain(cb_sys)
End Sub



Private Sub UserForm_Initialize()
Dim Formats(1 To 2, 1 To 2) As String

Formats(1, 1) = "6"
Formats(1, 2) = "CSV"
Formats(2, 1) = "24"
Formats(2, 2) = "MSDOS CSV"


cb_Format.List = Formats

End Sub
