object FormCardAct: TFormCardAct
  Left = 0
  Top = 0
  BiDiMode = bdLeftToRight
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1050#1072#1088#1090#1086#1095#1082#1072' '#1072#1082#1090#1072
  ClientHeight = 153
  ClientWidth = 392
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  ParentBiDiMode = False
  OnShow = FormShow
  DesignSize = (
    392
    153)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel: TBevel
    Left = 0
    Top = 112
    Width = 392
    Height = 41
    Align = alBottom
    Shape = bsTopLine
    ExplicitLeft = -175
    ExplicitTop = 110
    ExplicitWidth = 604
  end
  object ButtonSave: TButton
    Left = 178
    Top = 120
    Width = 100
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    Default = True
    TabOrder = 0
    OnClick = ButtonSaveClick
  end
  object ButtonClose: TButton
    Left = 284
    Top = 120
    Width = 100
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 1
    OnClick = ButtonCloseClick
  end
  object PanelDate: TPanel
    Left = 0
    Top = 0
    Width = 392
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    Caption = 'PanelDate'
    ShowCaption = False
    TabOrder = 2
    object LabelDate: TLabel
      Left = 6
      Top = 5
      Width = 97
      Height = 13
      Caption = #1044#1072#1090#1072' '#1089#1086#1089#1090#1072#1074#1083#1077#1085#1080#1103':'
    end
    object EditDate: TEdit
      Left = 109
      Top = 2
      Width = 280
      Height = 21
      TabStop = False
      Color = 14802912
      ReadOnly = True
      TabOrder = 0
    end
  end
  object PanelDescription: TPanel
    Left = 0
    Top = 50
    Width = 392
    Height = 50
    Align = alTop
    BevelOuter = bvNone
    Caption = 'PanelDescription'
    ShowCaption = False
    TabOrder = 3
    object LabelDescription: TLabel
      Left = 6
      Top = 16
      Width = 53
      Height = 13
      Caption = #1054#1087#1080#1089#1072#1085#1080#1077':'
    end
    object MemoDescription: TMemo
      Left = 65
      Top = 4
      Width = 325
      Height = 46
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
  object PanelName: TPanel
    Left = 0
    Top = 25
    Width = 392
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    Caption = 'PanelName'
    ShowCaption = False
    TabOrder = 4
    object LabelName: TLabel
      Left = 7
      Top = 5
      Width = 52
      Height = 13
      Caption = #1053#1072#1079#1074#1072#1085#1080#1077':'
    end
    object EditName: TEdit
      Left = 65
      Top = 2
      Width = 324
      Height = 21
      TabOrder = 0
    end
  end
  object ADOQueryTemp: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    Left = 28
    Top = 88
  end
end
