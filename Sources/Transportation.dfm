object FormTransportation: TFormTransportation
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1055#1077#1088#1077#1074#1086#1079#1082#1072' '#1075#1088#1091#1079#1086#1074
  ClientHeight = 350
  ClientWidth = 645
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    645
    350)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 0
    Top = 308
    Width = 645
    Height = 42
    Align = alBottom
    Shape = bsTopLine
    ExplicitTop = 175
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
    Top = 317
    Width = 100
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 1
    OnClick = ButtonCancelClick
    ExplicitTop = 183
  end
  object Panel2: TPanel
    Left = 0
    Top = 25
    Width = 645
    Height = 278
    Align = alClient
    BevelOuter = bvNone
    ParentBackground = False
    ShowCaption = False
    TabOrder = 0
    TabStop = True
    ExplicitLeft = 16
    ExplicitTop = 49
    ExplicitHeight = 382
    object Label7: TLabel
      Left = 78
      Top = 251
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
      Left = 171
      Top = 252
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
      Left = 419
      Top = 252
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
    object edtPriceNoNDS: TEdit
      Left = 263
      Top = 249
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
      TabOrder = 0
    end
    object edtPriceNDS: TEdit
      Left = 492
      Top = 251
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
      TabOrder = 1
    end
    object grbGruz: TGroupBox
      Left = 0
      Top = 0
      Width = 645
      Height = 73
      Align = alTop
      Caption = '  '#1043#1088#1091#1079'  '
      TabOrder = 2
      object Label6: TLabel
        Left = 152
        Top = 19
        Width = 41
        Height = 13
        Caption = #1045#1076'. '#1080#1079#1084'.'
      end
      object Label1: TLabel
        Left = 258
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
      object LabelMass: TLabel
        Left = 212
        Top = 46
        Width = 110
        Height = 13
        Caption = #1059#1076#1077#1083#1100#1085#1099#1081' '#1074#1077#1089', '#1082#1075'/'#1084'3:'
      end
      object Label2: TLabel
        Left = 12
        Top = 19
        Width = 33
        Height = 13
        Caption = #1050#1083#1072#1089#1089':'
      end
      object LabelDistance: TLabel
        Left = 416
        Top = 19
        Width = 76
        Height = 13
        Caption = #1056#1072#1089#1090#1086#1103#1085#1080#1077', '#1082#1084':'
      end
      object cmbUnit: TComboBox
        Left = 199
        Top = 16
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
        Left = 328
        Top = 16
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
        OnExit = EditExit
        OnKeyPress = EditKeyPress
      end
      object edtYDW: TEdit
        Left = 328
        Top = 43
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
        OnExit = EditExit
        OnKeyPress = EditKeyPress
      end
      object cmbClass: TComboBox
        Left = 51
        Top = 16
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
      object EditDistance: TEdit
        Left = 498
        Top = 16
        Width = 71
        Height = 21
        NumbersOnly = True
        TabOrder = 4
        OnChange = EditDistanceChange
        OnExit = EditExit
      end
    end
    object grbKoef: TGroupBox
      Left = 0
      Top = 73
      Width = 645
      Height = 55
      Align = alTop
      Caption = 
        ' '#1053#1072#1076#1073#1072#1074#1082#1080' '#1079#1072' '#1087#1077#1088#1077#1074#1086#1079#1082#1091' '#1075#1088#1091#1079#1086#1074' '#1074' '#1089#1087#1077#1094#1080#1072#1083#1080#1079#1080#1088#1086#1074#1072#1085#1085#1086#1084' '#1087#1086#1076#1074#1080#1078#1085#1086#1084' '#1089#1086#1089 +
        #1090#1072#1074#1077'  '
      TabOrder = 3
      object ComboBox1: TComboBox
        Left = 29
        Top = 15
        Width = 614
        Height = 36
        Align = alClient
        Style = csOwnerDrawVariable
        Enabled = False
        ItemHeight = 30
        TabOrder = 0
        OnDrawItem = ComboBox1DrawItem
        OnMeasureItem = ComboBox1MeasureItem
        Items.Strings = (
          'xvxv cx vfdsfvvvsddfdsfsdd fsdfddfd vcxv cvxcvxcvxc'
          'cxv cvcxvcxvxcvcvcx cvcxvcxv vcxvxv vxvxcv cxvxccvxcv ccxv'
          'sdfsdfsdfsdfsdd '
          
            'dsfsdfdsfsdfdsfdsfsddfdsfsdd fsdfddfdsfdsfdsfdsfdsfsd sfsdfsddf ' +
            'fdsdfs dsfsddfdsfsdd dsfsddfdsfsdd dsfsddfdsfsdd dsfsddfdsfsdd d' +
            'sfsddfdsfsdd dsfsddfdsfsdd dsfsddfdsfsdd'
          'fsfsdfsdfsdf '
          'gfgdfgdff gdffgdfg fgdffgdfgdfg fdgdfgdffgdf '
          'ertertert tertert ertertretert rtertert')
      end
      object Panel3: TPanel
        Left = 2
        Top = 15
        Width = 27
        Height = 38
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 1
        ExplicitHeight = 34
        object cbKoef: TCheckBox
          Left = 7
          Top = -1
          Width = 13
          Height = 17
          TabOrder = 0
        end
      end
    end
    object grdPrice: TJvStringGrid
      Left = 0
      Top = 128
      Width = 645
      Height = 116
      Align = alTop
      ColCount = 6
      DefaultRowHeight = 17
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine]
      TabOrder = 4
      OnKeyPress = grdPriceKeyPress
      OnSelectCell = grdPriceSelectCell
      Alignment = taLeftJustify
      FixedFont.Charset = DEFAULT_CHARSET
      FixedFont.Color = clWindowText
      FixedFont.Height = -11
      FixedFont.Name = 'Tahoma'
      FixedFont.Style = []
      OnExitCell = grdPriceExitCell
      OnSetCanvasProperties = grdPriceSetCanvasProperties
      OnGetCellAlignment = grdPriceGetCellAlignment
    end
  end
  object PanelBottom: TPanel
    Left = 0
    Top = 303
    Width = 645
    Height = 5
    Align = alBottom
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 3
    ExplicitTop = 170
  end
  object ButtonAdd: TButton
    Left = 537
    Top = 317
    Width = 100
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    TabOrder = 4
    OnClick = ButtonAddClick
    ExplicitTop = 183
  end
  object qrTemp: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    Left = 593
    Top = 41
  end
end
