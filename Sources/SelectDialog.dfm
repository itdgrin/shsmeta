object fSelectDialog: TfSelectDialog
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'fSelectDialog'
  ClientHeight = 338
  ClientWidth = 384
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object grMain1: TJvDBGrid
    Left = 0
    Top = 0
    Width = 384
    Height = 301
    Align = alClient
    DataSource = dsMainData
    DrawingStyle = gdsClassic
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDrawColumnCell = grMain1DrawColumnCell
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
        Width = 367
        Visible = True
      end>
  end
  object pnl1: TPanel
    Left = 0
    Top = 301
    Width = 384
    Height = 37
    Align = alBottom
    TabOrder = 1
    ExplicitTop = 232
    ExplicitWidth = 373
    DesignSize = (
      384
      37)
    object btn1: TBitBtn
      Left = 299
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #1054#1090#1084#1077#1085#1072
      ModalResult = 2
      TabOrder = 1
      ExplicitLeft = 288
    end
    object btn2: TBitBtn
      Left = 218
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #1042#1099#1073#1088#1072#1090#1100
      ModalResult = 1
      TabOrder = 0
      ExplicitLeft = 207
    end
  end
  object dsMainData: TDataSource
    DataSet = FormCalculationEstimate.qrTemp
    Left = 51
    Top = 96
  end
  object FormStorage: TJvFormStorage
    AppStorage = FormMain.AppIni
    AppStoragePath = '%FORM_NAME%\'
    Options = []
    StoredProps.Strings = (
      'grMain1.RowsHeight')
    StoredValues = <>
    Left = 48
    Top = 144
  end
end
