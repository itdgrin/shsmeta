object fSSR: TfSSR
  Left = 0
  Top = 0
  Caption = 'SSR'
  ClientHeight = 512
  ClientWidth = 984
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
  object pnlBottons: TPanel
    Left = 0
    Top = 471
    Width = 984
    Height = 41
    Align = alBottom
    TabOrder = 0
    DesignSize = (
      984
      41)
    object btnSelect: TButton
      Left = 789
      Top = 8
      Width = 98
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #1042#1099#1073#1088#1072#1090#1100
      ModalResult = 1
      TabOrder = 0
    end
    object btnCancel: TButton
      Left = 893
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #1054#1090#1084#1077#1085#1072
      ModalResult = 8
      TabOrder = 1
    end
  end
end
