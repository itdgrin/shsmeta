object fSmReportParamsEdit: TfSmReportParamsEdit
  Left = 0
  Top = 0
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1087#1072#1088#1072#1084#1077#1090#1088#1086#1074' '#1086#1090#1095#1077#1090#1072
  ClientHeight = 282
  ClientWidth = 703
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
  object pnl1: TPanel
    Left = 0
    Top = 248
    Width = 703
    Height = 34
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      703
      34)
    object dbnvgr1: TDBNavigator
      Left = 3
      Top = 4
      Width = 240
      Height = 25
      DataSource = dsReportParam
      TabOrder = 0
    end
    object btnClose: TBitBtn
      Left = 623
      Top = 4
      Width = 76
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #1047#1072#1082#1088#1099#1090#1100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = btnCloseClick
    end
  end
  object grReportParam: TJvDBGrid
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 697
    Height = 242
    Align = alClient
    DataSource = dsReportParam
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
    SelectColumnsDialogStrings.Caption = 'Select columns'
    SelectColumnsDialogStrings.OK = '&OK'
    SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
    EditControls = <>
    RowsHeight = 17
    TitleRowHeight = 17
    Columns = <
      item
        Expanded = False
        FieldName = 'REPORT_PARAM_LABEL'
        Title.Alignment = taCenter
        Title.Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1087#1072#1088#1072#1084#1077#1090#1088#1072
        Width = 138
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'REPORT_PARAM_NAME'
        Title.Alignment = taCenter
        Title.Caption = #1055#1077#1088#1077#1084#1077#1085#1085#1072#1103
        Width = 132
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'LookType'
        Title.Alignment = taCenter
        Title.Caption = #1058#1080#1087
        Width = 85
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'LookList'
        Title.Alignment = taCenter
        Title.Caption = #1057#1087#1080#1089#1086#1082
        Width = 87
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FL_REQUIRED'
        Title.Alignment = taCenter
        Title.Caption = #1054#1073#1103#1079#1072#1090#1077#1083#1100#1085#1086#1077
        Width = 82
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FL_ALLOW_ALL'
        Title.Alignment = taCenter
        Title.Caption = #1042#1086#1079#1084#1086#1078#1085#1086' '#1042#1089#1077
        Width = 79
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'POS'
        Title.Alignment = taCenter
        Title.Caption = #1055#1086#1079#1080#1094#1080#1103
        Width = 71
        Visible = True
      end>
  end
  object qrReportParam: TFDQuery
    BeforeOpen = qrReportParamBeforeOpen
    OnNewRecord = qrReportParamNewRecord
    MasterFields = 'REPORT_CATEGORY_ID'
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FetchOptions.AssignedValues = [evCache]
    FetchOptions.Cache = [fiBlobs, fiMeta]
    FormatOptions.AssignedValues = [fvMapRules]
    FormatOptions.OwnMapRules = True
    FormatOptions.MapRules = <
      item
        NameMask = 'FL_ALLOW_ALL'
        TargetDataType = dtBoolean
      end
      item
        NameMask = 'FL_REQUIRED'
        TargetDataType = dtBoolean
      end>
    UpdateOptions.UpdateTableName = 'smeta.report_param'
    UpdateOptions.KeyFields = 'REPORT_PARAM_ID'
    SQL.Strings = (
      'SELECT *'
      'FROM report_param'
      'WHERE REPORT_ID = :REPORT_ID'
      'ORDER BY POS DESC, REPORT_PARAM_ID DESC')
    Left = 30
    Top = 98
    ParamData = <
      item
        Name = 'REPORT_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object qrReportParamREPORT_PARAM_ID: TFDAutoIncField
      FieldName = 'REPORT_PARAM_ID'
      Origin = 'REPORT_PARAM_ID'
      ProviderFlags = [pfInWhere, pfInKey]
      DisplayFormat = '###,##0.########'
      EditFormat = '0.########'
    end
    object qrReportParamREPORT_ID: TIntegerField
      FieldName = 'REPORT_ID'
      Origin = 'REPORT_ID'
      Required = True
      DisplayFormat = '###,##0.########'
      EditFormat = '0.########'
    end
    object qrReportParamREPORT_PARAM_TYPE_ID: TIntegerField
      FieldName = 'REPORT_PARAM_TYPE_ID'
      Origin = 'REPORT_PARAM_TYPE_ID'
      Required = True
      DisplayFormat = '###,##0.########'
      EditFormat = '0.########'
    end
    object qrReportParamREPORT_PARAM_NAME: TStringField
      FieldName = 'REPORT_PARAM_NAME'
      Origin = 'REPORT_PARAM_NAME'
      Required = True
      Size = 200
    end
    object qrReportParamREPORT_PARAM_LABEL: TStringField
      FieldName = 'REPORT_PARAM_LABEL'
      Origin = 'REPORT_PARAM_LABEL'
      Required = True
      Size = 200
    end
    object qrReportParamREPORT_LIST_SQL_ID: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'REPORT_LIST_SQL_ID'
      Origin = 'REPORT_LIST_SQL_ID'
      DisplayFormat = '###,##0.########'
      EditFormat = '0.########'
    end
    object qrReportParamPOS: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'POS'
      Origin = 'POS'
      DisplayFormat = '###,##0.########'
      EditFormat = '0.########'
    end
    object qrReportParamFL_ALLOW_ALL: TBooleanField
      AutoGenerateValue = arDefault
      FieldName = 'FL_ALLOW_ALL'
      Origin = 'FL_ALLOW_ALL'
    end
    object qrReportParamLIST_SQL: TMemoField
      AutoGenerateValue = arDefault
      FieldName = 'LIST_SQL'
      Origin = 'LIST_SQL'
      BlobType = ftMemo
    end
    object qrReportParamFL_REQUIRED: TBooleanField
      AutoGenerateValue = arDefault
      FieldName = 'FL_REQUIRED'
      Origin = 'FL_REQUIRED'
    end
    object qrReportParamLookType: TStringField
      FieldKind = fkLookup
      FieldName = 'LookType'
      LookupDataSet = qrReportParamType
      LookupKeyFields = 'REPORT_PARAM_TYPE_ID'
      LookupResultField = 'REPORT_PARAM_TYPE_NAME'
      KeyFields = 'REPORT_PARAM_TYPE_ID'
      Size = 100
      Lookup = True
    end
    object qrReportParamLookList: TStringField
      FieldKind = fkLookup
      FieldName = 'LookList'
      LookupDataSet = qrReportListSql
      LookupKeyFields = 'REPORT_LIST_SQL_ID'
      LookupResultField = 'REPORT_LIST_SQL_NAME'
      KeyFields = 'REPORT_LIST_SQL_ID'
      Size = 100
      Lookup = True
    end
  end
  object dsReportParam: TDataSource
    DataSet = qrReportParam
    Left = 30
    Top = 146
  end
  object qrReportParamType: TFDQuery
    BeforeOpen = qrReportParamBeforeOpen
    OnNewRecord = qrReportParamNewRecord
    MasterFields = 'REPORT_CATEGORY_ID'
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FetchOptions.AssignedValues = [evCache]
    FetchOptions.Cache = [fiBlobs, fiMeta]
    SQL.Strings = (
      'SELECT *'
      'FROM report_param_type'
      'ORDER BY REPORT_PARAM_TYPE_NAME')
    Left = 190
    Top = 98
  end
  object qrReportListSql: TFDQuery
    BeforeOpen = qrReportParamBeforeOpen
    OnNewRecord = qrReportParamNewRecord
    MasterFields = 'REPORT_CATEGORY_ID'
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FetchOptions.AssignedValues = [evCache]
    FetchOptions.Cache = [fiBlobs, fiMeta]
    SQL.Strings = (
      'SELECT *'
      'FROM report_list_sql'
      'ORDER BY REPORT_LIST_SQL_NAME')
    Left = 190
    Top = 154
  end
end
