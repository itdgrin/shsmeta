object fUniDict: TfUniDict
  Left = 0
  Top = 0
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1077#1078#1077#1084#1077#1089#1103#1095#1085#1099#1093' '#1074#1077#1083#1080#1095#1080#1085
  ClientHeight = 394
  ClientWidth = 743
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Visible = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    743
    394)
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 8
    Top = 11
    Width = 81
    Height = 13
    Caption = #1059#1082#1072#1078#1080#1090#1077' '#1075#1086#1076':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl2: TLabel
    Left = 8
    Top = 314
    Width = 177
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1075#1083#1086#1073#1072#1083#1100#1085#1086#1081' '#1087#1077#1088#1077#1084#1077#1085#1085#1086#1081':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbl3: TLabel
    Left = 191
    Top = 314
    Width = 53
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = #1054#1087#1080#1089#1072#1085#1080#1077':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object pnl1: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 366
    Width = 737
    Height = 25
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    object dbnvgr1: TDBNavigator
      Left = 0
      Top = 0
      Width = 240
      Height = 25
      Align = alLeft
      Hints.Strings = (
        #1053#1072' '#1087#1077#1088#1074#1091#1102' '#1079#1072#1087#1080#1089#1100
        #1055#1088#1077#1076#1099#1076#1091#1097#1072#1103' '#1079#1072#1087#1080#1089#1100
        #1057#1083#1077#1076#1091#1102#1097#1072#1103' '#1079#1072#1087#1080#1089#1100
        #1053#1072' '#1087#1086#1089#1083#1077#1076#1085#1102#1102' '#1079#1072#1087#1080#1089#1100
        #1053#1086#1074#1072#1103' '#1079#1072#1087#1080#1089#1100
        #1059#1076#1072#1083#1080#1090#1100' '#1079#1072#1087#1080#1089#1100
        #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1079#1072#1087#1080#1089#1100
        #1057#1086#1093#1088#1072#1085#1080#1090#1100
        #1054#1090#1084#1077#1085#1080#1090#1100
        #1054#1073#1085#1086#1074#1080#1090#1100
        'Apply updates'
        'Cancel updates')
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      TabStop = True
    end
  end
  object dbmmoparam_description: TDBMemo
    Left = 250
    Top = 314
    Width = 485
    Height = 40
    TabStop = False
    Anchors = [akLeft, akRight, akBottom]
    DataField = 'param_description'
    DataSource = dsUniDict
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object seYear: TSpinEdit
    Left = 95
    Top = 8
    Width = 56
    Height = 22
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    MaxValue = 2100
    MinValue = 1900
    ParentFont = False
    TabOrder = 0
    Value = 2014
    OnChange = seYearChange
  end
  object dbedtcode: TDBEdit
    Left = 8
    Top = 333
    Width = 177
    Height = 21
    TabStop = False
    Anchors = [akLeft, akBottom]
    DataField = 'code'
    DataSource = dsUniDict
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object pnlClient: TPanel
    Left = 8
    Top = 36
    Width = 727
    Height = 272
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvNone
    Caption = 'pnlClient'
    TabOrder = 1
    object spl1: TSplitter
      Left = 185
      Top = 0
      Height = 272
      ExplicitLeft = 312
      ExplicitTop = 112
      ExplicitHeight = 100
    end
    object pnlLeft: TPanel
      Left = 0
      Top = 0
      Width = 185
      Height = 272
      Align = alLeft
      BevelOuter = bvNone
      Caption = 'pnlLeft'
      TabOrder = 0
      object gtUniDictType: TJvDBGrid
        Left = 0
        Top = 0
        Width = 185
        Height = 272
        Align = alClient
        DataSource = dsUniDictType
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnEnter = gtUniDictTypeEnter
        AutoSizeColumns = True
        SelectColumnsDialogStrings.Caption = 'Select columns'
        SelectColumnsDialogStrings.OK = '&OK'
        SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
        EditControls = <>
        RowsHeight = 17
        TitleRowHeight = 17
        Columns = <
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'unidicttype_id'
            Title.Alignment = taCenter
            Title.Caption = #1050#1086#1076
            Width = -1
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'unidicttype_name'
            Title.Alignment = taCenter
            Title.Caption = #1058#1080#1087' '#1089#1087#1088#1072#1074#1086#1095#1085#1080#1082#1072
            Width = 119
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CNT'
            Title.Alignment = taCenter
            Title.Caption = #1047#1072#1087#1080#1089#1077#1081
            Width = 48
            Visible = True
          end>
      end
    end
    object pnlClientCh: TPanel
      Left = 188
      Top = 0
      Width = 539
      Height = 272
      Align = alClient
      BevelOuter = bvNone
      Caption = 'pnlClientCh'
      TabOrder = 1
      object grUniDictParam: TJvDBGrid
        Left = 0
        Top = 0
        Width = 539
        Height = 272
        Align = alClient
        DataSource = dsUniDict
        DrawingStyle = gdsClassic
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        ParentFont = False
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnEnter = grUniDictParamEnter
        PostOnEnterKey = True
        AutoSizeColumns = True
        AutoSizeColumnIndex = 0
        SelectColumnsDialogStrings.Caption = 'Select columns'
        SelectColumnsDialogStrings.OK = '&OK'
        SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
        EditControls = <>
        AutoSizeRows = False
        RowsHeight = 60
        TitleRowHeight = 17
        WordWrap = True
        WordWrapAllFields = True
        Columns = <
          item
            Expanded = False
            FieldName = 'param_name'
            Title.Alignment = taCenter
            Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
            Width = 2
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'LookIDUniDictType'
            Title.Alignment = taCenter
            Title.Caption = #1058#1080#1087
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'MONTH_1'
            Title.Alignment = taCenter
            Title.Caption = #1071#1085#1074#1072#1088#1100
            Width = 55
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'MONTH_2'
            Title.Alignment = taCenter
            Title.Caption = #1060#1077#1074#1088#1072#1083#1100
            Width = 55
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'MONTH_3'
            Title.Alignment = taCenter
            Title.Caption = #1052#1072#1088#1090
            Width = 55
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'MONTH_4'
            Title.Alignment = taCenter
            Title.Caption = #1040#1087#1088#1077#1083#1100
            Width = 55
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'MONTH_5'
            Title.Alignment = taCenter
            Title.Caption = #1052#1072#1081
            Width = 55
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'MONTH_6'
            Title.Alignment = taCenter
            Title.Caption = #1048#1102#1085#1100
            Width = 55
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'MONTH_7'
            Title.Alignment = taCenter
            Title.Caption = #1048#1102#1083#1100
            Width = 55
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'MONTH_8'
            Title.Alignment = taCenter
            Title.Caption = #1040#1074#1075#1091#1089#1090
            Width = 55
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'MONTH_9'
            Title.Alignment = taCenter
            Title.Caption = #1057#1077#1085#1090#1103#1073#1088#1100
            Width = 55
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'MONTH_10'
            Title.Alignment = taCenter
            Title.Caption = #1054#1082#1090#1103#1073#1088#1100
            Width = 55
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'MONTH_11'
            Title.Alignment = taCenter
            Title.Caption = #1053#1086#1103#1073#1088#1100
            Width = 55
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'MONTH_12'
            Title.Alignment = taCenter
            Title.Caption = #1044#1077#1082#1072#1073#1088#1100
            Width = 55
            Visible = True
          end>
      end
    end
  end
  object qrUniDict: TFDQuery
    AfterPost = qrUniDictAfterPost
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
      end
      item
        SourceDataType = dtBCD
        TargetDataType = dtDouble
      end
      item
        SourceDataType = dtBlob
        TargetDataType = dtAnsiString
      end>
    FormatOptions.DefaultParamDataType = ftBCD
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.CheckUpdatable = False
    SQL.Strings = (
      'SELECT id_unidictparam,code,param_name,param_description,'
      'id_unidicttype,'
      'FN_getParamValue(code, 1, :year) AS MONTH_1,'
      'FN_getParamValue(code, 2, :year) AS MONTH_2,'
      'FN_getParamValue(code, 3, :year) AS MONTH_3,'
      'FN_getParamValue(code, 4, :year) AS MONTH_4,'
      'FN_getParamValue(code, 5, :year) AS MONTH_5,'
      'FN_getParamValue(code, 6, :year) AS MONTH_6,'
      'FN_getParamValue(code, 7, :year) AS MONTH_7,'
      'FN_getParamValue(code, 8, :year) AS MONTH_8,'
      'FN_getParamValue(code, 9, :year) AS MONTH_9,'
      'FN_getParamValue(code, 10, :year) AS MONTH_10,'
      'FN_getParamValue(code, 11, :year) AS MONTH_11,'
      'FN_getParamValue(code, 12, :year) AS MONTH_12'
      'FROM '
      '  unidictparam'
      'WHERE id_unidicttype=:id_unidicttype or (:id_unidicttype=-1)')
    Left = 203
    Top = 206
    ParamData = <
      item
        Name = 'YEAR'
        DataType = ftInteger
        ParamType = ptInput
        Value = 2014
      end
      item
        Name = 'ID_UNIDICTTYPE'
        DataType = ftInteger
        ParamType = ptInput
        Value = -1
      end>
    object qrUniDictid_unidictparam: TFDAutoIncField
      FieldName = 'id_unidictparam'
      Origin = 'id_unidictparam'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object strngfldUniDictcode: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'code'
      Origin = 'code'
      Size = 50
    end
    object strngfldUniDictparam_name: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'param_name'
      Origin = 'param_name'
      Size = 500
    end
    object strngfldUniDictparam_description: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'param_description'
      Origin = 'param_description'
      Size = 1000
    end
    object qrUniDictMONTH_1: TFloatField
      Tag = 1
      AutoGenerateValue = arDefault
      FieldName = 'MONTH_1'
      Origin = 'MONTH_1'
      ProviderFlags = []
      OnChange = qrUniDictMONTHChange
    end
    object qrUniDictMONTH_2: TFloatField
      Tag = 2
      AutoGenerateValue = arDefault
      FieldName = 'MONTH_2'
      Origin = 'MONTH_2'
      ProviderFlags = []
      OnChange = qrUniDictMONTHChange
    end
    object qrUniDictMONTH_3: TFloatField
      Tag = 3
      AutoGenerateValue = arDefault
      FieldName = 'MONTH_3'
      Origin = 'MONTH_3'
      ProviderFlags = []
      OnChange = qrUniDictMONTHChange
    end
    object qrUniDictMONTH_4: TFloatField
      Tag = 4
      AutoGenerateValue = arDefault
      FieldName = 'MONTH_4'
      Origin = 'MONTH_4'
      ProviderFlags = []
      OnChange = qrUniDictMONTHChange
    end
    object qrUniDictMONTH_5: TFloatField
      Tag = 5
      AutoGenerateValue = arDefault
      FieldName = 'MONTH_5'
      Origin = 'MONTH_5'
      ProviderFlags = []
      OnChange = qrUniDictMONTHChange
    end
    object qrUniDictMONTH_6: TFloatField
      Tag = 6
      AutoGenerateValue = arDefault
      FieldName = 'MONTH_6'
      Origin = 'MONTH_6'
      ProviderFlags = []
      OnChange = qrUniDictMONTHChange
    end
    object qrUniDictMONTH_7: TFloatField
      Tag = 7
      AutoGenerateValue = arDefault
      FieldName = 'MONTH_7'
      Origin = 'MONTH_7'
      ProviderFlags = []
      OnChange = qrUniDictMONTHChange
    end
    object qrUniDictMONTH_8: TFloatField
      Tag = 8
      AutoGenerateValue = arDefault
      FieldName = 'MONTH_8'
      Origin = 'MONTH_8'
      ProviderFlags = []
      OnChange = qrUniDictMONTHChange
    end
    object qrUniDictMONTH_9: TFloatField
      Tag = 9
      AutoGenerateValue = arDefault
      FieldName = 'MONTH_9'
      Origin = 'MONTH_9'
      ProviderFlags = []
      OnChange = qrUniDictMONTHChange
    end
    object qrUniDictMONTH_10: TFloatField
      Tag = 10
      AutoGenerateValue = arDefault
      FieldName = 'MONTH_10'
      Origin = 'MONTH_10'
      ProviderFlags = []
      OnChange = qrUniDictMONTHChange
    end
    object qrUniDictMONTH_11: TFloatField
      Tag = 11
      AutoGenerateValue = arDefault
      FieldName = 'MONTH_11'
      Origin = 'MONTH_11'
      ProviderFlags = []
      OnChange = qrUniDictMONTHChange
    end
    object qrUniDictMONTH_12: TFloatField
      Tag = 12
      AutoGenerateValue = arDefault
      FieldName = 'MONTH_12'
      Origin = 'MONTH_12'
      ProviderFlags = []
      OnChange = qrUniDictMONTHChange
    end
    object qrUniDictid_unidicttype: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'id_unidicttype'
      Origin = 'id_unidicttype'
    end
    object strngfldUniDictLookIDUniDictType: TStringField
      FieldKind = fkLookup
      FieldName = 'LookIDUniDictType'
      LookupDataSet = qrUniDictTypeLook
      LookupKeyFields = 'unidicttype_id'
      LookupResultField = 'unidicttype_name'
      KeyFields = 'id_unidicttype'
      Size = 255
      Lookup = True
    end
  end
  object dsUniDict: TDataSource
    DataSet = qrUniDict
    Left = 204
    Top = 254
  end
  object qrSetParamValue: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FetchOptions.AssignedValues = [evCache]
    FetchOptions.Cache = [fiBlobs, fiMeta]
    FormatOptions.AssignedValues = [fvMapRules, fvFmtDisplayNumeric]
    FormatOptions.OwnMapRules = True
    FormatOptions.MapRules = <
      item
        SourceDataType = dtMemo
        TargetDataType = dtAnsiString
      end
      item
        SourceDataType = dtByteString
        TargetDataType = dtAnsiString
      end
      item
        SourceDataType = dtBCD
        TargetDataType = dtDouble
      end
      item
        SourceDataType = dtBlob
        TargetDataType = dtAnsiString
      end>
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.CheckUpdatable = False
    SQL.Strings = (
      'CALL setParamValue(:inPARAM_CODE, :inMONTH, :inYEAR, :inValue);')
    Left = 259
    Top = 65534
    ParamData = <
      item
        Name = 'INPARAM_CODE'
        DataType = ftString
        ParamType = ptInput
        Size = 255
        Value = Null
      end
      item
        Name = 'INMONTH'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'INYEAR'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'INVALUE'
        DataType = ftFloat
        ParamType = ptInput
        Value = Null
      end>
  end
  object qrUniDictType: TFDQuery
    AfterPost = qrUniDictTypeAfterPost
    AfterDelete = qrUniDictTypeAfterPost
    AfterScroll = qrUniDictTypeAfterScroll
    OnUpdateError = qrUniDictTypeUpdateError
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FetchOptions.AssignedValues = [evCache]
    FetchOptions.Cache = [fiBlobs, fiMeta]
    FormatOptions.AssignedValues = [fvMapRules, fvFmtDisplayNumeric]
    FormatOptions.OwnMapRules = True
    FormatOptions.MapRules = <
      item
        SourceDataType = dtMemo
        TargetDataType = dtAnsiString
      end
      item
        SourceDataType = dtByteString
        TargetDataType = dtAnsiString
      end
      item
        SourceDataType = dtBCD
        TargetDataType = dtDouble
      end
      item
        SourceDataType = dtBlob
        TargetDataType = dtAnsiString
      end>
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvRefreshMode, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable, uvUpdateNonBaseFields]
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.UpdateNonBaseFields = True
    UpdateOptions.UpdateMode = upWhereChanged
    UpdateOptions.LockMode = lmOptimistic
    UpdateOptions.RefreshMode = rmManual
    UpdateOptions.CheckRequired = False
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.UpdateTableName = 'smeta.unidicttype'
    SQL.Strings = (
      'SELECT '
      '  `unidicttype_id`,'
      '  `unidicttype_name`,'
      
        '  (SELECT COUNT(*) FROM unidictparam WHERE id_unidicttype=`unidi' +
        'cttype`.unidicttype_id) AS CNT'
      'FROM '
      '  `unidicttype`'
      'UNION ALL'
      'SELECT '
      '  -1 AS unidicttype_id,'
      '  ("<'#1074#1089#1077'>") AS unidicttype_name,'
      '  (SELECT COUNT(*) FROM unidictparam) AS CNT'
      'UNION ALL'
      'SELECT '
      '  0 AS unidicttype_id,'
      '  ("<'#1085#1077' '#1091#1082#1072#1079#1072#1085'>") AS unidicttype_name,'
      
        '  (SELECT COUNT(*) FROM unidictparam WHERE id_unidicttype=0) AS ' +
        'CNT'
      'ORDER BY `unidicttype_name`, unidicttype_id')
    Left = 27
    Top = 118
  end
  object dsUniDictType: TDataSource
    DataSet = qrUniDictType
    Left = 28
    Top = 174
  end
  object qrUniDictTypeLook: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FetchOptions.AssignedValues = [evCache]
    FetchOptions.Cache = [fiBlobs, fiMeta]
    FormatOptions.AssignedValues = [fvMapRules, fvFmtDisplayNumeric]
    FormatOptions.OwnMapRules = True
    FormatOptions.MapRules = <
      item
        SourceDataType = dtMemo
        TargetDataType = dtAnsiString
      end
      item
        SourceDataType = dtByteString
        TargetDataType = dtAnsiString
      end
      item
        SourceDataType = dtBCD
        TargetDataType = dtDouble
      end
      item
        SourceDataType = dtBlob
        TargetDataType = dtAnsiString
      end>
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.CheckUpdatable = False
    SQL.Strings = (
      'SELECT '
      '  0 AS unidicttype_id,'
      '  ("<'#1085#1077' '#1091#1082#1072#1079#1072#1085'>") AS unidicttype_name'
      'UNION ALL'
      'SELECT '
      '  `unidicttype_id`,'
      '  `unidicttype_name`'
      'FROM '
      '  `unidicttype`'
      'ORDER BY `unidicttype_name`')
    Left = 395
    Top = 22
  end
  object dsUniDictTypeLook: TDataSource
    DataSet = qrUniDictTypeLook
    Left = 396
    Top = 78
  end
end
