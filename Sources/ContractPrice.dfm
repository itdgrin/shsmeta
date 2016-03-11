object fContractPrice: TfContractPrice
  Left = 0
  Top = 0
  Caption = #1050#1086#1085#1090#1088#1072#1082#1090#1085#1072#1103' '#1094#1077#1085#1072
  ClientHeight = 346
  ClientWidth = 891
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
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 891
    Height = 81
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      891
      81)
    object lblViewType: TLabel
      Left = 599
      Top = 4
      Width = 42
      Height = 13
      Caption = #1043#1088#1072#1092#1080#1082':'
    end
    object lblCalcType: TLabel
      Left = 757
      Top = 3
      Width = 39
      Height = 13
      Anchors = [akTop, akRight]
      Caption = #1056#1072#1089#1095#1077#1090':'
      ExplicitLeft = 1050
    end
    object grpSmetaStart: TGroupBox
      Left = 8
      Top = 3
      Width = 225
      Height = 42
      Caption = #1044#1072#1090#1072' '#1088#1072#1079#1088#1072#1073#1086#1090#1082#1080' '#1089#1084#1077#1090#1085#1086#1081' '#1076#1086#1082#1091#1084#1077#1085#1090#1072#1094#1080#1080':'
      Enabled = False
      TabOrder = 0
      object cbbMonthSmeta: TComboBox
        Left = 5
        Top = 15
        Width = 158
        Height = 21
        Style = csDropDownList
        DropDownCount = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
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
      object seYearSmeta: TSpinEdit
        Left = 169
        Top = 15
        Width = 50
        Height = 22
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        MaxValue = 2100
        MinValue = 2012
        ParentFont = False
        TabOrder = 1
        Value = 2015
      end
    end
    object grpBuildStart: TGroupBox
      Left = 236
      Top = 3
      Width = 162
      Height = 42
      Caption = #1044#1072#1090#1072' '#1085#1072#1095#1072#1083#1072' '#1089#1090#1088#1086#1080#1090#1077#1083#1100#1089#1090#1074#1072':'
      Enabled = False
      TabOrder = 1
      object cbbMonthBeginStroj: TComboBox
        Left = 5
        Top = 15
        Width = 98
        Height = 21
        Style = csDropDownList
        DropDownCount = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
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
        Left = 108
        Top = 15
        Width = 50
        Height = 22
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        MaxValue = 2100
        MinValue = 2012
        ParentFont = False
        TabOrder = 1
        Value = 2015
      end
    end
    object grpSrok: TGroupBox
      Left = 401
      Top = 3
      Width = 192
      Height = 42
      Caption = #1053#1086#1088#1084#1072#1090#1080#1074#1085#1099#1081' '#1089#1088#1086#1082' '#1089#1090#1088#1086#1080#1090#1077#1083#1100#1089#1090#1074#1072':'
      Enabled = False
      TabOrder = 2
      object lblMonth: TLabel
        Left = 159
        Top = 18
        Width = 20
        Height = 13
        Caption = ' '#1084#1077#1089
      end
      object dbedtSROK_STROJ: TDBEdit
        Left = 7
        Top = 15
        Width = 146
        Height = 21
        DataField = 'SROK_STROJ'
        DataSource = dsOBJ
        ReadOnly = True
        TabOrder = 0
      end
    end
    object dbchkFL_CONTRACT_PRICE: TDBCheckBox
      Left = 98
      Top = 51
      Width = 189
      Height = 17
      Caption = #1050#1086#1085#1090#1088#1072#1082#1090#1085#1072#1103' '#1094#1077#1085#1072' '#1089#1092#1086#1088#1084#1080#1088#1086#1074#1072#1085#1072
      DataField = 'FL_CONTRACT_PRICE_DONE'
      DataSource = dsOBJ
      TabOrder = 8
      ValueChecked = '1'
      ValueUnchecked = '0'
      OnClick = dbchkFL_CONTRACT_PRICE1Click
    end
    object dbchkFL_CONTRACT_PRICE1: TDBCheckBox
      Left = 8
      Top = 51
      Width = 84
      Height = 17
      Caption = #1056#1091#1095#1085#1086#1081' '#1074#1074#1086#1076
      DataField = 'FL_CONTRACT_PRICE_USER_DATA'
      DataSource = dsOBJ
      TabOrder = 7
      ValueChecked = '1'
      ValueUnchecked = '0'
      OnClick = dbchkFL_CONTRACT_PRICE1Click
    end
    object pnlIndex: TPanel
      Left = 298
      Top = 50
      Width = 351
      Height = 21
      BevelOuter = bvNone
      TabOrder = 6
      object lblTypeIndex: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 202
        Height = 15
        Align = alLeft
        Caption = #1048#1085#1076#1077#1082#1089' '#1085#1072' '#1076#1072#1090#1091' '#1085#1072#1095#1072#1083#1072' '#1089#1090#1088#1086#1080#1090#1077#1083#1100#1089#1090#1074#1072':'
        ExplicitHeight = 13
      end
      object dblkcbbindex_type_id: TDBLookupComboBox
        Left = 208
        Top = 0
        Width = 132
        Height = 21
        Align = alLeft
        DataField = 'index_type_id'
        DataSource = dsOBJ
        KeyField = 'index_type_id'
        ListField = 'index_type_name'
        ListSource = dsIndexType
        TabOrder = 0
        OnCloseUp = dblkcbbindex_type_idCloseUp
      end
    end
    object btnContractPays: TBitBtn
      Left = 647
      Top = 51
      Width = 121
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #1043#1088#1072#1092#1080#1082' '#1087#1083#1072#1090#1077#1078#1077#1081
      TabOrder = 9
      OnClick = btnContractPaysClick
    end
    object btnCalc: TBitBtn
      Left = 774
      Top = 51
      Width = 115
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100' '#1088#1072#1089#1095#1077#1090
      TabOrder = 10
      OnClick = btnCalcClick
    end
    object cbbViewType: TComboBox
      Left = 599
      Top = 23
      Width = 151
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
      TabOrder = 5
      Text = #1074' '#1088#1091#1073#1083#1103#1093
      OnCloseUp = cbbViewTypeCloseUp
      Items.Strings = (
        #1074' '#1088#1091#1073#1083#1103#1093
        #1074' '#1087#1088#1086#1094#1077#1085#1090#1072#1093' '#1086#1090' '#1086#1073#1098#1077#1084#1072)
    end
    object dblkcbbindex_type_id1: TDBLookupComboBox
      Left = 757
      Top = 22
      Width = 132
      Height = 21
      Align = alCustom
      Anchors = [akTop, akRight]
      DataField = 'CONTRACT_PRICE_TYPE_ID'
      DataSource = dsOBJ
      KeyField = 'CONTRACT_PRICE_TYPE_ID'
      ListField = 'CONTRACT_PRICE_TYPE_NAME'
      ListSource = dsCONTRACT_PRICE_TYPE
      TabOrder = 4
      OnCloseUp = dblkcbbindex_type_id1CloseUp
    end
    object btnShowResources: TBitBtn
      Left = 608
      Top = 22
      Width = 143
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1088#1072#1089#1095#1077#1090' '#1079#1072#1090#1088#1072#1090
      TabOrder = 3
      OnClick = btnShowResourcesClick
    end
  end
  object pnlClient: TPanel
    Left = 0
    Top = 81
    Width = 891
    Height = 265
    Align = alClient
    TabOrder = 1
    object grMain: TJvDBGrid
      Left = 1
      Top = 1
      Width = 889
      Height = 263
      Align = alClient
      DataSource = dsMain
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleHotTrack]
      PopupMenu = pm
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnDrawColumnCell = grMainDrawColumnCell
      OnDblClick = btnCalcClick
      SelectColumnsDialogStrings.Caption = 'Select columns'
      SelectColumnsDialogStrings.OK = '&OK'
      SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
      EditControls = <>
      RowsHeight = 17
      TitleRowHeight = 17
      OnCanEditCell = grMainCanEditCell
    end
  end
  object dsMain: TDataSource
    DataSet = qrMain
    Left = 416
    Top = 224
  end
  object qrMain: TFDQuery
    BeforeOpen = qrOBJBeforeOpen
    BeforePost = qrMainBeforePost
    AfterScroll = qrMainAfterScroll
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
    FormatOptions.FmtDisplayNumeric = '#,0'
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.CheckUpdatable = False
    SQL.Strings = (
      'SELECT '
      '  FN_getSortSM(s.`SM_ID`) AS SORT_ID, '
      '  s.`SM_ID`, '
      '  s.`SM_NUMBER`, '
      '  s.`NAME`,'
      '  s.`SM_TYPE`,'
      '  IF(:VIEW_TYPE=0,'
      
        '  (SELECT SUM(CONTRACT_PRICE) FROM contract_price WHERE SM_ID IN' +
        ' '
      '  (SELECT SM_ID'
      '   FROM smetasourcedata '
      '   WHERE DELETED=0 AND'
      '     CASE o.CONTRACT_PRICE_TYPE_ID'
      '     WHEN 1 THEN SM_TYPE=3'
      '     WHEN 2 THEN SM_TYPE=1'
      '     WHEN 3 THEN SM_TYPE=2'
      '     END'
      '   AND '
      '    ((smetasourcedata.SM_ID = s.SM_ID) OR'
      '     (smetasourcedata.PARENT_ID = s.SM_ID) OR '
      '     (smetasourcedata.PARENT_ID IN ('
      '        SELECT SM_ID'
      '        FROM smetasourcedata'
      '        WHERE PARENT_ID = s.SM_ID AND DELETED=0)))'
      
        '  ) AND OnDate BETWEEN o.BEG_STROJ2 AND DATE_ADD(o.BEG_STROJ2, I' +
        'NTERVAL (o.SROK_STROJ - 1) MONTH)),'
      '  (SELECT SUM(CP.PER_NORM_STROJ) / COUNT(*) * o.SROK_STROJ'
      '   FROM smetasourcedata'
      '   JOIN objcards AS o ON o.OBJ_ID=smetasourcedata.OBJ_ID'
      
        '   LEFT JOIN contract_price AS CP ON CP.SM_ID=smetasourcedata.SM' +
        '_ID AND CP.OnDate BETWEEN o.BEG_STROJ2 AND DATE_ADD(o.BEG_STROJ2' +
        ', INTERVAL (o.SROK_STROJ - 1) MONTH)'
      '   WHERE DELETED=0 AND'
      '     CASE o.CONTRACT_PRICE_TYPE_ID'
      '     WHEN 1 THEN SM_TYPE=3'
      '     WHEN 2 THEN SM_TYPE=1'
      '     WHEN 3 THEN SM_TYPE=2'
      '     END'
      '   AND '
      '    ((smetasourcedata.SM_ID = s.SM_ID) OR'
      '     (smetasourcedata.PARENT_ID = s.SM_ID) OR '
      '     (smetasourcedata.PARENT_ID IN ('
      '        SELECT SM_ID'
      '        FROM smetasourcedata'
      '        WHERE PARENT_ID = s.SM_ID AND DELETED=0)))'
      '  )) AS TOTAL,'
      '#MONTH_FIELDS#'
      'FROM `objcards` as o, `smetasourcedata` as s'
      'WHERE o.`OBJ_ID` = :OBJ_ID'
      
        '  AND ((o.`CONTRACT_PRICE_TYPE_ID` = 1) OR (o.`CONTRACT_PRICE_TY' +
        'PE_ID` = 2 AND s.`SM_TYPE` <> 3) OR (o.`CONTRACT_PRICE_TYPE_ID` ' +
        '= 3 AND s.`SM_TYPE` = 2))'
      '  AND s.`OBJ_ID` = o.`OBJ_ID`'
      '  AND s.`ACT` = 0'
      '  AND s.`DELETED` = 0'
      'GROUP BY s.`SM_ID`, s.`SM_NUMBER`, s.`NAME`, s.`SM_TYPE`'
      'ORDER BY 1')
    Left = 376
    Top = 224
    ParamData = <
      item
        Name = 'VIEW_TYPE'
        ParamType = ptInput
      end
      item
        Name = 'OBJ_ID'
        DataType = ftBCD
        ParamType = ptInput
      end>
  end
  object qrOBJ: TFDQuery
    BeforeOpen = qrOBJBeforeOpen
    AfterOpen = qrOBJAfterOpen
    AfterPost = qrOBJAfterPost
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
      'SELECT * FROM objcards WHERE OBJ_ID=:OBJ_ID')
    Left = 192
    Top = 280
    ParamData = <
      item
        Name = 'OBJ_ID'
        DataType = ftBCD
        ParamType = ptInput
      end>
  end
  object dsOBJ: TDataSource
    DataSet = qrOBJ
    Left = 208
    Top = 280
  end
  object qrIndexType: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FetchOptions.AssignedValues = [evCache]
    FetchOptions.Cache = [fiBlobs, fiMeta]
    FormatOptions.AssignedValues = [fvMapRules, fvDefaultParamDataType, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.OwnMapRules = True
    FormatOptions.MapRules = <>
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvCheckReadOnly]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.CheckReadOnly = False
    SQL.Strings = (
      'select * from index_type')
    Left = 25
    Top = 280
  end
  object dsIndexType: TDataSource
    DataSet = qrIndexType
    Left = 24
    Top = 280
  end
  object dsCONTRACT_PRICE_TYPE: TDataSource
    DataSet = qrCONTRACT_PRICE_TYPE
    Left = 296
    Top = 280
  end
  object qrCONTRACT_PRICE_TYPE: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FetchOptions.AssignedValues = [evCache]
    FetchOptions.Cache = [fiBlobs, fiMeta]
    FormatOptions.AssignedValues = [fvMapRules, fvDefaultParamDataType, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.OwnMapRules = True
    FormatOptions.MapRules = <>
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvCheckReadOnly]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.CheckReadOnly = False
    SQL.Strings = (
      'select * from CONTRACT_PRICE_TYPE')
    Left = 289
    Top = 280
  end
  object pm: TPopupMenu
    OnPopup = pmPopup
    Left = 312
    Top = 145
    object mRecalcAll: TMenuItem
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100' '#1087#1077#1088#1077#1088#1072#1089#1095#1077#1090
      OnClick = mRecalcAllClick
    end
  end
end
