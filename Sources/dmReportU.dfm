object dmReportF: TdmReportF
  OldCreateOrder = False
  Height = 689
  Width = 1069
  object frxZP_OBJ: TfrxDBDataset
    UserName = 'frxZP_OBJ'
    CloseDataSource = True
    FieldAliases.Strings = (
      'OBJECT_NAME=OBJECT_NAME'
      'LOCAL_NAME=LOCAL_NAME'
      'PTM_NAME=PTM_NAME'
      'RATE_CODE=RATE_CODE'
      'RATE_CAPTION=RATE_CAPTION'
      'RATE_UNIT=RATE_UNIT'
      'RATE_COUNT=RATE_COUNT'
      'TRUD_ED=TRUD_ED'
      'TRUD=TRUD'
      'NORMA=NORMA'
      'COEF=COEF'
      'K_TRUD=K_TRUD'
      'K_ZP=K_ZP'
      'ZP_ED=ZP_ED'
      'ZP=ZP')
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
    ReportOptions.LastChange = 42068.032230567130000000
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
      
        'select CONCAT(`ssd`.`SM_NUMBER`, " ", `ssd`.`NAME`) as `OBJECT_N' +
        'AME`,'
      
        '       CONCAT(`ssd1`.`SM_NUMBER`, " ", `ssd1`.`NAME`) as `LOCAL_' +
        'NAME`,'
      
        '       CONCAT(`ssd2`.`SM_NUMBER`, " ", `ssd2`.`NAME`) as `PTM_NA' +
        'ME`,'
      '       `cr`.`RATE_CODE`,'
      '       UCASE(`cr`.`RATE_CAPTION`) `RATE_CAPTION`,'
      '       `cr`.`RATE_UNIT`,'
      '       `cr`.`RATE_COUNT`,'
      
        '       `de`.`TRUD` / IF(IFNULL(`cr`.`RATE_COUNT`, 1) = 0, 1, IFN' +
        'ULL(`cr`.`RATE_COUNT`, 1)) `TRUD_ED`,'
      '       `de`.`TRUD`,'
      '       `nw`.`NORMA`,'
      
        '       IF(IFNULL(`c`.`COEF`, 0) = 0, "F", TRIM(TRAILING "0" FROM' +
        ' CONVERT(`c`.`COEF`, CHAR(8)))) `COEF`,'
      '       `de`.`K_TRUD`,'
      '       `de`.`K_ZP`,'
      
        '       `de`.`ZP` / IF(IFNULL(`cr`.`RATE_COUNT`, 1) = 0, 1, IFNUL' +
        'L(`cr`.`RATE_COUNT`, 1)) `ZP_ED`,'
      '       `de`.`ZP`'#9'   '
      'from `smetasourcedata` `ssd`'
      
        'inner join `smetasourcedata` `ssd1` on `ssd1`.`PARENT_ID` = `ssd' +
        '`.`SM_ID` '
      '                                   and `ssd1`.`SM_TYPE` = 1'
      
        'inner join `smetasourcedata` `ssd2` on `ssd2`.`PARENT_ID` = `ssd' +
        '1`.`SM_ID`'
      '                                   and `ssd2`.`SM_TYPE` = 3'
      
        'inner join `data_estimate` `de` on `de`.`ID_ESTIMATE` = `ssd2`.`' +
        'SM_ID`'
      '                               and `de`.`ID_TYPE_DATA` = 1'
      'inner join `card_rate` `cr` on `cr`.`ID` = `de`.`ID_TABLES`'
      
        'left join `normativwork` `nw` on `nw`.`NORMATIV_ID` = `cr`.`RATE' +
        '_ID`'
      '                             and `nw`.`WORK_ID` = 1'
      'left join `category` `c` on `c`.`VALUE` * 10 = `nw`.`NORMA` * 10'
      
        '                        and `c`.`DATE_BEG` <= CONVERT(CONCAT(:YE' +
        'AR, '#39'-'#39', :MONTH, '#39'-01'#39'), DATE)'
      'where `ssd`.`SM_ID` = :SM_ID'
      '  and `ssd`.`SM_TYPE` = 2  '
      'order by `OBJECT_NAME`, `LOCAL_NAME`, `PTM_NAME`, `RATE_CODE`')
    Left = 16
    Top = 112
    ParamData = <
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
      end
      item
        Name = 'SM_ID'
        DataType = ftString
        ParamType = ptInput
        Value = '344'
      end>
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
      'select `cra`.`RATE_ID`, '
      
        '       CONCAT(`ssd0`.`SM_NUMBER`, " ", `ssd0`.`NAME`) `OBJ_NAME`' +
        ', '
      
        '       CONCAT(`ssd1`.`SM_NUMBER`, " ", `ssd1`.`NAME`) `LOCAL_NAM' +
        'E`, '
      
        '       CONCAT(`ssd2`.`SM_NUMBER`, " ", `ssd2`.`NAME`) `PTM_NAME`' +
        ', '
      '       `cra`.`RATE_CODE`, '
      '       UCASE(`cra`.`RATE_CAPTION`) `RATE_CAPTION`, '
      '       `cra`.`RATE_UNIT`, '
      '       `cra`.`RATE_COUNT`, '
      '       `da`.`K_TRUD`, '
      '       IFNULL(`da`.`TRUD`, 0) `TRUD`, '
      '       `da`.`ZP`, '
      '       `da`.`K_ZP`, '
      '       `nw`.`NORMA`,'
      
        '       IF(IFNULL(`c`.`COEF`, 0) = 0, "F", TRIM(TRAILING "0" FROM' +
        ' CONVERT(`c`.`COEF`, CHAR(8)))) `COEF`,'
      
        '      `da`.`TRUD` / IF(IFNULL(`cra`.`RATE_COUNT`, 1) = 0, 1, IFN' +
        'ULL(`cra`.`RATE_COUNT`, 1)) `TRUD_ED`, '
      
        '      `da`.`ZP` / IF(IFNULL(`cra`.`RATE_COUNT`, 1) = 0, 1, IFNUL' +
        'L(`cra`.`RATE_COUNT`, 1)) `ZP_ED`'
      #9'   '
      'from `data_act` `da`'
      
        'inner join `card_rate_act` `cra` on `cra`.`ID` = `da`.`ID_TABLES' +
        '` '
      '                               and `cra`.`ID_ACT` = :ID_ACT'
      
        'inner join `smetasourcedata` `ssd2` on `ssd2`.`SM_ID` = `da`.`ID' +
        '_ESTIMATE`'
      '                                   and `ssd2`.`SM_TYPE` = 3'
      
        'inner join `smetasourcedata` `ssd1` on `ssd1`.`SM_ID` = `ssd2`.`' +
        'PARENT_ID`'
      '                                   and `ssd1`.`SM_TYPE` = 1'
      
        'inner join `smetasourcedata` `ssd0` on `ssd0`.`SM_ID` = `ssd1`.`' +
        'PARENT_ID`'
      '                                   and `ssd0`.`SM_TYPE` = 2'
      
        'left join `normativwork` `nw` on `nw`.`NORMATIV_ID` = `cra`.`RAT' +
        'E_ID`'
      '                 '#9#9'     and `nw`.`WORK_ID` = 1 '
      
        'left join `category` `c` on `c`.`VALUE` * 10 = `nw`.`NORMA` * 10' +
        ' '
      
        '                        and IFNULL(`c`.`DATE_BEG`, CONVERT('#39'1900' +
        '-01-01'#39', DATE)) <= CONVERT(CONCAT(:YEAR,'#39'-'#39',:MONTH,'#39'-01'#39'), DATE)' +
        '    '
      ''
      'where `da`.`ID_ACT` = :ID_ACT '
      '  and `da`.`ID_TYPE_DATA` = 1'
      'order by `OBJ_NAME`, `LOCAL_NAME`, `PTM_NAME`, `RATE_CODE`')
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
    Left = 984
    Top = 384
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
    Left = 984
    Top = 272
  end
  object frxRTFExport1: TfrxRTFExport
    FileName = 'test.rtf'
    UseFileCache = True
    DefaultPath = '..\Doc\'
    ShowProgress = True
    OverwritePrompt = True
    DataOnly = False
    PictureType = gpPNG
    ExportPageBreaks = False
    ExportPictures = False
    OpenAfterExport = True
    Wysiwyg = True
    Creator = 'FastReport'
    SuppressPageHeadersFooters = True
    HeaderFooterMode = hfText
    AutoSize = False
    Left = 984
    Top = 328
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
  object frxWRS_OBJ: TfrxDBDataset
    UserName = 'frxWRS_OBJ'
    CloseDataSource = True
    FieldAliases.Strings = (
      'zp_rab=zp_rab'
      'ZP_MASH=ZP_MASH'
      'KZP=KZP'
      'RATE_CODE=RATE_CODE'
      'RATE_CAPTION=RATE_CAPTION'
      'RATE_COUNT=RATE_COUNT'
      'RATE_UNIT=RATE_UNIT'
      'NAME1=NAME1'
      'v_rab=v_rab'
      'v_mash=v_mash')
    DataSet = qWRS_OBJ
    BCDToCurrency = False
    Left = 24
    Top = 240
  end
  object qWRS_OBJ: TFDQuery
    AutoCalcFields = False
    Connection = DM.Connect
    Transaction = trReportRead
    UpdateTransaction = trReportWrite
    SQL.Strings = (
      '')
    Left = 24
    Top = 288
  end
  object frxRSMO_OBJ: TfrxDBDataset
    UserName = 'frxRSMO_OBJ'
    CloseDataSource = True
    FieldAliases.Strings = (
      'mat_code=mat_code'
      'mat_name=mat_name'
      'mat_unit=mat_unit'
      'mat_count=mat_count'
      'coast_no_nds=coast_no_nds'
      'mat_sum_no_nds=mat_sum_no_nds'
      'proc_transp=proc_transp'
      'coast_transp=coast_transp'
      'nds=nds'
      'nds_rub=nds_rub'
      'transp_nds=transp_nds'
      'mat_sum_nds=mat_sum_nds')
    DataSet = qRSMO_OBJ
    BCDToCurrency = False
    Left = 104
    Top = 240
  end
  object qRSMO_OBJ: TFDQuery
    AutoCalcFields = False
    Connection = DM.Connect
    Transaction = trReportRead
    UpdateTransaction = trReportWrite
    Left = 104
    Top = 288
  end
  object qRSMEH_OBJ: TFDQuery
    AutoCalcFields = False
    Connection = DM.Connect
    Transaction = trReportRead
    UpdateTransaction = trReportWrite
    Left = 200
    Top = 288
  end
  object frxRSMEH_OBJ: TfrxDBDataset
    UserName = 'frxRSMEH_OBJ'
    CloseDataSource = True
    FieldAliases.Strings = (
      'mech_code=mech_code'
      'mech_name=mech_name'
      'mech_unit=mech_unit'
      'mech_count=mech_count'
      'coast_no_nds=coast_no_nds'
      'sum_no_nds=sum_no_nds'
      'zp_sum_no_nds=zp_sum_no_nds'
      'nds=nds'
      'zp_mach_no_nds=zp_mach_no_nds'
      'nds_rub=nds_rub'
      'sum_nds=sum_nds')
    DataSet = qRSMEH_OBJ
    BCDToCurrency = False
    Left = 200
    Top = 240
  end
end
