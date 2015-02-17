object FormObjectsAndEstimates: TFormObjectsAndEstimates
  Left = 0
  Top = 0
  Caption = #1054#1073#1098#1077#1082#1090#1099' '#1080' '#1089#1084#1077#1090#1099
  ClientHeight = 450
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
  object PanelSelectedColumns: TPanel
    Left = 0
    Top = 0
    Width = 705
    Height = 165
    Align = alTop
    BevelOuter = bvNone
    DoubleBuffered = True
    ParentBackground = False
    ParentDoubleBuffered = False
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 4
      Width = 244
      Height = 13
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1074#1080#1076#1080#1084#1086#1089#1090#1080' '#1082#1086#1083#1086#1085#1086#1082' '#1074' '#1090#1072#1073#1083#1080#1094#1077':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object CheckBox1: TCheckBox
      Left = 8
      Top = 23
      Width = 210
      Height = 17
      Caption = #1053#1086#1084#1077#1088' '#1086#1073#1098#1077#1082#1090#1072
      Checked = True
      State = cbChecked
      TabOrder = 0
      OnClick = CheckBoxColumnsClick
    end
    object CheckBox3: TCheckBox
      Left = 8
      Top = 69
      Width = 210
      Height = 17
      Caption = #1053#1086#1084#1077#1088' '#1076#1086#1075#1086#1074#1086#1088#1072
      Checked = True
      State = cbChecked
      TabOrder = 1
      OnClick = CheckBoxColumnsClick
    end
    object CheckBox4: TCheckBox
      Left = 8
      Top = 92
      Width = 210
      Height = 17
      Caption = #1044#1072#1090#1072' '#1076#1086#1075#1086#1074#1086#1088#1072
      Checked = True
      State = cbChecked
      TabOrder = 2
      OnClick = CheckBoxColumnsClick
    end
    object CheckBox5: TCheckBox
      Left = 8
      Top = 115
      Width = 210
      Height = 17
      Caption = #1057#1087#1080#1089#1086#1082' '#1076#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1093' '#1089#1086#1075#1083#1072#1096#1077#1085#1080#1081
      Checked = True
      State = cbChecked
      TabOrder = 3
      OnClick = CheckBoxColumnsClick
    end
    object CheckBox6: TCheckBox
      Left = 8
      Top = 138
      Width = 210
      Height = 17
      Caption = #1055#1086#1083#1085#1086#1077' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1086#1073#1098#1077#1082#1090#1072
      Checked = True
      State = cbChecked
      TabOrder = 4
      OnClick = CheckBoxColumnsClick
    end
    object CheckBox7: TCheckBox
      Left = 224
      Top = 23
      Width = 240
      Height = 17
      Caption = #1050#1088#1072#1090#1082#1086#1077' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1086#1073#1098#1077#1082#1090#1072
      Checked = True
      State = cbChecked
      TabOrder = 5
      OnClick = CheckBoxColumnsClick
    end
    object CheckBox8: TCheckBox
      Left = 224
      Top = 46
      Width = 240
      Height = 17
      Caption = #1053#1072#1095#1072#1083#1086' '#1089#1090#1088#1086#1080#1090#1077#1083#1100#1089#1090#1074#1072
      Checked = True
      State = cbChecked
      TabOrder = 6
      OnClick = CheckBoxColumnsClick
    end
    object CheckBox9: TCheckBox
      Left = 224
      Top = 69
      Width = 240
      Height = 17
      Caption = #1057#1088#1086#1082' '#1089#1090#1088#1086#1080#1090#1077#1083#1100#1089#1090#1074#1072' ('#1082#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1084#1077#1089#1103#1094#1077#1074')'
      Checked = True
      State = cbChecked
      TabOrder = 7
      OnClick = CheckBoxColumnsClick
    end
    object CheckBox10: TCheckBox
      Left = 224
      Top = 92
      Width = 240
      Height = 17
      Caption = #1048#1089#1090#1086#1095#1085#1080#1082' '#1092#1080#1085#1072#1085#1089#1080#1088#1086#1074#1072#1085#1080#1103
      Checked = True
      State = cbChecked
      TabOrder = 8
      OnClick = CheckBoxColumnsClick
    end
    object CheckBox11: TCheckBox
      Left = 224
      Top = 115
      Width = 240
      Height = 17
      Caption = #1047#1072#1082#1072#1079#1095#1080#1082
      Checked = True
      State = cbChecked
      TabOrder = 9
      OnClick = CheckBoxColumnsClick
    end
    object CheckBox12: TCheckBox
      Left = 224
      Top = 138
      Width = 240
      Height = 17
      Caption = #1043#1077#1085#1087#1086#1076#1088#1103#1076#1095#1080#1082
      Checked = True
      State = cbChecked
      TabOrder = 10
      OnClick = CheckBoxColumnsClick
    end
    object CheckBox13: TCheckBox
      Left = 470
      Top = 23
      Width = 130
      Height = 17
      Caption = #1050#1072#1090#1077#1075#1086#1088#1080#1103' '#1086#1073#1098#1077#1082#1090#1072
      Checked = True
      State = cbChecked
      TabOrder = 11
      OnClick = CheckBoxColumnsClick
    end
    object CheckBox14: TCheckBox
      Left = 470
      Top = 46
      Width = 130
      Height = 17
      Caption = #1057' '#1080#1083#1080' '#1073#1077#1079' '#1053#1044#1057
      Checked = True
      State = cbChecked
      TabOrder = 12
      OnClick = CheckBoxColumnsClick
    end
    object CheckBox15: TCheckBox
      Left = 470
      Top = 69
      Width = 130
      Height = 17
      Caption = #1056#1077#1075#1080#1086#1085
      Checked = True
      State = cbChecked
      TabOrder = 13
      OnClick = CheckBoxColumnsClick
    end
    object ButtonSelectAll: TButton
      Left = 606
      Top = 23
      Width = 91
      Height = 25
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1074#1089#1077
      TabOrder = 14
      OnClick = ButtonSelectAllClick
    end
    object ButtonSelectNone: TButton
      Left = 606
      Top = 54
      Width = 91
      Height = 25
      Caption = #1057#1082#1088#1099#1090#1100' '#1074#1089#1077
      TabOrder = 15
      OnClick = ButtonSelectNoneClick
    end
    object CheckBox16: TCheckBox
      Left = 470
      Top = 92
      Width = 130
      Height = 17
      Caption = #1041#1072#1079#1072' '#1088#1072#1089#1094#1077#1085#1086#1082
      Checked = True
      State = cbChecked
      TabOrder = 16
      OnClick = CheckBoxColumnsClick
    end
    object CheckBox17: TCheckBox
      Left = 470
      Top = 115
      Width = 130
      Height = 17
      Caption = #1058#1080#1087' '#1054#1061#1056' '#1080' '#1054#1055#1056
      Checked = True
      State = cbChecked
      TabOrder = 17
      OnClick = CheckBoxColumnsClick
    end
    object CheckBox2: TCheckBox
      Left = 8
      Top = 46
      Width = 210
      Height = 17
      Caption = #1064#1080#1092#1088' '#1086#1073#1098#1077#1082#1090#1072
      Checked = True
      State = cbChecked
      TabOrder = 18
      OnClick = CheckBoxColumnsClick
    end
    object ButtonCancel: TButton
      Left = 606
      Top = 130
      Width = 91
      Height = 25
      Caption = #1054#1090#1084#1077#1085#1072
      TabOrder = 19
      OnClick = ButtonCancelClick
    end
  end
  object PanelMain: TPanel
    Left = 0
    Top = 165
    Width = 705
    Height = 285
    Align = alClient
    BevelOuter = bvNone
    ParentBackground = False
    ShowCaption = False
    TabOrder = 1
    object ImageSplitterCenter: TImage
      Left = 304
      Top = 125
      Width = 15
      Height = 5
      Cursor = crVSplit
    end
    object SplitterCenter: TSplitter
      Left = 0
      Top = 100
      Width = 705
      Height = 5
      Cursor = crVSplit
      Align = alTop
      ResizeStyle = rsUpdate
      ExplicitWidth = 617
    end
    object PanelObjects: TPanel
      Left = 0
      Top = 0
      Width = 705
      Height = 100
      Align = alTop
      BevelOuter = bvNone
      ParentBackground = False
      ShowCaption = False
      TabOrder = 0
      object dbgrdObjects: TDBGrid
        Left = 0
        Top = 0
        Width = 705
        Height = 100
        Align = alClient
        DataSource = dsObjects
        DrawingStyle = gdsClassic
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        PopupMenu = PopupMenuObjects
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'IdObject'
            Title.Alignment = taCenter
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'IdIstFin'
            Title.Alignment = taCenter
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'IdClient'
            Title.Alignment = taCenter
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'IdContractor'
            Title.Alignment = taCenter
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'IdCategory'
            Title.Alignment = taCenter
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'IdRegion'
            Title.Alignment = taCenter
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'IdBasePrice'
            Title.Alignment = taCenter
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'IdOXROPR'
            Title.Alignment = taCenter
            Visible = False
          end
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
    end
    object PanelBottom: TPanel
      Left = 0
      Top = 105
      Width = 705
      Height = 180
      Align = alClient
      BevelOuter = bvNone
      ParentBackground = False
      ShowCaption = False
      TabOrder = 1
      OnResize = PanelBottomResize
      object ImageSplitterBottomCenter: TImage
        Left = 513
        Top = 73
        Width = 5
        Height = 15
        Cursor = crHSplit
        AutoSize = True
      end
      object SplitterBottomCenter: TSplitter
        Left = 330
        Top = 0
        Width = 5
        Height = 180
        ResizeStyle = rsUpdate
        ExplicitLeft = 345
      end
      object PanelEstimates: TPanel
        Left = 0
        Top = 0
        Width = 330
        Height = 180
        Align = alLeft
        BevelOuter = bvNone
        ParentBackground = False
        TabOrder = 0
        object tvEstimates: TJvDBTreeView
          Left = 0
          Top = 0
          Width = 330
          Height = 180
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
          TabOrder = 0
          OnDblClick = tvEstimatesDblClick
          PopupMenu = PopupMenuEstimates
          RowSelect = True
          Mirror = False
          ExplicitLeft = -1
          ExplicitTop = 1
        end
      end
      object PanelActs: TPanel
        Left = 335
        Top = 0
        Width = 370
        Height = 180
        Align = alClient
        BevelOuter = bvNone
        ParentBackground = False
        TabOrder = 1
        object grActs: TJvDBGrid
          Left = 0
          Top = 0
          Width = 370
          Height = 180
          Align = alClient
          DataSource = dsActs
          DrawingStyle = gdsClassic
          Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          PopupMenu = PMActs
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          OnMouseMove = grActsMouseMove
          AutoSizeColumns = True
          SelectColumnsDialogStrings.Caption = 'Select columns'
          SelectColumnsDialogStrings.OK = '&OK'
          SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
          EditControls = <>
          RowsHeight = 17
          TitleRowHeight = 17
          Columns = <
            item
              Expanded = False
              FieldName = 'NAME'
              Title.Alignment = taCenter
              Title.Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1072#1082#1090#1072
              Width = 126
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DATE'
              Title.Alignment = taCenter
              Title.Caption = #1044#1072#1090#1072
              Width = 45
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DESCRIPTION'
              Title.Alignment = taCenter
              Title.Caption = #1054#1087#1080#1089#1072#1085#1080#1077
              Width = 192
              Visible = True
            end>
        end
      end
    end
  end
  object dsObjects: TDataSource
    DataSet = qrObjects
    Left = 104
    Top = 192
  end
  object PopupMenuObjects: TPopupMenu
    Left = 352
    Top = 192
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
    object PopupMenuObjectsDelete: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100
      ImageIndex = 2
      OnClick = PopupMenuObjectsDeleteClick
    end
    object PopupMenuObjectsSeparator1: TMenuItem
      Caption = '-'
    end
    object PopupMenuObjectsColumns: TMenuItem
      Caption = #1050#1086#1083#1086#1085#1082#1080
      OnClick = PopupMenuObjectsColumnsClick
    end
  end
  object PopupMenuEstimates: TPopupMenu
    OnPopup = PopupMenuEstimatesPopup
    Left = 256
    Top = 400
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
    object PMEstimatesDelete: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100
      OnClick = PMEstimatesDeleteClick
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
  end
  object PMActs: TPopupMenu
    OnPopup = PMActsPopup
    Left = 456
    Top = 384
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
    object pmActProperty: TMenuItem
      Caption = #1057#1074#1086#1081#1089#1090#1074#1072
      OnClick = pmActPropertyClick
    end
  end
  object qrActsEx: TFDQuery
    AfterOpen = qrActsExAfterOpen
    AfterScroll = qrActsExAfterOpen
    MasterSource = dsTreeData
    MasterFields = 'SM_ID'
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FormatOptions.AssignedValues = [fvMapRules]
    FormatOptions.OwnMapRules = True
    FormatOptions.MapRules = <
      item
        SourceDataType = dtMemo
        TargetDataType = dtAnsiString
      end>
    SQL.Strings = (
      'SELECT *'
      'FROM '
      '  card_acts'
      'WHERE ID_ESTIMATE_OBJECT = :SM_ID')
    Left = 393
    Top = 384
    ParamData = <
      item
        Name = 'SM_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object qrTmp: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    Left = 273
    Top = 192
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
      '       obj_id'
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
      'ORDER BY'
      '       num,'
      '       num_dog,'
      '       objcards.full_name     ASC')
    Left = 49
    Top = 192
  end
  object dsActs: TDataSource
    DataSet = qrActsEx
    Left = 425
    Top = 384
  end
  object dsTreeData: TDataSource
    DataSet = qrTreeData
    Left = 216
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
      '       0 as PARENT  '
      'FROM smetasourcedata'
      'WHERE SM_TYPE=2 AND '
      '      OBJ_ID=:OBJ_ID'
      'UNION ALL'
      
        'SELECT SM_ID, SM_TYPE, OBJ_ID, CONCAT(SM_NUMBER, " ",  NAME) as ' +
        'NAME,'
      '       (PARENT_LOCAL_ID+PARENT_PTM_ID) as PARENT  '
      'FROM smetasourcedata'
      'WHERE SM_TYPE<>2 AND '
      '      OBJ_ID=:OBJ_ID'
      'ORDER BY NAME')
    Left = 177
    Top = 400
    ParamData = <
      item
        Name = 'OBJ_ID'
        DataType = ftInteger
        ParamType = ptInput
        Size = 10
        Value = Null
      end>
  end
end
