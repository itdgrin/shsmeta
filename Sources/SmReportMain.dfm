object fSmReportMain: TfSmReportMain
  Left = 0
  Top = 0
  ActiveControl = grReport
  Caption = #1055#1077#1095#1072#1090#1100' '#1086#1090#1095#1077#1090#1086#1074
  ClientHeight = 282
  ClientWidth = 384
  Color = clBtnFace
  Constraints.MinHeight = 320
  Constraints.MinWidth = 400
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
  object splCategory: TSplitter
    Left = 0
    Top = 80
    Width = 384
    Height = 3
    Cursor = crVSplit
    Align = alTop
    ExplicitLeft = -24
    ExplicitTop = 175
    ExplicitWidth = 716
  end
  object splReport: TSplitter
    Left = 0
    Top = 163
    Width = 384
    Height = 3
    Cursor = crVSplit
    Align = alTop
    ExplicitTop = 341
    ExplicitWidth = 261
  end
  object lblParams: TLabel
    AlignWithMargins = True
    Left = 3
    Top = 169
    Width = 378
    Height = 13
    Align = alTop
    Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1086#1090#1095#1077#1090#1072':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ExplicitWidth = 100
  end
  object pnlCategory: TPanel
    Left = 0
    Top = 0
    Width = 384
    Height = 80
    Align = alTop
    BevelOuter = bvNone
    Constraints.MinHeight = 80
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object lblCategory: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 378
      Height = 13
      Align = alTop
      Caption = #1057#1087#1080#1089#1086#1082' '#1088#1072#1079#1076#1077#1083#1086#1074':'
      ExplicitWidth = 91
    end
    object tvCategory: TJvDBTreeView
      Left = 0
      Top = 19
      Width = 384
      Height = 61
      DataSource = dsTreeCategory
      MasterField = 'REPORT_CATEGORY_ID'
      DetailField = 'PARENT_ID'
      ItemField = 'LABEL'
      StartMasterValue = '0'
      UseFilter = True
      PersistentNode = True
      ReadOnly = True
      DragMode = dmAutomatic
      HideSelection = False
      Indent = 19
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      TabOrder = 0
      PopupMenu = pmCategory
      ParentFont = False
      RowSelect = True
      Mirror = False
    end
  end
  object pnlReport: TPanel
    Left = 0
    Top = 83
    Width = 384
    Height = 80
    Align = alTop
    BevelOuter = bvNone
    Constraints.MinHeight = 80
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object lblReport: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 378
      Height = 13
      Align = alTop
      Caption = #1057#1087#1080#1089#1086#1082' '#1086#1090#1095#1077#1090#1086#1074':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ExplicitWidth = 85
    end
    object grReport: TJvDBGrid
      Left = 0
      Top = 19
      Width = 384
      Height = 61
      Align = alClient
      DataSource = dsReport
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      ParentFont = False
      PopupMenu = pmReport
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      ScrollBars = ssVertical
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
          FieldName = 'REPORT_CODE'
          Title.Alignment = taCenter
          Title.Caption = #1050#1086#1076
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'REPORT_NAME'
          Title.Alignment = taCenter
          Title.Caption = #1053#1072#1079#1074#1072#1085#1080#1077
          Width = 367
          Visible = True
        end>
    end
  end
  object pnlBott: TPanel
    Left = 0
    Top = 251
    Width = 384
    Height = 31
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    object btnPreview: TBitBtn
      Left = 3
      Top = 3
      Width = 118
      Height = 25
      Caption = #1055#1077#1095#1072#1090#1100' '#1086#1090#1095#1077#1090#1072
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = btnPreviewClick
    end
  end
  object sbParams: TScrollBox
    Left = 0
    Top = 185
    Width = 384
    Height = 66
    HorzScrollBar.Visible = False
    Align = alClient
    BorderStyle = bsNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object dsTreeCategory: TDataSource
    DataSet = qrTreeCategory
    Left = 30
    Top = 50
  end
  object qrTreeCategory: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FetchOptions.AssignedValues = [evCache]
    FetchOptions.Cache = [fiBlobs, fiMeta]
    UpdateOptions.UpdateTableName = 'smeta.report_category'
    SQL.Strings = (
      'SELECT report_category.*, '
      
        'CONCAT(REPORT_CATEGORY_NAME, " (", (SELECT COUNT(*) FROM REPORT ' +
        'WHERE DELETED = 0 AND REPORT.TREE_PATH LIKE CONCAT(report_catego' +
        'ry.TREE_PATH, "%")), ")") AS LABEL'
      'FROM report_category'
      'ORDER BY REPORT_CATEGORY_NAME')
    Left = 30
    Top = 2
  end
  object FormStorage: TJvFormStorage
    AppStorage = FormMain.AppIni
    AppStoragePath = '%FORM_NAME%\'
    Options = [fpSize]
    StoredProps.Strings = (
      'pnlCategory.Height'
      'pnlReport.Height')
    StoredValues = <>
    Left = 168
    Top = 26
  end
  object pmCategory: TPopupMenu
    Images = DM.ilIcons_16x16
    OnPopup = pmCategoryPopup
    Left = 96
    Top = 32
    object mCategoryAdd: TMenuItem
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1088#1072#1079#1076#1077#1083
      ImageIndex = 41
      OnClick = mCategoryAddClick
    end
    object mCategoryAddSub: TMenuItem
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1087#1086#1076#1088#1072#1079#1076#1077#1083
      ImageIndex = 42
      OnClick = mCategoryAddSubClick
    end
    object mCategoryEditName: TMenuItem
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1085#1072#1079#1074#1072#1085#1080#1077
      ImageIndex = 44
      OnClick = mCategoryEditNameClick
    end
    object mCategoryDel: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100
      ImageIndex = 38
      OnClick = mCategoryDelClick
    end
  end
  object qrReport: TFDQuery
    AfterOpen = qrReportAfterScroll
    AfterScroll = qrReportAfterScroll
    MasterSource = dsTreeCategory
    MasterFields = 'TREE_PATH'
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FetchOptions.AssignedValues = [evCache]
    FetchOptions.Cache = [fiBlobs, fiMeta]
    UpdateOptions.UpdateTableName = 'smeta.report'
    SQL.Strings = (
      'SELECT *'
      'FROM report'
      'WHERE TREE_PATH LIKE CONCAT(:TREE_PATH, "%")'
      '  AND ((DELETED = 0) OR (:SHOW_DELETED))'
      'ORDER BY REPORT_NAME')
    Left = 30
    Top = 98
    ParamData = <
      item
        Name = 'TREE_PATH'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'SHOW_DELETED'
        DataType = ftInteger
        ParamType = ptInput
        Value = 0
      end>
  end
  object dsReport: TDataSource
    DataSet = qrReport
    Left = 30
    Top = 146
  end
  object pmReport: TPopupMenu
    Images = DM.ilIcons_16x16
    OnPopup = pmReportPopup
    Left = 96
    Top = 124
    object mReportAdd: TMenuItem
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      ImageIndex = 39
      OnClick = mReportAddClick
    end
    object mReportCopy: TMenuItem
      Caption = #1057#1086#1079#1076#1072#1090#1100' '#1082#1086#1087#1080#1102
      Enabled = False
      ImageIndex = 35
      OnClick = mReportCopyClick
    end
    object mReportEdit: TMenuItem
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1096#1072#1073#1083#1086#1085
      Enabled = False
      ImageIndex = 45
      OnClick = mReportEditClick
    end
    object mReportEditParams: TMenuItem
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1074#1093#1086#1076#1085#1099#1093' '#1087#1072#1088#1072#1084#1077#1090#1088#1086#1074
      ImageIndex = 15
      OnClick = mReportEditParamsClick
    end
    object mReportDel: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100
      ImageIndex = 38
      OnClick = mReportDelClick
    end
  end
  object frxReport: TfrxReport
    Version = '4.13.2'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42385.845885347200000000
    ReportOptions.LastChange = 42392.018654502300000000
    ScriptLanguage = 'PascalScript'
    StoreInDFM = False
    Left = 224
    Top = 27
  end
  object frxDS: TfrxDBDataset
    UserName = 'DS'
    CloseDataSource = True
    OpenDataSource = False
    BCDToCurrency = False
    Left = 264
    Top = 27
  end
  object frxPDF: TfrxPDFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    PrintOptimized = False
    Outline = False
    Background = False
    HTMLTags = True
    Quality = 95
    Author = 'FastReport'
    Subject = 'FastReport PDF export'
    ProtectionFlags = [ePrint, eModify, eCopy, eAnnot]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = False
    PrintScaling = False
    Left = 296
    Top = 27
  end
  object frxRTF: TfrxRTFExport
    FileName = 'C:\Users\R654\Desktop\rst_foreman.rtf'
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    CreationTime = 42387.894452951390000000
    DataOnly = False
    PictureType = gpPNG
    OpenAfterExport = True
    Wysiwyg = True
    Creator = 'FastReport'
    SuppressPageHeadersFooters = False
    HeaderFooterMode = hfText
    AutoSize = False
    Left = 328
    Top = 27
  end
  object frxCSV: TfrxCSVExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    CreationTime = 42385.855946145840000000
    DataOnly = False
    Separator = ';'
    OEMCodepage = False
    NoSysSymbols = True
    ForcedQuotes = False
    Left = 360
    Top = 27
  end
  object qrReportData: TFDQuery
    BeforeOpen = qrReportDataBeforeOpen
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FetchOptions.AssignedValues = [evCache]
    FetchOptions.Cache = [fiBlobs, fiMeta]
    FormatOptions.AssignedValues = [fvSE2Null, fvDefaultParamDataType]
    FormatOptions.StrsEmpty2Null = True
    FormatOptions.DefaultParamDataType = ftVariant
    SQL.Strings = (
      'SELECT s.SM_ID, s.FOREMAN_ID, s.OBJ_ID, s.`TYPE_ACT`,'
      '  s.DATE,'
      '  s.NAME,'
      '  o.`FULL_NAME` AS OBJ_NAME,'
      '  o.`DATE_DOG`,'
      '  o.`NUM_DOG`,'
      
        '  CONCAT(IFNULL(cl.`NAME`, ""), " (", IFNULL(cl.`FULL_NAME`, "")' +
        ', ")")  AS CUST_NAME,'
      '  CONCAT('
      '    IFNULL(f.`foreman_first_name`, ""), " ", '
      '    IFNULL(f.`foreman_name`, ""), " ", '
      '    IFNULL(f.`foreman_second_name`, "")) AS FOREMAN_FULL,'
      '  IFNULL(:ORGANIZATION_NAME, "") AS ORGANIZATION_NAME,'
      
        '  ROUND( SUM(IFNULL(d.TOTAL_STOIM_SMRF, d.TOTAL_STOIM_SMR)), rs.' +
        'round_RATE) AS TOTAL_STOIM_SMR,'
      
        '  ROUND( SUM(IFNULL(d.OTHERF, d.OTHER)), rs.round_RATE) AS OTHER' +
        ','
      
        '  ROUND( SUM(IFNULL(d.TOTAL_STATF, d.TOTAL_STAT)), rs.round_RATE' +
        ') AS TOTAL_STAT,'
      
        '  ROUND( SUM(IFNULL(d.TOTAL_AND_DEBET_NALF, d.TOTAL_AND_DEBET_NA' +
        'L)), rs.round_RATE) AS TOTAL_AND_DEBET_NAL,'
      '  ROUND( SUM(IFNULL(d.NDSF, d.NDS)), rs.round_RATE) AS NDS,'
      
        '  ROUND( SUM(IFNULL(d.TOTAL_WORKF, d.TOTAL_WORK)), rs.round_RATE' +
        ') AS TOTAL_WORK,'
      '  ROUND( SUM(IFNULL(d.STOIMF, d.STOIM)), rs.round_RATE) AS STOIM'
      'FROM `round_setup` rs, smetasourcedata s'
      'LEFT JOIN summary_calculation d ON d.SM_ID IN'
      '  (SELECT SM_ID'
      '   FROM smetasourcedata '
      '   WHERE DELETED=0'
      '    ((smetasourcedata.SM_ID = s.SM_ID) OR'
      '           (smetasourcedata.PARENT_ID = s.SM_ID) OR '
      '           (smetasourcedata.PARENT_ID IN ('
      '             SELECT SM_ID'
      '             FROM smetasourcedata'
      '             WHERE PARENT_ID = s.SM_ID AND DELETED=0)))'
      '  )'
      'LEFT JOIN `objcards` o ON o.`OBJ_ID` = s.`OBJ_ID`'
      'LEFT JOIN `clients` cl ON cl.`CLIENT_ID` = o.`CUST_ID` '
      'LEFT JOIN `foreman` f ON f.`foreman_id` = s.`FOREMAN_ID`'
      'WHERE s.SM_TYPE=2'
      '  AND ((:OBJECT IS NULL) OR (s.OBJ_ID=:OBJECT))'
      
        '  AND ((:MONTH_YEAR IS NULL) OR (MONTH(s.DATE)=MONTH(:MONTH_YEAR' +
        ') AND YEAR(s.DATE)=YEAR(:MONTH_YEAR)))'
      '  AND ((:FOREMAN IS NULL) OR (s.`FOREMAN_ID` = :FOREMAN))'
      '  AND ((:TYPE_ACT IS NULL) OR (s.`TYPE_ACT_ID` = :TYPE_ACT))'
      '  AND ((:CUST IS NULL) OR (o.CUST_ID = :CUST))'
      '  AND s.DELETED = 0'
      '  AND s.FL_USE = 1'
      '  AND s.ACT = 1'
      'GROUP BY s.SM_ID '
      'ORDER BY s.FOREMAN_ID, s.OBJ_ID, s.`TYPE_ACT`, s.`DATE`')
    Left = 222
    Top = 130
    ParamData = <
      item
        Name = 'ORGANIZATION_NAME'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'OBJECT'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'MONTH_YEAR'
        DataType = ftDate
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'FOREMAN'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'TYPE_ACT'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'CUST'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object qrActMat: TFDQuery
    BeforeOpen = qrReportDataBeforeOpen
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FetchOptions.AssignedValues = [evCache]
    FetchOptions.Cache = [fiBlobs, fiMeta]
    FormatOptions.AssignedValues = [fvSE2Null, fvDefaultParamDataType]
    FormatOptions.StrsEmpty2Null = True
    FormatOptions.DefaultParamDataType = ftVariant
    SQL.Strings = (
      '/*'#1063#1072#1089#1090#1100' '#1087#1086#1076#1088#1103#1076#1095#1080#1082#1072'*/'
      'SELECT'
      '  1 AS GR_TYPE,'
      '  o.`FULL_NAME`,'
      '  IFNULL(:ORGANIZATION_NAME, "") AS ORGANIZATION_NAME,'
      '  IFNULL(:MOL_FIO, "") AS MOL_FIO,'
      '  IFNULL(:MOL_DOLJ, "") AS MOL_DOLJ,'
      '  IFNULL(:INJ_PTO, "") AS INJ_PTO,'
      '  sm_m.`DATE`,'
      '  MAT_CODE,MAT_NAME,'
      '  SUM(COALESCE(MAT_COUNT, 0)*MAT_PROC_PODR/100.0) AS CNT, '
      '  MAT_UNIT,'
      '  `materialcard`.DOC_DATE,'
      '  `materialcard`.DOC_NUM,'
      
        ' /* IF(sm.`NDS`=1, IF(FCOAST_NDS<>0, 1, 0), IF(FCOAST_NO_NDS<>0,' +
        ' 1, 0)) AS FCOAST,*/'
      
        '  IF(sm.`NDS`=1, IF(FCOAST_NDS<>0, FCOAST_NDS, COAST_NDS), IF(FC' +
        'OAST_NO_NDS<>0, FCOAST_NO_NDS, COAST_NO_NDS)) AS COAST_S,'
      
        '/*  SUM(ROUND(IF(sm.`NDS`=1, IF(FCOAST_NDS<>0, FCOAST_NDS, COAST' +
        '_NDS), IF(FCOAST_NO_NDS<>0, FCOAST_NO_NDS, COAST_NO_NDS))*COALES' +
        'CE(MAT_COUNT, 0))) AS PRICE,'
      
        '  SUM(IF(sm.`NDS`=1, IF(FTRANSP_NDS<>0, FTRANSP_NDS, TRANSP_NDS)' +
        ', IF(FTRANSP_NO_NDS<>0, FTRANSP_NO_NDS, TRANSP_NO_NDS))) AS TRAN' +
        'SP,*/'
      
        '  SUM(IFNULL(f.`CNT`*f.`PROC_PODR`/100.0, /*COALESCE(MAT_COUNT, ' +
        '0)*MAT_PROC_PODR/100.0*/0)) AS CNT_F,'
      
        '  IFNULL(f.`COAST`, IF(sm.`NDS`=1, IF(FCOAST_NDS<>0, FCOAST_NDS,' +
        ' COAST_NDS), IF(FCOAST_NO_NDS<>0, FCOAST_NO_NDS, COAST_NO_NDS)))' +
        ' AS COAST_F'
      'FROM `objcards` o'
      'INNER JOIN `smetasourcedata` sm_m ON sm_m.`OBJ_ID`=o.`OBJ_ID` '
      '  AND sm_m.`ACT` = 1 '
      '  AND sm_m.`SM_TYPE` = 2'
      '  AND sm_m.`DELETED` = 0'
      '  AND sm_m.`FL_USE` = 1'
      
        '  AND ((:MONTH_YEAR IS NULL) OR (MONTH(sm_m.`DATE`)=MONTH(:MONTH' +
        '_YEAR) AND YEAR(sm_m.`DATE`)=YEAR(:MONTH_YEAR)))'
      
        'INNER JOIN `smetasourcedata` sm ON (sm.`PARENT_ID` = sm_m.`SM_ID' +
        '`) OR (sm.`PARENT_ID` IN (SELECT SM_ID FROM `smetasourcedata` WH' +
        'ERE PARENT_ID=sm_m.SM_ID))'
      '  AND sm.`ACT` = 1 '
      '  AND sm.`DELETED` = 0'
      '  AND sm.`FL_USE` = 1'
      'INNER JOIN `materialcard` ON `materialcard`.`SM_ID`=sm.`SM_ID` '
      '  AND `materialcard`.`DELETED` = 0 '
      '  AND `materialcard`.MAT_PROC_PODR > 0'
      '  AND `materialcard`.`CONSIDERED` = 1'
      'LEFT JOIN fact_data f ON (f.DELETED = 0) '
      '  AND f.ID_TYPE_DATA = 2 '
      '  AND f.ID_ACT = sm_m.`SM_ID` '
      '  AND f.ID_TABLES = `materialcard`.`ID` '
      '  AND f.ID_TABLES is not null  '
      'WHERE o.`OBJ_ID`=:OBJECT'
      
        'GROUP BY o.`FULL_NAME`, sm_m.`DATE`, MAT_CODE, MAT_NAME, MAT_UNI' +
        'T, DOC_DATE, DOC_NUM, COAST_S, MAT_ID, SRC_OBJECT_ID'
      ''
      'UNION ALL'
      ''
      'SELECT'
      '  1 AS GR_TYPE,'
      '  o.`FULL_NAME`,'
      '  IFNULL(:ORGANIZATION_NAME, "") AS ORGANIZATION_NAME,'
      '  IFNULL(:MOL_FIO, "") AS MOL_FIO,'
      '  IFNULL(:MOL_DOLJ, "") AS MOL_DOLJ,'
      '  IFNULL(:INJ_PTO, "") AS INJ_PTO,'
      '  sm_m.`DATE`,'
      '  f.`CODE` AS MAT_CODE, f.`NAME` AS MAT_NAME,'
      '  NULL AS CNT, '
      '  f.`UNIT`,'
      '  f.`DOC_DATE`,'
      '  f.`DOC_NUM`,'
      '  NULL AS COAST_S,'
      '  SUM(IFNULL(f.`CNT`*f.`PROC_PODR`/100.0, 0)) AS CNT_F,'
      '  IFNULL(f.`COAST`, 0) AS COAST_F'
      'FROM `objcards` o'
      'INNER JOIN `smetasourcedata` sm_m ON sm_m.`OBJ_ID`=o.`OBJ_ID` '
      '  AND sm_m.`ACT` = 1 '
      '  AND sm_m.`SM_TYPE` = 2'
      '  AND sm_m.`DELETED` = 0'
      '  AND sm_m.`FL_USE` = 1'
      
        '  AND ((:MONTH_YEAR IS NULL) OR (MONTH(sm_m.`DATE`)=MONTH(:MONTH' +
        '_YEAR) AND YEAR(sm_m.`DATE`)=YEAR(:MONTH_YEAR)))'
      'INNER JOIN fact_data f ON (f.DELETED = 0) '
      '  AND f.ID_TYPE_DATA = 2 '
      '  AND f.ID_ACT = sm_m.`SM_ID` '
      '  AND f.ID_TABLES is null '
      '  AND f.`PROC_PODR` > 0 '
      'WHERE o.`OBJ_ID`=:OBJECT'
      
        'GROUP BY o.`FULL_NAME`, sm_m.`DATE`, MAT_CODE, MAT_NAME, UNIT, D' +
        'OC_DATE, DOC_NUM, COAST_S, COAST_F, SRC_OBJECT_ID'
      ''
      '/*'#1063#1072#1089#1090#1100' '#1079#1072#1082#1072#1079#1095#1080#1082#1072'*/'
      'UNION ALL'
      'SELECT'
      '  2 AS GR_TYPE,  '
      '  o.`FULL_NAME`,'
      '  IFNULL(:ORGANIZATION_NAME, "") AS ORGANIZATION_NAME,'
      '  IFNULL(:MOL_FIO, "") AS MOL_FIO,'
      '  IFNULL(:MOL_DOLJ, "") AS MOL_DOLJ,'
      '  IFNULL(:INJ_PTO, "") AS INJ_PTO,'
      '  sm_m.`DATE`,'
      '  MAT_CODE,MAT_NAME,'
      '  SUM(COALESCE(MAT_COUNT, 0)*MAT_PROC_ZAC/100.0) AS CNT, '
      '  MAT_UNIT,'
      '  `materialcard`.DOC_DATE,'
      '  `materialcard`.DOC_NUM,'
      
        '/*  IF(sm.`NDS`=1, IF(FCOAST_NDS<>0, 1, 0), IF(FCOAST_NO_NDS<>0,' +
        ' 1, 0)) AS FCOAST,*/'
      
        '  IF(sm.`NDS`=1, IF(FCOAST_NDS<>0, FCOAST_NDS, COAST_NDS), IF(FC' +
        'OAST_NO_NDS<>0, FCOAST_NO_NDS, COAST_NO_NDS)) AS COAST_S,'
      
        '/*  SUM(ROUND(IF(sm.`NDS`=1, IF(FCOAST_NDS<>0, FCOAST_NDS, COAST' +
        '_NDS), IF(FCOAST_NO_NDS<>0, FCOAST_NO_NDS, COAST_NO_NDS))*COALES' +
        'CE(MAT_COUNT, 0))) AS PRICE,'
      
        '  SUM(IF(sm.`NDS`=1, IF(FTRANSP_NDS<>0, FTRANSP_NDS, TRANSP_NDS)' +
        ', IF(FTRANSP_NO_NDS<>0, FTRANSP_NO_NDS, TRANSP_NO_NDS))) AS TRAN' +
        'SP,*/'
      
        '  SUM(IFNULL(f.`CNT`*f.`PROC_ZAC`/100.0, /*COALESCE(MAT_COUNT, 0' +
        ')*MAT_PROC_ZAC/100.0*/0)) AS CNT_F,'
      
        '  IFNULL(f.`COAST`, IF(sm.`NDS`=1, IF(FCOAST_NDS<>0, FCOAST_NDS,' +
        ' COAST_NDS), IF(FCOAST_NO_NDS<>0, FCOAST_NO_NDS, COAST_NO_NDS)))' +
        ' AS COAST_F'
      'FROM `objcards` o'
      'INNER JOIN `smetasourcedata` sm_m ON sm_m.`OBJ_ID`=o.`OBJ_ID` '
      '  AND sm_m.`ACT` = 1 '
      '  AND sm_m.`SM_TYPE` = 2'
      '  AND sm_m.`DELETED` = 0'
      '  AND sm_m.`FL_USE` = 1'
      
        '  AND ((:MONTH_YEAR IS NULL) OR (MONTH(sm_m.`DATE`)=MONTH(:MONTH' +
        '_YEAR) AND YEAR(sm_m.`DATE`)=YEAR(:MONTH_YEAR)))'
      
        'INNER JOIN `smetasourcedata` sm ON (sm.`PARENT_ID` = sm_m.`SM_ID' +
        '`) OR (sm.`PARENT_ID` IN (SELECT SM_ID FROM `smetasourcedata` WH' +
        'ERE PARENT_ID=sm_m.SM_ID))'
      '  AND sm.`ACT` = 1 '
      '  AND sm.`DELETED` = 0'
      '  AND sm.`FL_USE` = 1'
      'INNER JOIN `materialcard` ON `materialcard`.`SM_ID`=sm.`SM_ID` '
      '  AND `materialcard`.`DELETED` = 0 '
      '  AND `materialcard`.MAT_PROC_ZAC > 0'
      '  AND `materialcard`.`CONSIDERED` = 1'
      'LEFT JOIN fact_data f ON (f.DELETED = 0) '
      '  AND f.ID_TYPE_DATA = 2 '
      '  AND f.ID_ACT = sm_m.`SM_ID` '
      '  AND f.ID_TABLES = `materialcard`.`ID` '
      '  AND f.ID_TABLES is not null   '
      'WHERE o.`OBJ_ID`=:OBJECT'
      
        'GROUP BY o.`FULL_NAME`, sm_m.`DATE`, MAT_CODE, MAT_NAME, MAT_UNI' +
        'T, DOC_DATE, DOC_NUM, COAST_S, MAT_ID, SRC_OBJECT_ID'
      ''
      'UNION ALL'
      ''
      'SELECT'
      '  2 AS GR_TYPE,'
      '  o.`FULL_NAME`,'
      '  IFNULL(:ORGANIZATION_NAME, "") AS ORGANIZATION_NAME,'
      '  IFNULL(:MOL_FIO, "") AS MOL_FIO,'
      '  IFNULL(:MOL_DOLJ, "") AS MOL_DOLJ,'
      '  IFNULL(:INJ_PTO, "") AS INJ_PTO,'
      '  sm_m.`DATE`,'
      '  f.`CODE` AS MAT_CODE, f.`NAME` AS MAT_NAME,'
      '  NULL AS CNT, '
      '  f.`UNIT`,'
      '  f.`DOC_DATE`,'
      '  f.`DOC_NUM`,'
      '  NULL AS COAST_S,'
      '  SUM(IFNULL(f.`CNT`*f.`PROC_ZAC`/100.0, 0)) AS CNT_F,'
      '  IFNULL(f.`COAST`, 0) AS COAST_F'
      'FROM `objcards` o'
      'INNER JOIN `smetasourcedata` sm_m ON sm_m.`OBJ_ID`=o.`OBJ_ID` '
      '  AND sm_m.`ACT` = 1 '
      '  AND sm_m.`SM_TYPE` = 2'
      '  AND sm_m.`DELETED` = 0'
      '  AND sm_m.`FL_USE` = 1'
      
        '  AND ((:MONTH_YEAR IS NULL) OR (MONTH(sm_m.`DATE`)=MONTH(:MONTH' +
        '_YEAR) AND YEAR(sm_m.`DATE`)=YEAR(:MONTH_YEAR)))'
      'INNER JOIN fact_data f ON (f.DELETED = 0) '
      '  AND f.ID_TYPE_DATA = 2 '
      '  AND f.ID_ACT = sm_m.`SM_ID` '
      '  AND f.ID_TABLES is null  '
      '  AND f.`PROC_ZAC` > 0'
      'WHERE o.`OBJ_ID`=:OBJECT'
      
        'GROUP BY o.`FULL_NAME`, sm_m.`DATE`, MAT_CODE, MAT_NAME, UNIT, D' +
        'OC_DATE, DOC_NUM, COAST_S, COAST_F, SRC_OBJECT_ID'
      'ORDER BY GR_TYPE, MAT_NAME')
    Left = 286
    Top = 130
    ParamData = <
      item
        Name = 'ORGANIZATION_NAME'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'MOL_FIO'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'MOL_DOLJ'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'INJ_PTO'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'MONTH_YEAR'
        DataType = ftDate
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'OBJECT'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
end
