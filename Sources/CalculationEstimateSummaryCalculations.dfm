object frCalculationEstimateSummaryCalculations: TfrCalculationEstimateSummaryCalculations
  Left = 0
  Top = 0
  Width = 1116
  Height = 372
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object grSummaryCalculation: TJvDBGrid
    Left = 0
    Top = 62
    Width = 1116
    Height = 310
    Align = alClient
    DataSource = dsData
    DrawingStyle = gdsClassic
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ParentFont = False
    ParentShowHint = False
    PopupMenu = pm
    ShowHint = False
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDrawColumnCell = grSummaryCalculationDrawColumnCell
    OnDblClick = grSummaryCalculationDblClick
    AutoAppend = False
    IniStorage = FormStorage
    PostOnEnterKey = True
    SelectColumnsDialogStrings.Caption = 'Select columns'
    SelectColumnsDialogStrings.OK = '&OK'
    SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
    CanDelete = False
    EditControls = <>
    RowsHeight = 17
    TitleRowHeight = 17
    WordWrap = True
    WordWrapAllFields = True
    OnCanEditCell = grSummaryCalculationCanEditCell
    Columns = <
      item
        Expanded = False
        FieldName = 'TYPE_NAME'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = #1058#1080#1087
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SM_NUMBER'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = #1053#1086#1084#1077#1088
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SM_NAME'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = #1053#1072#1079#1074#1072#1085#1080#1077
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = #1054#1073#1098#1105#1084' '#1055#1058#1052
        Visible = False
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'STOIM'
        Title.Alignment = taCenter
        Title.Caption = #1042#1057#1045#1043#1054' '#1082' '#1086#1087#1083#1072#1090#1077
        Width = 100
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'STOIM_SMR'
        Title.Alignment = taCenter
        Title.Caption = #1042#1057#1045#1043#1054' '#1057#1052#1056
        Width = 100
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'ST_OHROPR'
        Title.Alignment = taCenter
        Title.Caption = #1042#1057#1045#1043#1054' '#1057' '#1054#1061#1056#1080#1054#1055#1056
        Width = 100
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'ZP'
        Title.Alignment = taCenter
        Title.Caption = #1047#1055
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ZP_PR'
        Title.Alignment = taCenter
        Title.Caption = #1047#1055' '#1087#1086' '#1087#1088'.5'
        Width = 100
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'EMiM'
        Title.Alignment = taCenter
        Title.Caption = #1069#1084#1080#1052
        Width = 100
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'ZP_MASH'
        Title.Alignment = taCenter
        Title.Caption = #1047#1055' '#1084#1072#1096
        Width = 100
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'MR'
        Title.Alignment = taCenter
        Title.Caption = #1052#1072#1090'-'#1083#1099
        Width = 100
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'TRANSP'
        Title.Alignment = taCenter
        Title.Caption = #1058#1088'-'#1090' '#1084#1072#1090'-'#1083#1099
        Width = 100
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'MR_DEVICE'
        Title.Alignment = taCenter
        Title.Caption = #1054#1073#1086#1088#1091#1076'-'#1077
        Width = 100
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'TRANSP_DEVICE'
        Title.Alignment = taCenter
        Title.Caption = #1058#1088'-'#1090' '#1086#1073#1086#1088#1091#1076'-'#1077
        Width = 100
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'TRUD'
        Title.Alignment = taCenter
        Title.Caption = #1058#1088#1091#1076'-'#1090#1099' '#1088#1072#1073
        Width = 100
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'TRUD_MASH'
        Title.Alignment = taCenter
        Title.Caption = #1058#1088#1091#1076'-'#1090#1099' '#1084#1072#1096
        Width = 100
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'OHROPR'
        Title.Alignment = taCenter
        Title.Caption = #1054#1061#1056#1080#1054#1055#1056
        Width = 100
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'PLAN_PRIB'
        Title.Alignment = taCenter
        Title.Caption = #1055#1083#1072#1085'. '#1087#1088#1080#1073'.'
        Width = 100
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'TEMP_BUILD'
        Title.Alignment = taCenter
        Title.Caption = #1042#1088#1077#1084'. '#1079#1076'. '#1080'  '#1089#1086#1086#1088#1091#1078'.'
        Width = 100
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'TEMP_RET'
        Title.Alignment = taCenter
        Title.Caption = #1042#1086#1079#1074#1088'. '#1084#1072#1090'.'
        Width = 100
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'ZIM_UDOR'
        Title.Alignment = taCenter
        Title.Caption = #1047#1080#1084#1085'. '#1091#1076#1086#1088'.'
        Width = 100
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'ZP_ZIM_UDOR'
        Title.Alignment = taCenter
        Title.Caption = #1047#1055' '#1074' '#1079#1080#1084#1085#1080#1093
        Width = 100
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'TRUD_ZIM'
        Title.Alignment = taCenter
        Title.Caption = #1058#1088#1091#1076'. '#1079#1080#1084'.'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GEN_PODR'
        Title.Alignment = taCenter
        Title.Caption = #1043#1077#1085'. '#1087#1086#1076#1088#1103#1076'.'
        Width = 100
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'SOC_STRAH'
        Title.Alignment = taCenter
        Title.Caption = #1057#1086#1094#1089#1090#1088#1072#1093
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TRAVEL_WORK'
        Title.Alignment = taCenter
        Title.Caption = #1056#1072#1079#1098#1077#1079#1076#1085#1099#1077
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'WORKER_DEPARTMENT'
        Title.Alignment = taCenter
        Title.Caption = #1055#1077#1088#1077#1074#1086#1079#1082#1072
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TRAVEL'
        Title.Alignment = taCenter
        Title.Caption = #1050#1086#1084#1072#1085#1076#1080#1088'-'#1077
        Width = 100
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'MR_DUMP'
        Title.Alignment = taCenter
        Title.Caption = #1057#1074#1072#1083#1082#1072
        Width = 100
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'DUMP_COUNT'
        Title.Alignment = taCenter
        Title.Caption = #1057#1074#1072#1083#1082#1072'('#1052#1047')'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FZP'
        Title.Alignment = taCenter
        Title.Caption = #1060#1047#1055
        Width = 100
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'ZEM_NAL'
        Title.Alignment = taCenter
        Title.Caption = #1047#1077#1084'. '#1085#1072#1083#1086#1075
        Width = 100
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'VEDOMS_NAL'
        Title.Alignment = taCenter
        Title.Caption = #1057#1083#1091#1078#1073'. '#1074#1077#1076'. '#1082#1086#1085#1090#1088'.'
        Width = 100
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'NDS'
        Title.Alignment = taCenter
        Title.Caption = #1053#1044#1057
        Width = 100
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'DEBET_NAL'
        Title.Alignment = taCenter
        Title.Caption = #1053#1072#1083#1086#1075' '#1086#1090' '#1074#1099#1088#1091#1095#1082#1080
        Width = 100
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        Title.Alignment = taCenter
        Title.Caption = #1048#1084#1087'. '#1084#1072#1090#1077#1088#1080#1072#1083#1099
        Visible = False
      end
      item
        Alignment = taRightJustify
        Expanded = False
        Title.Alignment = taCenter
        Title.Caption = #1048#1084#1087'. '#1086#1073#1086#1088#1091#1076'.'
        Visible = False
      end
      item
        Alignment = taRightJustify
        Expanded = False
        Title.Alignment = taCenter
        Title.Caption = #1056#1072#1079'. '#1089#1090#1086#1080#1084'. '#1084#1072#1090'.'
        Visible = False
      end
      item
        Alignment = taRightJustify
        Expanded = False
        Title.Alignment = taCenter
        Title.Caption = #1056#1072#1079'. '#1089#1090#1086#1080#1084'. '#1084#1077#1093'.'
        Visible = False
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'NormaAVG'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = #1057#1088'. '#1088#1072#1079#1088#1103#1076
        Width = 100
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'PR_352'
        Title.Alignment = taCenter
        Title.Caption = #1055#1088'. '#8470'352'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NORMAT'
        Title.Alignment = taCenter
        Title.Caption = #1053#1086#1088#1084#1072#1090#1080#1074#1085#1072#1103' '#1090#1088#1091#1076#1086#1077#1084#1082#1086#1089#1090#1100
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Si'
        Title.Alignment = taCenter
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MAT_ZAK'
        Title.Alignment = taCenter
        Title.Caption = #1052#1072#1090'-'#1083' '#1079#1072#1082#1072#1079#1095#1080#1082#1072
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TRANSP_ZAK'
        Title.Alignment = taCenter
        Title.Caption = #1058#1088'-'#1090' '#1084#1072#1090'-'#1083#1072' '#1079#1072#1082#1072#1079#1095#1080#1082#1072
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MR_DEVICE_ZAK'
        Title.Alignment = taCenter
        Title.Caption = #1054#1073#1086#1088#1091#1076'-'#1077' '#1079#1072#1082#1072#1079#1095#1080#1082#1072
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TRANSP_DEVICE_ZAK'
        Title.Alignment = taCenter
        Title.Caption = #1058#1088'-'#1090' '#1086#1073#1086#1088#1091#1076'-'#1103' '#1079#1072#1082#1072#1079#1095#1080#1082#1072
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'OTHER'
        Title.Alignment = taCenter
        Title.Caption = #1055#1088#1086#1095#1080#1077
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TRANSP_DUMP'
        Title.Alignment = taCenter
        Title.Caption = #1055#1077#1088#1077#1074#1086#1079#1082#1072' '#1084#1091#1089#1086#1088#1072' '#1057'310/'#1057'311'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TRANSP_CARGO'
        Title.Alignment = taCenter
        Title.Caption = #1055#1077#1088#1077#1074#1086#1079#1082#1072' '#1075#1088#1091#1079#1086#1074' '#1057'310/'#1057'311'
        Width = 100
        Visible = True
      end>
  end
  object pnlIndex: TPanel
    Left = 0
    Top = 0
    Width = 1116
    Height = 46
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object lbl1: TLabel
      Left = 647
      Top = 0
      Width = 45
      Height = 13
      Caption = #1053#1072' '#1076#1072#1090#1091':'
    end
    object lbl2: TLabel
      Left = 814
      Top = 0
      Width = 52
      Height = 13
      Caption = #1047#1085#1072#1095#1077#1085#1080#1077':'
    end
    object dbchkFL_APPLY_INDEX: TDBCheckBox
      Left = 509
      Top = -2
      Width = 121
      Height = 17
      Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100' '#1080#1085#1076#1077#1082#1089':'
      DataField = 'FL_APPLY_INDEX'
      DataSource = dsObject
      TabOrder = 0
      ValueChecked = '1'
      ValueUnchecked = '0'
      OnClick = dbchkFL_APPLY_INDEXClick
    end
    object dblkcbbindex_type_id: TDBLookupComboBox
      Left = 509
      Top = 16
      Width = 132
      Height = 21
      DataField = 'index_type_id'
      DataSource = dsObject
      KeyField = 'index_type_id'
      ListField = 'index_type_name'
      ListSource = dsIndexType
      TabOrder = 6
      OnClick = dblkcbbindex_type_idClick
    end
    object dblkcbbindex_type_date_id: TDBLookupComboBox
      Left = 647
      Top = 16
      Width = 161
      Height = 21
      DataField = 'index_type_date_id'
      DataSource = dsObject
      KeyField = 'index_type_date_id'
      ListField = 'index_type_date_name'
      ListSource = dsIndexTypeDate
      TabOrder = 7
      OnClick = dblkcbbindex_type_idClick
    end
    object dbedtindex_type_id: TDBEdit
      Left = 814
      Top = 16
      Width = 131
      Height = 21
      DataField = 'index_value'
      DataSource = dsObject
      TabOrder = 8
    end
    object btnSaveIndex: TBitBtn
      Left = 951
      Top = 12
      Width = 82
      Height = 25
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      TabOrder = 4
      Visible = False
      OnClick = btnSaveIndexClick
    end
    object btnCancelIndex: TBitBtn
      Left = 1035
      Top = 12
      Width = 79
      Height = 25
      Caption = #1054#1090#1084#1077#1085#1072
      TabOrder = 5
      Visible = False
      OnClick = btnCancelIndexClick
    end
    object grp1: TGroupBox
      Left = 151
      Top = 0
      Width = 162
      Height = 42
      Caption = #1044#1072#1090#1072' '#1085#1072#1095#1072#1083#1072' '#1089#1090#1088#1086#1080#1090#1077#1083#1100#1089#1090#1074#1072':'
      TabOrder = 2
      object cbbMonthBeginStroj: TComboBox
        Left = 5
        Top = 15
        Width = 98
        Height = 21
        Style = csDropDownList
        DropDownCount = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ItemIndex = 8
        ParentFont = False
        TabOrder = 0
        Text = #1057#1077#1085#1090#1103#1073#1088#1100
        OnChange = dblkcbbindex_type_idClick
        Items.Strings = (
          #1071#1085#1074#1072#1088#1100
          #1060#1077#1074#1088#1072#1083#1100
          #1052#1072#1088#1090
          #1040#1087#1088#1077#1083#1100
          #1052#1072#1081
          #1048#1102#1085#1100
          #1048#1102#1083#1100
          #1040#1074#1075#1091#1089#1090
          #1057#1077#1085#1090#1103#1073#1088#1100
          #1054#1082#1090#1103#1073#1088#1100
          #1053#1086#1103#1073#1088#1100
          #1044#1077#1082#1072#1073#1088#1100)
      end
      object seYearBeginStroj: TSpinEdit
        Left = 108
        Top = 15
        Width = 50
        Height = 22
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        MaxValue = 2100
        MinValue = 2012
        ParentFont = False
        TabOrder = 1
        Value = 2015
        OnChange = dblkcbbindex_type_idClick
      end
    end
    object grp2: TGroupBox
      Left = 314
      Top = 0
      Width = 181
      Height = 42
      Caption = #1044#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103' '#1089#1090#1088#1086#1080#1090#1077#1083#1100#1089#1090#1074#1072':'
      TabOrder = 3
      object seYearEndStroj: TSpinEdit
        Left = 127
        Top = 15
        Width = 50
        Height = 22
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        MaxValue = 2100
        MinValue = 2012
        ParentFont = False
        TabOrder = 1
        Value = 2015
        OnChange = dblkcbbindex_type_idClick
      end
      object cbbMonthEndStroj: TComboBox
        Left = 7
        Top = 15
        Width = 114
        Height = 21
        Style = csDropDownList
        DropDownCount = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ItemIndex = 8
        ParentFont = False
        TabOrder = 0
        Text = #1057#1077#1085#1090#1103#1073#1088#1100
        OnChange = dblkcbbindex_type_idClick
        Items.Strings = (
          #1071#1085#1074#1072#1088#1100
          #1060#1077#1074#1088#1072#1083#1100
          #1052#1072#1088#1090
          #1040#1087#1088#1077#1083#1100
          #1052#1072#1081
          #1048#1102#1085#1100
          #1048#1102#1083#1100
          #1040#1074#1075#1091#1089#1090
          #1057#1077#1085#1090#1103#1073#1088#1100
          #1054#1082#1090#1103#1073#1088#1100
          #1053#1086#1103#1073#1088#1100
          #1044#1077#1082#1072#1073#1088#1100)
      end
    end
    object grp3: TGroupBox
      Left = 0
      Top = 0
      Width = 150
      Height = 42
      Caption = #1044#1072#1090#1072' '#1089#1086#1089#1090#1072#1074#1083#1077#1085#1080#1103' '#1089#1084#1077#1090#1099':'
      TabOrder = 1
      object cbbMonthSmeta: TComboBox
        Left = 5
        Top = 15
        Width = 87
        Height = 21
        Style = csDropDownList
        DropDownCount = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ItemIndex = 8
        ParentFont = False
        TabOrder = 0
        Text = #1057#1077#1085#1090#1103#1073#1088#1100
        OnChange = dblkcbbindex_type_idClick
        Items.Strings = (
          #1071#1085#1074#1072#1088#1100
          #1060#1077#1074#1088#1072#1083#1100
          #1052#1072#1088#1090
          #1040#1087#1088#1077#1083#1100
          #1052#1072#1081
          #1048#1102#1085#1100
          #1048#1102#1083#1100
          #1040#1074#1075#1091#1089#1090
          #1057#1077#1085#1090#1103#1073#1088#1100
          #1054#1082#1090#1103#1073#1088#1100
          #1053#1086#1103#1073#1088#1100
          #1044#1077#1082#1072#1073#1088#1100)
      end
      object seYearSmeta: TSpinEdit
        Left = 95
        Top = 15
        Width = 50
        Height = 22
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        MaxValue = 2100
        MinValue = 2012
        ParentFont = False
        TabOrder = 1
        Value = 2015
        OnChange = dblkcbbindex_type_idClick
      end
    end
  end
  object pnl2: TPanel
    Left = 0
    Top = 46
    Width = 1116
    Height = 16
    Align = alTop
    BevelKind = bkFlat
    BevelOuter = bvNone
    TabOrder = 1
    Visible = False
    object img1: TImage
      Left = 0
      Top = 0
      Width = 1112
      Height = 12
      Cursor = crHandPoint
      Align = alClient
      Center = True
      ParentShowHint = False
      Picture.Data = {
        07544269746D61703E040000424D3E0400000000000036000000280000003900
        000006000000010018000000000008040000202E0000202E0000000000000000
        0000FFFFFF393939393939393939393939393939393939393939393939393939
        393939393939FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFF39393939393939393939393939393939393939393939393939
        3939393939393939FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFF3939393939393939393939393939393939393939393939
        39393939393939393939FFFFFF00FFFFFFFFFFFF393939393939393939393939
        393939393939393939393939393939FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF39393939393939393939
        3939393939393939393939393939393939FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3939393939393939
        39393939393939393939393939393939393939FFFFFFFFFFFF00FFFFFFFFFFFF
        FFFFFF393939393939393939393939393939393939393939FFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFF393939393939393939393939393939393939393939FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFF393939393939393939393939393939393939393939FFFFFFFF
        FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFF3939393939393939393939393939
        39FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF393939393939393939393939
        393939FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF39393939393939393939
        3939393939FFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FF393939393939393939FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFF393939393939393939FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFF393939393939393939FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF393939FFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF393939FFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF393939FFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFF00}
      ShowHint = False
      Transparent = True
      OnClick = img1Click
      ExplicitLeft = 520
      ExplicitTop = 8
      ExplicitWidth = 105
      ExplicitHeight = 105
    end
  end
  object qrData: TFDQuery
    AfterPost = qrDataAfterPost
    AfterCancel = qrDataAfterCancel
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FetchOptions.AssignedValues = [evCache]
    FetchOptions.Cache = [fiBlobs, fiMeta]
    FormatOptions.AssignedValues = [fvMapRules, fvDefaultParamDataType, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.OwnMapRules = True
    FormatOptions.MapRules = <
      item
        SourceDataType = dtByteString
        TargetDataType = dtAnsiString
      end
      item
        SourceDataType = dtFmtBCD
        TargetDataType = dtDouble
      end>
    FormatOptions.FmtDisplayNumeric = '### ### ### ##0.####'
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvCheckReadOnly]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.UpdateTableName = 'smeta.summary_calculation'
    UpdateOptions.KeyFields = 'id_estimate;id_act'
    UpdateObject = UpdateSQL
    SQL.Strings = (
      'SELECT '
      '  s.SM_ID AS id_estimate, '
      '  sm_type.id as sm_type,'
      '  s.OBJ_ID,'
      '  sm_type.NAME AS TYPE_NAME, '
      '  s.SM_NUMBER, '
      '  s.NAME AS SM_NAME, '
      
        '  SUM(IFNULL(d.ZPF, d.ZP * IF(o.FL_APPLY_INDEX, o.index_value, 1' +
        ' ))) AS ZP,'
      
        '  SUM(IFNULL(d.EMiMF, d.EMiM * IF(o.FL_APPLY_INDEX, o.index_valu' +
        'e, 1) )) AS EMiM,'
      
        '  SUM(IFNULL(d.MRF, d.MR * IF(o.FL_APPLY_INDEX, o.index_value, 1' +
        ') )) AS MR,'
      
        '  SUM(IFNULL(d.TRUDF, d.TRUD * IF(o.FL_APPLY_INDEX, o.index_valu' +
        'e, 1) )) AS TRUD,'
      
        '  SUM(IFNULL(d.TRUD_MASHF, d.TRUD_MASH * IF(o.FL_APPLY_INDEX, o.' +
        'index_value, 1) )) AS TRUD_MASH,'
      
        '  SUM(IFNULL(d.ZP_MASHF, d.ZP_MASH * IF(o.FL_APPLY_INDEX, o.inde' +
        'x_value, 1) )) AS ZP_MASH,'
      
        '  SUM(IFNULL(d.TRANSPF, d.TRANSP * IF(o.FL_APPLY_INDEX, o.index_' +
        'value, 1) )) AS TRANSP,'
      
        '  SUM(IFNULL(d.STOIMF, d.STOIM * IF(o.FL_APPLY_INDEX, o.index_va' +
        'lue, 1) )) AS STOIM,'
      
        '  SUM(IFNULL(d.OHROPRF, d.OHROPR * IF(o.FL_APPLY_INDEX, o.index_' +
        'value, 1) )) AS OHROPR,'
      
        '  SUM(IFNULL(d.PLAN_PRIBF, d.PLAN_PRIB * IF(o.FL_APPLY_INDEX, o.' +
        'index_value, 1) )) AS PLAN_PRIB,'
      
        '  SUM(IFNULL(d.ST_OHROPRF, d.ST_OHROPR * IF(o.FL_APPLY_INDEX, o.' +
        'index_value, 1) )) AS ST_OHROPR,'
      
        '  SUM(IFNULL(d.ZIM_UDORF, d.ZIM_UDOR * IF(o.FL_APPLY_INDEX, o.in' +
        'dex_value, 1) )) AS ZIM_UDOR,'
      
        '  SUM(IFNULL(d.ZP_ZIM_UDORF, d.ZP_ZIM_UDOR * IF(o.FL_APPLY_INDEX' +
        ', o.index_value, 1) )) AS ZP_ZIM_UDOR,'
      
        '  SUM(IFNULL(d.MR_DEVICEF, d.MR_DEVICE * IF(o.FL_APPLY_INDEX, o.' +
        'index_value, 1) )) AS MR_DEVICE,'
      
        '  SUM(IFNULL(d.TRANSP_DEVICEF, d.TRANSP_DEVICE * IF(o.FL_APPLY_I' +
        'NDEX, o.index_value, 1) )) AS TRANSP_DEVICE,'
      
        '  SUM(IFNULL(d.MR_DUMPF, d.MR_DUMP * IF(o.FL_APPLY_INDEX, o.inde' +
        'x_value, 1) )) AS MR_DUMP,'
      
        '  SUM(IFNULL(d.DUMP_COUNTF, d.DUMP_COUNT * IF(o.FL_APPLY_INDEX, ' +
        'o.index_value, 1) )) AS DUMP_COUNT,'
      
        '  SUM(IFNULL(d.TEMP_RETF, d.TEMP_RET * IF(o.FL_APPLY_INDEX, o.in' +
        'dex_value, 1) )) AS TEMP_RET,'
      '  AVG(IFNULL(d.NormaAVGF, d.NormaAVG)) AS NormaAVG,'
      
        '  SUM(IFNULL(d.PR_352F, d.PR_352 * IF(o.FL_APPLY_INDEX, o.index_' +
        'value, 1) )) AS PR_352,'
      
        '  SUM(IFNULL(d.TRUD_ZIMF, d.TRUD_ZIM * IF(o.FL_APPLY_INDEX, o.in' +
        'dex_value, 1) )) AS TRUD_ZIM,'
      
        '  SUM(IFNULL(d.SOC_STRAHF, d.SOC_STRAH * IF(o.FL_APPLY_INDEX, o.' +
        'index_value, 1) )) AS SOC_STRAH,'
      
        '  SUM(IFNULL(d.ZEM_NALF, d.ZEM_NAL * IF(o.FL_APPLY_INDEX, o.inde' +
        'x_value, 1) )) AS ZEM_NAL,'
      
        '  SUM(IFNULL(d.NDSF, d.NDS * IF(o.FL_APPLY_INDEX, o.index_value,' +
        ' 1) )) AS NDS,'
      
        '  SUM(IFNULL(d.DEBET_NALF, d.DEBET_NAL * IF(o.FL_APPLY_INDEX, o.' +
        'index_value, 1) )) AS DEBET_NAL,'
      
        '  SUM(IFNULL(d.VEDOMS_NALF, d.VEDOMS_NAL * IF(o.FL_APPLY_INDEX, ' +
        'o.index_value, 1) )) AS VEDOMS_NAL,'
      
        '  SUM(IFNULL(d.STOIM_SMRF, d.STOIM_SMR * IF(o.FL_APPLY_INDEX, o.' +
        'index_value, 1) )) AS STOIM_SMR,'
      
        '  SUM(IFNULL(d.TEMP_BUILDF, d.TEMP_BUILD * IF(o.FL_APPLY_INDEX, ' +
        'o.index_value, 1) )) AS TEMP_BUILD,'
      
        '  SUM(IFNULL(d.STOIM_SMRF, d.STOIM_SMR * IF(o.FL_APPLY_INDEX, o.' +
        'index_value, 1) )) AS STOIM_SMR,'
      
        '  SUM(IFNULL(d.GEN_PODRF, d.GEN_PODR * IF(o.FL_APPLY_INDEX, o.in' +
        'dex_value, 1) )) AS GEN_PODR, '
      
        '  SUM(IFNULL(d.ZP_PRF, d.ZP_PR * IF(o.FL_APPLY_INDEX, o.index_va' +
        'lue, 1) )) AS ZP_PR,'
      
        '  SUM(IFNULL(d.FZPF, d.FZP * IF(o.FL_APPLY_INDEX, o.index_value,' +
        ' 1) )) AS FZP,'
      
        '  SUM(IFNULL(d.TRAVELF, d.TRAVEL * IF(o.FL_APPLY_INDEX, o.index_' +
        'value, 1) )) AS TRAVEL,'
      
        '  SUM(IFNULL(d.TRAVEL_WORKF, d.TRAVEL_WORK * IF(o.FL_APPLY_INDEX' +
        ', o.index_value, 1) )) AS TRAVEL_WORK,'
      
        '  SUM(IFNULL(d.WORKER_DEPARTMENTF, d.WORKER_DEPARTMENT * IF(o.FL' +
        '_APPLY_INDEX, o.index_value, 1) )) AS WORKER_DEPARTMENT,'
      
        '  SUM(IFNULL(d.NORMATF, d.NORMAT * IF(o.FL_APPLY_INDEX, o.index_' +
        'value, 1) )) AS NORMAT,'
      '  AVG(IFNULL(d.SiF, d.Si)) AS Si,'
      
        '  SUM(IFNULL(d.MAT_ZAKF, d.MAT_ZAK * IF(o.FL_APPLY_INDEX, o.inde' +
        'x_value, 1) )) AS MAT_ZAK,'
      
        '  SUM(IFNULL(d.TRANSP_ZAKF, d.TRANSP_ZAK * IF(o.FL_APPLY_INDEX, ' +
        'o.index_value, 1) )) AS TRANSP_ZAK,'
      
        '  SUM(IFNULL(d.MR_DEVICE_ZAKF, d.MR_DEVICE_ZAK * IF(o.FL_APPLY_I' +
        'NDEX, o.index_value, 1) )) AS MR_DEVICE_ZAK,'
      
        '  SUM(IFNULL(d.TRANSP_DEVICE_ZAKF, d.TRANSP_DEVICE_ZAK * IF(o.FL' +
        '_APPLY_INDEX, o.index_value, 1) )) AS TRANSP_DEVICE_ZAK,'
      
        '  SUM(IFNULL(d.OTHERF, d.OTHER * IF(o.FL_APPLY_INDEX, o.index_va' +
        'lue, 1) )) AS OTHER,'
      
        '  SUM(IFNULL(d.TRANSP_DUMPF, d.TRANSP_DUMP * IF(o.FL_APPLY_INDEX' +
        ', o.index_value, 1) )) AS TRANSP_DUMP,'
      
        '  SUM(IFNULL(d.TRANSP_CARGOF, d.TRANSP_CARGO * IF(o.FL_APPLY_IND' +
        'EX, o.index_value, 1) )) AS TRANSP_CARGO,'
      ''
      
        '  SUM(IFNULL(d.TRANSP_CARGO * IF(o.FL_APPLY_INDEX, o.index_value' +
        ', 1) , 0)) AS TRANSP_CARGOF,'
      
        '  SUM(IFNULL(d.TRANSP_DUMP * IF(o.FL_APPLY_INDEX, o.index_value,' +
        ' 1) , 0)) AS TRANSP_DUMPF,'
      
        '  SUM(IFNULL(d.OTHER * IF(o.FL_APPLY_INDEX, o.index_value, 1) , ' +
        '0)) AS OTHERF,'
      
        '  SUM(IFNULL(d.TRANSP_DEVICE_ZAK * IF(o.FL_APPLY_INDEX, o.index_' +
        'value, 1) , 0)) AS TRANSP_DEVICE_ZAKF,'
      
        '  SUM(IFNULL(d.MR_DEVICE_ZAK * IF(o.FL_APPLY_INDEX, o.index_valu' +
        'e, 1) , 0)) AS MR_DEVICE_ZAKF,'
      
        '  SUM(IFNULL(d.TRANSP_ZAK * IF(o.FL_APPLY_INDEX, o.index_value, ' +
        '1) , 0)) AS TRANSP_ZAKF,'
      
        '  SUM(IFNULL(d.MAT_ZAK * IF(o.FL_APPLY_INDEX, o.index_value, 1) ' +
        ', 0)) AS MAT_ZAKF,'
      '  AVG(IFNULL(d.Si, 0)) AS SiF,'
      
        '  SUM(IFNULL(d.NORMAT * IF(o.FL_APPLY_INDEX, o.index_value, 1) ,' +
        ' 0)) AS NORMATF,'
      
        '  SUM(IFNULL(d.ZP * IF(o.FL_APPLY_INDEX, o.index_value, 1) , 0))' +
        ' AS ZPF,'
      
        '  SUM(IFNULL(d.EMiM * IF(o.FL_APPLY_INDEX, o.index_value, 1) , 0' +
        ')) AS EMiMF,'
      
        '  SUM(IFNULL(d.MR * IF(o.FL_APPLY_INDEX, o.index_value, 1) , 0))' +
        ' AS MRF,'
      
        '  SUM(IFNULL(d.TRUD * IF(o.FL_APPLY_INDEX, o.index_value, 1) , 0' +
        ')) AS TRUDF,'
      
        '  SUM(IFNULL(d.TRUD_MASH * IF(o.FL_APPLY_INDEX, o.index_value, 1' +
        ') , 0)) AS TRUD_MASHF,'
      
        '  SUM(IFNULL(d.ZP_MASH * IF(o.FL_APPLY_INDEX, o.index_value, 1) ' +
        ', 0)) AS ZP_MASHF,'
      
        '  SUM(IFNULL(d.TRANSP * IF(o.FL_APPLY_INDEX, o.index_value, 1) ,' +
        ' 0)) AS TRANSPF,'
      
        '  SUM(IFNULL(d.STOIM * IF(o.FL_APPLY_INDEX, o.index_value, 1) , ' +
        '0)) AS STOIMF,'
      
        '  SUM(IFNULL(d.OHROPR * IF(o.FL_APPLY_INDEX, o.index_value, 1) ,' +
        ' 0)) AS OHROPRF,'
      
        '  SUM(IFNULL(d.PLAN_PRIB * IF(o.FL_APPLY_INDEX, o.index_value, 1' +
        ') , 0)) AS PLAN_PRIBF,'
      
        '  SUM(IFNULL(d.ST_OHROPR * IF(o.FL_APPLY_INDEX, o.index_value, 1' +
        ') , 0)) AS ST_OHROPRF,'
      
        '  SUM(IFNULL(d.ZIM_UDOR * IF(o.FL_APPLY_INDEX, o.index_value, 1)' +
        ' , 0)) AS ZIM_UDORF,'
      
        '  SUM(IFNULL(d.ZP_ZIM_UDOR * IF(o.FL_APPLY_INDEX, o.index_value,' +
        ' 1) , 0)) AS ZP_ZIM_UDORF,'
      
        '  SUM(IFNULL(d.MR_DEVICE * IF(o.FL_APPLY_INDEX, o.index_value, 1' +
        ') , 0)) AS MR_DEVICEF,'
      
        '  SUM(IFNULL(d.TRANSP_DEVICE * IF(o.FL_APPLY_INDEX, o.index_valu' +
        'e, 1) , 0)) AS TRANSP_DEVICEF,'
      
        '  SUM(IFNULL(d.MR_DUMP * IF(o.FL_APPLY_INDEX, o.index_value, 1) ' +
        ', 0)) AS MR_DUMPF,'
      
        '  SUM(IFNULL(d.DUMP_COUNT * IF(o.FL_APPLY_INDEX, o.index_value, ' +
        '1) , 0)) AS DUMP_COUNTF,'
      
        '  SUM(IFNULL(d.TEMP_RET * IF(o.FL_APPLY_INDEX, o.index_value, 1)' +
        ' , 0)) AS TEMP_RETF,'
      
        '  SUM(IFNULL(d.PR_352 * IF(o.FL_APPLY_INDEX, o.index_value, 1) ,' +
        ' 0)) AS PR_352F,'
      
        '  SUM(IFNULL(d.TRUD_ZIM * IF(o.FL_APPLY_INDEX, o.index_value, 1)' +
        ' , 0)) AS TRUD_ZIMF,'
      
        '  SUM(IFNULL(d.SOC_STRAH * IF(o.FL_APPLY_INDEX, o.index_value, 1' +
        ') , 0)) AS SOC_STRAHF,'
      
        '  SUM(IFNULL(d.ZEM_NAL * IF(o.FL_APPLY_INDEX, o.index_value, 1) ' +
        ', 0)) AS ZEM_NALF,'
      
        '  SUM(IFNULL(d.NDS * IF(o.FL_APPLY_INDEX, o.index_value, 1) , 0)' +
        ') AS NDSF,'
      
        '  SUM(IFNULL(d.DEBET_NAL * IF(o.FL_APPLY_INDEX, o.index_value, 1' +
        ') , 0)) AS DEBET_NALF,'
      
        '  SUM(IFNULL(d.VEDOMS_NAL * IF(o.FL_APPLY_INDEX, o.index_value, ' +
        '1) , 0)) AS VEDOMS_NALF,'
      
        '  SUM(IFNULL(d.STOIM_SMR * IF(o.FL_APPLY_INDEX, o.index_value, 1' +
        ') , 0)) AS STOIM_SMRF,'
      
        '  SUM(IFNULL(d.TEMP_BUILD * IF(o.FL_APPLY_INDEX, o.index_value, ' +
        '1) , 0)) AS TEMP_BUILDF,'
      
        '  SUM(IFNULL(d.STOIM_SMR * IF(o.FL_APPLY_INDEX, o.index_value, 1' +
        ') , 0)) AS STOIM_SMRF,  '
      
        '  SUM(IFNULL(d.GEN_PODR * IF(o.FL_APPLY_INDEX, o.index_value, 1)' +
        ' , 0)) AS GEN_PODRF,'
      
        '  SUM(IFNULL(d.ZP_PR * IF(o.FL_APPLY_INDEX, o.index_value, 1) , ' +
        '0)) AS ZP_PRF,'
      
        '  SUM(IFNULL(d.FZP * IF(o.FL_APPLY_INDEX, o.index_value, 1) , 0)' +
        ') AS FZPF,'
      
        '  SUM(IFNULL(d.TRAVEL * IF(o.FL_APPLY_INDEX, o.index_value, 1) ,' +
        ' 0)) AS TRAVELF,'
      
        '  SUM(IFNULL(d.TRAVEL_WORK * IF(o.FL_APPLY_INDEX, o.index_value,' +
        ' 1) , 0)) AS TRAVEL_WORKF,'
      
        '  SUM(IFNULL(d.WORKER_DEPARTMENT * IF(o.FL_APPLY_INDEX, o.index_' +
        'value, 1) , 0)) AS WORKER_DEPARTMENTF'
      ''
      'FROM sm_type, objcards o, smetasourcedata s'
      'LEFT JOIN summary_calculation d ON d.SM_ID IN'
      '  (SELECT SM_ID'
      '   FROM smetasourcedata '
      '   WHERE DELETED=0 AND'
      '    ((smetasourcedata.SM_ID = s.SM_ID) OR'
      '           (smetasourcedata.PARENT_ID = s.SM_ID) OR '
      '           (smetasourcedata.PARENT_ID IN ('
      '             SELECT SM_ID'
      '             FROM smetasourcedata'
      '             WHERE PARENT_ID = s.SM_ID AND DELETED=0)))'
      '  ) '
      'WHERE '
      '  s.SM_TYPE = sm_type.ID AND '
      '  s.DELETED = 0 AND'
      
        '  s.OBJ_ID = (SELECT OBJ_ID FROM smetasourcedata WHERE SM_ID=:SM' +
        '_ID) AND'
      
        '  s.ACT = (SELECT ACT FROM smetasourcedata WHERE SM_ID=:SM_ID) A' +
        'ND'
      '  ((s.ACT = 0) OR (s.ACT = 1 AND '
      '  ((s.SM_ID = :SM_ID) OR'
      '           (s.PARENT_ID = :SM_ID) OR '
      '           (s.PARENT_ID IN ('
      '             SELECT SM_ID'
      '             FROM smetasourcedata'
      '             WHERE PARENT_ID = :SM_ID AND DELETED=0))) '
      '  ))'
      '  AND o.OBJ_ID=s.OBJ_ID'
      'GROUP BY s.SM_ID, s.OBJ_ID, TYPE_NAME, s.SM_NUMBER, SM_NAME'
      'ORDER BY FN_getSortSM(s.SM_ID);')
    Left = 9
    Top = 40
    ParamData = <
      item
        Name = 'SM_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object dsData: TDataSource
    DataSet = qrData
    Left = 48
    Top = 40
  end
  object pm: TPopupMenu
    OnPopup = pmPopup
    Left = 80
    Top = 40
    object mN3: TMenuItem
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1079#1072#1087#1080#1089#1100
      OnClick = mN3Click
    end
    object N1: TMenuItem
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077
      object N4: TMenuItem
        Caption = #1048#1089#1093#1086#1076#1085#1099#1077' '#1076#1072#1085#1085#1099#1077
        OnClick = grSummaryCalculationDblClick
      end
      object N5: TMenuItem
        Caption = #1054#1073#1098#1077#1082#1090
        OnClick = N5Click
      end
    end
    object N2: TMenuItem
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1088#1072#1089#1095#1077#1090#1072
      Visible = False
    end
    object mN4: TMenuItem
      Caption = #1042#1086#1089#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1079#1085#1072#1095#1077#1085#1080#1077
      OnClick = mN4Click
    end
    object mN5: TMenuItem
      Caption = #1042#1086#1089#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1079#1085#1072#1095#1077#1085#1080#1077' '#1074#1089#1077#1081' '#1089#1090#1088#1086#1082#1080
      OnClick = mN5Click
    end
    object mN6: TMenuItem
      Caption = #1042#1086#1089#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1074#1089#1077' '#1079#1085#1072#1095#1077#1085#1080#1103
      OnClick = mN6Click
    end
    object mN7: TMenuItem
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1088#1072#1089#1095#1077#1090#1072' '#1082#1086#1084#1072#1085#1076#1080#1088#1086#1074#1086#1095#1085#1099#1093'/'#1087#1077#1088#1077#1074#1086#1079#1082#1080'/'#1088#1072#1079#1098#1077#1079#1076#1085#1086#1075#1086
      OnClick = mN7Click
    end
  end
  object FormStorage: TJvFormStorage
    AppStorage = FormMain.AppIni
    AppStoragePath = '%FORM_NAME%\'
    Options = []
    StoredValues = <>
    Left = 32
    Top = 96
  end
  object UpdateSQL: TFDUpdateSQL
    Connection = DM.Connect
    ModifySQL.Strings = (
      'UPDATE '
      '  summary_calculation'
      'SET '
      '  SM_ID = :id_estimate,'
      '  ZPF = IF(:ZP=ZP, NULL, :ZP),'
      '  EMiMF = IF(:EMiM=EMiM, NULL, :EMiM),'
      '  MRF =  IF(:MR=MR, NULL, :MR),'
      '  TRUDF = IF( :TRUD=TRUD, NULL, :TRUD),'
      '  TRUD_MASHF =  IF(:TRUD_MASH=TRUD_MASH, NULL, :TRUD_MASH),'
      '  ZP_MASHF =  IF(:ZP_MASH=ZP_MASH, NULL, :ZP_MASH),'
      '  TRANSPF =  IF(:TRANSP=TRANSP, NULL, :TRANSP),'
      '  STOIMF =  IF(:STOIM=STOIM, NULL, :STOIM),'
      '  OHROPRF =  IF(:OHROPR=OHROPR, NULL, :OHROPR),'
      '  PLAN_PRIBF =  IF(:PLAN_PRIB=PLAN_PRIB, NULL, :PLAN_PRIB),'
      '  ST_OHROPRF =  IF(:ST_OHROPR=ST_OHROPR, NULL, :ST_OHROPR),'
      '  ZIM_UDORF =  IF(:ZIM_UDOR=ZIM_UDOR, NULL, :ZIM_UDOR),'
      
        '  ZP_ZIM_UDORF =  IF(:ZP_ZIM_UDOR=ZP_ZIM_UDOR, NULL, :ZP_ZIM_UDO' +
        'R),'
      '  MR_DEVICEF =  IF(:MR_DEVICE=MR_DEVICE, NULL, :MR_DEVICE),'
      
        '  TRANSP_DEVICEF =  IF(:TRANSP_DEVICE=TRANSP_DEVICE, NULL, :TRAN' +
        'SP_DEVICE),'
      '  MR_DUMPF =  IF(:MR_DUMP=MR_DUMP, NULL, :MR_DUMP),'
      '  DUMP_COUNTF = IF( :DUMP_COUNT=DUMP_COUNT, NULL, :DUMP_COUNT),'
      '  TEMP_RETF =  IF(:TEMP_RET=TEMP_RET, NULL, :TEMP_RET),'
      '  NormaAVGF =  IF(:NormaAVG=NormaAVG, NULL, :NormaAVG),'
      '  PR_352F =  IF(:PR_352=PR_352, NULL, :PR_352),'
      '  TRUD_ZIMF =  IF(:TRUD_ZIM=TRUD_ZIM, NULL, :TRUD_ZIM),'
      '  SOC_STRAHF =  IF( :SOC_STRAH=SOC_STRAH, NULL, :SOC_STRAH),'
      '  ZEM_NALF =  IF(:ZEM_NAL=ZEM_NAL, NULL, :ZEM_NAL),'
      '  NDSF=  IF(:NDS=NDS, NULL, :NDS),'
      '  DEBET_NALF=  IF(:DEBET_NAL=DEBET_NAL, NULL, :DEBET_NAL),'
      '  VEDOMS_NALF= IF(:VEDOMS_NAL=VEDOMS_NAL, NULL, :VEDOMS_NAL),'
      '  STOIM_SMRF= IF(:STOIM_SMR=STOIM_SMR, NULL, :STOIM_SMR),'
      '  TEMP_BUILDF= IF(:TEMP_BUILD=TEMP_BUILD, NULL, :TEMP_BUILD),'
      '  STOIM_SMRF= IF(:STOIM_SMR=STOIM_SMR, NULL, :STOIM_SMR),'
      '  GEN_PODRF =  IF(:GEN_PODR=GEN_PODR, NULL, :GEN_PODR),'
      '  ZP_PRF =  IF(:ZP_PR=ZP_PR, NULL, :ZP_PR),'
      '  FZPF  =  IF(:FZP=FZP, NULL, :FZP),'
      '  TRAVELF  =  IF(:TRAVEL=TRAVEL, NULL, :TRAVEL),'
      
        '  TRAVEL_WORKF  =  IF(TRAVEL_WORK=TRAVEL_WORK, NULL, :TRAVEL_WOR' +
        'K),'
      
        '  WORKER_DEPARTMENTF  =  IF(:WORKER_DEPARTMENT=WORKER_DEPARTMENT' +
        ', NULL, :WORKER_DEPARTMENT),'
      '  NORMATF = IF(:NORMAT=NORMAT, NULL, :NORMAT),'
      '  SiF = IF(:Si=Si, NULL, :Si),'
      '  OTHERF = IF(:OTHER=OTHER, NULL, :OTHER),'
      
        '  TRANSP_DEVICE_ZAKF = IF(:TRANSP_DEVICE_ZAK=TRANSP_DEVICE_ZAK, ' +
        'NULL, :TRANSP_DEVICE_ZAK),'
      
        '  MR_DEVICE_ZAKF = IF(:MR_DEVICE_ZAK=MR_DEVICE_ZAK, NULL, :MR_DE' +
        'VICE_ZAK),'
      '  TRANSP_ZAKF = IF(:TRANSP_ZAK=TRANSP_ZAK, NULL, :TRANSP_ZAK),'
      '  MAT_ZAKF = IF(:MAT_ZAK=MAT_ZAK, NULL, :MAT_ZAK),'
      
        '  TRANSP_CARGOF = IF(:TRANSP_CARGO=TRANSP_CARGO, NULL, :TRANSP_C' +
        'ARGO),'
      
        '  TRANSP_DUMPF = IF(:TRANSP_DUMP=TRANSP_DUMP, NULL, :TRANSP_DUMP' +
        ')'
      'WHERE   SM_ID = :id_estimate;')
    Left = 32
    Top = 160
  end
  object qrIndexType: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FetchOptions.AssignedValues = [evCache]
    FetchOptions.Cache = [fiBlobs, fiMeta]
    FormatOptions.AssignedValues = [fvMapRules, fvDefaultParamDataType, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.OwnMapRules = True
    FormatOptions.MapRules = <>
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvCheckReadOnly]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.CheckReadOnly = False
    SQL.Strings = (
      'select * from index_type')
    Left = 529
    Top = 56
  end
  object dsIndexType: TDataSource
    DataSet = qrIndexType
    Left = 568
    Top = 56
  end
  object qrIndexTypeDate: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FetchOptions.AssignedValues = [evCache]
    FetchOptions.Cache = [fiBlobs, fiMeta]
    FormatOptions.AssignedValues = [fvMapRules, fvDefaultParamDataType, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.OwnMapRules = True
    FormatOptions.MapRules = <
      item
        SourceDataType = dtByteString
        TargetDataType = dtAnsiString
      end
      item
        SourceDataType = dtFmtBCD
        TargetDataType = dtDouble
      end>
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvCheckReadOnly]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.CheckReadOnly = False
    SQL.Strings = (
      'SELECT * FROM index_type_date')
    Left = 673
    Top = 56
  end
  object dsIndexTypeDate: TDataSource
    DataSet = qrIndexTypeDate
    Left = 712
    Top = 56
  end
  object qrObject: TFDQuery
    AfterOpen = qrObjectAfterOpen
    BeforeEdit = qrObjectBeforeEdit
    AfterPost = qrObjectAfterOpen
    AfterCancel = qrObjectAfterOpen
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FetchOptions.AssignedValues = [evCache]
    FetchOptions.Cache = [fiBlobs, fiMeta]
    FormatOptions.AssignedValues = [fvMapRules, fvDefaultParamDataType, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.OwnMapRules = True
    FormatOptions.MapRules = <>
    FormatOptions.DefaultParamDataType = ftBCD
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvCheckReadOnly]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.CheckReadOnly = False
    SQL.Strings = (
      'SELECT * FROM objcards WHERE OBJ_ID=:OBJ_ID LIMIT 1')
    Left = 641
    Top = 104
    ParamData = <
      item
        Name = 'OBJ_ID'
        ParamType = ptInput
      end>
  end
  object dsObject: TDataSource
    DataSet = qrObject
    Left = 680
    Top = 104
  end
end
