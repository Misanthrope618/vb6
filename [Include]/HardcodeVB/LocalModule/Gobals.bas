Attribute VB_Name = "MGlobals"
Option Explicit

' Anything shared by all of VBCore

Private sys As New CSystem
Private vid As New CVideo
Private kbd As New CKeyboard
' Put other global variables and objects here

Property Get System()
    Set System = sys
End Property

Property Get Video()
    Set Video = vid
End Property

Property Get Keyboard()
    Set Keyboard = kbd
End Property

