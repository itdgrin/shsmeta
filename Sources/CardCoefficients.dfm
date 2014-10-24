object FormCardCoefficients: TFormCardCoefficients
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1050#1072#1088#1090#1086#1095#1082#1072' '#1082#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090#1086#1074
  ClientHeight = 229
  ClientWidth = 295
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    295
    229)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel: TBevel
    Left = 0
    Top = 188
    Width = 295
    Height = 41
    Align = alBottom
    Shape = bsTopLine
    ExplicitLeft = -130
    ExplicitTop = 129
    ExplicitWidth = 592
  end
  object MemoName: TMemo
    Left = 0
    Top = 25
    Width = 295
    Height = 46
    Align = alTop
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object PanelSeparator: TPanel
    Left = 0
    Top = 71
    Width = 295
    Height = 3
    Align = alTop
    BevelOuter = bvNone
    Caption = 'PanelSeparator'
    ShowCaption = False
    TabOrder = 4
  end
  object ButtonSave: TButton
    Left = 81
    Top = 196
    Width = 100
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    Default = True
    TabOrder = 2
    OnClick = ButtonSaveClick
  end
  object ButtonClose: TButton
    Left = 187
    Top = 196
    Width = 100
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 3
    OnClick = ButtonCloseClick
  end
  object PanelName: TPanel
    Left = 0
    Top = 0
    Width = 295
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    Caption = 'PanelName'
    ShowCaption = False
    TabOrder = 5
    object LabelName: TLabel
      Left = 8
      Top = 6
      Width = 155
      Height = 13
      Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1082#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090#1072':'
    end
  end
  object StringGrid: TStringGrid
    Left = 0
    Top = 74
    Width = 295
    Height = 109
    Align = alTop
    ColCount = 2
    DefaultRowHeight = 20
    DefaultDrawing = False
    FixedRows = 0
    TabOrder = 1
    OnDrawCell = StringGridDrawCell
  end
end
