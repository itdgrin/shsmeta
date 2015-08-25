object FormPartsEstimates: TFormPartsEstimates
  Left = 0
  Top = 0
  Caption = 'FormPartsEstimates'
  ClientHeight = 262
  ClientWidth = 284
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
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
    Options = [fpState, fpSize, fpLocation, fpActiveControl]
    StoredValues = <>
    Left = 32
    Top = 16
  end
end
