object FrameEquipment: TFrameEquipment
  Left = 0
  Top = 0
  Width = 488
  Height = 335
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
  OnEnter = FrameEnter
  OnExit = FrameExit
  OnResize = FrameResize
  object Panel: TPanel
    Left = 0
    Top = 0
    Width = 488
    Height = 316
    Align = alClient
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 0
    object ImageSplitter: TImage
      Left = 312
      Top = 395
      Width = 15
      Height = 5
      Cursor = crVSplit
    end
    object Splitter: TSplitter
      Left = 0
      Top = 276
      Width = 488
      Height = 5
      Cursor = crVSplit
      Align = alBottom
      ResizeStyle = rsUpdate
      ExplicitTop = 25
    end
    object PanelTable: TPanel
      Left = 0
      Top = 25
      Width = 488
      Height = 251
      Align = alClient
      BevelOuter = bvNone
      ParentBackground = False
      TabOrder = 1
      OnResize = PanelTableResize
      object SpeedButtonShowHide: TSpeedButton
        Tag = 1
        Left = 0
        Top = 236
        Width = 488
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
      object VST: TVirtualStringTree
        Left = 0
        Top = 0
        Width = 488
        Height = 236
        Align = alClient
        Header.AutoSizeIndex = 0
        Header.Font.Charset = DEFAULT_CHARSET
        Header.Font.Color = clWindowText
        Header.Font.Height = -11
        Header.Font.Name = 'Tahoma'
        Header.Font.Style = []
        Header.Options = [hoVisible]
        PopupMenu = PopupMenu
        TabOrder = 0
        TreeOptions.MiscOptions = [toAcceptOLEDrop, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning, toEditOnClick]
        TreeOptions.PaintOptions = [toHideFocusRect, toShowButtons, toShowDropmark, toShowHorzGridLines, toShowVertGridLines, toThemeAware, toUseBlendedImages]
        TreeOptions.SelectionOptions = [toExtendedFocus]
        OnAfterCellPaint = VSTAfterCellPaint
        OnBeforeCellPaint = VSTBeforeCellPaint
        OnDblClick = VSTDblClick
        OnEnter = VSTEnter
        OnExit = VSTExit
        OnFocusChanged = VSTFocusChanged
        OnGetText = VSTGetText
        OnKeyPress = VSTKeyPress
        Columns = <
          item
            Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coFixed]
            Position = 0
            WideText = #8470' '#1087'/'#1087
          end
          item
            Position = 1
            Width = 110
            WideText = #1050#1086#1076
          end
          item
            Position = 2
            Width = 130
            WideText = #1053#1072#1079#1074#1072#1085#1080#1077
          end
          item
            Position = 3
            Width = 70
            WideText = #1045#1076'. '#1080#1079#1084'.'
          end>
        WideDefaultText = 'node'
      end
    end
    object PanelSearch: TPanel
      Left = 0
      Top = 0
      Width = 488
      Height = 25
      Align = alTop
      BevelOuter = bvNone
      DoubleBuffered = True
      ParentBackground = False
      ParentDoubleBuffered = False
      TabOrder = 0
      DesignSize = (
        488
        25)
      object LabelSearch: TLabel
        Left = 6
        Top = 6
        Width = 34
        Height = 13
        Caption = #1055#1086#1080#1089#1082':'
      end
      object EditSearch: TEdit
        Left = 46
        Top = 2
        Width = 439
        Height = 21
        Hint = 
          #1042#1074#1077#1076#1080#1090#1077' '#1089#1083#1086#1074#1072' '#1095#1077#1088#1077#1079' '#1087#1088#1086#1073#1077#1083' '#1080' '#1085#1072#1078#1084#1080#1090#1077' - Enter, '#1076#1083#1103' '#1086#1095#1080#1089#1090#1082#1080' '#1085#1072#1078#1084#1080#1090 +
          #1077' - Esc'
        Anchors = [akLeft, akTop, akRight]
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnEnter = EditSearchEnter
        OnKeyPress = EditSearchKeyPress
      end
    end
    object PanelMemo: TPanel
      Left = 0
      Top = 281
      Width = 488
      Height = 35
      Align = alBottom
      BevelOuter = bvNone
      Constraints.MinHeight = 35
      DoubleBuffered = True
      ParentBackground = False
      ParentDoubleBuffered = False
      ShowCaption = False
      TabOrder = 2
      object Memo: TMemo
        Left = 0
        Top = 0
        Width = 488
        Height = 35
        Align = alClient
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 0
        OnEnter = MemoEnter
      end
    end
  end
  inline FrameStatusBar: TFrameStatusBar
    Left = 0
    Top = 316
    Width = 488
    Height = 19
    Align = alBottom
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 1
    ExplicitTop = 316
    ExplicitWidth = 488
    inherited StatusBar: TStatusBar
      Width = 488
      ExplicitWidth = 488
    end
  end
  object PopupMenu: TPopupMenu
    Left = 80
    Top = 32
    object CopyCell: TMenuItem
      Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100
      OnClick = CopyCellClick
    end
    object EquipmentSearch: TMenuItem
      Caption = #1055#1086#1080#1089#1082
      object EquipmentSearchFast: TMenuItem
        Caption = #1041#1099#1089#1090#1088#1099#1081
        Checked = True
      end
      object EquipmentSearchAccurate: TMenuItem
        Caption = #1052#1072#1082#1089#1080#1084#1072#1083#1100#1085#1086' '#1090#1086#1095#1085#1099#1081
        Enabled = False
      end
    end
  end
  object ADOQuery: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    Left = 28
    Top = 32
  end
end
