object fSmReportParamSelect: TfSmReportParamSelect
  Left = 0
  Top = 0
  ActiveControl = grParamList
  Caption = #1042#1099#1073#1086#1088' '#1079#1085#1072#1095#1077#1085#1080#1103' '#1087#1072#1088#1072#1084#1077#1090#1088#1072
  ClientHeight = 282
  ClientWidth = 284
  Color = clBtnFace
  Constraints.MinHeight = 320
  Constraints.MinWidth = 300
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  ShowHint = True
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object pnlBot: TPanel
    Left = 0
    Top = 245
    Width = 284
    Height = 37
    Align = alBottom
    TabOrder = 2
    DesignSize = (
      284
      37)
    object btnCancel: TBitBtn
      Left = 203
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #1054#1090#1084#1077#1085#1072
      ModalResult = 2
      TabOrder = 1
    end
    object btnOk: TBitBtn
      Left = 122
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
  object grParamList: TJvDBGrid
    Left = 0
    Top = 27
    Width = 284
    Height = 218
    Align = alClient
    DataSource = dsParamList
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleHotTrack]
    ParentFont = False
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = grParamListDblClick
    OnKeyDown = grParamListKeyDown
    AutoAppend = False
    ScrollBars = ssVertical
    AutoSizeColumns = True
    SelectColumnsDialogStrings.Caption = 'Select columns'
    SelectColumnsDialogStrings.OK = '&OK'
    SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
    CanDelete = False
    EditControls = <>
    RowsHeight = 17
    TitleRowHeight = 17
    Columns = <
      item
        Expanded = False
        FieldName = 'VALUE'
        Title.Alignment = taCenter
        Title.Caption = '  '
        Width = 267
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CODE'
        Title.Alignment = taCenter
        Title.Caption = #1050#1086#1076
        Visible = False
      end>
  end
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 284
    Height = 27
    Align = alTop
    BevelOuter = bvNone
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    object edtSearch: TEdit
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 278
      Height = 21
      Align = alClient
      TabOrder = 0
      TextHint = #1042#1074#1077#1076#1080#1090#1077' '#1090#1077#1082#1089#1090' '#1076#1083#1103' '#1087#1086#1080#1089#1082#1072'...'
      OnChange = edtSearchChange
      ExplicitWidth = 210
    end
  end
  object qrParamList: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FetchOptions.AssignedValues = [evCache]
    FetchOptions.Cache = [fiBlobs, fiMeta]
    Left = 30
    Top = 98
  end
  object dsParamList: TDataSource
    DataSet = qrParamList
    Left = 30
    Top = 146
  end
end
