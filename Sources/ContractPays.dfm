object fContractPays: TfContractPays
  Left = 0
  Top = 0
  Caption = #1043#1088#1072#1092#1080#1082' '#1087#1083#1072#1090#1077#1078#1077#1081' '#1076#1083#1103' '#1043#1055#1056
  ClientHeight = 307
  ClientWidth = 923
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
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object pnlTopEstimate: TPanel
    Left = 0
    Top = 0
    Width = 923
    Height = 29
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      923
      29)
    object lblEstimate: TLabel
      Left = 8
      Top = 6
      Width = 47
      Height = 13
      Caption = #1057#1090#1088#1086#1081#1082#1072':'
    end
    object dbedtFN_getSMName: TDBEdit
      Left = 55
      Top = 3
      Width = 862
      Height = 21
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      DataField = 'FULL_NAME'
      DataSource = dsHead
      ReadOnly = True
      TabOrder = 0
    end
  end
  object pnlTopSourceData: TPanel
    Left = 0
    Top = 29
    Width = 923
    Height = 20
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      923
      20)
    object GridPanel2: TGridPanel
      Left = 8
      Top = 1
      Width = 909
      Height = 14
      Anchors = [akLeft, akTop, akRight]
      BevelOuter = bvNone
      ColumnCollection = <
        item
          SizeStyle = ssAbsolute
          Value = 220.000000000000000000
        end
        item
          Value = 50.000000000000000000
        end
        item
          SizeStyle = ssAbsolute
          Value = 155.000000000000000000
        end
        item
          Value = 50.000000000000000000
        end
        item
          SizeStyle = ssAbsolute
          Value = 185.000000000000000000
        end
        item
          SizeStyle = ssAbsolute
          Value = 30.000000000000000000
        end>
      ControlCollection = <
        item
          Column = 0
          Control = lbl1
          Row = 0
        end
        item
          Column = 1
          Control = dbtxtBEG_STROJ
          Row = 0
        end
        item
          Column = 2
          Control = lbl2
          Row = 0
        end
        item
          Column = 3
          Control = dbtxtBEG_STROJ2
          Row = 0
        end
        item
          Column = 4
          Control = lbl3
          Row = 0
        end
        item
          Column = 5
          Control = dbtxtSROK_STROJ
          Row = 0
        end>
      RowCollection = <
        item
          Value = 100.000000000000000000
        end>
      TabOrder = 0
      object lbl1: TLabel
        Left = 0
        Top = 0
        Width = 212
        Height = 14
        Align = alLeft
        Caption = #1044#1072#1090#1072' '#1088#1072#1079#1088#1072#1073#1086#1090#1082#1080' '#1089#1084#1077#1090#1085#1086#1081' '#1076#1086#1082#1091#1084#1077#1085#1090#1072#1094#1080#1080':'
        ExplicitHeight = 13
      end
      object dbtxtBEG_STROJ: TDBText
        Left = 220
        Top = 0
        Width = 159
        Height = 14
        Align = alClient
        Alignment = taCenter
        DataField = 'BEG_STROJ'
        DataSource = dsHead
        ExplicitLeft = 218
        ExplicitWidth = 95
      end
      object lbl2: TLabel
        Left = 379
        Top = 0
        Width = 148
        Height = 14
        Align = alLeft
        Caption = #1044#1072#1090#1072' '#1085#1072#1095#1072#1083#1072' '#1089#1090#1088#1086#1080#1090#1077#1083#1100#1089#1090#1074#1072':'
        ExplicitHeight = 13
      end
      object dbtxtBEG_STROJ2: TDBText
        Left = 534
        Top = 0
        Width = 159
        Height = 14
        Align = alClient
        Alignment = taCenter
        DataField = 'BEG_STROJ2'
        DataSource = dsHead
        ExplicitLeft = 450
        ExplicitTop = 12
        ExplicitWidth = 60
        ExplicitHeight = 13
      end
      object lbl3: TLabel
        Left = 693
        Top = 0
        Width = 178
        Height = 14
        Align = alLeft
        Caption = #1053#1086#1088#1084#1072#1090#1080#1074#1085#1099#1081' '#1089#1088#1086#1082' '#1089#1090#1088#1086#1080#1090#1077#1083#1100#1089#1090#1074#1072':'
        ExplicitHeight = 13
      end
      object dbtxtSROK_STROJ: TDBText
        Left = 878
        Top = 0
        Width = 30
        Height = 14
        Align = alClient
        Alignment = taCenter
        DataField = 'SROK_STROJ'
        DataSource = dsHead
        ExplicitLeft = 730
        ExplicitTop = 12
        ExplicitWidth = 50
        ExplicitHeight = 13
      end
    end
  end
  object pnlClient: TPanel
    Left = 0
    Top = 49
    Width = 923
    Height = 258
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitTop = 213
    ExplicitHeight = 234
    object grMain: TJvDBGrid
      Left = 0
      Top = 0
      Width = 923
      Height = 258
      Align = alClient
      DataSource = dsMain
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnDrawColumnCell = grMainDrawColumnCell
      OnKeyDown = grMainKeyDown
      SelectColumnsDialogStrings.Caption = 'Select columns'
      SelectColumnsDialogStrings.OK = '&OK'
      SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
      EditControls = <>
      RowsHeight = 17
      TitleRowHeight = 17
      OnCanEditCell = grMainCanEditCell
    end
  end
  object qrHead: TFDQuery
    BeforeOpen = qrHeadBeforeOpen
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FetchOptions.AssignedValues = [evCache]
    FetchOptions.Cache = [fiBlobs, fiMeta]
    FormatOptions.AssignedValues = [fvMapRules, fvDefaultParamDataType, fvFmtDisplayDate]
    FormatOptions.OwnMapRules = True
    FormatOptions.MapRules = <
      item
        SourceDataType = dtMemo
        TargetDataType = dtAnsiString
      end
      item
        SourceDataType = dtByteString
        TargetDataType = dtAnsiString
      end>
    FormatOptions.DefaultParamDataType = ftBCD
    FormatOptions.FmtDisplayDate = 'MMMM YYYY'
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.CheckUpdatable = False
    SQL.Strings = (
      'SELECT o.*'
      'FROM objcards AS o'
      'WHERE o.OBJ_ID=:OBJ_ID')
    Left = 688
    Top = 64
    ParamData = <
      item
        Name = 'OBJ_ID'
        DataType = ftBCD
        ParamType = ptInput
      end>
  end
  object dsHead: TDataSource
    DataSet = qrHead
    Left = 728
    Top = 64
  end
  object qrMain: TFDQuery
    BeforeOpen = qrHeadBeforeOpen
    BeforePost = qrMainBeforePost
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FetchOptions.AssignedValues = [evCache]
    FetchOptions.Cache = [fiBlobs, fiMeta]
    FormatOptions.AssignedValues = [fvMapRules, fvDefaultParamDataType]
    FormatOptions.OwnMapRules = True
    FormatOptions.MapRules = <
      item
        SourceDataType = dtMemo
        TargetDataType = dtAnsiString
      end
      item
        SourceDataType = dtByteString
        TargetDataType = dtAnsiString
      end>
    FormatOptions.DefaultParamDataType = ftBCD
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.CheckUpdatable = False
    SQL.Strings = (
      'SELECT '
      '  1 AS CODE,'
      '  0 AS EDITABLE,'
      '  "'#1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1089#1086#1075#1083#1072#1089#1085#1086' '#1075#1088#1072#1092#1080#1082#1091' '#1087#1088#1086#1080#1079#1074#1086#1076#1089#1090#1074#1072'" AS ROW_NAME,'
      '  FN_ROUND('
      
        '  (SELECT SUM(IFNULL(cp.contract_price, 0)) FROM contract_price ' +
        'AS cp, smetasourcedata AS s, objcards AS o WHERE s.OBJ_ID=:OBJ_I' +
        'D AND o.OBJ_ID=s.OBJ_ID AND cp.SM_ID=s.SM_ID AND s.ACT=0 AND s.S' +
        'M_TYPE=CASE o.CONTRACT_PRICE_TYPE_ID WHEN 1 THEN 3 WHEN 2 THEN 1' +
        ' WHEN 3 THEN 2 ELSE 0 END AND cp.OnDate BETWEEN o.BEG_STROJ2 AND' +
        ' DATE_ADD(o.BEG_STROJ2, INTERVAL (o.SROK_STROJ - 1) MONTH))'
      '  / 1000000.0, 0.001, 0) AS TOTAL,'
      '  #CONTRACT_PRICE_FIELDS#'
      ''
      'UNION ALL'
      ''
      'SELECT '
      '  2 AS CODE,'
      '  0 AS EDITABLE,'
      '  "  '#1074' '#1090#1086#1084' '#1095#1080#1089#1083#1077':" AS ROW_NAME,'
      '  NULL AS TOTAL, '
      '  #EMPTY_FIELDS#'
      ''
      'UNION ALL'
      ''
      'SELECT '
      '  3 AS CODE,'
      '  0 AS EDITABLE,'
      '  "    '#1089#1090#1086#1080#1084#1086#1089#1090#1100' '#1084#1072#1090#1077#1088#1080#1072#1083#1086#1074', '#1080#1079#1076#1077#1083#1080#1081' '#1080' '#1082#1086#1085#1089#1090#1088#1091#1082#1094#1080#1081'" AS ROW_NAME,'
      '  FN_ROUND('
      
        '  (SELECT SUM(IFNULL(cp.MAT_PODR_IND, 0)) FROM contract_price AS' +
        ' cp, smetasourcedata AS s, objcards AS o WHERE s.OBJ_ID=:OBJ_ID ' +
        'AND o.OBJ_ID=s.OBJ_ID AND cp.SM_ID=s.SM_ID AND s.ACT=0 AND s.SM_' +
        'TYPE=CASE o.CONTRACT_PRICE_TYPE_ID WHEN 1 THEN 3 WHEN 2 THEN 1 W' +
        'HEN 3 THEN 2 ELSE 0 END AND cp.OnDate BETWEEN o.BEG_STROJ2 AND D' +
        'ATE_ADD(o.BEG_STROJ2, INTERVAL (o.SROK_STROJ - 1) MONTH))'
      '  / 1000000.0, 0.001, 0) AS TOTAL,'
      '  #MAT_PODR_IND_FIELDS#'
      ''
      'UNION ALL'
      ''
      'SELECT '
      '  4 AS CODE,'
      '  0 AS EDITABLE,'
      '  "    '#1089#1090#1086#1080#1084#1086#1089#1090#1100' '#1086#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1103', '#1084#1077#1073#1077#1083#1080', '#1080#1085#1074#1077#1085#1090#1072#1088#1103'" AS ROW_NAME,'
      '  FN_ROUND('
      
        '  (SELECT SUM(IFNULL(cp.DEVICE_PODR_IND, 0)) FROM contract_price' +
        ' AS cp, smetasourcedata AS s, objcards AS o WHERE s.OBJ_ID=:OBJ_' +
        'ID AND o.OBJ_ID=s.OBJ_ID AND cp.SM_ID=s.SM_ID AND s.ACT=0 AND s.' +
        'SM_TYPE=CASE o.CONTRACT_PRICE_TYPE_ID WHEN 1 THEN 3 WHEN 2 THEN ' +
        '1 WHEN 3 THEN 2 ELSE 0 END AND cp.OnDate BETWEEN o.BEG_STROJ2 AN' +
        'D DATE_ADD(o.BEG_STROJ2, INTERVAL (o.SROK_STROJ - 1) MONTH))'
      '  / 1000000.0, 0.001, 0) AS TOTAL,'
      '  #DEVICE_PODR_IND_FIELDS#'
      ''
      'UNION ALL'
      ''
      'SELECT '
      '  5 AS CODE,'
      '  0 AS EDITABLE,'
      '  "'#1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1089#1086#1075#1083#1072#1089#1085#1086' '#1075#1088#1072#1092#1080#1082#1072' '#1087#1083#1072#1090#1077#1078#1077#1081'" AS ROW_NAME,'
      
        '  (SELECT SUM(IFNULL(cp.TOTAL, 0)) FROM contract_pay AS cp, objc' +
        'ards AS o WHERE cp.OBJ_ID=:OBJ_ID AND o.OBJ_ID=:OBJ_ID AND cp.On' +
        'Date BETWEEN DATE_ADD(o.BEG_STROJ2, INTERVAL -1 MONTH) AND DATE_' +
        'ADD(o.BEG_STROJ2, INTERVAL (o.SROK_STROJ - 1) MONTH))'
      '  AS TOTAL,'
      '  #TOTAL_FIELDS#'
      'UNION ALL'
      ''
      'SELECT '
      '  6 AS CODE,'
      '  0 AS EDITABLE,'
      '  "  '#1074' '#1090#1086#1084' '#1095#1080#1089#1083#1077':" AS ROW_NAME,'
      '  NULL AS TOTAL,'
      '  #EMPTY_FIELDS#'
      ''
      'UNION ALL'
      ''
      'SELECT '
      '  7 AS CODE,'
      '  0 AS EDITABLE,'
      '  "    '#1088#1072#1089#1095#1077#1090' '#1079#1072' '#1074#1099#1087#1086#1083#1085#1077#1085#1085#1099#1077' '#1101#1090#1072#1087#1099' '#1088#1072#1073#1086#1090' ('#1088#1072#1073#1086#1090#1099')" AS ROW_NAME,'
      
        '  (SELECT SUM(IFNULL(cp.CALC_SUM, 0)) FROM contract_pay AS cp, o' +
        'bjcards AS o WHERE cp.OBJ_ID=:OBJ_ID AND o.OBJ_ID=:OBJ_ID AND cp' +
        '.OnDate BETWEEN DATE_ADD(o.BEG_STROJ2, INTERVAL -1 MONTH) AND DA' +
        'TE_ADD(o.BEG_STROJ2, INTERVAL (o.SROK_STROJ - 1) MONTH))'
      '  AS TOTAL,'
      '  #CALC_SUM_FIELDS#'
      ''
      'UNION ALL'
      ''
      'SELECT '
      '  8 AS CODE,'
      '  1 AS EDITABLE,'
      
        '  "    '#1072#1074#1072#1085#1089' '#1085#1072' '#1079#1072#1082#1091#1087#1082#1091' '#1084#1072#1090#1077#1088#1080#1072#1083#1086#1074', '#1080#1079#1076#1077#1083#1080#1081' '#1080' '#1082#1086#1085#1089#1090#1088#1091#1082#1094#1080#1081'" AS RO' +
        'W_NAME,'
      
        '  (SELECT SUM(IFNULL(cp.PRE_PAY_MAT, 0)) FROM contract_pay AS cp' +
        ', objcards AS o WHERE cp.OBJ_ID=:OBJ_ID AND o.OBJ_ID=:OBJ_ID AND' +
        ' cp.OnDate BETWEEN DATE_ADD(o.BEG_STROJ2, INTERVAL -1 MONTH) AND' +
        ' DATE_ADD(o.BEG_STROJ2, INTERVAL (o.SROK_STROJ - 1) MONTH))'
      '  AS TOTAL,'
      '  #PRE_PAY_MAT_FIELDS#'
      ''
      'UNION ALL'
      ''
      'SELECT '
      '  9 AS CODE,'
      '  1 AS EDITABLE,'
      '  "    '#1072#1074#1072#1085#1089' '#1085#1072' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1077' '#1088#1072#1073#1086#1090'" AS ROW_NAME,'
      
        '  (SELECT SUM(IFNULL(cp.PRE_PAY_WORK, 0)) FROM contract_pay AS c' +
        'p, objcards AS o WHERE cp.OBJ_ID=:OBJ_ID AND o.OBJ_ID=:OBJ_ID AN' +
        'D cp.OnDate BETWEEN DATE_ADD(o.BEG_STROJ2, INTERVAL -1 MONTH) AN' +
        'D DATE_ADD(o.BEG_STROJ2, INTERVAL (o.SROK_STROJ - 1) MONTH))'
      '  AS TOTAL,'
      '  #PRE_PAY_WORK_FIELDS#')
    Left = 296
    Top = 240
    ParamData = <
      item
        Name = 'OBJ_ID'
        ParamType = ptInput
      end>
  end
  object dsMain: TDataSource
    DataSet = qrMain
    Left = 336
    Top = 240
  end
  object FormStorage: TJvFormStorage
    AppStorage = FormMain.AppIni
    AppStoragePath = '%FORM_NAME%\'
    Options = [fpSize, fpActiveControl]
    StoredValues = <>
    Left = 32
    Top = 224
  end
end
