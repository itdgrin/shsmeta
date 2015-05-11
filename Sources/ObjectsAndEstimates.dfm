object FormObjectsAndEstimates: TFormObjectsAndEstimates
  Left = 0
  Top = 0
  Caption = #1054#1073#1098#1077#1082#1090#1099' '#1080' '#1089#1084#1077#1090#1099
  ClientHeight = 518
  ClientWidth = 705
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Visible = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PanelMain: TPanel
    Left = 0
    Top = 0
    Width = 705
    Height = 518
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
    TabOrder = 0
    ExplicitHeight = 502
    object ImageSplitterCenter: TImage
      Left = 304
      Top = 125
      Width = 15
      Height = 5
      Cursor = crVSplit
    end
    object SplitterCenter: TSplitter
      Left = 0
      Top = 321
      Width = 705
      Height = 5
      Cursor = crVSplit
      Align = alTop
      ResizeStyle = rsUpdate
      ExplicitTop = 100
      ExplicitWidth = 617
    end
    object PanelObjects: TPanel
      Left = 0
      Top = 0
      Width = 705
      Height = 321
      Align = alTop
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      ShowCaption = False
      TabOrder = 0
      object dbgrdObjects: TJvDBGrid
        Left = 0
        Top = 25
        Width = 705
        Height = 268
        Align = alClient
        DataSource = dsObjects
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        ParentFont = False
        PopupMenu = pmObjects
        ReadOnly = True
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnDrawColumnCell = dbgrdObjectsDrawColumnCell
        IniStorage = FormStorage
        TitleButtons = True
        OnTitleBtnClick = dbgrdObjectsTitleBtnClick
        SelectColumn = scGrid
        TitleArrow = True
        SelectColumnsDialogStrings.Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1074#1080#1076#1080#1084#1086#1089#1090#1080' '#1082#1086#1083#1086#1085#1086#1082
        SelectColumnsDialogStrings.OK = '&OK'
        SelectColumnsDialogStrings.NoSelectionWarning = #1044#1086#1083#1078#1085#1072' '#1073#1099#1090#1100' '#1074#1099#1073#1088#1072#1085#1072' '#1093#1086#1090#1103' '#1073#1099' '#1086#1076#1085#1072' '#1082#1086#1083#1086#1085#1082#1072'!'
        EditControls = <>
        RowsHeight = 17
        TitleRowHeight = 17
        Columns = <
          item
            Expanded = False
            FieldName = 'NumberObject'
            Title.Alignment = taCenter
            Title.Caption = #8470' '#1086#1073#1098#1077#1082#1090#1072
            Width = 65
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CodeObject'
            Title.Alignment = taCenter
            Title.Caption = #1064#1080#1092#1088' '#1086#1073#1098#1077#1082#1090#1072
            Width = 85
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NumberContract'
            Title.Alignment = taCenter
            Title.Caption = #1053#1086#1084#1077#1088' '#1076#1086#1075#1086#1074#1086#1088#1072
            Width = 90
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DateContract'
            Title.Alignment = taCenter
            Title.Caption = #1044#1072#1090#1072' '#1076#1086#1075#1086#1074#1086#1088#1072
            Width = 80
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ListAgreements'
            Title.Alignment = taCenter
            Title.Caption = #1057#1087#1080#1089#1086#1082' '#1076#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1093' '#1089#1086#1075#1083#1072#1096#1077#1085#1080#1081
            Width = 200
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'FullName'
            Title.Alignment = taCenter
            Title.Caption = #1055#1086#1083#1085#1086#1077' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1086#1073#1098#1077#1082#1090#1072
            Width = 250
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Name'
            Title.Alignment = taCenter
            Title.Caption = #1050#1088#1072#1090#1082#1086#1077' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1086#1073#1098#1077#1082#1090#1072
            Width = 170
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'BeginConstruction'
            Title.Alignment = taCenter
            Title.Caption = #1053#1072#1095#1072#1083#1086' '#1089#1090#1088#1086#1080#1090#1077#1083#1100#1089#1090#1074#1072
            Width = 120
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TermConstruction'
            Title.Alignment = taCenter
            Title.Caption = #1057#1088#1086#1082' '#1089#1090#1088#1086#1080#1090#1077#1083#1100#1089#1090#1074#1072
            Width = 120
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NameIstFin'
            Title.Alignment = taCenter
            Title.Caption = #1048#1089#1090#1086#1095#1085#1080#1082' '#1092#1080#1085#1072#1085#1089#1080#1088#1086#1074#1072#1085#1080#1103
            Width = 150
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NameClient'
            Title.Alignment = taCenter
            Title.Caption = #1047#1072#1082#1072#1079#1095#1080#1082
            Width = 150
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NameContractor'
            Title.Alignment = taCenter
            Title.Caption = #1043#1077#1085#1087#1086#1076#1088#1103#1076#1095#1080#1082
            Width = 150
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NameCategory'
            Title.Alignment = taCenter
            Title.Caption = #1050#1072#1090#1077#1075#1086#1088#1080#1103' '#1086#1073#1098#1077#1082#1090#1072
            Width = 200
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'VAT'
            Title.Alignment = taCenter
            Title.Caption = #1057'/'#1073#1077#1079' '#1053#1044#1057
            Width = 60
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NameRegion'
            Title.Alignment = taCenter
            Title.Caption = #1056#1077#1075#1080#1086#1085
            Width = 150
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'BasePrice'
            Title.Alignment = taCenter
            Title.Caption = #1041#1072#1079#1072' '#1088#1072#1089#1094#1077#1085#1086#1082
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'OXROPR'
            Title.Alignment = taCenter
            Title.Caption = #1058#1080#1087' '#1054#1061#1056' '#1080' '#1054#1055#1056' '
            Width = 150
            Visible = True
          end>
      end
      object dbmmoFullName: TDBMemo
        Left = 0
        Top = 293
        Width = 705
        Height = 28
        Align = alBottom
        DataField = 'FullName'
        DataSource = dsObjects
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 2
      end
      object pnl1: TPanel
        Left = 0
        Top = 0
        Width = 705
        Height = 25
        Align = alTop
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object lbl3: TLabel
          Left = 8
          Top = 5
          Width = 34
          Height = 13
          Caption = #1055#1086#1080#1089#1082':'
        end
        object btnSearch: TSpeedButton
          Left = 366
          Top = 1
          Width = 23
          Height = 22
          Glyph.Data = {
            F6000000424DF600000000000000760000002800000010000000100000000100
            04000000000080000000C40E0000C40E00001000000000000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
            8888888888888888888800000888880000080F000888880F00080F000888880F
            0008000000080000000800F000000F00000800F000800F00000800F000800F00
            00088000000000000088880F00080F0008888800000800000888888000888000
            88888880F08880F0888888800088800088888888888888888888}
          OnClick = btnSearchClick
        end
        object edtSearch: TEdit
          Left = 158
          Top = 2
          Width = 209
          Height = 21
          TabOrder = 1
          TextHint = #1042#1074#1077#1076#1080#1090#1077' '#1090#1077#1082#1089#1090' '#1076#1083#1103' '#1087#1086#1080#1089#1082#1072'...'
          OnChange = edtSearchChange
          OnKeyDown = edtSearchKeyDown
        end
        object cbbSearch: TComboBox
          Left = 45
          Top = 2
          Width = 114
          Height = 21
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 0
          Text = #1087#1086' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1102
          Items.Strings = (
            #1087#1086' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1102
            #1087#1086' '#1079#1072#1082#1072#1079#1095#1080#1082#1091)
        end
      end
    end
    object PanelBottom: TPanel
      Left = 0
      Top = 326
      Width = 705
      Height = 192
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
      TabOrder = 1
      OnResize = PanelBottomResize
      ExplicitHeight = 176
      object ImageSplitterBottomCenter: TImage
        Left = 513
        Top = 73
        Width = 5
        Height = 15
        Cursor = crHSplit
        AutoSize = True
      end
      object SplitterBottomCenter: TSplitter
        Left = 358
        Top = 0
        Width = 5
        Height = 192
        ResizeStyle = rsUpdate
        ExplicitLeft = 345
        ExplicitHeight = 180
      end
      object PanelEstimates: TPanel
        Left = 0
        Top = 0
        Width = 358
        Height = 192
        Align = alLeft
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 0
        ExplicitHeight = 176
        object lblEstimates: TLabel
          Left = 0
          Top = 0
          Width = 358
          Height = 13
          Align = alTop
          Alignment = taCenter
          Caption = #1057#1084#1077#1090#1099
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitWidth = 39
        end
        object tvEstimates: TJvDBTreeView
          Left = 0
          Top = 13
          Width = 358
          Height = 179
          DataSource = dsTreeData
          MasterField = 'SM_ID'
          DetailField = 'PARENT'
          ItemField = 'NAME'
          StartMasterValue = '0'
          UseFilter = True
          PersistentNode = True
          ReadOnly = True
          DragMode = dmAutomatic
          HideSelection = False
          Indent = 19
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          TabOrder = 0
          OnDblClick = tvEstimatesDblClick
          PopupMenu = pmEstimates
          ParentFont = False
          RowSelect = True
          Mirror = False
          ExplicitHeight = 163
        end
      end
      object PanelActs: TPanel
        Left = 363
        Top = 0
        Width = 342
        Height = 192
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 1
        ExplicitHeight = 176
        object lblActs: TLabel
          Left = 0
          Top = 0
          Width = 342
          Height = 13
          Align = alTop
          Alignment = taCenter
          Caption = #1040#1082#1090#1099' '#1074#1099#1087#1086#1083#1085#1077#1085#1085#1099#1093' '#1088#1072#1073#1086#1090
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitWidth = 156
        end
        object tvActs: TJvDBTreeView
          Left = 0
          Top = 13
          Width = 342
          Height = 179
          DataSource = dsActs
          MasterField = 'MASTER_ID'
          DetailField = 'PARENT_ID'
          ItemField = 'ITEAM_NAME'
          StartMasterValue = '0'
          UseFilter = False
          PersistentNode = True
          ReadOnly = True
          DragMode = dmAutomatic
          HideSelection = False
          Indent = 19
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          TabOrder = 0
          OnDblClick = PMActsEditClick
          PopupMenu = pmActs
          ParentFont = False
          RowSelect = True
          OnCustomDrawItem = tvActsCustomDrawItem
          Mirror = False
          ExplicitHeight = 163
        end
      end
    end
  end
  object dsObjects: TDataSource
    DataSet = qrObjects
    Left = 32
    Top = 120
  end
  object pmObjects: TPopupMenu
    OnPopup = pmObjectsPopup
    Left = 32
    Top = 168
    object PopupMenuObjectsAdd: TMenuItem
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      ImageIndex = 0
      OnClick = PopupMenuObjectsAddClick
    end
    object PopupMenuObjectsEdit: TMenuItem
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      ImageIndex = 1
      OnClick = PopupMenuObjectsEditClick
    end
    object mDelete: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100
      ImageIndex = 2
      OnClick = mDeleteClick
    end
    object mRepair: TMenuItem
      Caption = #1042#1086#1089#1089#1090#1072#1085#1086#1074#1080#1090#1100
      OnClick = mRepairClick
    end
    object PopupMenuObjectsSeparator1: TMenuItem
      Caption = '-'
    end
    object PMExportObject: TMenuItem
      Caption = #1069#1082#1089#1087#1086#1088#1090' '#1086#1073#1098#1077#1082#1090#1072
      OnClick = PMExportObjectClick
    end
    object PMImportObject: TMenuItem
      Caption = #1048#1084#1087#1086#1088#1090' '#1086#1073#1098#1077#1082#1090#1072
      OnClick = PMImportObjectClick
    end
    object PMImportDir: TMenuItem
      Caption = #1048#1084#1087#1086#1088#1090' '#1080#1079' '#1087#1072#1087#1082#1080
      OnClick = PMImportDirClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object mCopyObject: TMenuItem
      Caption = #1057#1086#1079#1076#1072#1090#1100' '#1082#1086#1087#1080#1102
      OnClick = mCopyObjectClick
    end
    object mN3: TMenuItem
      Caption = '-'
    end
    object mShowActual: TMenuItem
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1072#1082#1090#1091#1072#1083#1100#1085#1099#1077
      Checked = True
      OnClick = mShowActualClick
    end
    object mShowAll: TMenuItem
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1074#1089#1077
      OnClick = mShowAllClick
    end
    object mN4: TMenuItem
      Caption = '-'
    end
    object mN6: TMenuItem
      Caption = #1050#1086#1083#1086#1085#1082#1080
      OnClick = mN6Click
    end
  end
  object pmEstimates: TPopupMenu
    OnPopup = pmEstimatesPopup
    Left = 24
    Top = 448
    object PopupMenuEstimatesAdd: TMenuItem
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      object PMEstimatesAddLocal: TMenuItem
        Tag = 1
        Caption = #1051#1086#1082#1072#1083#1100#1085#1072#1103
        OnClick = PopupMenuEstimatesAddClick
      end
      object PMEstimatesAddObject: TMenuItem
        Tag = 2
        Caption = #1054#1073#1098#1077#1082#1090#1085#1072#1103
        OnClick = PopupMenuEstimatesAddClick
      end
      object PMEstimatesAddPTM: TMenuItem
        Tag = 3
        Caption = #1055#1058#1052
        OnClick = PopupMenuEstimatesAddClick
      end
    end
    object PMEstimatesEdit: TMenuItem
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      OnClick = PMEstimatesEditClick
    end
    object mN11: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Enabled = False
    end
    object PMEstimatesDelete: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1087#1086#1083#1085#1086#1089#1090#1100#1102
      OnClick = PMEstimatesDeleteClick
    end
    object mN7: TMenuItem
      Caption = #1042#1086#1089#1089#1090#1072#1085#1086#1074#1080#1090#1100
      Enabled = False
    end
    object PopupMenuEstimatesSeparator1: TMenuItem
      Caption = '-'
    end
    object PMEstimatesBasicData: TMenuItem
      Caption = #1048#1089#1093#1086#1076#1085#1099#1077' '#1076#1072#1085#1085#1099#1077
      OnClick = PMEstimatesBasicDataClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object PMEstimateExpandSelected: TMenuItem
      Caption = #1056#1072#1089#1082#1088#1099#1090#1100' '#1074#1099#1076#1077#1083#1077#1085#1085#1091#1102
      OnClick = PMEstimateExpandSelectedClick
    end
    object PMEstimateExpand: TMenuItem
      Caption = #1056#1072#1089#1082#1088#1099#1090#1100' '#1074#1089#1077
      OnClick = PMEstimateExpandClick
    end
    object PMEstimateCollapse: TMenuItem
      Caption = #1057#1074#1077#1088#1085#1091#1090#1100' '#1074#1089#1077
      OnClick = PMEstimateCollapseClick
    end
    object mN9: TMenuItem
      Caption = '-'
    end
    object mN10: TMenuItem
      Caption = #1057#1086#1079#1076#1072#1090#1100' '#1082#1086#1087#1080#1102
      Enabled = False
    end
    object mN15: TMenuItem
      Caption = '-'
    end
    object mN13: TMenuItem
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1072#1082#1090#1091#1072#1083#1100#1085#1099#1077
      Checked = True
      Enabled = False
    end
    object mN14: TMenuItem
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1074#1089#1077
      Enabled = False
    end
  end
  object pmActs: TPopupMenu
    OnPopup = pmActsPopup
    Left = 376
    Top = 440
    object PMActsOpen: TMenuItem
      Caption = #1054#1090#1082#1088#1099#1090#1100
      OnClick = PMActsOpenClick
    end
    object PMActsAdd: TMenuItem
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      OnClick = PMActsAddClick
    end
    object PMActsEdit: TMenuItem
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      OnClick = PMActsEditClick
    end
    object PMActsDelete: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100
      OnClick = PMActsDeleteClick
    end
    object mN12: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1087#1086#1083#1085#1086#1089#1090#1100#1102
      Enabled = False
    end
    object mRepAct: TMenuItem
      Caption = #1042#1086#1089#1089#1090#1072#1085#1086#1074#1080#1090#1100
      OnClick = mRepActClick
    end
    object pmActProperty: TMenuItem
      Caption = #1057#1074#1086#1081#1089#1090#1074#1072
      OnClick = pmActPropertyClick
    end
    object mN5: TMenuItem
      Caption = '-'
    end
    object mREM6KC: TMenuItem
      Caption = #1042#1099#1085#1077#1089#1090#1080' '#1080#1079' 6'#1050#1057
      OnClick = mREM6KCClick
    end
    object mADD6KC: TMenuItem
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1074' 6'#1050#1057
      OnClick = mADD6KCClick
    end
    object mN8: TMenuItem
      Caption = '-'
    end
    object mCopy: TMenuItem
      Caption = #1057#1086#1079#1076#1072#1090#1100' '#1082#1086#1087#1080#1102
      OnClick = mCopyClick
    end
    object mN16: TMenuItem
      Caption = '-'
    end
    object mN17: TMenuItem
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1072#1082#1090#1091#1072#1083#1100#1085#1099#1077
      Checked = True
      Enabled = False
    end
    object mN18: TMenuItem
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1074#1089#1077
      Enabled = False
    end
  end
  object qrActsEx: TFDQuery
    AfterOpen = qrActsExAfterOpen
    AfterScroll = qrActsExAfterOpen
    MasterSource = dsObjects
    MasterFields = 'obj_id'
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FormatOptions.AssignedValues = [fvMapRules, fvDefaultParamDataType]
    FormatOptions.OwnMapRules = True
    FormatOptions.MapRules = <
      item
        SourceDataType = dtMemo
        TargetDataType = dtAnsiString
      end>
    FormatOptions.DefaultParamDataType = ftBCD
    UpdateOptions.UpdateTableName = 'smeta.card_acts'
    UpdateOptions.KeyFields = 'ID'
    SQL.Strings = (
      'SELECT card_acts.*, '
      '(YEAR(card_acts.date)*12+MONTH(card_acts.date)) AS PARENT_ID,'
      'ID AS MASTER_ID,'
      
        'CONCAT(IF(card_acts.FL_USE=1, "", "'#1041#1077#1079' 6'#1050#1057' "), TRIM(card_acts.na' +
        'me), IF(card_acts.DEL_FLAG=1, "-", "")) AS ITEAM_NAME'
      'FROM card_acts'
      'WHERE ID_OBJECT = :OBJ_ID'
      'UNION ALL'
      
        'SELECT NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NU' +
        'LL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, '
      '0 AS PARENT_ID, '
      '(YEAR(card_acts.date)*12+MONTH(card_acts.date)) AS MASTER_ID,'
      'CONCAT(YEAR(card_acts.date), " ", ('
      'case MONTH(card_acts.date) '
      'WHEN 1 THEN "'#1071#1053#1042#1040#1056#1068'"'
      'WHEN 2 THEN "'#1060#1045#1042#1056#1040#1051#1068'"'
      'WHEN 3 THEN "'#1052#1040#1056#1058'"'
      'WHEN 4 THEN "'#1040#1055#1056#1045#1051#1068'"'
      'WHEN 5 THEN "'#1052#1040#1049'"'
      'WHEN 6 THEN "'#1048#1070#1053#1068'"'
      'WHEN 7 THEN "'#1048#1070#1051#1068'"'
      'WHEN 8 THEN "'#1040#1042#1043#1059#1057#1058'"'
      'WHEN 9 THEN "'#1057#1045#1053#1058#1071#1041#1056#1068'"'
      'WHEN 10 THEN "'#1054#1050#1058#1071#1041#1056#1068'"'
      'WHEN 11 THEN "'#1053#1054#1071#1041#1056#1068'"'
      'WHEN 12 THEN "'#1044#1045#1050#1040#1041#1056#1068'"'
      'END)) AS ITEAM_NAME'
      'FROM card_acts'
      'WHERE ID_OBJECT = :OBJ_ID'
      'GROUP BY (YEAR(card_acts.date)*12+MONTH(card_acts.date))'
      'ORDER BY date')
    Left = 377
    Top = 344
    ParamData = <
      item
        Name = 'OBJ_ID'
        ParamType = ptInput
      end>
  end
  object qrObjects: TFDQuery
    AfterOpen = qrObjectsAfterOpen
    AfterScroll = qrObjectsAfterScroll
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    SQL.Strings = (
      'SELECT DISTINCT obj_id        AS "IdObject",'
      '       objcards.fin_id        AS "IdIstFin",'
      '       objcards.cust_id       AS "IdClient",'
      '       objcards.general_id    AS "IdContractor",'
      '       objcards.cat_id        AS "IdCategory",'
      '       objcards.region_id     AS "IdRegion",'
      '       objcards.base_norm_id  AS "IdBasePrice",'
      '       objcards.stroj_id      AS "IdOXROPR",'
      '       objcards.mais_id       AS "IdMAIS",'
      '       num                    AS "NumberObject",'
      '       num_dog                AS "NumberContract",'
      '       date_dog               AS "DateContract",'
      '       agr_list               AS "ListAgreements",'
      '       objcards.full_name     AS "FullName",'
      '       objcards.name          AS "Name",'
      '       beg_stroj              AS "BeginConstruction",'
      '       srok_stroj             AS "TermConstruction",'
      '       ('
      '           SELECT DISTINCT NAME'
      '           FROM   istfin'
      '           WHERE  id = IdIstFin'
      '       )                      AS "NameIstFin",'
      '       ('
      '           SELECT DISTINCT full_name'
      '           FROM   clients'
      '           WHERE  client_id = IdClient'
      '       )                      AS "NameClient",'
      '       ('
      '           SELECT DISTINCT full_name'
      '           FROM   clients'
      '           WHERE  client_id = IdContractor'
      '       )                      AS "NameContractor",'
      '       objcategory.cat_name   AS "NameCategory",'
      '       state_nds              AS "VAT",'
      '       regions.region_name    AS "NameRegion",'
      '       baseprices.base_name   AS "BasePrice",'
      '       objstroj.name          AS "OXROPR",'
      '       encrypt                AS "CodeObject",'
      '       calc_econom            AS "CalculationEconom",'
      '       obj_id,'
      '       objcards.DEL_FLAG'
      'FROM   objcards,'
      '       istfin,'
      '       objcategory,'
      '       regions,'
      '       baseprices,'
      '       objstroj'
      'WHERE  objcards.cat_id = objcategory.cat_id'
      '       AND objcards.region_id = regions.region_id'
      '       AND objcards.base_norm_id = baseprices.base_id'
      '       AND objcards.stroj_id = objstroj.stroj_id'
      '       AND ((objcards.DEL_FLAG=0) OR (:SHOW_DELETED=1))'
      'ORDER BY num, num_dog,objcards.full_name')
    Left = 33
    Top = 72
    ParamData = <
      item
        Name = 'SHOW_DELETED'
        DataType = ftString
        ParamType = ptInput
        Value = '0'
      end>
  end
  object dsActs: TDataSource
    DataSet = qrActsEx
    Left = 377
    Top = 392
  end
  object dsTreeData: TDataSource
    DataSet = qrTreeData
    Left = 24
    Top = 400
  end
  object qrTreeData: TFDQuery
    AfterOpen = qrTreeDataAfterOpen
    AfterScroll = qrTreeDataAfterOpen
    MasterSource = dsObjects
    MasterFields = 'obj_id'
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FetchOptions.AssignedValues = [evCache]
    FetchOptions.Cache = [fiBlobs, fiMeta]
    SQL.Strings = (
      
        'SELECT SM_ID, SM_TYPE, OBJ_ID, CONCAT(SM_NUMBER, " ",  NAME) as ' +
        'NAME,'
      '       PARENT_ID as PARENT, DELETED'
      'FROM smetasourcedata'
      'WHERE SM_TYPE=2 AND '
      '      OBJ_ID=:OBJ_ID'
      'UNION ALL'
      
        'SELECT SM_ID, SM_TYPE, OBJ_ID, CONCAT(SM_NUMBER, " ",  NAME) as ' +
        'NAME,'
      '       PARENT_ID as PARENT, DELETED '
      'FROM smetasourcedata'
      'WHERE SM_TYPE<>2 AND '
      '      OBJ_ID=:OBJ_ID'
      'ORDER BY NAME')
    Left = 25
    Top = 352
    ParamData = <
      item
        Name = 'OBJ_ID'
        DataType = ftInteger
        ParamType = ptInput
        Size = 10
        Value = Null
      end>
  end
  object SaveDialog: TSaveDialog
    Filter = 'xml|*.xml'
    Left = 648
    Top = 109
  end
  object OpenDialog: TOpenDialog
    Filter = 'xml|*.xml'
    Left = 648
    Top = 61
  end
  object FormStorage: TJvFormStorage
    AppStorage = FormMain.AppIni
    AppStoragePath = '%FORM_NAME%\'
    Options = []
    StoredValues = <>
    Left = 32
    Top = 224
  end
end
