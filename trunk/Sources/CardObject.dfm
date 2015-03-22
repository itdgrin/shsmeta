object FormCardObject: TFormCardObject
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = #1050#1072#1088#1090#1086#1095#1082#1072' '#1086#1073#1098#1077#1082#1090#1072
  ClientHeight = 577
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
  OnShow = FormShow
  DesignSize = (
    457
    577)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 0
    Top = 536
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
    Height = 41
    Caption = #1054#1073#1098#1077#1082#1090':'
    TabOrder = 0
    object LabelNumberObject: TLabel
      Left = 8
      Top = 17
      Width = 13
      Height = 13
      Caption = #8470
    end
    object LabelCodeObject: TLabel
      Left = 68
      Top = 17
      Width = 30
      Height = 13
      Caption = #1064#1080#1092#1088
    end
    object EditNumberObject: TEdit
      Left = 27
      Top = 14
      Width = 35
      Height = 21
      TabStop = False
      Color = 14802912
      ReadOnly = True
      TabOrder = 0
      OnKeyPress = EditNumberObjectKeyPress
    end
    object EditCodeObject: TEdit
      Left = 104
      Top = 14
      Width = 59
      Height = 21
      TabOrder = 1
      OnKeyPress = EditNumberObjectKeyPress
    end
  end
  object GroupBoxContract: TGroupBox
    Left = 185
    Top = 1
    Width = 264
    Height = 41
    Caption = #1044#1086#1075#1086#1074#1086#1088':'
    TabOrder = 1
    object LabelNumberContract: TLabel
      Left = 8
      Top = 17
      Width = 13
      Height = 13
      Caption = #8470
    end
    object Label2: TLabel
      Left = 153
      Top = 17
      Width = 12
      Height = 13
      Caption = #1086#1090
    end
    object EditNumberContract: TEdit
      Left = 27
      Top = 14
      Width = 120
      Height = 21
      TabOrder = 0
    end
    object DateTimePickerDataCreateContract: TDateTimePicker
      Left = 171
      Top = 14
      Width = 85
      Height = 21
      Date = 41507.639729814820000000
      Time = 41507.639729814820000000
      TabOrder = 1
    end
  end
  object ButtonListAgreements: TButton
    Left = 304
    Top = 158
    Width = 145
    Height = 25
    Caption = #1044#1086#1087'. '#1089#1086#1075#1083#1072#1096#1077#1085#1080#1103
    TabOrder = 5
    WordWrap = True
  end
  object GroupBoxFullDescription: TGroupBox
    Left = 8
    Top = 42
    Width = 441
    Height = 68
    Caption = #1055#1086#1083#1085#1086#1077' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1086#1073#1098#1077#1082#1090#1072' ('#1085#1077' '#1073#1086#1083#1077#1077' 255 '#1089#1080#1084#1074#1086#1083#1086#1074'):'
    TabOrder = 2
    DesignSize = (
      441
      68)
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
    Top = 111
    Width = 441
    Height = 41
    Caption = #1050#1088#1072#1090#1082#1086#1077' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1086#1073#1098#1077#1082#1090#1072':'
    TabOrder = 3
    DesignSize = (
      441
      41)
    object EditShortDescription: TEdit
      Left = 8
      Top = 15
      Width = 425
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
    end
  end
  object GroupBoxDateBuilding: TGroupBox
    Left = 8
    Top = 152
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
    Top = 204
    Width = 441
    Height = 49
    Caption = #1048#1089#1090#1086#1095#1085#1080#1082' '#1092#1080#1085#1072#1085#1089#1080#1088#1086#1074#1072#1085#1080#1103':'
    TabOrder = 7
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
    Top = 255
    Width = 218
    Height = 49
    Caption = #1047#1072#1082#1072#1079#1095#1080#1082':'
    TabOrder = 8
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
    Top = 255
    Width = 217
    Height = 49
    Caption = #1043#1077#1085#1077#1088#1072#1083#1100#1085#1099#1081' '#1087#1086#1076#1088#1103#1076#1095#1080#1082':'
    TabOrder = 9
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
    Top = 303
    Width = 324
    Height = 49
    Caption = #1050#1072#1090#1077#1075#1086#1088#1080#1103' '#1086#1073#1098#1077#1082#1090#1072':'
    TabOrder = 10
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
    Top = 352
    Width = 217
    Height = 49
    Caption = #1041#1072#1079#1072' '#1088#1072#1089#1094#1077#1085#1086#1082':'
    TabOrder = 13
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
    Top = 400
    Width = 218
    Height = 43
    Caption = #1047#1086#1085#1072' '#1088#1072#1089#1094#1077#1085#1086#1082':'
    TabOrder = 14
    object DBLookupComboBoxZonePrices: TDBLookupComboBox
      Left = 8
      Top = 16
      Width = 202
      Height = 21
      TabOrder = 0
      OnClick = GetValueDBLookupComboBoxTypeOXR
    end
  end
  object GroupBoxTypeOXR: TGroupBox
    Left = 232
    Top = 400
    Width = 217
    Height = 43
    Caption = #1058#1080#1087' '#1054#1061#1056' '#1054#1055#1056' '#1080' '#1087#1083#1072#1085'. '#1087#1088#1080#1073#1099#1083#1080':'
    TabOrder = 15
    object DBLookupComboBoxTypeOXR: TDBLookupComboBox
      Left = 8
      Top = 16
      Width = 201
      Height = 21
      TabOrder = 0
    end
  end
  object ButtonSave: TButton
    Left = 223
    Top = 544
    Width = 110
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    Default = True
    TabOrder = 18
    OnClick = ButtonSaveClick
  end
  object ButtonCancel: TButton
    Left = 339
    Top = 544
    Width = 110
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 19
    OnClick = ButtonCancelClick
  end
  object GroupBoxVAT: TGroupBox
    Left = 338
    Top = 303
    Width = 111
    Height = 49
    Caption = #1062#1077#1085#1099' '#1085#1072' '#1084#1072#1090'. '#1084#1077#1093'.'
    TabOrder = 11
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
    Top = 352
    Width = 218
    Height = 49
    Caption = #1056#1077#1075#1080#1086#1085':'
    TabOrder = 12
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
    Top = 184
    Width = 145
    Height = 17
    Caption = #1056#1072#1089#1095#1105#1090' '#1093#1086#1079'. '#1089#1087#1086#1089#1086#1073#1086#1084
    TabOrder = 6
    Visible = False
  end
  object GroupBox1: TGroupBox
    Left = 232
    Top = 442
    Width = 217
    Height = 45
    Caption = #1052#1040#1048#1057':'
    TabOrder = 17
    object DBLookupComboBoxMAIS: TDBLookupComboBox
      Left = 8
      Top = 16
      Width = 201
      Height = 21
      TabOrder = 0
    end
  end
  object grp1: TGroupBox
    Left = 8
    Top = 442
    Width = 218
    Height = 90
    Caption = #1056#1072#1089#1093#1086#1076#1099', %'
    TabOrder = 16
    object lbl1: TLabel
      Left = 8
      Top = 17
      Width = 152
      Height = 13
      Caption = #1042#1088#1077#1084#1077#1085#1085#1099#1077' '#1079#1076#1072#1085#1080#1103' '#1080' '#1089#1086#1086#1088#1091#1078'.:'
    end
    object lbl2: TLabel
      Left = 8
      Top = 67
      Width = 128
      Height = 13
      Caption = #1059#1089#1083#1091#1075#1080' '#1075#1077#1085'. '#1087#1086#1076#1088#1103#1076#1095#1080#1082#1072':'
    end
    object lbl3: TLabel
      Left = 8
      Top = 36
      Width = 167
      Height = 26
      Caption = #1042#1086#1079#1074#1088#1072#1090' '#1089#1090#1086#1080#1084#1086#1089#1090#1080' '#1084#1072#1090#1077#1088#1080#1072#1083#1086#1074#13#10#1086#1090' '#1074#1088#1077#1084#1077#1085#1085#1099#1093' '#1079#1076#1072#1085#1080#1081' '#1080' '#1089#1086#1086#1088#1091#1078'.:'
    end
    object dbedtPER_TEPM_BUILD: TDBEdit
      Left = 179
      Top = 14
      Width = 31
      Height = 21
      DataField = 'PER_TEPM_BUILD'
      DataSource = dsMain
      PopupMenu = pm1
      TabOrder = 0
    end
    object dbedtPER_TEMP_BUILD_BACK: TDBEdit
      Left = 179
      Top = 39
      Width = 31
      Height = 21
      DataField = 'PER_TEMP_BUILD_BACK'
      DataSource = dsMain
      PopupMenu = pm1
      TabOrder = 1
    end
    object dbedtPER_CONTRACTOR: TDBEdit
      Left = 179
      Top = 64
      Width = 31
      Height = 21
      DataField = 'PER_CONTRACTOR'
      DataSource = dsMain
      PopupMenu = pm1
      TabOrder = 2
    end
  end
  object DataSourceSF: TDataSource
    DataSet = ADOQuerySF
    Left = 240
    Top = 217
  end
  object DataSourceCO: TDataSource
    DataSet = ADOQueryCO
    Left = 208
    Top = 321
  end
  object DataSourceZP: TDataSource
    DataSet = ADOQueryZP
    Left = 120
    Top = 410
  end
  object DataSourceR: TDataSource
    DataSet = ADOQueryR
    Left = 112
    Top = 362
  end
  object DataSourceCl: TDataSource
    DataSet = ADOQueryCl
    Left = 120
    Top = 273
  end
  object DataSourceC: TDataSource
    DataSet = ADOQueryC
    Left = 352
    Top = 273
  end
  object DataSourceBP: TDataSource
    DataSet = ADOQueryBP
    Left = 360
    Top = 362
  end
  object DataSourceTO: TDataSource
    DataSet = ADOQueryTO
    Left = 312
    Top = 418
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
    Top = 217
  end
  object ADOQueryC: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    Left = 321
    Top = 273
  end
  object ADOQueryCl: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    Left = 89
    Top = 273
  end
  object ADOQueryCO: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    Left = 177
    Top = 321
  end
  object ADOQueryBP: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    Left = 329
    Top = 362
  end
  object ADOQueryTO: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    Left = 281
    Top = 418
  end
  object ADOQueryR: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    Left = 81
    Top = 362
  end
  object ADOQueryZP: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    Left = 81
    Top = 410
  end
  object ADOQueryMAIS: TFDQuery
    AutoCalcFields = False
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    Left = 273
    Top = 461
  end
  object DataSourceMAIS: TDataSource
    DataSet = ADOQueryMAIS
    Left = 304
    Top = 461
  end
  object qrMain: TFDQuery
    AutoCalcFields = False
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvUpdateChngFields, uvUpdateMode, uvCountUpdatedRecords, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable, uvUpdateNonBaseFields]
    UpdateOptions.EnableDelete = False
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.UpdateNonBaseFields = True
    UpdateOptions.UpdateMode = upWhereAll
    UpdateOptions.CountUpdatedRecords = False
    UpdateOptions.CheckRequired = False
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.CheckUpdatable = False
    SQL.Strings = (
      'SELECT * FROM OBJCARDS'
      'WHERE OBJ_ID=:OBJ_ID')
    Left = 377
    Top = 485
    ParamData = <
      item
        Name = 'OBJ_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 0
      end>
  end
  object dsMain: TDataSource
    DataSet = qrMain
    Left = 416
    Top = 485
  end
  object pm1: TPopupMenu
    Left = 168
    Top = 498
    object N1: TMenuItem
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077
      OnClick = N1Click
    end
  end
end
