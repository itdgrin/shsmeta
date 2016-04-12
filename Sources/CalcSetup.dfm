object fCalcSetup: TfCalcSetup
  Left = 0
  Top = 0
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1088#1072#1089#1095#1077#1090#1072' '#1090#1077#1082#1091#1097#1077#1081' '#1089#1090#1086#1080#1084#1086#1089#1090#1080
  ClientHeight = 697
  ClientWidth = 412
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnl1: TPanel
    Left = 0
    Top = 656
    Width = 412
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      412
      41)
    object btnCancel: TBitBtn
      Left = 330
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #1047#1072#1082#1088#1099#1090#1100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = btnCancelClick
    end
    object btnSave: TBitBtn
      Left = 249
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = btnSaveClick
    end
    object btnCalcSetupIndex: TBitBtn
      Left = 4
      Top = 8
      Width = 98
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = #1048#1085#1076#1077#1082#1089' '#1088#1086#1089#1090#1072
      TabOrder = 0
      OnClick = btnCalcSetupIndexClick
    end
  end
  object ScrollBox1: TScrollBox
    Left = 0
    Top = 0
    Width = 412
    Height = 656
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object GridPanel1: TGridPanel
      Left = 0
      Top = 20
      Width = 412
      Height = 20
      Margins.Left = 10
      Align = alTop
      BevelOuter = bvNone
      ColumnCollection = <
        item
          Value = 100.000000000000000000
        end
        item
          SizeStyle = ssAbsolute
          Value = 80.000000000000000000
        end>
      ControlCollection = <
        item
          Column = 0
          Control = lbl1
          Row = 0
        end
        item
          Column = 1
          Control = JvDBSpinEdit3
          Row = 0
        end>
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      RowCollection = <
        item
          Value = 100.000000000000000000
        end
        item
          SizeStyle = ssAuto
        end>
      TabOrder = 1
      DesignSize = (
        412
        20)
      object lbl1: TLabel
        Tag = 2
        AlignWithMargins = True
        Left = 7
        Top = 3
        Width = 322
        Height = 14
        Cursor = crHandPoint
        Margins.Left = 7
        Align = alClient
        Caption = #1042#1088#1077#1084#1077#1085#1085#1099#1077' '#1079#1076#1072#1085#1080#1103' '#1080' '#1089#1086#1086#1088#1091#1078#1077#1085#1080#1103', %:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsUnderline]
        ParentFont = False
        OnClick = lbl1Click
        ExplicitWidth = 190
        ExplicitHeight = 13
      end
      object JvDBSpinEdit3: TJvDBSpinEdit
        Left = 339
        Top = 0
        Width = 65
        Height = 20
        MaxValue = 100.000000000000000000
        ValueType = vtFloat
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Anchors = []
        ParentFont = False
        TabOrder = 0
        DataField = 'PER_TEMP_BUILD'
        DataSource = dsMain
      end
    end
    object GridPanel2: TGridPanel
      Left = 0
      Top = 40
      Width = 412
      Height = 20
      Align = alTop
      BevelOuter = bvNone
      ColumnCollection = <
        item
          Value = 100.000000000000000000
        end
        item
          SizeStyle = ssAbsolute
          Value = 80.000000000000000000
        end>
      ControlCollection = <
        item
          Column = 0
          Control = lbl3
          Row = 0
        end
        item
          Column = 1
          Control = dbchkAPPLY_WINTERPRISE_FLAG
          Row = 0
        end>
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      RowCollection = <
        item
          Value = 100.000000000000000000
        end>
      TabOrder = 2
      DesignSize = (
        412
        20)
      object lbl3: TLabel
        AlignWithMargins = True
        Left = 7
        Top = 3
        Width = 322
        Height = 14
        Margins.Left = 7
        Align = alClient
        Caption = #1047#1080#1084#1085#1077#1077' '#1091#1076#1086#1088#1086#1078#1072#1085#1080#1077':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ExplicitWidth = 106
        ExplicitHeight = 13
      end
      object dbchkAPPLY_WINTERPRISE_FLAG: TDBCheckBox
        Left = 365
        Top = 1
        Width = 13
        Height = 17
        Margins.Left = 7
        Anchors = []
        BiDiMode = bdLeftToRight
        DataField = 'FL_APPLY_WINTERPRICE'
        DataSource = dsMain
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentBiDiMode = False
        ParentFont = False
        TabOrder = 0
        ValueChecked = '1'
        ValueUnchecked = '0'
        OnClick = dbchkAPPLY_WINTERPRISE_FLAGClick
      end
    end
    object GridPanel3: TGridPanel
      Left = 0
      Top = 101
      Width = 412
      Height = 20
      Align = alTop
      BevelOuter = bvNone
      ColumnCollection = <
        item
          Value = 100.000000000000000000
        end
        item
          SizeStyle = ssAbsolute
          Value = 80.000000000000000000
        end>
      ControlCollection = <
        item
          Column = 0
          Control = lbl4
          Row = 0
        end
        item
          Column = 1
          Control = JvDBSpinEdit4
          Row = 0
        end>
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      RowCollection = <
        item
          Value = 100.000000000000000000
        end>
      TabOrder = 4
      DesignSize = (
        412
        20)
      object lbl4: TLabel
        AlignWithMargins = True
        Left = 7
        Top = 3
        Width = 322
        Height = 14
        Cursor = crHandPoint
        Margins.Left = 7
        Align = alClient
        Caption = #1059#1089#1083#1091#1075#1080' '#1075#1077#1085'. '#1087#1086#1076#1088#1103#1076#1095#1080#1082#1072', %:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsUnderline]
        ParentFont = False
        OnClick = lbl4Click
        ExplicitWidth = 146
        ExplicitHeight = 13
      end
      object JvDBSpinEdit4: TJvDBSpinEdit
        Left = 339
        Top = 0
        Width = 65
        Height = 20
        MaxValue = 100.000000000000000000
        ValueType = vtFloat
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Anchors = []
        ParentFont = False
        TabOrder = 0
        DataField = 'PER_CONTRACTOR'
        DataSource = dsMain
      end
    end
    object GridPanel4: TGridPanel
      Left = 0
      Top = 121
      Width = 412
      Height = 20
      Align = alTop
      BevelOuter = bvNone
      ColumnCollection = <
        item
          Value = 100.000000000000000000
        end
        item
          SizeStyle = ssAbsolute
          Value = 80.000000000000000000
        end>
      ControlCollection = <
        item
          Column = 0
          Control = lbl2
          Row = 0
        end
        item
          Column = 1
          Control = JvDBSpinEdit5
          Row = 0
        end>
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      RowCollection = <
        item
          Value = 100.000000000000000000
        end>
      TabOrder = 5
      DesignSize = (
        412
        20)
      object lbl2: TLabel
        AlignWithMargins = True
        Left = 7
        Top = 3
        Width = 322
        Height = 14
        Margins.Left = 7
        Align = alClient
        Caption = #1053#1077#1087#1088#1077#1076#1074#1080#1076#1077#1085#1085#1099#1077' '#1079#1072#1090#1088#1072#1090#1099', %:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ExplicitWidth = 157
        ExplicitHeight = 13
      end
      object JvDBSpinEdit5: TJvDBSpinEdit
        Left = 339
        Top = 0
        Width = 65
        Height = 20
        MaxValue = 100.000000000000000000
        ValueType = vtFloat
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Anchors = []
        ParentFont = False
        TabOrder = 0
        DataField = 'PER_NPZ'
        DataSource = dsMain
      end
    end
    object pnl2: TPanel
      Left = 0
      Top = 141
      Width = 412
      Height = 25
      Align = alTop
      Caption = #1050#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090#1099' '#1082' '#1089#1090#1072#1090#1100#1103#1084' '#1079#1072#1090#1088#1072#1090
      Color = clActiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold, fsItalic]
      ParentBackground = False
      ParentFont = False
      TabOrder = 6
    end
    object GridPanel5: TGridPanel
      Left = 0
      Top = 166
      Width = 412
      Height = 20
      Align = alTop
      BevelOuter = bvNone
      ColumnCollection = <
        item
          Value = 100.000000000000000000
        end
        item
          SizeStyle = ssAbsolute
          Value = 80.000000000000000000
        end>
      ControlCollection = <
        item
          Column = 0
          Control = lbl5
          Row = 0
        end
        item
          Column = 1
          Control = JvDBSpinEdit7
          Row = 0
        end>
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      RowCollection = <
        item
          Value = 100.000000000000000000
        end>
      TabOrder = 7
      DesignSize = (
        412
        20)
      object lbl5: TLabel
        AlignWithMargins = True
        Left = 7
        Top = 3
        Width = 322
        Height = 14
        Margins.Left = 7
        Align = alClient
        Caption = #1050#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090' '#1082' '#1079#1072#1088#1072#1073#1086#1090#1085#1086#1081' '#1087#1083#1072#1090#1077':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ExplicitWidth = 178
        ExplicitHeight = 13
      end
      object JvDBSpinEdit7: TJvDBSpinEdit
        Left = 339
        Top = 0
        Width = 65
        Height = 20
        MaxValue = 100.000000000000000000
        ValueType = vtFloat
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Anchors = []
        ParentFont = False
        TabOrder = 0
        DataField = 'K_ZP'
        DataSource = dsMain
      end
    end
    object GridPanel6: TGridPanel
      Left = 0
      Top = 206
      Width = 412
      Height = 20
      Align = alTop
      BevelOuter = bvNone
      ColumnCollection = <
        item
          Value = 100.000000000000000000
        end
        item
          SizeStyle = ssAbsolute
          Value = 80.000000000000000000
        end>
      ControlCollection = <
        item
          Column = 0
          Control = lbl6
          Row = 0
        end
        item
          Column = 1
          Control = jvdbspndtK_PP
          Row = 0
        end>
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      RowCollection = <
        item
          Value = 100.000000000000000000
        end>
      TabOrder = 9
      DesignSize = (
        412
        20)
      object lbl6: TLabel
        AlignWithMargins = True
        Left = 7
        Top = 3
        Width = 322
        Height = 14
        Margins.Left = 7
        Align = alClient
        Caption = #1050#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090' '#1082' '#1055#1083#1072#1085#1086#1074#1086#1081' '#1087#1088#1080#1073#1099#1083#1080':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ExplicitWidth = 182
        ExplicitHeight = 13
      end
      object jvdbspndtK_PP: TJvDBSpinEdit
        Left = 339
        Top = 0
        Width = 65
        Height = 20
        MaxValue = 100.000000000000000000
        ValueType = vtFloat
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Anchors = []
        ParentFont = False
        TabOrder = 0
        DataField = 'K_PP'
        DataSource = dsMain
      end
    end
    object GridPanel7: TGridPanel
      Left = 0
      Top = 186
      Width = 412
      Height = 20
      Align = alTop
      BevelOuter = bvNone
      ColumnCollection = <
        item
          Value = 100.000000000000000000
        end
        item
          SizeStyle = ssAbsolute
          Value = 80.000000000000000000
        end>
      ControlCollection = <
        item
          Column = 0
          Control = lbl7
          Row = 0
        end
        item
          Column = 1
          Control = JvDBSpinEdit8
          Row = 0
        end>
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      RowCollection = <
        item
          Value = 100.000000000000000000
        end>
      TabOrder = 8
      DesignSize = (
        412
        20)
      object lbl7: TLabel
        AlignWithMargins = True
        Left = 7
        Top = 3
        Width = 322
        Height = 14
        Margins.Left = 7
        Align = alClient
        Caption = #1050#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090' '#1082' '#1054#1061#1056' '#1080' '#1054#1055#1056':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ExplicitWidth = 139
        ExplicitHeight = 13
      end
      object JvDBSpinEdit8: TJvDBSpinEdit
        Left = 339
        Top = 0
        Width = 65
        Height = 20
        MaxValue = 100.000000000000000000
        ValueType = vtFloat
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Anchors = []
        ParentFont = False
        TabOrder = 0
        DataField = 'K_OHR'
        DataSource = dsMain
      end
    end
    object pnl3: TPanel
      Left = 0
      Top = 226
      Width = 412
      Height = 25
      Align = alTop
      Caption = #1053#1072#1083#1086#1075#1080' '#1080' '#1086#1090#1095#1080#1089#1083#1077#1085#1080#1103
      Color = clActiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold, fsItalic]
      ParentBackground = False
      ParentFont = False
      TabOrder = 10
    end
    object GridPanel8: TGridPanel
      Left = 0
      Top = 251
      Width = 412
      Height = 20
      Align = alTop
      BevelOuter = bvNone
      ColumnCollection = <
        item
          Value = 100.000000000000000000
        end
        item
          SizeStyle = ssAbsolute
          Value = 80.000000000000000000
        end>
      ControlCollection = <
        item
          Column = 0
          Control = lbl8
          Row = 0
        end
        item
          Column = 1
          Control = dbchkFL_K_PP
          Row = 0
        end>
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      RowCollection = <
        item
          Value = 100.000000000000000000
        end>
      TabOrder = 11
      DesignSize = (
        412
        20)
      object lbl8: TLabel
        AlignWithMargins = True
        Left = 7
        Top = 3
        Width = 322
        Height = 14
        Margins.Left = 7
        Align = alClient
        Caption = #1047#1077#1084#1077#1083#1100#1085#1099#1081' '#1085#1072#1083#1086#1075':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ExplicitWidth = 92
        ExplicitHeight = 13
      end
      object dbchkFL_K_PP: TDBCheckBox
        Left = 365
        Top = 1
        Width = 13
        Height = 17
        Margins.Left = 7
        Anchors = []
        BiDiMode = bdLeftToRight
        DataField = 'FL_CALC_ZEM_NAL'
        DataSource = dsMain
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentBiDiMode = False
        ParentFont = False
        TabOrder = 0
        ValueChecked = '1'
        ValueUnchecked = '0'
        OnClick = dbchkAPPLY_WINTERPRISE_FLAGClick
      end
    end
    object GridPanel9: TGridPanel
      Left = 0
      Top = 271
      Width = 412
      Height = 20
      Align = alTop
      BevelOuter = bvNone
      ColumnCollection = <
        item
          Value = 100.000000000000000000
        end
        item
          SizeStyle = ssAbsolute
          Value = 80.000000000000000000
        end>
      ControlCollection = <
        item
          Column = 0
          Control = lbl9
          Row = 0
        end
        item
          Column = 1
          Control = dbchkFL_CALC_ZEM_NAL
          Row = 0
        end>
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      RowCollection = <
        item
          Value = 100.000000000000000000
        end>
      TabOrder = 12
      DesignSize = (
        412
        20)
      object lbl9: TLabel
        AlignWithMargins = True
        Left = 7
        Top = 3
        Width = 322
        Height = 14
        Margins.Left = 7
        Align = alClient
        Caption = #1054#1090#1095#1080#1089#1083#1077#1085#1080#1103' '#1085#1072' '#1089#1086#1076#1077#1088#1078#1072#1085#1080#1077' '#1089#1083#1091#1078#1073' '#1074#1077#1076#1086#1084#1089#1090#1074#1077#1085#1085#1086#1075#1086' '#1082#1086#1085#1090#1088#1086#1083#1103':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ExplicitWidth = 316
        ExplicitHeight = 13
      end
      object dbchkFL_CALC_ZEM_NAL: TDBCheckBox
        Left = 365
        Top = 1
        Width = 13
        Height = 17
        Margins.Left = 7
        Anchors = []
        BiDiMode = bdLeftToRight
        DataField = 'FL_CALC_VEDOMS_NAL'
        DataSource = dsMain
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentBiDiMode = False
        ParentFont = False
        TabOrder = 0
        ValueChecked = '1'
        ValueUnchecked = '0'
        OnClick = dbchkAPPLY_WINTERPRISE_FLAGClick
      end
    end
    object GridPanel10: TGridPanel
      Left = 0
      Top = 291
      Width = 412
      Height = 20
      Align = alTop
      BevelOuter = bvNone
      ColumnCollection = <
        item
          Value = 100.000000000000000000
        end
        item
          SizeStyle = ssAbsolute
          Value = 80.000000000000000000
        end>
      ControlCollection = <
        item
          Column = 1
          Control = JvDBSpinEdit6
          Row = 0
        end
        item
          Column = 0
          Control = dbchkFl_SPEC_SCH
          Row = 0
        end>
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      RowCollection = <
        item
          Value = 100.000000000000000000
        end>
      TabOrder = 13
      DesignSize = (
        412
        20)
      object JvDBSpinEdit6: TJvDBSpinEdit
        Left = 339
        Top = 0
        Width = 65
        Height = 20
        MaxValue = 100.000000000000000000
        ValueType = vtFloat
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Anchors = []
        ParentFont = False
        TabOrder = 0
        DataField = 'NAL_USN'
        DataSource = dsMain
      end
      object dbchkFl_SPEC_SCH: TDBCheckBox
        AlignWithMargins = True
        Left = 7
        Top = 3
        Width = 322
        Height = 14
        Margins.Left = 7
        Align = alClient
        Caption = #1053#1072#1083#1086#1075' '#1087#1088#1080' '#1059#1057#1053', %:'
        DataField = 'Fl_NAL_USN'
        DataSource = dsMain
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        ValueChecked = '1'
        ValueUnchecked = '0'
      end
    end
    object GridPanel11: TGridPanel
      Left = 0
      Top = 311
      Width = 412
      Height = 20
      Align = alTop
      BevelOuter = bvNone
      ColumnCollection = <
        item
          Value = 100.000000000000000000
        end
        item
          SizeStyle = ssAbsolute
          Value = 80.000000000000000000
        end>
      ControlCollection = <
        item
          Column = 1
          Control = JvDBSpinEdit1
          Row = 0
        end
        item
          Column = 0
          Control = dbchkFL_CALC_VEDOMS_NAL2
          Row = 0
        end>
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      RowCollection = <
        item
          Value = 100.000000000000000000
        end
        item
          SizeStyle = ssAuto
        end>
      TabOrder = 14
      DesignSize = (
        412
        20)
      object JvDBSpinEdit1: TJvDBSpinEdit
        Left = 339
        Top = 0
        Width = 65
        Height = 20
        MaxValue = 100.000000000000000000
        ValueType = vtFloat
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Anchors = []
        ParentFont = False
        TabOrder = 0
        DataField = 'SPEC_SCH'
        DataSource = dsMain
      end
      object dbchkFL_CALC_VEDOMS_NAL2: TDBCheckBox
        AlignWithMargins = True
        Left = 7
        Top = 3
        Width = 322
        Height = 14
        Margins.Left = 7
        Align = alClient
        Caption = #1055#1077#1088#1077#1095#1080#1089#1083#1077#1085#1080#1103' '#1085#1072' '#1089#1087#1077#1094'.'#1089#1095#1077#1090', %:'
        DataField = 'Fl_SPEC_SCH'
        DataSource = dsMain
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        ValueChecked = '1'
        ValueUnchecked = '0'
      end
    end
    object pnl4: TPanel
      Left = 0
      Top = 331
      Width = 412
      Height = 25
      Align = alTop
      Caption = #1055#1088#1086#1095#1080#1077' '#1079#1072#1090#1088#1072#1090#1099
      Color = clActiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold, fsItalic]
      ParentBackground = False
      ParentFont = False
      TabOrder = 15
    end
    object pnl5: TPanel
      Left = 0
      Top = 416
      Width = 412
      Height = 25
      Align = alTop
      Caption = #1056#1072#1089#1095#1105#1090' '#1086#1090#1082#1083#1086#1085#1077#1085#1080#1081
      Color = clActiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold, fsItalic]
      ParentBackground = False
      ParentFont = False
      TabOrder = 19
    end
    object GridPanel12: TGridPanel
      Left = 0
      Top = 356
      Width = 412
      Height = 20
      Align = alTop
      BevelOuter = bvNone
      ColumnCollection = <
        item
          Value = 100.000000000000000000
        end
        item
          SizeStyle = ssAbsolute
          Value = 80.000000000000000000
        end>
      ControlCollection = <
        item
          Column = 0
          Control = lbl10
          Row = 0
        end
        item
          Column = 1
          Control = dbchkFL_CALC_ZEM_NAL1
          Row = 0
        end>
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      RowCollection = <
        item
          Value = 100.000000000000000000
        end>
      TabOrder = 16
      DesignSize = (
        412
        20)
      object lbl10: TLabel
        AlignWithMargins = True
        Left = 7
        Top = 3
        Width = 322
        Height = 14
        Margins.Left = 7
        Align = alClient
        Caption = #1056#1072#1089#1095#1105#1090' '#1082#1086#1084#1072#1085#1076#1080#1088#1086#1074#1086#1095#1085#1099#1093' '#1088#1072#1089#1093#1086#1076#1086#1074':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ExplicitWidth = 186
        ExplicitHeight = 13
      end
      object dbchkFL_CALC_ZEM_NAL1: TDBCheckBox
        Left = 365
        Top = 1
        Width = 13
        Height = 17
        Margins.Left = 7
        Anchors = []
        BiDiMode = bdLeftToRight
        DataField = 'FL_CALC_TRAVEL'
        DataSource = dsMain
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentBiDiMode = False
        ParentFont = False
        TabOrder = 0
        ValueChecked = '1'
        ValueUnchecked = '0'
        OnClick = dbchkAPPLY_WINTERPRISE_FLAGClick
      end
    end
    object GridPanel13: TGridPanel
      Left = 0
      Top = 396
      Width = 412
      Height = 20
      Align = alTop
      BevelOuter = bvNone
      ColumnCollection = <
        item
          Value = 100.000000000000000000
        end
        item
          SizeStyle = ssAbsolute
          Value = 80.000000000000000000
        end>
      ControlCollection = <
        item
          Column = 0
          Control = lbl11
          Row = 0
        end
        item
          Column = 1
          Control = dbchkFL_CALC_ZEM_NAL2
          Row = 0
        end>
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      RowCollection = <
        item
          Value = 100.000000000000000000
        end>
      TabOrder = 18
      DesignSize = (
        412
        20)
      object lbl11: TLabel
        AlignWithMargins = True
        Left = 7
        Top = 3
        Width = 322
        Height = 14
        Margins.Left = 7
        Align = alClient
        Caption = #1056#1072#1089#1095#1105#1090' '#1088#1072#1089#1093#1086#1076#1086#1074' '#1085#1072' '#1087#1077#1088#1077#1074#1086#1079#1082#1091' '#1088#1072#1073#1086#1095#1080#1093':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ExplicitWidth = 206
        ExplicitHeight = 13
      end
      object dbchkFL_CALC_ZEM_NAL2: TDBCheckBox
        Left = 365
        Top = 1
        Width = 13
        Height = 17
        Margins.Left = 7
        Anchors = []
        BiDiMode = bdLeftToRight
        DataField = 'FL_CALC_TRAVEL_WORK'
        DataSource = dsMain
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentBiDiMode = False
        ParentFont = False
        TabOrder = 0
        ValueChecked = '1'
        ValueUnchecked = '0'
        OnClick = dbchkAPPLY_WINTERPRISE_FLAGClick
      end
    end
    object GridPanel14: TGridPanel
      Left = 0
      Top = 376
      Width = 412
      Height = 20
      Align = alTop
      BevelOuter = bvNone
      ColumnCollection = <
        item
          Value = 100.000000000000000000
        end
        item
          SizeStyle = ssAbsolute
          Value = 80.000000000000000000
        end>
      ControlCollection = <
        item
          Column = 0
          Control = lbl12
          Row = 0
        end
        item
          Column = 1
          Control = dbchkFL_CALC_ZEM_NAL3
          Row = 0
        end>
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      RowCollection = <
        item
          Value = 100.000000000000000000
        end>
      TabOrder = 17
      DesignSize = (
        412
        20)
      object lbl12: TLabel
        AlignWithMargins = True
        Left = 7
        Top = 3
        Width = 322
        Height = 14
        Margins.Left = 7
        Align = alClient
        Caption = #1056#1072#1089#1095#1105#1090' '#1088#1072#1079#1098#1077#1079#1076#1085#1086#1075#1086' '#1093#1072#1088#1072#1082#1090#1077#1088#1072' '#1088#1072#1073#1086#1090':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ExplicitWidth = 197
        ExplicitHeight = 13
      end
      object dbchkFL_CALC_ZEM_NAL3: TDBCheckBox
        Left = 365
        Top = 1
        Width = 13
        Height = 17
        Margins.Left = 7
        Anchors = []
        BiDiMode = bdLeftToRight
        DataField = 'FL_CALC_WORKER_DEPARTMENT'
        DataSource = dsMain
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentBiDiMode = False
        ParentFont = False
        TabOrder = 0
        ValueChecked = '1'
        ValueUnchecked = '0'
        OnClick = dbchkAPPLY_WINTERPRISE_FLAGClick
      end
    end
    object GridPanel15: TGridPanel
      Left = 0
      Top = 441
      Width = 412
      Height = 20
      Align = alTop
      BevelOuter = bvNone
      ColumnCollection = <
        item
          Value = 100.000000000000000000
        end
        item
          SizeStyle = ssAbsolute
          Value = 80.000000000000000000
        end>
      ControlCollection = <
        item
          Column = 0
          Control = lbl13
          Row = 0
        end
        item
          Column = 1
          Control = dbchkFL_CALC_TRAVEL_WORK
          Row = 0
        end>
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      RowCollection = <
        item
          Value = 100.000000000000000000
        end>
      TabOrder = 20
      DesignSize = (
        412
        20)
      object lbl13: TLabel
        AlignWithMargins = True
        Left = 7
        Top = 3
        Width = 322
        Height = 14
        Margins.Left = 7
        Align = alClient
        Caption = #1052#1072#1090#1077#1088#1080#1072#1083#1099':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ExplicitWidth = 62
        ExplicitHeight = 13
      end
      object dbchkFL_CALC_TRAVEL_WORK: TDBCheckBox
        Left = 365
        Top = 1
        Width = 13
        Height = 17
        Margins.Left = 7
        Anchors = []
        BiDiMode = bdLeftToRight
        DataField = 'FL_DIFF_MAT'
        DataSource = dsMain
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentBiDiMode = False
        ParentFont = False
        TabOrder = 0
        ValueChecked = '1'
        ValueUnchecked = '0'
        OnClick = dbchkAPPLY_WINTERPRISE_FLAGClick
      end
    end
    object GridPanel16: TGridPanel
      Left = 0
      Top = 521
      Width = 412
      Height = 20
      Align = alTop
      BevelOuter = bvNone
      ColumnCollection = <
        item
          Value = 100.000000000000000000
        end
        item
          SizeStyle = ssAbsolute
          Value = 80.000000000000000000
        end>
      ControlCollection = <
        item
          Column = 0
          Control = lbl14
          Row = 0
        end
        item
          Column = 1
          Control = dbchkFL_CALC_TRAVEL_WORK1
          Row = 0
        end>
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      RowCollection = <
        item
          Value = 100.000000000000000000
        end>
      TabOrder = 24
      DesignSize = (
        412
        20)
      object lbl14: TLabel
        AlignWithMargins = True
        Left = 7
        Top = 3
        Width = 322
        Height = 14
        Margins.Left = 7
        Align = alClient
        Caption = #1053#1072#1083#1086#1075#1080' '#1080' '#1086#1090#1095#1080#1089#1083#1077#1085#1080#1103':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ExplicitWidth = 111
        ExplicitHeight = 13
      end
      object dbchkFL_CALC_TRAVEL_WORK1: TDBCheckBox
        Left = 365
        Top = 1
        Width = 13
        Height = 17
        Margins.Left = 7
        Anchors = []
        BiDiMode = bdLeftToRight
        DataField = 'FL_DIFF_NAL'
        DataSource = dsMain
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentBiDiMode = False
        ParentFont = False
        TabOrder = 0
        ValueChecked = '1'
        ValueUnchecked = '0'
        OnClick = dbchkAPPLY_WINTERPRISE_FLAGClick
      end
    end
    object GridPanel17: TGridPanel
      Left = 0
      Top = 501
      Width = 412
      Height = 20
      Align = alTop
      BevelOuter = bvNone
      ColumnCollection = <
        item
          Value = 100.000000000000000000
        end
        item
          SizeStyle = ssAbsolute
          Value = 80.000000000000000000
        end>
      ControlCollection = <
        item
          Column = 0
          Control = lbl15
          Row = 0
        end
        item
          Column = 1
          Control = dbchkFL_CALC_TRAVEL_WORK2
          Row = 0
        end>
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      RowCollection = <
        item
          Value = 100.000000000000000000
        end>
      TabOrder = 23
      DesignSize = (
        412
        20)
      object lbl15: TLabel
        AlignWithMargins = True
        Left = 7
        Top = 3
        Width = 322
        Height = 14
        Margins.Left = 7
        Align = alClient
        Caption = #1055#1088#1086#1095#1080#1077' '#1079#1072#1090#1088#1072#1090#1099':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ExplicitWidth = 87
        ExplicitHeight = 13
      end
      object dbchkFL_CALC_TRAVEL_WORK2: TDBCheckBox
        Left = 365
        Top = 1
        Width = 13
        Height = 17
        Margins.Left = 7
        Anchors = []
        BiDiMode = bdLeftToRight
        DataField = 'FL_DIFF_OTHER'
        DataSource = dsMain
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentBiDiMode = False
        ParentFont = False
        TabOrder = 0
        ValueChecked = '1'
        ValueUnchecked = '0'
        OnClick = dbchkAPPLY_WINTERPRISE_FLAGClick
      end
    end
    object GridPanel18: TGridPanel
      Left = 0
      Top = 481
      Width = 412
      Height = 20
      Align = alTop
      BevelOuter = bvNone
      ColumnCollection = <
        item
          Value = 100.000000000000000000
        end
        item
          SizeStyle = ssAbsolute
          Value = 80.000000000000000000
        end>
      ControlCollection = <
        item
          Column = 0
          Control = lbl16
          Row = 0
        end
        item
          Column = 1
          Control = dbchkFL_CALC_TRAVEL_WORK3
          Row = 0
        end>
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      RowCollection = <
        item
          Value = 100.000000000000000000
        end>
      TabOrder = 22
      DesignSize = (
        412
        20)
      object lbl16: TLabel
        AlignWithMargins = True
        Left = 7
        Top = 3
        Width = 322
        Height = 14
        Margins.Left = 7
        Align = alClient
        Caption = #1069#1082#1089#1087#1083#1091#1072#1090#1072#1094#1080#1103' '#1084#1072#1096#1080#1085' '#1080' '#1084#1077#1093#1072#1085#1080#1079#1084#1086#1074':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ExplicitWidth = 182
        ExplicitHeight = 13
      end
      object dbchkFL_CALC_TRAVEL_WORK3: TDBCheckBox
        Left = 365
        Top = 1
        Width = 13
        Height = 17
        Margins.Left = 7
        Anchors = []
        BiDiMode = bdLeftToRight
        DataField = 'FL_DIFF_EMIM'
        DataSource = dsMain
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentBiDiMode = False
        ParentFont = False
        TabOrder = 0
        ValueChecked = '1'
        ValueUnchecked = '0'
        OnClick = dbchkAPPLY_WINTERPRISE_FLAGClick
      end
    end
    object GridPanel19: TGridPanel
      Left = 0
      Top = 461
      Width = 412
      Height = 20
      Align = alTop
      BevelOuter = bvNone
      ColumnCollection = <
        item
          Value = 100.000000000000000000
        end
        item
          SizeStyle = ssAbsolute
          Value = 80.000000000000000000
        end>
      ControlCollection = <
        item
          Column = 0
          Control = lbl17
          Row = 0
        end
        item
          Column = 1
          Control = dbchkFL_CALC_TRAVEL_WORK4
          Row = 0
        end>
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      RowCollection = <
        item
          Value = 100.000000000000000000
        end>
      TabOrder = 21
      DesignSize = (
        412
        20)
      object lbl17: TLabel
        AlignWithMargins = True
        Left = 7
        Top = 3
        Width = 322
        Height = 14
        Margins.Left = 7
        Align = alClient
        Caption = #1058#1088#1072#1085#1089#1087#1086#1088#1090':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ExplicitWidth = 57
        ExplicitHeight = 13
      end
      object dbchkFL_CALC_TRAVEL_WORK4: TDBCheckBox
        Left = 365
        Top = 1
        Width = 13
        Height = 17
        Margins.Left = 7
        Anchors = []
        BiDiMode = bdLeftToRight
        DataField = 'FL_DIFF_TRANSP'
        DataSource = dsMain
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentBiDiMode = False
        ParentFont = False
        TabOrder = 0
        ValueChecked = '1'
        ValueUnchecked = '0'
        OnClick = dbchkAPPLY_WINTERPRISE_FLAGClick
      end
    end
    object pnl6: TPanel
      Left = 0
      Top = 541
      Width = 412
      Height = 34
      Align = alTop
      Color = clActiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold, fsItalic]
      ParentBackground = False
      ParentFont = False
      TabOrder = 25
      object lbl23: TLabel
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 404
        Height = 26
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 
          #1057#1091#1084#1084#1099', '#1091#1095#1080#1090#1099#1074#1072#1077#1084#1099#1077' '#1087#1088#1080' '#1088#1072#1089#1095#1077#1090#1072#1093' '#1074' '#1089#1074#1103#1079#1080' '#1089' '#1082#1086#1088#1088#1077#1082#1090#1080#1088#1086#1074#1082#1086#1081' '#1082#1086#1085#1090#1088#1072#1082 +
          #1090#1085#1086#1081' '#1094#1077#1085#1099' ('#1086#1090#1082#1083#1086#1085#1077#1085#1080#1103')'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold, fsItalic]
        ParentFont = False
        WordWrap = True
        ExplicitLeft = 193
        ExplicitTop = -17
        ExplicitWidth = 410
        ExplicitHeight = 48
      end
    end
    object GridPanel20: TGridPanel
      Left = 0
      Top = 575
      Width = 412
      Height = 20
      Align = alTop
      BevelOuter = bvNone
      ColumnCollection = <
        item
          Value = 100.000000000000000000
        end
        item
          SizeStyle = ssAbsolute
          Value = 80.000000000000000000
        end>
      ControlCollection = <
        item
          Column = 0
          Control = lbl18
          Row = 0
        end
        item
          Column = 1
          Control = dbchkFL_DIFF_MAT_ZAK
          Row = 0
        end>
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      RowCollection = <
        item
          Value = 100.000000000000000000
        end>
      TabOrder = 26
      DesignSize = (
        412
        20)
      object lbl18: TLabel
        AlignWithMargins = True
        Left = 7
        Top = 3
        Width = 322
        Height = 14
        Margins.Left = 7
        Align = alClient
        Caption = #1052#1072#1090#1077#1088#1080#1072#1083#1099' '#1047#1072#1082#1072#1079#1095#1080#1082#1072':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ExplicitWidth = 118
        ExplicitHeight = 13
      end
      object dbchkFL_DIFF_MAT_ZAK: TDBCheckBox
        Left = 365
        Top = 1
        Width = 13
        Height = 17
        Margins.Left = 7
        Anchors = []
        BiDiMode = bdLeftToRight
        DataField = 'FL_DIFF_MAT_ZAK'
        DataSource = dsMain
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentBiDiMode = False
        ParentFont = False
        TabOrder = 0
        ValueChecked = '1'
        ValueUnchecked = '0'
        OnClick = dbchkAPPLY_WINTERPRISE_FLAGClick
      end
    end
    object GridPanel21: TGridPanel
      Left = 0
      Top = 595
      Width = 412
      Height = 20
      Align = alTop
      BevelOuter = bvNone
      ColumnCollection = <
        item
          Value = 100.000000000000000000
        end
        item
          SizeStyle = ssAbsolute
          Value = 80.000000000000000000
        end>
      ControlCollection = <
        item
          Column = 0
          Control = lbl19
          Row = 0
        end
        item
          Column = 1
          Control = dbchkFL_DIFF_NAL_USN
          Row = 0
        end>
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      RowCollection = <
        item
          Value = 100.000000000000000000
        end>
      TabOrder = 27
      DesignSize = (
        412
        20)
      object lbl19: TLabel
        AlignWithMargins = True
        Left = 7
        Top = 3
        Width = 322
        Height = 14
        Margins.Left = 7
        Align = alClient
        Caption = #1053#1072#1083#1086#1075' '#1087#1088#1080' '#1059#1057#1053':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ExplicitWidth = 79
        ExplicitHeight = 13
      end
      object dbchkFL_DIFF_NAL_USN: TDBCheckBox
        Left = 365
        Top = 1
        Width = 13
        Height = 17
        Margins.Left = 7
        Anchors = []
        BiDiMode = bdLeftToRight
        DataField = 'FL_DIFF_NAL_USN'
        DataSource = dsMain
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentBiDiMode = False
        ParentFont = False
        TabOrder = 0
        ValueChecked = '1'
        ValueUnchecked = '0'
        OnClick = dbchkAPPLY_WINTERPRISE_FLAGClick
      end
    end
    object GridPanel22: TGridPanel
      Left = 0
      Top = 635
      Width = 412
      Height = 20
      Align = alTop
      BevelOuter = bvNone
      ColumnCollection = <
        item
          Value = 100.000000000000000000
        end
        item
          SizeStyle = ssAbsolute
          Value = 80.000000000000000000
        end>
      ControlCollection = <
        item
          Column = 0
          Control = lbl20
          Row = 0
        end
        item
          Column = 1
          Control = dbchkFL_DIFF_DEVICE_PODR_WITH_NAL
          Row = 0
        end>
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      RowCollection = <
        item
          Value = 100.000000000000000000
        end>
      TabOrder = 29
      DesignSize = (
        412
        20)
      object lbl20: TLabel
        AlignWithMargins = True
        Left = 7
        Top = 3
        Width = 322
        Height = 14
        Margins.Left = 7
        Align = alClient
        Caption = #1054#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1077' '#1087#1086#1076#1088#1103#1076#1095#1080#1082#1072' '#1089' '#1085#1072#1083#1086#1075#1072#1084#1080':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ExplicitWidth = 202
        ExplicitHeight = 13
      end
      object dbchkFL_DIFF_DEVICE_PODR_WITH_NAL: TDBCheckBox
        Left = 365
        Top = 1
        Width = 13
        Height = 17
        Margins.Left = 7
        Anchors = []
        BiDiMode = bdLeftToRight
        DataField = 'FL_DIFF_DEVICE_PODR_WITH_NAL'
        DataSource = dsMain
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentBiDiMode = False
        ParentFont = False
        TabOrder = 0
        ValueChecked = '1'
        ValueUnchecked = '0'
        OnClick = dbchkAPPLY_WINTERPRISE_FLAGClick
      end
    end
    object GridPanel23: TGridPanel
      Left = 0
      Top = 615
      Width = 412
      Height = 20
      Align = alTop
      BevelOuter = bvNone
      ColumnCollection = <
        item
          Value = 100.000000000000000000
        end
        item
          SizeStyle = ssAbsolute
          Value = 80.000000000000000000
        end>
      ControlCollection = <
        item
          Column = 0
          Control = lbl21
          Row = 0
        end
        item
          Column = 1
          Control = dbchkFL_DIFF_NDS
          Row = 0
        end>
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      RowCollection = <
        item
          Value = 100.000000000000000000
        end>
      TabOrder = 28
      DesignSize = (
        412
        20)
      object lbl21: TLabel
        AlignWithMargins = True
        Left = 7
        Top = 3
        Width = 322
        Height = 14
        Margins.Left = 7
        Align = alClient
        Caption = #1053#1044#1057':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ExplicitWidth = 26
        ExplicitHeight = 13
      end
      object dbchkFL_DIFF_NDS: TDBCheckBox
        Left = 365
        Top = 1
        Width = 13
        Height = 17
        Margins.Left = 7
        Anchors = []
        BiDiMode = bdLeftToRight
        DataField = 'FL_DIFF_NDS'
        DataSource = dsMain
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentBiDiMode = False
        ParentFont = False
        TabOrder = 0
        ValueChecked = '1'
        ValueUnchecked = '0'
        OnClick = dbchkAPPLY_WINTERPRISE_FLAGClick
      end
    end
    object GridPanel24: TGridPanel
      Left = 0
      Top = 60
      Width = 412
      Height = 41
      Align = alTop
      BevelOuter = bvNone
      ColumnCollection = <
        item
          Value = 100.000000000000000000
        end
        item
          SizeStyle = ssAbsolute
          Value = 80.000000000000000000
        end>
      ControlCollection = <
        item
          Column = 1
          Control = JvDBSpinEdit2
          Row = 0
        end
        item
          Column = 0
          Control = pnl7
          Row = 0
        end>
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      RowCollection = <
        item
          Value = 100.000000000000000000
        end
        item
          SizeStyle = ssAuto
        end>
      TabOrder = 3
      object JvDBSpinEdit2: TJvDBSpinEdit
        AlignWithMargins = True
        Left = 339
        Top = 0
        Width = 65
        Height = 21
        Margins.Left = 7
        Margins.Top = 0
        Margins.Right = 8
        Align = alTop
        MaxValue = 100.000000000000000000
        ValueType = vtFloat
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        DataField = 'PER_WINTERPRICE'
        DataSource = dsMain
      end
      object pnl7: TPanel
        Left = 0
        Top = 0
        Width = 193
        Height = 41
        Align = alLeft
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        DesignSize = (
          193
          41)
        object JvDBRadioPanel1: TJvDBRadioPanel
          Left = 0
          Top = 3
          Width = 153
          Height = 36
          Anchors = []
          BevelOuter = bvNone
          DataField = 'WINTERPRICE_TYPE'
          DataSource = dsMain
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Items.Strings = (
            ' '
            #1053#1044#1047'-2 '#1087#1086' '#1074#1080#1076#1072#1084' '#1088#1072#1073#1086#1090)
          ParentFont = False
          TabOrder = 1
          Values.Strings = (
            '0'
            '1')
        end
        object pnl8: TPanel
          Left = 24
          Top = 1
          Width = 169
          Height = 20
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          object lbl22: TLabel
            Tag = 1
            Left = 0
            Top = 3
            Width = 159
            Height = 13
            Cursor = crHandPoint
            Caption = #1053#1044#1047'-1 '#1087#1086' '#1074#1080#1076#1072#1084' '#1089#1090#1088#1086#1080#1090#1077#1083#1100#1089#1090#1074#1072
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsUnderline]
            ParentFont = False
            OnClick = lbl1Click
          end
        end
      end
    end
    object GridPanel25: TGridPanel
      Left = 0
      Top = 0
      Width = 412
      Height = 20
      Align = alTop
      BevelOuter = bvNone
      ColumnCollection = <
        item
          Value = 100.000000000000000000
        end
        item
          SizeStyle = ssAbsolute
          Value = 80.000000000000000000
        end>
      ControlCollection = <
        item
          Column = 0
          Control = lbl24
          Row = 0
        end
        item
          Column = 1
          Control = jvdbspndtK_PP1
          Row = 0
        end>
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      RowCollection = <
        item
          Value = 100.000000000000000000
        end>
      TabOrder = 0
      DesignSize = (
        412
        20)
      object lbl24: TLabel
        AlignWithMargins = True
        Left = 7
        Top = 3
        Width = 322
        Height = 14
        Margins.Left = 7
        Align = alClient
        Caption = #1042#1099#1087#1086#1083#1085#1077#1085#1080#1077' '#1086#1090' '#1086#1073#1097#1077#1075#1086' '#1086#1073#1098#1105#1084#1072' '#1088#1072#1073#1086#1090':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ExplicitWidth = 195
        ExplicitHeight = 13
      end
      object jvdbspndtK_PP1: TJvDBSpinEdit
        Left = 339
        Top = 0
        Width = 65
        Height = 20
        MaxValue = 100.000000000000000000
        ValueType = vtFloat
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Anchors = []
        ParentFont = False
        TabOrder = 0
        DataField = 'PER_DONE'
        DataSource = dsMain
      end
    end
  end
  object FormStorage: TJvFormStorage
    AppStorage = FormMain.AppIni
    AppStoragePath = '%FORM_NAME%\'
    Options = [fpSize]
    StoredValues = <>
    Left = 248
  end
  object qrMain: TFDQuery
    AutoCalcFields = False
    BeforeOpen = qrMainBeforeOpen
    OnNewRecord = qrMainNewRecord
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvUpdateChngFields, uvUpdateMode, uvCountUpdatedRecords, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable, uvUpdateNonBaseFields]
    UpdateOptions.EnableDelete = False
    UpdateOptions.CountUpdatedRecords = False
    UpdateOptions.CheckRequired = False
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.CheckUpdatable = False
    UpdateOptions.UpdateTableName = 'smeta.calc_setup'
    UpdateOptions.KeyFields = 'CALC_SETUP_ID'
    SQL.Strings = (
      'SELECT *'
      'FROM calc_setup'
      
        'WHERE (OBJ_ID=:OBJ_ID AND IFNULL(SM_ID, 0)=IFNULL(:SM_ID, 0)) OR' +
        ' '
      
        '      (IFNULL(:OBJ_ID, 0)=0 AND IFNULL(SM_ID, 0)=IFNULL(:SM_ID, ' +
        '0))')
    Left = 17
    Top = 5
    ParamData = <
      item
        Name = 'OBJ_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 0
      end
      item
        Name = 'SM_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object dsMain: TDataSource
    DataSet = qrMain
    Left = 56
    Top = 5
  end
end
