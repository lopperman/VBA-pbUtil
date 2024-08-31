VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "pbNudgeRange"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
' ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ '
' ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ '
''
''      *** WORK IN PROGRESS ***
''
''      *** NOT READY FOR GENERAL USE !! ***
''
' ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ '
' ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ '

' ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ '
' ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ '
''      Misc Utilities for 'pushing' and 'pulling' ("nudging") data around
''      specified range(s)
' ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ '
''
''      ** ALL Published VBA Code Is MAC and PCCompatible **
''
''      author (c) Paul Brower https://github.com/lopperman/just-VBA
''      class module pbNudgeRange.cls
''      license GNU General Public License v3.0
''      Created Aug-2024
''
''      Download pbNudgeRange.cls with NO DEPENDENCIES at
''      https://github.com/lopperman/just-VBA/blob/main/Code_NoDependencies/pbNudgeRange.cls
''
' ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ '
' ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ '
Option Explicit
Option Compare Text
Option Base 1

    Public Enum NudgeOptions
        ndOPTIONS_NOT_SET = 0
        ndFillByRow = &H1
        ndFillByColumn = &H2
        ndFillBottomUp = &H4
        ndFillRightLeft = &H8
        ndOnCompleteDeleteBlankRows = &H10
        ndOnCompleteDeleteBlankCols = &H20
'        nd = &H40
'        nd = &H80
'        nd = &H100
'        nd = &H200
'        nd = &H400
'        nd = &H800
'        nd = &H1000
'        nd = &H2000
'        nd = &H4000
'        nd = &H8000&
    End Enum


    Private Enum strMatchEnum
        smEqual = 0
        smNotEqualTo = 1
        smContains = 2
        smStartsWithStr = 3
        smEndWithStr = 4
    End Enum

Private l_logMessages As Collection
Private l_options As Collection


' ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ '
' ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ '
''      EVENTS
' ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ '
' ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ '

' ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ '
''      Raises Event that can be used for logging
''      [logLevel] will be one of the following:
''              "TRACE", "ERROR"
' ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ '
        Public Event OnLogMessage(logLevel As String, msg As String)
''
' ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ '
''      Raised after error occurs
' ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ '
Public Event OnError(ByVal errNumber, ByVal errDescription)

' ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ '
''       Returns all log messages as collection of strings
''      (Does not require 'OnLogMessage' events to be handled)
' ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ '
Public Property Get LogMessages() As Collection
    Set LogMessages = l_logMessages
End Property

Public Function DeleteBlankSheetColumns(wksht As Worksheet)

End Function
Public Function DeleteBlankSheetRows(wksht As Worksheet)

End Function
Public Function AddBlankListRows(lstObj As ListObject, Optional rowCountAdd, Optional rowCountTotal, Optional truncateAllowed As Boolean = False)

End Function
Public Function PutSomething(data, writeAt As Range, Optional canOverwrite As Boolean = False, Optional canInsertCells As Boolean = False, Optional pushDirection As XlDirection)

End Function


' ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ '
''   Returns item from collection by Key
''   If [key] does not exist in collection, error object with
''   error code 1004 is return
''   suggested use:
''
''   Dim colItem as Variant
''   colItem = CollectionItemByKey([collection], [expectedKey])
''
''   'If expecting object, use 'Set'
''    Set colItem = CollectionItemByKey([collection], [expectedKey])
''
''   If Not IsError(colItem) Then
''       'value was returned
''   Else
''       'error was returned
''   End if
' ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ '
Private Function CollectionItemByKey(ByRef col As Collection, ByVal Key)
On Error Resume Next
    Key = CStr(Key)
    If IsObject(col(Key)) Then
        If Err.number = 0 Then
            Set CollectionItemByKey = col(Key)
        End If
    Else
        If Err.number = 0 Then
            CollectionItemByKey = col(Key)
        End If
    End If
    If Err.number <> 0 Then
        Err.Clear
        CollectionItemByKey = CVErr(1004)
    End If
End Function
Private Function CollectionKeyExists(ByRef col As Collection, ByVal Key)
On Error Resume Next
    Key = CStr(Key)
    If IsObject(col(Key)) Then
        If Err.number = 0 Then
            CollectionKeyExists = True
        Else
            CollectionKeyExists = False
        End If
    Else
        If Err.number = 0 Then
            CollectionKeyExists = True
        Else
            CollectionKeyExists = False
        End If
    End If
    If Err.number <> 0 Then
        Err.Clear
    End If
End Function

    Private Function StringsMatch( _
        ByVal checkString As Variant, ByVal _
        validString As Variant, _
        Optional smEnum As strMatchEnum = strMatchEnum.smEqual, _
        Optional compMethod As VbCompareMethod = vbTextCompare) As Boolean
         
    '       IF NEEDED, PUT THIS ENUM AT TOP OF A STANDARD MODULE
            'Public Enum strMatchEnum
            '    smEqual = 0
            '    smNotEqualTo = 1
            '    smContains = 2
            '    smStartsWithStr = 3
            '    smEndWithStr = 4
            'End Enum
            
        Dim str1, str2
            
        str1 = CStr(checkString)
        str2 = CStr(validString)
        Select Case smEnum
            Case strMatchEnum.smEqual
                StringsMatch = StrComp(str1, str2, compMethod) = 0
            Case strMatchEnum.smNotEqualTo
                StringsMatch = StrComp(str1, str2, compMethod) <> 0
            Case strMatchEnum.smContains
                StringsMatch = InStr(1, str1, str2, compMethod) > 0
            Case strMatchEnum.smStartsWithStr
                StringsMatch = InStr(1, str1, str2, compMethod) = 1
            Case strMatchEnum.smEndWithStr
                If Len(str2) > Len(str1) Then
                    StringsMatch = False
                Else
                    StringsMatch = InStr(Len(str1) - Len(str2) + 1, str1, str2, compMethod) = Len(str1) - Len(str2) + 1
                End If
        End Select
    End Function

    Private Function MaxV(Val1, Val2)
        If Val1 > Val2 Then
            MaxV = Val1
        Else
            MaxV = Val2
        End If
    End Function
    
    Public Function MinV(Val1, Val2)
        If Val1 > Val2 Then
            MinV = Val2
        Else
            MinV = Val1
        End If
    End Function

Private Function TimeStamp() As String
    TimeStamp = Format(Now, "yyyymmdd hh:mm:ss") & Right(Format(Timer, "0.000"), 4)
End Function

Private Function OnErrorRaise(errNumber, errMessage As String)
    OnLog "ERROR", errMessage
    RaiseEvent OnError(errNumber, errMessage)
    Err.Raise errNumber, Source:=Me, Description:=errMessage
End Function

Private Function OnLog(logLvl As String, msg As String)
    l_logMessages.add TimeStamp & " " & UCase(logLvl) & " " & msg
    RaiseEvent OnLogMessage(logLvl, msg)
End Function

Private Sub Class_Initialize()
    Set l_logMessages = New Collection
    Set l_options = New Collection
End Sub