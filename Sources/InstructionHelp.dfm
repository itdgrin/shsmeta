object fInstructionHelp: TfInstructionHelp
  Left = 0
  Top = 0
  Caption = #1052#1077#1090#1086#1076#1080#1095#1077#1082#1080#1077' '#1091#1082#1072#1079#1072#1085#1080#1103
  ClientHeight = 365
  ClientWidth = 493
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
  object pnl1: TPanel
    Left = 0
    Top = 333
    Width = 493
    Height = 32
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      493
      32)
    object btn1: TBitBtn
      Left = 3
      Top = 3
      Width = 126
      Height = 25
      Caption = #1054#1090#1082#1088#1099#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090
      TabOrder = 0
      OnClick = tvDocumentsDblClick
    end
    object btn2: TBitBtn
      Left = 415
      Top = 3
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #1047#1072#1082#1088#1099#1090#1100
      TabOrder = 1
      OnClick = btn2Click
    end
  end
  object tvDocuments: TJvDBTreeView
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 487
    Height = 327
    DataSource = dsTreeData
    MasterField = 'doc_id'
    DetailField = 'parent_id'
    IconField = 'doc_type'
    ItemField = 'doc_name'
    StartMasterValue = '2'
    UseFilter = True
    PersistentNode = True
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
    OnDblClick = tvDocumentsDblClick
    ParentFont = False
    RowSelect = True
    Mirror = False
  end
  object qrTreeData: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FetchOptions.AssignedValues = [evCache]
    FetchOptions.Cache = [fiBlobs, fiMeta]
    SQL.Strings = (
      'SELECT * '
      'FROM '
      '  `doc` '
      'WHERE (doc_id>=2 and doc_id<=4) or (doc_id>=9 and doc_id<=35)'
      'ORDER BY doc_type, doc_name')
    Left = 41
    Top = 38
  end
  object dsTreeData: TDataSource
    DataSet = qrTreeData
    Left = 40
    Top = 86
  end
end
