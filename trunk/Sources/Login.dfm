object FormLogin: TFormLogin
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = ' '#1042#1093#1086#1076' '#1074' '#1087#1088#1086#1075#1088#1072#1084#1084#1091
  ClientHeight = 171
  ClientWidth = 281
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object LabelUsername: TLabel
    Left = 21
    Top = 76
    Width = 97
    Height = 13
    Caption = #1048#1084#1103' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103':'
  end
  object LabelPassword: TLabel
    Left = 21
    Top = 103
    Width = 41
    Height = 13
    Caption = #1055#1072#1088#1086#1083#1100':'
  end
  object Image1: TImage
    Left = 112
    Top = 8
    Width = 48
    Height = 48
  end
  object Bevel2: TBevel
    Left = 6
    Top = 127
    Width = 265
    Height = 5
    Shape = bsBottomLine
    Style = bsRaised
  end
  object EditUsername: TEdit
    Left = 124
    Top = 73
    Width = 147
    Height = 21
    TabOrder = 0
    Text = 'root'
  end
  object EditPassword: TEdit
    Left = 124
    Top = 100
    Width = 147
    Height = 21
    PasswordChar = '*'
    TabOrder = 1
    Text = 'serg'
  end
  object ButtonCancel: TButton
    Left = 30
    Top = 138
    Width = 104
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 2
    OnClick = ButtonCancelClick
  end
  object ButtonConnect: TButton
    Left = 140
    Top = 138
    Width = 104
    Height = 25
    Caption = #1042#1086#1081#1090#1080
    Default = True
    TabOrder = 3
    OnClick = ButtonConnectClick
  end
end
