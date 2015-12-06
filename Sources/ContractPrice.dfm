object fContractPrice: TfContractPrice
  Left = 0
  Top = 0
  Caption = #1050#1086#1085#1090#1088#1072#1082#1090#1085#1072#1103' '#1094#1077#1085#1072
  ClientHeight = 346
  ClientWidth = 573
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
    Width = 573
    Height = 113
    Align = alTop
    TabOrder = 0
    ExplicitLeft = -1
    ExplicitTop = -5
    object lbl1: TLabel
      Left = 8
      Top = 8
      Width = 43
      Height = 13
      Caption = #1054#1073#1098#1077#1082#1090':'
    end
    object lbl2: TLabel
      Left = 8
      Top = 27
      Width = 212
      Height = 13
      Caption = #1044#1072#1090#1072' '#1088#1072#1079#1088#1072#1073#1086#1090#1082#1080' '#1089#1084#1077#1090#1085#1086#1081' '#1076#1086#1082#1091#1084#1077#1085#1090#1072#1094#1080#1080':'
    end
    object lbl3: TLabel
      Left = 264
      Top = 27
      Width = 148
      Height = 13
      Caption = #1044#1072#1090#1072' '#1085#1072#1095#1072#1083#1072' '#1089#1090#1088#1086#1080#1090#1077#1083#1100#1089#1090#1074#1072':'
    end
    object lbl4: TLabel
      Left = 418
      Top = 27
      Width = 136
      Height = 13
      Caption = #1057#1088#1086#1082' '#1089#1090#1088#1086#1080#1090#1077#1083#1100#1089#1090#1074#1072', '#1084#1077#1089'.:'
    end
    object rgShowProgress: TRadioGroup
      Left = 8
      Top = 46
      Width = 289
      Height = 43
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1075#1088#1072#1092#1080#1082':'
      Columns = 2
      Items.Strings = (
        #1074' '#1088#1091#1073#1083#1103#1093
        #1074' '#1087#1088#1086#1094#1077#1085#1090#1072#1093' '#1086#1090' '#1086#1073#1098#1077#1084#1072)
      TabOrder = 0
    end
  end
  object pnlClient: TPanel
    Left = 0
    Top = 113
    Width = 573
    Height = 233
    Align = alClient
    TabOrder = 1
    ExplicitTop = 8
    ExplicitHeight = 113
    object JvDBGrid1: TJvDBGrid
      Left = 1
      Top = 1
      Width = 571
      Height = 231
      Align = alClient
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
      Columns = <
        item
          Expanded = False
          Title.Alignment = taCenter
          Visible = True
        end
        item
          Expanded = False
          Title.Alignment = taCenter
          Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
          Width = 79
          Visible = True
        end
        item
          Expanded = False
          Title.Alignment = taCenter
          Title.Caption = #1050#1086#1083'-'#1074#1086
          Visible = True
        end
        item
          Expanded = False
          Title.Alignment = taCenter
          Title.Caption = #1045#1076'. '#1080#1079#1084'.'
          Visible = True
        end
        item
          Expanded = False
          Title.Alignment = taCenter
          Title.Caption = #1042#1089#1077#1075#1086
          Width = 81
          Visible = True
        end>
    end
  end
  object dsMain: TDataSource
    DataSet = qrMain
    Left = 424
    Top = 176
  end
  object qrMain: TFDQuery
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
    FormatOptions.FmtDisplayNumeric = '### ### ### ### ### ### ##0.######'
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.CheckUpdatable = False
    SQL.Strings = (
      'SELECT '
      
        'CONCAT(IF(((sm.`SM_ID` = :SM_ID) OR (sm.`PARENT_ID` = :SM_ID)), ' +
        #39#39', :SM_ID), sm.`PARENT_ID`, sm.`SM_ID`, d.`ID`) as SORT_ID,'
      'CASE d.`ID_TYPE_DATA` '
      '  WHEN 1 THEN cr.`RATE_CODE`'
      '  WHEN 2 THEN mat.`MAT_CODE`'
      '  WHEN 3 THEN mech.`MECH_CODE`'
      '  WHEN 4 THEN dev.`DEVICE_CODE`'
      '  WHEN 5 THEN dmp.`DUMP_CODE_JUST`'
      '  WHEN 6 THEN tr.`TRANSP_CODE_JUST`'
      '  WHEN 7 THEN tr.`TRANSP_CODE_JUST`'
      '  WHEN 8 THEN tr.`TRANSP_CODE_JUST`'
      '  WHEN 9 THEN tr.`TRANSP_CODE_JUST`'
      '  WHEN 10 THEN ('#39#1045#1058'18'#39')'
      '  WHEN 11 THEN ('#39#1045#1058'20'#39')'
      'END AS OBJ_CODE, '
      'CASE d.`ID_TYPE_DATA` '
      '  WHEN 1 THEN cr.`RATE_CAPTION`'
      '  WHEN 2 THEN mat.`MAT_NAME`'
      '  WHEN 3 THEN mech.`MECH_NAME`'
      '  WHEN 4 THEN dev.`DEVICE_NAME`'
      '  WHEN 5 THEN dmp.`DUMP_NAME`'
      '  WHEN 6 THEN tr.`TRANSP_JUST`'
      '  WHEN 7 THEN tr.`TRANSP_JUST`'
      '  WHEN 8 THEN tr.`TRANSP_JUST`'
      '  WHEN 9 THEN tr.`TRANSP_JUST`'
      '  WHEN 10 THEN ('#39#1045#1058'18'#39')'
      '  WHEN 11 THEN ('#39#1045#1058'20'#39')'
      'END AS OBJ_NAME, '
      'IF(:BY_COUNT=1,'
      'CASE d.`ID_TYPE_DATA` '
      '  WHEN 1 THEN cr.`RATE_COUNT`'
      '  WHEN 2 THEN mat.`MAT_COUNT`'
      '  WHEN 3 THEN mech.`MECH_COUNT`'
      '  WHEN 4 THEN dev.`DEVICE_COUNT`'
      '  WHEN 5 THEN dmp.`DUMP_COUNT`'
      '  WHEN 6 THEN tr.`TRANSP_COUNT`'
      '  WHEN 7 THEN tr.`TRANSP_COUNT`'
      '  WHEN 8 THEN tr.`TRANSP_COUNT`'
      '  WHEN 9 THEN tr.`TRANSP_COUNT`'
      '  WHEN 10 THEN d.`E1820_COUNT`'
      '  WHEN 11 THEN d.`E1820_COUNT`'
      
        'END, ROUND(IF(:FL_INCL_OHROPR_PLPR=1, d.`ST_OHROPR`, d.`STOIM`)+' +
        'IF(:FL_INCL_WINTER=1, (d.`ZIM_UDOR` + d.`ZP_ZIM_UDOR`) * sm.`APP' +
        'LY_WINTERPRISE_FLAG`, 0.0))) AS OBJ_COUNT,'
      'IF(:BY_COUNT=1,'
      'CASE d.`ID_TYPE_DATA`'
      
        '  WHEN 1 THEN (SELECT SUM(`card_rate_act`.`RATE_COUNT`) FROM `ca' +
        'rd_rate_act`, `data_act` WHERE `card_rate_act`.`ID`=`data_act`.`' +
        'ID_TABLES` AND `data_act`.`ID_TYPE_DATA`=d.`ID_TYPE_DATA` AND `d' +
        'ata_act`.`ID_TABLES`=d.`ID_TABLES` AND `data_act`.`ID_ESTIMATE`=' +
        'd.`ID_ESTIMATE`)'
      
        '  WHEN 2 THEN (SELECT SUM(`materialcard_act`.`MAT_COUNT`) FROM `' +
        'materialcard_act`, `data_act` WHERE `materialcard_act`.`ID`=`dat' +
        'a_act`.`ID_TABLES` AND `data_act`.`ID_TYPE_DATA`=d.`ID_TYPE_DATA' +
        '` AND `data_act`.`ID_TABLES`=d.`ID_TABLES` AND `data_act`.`ID_ES' +
        'TIMATE`=d.`ID_ESTIMATE`)'
      
        '  WHEN 3 THEN (SELECT SUM(`mechanizmcard_act`.`MECH_COUNT`) FROM' +
        ' `mechanizmcard_act`, `data_act` WHERE `mechanizmcard_act`.`ID`=' +
        '`data_act`.`ID_TABLES` AND `data_act`.`ID_TYPE_DATA`=d.`ID_TYPE_' +
        'DATA` AND `data_act`.`ID_TABLES`=d.`ID_TABLES` AND `data_act`.`I' +
        'D_ESTIMATE`=d.`ID_ESTIMATE`)'
      
        '  WHEN 4 THEN (SELECT SUM(`devicescard_act`.`DEVICE_COUNT`) FROM' +
        ' `devicescard_act`, `data_act` WHERE `devicescard_act`.`ID`=`dat' +
        'a_act`.`ID_TABLES` AND `data_act`.`ID_TYPE_DATA`=d.`ID_TYPE_DATA' +
        '` AND `data_act`.`ID_TABLES`=d.`ID_TABLES` AND `data_act`.`ID_ES' +
        'TIMATE`=d.`ID_ESTIMATE`)'
      
        '  WHEN 5 THEN (SELECT SUM(`dumpcard_act`.`DUMP_COUNT`) FROM `dum' +
        'pcard_act`, `data_act` WHERE `dumpcard_act`.`ID`=`data_act`.`ID_' +
        'TABLES` AND `data_act`.`ID_TYPE_DATA`=d.`ID_TYPE_DATA` AND `data' +
        '_act`.`ID_TABLES`=d.`ID_TABLES` AND `data_act`.`ID_ESTIMATE`=d.`' +
        'ID_ESTIMATE`)'
      
        '  WHEN 6 THEN (SELECT SUM(`transpcard_act`.`TRANSP_COUNT`) FROM ' +
        '`transpcard_act`, `data_act` WHERE `transpcard_act`.`ID`=`data_a' +
        'ct`.`ID_TABLES` AND `data_act`.`ID_TYPE_DATA`=d.`ID_TYPE_DATA` A' +
        'ND `data_act`.`ID_TABLES`=d.`ID_TABLES` AND `data_act`.`ID_ESTIM' +
        'ATE`=d.`ID_ESTIMATE`)'
      
        '  WHEN 7 THEN (SELECT SUM(`transpcard_act`.`TRANSP_COUNT`) FROM ' +
        '`transpcard_act`, `data_act` WHERE `transpcard_act`.`ID`=`data_a' +
        'ct`.`ID_TABLES` AND `data_act`.`ID_TYPE_DATA`=d.`ID_TYPE_DATA` A' +
        'ND `data_act`.`ID_TABLES`=d.`ID_TABLES` AND `data_act`.`ID_ESTIM' +
        'ATE`=d.`ID_ESTIMATE`)'
      
        '  WHEN 8 THEN (SELECT SUM(`transpcard_act`.`TRANSP_COUNT`) FROM ' +
        '`transpcard_act`, `data_act` WHERE `transpcard_act`.`ID`=`data_a' +
        'ct`.`ID_TABLES` AND `data_act`.`ID_TYPE_DATA`=d.`ID_TYPE_DATA` A' +
        'ND `data_act`.`ID_TABLES`=d.`ID_TABLES` AND `data_act`.`ID_ESTIM' +
        'ATE`=d.`ID_ESTIMATE`)'
      
        '  WHEN 9 THEN (SELECT SUM(`transpcard_act`.`TRANSP_COUNT`) FROM ' +
        '`transpcard_act`, `data_act` WHERE `transpcard_act`.`ID`=`data_a' +
        'ct`.`ID_TABLES` AND `data_act`.`ID_TYPE_DATA`=d.`ID_TYPE_DATA` A' +
        'ND `data_act`.`ID_TABLES`=d.`ID_TABLES` AND `data_act`.`ID_ESTIM' +
        'ATE`=d.`ID_ESTIMATE`)'
      
        '  WHEN 10 THEN (SELECT SUM(`data_act`.`E1820_COUNT`) FROM `data_' +
        'act` WHERE `data_act`.`ID_TYPE_DATA`=d.`ID_TYPE_DATA` AND `data_' +
        'act`.`ID_TABLES`=d.`ID_TABLES` AND `data_act`.`ID_ESTIMATE`=d.`I' +
        'D_ESTIMATE`)'
      
        '  WHEN 11 THEN (SELECT SUM(`data_act`.`E1820_COUNT`) FROM `data_' +
        'act` WHERE `data_act`.`ID_TYPE_DATA`=d.`ID_TYPE_DATA` AND `data_' +
        'act`.`ID_TABLES`=d.`ID_TABLES` AND `data_act`.`ID_ESTIMATE`=d.`I' +
        'D_ESTIMATE`)'
      
        'END, ROUND((SELECT SUM(IF(:FL_INCL_OHROPR_PLPR=1, `data_act`.`ST' +
        '_OHROPR`, `data_act`.`STOIM`)+IF(:FL_INCL_WINTER=1, (`data_act`.' +
        '`ZIM_UDOR` + `data_act`.`ZP_ZIM_UDOR`) * sm.`APPLY_WINTERPRISE_F' +
        'LAG`, 0.0)) FROM `data_act` WHERE d.`ID_TABLES`=`data_act`.`ID_T' +
        'ABLES` AND d.`ID_TYPE_DATA`=`data_act`.`ID_TYPE_DATA` AND d.`ID_' +
        'ESTIMATE`=`data_act`.`ID_ESTIMATE`))) AS OBJ_COUNT_DONE,'
      'CASE d.`ID_TYPE_DATA` '
      '  WHEN 1 THEN cr.`RATE_UNIT`'
      '  WHEN 2 THEN mat.`MAT_UNIT`'
      '  WHEN 3 THEN mech.`MECH_UNIT`'
      '  WHEN 4 THEN dev.`DEVICE_UNIT`'
      '  WHEN 5 THEN dmp.`DUMP_UNIT`'
      '  WHEN 6 THEN tr.`CARG_UNIT`'
      '  WHEN 7 THEN tr.`CARG_UNIT`'
      '  WHEN 8 THEN tr.`CARG_UNIT`'
      '  WHEN 9 THEN tr.`CARG_UNIT`'
      '  WHEN 10 THEN ('#39#1096#1090'.'#39')'
      '  WHEN 11 THEN ('#39#1096#1090'.'#39')'
      'END AS OBJ_UNIT, '
      'd.`ID_TYPE_DATA` as ID_TYPE_DATA,'
      'd.`ID` as DATA_ESTIMATE_OR_ACT_ID,'
      'd.`ID_TABLES` AS ID_TABLES,'
      'sm.`SM_ID`'
      'FROM `smetasourcedata` sm, `data_estimate` d'
      
        'LEFT JOIN `card_rate` cr ON d.`ID_TYPE_DATA` = 1 AND cr.`ID` = d' +
        '.`ID_TABLES`'
      
        'LEFT JOIN `materialcard` mat ON d.`ID_TYPE_DATA` = 2 AND mat.`ID' +
        '` = d.`ID_TABLES`'
      
        'LEFT JOIN `mechanizmcard` mech ON d.`ID_TYPE_DATA` = 3 AND mech.' +
        '`ID` = d.`ID_TABLES`'
      
        'LEFT JOIN `devicescard` dev ON d.`ID_TYPE_DATA` = 4 AND dev.`ID`' +
        ' = d.`ID_TABLES`'
      
        'LEFT JOIN `dumpcard` dmp ON d.`ID_TYPE_DATA` = 5 AND dmp.`ID` = ' +
        'd.`ID_TABLES`'
      
        'LEFT JOIN `transpcard` tr ON d.`ID_TYPE_DATA` IN (6,7,8,9) AND t' +
        'r.`ID` = d.`ID_TABLES`'
      'WHERE sm.`SM_ID`=d.`ID_ESTIMATE` AND'
      '      ((sm.`SM_ID` = :SM_ID) OR '
      '       (sm.`PARENT_ID` = :SM_ID) OR'
      '       (sm.`PARENT_ID` IN '
      '        (SELECT `smetasourcedata`.`SM_ID` '
      '         FROM `smetasourcedata` '
      '         WHERE `smetasourcedata`.`PARENT_ID` = :SM_ID)))'
      'UNION ALL'
      '/* '#1042#1099#1074#1086#1076#1080#1084' '#1079#1072#1084#1077#1085#1103#1102#1097#1080#1077' '#1084#1072#1090#1077#1088#1080#1072#1083#1099' */'
      'SELECT '
      
        'CONCAT(IF(((sm.`SM_ID` = :SM_ID) OR (sm.`PARENT_ID` = :SM_ID)), ' +
        #39#39', :SM_ID), sm.`PARENT_ID`, sm.`SM_ID`, d.`ID`, mat.`ID`) as SO' +
        'RT_ID,'
      'CONCAT('#39'   '#39', mat.`MAT_CODE`) AS OBJ_CODE, '
      'mat.`MAT_NAME` AS OBJ_NAME,'
      '/*'#1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1076#1086#1089#1090#1072#1077#1090#1089#1103' '#1085#1077#1074#1077#1088#1085#1086'*/'
      
        'IF(:BY_COUNT=1, mat.`MAT_COUNT`, ROUND(IF(:FL_INCL_OHROPR_PLPR=1' +
        ', d.`ST_OHROPR`, d.`STOIM`)+IF(:FL_INCL_WINTER=1, (d.`ZIM_UDOR` ' +
        '+ d.`ZP_ZIM_UDOR`) * sm.`APPLY_WINTERPRISE_FLAG`, 0.0))) AS OBJ_' +
        'COUNT, '
      'mat.`MAT_UNIT` AS OBJ_UNIT, '
      'd.`ID_TYPE_DATA` as ID_TYPE_DATA,'
      'd.`ID` as DATA_ESTIMATE_OR_ACT_ID,'
      'd.`ID_TABLES` AS ID_TABLES,'
      'sm.`SM_ID`'
      'FROM `smetasourcedata` sm, `data_estimate` d'
      'JOIN `card_rate` cr ON cr.`ID` = d.`ID_TABLES`'
      
        'JOIN `materialcard` mat ON cr.`ID` = d.`ID_TABLES` AND mat.`ID_C' +
        'ARD_RATE` = d.`ID_TABLES` AND mat.`ID_REPLACED` > 0'
      'WHERE sm.`SM_ID`=d.`ID_ESTIMATE` AND'
      '      d.`ID_TYPE_DATA` = 1 AND'
      '      ((sm.`SM_ID` = :SM_ID) OR '
      '       (sm.`PARENT_ID` = :SM_ID) OR'
      '       (sm.`PARENT_ID` IN '
      '        (SELECT `smetasourcedata`.`SM_ID` '
      '         FROM `smetasourcedata` '
      '         WHERE `smetasourcedata`.`PARENT_ID` = :SM_ID)))'
      'UNION ALL'
      '/* '#1047#1072#1075#1086#1083#1086#1074#1082#1080' '#1088#1072#1079#1076#1077#1083#1086#1074' */'
      'select CONCAT('
      
        'IF(((sm.`SM_ID` = :SM_ID) OR (sm.`PARENT_ID` = :SM_ID)), '#39#39', :SM' +
        '_ID), sm.`PARENT_ID`, sm.`SM_ID`) as SORT_ID,'
      
        'CONCAT(sm.`SM_NUMBER`, '#39' '#39', sm.`NAME`) AS OBJ_CODE, NULL AS OBJ_' +
        'NAME, '
      
        'IF(:BY_COUNT=1, NULL, ROUND(IF(:FL_INCL_OHROPR_PLPR=1, sm.`S_ST_' +
        'OHROPR`, sm.`S_STOIM`)+IF(:FL_INCL_WINTER=1, (sm.`S_ZIM_UDOR` + ' +
        'sm.`S_ZP_ZIM_UDOR`) * sm.`APPLY_WINTERPRISE_FLAG`, 0.0))) AS OBJ' +
        '_COUNT, '
      'NULL AS OBJ_UNIT,(sm.`SM_TYPE` * -1) as ID_TYPE_DATA,'
      'NULL AS DATA_ESTIMATE_OR_ACT_ID, NULL AS ID_TABLES, sm.`SM_ID`'
      'FROM `smetasourcedata` sm'
      'WHERE ((sm.`PARENT_ID` = :SM_ID) OR'
      '       (sm.`PARENT_ID` IN '
      '        (SELECT `smetasourcedata`.`SM_ID` '
      '         FROM `smetasourcedata` '
      '         WHERE `smetasourcedata`.`PARENT_ID` = :SM_ID)))'
      'ORDER BY SORT_ID')
    Left = 384
    Top = 176
    ParamData = <
      item
        Name = 'SM_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 344
      end
      item
        Name = 'BY_COUNT'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end
      item
        Name = 'FL_INCL_OHROPR_PLPR'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end
      item
        Name = 'FL_INCL_WINTER'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end>
  end
end
