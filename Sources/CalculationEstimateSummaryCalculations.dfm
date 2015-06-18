object frCalculationEstimateSummaryCalculations: TfrCalculationEstimateSummaryCalculations
  Left = 0
  Top = 0
  Width = 824
  Height = 342
  TabOrder = 0
  OnResize = FrameResize
  object dbgrdSummaryCalculation: TJvDBGrid
    Left = 0
    Top = 0
    Width = 824
    Height = 342
    Align = alClient
    DataSource = dsData
    DrawingStyle = gdsClassic
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    PopupMenu = pm1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = dbgrdSummaryCalculationDblClick
    AutoAppend = False
    IniStorage = FormStorage
    AutoSizeColumns = True
    SelectColumnsDialogStrings.Caption = 'Select columns'
    SelectColumnsDialogStrings.OK = '&OK'
    SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
    EditControls = <>
    RowsHeight = 17
    TitleRowHeight = 17
    Columns = <
      item
        Expanded = False
        FieldName = 'TYPE_NAME'
        Title.Alignment = taCenter
        Title.Caption = #1058#1080#1087
        Width = 63
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SM_NUMBER'
        Title.Alignment = taCenter
        Title.Caption = #1053#1086#1084#1077#1088
        Width = 59
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SM_NAME'
        Title.Alignment = taCenter
        Title.Caption = #1053#1072#1079#1074#1072#1085#1080#1077
        Width = 99
        Visible = True
      end
      item
        Expanded = False
        Title.Alignment = taCenter
        Title.Caption = #1054#1073#1098#1105#1084' '#1055#1058#1052
        Width = 63
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'STOIM'
        Title.Alignment = taCenter
        Title.Caption = #1042#1089#1077#1075#1086
        Width = 63
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ZP'
        Title.Alignment = taCenter
        Title.Caption = #1047#1072#1088#1087#1083#1072#1090#1072
        Width = 63
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TRUD'
        Title.Alignment = taCenter
        Title.Caption = #1058#1088#1091#1076#1086#1105#1084#1082#1086#1089#1090#1100
        Width = 99
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'EMiM'
        Title.Alignment = taCenter
        Title.Caption = #1069#1052#1080#1052
        Width = 63
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ZP_MASH'
        Title.Alignment = taCenter
        Title.Caption = #1069#1055' '#1084#1072#1096'.'
        Width = 63
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MR'
        Title.Alignment = taCenter
        Title.Caption = #1052#1072#1090#1077#1088#1080#1072#1083
        Width = 59
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TRANSP'
        Title.Alignment = taCenter
        Title.Caption = #1058#1088#1072#1085#1089#1087#1086#1088#1090
        Width = 103
        Visible = True
      end>
  end
  object qrData: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FetchOptions.AssignedValues = [evCache]
    FetchOptions.Cache = [fiBlobs, fiMeta]
    FormatOptions.AssignedValues = [fvMapRules, fvDefaultParamDataType, fvFmtDisplayNumeric]
    FormatOptions.OwnMapRules = True
    FormatOptions.MapRules = <
      item
        SourceDataType = dtByteString
        TargetDataType = dtAnsiString
      end>
    FormatOptions.FmtDisplayNumeric = '### ### ### ##0.####'
    SQL.Strings = (
      'SELECT '
      '  s.SM_ID,'
      '  s.OBJ_ID,'
      '  typesm.NAME AS TYPE_NAME, '
      '  s.SM_NUMBER, '
      '  s.NAME AS SM_NAME,'
      '  SUM(IFNULL(d.ZP, 0)) AS ZP,'
      '  SUM(IFNULL(d.EMiM, 0)) AS EMiM,'
      '  SUM(IFNULL(d.MR, 0)) AS MR,'
      '  SUM(IFNULL(d.TRUD, 0)) AS TRUD,'
      '  SUM(IFNULL(d.TRUD_MASH, 0)) AS TRUD_MASH,'
      '  SUM(IFNULL(d.ZP_MASH, 0)) AS ZP_MASH,'
      '  SUM(IFNULL(d.TRANSP, 0)) AS TRANSP,'
      '  SUM(IFNULL(d.STOIM, 0)) AS STOIM,'
      '  SUM(IFNULL(d.OHROPR, 0)) AS OHROPR,'
      '  SUM(IFNULL(d.PLAN_PRIB, 0)) AS PLAN_PRIB,'
      '  SUM(IFNULL(d.ST_OHROPR, 0)) AS ST_OHROPR,'
      '  SUM(IFNULL(d.ZIM_UDOR, 0)) AS ZIM_UDOR,'
      '  SUM(IFNULL(d.ZP_ZIM_UDOR, 0)) AS ZP_ZIM_UDOR'
      'FROM typesm, smetasourcedata s '
      'LEFT JOIN data_estimate_temp d ON d.ID_ESTIMATE IN '
      '  (SELECT SM_ID '
      '   FROM smetasourcedata '
      '   WHERE'
      '    ((smetasourcedata.SM_ID = s.SM_ID) OR'
      '           (smetasourcedata.PARENT_ID = s.SM_ID) OR '
      '           (smetasourcedata.PARENT_ID IN ('
      '             SELECT SM_ID'
      '             FROM smetasourcedata'
      '             WHERE PARENT_ID = s.SM_ID AND DELETED=0))) '
      '  ) '
      'WHERE '
      '  s.SM_TYPE=typesm.ID AND '
      '  ((s.SM_ID = :SM_ID) OR'
      '           (s.PARENT_ID = :SM_ID) OR '
      '           (s.PARENT_ID IN ('
      '             SELECT SM_ID'
      '             FROM smetasourcedata'
      '             WHERE PARENT_ID = :SM_ID AND DELETED=0))) '
      'GROUP BY s.SM_ID, s.OBJ_ID, TYPE_NAME, s.SM_NUMBER, SM_NAME'
      
        'ORDER BY CONCAT(IF(((s.SM_ID = :SM_ID) OR (s.PARENT_ID = :SM_ID)' +
        '), "", :SM_ID), s.PARENT_ID, s.SM_ID)')
    Left = 9
    Top = 40
    ParamData = <
      item
        Name = 'SM_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object dsData: TDataSource
    DataSet = qrData
    Left = 48
    Top = 40
  end
  object pm1: TPopupMenu
    Left = 88
    Top = 40
    object N1: TMenuItem
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077
      object N4: TMenuItem
        Caption = #1048#1089#1093#1086#1076#1085#1099#1077' '#1076#1072#1085#1085#1099#1077
        OnClick = dbgrdSummaryCalculationDblClick
      end
      object N5: TMenuItem
        Caption = #1054#1073#1098#1077#1082#1090
        OnClick = N5Click
      end
    end
    object N2: TMenuItem
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1088#1072#1089#1095#1077#1090#1072
    end
  end
  object FormStorage: TJvFormStorage
    AppStorage = FormMain.AppIni
    AppStoragePath = '%FORM_NAME%\'
    Options = []
    StoredValues = <>
    Left = 32
    Top = 96
  end
end
