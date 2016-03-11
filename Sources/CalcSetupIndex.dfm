object fCalcSetupIndex: TfCalcSetupIndex
  Left = 0
  Top = 0
  Caption = #1048#1085#1076#1077#1082#1089#1099' '#1088#1086#1089#1090#1072
  ClientHeight = 234
  ClientWidth = 335
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    335
    234)
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 8
    Top = 8
    Width = 93
    Height = 39
    Caption = #1044#1072#1090#1072' '#1089#1086#1089#1090#1072#1074#1083#1077#1085#1080#1103#13#10#1089#1084#1077#1090#1099' '#1085#1072' '#1087#1077#1088#1074#1086#1077#13#10#1095#1080#1089#1083#1086
  end
  object lbl2: TLabel
    Left = 115
    Top = 8
    Width = 91
    Height = 39
    Caption = #1044#1072#1090#1072' '#1085#1072#1095#1072#1083#1072' '#13#10#1089#1090#1088#1086#1080#1090#1077#1083#1100#1089#1090#1074#1072' '#1085#1072#13#10#1087#1077#1088#1074#1086#1077' '#1095#1080#1089#1083#1086
  end
  object lbl3: TLabel
    Left = 224
    Top = 8
    Width = 91
    Height = 39
    Caption = #1044#1072#1090#1072' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1103#13#10#1088#1072#1073#1086#1090' '#1085#1072' '#1082#1086#1085#1077#1094#13#10#1084#1077#1089#1103#1094#1072
  end
  object lbl4: TLabel
    Left = 8
    Top = 112
    Width = 85
    Height = 26
    Caption = #1056#1072#1089#1095#1077#1090' '#13#10#1087#1088#1086#1080#1079#1074#1086#1076#1080#1090#1100' '#1087#1086':'
  end
  object lbl5: TLabel
    Left = 115
    Top = 72
    Width = 80
    Height = 39
    Caption = #1048#1085#1076#1077#1082#1089' '#1085#1072' '#1076#1072#1090#1091#13#10#1085#1072#1095#1072#1083#1072' '#13#10#1089#1090#1088#1086#1080#1090#1077#1083#1100#1089#1090#1074#1072
  end
  object lbl6: TLabel
    Left = 224
    Top = 72
    Width = 80
    Height = 39
    Caption = #1048#1085#1076#1077#1082#1089' '#1085#1072' '#1076#1072#1090#1091#13#10#1074#1099#1087#1086#1083#1085#1077#1085#1080#1103#13#10#1088#1072#1073#1086#1090
  end
  object lbl7: TLabel
    Left = 116
    Top = 171
    Width = 102
    Height = 13
    Caption = #1048#1085#1076#1077#1082#1089' '#1088#1086#1089#1090#1072' '#1088#1072#1074#1077#1085
  end
  object JvDBLookupCombo1: TJvDBLookupCombo
    Left = 115
    Top = 117
    Width = 103
    Height = 21
    DropDownCount = 2
    DataField = 'INDEX_TYPE_BEGIN'
    DataSource = dsMain
    LookupField = 'index_type_id'
    LookupDisplay = 'index_type_name'
    LookupSource = dsInd
    TabOrder = 3
    OnChange = JvDBDateTimePicker3Change
  end
  object JvDBLookupCombo2: TJvDBLookupCombo
    Left = 224
    Top = 117
    Width = 103
    Height = 21
    DropDownCount = 2
    DataField = 'INDEX_TYPE_END'
    DataSource = dsMain
    LookupField = 'index_type_id'
    LookupDisplay = 'index_type_name'
    LookupSource = dsInd
    TabOrder = 4
    OnChange = JvDBDateTimePicker3Change
  end
  object dbedtINDEX_VAL_BEGIN: TDBEdit
    Left = 115
    Top = 144
    Width = 103
    Height = 21
    DataField = 'INDEX_VAL_BEGIN'
    DataSource = dsMain
    TabOrder = 5
    OnChange = dbedtINDEX_VAL_ENDChange
  end
  object dbedtINDEX_VAL_END: TDBEdit
    Left = 224
    Top = 144
    Width = 103
    Height = 21
    DataField = 'INDEX_VAL_END'
    DataSource = dsMain
    TabOrder = 6
    OnChange = dbedtINDEX_VAL_ENDChange
  end
  object btnCancel: TBitBtn
    Left = 252
    Top = 201
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1054#1090#1084#1077#1085#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
    OnClick = btnCancelClick
    ExplicitLeft = 251
    ExplicitTop = 249
  end
  object btnSave: TBitBtn
    Left = 171
    Top = 201
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
    OnClick = btnSaveClick
    ExplicitLeft = 170
    ExplicitTop = 249
  end
  object dbedtINDEX_VAL: TDBEdit
    Left = 224
    Top = 171
    Width = 103
    Height = 21
    DataField = 'INDEX_VAL'
    DataSource = dsMain
    TabOrder = 7
  end
  object JvDBDateTimePicker1: TJvDBDateTimePicker
    Left = 115
    Top = 53
    Width = 103
    Height = 21
    Date = 0.023611111111111110
    Format = 'MMMM yyyy'
    Time = 0.023611111111111110
    DateFormat = dfLong
    TabOrder = 1
    OnChange = JvDBDateTimePicker3Change
    DataField = 'DATE_BEGIN'
    DataSource = dsMain
  end
  object JvDBDateTimePicker2: TJvDBDateTimePicker
    Left = 224
    Top = 53
    Width = 103
    Height = 21
    Date = 0.023611111111111110
    Format = 'MMMM yyyy'
    Time = 0.023611111111111110
    DateFormat = dfLong
    TabOrder = 2
    OnChange = JvDBDateTimePicker3Change
    DropDownDate = 42439.000000000000000000
    DataField = 'DATE_END'
    DataSource = dsMain
  end
  object JvDBDateTimePicker3: TJvDBDateTimePicker
    Left = 8
    Top = 53
    Width = 103
    Height = 21
    Date = 0.023611111111111110
    Format = 'MMMM yyyy'
    Time = 0.023611111111111110
    DateFormat = dfLong
    TabOrder = 0
    OnChange = JvDBDateTimePicker3Change
    DropDownDate = 42439.000000000000000000
    DataField = 'DATE_CREATE'
    DataSource = dsMain
  end
  object qrMain: TFDQuery
    AutoCalcFields = False
    BeforeOpen = qrMainBeforeOpen
    OnNewRecord = qrMainNewRecord
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvUpdateChngFields, uvUpdateMode, uvCountUpdatedRecords, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable, uvUpdateNonBaseFields]
    UpdateOptions.EnableDelete = False
    UpdateOptions.CountUpdatedRecords = False
    UpdateOptions.CheckRequired = False
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.CheckUpdatable = False
    UpdateOptions.UpdateTableName = 'smeta.calc_setup'
    UpdateOptions.KeyFields = 'CALC_SETUP_ID'
    SQL.Strings = (
      'SELECT *'
      'FROM calc_setup'
      
        'WHERE (OBJ_ID=:OBJ_ID AND IFNULL(SM_ID, 0)=IFNULL(:SM_ID, 0)) OR' +
        ' '
      
        '      (IFNULL(:OBJ_ID, 0)=0 AND IFNULL(SM_ID, 0)=IFNULL(:SM_ID, ' +
        '0))')
    Left = 40
    Top = 136
    ParamData = <
      item
        Name = 'OBJ_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 0
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
    Left = 8
    Top = 136
  end
  object FormStorage: TJvFormStorage
    AppStorage = FormMain.AppIni
    AppStoragePath = '%FORM_NAME%\'
    Options = [fpSize]
    StoredValues = <>
    Left = 72
    Top = 136
  end
  object qrInd: TFDQuery
    AutoCalcFields = False
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvUpdateChngFields, uvUpdateMode, uvCountUpdatedRecords, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable, uvUpdateNonBaseFields]
    UpdateOptions.EnableDelete = False
    UpdateOptions.CountUpdatedRecords = False
    UpdateOptions.CheckRequired = False
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.CheckUpdatable = False
    UpdateOptions.UpdateTableName = 'smeta.calc_setup'
    UpdateOptions.KeyFields = 'CALC_SETUP_ID'
    SQL.Strings = (
      'SELECT *'
      'FROM index_type')
    Left = 40
    Top = 184
  end
  object dsInd: TDataSource
    DataSet = qrInd
    Left = 8
    Top = 184
  end
end
