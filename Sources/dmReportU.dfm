object dmReportF: TdmReportF
  OldCreateOrder = False
  Height = 677
  Width = 1052
  object frxZP_OBJ: TfrxDBDataset
    UserName = 'frxZP_OBJ'
    CloseDataSource = True
    FieldAliases.Strings = (
      'OUT_npp=OUT_npp'
      'OUT_sm_vid=OUT_sm_vid'
      'OUT_sm_name=OUT_sm_name'
      'OUT_rate_code=OUT_rate_code'
      'OUT_rate_caption=OUT_rate_caption'
      'OUT_rate_unit=OUT_rate_unit'
      'OUT_trud_ed=OUT_trud_ed'
      'OUT_norma=OUT_norma'
      'OUT_k_trud=OUT_k_trud'
      'OUT_zp_ed=OUT_zp_ed'
      'OUT_rate_count=OUT_rate_count'
      'OUT_trud=OUT_trud'
      'OUT_coef=OUT_coef'
      'OUT_k_zp=OUT_k_zp'
      'OUT_zp=OUT_zp'
      'OUT_name_o=OUT_name_o'
      'OUT_name_l=OUT_name_l'
      'OUT_name_p=OUT_name_p')
    DataSet = qrZP_OBJ
    BCDToCurrency = False
    Left = 16
    Top = 56
  end
  object frxReport: TfrxReport
    Version = '4.13.2'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42048.002529965300000000
    ReportOptions.LastChange = 42061.086144398150000000
    ScriptLanguage = 'PascalScript'
    StoreInDFM = False
    Left = 16
    Top = 8
  end
  object qrZP_OBJ: TFDQuery
    AutoCalcFields = False
    Connection = DM.Connect
    Transaction = trReportRead
    UpdateTransaction = trReportWrite
    SQL.Strings = (
      'call smeta.Report_ZP_OBJ(315, 5, 2014)')
    Left = 16
    Top = 112
  end
  object trReportRead: TFDTransaction
    Options.ReadOnly = True
    Options.StopOptions = [xoIfCmdsInactive, xoIfAutoStarted, xoFinishRetaining]
    Connection = DM.Connect
    Left = 920
    Top = 16
  end
  object trReportWrite: TFDTransaction
    Options.ReadOnly = True
    Options.StopOptions = [xoIfCmdsInactive, xoIfAutoStarted, xoFinishRetaining]
    Connection = DM.Connect
    Left = 992
    Top = 16
  end
  object qrTMP: TFDQuery
    Connection = DM.Connect
    Transaction = trReportRead
    UpdateTransaction = trReportWrite
    Left = 992
    Top = 72
  end
  object frxZP_OBJ_ACT: TfrxDBDataset
    UserName = 'frxZP_OBJ_ACT'
    CloseDataSource = True
    FieldAliases.Strings = (
      'RATE_ID=RATE_ID'
      'OBJ_NAME=OBJ_NAME'
      'LOCAL_NAME=LOCAL_NAME'
      'PTM_NAME=PTM_NAME'
      'RATE_CODE=RATE_CODE'
      'RATE_CAPTION=RATE_CAPTION'
      'RATE_UNIT=RATE_UNIT'
      'RATE_COUNT=RATE_COUNT'
      'K_TRUD=K_TRUD'
      'TRUD=TRUD'
      'ZP=ZP'
      'K_ZP=K_ZP'
      'NORMA=NORMA'
      'COEF=COEF'
      'TRUD_ED=TRUD_ED'
      'ZP_ED=ZP_ED')
    DataSet = qrZP_OBJ_ACT
    BCDToCurrency = False
    Left = 88
    Top = 56
  end
  object qrZP_OBJ_ACT: TFDQuery
    AutoCalcFields = False
    Connection = DM.Connect
    Transaction = trReportRead
    UpdateTransaction = trReportWrite
    SQL.Strings = (
      
        'select cra.`RATE_ID`, ssd0.`NAME` as OBJ_NAME, ssd1.`NAME` as LO' +
        'CAL_NAME, ssd2.`NAME` as PTM_NAME, '
      
        '       cra.`RATE_CODE`, UCASE(cra.`RATE_CAPTION`) as RATE_CAPTIO' +
        'N, cra.`RATE_UNIT`, cra.`RATE_COUNT`, '
      
        #9'   da.`K_TRUD`, IFNULL(da.`TRUD`, 0) as TRUD, da.`ZP`, da.`K_ZP' +
        '`, nw.`NORMA`,'
      
        #9'   CAST(IF(IFNULL(c.`COEF`, 0) = 0, "F", TRIM(TRAILING '#39'0'#39' FROM' +
        ' c.`COEF`)) as CHAR(10)) as COEF,'
      
        #9'   da.`TRUD` / IF(IFNULL(cra.`RATE_COUNT`, 1) = 0, 1, IFNULL(cr' +
        'a.`RATE_COUNT`, 1)) as TRUD_ED, '
      
        #9'   da.`ZP` / IF(IFNULL(cra.`RATE_COUNT`, 1) = 0, 1, IFNULL(cra.' +
        '`RATE_COUNT`, 1)) as ZP_ED'
      #9'   '
      'from `data_act` as da'
      ''
      'left join `card_rate_act` as cra on cra.`ID` = da.`ID_TABLES` '
      '                                and cra.`ID_ACT` = :ID_ACT'
      
        'left join `smetasourcedata` as ssd2 on ssd2.`SM_ID` = da.`ID_EST' +
        'IMATE`'
      
        'left join `smetasourcedata` as ssd1 on ssd1.`SM_ID` = ssd2.`PARE' +
        'NT_PTM_ID`'
      
        'left join `smetasourcedata` as ssd0 on ssd0.`SM_ID` = ssd1.`PARE' +
        'NT_LOCAL_ID`'
      
        'left join `normativwork` as nw on nw.`NORMATIV_ID` = cra.`RATE_I' +
        'D`'
      '         '#9#9'      and nw.`WORK_ID` = 1 '
      'left join `category` as c on c.`VALUE` * 10 = nw.`NORMA` * 10 '
      
        '                         AND IFNULL(c.`DATE_BEG`, CONVERT('#39'1900-' +
        '01-01'#39', DATE)) <= CONVERT(CONCAT(:YEAR,'#39'-'#39',:MONTH,'#39'-01'#39'), DATE) ' +
        '   '
      ''
      'where da.`ID_ACT` = :ID_ACT and da.`ID_TYPE_DATA` = 1'
      'order by OBJ_NAME, LOCAL_NAME, PTM_NAME, RATE_CAPTION')
    Left = 88
    Top = 112
    ParamData = <
      item
        Name = 'ID_ACT'
        DataType = ftString
        ParamType = ptInput
        Value = '10'
      end
      item
        Name = 'YEAR'
        DataType = ftString
        ParamType = ptInput
        Value = '2014'
      end
      item
        Name = 'MONTH'
        DataType = ftString
        ParamType = ptInput
        Value = '4'
      end>
  end
  object qrRASX_MAT: TFDQuery
    AutoCalcFields = False
    Connection = DM.Connect
    Transaction = trReportRead
    UpdateTransaction = trReportWrite
    SQL.Strings = (
      
        'select mca.`MAT_CODE`, UCASE(mca.`MAT_NAME`) as MAT_NAME, mca.`M' +
        'AT_UNIT`, mca.`MAT_NORMA`,'
      
        #9'   cra.`RATE_CODE`, UCASE(cra.`RATE_CAPTION`) as RATE_CAPTION, ' +
        'cra.`RATE_UNIT`, cra.`RATE_COUNT`,'
      
        #9'   cra.`COEF_ORDERS`, IFNULL(mca.`MAT_NORMA`, 0) * IFNULL(cra.`' +
        'RATE_COUNT`, 0) as VAL, '
      #9'   CONCAT(ssd.`SM_NUMBER`, " ", ssd.`NAME`) as PTM_NAME,'
      #9'   CONCAT(ssd1.`SM_NUMBER`, " ", ssd1.`NAME`) as LOCAL_NAME,'
      ' '#9'   CONCAT(ssd2.`SM_NUMBER`, " ", ssd2.`NAME`) as OBJECT_NAME, '
      '           1 as TAB'
      'from `materialcard_act` mca'
      ''
      'left join `card_rate_act` cra on cra.`ID_ACT` = mca.`ID_ACT`'
      'left join `data_estimate` da on da.`ID_TABLES` = cra.`ID`'
      
        'left join `smetasourcedata` ssd on ssd.`SM_ID` = da.`ID_ESTIMATE' +
        '`'
      
        'left join `smetasourcedata` ssd1 on ssd1.`SM_ID` = ssd.`PARENT_P' +
        'TM_ID`'
      
        'left join `smetasourcedata` ssd2 on ssd2.`SM_ID` = ssd1.`PARENT_' +
        'LOCAL_ID`'
      ''
      'where mca.`ID_ACT` = :ID_ACT'
      '  and mca.`CONSIDERED` = 1'
      'ORDER BY LOCAL_NAME, RATE_CODE, MAT_CODE')
    Left = 176
    Top = 112
    ParamData = <
      item
        Name = 'ID_ACT'
        DataType = ftString
        ParamType = ptInput
        Value = '10'
      end>
  end
  object frxRASX_MAT: TfrxDBDataset
    UserName = 'frxRASX_MAT'
    CloseDataSource = True
    FieldAliases.Strings = (
      'MAT_CODE=MAT_CODE'
      'MAT_NAME=MAT_NAME'
      'MAT_UNIT=MAT_UNIT'
      'MAT_NORMA=MAT_NORMA'
      'RATE_CODE=RATE_CODE'
      'RATE_CAPTION=RATE_CAPTION'
      'RATE_UNIT=RATE_UNIT'
      'RATE_COUNT=RATE_COUNT'
      'COEF_ORDERS=COEF_ORDERS'
      'VAL=VAL'
      'PTM_NAME=PTM_NAME'
      'LOCAL_NAME=LOCAL_NAME'
      'OBJECT_NAME=OBJECT_NAME'
      'TAB=TAB')
    DataSet = qrRASX_MAT
    BCDToCurrency = False
    Left = 176
    Top = 56
  end
  object qrRASX_MAT2: TFDQuery
    AutoCalcFields = False
    Connection = DM.Connect
    Transaction = trReportRead
    UpdateTransaction = trReportWrite
    SQL.Strings = (
      
        'select mca.`MAT_CODE`, UCASE(mca.`MAT_NAME`) as MAT_NAME, mca.`M' +
        'AT_UNIT`, mca.`MAT_NORMA`,'
      #9'   cra.`RATE_COUNT`,'
      
        #9'   cra.`COEF_ORDERS`, IFNULL(mca.`MAT_NORMA`, 0) * IFNULL(cra.`' +
        'RATE_COUNT`, 0) as VAL,'
      #9'   mca.`COAST_NDS`, 2 as TAB'
      'from `materialcard_act` mca'
      'left join `card_rate_act` cra on cra.`ID_ACT` = mca.`ID_ACT`'
      'where mca.`ID_ACT` = :ID_ACT'
      '  and mca.`CONSIDERED` = 0'
      'order by MAT_CODE')
    Left = 248
    Top = 112
    ParamData = <
      item
        Name = 'ID_ACT'
        DataType = ftString
        ParamType = ptInput
        Value = '10'
      end>
  end
  object frxRASX_MAT2: TfrxDBDataset
    UserName = 'frxRASX_MAT2'
    CloseDataSource = True
    FieldAliases.Strings = (
      'MAT_CODE=MAT_CODE'
      'MAT_NAME=MAT_NAME'
      'MAT_UNIT=MAT_UNIT'
      'MAT_NORMA=MAT_NORMA'
      'RATE_COUNT=RATE_COUNT'
      'COEF_ORDERS=COEF_ORDERS'
      'VAL=VAL'
      'COAST_NDS=COAST_NDS'
      'TAB=TAB')
    DataSet = qrRASX_MAT2
    BCDToCurrency = False
    Left = 248
    Top = 56
  end
  object frxPDFExport1: TfrxPDFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    OpenAfterExport = True
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
    CenterWindow = True
    PrintScaling = False
    Left = 920
    Top = 160
  end
  object frxHTMLExport1: TfrxHTMLExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    FixedWidth = True
    Background = False
    Centered = False
    EmptyLines = True
    Print = False
    PictureType = gpPNG
    Left = 840
    Top = 160
  end
  object frxRTFExport1: TfrxRTFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = True
    DataOnly = False
    PictureType = gpPNG
    OpenAfterExport = True
    Wysiwyg = True
    Creator = 'FastReport'
    SuppressPageHeadersFooters = True
    HeaderFooterMode = hfPrint
    AutoSize = False
    Left = 992
    Top = 160
  end
  object frxSimpleTextExport1: TfrxSimpleTextExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    Frames = False
    EmptyLines = False
    OEMCodepage = False
    DeleteEmptyColumns = True
    Left = 984
    Top = 216
  end
end
