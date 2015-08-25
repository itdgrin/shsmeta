object FormCategoriesObjects: TFormCategoriesObjects
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'FormCategoriesObjects'
  ClientHeight = 212
  ClientWidth = 234
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel: TPanel
    Left = 8
    Top = 8
    Width = 297
    Height = 209
    BevelOuter = bvNone
    Caption = 'Panel'
    ShowCaption = False
    TabOrder = 0
  end
  object FormStorage: TJvFormStorage
    AppStorage = FormMain.AppIni
    AppStoragePath = '%FORM_NAME%\'
    StoredValues = <>
    Left = 24
    Top = 48
  end
end
