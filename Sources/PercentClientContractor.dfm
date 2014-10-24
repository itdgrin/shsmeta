object FormPercentClientContractor: TFormPercentClientContractor
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = ' '#1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1084#1072#1090#1077#1088#1080#1072#1083#1086#1074' '#1080' '#1090#1088#1072#1085#1089#1087#1086#1088#1090#1072
  ClientHeight = 157
  ClientWidth = 281
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
    281
    157)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 0
    Top = 116
    Width = 281
    Height = 41
    Align = alBottom
    Shape = bsTopLine
    ExplicitLeft = -355
    ExplicitTop = 105
    ExplicitWidth = 648
  end
  object ButtonSave: TButton
    Left = 173
    Top = 124
    Width = 100
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100
    Default = True
    TabOrder = 1
    OnClick = ButtonSaveClick
  end
  object GroupBoxPercent: TGroupBox
    Left = 8
    Top = 8
    Width = 265
    Height = 101
    Caption = '% c'#1086#1086#1090#1085#1086#1096#1077#1085#1080#1077
    TabOrder = 0
    object LabelClient: TLabel
      Left = 76
      Top = 20
      Width = 54
      Height = 13
      Caption = #1047#1072#1082#1072#1079#1095#1080#1082
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = LabelClientClick
      OnMouseEnter = LabelMouseEnter
      OnMouseLeave = LabelMouseLeave
    end
    object LabelContractor: TLabel
      Left = 181
      Top = 20
      Width = 67
      Height = 13
      Caption = #1055#1086#1076#1088#1103#1076#1095#1080#1082
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = LabelContractorClick
      OnMouseEnter = LabelMouseEnter
      OnMouseLeave = LabelMouseLeave
    end
    object LabelPMC: TLabel
      Left = 122
      Top = 45
      Width = 11
      Height = 13
      Caption = '%'
    end
    object LabelPTC: TLabel
      Left = 122
      Top = 72
      Width = 11
      Height = 13
      Caption = '%'
    end
    object LabelPMCon: TLabel
      Left = 227
      Top = 45
      Width = 11
      Height = 13
      Caption = '%'
    end
    object LabelPTCon: TLabel
      Left = 227
      Top = 72
      Width = 11
      Height = 13
      Caption = '%'
    end
    object LabelMaterials: TLabel
      Left = 8
      Top = 45
      Width = 62
      Height = 13
      Caption = #1052#1072#1090#1077#1088#1080#1072#1083#1099':'
    end
    object LabelTransport: TLabel
      Left = 13
      Top = 72
      Width = 57
      Height = 13
      Caption = #1058#1088#1072#1085#1089#1087#1086#1088#1090':'
    end
    object SpeedButtonMaterial: TSpeedButton
      Left = 144
      Top = 39
      Width = 24
      Height = 24
      OnClick = SpeedButtonMaterialClick
    end
    object SpeedButtonTransport: TSpeedButton
      Left = 144
      Top = 69
      Width = 24
      Height = 24
      OnClick = SpeedButtonTransportClick
    end
    object EditMCon: TEdit
      Tag = 2
      Left = 181
      Top = 42
      Width = 40
      Height = 21
      TabOrder = 1
      Text = '0'
      OnChange = EditChange
      OnKeyPress = EditKeyPress
    end
    object EditMC: TEdit
      Tag = 1
      Left = 76
      Top = 42
      Width = 40
      Height = 21
      TabOrder = 0
      Text = '100'
      OnChange = EditChange
      OnKeyPress = EditKeyPress
    end
    object EditTC: TEdit
      Tag = 1
      Left = 76
      Top = 69
      Width = 40
      Height = 21
      TabOrder = 2
      Text = '100'
      OnChange = EditTCChange
      OnKeyPress = EditKeyPress
    end
    object EditTCon: TEdit
      Tag = 2
      Left = 181
      Top = 69
      Width = 40
      Height = 21
      TabOrder = 3
      Text = '0'
      OnChange = EditTCChange
      OnKeyPress = EditKeyPress
    end
  end
  object ButtonCancel: TButton
    Left = 67
    Top = 124
    Width = 100
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 2
    OnClick = ButtonCancelClick
  end
end
