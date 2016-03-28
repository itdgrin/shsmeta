object FormCopyEstimRow: TFormCopyEstimRow
  Left = 0
  Top = 0
  Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1080#1077' '#1089#1090#1088#1086#1082' '#1089#1084#1077#1090#1099
  ClientHeight = 504
  ClientWidth = 776
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 409
    Top = 0
    Height = 504
  end
  object pnlLeft: TPanel
    Left = 0
    Top = 0
    Width = 409
    Height = 504
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitHeight = 496
    object SplitterCenter: TSplitter
      Left = 0
      Top = 183
      Width = 409
      Height = 3
      Cursor = crVSplit
      Align = alTop
      ResizeStyle = rsUpdate
    end
    object gbObjects: TGroupBox
      Left = 0
      Top = 0
      Width = 409
      Height = 183
      Align = alTop
      Caption = ' '#1054#1073#1098#1077#1082#1090#1099' '
      TabOrder = 0
      ExplicitLeft = 1
      ExplicitTop = 1
      ExplicitWidth = 400
      object dbgrdObjects: TJvDBGrid
        Left = 2
        Top = 15
        Width = 405
        Height = 166
        Align = alClient
        DataSource = dsObjects
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        TitleButtons = True
        SelectColumn = scGrid
        TitleArrow = True
        SelectColumnsDialogStrings.Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1074#1080#1076#1080#1084#1086#1089#1090#1080' '#1082#1086#1083#1086#1085#1086#1082
        SelectColumnsDialogStrings.OK = '&OK'
        SelectColumnsDialogStrings.NoSelectionWarning = #1044#1086#1083#1078#1085#1072' '#1073#1099#1090#1100' '#1074#1099#1073#1088#1072#1085#1072' '#1093#1086#1090#1103' '#1073#1099' '#1086#1076#1085#1072' '#1082#1086#1083#1086#1085#1082#1072'!'
        EditControls = <>
        RowsHeight = 17
        TitleRowHeight = 17
        Columns = <
          item
            Expanded = False
            FieldName = 'num'
            Title.Alignment = taCenter
            Title.Caption = #8470' '
            Width = 40
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'encrypt'
            Title.Alignment = taCenter
            Title.Caption = #1064#1080#1092#1088
            Width = 70
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'full_name'
            Title.Alignment = taCenter
            Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1086#1073#1098#1077#1082#1090#1072
            Width = 250
            Visible = True
          end>
      end
    end
    object gbTreeData: TGroupBox
      Left = 0
      Top = 186
      Width = 409
      Height = 318
      Align = alClient
      Caption = ' '#1057#1084#1077#1090#1099' '
      TabOrder = 1
      ExplicitLeft = 25
      ExplicitTop = 236
      ExplicitWidth = 271
      ExplicitHeight = 179
      object tvEstimates: TJvDBTreeView
        Left = 2
        Top = 15
        Width = 405
        Height = 301
        DataSource = dsTreeData
        MasterField = 'SM_ID'
        DetailField = 'PARENT'
        ItemField = 'NAME'
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
        ParentFont = False
        RowSelect = True
        Mirror = False
        ExplicitLeft = 3
        ExplicitTop = 17
        ExplicitWidth = 384
        ExplicitHeight = 166
      end
    end
  end
  object pnlRigth: TPanel
    Left = 412
    Top = 0
    Width = 364
    Height = 504
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitLeft = 560
    ExplicitTop = 328
    ExplicitWidth = 185
    ExplicitHeight = 41
    object gbRate: TGroupBox
      Left = 0
      Top = 0
      Width = 364
      Height = 504
      Align = alClient
      Caption = ' '#1057#1086#1089#1090#1072#1074' '#1089#1084#1077#1090#1099' '
      TabOrder = 0
      ExplicitLeft = 19
      ExplicitTop = 7
      ExplicitWidth = 349
      ExplicitHeight = 494
      object grRatesEx: TJvDBGrid
        Left = 2
        Top = 15
        Width = 360
        Height = 487
        Align = alClient
        DataSource = dsRatesEx
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgMultiSelect, dgTitleHotTrack]
        ParentFont = False
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        AutoAppend = False
        MultiSelect = True
        AutoSizeColumns = True
        SelectColumnsDialogStrings.Caption = 'Select columns'
        SelectColumnsDialogStrings.OK = '&OK'
        SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
        CanDelete = False
        EditControls = <>
        RowsHeight = 17
        TitleRowHeight = 17
        Columns = <
          item
            Expanded = False
            FieldName = 'ITERATOR'
            Title.Alignment = taCenter
            Title.Caption = #8470' '#1087'/'#1087
            Width = 30
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NOM_ROW_MANUAL'
            Title.Alignment = taCenter
            Title.Caption = #8470
            Width = 30
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'OBJ_CODE'
            Title.Alignment = taCenter
            Title.Caption = #1050#1086#1076
            Width = 135
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'OBJ_COUNT'
            Title.Alignment = taCenter
            Title.Caption = #1050#1086#1083'-'#1074#1086
            Width = 59
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'OBJ_UNIT'
            Title.Alignment = taCenter
            Title.Caption = #1045#1076'. '#1080#1079#1084'.'
            Width = 85
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'SORT_ID'
            Title.Alignment = taCenter
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'ID_TYPE_DATA'
            Title.Alignment = taCenter
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'DATA_ESTIMATE_OR_ACT_ID'
            Title.Alignment = taCenter
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'ID_TABLES'
            Title.Alignment = taCenter
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'SM_ID'
            Title.Alignment = taCenter
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'WORK_ID'
            Title.Alignment = taCenter
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'ZNORMATIVS_ID'
            Title.Alignment = taCenter
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'APPLY_WINTERPRISE_FLAG'
            Title.Alignment = taCenter
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'ID_RATE'
            Title.Alignment = taCenter
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'SORT_ID2'
            Title.Alignment = taCenter
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'NUM_ROW'
            Title.Alignment = taCenter
            Title.Caption = #1055#1086#1088#1103#1076#1082#1086#1074#1099#1081' '#1085#1086#1084#1077#1088
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'ID_REPLACED'
            Title.Caption = 'ID_REPLACED ('#1048#1044' '#1084#1072#1090#1077#1088#1080#1072#1083#1072', '#1079#1072#1084#1077#1085#1103#1077#1084#1086#1075#1086' '#1076#1072#1085#1085#1099#1084')'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'ID_ACT'
            Visible = False
          end>
      end
    end
  end
  object qrObjects: TFDQuery
    BeforeOpen = qrObjectsBeforeOpen
    AfterOpen = qrObjectsAfterOpen
    AfterScroll = qrObjectsAfterScroll
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    SQL.Strings = (
      'SELECT obj_id, num, encrypt, num_dog, full_name'
      'FROM objcards'
      'WHERE (DEL_FLAG=0) AND '
      '      ((:USER_ID=1) OR (USER_ID=:USER_ID) OR '
      
        '      EXISTS(SELECT USER_ID FROM user_access WHERE DOC_TYPE_ID=2' +
        ' AND MASTER_ID=objcards.obj_id AND ((USER_ID=0) OR (USER_ID=:USE' +
        'R_ID)) LIMIT 1))'
      'ORDER BY num, num_dog, full_name;')
    Left = 33
    Top = 72
    ParamData = <
      item
        Name = 'USER_ID'
        ParamType = ptInput
      end>
  end
  object dsObjects: TDataSource
    DataSet = qrObjects
    Left = 32
    Top = 120
  end
  object qrTreeData: TFDQuery
    BeforeOpen = qrObjectsBeforeOpen
    MasterSource = dsObjects
    MasterFields = 'obj_id'
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FetchOptions.AssignedValues = [evCache]
    FetchOptions.Cache = [fiBlobs, fiMeta]
    SQL.Strings = (
      
        'SELECT SM_ID, SM_TYPE, OBJ_ID, CONCAT(IFNULL(SM_NUMBER, ""), " "' +
        ',  IFNULL(NAME, ""), IF(DELETED=1, "-", "")) as NAME,'
      '       PARENT_ID as PARENT, USER_ID, SM_NUMBER'
      'FROM smetasourcedata'
      'WHERE OBJ_ID=:OBJ_ID'
      '  AND (DELETED=0) '
      '  AND (ACT=0)'
      '  AND ((:USER_ID=1) OR '
      '       (USER_ID=:USER_ID) OR '
      
        '       EXISTS(SELECT USER_ID FROM user_access WHERE DOC_TYPE_ID=' +
        '1 AND MASTER_ID=SM_ID AND ((USER_ID=0) OR (USER_ID=:USER_ID)) LI' +
        'MIT 1))'
      'ORDER BY NAME')
    Left = 33
    Top = 256
    ParamData = <
      item
        Name = 'OBJ_ID'
        DataType = ftInteger
        ParamType = ptInput
        Size = 10
        Value = Null
      end
      item
        Name = 'USER_ID'
        ParamType = ptInput
      end>
  end
  object dsTreeData: TDataSource
    DataSet = qrTreeData
    Left = 32
    Top = 320
  end
  object qrRatesEx: TFDQuery
    CachedUpdates = True
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FetchOptions.AssignedValues = [evItems]
    FetchOptions.Items = [fiBlobs, fiDetails]
    FormatOptions.AssignedValues = [fvMapRules, fvMaxBcdPrecision, fvMaxBcdScale, fvDefaultParamDataType, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.OwnMapRules = True
    FormatOptions.MapRules = <
      item
        SourceDataType = dtMemo
        TargetDataType = dtAnsiString
      end
      item
        SourceDataType = dtUInt32
        TargetDataType = dtInt32
      end
      item
        SourceDataType = dtUInt64
        TargetDataType = dtInt32
      end
      item
        SourceDataType = dtInt64
        TargetDataType = dtInt32
      end
      item
        SourceDataType = dtBCD
        TargetDataType = dtDouble
      end
      item
        SourceDataType = dtFmtBCD
        TargetDataType = dtDouble
      end>
    FormatOptions.MaxBcdPrecision = 24
    FormatOptions.MaxBcdScale = 6
    FormatOptions.DefaultParamDataType = ftBCD
    FormatOptions.FmtDisplayNumeric = '### ### ### ### ### ### ### ##0.#######'
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvUpdateChngFields, uvRefreshMode, uvRefreshDelete, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable, uvUpdateNonBaseFields]
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.UpdateNonBaseFields = True
    UpdateOptions.CheckRequired = False
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.CheckUpdatable = False
    SQL.Strings = (
      'CALL `GetRates_ex`(:vIsACT, :EAID);')
    Left = 688
    Top = 200
    ParamData = <
      item
        Name = 'VISACT'
        DataType = ftInteger
        ParamType = ptInput
        Value = 0
      end
      item
        Name = 'EAID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 0
      end>
    object strngfldRatesExSORT_ID: TStringField
      FieldName = 'SORT_ID'
      Size = 255
    end
    object qrRatesExITERATOR: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'ITERATOR'
      Origin = 'ITERATOR'
      ProviderFlags = []
      ReadOnly = True
    end
    object qrRatesExOBJ_CODE: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'OBJ_CODE'
      Origin = 'OBJ_CODE'
      ProviderFlags = []
      Size = 151
    end
    object qrRatesExOBJ_NAME: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'OBJ_NAME'
      Origin = 'OBJ_NAME'
      ProviderFlags = []
      Size = 300
    end
    object qrRatesExOBJ_UNIT: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'OBJ_UNIT'
      Origin = 'OBJ_UNIT'
      ProviderFlags = []
      ReadOnly = True
      Size = 100
    end
    object qrRatesExID_TYPE_DATA: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'ID_TYPE_DATA'
      Origin = 'ID_TYPE_DATA'
      ProviderFlags = []
    end
    object qrRatesExDATA_ESTIMATE_OR_ACT_ID: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'DATA_ESTIMATE_OR_ACT_ID'
      Origin = 'DATA_ESTIMATE_OR_ACT_ID'
      ProviderFlags = []
    end
    object qrRatesExID_TABLES: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'ID_TABLES'
      Origin = 'ID_TABLES'
      ProviderFlags = []
    end
    object qrRatesExSM_ID: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'SM_ID'
      Origin = 'SM_ID'
      ProviderFlags = []
    end
    object qrRatesExWORK_ID: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'WORK_ID'
      Origin = 'WORK_ID'
      ProviderFlags = []
    end
    object qrRatesExZNORMATIVS_ID: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'ZNORMATIVS_ID'
      Origin = 'ZNORMATIVS_ID'
      ProviderFlags = []
    end
    object qrRatesExAPPLY_WINTERPRISE_FLAG: TShortintField
      AutoGenerateValue = arDefault
      FieldName = 'APPLY_WINTERPRISE_FLAG'
      Origin = 'APPLY_WINTERPRISE_FLAG'
      ProviderFlags = []
    end
    object qrRatesExID_RATE: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'ID_RATE'
      Origin = 'ID_RATE'
      ProviderFlags = []
    end
    object qrRatesExOBJ_COUNT: TFloatField
      FieldName = 'OBJ_COUNT'
    end
    object qrRatesExADDED_COUNT: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'ADDED_COUNT'
      Calculated = True
    end
    object qrRatesExREPLACED_COUNT: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'REPLACED_COUNT'
      Calculated = True
    end
    object qrRatesExINCITERATOR: TIntegerField
      FieldName = 'INCITERATOR'
    end
    object strngfldRatesExSORT_ID2: TStringField
      FieldName = 'SORT_ID2'
    end
    object qrRatesExNUM_ROW: TIntegerField
      FieldName = 'NUM_ROW'
    end
    object qrRatesExID_REPLACED: TIntegerField
      FieldName = 'ID_REPLACED'
    end
    object qrRatesExCONS_REPLASED: TIntegerField
      FieldName = 'CONS_REPLASED'
    end
    object qrRatesExCOEF_ORDERS: TIntegerField
      FieldName = 'COEF_ORDERS'
    end
    object qrRatesExNOM_ROW_MANUAL: TIntegerField
      FieldName = 'NOM_ROW_MANUAL'
    end
    object qrRatesExMarkRow: TShortintField
      FieldName = 'MarkRow'
    end
  end
  object dsRatesEx: TDataSource
    DataSet = qrRatesEx
    Left = 688
    Top = 248
  end
end
