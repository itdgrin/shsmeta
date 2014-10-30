object fKC6Journal: TfKC6Journal
  Left = 0
  Top = 0
  Caption = #1046#1091#1088#1085#1072#1083' '#1050#1057'-6'
  ClientHeight = 400
  ClientWidth = 503
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Visible = True
  OnClose = FormClose
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object pgc1: TPageControl
    Left = 8
    Top = 24
    Width = 289
    Height = 193
    ActivePage = ts1
    Style = tsFlatButtons
    TabOrder = 0
    object ts1: TTabSheet
      Caption = 'ts1'
    end
    object ts2: TTabSheet
      Caption = 'ts2'
      ImageIndex = 1
    end
  end
end
