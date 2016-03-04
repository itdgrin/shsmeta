object fCardObject: TfCardObject
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = #1050#1072#1088#1090#1086#1095#1082#1072' '#1086#1073#1098#1077#1082#1090#1072
  ClientHeight = 524
  ClientWidth = 456
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    456
    524)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 0
    Top = 483
    Width = 456
    Height = 41
    Align = alBottom
    Shape = bsTopLine
    ExplicitLeft = -191
    ExplicitTop = 365
    ExplicitWidth = 648
  end
  object lbl3: TLabel
    Left = 16
    Top = 221
    Width = 140
    Height = 13
    Caption = #1048#1089#1090#1086#1095#1085#1080#1082' '#1092#1080#1085#1072#1085#1089#1080#1088#1086#1074#1072#1085#1080#1103':'
  end
  object lblCountMonth: TLabel
    Left = 16
    Top = 194
    Width = 111
    Height = 13
    Caption = #1057#1088#1086#1082' '#1089#1090#1088#1086#1080#1090'-'#1074#1072', '#1084#1077#1089'.:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object GroupBoxDateBuilding: TGroupBox
    Left = 8
    Top = 139
    Width = 218
    Height = 49
    Caption = #1044#1072#1090#1072' '#1089#1086#1089#1090#1072#1074#1083#1077#1085#1080#1103' '#1089#1084#1077#1090#1099':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    object LabelStartBuilding: TLabel
      Left = 8
      Top = 23
      Width = 37
      Height = 13
      Caption = #1053#1072#1095#1072#1083#1086
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object cbbFromMonth: TComboBox
      Left = 51
      Top = 20
      Width = 100
      Height = 21
      Style = csDropDownList
      DropDownCount = 12
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemIndex = 0
      ParentFont = False
      TabOrder = 1
      Text = #1071#1085#1074#1072#1088#1100
      OnChange = DateTimePickerStartBuildingChange
      Items.Strings = (
        #1071#1085#1074#1072#1088#1100
        #1060#1077#1074#1088#1072#1083#1100
        #1052#1072#1088#1090
        #1040#1087#1088#1077#1083#1100
        #1052#1072#1081
        #1048#1102#1085#1100
        #1048#1102#1083#1100
        #1040#1074#1075#1091#1089#1090
        #1057#1077#1085#1090#1103#1073#1088#1100
        #1054#1082#1090#1103#1073#1088#1100
        #1053#1086#1103#1073#1088#1100
        #1044#1077#1082#1072#1073#1088#1100)
    end
    object seYear: TSpinEdit
      Left = 154
      Top = 19
      Width = 56
      Height = 22
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxValue = 2100
      MinValue = 2012
      ParentFont = False
      TabOrder = 0
      Value = 2015
      OnChange = DateTimePickerStartBuildingChange
    end
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
    end
    object EditCodeObject: TEdit
      Left = 104
      Top = 14
      Width = 59
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
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
      Width = 86
      Height = 21
      Date = 41507.639729814820000000
      Time = 41507.639729814820000000
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
  end
  object ButtonListAgreements: TButton
    Left = 232
    Top = 192
    Width = 216
    Height = 25
    Caption = #1044#1086#1087'. '#1089#1086#1075#1083#1072#1096#1077#1085#1080#1103
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    WordWrap = True
    OnClick = ButtonListAgreementsClick
  end
  object GroupBoxFullDescription: TGroupBox
    Left = 8
    Top = 42
    Width = 441
    Height = 56
    Caption = #1055#1086#1083#1085#1086#1077' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1086#1073#1098#1077#1082#1090#1072' ('#1085#1077' '#1073#1086#1083#1077#1077' 255 '#1089#1080#1084#1074#1086#1083#1086#1074'):'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    object dbmmoFULL_NAME: TDBMemo
      Left = 2
      Top = 15
      Width = 437
      Height = 39
      Align = alClient
      DataField = 'FULL_NAME'
      DataSource = dsMain
      TabOrder = 0
    end
  end
  object GroupBoxShortDescription: TGroupBox
    Left = 8
    Top = 97
    Width = 441
    Height = 41
    Caption = #1050#1088#1072#1090#1082#1086#1077' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1086#1073#1098#1077#1082#1090#1072':'
    TabOrder = 3
    object dbedtname: TDBEdit
      Left = 2
      Top = 15
      Width = 437
      Height = 24
      Align = alClient
      DataField = 'name'
      DataSource = dsMain
      TabOrder = 0
      ExplicitHeight = 21
    end
  end
  object GroupBoxClient: TGroupBox
    Left = 8
    Top = 246
    Width = 218
    Height = 49
    Caption = #1047#1072#1082#1072#1079#1095#1080#1082':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 10
    object dblkcbbCUST_ID: TDBLookupComboBox
      Left = 8
      Top = 18
      Width = 202
      Height = 21
      DataField = 'CUST_ID'
      DataSource = dsMain
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      KeyField = 'CLIENT_ID'
      ListField = 'NAME'
      ListSource = dsClients
      ParentFont = False
      TabOrder = 1
    end
    object btn2: TBitBtn
      Left = 188
      Top = 17
      Width = 22
      Height = 23
      Caption = '..'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = btn2Click
    end
  end
  object GroupBoxContractor: TGroupBox
    Left = 232
    Top = 246
    Width = 217
    Height = 49
    Caption = #1043#1077#1085#1077#1088#1072#1083#1100#1085#1099#1081' '#1087#1086#1076#1088#1103#1076#1095#1080#1082':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 11
    object dblkcbbGENERAL: TDBLookupComboBox
      Left = 8
      Top = 18
      Width = 202
      Height = 21
      Ctl3D = True
      DataField = 'GENERAL_ID'
      DataSource = dsMain
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      KeyField = 'CLIENT_ID'
      ListField = 'NAME'
      ListSource = dsClients
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 1
    end
    object btn1: TBitBtn
      Left = 188
      Top = 17
      Width = 22
      Height = 23
      Caption = '..'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = btn1Click
    end
  end
  object GroupBoxCategoryObject: TGroupBox
    Left = 8
    Top = 294
    Width = 324
    Height = 49
    Caption = #1042#1080#1076' '#1089#1090#1088#1086#1080#1090#1077#1083#1100#1089#1090#1074#1072':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 12
    object dblkcbbCategoryObject: TDBLookupComboBox
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
    Top = 343
    Width = 217
    Height = 49
    Caption = #1041#1072#1079#1072' '#1088#1072#1089#1094#1077#1085#1086#1082':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 15
    object DBLookupComboBoxBasePrices: TDBLookupComboBox
      Left = 8
      Top = 20
      Width = 202
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
  end
  object GroupBoxZonePrices: TGroupBox
    Left = 8
    Top = 391
    Width = 218
    Height = 43
    Caption = #1047#1086#1085#1072' '#1089#1090#1088#1086#1080#1090#1077#1083#1100#1089#1090#1074#1072':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 16
    object dblkcbbZonePrices: TDBLookupComboBox
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
    Top = 391
    Width = 217
    Height = 43
    Caption = #1058#1080#1087' '#1054#1061#1056' '#1054#1055#1056' '#1080' '#1087#1083#1072#1085'. '#1087#1088#1080#1073#1099#1083#1080':'
    TabOrder = 17
    object dblkcbbTypeOXR: TDBLookupComboBox
      Left = 8
      Top = 16
      Width = 202
      Height = 21
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
  end
  object ButtonSave: TButton
    Left = 222
    Top = 491
    Width = 110
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 20
    OnClick = ButtonSaveClick
  end
  object ButtonCancel: TButton
    Left = 338
    Top = 491
    Width = 110
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 21
    OnClick = ButtonCancelClick
  end
  object GroupBoxVAT: TGroupBox
    Left = 338
    Top = 294
    Width = 111
    Height = 49
    Caption = #1062#1077#1085#1099' '#1085#1072' '#1084#1072#1090'. '#1084#1077#1093'.'
    TabOrder = 13
    DesignSize = (
      111
      49)
    object ComboBoxVAT: TComboBox
      Left = 7
      Top = 20
      Width = 96
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemIndex = 0
      ParentFont = False
      TabOrder = 0
      Text = #1073#1077#1079' '#1053#1044#1057
      Items.Strings = (
        #1073#1077#1079' '#1053#1044#1057
        #1089' '#1053#1044#1057)
    end
  end
  object GroupBoxRegion: TGroupBox
    Left = 8
    Top = 343
    Width = 218
    Height = 49
    Caption = #1056#1077#1075#1080#1086#1085':'
    TabOrder = 14
    object dblkcbbRegion: TDBLookupComboBox
      Left = 8
      Top = 20
      Width = 202
      Height = 21
      DataField = 'REGION_ID'
      DataSource = dsMain
      TabOrder = 0
      OnCloseUp = dblkcbbRegionCloseUp
    end
  end
  object CheckBoxCalculationEconom: TCheckBox
    Left = 338
    Top = 207
    Width = 110
    Height = 17
    Caption = #1056#1072#1089#1095#1105#1090' '#1093#1086#1079'. '#1089#1087#1086#1089#1086#1073#1086#1084
    TabOrder = 8
    Visible = False
  end
  object grp2: TGroupBox
    Left = 8
    Top = 434
    Width = 441
    Height = 43
    Caption = #1054#1061#1056#1080#1054#1055#1056' '#1087#1086' '#1087#1086#1089#1090#1072#1085#1086#1074#1083#1077#1085#1080#1102' '#1052#1040#1048#1057':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 18
    object dblkcbbMAIS: TDBLookupComboBox
      Left = 8
      Top = 15
      Width = 426
      Height = 21
      DataField = 'MAIS_ID'
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
  object dblkcbbSourseFinance: TDBLookupComboBox
    Left = 162
    Top = 221
    Width = 280
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
  end
  object btnCardObjectAdditional: TBitBtn
    Left = 8
    Top = 491
    Width = 208
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = #1055#1088#1086#1095#1080#1077' '#1087#1072#1088#1072#1084#1077#1090#1088#1099' '#1088#1072#1089#1095#1077#1090#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 19
    OnClick = btnCardObjectAdditionalClick
  end
  object grp3: TGroupBox
    Left = 232
    Top = 139
    Width = 216
    Height = 48
    Caption = #1044#1072#1090#1072' '#1085#1072#1095#1072#1083#1072' '#1089#1090#1088#1086#1080#1090#1077#1083#1100#1089#1090#1074#1072':'
    TabOrder = 5
    object lbl4: TLabel
      Left = 8
      Top = 23
      Width = 37
      Height = 13
      Caption = #1053#1072#1095#1072#1083#1086
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object cbbMonthBeginStroj: TComboBox
      Left = 51
      Top = 20
      Width = 100
      Height = 21
      Style = csDropDownList
      DropDownCount = 12
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemIndex = 0
      ParentFont = False
      TabOrder = 1
      Text = #1071#1085#1074#1072#1088#1100
      OnChange = cbbMonthBeginStrojChange
      Items.Strings = (
        #1071#1085#1074#1072#1088#1100
        #1060#1077#1074#1088#1072#1083#1100
        #1052#1072#1088#1090
        #1040#1087#1088#1077#1083#1100
        #1052#1072#1081
        #1048#1102#1085#1100
        #1048#1102#1083#1100
        #1040#1074#1075#1091#1089#1090
        #1057#1077#1085#1090#1103#1073#1088#1100
        #1054#1082#1090#1103#1073#1088#1100
        #1053#1086#1103#1073#1088#1100
        #1044#1077#1082#1072#1073#1088#1100)
    end
    object seYearBeginStroj: TSpinEdit
      Left = 154
      Top = 19
      Width = 56
      Height = 22
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxValue = 2100
      MinValue = 2012
      ParentFont = False
      TabOrder = 0
      Value = 2015
      OnChange = cbbMonthBeginStrojChange
    end
  end
  object jvdbspndtSROK_STROJ: TJvDBSpinEdit
    Left = 162
    Top = 194
    Width = 64
    Height = 21
    MaxValue = 9999999.000000000000000000
    MinValue = 1.000000000000000000
    TabOrder = 7
    DataField = 'SROK_STROJ'
    DataSource = dsMain
  end
  object DataSourceSF: TDataSource
    DataSet = ADOQuerySF
    Left = 272
    Top = 97
  end
  object DataSourceCO: TDataSource
    DataSet = ADOQueryCO
    Left = 208
    Top = 312
  end
  object dsZP: TDataSource
    DataSet = qrZP
    Left = 120
    Top = 401
  end
  object dsR: TDataSource
    DataSet = qrR
    Left = 112
    Top = 353
  end
  object DataSourceBP: TDataSource
    DataSet = qrBP
    Left = 360
    Top = 353
  end
  object dsTO: TDataSource
    DataSet = qrTO
    Left = 312
    Top = 409
  end
  object DataSourceDifferent: TDataSource
    DataSet = ADOQueryDifferent
    Left = 272
    Top = 56
  end
  object ADOQueryDifferent: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    Left = 169
    Top = 56
  end
  object ADOQuerySF: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    Left = 201
    Top = 97
  end
  object ADOQueryCO: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    Left = 177
    Top = 312
  end
  object qrBP: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    Left = 329
    Top = 353
  end
  object qrTO: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    Left = 281
    Top = 409
  end
  object qrR: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    Left = 81
    Top = 353
  end
  object qrZP: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    Left = 81
    Top = 401
  end
  object qrMAIS: TFDQuery
    AutoCalcFields = False
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    Left = 273
    Top = 452
  end
  object dsMAIS: TDataSource
    DataSet = qrMAIS
    Left = 304
    Top = 452
  end
  object qrMain: TFDQuery
    AutoCalcFields = False
    OnNewRecord = qrMainNewRecord
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
    UpdateOptions.UpdateTableName = 'smeta.objcards'
    SQL.Strings = (
      
        'SELECT OBJCARDS.*, cust.FULL_NAME AS FULL_NAME_CUST, general.FUL' +
        'L_NAME AS FULL_NAME_GENERAL'
      'FROM OBJCARDS'
      'LEFT OUTER JOIN CLIENTS cust ON cust.CLIENT_ID=OBJCARDS.cust_id'
      
        'LEFT OUTER JOIN CLIENTS general ON cust.CLIENT_ID=OBJCARDS.gener' +
        'al_id'
      'WHERE OBJ_ID=:OBJ_ID')
    Left = 345
    Top = 69
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
    Left = 384
    Top = 69
  end
  object dsClients: TDataSource
    DataSet = qrClients
    Left = 152
    Top = 253
  end
  object qrClients: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FormatOptions.AssignedValues = [fvDefaultParamDataType, fvFmtDisplayNumeric]
    FormatOptions.DefaultParamDataType = ftBCD
    FormatOptions.FmtDisplayNumeric = '### ### ### ### ### ### ##0.####'
    UpdateOptions.AssignedValues = [uvUpdateNonBaseFields]
    SQL.Strings = (
      'SELECT * FROM clients')
    Left = 103
    Top = 253
  end
end
