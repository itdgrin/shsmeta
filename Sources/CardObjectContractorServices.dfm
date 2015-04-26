object fCardObjectContractorServices: TfCardObjectContractorServices
  Left = 0
  Top = 0
  Caption = #1059#1089#1083#1091#1075#1080' '#1075#1077#1085#1077#1088#1072#1083#1100#1085#1086#1075#1086' '#1087#1086#1076#1088#1103#1076#1095#1080#1082#1072
  ClientHeight = 399
  ClientWidth = 435
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object pnlBott: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 360
    Width = 429
    Height = 36
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      429
      36)
    object btnCancel: TBitBtn
      Left = 349
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #1054#1090#1084#1077#1085#1072
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = btnCancelClick
    end
    object btnSave: TBitBtn
      Left = 268
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = btnSaveClick
    end
  end
  object grMain: TJvDBGrid
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 429
    Height = 351
    Align = alClient
    DataSource = dsMain
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    ScrollBars = ssVertical
    ShowCellHint = True
    AutoSizeColumns = True
    SelectColumnsDialogStrings.Caption = 'Select columns'
    SelectColumnsDialogStrings.OK = '&OK'
    SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
    EditControls = <>
    RowsHeight = 17
    TitleRowHeight = 17
    WordWrap = True
    WordWrapAllFields = True
    Columns = <
      item
        Expanded = False
        Title.Alignment = taCenter
        Title.Caption = #1048#1089#1087'.'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = []
        Width = 41
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'param_name'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1091#1089#1083#1091#1075#1080
        Width = 325
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALUE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Title.Alignment = taCenter
        Title.Caption = #1055#1088#1086#1094#1077#1085#1090
        Width = 56
        Visible = True
      end>
  end
  object DBCtrlGrid1: TDBCtrlGrid
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 429
    Height = 351
    Align = alClient
    AllowDelete = False
    AllowInsert = False
    DataSource = dsMain
    PanelHeight = 50
    PanelWidth = 412
    TabOrder = 0
    RowCount = 7
    ExplicitHeight = 406
    object dbtxtVALUE: TDBText
      AlignWithMargins = True
      Left = 376
      Top = 3
      Width = 33
      Height = 44
      Align = alRight
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      DataField = 'VALUE'
      DataSource = dsMain
      ParentBiDiMode = False
    end
    object dbmmoparam_name: TDBMemo
      AlignWithMargins = True
      Left = 22
      Top = 3
      Width = 348
      Height = 44
      Align = alClient
      DataField = 'param_name'
      DataSource = dsMain
      ScrollBars = ssVertical
      TabOrder = 1
      ExplicitLeft = 14
      ExplicitTop = 0
      ExplicitWidth = 187
      ExplicitHeight = 72
    end
    object dbchkchecked: TDBCheckBox
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 13
      Height = 44
      Align = alLeft
      Caption = 'dbchkchecked'
      DataField = 'checked'
      DataSource = dsMain
      TabOrder = 0
      ValueChecked = '1'
      ValueUnchecked = '0'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitHeight = 72
    end
  end
  object qrMain: TFDQuery
    OnCalcFields = qrMainCalcFields
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FormatOptions.AssignedValues = [fvDefaultParamDataType, fvFmtDisplayNumeric]
    FormatOptions.DefaultParamDataType = ftBCD
    FormatOptions.FmtDisplayNumeric = '### ### ### ### ### ### ##0.####'
    SQL.Strings = (
      'SELECT id_unidictparam,code,param_name,param_description,'
      'FN_getParamValue(code, :month, :year) AS VALUE'
      'FROM '
      '  unidictparam'
      'WHERE id_unidicttype=7')
    Left = 287
    Top = 270
    ParamData = <
      item
        Name = 'MONTH'
        DataType = ftBCD
        ParamType = ptInput
        Value = 10000c
      end
      item
        Name = 'YEAR'
        DataType = ftBCD
        ParamType = ptInput
        Value = 20150000c
      end>
    object qrMainid_unidictparam: TFDAutoIncField
      DefaultExpression = ''
      FieldName = 'id_unidictparam'
      ProviderFlags = []
      DisplayFormat = '### ### ### ### ### ### ##0.####'
    end
    object strngfldMaincode: TStringField
      AutoGenerateValue = arDefault
      DefaultExpression = ''
      FieldName = 'code'
      ProviderFlags = []
      Size = 50
    end
    object strngfldMainparam_name: TStringField
      FieldName = 'param_name'
      Size = 500
    end
    object strngfldMainparam_description: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'param_description'
      Origin = 'param_description'
      Size = 1000
    end
    object qrMainVALUE: TFloatField
      AutoGenerateValue = arDefault
      FieldName = 'VALUE'
      Origin = 'VALUE'
      ProviderFlags = []
      ReadOnly = True
      DisplayFormat = '### ### ### ### ### ### ##0.####'
    end
    object qrMainChecked: TBooleanField
      FieldKind = fkCalculated
      FieldName = 'Checked'
      Calculated = True
    end
  end
  object dsMain: TDataSource
    DataSet = qrMain
    Left = 320
    Top = 270
  end
end
