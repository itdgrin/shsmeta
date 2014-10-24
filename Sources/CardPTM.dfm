object FormCardPTM: TFormCardPTM
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1050#1072#1088#1090#1086#1095#1082#1072' '#1055#1058#1052
  ClientHeight = 221
  ClientWidth = 535
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  DesignSize = (
    535
    221)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 0
    Top = 180
    Width = 535
    Height = 41
    Align = alBottom
    Shape = bsTopLine
    ExplicitTop = 187
    ExplicitWidth = 810
  end
  object PanelObject: TPanel
    Left = 0
    Top = 0
    Width = 535
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 0
    DesignSize = (
      535
      25)
    object LabelObject: TLabel
      Left = 19
      Top = 5
      Width = 43
      Height = 13
      Caption = #1054#1073#1098#1077#1082#1090':'
    end
    object EditObject: TEdit
      Left = 68
      Top = 2
      Width = 464
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      Color = 14802912
      ReadOnly = True
      TabOrder = 0
    end
  end
  object PanelCountAndUnit: TPanel
    Left = 0
    Top = 150
    Width = 535
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 6
    object LabelCount: TLabel
      Left = 23
      Top = 5
      Width = 39
      Height = 13
      Caption = #1050#1086#1083'-'#1074#1086':'
    end
    object LabelUnit: TLabel
      Left = 144
      Top = 5
      Width = 103
      Height = 13
      Caption = #1045#1076#1080#1085#1080#1094#1072' '#1080#1079#1084#1077#1088#1077#1085#1080#1103':'
    end
    object EditCount: TEdit
      Left = 68
      Top = 2
      Width = 70
      Height = 21
      TabOrder = 0
    end
    object EditUnit: TEdit
      Left = 253
      Top = 2
      Width = 200
      Height = 21
      TabOrder = 1
    end
  end
  object PanelPTMAndName: TPanel
    Left = 0
    Top = 125
    Width = 535
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 5
    DesignSize = (
      535
      25)
    object LabelPTM: TLabel
      Left = 37
      Top = 5
      Width = 25
      Height = 13
      Caption = #1055#1058#1052':'
    end
    object LabelName: TLabel
      Left = 274
      Top = 5
      Width = 52
      Height = 13
      Caption = #1053#1072#1079#1074#1072#1085#1080#1077':'
    end
    object EditPTM: TEdit
      Left = 68
      Top = 2
      Width = 200
      Height = 21
      TabOrder = 0
    end
    object EditName: TEdit
      Left = 332
      Top = 2
      Width = 200
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 1
    end
  end
  object PanelPart: TPanel
    Left = 0
    Top = 50
    Width = 535
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 2
    DesignSize = (
      535
      25)
    object LabelPart: TLabel
      Left = 28
      Top = 5
      Width = 34
      Height = 13
      Caption = #1063#1072#1089#1090#1100':'
    end
    object ComboBoxPart: TComboBox
      Left = 68
      Top = 2
      Width = 464
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
    end
  end
  object PanelEstimate: TPanel
    Left = 0
    Top = 25
    Width = 535
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 1
    DesignSize = (
      535
      25)
    object LabelEstimate: TLabel
      Left = 27
      Top = 5
      Width = 35
      Height = 13
      Caption = #1057#1084#1077#1090#1072':'
    end
    object EditEstimate: TEdit
      Left = 68
      Top = 0
      Width = 464
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      Color = 14802912
      ReadOnly = True
      TabOrder = 0
    end
  end
  object ButtonCancel: TButton
    Left = 427
    Top = 188
    Width = 100
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 8
    OnClick = ButtonCancelClick
  end
  object ButtonSave: TButton
    Left = 321
    Top = 188
    Width = 100
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    Default = True
    TabOrder = 7
    OnClick = ButtonSaveClick
  end
  object PanelTypeWork: TPanel
    Left = 0
    Top = 100
    Width = 535
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 4
    DesignSize = (
      535
      25)
    object LabelTypeWork: TLabel
      Left = 6
      Top = 5
      Width = 56
      Height = 13
      Caption = #1042#1080#1076' '#1088#1072#1073#1086#1090':'
    end
    object ComboBoxTypeWork: TComboBox
      Left = 68
      Top = 2
      Width = 464
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
    end
  end
  object PanelSection: TPanel
    Left = 0
    Top = 75
    Width = 535
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 3
    DesignSize = (
      535
      25)
    object LabelSection: TLabel
      Left = 22
      Top = 5
      Width = 40
      Height = 13
      Caption = #1056#1072#1079#1076#1077#1083':'
    end
    object ComboBoxSection: TComboBox
      Left = 68
      Top = 2
      Width = 464
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
    end
  end
  object ADOQueryTemp: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    Left = 65
    Top = 105
  end
end
