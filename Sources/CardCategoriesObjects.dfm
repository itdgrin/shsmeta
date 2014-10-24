object FormCardCategoriesObjects: TFormCardCategoriesObjects
  Left = 0
  Top = 0
  Caption = 'FormCardCategoriesObjects'
  ClientHeight = 71
  ClientWidth = 392
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
    392
    71)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel: TBevel
    Left = 0
    Top = 30
    Width = 392
    Height = 41
    Align = alBottom
    Shape = bsTopLine
    ExplicitLeft = -2
    ExplicitTop = 53
    ExplicitWidth = 394
  end
  object PanelName: TPanel
    Left = 0
    Top = 0
    Width = 392
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    DoubleBuffered = True
    ParentBackground = False
    ParentDoubleBuffered = False
    TabOrder = 0
    DesignSize = (
      392
      25)
    object LabelName: TLabel
      Left = 8
      Top = 5
      Width = 77
      Height = 13
      Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077':'
    end
    object EditName: TEdit
      Left = 91
      Top = 2
      Width = 299
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
    end
  end
  object ButtonSave: TButton
    Left = 180
    Top = 40
    Width = 100
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    Default = True
    TabOrder = 1
    OnClick = ButtonSaveClick
  end
  object ButtonClose: TButton
    Left = 286
    Top = 40
    Width = 100
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 2
    OnClick = ButtonCloseClick
  end
end
