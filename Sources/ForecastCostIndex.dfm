object fForecastCostIndex: TfForecastCostIndex
  Left = 0
  Top = 0
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1087#1088#1086#1075#1085#1086#1079#1085#1099#1093' '#1080#1085#1076#1077#1082#1089#1086#1074' '#1094#1077#1085
  ClientHeight = 282
  ClientWidth = 418
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  ShowHint = True
  Visible = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 418
    Height = 33
    Align = alTop
    TabOrder = 0
    DesignSize = (
      418
      33)
    object lbl1: TLabel
      Left = 13
      Top = 8
      Width = 23
      Height = 13
      Caption = #1043#1086#1076':'
    end
    object lbl2: TLabel
      Left = 104
      Top = 8
      Width = 54
      Height = 13
      Caption = #1044#1086#1082#1091#1084#1077#1085#1090':'
    end
    object btnRunDoc: TSpeedButton
      Left = 391
      Top = 5
      Width = 23
      Height = 22
      Hint = #1054#1090#1082#1088#1099#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090
      Anchors = [akTop, akRight]
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000C6C4BAFFACAB9EFFB1AFA2FFB1AFA2FFB1AFA2FFB1AFA2FFB1AFA2FFB1AF
        A2FFB1AFA2FFB1AFA2FFACAB9EFFC7C5BEFF0000000000000000000000000000
        0000C3BEB7FFC7C3BDFFC7C3BDFFC7C3BDFFC7C3BDFFC7C3BDFFC7C3BDFFC7C3
        BDFFC7C3BDFFC7C3BDFFC7C3BDFFC1BEB7FF0000000000000000000000000000
        0000C7C3BDFFC7C3BDFFCDB590FFCDB590FFCDB590FFCDB590FFCDB590FFCDB5
        90FFCDB590FFCDB590FFC7C3BDFFC7C3BDFF0000000000000000000000000000
        0000C7C3BDFFC7C3BDFFCEB48EFFCEB48EFFCEB48EFFCEB48EFFCEB48EFFCEB4
        8EFFCEB48EFFCEB48EFFC7C3BDFFC7C3BDFF0000000000000000000000000000
        0000C7C3BDFFC7C3BDFFCDB590FFCDB590FFCDB590FFCDB590FFCDB590FFCDB5
        90FFCDB590FFCDB590FFC7C3BDFFC7C3BDFF0000000000000000000000000000
        0000C7C3BDFFC7C3BDFFCEB48EFFCEB48EFFCEB48EFFCEB48EFFCEB48EFFCEB4
        8EFFCEB48EFFCEB48EFFC7C3BDFFC7C3BDFF0000000000000000000000000000
        0000C7C3BDFFC7C3BDFFCDB590FFCDB590FFCDB590FFCDB590FFCDB590FFCDB5
        90FFCDB590FFCDB590FFC7C3BDFFC7C3BDFF0000000000000000000000000000
        0000C7C3BDFFC7C3BDFFCEB48EFFCEB48EFFCEB48EFFCEB48EFFCEB48EFFCEB4
        8EFFCEB48EFFCEB48EFFC7C3BDFFC7C3BDFF0000000000000000000000000000
        0000C7C3BDFFC7C3BDFFC3B39AFFC7C3BBFFC4B49CFFC7C1B7FFCDB590FFCDB5
        90FFCDB590FFCDB590FFC7C3BDFFC7C3BDFF0000000000000000000000000000
        0000C7C3BDFFC6C2BCFFBA8535FFC3B39AFFBB883BFFC3AF90FFCEB48EFFCEB4
        8EFFCEB48EFFCEB48EFFC7C3BDFFC7C3BDFF0000000000000000000000000000
        0000C7C3BDFFC4B49AFFBE9960FFBE9354FFBE995FFFBF9B65FFC7C3BDFFC7C3
        BDFFC7C3BDFFC7C3BDFFC7C3BDFFC7C3BDFF0000000000000000000000000000
        0000C7C3BDFFBFA06FFFC4B8A5FFBB8A3FFFC4B49BFFBE9658FFC7C3BDFFC7C3
        BDFFBCB9B0FFB1AFA3FFB1B0A2FFBBB6ACFF0000000000000000000000000000
        0000C7C3BDFFC7C3BDFFC7C3BDFFC7C3BDFFC7C3BDFFC7C3BDFFC7C3BDFFC7C3
        BDFFA7A697FFA6A595FFACA99CFF000000000000000000000000000000000000
        0000C7C3BDFFC7C3BDFFC7C3BDFFC7C3BDFFC7C3BDFFC7C3BDFFC7C3BDFFC7C3
        BDFFA6A595FFACA99CFF00000000000000000000000000000000000000000000
        0000C7C4BDFFC7C3BDFFC7C3BDFFC7C3BDFFC7C3BDFFC7C3BDFFC7C3BDFFC7C3
        BDFFACA99CFF0000000000000000000000000000000000000000000000000000
        000000000000EAE9E7FFEAE8E6FFEAE8E6FFEAE8E6FFEAE8E6FFEAE8E6FFEAE8
        E6FF000000000000000000000000000000000000000000000000}
      OnClick = btnRunDocClick
    end
    object seYear: TSpinEdit
      Left = 42
      Top = 5
      Width = 56
      Height = 22
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      MaxValue = 2100
      MinValue = 1900
      ParentFont = False
      TabOrder = 0
      Value = 2014
      OnChange = seYearChange
    end
    object dblkcbbDocument: TDBLookupComboBox
      Left = 164
      Top = 6
      Width = 221
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      KeyField = 'forecast_cost_index_id'
      ListField = 'name'
      ListSource = dsDocument
      TabOrder = 1
      OnCloseUp = seYearChange
    end
  end
  object pnlMain: TPanel
    Left = 0
    Top = 33
    Width = 418
    Height = 249
    Align = alClient
    BevelOuter = bvNone
    Caption = #1053#1077#1090' '#1076#1072#1085#1085#1099#1093
    TabOrder = 1
    object grMain: TJvDBGrid
      Left = 0
      Top = 0
      Width = 418
      Height = 249
      Align = alClient
      DataSource = dsMain
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnDrawColumnCell = grMainDrawColumnCell
      AutoAppend = False
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
          FieldName = 'MONTH'
          Title.Alignment = taCenter
          Title.Caption = #1052#1077#1089#1103#1094
          Width = 82
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'value'
          Title.Alignment = taCenter
          Title.Caption = #1047#1085#1072#1095#1077#1085#1080#1077
          Width = 108
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NAME'
          Title.Alignment = taCenter
          Title.Caption = #1044#1086#1082#1091#1084#1077#1085#1090
          Width = 209
          Visible = True
        end>
    end
  end
  object qrDocument: TFDQuery
    AfterScroll = qrDocumentAfterScroll
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FormatOptions.AssignedValues = [fvMapRules]
    FormatOptions.OwnMapRules = True
    FormatOptions.MapRules = <
      item
        SourceDataType = dtMemo
        TargetDataType = dtAnsiString
      end>
    UpdateOptions.AssignedValues = [uvCheckReadOnly]
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.UpdateTableName = 'smeta.forecast_cost_index'
    UpdateOptions.KeyFields = 'forecast_cost_index_id'
    SQL.Strings = (
      
        'SELECT 0 AS forecast_cost_index_id, "<'#1072#1082#1090#1091#1072#1083#1100#1085#1099#1077'>" AS name, null' +
        ' AS doc_id, null AS onDate '
      'UNION ALL'
      
        'select forecast_cost_index_id, name, doc_id, onDate from forecas' +
        't_cost_index'
      'ORDER BY onDate desc')
    Left = 140
    Top = 40
  end
  object dsDocument: TDataSource
    DataSet = qrDocument
    Left = 176
    Top = 40
  end
  object qrMain: TFDQuery
    BeforeOpen = qrMainBeforeOpen
    AfterOpen = qrMainAfterOpen
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FormatOptions.AssignedValues = [fvMapRules, fvFmtDisplayNumeric]
    FormatOptions.OwnMapRules = True
    FormatOptions.MapRules = <
      item
        SourceDataType = dtMemo
        TargetDataType = dtAnsiString
      end
      item
        SourceDataType = dtByteString
        TargetDataType = dtAnsiString
      end>
    FormatOptions.FmtDisplayNumeric = '###0.0000'
    SQL.Strings = (
      
        'SELECT CONCAT(forecast_cost_index_detail.forecast_cost_index_ID,' +
        ' forecast_cost_index_detail.onDate), '
      '  forecast_cost_index_detail.*,'
      'CONCAT(/*YEAR(forecast_cost_index_detail.onDate), " ", */('
      'case MONTH(forecast_cost_index_detail.onDate) '
      'WHEN 1 THEN "'#1071#1053#1042#1040#1056#1068'"'
      'WHEN 2 THEN "'#1060#1045#1042#1056#1040#1051#1068'"'
      'WHEN 3 THEN "'#1052#1040#1056#1058'"'
      'WHEN 4 THEN "'#1040#1055#1056#1045#1051#1068'"'
      'WHEN 5 THEN "'#1052#1040#1049'"'
      'WHEN 6 THEN "'#1048#1070#1053#1068'"'
      'WHEN 7 THEN "'#1048#1070#1051#1068'"'
      'WHEN 8 THEN "'#1040#1042#1043#1059#1057#1058'"'
      'WHEN 9 THEN "'#1057#1045#1053#1058#1071#1041#1056#1068'"'
      'WHEN 10 THEN "'#1054#1050#1058#1071#1041#1056#1068'"'
      'WHEN 11 THEN "'#1053#1054#1071#1041#1056#1068'"'
      'WHEN 12 THEN "'#1044#1045#1050#1040#1041#1056#1068'"'
      'END)) AS MONTH,'
      'forecast_cost_index.NAME  '
      'FROM forecast_cost_index_detail, forecast_cost_index'
      
        'WHERE forecast_cost_index_detail.forecast_cost_index_ID=forecast' +
        '_cost_index.forecast_cost_index_ID AND '
      '  YEAR(forecast_cost_index_detail.onDate) = :YEAR '
      '  AND ((forecast_cost_index_detail.forecast_cost_index_ID=:DOC) '
      
        '    OR ((:DOC=0 OR :DOC IS NULL) AND forecast_cost_index_detail.' +
        'forecast_cost_index_ID=('
      #9'  SELECT forecast_cost_index.forecast_cost_index_ID '
      #9'  FROM forecast_cost_index, forecast_cost_index_detail '
      
        #9'  WHERE YEAR(forecast_cost_index_detail.onDate) = :YEAR AND for' +
        'ecast_cost_index_detail.forecast_cost_index_ID=forecast_cost_ind' +
        'ex.forecast_cost_index_ID'
      #9'  ORDER BY forecast_cost_index.onDate DESC'
      #9'  LIMIT 1)))'
      'ORDER BY onDate')
    Left = 204
    Top = 120
    ParamData = <
      item
        Name = 'YEAR'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'DOC'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object dsMain: TDataSource
    DataSet = qrMain
    Left = 240
    Top = 120
  end
end