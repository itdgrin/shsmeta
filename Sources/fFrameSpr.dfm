object SprFrame: TSprFrame
  Left = 0
  Top = 0
  Width = 759
  Height = 435
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object SpeedButtonShowHide: TSpeedButton
    Tag = 1
    Left = 0
    Top = 369
    Width = 759
    Height = 15
    Align = alBottom
    Flat = True
    ParentShowHint = False
    ShowHint = True
    OnClick = SpeedButtonShowHideClick
    ExplicitLeft = -568
    ExplicitTop = 161
    ExplicitWidth = 796
  end
  object PanelSettings: TPanel
    Left = 0
    Top = 0
    Width = 759
    Height = 36
    Align = alTop
    DoubleBuffered = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentBackground = False
    ParentDoubleBuffered = False
    ParentFont = False
    TabOrder = 0
    object lbYear: TLabel
      Left = 8
      Top = 10
      Width = 23
      Height = 13
      Caption = #1043#1086#1076':'
    end
    object lbMonth: TLabel
      Left = 93
      Top = 11
      Width = 35
      Height = 13
      Caption = #1052#1077#1089#1103#1094':'
    end
    object cmbMonth: TComboBox
      Left = 132
      Top = 8
      Width = 101
      Height = 21
      Style = csDropDownList
      TabOrder = 0
    end
    object edtYear: TSpinEdit
      Left = 33
      Top = 8
      Width = 54
      Height = 22
      MaxValue = 0
      MinValue = 0
      TabOrder = 1
      Value = 2015
    end
    object btnShow: TButton
      AlignWithMargins = True
      Left = 663
      Top = 5
      Width = 91
      Height = 26
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Align = alRight
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100
      TabOrder = 2
    end
  end
  object PanelFind: TPanel
    Left = 0
    Top = 36
    Width = 759
    Height = 34
    Align = alTop
    TabOrder = 1
    object lbFind: TLabel
      Left = 8
      Top = 11
      Width = 120
      Height = 13
      Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1080#1083#1080' '#1082#1086#1076':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object edtFind: TEdit
      AlignWithMargins = True
      Left = 131
      Top = 5
      Width = 525
      Height = 24
      Margins.Left = 130
      Margins.Top = 4
      Margins.Bottom = 4
      Align = alClient
      TabOrder = 0
      ExplicitHeight = 21
    end
    object btnFind: TButton
      AlignWithMargins = True
      Left = 663
      Top = 5
      Width = 91
      Height = 24
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Align = alRight
      Caption = #1055#1086#1080#1089#1082
      Enabled = False
      TabOrder = 1
    end
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 416
    Width = 759
    Height = 19
    BiDiMode = bdLeftToRight
    Panels = <
      item
        Width = 120
      end
      item
        Width = 150
      end
      item
        Width = 150
      end>
    ParentBiDiMode = False
  end
  object Memo: TMemo
    Left = 0
    Top = 384
    Width = 759
    Height = 32
    Align = alBottom
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 3
  end
  object ListSpr: TListView
    Left = 0
    Top = 70
    Width = 759
    Height = 299
    Align = alClient
    Columns = <
      item
        Caption = #1050#1086#1076
        Width = 100
      end
      item
        Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
        Width = 350
      end
      item
        Caption = #1045#1076'. '#1080#1079#1084'.'
        Width = 70
      end
      item
        Caption = #1062#1077#1085#1072' '#1089' '#1053#1044#1057', '#1088#1091#1073
        Width = 100
      end
      item
        Caption = #1062#1077#1085#1072' '#1073#1077#1079' '#1053#1044#1057', '#1088#1091#1073
        Width = 110
      end>
    ColumnClick = False
    DoubleBuffered = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    GridLines = True
    ReadOnly = True
    RowSelect = True
    ParentDoubleBuffered = False
    ParentFont = False
    ShowWorkAreas = True
    TabOrder = 4
    ViewStyle = vsReport
  end
end
