object FormListCollections: TFormListCollections
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = #1055#1077#1088#1077#1095#1077#1085#1100' '#1089#1073#1086#1088#1085#1080#1082#1086#1074
  ClientHeight = 425
  ClientWidth = 680
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
  PixelsPerInch = 96
  TextHeight = 13
  object TreeView: TTreeView
    Left = 0
    Top = 25
    Width = 680
    Height = 329
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Indent = 19
    ParentFont = False
    PopupMenu = PopupMenu
    ReadOnly = True
    TabOrder = 0
    OnClick = TreeViewClick
    OnDblClick = TreeViewDblClick
  end
  object PanelTop: TPanel
    Left = 0
    Top = 0
    Width = 680
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    Caption = 'PanelTop'
    ShowCaption = False
    TabOrder = 1
    DesignSize = (
      680
      25)
    object LabelPage: TLabel
      Left = 6
      Top = 6
      Width = 69
      Height = 13
      Caption = #8470' '#1089#1090#1088#1072#1085#1080#1094#1099':'
    end
    object LabelSearch: TLabel
      Left = 117
      Top = 6
      Width = 34
      Height = 13
      Caption = #1055#1086#1080#1089#1082':'
    end
    object EditPage: TEdit
      Left = 81
      Top = 2
      Width = 30
      Height = 21
      Color = 14802912
      ReadOnly = True
      TabOrder = 0
    end
    object EditSearch: TEdit
      Left = 157
      Top = 2
      Width = 472
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 1
      OnKeyPress = EditSearchKeyPress
    end
    object ButtonSearchUp: TButton
      Left = 635
      Top = 1
      Width = 20
      Height = 23
      Hint = #1053#1072#1081#1090#1080' '#1088#1072#1085#1077#1077' ('#1074#1074#1077#1088#1093')'
      Anchors = [akTop, akRight]
      Caption = #171
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = ButtonSearchUpClick
    end
    object ButtonSearchDown: TButton
      Left = 657
      Top = 1
      Width = 20
      Height = 23
      Hint = #1053#1072#1081#1090#1080' '#1076#1072#1083#1077#1077' ('#1074#1085#1080#1079')'
      Anchors = [akTop, akRight]
      Caption = #187
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = ButtonSearchDownClick
    end
  end
  object PanelSostav: TPanel
    Left = 0
    Top = 354
    Width = 680
    Height = 71
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'PanelSostav'
    Padding.Top = 2
    ShowCaption = False
    TabOrder = 2
    object MemoSostav: TMemo
      Left = 0
      Top = 2
      Width = 680
      Height = 69
      Align = alClient
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
  object PopupMenu: TPopupMenu
    Left = 40
    Top = 144
    object PMOpen: TMenuItem
      Caption = #1054#1090#1082#1088#1099#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090
      OnClick = PMOpenClick
    end
  end
  object ADOQuerySbornik: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    Left = 40
    Top = 32
  end
  object ADOQueryTemp: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    Left = 40
    Top = 96
  end
  object ADOQueryRazdel: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    Left = 136
    Top = 32
  end
  object ADOQueryPodrazdel: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    Left = 236
    Top = 32
  end
  object ADOQueryTable: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    Left = 332
    Top = 32
  end
end
