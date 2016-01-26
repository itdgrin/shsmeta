object fC3: TfC3
  Left = 0
  Top = 0
  Caption = #1057#1087#1088#1072#1074#1082#1072' '#1057'-3'
  ClientHeight = 362
  ClientWidth = 409
  Color = clBtnFace
  Constraints.MinHeight = 400
  Constraints.MinWidth = 425
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poMainFormCenter
  Visible = True
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 409
    Height = 89
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitWidth = 517
    DesignSize = (
      409
      89)
    object lblDate: TLabel
      Left = 8
      Top = 8
      Width = 167
      Height = 13
      Caption = #1056#1045#1045#1057#1058#1056' '#1042#1067#1055#1054#1051#1053#1045#1053#1053#1067#1061' '#1056#1040#1041#1054#1058' '#1079#1072
    end
    object lblObject: TLabel
      Left = 8
      Top = 35
      Width = 39
      Height = 13
      Caption = #1054#1073#1098#1077#1082#1090
    end
    object cbbMonth: TComboBox
      Left = 181
      Top = 5
      Width = 100
      Height = 21
      Style = csDropDownList
      DropDownCount = 12
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemIndex = 0
      ParentFont = False
      TabOrder = 0
      Text = #1071#1085#1074#1072#1088#1100
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
    object dbedt1: TDBEdit
      Left = 53
      Top = 32
      Width = 348
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 2
      ExplicitWidth = 481
    end
    object seYear: TJvSpinEdit
      Left = 287
      Top = 5
      Width = 58
      Height = 21
      Value = 2016.000000000000000000
      TabOrder = 1
    end
    object btn1: TBitBtn
      Left = 8
      Top = 59
      Width = 75
      Height = 25
      Caption = #1042#1089#1077' '#1089#1090#1088#1086#1082#1080
      TabOrder = 3
    end
    object btn2: TBitBtn
      Left = 89
      Top = 59
      Width = 112
      Height = 25
      Caption = #1055#1077#1095#1072#1090#1100' '#1088#1077#1077#1089#1090#1088#1072
      TabOrder = 4
    end
    object btn3: TBitBtn
      Left = 207
      Top = 59
      Width = 87
      Height = 25
      Caption = #1057#1087#1088#1072#1074#1082#1072' '#1057'-3'
      TabOrder = 5
    end
    object btn4: TBitBtn
      Left = 300
      Top = 59
      Width = 102
      Height = 25
      Caption = #1056#1077#1082#1074#1080#1079#1080#1090#1099' '#1057'-3'
      TabOrder = 6
    end
  end
  object pnl1: TPanel
    Left = 0
    Top = 89
    Width = 409
    Height = 273
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitLeft = 24
    ExplicitTop = 137
    ExplicitWidth = 517
    ExplicitHeight = 534
    object JvDBGrid1: TJvDBGrid
      Left = 0
      Top = 0
      Width = 409
      Height = 273
      Align = alClient
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      AutoSizeColumns = True
      AutoSizeColumnIndex = 0
      SelectColumnsDialogStrings.Caption = 'Select columns'
      SelectColumnsDialogStrings.OK = '&OK'
      SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
      EditControls = <>
      RowsHeight = 17
      TitleRowHeight = 17
      Columns = <
        item
          Expanded = False
          Title.Alignment = taCenter
          Title.Caption = #1057#1090#1072#1090#1100#1103
          Width = 148
          Visible = True
        end
        item
          Expanded = False
          Title.Alignment = taCenter
          Title.Caption = #1057' '#1085#1072#1095'. '#1089#1090#1088'-'#1074#1072
          Width = 81
          Visible = True
        end
        item
          Expanded = False
          Title.Alignment = taCenter
          Title.Caption = #1057' '#1085#1072#1095'. '#1075#1086#1076#1072
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          Title.Alignment = taCenter
          Title.Caption = #1047#1072' '#1084#1077#1089#1103#1094
          Width = 80
          Visible = True
        end>
    end
  end
end
