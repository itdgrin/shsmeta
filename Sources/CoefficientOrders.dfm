object FormCoefficientOrders: TFormCoefficientOrders
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1050#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090' '#1087#1086' '#1087#1088#1080#1082#1072#1079#1072#1084
  ClientHeight = 129
  ClientWidth = 265
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
    265
    129)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel: TBevel
    Left = 0
    Top = 88
    Width = 265
    Height = 41
    Align = alBottom
    Shape = bsTopLine
    ExplicitLeft = -386
    ExplicitTop = 119
    ExplicitWidth = 651
  end
  object CheckBoxAll: TCheckBox
    Left = 8
    Top = 8
    Width = 177
    Height = 17
    Caption = #1059#1095#1080#1090#1099#1074#1072#1090#1100' '#1074#1086' '#1074#1089#1077#1093' '#1088#1072#1089#1094#1077#1085#1082#1072#1093
    TabOrder = 0
    Visible = False
  end
  object CheckBoxNone: TCheckBox
    Left = 8
    Top = 31
    Width = 129
    Height = 17
    Caption = #1053#1080#1075#1076#1077' '#1085#1077' '#1091#1095#1080#1090#1099#1074#1072#1090#1100
    TabOrder = 1
    Visible = False
  end
  object CheckBoxInThis: TCheckBox
    Left = 8
    Top = 54
    Width = 209
    Height = 17
    Caption = #1059#1095#1080#1090#1099#1074#1072#1090#1100' '#1090#1086#1083#1100#1082#1086' '#1074' '#1101#1090#1086#1081' '#1088#1072#1089#1094#1077#1085#1082#1077
    TabOrder = 2
    Visible = False
  end
  object RadioGroupCoefOrders: TRadioGroup
    Left = 8
    Top = 8
    Width = 249
    Height = 73
    Caption = #1042' '#1101#1090#1086#1081' '#1088#1072#1089#1094#1077#1085#1082#1077' '#1082#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090
    ItemIndex = 0
    Items.Strings = (
      #1055#1088#1080#1084#1077#1085#1103#1090#1100
      #1053#1077' '#1087#1088#1080#1084#1077#1085#1103#1090#1100)
    TabOrder = 3
  end
  object ButtonSave: TButton
    Left = 51
    Top = 96
    Width = 100
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    Default = True
    TabOrder = 4
    OnClick = ButtonSaveClick
  end
  object ButtonClose: TButton
    Left = 157
    Top = 96
    Width = 100
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 5
    OnClick = ButtonCloseClick
  end
  object ADOQueryTemp: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    Left = 196
    Top = 16
  end
end
