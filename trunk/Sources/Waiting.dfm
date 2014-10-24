object FormWaiting: TFormWaiting
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'FormWaiting'
  ClientHeight = 88
  ClientWidth = 300
  Color = clBtnFace
  TransparentColor = True
  TransparentColorValue = clGreen
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Shape1: TShape
    Left = 0
    Top = 0
    Width = 300
    Height = 88
    Brush.Color = clBtnFace
    Pen.Color = clGradientActiveCaption
    Pen.Width = 2
  end
  object Label1: TLabel
    Left = 67
    Top = 45
    Width = 165
    Height = 26
    Alignment = taCenter
    Caption = #1055#1086#1078#1072#1083#1091#1081#1089#1090#1072' '#1087#1086#1076#1086#1078#1076#1080#1090#1077'. '#1048#1076#1105#1090' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1077' '#1079#1072#1087#1088#1086#1089#1072'...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object Image: TImage
    Left = 46
    Top = 20
    Width = 208
    Height = 13
  end
end
