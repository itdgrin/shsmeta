object fSprSelection: TfSprSelection
  Left = 0
  Top = 0
  Caption = 'fSprSelection'
  ClientHeight = 415
  ClientWidth = 779
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel4: TPanel
    Left = 0
    Top = 382
    Width = 779
    Height = 33
    Align = alBottom
    TabOrder = 0
    ExplicitLeft = -155
    ExplicitTop = 366
    object btnSelect: TButton
      AlignWithMargins = True
      Left = 590
      Top = 4
      Width = 104
      Height = 25
      Align = alRight
      Caption = #1042#1099#1073#1088#1072#1090#1100
      TabOrder = 0
      OnClick = btnSelectClick
    end
    object btnCancel: TButton
      AlignWithMargins = True
      Left = 700
      Top = 4
      Width = 75
      Height = 25
      Align = alRight
      Caption = #1054#1090#1084#1077#1085#1072
      TabOrder = 1
      OnClick = btnCancelClick
    end
  end
end
