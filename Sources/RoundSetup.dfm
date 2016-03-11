object fRoundSetup: TfRoundSetup
  Left = 0
  Top = 0
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1086#1082#1088#1091#1075#1083#1077#1085#1080#1081
  ClientHeight = 326
  ClientWidth = 572
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
  DesignSize = (
    572
    326)
  PixelsPerInch = 96
  TextHeight = 13
  object btnCancel: TBitBtn
    Left = 489
    Top = 293
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1054#1090#1084#1077#1085#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = btnCancelClick
    ExplicitLeft = 538
  end
  object btnSave: TBitBtn
    Left = 408
    Top = 293
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = btnSaveClick
    ExplicitLeft = 457
  end
  object grMainEx: TJvDBGrid
    Left = 8
    Top = 8
    Width = 556
    Height = 279
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = dsMainEx
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
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
        FieldName = 'DESCRIPTION'
        Title.Alignment = taCenter
        Title.Caption = #1054#1087#1080#1089#1072#1085#1080#1077
        Width = 354
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ACCURACY'
        Title.Alignment = taCenter
        Title.Caption = #1058#1086#1095#1085#1086#1089#1090#1100
        Width = 57
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'LOOK_TYPE'
        Title.Alignment = taCenter
        Title.Caption = #1058#1080#1087
        Width = 126
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NAME'
        Title.Alignment = taCenter
        Title.Caption = #1050#1086#1076
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'CODE'
        Title.Alignment = taCenter
        Visible = False
      end>
  end
  object qrMainEx: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FetchOptions.AssignedValues = [evRowsetSize, evCache, evRecordCountMode, evAutoFetchAll]
    FetchOptions.RowsetSize = 500
    FetchOptions.RecordCountMode = cmTotal
    FetchOptions.Cache = [fiBlobs, fiMeta]
    FormatOptions.AssignedValues = [fvMapRules]
    FormatOptions.OwnMapRules = True
    FormatOptions.MapRules = <
      item
        SourceDataType = dtMemo
        TargetDataType = dtAnsiString
      end
      item
        SourceDataType = dtFmtBCD
        TargetDataType = dtDouble
      end>
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvUpdateChngFields, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.EnableDelete = False
    UpdateOptions.UpdateTableName = 'smeta.round_ex'
    SQL.Strings = (
      'SELECT * FROM round_ex')
    Left = 72
    Top = 72
    object qrMainExNAME: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'NAME'
      Origin = 'NAME'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Size = 250
    end
    object qrMainExACCURACY: TFloatField
      AutoGenerateValue = arDefault
      FieldName = 'ACCURACY'
      Origin = 'ACCURACY'
      DisplayFormat = '### ### ### ### ### ### ##0.########'
      EditFormat = '0.########'
    end
    object qrMainExROUND_TYPE: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'ROUND_TYPE'
      Origin = 'ROUND_TYPE'
      DisplayFormat = '###,##0.########'
      EditFormat = '0.########'
    end
    object qrMainExDESCRIPTION: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'DESCRIPTION'
      Origin = 'DESCRIPTION'
      Size = 500
    end
    object qrMainExLOOK_TYPE: TStringField
      FieldKind = fkLookup
      FieldName = 'LOOK_TYPE'
      LookupDataSet = qrRoundType
      LookupKeyFields = 'ID'
      LookupResultField = 'NAME'
      KeyFields = 'ROUND_TYPE'
      Lookup = True
    end
    object qrMainExCODE: TIntegerField
      FieldName = 'CODE'
      Origin = 'CODE'
      Required = True
      DisplayFormat = '###,##0.########'
      EditFormat = '0.########'
    end
  end
  object dsMainEx: TDataSource
    DataSet = qrMainEx
    Left = 72
    Top = 118
  end
  object qrRoundType: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FetchOptions.AssignedValues = [evRowsetSize, evCache, evRecordCountMode, evAutoFetchAll]
    FetchOptions.RowsetSize = 500
    FetchOptions.RecordCountMode = cmTotal
    FetchOptions.Cache = [fiBlobs, fiMeta]
    FormatOptions.AssignedValues = [fvMapRules]
    FormatOptions.OwnMapRules = True
    FormatOptions.MapRules = <
      item
        SourceDataType = dtMemo
        TargetDataType = dtAnsiString
      end
      item
        SourceDataType = dtFmtBCD
        TargetDataType = dtDouble
      end>
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvUpdateChngFields, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.EnableDelete = False
    SQL.Strings = (
      'SELECT * FROM round_type')
    Left = 120
    Top = 72
  end
end
