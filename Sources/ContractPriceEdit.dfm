object fContractPriceEdit: TfContractPriceEdit
  Left = 0
  Top = 0
  Caption = #1056#1072#1089#1095#1077#1090' '#1080#1085#1076#1077#1082#1089#1072#1094#1080#1080' '#1076#1083#1103' '#1055#1043#1056
  ClientHeight = 498
  ClientWidth = 802
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
    Width = 802
    Height = 29
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      802
      29)
    object lblEstimate: TLabel
      Left = 8
      Top = 6
      Width = 35
      Height = 13
      Caption = #1057#1084#1077#1090#1072':'
    end
    object dbedtFN_getSMName: TDBEdit
      Left = 49
      Top = 3
      Width = 747
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
    Width = 802
    Height = 184
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      802
      184)
    object GridPanel1: TGridPanel
      Left = 8
      Top = 21
      Width = 593
      Height = 161
      Align = alCustom
      BevelOuter = bvNone
      ColumnCollection = <
        item
          Value = 100.000000000000000000
        end
        item
          SizeStyle = ssAbsolute
          Value = 150.000000000000000000
        end>
      ControlCollection = <
        item
          Column = 0
          Control = lbl4
          Row = 0
        end
        item
          Column = 1
          Control = dbedtFULL_NAME
          Row = 0
        end
        item
          Column = 0
          Control = lbl5
          Row = 1
        end
        item
          Column = 1
          Control = dbedtFULL_NAME1
          Row = 1
        end
        item
          Column = 0
          Control = lbl6
          Row = 2
        end
        item
          Column = 1
          Control = dbedtFULL_NAME2
          Row = 2
        end
        item
          Column = 0
          Control = lbl7
          Row = 3
        end
        item
          Column = 1
          Control = dbedtFULL_NAME3
          Row = 3
        end
        item
          Column = 0
          Control = lbl8
          Row = 4
        end
        item
          Column = 1
          Control = dbedtFULL_NAME4
          Row = 4
        end
        item
          Column = 0
          Control = lbl9
          Row = 5
        end
        item
          Column = 1
          Control = dbedtFULL_NAME5
          Row = 5
        end
        item
          Column = 0
          Control = lbl10
          Row = 6
        end
        item
          Column = 1
          Control = dbedtFULL_NAME6
          Row = 6
        end>
      RowCollection = <
        item
          SizeStyle = ssAbsolute
          Value = 23.000000000000000000
        end
        item
          SizeStyle = ssAbsolute
          Value = 23.000000000000000000
        end
        item
          SizeStyle = ssAbsolute
          Value = 23.000000000000000000
        end
        item
          SizeStyle = ssAbsolute
          Value = 23.000000000000000000
        end
        item
          SizeStyle = ssAbsolute
          Value = 23.000000000000000000
        end
        item
          SizeStyle = ssAbsolute
          Value = 23.000000000000000000
        end
        item
          SizeStyle = ssAbsolute
          Value = 23.000000000000000000
        end>
      TabOrder = 1
      DesignSize = (
        593
        161)
      object lbl4: TLabel
        AlignWithMargins = True
        Left = 117
        Top = 3
        Width = 316
        Height = 17
        Margins.Right = 10
        Align = alRight
        Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1088#1072#1073#1086#1090' '#1085#1072' '#1076#1072#1090#1091' '#1088#1072#1079#1088#1072#1073#1086#1090#1082#1080' '#1089#1084#1077#1090#1085#1086#1081' '#1076#1086#1082#1091#1084#1077#1085#1090#1072#1094#1080#1080':'
        ExplicitHeight = 13
      end
      object dbedtFULL_NAME: TDBEdit
        Left = 443
        Top = 0
        Width = 150
        Height = 21
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        Color = clBtnFace
        DataSource = dsHead
        ReadOnly = True
        TabOrder = 0
      end
      object lbl5: TLabel
        AlignWithMargins = True
        Left = 184
        Top = 26
        Width = 249
        Height = 17
        Margins.Right = 10
        Align = alRight
        Caption = #1074' '#1090'.'#1095'. '#1089#1090#1086#1080#1084#1086#1089#1090#1100' '#1084#1072#1090#1077#1088#1080#1072#1083#1086#1074' '#1087#1086#1076#1088#1103#1076#1095#1080#1082#1072' '#1089' '#1053#1044#1057':'
        ExplicitHeight = 13
      end
      object dbedtFULL_NAME1: TDBEdit
        Left = 443
        Top = 23
        Width = 150
        Height = 21
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        Color = clBtnFace
        DataSource = dsHead
        ReadOnly = True
        TabOrder = 1
      end
      object lbl6: TLabel
        AlignWithMargins = True
        Left = 201
        Top = 49
        Width = 232
        Height = 17
        Margins.Right = 10
        Align = alRight
        Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1086#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1103' '#1087#1086#1076#1088#1103#1076#1095#1080#1082#1072' '#1089' '#1053#1044#1057':'
        ExplicitHeight = 13
      end
      object dbedtFULL_NAME2: TDBEdit
        Left = 443
        Top = 46
        Width = 150
        Height = 21
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        Color = clBtnFace
        DataSource = dsHead
        ReadOnly = True
        TabOrder = 2
      end
      object lbl7: TLabel
        AlignWithMargins = True
        Left = 163
        Top = 72
        Width = 270
        Height = 17
        Margins.Right = 10
        Align = alRight
        Caption = #1074' '#1090'.'#1095'. '#1089#1090#1086#1080#1084#1086#1089#1090#1100' '#1079#1072#1090#1088#1072#1090', '#1085#1077' '#1087#1086#1076#1083#1077#1078#1072#1097#1080#1093' '#1080#1085#1077#1082#1089#1072#1094#1080#1080':'
        ExplicitHeight = 13
      end
      object dbedtFULL_NAME3: TDBEdit
        Left = 443
        Top = 69
        Width = 150
        Height = 21
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        Color = clBtnFace
        DataField = 'SUM_NO_INDEX'
        DataSource = dsHead
        ReadOnly = True
        TabOrder = 3
      end
      object lbl8: TLabel
        AlignWithMargins = True
        Left = 10
        Top = 95
        Width = 423
        Height = 17
        Margins.Right = 10
        Align = alRight
        Caption = 
          #1057#1090#1086#1080#1084#1086#1089#1090#1100', '#1087#1086#1076#1083#1077#1078#1072#1097#1072#1103' '#1080#1085#1076#1077#1082#1089#1072#1094#1080#1080', '#1085#1072' '#1076#1072#1090#1091' '#1088#1072#1079#1088#1072#1073#1086#1090#1082#1080' '#1089#1084#1077#1090#1085#1086#1081' '#1076#1086#1082 +
          #1091#1084#1077#1085#1090#1072#1094#1080#1080':'
        ExplicitHeight = 13
      end
      object dbedtFULL_NAME4: TDBEdit
        Left = 443
        Top = 92
        Width = 150
        Height = 21
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        Color = clBtnFace
        DataSource = dsHead
        ReadOnly = True
        TabOrder = 4
      end
      object lbl9: TLabel
        AlignWithMargins = True
        Left = 136
        Top = 118
        Width = 297
        Height = 17
        Margins.Right = 10
        Align = alRight
        Caption = #1055#1088#1086#1075#1085#1086#1079#1085#1099#1081' '#1080#1085#1076#1077#1082#1089' '#1087#1086#1089#1090#1072' '#1085#1072' '#1076#1072#1090#1091' '#1085#1072#1095#1072#1083#1072' '#1089#1090#1088#1086#1080#1090#1077#1083#1100#1089#1090#1074#1072':'
        ExplicitHeight = 13
      end
      object dbedtFULL_NAME5: TDBEdit
        Left = 443
        Top = 115
        Width = 150
        Height = 21
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        Color = clBtnFace
        DataField = 'START_INDEX'
        DataSource = dsHead
        ReadOnly = True
        TabOrder = 5
      end
      object lbl10: TLabel
        AlignWithMargins = True
        Left = 74
        Top = 141
        Width = 359
        Height = 17
        Margins.Right = 10
        Align = alRight
        Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100', '#1087#1086#1076#1083#1077#1078#1072#1097#1072#1103' '#1080#1085#1076#1077#1082#1089#1072#1094#1080#1080', '#1085#1072' '#1076#1072#1090#1091' '#1085#1072#1095#1072#1083#1072' '#1089#1090#1088#1086#1080#1090#1077#1083#1100#1089#1090#1074#1072':'
        ExplicitHeight = 13
      end
      object dbedtFULL_NAME6: TDBEdit
        Left = 443
        Top = 138
        Width = 150
        Height = 21
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        Color = clBtnFace
        DataSource = dsHead
        ReadOnly = True
        TabOrder = 6
      end
    end
    object GridPanel2: TGridPanel
      Left = 8
      Top = 1
      Width = 788
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
        Width = 99
        Height = 14
        Align = alClient
        Alignment = taCenter
        DataField = 'BEG_STROJ'
        DataSource = dsHead
        ExplicitLeft = 218
        ExplicitWidth = 95
      end
      object lbl2: TLabel
        Left = 319
        Top = 0
        Width = 148
        Height = 14
        Align = alLeft
        Caption = #1044#1072#1090#1072' '#1085#1072#1095#1072#1083#1072' '#1089#1090#1088#1086#1080#1090#1077#1083#1100#1089#1090#1074#1072':'
        ExplicitHeight = 13
      end
      object dbtxtBEG_STROJ2: TDBText
        Left = 474
        Top = 0
        Width = 99
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
        Left = 573
        Top = 0
        Width = 178
        Height = 14
        Align = alLeft
        Caption = #1053#1086#1088#1084#1072#1090#1080#1074#1085#1099#1081' '#1089#1088#1086#1082' '#1089#1090#1088#1086#1080#1090#1077#1083#1100#1089#1090#1074#1072':'
        ExplicitHeight = 13
      end
      object dbtxtSROK_STROJ: TDBText
        Left = 758
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
    Top = 213
    Width = 802
    Height = 244
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object grMain: TJvDBGrid
      Left = 0
      Top = 0
      Width = 802
      Height = 244
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
  object pnlBottom: TPanel
    Left = 0
    Top = 457
    Width = 802
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
  end
  object qrHead: TFDQuery
    BeforeOpen = qrHeadBeforeOpen
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FetchOptions.AssignedValues = [evCache]
    FetchOptions.Cache = [fiBlobs, fiMeta]
    FormatOptions.AssignedValues = [fvMapRules, fvDefaultParamDataType, fvFmtDisplayDate, fvFmtDisplayNumeric]
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
    FormatOptions.FmtDisplayNumeric = '#,0'
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.CheckUpdatable = False
    SQL.Strings = (
      'SELECT FN_getSMName(:SM_ID) AS FULL_NAME, o.*,'
      
        '  (SELECT SUM(IFNULL(SUM_NO_INDEX, 0)) FROM contract_price WHERE' +
        ' SM_ID=:SM_ID) AS SUM_NO_INDEX,'
      '  1 AS START_INDEX'
      'FROM objcards AS o '
      'WHERE OBJ_ID=:OBJ_ID')
    Left = 688
    Top = 64
    ParamData = <
      item
        Name = 'SM_ID'
        DataType = ftBCD
        ParamType = ptInput
      end
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
    AfterPost = qrMainAfterPost
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FetchOptions.AssignedValues = [evCache]
    FetchOptions.Cache = [fiBlobs, fiMeta]
    FormatOptions.AssignedValues = [fvMapRules, fvDefaultParamDataType, fvFmtDisplayNumeric]
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
      '  1 AS EDITABLE,'
      '  "'#1053#1086#1088#1084#1099' '#1079#1072#1076#1077#1083#1072' '#1074' '#1089#1090#1088#1086#1080#1090#1077#1083#1100#1089#1090#1074#1077' '#1087#1086' '#1084#1077#1089#1103#1094#1072#1084' (%)" AS ROW_NAME,'
      
        '  (100 - (SELECT SUM(IFNULL(PER_NORM_STROJ, 0)) FROM contract_pr' +
        'ice WHERE SM_ID=:SM_ID)) AS TOTAL,'
      '  #PER_NORM_STROJ_FIELDS#'
      ''
      'UNION ALL'
      ''
      'SELECT '
      '  2 AS CODE,'
      '  1 AS EDITABLE,'
      '  "'#1053#1086#1088#1084#1099' '#1079#1072#1076#1077#1083#1072' '#1087#1086' '#1086#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1102' '#1087#1086' '#1084#1077#1089#1103#1094#1072#1084' (%)" AS ROW_NAME,'
      
        '  (100 - (SELECT SUM(IFNULL(PER_NORM_DEVICE, 0)) FROM contract_p' +
        'rice WHERE SM_ID=:SM_ID)) AS TOTAL,'
      '  #PER_NORM_DEVICE_FIELDS#'
      ''
      'UNION ALL'
      ''
      'SELECT '
      '  3 AS CODE,'
      '  0 AS EDITABLE,'
      '  "'#1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1073#1077#1079' '#1086#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1103' ('#1088#1091#1073'.)" AS ROW_NAME,'
      
        '  (SELECT SUM(IFNULL(PRICE_NO_DEVICE, 0)) FROM contract_price WH' +
        'ERE SM_ID=:SM_ID) AS TOTAL,'
      '  #PRICE_NO_DEVICE_FIELDS#'
      ''
      'UNION ALL'
      ''
      'SELECT '
      '  4 AS CODE,'
      '  0 AS EDITABLE,'
      '  "    '#1074' '#1090'.'#1095'. '#1084#1072#1090#1077#1088#1080#1072#1083#1099' '#1087#1086#1076#1088#1103#1076#1095#1080#1082#1072' ('#1088#1091#1073'.)" AS ROW_NAME,'
      
        '  (SELECT SUM(IFNULL(MAT_PODR, 0)) FROM contract_price WHERE SM_' +
        'ID=:SM_ID) AS TOTAL,'
      '  #MAT_PODR_FIELDS#'
      ''
      'UNION ALL'
      ''
      'SELECT '
      '  5 AS CODE,'
      '  0 AS EDITABLE,'
      '  "'#1054#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1077' '#1087#1086#1076#1088#1103#1076#1095#1080#1082#1072' ('#1088#1091#1073'.)" AS ROW_NAME,'
      
        '  (SELECT SUM(IFNULL(DEVICE_PODR, 0)) FROM contract_price WHERE ' +
        'SM_ID=:SM_ID) AS TOTAL,'
      '  #DEVICE_PODR_FIELDS#'
      ''
      'UNION ALL'
      ''
      'SELECT '
      '  6 AS CODE,'
      '  0 AS EDITABLE,'
      
        '  "'#1045#1078#1077#1084#1077#1089#1103#1095#1085#1099#1081' '#1087#1088#1086#1075#1085#1086#1079#1085#1099#1081' '#1080#1085#1076#1077#1082#1089' '#1094#1077#1085' '#1074' '#1089#1090#1088#1086#1080#1090#1077#1083#1100#1089#1090#1074#1077' ('#1089' '#1085#1072#1088#1072#1089#1090#1072#1102 +
        #1097#1080#1084' '#1080#1090#1086#1075#1086#1084')" AS ROW_NAME,'
      '  NULL AS TOTAL,'
      '  #INDEX_FIELDS#'
      ''
      'UNION ALL'
      ''
      'SELECT '
      '  7 AS CODE,'
      '  0 AS EDITABLE,'
      
        '  "'#1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1073#1077#1079' '#1086#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1103' '#1089' '#1091#1095#1077#1090#1086#1084' '#1087#1088#1086#1075#1085#1086#1079#1085#1086#1075#1086' '#1080#1085#1076#1077#1082#1089#1072' ('#1088#1091#1073'.' +
        ')" AS ROW_NAME,'
      
        '  (SELECT SUM(IFNULL(PRICE_NO_DEVICE_IND, 0)) FROM contract_pric' +
        'e WHERE SM_ID=:SM_ID) AS TOTAL,'
      '  #PRICE_NO_DEVICE_IND_FIELDS#'
      ''
      'UNION ALL'
      ''
      'SELECT '
      '  8 AS CODE,'
      '  0 AS EDITABLE,'
      
        '  "    '#1074' '#1090'.'#1095'. '#1089#1090#1086#1080#1084#1086#1089#1090#1100' '#1084#1072#1090#1077#1088#1080#1072#1083#1086#1074' '#1087#1086#1076#1088#1103#1076#1095#1080#1082#1072' '#1089' '#1053#1044#1057'" AS ROW_NAME' +
        ','
      
        '  (SELECT SUM(IFNULL(MAT_PODR_IND, 0)) FROM contract_price WHERE' +
        ' SM_ID=:SM_ID) AS TOTAL,'
      '  #MAT_PODR_IND_FIELDS#'
      ''
      'UNION ALL'
      ''
      'SELECT '
      '  9 AS CODE,'
      '  0 AS EDITABLE,'
      
        '  "'#1054#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1077' '#1087#1086#1076#1088#1103#1076#1095#1080#1082#1072' '#1089' '#1091#1095#1077#1090#1086#1084' '#1087#1088#1086#1075#1085#1086#1079#1085#1086#1075#1086' '#1080#1085#1076#1077#1082#1089#1072'" AS ROW_' +
        'NAME,'
      
        '  (SELECT SUM(IFNULL(DEVICE_PODR_IND, 0)) FROM contract_price WH' +
        'ERE SM_ID=:SM_ID) AS TOTAL,'
      '  #DEVICE_PODR_IND_FIELDS#'
      ''
      'UNION ALL'
      ''
      'SELECT '
      '  10 AS CODE,'
      '  1 AS EDITABLE,'
      '  "'#1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1079#1072#1090#1088#1072#1090', '#1085#1077' '#1087#1086#1076#1083#1077#1078#1072#1097#1080#1093' '#1080#1085#1076#1077#1082#1089#1072#1094#1080#1080'" AS ROW_NAME,'
      
        '  (SELECT SUM(IFNULL(SUM_NO_INDEX, 0)) FROM contract_price WHERE' +
        ' SM_ID=:SM_ID) AS TOTAL,'
      '  #SUM_NO_INDEX_FIELDS#'
      ''
      'UNION ALL'
      ''
      'SELECT '
      '  11 AS CODE,'
      '  0 AS EDITABLE,'
      '  "'#1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1088#1072#1073#1086#1090' '#1087#1086' '#1076#1086#1075#1086#1074#1086#1088#1091'" AS ROW_NAME,'
      
        '  (SELECT SUM(IFNULL(CONTRACT_PRICE, 0)) FROM contract_price WHE' +
        'RE SM_ID=:SM_ID) AS TOTAL,'
      '  #CONTRACT_PRICE_FIELDS#')
    Left = 296
    Top = 240
    ParamData = <
      item
        Name = 'SM_ID'
        ParamType = ptInput
      end>
  end
  object dsMain: TDataSource
    DataSet = qrMain
    Left = 336
    Top = 240
  end
end
