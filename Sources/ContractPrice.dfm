object fContractPrice: TfContractPrice
  Left = 0
  Top = 0
  Caption = #1050#1086#1085#1090#1088#1072#1082#1090#1085#1072#1103' '#1094#1077#1085#1072
  ClientHeight = 346
  ClientWidth = 1184
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
    Width = 1184
    Height = 81
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      1184
      81)
    object lbl4: TLabel
      Left = 783
      Top = 3
      Width = 42
      Height = 13
      Caption = #1043#1088#1072#1092#1080#1082':'
    end
    object lbl1: TLabel
      Left = 1050
      Top = 3
      Width = 39
      Height = 13
      Anchors = [akTop, akRight]
      Caption = #1056#1072#1089#1095#1077#1090':'
    end
    object grp3: TGroupBox
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
    object grp1: TGroupBox
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
    object grp2: TGroupBox
      Left = 596
      Top = 3
      Width = 181
      Height = 42
      Caption = #1044#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103' '#1089#1090#1088#1086#1080#1090#1077#1083#1100#1089#1090#1074#1072':'
      Enabled = False
      TabOrder = 3
      object seYearEndStroj: TSpinEdit
        Left = 127
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
      object cbbMonthEndStroj: TComboBox
        Left = 7
        Top = 15
        Width = 114
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
    end
    object grp4: TGroupBox
      Left = 401
      Top = 3
      Width = 192
      Height = 42
      Caption = #1053#1086#1088#1084#1072#1090#1080#1074#1085#1099#1081' '#1089#1088#1086#1082' '#1089#1090#1088#1086#1080#1090#1077#1083#1100#1089#1090#1074#1072':'
      Enabled = False
      TabOrder = 2
      object lbl5: TLabel
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
    end
    object pnl1: TPanel
      Left = 298
      Top = 51
      Width = 519
      Height = 21
      BevelOuter = bvNone
      TabOrder = 9
      object lbl2: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 68
        Height = 15
        Align = alLeft
        Caption = #1042#1080#1076' '#1080#1085#1076#1077#1082#1089#1072':'
        ExplicitHeight = 13
      end
      object lbl3: TLabel
        AlignWithMargins = True
        Left = 209
        Top = 3
        Width = 145
        Height = 15
        Align = alLeft
        Caption = #1056#1072#1089#1095#1077#1090' '#1080#1085#1076#1077#1082#1089#1072#1094#1080#1080' '#1085#1072' '#1076#1072#1090#1091':'
        ExplicitHeight = 13
      end
      object dblkcbbindex_type_id: TDBLookupComboBox
        Left = 74
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
      end
      object dblkcbbindex_type_date_id: TDBLookupComboBox
        Left = 357
        Top = 0
        Width = 161
        Height = 21
        Align = alLeft
        DataField = 'index_type_date_id'
        DataSource = dsOBJ
        KeyField = 'index_type_date_id'
        ListField = 'index_type_date_name'
        ListSource = dsIndexTypeDate
        TabOrder = 1
      end
    end
    object btn1: TBitBtn
      Left = 940
      Top = 20
      Width = 121
      Height = 25
      Caption = #1043#1088#1072#1092#1080#1082' '#1087#1083#1072#1090#1077#1078#1077#1081
      TabOrder = 4
      OnClick = btn1Click
    end
    object btnRecalc: TBitBtn
      Left = 1060
      Top = 51
      Width = 122
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100' '#1088#1072#1089#1095#1077#1090
      TabOrder = 10
      OnClick = btnRecalcClick
    end
    object cbbViewType: TComboBox
      Left = 783
      Top = 22
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
      Items.Strings = (
        #1074' '#1088#1091#1073#1083#1103#1093
        #1074' '#1087#1088#1086#1094#1077#1085#1090#1072#1093' '#1086#1090' '#1086#1073#1098#1077#1084#1072)
    end
    object dblkcbbindex_type_id1: TDBLookupComboBox
      Left = 1050
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
      TabOrder = 6
      OnCloseUp = dblkcbbindex_type_id1CloseUp
    end
  end
  object pnlClient: TPanel
    Left = 0
    Top = 81
    Width = 1184
    Height = 265
    Align = alClient
    TabOrder = 1
    object grMain: TJvDBGrid
      Left = 1
      Top = 1
      Width = 1182
      Height = 263
      Align = alClient
      DataSource = dsMain
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      SelectColumnsDialogStrings.Caption = 'Select columns'
      SelectColumnsDialogStrings.OK = '&OK'
      SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
      EditControls = <>
      RowsHeight = 17
      TitleRowHeight = 17
    end
  end
  object dsMain: TDataSource
    DataSet = qrMain
    Left = 416
    Top = 224
  end
  object qrMain: TFDQuery
    BeforeOpen = qrOBJBeforeOpen
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
      '  FN_getSortSM(s.`SM_ID`), '
      '  s.`SM_ID`, '
      '  s.`SM_NUMBER`, '
      '  s.`NAME`,'
      '  s.`SM_TYPE`,'
      
        '  ROUND( SUM(IFNULL(d.STOIMF, d.STOIM)), rs.round_RATE) AS TOTAL' +
        ','
      '#MONTH_FIELDS#'
      'FROM `objcards` as o, round_setup rs, `smetasourcedata` as s'
      'LEFT JOIN summary_calculation d ON d.SM_ID IN'
      '  (SELECT SM_ID'
      '   FROM smetasourcedata '
      '   WHERE DELETED=0 AND'
      '    ((smetasourcedata.SM_ID = s.SM_ID) OR'
      '           (smetasourcedata.PARENT_ID = s.SM_ID) OR '
      '           (smetasourcedata.PARENT_ID IN ('
      '             SELECT SM_ID'
      '             FROM smetasourcedata'
      '             WHERE PARENT_ID = s.SM_ID AND DELETED=0)))'
      '  ) '
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
    Left = 192
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
  object qrIndexTypeDate: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FetchOptions.AssignedValues = [evCache]
    FetchOptions.Cache = [fiBlobs, fiMeta]
    FormatOptions.AssignedValues = [fvMapRules, fvDefaultParamDataType, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.OwnMapRules = True
    FormatOptions.MapRules = <
      item
        SourceDataType = dtByteString
        TargetDataType = dtAnsiString
      end
      item
        SourceDataType = dtFmtBCD
        TargetDataType = dtDouble
      end>
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvCheckReadOnly]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.CheckReadOnly = False
    SQL.Strings = (
      'SELECT * FROM index_type_date')
    Left = 121
    Top = 280
  end
  object dsIndexTypeDate: TDataSource
    DataSet = qrIndexTypeDate
    Left = 119
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
end
