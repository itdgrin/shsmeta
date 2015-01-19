object FormCardObject: TFormCardObject
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = #1050#1072#1088#1090#1086#1095#1082#1072' '#1086#1073#1098#1077#1082#1090#1072
  ClientHeight = 584
  ClientWidth = 457
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
  OnPaint = FormPaint
  OnShow = FormShow
  DesignSize = (
    457
    584)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 0
    Top = 543
    Width = 457
    Height = 41
    Align = alBottom
    Shape = bsTopLine
    ExplicitLeft = -191
    ExplicitTop = 365
    ExplicitWidth = 648
  end
  object GroupBoxObject: TGroupBox
    Left = 8
    Top = 1
    Width = 171
    Height = 49
    Caption = #1054#1073#1098#1077#1082#1090':'
    TabOrder = 0
    object LabelNumberObject: TLabel
      Left = 8
      Top = 23
      Width = 13
      Height = 13
      Caption = #8470
    end
    object LabelCodeObject: TLabel
      Left = 68
      Top = 23
      Width = 30
      Height = 13
      Caption = #1064#1080#1092#1088
    end
    object EditNumberObject: TEdit
      Left = 27
      Top = 20
      Width = 35
      Height = 21
      TabStop = False
      Color = 14802912
      ReadOnly = True
      TabOrder = 1
      OnKeyPress = EditNumberObjectKeyPress
    end
    object EditCodeObject: TEdit
      Left = 104
      Top = 20
      Width = 59
      Height = 21
      TabOrder = 0
      OnKeyPress = EditNumberObjectKeyPress
    end
  end
  object GroupBoxContract: TGroupBox
    Left = 185
    Top = 1
    Width = 264
    Height = 49
    Caption = #1044#1086#1075#1086#1074#1086#1088':'
    TabOrder = 1
    object LabelNumberContract: TLabel
      Left = 8
      Top = 23
      Width = 13
      Height = 13
      Caption = #8470
    end
    object Label2: TLabel
      Left = 153
      Top = 23
      Width = 12
      Height = 13
      Caption = #1086#1090
    end
    object EditNumberContract: TEdit
      Left = 27
      Top = 20
      Width = 120
      Height = 21
      TabOrder = 0
    end
    object DateTimePickerDataCreateContract: TDateTimePicker
      Left = 171
      Top = 20
      Width = 85
      Height = 21
      Date = 41507.639729814820000000
      Time = 41507.639729814820000000
      TabOrder = 1
    end
  end
  object ButtonListAgreements: TButton
    Left = 304
    Top = 181
    Width = 145
    Height = 25
    Caption = #1044#1086#1087'. '#1089#1086#1075#1083#1072#1096#1077#1085#1080#1103
    TabOrder = 5
    WordWrap = True
  end
  object GroupBoxFullDescription: TGroupBox
    Left = 8
    Top = 51
    Width = 441
    Height = 71
    Caption = #1055#1086#1083#1085#1086#1077' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1086#1073#1098#1077#1082#1090#1072' ('#1085#1077' '#1073#1086#1083#1077#1077' 255 '#1089#1080#1084#1074#1086#1083#1086#1074'):'
    TabOrder = 3
    DesignSize = (
      441
      71)
    object MemoFullDescription: TMemo
      Left = 8
      Top = 16
      Width = 425
      Height = 47
      Anchors = [akLeft, akTop, akRight]
      MaxLength = 1000
      TabOrder = 0
    end
  end
  object GroupBoxShortDescription: TGroupBox
    Left = 8
    Top = 124
    Width = 441
    Height = 49
    Caption = #1050#1088#1072#1090#1082#1086#1077' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1086#1073#1098#1077#1082#1090#1072':'
    TabOrder = 2
    DesignSize = (
      441
      49)
    object EditShortDescription: TEdit
      Left = 8
      Top = 20
      Width = 425
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
    end
  end
  object GroupBoxDateBuilding: TGroupBox
    Left = 8
    Top = 175
    Width = 290
    Height = 49
    Caption = #1044#1072#1090#1072' '#1089#1090#1088#1086#1080#1090#1077#1083#1100#1089#1090#1074#1072':'
    TabOrder = 4
    DesignSize = (
      290
      49)
    object LabelStartBuilding: TLabel
      Left = 8
      Top = 23
      Width = 37
      Height = 13
      Caption = #1053#1072#1095#1072#1083#1086
    end
    object LabelCountMonth: TLabel
      Left = 142
      Top = 23
      Width = 102
      Height = 13
      Caption = #1089#1088#1086#1082' '#1089#1090#1088#1086#1080#1090#1077#1083#1100#1089#1090#1074#1072
    end
    object DateTimePickerStartBuilding: TDateTimePicker
      Left = 51
      Top = 20
      Width = 85
      Height = 21
      Date = 41507.639729814820000000
      Time = 41507.639729814820000000
      TabOrder = 0
    end
    object EditCountMonth: TEdit
      Left = 250
      Top = 20
      Width = 32
      Height = 21
      Hint = #1063#1080#1089#1083#1086' '#1084#1077#1089#1103#1094#1077#1074
      Anchors = [akLeft, akTop, akRight]
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnKeyPress = EditNumberObjectKeyPress
    end
  end
  object GroupBoxSourseFinance: TGroupBox
    Left = 8
    Top = 227
    Width = 441
    Height = 49
    Caption = #1048#1089#1090#1086#1095#1085#1080#1082' '#1092#1080#1085#1072#1085#1089#1080#1088#1086#1074#1072#1085#1080#1103':'
    TabOrder = 6
    object DBLookupComboBoxSourseFinance: TDBLookupComboBox
      Left = 8
      Top = 20
      Width = 425
      Height = 21
      TabOrder = 0
    end
  end
  object GroupBoxClient: TGroupBox
    Left = 8
    Top = 278
    Width = 218
    Height = 49
    Caption = #1047#1072#1082#1072#1079#1095#1080#1082':'
    TabOrder = 7
    object DBLookupComboBoxClient: TDBLookupComboBox
      Left = 8
      Top = 20
      Width = 202
      Height = 21
      TabOrder = 0
    end
  end
  object GroupBoxContractor: TGroupBox
    Left = 232
    Top = 278
    Width = 217
    Height = 49
    Caption = #1043#1077#1085#1077#1088#1072#1083#1100#1085#1099#1081' '#1087#1086#1076#1088#1103#1076#1095#1080#1082':'
    TabOrder = 8
    object DBLookupComboBoxContractor: TDBLookupComboBox
      Left = 8
      Top = 20
      Width = 202
      Height = 21
      TabOrder = 0
    end
  end
  object GroupBoxCategoryObject: TGroupBox
    Left = 8
    Top = 330
    Width = 324
    Height = 49
    Caption = #1050#1072#1090#1077#1075#1086#1088#1080#1103' '#1086#1073#1098#1077#1082#1090#1072':'
    TabOrder = 9
    object DBLookupComboBoxCategoryObject: TDBLookupComboBox
      Left = 8
      Top = 20
      Width = 308
      Height = 21
      TabOrder = 0
      OnClick = GetValueDBLookupComboBoxTypeOXR
    end
  end
  object GroupBoxBasePrices: TGroupBox
    Left = 232
    Top = 382
    Width = 217
    Height = 49
    Caption = #1041#1072#1079#1072' '#1088#1072#1089#1094#1077#1085#1086#1082':'
    TabOrder = 12
    object DBLookupComboBoxBasePrices: TDBLookupComboBox
      Left = 8
      Top = 20
      Width = 201
      Height = 21
      TabOrder = 0
    end
  end
  object GroupBoxZonePrices: TGroupBox
    Left = 8
    Top = 435
    Width = 218
    Height = 49
    Caption = #1047#1086#1085#1072' '#1088#1072#1089#1094#1077#1085#1086#1082':'
    TabOrder = 13
    object DBLookupComboBoxZonePrices: TDBLookupComboBox
      Left = 8
      Top = 20
      Width = 202
      Height = 21
      TabOrder = 0
      OnClick = GetValueDBLookupComboBoxTypeOXR
    end
  end
  object GroupBoxTypeOXR: TGroupBox
    Left = 232
    Top = 435
    Width = 217
    Height = 49
    Caption = #1058#1080#1087' '#1054#1061#1056' '#1054#1055#1056' '#1080' '#1087#1083#1072#1085'. '#1087#1088#1080#1073#1099#1083#1080':'
    TabOrder = 14
    object DBLookupComboBoxTypeOXR: TDBLookupComboBox
      Left = 8
      Top = 20
      Width = 201
      Height = 21
      TabOrder = 0
    end
  end
  object ButtonSave: TButton
    Left = 223
    Top = 551
    Width = 110
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    Default = True
    TabOrder = 15
    OnClick = ButtonSaveClick
    ExplicitTop = 534
  end
  object ButtonCancel: TButton
    Left = 339
    Top = 551
    Width = 110
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 16
    OnClick = ButtonCancelClick
    ExplicitTop = 534
  end
  object GroupBoxVAT: TGroupBox
    Left = 338
    Top = 330
    Width = 111
    Height = 49
    Caption = #1062#1077#1085#1099' '#1085#1072' '#1084#1072#1090'. '#1084#1077#1093'.'
    TabOrder = 10
    DesignSize = (
      111
      49)
    object ComboBoxVAT: TComboBox
      Left = 8
      Top = 20
      Width = 95
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      ItemIndex = 0
      TabOrder = 0
      Text = #1073#1077#1079' '#1053#1044#1057
      Items.Strings = (
        #1073#1077#1079' '#1053#1044#1057
        #1089' '#1053#1044#1057)
    end
  end
  object GroupBoxRegion: TGroupBox
    Left = 8
    Top = 382
    Width = 218
    Height = 49
    Caption = #1056#1077#1075#1080#1086#1085':'
    TabOrder = 11
    object DBLookupComboBoxRegion: TDBLookupComboBox
      Left = 8
      Top = 20
      Width = 202
      Height = 21
      TabOrder = 0
    end
  end
  object CheckBoxCalculationEconom: TCheckBox
    Left = 304
    Top = 207
    Width = 145
    Height = 17
    Caption = #1056#1072#1089#1095#1105#1090' '#1093#1086#1079'. '#1089#1087#1086#1089#1086#1073#1086#1084
    TabOrder = 17
  end
  object GroupBox1: TGroupBox
    Left = 232
    Top = 488
    Width = 217
    Height = 49
    Caption = #1052#1040#1048#1057':'
    TabOrder = 18
    object DBLookupComboBoxMAIS: TDBLookupComboBox
      Left = 8
      Top = 20
      Width = 201
      Height = 21
      TabOrder = 0
    end
  end
  object DataSourceSF: TDataSource
    DataSet = ADOQuerySF
    Left = 240
    Top = 240
  end
  object DataSourceCO: TDataSource
    DataSet = ADOQueryCO
    Left = 208
    Top = 344
  end
  object DataSourceZP: TDataSource
    DataSet = ADOQueryZP
    Left = 104
    Top = 448
  end
  object DataSourceR: TDataSource
    DataSet = ADOQueryR
    Left = 112
    Top = 400
  end
  object DataSourceCl: TDataSource
    DataSet = ADOQueryCl
    Left = 120
    Top = 296
  end
  object DataSourceC: TDataSource
    DataSet = ADOQueryC
    Left = 352
    Top = 296
  end
  object DataSourceBP: TDataSource
    DataSet = ADOQueryBP
    Left = 360
    Top = 392
  end
  object DataSourceTO: TDataSource
    DataSet = ADOQueryTO
    Left = 312
    Top = 448
  end
  object DataSourceDifferent: TDataSource
    DataSet = ADOQueryDifferent
    Left = 248
    Top = 128
  end
  object ADOQueryDifferent: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    Left = 209
    Top = 128
  end
  object ADOQuerySF: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    Left = 201
    Top = 240
  end
  object ADOQueryC: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    Left = 321
    Top = 296
  end
  object ADOQueryCl: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    Left = 89
    Top = 296
  end
  object ADOQueryCO: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    Left = 177
    Top = 344
  end
  object ADOQueryBP: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    Left = 329
    Top = 392
  end
  object ADOQueryTO: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    Left = 281
    Top = 448
  end
  object ADOQueryR: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    Left = 81
    Top = 400
  end
  object ADOQueryZP: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    Left = 73
    Top = 448
  end
  object ADOQueryMAIS: TFDQuery
    AutoCalcFields = False
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    Left = 273
    Top = 496
  end
  object DataSourceMAIS: TDataSource
    DataSet = ADOQueryMAIS
    Left = 304
    Top = 496
  end
end
