object FormCardEstimate: TFormCardEstimate
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1050#1072#1088#1090#1086#1095#1082#1072' '#1089#1084#1077#1090#1099
  ClientHeight = 253
  ClientWidth = 604
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    604
    253)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel: TBevel
    Left = 0
    Top = 212
    Width = 604
    Height = 41
    Align = alBottom
    Shape = bsTopLine
    ExplicitTop = 201
    ExplicitWidth = 592
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 604
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 0
    object LabelNumberChapter: TLabel
      Left = 189
      Top = 5
      Width = 74
      Height = 13
      Caption = #8470' '#1075#1083#1072#1074#1099' '#1057#1057#1056':'
    end
    object LabelNumberRow: TLabel
      Left = 390
      Top = 5
      Width = 55
      Height = 13
      Caption = #8470' '#1089#1090#1088#1086#1082#1080':'
    end
    object LabelNumberEstimate: TLabel
      Left = 11
      Top = 5
      Width = 51
      Height = 13
      Caption = #8470' '#1089#1084#1077#1090#1099':'
    end
    object EditNumberChapter: TEdit
      Left = 269
      Top = 2
      Width = 115
      Height = 21
      TabOrder = 0
    end
    object EditNumberRow: TEdit
      Left = 451
      Top = 2
      Width = 115
      Height = 21
      TabOrder = 1
    end
    object EditNumberEstimate: TEdit
      Left = 68
      Top = 2
      Width = 115
      Height = 21
      Color = 14802912
      ReadOnly = True
      TabOrder = 2
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 100
    Width = 604
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 1
    DesignSize = (
      604
      25)
    object LabelNameEstimate: TLabel
      Left = 10
      Top = 5
      Width = 52
      Height = 13
      Caption = #1053#1072#1079#1074#1072#1085#1080#1077':'
    end
    object EditNameEstimate: TEdit
      Left = 68
      Top = 2
      Width = 533
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 125
    Width = 604
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 2
    object LabelCompose: TLabel
      Left = 10
      Top = 5
      Width = 52
      Height = 13
      Caption = #1057#1086#1089#1090#1072#1074#1080#1083':'
    end
    object LabelPostCompose: TLabel
      Left = 304
      Top = 5
      Width = 61
      Height = 13
      Caption = #1044#1086#1083#1078#1085#1086#1089#1090#1100':'
    end
    object EditCompose: TEdit
      Left = 68
      Top = 2
      Width = 230
      Height = 21
      TabOrder = 0
    end
    object EditPostCompose: TEdit
      Left = 371
      Top = 2
      Width = 230
      Height = 21
      TabOrder = 1
    end
  end
  object Panel4: TPanel
    Left = 0
    Top = 150
    Width = 604
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 3
    object LabelChecked: TLabel
      Left = 9
      Top = 5
      Width = 53
      Height = 13
      Caption = #1055#1088#1086#1074#1077#1088#1080#1083':'
    end
    object LabelPostChecked: TLabel
      Left = 304
      Top = 5
      Width = 61
      Height = 13
      Caption = #1044#1086#1083#1078#1085#1086#1089#1090#1100':'
    end
    object EditChecked: TEdit
      Left = 68
      Top = 2
      Width = 230
      Height = 21
      TabOrder = 0
    end
    object EditPostChecked: TEdit
      Left = 371
      Top = 2
      Width = 230
      Height = 21
      TabOrder = 1
    end
  end
  object Panel5: TPanel
    Left = 0
    Top = 175
    Width = 604
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 4
    DesignSize = (
      604
      25)
    object LabelSetDrawing: TLabel
      Left = 6
      Top = 5
      Width = 106
      Height = 13
      Caption = #1050#1086#1084#1087#1083#1077#1082#1090' '#1095#1077#1088#1090#1077#1078#1077#1081':'
    end
    object EditSetDrawing: TEdit
      Left = 118
      Top = 2
      Width = 483
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
    end
  end
  object ButtonSave: TButton
    Left = 390
    Top = 220
    Width = 100
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    Default = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    OnClick = ButtonSaveClick
  end
  object ButtonClose: TButton
    Left = 496
    Top = 220
    Width = 100
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 6
    OnClick = ButtonCloseClick
  end
  object PanelPart: TPanel
    Left = 0
    Top = 25
    Width = 604
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 7
    DesignSize = (
      604
      25)
    object LabelPart: TLabel
      Left = 28
      Top = 5
      Width = 34
      Height = 13
      Caption = #1063#1072#1089#1090#1100':'
    end
    object ComboBoxPart: TComboBox
      Tag = 1
      Left = 68
      Top = 2
      Width = 533
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      OnChange = ComboBoxChange
    end
  end
  object PanelSection: TPanel
    Left = 0
    Top = 50
    Width = 604
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 8
    DesignSize = (
      604
      25)
    object LabelSection: TLabel
      Left = 22
      Top = 5
      Width = 40
      Height = 13
      Caption = #1056#1072#1079#1076#1077#1083':'
    end
    object ComboBoxSection: TComboBox
      Tag = 2
      Left = 68
      Top = 2
      Width = 533
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      OnChange = ComboBoxChange
    end
  end
  object PanelTypeWork: TPanel
    Left = 0
    Top = 75
    Width = 604
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 9
    DesignSize = (
      604
      25)
    object LabelTypeWork: TLabel
      Left = 6
      Top = 5
      Width = 56
      Height = 13
      Caption = #1042#1080#1076' '#1088#1072#1073#1086#1090':'
    end
    object ComboBoxTypeWork: TComboBox
      Tag = 3
      Left = 68
      Top = 2
      Width = 533
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      OnChange = ComboBoxChange
    end
  end
  object ADOQueryTemp: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    Left = 33
    Top = 200
  end
end
