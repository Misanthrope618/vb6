VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "cStringVentor"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Option Explicit
Private mSize As Long
Private mString() As String
Private hashTable() As Long
Private mInitSize As Long
Private mCount As Long 'local copy
Private hashHandle As cHashTable
Const constInitSize  As Long = 100
Public Sub assign(value As String, Optional index As Long = -1)
If (index < 0) Then index = mCount + 1
If (index > mSize) Then enLargeSize (index - mSize + mInitSize)
If (index > mCount) Then mCount = index
mString(index) = value
hashHandle.Insert value, CStr(index)
End Sub
Public Function index(value As String) As Long
Dim i As Long
Dim iStart As Long
Dim iEnd As Long

On Error Resume Next
Dim arrIndex() As String
hashHandle.value value, arrIndex
iStart = LBound(arrIndex)
iEnd = UBound(arrIndex)
For i = iStart To iEnd
    index = CLng(arrIndex(i))
    If Err = 0 Then
        If mString(index) = value Then Exit Function
    End If
Next
index = 0
End Function
Public Property Get initSize() As Long
initSize = mInitSize
End Property
Public Property Let initSize(inLong As Long)
If inLong < 1 Then Exit Property
initSize = inLong
End Property
Public Function value(index As Long) As String
If index > mCount Then Exit Function
value = mString(index)
End Function
Public Sub clearData()
ReDim mString(1 To mSize) As String
mCount = 0
hashHandle.reset
End Sub
Public Property Get count() As Long
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.count
    count = mCount
End Property
Private Sub enLargeSize(Optional lStep As Long = -1)
If lStep = 0 Then Exit Sub
If lStep < 0 Then lStep = mInitSize
mSize = mSize + lStep
ReDim Preserve mString(1 To mSize) As String
End Sub
Private Sub Class_Initialize()
mInitSize = constInitSize
mSize = mInitSize
ReDim mString(1 To mSize) As String
Set hashHandle = New cHashTable
End Sub

Private Sub Class_Terminate()
Erase mString
Set hashHandle = Nothing
End Sub
