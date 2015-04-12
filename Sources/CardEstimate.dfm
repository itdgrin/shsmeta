object FormCardEstimate: TFormCardEstimate
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1050#1072#1088#1090#1086#1095#1082#1072' '#1089#1084#1077#1090#1099
  ClientHeight = 243
  ClientWidth = 604
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    604
    243)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel: TBevel
    Left = 0
    Top = 202
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
    object LabelNumberChapter: TLabel
      Left = 189
      Top = 5
      Width = 74
      Height = 13
      Caption = #8470' '#1075#1083#1072#1074#1099' '#1057#1057#1056':'
    end
    object LabelNumberRow: TLabel
      Left = 390
      Top = 5
      Width = 55
      Height = 13
      Caption = #8470' '#1089#1090#1088#1086#1082#1080':'
    end
    object LabelNumberEstimate: TLabel
      Left = 11
      Top = 5
      Width = 51
      Height = 13
      Caption = #8470' '#1089#1084#1077#1090#1099':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object dbedtSM_NUMBER: TDBEdit
      Left = 68
      Top = 2
      Width = 115
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
    object dbedtCHAPTER: TDBEdit
      Left = 269
      Top = 2
      Width = 115
      Height = 21
      DataField = 'CHAPTER'
      DataSource = dsMain
      TabOrder = 1
    end
    object dbedtROW_NUMBER: TDBEdit
      Left = 451
      Top = 2
      Width = 150
      Height = 21
      DataField = 'ROW_NUMBER'
      DataSource = dsMain
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 100
    Width = 604
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 4
    object LabelNameEstimate: TLabel
      Left = 10
      Top = 5
      Width = 52
      Height = 13
      Caption = #1053#1072#1079#1074#1072#1085#1080#1077':'
    end
    object dbedtNAME: TDBEdit
      Left = 68
      Top = 3
      Width = 533
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
    Top = 125
    Width = 604
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 5
    object LabelCompose: TLabel
      Left = 10
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
      Left = 68
      Top = 2
      Width = 230
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
    Top = 150
    Width = 604
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 6
    object LabelChecked: TLabel
      Left = 9
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
      Left = 68
      Top = 2
      Width = 230
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
    Top = 175
    Width = 604
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 7
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
    Top = 210
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
    TabOrder = 8
    OnClick = btnSaveClick
  end
  object btnClose: TButton
    Left = 496
    Top = 210
    Width = 100
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 9
    OnClick = btnCloseClick
  end
  object PanelPart: TPanel
    Left = 0
    Top = 25
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
    TabOrder = 1
    object LabelPart: TLabel
      Left = 28
      Top = 5
      Width = 34
      Height = 13
      Caption = #1063#1072#1089#1090#1100':'
    end
    object dblkcbbParts: TDBLookupComboBox
      Left = 68
      Top = 3
      Width = 533
      Height = 21
      DataField = 'PART_ID'
      DataSource = dsMain
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
    Top = 50
    Width = 604
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 2
    object LabelSection: TLabel
      Left = 22
      Top = 5
      Width = 40
      Height = 13
      Caption = #1056#1072#1079#1076#1077#1083':'
    end
    object dblkcbbSections: TDBLookupComboBox
      Left = 68
      Top = 3
      Width = 533
      Height = 21
      DataField = 'SECTION_ID'
      DataSource = dsMain
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
    Top = 75
    Width = 604
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 3
    object LabelTypeWork: TLabel
      Left = 6
      Top = 5
      Width = 56
      Height = 13
      Caption = #1042#1080#1076' '#1088#1072#1073#1086#1090':'
    end
    object dblkcbbTypesWorks: TDBLookupComboBox
      Left = 68
      Top = 3
      Width = 533
      Height = 21
      DataField = 'TYPE_WORK_ID'
      DataSource = dsMain
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
  object qrTemp: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    Left = 25
    Top = 200
  end
  object qrParts: TFDQuery
    AfterScroll = qrPartsAfterScroll
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FormatOptions.AssignedValues = [fvFmtDisplayNumeric]
    FormatOptions.FmtDisplayNumeric = '#0.00'
    SQL.Strings = (
      'SELECT '
      '  `ID`,'
      '  `CODE`,'
      '  `NAME`,'
      '  `CONSTANT`,'
      '  CONCAT(`CODE`, ". ", `NAME`) AS PART_NAME'
      'FROM '
      '  `parts_estimates`'
      'ORDER BY `CODE`;')
    Left = 497
    Top = 18
  end
  object dsParts: TDataSource
    DataSet = qrParts
    Left = 536
    Top = 18
  end
  object qrSections: TFDQuery
    AfterScroll = qrPartsAfterScroll
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FormatOptions.AssignedValues = [fvFmtDisplayNumeric]
    FormatOptions.FmtDisplayNumeric = '#0.00'
    SQL.Strings = (
      'SELECT '
      '  `ID`,'
      '  `CODE`,'
      '  `NAME`,'
      '  `CONSTANT`,'
      '  CONCAT(`CODE`, ". ", `NAME`) AS Section_NAME'
      'FROM '
      '  `sections_estimates`'
      'ORDER BY `CODE`;')
    Left = 361
    Top = 42
  end
  object dsSections: TDataSource
    DataSet = qrSections
    Left = 400
    Top = 42
  end
  object qrTypesWorks: TFDQuery
    AfterScroll = qrPartsAfterScroll
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FormatOptions.AssignedValues = [fvFmtDisplayNumeric]
    FormatOptions.FmtDisplayNumeric = '#0.00'
    SQL.Strings = (
      'SELECT '
      '  `ID`,'
      '  `CODE`,'
      '  `NAME`,'
      '  `CONSTANT`,'
      '  CONCAT(`CODE`, ". ", `NAME`) AS TYPE_WORK_NAME'
      'FROM '
      '  `types_works`'
      'ORDER BY `CODE`;')
    Left = 233
    Top = 74
  end
  object dsTypesWorks: TDataSource
    DataSet = qrTypesWorks
    Left = 280
    Top = 74
  end
  object qrMain: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FormatOptions.AssignedValues = [fvFmtDisplayNumeric]
    FormatOptions.FmtDisplayNumeric = '#0.00'
    SQL.Strings = (
      'SELECT * '
      'FROM smetasourcedata'
      'WHERE SM_ID=:SM_ID')
    Left = 105
    Top = 202
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
    Left = 144
    Top = 202
  end
end
