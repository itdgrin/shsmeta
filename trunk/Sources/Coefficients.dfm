object FormCoefficients: TFormCoefficients
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1050#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090#1099
  ClientHeight = 418
  ClientWidth = 644
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PanelRight: TPanel
    Left = 385
    Top = 0
    Width = 259
    Height = 418
    Align = alRight
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 1
    DesignSize = (
      259
      418)
    object LabelSalary: TLabel
      Left = 8
      Top = 9
      Width = 127
      Height = 13
      Caption = #1054#1089#1085#1086#1074#1085#1072#1103' '#1079#1072#1088#1087#1083#1072#1090#1072' ('#1047#1055'):'
    end
    object LabelExploitationCars: TLabel
      Left = 8
      Top = 36
      Width = 151
      Height = 13
      Caption = #1069#1082#1089#1087#1083#1091#1072#1090#1072#1094#1080#1103' '#1084#1072#1096#1080#1085' ('#1069#1052#1080#1052'):'
    end
    object LabelMaterialResources: TLabel
      Left = 8
      Top = 63
      Width = 150
      Height = 13
      Caption = #1052#1072#1090#1077#1088#1080#1072#1083#1100#1085#1099#1077' '#1088#1077#1089#1091#1088#1089#1099' ('#1052#1056'):'
    end
    object LabelWorkBuilders: TLabel
      Left = 8
      Top = 90
      Width = 171
      Height = 13
      Caption = #1058#1088#1091#1076#1086#1079#1072#1090#1088#1072#1090#1099' '#1088#1072#1073#1086#1095#1080#1093' ('#1058#1047' '#1088#1072#1073'.):'
    end
    object LabelWorkMachinist: TLabel
      Left = 8
      Top = 117
      Width = 192
      Height = 13
      Caption = #1058#1088#1091#1076#1086#1079#1072#1090#1088#1072#1090#1099' '#1084#1072#1096#1080#1085#1080#1089#1090#1086#1074' ('#1058#1047' '#1084#1072#1096'.):'
    end
    object Bevel1: TBevel
      Left = 0
      Top = 377
      Width = 260
      Height = 41
      Anchors = [akLeft, akBottom]
      Shape = bsTopLine
      ExplicitTop = 375
    end
    object ButtonAdd: TButton
      Left = 45
      Top = 385
      Width = 100
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      Default = True
      TabOrder = 0
      OnClick = ButtonAddClick
    end
    object ButtonCancel: TButton
      Left = 151
      Top = 385
      Width = 100
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #1054#1090#1084#1077#1085#1072
      TabOrder = 1
      OnClick = ButtonCancelClick
    end
    object EditSalary: TEdit
      Left = 206
      Top = 6
      Width = 45
      Height = 21
      TabStop = False
      Color = 14802912
      ReadOnly = True
      TabOrder = 3
    end
    object EditWorkBuilders: TEdit
      Left = 206
      Top = 87
      Width = 45
      Height = 21
      TabStop = False
      Color = 14802912
      ReadOnly = True
      TabOrder = 4
    end
    object EditWorkMachinist: TEdit
      Left = 206
      Top = 114
      Width = 45
      Height = 21
      TabStop = False
      Color = 14802912
      ReadOnly = True
      TabOrder = 2
    end
    object EditExploitationCars: TEdit
      Left = 206
      Top = 33
      Width = 45
      Height = 21
      TabStop = False
      Color = 14802912
      ReadOnly = True
      TabOrder = 5
    end
    object EditMaterialResources: TEdit
      Left = 206
      Top = 60
      Width = 45
      Height = 21
      TabStop = False
      Color = 14802912
      ReadOnly = True
      TabOrder = 6
    end
  end
  object PanelTable: TPanel
    Left = 0
    Top = 0
    Width = 385
    Height = 418
    Align = alClient
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 0
    object StringGridTable: TStringGrid
      Left = 0
      Top = 0
      Width = 385
      Height = 418
      Align = alClient
      DefaultRowHeight = 20
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect, goThumbTracking]
      ScrollBars = ssVertical
      TabOrder = 0
      OnClick = StringGridTableClick
      OnDblClick = StringGridTableDblClick
    end
  end
  object DataSourceTable: TDataSource
    DataSet = ADOQueryTable
    Left = 120
    Top = 112
  end
  object ADOQueryTable: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    Left = 36
    Top = 112
  end
end
