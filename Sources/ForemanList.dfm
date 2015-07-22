object fForemanList: TfForemanList
  Left = 0
  Top = 0
  Caption = #1057#1087#1080#1089#1086#1082' '#1087#1088#1086#1088#1072#1073#1086#1074
  ClientHeight = 451
  ClientWidth = 351
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
  PixelsPerInch = 96
  TextHeight = 13
  object grMain: TJvDBGrid
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 345
    Height = 414
    Align = alClient
    DataSource = dsMain
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDrawColumnCell = grMainDrawColumnCell
    IniStorage = FormStorage
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
        FieldName = 'foreman_first_name'
        Title.Alignment = taCenter
        Title.Caption = #1060#1072#1084#1080#1083#1080#1103
        Width = 110
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'foreman_name'
        Title.Alignment = taCenter
        Title.Caption = #1048#1084#1103
        Width = 110
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'foreman_second_name'
        Title.Alignment = taCenter
        Title.Caption = #1054#1090#1095#1077#1089#1090#1074#1086
        Width = 106
        Visible = True
      end>
  end
  object dbnvgr1: TDBNavigator
    AlignWithMargins = True
    Left = 3
    Top = 423
    Width = 345
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
    ExplicitLeft = 0
    ExplicitTop = 427
    ExplicitWidth = 351
  end
  object qrMain: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    UpdateOptions.UpdateTableName = 'smeta.foreman'
    UpdateOptions.KeyFields = 'foreman_id'
    SQL.Strings = (
      'SELECT * FROM foreman')
    Left = 256
    Top = 152
  end
  object dsMain: TDataSource
    DataSet = qrMain
    Left = 200
    Top = 152
  end
  object FormStorage: TJvFormStorage
    AppStorage = FormMain.AppIni
    AppStoragePath = '%FORM_NAME%\'
    Options = []
    StoredValues = <>
    Left = 32
    Top = 224
  end
end
