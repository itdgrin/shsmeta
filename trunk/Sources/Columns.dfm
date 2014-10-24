object FormColumns: TFormColumns
  Left = 0
  Top = 0
  BorderStyle = bsSizeToolWin
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1074#1080#1076#1080#1084#1086#1089#1090#1080' '#1082#1086#1083#1086#1085#1086#1082' '#1090#1072#1073#1083#1080#1094#1099
  ClientHeight = 382
  ClientWidth = 572
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  DesignSize = (
    572
    382)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel: TBevel
    Left = 0
    Top = 341
    Width = 572
    Height = 41
    Align = alBottom
    Shape = bsTopLine
    ExplicitLeft = -397
    ExplicitTop = 369
    ExplicitWidth = 648
  end
  object PanelStringGridRates: TPanel
    Left = -2000
    Top = 0
    Width = 301
    Height = 131
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 0
    object ButtonSGLAll: TButton
      Left = 8
      Top = 6
      Width = 91
      Height = 25
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1074#1089#1077
      TabOrder = 0
      OnClick = ButtonSGLAllClick
    end
    object ButtonSGLNone: TButton
      Left = 105
      Top = 6
      Width = 91
      Height = 25
      Caption = #1057#1082#1088#1099#1090#1100' '#1074#1089#1077
      TabOrder = 1
      OnClick = ButtonSGLNoneClick
    end
    object CheckBoxSGL1: TCheckBox
      Left = 8
      Top = 37
      Width = 230
      Height = 17
      Caption = #8470' '#1087'/'#1087
      Checked = True
      State = cbChecked
      TabOrder = 2
      OnClick = CheckBoxSGLClick
    end
    object CheckBoxSGL2: TCheckBox
      Left = 8
      Top = 60
      Width = 230
      Height = 17
      Caption = #8470' '#1085#1086#1088#1084#1072#1090#1080#1074#1072
      Checked = True
      State = cbChecked
      TabOrder = 3
      OnClick = CheckBoxSGLClick
    end
    object CheckBoxSGL3: TCheckBox
      Left = 8
      Top = 83
      Width = 230
      Height = 17
      Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
      Checked = True
      State = cbChecked
      TabOrder = 4
      OnClick = CheckBoxSGLClick
    end
    object CheckBoxSGL4: TCheckBox
      Left = 8
      Top = 106
      Width = 230
      Height = 17
      Caption = #1045#1076#1080#1085#1080#1094#1072' '#1080#1079#1084#1077#1088#1077#1085#1080#1103
      Checked = True
      State = cbChecked
      TabOrder = 5
      OnClick = CheckBoxSGLClick
    end
    object ButtonSGLDefault: TButton
      Left = 202
      Top = 6
      Width = 91
      Height = 25
      Caption = #1055#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
      TabOrder = 6
      OnClick = ButtonSGLDefaultClick
    end
  end
  object PanelStringGridRight: TPanel
    Left = 0
    Top = 0
    Width = 301
    Height = 335
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 1
    object CheckBoxSGR1: TCheckBox
      Left = 8
      Top = 37
      Width = 230
      Height = 17
      Caption = 'CheckBoxSGR1'
      Checked = True
      State = cbChecked
      TabOrder = 0
      Visible = False
      OnClick = CheckBoxSGRClick
    end
    object CheckBoxSGR2: TCheckBox
      Left = 8
      Top = 60
      Width = 230
      Height = 17
      Caption = 'CheckBoxSGR2'
      Checked = True
      State = cbChecked
      TabOrder = 1
      Visible = False
      OnClick = CheckBoxSGRClick
    end
    object CheckBoxSGR3: TCheckBox
      Left = 8
      Top = 83
      Width = 230
      Height = 17
      Caption = 'CheckBoxSGR3'
      Checked = True
      State = cbChecked
      TabOrder = 2
      Visible = False
      OnClick = CheckBoxSGRClick
    end
    object CheckBoxSGR4: TCheckBox
      Left = 8
      Top = 106
      Width = 230
      Height = 17
      Caption = 'CheckBoxSGR4'
      Checked = True
      State = cbChecked
      TabOrder = 3
      Visible = False
      OnClick = CheckBoxSGRClick
    end
    object CheckBoxSGR5: TCheckBox
      Left = 8
      Top = 129
      Width = 230
      Height = 17
      Caption = 'CheckBoxSGR5'
      Checked = True
      State = cbChecked
      TabOrder = 4
      Visible = False
      OnClick = CheckBoxSGRClick
    end
    object CheckBoxSGR6: TCheckBox
      Left = 8
      Top = 152
      Width = 230
      Height = 17
      Caption = 'CheckBoxSGR6'
      Checked = True
      State = cbChecked
      TabOrder = 5
      Visible = False
      OnClick = CheckBoxSGRClick
    end
    object CheckBoxSGR7: TCheckBox
      Left = 8
      Top = 175
      Width = 230
      Height = 17
      Caption = 'CheckBoxSGR7'
      Checked = True
      State = cbChecked
      TabOrder = 6
      Visible = False
      OnClick = CheckBoxSGRClick
    end
    object CheckBoxSGR8: TCheckBox
      Left = 8
      Top = 198
      Width = 230
      Height = 17
      Caption = 'CheckBoxSGR8'
      Checked = True
      State = cbChecked
      TabOrder = 7
      Visible = False
      OnClick = CheckBoxSGRClick
    end
    object CheckBoxSGR9: TCheckBox
      Left = 8
      Top = 221
      Width = 230
      Height = 17
      Caption = 'CheckBoxSGR9'
      Checked = True
      State = cbChecked
      TabOrder = 8
      Visible = False
      OnClick = CheckBoxSGRClick
    end
    object CheckBoxSGR10: TCheckBox
      Left = 8
      Top = 244
      Width = 230
      Height = 17
      Caption = 'CheckBoxSGR10'
      Checked = True
      State = cbChecked
      TabOrder = 9
      Visible = False
      OnClick = CheckBoxSGRClick
    end
    object CheckBoxSGR11: TCheckBox
      Left = 8
      Top = 267
      Width = 230
      Height = 17
      Caption = 'CheckBoxSGR11'
      Checked = True
      State = cbChecked
      TabOrder = 10
      Visible = False
      OnClick = CheckBoxSGRClick
    end
    object ButtonSGRAll: TButton
      Left = 8
      Top = 6
      Width = 91
      Height = 25
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1074#1089#1077
      TabOrder = 11
      OnClick = ButtonSGRAllClick
    end
    object ButtonSGRNone: TButton
      Left = 105
      Top = 6
      Width = 91
      Height = 25
      Caption = #1057#1082#1088#1099#1090#1100' '#1074#1089#1077
      TabOrder = 12
      OnClick = ButtonSGRNoneClick
    end
    object ButtonSGRDefault: TButton
      Left = 202
      Top = 6
      Width = 91
      Height = 25
      Caption = #1055#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
      TabOrder = 13
      OnClick = ButtonSGRDefaultClick
    end
    object CheckBoxSGR12: TCheckBox
      Left = 8
      Top = 290
      Width = 230
      Height = 17
      Caption = 'CheckBoxSGR12'
      Checked = True
      State = cbChecked
      TabOrder = 14
      Visible = False
      OnClick = CheckBoxSGRClick
    end
    object CheckBoxSGR13: TCheckBox
      Left = 8
      Top = 313
      Width = 230
      Height = 17
      Caption = 'CheckBoxSGR13'
      Checked = True
      State = cbChecked
      TabOrder = 15
      Visible = False
      OnClick = CheckBoxSGRClick
    end
  end
  object ButtonCancel: TButton
    Left = 464
    Top = 349
    Width = 100
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1054#1050
    Default = True
    TabOrder = 2
    OnClick = ButtonCancelClick
  end
  object PanelStringGridCoef: TPanel
    Left = -2000
    Top = 0
    Width = 330
    Height = 223
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 3
    object CheckBoxSGC1: TCheckBox
      Left = 8
      Top = 37
      Width = 150
      Height = 17
      Caption = 'CheckBoxSGC1'
      Checked = True
      State = cbChecked
      TabOrder = 0
      OnClick = CheckBoxSGCClick
    end
    object CheckBoxSGC2: TCheckBox
      Left = 8
      Top = 60
      Width = 150
      Height = 17
      Caption = 'CheckBoxSGC2'
      Checked = True
      State = cbChecked
      TabOrder = 1
      OnClick = CheckBoxSGCClick
    end
    object CheckBoxSGC3: TCheckBox
      Left = 8
      Top = 83
      Width = 150
      Height = 17
      Caption = 'CheckBoxSGC3'
      Checked = True
      State = cbChecked
      TabOrder = 2
      OnClick = CheckBoxSGCClick
    end
    object CheckBoxSGC4: TCheckBox
      Left = 8
      Top = 106
      Width = 150
      Height = 17
      Caption = 'CheckBoxSGC4'
      Checked = True
      State = cbChecked
      TabOrder = 3
      OnClick = CheckBoxSGCClick
    end
    object CheckBoxSGC5: TCheckBox
      Left = 8
      Top = 129
      Width = 150
      Height = 17
      Caption = 'CheckBoxSGC5'
      Checked = True
      State = cbChecked
      TabOrder = 4
      OnClick = CheckBoxSGCClick
    end
    object CheckBoxSGC6: TCheckBox
      Left = 8
      Top = 152
      Width = 150
      Height = 17
      Caption = 'CheckBoxSGC6'
      Checked = True
      State = cbChecked
      TabOrder = 5
      OnClick = CheckBoxSGCClick
    end
    object CheckBoxSGC7: TCheckBox
      Left = 8
      Top = 175
      Width = 150
      Height = 17
      Caption = 'CheckBoxSGC7'
      Checked = True
      State = cbChecked
      TabOrder = 6
      OnClick = CheckBoxSGCClick
    end
    object CheckBoxSGC8: TCheckBox
      Left = 8
      Top = 198
      Width = 150
      Height = 17
      Caption = 'CheckBoxSGC8'
      Checked = True
      State = cbChecked
      TabOrder = 7
      OnClick = CheckBoxSGCClick
    end
    object CheckBoxSGC9: TCheckBox
      Left = 164
      Top = 37
      Width = 150
      Height = 17
      Caption = 'CheckBoxSGC9'
      Checked = True
      State = cbChecked
      TabOrder = 8
      OnClick = CheckBoxSGCClick
    end
    object CheckBoxSGC10: TCheckBox
      Left = 164
      Top = 60
      Width = 150
      Height = 17
      Caption = 'CheckBoxSGC10'
      Checked = True
      State = cbChecked
      TabOrder = 9
      OnClick = CheckBoxSGCClick
    end
    object CheckBoxSGC11: TCheckBox
      Left = 164
      Top = 83
      Width = 150
      Height = 17
      Caption = 'CheckBoxSGC11'
      Checked = True
      State = cbChecked
      TabOrder = 10
      OnClick = CheckBoxSGCClick
    end
    object ButtonSGCAll: TButton
      Left = 8
      Top = 6
      Width = 91
      Height = 25
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1074#1089#1077
      TabOrder = 11
      OnClick = ButtonSGCAllClick
    end
    object ButtonSGCNone: TButton
      Left = 105
      Top = 6
      Width = 91
      Height = 25
      Caption = #1057#1082#1088#1099#1090#1100' '#1074#1089#1077
      TabOrder = 12
      OnClick = ButtonSGCNoneClick
    end
    object ButtonSGCDefault: TButton
      Left = 202
      Top = 6
      Width = 91
      Height = 25
      Caption = #1055#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
      TabOrder = 13
      OnClick = ButtonSGCDefaultClick
    end
    object CheckBoxSGC12: TCheckBox
      Left = 164
      Top = 106
      Width = 150
      Height = 17
      Caption = 'CheckBoxSGC12'
      Checked = True
      State = cbChecked
      TabOrder = 14
      OnClick = CheckBoxSGCClick
    end
    object CheckBoxSGC13: TCheckBox
      Left = 164
      Top = 129
      Width = 150
      Height = 17
      Caption = 'CheckBoxSGC13'
      Checked = True
      State = cbChecked
      TabOrder = 15
      OnClick = CheckBoxSGCClick
    end
    object CheckBoxSGC14: TCheckBox
      Left = 164
      Top = 152
      Width = 150
      Height = 17
      Caption = 'CheckBoxSGC14'
      Checked = True
      State = cbChecked
      TabOrder = 16
      OnClick = CheckBoxSGCClick
    end
    object CheckBoxSGC15: TCheckBox
      Left = 164
      Top = 175
      Width = 150
      Height = 17
      Caption = 'CheckBoxSGC15'
      Checked = True
      State = cbChecked
      TabOrder = 17
      OnClick = CheckBoxSGCClick
    end
  end
end
