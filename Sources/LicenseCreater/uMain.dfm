object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'MainForm'
  ClientHeight = 227
  ClientWidth = 481
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    481
    227)
  PixelsPerInch = 96
  TextHeight = 13
  object SpeedButton1: TSpeedButton
    Left = 450
    Top = 26
    Width = 24
    Height = 22
    Anchors = [akTop, akRight]
    Caption = '...'
    OnClick = SpeedButton1Click
    ExplicitLeft = 515
  end
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 131
    Height = 13
    Caption = #1060#1072#1081#1083' '#1083#1086#1082#1072#1083#1100#1085#1099#1093' '#1076#1072#1085#1085#1099#1093':'
  end
  object Label2: TLabel
    Left = 23
    Top = 69
    Width = 88
    Height = 13
    Caption = #1057#1077#1088#1080#1081#1085#1099#1081' '#1085#1086#1084#1077#1088':'
  end
  object Label3: TLabel
    Left = 8
    Top = 91
    Width = 103
    Height = 13
    Caption = #1051#1086#1082#1072#1083#1100#1085#1099#1077' '#1076#1072#1085#1085#1099#1077':'
  end
  object Bevel1: TBevel
    Left = 8
    Top = 110
    Width = 465
    Height = 17
    Anchors = [akLeft, akTop, akRight]
    Shape = bsBottomLine
    ExplicitWidth = 534
  end
  object Label4: TLabel
    Left = 57
    Top = 144
    Width = 53
    Height = 13
    Caption = #1042#1083#1072#1076#1077#1083#1077#1094':'
  end
  object Label5: TLabel
    Left = 23
    Top = 171
    Width = 87
    Height = 13
    Caption = #1044#1072#1090#1072' '#1072#1082#1090#1080#1074#1072#1094#1080#1080':'
  end
  object Label6: TLabel
    Left = 23
    Top = 198
    Width = 87
    Height = 13
    Caption = #1044#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103':'
  end
  object edtLocalDate: TEdit
    Left = 8
    Top = 27
    Width = 436
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    ReadOnly = True
    TabOrder = 0
  end
  object Edit1: TEdit
    Left = 117
    Top = 61
    Width = 327
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    ReadOnly = True
    TabOrder = 1
  end
  object Edit2: TEdit
    Left = 117
    Top = 88
    Width = 327
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 2
  end
  object Button1: TButton
    Left = 302
    Top = 191
    Width = 142
    Height = 25
    Anchors = [akTop, akRight]
    Caption = #1057#1086#1079#1076#1072#1090#1100' '#1082#1083#1102#1095#1092#1072#1081#1083
    TabOrder = 3
    OnClick = Button1Click
  end
  object edtUser: TEdit
    Left = 117
    Top = 141
    Width = 327
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 4
  end
  object dateAct: TDateTimePicker
    Left = 117
    Top = 168
    Width = 122
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    Date = 42341.939593136570000000
    Time = 42341.939593136570000000
    TabOrder = 5
  end
  object dateEnd: TDateTimePicker
    Left = 116
    Top = 195
    Width = 122
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    Date = 42341.939811527780000000
    Time = 42341.939811527780000000
    TabOrder = 6
  end
  object OpenDialog1: TOpenDialog
    Filter = #1060#1072#1081#1083' '#1083#1086#1082#1072#1083#1100#1085#1099#1081' '#1076#1072#1085#1085#1099#1093'|*.dat'
    Left = 336
    Top = 144
  end
  object SaveDialog1: TSaveDialog
    Filter = #1060#1072#1081#1083' '#1083#1080#1094#1077#1085#1079#1080#1080'|*.key'
    Left = 384
    Top = 144
  end
end
