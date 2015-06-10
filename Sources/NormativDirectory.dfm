object fNormativDirectory: TfNormativDirectory
  Left = 0
  Top = 0
  BorderStyle = bsSizeToolWin
  Caption = #1057#1073#1086#1088#1085#1080#1082#1080
  ClientHeight = 493
  ClientWidth = 554
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object spl1: TSplitter
    Left = 0
    Top = 389
    Width = 554
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    ExplicitTop = 398
  end
  object tvMain: TJvDBTreeView
    Left = 0
    Top = 0
    Width = 554
    Height = 389
    DataSource = dsMain
    MasterField = 'normativ_directory_id'
    DetailField = 'parent_id'
    ItemField = 'FULL_NAME'
    StartMasterValue = '0'
    UseFilter = True
    PersistentNode = True
    ReadOnly = True
    DragMode = dmAutomatic
    HideSelection = False
    Indent = 19
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    TabOrder = 0
    OnDblClick = tvMainDblClick
    ParentFont = False
    RowSelect = True
    Mirror = False
    ExplicitTop = -3
  end
  object grSostav: TJvDBGrid
    Left = 0
    Top = 392
    Width = 554
    Height = 101
    Align = alBottom
    DataSource = dsDetail
    Options = [dgTitles, dgColumnResize, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleHotTrack]
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    AutoAppend = False
    AutoSizeColumns = True
    SelectColumnsDialogStrings.Caption = 'Select columns'
    SelectColumnsDialogStrings.OK = '&OK'
    SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
    CanDelete = False
    EditControls = <>
    RowsHeight = 16
    TitleRowHeight = 17
    WordWrap = True
    WordWrapAllFields = True
    Columns = <
      item
        Expanded = False
        FieldName = 'FULL_NAME'
        Title.Alignment = taCenter
        Title.Caption = #1057#1086#1089#1090#1072#1074' '#1088#1072#1073#1086#1090
        Width = 550
        Visible = True
      end>
  end
  object qrMain: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FetchOptions.AssignedValues = [evCache]
    FetchOptions.Cache = [fiBlobs, fiMeta]
    SQL.Strings = (
      
        'SELECT CONCAT(IFNULL(FIRST_NAME, ""), IF(SECOND_NAME IS NULL, ""' +
        ', " - "), IFNULL(SECOND_NAME, "")) AS FULL_NAME, IFNULL(parent_i' +
        'd, 0) AS parent_id, normativ_directory_id'
      'FROM normativ_directory'
      'WHERE type_directory <> 6'
      
        'ORDER BY parent_id, CONCAT(LEFT("000000000000000000000000000000"' +
        ', 30-LENGTH(FIRST_NAME)), FIRST_NAME), SECOND_NAME')
    Left = 25
    Top = 344
  end
  object dsMain: TDataSource
    DataSet = qrMain
    Left = 24
    Top = 392
  end
  object qrDetail: TFDQuery
    MasterSource = dsMain
    MasterFields = 'normativ_directory_id'
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FetchOptions.AssignedValues = [evCache]
    FetchOptions.Cache = [fiBlobs, fiMeta]
    FormatOptions.AssignedValues = [fvDefaultParamDataType]
    FormatOptions.DefaultParamDataType = ftBCD
    SQL.Strings = (
      'SELECT FIRST_NAME AS FULL_NAME, normativ_directory_id'
      'FROM normativ_directory'
      'WHERE type_directory = 6 AND parent_id=:normativ_directory_id'
      'ORDER BY FIRST_NAME')
    Left = 89
    Top = 368
    ParamData = <
      item
        Name = 'NORMATIV_DIRECTORY_ID'
        ParamType = ptInput
      end>
  end
  object dsDetail: TDataSource
    DataSet = qrDetail
    Left = 88
    Top = 416
  end
end
