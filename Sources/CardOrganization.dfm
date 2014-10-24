object FormCardOrganization: TFormCardOrganization
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1050#1072#1088#1090#1086#1095#1082#1072' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080
  ClientHeight = 297
  ClientWidth = 651
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    651
    297)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel: TBevel
    Left = 0
    Top = 256
    Width = 651
    Height = 41
    Align = alBottom
    Shape = bsTopLine
    ExplicitTop = 157
    ExplicitWidth = 712
  end
  object ButtonSave: TButton
    Left = 437
    Top = 264
    Width = 100
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    Default = True
    TabOrder = 1
    OnClick = ButtonSaveClick
  end
  object ButtonClose: TButton
    Left = 543
    Top = 264
    Width = 100
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 2
    OnClick = ButtonCloseClick
  end
  object StringGrid: TStringGrid
    Left = 0
    Top = 0
    Width = 651
    Height = 256
    Align = alClient
    DefaultRowHeight = 20
    DefaultDrawing = False
    RowCount = 12
    TabOrder = 0
    OnDrawCell = StringGridDrawCell
  end
  object ADOQuery: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    Left = 345
    Top = 16
  end
end
