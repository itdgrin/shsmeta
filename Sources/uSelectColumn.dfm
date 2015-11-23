object fSelectColumn: TfSelectColumn
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSizeToolWin
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1074#1080#1076#1080#1084#1086#1089#1090#1080' '#1082#1086#1083#1086#1085#1086#1082
  ClientHeight = 83
  ClientWidth = 190
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object clbList: TCheckListBox
    Left = 0
    Top = 0
    Width = 190
    Height = 51
    OnClickCheck = clbListClickCheck
    Align = alClient
    DragMode = dmAutomatic
    ItemHeight = 13
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 51
    Width = 190
    Height = 32
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      190
      32)
    object ButtonOK: TButton
      Left = 56
      Top = 4
      Width = 75
      Height = 25
      Anchors = []
      Caption = '&OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
  end
end
