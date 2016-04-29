object fCardEstimate: TfCardEstimate
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1050#1072#1088#1090#1086#1095#1082#1072' '#1089#1084#1077#1090#1099
  ClientHeight = 292
  ClientWidth = 604
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    604
    292)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel: TBevel
    Left = 0
    Top = 251
    Width = 604
    Height = 41
    Align = alBottom
    Shape = bsTopLine
    ExplicitTop = 201
    ExplicitWidth = 592
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 604
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 0
    object LabelNumberEstimate: TLabel
      Left = 28
      Top = 6
      Width = 51
      Height = 13
      AutoSize = False
      Caption = #8470' '#1089#1084#1077#1090#1099':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblType: TLabel
      Left = 192
      Top = 7
      Width = 22
      Height = 13
      Caption = #1058#1080#1087':'
    end
    object dbedtSM_NUMBER: TDBEdit
      Left = 86
      Top = 3
      Width = 93
      Height = 21
      Color = 14802912
      DataField = 'SM_NUMBER'
      DataSource = dsMain
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
    end
    object cbbType: TComboBox
      Left = 220
      Top = 3
      Width = 126
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 1
      Text = #1083#1086#1082#1072#1083#1100#1085#1072#1103
      OnCloseUp = cbbTypeCloseUp
      Items.Strings = (
        #1083#1086#1082#1072#1083#1100#1085#1072#1103
        #1055#1053#1056
        #1076#1086#1087'. '#1088#1072#1073#1086#1090#1099
        #1088#1077#1082#1086#1085#1089#1090#1088#1091#1082#1094#1080#1103)
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 147
    Width = 604
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 5
    object LabelNameEstimate: TLabel
      Left = 27
      Top = 5
      Width = 52
      Height = 13
      Caption = #1053#1072#1079#1074#1072#1085#1080#1077':'
    end
    object dbedtNAME: TDBEdit
      Left = 86
      Top = 3
      Width = 515
      Height = 21
      DataField = 'NAME'
      DataSource = dsMain
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 172
    Width = 604
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 6
    object LabelCompose: TLabel
      Left = 27
      Top = 5
      Width = 52
      Height = 13
      Caption = #1057#1086#1089#1090#1072#1074#1080#1083':'
    end
    object LabelPostCompose: TLabel
      Left = 304
      Top = 5
      Width = 61
      Height = 13
      Caption = #1044#1086#1083#1078#1085#1086#1089#1090#1100':'
    end
    object dbedtPREPARER: TDBEdit
      Left = 86
      Top = 2
      Width = 212
      Height = 21
      DataField = 'PREPARER'
      DataSource = dsMain
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object dbedtPOST_PREPARER: TDBEdit
      Left = 371
      Top = 2
      Width = 230
      Height = 21
      DataField = 'POST_PREPARER'
      DataSource = dsMain
      TabOrder = 1
    end
  end
  object Panel4: TPanel
    Left = 0
    Top = 197
    Width = 604
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 7
    object LabelChecked: TLabel
      Left = 26
      Top = 5
      Width = 53
      Height = 13
      Caption = #1055#1088#1086#1074#1077#1088#1080#1083':'
    end
    object LabelPostChecked: TLabel
      Left = 304
      Top = 5
      Width = 61
      Height = 13
      Caption = #1044#1086#1083#1078#1085#1086#1089#1090#1100':'
    end
    object dbedtEXAMINER: TDBEdit
      Left = 86
      Top = 2
      Width = 212
      Height = 21
      DataField = 'EXAMINER'
      DataSource = dsMain
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object dbedtPOST_EXAMINER: TDBEdit
      Left = 371
      Top = 2
      Width = 230
      Height = 21
      DataField = 'POST_EXAMINER'
      DataSource = dsMain
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
  end
  object Panel5: TPanel
    Left = 0
    Top = 222
    Width = 604
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 8
    object LabelSetDrawing: TLabel
      Left = 6
      Top = 5
      Width = 106
      Height = 13
      Caption = #1050#1086#1084#1087#1083#1077#1082#1090' '#1095#1077#1088#1090#1077#1078#1077#1081':'
    end
    object dbedtSET_DRAWINGS: TDBEdit
      Left = 118
      Top = 2
      Width = 483
      Height = 21
      DataField = 'SET_DRAWINGS'
      DataSource = dsMain
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
  end
  object btnSave: TButton
    Left = 390
    Top = 259
    Width = 100
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    Default = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
    OnClick = btnSaveClick
  end
  object btnClose: TButton
    Left = 496
    Top = 259
    Width = 100
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 10
    OnClick = btnCloseClick
  end
  object PanelPart: TPanel
    Left = 0
    Top = 72
    Width = 604
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 2
    object LabelPart: TLabel
      Left = 45
      Top = 5
      Width = 34
      Height = 13
      Caption = #1063#1072#1089#1090#1100':'
    end
    object dblkcbbParts: TDBLookupComboBox
      Left = 86
      Top = 3
      Width = 515
      Height = 21
      DataField = 'PART_ID'
      DataSource = dsMain
      DropDownRows = 20
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      KeyField = 'ID'
      ListField = 'PART_NAME'
      ListSource = dsParts
      ParentFont = False
      TabOrder = 0
    end
  end
  object PanelSection: TPanel
    Left = 0
    Top = 97
    Width = 604
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 3
    object LabelSection: TLabel
      Left = 39
      Top = 5
      Width = 40
      Height = 13
      Caption = #1056#1072#1079#1076#1077#1083':'
    end
    object dblkcbbSections: TDBLookupComboBox
      Left = 86
      Top = 3
      Width = 515
      Height = 21
      DataField = 'SECTION_ID'
      DataSource = dsMain
      DropDownRows = 20
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      KeyField = 'ID'
      ListField = 'Section_NAME'
      ListSource = dsSections
      ParentFont = False
      TabOrder = 0
    end
  end
  object PanelTypeWork: TPanel
    Left = 0
    Top = 122
    Width = 604
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 4
    object LabelTypeWork: TLabel
      Left = 23
      Top = 5
      Width = 56
      Height = 13
      Caption = #1042#1080#1076' '#1088#1072#1073#1086#1090':'
    end
    object dblkcbbTypesWorks: TDBLookupComboBox
      Left = 86
      Top = 3
      Width = 515
      Height = 21
      DataField = 'TYPE_WORK_ID'
      DataSource = dsMain
      DropDownRows = 20
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      KeyField = 'ID'
      ListField = 'TYPE_WORK_NAME'
      ListSource = dsTypesWorks
      ParentFont = False
      TabOrder = 0
    end
  end
  object chkAddChapterNumber: TCheckBox
    Left = 8
    Top = 267
    Width = 213
    Height = 17
    Anchors = [akLeft, akBottom]
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1074' '#1085#1072#1079#1074#1072#1085#1080#1077' '#1090#1080#1087' '#1075#1083#1072#1074#1099' '#1057#1057#1056
    TabOrder = 11
    OnClick = cbbTypeCloseUp
  end
  object pnl1: TPanel
    Left = 0
    Top = 25
    Width = 604
    Height = 47
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object lblNumberChapter: TLabel
      Left = 5
      Top = 6
      Width = 74
      Height = 13
      Caption = #8470' '#1075#1083#1072#1074#1099' '#1057#1057#1056':'
    end
    object LabelNumberRow: TLabel
      Left = 24
      Top = 29
      Width = 55
      Height = 13
      Caption = #8470' '#1089#1090#1088#1086#1082#1080':'
    end
    object dbcbbCHAPTER: TDBLookupComboBox
      Left = 86
      Top = 2
      Width = 515
      Height = 21
      DataField = 'CHAPTER'
      DataSource = dsMain
      DropDownRows = 20
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      KeyField = 'CID'
      ListField = 'chap_name'
      ListSource = dsSSRChap
      ParentFont = False
      TabOrder = 0
      OnClick = dbcbbCHAPTERClick
    end
    object dbcbbSUBCHAPTER: TDBLookupComboBox
      Left = 86
      Top = 26
      Width = 515
      Height = 21
      DataField = 'ROW_NUMBER'
      DataSource = dsMain
      DropDownRows = 20
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      KeyField = 'SCID'
      ListField = 'syb_name'
      ListSource = dsSSRSubChap
      ParentFont = False
      TabOrder = 1
    end
  end
  object qrTemp: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    Left = 305
    Top = 248
  end
  object qrParts: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FormatOptions.AssignedValues = [fvMapRules, fvFmtDisplayNumeric]
    FormatOptions.OwnMapRules = True
    FormatOptions.MapRules = <
      item
        SourceDataType = dtByteString
        TargetDataType = dtAnsiString
      end>
    SQL.Strings = (
      'SELECT '
      '  0 AS ID,'
      '  "0" AS CODE,'
      '  "0" AS CODE1,'
      '  NULL AS NAME,'
      '  NULL AS CONSTANT,'
      '  "0." AS PART_NAME'
      'UNION ALL '
      'SELECT '
      '  `ID`,'
      '  `CODE`,'
      '  `CODE` AS CODE1,'
      '  `NAME`,'
      '  `CONSTANT`,'
      '  CONCAT(`CODE`, ". ", `NAME`) AS PART_NAME'
      'FROM '
      '  `parts_estimates`'
      'WHERE `CODE`<>0'
      'ORDER BY `CODE`;')
    Left = 289
    Top = 74
  end
  object dsParts: TDataSource
    DataSet = qrParts
    Left = 328
    Top = 74
  end
  object qrSections: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FormatOptions.AssignedValues = [fvFmtDisplayNumeric]
    FormatOptions.FmtDisplayNumeric = '#0.00'
    SQL.Strings = (
      'SELECT '
      '  0 AS ID,'
      '  "0" AS CODE,'
      '  "00" AS CODE1,'
      '  NULL AS NAME,'
      '  NULL AS CONSTANT,'
      '  "0." AS Section_NAME'
      'UNION ALL '
      'SELECT '
      '  `ID`,'
      '  `CODE`,'
      '  `CODE` AS CODE1,'
      '  `NAME`,'
      '  `CONSTANT`,'
      '  CONCAT(`CODE`, ". ", `NAME`) AS Section_NAME'
      'FROM '
      '  `sections_estimates`'
      'WHERE -`CODE`<>0'
      'ORDER BY `CODE`;')
    Left = 417
    Top = 90
  end
  object dsSections: TDataSource
    DataSet = qrSections
    Left = 456
    Top = 90
  end
  object qrTypesWorks: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FormatOptions.AssignedValues = [fvMapRules, fvDefaultParamDataType, fvFmtDisplayNumeric]
    FormatOptions.OwnMapRules = True
    FormatOptions.MapRules = <
      item
        SourceDataType = dtByteString
        TargetDataType = dtAnsiString
      end>
    FormatOptions.DefaultParamDataType = ftBCD
    SQL.Strings = (
      'SELECT '
      '  0 AS ID,'
      '  "0" AS CODE,'
      '  "" AS CODE1,'
      '  NULL AS NAME,'
      '  NULL AS CONSTANT,'
      '  "0." AS TYPE_WORK_NAME'
      'UNION ALL '
      'SELECT '
      '  `ID`,'
      '  CONCAT(LEFT("000", 3-LENGTH(`CODE`)), `CODE`) AS CODE,'
      '  CONCAT(LEFT("000", 3-LENGTH(`CODE`)), `CODE`) AS CODE1,'
      '  `NAME`,'
      '  `CONSTANT`,'
      
        '  CONCAT(CONCAT(LEFT("000", 3-LENGTH(`CODE`)), `CODE`), ". ", `N' +
        'AME`) AS TYPE_WORK_NAME'
      'FROM '
      '  `types_works`'
      'WHERE `CODE`<>0'
      'ORDER BY `CODE`;')
    Left = 201
    Top = 114
  end
  object dsTypesWorks: TDataSource
    DataSet = qrTypesWorks
    Left = 240
    Top = 114
  end
  object qrMain: TFDQuery
    OnNewRecord = qrMainNewRecord
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FormatOptions.AssignedValues = [fvFmtDisplayNumeric]
    FormatOptions.FmtDisplayNumeric = '#0.00'
    UpdateOptions.UpdateTableName = 'smeta.smetasourcedata'
    SQL.Strings = (
      'SELECT * '
      'FROM smetasourcedata'
      'WHERE SM_ID=:SM_ID')
    Left = 225
    Top = 242
    ParamData = <
      item
        Name = 'SM_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object dsMain: TDataSource
    DataSet = qrMain
    Left = 264
    Top = 242
  end
  object FormStorage: TJvFormStorage
    AppStorage = FormMain.AppIni
    AppStoragePath = '%FORM_NAME%\'
    Options = []
    StoredProps.Strings = (
      'chkAddChapterNumber.Checked')
    StoredValues = <>
    Left = 152
    Top = 240
  end
  object qrSSRChap: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FormatOptions.AssignedValues = [fvMapRules, fvFmtDisplayNumeric]
    FormatOptions.OwnMapRules = True
    FormatOptions.MapRules = <
      item
        SourceDataType = dtByteString
        TargetDataType = dtAnsiString
      end>
    SQL.Strings = (
      
        'SELECT ID, `CID`, CONCAT("'#1043#1051#1040#1042#1040' ",`CID`, ". ", `CNAME`) AS chap_' +
        'name'
      'FROM `ssr_chapters`'
      'WHERE (`SCID` is Null) and (`CID` <= 7) and '
      '      ((DATES is Null) or (DATES >= :DATESM)) and '
      '      ((DATEPO is Null) or (DATEPO <= :DATESM)) ORDER BY `CID`;')
    Left = 353
    Top = 18
    ParamData = <
      item
        Name = 'DATESM'
        ParamType = ptInput
      end>
  end
  object dsSSRChap: TDataSource
    DataSet = qrSSRChap
    Left = 392
    Top = 18
  end
  object qrSSRSubChap: TFDQuery
    MasterSource = dsSSRChap
    MasterFields = 'CID'
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FormatOptions.AssignedValues = [fvMapRules, fvFmtDisplayNumeric]
    FormatOptions.OwnMapRules = True
    FormatOptions.MapRules = <
      item
        SourceDataType = dtByteString
        TargetDataType = dtAnsiString
      end>
    SQL.Strings = (
      
        'SELECT ID, `SCID`, IF(not(`SCID` is null), CONCAT(`SCID`, ". ", ' +
        '`CNAME`), "") AS syb_name'
      'FROM `ssr_chapters`'
      'WHERE (`CID` = :CID) and not(`SCID` is Null) and'
      '      ((DATES is Null) or (DATES >= :DATESM)) and '
      '      ((DATEPO is Null) or (DATEPO <= :DATESM)) '
      'ORDER BY `SCID`;')
    Left = 481
    Top = 18
    ParamData = <
      item
        Name = 'CID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'DATESM'
        ParamType = ptInput
      end>
  end
  object dsSSRSubChap: TDataSource
    DataSet = qrSSRSubChap
    Left = 520
    Top = 18
  end
end
