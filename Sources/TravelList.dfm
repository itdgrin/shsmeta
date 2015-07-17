object fTravelList: TfTravelList
  Left = 0
  Top = 0
  Caption = #1056#1072#1089#1095#1077#1090
  ClientHeight = 282
  ClientWidth = 468
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
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 468
    Height = 32
    Align = alTop
    TabOrder = 0
    DesignSize = (
      468
      32)
    object lbl1: TLabel
      Left = 8
      Top = 8
      Width = 39
      Height = 13
      Caption = #1054#1073#1098#1077#1082#1090
    end
    object dblkcbbNAME: TDBLookupComboBox
      Left = 69
      Top = 5
      Width = 390
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      KeyField = 'OBJ_ID'
      ListField = 'NAME'
      ListSource = dsObject
      TabOrder = 0
    end
  end
  object pnl1: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 244
    Width = 462
    Height = 35
    Align = alBottom
    TabOrder = 2
    object dbnvgr1: TDBNavigator
      Left = 5
      Top = 4
      Width = 220
      Height = 25
      DataSource = dsTravel
      Hints.Strings = (
        #1053#1072' '#1087#1077#1088#1074#1091#1102' '#1079#1072#1087#1080#1089#1100
        #1055#1088#1077#1076#1099#1076#1091#1097#1072#1103' '#1079#1072#1087#1080#1089#1100
        #1057#1083#1077#1076#1091#1102#1097#1072#1103' '#1079#1072#1087#1080#1089#1100
        #1053#1072' '#1087#1086#1089#1083#1077#1076#1085#1102#1102' '#1079#1072#1087#1080#1089#1100
        #1053#1086#1074#1072#1103' '#1079#1072#1087#1080#1089#1100
        #1059#1076#1072#1083#1080#1090#1100' '#1079#1072#1087#1080#1089#1100
        #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1079#1072#1087#1080#1089#1100
        #1057#1086#1093#1088#1072#1085#1080#1090#1100
        #1054#1090#1084#1077#1085#1080#1090#1100
        #1054#1073#1085#1086#1074#1080#1090#1100
        'Apply updates'
        'Cancel updates')
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      TabStop = True
    end
  end
  object pgc1: TPageControl
    Left = 0
    Top = 32
    Width = 468
    Height = 209
    ActivePage = ts1
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnChange = pgc1Change
    object ts1: TTabSheet
      Caption = #1050#1086#1084#1072#1085#1076#1080#1088#1086#1074#1086#1095#1085#1099#1077
      object spl1: TSplitter
        Left = 0
        Top = 97
        Width = 460
        Height = 3
        Cursor = crVSplit
        Align = alTop
        ExplicitWidth = 84
      end
      object grTravel: TJvDBGrid
        Left = 0
        Top = 0
        Width = 460
        Height = 97
        Align = alTop
        DataSource = dsTravel
        DrawingStyle = gdsClassic
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgTitleClick, dgTitleHotTrack]
        ParentFont = False
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnDrawColumnCell = grTravelDrawColumnCell
        IniStorage = FormStorage
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
            FieldName = 'travel_id'
            Title.Alignment = taCenter
            Title.Caption = #8470
            Width = 111
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NAME'
            Title.Alignment = taCenter
            Title.Caption = #1040#1082#1090'/'#1057#1084#1077#1090#1072
            Width = 111
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'OnDate'
            Title.Alignment = taCenter
            Title.Caption = #1044#1072#1090#1072
            Width = 111
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'summ'
            Title.Alignment = taCenter
            Title.Caption = #1057#1091#1084#1084#1072
            Width = 107
            Visible = True
          end>
      end
      object pnlTravel: TPanel
        Left = 0
        Top = 100
        Width = 460
        Height = 81
        Align = alClient
        BevelOuter = bvNone
        Caption = #1053#1077#1090' '#1076#1072#1085#1085#1099#1093
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
    end
    object ts2: TTabSheet
      Caption = #1056#1072#1079#1098#1077#1079#1076#1085#1086#1081' '#1093#1072#1088#1072#1082#1090#1077#1088' '#1088#1072#1073#1086#1090
      ImageIndex = 1
      object spl2: TSplitter
        Left = 0
        Top = 97
        Width = 460
        Height = 3
        Cursor = crVSplit
        Align = alTop
        ExplicitWidth = 84
      end
      object grTravelWork: TJvDBGrid
        Left = 0
        Top = 0
        Width = 460
        Height = 97
        Align = alTop
        DataSource = dsTravelWork
        DrawingStyle = gdsClassic
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgTitleClick, dgTitleHotTrack]
        ParentFont = False
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnDrawColumnCell = grTravelWorkDrawColumnCell
        IniStorage = FormStorage
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
            FieldName = 'travel_work_id'
            Title.Alignment = taCenter
            Title.Caption = #8470
            Width = 111
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NAME'
            Title.Alignment = taCenter
            Title.Caption = #1040#1082#1090'/'#1057#1084#1077#1090#1072
            Width = 111
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'OnDate'
            Title.Alignment = taCenter
            Title.Caption = #1044#1072#1090#1072
            Width = 111
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'summ'
            Title.Alignment = taCenter
            Title.Caption = #1057#1091#1084#1084#1072
            Width = 107
            Visible = True
          end>
      end
      object pnlTravelWork: TPanel
        Left = 0
        Top = 100
        Width = 460
        Height = 81
        Align = alClient
        BevelOuter = bvNone
        Caption = #1053#1077#1090' '#1076#1072#1085#1085#1099#1093
        TabOrder = 1
      end
    end
    object ts3: TTabSheet
      Caption = #1055#1077#1088#1077#1074#1086#1079#1082#1072' '#1088#1072#1073#1086#1095#1080#1093
      ImageIndex = 2
      object spl3: TSplitter
        Left = 0
        Top = 97
        Width = 460
        Height = 3
        Cursor = crVSplit
        Align = alTop
        ExplicitWidth = 84
      end
      object grWorkerDepartment: TJvDBGrid
        Left = 0
        Top = 0
        Width = 460
        Height = 97
        Align = alTop
        DataSource = dsWorkerDepartment
        DrawingStyle = gdsClassic
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgTitleClick, dgTitleHotTrack]
        ParentFont = False
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnDrawColumnCell = grWorkerDepartmentDrawColumnCell
        IniStorage = FormStorage
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
            FieldName = 'worker_department_id'
            Title.Alignment = taCenter
            Title.Caption = #8470
            Width = 111
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NAME'
            Title.Alignment = taCenter
            Title.Caption = #1040#1082#1090'/'#1057#1084#1077#1090#1072
            Width = 111
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'OnDate'
            Title.Alignment = taCenter
            Title.Caption = #1044#1072#1090#1072
            Width = 111
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'summ'
            Title.Alignment = taCenter
            Title.Caption = #1057#1091#1084#1084#1072
            Width = 107
            Visible = True
          end>
      end
      object pnlWorkerDepartment: TPanel
        Left = 0
        Top = 100
        Width = 460
        Height = 81
        Align = alClient
        BevelOuter = bvNone
        Caption = #1053#1077#1090' '#1076#1072#1085#1085#1099#1093
        TabOrder = 1
      end
    end
  end
  object qrObject: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    SQL.Strings = (
      'SELECT OBJ_ID, FULL_NAME as NAME, BEG_STROJ as DATE'
      'FROM objcards '
      'WHERE DEL_FLAG=0'
      'ORDER BY NAME')
    Left = 369
  end
  object dsObject: TDataSource
    DataSet = qrObject
    Left = 400
    Top = 1
  end
  object qrTravel: TFDQuery
    AfterOpen = qrTravelAfterOpen
    BeforePost = qrTravelBeforePost
    AfterPost = qrTravelAfterPost
    AfterCancel = qrTravelAfterScroll
    AfterScroll = qrTravelAfterScroll
    OnNewRecord = qrTravelNewRecord
    MasterSource = dsObject
    MasterFields = 'OBJ_ID'
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FormatOptions.AssignedValues = [fvFmtDisplayNumeric]
    FormatOptions.FmtDisplayNumeric = '### ### ### ### ### ### ### ### ###'
    UpdateOptions.AssignedValues = [uvCheckReadOnly]
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.UpdateTableName = 'smeta.travel'
    SQL.Strings = (
      'SELECT '
      '  `travel`.*,'
      
        '  IF(`travel`.`SOURCE_TYPE`, `smetasourcedata`.`NAME`, `card_act' +
        's`.`NAME`) AS NAME'
      'FROM `travel`'
      
        '  LEFT JOIN `smetasourcedata` ON `smetasourcedata`.`SM_ID`=`trav' +
        'el`.`ID_ESTIMATE`  AND `smetasourcedata`.`OBJ_ID`=:OBJ_ID AND `s' +
        'metasourcedata`.`SM_TYPE`<>3 AND `travel`.`SOURCE_TYPE` = 1'
      
        '  LEFT JOIN `card_acts` ON `card_acts`.`ID`=`travel`.`id_act` AN' +
        'D `card_acts`.`ID_OBJECT`=:OBJ_ID AND `travel`.`SOURCE_TYPE` = 0'
      
        'WHERE ((`card_acts`.`ID` IS NOT NULL) OR (`smetasourcedata`.`SM_' +
        'ID` IS NOT NULL))')
    Left = 25
    Top = 96
    ParamData = <
      item
        Name = 'OBJ_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 40
      end>
  end
  object dsTravel: TDataSource
    DataSet = qrTravel
    Left = 72
    Top = 96
  end
  object qrTravelWork: TFDQuery
    AfterOpen = qrTravelWorkAfterOpen
    BeforePost = qrTravelWorkBeforePost
    AfterPost = qrTravelWorkAfterPost
    AfterCancel = qrTravelWorkAfterScroll
    AfterScroll = qrTravelWorkAfterScroll
    OnNewRecord = qrTravelNewRecord
    MasterSource = dsObject
    MasterFields = 'OBJ_ID'
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FormatOptions.AssignedValues = [fvFmtDisplayNumeric]
    FormatOptions.FmtDisplayNumeric = '### ### ### ### ### ### ### ### ###'
    UpdateOptions.AssignedValues = [uvCheckReadOnly]
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.UpdateTableName = 'smeta.travel_work'
    SQL.Strings = (
      'SELECT '
      '  `travel_work`.*,'
      
        '  IF(`travel_work`.`SOURCE_TYPE`, `smetasourcedata`.`NAME`, `car' +
        'd_acts`.`NAME`) AS NAME'
      'FROM `travel_work`'
      
        '  LEFT JOIN `smetasourcedata` ON `smetasourcedata`.`SM_ID`=`trav' +
        'el_work`.`ID_ESTIMATE` AND `smetasourcedata`.`OBJ_ID`=:OBJ_ID AN' +
        'D `smetasourcedata`.`SM_TYPE`<>3 AND `travel_work`.`SOURCE_TYPE`' +
        ' = 1'
      
        '  LEFT JOIN `card_acts` ON `card_acts`.`ID`=`travel_work`.`id_ac' +
        't` AND `card_acts`.`ID_OBJECT`=:OBJ_ID AND `travel_work`.`SOURCE' +
        '_TYPE` = 0'
      
        'WHERE ((`card_acts`.`ID` IS NOT NULL) OR (`smetasourcedata`.`SM_' +
        'ID` IS NOT NULL))')
    Left = 25
    Top = 152
    ParamData = <
      item
        Name = 'OBJ_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 40
      end>
  end
  object dsTravelWork: TDataSource
    DataSet = qrTravelWork
    Left = 96
    Top = 152
  end
  object qrWorkerDepartment: TFDQuery
    AfterOpen = qrWorkerDepartmentAfterOpen
    BeforePost = qrWorkerDepartmentBeforePost
    AfterPost = qrWorkerDepartmentAfterPost
    AfterCancel = qrWorkerDepartmentAfterScroll
    AfterScroll = qrWorkerDepartmentAfterScroll
    OnNewRecord = qrTravelNewRecord
    MasterSource = dsObject
    MasterFields = 'OBJ_ID'
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FormatOptions.AssignedValues = [fvFmtDisplayNumeric]
    FormatOptions.FmtDisplayNumeric = '### ### ### ### ### ### ### ### ###'
    UpdateOptions.AssignedValues = [uvCheckReadOnly]
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.UpdateTableName = 'smeta.worker_deartment'
    SQL.Strings = (
      'SELECT '
      '  `worker_deartment`.*,'
      
        '  IF(`worker_deartment`.`SOURCE_TYPE`, `smetasourcedata`.`NAME`,' +
        ' `card_acts`.`NAME`) AS NAME'
      'FROM `worker_deartment`'
      
        '  LEFT JOIN `smetasourcedata` ON `smetasourcedata`.`SM_ID`=`work' +
        'er_deartment`.`ID_ESTIMATE` AND `smetasourcedata`.`OBJ_ID`=:OBJ_' +
        'ID AND `smetasourcedata`.`SM_TYPE`<>3 AND `worker_deartment`.`SO' +
        'URCE_TYPE` = 1'
      
        '  LEFT JOIN `card_acts` ON `card_acts`.`ID`=`worker_deartment`.`' +
        'id_act` AND `card_acts`.`ID_OBJECT`=:OBJ_ID AND `worker_deartmen' +
        't`.`SOURCE_TYPE` = 0'
      
        'WHERE ((`card_acts`.`ID` IS NOT NULL) OR (`smetasourcedata`.`SM_' +
        'ID` IS NOT NULL))')
    Left = 25
    Top = 200
    ParamData = <
      item
        Name = 'OBJ_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 40
      end>
  end
  object dsWorkerDepartment: TDataSource
    DataSet = qrWorkerDepartment
    Left = 136
    Top = 200
  end
  object FormStorage: TJvFormStorage
    AppStorage = FormMain.AppIni
    AppStoragePath = '%FORM_NAME%\'
    Options = []
    StoredProps.Strings = (
      'grTravel.Height'
      'grTravelWork.Height'
      'grWorkerDepartment.Height')
    StoredValues = <>
    Left = 24
    Top = 48
  end
end
