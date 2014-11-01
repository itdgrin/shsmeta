inherited FrameWinterPrice: TFrameWinterPrice
  Width = 557
  Height = 325
  DoubleBuffered = True
  ParentBackground = False
  ParentDoubleBuffered = False
  ParentFont = False
  ExplicitWidth = 557
  ExplicitHeight = 325
  object PanelRight: TPanel
    Left = 317
    Top = 0
    Width = 240
    Height = 325
    Align = alRight
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 0
    DesignSize = (
      240
      325)
    object GroupBox1: TGroupBox
      Left = 8
      Top = 8
      Width = 224
      Height = 100
      Caption = #1055#1088#1086#1094#1077#1085#1090', %'
      ParentBackground = False
      TabOrder = 0
      object LabelCoef: TLabel
        Left = 8
        Top = 20
        Width = 39
        Height = 13
        Caption = #1054#1073#1097#1080#1081':'
      end
      object LabelCoefZP: TLabel
        Left = 8
        Top = 47
        Width = 52
        Height = 13
        Caption = #1047#1072#1088#1087#1083#1072#1090#1072':'
      end
      object LabelCoefZPMach: TLabel
        Left = 8
        Top = 74
        Width = 110
        Height = 13
        Caption = #1047#1072#1088#1087#1083#1072#1090#1072' '#1084#1072#1096#1080#1085#1080#1089#1090#1072':'
      end
      object EditCoefZPMach: TEdit
        Left = 166
        Top = 71
        Width = 50
        Height = 21
        TabStop = False
        Color = 14802912
        ReadOnly = True
        TabOrder = 0
      end
      object EditCoefZP: TEdit
        Left = 166
        Top = 44
        Width = 50
        Height = 21
        TabStop = False
        Color = 14802912
        ReadOnly = True
        TabOrder = 1
      end
      object EditCoef: TEdit
        Left = 166
        Top = 17
        Width = 50
        Height = 21
        TabStop = False
        Color = 14802912
        ReadOnly = True
        TabOrder = 2
      end
    end
    object GroupBox2: TGroupBox
      Left = 8
      Top = 114
      Width = 224
      Height = 46
      Caption = #1044#1072#1090#1072
      ParentBackground = False
      TabOrder = 1
      Visible = False
      object Label6: TLabel
        Left = 8
        Top = 20
        Width = 7
        Height = 13
        Caption = 'C'
      end
      object Label7: TLabel
        Left = 112
        Top = 20
        Width = 13
        Height = 13
        Caption = #1076#1086
      end
      object DateTimePicker1: TDateTimePicker
        Left = 21
        Top = 17
        Width = 85
        Height = 21
        Date = 41539.811306423610000000
        Time = 41539.811306423610000000
        TabOrder = 0
      end
      object DateTimePicker2: TDateTimePicker
        Left = 131
        Top = 17
        Width = 85
        Height = 21
        Date = 41539.811306423610000000
        Time = 41539.811306423610000000
        TabOrder = 1
      end
    end
    object GroupBoxNormative: TGroupBox
      Left = 6
      Top = 166
      Width = 226
      Height = 151
      Anchors = [akLeft, akTop, akBottom]
      Caption = #1053#1086#1088#1084#1072#1090#1080#1074#1099' ('#1088#1072#1089#1094#1077#1085#1082#1080')'
      TabOrder = 2
      DesignSize = (
        226
        151)
      object StringGridNormatives: TStringGrid
        Left = 10
        Top = 20
        Width = 208
        Height = 123
        Anchors = [akLeft, akTop, akBottom]
        ColCount = 2
        DefaultRowHeight = 20
        DefaultDrawing = False
        RowCount = 2
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect, goThumbTracking]
        TabOrder = 0
        OnClick = StringGridNormativesClick
        OnDrawCell = StringGridNormativesDrawCell
        OnEnter = StringGridNormativesEnter
        OnExit = StringGridNormativesExit
        OnKeyDown = StringGridNormativesKeyDown
        OnMouseDown = StringGridNormativesMouseDown
        OnMouseMove = StringGridNormativesMouseMove
      end
    end
  end
  object PanelTable: TPanel
    Left = 0
    Top = 0
    Width = 317
    Height = 325
    Align = alClient
    BevelOuter = bvNone
    ParentBackground = False
    ShowCaption = False
    TabOrder = 1
    object TreeView: TTreeView
      Left = 0
      Top = 0
      Width = 317
      Height = 325
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Indent = 19
      ParentFont = False
      PopupMenu = PopupMenuTreeView
      TabOrder = 0
      OnChanging = TreeViewChanging
    end
  end
  object PopupMenuTreeView: TPopupMenu
    Left = 40
    Top = 8
    object PopupMenuTreeViewExpandTrue: TMenuItem
      Caption = #1056#1072#1079#1074#1077#1088#1085#1091#1090#1100' '#1091#1079#1083#1099' '#1076#1077#1088#1077#1074#1072
      OnClick = PopupMenuTreeViewExpandTrueClick
    end
    object PopupMenuTreeViewExpandFalse: TMenuItem
      Caption = #1057#1074#1077#1088#1085#1091#1090#1100' '#1091#1079#1083#1099' '#1076#1077#1088#1077#1074#1072
      OnClick = PopupMenuTreeViewExpandFalseClick
    end
  end
  object ADOQueryTable: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    Left = 41
    Top = 64
  end
  object ADOQueryTemp3: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    Left = 41
    Top = 224
  end
  object ADOQueryTemp2: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    Left = 41
    Top = 168
  end
  object ADOQueryTemp1: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    Left = 41
    Top = 120
  end
end
