object FormCalculationDump: TFormCalculationDump
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1056#1072#1089#1095#1105#1090' '#1089#1074#1072#1083#1082#1080
  ClientHeight = 282
  ClientWidth = 582
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  DesignSize = (
    582
    282)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 0
    Top = 241
    Width = 582
    Height = 41
    Align = alBottom
    Shape = bsTopLine
    ExplicitTop = 247
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 582
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    ShowCaption = False
    TabOrder = 4
    DesignSize = (
      582
      25)
    object LabelJustification: TLabel
      Left = 8
      Top = 6
      Width = 71
      Height = 13
      Caption = #1054#1073#1086#1089#1085#1086#1074#1072#1085#1080#1077':'
    end
    object EditJustificationNumber: TEdit
      Left = 85
      Top = 2
      Width = 80
      Height = 21
      TabStop = False
      Color = 14802912
      TabOrder = 0
      Text = #1041#1057'999-9901'
    end
    object EditJustification: TEdit
      Left = 171
      Top = 2
      Width = 408
      Height = 21
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      Color = 14802912
      TabOrder = 1
      Text = #1055#1083#1072#1090#1072' '#1079#1072' '#1087#1088#1080#1105#1084' '#1080' '#1079#1072#1093#1086#1088#1086#1085#1077#1085#1080#1077' '#1086#1090#1093#1086#1076#1086#1074' ('#1089#1090#1088#1086#1080#1090#1077#1083#1100#1085#1086#1075#1086' '#1084#1091#1089#1086#1088#1072')'
    end
  end
  object PanelMemo: TPanel
    Left = 0
    Top = 183
    Width = 582
    Height = 58
    Align = alBottom
    BevelOuter = bvNone
    ParentBackground = False
    ShowCaption = False
    TabOrder = 1
    object Memo: TMemo
      Left = 0
      Top = 0
      Width = 582
      Height = 58
      Align = alClient
      Lines.Strings = (
        'Memo')
      TabOrder = 0
    end
  end
  object ButtonCancel: TButton
    Left = 368
    Top = 249
    Width = 100
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 3
    OnClick = ButtonCancelClick
  end
  object ButtonSave: TButton
    Left = 474
    Top = 249
    Width = 100
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    Default = True
    TabOrder = 2
    OnClick = ButtonSaveClick
  end
  object Panel2: TPanel
    Left = 0
    Top = 25
    Width = 582
    Height = 24
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    ShowCaption = False
    TabOrder = 0
    TabStop = True
    object LabelND: TLabel
      Left = 8
      Top = 6
      Width = 90
      Height = 13
      Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1089#1074#1072#1083#1082#1080':'
    end
    object DBLookupComboBoxND: TDBLookupComboBox
      Left = 104
      Top = 2
      Width = 475
      Height = 21
      ListSource = DataSourceND
      TabOrder = 0
      OnClick = DBLookupComboBoxNDClick
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 49
    Width = 582
    Height = 134
    Align = alClient
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    ShowCaption = False
    TabOrder = 5
    TabStop = True
    object Label7: TLabel
      Left = 10
      Top = 102
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
    object Label8: TLabel
      Left = 351
      Top = 102
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
    object Label9: TLabel
      Left = 103
      Top = 102
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
    object GroupBox1: TGroupBox
      Left = 0
      Top = 0
      Width = 582
      Height = 47
      Align = alTop
      Caption = '  '#1057#1074#1072#1083#1082#1072
      TabOrder = 0
      object Label1: TLabel
        Left = 10
        Top = 19
        Width = 41
        Height = 13
        Caption = #1045#1076'. '#1080#1079#1084'.'
      end
      object Label2: TLabel
        Left = 112
        Top = 19
        Width = 60
        Height = 13
        Caption = #1062#1077#1085#1072' '#1079#1072' '#1077#1076'.'
      end
      object Label3: TLabel
        Left = 178
        Top = 19
        Width = 59
        Height = 13
        Caption = #1073#1077#1079' '#1053#1044#1057', '#1088':'
      end
      object Label4: TLabel
        Left = 339
        Top = 19
        Width = 47
        Height = 13
        Caption = #1089' '#1053#1044#1057', '#1088':'
      end
      object Label5: TLabel
        Left = 488
        Top = 19
        Width = 44
        Height = 13
        Caption = #1053#1044#1057', %:'
      end
      object edtDumpUnit: TEdit
        Left = 57
        Top = 16
        Width = 42
        Height = 21
        ReadOnly = True
        TabOrder = 0
      end
      object edtCoastNDS: TEdit
        Left = 390
        Top = 16
        Width = 92
        Height = 21
        NumbersOnly = True
        TabOrder = 1
        OnChange = edtCoastNDSChange
      end
      object edtCoastNoNDS: TEdit
        Left = 240
        Top = 16
        Width = 92
        Height = 21
        NumbersOnly = True
        TabOrder = 2
        OnChange = edtCoastNoNDSChange
      end
      object edtNDS: TEdit
        Left = 537
        Top = 16
        Width = 39
        Height = 21
        NumbersOnly = True
        TabOrder = 3
        OnChange = edtNDSChange
      end
    end
    object GroupBox2: TGroupBox
      Left = 0
      Top = 47
      Width = 582
      Height = 46
      Align = alTop
      Caption = '  '#1052#1091#1089#1086#1088'  '
      TabOrder = 1
      object Label6: TLabel
        Left = 10
        Top = 19
        Width = 41
        Height = 13
        Caption = #1045#1076'. '#1080#1079#1084'.'
      end
      object LabelMass: TLabel
        Left = 272
        Top = 19
        Width = 110
        Height = 13
        Caption = #1059#1076#1077#1083#1100#1085#1099#1081' '#1074#1077#1089', '#1082#1075'/'#1084'3:'
      end
      object LabelCount: TLabel
        Left = 119
        Top = 19
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
      object cmbUnit: TComboBox
        Left = 57
        Top = 16
        Width = 42
        Height = 21
        Style = csDropDownList
        TabOrder = 0
        OnChange = cmbUnitChange
        Items.Strings = (
          #1090
          #1084'3')
      end
      object edtYDW: TEdit
        Left = 388
        Top = 16
        Width = 65
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnChange = edtYDWChange
        OnKeyPress = EditKeyPress
      end
      object edtCount: TEdit
        Left = 188
        Top = 16
        Width = 66
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
    end
    object edtPriceNoNDS: TEdit
      Left = 195
      Top = 99
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
      TabOrder = 2
    end
    object edtPriceNDS: TEdit
      Left = 424
      Top = 101
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
      TabOrder = 3
    end
  end
  object DataSourceND: TDataSource
    DataSet = ADOQueryND
    Left = 216
    Top = 224
  end
  object ADOQueryND: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    Left = 129
    Top = 224
  end
  object qrTemp: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    Left = 296
    Top = 224
  end
end
