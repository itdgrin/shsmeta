object fCalcWorkerDepartment: TfCalcWorkerDepartment
  Left = 0
  Top = 0
  Caption = #1056#1072#1089#1095#1077#1090' '#1087#1077#1088#1077#1074#1086#1079#1082#1080' '#1088#1072#1073#1086#1095#1080#1093
  ClientHeight = 354
  ClientWidth = 610
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object grCalc: TJvDBGrid
    Left = 0
    Top = 32
    Width = 610
    Height = 322
    Align = alClient
    DataSource = dsCalc
    DrawingStyle = gdsClassic
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ParentFont = False
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnKeyPress = grCalcKeyPress
    AutoAppend = False
    IniStorage = FormStorage
    AutoSizeColumns = True
    SelectColumnsDialogStrings.Caption = 'Select columns'
    SelectColumnsDialogStrings.OK = '&OK'
    SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
    EditControls = <>
    RowsHeight = 17
    TitleRowHeight = 17
    Columns = <
      item
        Expanded = False
        FieldName = 'NAIMEN'
        Title.Alignment = taCenter
        Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1079#1072#1090#1088#1072#1090
        Width = 182
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CALC'
        Title.Alignment = taCenter
        Title.Caption = #1056#1072#1089#1095#1077#1090
        Width = 319
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TOTAL'
        Title.Alignment = taCenter
        Title.Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100
        Width = 102
        Visible = True
      end>
  end
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 610
    Height = 32
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    ExplicitWidth = 609
    DesignSize = (
      610
      32)
    object lbl4: TLabel
      Left = 8
      Top = 9
      Width = 48
      Height = 13
      Caption = #1057#1086#1089#1090#1072#1074#1080#1083
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object dbedtPREPARER: TDBEdit
      Left = 62
      Top = 6
      Width = 372
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      DataField = 'PREPARER'
      DataSource = dsMain
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      ExplicitWidth = 371
    end
    object chkEnableEditing: TCheckBox
      Left = 440
      Top = 8
      Width = 162
      Height = 17
      Anchors = [akTop, akRight]
      Caption = #1056#1072#1079#1088#1077#1096#1080#1090#1100' '#1088#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = chkEnableEditingClick
      ExplicitLeft = 439
    end
  end
  object dsCalc: TDataSource
    DataSet = qrCalc
    Left = 36
    Top = 150
  end
  object qrCalc: TFDQuery
    BeforePost = qrCalcBeforePost
    AfterPost = qrCalcAfterPost
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FetchOptions.AssignedValues = [evCache]
    FetchOptions.Cache = [fiBlobs, fiMeta]
    FormatOptions.AssignedValues = [fvMapRules, fvDefaultParamDataType, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.OwnMapRules = True
    FormatOptions.MapRules = <
      item
        SourceDataType = dtMemo
        TargetDataType = dtAnsiString
      end
      item
        SourceDataType = dtByteString
        TargetDataType = dtAnsiString
      end
      item
        SourceDataType = dtBCD
        TargetDataType = dtDouble
      end
      item
        SourceDataType = dtBlob
        TargetDataType = dtAnsiString
      end>
    FormatOptions.DefaultParamDataType = ftBCD
    FormatOptions.FmtDisplayNumeric = '### ### ### ##0.###'
    FormatOptions.FmtEditNumeric = '############.###'
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.CheckUpdatable = False
    SQL.Strings = (
      'CALL `CalcWorkerDepartment`(:OBJ_ID, :ID_ESTIMATE);')
    Left = 35
    Top = 94
    ParamData = <
      item
        Name = 'OBJ_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'ID_ESTIMATE'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object FormStorage: TJvFormStorage
    AppStorage = FormMain.AppIni
    AppStoragePath = '%FORM_NAME%\'
    Options = []
    StoredValues = <>
    Left = 32
    Top = 224
  end
  object qrMain: TFDQuery
    OnNewRecord = qrMainNewRecord
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FormatOptions.AssignedValues = [fvFmtDisplayNumeric]
    FormatOptions.FmtDisplayNumeric = '### ### ### ### ### ### ### ### ###'
    SQL.Strings = (
      'SELECT *'
      'FROM worker_deartment'
      'WHERE OBJ_ID=:OBJ_ID'
      '  AND IFNULL(SM_ID, 0) = IFNULL(:SM_ID, 0)')
    Left = 81
    Top = 94
    ParamData = <
      item
        Name = 'OBJ_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'SM_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object dsMain: TDataSource
    DataSet = qrMain
    Left = 80
    Top = 150
  end
end
