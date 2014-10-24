object FormTransportation: TFormTransportation
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1055#1077#1088#1077#1074#1086#1079#1082#1072' '#1075#1088#1091#1079#1086#1074
  ClientHeight = 205
  ClientWidth = 644
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    644
    205)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 0
    Top = 164
    Width = 644
    Height = 41
    Align = alBottom
    Shape = bsTopLine
    ExplicitTop = 320
    ExplicitWidth = 560
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 644
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    ShowCaption = False
    TabOrder = 5
    DesignSize = (
      644
      25)
    object LabelJustification: TLabel
      Left = 8
      Top = 6
      Width = 71
      Height = 13
      Caption = #1054#1073#1086#1089#1085#1086#1074#1072#1085#1080#1077':'
    end
    object EditJustificationNumber: TEdit
      Left = 85
      Top = 2
      Width = 50
      Height = 21
      TabStop = False
      Color = 14802912
      ReadOnly = True
      TabOrder = 0
    end
    object EditJustification: TEdit
      Left = 141
      Top = 2
      Width = 500
      Height = 21
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      Color = 14802912
      ReadOnly = True
      TabOrder = 1
    end
  end
  object PanelTable: TPanel
    Left = 0
    Top = 50
    Width = 320
    Height = 109
    Align = alLeft
    BevelOuter = bvNone
    ParentBackground = False
    ShowCaption = False
    TabOrder = 1
    object StringGrid: TStringGrid
      Left = 0
      Top = 0
      Width = 320
      Height = 109
      Align = alClient
      ColCount = 3
      DefaultRowHeight = 20
      DefaultDrawing = False
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
      ScrollBars = ssNone
      TabOrder = 0
      OnClick = StringGridClick
      OnDblClick = StringGridDblClick
      OnDrawCell = StringGridDrawCell
      OnEnter = StringGridRepaint
      OnExit = StringGridExit
      RowHeights = (
        20
        20
        20
        20
        20)
    end
  end
  object ButtonAdd: TButton
    Left = 536
    Top = 172
    Width = 100
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    Default = True
    TabOrder = 3
    OnClick = ButtonAddClick
  end
  object ButtonCancel: TButton
    Left = 430
    Top = 172
    Width = 100
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 4
    OnClick = ButtonCancelClick
  end
  object PanelMemo: TPanel
    Left = 325
    Top = 50
    Width = 319
    Height = 109
    Align = alClient
    BevelOuter = bvNone
    ParentBackground = False
    ShowCaption = False
    TabOrder = 2
    object Memo: TMemo
      Left = 0
      Top = 0
      Width = 319
      Height = 109
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 0
      ExplicitLeft = 1
      ExplicitTop = -1
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 25
    Width = 644
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    ShowCaption = False
    TabOrder = 0
    TabStop = True
    object LabelDistance: TLabel
      Left = 8
      Top = 6
      Width = 76
      Height = 13
      Caption = #1056#1072#1089#1090#1086#1103#1085#1080#1077', '#1082#1084':'
    end
    object LabelCount: TLabel
      Left = 136
      Top = 6
      Width = 47
      Height = 13
      Caption = #1052#1072#1089#1089#1072', '#1090':'
    end
    object LabelCostNoVAT: TLabel
      Left = 239
      Top = 6
      Width = 128
      Height = 13
      Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1073#1077#1079' '#1053#1044#1057', '#1088#1091#1073':'
    end
    object LabelCostVAT: TLabel
      Left = 449
      Top = 6
      Width = 116
      Height = 13
      Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1089' '#1053#1044#1057', '#1088#1091#1073':'
    end
    object EditDistance: TEdit
      Left = 90
      Top = 2
      Width = 40
      Height = 21
      TabOrder = 0
      OnChange = EditDistanceChange
      OnKeyPress = EditKeyPress
    end
    object EditMass: TEdit
      Left = 189
      Top = 2
      Width = 40
      Height = 21
      TabOrder = 1
      OnChange = EditMassChange
      OnKeyPress = EditKeyPress
    end
    object EditCostNoVAT: TEdit
      Left = 373
      Top = 2
      Width = 70
      Height = 21
      TabStop = False
      Color = 14802912
      ReadOnly = True
      TabOrder = 2
    end
    object EditCostVAT: TEdit
      Left = 571
      Top = 2
      Width = 70
      Height = 21
      TabStop = False
      Color = 14802912
      ReadOnly = True
      TabOrder = 3
    end
  end
  object PanelCenter: TPanel
    Left = 320
    Top = 50
    Width = 5
    Height = 109
    Align = alLeft
    BevelOuter = bvNone
    ParentBackground = False
    ShowCaption = False
    TabOrder = 6
  end
  object PanelBottom: TPanel
    Left = 0
    Top = 159
    Width = 644
    Height = 5
    Align = alBottom
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 7
  end
  object ADOQueryTemp: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    Left = 377
    Top = 73
  end
end
