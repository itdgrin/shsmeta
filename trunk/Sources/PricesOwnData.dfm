object FormPricesOwnData: TFormPricesOwnData
  Left = 0
  Top = 0
  ClientHeight = 436
  ClientWidth = 974
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Visible = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnDestroy = FormDestroy
  OnPaint = FormPaint
  PixelsPerInch = 96
  TextHeight = 13
  object PanelPrices: TPanel
    Left = 0
    Top = 0
    Width = 974
    Height = 27
    Align = alTop
    BevelOuter = bvNone
    Ctl3D = True
    DoubleBuffered = True
    ParentBackground = False
    ParentCtl3D = False
    ParentDoubleBuffered = False
    TabOrder = 0
    object SpeedButtonTariffs: TSpeedButton
      Left = 1
      Top = 1
      Width = 120
      Height = 25
      GroupIndex = 1
      Caption = #1058#1072#1088#1080#1092#1099' '#1087#1086' ...'
      Enabled = False
    end
    object SpeedButtonPriceMaterials: TSpeedButton
      Left = 122
      Top = 1
      Width = 120
      Height = 25
      GroupIndex = 1
      Down = True
      Caption = #1062#1077#1085#1099' '#1085#1072' '#1084#1072#1090#1077#1088#1080#1072#1083#1099
      OnClick = SpeedButtonMaterialsClick
    end
    object SpeedButtonPriceMechanizms: TSpeedButton
      Left = 243
      Top = 1
      Width = 120
      Height = 25
      GroupIndex = 1
      Caption = #1062#1077#1085#1099' '#1085#1072' '#1084#1077#1093#1072#1085#1080#1079#1084#1099
      OnClick = SpeedButtonMechanizmsClick
    end
    object SpeedButtonPriceTransportation: TSpeedButton
      Left = 364
      Top = 1
      Width = 120
      Height = 25
      GroupIndex = 1
      Caption = #1058#1072#1088'. '#1087#1086' '#1075#1088#1091#1079#1086#1087#1077#1088#1077#1074#1086#1079'.'
      OnClick = SpeedButtonPriceTransportationClick
    end
    object SpeedButtonPriceDumps: TSpeedButton
      Left = 485
      Top = 1
      Width = 120
      Height = 25
      GroupIndex = 1
      Caption = #1058#1072#1088#1080#1092#1099' '#1087#1086' '#1089#1074#1072#1083#1082#1072#1084
      OnClick = SpeedButtonPriceDumpsClick
    end
    object SpeedButtonIndex: TSpeedButton
      Left = 606
      Top = 1
      Width = 120
      Height = 25
      GroupIndex = 1
      Caption = #1057#1090#1072#1090#1080#1089#1090#1080#1095'. '#1080#1085#1076#1077#1082#1089#1099
      Enabled = False
    end
  end
end
