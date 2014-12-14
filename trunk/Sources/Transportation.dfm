object FormTransportation: TFormTransportation
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1055#1077#1088#1077#1074#1086#1079#1082#1072' '#1075#1088#1091#1079#1086#1074
  ClientHeight = 216
  ClientWidth = 645
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  DesignSize = (
    645
    216)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 0
    Top = 175
    Width = 645
    Height = 41
    Align = alBottom
    Shape = bsTopLine
    ExplicitTop = 320
    ExplicitWidth = 560
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 645
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    ShowCaption = False
    TabOrder = 2
    DesignSize = (
      645
      25)
    object LabelJustification: TLabel
      Left = 8
      Top = 8
      Width = 71
      Height = 13
      Caption = #1054#1073#1086#1089#1085#1086#1074#1072#1085#1080#1077':'
    end
    object EditJustificationNumber: TEdit
      Left = 85
      Top = 4
      Width = 69
      Height = 21
      TabStop = False
      Color = 14802912
      ReadOnly = True
      TabOrder = 0
    end
    object EditJustification: TEdit
      Left = 160
      Top = 4
      Width = 482
      Height = 21
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      Color = 14802912
      ReadOnly = True
      TabOrder = 1
    end
  end
  object ButtonCancel: TButton
    Left = 431
    Top = 183
    Width = 100
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 1
    OnClick = ButtonCancelClick
  end
  object Panel2: TPanel
    Left = 0
    Top = 25
    Width = 645
    Height = 145
    Align = alClient
    BevelOuter = bvNone
    ParentBackground = False
    ShowCaption = False
    TabOrder = 0
    TabStop = True
    object LabelDistance: TLabel
      Left = 12
      Top = 67
      Width = 76
      Height = 13
      Caption = #1056#1072#1089#1090#1086#1103#1085#1080#1077', '#1082#1084':'
    end
    object Label7: TLabel
      Left = 10
      Top = 108
      Width = 78
      Height = 19
      Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label9: TLabel
      Left = 103
      Top = 109
      Width = 86
      Height = 19
      Caption = #1073#1077#1079' '#1053#1044#1057', '#1088':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 351
      Top = 109
      Width = 69
      Height = 19
      Caption = #1089' '#1053#1044#1057', '#1088':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 395
      Top = 67
      Width = 47
      Height = 13
      Caption = #1089' '#1053#1044#1057', '#1088':'
    end
    object Label3: TLabel
      Left = 175
      Top = 67
      Width = 53
      Height = 13
      Caption = #1062#1077#1085#1072' '#1079#1072' '#1090'.'
    end
    object Label5: TLabel
      Left = 234
      Top = 67
      Width = 59
      Height = 13
      Caption = #1073#1077#1079' '#1053#1044#1057', '#1088':'
    end
    object Label10: TLabel
      Left = 544
      Top = 67
      Width = 44
      Height = 13
      Caption = #1053#1044#1057', %:'
    end
    object Bevel2: TBevel
      Left = 0
      Top = 58
      Width = 645
      Height = 36
      Align = alTop
      Shape = bsBottomLine
    end
    object EditDistance: TEdit
      Left = 94
      Top = 64
      Width = 59
      Height = 21
      NumbersOnly = True
      TabOrder = 0
      OnChange = EditDistanceChange
    end
    object edtPriceNoNDS: TEdit
      Left = 195
      Top = 106
      Width = 144
      Height = 27
      Color = 8454143
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      NumbersOnly = True
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
    end
    object edtPriceNDS: TEdit
      Left = 424
      Top = 108
      Width = 145
      Height = 27
      Color = 8454143
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      NumbersOnly = True
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
    end
    object GroupBox1: TGroupBox
      Left = 0
      Top = 0
      Width = 645
      Height = 58
      Align = alTop
      Caption = '  '#1043#1088#1091#1079'  '
      TabOrder = 3
      object Label6: TLabel
        Left = 199
        Top = 27
        Width = 41
        Height = 13
        Caption = #1045#1076'. '#1080#1079#1084'.'
      end
      object Label1: TLabel
        Left = 298
        Top = 27
        Width = 64
        Height = 13
        Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object LabelMass: TLabel
        Left = 451
        Top = 27
        Width = 110
        Height = 13
        Caption = #1059#1076#1077#1083#1100#1085#1099#1081' '#1074#1077#1089', '#1082#1075'/'#1084'3:'
      end
      object Label2: TLabel
        Left = 12
        Top = 27
        Width = 33
        Height = 13
        Caption = #1050#1083#1072#1089#1089':'
      end
      object cmbUnit: TComboBox
        Left = 245
        Top = 22
        Width = 41
        Height = 21
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 0
        Text = #1090
        OnChange = cmbUnitChange
        Items.Strings = (
          #1090
          #1084'3')
      end
      object edtCount: TEdit
        Left = 367
        Top = 22
        Width = 66
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnChange = edtCountChange
        OnKeyPress = EditKeyPress
      end
      object edtYDW: TEdit
        Left = 567
        Top = 22
        Width = 65
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnChange = edtCountChange
        OnKeyPress = EditKeyPress
      end
      object cmbClass: TComboBox
        Left = 51
        Top = 22
        Width = 78
        Height = 21
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 3
        Text = 'I'
        OnChange = EditDistanceChange
        Items.Strings = (
          'I'
          'II'
          'III'
          'IV')
      end
    end
    object edtCoastNoNDS: TEdit
      Left = 296
      Top = 64
      Width = 92
      Height = 21
      NumbersOnly = True
      TabOrder = 4
      OnChange = edtCoastNoNDSChange
    end
    object edtCoastNDS: TEdit
      Left = 446
      Top = 64
      Width = 92
      Height = 21
      NumbersOnly = True
      TabOrder = 5
      OnChange = edtCoastNDSChange
    end
    object edtNDS: TEdit
      Left = 594
      Top = 64
      Width = 39
      Height = 21
      NumbersOnly = True
      TabOrder = 6
      OnChange = edtNDSChange
    end
  end
  object PanelBottom: TPanel
    Left = 0
    Top = 170
    Width = 645
    Height = 5
    Align = alBottom
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 3
  end
  object ButtonAdd: TButton
    Left = 537
    Top = 183
    Width = 100
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    TabOrder = 4
    OnClick = ButtonAddClick
  end
  object qrTemp: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    Left = 241
    Top = 169
  end
end
