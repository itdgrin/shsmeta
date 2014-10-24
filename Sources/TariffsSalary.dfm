object FormTariffsSalary: TFormTariffsSalary
  Left = 0
  Top = 0
  Caption = #1058#1072#1088#1080#1092#1099' '#1087#1086' '#1079#1072#1088#1087#1083#1072#1090#1077
  ClientHeight = 400
  ClientWidth = 600
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
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter: TSplitter
    Left = 300
    Top = 25
    Height = 346
    ExplicitLeft = 345
    ExplicitTop = 0
    ExplicitHeight = 405
  end
  object PanelLeft: TPanel
    Left = 0
    Top = 25
    Width = 300
    Height = 346
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 0
    object DBGrid1: TDBGrid
      Left = 0
      Top = 0
      Width = 300
      Height = 346
      Align = alClient
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
  end
  object PanelRight: TPanel
    Left = 303
    Top = 25
    Width = 297
    Height = 346
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object DBGrid2: TDBGrid
      Left = 0
      Top = 0
      Width = 297
      Height = 346
      Align = alClient
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
  end
  object PanelBottom: TPanel
    Left = 0
    Top = 371
    Width = 600
    Height = 29
    Align = alBottom
    ParentBackground = False
    TabOrder = 2
    DesignSize = (
      600
      29)
    object BitBtnFind: TBitBtn
      Left = 4
      Top = 2
      Width = 150
      Height = 25
      Anchors = [akLeft]
      Caption = 'F6 '#1055#1086#1080#1089#1082
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 0
    end
    object BitBtnLoad: TBitBtn
      Left = 160
      Top = 2
      Width = 150
      Height = 25
      Anchors = [akLeft]
      Caption = #1047#1072#1075#1088#1091#1079#1082#1072
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 1
    end
  end
  object PanelTop: TPanel
    Left = 0
    Top = 0
    Width = 600
    Height = 25
    Align = alTop
    BevelOuter = bvLowered
    DoubleBuffered = True
    ParentBackground = False
    ParentDoubleBuffered = False
    TabOrder = 3
    object LabelData: TLabel
      Left = 8
      Top = 5
      Width = 97
      Height = 13
      Caption = #1048#1089#1093#1086#1076#1085#1099#1077' '#1076#1072#1085#1085#1099#1077':'
    end
    object EditVAT: TEdit
      Left = 237
      Top = 2
      Width = 65
      Height = 21
      Alignment = taCenter
      Color = 13619151
      ReadOnly = True
      TabOrder = 0
      Text = #1073#1077#1079' '#1053#1044#1057
    end
    object EditMonth: TEdit
      Left = 111
      Top = 2
      Width = 120
      Height = 21
      Alignment = taCenter
      Color = 13619151
      ReadOnly = True
      TabOrder = 1
      Text = #1071#1085#1074#1072#1088#1100' 2012 '#1075#1086#1076#1072
    end
  end
end
