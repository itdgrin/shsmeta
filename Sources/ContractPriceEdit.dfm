object fContractPriceEdit: TfContractPriceEdit
  Left = 0
  Top = 0
  Caption = #1056#1072#1089#1095#1077#1090' '#1080#1085#1076#1077#1082#1089#1072#1094#1080#1080' '#1043#1055#1056
  ClientHeight = 498
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
      Width = 35
      Height = 13
      Caption = #1057#1084#1077#1090#1072':'
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
    Height = 184
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      923
      184)
    object lbl11: TLabel
      Left = 607
      Top = 139
      Width = 41
      Height = 13
      Caption = #1048#1085#1076#1077#1082#1089':'
    end
    object dbtxtINDEX_NAME: TDBText
      Left = 654
      Top = 139
      Width = 142
      Height = 17
      DataField = 'INDEX_NAME'
      DataSource = dsHead
    end
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
        DataField = 'SUM_START'
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
        DataField = 'MR'
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
        DataField = 'DEV'
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
        DataField = 'SUM_TO_INDEX'
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
        Caption = #1055#1088#1086#1075#1085#1086#1079#1085#1099#1081' '#1080#1085#1076#1077#1082#1089' '#1088#1086#1089#1090#1072' '#1085#1072' '#1076#1072#1090#1091' '#1085#1072#1095#1072#1083#1072' '#1089#1090#1088#1086#1080#1090#1077#1083#1100#1089#1090#1074#1072':'
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
        DataField = 'SUM_START_INDEX'
        DataSource = dsHead
        ReadOnly = True
        TabOrder = 6
      end
    end
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
    Top = 213
    Width = 923
    Height = 234
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object grMain: TJvDBGrid
      Left = 0
      Top = 0
      Width = 923
      Height = 234
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
    Top = 447
    Width = 923
    Height = 51
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    object lbl12: TLabel
      Left = 8
      Top = 3
      Width = 483
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 
        #1048#1058#1054#1043#1054' '#1089#1090#1086#1080#1084#1086#1089#1090#1100' '#1088#1072#1073#1086#1090' '#1087#1086' '#1076#1086#1075#1086#1074#1086#1088#1085#1086#1081' ('#1082#1086#1085#1090#1088#1072#1082#1090#1085#1086#1081') '#1094#1077#1085#1077' '#1085#1072' '#1084#1086#1084#1077#1085#1090 +
        ' '#1079#1072#1082#1083#1102#1095#1077#1085#1080#1103' '#1076#1086#1075#1086#1074#1086#1088#1072':'
    end
    object lbl13: TLabel
      Left = 8
      Top = 27
      Width = 483
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 
        #1074' '#1090'.'#1095'. '#1089#1088#1077#1076#1089#1090#1074#1072', '#1091#1095#1080#1090#1099#1074#1072#1102#1097#1080#1077' '#1087#1088#1080#1084#1077#1085#1077#1085#1080#1077' '#1087#1088#1086#1075#1085#1086#1089#1079#1085#1099#1093' '#1080#1085#1076#1077#1082#1089#1086#1074' '#1088#1086#1089 +
        #1090#1072':'
    end
    object lbl14: TLabel
      Left = 592
      Top = 3
      Width = 242
      Height = 13
      Caption = #1057#1055#1056#1040#1042#1054#1063#1053#1054' '#1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1084#1072#1090#1077#1088#1080#1072#1083#1086#1074' '#1079#1072#1082#1072#1079#1095#1080#1082#1072':'
    end
    object lbl15: TLabel
      Left = 579
      Top = 27
      Width = 255
      Height = 13
      Caption = #1057#1055#1056#1040#1042#1054#1063#1053#1054' '#1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1086#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1103' '#1079#1072#1082#1072#1079#1095#1080#1082#1072':'
    end
    object dbedtSUM_START: TDBEdit
      Left = 497
      Top = 3
      Width = 76
      Height = 21
      TabStop = False
      Color = clBtnFace
      DataField = 'CONTRACT_PRICE_TOTAL'
      DataSource = dsHead
      ReadOnly = True
      TabOrder = 0
    end
    object dbedtSUM_START1: TDBEdit
      Left = 497
      Top = 27
      Width = 76
      Height = 21
      TabStop = False
      Color = clBtnFace
      DataField = 'SUM_INDEX'
      DataSource = dsHead
      ReadOnly = True
      TabOrder = 2
    end
    object dbedtSUM_START2: TDBEdit
      Left = 840
      Top = 3
      Width = 76
      Height = 21
      TabStop = False
      Color = clBtnFace
      DataField = 'MAT_ZAK'
      DataSource = dsHead
      ReadOnly = True
      TabOrder = 1
    end
    object dbedtSUM_START3: TDBEdit
      Left = 840
      Top = 27
      Width = 76
      Height = 21
      TabStop = False
      Color = clBtnFace
      DataField = 'DEV_ZAK'
      DataSource = dsHead
      ReadOnly = True
      TabOrder = 3
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
      'SELECT FN_getSMName(:SM_ID) AS FULL_NAME, o.*,'
      '  SSR.SUM_START,'
      '  FN_ROUND(SSR.MR * IF(o.STATE_NDS=1, 1, NDS.VAL), 1, 0) AS MR,'
      
        '  FN_ROUND(SSR.DEV * IF(o.STATE_NDS=1, 1, NDS.VAL), 1, 0) AS DEV' +
        ','
      '  SSR.MAT_ZAK,'
      '  SSR.DEV_ZAK,'
      '  CP.SUM_NO_INDEX,'
      '  SSR.SUM_START - CP.SUM_NO_INDEX AS SUM_TO_INDEX, '
      
        '  FN_getIndex(o.BEG_STROJ, DATE_ADD(o.BEG_STROJ2, INTERVAL -1 MO' +
        'NTH), o.index_type_id) AS START_INDEX,'
      
        '  FN_ROUND((SSR.SUM_START - CP.SUM_NO_INDEX)*FN_getIndex(o.BEG_S' +
        'TROJ, DATE_ADD(o.BEG_STROJ2, INTERVAL -1 MONTH), o.index_type_id' +
        '), 1, 0) AS SUM_START_INDEX,'
      
        '  (SELECT index_type_name FROM index_type WHERE index_type_ID=o.' +
        'index_type_id) AS INDEX_NAME,'
      '  CP.SUM_CONTRACT_PRICE AS CONTRACT_PRICE_TOTAL,'
      
        '  (CP.SUM_CONTRACT_PRICE - CP.SUM_NO_INDEX - FN_ROUND((SSR.SUM_S' +
        'TART - CP.SUM_NO_INDEX)*FN_getIndex(o.BEG_STROJ, DATE_ADD(o.BEG_' +
        'STROJ2, INTERVAL -1 MONTH), o.index_type_id), 1, 0)) AS SUM_INDE' +
        'X '
      'FROM objcards AS o,'
      ' (SELECT '
      '  SUM(COALESCE(sc.STOIMF, sc.STOIM, 0)) AS SUM_START,'
      
        '  SUM(COALESCE(sc.MRF, sc.MR, 0) - COALESCE(sc.MAT_ZAKF, sc.MAT_' +
        'ZAK, 0)) AS MR,'
      
        '  SUM(COALESCE(sc.MR_DEVICEF, sc.MR_DEVICE, 0) + COALESCE(sc.TRA' +
        'NSP_DEVICEF, sc.TRANSP_DEVICE, 0) - COALESCE(sc.MR_DEVICE_ZAKF, ' +
        'sc.MR_DEVICE_ZAK, 0) - COALESCE(sc.TRANSP_DEVICE_ZAKF, sc.TRANSP' +
        '_DEVICE_ZAK, 0)) AS DEV,'
      '  SUM(COALESCE(sc.MAT_ZAKF, sc.MAT_ZAK, 0)) AS MAT_ZAK, '
      
        '  SUM(COALESCE(sc.MR_DEVICE_ZAKF, sc.MR_DEVICE_ZAK, 0) + COALESC' +
        'E(sc.TRANSP_DEVICE_ZAKF, sc.TRANSP_DEVICE_ZAK, 0)) AS DEV_ZAK '
      '  FROM `smetasourcedata` as s'
      '  LEFT JOIN summary_calculation sc ON sc.SM_ID IN'
      '    (SELECT SM_ID'
      '     FROM smetasourcedata'
      '     WHERE DELETED=0 AND'
      '      ((smetasourcedata.SM_ID = s.SM_ID) OR'
      '       (smetasourcedata.PARENT_ID = s.SM_ID) OR '
      '       (smetasourcedata.PARENT_ID IN ('
      '          SELECT SM_ID'
      '          FROM smetasourcedata'
      '          WHERE PARENT_ID = s.SM_ID AND DELETED=0))))'
      '  WHERE s.SM_ID = :SM_ID) AS SSR,'
      
        '  (SELECT (`FN_getParamValue`("NDS", MONTH(BEG_STROJ), YEAR(BEG_' +
        'STROJ)) / 100.0 + 1) AS VAL FROM objcards WHERE OBJ_ID=:OBJ_ID) ' +
        'AS NDS,'
      '  (SELECT SUM(IFNULL(cp.SUM_NO_INDEX, 0)) AS SUM_NO_INDEX,'
      
        '          SUM(IFNULL(cp.CONTRACT_PRICE, 0)) AS SUM_CONTRACT_PRIC' +
        'E'
      '   FROM contract_price AS cp, objcards AS o'
      '   WHERE cp.SM_ID=:SM_ID AND o.OBJ_ID=:OBJ_ID'
      
        '     AND cp.OnDate BETWEEN o.BEG_STROJ2 AND DATE_ADD(o.BEG_STROJ' +
        '2, INTERVAL (o.SROK_STROJ - 1) MONTH)) AS CP'
      'WHERE o.OBJ_ID=:OBJ_ID')
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
      '  1 AS EDITABLE,'
      '  "'#1053#1086#1088#1084#1099' '#1079#1072#1076#1077#1083#1072' '#1074' '#1089#1090#1088#1086#1080#1090#1077#1083#1100#1089#1090#1074#1077' '#1087#1086' '#1084#1077#1089#1103#1094#1072#1084' (%)" AS ROW_NAME,'
      
        '  (100 - (SELECT SUM(IFNULL(PER_NORM_STROJ, 0)) FROM contract_pr' +
        'ice, objcards AS o WHERE SM_ID=:SM_ID AND o.OBJ_ID=:OBJ_ID AND O' +
        'nDate BETWEEN o.BEG_STROJ2 AND DATE_ADD(o.BEG_STROJ2, INTERVAL (' +
        'o.SROK_STROJ - 1) MONTH))) AS TOTAL,'
      '  #PER_NORM_STROJ_FIELDS#'
      ''
      'UNION ALL'
      ''
      'SELECT '
      '  2 AS CODE,'
      '  1 AS EDITABLE,'
      '  "'#1053#1086#1088#1084#1099' '#1079#1072#1076#1077#1083#1072' '#1087#1086' '#1086#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1102' '#1087#1086' '#1084#1077#1089#1103#1094#1072#1084' (%)" AS ROW_NAME,'
      
        '  (100 - (SELECT SUM(IFNULL(PER_NORM_DEVICE, 0)) FROM contract_p' +
        'rice, objcards AS o WHERE SM_ID=:SM_ID AND o.OBJ_ID=:OBJ_ID AND ' +
        'OnDate BETWEEN o.BEG_STROJ2 AND DATE_ADD(o.BEG_STROJ2, INTERVAL ' +
        '(o.SROK_STROJ - 1) MONTH))) AS TOTAL, '
      '  #PER_NORM_DEVICE_FIELDS#'
      ''
      'UNION ALL'
      ''
      'SELECT '
      '  3 AS CODE,'
      '  0 AS EDITABLE,'
      '  "'#1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1073#1077#1079' '#1086#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1103' ('#1088#1091#1073'.)" AS ROW_NAME,'
      
        '  (SELECT SUM(IFNULL(PRICE_NO_DEVICE, 0)) FROM contract_price, o' +
        'bjcards AS o WHERE SM_ID=:SM_ID AND o.OBJ_ID=:OBJ_ID AND OnDate ' +
        'BETWEEN o.BEG_STROJ2 AND DATE_ADD(o.BEG_STROJ2, INTERVAL (o.SROK' +
        '_STROJ - 1) MONTH)) AS TOTAL,'
      '  #PRICE_NO_DEVICE_FIELDS#'
      ''
      'UNION ALL'
      ''
      'SELECT '
      '  4 AS CODE,'
      '  0 AS EDITABLE,'
      '  "    '#1074' '#1090'.'#1095'. '#1084#1072#1090#1077#1088#1080#1072#1083#1099' '#1087#1086#1076#1088#1103#1076#1095#1080#1082#1072' ('#1088#1091#1073'.)" AS ROW_NAME,'
      
        '  (SELECT SUM(IFNULL(MAT_PODR, 0)) FROM contract_price, objcards' +
        ' AS o WHERE SM_ID=:SM_ID AND o.OBJ_ID=:OBJ_ID AND OnDate BETWEEN' +
        ' o.BEG_STROJ2 AND DATE_ADD(o.BEG_STROJ2, INTERVAL (o.SROK_STROJ ' +
        '- 1) MONTH)) AS TOTAL,'
      '  #MAT_PODR_FIELDS#'
      ''
      'UNION ALL'
      ''
      'SELECT '
      '  5 AS CODE,'
      '  0 AS EDITABLE,'
      '  "'#1054#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1077' '#1087#1086#1076#1088#1103#1076#1095#1080#1082#1072' ('#1088#1091#1073'.)" AS ROW_NAME,'
      
        '  (SELECT SUM(IFNULL(DEVICE_PODR, 0)) FROM contract_price, objca' +
        'rds AS o WHERE SM_ID=:SM_ID AND o.OBJ_ID=:OBJ_ID AND OnDate BETW' +
        'EEN o.BEG_STROJ2 AND DATE_ADD(o.BEG_STROJ2, INTERVAL (o.SROK_STR' +
        'OJ - 1) MONTH)) AS TOTAL,'
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
        'e, objcards AS o WHERE SM_ID=:SM_ID AND o.OBJ_ID=:OBJ_ID AND OnD' +
        'ate BETWEEN o.BEG_STROJ2 AND DATE_ADD(o.BEG_STROJ2, INTERVAL (o.' +
        'SROK_STROJ - 1) MONTH)) AS TOTAL,'
      '  #PRICE_NO_DEVICE_IND_FIELDS#'
      ''
      'UNION ALL'
      ''
      'SELECT '
      '  8 AS CODE,'
      '  0 AS EDITABLE,'
      
        '  "    '#1074' '#1090'.'#1095'. '#1089#1090#1086#1080#1084#1086#1089#1090#1100' '#1084#1072#1090#1077#1088#1080#1072#1083#1086#1074' '#1087#1086#1076#1088#1103#1076#1095#1080#1082#1072' '#1089' '#1053#1044#1057'" AS ROW_NAME' +
        ','
      
        '  (SELECT SUM(IFNULL(MAT_PODR_IND, 0)) FROM contract_price, objc' +
        'ards AS o WHERE SM_ID=:SM_ID AND o.OBJ_ID=:OBJ_ID AND OnDate BET' +
        'WEEN o.BEG_STROJ2 AND DATE_ADD(o.BEG_STROJ2, INTERVAL (o.SROK_ST' +
        'ROJ - 1) MONTH)) AS TOTAL,'
      '  #MAT_PODR_IND_FIELDS#'
      ''
      'UNION ALL'
      ''
      'SELECT '
      '  9 AS CODE,'
      '  0 AS EDITABLE,'
      
        '  "'#1054#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1077' '#1087#1086#1076#1088#1103#1076#1095#1080#1082#1072' '#1089' '#1091#1095#1077#1090#1086#1084' '#1087#1088#1086#1075#1085#1086#1079#1085#1086#1075#1086' '#1080#1085#1076#1077#1082#1089#1072'" AS ROW_' +
        'NAME,'
      
        '  (SELECT SUM(IFNULL(DEVICE_PODR_IND, 0)) FROM contract_price, o' +
        'bjcards AS o WHERE SM_ID=:SM_ID AND o.OBJ_ID=:OBJ_ID AND OnDate ' +
        'BETWEEN o.BEG_STROJ2 AND DATE_ADD(o.BEG_STROJ2, INTERVAL (o.SROK' +
        '_STROJ - 1) MONTH)) AS TOTAL,'
      '  #DEVICE_PODR_IND_FIELDS#'
      ''
      'UNION ALL'
      ''
      'SELECT '
      '  10 AS CODE,'
      '  1 AS EDITABLE,'
      '  "'#1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1079#1072#1090#1088#1072#1090', '#1085#1077' '#1087#1086#1076#1083#1077#1078#1072#1097#1080#1093' '#1080#1085#1076#1077#1082#1089#1072#1094#1080#1080'" AS ROW_NAME,'
      
        '  (SELECT SUM(IFNULL(SUM_NO_INDEX, 0)) FROM contract_price, objc' +
        'ards AS o WHERE SM_ID=:SM_ID AND o.OBJ_ID=:OBJ_ID AND OnDate BET' +
        'WEEN o.BEG_STROJ2 AND DATE_ADD(o.BEG_STROJ2, INTERVAL (o.SROK_ST' +
        'ROJ - 1) MONTH)) AS TOTAL,'
      '  #SUM_NO_INDEX_FIELDS#'
      ''
      'UNION ALL'
      ''
      'SELECT '
      '  11 AS CODE,'
      '  0 AS EDITABLE,'
      '  "'#1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1088#1072#1073#1086#1090' '#1087#1086' '#1076#1086#1075#1086#1074#1086#1088#1091'" AS ROW_NAME,'
      
        '  (SELECT SUM(IFNULL(CONTRACT_PRICE, 0)) FROM contract_price, ob' +
        'jcards AS o WHERE SM_ID=:SM_ID AND o.OBJ_ID=:OBJ_ID AND OnDate B' +
        'ETWEEN o.BEG_STROJ2 AND DATE_ADD(o.BEG_STROJ2, INTERVAL (o.SROK_' +
        'STROJ - 1) MONTH)) AS TOTAL,'
      '  #CONTRACT_PRICE_FIELDS#')
    Left = 296
    Top = 240
    ParamData = <
      item
        Name = 'SM_ID'
        ParamType = ptInput
      end
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
