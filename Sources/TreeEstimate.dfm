object fTreeEstimate: TfTreeEstimate
  Left = 378
  Top = 77
  ActiveControl = tvEstimates
  BorderStyle = bsSizeToolWin
  Caption = #1057#1090#1088#1091#1082#1090#1091#1088#1072' '#1086#1073#1098#1077#1082#1090#1072'/'#1089#1084#1077#1090#1099
  ClientHeight = 293
  ClientWidth = 396
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnClose = FormClose
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object tvEstimates: TJvDBTreeView
    Left = 0
    Top = 0
    Width = 396
    Height = 293
    DataSource = dsTreeEstimates
    MasterField = 'SM_ID'
    DetailField = 'PARENT'
    ItemField = 'NAME'
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
    OnClick = tvEstimatesClick
    OnDblClick = tvEstimatesDblClick
    ParentFont = False
    RowSelect = True
    Mirror = False
  end
  object qrTreeEstimates: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FetchOptions.AssignedValues = [evCache]
    FetchOptions.Cache = [fiBlobs, fiMeta]
    SQL.Strings = (
      
        'SELECT SM_ID, SM_TYPE, OBJ_ID, CONCAT(SM_NUMBER, " ",  NAME) as ' +
        'NAME,'
      '       PARENT_ID as PARENT  '
      'FROM smetasourcedata'
      'WHERE SM_TYPE=2 AND '
      '      DELETED=0 AND'
      '      OBJ_ID=:OBJ_ID'
      'UNION ALL'
      
        'SELECT SM_ID, SM_TYPE, OBJ_ID, CONCAT(SM_NUMBER, " ",  NAME) as ' +
        'NAME,'
      '       PARENT_ID as PARENT  '
      'FROM smetasourcedata'
      'WHERE SM_TYPE<>2 AND '
      '      DELETED=0 AND'
      '      OBJ_ID=:OBJ_ID'
      'ORDER BY NAME')
    Left = 118
    Top = 186
    ParamData = <
      item
        Name = 'OBJ_ID'
        DataType = ftInteger
        ParamType = ptInput
        Size = 10
        Value = Null
      end>
  end
  object dsTreeEstimates: TDataSource
    DataSet = qrTreeEstimates
    Left = 158
    Top = 186
  end
  object FormStorage: TJvFormStorage
    AppStorage = FormMain.AppIni
    AppStoragePath = '%FORM_NAME%\'
    Options = [fpSize, fpLocation]
    StoredValues = <>
    Left = 32
    Top = 224
  end
end
