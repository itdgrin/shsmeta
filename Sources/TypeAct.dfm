object fTypeAct: TfTypeAct
  Left = 0
  Top = 0
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1090#1080#1087#1086#1074' '#1072#1082#1090#1086#1074
  ClientHeight = 282
  ClientWidth = 370
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object grMain: TJvDBGrid
    Left = 0
    Top = 0
    Width = 370
    Height = 220
    Align = alClient
    DataSource = dsMain
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ParentFont = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = grMainDblClick
    ScrollBars = ssVertical
    AutoSizeColumns = True
    SelectColumnsDialogStrings.Caption = 'Select columns'
    SelectColumnsDialogStrings.OK = '&OK'
    SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
    EditControls = <>
    RowsHeight = 17
    TitleRowHeight = 17
    OnCanEditCell = grMainCanEditCell
    Columns = <
      item
        Expanded = False
        FieldName = 'POS'
        Title.Alignment = taCenter
        Title.Caption = #8470#1087#1087
        Width = 54
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TYPE_ACT_NAME'
        Title.Alignment = taCenter
        Title.Caption = #1058#1080#1087' '#1072#1082#1090#1072
        Width = 298
        Visible = True
      end>
  end
  object pnlBot: TPanel
    Left = 0
    Top = 251
    Width = 370
    Height = 31
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object btnCancel: TBitBtn
      AlignWithMargins = True
      Left = 292
      Top = 3
      Width = 75
      Height = 25
      Align = alRight
      Caption = #1047#1072#1082#1088#1099#1090#1100
      ModalResult = 2
      TabOrder = 1
    end
    object btnSelect: TBitBtn
      AlignWithMargins = True
      Left = 214
      Top = 3
      Width = 75
      Height = 25
      Margins.Right = 0
      Align = alRight
      Caption = #1042#1099#1073#1088#1072#1090#1100
      ModalResult = 1
      TabOrder = 0
    end
  end
  object dbnvgr1: TDBNavigator
    AlignWithMargins = True
    Left = 3
    Top = 223
    Width = 364
    Height = 25
    DataSource = dsMain
    Align = alBottom
    Hints.Strings = (
      #1053#1072' '#1087#1077#1088#1074#1091#1102' '#1079#1072#1087#1080#1089#1100
      #1055#1088#1077#1076#1099#1076#1091#1097#1072#1103' '#1079#1072#1087#1080#1089#1100
      #1057#1083#1077#1076#1091#1102#1097#1072#1103' '#1079#1072#1087#1080#1089#1100
      #1053#1072' '#1087#1086#1089#1083#1077#1076#1085#1102#1102' '#1079#1072#1087#1080#1089#1100
      #1053#1086#1074#1072#1103' '#1079#1072#1087#1080#1089#1100
      #1059#1076#1072#1083#1080#1090#1100' '#1079#1072#1087#1080#1089#1100
      #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1079#1072#1087#1080#1089#1100
      #1057#1086#1093#1088#1072#1085#1080#1090#1100
      #1054#1090#1084#1077#1085#1080#1090#1100
      #1054#1073#1085#1086#1074#1080#1090#1100
      'Apply updates'
      'Cancel updates')
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    TabStop = True
  end
  object FormStorage: TJvFormStorage
    AppStorage = FormMain.AppIni
    AppStoragePath = '%FORM_NAME%\'
    Options = [fpSize]
    StoredValues = <>
    Left = 40
    Top = 74
  end
  object qrMain: TFDQuery
    BeforePost = qrMainBeforePost
    BeforeDelete = qrMainBeforeDelete
    OnNewRecord = qrMainNewRecord
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    UpdateOptions.UpdateTableName = 'smeta.type_act'
    UpdateOptions.KeyFields = 'foreman_id'
    SQL.Strings = (
      'SELECT * FROM type_act'
      'ORDER BY pos, type_act_name')
    Left = 160
    Top = 72
  end
  object dsMain: TDataSource
    DataSet = qrMain
    Left = 160
    Top = 120
  end
end
