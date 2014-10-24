object FormCalculationDump: TFormCalculationDump
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1056#1072#1089#1095#1105#1090' '#1089#1074#1072#1083#1082#1080
  ClientHeight = 299
  ClientWidth = 582
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
    582
    299)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 0
    Top = 258
    Width = 582
    Height = 41
    Align = alBottom
    Shape = bsTopLine
    ExplicitLeft = -80
    ExplicitTop = 164
    ExplicitWidth = 644
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
    TabOrder = 5
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
      ReadOnly = True
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
      ReadOnly = True
      TabOrder = 1
      Text = #1055#1083#1072#1090#1072' '#1079#1072' '#1087#1088#1080#1105#1084' '#1080' '#1079#1072#1093#1086#1088#1086#1085#1077#1085#1080#1077' '#1086#1090#1093#1086#1076#1086#1074' ('#1089#1090#1088#1086#1080#1090#1077#1083#1100#1085#1086#1075#1086' '#1084#1091#1089#1086#1088#1072')'
    end
  end
  object PanelBottom: TPanel
    Left = 0
    Top = 253
    Width = 582
    Height = 5
    Align = alBottom
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 6
  end
  object PanelCenter: TPanel
    Left = 281
    Top = 75
    Width = 5
    Height = 178
    Align = alLeft
    BevelOuter = bvNone
    ParentBackground = False
    ShowCaption = False
    TabOrder = 7
  end
  object PanelMemo: TPanel
    Left = 286
    Top = 75
    Width = 296
    Height = 178
    Align = alClient
    BevelOuter = bvNone
    ParentBackground = False
    ShowCaption = False
    TabOrder = 2
    object Memo: TMemo
      Left = 0
      Top = 0
      Width = 296
      Height = 178
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
  object PanelTable: TPanel
    Left = 0
    Top = 75
    Width = 281
    Height = 178
    Align = alLeft
    BevelOuter = bvNone
    ParentBackground = False
    ShowCaption = False
    TabOrder = 1
    object StringGrid: TStringGrid
      Left = 0
      Top = 0
      Width = 281
      Height = 178
      Align = alClient
      ColCount = 2
      DefaultRowHeight = 20
      DefaultDrawing = False
      RowCount = 7
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
      ScrollBars = ssNone
      TabOrder = 0
      OnClick = StringGridClick
      OnDrawCell = StringGridDrawCell
      OnEnter = StringGridEnter
      OnExit = StringGridExit
      RowHeights = (
        20
        20
        20
        20
        20
        20
        20)
    end
  end
  object ButtonCancel: TButton
    Left = 368
    Top = 266
    Width = 100
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 4
    OnClick = ButtonCancelClick
  end
  object ButtonSave: TButton
    Left = 474
    Top = 266
    Width = 100
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    Default = True
    TabOrder = 3
    OnClick = ButtonSaveClick
  end
  object Panel2: TPanel
    Left = 0
    Top = 25
    Width = 582
    Height = 25
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
    Top = 50
    Width = 582
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    ShowCaption = False
    TabOrder = 8
    TabStop = True
    object LabelCount: TLabel
      Left = 8
      Top = 6
      Width = 77
      Height = 13
      Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086', '#1090':'
    end
    object LabelMass: TLabel
      Left = 137
      Top = 6
      Width = 110
      Height = 13
      Caption = #1059#1076#1077#1083#1100#1085#1099#1081' '#1074#1077#1089', '#1082#1075'/'#1084'3:'
    end
    object EditCount: TEdit
      Left = 91
      Top = 2
      Width = 40
      Height = 21
      TabOrder = 0
      OnChange = EditCountChange
      OnKeyPress = EditKeyPress
    end
    object EditMass: TEdit
      Left = 253
      Top = 2
      Width = 40
      Height = 21
      TabOrder = 1
      OnChange = EditMassChange
      OnKeyPress = EditKeyPress
    end
  end
  object DataSourceND: TDataSource
    DataSet = ADOQueryND
    Left = 184
    Top = 176
  end
  object ADOQueryND: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    Left = 185
    Top = 136
  end
  object ADOQueryTemp: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    Left = 185
    Top = 88
  end
end
