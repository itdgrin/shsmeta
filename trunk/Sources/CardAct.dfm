object fCardAct: TfCardAct
  Left = 0
  Top = 0
  BiDiMode = bdLeftToRight
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1050#1072#1088#1090#1086#1095#1082#1072' '#1072#1082#1090#1072
  ClientHeight = 153
  ClientWidth = 392
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  ParentBiDiMode = False
  OnClose = FormClose
  OnShow = FormShow
  DesignSize = (
    392
    153)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel: TBevel
    Left = 0
    Top = 112
    Width = 392
    Height = 41
    Align = alBottom
    Shape = bsTopLine
    ExplicitTop = 106
  end
  object ButtonSave: TButton
    Left = 178
    Top = 120
    Width = 100
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    Default = True
    TabOrder = 0
    OnClick = ButtonSaveClick
  end
  object ButtonClose: TButton
    Left = 284
    Top = 120
    Width = 100
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 1
    OnClick = ButtonCloseClick
  end
  object PanelDate: TPanel
    Left = 0
    Top = 0
    Width = 392
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    Caption = 'PanelDate'
    ShowCaption = False
    TabOrder = 2
    object LabelDate: TLabel
      Left = 6
      Top = 5
      Width = 97
      Height = 13
      Caption = #1044#1072#1090#1072' '#1089#1086#1089#1090#1072#1074#1083#1077#1085#1080#1103':'
    end
    object edDate: TJvDBDateEdit
      Left = 109
      Top = 2
      Width = 97
      Height = 21
      DataField = 'DATE'
      DataSource = dsAct
      CheckOnExit = True
      ShowNullDate = False
      TabOrder = 0
    end
  end
  object PanelDescription: TPanel
    Left = 0
    Top = 50
    Width = 392
    Height = 50
    Align = alTop
    BevelOuter = bvNone
    Caption = 'PanelDescription'
    ShowCaption = False
    TabOrder = 3
    object LabelDescription: TLabel
      Left = 6
      Top = 16
      Width = 53
      Height = 13
      Caption = #1054#1087#1080#1089#1072#1085#1080#1077':'
    end
    object dbmmoDESCRIPTION: TDBMemo
      Left = 65
      Top = 4
      Width = 319
      Height = 45
      DataField = 'DESCRIPTION'
      DataSource = dsAct
      TabOrder = 0
    end
  end
  object PanelName: TPanel
    Left = 0
    Top = 25
    Width = 392
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    Caption = 'PanelName'
    ShowCaption = False
    TabOrder = 4
    object LabelName: TLabel
      Left = 7
      Top = 5
      Width = 52
      Height = 13
      Caption = #1053#1072#1079#1074#1072#1085#1080#1077':'
    end
    object dbedtNAME: TDBEdit
      Left = 65
      Top = 2
      Width = 319
      Height = 21
      DataField = 'NAME'
      DataSource = dsAct
      TabOrder = 0
    end
  end
  object qrTemp: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    Left = 12
    Top = 96
  end
  object qrAct: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    SQL.Strings = (
      'select * from card_acts'
      'where id=:id')
    Left = 84
    Top = 96
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object dsAct: TDataSource
    DataSet = qrAct
    Left = 120
    Top = 96
  end
end
