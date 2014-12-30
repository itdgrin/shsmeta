object fCalcTravel: TfCalcTravel
  Left = 0
  Top = 0
  Caption = #1056#1072#1089#1095#1077#1090' '#1082#1086#1084#1072#1085#1076#1080#1088#1086#1074#1086#1095#1085#1099#1093
  ClientHeight = 354
  ClientWidth = 452
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
    452
    354)
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 8
    Top = 35
    Width = 25
    Height = 13
    Caption = #1040#1082#1090':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
  end
  object lbl3: TLabel
    Left = 8
    Top = 8
    Width = 48
    Height = 13
    Caption = #1054#1073#1098#1077#1082#1090':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
  end
  object lbl4: TLabel
    Left = 8
    Top = 297
    Width = 48
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = #1057#1086#1089#1090#1072#1074#1080#1083
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object dbedt1: TDBEdit
    Left = 62
    Top = 35
    Width = 382
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object dbedt2: TDBEdit
    Left = 62
    Top = 294
    Width = 227
    Height = 21
    Anchors = [akLeft, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object dbedtNAME: TDBEdit
    Left = 62
    Top = 8
    Width = 382
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    DataField = 'NAME'
    DataSource = fTravelList.dsObject
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object btnExit: TBitBtn
    Left = 353
    Top = 321
    Width = 91
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1047#1072#1082#1088#1099#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnClick = btnExitClick
  end
  object btnSave: TBitBtn
    Left = 256
    Top = 321
    Width = 91
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnClick = btnSaveClick
  end
  object JvDBGrid1: TJvDBGrid
    Left = 8
    Top = 62
    Width = 436
    Height = 226
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = dsCalcKomandir
    DrawingStyle = gdsClassic
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ParentFont = False
    TabOrder = 5
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnKeyPress = JvDBGrid1KeyPress
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
        FieldName = 'NUMPP'
        Title.Alignment = taCenter
        Title.Caption = #8470' '#1087#1087
        Width = 34
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NAIMEN'
        Title.Alignment = taCenter
        Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1079#1072#1090#1088#1072#1090
        Width = 211
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CALC'
        Title.Alignment = taCenter
        Title.Caption = #1056#1072#1089#1095#1077#1090
        Width = 92
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TOTAL'
        Title.Alignment = taCenter
        Title.Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100
        Width = 91
        Visible = True
      end>
  end
  object dsCalcKomandir: TDataSource
    DataSet = qrCalcKomandir
    Left = 36
    Top = 150
  end
  object qrCalcKomandir: TFDQuery
    AfterPost = qrCalcKomandirAfterPost
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
    FormatOptions.FmtDisplayNumeric = '### ### ### ###.##'
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.CheckUpdatable = False
    SQL.Strings = (
      'SELECT ('#39'01'#39') AS NUMPP,'
      '       (null) AS NAIMEN,'
      '       (null) AS CALC,'
      '       (null) AS TOTAL'
      'UNION ALL'
      'SELECT ('#39'02'#39') AS NUMPP,'
      
        '       ('#39#1048'CXO'#1044'H'#1067'E '#1044'AHH'#1067'E '#1044#1051#1071' PAC'#1063'ETA '#1050'OMAH'#1044#1048'POBO'#1063'H'#1067'X PACXO'#1044'OB:'#39')' +
        ' AS NAIMEN,'
      '       (null) AS CALC,'
      '       (null) AS TOTAL'
      'UNION ALL'
      'SELECT ('#39'06'#39') AS NUMPP,'
      '       ('#39'C'#1091#1090#1086#1095#1085#1099#1077' '#1074' '#1090#1077#1082#1091#1097#1080#1093' '#1094#1077#1085#1072#1093' ('#1088#1091#1073')'#39') AS NAIMEN,'
      '       (FN_getParamValue('#39'SUTKI_KOMANDIR'#39', 1, 2014)) AS CALC,'
      '       (FN_getParamValue('#39'SUTKI_KOMANDIR'#39', 1, 2014)) AS TOTAL'
      'UNION ALL'
      'SELECT ('#39'07'#39') AS NUMPP,'
      '       ('#39#1050#1074#1072#1088#1090#1080#1088#1085#1099#1077' '#1074' '#1090#1077#1082#1091#1097#1080#1093' '#1094#1077#1085#1072#1093' ('#1088#1091#1073')'#39') AS NAIMEN,'
      '       (FN_getParamValue('#39'HOUSING_KOMANDIR'#39', 1, 2014)) AS CALC,'
      '       (FN_getParamValue('#39'HOUSING_KOMANDIR'#39', 1, 2014)) AS TOTAL'
      'UNION ALL'
      'SELECT ('#39'08'#39') AS NUMPP,'
      
        '       ('#39'C'#1090#1086#1080#1084#1086#1089#1090#1100' '#1087#1088#1086#1077#1079#1076#1072' '#1074' '#1086#1076#1085#1091' '#1089#1090#1086#1088#1086#1085#1091'  '#1074' '#1090#1077#1082#1091#1097#1080#1093' '#1094#1077#1085#1072#1093' ('#1088#1091#1073'.' +
        ' '#1085#1072' 1 '#1082#1084')'#39') AS NAIMEN,'
      '       (:STOIM_KM) AS CALC,'
      '       ((null) ) AS TOTAL'
      'UNION ALL'
      'SELECT ('#39'09'#39') AS NUMPP,'
      '       ('#39'P'#1072#1089#1089#1090#1086#1103#1085#1080#1077' '#1076#1086' '#1086#1073#1098#1077#1082#1090#1072'  ('#1082#1084')'#39') AS NAIMEN,'
      '       (:KM) AS CALC,'
      '       ((null) ) AS TOTAL'
      'UNION ALL'
      'SELECT ('#39'10'#39') AS NUMPP,'
      '       ('#39#1055#1088#1086#1076#1086#1083#1078#1080#1090#1077#1083#1100#1085#1086#1089#1090#1100' '#1088#1072#1073#1086#1095#1077#1075#1086' '#1076#1085#1103'  ('#1095#1072#1089')'#39') AS NAIMEN,'
      '       (8) AS CALC,'
      '       (8) AS TOTAL'
      'UNION ALL'
      'SELECT ('#39'11'#39') AS NUMPP,'
      '       ('#39#1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1088#1072#1073#1086#1095#1080#1093' '#1076#1085#1077#1081' '#1074' '#1084#1077#1089#1103#1094#1077'  ('#1076#1085#1077#1081')'#39') AS NAIMEN,'
      
        '       (FN_getParamValue('#39'COUNT_WORK_DAY_IN_MONTH'#39', 1, 2014)) AS' +
        ' CALC,'
      
        '       (FN_getParamValue('#39'COUNT_WORK_DAY_IN_MONTH'#39', 1, 2014)) AS' +
        ' TOTAL'
      'UNION ALL'
      'SELECT ('#39'12'#39') AS NUMPP,'
      
        '       ('#39#1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1082#1072#1083#1077#1085#1076#1072#1088#1085#1099#1093' '#1076#1085#1077#1081' '#1074' '#1084#1077#1089#1103#1094#1077' ('#1076#1085#1077#1081')'#39') AS NAIMEN' +
        ','
      '       (FN_getParamValue('#39'CUNT_DAY_IN_MONTH'#39', 1, 2014)) AS CALC,'
      '       (FN_getParamValue('#39'CUNT_DAY_IN_MONTH'#39', 1, 2014)) AS TOTAL'
      'UNION ALL'
      'SELECT ('#39'13'#39') AS NUMPP,'
      
        '       ('#39'---------------------------------------------'#39') AS NAIM' +
        'EN,'
      '       (null) AS CALC,'
      '       (null) AS TOTAL'
      'UNION ALL'
      'SELECT ('#39'14'#39') AS NUMPP,'
      '       ('#39'H'#1086#1088#1084#1072#1090#1080#1074#1085#1072#1103' '#1090#1088#1091#1076#1086#1077#1084#1082#1086#1089#1090#1100' '#1088#1072#1073#1086#1090' ('#1095#1077#1083'-'#1076#1085')'#39') AS NAIMEN,'
      '       (CONCAT('#39'(141+19+'#39', '
      '        FN_getParamValue('#39'K_SUM1000_TO_TRUD_OBHOZ'#39', 1, 2014),'
      '        '#39'/1000*'#39', '
      
        '        (SELECT S_OHROPR FROM smetasourcedata WHERE SM_ID=:ID_AC' +
        'T),'
      '        '#39'+'#39','
      '        FN_getParamValue('#39'K_SUM1000_TO_TRUD_VREM'#39', 1, 2014),'
      '        '#39'/1000*'#39','
      '        (SELECT 0 FROM smetasourcedata WHERE SM_ID=:ID_ACT),'
      '        '#39'+0.035/1000*'#39','
      '        FN_getParamValue('#39'K_SUM1000_TO_TRUD_ZIM'#39', 1, 2014),'
      '        '#39'*0)/8'#39
      '       )'
      '       ) AS CALC,'
      
        '       ((141+19+FN_getParamValue('#39'K_SUM1000_TO_TRUD_OBHOZ'#39', 1, 2' +
        '014)/1000*(SELECT S_OHROPR FROM smetasourcedata WHERE SM_ID=:ID_' +
        'ACT)+'
      
        '        FN_getParamValue('#39'K_SUM1000_TO_TRUD_VREM'#39', 1, 2014)/1000' +
        '*(SELECT 0 FROM smetasourcedata WHERE SM_ID=:ID_ACT)+0.035/1000*'
      
        '        FN_getParamValue('#39'K_SUM1000_TO_TRUD_ZIM'#39', 1, 2014)*0)/8)' +
        ' AS TOTAL'
      'UNION ALL'
      'SELECT ('#39'15'#39') AS NUMPP,'
      
        '       ('#39'---------------------------------------------'#39') AS NAIM' +
        'EN,'
      '       (null) AS CALC,'
      '       (null) AS TOTAL'
      'UNION ALL'
      'SELECT ('#39'22'#39') AS NUMPP,'
      '       ('#39'PAC'#1063'ET  B TE'#1050#1059#1065#1048'X '#1062'EHAX'#39') AS NAIMEN,'
      '       (null) AS CALC,'
      '       (null) AS TOTAL'
      'UNION ALL'
      'SELECT ('#39'23'#39') AS NUMPP,'
      '       ('#39'C'#1091#1090#1086#1095#1085#1099#1077#39') AS NAIMEN,'
      
        '       (CONCAT(FN_getParamValue('#39'SUTKI_KOMANDIR'#39', 1, 2014), '#39'*'#39',' +
        ' ((141+19+FN_getParamValue('#39'K_SUM1000_TO_TRUD_OBHOZ'#39', 1, 2014)/1' +
        '000*(SELECT S_OHROPR FROM smetasourcedata WHERE SM_ID=:ID_ACT)+'
      
        '        FN_getParamValue('#39'K_SUM1000_TO_TRUD_VREM'#39', 1, 2014)/1000' +
        '*(SELECT 0 FROM smetasourcedata WHERE SM_ID=:ID_ACT)+0.035/1000*'
      
        '        FN_getParamValue('#39'K_SUM1000_TO_TRUD_ZIM'#39', 1, 2014)*0)/8)' +
        ', '#39'/'#39' , FN_getParamValue('#39'COUNT_WORK_DAY_IN_MONTH'#39', 1, 2014),'#39'*'#39 +
        ', FN_getParamValue('#39'CUNT_DAY_IN_MONTH'#39', 1, 2014))) AS CALC,'
      
        '       (FN_getParamValue('#39'SUTKI_KOMANDIR'#39', 1, 2014)*((141+19+FN_' +
        'getParamValue('#39'K_SUM1000_TO_TRUD_OBHOZ'#39', 1, 2014)/1000*(SELECT S' +
        '_OHROPR FROM smetasourcedata WHERE SM_ID=:ID_ACT)+'
      
        '        FN_getParamValue('#39'K_SUM1000_TO_TRUD_VREM'#39', 1, 2014)/1000' +
        '*(SELECT 0 FROM smetasourcedata WHERE SM_ID=:ID_ACT)+0.035/1000*'
      
        '        FN_getParamValue('#39'K_SUM1000_TO_TRUD_ZIM'#39', 1, 2014)*0)/8)' +
        '/FN_getParamValue('#39'COUNT_WORK_DAY_IN_MONTH'#39', 1, 2014)*FN_getPara' +
        'mValue('#39'CUNT_DAY_IN_MONTH'#39', 1, 2014)) AS TOTAL'
      'UNION ALL'
      'SELECT ('#39'24'#39') AS NUMPP,'
      '       ('#39#1050#1074#1072#1088#1090#1080#1088#1085#1099#1077#39') AS NAIMEN,'
      
        '       (CONCAT(FN_getParamValue('#39'HOUSING_KOMANDIR'#39', 1, 2014), '#39'*' +
        #39', ((141+19+FN_getParamValue('#39'K_SUM1000_TO_TRUD_OBHOZ'#39', 1, 2014)' +
        '/1000*(SELECT S_OHROPR FROM smetasourcedata WHERE SM_ID=:ID_ACT)' +
        '+'
      
        '        FN_getParamValue('#39'K_SUM1000_TO_TRUD_VREM'#39', 1, 2014)/1000' +
        '*(SELECT 0 FROM smetasourcedata WHERE SM_ID=:ID_ACT)+0.035/1000*'
      
        '        FN_getParamValue('#39'K_SUM1000_TO_TRUD_ZIM'#39', 1, 2014)*0)/8)' +
        ', '#39'/'#39' , FN_getParamValue('#39'COUNT_WORK_DAY_IN_MONTH'#39', 1, 2014),'#39'*'#39 +
        ', FN_getParamValue('#39'CUNT_DAY_IN_MONTH'#39', 1, 2014))) AS CALC,'
      
        '       (FN_getParamValue('#39'HOUSING_KOMANDIR'#39', 1, 2014)*((141+19+F' +
        'N_getParamValue('#39'K_SUM1000_TO_TRUD_OBHOZ'#39', 1, 2014)/1000*(SELECT' +
        ' S_OHROPR FROM smetasourcedata WHERE SM_ID=:ID_ACT)+'
      
        '        FN_getParamValue('#39'K_SUM1000_TO_TRUD_VREM'#39', 1, 2014)/1000' +
        '*(SELECT 0 FROM smetasourcedata WHERE SM_ID=:ID_ACT)+0.035/1000*'
      
        '        FN_getParamValue('#39'K_SUM1000_TO_TRUD_ZIM'#39', 1, 2014)*0)/8)' +
        '/FN_getParamValue('#39'COUNT_WORK_DAY_IN_MONTH'#39', 1, 2014)*FN_getPara' +
        'mValue('#39'CUNT_DAY_IN_MONTH'#39', 1, 2014)) AS TOTAL'
      'UNION ALL'
      'SELECT ('#39'25'#39') AS NUMPP,'
      '       ('#39'P'#1072#1089#1093#1086#1076#1099' '#1085#1072' '#1087#1088#1086#1077#1079#1076' ('#1090#1091#1076#1072' '#1080' '#1086#1073#1088#1072#1090#1085#1086')'#39') AS NAIMEN,'
      
        '       (CONCAT(:STOIM_KM, '#39'*'#39', :KM ,'#39'*'#39',        ((141+19+FN_getP' +
        'aramValue('#39'K_SUM1000_TO_TRUD_OBHOZ'#39', 1, 2014)/1000*(SELECT S_OHR' +
        'OPR FROM smetasourcedata WHERE SM_ID=:ID_ACT)+'
      
        '        FN_getParamValue('#39'K_SUM1000_TO_TRUD_VREM'#39', 1, 2014)/1000' +
        '*(SELECT 0 FROM smetasourcedata WHERE SM_ID=:ID_ACT)+0.035/1000*'
      '        FN_getParamValue('#39'K_SUM1000_TO_TRUD_ZIM'#39', 1, 2014)*0)/8)'
      
        '        , '#39'/'#39', FN_getParamValue('#39'COUNT_WORK_DAY_IN_MONTH'#39', 1, 20' +
        '14),  '#39'*2'#39')) AS CALC,'
      
        '       (:STOIM_KM*:KM*((141+19+FN_getParamValue('#39'K_SUM1000_TO_TR' +
        'UD_OBHOZ'#39', 1, 2014)/1000*(SELECT S_OHROPR FROM smetasourcedata W' +
        'HERE SM_ID=:ID_ACT)+'
      
        '        FN_getParamValue('#39'K_SUM1000_TO_TRUD_VREM'#39', 1, 2014)/1000' +
        '*(SELECT 0 FROM smetasourcedata WHERE SM_ID=:ID_ACT)+0.035/1000*'
      
        '        FN_getParamValue('#39'K_SUM1000_TO_TRUD_ZIM'#39', 1, 2014)*0)/8)' +
        '/FN_getParamValue('#39'COUNT_WORK_DAY_IN_MONTH'#39', 1, 2014)*2) AS TOTA' +
        'L'
      'UNION ALL'
      'SELECT ('#39'26'#39') AS NUMPP,'
      
        '       ('#39#1048'TO'#1043'O '#1082#1086#1084#1072#1085#1076#1080#1088#1086#1074#1086#1095#1085#1099#1093' '#1088#1072#1089#1093#1086#1076#1086#1074' '#1074' '#1090#1077#1082#1091#1097#1080#1093' '#1094#1077#1085#1072#1093#39') AS NAI' +
        'MEN,'
      
        '       CONCAT((FN_getParamValue('#39'SUTKI_KOMANDIR'#39', 1, 2014)*((141' +
        '+19+FN_getParamValue('#39'K_SUM1000_TO_TRUD_OBHOZ'#39', 1, 2014)/1000*(S' +
        'ELECT S_OHROPR FROM smetasourcedata WHERE SM_ID=:ID_ACT)+'
      
        '        FN_getParamValue('#39'K_SUM1000_TO_TRUD_VREM'#39', 1, 2014)/1000' +
        '*(SELECT 0 FROM smetasourcedata WHERE SM_ID=:ID_ACT)+0.035/1000*'
      
        '        FN_getParamValue('#39'K_SUM1000_TO_TRUD_ZIM'#39', 1, 2014)*0)/8)' +
        '/FN_getParamValue('#39'COUNT_WORK_DAY_IN_MONTH'#39', 1, 2014)*FN_getPara' +
        'mValue('#39'CUNT_DAY_IN_MONTH'#39', 1, 2014)),'#39'+'#39','
      
        '(FN_getParamValue('#39'HOUSING_KOMANDIR'#39', 1, 2014)*((141+19+FN_getPa' +
        'ramValue('#39'K_SUM1000_TO_TRUD_OBHOZ'#39', 1, 2014)/1000*(SELECT S_OHRO' +
        'PR FROM smetasourcedata WHERE SM_ID=:ID_ACT)+'
      
        '        FN_getParamValue('#39'K_SUM1000_TO_TRUD_VREM'#39', 1, 2014)/1000' +
        '*(SELECT 0 FROM smetasourcedata WHERE SM_ID=:ID_ACT)+0.035/1000*'
      
        '        FN_getParamValue('#39'K_SUM1000_TO_TRUD_ZIM'#39', 1, 2014)*0)/8)' +
        '/FN_getParamValue('#39'COUNT_WORK_DAY_IN_MONTH'#39', 1, 2014)*FN_getPara' +
        'mValue('#39'CUNT_DAY_IN_MONTH'#39', 1, 2014)),'#39'+'#39', (0*00*00000/FN_getPar' +
        'amValue('#39'COUNT_WORK_DAY_IN_MONTH'#39', 1, 2014)*2)) AS CALC,'
      
        '       ((FN_getParamValue('#39'SUTKI_KOMANDIR'#39', 1, 2014)*((141+19+FN' +
        '_getParamValue('#39'K_SUM1000_TO_TRUD_OBHOZ'#39', 1, 2014)/1000*(SELECT ' +
        'S_OHROPR FROM smetasourcedata WHERE SM_ID=:ID_ACT)+'
      
        '        FN_getParamValue('#39'K_SUM1000_TO_TRUD_VREM'#39', 1, 2014)/1000' +
        '*(SELECT 0 FROM smetasourcedata WHERE SM_ID=:ID_ACT)+0.035/1000*'
      
        '        FN_getParamValue('#39'K_SUM1000_TO_TRUD_ZIM'#39', 1, 2014)*0)/8)' +
        '/FN_getParamValue('#39'COUNT_WORK_DAY_IN_MONTH'#39', 1, 2014)*FN_getPara' +
        'mValue('#39'CUNT_DAY_IN_MONTH'#39', 1, 2014))+(FN_getParamValue('#39'HOUSING' +
        '_KOMANDIR'#39', 1, 2014)*((141+19+FN_getParamValue('#39'K_SUM1000_TO_TRU' +
        'D_OBHOZ'#39', 1, 2014)/1000*(SELECT S_OHROPR FROM smetasourcedata WH' +
        'ERE SM_ID=:ID_ACT)+'
      
        '        FN_getParamValue('#39'K_SUM1000_TO_TRUD_VREM'#39', 1, 2014)/1000' +
        '*(SELECT 0 FROM smetasourcedata WHERE SM_ID=:ID_ACT)+0.035/1000*'
      
        '        FN_getParamValue('#39'K_SUM1000_TO_TRUD_ZIM'#39', 1, 2014)*0)/8)' +
        '/FN_getParamValue('#39'COUNT_WORK_DAY_IN_MONTH'#39', 1, 2014)*FN_getPara' +
        'mValue('#39'CUNT_DAY_IN_MONTH'#39', 1, 2014))+ (0*00*00000/FN_getParamVa' +
        'lue('#39'COUNT_WORK_DAY_IN_MONTH'#39', 1, 2014)*2)+'
      
        '(:STOIM_KM*:KM*((141+19+FN_getParamValue('#39'K_SUM1000_TO_TRUD_OBHO' +
        'Z'#39', 1, 2014)/1000*(SELECT S_OHROPR FROM smetasourcedata WHERE SM' +
        '_ID=:ID_ACT)+'
      
        '        FN_getParamValue('#39'K_SUM1000_TO_TRUD_VREM'#39', 1, 2014)/1000' +
        '*(SELECT 0 FROM smetasourcedata WHERE SM_ID=:ID_ACT)+0.035/1000*'
      
        '        FN_getParamValue('#39'K_SUM1000_TO_TRUD_ZIM'#39', 1, 2014)*0)/8)' +
        '/FN_getParamValue('#39'COUNT_WORK_DAY_IN_MONTH'#39', 1, 2014)*2)) AS TOT' +
        'AL')
    Left = 35
    Top = 94
    ParamData = <
      item
        Name = 'STOIM_KM'
        DataType = ftInteger
        ParamType = ptInput
        Value = 0
      end
      item
        Name = 'KM'
        DataType = ftInteger
        ParamType = ptInput
        Value = 0
      end
      item
        Name = 'ID_ACT'
        DataType = ftInteger
        ParamType = ptInput
        Value = 310
      end>
  end
end
