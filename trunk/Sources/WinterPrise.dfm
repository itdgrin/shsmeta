object fWinterPrise: TfWinterPrise
  Left = 0
  Top = 0
  Caption = #1047#1080#1084#1085#1077#1077' '#1091#1076#1086#1088#1086#1078#1072#1085#1080#1077
  ClientHeight = 532
  ClientWidth = 801
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    801
    532)
  PixelsPerInch = 96
  TextHeight = 13
  object tvEstimates: TJvDBTreeView
    Left = 8
    Top = 8
    Width = 587
    Height = 481
    DataSource = dsTreeData
    MasterField = 'ZNORMATIVS_ID'
    DetailField = 'PARENT_ID'
    ItemField = 'NAME_EX'
    UseFilter = True
    PersistentNode = False
    DragMode = dmAutomatic
    HideSelection = False
    Indent = 19
    Align = alCustom
    TabOrder = 0
    PopupMenu = pm1
    Anchors = [akLeft, akTop, akRight, akBottom]
    HotTrack = True
    Mirror = False
  end
  object grp1: TGroupBox
    Left = 601
    Top = 8
    Width = 192
    Height = 100
    Anchors = [akTop, akRight]
    Caption = #1055#1088#1086#1094#1077#1085#1090', %'
    TabOrder = 1
    object lblCoef: TLabel
      Left = 8
      Top = 20
      Width = 39
      Height = 13
      Caption = #1054#1073#1097#1080#1081':'
    end
    object lblCoefZP: TLabel
      Left = 8
      Top = 47
      Width = 52
      Height = 13
      Caption = #1047#1072#1088#1087#1083#1072#1090#1072':'
    end
    object lblCoefZPMach: TLabel
      Left = 8
      Top = 74
      Width = 110
      Height = 13
      Caption = #1047#1072#1088#1087#1083#1072#1090#1072' '#1084#1072#1096#1080#1085#1080#1089#1090#1072':'
    end
    object dbedtCOEF: TDBEdit
      Left = 128
      Top = 16
      Width = 57
      Height = 21
      Color = clSilver
      DataField = 'COEF'
      DataSource = dsTreeData
      ReadOnly = True
      TabOrder = 0
    end
    object dbedtCOEF_ZP: TDBEdit
      Left = 128
      Top = 43
      Width = 57
      Height = 21
      Color = clSilver
      DataField = 'COEF_ZP'
      DataSource = dsTreeData
      ReadOnly = True
      TabOrder = 1
    end
    object dbedtCOEF_ZP_MACH: TDBEdit
      Left = 128
      Top = 70
      Width = 57
      Height = 21
      Color = clSilver
      DataField = 'COEF_ZP_MACH'
      DataSource = dsTreeData
      ReadOnly = True
      TabOrder = 2
    end
  end
  object JvDBGrid1: TJvDBGrid
    Left = 601
    Top = 114
    Width = 192
    Height = 375
    Anchors = [akTop, akRight, akBottom]
    DataSource = dsZnormativs_detail
    Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
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
        FieldName = 'S'
        Title.Alignment = taCenter
        Title.Caption = #1057
        Width = 93
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PO'
        Title.Alignment = taCenter
        Title.Caption = #1055#1086
        Width = 93
        Visible = True
      end>
  end
  object pnl1: TPanel
    Left = 0
    Top = 495
    Width = 801
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    DesignSize = (
      801
      37)
    object lbl1: TLabel
      Left = 8
      Top = 0
      Width = 35
      Height = 13
      Caption = #1053#1086#1084#1077#1088':'
    end
    object lbl2: TLabel
      Left = 119
      Top = 0
      Width = 52
      Height = 13
      Caption = #1053#1072#1079#1074#1072#1085#1080#1077':'
    end
    object btnClose: TBitBtn
      Left = 718
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #1047#1072#1082#1088#1099#1090#1100
      TabOrder = 3
      OnClick = btnCloseClick
    end
    object btnSelect: TBitBtn
      Left = 637
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #1042#1099#1073#1088#1072#1090#1100
      ModalResult = 1
      TabOrder = 2
      OnClick = btnSelectClick
    end
    object dbedtNUM: TDBEdit
      Left = 49
      Top = 0
      Width = 64
      Height = 21
      DataField = 'NUM'
      DataSource = dsTreeData
      TabOrder = 0
    end
    object dbedtNAME: TDBEdit
      Left = 177
      Top = 0
      Width = 418
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      DataField = 'NAME'
      DataSource = dsTreeData
      TabOrder = 1
    end
  end
  object qrTreeData: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    SQL.Strings = (
      'SELECT '
      '  `ZNORMATIVS_ID`,'
      '  `NUM`,'
      '  `NAME`,'
      '  `COEF`,'
      '  `COEF_ZP`,'
      '  `COEF_ZP_MACH`,'
      '  `COEF_ZP_MACH_MOD`,'
      '  `PARENT_ID`,'
      '  CONCAT(`NUM`, " ", `NAME`) AS NAME_EX'
      'FROM '
      '  `znormativs_ex`'
      'ORDER BY `NUM`=0, -`NUM` DESC, `NUM`;')
    Left = 33
    Top = 18
  end
  object dsTreeData: TDataSource
    DataSet = qrTreeData
    Left = 32
    Top = 66
  end
  object qrZnormativs_detail: TFDQuery
    MasterSource = dsTreeData
    MasterFields = 'ZNORMATIVS_ID'
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    SQL.Strings = (
      'select * from znormativs_detail'
      'WHERE ZNORMATIVS_ID=:ZNORMATIVS_ID')
    Left = 649
    Top = 210
    ParamData = <
      item
        Name = 'ZNORMATIVS_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 0
      end>
  end
  object dsZnormativs_detail: TDataSource
    DataSet = qrZnormativs_detail
    Left = 648
    Top = 258
  end
  object pm1: TPopupMenu
    Left = 32
    Top = 112
    object N1: TMenuItem
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    end
    object N2: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100
    end
  end
end
