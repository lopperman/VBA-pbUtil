Attribute VB_Name = "pbCommon"
' ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ '
' pbCommon v1.0.0
' (c) Paul Brower - https://github.com/lopperman/VBA-pbUtil
'
' Enums, Constants, Types, Common Utilities
'
' @module pbCommon
' @author Paul Brower
' @license GNU General Public License v3.0
' ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ '
Option Explicit
Option Compare Text
Option Base 1

' ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ '
'   GENERALIZED CONSTANTS
' ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ '
Public Const CFG_PROTECT_PASSWORD As String = "00000"
Public Const CFG_PROTECT_PASSWORD_EXPORT As String = "000001"
Public Const CFG_PROTECT_PASSWORD_MISC As String = "0000015"
Public Const CFG_P_LOG As String = "0000016"

' ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ '
'   GENERALIZED TYPES
' ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ '
    Public Type KVP
      KEY As String
      value As Variant
    End Type


    Public Enum DateDiffType
        dtSecond
        dtMinute
        dtHour
        dtday
        dtWeek
        dtMonth
        dtYear
        dtQuarter
        dtDayOfYear
        dtWeekday
        dtDate_NoTime
    End Enum

    Public Enum NullableBool
        [_Default] = 0
        triNULL = 0
        triTRUE = 1
        triFALSE = 2
    End Enum

Public Enum ExtendedBool
    ebTRUE = 2 ^ 0
    ebFALSE = 2 ^ 1
    ebPartial = 2 ^ 2
    ebERROR = 2 ^ 3
    ebNULL = 2 ^ 4
End Enum

Public Enum CopyOptions
    [_coError] = 0
    'Modifies What's Being Copied
    coFormulas = 2 ^ 0
    coVisibleCellsOnly = 2 ^ 1
    coUniqueRows = 2 ^ 2
    coUniqueCols = 2 ^ 3
    
    'Modifies Target Structure
    coIncludeListObjHeaders = 2 ^ 4 'Valid LstObj, and LstObjCols only
    coCreateListObj = 2 ^ 5
    coPullRowsTogether = 2 ^ 6 'Only Valid Range w/multiple disparate areas
    coPullColsTogether = 2 ^ 7 'Only ValidRange w/multiple disparate areas, OR LstCols with disparate cols
    
    'Modifies Format
    coMatchFontStyle = 2 ^ 8
    coMatchInterior = 2 ^ 9
    coMatchRowColSize = 2 ^ 10
    coMatchMergeAreas = 2 ^ 11
    coMatchLockedCells = 2 ^ 12
    
    coDROPUnmatchedLstObjCols = 2 ^ 13
    coClearTargetLstObj = 2 ^ 14
    coManualLstObjMap = 2 ^ 15
    
    'Create Destination
    coNewWorkbook = 2 ^ 16
End Enum
Public Enum CopyTo
    ftRange
    ftListObj
    ftListObjCols
    toNewWorksheet
    toNewWorkbook
End Enum

Public Enum PicklistMode
    plSingle = 0
    plMultiple_MinimumNone = -1
    plMultiple_MinimumOne = 1
End Enum

Public Enum ecComparisonType
    ecOR = 0 'default
    ecAnd
End Enum

Public Enum MergeRangeEnum
    mrDefault_MergeAll = 0
    mrUnprotect = 2 ^ 0
    mrClearFormatting = 2 ^ 1
    mrClearContents = 2 ^ 2
    mrMergeAcrossOnly = 2 ^ 3
End Enum

Public Type ftFound
    matchExactFirstIDX As Long
    matchExactLastIDX As Long
    matchSmallerIDX As Long
    matchLargerIDX As Long
    realRowFirst As Long
    realRowLast As Long
    realRowSmaller As Long
    realRowLarger As Long
End Type
Public Enum InitActionEnum
    [_DefaultInvalid] = 0
    iaAutoCode
    iaEventResponse
    iaButtonClick
    iaManual
End Enum

Public Enum ReportPeriod
    frpDay = 1
    frpWeek = 2
    frpGLPeriod = 3
    frpCalMonth = 4
End Enum

Public Enum strMatchEnum
    smEqual = 0
    smNotEqualTo = 1
    smContains = 2
    smStartsWithStr = 3
    smEndWithStr = 4
End Enum

Public Type LocationStart
    Left As Long
    Top As Long
End Type

Public Type ArrInformation
    Rows As Long
    Columns As Long
    Dimensions As Long
    Ubound_first As Long
    LBound_first As Long
    UBound_second As Long
    LBound_second As Long
    IsArray As Boolean
End Type
Public Type AreaStruct
    RowStart As Long
    RowEnd As Long
    ColStart As Long
    ColEnd As Long
    rowCount As Long
    columnCount As Long
End Type
Public Type RngInfo
    Rows As Long
    Columns As Long
    AreasSameRows As Boolean
    AreasSameColumns As Boolean
    Areas As Long
End Type



' ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ '
'   GENERALIZED ENUMS
' ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ '
Public Enum ftOperatingState
    [_ftunknown] = -1
    ftOpening = 0
    ftRunning = 1
    ftClosing = 2
    ftUpgrading = 3
    ftResetting = 4
    ftImporting = 5
End Enum

Public Enum ProtectionTemplate
    ptDefault = 0
    ptAllowFilterSort = 1
    ptDenyFilterSort = 2
    ptCustom = 3
End Enum

Public Enum ProtectionPWD
    pwStandard = 1
    pwExport = 2
    pwMisc = 3
    pwLog = 4
End Enum

Public Enum SheetProtection
    psContents = 2 ^ 0
    psUsePassword = 2 ^ 1
    psDrawingObjects = 2 ^ 2
    psScenarios = 2 ^ 3
    psUserInterfaceOnly = 2 ^ 4
    psAllowFormattingCells = 2 ^ 5
    psAllowFormattingColumns = 2 ^ 6
    psAllowFormattingRows = 2 ^ 7
    psAllowInsertingColumns = 2 ^ 8
    psAllowInsertingRows = 2 ^ 9
    psAllowInsertingHyperlinks = 2 ^ 10
    psAllowDeletingColumns = 2 ^ 11
    psAllowDeletingRows = 2 ^ 12
    psAllowSorting = 2 ^ 13
    psAllowFiltering = 2 ^ 14
    psAllowUsingPivotTables = 2 ^ 15
    
End Enum

Public Enum RangeFunctionOperator
    Min = 1
    Max = 2
    Sum = 3
    Count = 4
    CountUnique = 5
    CountBlank = 6
End Enum

Public Enum btnLocationEnum
    Beneath = 1
    ToTheRight
End Enum


Public Enum color
    Aqua = 42
    Black = 1
    Blue = 5
    BlueGray = 47
    BrightGreen = 4
    Brown = 53
    cream = 19
    DarkBlue = 11
    DarkGreen = 51
    DarkPurple = 21
    DarkRed = 9
    DarkTeal = 49
    DarkYellow = 12
    Gold = 44
    Gray25 = 15
    Gray40 = 48
    Gray50 = 16
    Gray80 = 56
    Green = 10
    Indigo = 55
    Lavender = 39
    LightBlue = 41
    LIGHtgreen = 35
    LightLavender = 24
    LightOrange = 45
    LightTurquoise = 20
    LightYellow = 36
    Lime = 43
    NavyBlue = 23
    OliveGreen = 52
    Orange = 46
    PaleBlue = 37
    Pink = 7
    Plum = 18
    PowderBlue = 17
    red = 3
    Rose = 38
    SALMON = 22
    SeaGreen = 50
    SkyBlue = 33
    Tan = 40
    Teal = 14
    Turquoise = 8
    Violet = 13
    White = 2
    Yellow = 6
End Enum

Public Enum ftInputBoxType
    ftibFormula = 0
    ftibNumber = 1
    ftibString = 2
    ftibLogicalValue = 4
    ftibCellReference = 8
    ftibErrorValue = 16
    ftibArrayOfValues = 64
End Enum

Public Enum BusyState
    bsUnknown = -1
    bsOpening = 1
    bsClosing = 2
    bsRunning = 3
End Enum

Public Enum ListReturnType
    lrtArray = 1
    lrtDictionary = 2
    lrtCollection = 3
End Enum

Public Enum AllocationReportType
    artFirstOfMonth = 1
    artLastOfMonth = 2
    artFirstOrLastOfMonth = 3
End Enum

Public Enum XMatchMode
    ExactMatch = 0
    ExactMatchOrNextSmaller = -1
    ExactMatchOrNextLarger = 1
    WildcardCharacterMatch = 2
End Enum

Public Enum XSearchMode
    searchFirstToLast = 1
    searchLastToFirst = -1
    searchBinaryAsc = 2
    searchBinaryDesc = -2
End Enum
Public Enum ftActionType
    ftaADD = 1
    ftaEDIT
    ftaDELETE
End Enum

Public Enum MatchTypeEnum
    mtAll = 1
    mtAny = 2
    mtNONE = 3
End Enum

Public Enum ListObjCompareEnum
    locName = 2 ^ 0
    locColumnCount = 2 ^ 1
    locColumnNames = 2 ^ 2
    locColumnOrder = 2 ^ 3
    locRowCount = 2 ^ 4
End Enum

Public Enum ArrayOptionFlags
    aoNone = 0
    aoUnique = 2 ^ 0
    aoUniqueNoSort = 2 ^ 1
    aoAreaSizesMustMatch = 2 ^ 2
    'implement aoAreaMustMatchRows
    'implement aoAreasMustMatchCols
    aoVisibleRangeOnly = 2 ^ 3
    aoIncludeListObjHeaderRow = 2 ^ 4
End Enum

Public Enum CHSuppEnum
    chNONE = 0
    chForceFullUpdate = 2 ^ 0
    chUpdateAllColumns = 2 ^ 1
    chSpecificRange = 2 ^ 2
    chCalcAllAtOnce = 2 ^ 3
End Enum

Public Enum TempFolderEnum
    tfSettings = 1
    tfDeploymentFiles = 2
    tfProdRelease = 3
    tfBetaRelease = 4
    tfTestRelease = 4 'this is not a mistake!
End Enum
Public Enum ftTrigger
    ftButtonAction = 1
    ftUserEvent = 2
End Enum
Public Enum ftMinMax
    minValue = 1
    maxValue = 2
End Enum
Public Enum HolidayEnum
    holidayName = 1
    holidayDT = 2
End Enum
Public Enum HolCalendars
    hcCallId = 1
    hcDescription
    hcHolidayName
    hcHolidayDt
    hcDayOfWeek
End Enum
Public Enum BeepType
    btMsgBoxOK = 0
    btMsgBoxChoice = 1
    btError = 2
    btBusyWait = 3
    btButton = 4
    btForced = 5
End Enum

Private lBypassOnCloseCheck As Boolean
Private logUploadPath As String




'   ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~
'   ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~
'                                   PRIVATE VS OPEN
'   ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~
'   ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~
#If privateVersion Then
'   ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~
'                   *** PRIVATE *** IMPLEMENTATION OF COMMON FUNCTIONS
'   ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~

    Public Function ProtectSht(ByRef ws As Worksheet, Optional ByVal forceProtect As Boolean = False) As Boolean
        ProtectSht = ProtectShtPriv(ws, forceProtect:=forceProtect)
    End Function
    Public Function UnprotectSht(ByRef ws As Worksheet) As Boolean
        UnprotectSht = UnprotectSHTPriv(ws)
    End Function
    Public Property Get byPassOnCloseCheck() As Boolean
        byPassOnCloseCheck = lBypassOnCloseCheck
        If IsUpgrader Then byPassOnCloseCheck = True
    End Property
    Public Property Let byPassOnCloseCheck(bypassCheck As Boolean)
        lBypassOnCloseCheck = bypassCheck
    End Property
    Public Property Get DevUserNames() As String
        DevUserNames = DEV_USERNAME
    End Property
    Public Sub ftBeep(bpType As BeepType)
        Dim doBeep    As Boolean
        Select Case bpType
            Case BeepType.btMsgBoxOK
                doBeep = (Setting2(seBeepMsgBoxOK) = True)
            Case BeepType.btError, BeepType.btForced
                doBeep = True
            Case BeepType.btMsgBoxChoice
                doBeep = (Setting2(seBeepMsgBoxChoice) = True)
            Case BeepType.btBusyWait
                doBeep = (Setting2(seBeepBusyWait) = True)
            Case BeepType.btButton
                doBeep = (Setting2(seBeepButton) = True)
        End Select
        If doBeep Then
            Beep
        End If
    End Sub
    Public Property Get LogFileUploadPath() As String
        If Len(logUploadPath) = 0 Then logUploadPath = Setting2(seLogFileUploadPath)
        LogFileUploadPath = logUploadPath
    End Property
    Public Property Get AppVersion() As Variant
        AppVersion = FinToolVersion
    End Property
    


'   ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~
'                   *** END PRIVATE *** IMPLEMENTATION OF COMMON FUNCTIONS
'   ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~
#Else
'   ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~
'                   *** PUBLIC *** IMPLEMENTATION OF COMMON FUNCTIONS
'   ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~
    Public Function ProtectSht(ByRef ws As Worksheet, Optional ByVal forceProtect As Boolean = False) As Boolean
        ProtectSht = True
        Debug.Print "pbCommon.ProtectSht - Not Implemented in Open Source Version"
    End Function
    Public Function UnprotectSht(ByRef ws As Worksheet) As Boolean
        UnprotectSht = True
        Debug.Print "pbCommon.UnprotectSht - Not Implemented in Open Source Version"
    End Function
    Public Property Get byPassOnCloseCheck() As Boolean
        byPassOnCloseCheck = lBypassOnCloseCheck
    End Property
    Public Property Let byPassOnCloseCheck(bypassCheck As Boolean)
        lBypassOnCloseCheck = bypassCheck
    End Property
    Public Property Get DevUserNames() As String
        DevUserNames = "*"
    End Property
    Public Sub ftBeep(bpType As BeepType)
        Dim doBeep    As Boolean
        Select Case bpType
            Case BeepType.btMsgBoxOK
            Case BeepType.btError, BeepType.btForced
            Case BeepType.btMsgBoxChoice
            Case BeepType.btBusyWait
            Case BeepType.btButton
        End Select
        Beep
    End Sub
    Public Property Get LogFileUploadPath() As String
        Err.Raise ERR_NOT_IMPLEMENTED_YET, Source:="pbCommon.LogFileUploadPath"
    End Property
    Public Property Get AppVersion() As Variant
        AppVersion = CDbl(1)
        Err.Raise ERR_NOT_IMPLEMENTED_YET, Source:="pbCommon.AppVersion"
    End Property
    
    

'   ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~
'                   *** END PUBLIC *** IMPLEMENTATION OF COMMON FUNCTIONS
'   ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~ ~~~
#End If




Public Property Get IsDEV() As Boolean
    Dim retV As Boolean
    Dim devNames() As Variant
    devNames = ArrArray(Split(DevUserNames, "|", , vbTextCompare), aoNone)
    Dim ai As ArrInformation
    ai = ArrayInfo(devNames)
    If ai.Dimensions > 0 Then
        Dim i As Long
        For i = ai.LBound_first To ai.Ubound_first
            If StringsMatch(ENV_LogName, Trim(devNames(i, 1)), smContains) Then
                retV = True
                Exit For
            End If
        Next i
    End If
    IsDEV = retV
    If Not IsDeveloper = retV Then IsDeveloper = retV
End Property




