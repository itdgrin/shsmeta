object FormReplacementMaterial: TFormReplacementMaterial
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1047#1072#1084#1077#1085#1072' '#1085#1077#1091#1095#1090#1105#1085#1085#1099#1093' '#1084#1072#1090#1077#1088#1080#1072#1083#1086#1074
  ClientHeight = 77
  ClientWidth = 335
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    335
    77)
  PixelsPerInch = 96
  TextHeight = 13
  object LabelCode: TLabel
    Left = 8
    Top = 11
    Width = 126
    Height = 13
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1082#1086#1076' '#1084#1072#1090#1077#1088#1080#1072#1083#1072':'
  end
  object Bevel1: TBevel
    Left = 0
    Top = 36
    Width = 335
    Height = 41
    Align = alBottom
    Shape = bsTopLine
    ExplicitTop = 41
  end
  object EditCode: TEdit
    Left = 140
    Top = 8
    Width = 187
    Height = 21
    TabOrder = 0
    OnEnter = EditCodeEnter
  end
  object ButtonReplacement: TButton
    Left = 121
    Top = 44
    Width = 100
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1047#1072#1084#1077#1085#1080#1090#1100
    Default = True
    TabOrder = 1
    OnClick = ButtonReplacementClick
  end
  object ButtonCancel: TButton
    Left = 227
    Top = 44
    Width = 100
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 2
    OnClick = ButtonCancelClick
  end
  object ADOQuery: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    Left = 65
    Top = 9
  end
end
