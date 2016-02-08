object fCardAct: TfCardAct
  Left = 0
  Top = 0
  BiDiMode = bdLeftToRight
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1050#1072#1088#1090#1086#1095#1082#1072' '#1072#1082#1090#1072
  ClientHeight = 342
  ClientWidth = 455
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  ParentBiDiMode = False
  ShowHint = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    455
    342)
  PixelsPerInch = 96
  TextHeight = 13
  object bvl1: TBevel
    Left = 8
    Top = 8
    Width = 439
    Height = 81
    Anchors = [akLeft, akTop, akRight]
    Shape = bsBottomLine
    ExplicitWidth = 444
  end
  object Bevel: TBevel
    Left = 0
    Top = 301
    Width = 455
    Height = 41
    Align = alBottom
    Shape = bsTopLine
    ExplicitTop = 106
    ExplicitWidth = 392
  end
  object lblDate: TLabel
    Left = 8
    Top = 8
    Width = 97
    Height = 13
    Caption = #1044#1072#1090#1072' '#1089#1086#1089#1090#1072#1074#1083#1077#1085#1080#1103':'
  end
  object lbl2: TLabel
    Left = 228
    Top = 8
    Width = 49
    Height = 13
    Caption = #1058#1080#1087' '#1072#1082#1090#1072':'
  end
  object lbl1: TLabel
    Left = 8
    Top = 62
    Width = 41
    Height = 13
    Caption = #1055#1088#1086#1088#1072#1073':'
  end
  object lblName: TLabel
    Left = 8
    Top = 95
    Width = 52
    Height = 13
    Caption = #1053#1072#1079#1074#1072#1085#1080#1077':'
  end
  object lblDescription: TLabel
    Left = 8
    Top = 122
    Width = 53
    Height = 13
    Caption = #1054#1087#1080#1089#1072#1085#1080#1077':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object bvl2: TBevel
    Left = 8
    Top = 184
    Width = 439
    Height = 9
    Anchors = [akLeft, akTop, akRight]
    Shape = bsTopLine
    ExplicitWidth = 442
  end
  object lbl3: TLabel
    Left = 8
    Top = 199
    Width = 264
    Height = 13
    Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1087#1077#1095#1072#1090#1080' '#1072#1082#1090#1072' '#1074#1099#1087#1086#1083#1085#1077#1085#1085#1099#1093' '#1088#1072#1073#1086#1090':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl4: TLabel
    Left = 8
    Top = 226
    Width = 79
    Height = 13
    Caption = #1057#1091#1073#1087#1086#1076#1088#1103#1076#1095#1080#1082':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbl5: TLabel
    Left = 8
    Top = 253
    Width = 50
    Height = 13
    Caption = #1040#1082#1090' '#1089#1076#1072#1083':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbl6: TLabel
    Left = 228
    Top = 253
    Width = 62
    Height = 13
    Caption = #1040#1082#1090' '#1087#1088#1080#1085#1103#1083':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object ButtonSave: TButton
    Left = 241
    Top = 309
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
    TabOrder = 13
    OnClick = ButtonSaveClick
  end
  object btnClose: TButton
    Left = 347
    Top = 309
    Width = 100
    Height = 25
    Align = alCustom
    Anchors = [akRight, akBottom]
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 14
    OnClick = btnCloseClick
  end
  object cbbType: TComboBox
    Left = 283
    Top = 8
    Width = 163
    Height = 21
    Style = csDropDownList
    TabOrder = 1
    OnChange = cbbTypeChange
    OnCloseUp = cbbTypeCloseUp
    Items.Strings = (
      #1087#1086' '#1089#1084#1077#1090#1077
      #1085#1072' '#1076#1086#1087'. '#1088#1072#1073#1086#1090#1099
      #1080#1090#1086#1075#1086#1074#1099#1084#1080' '#1089#1091#1084#1084#1072#1084#1080)
  end
  object edDate: TJvDBDateEdit
    Left = 111
    Top = 8
    Width = 98
    Height = 21
    Align = alCustom
    DataField = 'DATE'
    DataSource = dsAct
    CheckOnExit = True
    ShowNullDate = False
    TabOrder = 0
    OnChange = edDateChange
  end
  object cbbPERFOM_ID: TComboBox
    Left = 283
    Top = 62
    Width = 163
    Height = 21
    Style = csDropDownList
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ItemIndex = 0
    ParentFont = False
    TabOrder = 6
    Text = #1057#1086#1073#1089#1090#1074#1077#1085#1085#1099#1077' '#1089#1080#1083#1099
    OnChange = cbbPERFOM_IDChange
    Items.Strings = (
      #1057#1086#1073#1089#1090#1074#1077#1085#1085#1099#1077' '#1089#1080#1083#1099
      #1057#1091#1073#1087#1086#1076#1088#1103#1076)
  end
  object dbedtNAME1: TDBEdit
    Left = 66
    Top = 62
    Width = 211
    Height = 21
    DataField = 'FOREMAN_'
    DataSource = dsAct
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 4
    OnChange = dbedtNAMEChange
  end
  object btnSelectForeman: TBitBtn
    Left = 254
    Top = 62
    Width = 23
    Height = 21
    Caption = '...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    TabStop = False
    OnClick = btnSelectForemanClick
  end
  object dbedtNAME: TDBEdit
    Left = 66
    Top = 95
    Width = 380
    Height = 21
    DataField = 'NAME'
    DataSource = dsAct
    ReadOnly = True
    TabOrder = 7
    OnChange = dbedtNAMEChange
  end
  object dbmmoDESCRIPTION: TDBMemo
    Left = 66
    Top = 122
    Width = 380
    Height = 55
    DataField = 'DESCRIPTION'
    DataSource = dsAct
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 8
  end
  object cbbPASSED_ID: TComboBox
    Left = 8
    Top = 272
    Width = 214
    Height = 21
    Style = csDropDownList
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ItemIndex = 0
    ParentFont = False
    TabOrder = 11
    Text = #1043#1077#1085#1087#1086#1076#1088#1103#1076#1095#1080#1082' ('#1055#1086#1076#1088#1103#1076#1095#1080#1082')'
    OnChange = cbbPASSED_IDChange
    Items.Strings = (
      #1043#1077#1085#1087#1086#1076#1088#1103#1076#1095#1080#1082' ('#1055#1086#1076#1088#1103#1076#1095#1080#1082')'
      #1057#1091#1073#1087#1086#1076#1088#1103#1076#1095#1080#1082)
  end
  object cbbRECEIVED_ID: TComboBox
    Left = 228
    Top = 272
    Width = 218
    Height = 21
    Style = csDropDownList
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ItemIndex = 0
    ParentFont = False
    TabOrder = 12
    Text = #1047#1072#1082#1072#1079#1095#1080#1082
    OnChange = cbbRECEIVED_IDChange
    Items.Strings = (
      #1047#1072#1082#1072#1079#1095#1080#1082
      #1043#1077#1085#1087#1086#1076#1088#1103#1076#1095#1080#1082' ('#1055#1086#1076#1088#1103#1076#1095#1080#1082')')
  end
  object dblkcbbSUB_CLIENT_ID: TDBLookupComboBox
    Left = 93
    Top = 226
    Width = 354
    Height = 21
    DataField = 'SUB_CLIENT_ID'
    DataSource = dsAct
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    KeyField = 'CLIENT_ID'
    ListField = 'NAME'
    ListSource = dsClients
    ParentFont = False
    TabOrder = 9
  end
  object btnSelectOrganization: TBitBtn
    Left = 425
    Top = 226
    Width = 22
    Height = 21
    Caption = '...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 10
    OnClick = btnSelectOrganizationClick
  end
  object dblkcbbTYPE_ACT_ID: TDBLookupComboBox
    Left = 283
    Top = 35
    Width = 163
    Height = 21
    DataField = 'TYPE_ACT_ID'
    DataSource = dsAct
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    KeyField = 'TYPE_ACT_ID'
    ListField = 'TYPE_ACT_NAME'
    ListSource = dsTYPE_ACT
    ParentFont = False
    TabOrder = 2
  end
  object btnSelectTypeAct: TBitBtn
    Left = 425
    Top = 35
    Width = 22
    Height = 21
    Caption = '...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnClick = btnSelectTypeActClick
  end
  object qrTemp: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FormatOptions.AssignedValues = [fvDefaultParamDataType]
    FormatOptions.DefaultParamDataType = ftBCD
    Left = 80
    Top = 32
  end
  object qrAct: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FormatOptions.AssignedValues = [fvMapRules]
    FormatOptions.OwnMapRules = True
    FormatOptions.MapRules = <
      item
        SourceDataType = dtMemo
        TargetDataType = dtAnsiString
      end>
    UpdateOptions.AssignedValues = [uvEDelete, uvUpdateChngFields, uvRefreshMode, uvCheckReadOnly, uvCheckUpdatable, uvUpdateNonBaseFields]
    UpdateOptions.RefreshMode = rmAll
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.CheckUpdatable = False
    UpdateOptions.UpdateTableName = 'smeta.smetasourcedata'
    UpdateOptions.KeyFields = 'ID'
    SQL.Strings = (
      'select smetasourcedata.*, '
      
        'CONCAT(IFNULL(foreman_first_name, ""), " ", IFNULL(foreman_name,' +
        ' ""), " ", IFNULL(foreman_second_name, "")) AS FOREMAN_'
      'from smetasourcedata'
      
        'LEFT JOIN foreman ON smetasourcedata.foreman_id=foreman.foreman_' +
        'id'
      'where SM_ID=:id')
    Left = 112
    Top = 32
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object dsAct: TDataSource
    DataSet = qrAct
    Left = 16
    Top = 32
  end
  object qrMain: TFDQuery
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
    Left = 48
    Top = 32
    ParamData = <
      item
        Name = 'SM_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
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
    Left = 111
    Top = 213
  end
  object dsClients: TDataSource
    DataSet = qrClients
    Left = 160
    Top = 213
  end
  object dsTYPE_ACT: TDataSource
    DataSet = qrTYPE_ACT
    Left = 224
    Top = 29
  end
  object qrTYPE_ACT: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FormatOptions.AssignedValues = [fvDefaultParamDataType, fvFmtDisplayNumeric]
    FormatOptions.DefaultParamDataType = ftBCD
    FormatOptions.FmtDisplayNumeric = '### ### ### ### ### ### ##0.####'
    UpdateOptions.AssignedValues = [uvUpdateNonBaseFields]
    SQL.Strings = (
      'SELECT * FROM TYPE_ACT')
    Left = 175
    Top = 29
  end
end
