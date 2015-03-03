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
    ReportOptions.LastChange = 42066.940764317130000000
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
    Left = 56
    Top = 208
  end
  object qWRS_OBJ: TFDQuery
    AutoCalcFields = False
    Connection = DM.Connect
    Transaction = trReportRead
    UpdateTransaction = trReportWrite
    SQL.Strings = (
      '')
    Left = 56
    Top = 264
  end
  object frxReport1: TfrxReport
    Version = '4.13.2'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42066.384048414400000000
    ReportOptions.LastChange = 42067.035363402780000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 384
    Top = 384
    Datasets = <
      item
        DataSet = frxWRS_OBJ
        DataSetName = 'frxWRS_OBJ'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object PageHeader1: TfrxPageHeader
        Height = 188.976500000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object Memo17: TfrxMemoView
          Top = 173.858380000000000000
          Width = 28.346456690000000000
          Height = 15.118110240000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '1')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo18: TfrxMemoView
          Left = 28.236240000000000000
          Top = 173.858380000000000000
          Width = 28.346456690000000000
          Height = 15.118110240000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '2')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo19: TfrxMemoView
          Left = 56.692950000000000000
          Top = 173.858380000000000000
          Width = 249.448980000000000000
          Height = 15.118110240000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '3')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo20: TfrxMemoView
          Left = 306.141930000000000000
          Top = 173.858380000000000000
          Width = 47.244094490000000000
          Height = 15.118110240000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '4')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo21: TfrxMemoView
          Left = 353.496290000000000000
          Top = 173.858380000000000000
          Width = 47.244094490000000000
          Height = 15.118110240000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '5')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo22: TfrxMemoView
          Left = 400.629923700000000000
          Top = 173.858380000000000000
          Width = 47.244094490000000000
          Height = 15.118110240000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '6')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo23: TfrxMemoView
          Left = 447.874018190000000000
          Top = 173.858380000000000000
          Width = 47.244094490000000000
          Height = 15.118110240000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '7')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo24: TfrxMemoView
          Left = 495.118112680000000000
          Top = 173.858380000000000000
          Width = 47.244094490000000000
          Height = 15.118110240000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '8')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo25: TfrxMemoView
          Left = 542.362207170000000000
          Top = 173.858380000000000000
          Width = 47.244094490000000000
          Height = 15.118110240000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '9')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo26: TfrxMemoView
          Left = 589.606301650000000000
          Top = 173.858380000000000000
          Width = 47.244094490000000000
          Height = 15.118110240000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '10')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo27: TfrxMemoView
          Left = 636.961040000000000000
          Top = 173.858380000000000000
          Width = 47.244094490000000000
          Height = 15.118110240000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '11')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo1: TfrxMemoView
          Left = 215.433210000000000000
          Width = 279.685220000000000000
          Height = 45.354360000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            #1056#1040#1057#1063#1045#1058' '
            #1089#1090#1086#1080#1084#1086#1089#1090#1080' '#1079#1080#1084#1085#1080#1093' '#1091#1076#1086#1088#1086#1078#1072#1085#1080#1081' ')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 139.842610000000000000
          Top = 45.354360000000000000
          Width = 404.409710000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            #1082' '#1040#1050#1058#1059' '#1057#1044#1040#1063#1048'-'#1055#1056#1048#1045#1052#1050#1048' '#1042#1067#1055#1054#1051#1053#1045#1053#1053#1067#1061' '#1056#1040#1041#1054#1058' '#8470'  '#1079#1072' ')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Top = 98.267780000000000000
          Width = 28.346456690000000000
          Height = 75.590600000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            #1087#1087)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo3: TfrxMemoView
          Left = 28.236240000000000000
          Top = 98.267780000000000000
          Width = 28.346456690000000000
          Height = 75.590600000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            #1087#1086
            #1089#1084#1077#1090#1077)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo4: TfrxMemoView
          Top = 75.590600000000000000
          Width = 56.692950000000000000
          Height = 22.677180000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            #1053#1086#1084#1077#1088)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo5: TfrxMemoView
          Left = 56.692950000000000000
          Top = 75.590600000000000000
          Width = 249.448980000000000000
          Height = 98.267780000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            #1054#1073#1086#1089#1085#1086#1074#1072#1085#1080#1077', '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1074#1080#1076#1086#1074' '#1088#1072#1073#1086#1090)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo6: TfrxMemoView
          Left = 306.141930000000000000
          Top = 75.590600000000000000
          Width = 47.244094490000000000
          Height = 98.267780000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            #1045#1076'.'#1080#1079#1084'.'
            #1050#1086#1083'-'#1074#1086)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo7: TfrxMemoView
          Left = 353.496290000000000000
          Top = 75.590600000000000000
          Width = 47.244094490000000000
          Height = 98.267780000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            #1047#1072#1088#1087#1083#1072#1090#1072' '#1088#1072#1073#1086#1095#1080#1093', '#1088#1091#1073'.'
            #1077#1076'./'#1086#1073#1098#1077#1084)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo8: TfrxMemoView
          Left = 400.629923700000000000
          Top = 75.590600000000000000
          Width = 47.244094490000000000
          Height = 98.267780000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            #1047#1072#1088#1087#1083#1072#1090#1072' '#1084#1072#1096#1080#1085#1080#1089#1090#1086#1074', '#1088#1091#1073'.'
            #1077#1076'./'#1086#1073#1098#1077#1084)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo9: TfrxMemoView
          Left = 447.874018190000000000
          Top = 102.047310000000000000
          Width = 47.244094490000000000
          Height = 71.811070000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            #1054#1073#1086#1089#1085#1086#1074#1072'-'#1085#1080#1077)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo11: TfrxMemoView
          Left = 495.118112680000000000
          Top = 102.047310000000000000
          Width = 47.244094490000000000
          Height = 71.811070000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            #1042#1089#1077#1075#1086)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo12: TfrxMemoView
          Left = 542.362207170000000000
          Top = 75.590600000000000000
          Width = 47.244094490000000000
          Height = 98.267780000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            #1042#1089#1077#1075#1086' '#1079#1080#1084#1085#1080#1077' '#1091#1076#1086#1088#1086#1078#1072#1085#1080#1103'/'
            #1047#1072#1088#1087#1083#1072#1090#1072' '#1074' '#1079#1080#1084'.'#1091#1076'., '#1088#1091#1073'.')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo13: TfrxMemoView
          Left = 589.606301650000000000
          Top = 102.047310000000000000
          Width = 47.244094490000000000
          Height = 71.811070000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            #1052#1077#1078#1088#1072#1079'-'#1088#1103#1076#1085#1099#1081' '#1082#1086#1101#1092'-'#1090)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo14: TfrxMemoView
          Left = 636.961040000000000000
          Top = 75.590600000000000000
          Width = 47.244094490000000000
          Height = 98.267780000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            #1058#1088#1091#1076#1086#1079#1072#1090#1088'. '#1074' '#1079#1080#1084#1085#1077#1084' '#1091#1076#1086#1088#1086#1078#1072#1085#1080#1080', '#1095#1077#1083'-'#1095#1072#1089)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo15: TfrxMemoView
          Left = 447.874018190000000000
          Top = 75.590600000000000000
          Width = 94.488250000000000000
          Height = 26.456710000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            #1047#1080#1084#1085#1080#1077' '#1091#1076#1086#1088#1086#1078#1072#1085#1080#1103'/'
            #1079#1072#1088#1072#1073#1086#1090#1085#1072#1103' '#1087#1083#1072#1090#1072', %')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo16: TfrxMemoView
          Left = 589.606680000000000000
          Top = 75.590600000000000000
          Width = 47.244094490000000000
          Height = 26.456710000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            #1053#1086#1084#1077#1088)
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object MasterData1: TfrxMasterData
        Height = 45.354360000000000000
        Top = 306.141930000000000000
        Width = 718.110700000000000000
        DataSet = frxWRS_OBJ
        DataSetName = 'frxWRS_OBJ'
        RowCount = 0
        Stretched = True
        object frxZP_OBJOUT_rate_caption: TfrxMemoView
          Left = 56.692950000000000000
          Width = 249.448980000000000000
          Height = 45.354360000000000000
          ShowHint = False
          DataSet = frxWRS_OBJ
          DataSetName = 'frxWRS_OBJ'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Frame.Width = 0.500000000000000000
          HAlign = haBlock
          Memo.UTF8W = (
            '[frxWRS_OBJ."rate_code"]  [frxWRS_OBJ."rate_caption"]')
          ParentFont = False
          WordBreak = True
        end
        object SysMemo3: TfrxSysMemoView
          Width = 28.346456690000000000
          Height = 45.354360000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftBottom]
          Frame.Width = 0.500000000000000000
          Memo.UTF8W = (
            '[LINE#]')
          ParentFont = False
          VAlign = vaCenter
        end
        object frxWRS_OBJOUT_rate_code: TfrxMemoView
          Left = 56.692910940000000000
          Width = 45.354360000000000000
          Height = 11.338590000000000000
          ShowHint = False
          AutoWidth = True
          Color = clWhite
          DataSet = frxWRS_OBJ
          DataSetName = 'frxWRS_OBJ'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftTop]
          Frame.Width = 0.500000000000000000
          Memo.UTF8W = (
            '[frxWRS_OBJ."RATE_CODE"]')
          ParentFont = False
          SuppressRepeated = True
          WordWrap = False
        end
        object frxWRS_OBJRATE_UNIT: TfrxMemoView
          Left = 306.141930000000000000
          Width = 47.244094490000000000
          Height = 22.677180000000000000
          ShowHint = False
          DataField = 'RATE_UNIT'
          DataSet = frxWRS_OBJ
          DataSetName = 'frxWRS_OBJ'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Times New Roman'
          Font.Style = [fsUnderline]
          Frame.Typ = [ftRight]
          Frame.Width = 0.500000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxWRS_OBJ."RATE_UNIT"]')
          ParentFont = False
        end
        object frxWRS_OBJRATE_COUNT: TfrxMemoView
          Left = 306.141930000000000000
          Top = 22.677180000000000000
          Width = 47.244094490000000000
          Height = 22.677180000000000000
          ShowHint = False
          DataField = 'RATE_COUNT'
          DataSet = frxWRS_OBJ
          DataSetName = 'frxWRS_OBJ'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftRight, ftBottom]
          Frame.Width = 0.500000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxWRS_OBJ."RATE_COUNT"]')
          ParentFont = False
        end
        object frxWRS_OBJv_rab: TfrxMemoView
          Left = 353.275820000000000000
          Width = 47.244094490000000000
          Height = 22.677180000000000000
          ShowHint = False
          DataField = 'v_rab'
          DataSet = frxWRS_OBJ
          DataSetName = 'frxWRS_OBJ'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Times New Roman'
          Font.Style = [fsUnderline]
          Frame.Typ = [ftRight]
          Frame.Width = 0.500000000000000000
          HAlign = haCenter
          HideZeros = True
          Memo.UTF8W = (
            '[frxWRS_OBJ."v_rab"]')
          ParentFont = False
        end
        object frxWRS_OBJZP_RAB: TfrxMemoView
          Left = 353.275820000000000000
          Top = 22.677180000000000000
          Width = 47.244094490000000000
          Height = 22.677180000000000000
          ShowHint = False
          DataField = 'ZP_RAB'
          DataSet = frxWRS_OBJ
          DataSetName = 'frxWRS_OBJ'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftRight, ftBottom]
          Frame.Width = 0.500000000000000000
          HAlign = haCenter
          HideZeros = True
          Memo.UTF8W = (
            '[frxWRS_OBJ."ZP_RAB"]')
          ParentFont = False
        end
        object frxWRS_OBJv_mash: TfrxMemoView
          Left = 400.630180000000000000
          Width = 45.354360000000000000
          Height = 22.677180000000000000
          ShowHint = False
          DataField = 'v_mash'
          DataSet = frxWRS_OBJ
          DataSetName = 'frxWRS_OBJ'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Times New Roman'
          Font.Style = [fsUnderline]
          Frame.Typ = [ftRight]
          Frame.Width = 0.500000000000000000
          HAlign = haCenter
          HideZeros = True
          Memo.UTF8W = (
            '[frxWRS_OBJ."v_mash"]')
          ParentFont = False
        end
        object frxWRS_OBJZP_MASH: TfrxMemoView
          Left = 400.630180000000000000
          Top = 22.677180000000000000
          Width = 45.354360000000000000
          Height = 22.677180000000000000
          ShowHint = False
          DataField = 'ZP_MASH'
          DataSet = frxWRS_OBJ
          DataSetName = 'frxWRS_OBJ'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftRight, ftBottom]
          Frame.Width = 0.500000000000000000
          HAlign = haCenter
          HideZeros = True
          Memo.UTF8W = (
            '[frxWRS_OBJ."ZP_MASH"]')
          ParentFont = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        Height = 15.118120000000000000
        Top = 268.346630000000000000
        Width = 718.110700000000000000
        Condition = 'frxWRS_OBJ."NAME1"'
        object frxWRS_OBJNAME1: TfrxMemoView
          Width = 680.315400000000000000
          Height = 15.118120000000000000
          ShowHint = False
          DataSet = frxWRS_OBJ
          DataSetName = 'frxWRS_OBJ'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          Frame.Typ = [ftBottom]
          Frame.Width = 0.500000000000000000
          Memo.UTF8W = (
            '[frxWRS_OBJ."NAME1"]')
          ParentFont = False
        end
      end
    end
  end
end
