object fTravelList: TfTravelList
  Left = 0
  Top = 0
  Caption = #1050#1086#1084#1072#1085#1076#1080#1088#1086#1074#1086#1095#1085#1099#1077
  ClientHeight = 282
  ClientWidth = 418
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Visible = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    418
    282)
  PixelsPerInch = 96
  TextHeight = 13
  object JvDBGrid1: TJvDBGrid
    Left = 8
    Top = 38
    Width = 402
    Height = 195
    Anchors = [akLeft, akTop, akRight, akBottom]
    DrawingStyle = gdsClassic
    TabOrder = 0
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
        Title.Alignment = taCenter
        Title.Caption = #8470
        Width = 96
        Visible = True
      end
      item
        Expanded = False
        Title.Alignment = taCenter
        Title.Caption = #1040#1082#1090
        Width = 96
        Visible = True
      end
      item
        Expanded = False
        Title.Alignment = taCenter
        Title.Caption = #1044#1072#1090#1072
        Width = 96
        Visible = True
      end
      item
        Expanded = False
        Title.Alignment = taCenter
        Title.Caption = #1057#1091#1084#1084#1072
        Width = 94
        Visible = True
      end>
  end
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 418
    Height = 32
    Align = alTop
    TabOrder = 1
    ExplicitLeft = -198
    ExplicitWidth = 616
    DesignSize = (
      418
      32)
    object lbl1: TLabel
      Left = 8
      Top = 8
      Width = 39
      Height = 13
      Caption = #1054#1073#1098#1077#1082#1090
    end
    object dblkcbbNAME: TDBLookupComboBox
      Left = 53
      Top = 5
      Width = 356
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      KeyField = 'OBJ_ID'
      ListField = 'NAME'
      ListSource = dsObject
      TabOrder = 0
      ExplicitWidth = 554
    end
  end
  object pnl1: TPanel
    Left = 8
    Top = 239
    Width = 402
    Height = 35
    Anchors = [akLeft, akRight, akBottom]
    TabOrder = 2
    DesignSize = (
      402
      35)
    object btnDel: TButton
      Left = 182
      Top = 4
      Width = 75
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = #1059#1076#1072#1083#1080#1090#1100
      TabOrder = 0
    end
    object btnEdit: TButton
      Left = 83
      Top = 4
      Width = 96
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      TabOrder = 1
      OnClick = btnEditClick
    end
    object btnAdd: TButton
      Left = 5
      Top = 4
      Width = 75
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      TabOrder = 2
      OnClick = btnAddClick
    end
    object btnClose: TButton
      Left = 322
      Top = 4
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #1047#1072#1082#1088#1099#1090#1100
      TabOrder = 3
      OnClick = btnCloseClick
    end
  end
  object qrObject: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    SQL.Strings = (
      'SELECT OBJ_ID, FULL_NAME as NAME, BEG_STROJ as DATE'
      'FROM objcards '
      'ORDER BY NAME')
    Left = 25
  end
  object dsObject: TDataSource
    DataSet = qrObject
    Left = 56
    Top = 1
  end
end
