object fCardObjectAdditional: TfCardObjectAdditional
  Left = 0
  Top = 0
  Caption = #1050#1072#1088#1090#1086#1095#1082#1072' '#1086#1073#1098#1077#1082#1090#1072' - '#1076#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1086
  ClientHeight = 295
  ClientWidth = 353
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnl1: TPanel
    Left = 0
    Top = 254
    Width = 353
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    ExplicitTop = 208
    DesignSize = (
      353
      41)
    object btn1: TBitBtn
      Left = 271
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #1047#1072#1082#1088#1099#1090#1100
      TabOrder = 0
      OnClick = btn1Click
    end
  end
  object grp1: TGroupBox
    AlignWithMargins = True
    Left = 7
    Top = 7
    Width = 339
    Height = 160
    Margins.Left = 7
    Margins.Top = 7
    Margins.Right = 7
    Align = alTop
    Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1076#1083#1103' '#1088#1072#1089#1095#1077#1090#1072' '#1074' '#1090#1077#1082#1091#1097#1080#1093' '#1094#1077#1085#1072#1093':'
    TabOrder = 0
    object dbchkFL_CALC_TRAVEL: TDBCheckBox
      Left = 10
      Top = 18
      Width = 217
      Height = 17
      Caption = #1088#1072#1089#1095#1077#1090' '#1082#1086#1084#1072#1085#1076#1080#1088#1086#1074#1086#1095#1085#1099#1093' '#1088#1072#1089#1093#1086#1076#1086#1074
      DataField = 'FL_CALC_TRAVEL'
      DataSource = fCardObject.dsMain
      TabOrder = 0
      ValueChecked = '1'
      ValueUnchecked = '0'
    end
    object dbchkFL_CALC_WORKER_DEPARTMENT: TDBCheckBox
      Left = 10
      Top = 36
      Width = 217
      Height = 17
      Caption = #1088#1072#1089#1095#1077#1090' '#1088#1072#1089#1093#1086#1076#1086#1074' '#1085#1072' '#1087#1077#1088#1077#1074#1086#1079#1082#1091' '#1088#1072#1073#1086#1095#1080#1093
      DataField = 'FL_CALC_WORKER_DEPARTMENT'
      DataSource = fCardObject.dsMain
      TabOrder = 1
      ValueChecked = '1'
      ValueUnchecked = '0'
    end
    object dbchkFL_CALC_TRAVEL_WORK: TDBCheckBox
      Left = 10
      Top = 54
      Width = 217
      Height = 17
      Caption = #1088#1072#1089#1095#1077#1090' '#1088#1072#1079#1098#1077#1079#1085#1086#1075#1086' '#1093#1072#1088#1072#1082#1090#1077#1088#1072' '#1088#1072#1073#1086#1090
      DataField = 'FL_CALC_TRAVEL_WORK'
      DataSource = fCardObject.dsMain
      TabOrder = 2
      ValueChecked = '1'
      ValueUnchecked = '0'
    end
    object dbchkFL_CALC_ZEM_NAL: TDBCheckBox
      Left = 10
      Top = 72
      Width = 217
      Height = 17
      Caption = #1088#1072#1089#1095#1077#1090' '#1079#1077#1084#1077#1083#1100#1085#1086#1075#1086' '#1085#1072#1083#1086#1075#1072
      DataField = 'FL_CALC_ZEM_NAL'
      DataSource = fCardObject.dsMain
      TabOrder = 3
      ValueChecked = '1'
      ValueUnchecked = '0'
    end
    object dbchkFL_CALC_VEDOMS_NAL: TDBCheckBox
      Left = 10
      Top = 90
      Width = 313
      Height = 17
      Caption = #1088#1072#1089#1095#1077#1090' '#1086#1090#1095#1080#1089#1083#1077#1085#1080#1081' '#1085#1072' '#1089#1083#1091#1078#1073#1091' '#1074#1077#1076#1086#1084#1089#1090#1074#1077#1085#1085#1086#1075#1086' '#1082#1086#1085#1090#1088#1086#1083#1103
      DataField = 'FL_CALC_VEDOMS_NAL'
      DataSource = fCardObject.dsMain
      TabOrder = 4
      ValueChecked = '1'
      ValueUnchecked = '0'
    end
    object dbchkFL_CALC_VEDOMS_NAL1: TDBCheckBox
      Left = 10
      Top = 109
      Width = 119
      Height = 17
      Caption = #1053#1072#1083#1086#1075' '#1087#1088#1080' '#1059#1057#1053', %:'
      DataField = 'Fl_NAL_USN'
      DataSource = fCardObject.dsMain
      TabOrder = 6
      ValueChecked = '1'
      ValueUnchecked = '0'
    end
    object JvDBSpinEdit1: TJvDBSpinEdit
      Left = 199
      Top = 107
      Width = 66
      Height = 21
      MaxValue = 100.000000000000000000
      ValueType = vtFloat
      TabOrder = 5
      DataField = 'NAL_USN'
      DataSource = fCardObject.dsMain
    end
    object dbchkFL_CALC_VEDOMS_NAL2: TDBCheckBox
      Left = 10
      Top = 132
      Width = 183
      Height = 17
      Caption = #1055#1077#1088#1077#1095#1080#1089#1083#1077#1085#1080#1103' '#1085#1072' '#1089#1087#1077#1094'.'#1089#1095#1077#1090', %:'
      DataField = 'Fl_SPEC_SCH'
      DataSource = fCardObject.dsMain
      TabOrder = 8
      ValueChecked = '1'
      ValueUnchecked = '0'
    end
    object JvDBSpinEdit2: TJvDBSpinEdit
      Left = 199
      Top = 130
      Width = 66
      Height = 21
      MaxValue = 100.000000000000000000
      ValueType = vtFloat
      TabOrder = 7
      DataField = 'SPEC_SCH'
      DataSource = fCardObject.dsMain
    end
  end
  object dbchkAPPLY_WINTERPRISE_FLAG: TDBCheckBox
    AlignWithMargins = True
    Left = 7
    Top = 173
    Width = 343
    Height = 17
    Margins.Left = 7
    Align = alBottom
    BiDiMode = bdLeftToRight
    Caption = #1055#1088#1080#1084#1077#1085#1103#1090#1100' '#1079#1080#1084#1085#1077#1077' '#1091#1076#1086#1088#1086#1078#1072#1085#1080#1077
    DataField = 'FL_APPLY_WINTERPRICE'
    DataSource = fCardObject.dsMain
    ParentBiDiMode = False
    TabOrder = 1
    ValueChecked = '1'
    ValueUnchecked = '0'
    OnClick = dbchkAPPLY_WINTERPRISE_FLAGClick
    ExplicitTop = 127
  end
  object dbrgrpCOEF_ORDERS: TDBRadioGroup
    AlignWithMargins = True
    Left = 7
    Top = 193
    Width = 339
    Height = 61
    Margins.Left = 7
    Margins.Top = 0
    Margins.Right = 7
    Margins.Bottom = 0
    Align = alBottom
    Caption = #1053#1086#1088#1084#1072' '#1076#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1093' '#1079#1080#1084#1085#1080#1093':'
    DataField = 'WINTERPRICE_TYPE'
    DataSource = fCardObject.dsMain
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Items.Strings = (
      #1053#1044#1047' 1 ('#1087#1086' '#1074#1080#1076#1072#1084' '#1089#1090#1088#1086#1080#1090#1077#1083#1100#1089#1090#1074#1072')'
      #1053#1044#1047' 2 ('#1087#1086' '#1074#1080#1076#1072#1084' '#1088#1072#1073#1086#1090')')
    ParentFont = False
    TabOrder = 2
    Values.Strings = (
      '0'
      '1')
    ExplicitTop = 147
  end
end
