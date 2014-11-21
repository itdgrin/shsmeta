object frCalculationEstimateSummaryCalculations: TfrCalculationEstimateSummaryCalculations
  Left = 0
  Top = 0
  Width = 887
  Height = 342
  TabOrder = 0
  OnResize = FrameResize
  object dbgrdSummaryCalculation: TDBGrid
    Left = 0
    Top = 0
    Width = 887
    Height = 342
    Align = alClient
    DataSource = dsData
    DrawingStyle = gdsClassic
    Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    PopupMenu = pm1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = dbgrdSummaryCalculationDblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'TYPE_NAME'
        Title.Alignment = taCenter
        Title.Caption = #1058#1080#1087
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SM_NUMBER'
        Title.Alignment = taCenter
        Title.Caption = #1053#1086#1084#1077#1088
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NAME'
        Title.Alignment = taCenter
        Title.Caption = #1053#1072#1079#1074#1072#1085#1080#1077
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        Title.Alignment = taCenter
        Title.Caption = #1054#1073#1098#1105#1084' '#1055#1058#1052
        Visible = True
      end
      item
        Expanded = False
        Title.Alignment = taCenter
        Title.Caption = #1042#1089#1077#1075#1086
        Visible = True
      end
      item
        Expanded = False
        Title.Alignment = taCenter
        Title.Caption = #1047#1072#1088#1087#1083#1072#1090#1072
        Visible = True
      end
      item
        Expanded = False
        Title.Alignment = taCenter
        Title.Caption = #1058#1088#1091#1076#1086#1105#1084#1082#1086#1089#1090#1100
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        Title.Alignment = taCenter
        Title.Caption = #1069#1052#1080#1052
        Visible = True
      end
      item
        Expanded = False
        Title.Alignment = taCenter
        Title.Caption = #1069#1055' '#1084#1072#1096'.'
        Visible = True
      end
      item
        Expanded = False
        Title.Alignment = taCenter
        Title.Caption = #1052#1072#1090#1077#1088#1080#1072#1083
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        Title.Alignment = taCenter
        Title.Caption = #1058#1088#1072#1085#1089#1087#1086#1088#1090
        Width = 100
        Visible = True
      end>
  end
  object qrData: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FetchOptions.AssignedValues = [evCache]
    FetchOptions.Cache = [fiBlobs, fiMeta]
    FormatOptions.AssignedValues = [fvMapRules, fvDefaultParamDataType]
    FormatOptions.OwnMapRules = True
    FormatOptions.MapRules = <
      item
        SourceDataType = dtByteString
        TargetDataType = dtAnsiString
      end>
    SQL.Strings = (
      '/* '#1054#1073#1098#1077#1082#1090#1085#1099#1077' */'
      
        'SELECT SM_ID, SM_TYPE, NAME as NAME, SM_NUMBER, SM_ID as ID, (NU' +
        'LL) AS PTM_COST, (NULL) AS PTM_COST_DONE, (NULL) AS PTM_COST_OUT' +
        ', ('#39#1054#1073#1098#1077#1082#1090#1085#1072#1103#39') as TYPE_NAME, SM_ID as ID     '
      'FROM smetasourcedata'
      'WHERE SM_TYPE=2 AND '
      '      OBJ_ID=:OBJ_ID'
      ''
      'UNION ALL'
      ''
      '/* '#1051#1086#1082#1072#1083#1100#1085#1099#1077' */'
      
        'SELECT CONCAT((PARENT_LOCAL_ID+PARENT_PTM_ID), SM_ID) AS SM_ID, ' +
        'SM_TYPE, NAME as NAME, SM_NUMBER, SM_ID as ID, (NULL) AS PTM_COS' +
        'T, '
      
        '(NULL) AS PTM_COST_DONE, (NULL) AS PTM_COST_OUT, ('#39#1051#1086#1082#1072#1083#1100#1085#1072#1103#39') a' +
        's TYPE_NAME, SM_ID as ID  '
      'FROM smetasourcedata'
      'WHERE SM_TYPE=1 AND '
      '      OBJ_ID=:OBJ_ID'
      ''
      'UNION ALL'
      ''
      '/* '#1055#1058#1052' */'
      'SELECT CONCAT('
      
        '(SELECT (s1.PARENT_LOCAL_ID+s1.PARENT_PTM_ID) FROM smetasourceda' +
        'ta s1 WHERE s1.SM_ID=(s2.PARENT_LOCAL_ID+s2.PARENT_PTM_ID)), '
      
        '(s2.PARENT_LOCAL_ID+s2.PARENT_PTM_ID), s2.SM_ID) AS SM_ID, s2.SM' +
        '_TYPE, s2.NAME as NAME, CONCAT('#39' - '#39', s2.SM_NUMBER) as SM_NUMBER' +
        ', SM_ID as ID,'
      
        '/*'#1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1087#1086' '#1088#1072#1089#1094#1077#1085#1082#1072#1084' + '#1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1087#1086' '#1084#1072#1090#1077#1088#1080#1072#1083#1072#1084' + '#1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1087 +
        #1086' '#1084#1072#1090#1077#1088#1080#1072#1083#1072#1084', '#1074#1099#1085#1089#1077#1085#1085#1099#1084' '#1079#1072' '#1088#1072#1089#1094#1077#1085#1082#1091'*/'
      
        '(COALESCE((SELECT SUM(RATE_SUM) FROM data_estimate, card_rate WH' +
        'ERE data_estimate.ID_TYPE_DATA = 1 AND card_rate.ID = data_estim' +
        'ate.ID_TABLES AND ID_ESTIMATE = SM_ID), 0) + '
      
        'COALESCE((SELECT SUM(MAT_SUM) FROM data_estimate, materialcard W' +
        'HERE data_estimate.ID_TYPE_DATA = 2 AND materialcard.ID = data_e' +
        'stimate.ID_TABLES AND ID_ESTIMATE = SM_ID), 0) +'
      '(0)) AS PTM_COST, '
      
        '/*'#1042#1067#1055#1054#1051#1053#1045#1053#1054' '#1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1087#1086' '#1088#1072#1089#1094#1077#1085#1082#1072#1084' + '#1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1087#1086' '#1084#1072#1090#1077#1088#1080#1072#1083#1072#1084' + '#1057 +
        #1090#1086#1080#1084#1086#1089#1090#1100' '#1087#1086' '#1084#1072#1090#1077#1088#1080#1072#1083#1072#1084', '#1074#1099#1085#1089#1077#1085#1085#1099#1084' '#1079#1072' '#1088#1072#1089#1094#1077#1085#1082#1091'*/'
      
        '(COALESCE((SELECT SUM(RATE_SUM) FROM card_rate_act, data_estimat' +
        'e where data_estimate.ID_TYPE_DATA = 1 AND card_rate_act.id=data' +
        '_estimate.ID_TABLES AND ID_ESTIMATE = SM_ID), 0) +'
      
        'COALESCE((SELECT SUM(MAT_SUM) FROM data_estimate, materialcard_a' +
        'ct WHERE data_estimate.ID_TYPE_DATA = 2 AND materialcard_act.ID ' +
        '= data_estimate.ID_TABLES AND ID_ESTIMATE = SM_ID), 0) + '
      '(0)) AS PTM_COST_DONE,'
      '/* '#1054#1057#1058#1040#1058#1054#1050' */'
      
        '((COALESCE((SELECT SUM(RATE_SUM) FROM data_estimate, card_rate W' +
        'HERE data_estimate.ID_TYPE_DATA = 1 AND card_rate.ID = data_esti' +
        'mate.ID_TABLES AND ID_ESTIMATE = SM_ID), 0) + '
      
        'COALESCE((SELECT SUM(MAT_SUM) FROM data_estimate, materialcard W' +
        'HERE data_estimate.ID_TYPE_DATA = 2 AND materialcard.ID = data_e' +
        'stimate.ID_TABLES AND ID_ESTIMATE = SM_ID), 0) +'
      
        '(0))-(COALESCE((SELECT SUM(RATE_SUM) FROM card_rate_act, data_es' +
        'timate where data_estimate.ID_TYPE_DATA = 1 AND card_rate_act.id' +
        '=data_estimate.ID_TABLES AND ID_ESTIMATE = SM_ID), 0) +'
      
        'COALESCE((SELECT SUM(MAT_SUM) FROM data_estimate, materialcard_a' +
        'ct WHERE data_estimate.ID_TYPE_DATA = 2 AND materialcard_act.ID ' +
        '= data_estimate.ID_TABLES AND ID_ESTIMATE = SM_ID), 0) + '
      '(0))) AS PTM_COST_OUT, ('#39#39') as TYPE_NAME, SM_ID as ID    '
      'FROM smetasourcedata s2'
      'WHERE s2.SM_TYPE=3 AND '
      '      s2.OBJ_ID=:OBJ_ID'
      'ORDER BY 1,4,5')
    Left = 9
    Top = 40
    ParamData = <
      item
        Name = 'OBJ_ID'
        DataType = ftAutoInc
        ParamType = ptInput
        Size = 4
        Value = 36
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
    object N3: TMenuItem
      Caption = #1050#1086#1083#1086#1085#1082#1080
    end
    object N2: TMenuItem
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1088#1072#1089#1095#1077#1090#1072
    end
  end
end
