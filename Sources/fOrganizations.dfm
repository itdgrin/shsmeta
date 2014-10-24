object FrameOrganizations: TFrameOrganizations
  Left = 0
  Top = 0
  Width = 517
  Height = 331
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object PanelListOrganizations: TPanel
    Left = 0
    Top = 0
    Width = 517
    Height = 331
    Align = alClient
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 0
    object VST: TVirtualStringTree
      Left = 0
      Top = 0
      Width = 517
      Height = 271
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
      OnFocusChanged = VSTFocusChanged
      OnGetText = VSTGetText
      OnResize = VSTResize
      Columns = <
        item
          Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coFixed]
          Position = 0
          WideText = #8470' '#1087'/'#1087
        end
        item
          Position = 1
          Width = 150
          WideText = #1053#1072#1080#1084'. '#1086#1088#1075#1072#1085#1080#1079'. ('#1082#1088#1072#1090#1082#1086#1077')'
        end
        item
          Position = 2
          Width = 70
          WideText = #1050#1086#1076' '#1073#1072#1085#1082#1072
        end
        item
          Position = 3
          Width = 130
          WideText = #1053#1072#1080#1084'. '#1073#1072#1085#1082#1072
        end
        item
          Position = 4
          Width = 70
          WideText = #8470' '#1089#1095#1105#1090#1072
        end
        item
          Position = 5
          Width = 70
          WideText = #1059#1053#1053
        end
        item
          Position = 6
          Width = 70
          WideText = #1054#1050#1055#1054
        end
        item
          Position = 7
          Width = 150
          WideText = #1040#1076#1088#1077#1089
        end
        item
          Position = 8
          Width = 100
          WideText = #1056#1091#1082'. '#1076#1086#1083#1078#1085#1086#1089#1090#1100
        end
        item
          Position = 9
          Width = 100
          WideText = #1060'.'#1048'.'#1054'.'
        end
        item
          Position = 10
          Width = 70
          WideText = #1058#1077#1083'./'#1092#1072#1082#1089
        end
        item
          Position = 11
          Width = 150
          WideText = #1050#1086#1085#1090#1072#1082#1090'. '#1083#1080#1094#1086
        end>
      WideDefaultText = 'node'
    end
    object PanelFullNameOrganization: TPanel
      Left = 0
      Top = 271
      Width = 517
      Height = 60
      Align = alBottom
      BevelOuter = bvNone
      Caption = 'PanelFullNameOrganization'
      ShowCaption = False
      TabOrder = 1
      object MemoFullNameOrganization: TMemo
        Left = 0
        Top = 25
        Width = 517
        Height = 35
        Align = alClient
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 0
      end
      object PanelTopFullNameOrganization: TPanel
        Left = 0
        Top = 0
        Width = 517
        Height = 25
        Align = alTop
        BevelOuter = bvNone
        Caption = 'PanelTopFullNameOrganization'
        ShowCaption = False
        TabOrder = 1
        object LabelFullNameOrganization: TLabel
          Left = 8
          Top = 6
          Width = 183
          Height = 13
          Caption = #1055#1086#1083#1085#1086#1077' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080':'
        end
      end
    end
  end
  object PopupMenu: TPopupMenu
    Left = 24
    Top = 88
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
    Left = 97
    Top = 32
  end
  object ADOQuery: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    Left = 25
    Top = 32
  end
end
