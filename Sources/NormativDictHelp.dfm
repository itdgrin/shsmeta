object fNormativDictHelp: TfNormativDictHelp
  Left = 0
  Top = 0
  Caption = 
    #1055#1077#1088#1077#1095#1077#1085#1100' '#1089#1073#1086#1088#1085#1080#1082#1086#1074' '#1085#1086#1088#1084#1072#1090#1080#1074#1086#1074' '#1088#1072#1089#1093#1086#1076#1072' '#1088#1077#1089#1091#1088#1089#1086#1074' '#1074' '#1085#1072#1090#1091#1088#1072#1083#1100#1085#1086#1084' '#1074#1099#1088 +
    #1072#1078#1077#1085#1080#1080
  ClientHeight = 452
  ClientWidth = 652
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Visible = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object pgc1: TPageControl
    Left = 0
    Top = 0
    Width = 652
    Height = 452
    ActivePage = ts1
    Align = alClient
    MultiLine = True
    TabOrder = 0
    OnChange = pgc1Change
    object ts1: TTabSheet
      Caption = 
        #1055#1077#1088#1077#1095#1077#1085#1100' '#1089#1073#1086#1088#1085#1080#1082#1086#1074' '#1085#1086#1088#1084#1072#1090#1080#1074#1086#1074' '#1088#1072#1089#1093#1086#1076#1072' '#1088#1077#1089#1091#1088#1089#1086#1074' '#1074' '#1085#1072#1090#1091#1088#1072#1083#1100#1085#1086#1084' '#1074#1099#1088 +
        #1072#1078#1077#1085#1080#1080' '#1085#1072' '#1089#1090#1088#1086#1080#1090#1077#1083#1100#1085#1099#1077' '#1082#1086#1085#1089#1090#1088#1091#1082#1094#1080#1080' '#1080' '#1088#1072#1073#1086#1090#1099
      object grMain1: TJvDBGrid
        Left = 0
        Top = 0
        Width = 644
        Height = 370
        Align = alClient
        DataSource = dsMainData
        DrawingStyle = gdsClassic
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnDrawColumnCell = grMain1DrawColumnCell
        AutoAppend = False
        IniStorage = FormStorage
        AutoSizeColumns = True
        SelectColumnsDialogStrings.Caption = 'Select columns'
        SelectColumnsDialogStrings.OK = '&OK'
        SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
        CanDelete = False
        EditControls = <>
        AutoSizeRows = False
        ReduceFlicker = False
        RowsHeight = 34
        TitleRowHeight = 17
        WordWrap = True
        WordWrapAllFields = True
        Columns = <
          item
            Expanded = False
            FieldName = 'dict_number'
            Title.Alignment = taCenter
            Title.Caption = #8470' '#1089#1073#1086#1088#1085#1080#1082#1072
            Width = 75
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'dict_name'
            Title.Alignment = taCenter
            Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1089#1073#1086#1088#1085#1080#1082#1072
            Width = 384
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'dict_descr'
            Title.Alignment = taCenter
            Title.Caption = #1054#1073#1086#1079#1085#1072#1095#1077#1085#1080#1077' '#1089#1073#1086#1088#1085#1080#1082#1072
            Width = 166
            Visible = True
          end>
      end
    end
    object ts2: TTabSheet
      Caption = 
        #1055#1077#1088#1077#1095#1077#1085#1100' '#1089#1073#1086#1088#1085#1080#1082#1086#1074' '#1085#1086#1088#1084#1072#1090#1080#1074#1086#1074' '#1088#1072#1089#1093#1086#1076#1072' '#1088#1077#1089#1091#1088#1089#1086#1074' '#1074' '#1085#1072#1090#1091#1088#1072#1083#1100#1085#1086#1084' '#1074#1099#1088 +
        #1072#1078#1077#1085#1080#1080' '#1085#1072' '#1084#1086#1085#1090#1072#1078' '#1086#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1103
      ImageIndex = 1
      object grMain4: TJvDBGrid
        Left = 0
        Top = 0
        Width = 644
        Height = 370
        Align = alClient
        DataSource = dsMainData
        DrawingStyle = gdsClassic
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnDrawColumnCell = grMain1DrawColumnCell
        AutoAppend = False
        IniStorage = FormStorage
        AutoSizeColumns = True
        SelectColumnsDialogStrings.Caption = 'Select columns'
        SelectColumnsDialogStrings.OK = '&OK'
        SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
        CanDelete = False
        EditControls = <>
        AutoSizeRows = False
        ReduceFlicker = False
        RowsHeight = 34
        TitleRowHeight = 17
        WordWrap = True
        WordWrapAllFields = True
        Columns = <
          item
            Expanded = False
            FieldName = 'dict_number'
            Title.Alignment = taCenter
            Title.Caption = #8470' '#1089#1073#1086#1088#1085#1080#1082#1072
            Width = 75
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'dict_name'
            Title.Alignment = taCenter
            Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1089#1073#1086#1088#1085#1080#1082#1072
            Width = 384
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'dict_descr'
            Title.Alignment = taCenter
            Title.Caption = #1054#1073#1086#1079#1085#1072#1095#1077#1085#1080#1077' '#1089#1073#1086#1088#1085#1080#1082#1072
            Width = 166
            Visible = True
          end>
      end
    end
    object ts3: TTabSheet
      Caption = 
        #1055#1077#1088#1077#1095#1077#1085#1100' '#1089#1073#1086#1088#1085#1080#1082#1086#1074' '#1085#1086#1088#1084#1072#1090#1080#1074#1086#1074' '#1088#1072#1089#1093#1086#1076#1072' '#1088#1077#1089#1091#1088#1089#1086#1074' '#1074' '#1085#1072#1090#1091#1088#1072#1083#1100#1085#1086#1084' '#1074#1099#1088 +
        #1072#1078#1077#1085#1080#1080' '#1085#1072' '#1088#1077#1084#1086#1085#1090' '#1086#1073#1098#1077#1082#1090#1086#1074
      ImageIndex = 2
      object grMain3: TJvDBGrid
        Left = 0
        Top = 0
        Width = 644
        Height = 370
        Align = alClient
        DataSource = dsMainData
        DrawingStyle = gdsClassic
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnDrawColumnCell = grMain1DrawColumnCell
        AutoAppend = False
        IniStorage = FormStorage
        AutoSizeColumns = True
        SelectColumnsDialogStrings.Caption = 'Select columns'
        SelectColumnsDialogStrings.OK = '&OK'
        SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
        CanDelete = False
        EditControls = <>
        AutoSizeRows = False
        ReduceFlicker = False
        RowsHeight = 34
        TitleRowHeight = 17
        WordWrap = True
        WordWrapAllFields = True
        Columns = <
          item
            Expanded = False
            FieldName = 'dict_number'
            Title.Alignment = taCenter
            Title.Caption = #8470' '#1089#1073#1086#1088#1085#1080#1082#1072
            Width = 75
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'dict_name'
            Title.Alignment = taCenter
            Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1089#1073#1086#1088#1085#1080#1082#1072
            Width = 384
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'dict_descr'
            Title.Alignment = taCenter
            Title.Caption = #1054#1073#1086#1079#1085#1072#1095#1077#1085#1080#1077' '#1089#1073#1086#1088#1085#1080#1082#1072
            Width = 166
            Visible = True
          end>
      end
    end
    object ts4: TTabSheet
      Caption = #1055#1077#1088#1077#1095#1077#1085#1100' '#1089#1073#1086#1088#1085#1080#1082#1086#1074' '#1085#1086#1088#1084#1072#1090#1080#1074#1086#1074' '#1088#1072#1089#1093#1086#1076#1072' '#1088#1077#1089#1091#1088#1089#1086#1074
      ImageIndex = 3
      object grMain2: TJvDBGrid
        Left = 0
        Top = 0
        Width = 644
        Height = 370
        Align = alClient
        DataSource = dsMainData
        DrawingStyle = gdsClassic
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnDrawColumnCell = grMain1DrawColumnCell
        AutoAppend = False
        IniStorage = FormStorage
        AutoSizeColumns = True
        SelectColumnsDialogStrings.Caption = 'Select columns'
        SelectColumnsDialogStrings.OK = '&OK'
        SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
        CanDelete = False
        EditControls = <>
        AutoSizeRows = False
        ReduceFlicker = False
        RowsHeight = 34
        TitleRowHeight = 17
        WordWrap = True
        WordWrapAllFields = True
        Columns = <
          item
            Expanded = False
            FieldName = 'dict_number'
            Title.Alignment = taCenter
            Title.Caption = #8470' '#1089#1073#1086#1088#1085#1080#1082#1072
            Width = 75
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'dict_name'
            Title.Alignment = taCenter
            Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1089#1073#1086#1088#1085#1080#1082#1072
            Width = 384
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'dict_descr'
            Title.Alignment = taCenter
            Title.Caption = #1054#1073#1086#1079#1085#1072#1095#1077#1085#1080#1077' '#1089#1073#1086#1088#1085#1080#1082#1072
            Width = 166
            Visible = True
          end>
      end
    end
  end
  object qrMainData: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FetchOptions.AssignedValues = [evRowsetSize, evCache, evRecordCountMode, evAutoFetchAll]
    FetchOptions.RowsetSize = 500
    FetchOptions.RecordCountMode = cmTotal
    FetchOptions.Cache = [fiBlobs, fiMeta]
    FormatOptions.AssignedValues = [fvMapRules, fvDefaultParamDataType, fvFmtDisplayNumeric]
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
    FormatOptions.DefaultParamDataType = ftBCD
    FormatOptions.FmtDisplayNumeric = '### ### ### ### ### ### ##0.########'
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvUpdateChngFields, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.CheckUpdatable = False
    UpdateOptions.UpdateTableName = 'smeta.fact_data'
    UpdateOptions.KeyFields = 'fact_data_id'
    SQL.Strings = (
      'SELECT * FROM help_normativ_dict')
    Left = 27
    Top = 168
  end
  object dsMainData: TDataSource
    DataSet = qrMainData
    Left = 27
    Top = 216
  end
  object FormStorage: TJvFormStorage
    AppStorage = FormMain.AppIni
    AppStoragePath = '%FORM_NAME%\'
    Options = []
    StoredValues = <>
    Left = 24
    Top = 264
  end
end
