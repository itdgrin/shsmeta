object fTariffDict: TfTariffDict
  Left = 0
  Top = 0
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1090#1072#1088#1080#1092#1086#1074
  ClientHeight = 430
  ClientWidth = 537
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object pgc: TPageControl
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 531
    Height = 391
    ActivePage = ts2
    Align = alClient
    MultiLine = True
    Style = tsButtons
    TabOrder = 0
    TabWidth = 140
    OnChange = pgcChange
    ExplicitLeft = 8
    ExplicitTop = 8
    ExplicitWidth = 436
    ExplicitHeight = 150
    object ts1: TTabSheet
      Caption = #1058#1072#1088#1080#1092#1099' '#1087#1086' '#1079#1072#1088#1087#1083#1072#1090#1077
      ExplicitLeft = 0
      ExplicitTop = 31
      ExplicitHeight = 346
      object spl1: TSplitter
        Left = 180
        Top = 62
        Height = 298
        ExplicitLeft = 248
        ExplicitTop = 72
        ExplicitHeight = 100
      end
      object pnlLeft: TPanel
        Left = 0
        Top = 62
        Width = 180
        Height = 298
        Align = alLeft
        Caption = 'pnlLeft'
        Constraints.MinWidth = 180
        TabOrder = 1
        ExplicitTop = 0
        ExplicitHeight = 360
        object JvDBGrid1: TJvDBGrid
          Left = 1
          Top = 1
          Width = 178
          Height = 296
          Align = alClient
          DataSource = dsCategory
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
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
              FieldName = 'VALUE'
              Title.Alignment = taCenter
              Title.Caption = #1056#1072#1079#1088#1103#1076
              Width = 50
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'COEF'
              Title.Alignment = taCenter
              Title.Caption = #1050'-'#1092
              Width = 46
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'SUMMA'
              Title.Alignment = taCenter
              Title.Caption = #1057#1091#1084#1084#1072
              Width = 63
              Visible = True
            end>
        end
      end
      object pnlClient: TPanel
        Left = 183
        Top = 62
        Width = 340
        Height = 298
        Align = alClient
        Caption = 'pnlClient'
        TabOrder = 2
        ExplicitLeft = 190
        ExplicitTop = 230
        ExplicitWidth = 219
        ExplicitHeight = 124
        object JvDBGrid2: TJvDBGrid
          Left = 1
          Top = 1
          Width = 338
          Height = 296
          Align = alClient
          DataSource = dsStavka
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          OnDrawColumnCell = JvDBGrid2DrawColumnCell
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
              FieldName = 'MONTH_YEAR'
              Title.Alignment = taCenter
              Title.Caption = #1052#1077#1089#1103#1094
              Width = 37
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'STAVKA_M_RAB'
              Title.Alignment = taCenter
              Title.Caption = #1075'. '#1052#1080#1085#1089#1082
              Width = 37
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'STAVKA_RB_RAB'
              Title.Alignment = taCenter
              Title.Caption = #1041#1088#1077#1089#1090#1089#1082#1072#1103
              Width = 37
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'STAVKA_RB_RAB'
              Title.Alignment = taCenter
              Title.Caption = #1042#1080#1090#1077#1073#1089#1082#1072#1103
              Width = 37
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'STAVKA_RB_RAB'
              Title.Alignment = taCenter
              Title.Caption = #1043#1088#1086#1076#1085#1077#1085#1089#1082#1072#1103
              Width = 37
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'STAVKA_RB_RAB'
              Title.Alignment = taCenter
              Title.Caption = #1043#1086#1084#1077#1083#1100#1089#1082#1072#1103
              Width = 37
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'STAVKA_RB_RAB'
              Title.Alignment = taCenter
              Title.Caption = #1052#1080#1085#1089#1082#1072#1103
              Width = 37
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'STAVKA_RB_RAB'
              Title.Alignment = taCenter
              Title.Caption = #1052#1086#1075#1080#1083#1077#1074#1089#1082#1072#1103
              Width = 55
              Visible = True
            end>
        end
      end
      object pnlTop: TPanel
        Left = 0
        Top = 0
        Width = 523
        Height = 62
        Align = alTop
        TabOrder = 0
        ExplicitTop = -5
        object lbl1: TLabel
          Left = 8
          Top = 8
          Width = 53
          Height = 13
          Caption = #1090#1072#1088#1080#1074#1099' '#1085#1072
        end
        object lbl2: TLabel
          Left = 8
          Top = 35
          Width = 166
          Height = 13
          Caption = #1087#1086' '#1088#1077#1089#1087#1091#1073#1083#1080#1082#1077' '#1089#1090#1072#1074#1082#1072' 4 '#1088#1072#1079#1088#1103#1076#1072
        end
        object dbedtInDate: TDBEdit
          Left = 180
          Top = 8
          Width = 121
          Height = 21
          DataField = 'MONTH_YEAR'
          DataSource = dsStavka
          TabOrder = 0
        end
        object dbedtSTAVKA_M_RAB: TDBEdit
          Left = 180
          Top = 35
          Width = 121
          Height = 21
          DataField = 'STAVKA_M_RAB'
          DataSource = dsStavka
          TabOrder = 1
        end
      end
    end
    object ts2: TTabSheet
      Caption = #1057#1090#1072#1090#1080#1089#1090#1080#1095#1077#1089#1082#1080#1077' '#1080#1085#1076#1077#1082#1089#1099
      ImageIndex = 1
      ExplicitHeight = 393
      object pnl1: TPanel
        Left = 0
        Top = 0
        Width = 523
        Height = 41
        Align = alTop
        Caption = 'pnl1'
        TabOrder = 0
        ExplicitLeft = 144
        ExplicitTop = 96
        ExplicitWidth = 185
      end
      object pnl2: TPanel
        Left = 0
        Top = 41
        Width = 523
        Height = 319
        Align = alClient
        Caption = 'pnl2'
        TabOrder = 1
        ExplicitLeft = 160
        ExplicitTop = 144
        ExplicitWidth = 185
        ExplicitHeight = 41
        object JvDBGrid3: TJvDBGrid
          Left = 1
          Top = 1
          Width = 521
          Height = 317
          Align = alClient
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          OnDrawColumnCell = JvDBGrid2DrawColumnCell
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
              Width = 310
              Visible = True
            end
            item
              Expanded = False
              Width = 39
              Visible = True
            end
            item
              Expanded = False
              Width = 44
              Visible = True
            end
            item
              Expanded = False
              Width = 50
              Visible = True
            end
            item
              Expanded = False
              Width = 57
              Visible = True
            end>
        end
      end
    end
  end
  object pnlBott: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 400
    Width = 531
    Height = 27
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      531
      27)
    object btnClose: TBitBtn
      Left = 452
      Top = 0
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #1047#1072#1082#1088#1099#1090#1100
      TabOrder = 0
      OnClick = btnCloseClick
    end
  end
  object qrCategory: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FormatOptions.AssignedValues = [fvDefaultParamDataType, fvFmtDisplayNumeric]
    FormatOptions.DefaultParamDataType = ftBCD
    FormatOptions.FmtDisplayNumeric = '### ### ### ### ### ### ##0.####'
    SQL.Strings = (
      'SELECT `CATEGORY_ID`,'
      '       `VALUE`,'
      '       `COEF`,'
      '       ROUND(`COEF` * :IN_STAVKA) AS SUMMA,'
      '       `DATE_BEG`'
      'FROM `category`'
      'WHERE `DATE_BEG` ='
      '      ('
      '        SELECT MAX(`category`.`DATE_BEG`)'
      '        FROM `category`'
      '        WHERE `category`.`DATE_BEG` <= :IN_DATE'
      '        LIMIT 1'
      '      )'
      'ORDER BY `VALUE`')
    Left = 119
    Top = 342
    ParamData = <
      item
        Name = 'IN_STAVKA'
        DataType = ftBCD
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'IN_DATE'
        DataType = ftDate
        ParamType = ptInput
        Value = Null
      end>
  end
  object dsCategory: TDataSource
    DataSet = qrCategory
    Left = 152
    Top = 342
  end
  object qrStavka: TFDQuery
    AfterScroll = qrStavkaAfterScroll
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FormatOptions.AssignedValues = [fvDefaultParamDataType, fvFmtDisplayNumeric]
    FormatOptions.DefaultParamDataType = ftBCD
    FormatOptions.FmtDisplayNumeric = '### ### ### ### ### ### ##0.####'
    SQL.Strings = (
      'SELECT '
      '  `STAVKA_ID`,'
      '  `YEAR`,'
      '  `MONAT`,'
      '  `STAVKA_RB_RAB`,'
      '  `STAVKA_RB_MACH`,'
      '  `STAVKA_M_RAB`,'
      '  `STAVKA_M_MACH`,'
      '  CONVERT(CONCAT(`YEAR`,'#39'-'#39',`MONAT`,'#39'-01'#39'), DATE) AS MONTH_YEAR'
      'FROM '
      '  `stavka`'
      'ORDER BY `YEAR` DESC, `MONAT` DESC  ')
    Left = 463
    Top = 342
    object qrStavkaSTAVKA_ID: TWordField
      AutoGenerateValue = arAutoInc
      FieldName = 'STAVKA_ID'
      Origin = 'STAVKA_ID'
      ProviderFlags = [pfInWhere, pfInKey]
      DisplayFormat = '### ### ### ### ### ### ##0.####'
    end
    object qrStavkaYEAR: TWordField
      AutoGenerateValue = arDefault
      FieldName = 'YEAR'
      Origin = 'YEAR'
      DisplayFormat = '### ### ### ### ### ### ##0.####'
    end
    object qrStavkaMONAT: TWordField
      AutoGenerateValue = arDefault
      FieldName = 'MONAT'
      Origin = 'MONAT'
      DisplayFormat = '### ### ### ### ### ### ##0.####'
    end
    object qrStavkaSTAVKA_RB_RAB: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'STAVKA_RB_RAB'
      Origin = 'STAVKA_RB_RAB'
      DisplayFormat = '### ### ### ### ### ### ##0.####'
    end
    object qrStavkaSTAVKA_RB_MACH: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'STAVKA_RB_MACH'
      Origin = 'STAVKA_RB_MACH'
      DisplayFormat = '### ### ### ### ### ### ##0.####'
    end
    object qrStavkaSTAVKA_M_RAB: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'STAVKA_M_RAB'
      Origin = 'STAVKA_M_RAB'
      DisplayFormat = '### ### ### ### ### ### ##0.####'
    end
    object qrStavkaSTAVKA_M_MACH: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'STAVKA_M_MACH'
      Origin = 'STAVKA_M_MACH'
      DisplayFormat = '### ### ### ### ### ### ##0.####'
    end
    object qrStavkaMONTH_YEAR: TDateField
      AutoGenerateValue = arDefault
      FieldName = 'MONTH_YEAR'
      Origin = 'MONTH_YEAR'
      ProviderFlags = []
      ReadOnly = True
      DisplayFormat = 'yyyy MMMM'
    end
  end
  object dsStavka: TDataSource
    DataSet = qrStavka
    Left = 496
    Top = 342
  end
end
