object fSmReportEdit: TfSmReportEdit
  Left = 0
  Top = 0
  Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1096#1072#1073#1083#1086#1085#1072' '#1086#1090#1095#1077#1090#1072
  ClientHeight = 506
  ClientWidth = 604
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object pgc: TPageControl
    Left = 0
    Top = 0
    Width = 604
    Height = 506
    ActivePage = tsData
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 0
    object tsData: TTabSheet
      Caption = #1044#1072#1085#1085#1099#1077
      object pgcData: TPageControl
        Left = 0
        Top = 0
        Width = 596
        Height = 475
        ActivePage = tsVar
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnChange = pgcDataChange
        object tsVar: TTabSheet
          Caption = #1055#1077#1088#1077#1084#1077#1085#1085#1099#1077
          ImageIndex = 3
          object grVars: TJvDBGrid
            Left = 0
            Top = 0
            Width = 588
            Height = 414
            Align = alClient
            DataSource = dsVars
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'Tahoma'
            TitleFont.Style = []
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
                FieldName = 'REPORT_VAR_DESCR'
                Title.Alignment = taCenter
                Title.Caption = #1054#1087#1080#1089#1072#1085#1080#1077
                Width = 222
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'REPORT_VAR_NAME'
                Title.Alignment = taCenter
                Title.Caption = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088' '#1087#1077#1088#1077#1084#1077#1085#1085#1086#1081
                Width = 157
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'LK_TYPE'
                Title.Alignment = taCenter
                Title.Caption = #1058#1080#1087' '#1087#1077#1088#1077#1084#1077#1085#1085#1086#1081
                Width = 95
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'REPORT_VAR_VAL'
                Title.Alignment = taCenter
                Title.Caption = #1047#1085#1072#1095#1077#1085#1080#1077
                Width = 94
                Visible = True
              end>
          end
          object pnlVarsBott: TPanel
            Left = 0
            Top = 414
            Width = 588
            Height = 33
            Align = alBottom
            BevelOuter = bvNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            object dbnvgr4: TDBNavigator
              Left = 0
              Top = 6
              Width = 200
              Height = 25
              DataSource = dsVars
              VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbInsert, nbDelete, nbEdit, nbPost, nbCancel]
              Align = alCustom
              Hints.Strings = (
                #1053#1072' '#1087#1077#1088#1074#1091#1102' '#1079#1072#1087#1080#1089#1100
                #1055#1088#1077#1076#1099#1076#1091#1097#1072#1103' '#1079#1072#1087#1080#1089#1100
                #1057#1083#1077#1076#1091#1102#1097#1072#1103' '#1079#1072#1087#1080#1089#1100
                #1053#1072' '#1087#1086#1089#1083#1077#1076#1085#1102#1102' '#1079#1072#1087#1080#1089#1100
                #1053#1086#1074#1072#1103' '#1079#1072#1087#1080#1089#1100
                #1059#1076#1072#1083#1080#1090#1100' '#1079#1072#1087#1080#1089#1100
                #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1079#1072#1087#1080#1089#1100
                #1057#1086#1093#1088#1072#1085#1080#1090#1100
                #1054#1090#1084#1077#1085#1080#1090#1100
                #1054#1073#1085#1086#1074#1080#1090#1100
                'Apply updates'
                'Cancel updates')
              ParentShowHint = False
              ShowHint = True
              TabOrder = 0
              TabStop = True
            end
          end
        end
        object tsRows: TTabSheet
          Caption = #1047#1072#1087#1080#1089#1080
          object grRows: TJvDBGrid
            Left = 0
            Top = 0
            Width = 588
            Height = 414
            Align = alClient
            DataSource = dsRows
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'Tahoma'
            TitleFont.Style = []
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
                FieldName = 'POS'
                Title.Alignment = taCenter
                Title.Caption = #1055#1086#1079#1080#1094#1080#1103
                Width = 51
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'REPORT_ROW_NAME'
                Title.Alignment = taCenter
                Title.Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1080#1089#1090#1086#1095#1085#1080#1082#1072
                Width = 353
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'LK_TYPE'
                Title.Alignment = taCenter
                Title.Caption = #1058#1080#1087
                Width = 53
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'LK_LIST_NAME'
                Title.Alignment = taCenter
                Title.Caption = #1057#1087#1080#1089#1086#1082
                Width = 58
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'FL_SHOW'
                Title.Alignment = taCenter
                Title.Caption = #1042#1099#1074#1086#1076#1080#1090#1100
                Width = 52
                Visible = True
              end>
          end
          object pnlRowsBott: TPanel
            Left = 0
            Top = 414
            Width = 588
            Height = 33
            Align = alBottom
            BevelOuter = bvNone
            TabOrder = 1
            object dbnvgr1: TDBNavigator
              Left = 0
              Top = 6
              Width = 200
              Height = 25
              DataSource = dsRows
              VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbInsert, nbDelete, nbEdit, nbPost, nbCancel]
              Align = alCustom
              Hints.Strings = (
                #1053#1072' '#1087#1077#1088#1074#1091#1102' '#1079#1072#1087#1080#1089#1100
                #1055#1088#1077#1076#1099#1076#1091#1097#1072#1103' '#1079#1072#1087#1080#1089#1100
                #1057#1083#1077#1076#1091#1102#1097#1072#1103' '#1079#1072#1087#1080#1089#1100
                #1053#1072' '#1087#1086#1089#1083#1077#1076#1085#1102#1102' '#1079#1072#1087#1080#1089#1100
                #1053#1086#1074#1072#1103' '#1079#1072#1087#1080#1089#1100
                #1059#1076#1072#1083#1080#1090#1100' '#1079#1072#1087#1080#1089#1100
                #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1079#1072#1087#1080#1089#1100
                #1057#1086#1093#1088#1072#1085#1080#1090#1100
                #1054#1090#1084#1077#1085#1080#1090#1100
                #1054#1073#1085#1086#1074#1080#1090#1100
                'Apply updates'
                'Cancel updates')
              ParentShowHint = False
              ShowHint = True
              TabOrder = 0
              TabStop = True
            end
          end
        end
        object tsFields: TTabSheet
          Caption = #1055#1086#1083#1103
          ImageIndex = 1
          object geCols: TJvDBGrid
            Left = 0
            Top = 0
            Width = 588
            Height = 414
            Align = alClient
            DataSource = dsCols
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'Tahoma'
            TitleFont.Style = []
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
                FieldName = 'POS'
                Title.Alignment = taCenter
                Title.Caption = #1055#1086#1079#1080#1094#1080#1103
                Width = 52
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'REPORT_COL_LABEL'
                Title.Alignment = taCenter
                Title.Caption = #1053#1072#1079#1074#1072#1085#1080#1077
                Width = 344
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'FL_PRINT_ROW_NAME'
                Title.Alignment = taCenter
                Title.Caption = #1042#1099#1074#1086#1076#1080#1090#1100' '#1085#1072#1079#1074#1072#1085#1080#1077' '#1080#1089#1090#1086#1095#1085#1080#1082#1072
                Width = 173
                Visible = True
              end>
          end
          object pnlColsBott: TPanel
            Left = 0
            Top = 414
            Width = 588
            Height = 33
            Align = alBottom
            BevelOuter = bvNone
            TabOrder = 1
            object dbnvgr2: TDBNavigator
              Left = 0
              Top = 6
              Width = 200
              Height = 25
              DataSource = dsCols
              VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbInsert, nbDelete, nbEdit, nbPost, nbCancel]
              Align = alCustom
              Hints.Strings = (
                #1053#1072' '#1087#1077#1088#1074#1091#1102' '#1079#1072#1087#1080#1089#1100
                #1055#1088#1077#1076#1099#1076#1091#1097#1072#1103' '#1079#1072#1087#1080#1089#1100
                #1057#1083#1077#1076#1091#1102#1097#1072#1103' '#1079#1072#1087#1080#1089#1100
                #1053#1072' '#1087#1086#1089#1083#1077#1076#1085#1102#1102' '#1079#1072#1087#1080#1089#1100
                #1053#1086#1074#1072#1103' '#1079#1072#1087#1080#1089#1100
                #1059#1076#1072#1083#1080#1090#1100' '#1079#1072#1087#1080#1089#1100
                #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1079#1072#1087#1080#1089#1100
                #1057#1086#1093#1088#1072#1085#1080#1090#1100
                #1054#1090#1084#1077#1085#1080#1090#1100
                #1054#1073#1085#1086#1074#1080#1090#1100
                'Apply updates'
                'Cancel updates')
              ParentShowHint = False
              ShowHint = True
              TabOrder = 0
              TabStop = True
            end
          end
        end
        object tsCalc: TTabSheet
          Caption = #1056#1072#1089#1095#1077#1090
          ImageIndex = 2
          object grCell: TJvDBGrid
            Left = 0
            Top = 33
            Width = 588
            Height = 414
            Align = alClient
            DataSource = dsRepCell
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleHotTrack]
            ParentFont = False
            TabOrder = 1
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'Tahoma'
            TitleFont.Style = []
            OnCellClick = grCellCellClick
            OnColEnter = grCellColEnter
            FixedCols = 1
            SelectColumnsDialogStrings.Caption = 'Select columns'
            SelectColumnsDialogStrings.OK = '&OK'
            SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
            EditControls = <>
            RowsHeight = 17
            TitleRowHeight = 17
            WordWrap = True
            WordWrapAllFields = True
          end
          object pnl5: TPanel
            Left = 0
            Top = 0
            Width = 588
            Height = 33
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 0
            DesignSize = (
              588
              33)
            object lbl1: TLabel
              Left = 0
              Top = 10
              Width = 48
              Height = 13
              Caption = #1060#1086#1088#1084#1091#1083#1072':'
            end
            object btnSaveFormul: TSpeedButton
              Left = 559
              Top = 5
              Width = 23
              Height = 22
              Anchors = [akTop, akRight]
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              OnClick = btnSaveFormulClick
            end
            object lblCellLink: TLabel
              Left = 54
              Top = 10
              Width = 45
              Height = 13
              Cursor = crHandPoint
              Hint = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1089#1089#1099#1083#1082#1091' '#1085#1072' '#1103#1095#1077#1081#1082#1091
              Caption = 'lblCellLink'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsUnderline]
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
              OnClick = lblCellLinkClick
            end
            object edtFormul: TEdit
              Left = 120
              Top = 7
              Width = 433
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 0
            end
          end
        end
        object tsPreView: TTabSheet
          Caption = #1054#1090#1083#1072#1076#1082#1072
          ImageIndex = 4
          DesignSize = (
            588
            447)
          object JvDBGrid5: TJvDBGrid
            Left = 0
            Top = 0
            Width = 588
            Height = 345
            Align = alClient
            DataSource = dsPreview
            Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleHotTrack]
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'Tahoma'
            TitleFont.Style = []
            AutoSizeColumns = True
            SelectColumnsDialogStrings.Caption = 'Select columns'
            SelectColumnsDialogStrings.OK = '&OK'
            SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
            EditControls = <>
            RowsHeight = 17
            TitleRowHeight = 17
            WordWrap = True
            WordWrapAllFields = True
          end
          object pnl1: TPanel
            Left = 0
            Top = 345
            Width = 588
            Height = 102
            Align = alBottom
            BevelOuter = bvNone
            Caption = 'pnl1'
            TabOrder = 1
            object mmoLog: TMemo
              Left = 185
              Top = 0
              Width = 403
              Height = 102
              Align = alClient
              ScrollBars = ssVertical
              TabOrder = 1
            end
            object mmoInParams: TMemo
              Left = 0
              Top = 0
              Width = 185
              Height = 102
              Align = alLeft
              Lines.Strings = (
                'SET @OBJ_ID = 49; '
                'SET @SM_ID = 440;')
              TabOrder = 0
            end
          end
          object btnTest: TButton
            Left = 492
            Top = 419
            Width = 75
            Height = 25
            Anchors = [akRight, akBottom]
            Caption = #1058#1077#1089#1090
            TabOrder = 2
            OnClick = btnTestClick
          end
        end
      end
    end
    object tsView: TTabSheet
      Caption = #1042#1080#1076
      ImageIndex = 1
    end
  end
  object qrRows: TFDQuery
    BeforeOpen = qrRowsBeforeOpen
    OnNewRecord = qrRowsNewRecord
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FetchOptions.AssignedValues = [evCache]
    FetchOptions.Cache = [fiBlobs, fiMeta]
    FormatOptions.AssignedValues = [fvMapRules]
    FormatOptions.OwnMapRules = True
    FormatOptions.MapRules = <
      item
        SourceDataType = dtByte
        TargetDataType = dtBoolean
      end>
    UpdateOptions.UpdateTableName = 'smeta.report_row'
    SQL.Strings = (
      'SELECT *'
      'FROM report_row'
      'WHERE REPORT_ID = :REPORT_ID'
      'ORDER BY POS')
    Left = 70
    Top = 98
    ParamData = <
      item
        Name = 'REPORT_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object qrRowsREPORT_ROW_ID: TFDAutoIncField
      FieldName = 'REPORT_ROW_ID'
      Origin = 'REPORT_ROW_ID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
      DisplayFormat = '###,##0.########'
      EditFormat = '0.########'
    end
    object qrRowsREPORT_ID: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'REPORT_ID'
      Origin = 'REPORT_ID'
      DisplayFormat = '###,##0.########'
      EditFormat = '0.########'
    end
    object qrRowsROW_ID: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'ROW_ID'
      Origin = 'ROW_ID'
      DisplayFormat = '###,##0.########'
      EditFormat = '0.########'
    end
    object qrRowsPOS: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'POS'
      Origin = 'POS'
      DisplayFormat = '###,##0.########'
      EditFormat = '0.########'
    end
    object qrRowsREPORT_ROW_NAME: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'REPORT_ROW_NAME'
      Origin = 'REPORT_ROW_NAME'
      Size = 512
    end
    object qrRowsFL_SHOW: TBooleanField
      AutoGenerateValue = arDefault
      FieldName = 'FL_SHOW'
      Origin = 'FL_SHOW'
    end
    object qrRowsREPORT_ROW_TYPE: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'REPORT_ROW_TYPE'
      Origin = 'REPORT_ROW_TYPE'
      DisplayFormat = '###,##0.########'
      EditFormat = '0.########'
    end
    object qrRowsLK_TYPE: TStringField
      FieldKind = fkLookup
      FieldName = 'LK_TYPE'
      LookupDataSet = qrRowType
      LookupKeyFields = 'ROW_TYPE_ID'
      LookupResultField = 'ROW_TYPE_NAME'
      KeyFields = 'REPORT_ROW_TYPE'
      Size = 200
      Lookup = True
    end
    object qrRowsREPORT_LIST_SQL_ID: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'REPORT_LIST_SQL_ID'
      Origin = 'REPORT_LIST_SQL_ID'
      DisplayFormat = '###,##0.########'
      EditFormat = '0.########'
    end
    object qrRowsLK_LIST_NAME: TStringField
      FieldKind = fkLookup
      FieldName = 'LK_LIST_NAME'
      LookupDataSet = qrReportListSql
      LookupKeyFields = 'REPORT_LIST_SQL_ID'
      LookupResultField = 'REPORT_LIST_SQL_NAME'
      KeyFields = 'REPORT_LIST_SQL_ID'
      Size = 254
      Lookup = True
    end
  end
  object dsRows: TDataSource
    DataSet = qrRows
    Left = 70
    Top = 146
  end
  object qrCols: TFDQuery
    BeforeOpen = qrRowsBeforeOpen
    OnNewRecord = qrRowsNewRecord
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FetchOptions.AssignedValues = [evCache]
    FetchOptions.Cache = [fiBlobs, fiMeta]
    FormatOptions.AssignedValues = [fvMapRules]
    FormatOptions.OwnMapRules = True
    FormatOptions.MapRules = <
      item
        SourceDataType = dtByte
        TargetDataType = dtBoolean
      end>
    UpdateOptions.UpdateTableName = 'smeta.report_col'
    SQL.Strings = (
      'SELECT *'
      'FROM report_col'
      'WHERE REPORT_ID = :REPORT_ID'
      'ORDER BY POS')
    Left = 118
    Top = 98
    ParamData = <
      item
        Name = 'REPORT_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object dsCols: TDataSource
    DataSet = qrCols
    Left = 118
    Top = 146
  end
  object qrVars: TFDQuery
    BeforeOpen = qrRowsBeforeOpen
    OnNewRecord = qrRowsNewRecord
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FetchOptions.AssignedValues = [evCache]
    FetchOptions.Cache = [fiBlobs, fiMeta]
    UpdateOptions.UpdateTableName = 'smeta.report_var'
    SQL.Strings = (
      'SELECT *'
      'FROM report_var'
      'WHERE REPORT_ID = :REPORT_ID')
    Left = 22
    Top = 98
    ParamData = <
      item
        Name = 'REPORT_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object qrVarsREPORT_VAR_ID: TFDAutoIncField
      FieldName = 'REPORT_VAR_ID'
      Origin = 'REPORT_VAR_ID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
      DisplayFormat = '###,##0.########'
      EditFormat = '0.########'
    end
    object qrVarsREPORT_ID: TIntegerField
      FieldName = 'REPORT_ID'
      Origin = 'REPORT_ID'
      Required = True
      DisplayFormat = '###,##0.########'
      EditFormat = '0.########'
    end
    object qrVarsREPORT_VAR_NAME: TStringField
      FieldName = 'REPORT_VAR_NAME'
      Origin = 'REPORT_VAR_NAME'
      Required = True
      Size = 100
    end
    object qrVarsREPORT_VAR_DESCR: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'REPORT_VAR_DESCR'
      Origin = 'REPORT_VAR_DESCR'
      Size = 250
    end
    object qrVarsREPORT_VAR_VAL: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'REPORT_VAR_VAL'
      Origin = 'REPORT_VAR_VAL'
      Size = 1000
    end
    object qrVarsREPORT_VAR_TYPE: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'REPORT_VAR_TYPE'
      Origin = 'REPORT_VAR_TYPE'
      DisplayFormat = '###,##0.########'
      EditFormat = '0.########'
    end
    object qrVarsLK_TYPE: TStringField
      FieldKind = fkLookup
      FieldName = 'LK_TYPE'
      LookupDataSet = qrVarType
      LookupKeyFields = 'REPORT_VAR_TYPE_ID'
      LookupResultField = 'REPORT_VAR_TYPE_NAME'
      KeyFields = 'REPORT_VAR_TYPE'
      Size = 250
      Lookup = True
    end
  end
  object dsVars: TDataSource
    DataSet = qrVars
    Left = 22
    Top = 146
  end
  object qrRepCell: TFDQuery
    BeforeOpen = qrRowsBeforeOpen
    AfterScroll = qrRepCellAfterScroll
    CachedUpdates = True
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FetchOptions.AssignedValues = [evCache]
    UpdateOptions.AssignedValues = [uvUpdateMode, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.CheckUpdatable = False
    Left = 166
    Top = 98
  end
  object dsRepCell: TDataSource
    DataSet = qrRepCell
    Left = 166
    Top = 146
  end
  object qrPreview: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    FormatOptions.AssignedValues = [fvMapRules, fvDataSnapCompatibility]
    FormatOptions.OwnMapRules = True
    FormatOptions.MapRules = <
      item
        NameMask = 'F_*'
        TargetDataType = dtDouble
      end>
    Left = 214
    Top = 98
  end
  object dsPreview: TDataSource
    DataSet = qrPreview
    Left = 214
    Top = 146
  end
  object qrVarType: TFDQuery
    BeforeOpen = qrRowsBeforeOpen
    OnNewRecord = qrRowsNewRecord
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FetchOptions.AssignedValues = [evCache]
    FetchOptions.Cache = [fiBlobs, fiMeta]
    UpdateOptions.UpdateTableName = 'smeta.report_var'
    SQL.Strings = (
      'SELECT *'
      'FROM report_var_type')
    Left = 22
    Top = 202
  end
  object dsVarType: TDataSource
    DataSet = qrVarType
    Left = 22
    Top = 250
  end
  object bh: TBalloonHint
    Delay = 200
    HideAfter = 1000
    Left = 24
    Top = 59
  end
  object dsRowType: TDataSource
    DataSet = qrRowType
    Left = 70
    Top = 250
  end
  object qrRowType: TFDQuery
    BeforeOpen = qrRowsBeforeOpen
    OnNewRecord = qrRowsNewRecord
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FetchOptions.AssignedValues = [evCache]
    FetchOptions.Cache = [fiBlobs, fiMeta]
    FormatOptions.AssignedValues = [fvMapRules]
    FormatOptions.OwnMapRules = True
    FormatOptions.MapRules = <
      item
        SourceDataType = dtByte
        TargetDataType = dtBoolean
      end>
    UpdateOptions.UpdateTableName = 'smeta.report_row'
    SQL.Strings = (
      'SELECT 1 as ROW_TYPE_ID, "'#1060#1080#1082#1089#1080#1088#1086#1074#1072#1085#1085#1072#1103' '#1089#1090#1088#1086#1082#1072'" as ROW_TYPE_NAME'
      'UNION ALL'
      'SELECT 2 as ROW_TYPE_ID, "'#1057#1087#1080#1089#1086#1082'" as ROW_TYPE_NAME')
    Left = 70
    Top = 202
  end
  object qrReportListSql: TFDQuery
    MasterFields = 'REPORT_CATEGORY_ID'
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FetchOptions.AssignedValues = [evCache]
    FetchOptions.Cache = [fiBlobs, fiMeta]
    SQL.Strings = (
      'SELECT *'
      'FROM report_list_sql'
      'ORDER BY REPORT_LIST_SQL_NAME')
    Left = 118
    Top = 202
  end
end
