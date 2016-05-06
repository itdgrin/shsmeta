object fCalcResourceEdit: TfCalcResourceEdit
  Left = 0
  Top = 0
  Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077
  ClientHeight = 229
  ClientWidth = 381
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
  PixelsPerInch = 96
  TextHeight = 13
  object pgc1: TPageControl
    Left = 0
    Top = 0
    Width = 381
    Height = 192
    ActivePage = tsDevice
    Align = alClient
    TabOrder = 0
    object tsMaterial: TTabSheet
      Caption = #1052#1072#1090#1077#1088#1080#1072#1083#1099
      object lbl1: TLabel
        Left = 239
        Top = 139
        Width = 56
        Height = 13
        Caption = #1079#1072#1082#1072#1079#1095#1080#1082#1072':'
      end
      object lbl2: TLabel
        Left = 239
        Top = 112
        Width = 56
        Height = 13
        Caption = #1079#1072#1082#1072#1079#1095#1080#1082#1072':'
      end
      object chkMatCoast: TCheckBox
        Left = 3
        Top = 3
        Width = 159
        Height = 17
        Caption = #1062#1077#1085#1072':'
        TabOrder = 0
      end
      object chkMatTransp: TCheckBox
        Left = 3
        Top = 30
        Width = 159
        Height = 17
        Caption = '% '#1090#1088#1072#1085#1089#1087#1086#1088#1090#1072':'
        TabOrder = 2
      end
      object chkMatNaklDate: TCheckBox
        Left = 3
        Top = 57
        Width = 159
        Height = 17
        Caption = #1044#1072#1090#1072' '#1085#1072#1082#1083'.:'
        TabOrder = 4
      end
      object chkMatNakl: TCheckBox
        Left = 3
        Top = 84
        Width = 159
        Height = 17
        Caption = #8470' '#1085#1072#1082#1083'.:'
        TabOrder = 6
      end
      object chkMatZakPodr: TCheckBox
        Left = 3
        Top = 111
        Width = 159
        Height = 17
        Caption = '% '#1087#1086#1076#1088#1103#1076#1095#1080#1082#1072':'
        TabOrder = 8
      end
      object chkMatTranspZakPodr: TCheckBox
        Left = 3
        Top = 138
        Width = 159
        Height = 17
        Caption = '% '#1090#1088#1072#1085#1089#1087#1086#1088#1090#1072' '#1087#1086#1076#1088#1103#1076#1095#1080#1082#1072':'
        TabOrder = 11
      end
      object edtMatNakl: TEdit
        Left = 168
        Top = 84
        Width = 198
        Height = 21
        TabOrder = 7
        OnChange = edtMatNaklChange
      end
      object dtpMatNaklDate: TDateTimePicker
        Left = 168
        Top = 57
        Width = 105
        Height = 21
        Date = 42333.979398148150000000
        Time = 42333.979398148150000000
        TabOrder = 5
        OnChange = dtpMatNaklDateChange
      end
      object edtMatCoast: TEdit
        Left = 168
        Top = 3
        Width = 105
        Height = 21
        NumbersOnly = True
        TabOrder = 1
        OnChange = edtMatCoastChange
      end
      object edtMatTranspPodr: TJvSpinEdit
        Left = 168
        Top = 140
        Width = 65
        Height = 21
        Items.Strings = (
          '0'
          '100')
        MaxValue = 100.000000000000000000
        ValueType = vtFloat
        Value = 100.000000000000000000
        TabOrder = 13
        OnChange = edtMatTranspPodrChange
      end
      object edtMatTranspZak: TJvSpinEdit
        Left = 301
        Top = 138
        Width = 65
        Height = 21
        Items.Strings = (
          '0'
          '100')
        MaxValue = 100.000000000000000000
        ValueType = vtFloat
        TabOrder = 12
        OnChange = edtMatTranspZakChange
      end
      object edtMatPodr: TJvSpinEdit
        Left = 168
        Top = 111
        Width = 65
        Height = 21
        Items.Strings = (
          '0'
          '100')
        MaxValue = 100.000000000000000000
        ValueType = vtFloat
        Value = 100.000000000000000000
        TabOrder = 9
        OnChange = edtMatPodrChange
      end
      object edtMatZak: TJvSpinEdit
        Left = 301
        Top = 111
        Width = 65
        Height = 21
        Items.Strings = (
          '0'
          '100')
        MaxValue = 100.000000000000000000
        ValueType = vtFloat
        TabOrder = 10
        OnChange = edtMatZakChange
      end
      object edtMatTransp: TJvSpinEdit
        Left = 168
        Top = 30
        Width = 65
        Height = 21
        Items.Strings = (
          '0'
          '100')
        MaxValue = 100.000000000000000000
        ValueType = vtFloat
        TabOrder = 3
        OnChange = edtMatTranspChange
      end
    end
    object tsMechanizm: TTabSheet
      Caption = #1052#1077#1093#1072#1085#1080#1079#1084#1099
      ImageIndex = 1
      object lbl3: TLabel
        Left = 239
        Top = 112
        Width = 56
        Height = 13
        Caption = #1079#1072#1082#1072#1079#1095#1080#1082#1072':'
      end
      object chkMechCoast: TCheckBox
        Left = 3
        Top = 3
        Width = 159
        Height = 17
        Caption = #1062#1077#1085#1072':'
        TabOrder = 0
      end
      object edtMechCoast: TEdit
        Left = 168
        Top = 3
        Width = 105
        Height = 21
        NumbersOnly = True
        TabOrder = 1
        OnChange = edtMechCoastChange
      end
      object chkMechZPMash: TCheckBox
        Left = 3
        Top = 30
        Width = 159
        Height = 17
        Caption = #1047#1055' '#1084#1072#1096#1080#1085#1080#1089#1090#1072':'
        TabOrder = 2
      end
      object chkMechNaklDate: TCheckBox
        Left = 3
        Top = 57
        Width = 159
        Height = 17
        Caption = #1044#1072#1090#1072' '#1085#1072#1082#1083'.:'
        TabOrder = 4
      end
      object dtpMechNaklDate: TDateTimePicker
        Left = 168
        Top = 57
        Width = 105
        Height = 21
        Date = 42333.979398148150000000
        Time = 42333.979398148150000000
        TabOrder = 5
        OnChange = dtpMechNaklDateChange
      end
      object edtMechNakl: TEdit
        Left = 167
        Top = 84
        Width = 198
        Height = 21
        TabOrder = 7
        OnChange = edtMechNaklChange
      end
      object chkMechNakl: TCheckBox
        Left = 3
        Top = 84
        Width = 159
        Height = 17
        Caption = #8470' '#1085#1072#1082#1083'.:'
        TabOrder = 6
      end
      object chkMechZakPodr: TCheckBox
        Left = 3
        Top = 111
        Width = 159
        Height = 17
        Caption = '% '#1087#1086#1076#1088#1103#1076#1095#1080#1082#1072':'
        TabOrder = 8
      end
      object edtMechPodr: TJvSpinEdit
        Left = 168
        Top = 111
        Width = 65
        Height = 21
        Items.Strings = (
          '0'
          '100')
        MaxValue = 100.000000000000000000
        ValueType = vtFloat
        Value = 100.000000000000000000
        TabOrder = 9
        OnChange = edtMechPodrChange
      end
      object edtMechZak: TJvSpinEdit
        Left = 300
        Top = 111
        Width = 65
        Height = 21
        Items.Strings = (
          '0'
          '100')
        MaxValue = 100.000000000000000000
        ValueType = vtFloat
        TabOrder = 10
        OnChange = edtMechZakChange
      end
      object edtMechZPMash: TEdit
        Left = 168
        Top = 30
        Width = 105
        Height = 21
        NumbersOnly = True
        TabOrder = 3
        OnChange = edtMechZPMashChange
      end
    end
    object tsDevice: TTabSheet
      Caption = #1054#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1077
      ImageIndex = 2
      object lbl5: TLabel
        Left = 239
        Top = 112
        Width = 56
        Height = 13
        Caption = #1079#1072#1082#1072#1079#1095#1080#1082#1072':'
      end
      object lbl6: TLabel
        Left = 239
        Top = 139
        Width = 56
        Height = 13
        Caption = #1079#1072#1082#1072#1079#1095#1080#1082#1072':'
      end
      object chkDevCoast: TCheckBox
        Left = 3
        Top = 3
        Width = 159
        Height = 17
        Caption = #1062#1077#1085#1072':'
        TabOrder = 0
      end
      object edtDevCoast: TEdit
        Left = 168
        Top = 3
        Width = 105
        Height = 21
        NumbersOnly = True
        TabOrder = 1
        OnChange = edtDevCoastChange
      end
      object chkDevTransp: TCheckBox
        Left = 3
        Top = 30
        Width = 159
        Height = 17
        Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1090#1088#1072#1085#1089#1087#1086#1088#1090#1072':'
        TabOrder = 2
      end
      object chkDevNaklDate: TCheckBox
        Left = 3
        Top = 57
        Width = 159
        Height = 17
        Caption = #1044#1072#1090#1072' '#1085#1072#1082#1083'.:'
        TabOrder = 4
      end
      object dtpDevNaklDate: TDateTimePicker
        Left = 168
        Top = 57
        Width = 105
        Height = 21
        Date = 42333.979398148150000000
        Time = 42333.979398148150000000
        TabOrder = 5
        OnChange = dtpDevNaklDateChange
      end
      object edtDevNakl: TEdit
        Left = 167
        Top = 84
        Width = 198
        Height = 21
        TabOrder = 7
        OnChange = edtDevNaklChange
      end
      object chkDevNakl: TCheckBox
        Left = 3
        Top = 84
        Width = 159
        Height = 17
        Caption = #8470' '#1085#1072#1082#1083'.:'
        TabOrder = 6
      end
      object chkDevZakPodr: TCheckBox
        Left = 3
        Top = 111
        Width = 159
        Height = 17
        Caption = '% '#1087#1086#1076#1088#1103#1076#1095#1080#1082#1072':'
        TabOrder = 8
      end
      object edtDevPodr: TJvSpinEdit
        Left = 168
        Top = 111
        Width = 65
        Height = 21
        Items.Strings = (
          '0'
          '100')
        MaxValue = 100.000000000000000000
        ValueType = vtFloat
        Value = 100.000000000000000000
        TabOrder = 9
        OnChange = edtDevPodrChange
      end
      object edtDevZak: TJvSpinEdit
        Left = 300
        Top = 111
        Width = 65
        Height = 21
        Items.Strings = (
          '0'
          '100')
        MaxValue = 100.000000000000000000
        ValueType = vtFloat
        TabOrder = 10
        OnChange = edtDevZakChange
      end
      object chkDevTranspZakPodr: TCheckBox
        Left = 3
        Top = 138
        Width = 159
        Height = 17
        Caption = '% '#1090#1088#1072#1085#1089#1087#1086#1088#1090#1072' '#1087#1086#1076#1088#1103#1076#1095#1080#1082#1072':'
        TabOrder = 13
      end
      object edtDevTranspPodr: TJvSpinEdit
        Left = 168
        Top = 135
        Width = 65
        Height = 21
        Items.Strings = (
          '0'
          '100')
        MaxValue = 100.000000000000000000
        ValueType = vtFloat
        Value = 100.000000000000000000
        TabOrder = 11
        OnChange = edtDevTranspPodrChange
      end
      object edtDevTranspZak: TJvSpinEdit
        Left = 300
        Top = 135
        Width = 65
        Height = 21
        Items.Strings = (
          '0'
          '100')
        MaxValue = 100.000000000000000000
        ValueType = vtFloat
        TabOrder = 12
        OnChange = edtDevTranspZakChange
      end
      object edtDevTransp: TEdit
        Left = 168
        Top = 30
        Width = 105
        Height = 21
        NumbersOnly = True
        TabOrder = 3
        OnChange = edtDevTranspChange
      end
    end
  end
  object pnl1: TPanel
    Left = 0
    Top = 192
    Width = 381
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      381
      37)
    object btnCancel: TBitBtn
      Left = 302
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #1054#1090#1084#1077#1085#1072
      ModalResult = 2
      TabOrder = 1
    end
    object btnOk: TBitBtn
      Left = 221
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      ModalResult = 1
      TabOrder = 0
    end
  end
end
