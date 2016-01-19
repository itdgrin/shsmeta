object fSmReportMain: TfSmReportMain
  Left = 0
  Top = 0
  ActiveControl = grReport
  Caption = #1055#1077#1095#1072#1090#1100' '#1086#1090#1095#1077#1090#1086#1074
  ClientHeight = 282
  ClientWidth = 384
  Color = clBtnFace
  Constraints.MinHeight = 320
  Constraints.MinWidth = 400
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
  object splCategory: TSplitter
    Left = 0
    Top = 80
    Width = 384
    Height = 3
    Cursor = crVSplit
    Align = alTop
    ExplicitLeft = -24
    ExplicitTop = 175
    ExplicitWidth = 716
  end
  object splReport: TSplitter
    Left = 0
    Top = 163
    Width = 384
    Height = 3
    Cursor = crVSplit
    Align = alTop
    ExplicitTop = 341
    ExplicitWidth = 261
  end
  object lblParams: TLabel
    AlignWithMargins = True
    Left = 3
    Top = 169
    Width = 378
    Height = 13
    Align = alTop
    Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1086#1090#1095#1077#1090#1072':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ExplicitWidth = 100
  end
  object pnlCategory: TPanel
    Left = 0
    Top = 0
    Width = 384
    Height = 80
    Align = alTop
    BevelOuter = bvNone
    Constraints.MinHeight = 80
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object lblCategory: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 378
      Height = 13
      Align = alTop
      Caption = #1057#1087#1080#1089#1086#1082' '#1088#1072#1079#1076#1077#1083#1086#1074':'
      ExplicitWidth = 91
    end
    object tvCategory: TJvDBTreeView
      Left = 0
      Top = 19
      Width = 384
      Height = 61
      DataSource = dsTreeCategory
      MasterField = 'REPORT_CATEGORY_ID'
      DetailField = 'PARENT_ID'
      ItemField = 'REPORT_CATEGORY_NAME'
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
      PopupMenu = pmCategory
      ParentFont = False
      RowSelect = True
      Mirror = False
    end
  end
  object pnlReport: TPanel
    Left = 0
    Top = 83
    Width = 384
    Height = 80
    Align = alTop
    BevelOuter = bvNone
    Constraints.MinHeight = 80
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object lblReport: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 378
      Height = 13
      Align = alTop
      Caption = #1057#1087#1080#1089#1086#1082' '#1086#1090#1095#1077#1090#1086#1074':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ExplicitWidth = 85
    end
    object grReport: TJvDBGrid
      Left = 0
      Top = 19
      Width = 384
      Height = 61
      Align = alClient
      DataSource = dsReport
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      ParentFont = False
      PopupMenu = pmReport
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      ScrollBars = ssVertical
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
          FieldName = 'REPORT_CODE'
          Title.Alignment = taCenter
          Title.Caption = #1050#1086#1076
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'REPORT_NAME'
          Title.Alignment = taCenter
          Title.Caption = #1053#1072#1079#1074#1072#1085#1080#1077
          Width = 367
          Visible = True
        end>
    end
  end
  object pnlBott: TPanel
    Left = 0
    Top = 251
    Width = 384
    Height = 31
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    object btnPreview: TBitBtn
      Left = 3
      Top = 3
      Width = 118
      Height = 25
      Caption = #1055#1077#1095#1072#1090#1100' '#1086#1090#1095#1077#1090#1072
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = btnPreviewClick
    end
  end
  object sbParams: TScrollBox
    Left = 0
    Top = 185
    Width = 384
    Height = 66
    HorzScrollBar.Visible = False
    Align = alClient
    BorderStyle = bsNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object dsTreeCategory: TDataSource
    DataSet = qrTreeCategory
    Left = 30
    Top = 50
  end
  object qrTreeCategory: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FetchOptions.AssignedValues = [evCache]
    FetchOptions.Cache = [fiBlobs, fiMeta]
    UpdateOptions.UpdateTableName = 'smeta.report_category'
    SQL.Strings = (
      'SELECT *'
      'FROM report_category'
      'ORDER BY REPORT_CATEGORY_NAME')
    Left = 30
    Top = 2
  end
  object FormStorage: TJvFormStorage
    AppStorage = FormMain.AppIni
    AppStoragePath = '%FORM_NAME%\'
    Options = [fpSize]
    StoredProps.Strings = (
      'pnlCategory.Height'
      'pnlReport.Height')
    StoredValues = <>
    Left = 168
    Top = 26
  end
  object pmCategory: TPopupMenu
    Images = DM.ilIcons_16x16
    OnPopup = pmCategoryPopup
    Left = 96
    Top = 32
    object mCategoryAdd: TMenuItem
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1088#1072#1079#1076#1077#1083
      ImageIndex = 41
      OnClick = mCategoryAddClick
    end
    object mCategoryAddSub: TMenuItem
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1087#1086#1076#1088#1072#1079#1076#1077#1083
      ImageIndex = 42
      OnClick = mCategoryAddSubClick
    end
    object mCategoryEditName: TMenuItem
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1085#1072#1079#1074#1072#1085#1080#1077
      ImageIndex = 44
      OnClick = mCategoryEditNameClick
    end
    object mCategoryDel: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100
      ImageIndex = 38
      OnClick = mCategoryDelClick
    end
  end
  object qrReport: TFDQuery
    AfterOpen = qrReportAfterScroll
    AfterScroll = qrReportAfterScroll
    MasterSource = dsTreeCategory
    MasterFields = 'REPORT_CATEGORY_ID'
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FetchOptions.AssignedValues = [evCache]
    FetchOptions.Cache = [fiBlobs, fiMeta]
    UpdateOptions.UpdateTableName = 'smeta.report'
    SQL.Strings = (
      'SELECT *'
      'FROM report'
      'WHERE REPORT_CATEGORY_ID = :REPORT_CATEGORY_ID'
      'ORDER BY REPORT_NAME')
    Left = 30
    Top = 98
    ParamData = <
      item
        Name = 'REPORT_CATEGORY_ID'
        ParamType = ptInput
      end>
  end
  object dsReport: TDataSource
    DataSet = qrReport
    Left = 30
    Top = 146
  end
  object pmReport: TPopupMenu
    Images = DM.ilIcons_16x16
    OnPopup = pmReportPopup
    Left = 96
    Top = 124
    object mReportAdd: TMenuItem
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      ImageIndex = 39
      OnClick = mReportAddClick
    end
    object mReportCopy: TMenuItem
      Caption = #1057#1086#1079#1076#1072#1090#1100' '#1082#1086#1087#1080#1102
      Enabled = False
      ImageIndex = 35
      OnClick = mReportCopyClick
    end
    object mReportEdit: TMenuItem
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1096#1072#1073#1083#1086#1085
      Enabled = False
      ImageIndex = 45
      OnClick = mReportEditClick
    end
    object mReportEditParams: TMenuItem
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1074#1093#1086#1076#1085#1099#1093' '#1087#1072#1088#1072#1084#1077#1090#1088#1086#1074
      ImageIndex = 15
      OnClick = mReportEditParamsClick
    end
    object mReportDel: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100
      ImageIndex = 38
      OnClick = mReportDelClick
    end
  end
  object frxReport: TfrxReport
    Version = '4.13.2'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42385.845885347190000000
    ReportOptions.LastChange = 42388.955177916700000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 224
    Top = 27
    Datasets = <
      item
        DataSet = frxDS
        DataSetName = 'DS'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      Orientation = poLandscape
      PaperWidth = 279.400000000000000000
      PaperHeight = 215.900000000000000000
      PaperSize = 1
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object MasterData1: TfrxMasterData
        Height = 18.897650000000000000
        Top = 336.378170000000000000
        Width = 980.410081999999900000
        DataSet = frxDS
        DataSetName = 'DS'
        RowCount = 0
        Stretched = True
        object Memo13: TfrxMemoView
          Width = 309.921460000000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smActualHeight
          DataField = 'NAME'
          DataSet = frxDS
          DataSetName = 'DS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[DS."NAME"]')
          ParentFont = False
        end
        object DSTOTAL_STOIM_SMR: TfrxMemoView
          Left = 309.921460000000000000
          Width = 94.488188980000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataField = 'TOTAL_STOIM_SMR'
          DataSet = frxDS
          DataSetName = 'DS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[DS."TOTAL_STOIM_SMR"]')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          Left = 404.409710000000000000
          Width = 94.488188980000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataField = 'OTHER'
          DataSet = frxDS
          DataSetName = 'DS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[DS."OTHER"]')
          ParentFont = False
        end
        object DSTOTAL_STAT: TfrxMemoView
          Left = 498.897960000000000000
          Width = 102.047248980000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataField = 'TOTAL_STAT'
          DataSet = frxDS
          DataSetName = 'DS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[DS."TOTAL_STAT"]')
          ParentFont = False
        end
        object DSTOTAL_AND_DEBET_NAL: TfrxMemoView
          Left = 600.945270000000000000
          Width = 94.488188980000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataField = 'TOTAL_AND_DEBET_NAL'
          DataSet = frxDS
          DataSetName = 'DS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[DS."TOTAL_AND_DEBET_NAL"]')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 695.433520000000000000
          Width = 94.488188976378000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataField = 'NDS'
          DataSet = frxDS
          DataSetName = 'DS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[DS."NDS"]')
          ParentFont = False
        end
        object DSTOTAL_WORK: TfrxMemoView
          Left = 789.921770000000000000
          Width = 94.488188980000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataField = 'TOTAL_WORK'
          DataSet = frxDS
          DataSetName = 'DS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[DS."TOTAL_WORK"]')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 884.410020000000000000
          Width = 94.488188980000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataField = 'STOIM'
          DataSet = frxDS
          DataSetName = 'DS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[DS."STOIM"]')
          ParentFont = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        Height = 18.897650000000000000
        Top = 234.330860000000000000
        Width = 980.410081999999900000
        Condition = 'DS."TYPE_ACT"'
        StartNewPage = True
        object DSFOREMAN_ID: TfrxMemoView
          Width = 978.898270000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Color = cl3DLight
          DataSet = frxDS
          DataSetName = 'DS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            #1058#1080#1087' '#1072#1082#1090#1072': [DS."TYPE_ACT"]')
          ParentFont = False
        end
      end
      object GroupHeader2: TfrxGroupHeader
        Height = 37.795300000000000000
        Top = 275.905690000000000000
        Width = 980.410081999999900000
        Condition = 'DS."OBJ_ID"'
        object DSOBJ_ID: TfrxMemoView
          Width = 978.898270000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataSet = frxDS
          DataSetName = 'DS'
          Memo.UTF8W = (
            #1054#1073#1098#1077#1082#1090': [DS."OBJ_NAME"]')
        end
        object Memo15: TfrxMemoView
          Top = 18.897650000000000000
          Width = 978.898270000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Memo.UTF8W = (
            
              #1047#1072#1082#1072#1079#1095#1080#1082': [DS."FOREMAN_FULL"] '#1044#1086#1075#1086#1074#1086#1088' '#8470': [DS."NUM_DOG"] '#1086#1090' [DS."' +
              'DATE_DOG"]')
        end
      end
      object ReportTitle1: TfrxReportTitle
        Height = 75.590600000000000000
        Top = 18.897650000000000000
        Width = 980.410081999999900000
        object Memo2: TfrxMemoView
          Width = 491.338900000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            '[DS."ORGANIZATION_NAME"]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Top = 18.897650000000000000
          Width = 491.338900000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            #1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080)
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Top = 37.795300000000000000
          Width = 978.898270000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DisplayFormat.FormatStr = 'MMMM yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Times New Roman'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            #1056#1045#1045#1057#1058#1056' '#1042#1067#1055#1054#1051#1053#1045#1053#1053#1067#1061' '#1056#1040#1041#1054#1058' '#1047#1040' [DS."DATE"]')
          ParentFont = False
        end
      end
      object PageHeader1: TfrxPageHeader
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Times New Roman'
        Font.Style = []
        Height = 56.692950000000000000
        ParentFont = False
        Top = 117.165430000000000000
        Width = 980.410081999999900000
        object Memo5: TfrxMemoView
          Width = 309.921460000000000000
          Height = 56.692950000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo6: TfrxMemoView
          Left = 309.921460000000000000
          Width = 94.488188980000000000
          Height = 56.692950000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            #1042#1057#1045#1043#1054' '#1057#1052#1056)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo7: TfrxMemoView
          Left = 404.409710000000000000
          Width = 94.488188980000000000
          Height = 56.692950000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            #1048#1058#1054#1043#1054' '#1087#1088#1086#1095#1080#1093)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo8: TfrxMemoView
          Left = 498.897960000000000000
          Width = 102.047248980000000000
          Height = 56.692950000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            #1054#1073#1098#1077#1084' '#1088#1072#1073#1086#1090' '#1076#1083#1103' '#1089#1090#1072#1090#1080#1089#1090#1080#1095#1077#1089#1082#1086#1081' '#1086#1090#1095#1077#1090#1085#1086#1089#1090#1080)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo9: TfrxMemoView
          Left = 600.945270000000000000
          Width = 94.488188980000000000
          Height = 56.692950000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            #1048#1058#1054#1043#1054' '#1073#1077#1079' '#1053#1044#1057)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo10: TfrxMemoView
          Left = 695.433520000000000000
          Width = 94.488188980000000000
          Height = 56.692950000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            #1053#1044#1057)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo11: TfrxMemoView
          Left = 789.921770000000000000
          Width = 94.488188980000000000
          Height = 56.692950000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            #1048#1058#1054#1043#1054' '#1089' '#1053#1044#1057)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo12: TfrxMemoView
          Left = 884.410020000000000000
          Width = 94.488188980000000000
          Height = 56.692950000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            #1042#1057#1045#1043#1054' '#1050' '#1054#1055#1051#1040#1058#1045)
          ParentFont = False
          VAlign = vaCenter
        end
      end
    end
  end
  object frxDS: TfrxDBDataset
    UserName = 'DS'
    CloseDataSource = True
    DataSet = qrReportData
    BCDToCurrency = False
    Left = 264
    Top = 27
  end
  object frxPDF: TfrxPDFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    PrintOptimized = False
    Outline = False
    Background = False
    HTMLTags = True
    Quality = 95
    Author = 'FastReport'
    Subject = 'FastReport PDF export'
    ProtectionFlags = [ePrint, eModify, eCopy, eAnnot]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = False
    PrintScaling = False
    Left = 296
    Top = 27
  end
  object frxRTF: TfrxRTFExport
    FileName = 'C:\Users\R654\Desktop\rst_foreman.rtf'
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    CreationTime = 42387.894452951390000000
    DataOnly = False
    PictureType = gpPNG
    OpenAfterExport = True
    Wysiwyg = True
    Creator = 'FastReport'
    SuppressPageHeadersFooters = False
    HeaderFooterMode = hfText
    AutoSize = False
    Left = 328
    Top = 27
  end
  object frxCSV: TfrxCSVExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    CreationTime = 42385.855946145840000000
    DataOnly = False
    Separator = ';'
    OEMCodepage = False
    NoSysSymbols = True
    ForcedQuotes = False
    Left = 360
    Top = 27
  end
  object qrReportData: TFDQuery
    BeforeOpen = qrReportDataBeforeOpen
    MasterFields = 'REPORT_CATEGORY_ID'
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FetchOptions.AssignedValues = [evCache]
    FetchOptions.Cache = [fiBlobs, fiMeta]
    FormatOptions.AssignedValues = [fvSE2Null, fvDefaultParamDataType]
    FormatOptions.StrsEmpty2Null = True
    FormatOptions.DefaultParamDataType = ftVariant
    SQL.Strings = (
      'SELECT s.SM_ID, s.FOREMAN_ID, s.OBJ_ID, s.`TYPE_ACT`,'
      '  s.DATE,'
      '  s.NAME,'
      '  o.`FULL_NAME` AS OBJ_NAME,'
      '  o.`DATE_DOG`,'
      '  o.`NUM_DOG`,'
      '  CONCAT(cl.`NAME`, " (", cl.`FULL_NAME`, ")")  AS CUST_NAME,'
      '  CONCAT('
      '    IFNULL(f.`foreman_first_name`, ""), " ", '
      '    IFNULL(f.`foreman_name`, ""), " ", '
      '    IFNULL(f.`foreman_second_name`, "")) AS FOREMAN_FULL,'
      '  IFNULL(:ORGANIZATION_NAME, "") AS ORGANIZATION_NAME,'
      
        '  ROUND( SUM(IFNULL(d.TOTAL_STOIM_SMRF, d.TOTAL_STOIM_SMR)), rs.' +
        'round_RATE) AS TOTAL_STOIM_SMR,'
      
        '  ROUND( SUM(IFNULL(d.OTHERF, d.OTHER)), rs.round_RATE) AS OTHER' +
        ','
      
        '  ROUND( SUM(IFNULL(d.TOTAL_STATF, d.TOTAL_STAT)), rs.round_RATE' +
        ') AS TOTAL_STAT,'
      
        '  ROUND( SUM(IFNULL(d.TOTAL_AND_DEBET_NALF, d.TOTAL_AND_DEBET_NA' +
        'L)), rs.round_RATE) AS TOTAL_AND_DEBET_NAL,'
      '  ROUND( SUM(IFNULL(d.NDSF, d.NDS)), rs.round_RATE) AS NDS,'
      
        '  ROUND( SUM(IFNULL(d.TOTAL_WORKF, d.TOTAL_WORK)), rs.round_RATE' +
        ') AS TOTAL_WORK,'
      '  ROUND( SUM(IFNULL(d.STOIMF, d.STOIM)), rs.round_RATE) AS STOIM'
      'FROM `round_setup` rs, smetasourcedata s'
      'LEFT JOIN summary_calculation d ON d.SM_ID IN'
      '  (SELECT SM_ID'
      '   FROM smetasourcedata '
      '   WHERE DELETED=0 AND'
      '    ((smetasourcedata.SM_ID = s.SM_ID) OR'
      '           (smetasourcedata.PARENT_ID = s.SM_ID) OR '
      '           (smetasourcedata.PARENT_ID IN ('
      '             SELECT SM_ID'
      '             FROM smetasourcedata'
      '             WHERE PARENT_ID = s.SM_ID AND DELETED=0)))'
      '  )'
      'LEFT JOIN `objcards` o ON o.`OBJ_ID` = s.`OBJ_ID`'
      'LEFT JOIN `clients` cl ON cl.`CLIENT_ID` = o.`CUST_ID` '
      'LEFT JOIN `foreman` f ON f.`foreman_id` = s.`FOREMAN_ID`'
      'WHERE s.SM_TYPE=2'
      '  AND ((:OBJECT IS NULL) OR (s.OBJ_ID=:OBJECT))'
      
        '  AND ((:MONTH_YEAR IS NULL) OR (MONTH(s.DATE)=MONTH(:MONTH_YEAR' +
        ') AND YEAR(s.DATE)=YEAR(:MONTH_YEAR)))'
      '  AND ((:FOREMAN IS NULL) OR (s.`FOREMAN_ID` = :FOREMAN))'
      '  AND ((:TYPE_ACT IS NULL) OR (s.`TYPE_ACT` = :TYPE_ACT))'
      '  AND ((:CUST IS NULL) OR (o.CUST_ID = :CUST))'
      '  AND s.DELETED=0'
      '  AND s.ACT=1'
      'GROUP BY s.SM_ID '
      'ORDER BY s.FOREMAN_ID, s.OBJ_ID, s.`TYPE_ACT`, s.`DATE`')
    Left = 182
    Top = 106
    ParamData = <
      item
        Name = 'ORGANIZATION_NAME'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'OBJECT'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'MONTH_YEAR'
        DataType = ftDate
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'FOREMAN'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'TYPE_ACT'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'CUST'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
end
