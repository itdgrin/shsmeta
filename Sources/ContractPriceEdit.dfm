object fContractPriceEdit: TfContractPriceEdit
  Left = 0
  Top = 0
  Caption = #1056#1072#1089#1095#1077#1090' '#1080#1085#1076#1077#1082#1089#1072#1094#1080#1080' '#1076#1083#1103' '#1055#1043#1056
  ClientHeight = 403
  ClientWidth = 727
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
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object pnlTopEstimate: TPanel
    Left = 0
    Top = 0
    Width = 727
    Height = 29
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      727
      29)
    object lblEstimate: TLabel
      Left = 8
      Top = 6
      Width = 35
      Height = 13
      Caption = #1057#1084#1077#1090#1072':'
    end
    object dbedt1: TDBEdit
      Left = 49
      Top = 3
      Width = 672
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
    end
  end
  object pnlTopSourceData: TPanel
    Left = 0
    Top = 29
    Width = 727
    Height = 135
    Align = alTop
    TabOrder = 1
    ExplicitTop = 82
    object lbl1: TLabel
      Left = 8
      Top = 1
      Width = 35
      Height = 13
      Caption = #1057#1084#1077#1090#1072':'
    end
  end
  object pnlClient: TPanel
    Left = 0
    Top = 164
    Width = 727
    Height = 198
    Align = alClient
    TabOrder = 2
    ExplicitLeft = -8
    ExplicitTop = 306
    ExplicitHeight = 41
    object grMain: TJvDBGrid
      Left = 1
      Top = 1
      Width = 725
      Height = 196
      Align = alClient
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      SelectColumnsDialogStrings.Caption = 'Select columns'
      SelectColumnsDialogStrings.OK = '&OK'
      SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
      EditControls = <>
      RowsHeight = 17
      TitleRowHeight = 17
    end
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 362
    Width = 727
    Height = 41
    Align = alBottom
    TabOrder = 3
    ExplicitTop = 281
  end
end
