object FormCardDataEstimate: TFormCardDataEstimate
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1050#1072#1088#1090#1086#1095#1082#1072' '#1088#1072#1089#1094#1077#1085#1082#1080
  ClientHeight = 397
  ClientWidth = 476
  Color = clBtnFace
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
  object PanelTop: TPanel
    Left = 0
    Top = 0
    Width = 476
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    Caption = 'PanelTop'
    ShowCaption = False
    TabOrder = 3
    DesignSize = (
      476
      25)
    object LabelCode: TLabel
      Left = 8
      Top = 5
      Width = 71
      Height = 13
      Caption = #1054#1073#1086#1089#1085#1086#1074#1072#1085#1080#1077':'
    end
    object EditCode: TEdit
      Left = 85
      Top = 2
      Width = 388
      Height = 21
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      Color = 14802912
      ReadOnly = True
      TabOrder = 0
    end
  end
  object Memo: TMemo
    Left = 0
    Top = 25
    Width = 476
    Height = 72
    Align = alTop
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object PanelBottom: TPanel
    Left = 0
    Top = 356
    Width = 476
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'PanelBottom'
    ShowCaption = False
    TabOrder = 2
    DesignSize = (
      476
      41)
    object ButtonSave: TButton
      Left = 262
      Top = 8
      Width = 100
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      Default = True
      TabOrder = 0
      OnClick = ButtonSaveClick
    end
    object ButtonClose: TButton
      Left = 368
      Top = 8
      Width = 100
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #1054#1090#1084#1077#1085#1072
      TabOrder = 1
      OnClick = ButtonCloseClick
    end
  end
  object PanelSeparator: TPanel
    Left = 0
    Top = 97
    Width = 476
    Height = 3
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Panel'
    ShowCaption = False
    TabOrder = 4
  end
  object StringGrid: TStringGrid
    Left = 0
    Top = 100
    Width = 476
    Height = 256
    Align = alClient
    ColCount = 3
    DefaultRowHeight = 20
    DefaultDrawing = False
    RowCount = 12
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    TabOrder = 1
    OnClick = StringGridClick
    OnDrawCell = StringGridDrawCell
  end
  object ADOQueryTemp: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    Left = 41
    Top = 48
  end
end
