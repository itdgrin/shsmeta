object fSelectDialog: TfSelectDialog
  Left = 0
  Top = 0
  ActiveControl = grMain
  BorderIcons = [biSystemMenu]
  Caption = #1044#1080#1072#1083#1086#1075' '#1074#1099#1073#1086#1088#1072' '#1079#1085#1072#1095#1077#1085#1080#1103' '#1080#1079' DataSet '
  ClientHeight = 328
  ClientWidth = 503
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object grMain: TJvDBGrid
    Left = 0
    Top = 0
    Width = 503
    Height = 291
    Align = alClient
    DataSource = dsMain
    DrawingStyle = gdsClassic
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleHotTrack]
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = grMainDblClick
    AutoAppend = False
    IniStorage = FormStorage
    AutoSizeColumns = True
    SelectColumnsDialogStrings.Caption = 'Select columns'
    SelectColumnsDialogStrings.OK = '&OK'
    SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
    CanDelete = False
    EditControls = <>
    AutoSizeRows = False
    ReduceFlicker = False
    RowResize = True
    RowsHeight = 35
    TitleRowHeight = 17
    WordWrap = True
    WordWrapAllFields = True
    Columns = <
      item
        Expanded = False
        FieldName = 'NAME'
        Title.Alignment = taCenter
        Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
        Width = 271
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALUE'
        Title.Alignment = taCenter
        Title.Caption = #1047#1085#1072#1095#1077#1085#1080#1077
        Width = 114
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESCRIPTION'
        Title.Alignment = taCenter
        Title.Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072
        Width = 99
        Visible = True
      end>
  end
  object pnlBot: TPanel
    Left = 0
    Top = 291
    Width = 503
    Height = 37
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      503
      37)
    object btnCancel: TBitBtn
      Left = 418
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #1054#1090#1084#1077#1085#1072
      ModalResult = 2
      TabOrder = 1
    end
    object btnOk: TBitBtn
      Left = 337
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #1042#1099#1073#1088#1072#1090#1100
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
  end
  object dsMain: TDataSource
    Left = 51
    Top = 96
  end
  object FormStorage: TJvFormStorage
    AppStorage = FormMain.AppIni
    AppStoragePath = '%FORM_NAME%\'
    Options = []
    StoredProps.Strings = (
      'grMain.RowsHeight')
    StoredValues = <>
    Left = 48
    Top = 144
  end
end
