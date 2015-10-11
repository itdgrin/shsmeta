object FormProgramSettings: TFormProgramSettings
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
  ClientHeight = 406
  ClientWidth = 648
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  DesignSize = (
    648
    406)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 0
    Top = 365
    Width = 648
    Height = 41
    Align = alBottom
    Shape = bsTopLine
    ExplicitLeft = 8
    ExplicitTop = 326
  end
  object PageControl1: TPageControl
    Left = 8
    Top = 8
    Width = 632
    Height = 351
    ActivePage = TabSheet1
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object TabSheet3: TTabSheet
      Caption = #1058#1072#1073#1083#1080#1094#1099
      ImageIndex = 2
      DesignSize = (
        624
        323)
      object Label1: TLabel
        Left = 287
        Top = 3
        Width = 249
        Height = 13
        Caption = #1055#1088#1080#1084#1077#1088' '#1090#1072#1073#1083#1080#1094#1099' '#1089' '#1085#1072#1089#1090#1088#1086#1077#1085#1085#1099#1084#1080' '#1089#1090#1080#1083#1103#1084#1080':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object GroupBoxColor: TGroupBox
        Left = 3
        Top = 3
        Width = 278
        Height = 317
        Anchors = [akLeft, akTop, akBottom]
        Caption = #1062#1074#1077#1090#1072
        TabOrder = 0
        object LabelFontSelectRow: TLabel
          Left = 8
          Top = 153
          Width = 168
          Height = 13
          Caption = #1062#1074#1077#1090' '#1090#1077#1082#1089#1090#1072' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1081' '#1089#1090#1088#1086#1082#1077
        end
        object LabelFontSelectCell: TLabel
          Left = 8
          Top = 210
          Width = 143
          Height = 13
          Caption = #1058#1077#1082#1089#1090' '#1074' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1081' '#1103#1095#1077#1081#1082#1077
        end
        object ShapeFontRows: TShape
          Left = 257
          Top = 94
          Width = 17
          Height = 17
          OnMouseDown = ShapeMouseDown
        end
        object ShapeBackgroundSelectRow: TShape
          Left = 257
          Top = 132
          Width = 17
          Height = 17
          OnMouseDown = ShapeMouseDown
        end
        object LabelBackgroundHead: TLabel
          Left = 8
          Top = 20
          Width = 55
          Height = 13
          Caption = #1060#1086#1085' '#1096#1072#1087#1082#1080
        end
        object LabelBackgroundSelectRow: TLabel
          Left = 8
          Top = 134
          Width = 124
          Height = 13
          Caption = #1060#1086#1085' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1081' '#1089#1090#1088#1086#1082#1080
        end
        object LabelBackgroundSelectCell: TLabel
          Left = 8
          Top = 191
          Width = 125
          Height = 13
          Caption = #1060#1086#1085' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1081' '#1103#1095#1077#1081#1082#1080
        end
        object ShapeBackgroundHead: TShape
          Left = 257
          Top = 18
          Width = 17
          Height = 17
          OnMouseDown = ShapeMouseDown
        end
        object ShapeBackgroundSelectCell: TShape
          Left = 257
          Top = 189
          Width = 17
          Height = 17
          OnMouseDown = ShapeMouseDown
        end
        object LabelFontHead: TLabel
          Left = 8
          Top = 39
          Width = 108
          Height = 13
          Caption = #1062#1074#1077#1090' '#1090#1077#1082#1089#1090#1072' '#1074' '#1096#1072#1087#1082#1077
        end
        object ShapeFontHead: TShape
          Left = 257
          Top = 37
          Width = 17
          Height = 17
          OnMouseDown = ShapeMouseDown
        end
        object ShapeFontSelectCell: TShape
          Left = 257
          Top = 208
          Width = 17
          Height = 17
          OnMouseDown = ShapeMouseDown
        end
        object LabelBackgroundRows: TLabel
          Left = 8
          Top = 77
          Width = 132
          Height = 13
          Caption = #1060#1086#1085' '#1085#1077#1074#1099#1076#1077#1083#1077#1085#1085#1099#1093' '#1089#1090#1088#1086#1082
        end
        object LabelFontRows: TLabel
          Left = 8
          Top = 96
          Width = 176
          Height = 13
          Caption = #1062#1074#1077#1090' '#1090#1077#1082#1089#1090#1072' '#1085#1077#1074#1099#1076#1077#1083#1077#1085#1085#1099#1093' '#1089#1090#1088#1086#1082
        end
        object ShapeFontSelectRow: TShape
          Left = 257
          Top = 151
          Width = 17
          Height = 17
          OnMouseDown = ShapeMouseDown
        end
        object ShapeBackgroundRows: TShape
          Left = 257
          Top = 75
          Width = 17
          Height = 17
          OnMouseDown = ShapeMouseDown
        end
        object ShapeSelectRowUnfocusedTable: TShape
          Left = 257
          Top = 246
          Width = 17
          Height = 17
          Brush.Color = clWindow
          OnMouseDown = ShapeMouseDown
        end
        object LabelSelectRowUnfocusedTable: TLabel
          Left = 8
          Top = 248
          Width = 218
          Height = 13
          Caption = #1042#1099#1076#1077#1083#1077#1085#1085#1072#1103' '#1089#1090#1088#1086#1082#1072' '#1074' '#1085#1077#1072#1082#1090#1080#1074#1085#1086#1081' '#1090#1072#1073#1083#1080#1094#1077
        end
        object Button3: TButton
          Left = 8
          Top = 328
          Width = 262
          Height = 25
          Caption = #1042#1086#1089#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1094#1074#1077#1090#1072' '#1087#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
          Enabled = False
          TabOrder = 0
        end
      end
      object StringGridDemo: TStringGrid
        Left = 287
        Top = 22
        Width = 334
        Height = 150
        ColCount = 3
        DefaultColWidth = 70
        DefaultRowHeight = 20
        DefaultDrawing = False
        FixedCols = 0
        RowCount = 3
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goThumbTracking]
        ParentFont = False
        TabOrder = 1
        OnClick = StringGridDemoClick
        OnDrawCell = StringGridDemoDrawCell
        OnEnter = StringGridDemoEnter
        OnExit = StringGridDemoExit
        OnMouseMove = StringGridDemoMouseMove
      end
      object ButtonDefaultSettingsTables: TButton
        Left = 391
        Top = 295
        Width = 230
        Height = 25
        Caption = #1042#1086#1089#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1085#1072#1089#1090#1088#1086#1081#1082#1080' '#1087#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
        TabOrder = 2
        OnClick = ButtonDefaultSettingsTablesClick
      end
    end
    object TabSheet1: TTabSheet
      Caption = #1056#1072#1079#1085#1086#1077
      ImageIndex = 1
      object GroupBoxRound: TGroupBox
        Left = 3
        Top = 3
        Width = 244
        Height = 46
        Caption = #1055#1088#1072#1074#1080#1083#1072' '#1086#1082#1088#1091#1075#1083#1077#1085#1080#1103' '#1095#1080#1089#1077#1083
        TabOrder = 0
        object LabelRound1: TLabel
          Left = 8
          Top = 20
          Width = 71
          Height = 13
          Caption = #1054#1082#1088#1091#1075#1083#1103#1090#1100' '#1076#1086
        end
        object LabelRound2: TLabel
          Left = 131
          Top = 20
          Width = 105
          Height = 13
          Caption = #1095#1080#1089#1077#1083' '#1087#1086#1089#1083#1077' '#1079#1072#1087#1103#1090#1086#1081
        end
        object ComboBoxRound: TComboBox
          Left = 85
          Top = 17
          Width = 40
          Height = 21
          ItemIndex = 0
          TabOrder = 0
          Text = '0'
          Items.Strings = (
            '0'
            '1'
            '2'
            '3'
            '4')
        end
      end
      object ButtonDefaultOtherSettings: TButton
        Left = 391
        Top = 295
        Width = 230
        Height = 25
        Caption = #1042#1086#1089#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1085#1072#1089#1090#1088#1086#1081#1082#1080' '#1087#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
        TabOrder = 8
        OnClick = ButtonDefaultOtherSettingsClick
      end
      object CheckBoxShowHint: TCheckBox
        Left = 3
        Top = 55
        Width = 286
        Height = 17
        Caption = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1074#1089#1087#1083#1099#1074#1072#1102#1097#1091#1102' '#1087#1086#1076#1089#1082#1072#1079#1082#1091' '#1074' '#1090#1072#1073#1083#1080#1094#1072#1093
        TabOrder = 1
      end
      object chkAutoCreateEstimates: TCheckBox
        Left = 3
        Top = 78
        Width = 334
        Height = 17
        Caption = #1057#1086#1079#1076#1072#1074#1072#1090#1100' '#1085#1072#1073#1086#1088' '#1054#1073#1098#1077#1082#1090#1085#1072#1103'-'#1051#1086#1082#1072#1083#1100#1085#1072#1103'-'#1055#1058#1052' '#1072#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1080
        Checked = True
        State = cbChecked
        TabOrder = 2
      end
      object chkAutoExpandTreeEstimates: TCheckBox
        Left = 3
        Top = 101
        Width = 310
        Height = 17
        Caption = #1056#1072#1089#1082#1088#1099#1074#1072#1090#1100' '#1072#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1080' '#1076#1077#1088#1077#1074#1086' '#1089#1084#1077#1090'/'#1072#1082#1090#1086#1074' '#1086#1073#1098#1077#1082#1090#1072
        Checked = True
        State = cbChecked
        TabOrder = 3
      end
      object chkCalcResourcesAutoSave: TCheckBox
        Left = 3
        Top = 124
        Width = 470
        Height = 17
        Caption = 
          #1056#1072#1089#1095#1077#1090' '#1089#1090#1086#1080#1084#1086#1089#1090#1080' '#1088#1077#1089#1091#1088#1089#1086#1074' - '#1072#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1086#1077' '#1089#1086#1093#1088#1072#1085#1077#1085#1080#1077' '#1080#1079#1084#1077#1085#1077#1085#1080#1081' '#1073 +
          #1077#1079' '#1087#1086#1076#1090#1074#1077#1088#1078#1076#1077#1085#1080#1103
        Checked = True
        State = cbChecked
        TabOrder = 4
      end
      object chkAutosaveRateDescr: TCheckBox
        Left = 3
        Top = 170
        Width = 470
        Height = 17
        Caption = #1040#1074#1090#1086#1089#1086#1093#1088#1072#1085#1077#1085#1080#1077' '#1087#1088#1080' '#1080#1079#1084#1077#1085#1077#1085#1080#1080' '#1086#1087#1080#1089#1072#1085#1080#1103' '#1088#1072#1089#1094#1077#1085#1082#1080
        Checked = True
        State = cbChecked
        TabOrder = 6
      end
      object chkAutoSaveCalcResourcesAfterExitCell: TCheckBox
        Left = 3
        Top = 147
        Width = 598
        Height = 17
        Caption = 
          #1056#1072#1089#1095#1077#1090' '#1089#1090#1086#1080#1084#1086#1089#1090#1080' '#1088#1077#1089#1091#1088#1089#1086#1074' - '#1072#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1086#1077' '#1089#1086#1093#1088#1072#1085#1077#1085#1080#1077' '#1080#1079#1084#1077#1085#1077#1085#1080#1081' '#1087 +
          #1088#1080' '#1087#1077#1088#1077#1093#1086#1076#1077' '#1074#1085#1091#1090#1088#1080' '#1088#1077#1076#1072#1082#1090#1080#1088#1091#1077#1084#1086#1081' '#1079#1072#1087#1080#1089#1080
        TabOrder = 5
      end
      object chkShowNeedSaveDialog: TCheckBox
        Left = 3
        Top = 193
        Width = 350
        Height = 17
        Caption = #1047#1072#1087#1088#1086#1089' '#1085#1072' '#1089#1086#1093#1088#1072#1085#1077#1085#1080#1077' '#1089#1084#1077#1090#1099' '#1055#1045#1063#1040#1058#1068'-'#1057#1057#1056'-'#1056#1040#1057#1063#1045#1058' '#1057#1058#1054#1048#1052#1054#1057#1058#1048
        Checked = True
        State = cbChecked
        TabOrder = 7
      end
      object chkFindAutoRepInAllRate: TCheckBox
        Left = 3
        Top = 216
        Width = 494
        Height = 17
        Caption = #1048#1089#1082#1072#1090#1100' '#1072#1074#1090#1086#1079#1072#1084#1077#1085#1091' '#1087#1086' '#1074#1089#1077#1084' '#1088#1072#1089#1094#1077#1085#1082#1072#1084' '#1089#1084#1077#1090#1099
        TabOrder = 9
      end
    end
  end
  object ButtonCancel: TButton
    Left = 540
    Top = 373
    Width = 100
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 2
    OnClick = ButtonCancelClick
  end
  object ButtonSave: TButton
    Left = 434
    Top = 373
    Width = 100
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    Default = True
    TabOrder = 1
    OnClick = ButtonSaveClick
  end
  object ColorDialog: TColorDialog
    Options = [cdFullOpen]
    Left = 320
    Top = 248
  end
end
