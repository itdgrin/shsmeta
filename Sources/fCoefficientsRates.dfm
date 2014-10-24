object FrameCoefficientsRates: TFrameCoefficientsRates
  Left = 0
  Top = 0
  Width = 600
  Height = 400
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object PanelRight: TPanel
    Left = 341
    Top = 0
    Width = 259
    Height = 400
    Align = alRight
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 0
    object LabelSalary: TLabel
      Left = 8
      Top = 9
      Width = 127
      Height = 13
      Caption = #1054#1089#1085#1086#1074#1085#1072#1103' '#1079#1072#1088#1087#1083#1072#1090#1072' ('#1047#1055'):'
    end
    object LabelExploitationCars: TLabel
      Left = 8
      Top = 36
      Width = 151
      Height = 13
      Caption = #1069#1082#1089#1087#1083#1091#1072#1090#1072#1094#1080#1103' '#1084#1072#1096#1080#1085' ('#1069#1052#1080#1052'):'
    end
    object LabelMaterialResources: TLabel
      Left = 8
      Top = 63
      Width = 150
      Height = 13
      Caption = #1052#1072#1090#1077#1088#1080#1072#1083#1100#1085#1099#1077' '#1088#1077#1089#1091#1088#1089#1099' ('#1052#1056'):'
    end
    object LabelWorkBuilders: TLabel
      Left = 8
      Top = 90
      Width = 171
      Height = 13
      Caption = #1058#1088#1091#1076#1086#1079#1072#1090#1088#1072#1090#1099' '#1088#1072#1073#1086#1095#1080#1093' ('#1058#1047' '#1088#1072#1073'.):'
    end
    object LabelWorkMachinist: TLabel
      Left = 8
      Top = 117
      Width = 192
      Height = 13
      Caption = #1058#1088#1091#1076#1086#1079#1072#1090#1088#1072#1090#1099' '#1084#1072#1096#1080#1085#1080#1089#1090#1086#1074' ('#1058#1047' '#1084#1072#1096'.):'
    end
    object EditSalary: TEdit
      Left = 206
      Top = 6
      Width = 45
      Height = 21
      TabStop = False
      Color = 14802912
      ReadOnly = True
      TabOrder = 1
    end
    object EditWorkBuilders: TEdit
      Left = 206
      Top = 87
      Width = 45
      Height = 21
      TabStop = False
      Color = 14802912
      ReadOnly = True
      TabOrder = 2
    end
    object EditWorkMachinist: TEdit
      Left = 206
      Top = 114
      Width = 45
      Height = 21
      TabStop = False
      Color = 14802912
      ReadOnly = True
      TabOrder = 0
    end
    object EditExploitationCars: TEdit
      Left = 206
      Top = 33
      Width = 45
      Height = 21
      TabStop = False
      Color = 14802912
      ReadOnly = True
      TabOrder = 3
    end
    object EditMaterialResources: TEdit
      Left = 206
      Top = 60
      Width = 45
      Height = 21
      TabStop = False
      Color = 14802912
      ReadOnly = True
      TabOrder = 4
    end
  end
  object VST: TVirtualStringTree
    Left = 0
    Top = 0
    Width = 341
    Height = 400
    Align = alClient
    Header.AutoSizeIndex = 0
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clWindowText
    Header.Font.Height = -11
    Header.Font.Name = 'Tahoma'
    Header.Font.Style = []
    Header.Options = [hoVisible]
    PopupMenu = PopupMenu
    TabOrder = 1
    TreeOptions.MiscOptions = [toAcceptOLEDrop, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning, toEditOnClick]
    TreeOptions.PaintOptions = [toHideFocusRect, toShowButtons, toShowDropmark, toShowHorzGridLines, toShowVertGridLines, toThemeAware, toUseBlendedImages]
    TreeOptions.SelectionOptions = [toExtendedFocus]
    OnAfterCellPaint = VSTAfterCellPaint
    OnBeforeCellPaint = VSTBeforeCellPaint
    OnFocusChanged = VSTFocusChanged
    OnGetText = VSTGetText
    OnResize = VSTResize
    ExplicitLeft = 2
    Columns = <
      item
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coFixed]
        Position = 0
        WideText = #8470' '#1087'/'#1087
      end
      item
        Position = 1
        Width = 200
        WideText = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      end>
    WideDefaultText = 'node'
  end
  object PopupMenu: TPopupMenu
    Left = 24
    Top = 80
    object PMAdd: TMenuItem
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      OnClick = PMAddClick
    end
    object PMEdit: TMenuItem
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      OnClick = PMEditClick
    end
    object PMDelete: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100
      OnClick = PMDeleteClick
    end
  end
  object ADOQueryTemp: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    Left = 81
    Top = 32
  end
  object ADOQuery: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    Left = 28
    Top = 32
  end
end
