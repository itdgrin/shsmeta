object dmReportF: TdmReportF
  OldCreateOrder = False
  Height = 179
  Width = 415
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
    ReportOptions.LastChange = 42050.727586296300000000
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
    Left = 288
    Top = 8
  end
  object trReportWrite: TFDTransaction
    Options.ReadOnly = True
    Options.StopOptions = [xoIfCmdsInactive, xoIfAutoStarted, xoFinishRetaining]
    Connection = DM.Connect
    Left = 360
    Top = 8
  end
  object qrTMP: TFDQuery
    Connection = DM.Connect
    Transaction = trReportRead
    UpdateTransaction = trReportWrite
    Left = 80
    Top = 8
  end
end
