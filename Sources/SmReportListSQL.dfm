object fSmReportListSQL: TfSmReportListSQL
  Left = 0
  Top = 0
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1089#1087#1080#1089#1082#1086#1074
  ClientHeight = 282
  ClientWidth = 464
  Color = clBtnFace
  Constraints.MinHeight = 320
  Constraints.MinWidth = 480
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
  DesignSize = (
    464
    282)
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 244
    Top = 8
    Width = 89
    Height = 13
    Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1089#1087#1080#1089#1082#1072':'
  end
  object lbl2: TLabel
    Left = 244
    Top = 54
    Width = 53
    Height = 13
    Caption = #1054#1087#1080#1089#1072#1085#1080#1077':'
  end
  object lbl3: TLabel
    Left = 244
    Top = 143
    Width = 101
    Height = 13
    Caption = #1047#1072#1087#1088#1086#1089' '#1085#1072' '#1074#1099#1073#1086#1088#1082#1091':'
  end
  object grMain: TJvDBGrid
    Left = 8
    Top = 8
    Width = 230
    Height = 234
    Align = alCustom
    Anchors = [akLeft, akTop, akBottom]
    DataSource = dsMain
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ParentFont = False
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
        FieldName = 'REPORT_LIST_SQL_NAME'
        Title.Alignment = taCenter
        Title.Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1089#1087#1080#1089#1082#1072
        Width = 213
        Visible = True
      end>
  end
  object pnlBot: TPanel
    Left = 0
    Top = 248
    Width = 464
    Height = 34
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    DesignSize = (
      464
      34)
    object dbnvgr1: TDBNavigator
      Left = 8
      Top = 4
      Width = 230
      Height = 25
      DataSource = dsMain
      TabOrder = 0
    end
    object btnClose: TBitBtn
      Left = 384
      Top = 4
      Width = 76
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #1047#1072#1082#1088#1099#1090#1100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ModalResult = 2
      ParentFont = False
      TabOrder = 2
    end
    object btn1: TBitBtn
      Left = 244
      Top = 4
      Width = 75
      Height = 25
      Caption = #1058#1077#1089#1090
      TabOrder = 1
      OnClick = btn1Click
    end
  end
  object dbmmoREPORT_LIST_SQL_DESCR: TDBMemo
    Left = 244
    Top = 73
    Width = 212
    Height = 64
    Anchors = [akLeft, akTop, akRight]
    DataField = 'REPORT_LIST_SQL_DESCR'
    DataSource = dsMain
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object dbmmoREPORT_LIST_SQL_SRC: TDBMemo
    Left = 244
    Top = 162
    Width = 212
    Height = 80
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataField = 'REPORT_LIST_SQL_SRC'
    DataSource = dsMain
    ScrollBars = ssVertical
    TabOrder = 3
  end
  object dbedtREPORT_LIST_SQL_NAME: TDBEdit
    Left = 244
    Top = 27
    Width = 212
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    DataField = 'REPORT_LIST_SQL_NAME'
    DataSource = dsMain
    TabOrder = 1
  end
  object qrMain: TFDQuery
    OnNewRecord = qrMainNewRecord
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FetchOptions.AssignedValues = [evCache]
    FetchOptions.Cache = [fiBlobs, fiMeta]
    UpdateOptions.UpdateTableName = 'smeta.report_list_sql'
    UpdateOptions.KeyFields = 'REPORT_LIST_SQL_ID'
    SQL.Strings = (
      'SELECT *'
      'FROM report_list_sql'
      'ORDER BY REPORT_LIST_SQL_NAME')
    Left = 22
    Top = 50
  end
  object dsMain: TDataSource
    DataSet = qrMain
    Left = 22
    Top = 98
  end
  object FormStorage: TJvFormStorage
    AppStorage = FormMain.AppIni
    AppStoragePath = '%FORM_NAME%\'
    Options = [fpSize]
    StoredValues = <>
    Left = 24
    Top = 10
  end
end
