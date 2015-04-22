object fCalcWorkerDepartment: TfCalcWorkerDepartment
  Left = 0
  Top = 0
  Caption = #1056#1072#1089#1095#1077#1090' '#1087#1077#1088#1077#1074#1086#1079#1082#1080' '#1088#1072#1073#1086#1095#1080#1093
  ClientHeight = 354
  ClientWidth = 495
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
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    495
    354)
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 8
    Top = 35
    Width = 65
    Height = 13
    Caption = #1054#1089#1085#1086#1074#1072#1085#1080#1077':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
  end
  object lbl3: TLabel
    Left = 8
    Top = 8
    Width = 48
    Height = 13
    Caption = #1054#1073#1098#1077#1082#1090':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
  end
  object lbl4: TLabel
    Left = 8
    Top = 65
    Width = 48
    Height = 13
    Caption = #1057#1086#1089#1090#1072#1074#1080#1083
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object dbedtPREPARER: TDBEdit
    Left = 79
    Top = 62
    Width = 210
    Height = 21
    DataField = 'PREPARER'
    DataSource = fTravelList.dsWorkerDepartment
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object dbedtNAME: TDBEdit
    Left = 79
    Top = 8
    Width = 408
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    DataField = 'NAME'
    DataSource = fTravelList.dsObject
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object JvDBGrid1: TJvDBGrid
    Left = 8
    Top = 89
    Width = 479
    Height = 257
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = dsCalc
    DrawingStyle = gdsClassic
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ParentFont = False
    TabOrder = 6
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnKeyPress = JvDBGrid1KeyPress
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
        FieldName = 'NAIMEN'
        Title.Alignment = taCenter
        Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1079#1072#1090#1088#1072#1090
        Width = 141
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CALC'
        Title.Alignment = taCenter
        Title.Caption = #1056#1072#1089#1095#1077#1090
        Width = 248
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TOTAL'
        Title.Alignment = taCenter
        Title.Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100
        Width = 83
        Visible = True
      end>
  end
  object dblkcbbAct: TDBLookupComboBox
    Left = 143
    Top = 35
    Width = 344
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    DataField = 'id_act'
    DataSource = fTravelList.dsWorkerDepartment
    KeyField = 'ID'
    ListField = 'NAME'
    ListSource = dsActList
    TabOrder = 3
    OnClick = dblkcbbActClick
  end
  object cbbSource: TComboBox
    Left = 79
    Top = 35
    Width = 58
    Height = 21
    AutoCloseUp = True
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 1
    Text = #1072#1082#1090
    OnChange = cbbSourceChange
    Items.Strings = (
      #1072#1082#1090
      #1089#1084#1077#1090#1072)
  end
  object dbchkFL_Full_month: TDBCheckBox
    Left = 295
    Top = 62
    Width = 146
    Height = 17
    Caption = #1056#1072#1089#1095#1077#1090' '#1079#1072' '#1087#1086#1083#1085#1099#1081' '#1084#1077#1089#1103#1094
    DataField = 'FL_Full_month'
    DataSource = fTravelList.dsWorkerDepartment
    TabOrder = 5
    ValueChecked = '1'
    ValueUnchecked = '0'
  end
  object dblkcbbSmeta: TDBLookupComboBox
    Left = 143
    Top = 35
    Width = 344
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    DataField = 'id_estimate'
    DataSource = fTravelList.dsWorkerDepartment
    KeyField = 'SM_ID'
    ListField = 'NAME'
    ListSource = dsSmetaList
    TabOrder = 2
    Visible = False
    OnClick = dblkcbbActClick
  end
  object dsCalc: TDataSource
    DataSet = qrCalc
    Left = 36
    Top = 150
  end
  object qrCalc: TFDQuery
    AfterPost = qrCalcAfterPost
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FetchOptions.AssignedValues = [evCache]
    FetchOptions.Cache = [fiBlobs, fiMeta]
    FormatOptions.AssignedValues = [fvMapRules, fvDefaultParamDataType, fvFmtDisplayNumeric]
    FormatOptions.OwnMapRules = True
    FormatOptions.MapRules = <
      item
        SourceDataType = dtMemo
        TargetDataType = dtAnsiString
      end
      item
        SourceDataType = dtByteString
        TargetDataType = dtAnsiString
      end
      item
        SourceDataType = dtBCD
        TargetDataType = dtDouble
      end
      item
        SourceDataType = dtBlob
        TargetDataType = dtAnsiString
      end>
    FormatOptions.DefaultParamDataType = ftBCD
    FormatOptions.FmtDisplayNumeric = '### ### ### ###.###'
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.CheckUpdatable = False
    SQL.Strings = (
      
        'CALL `CalcWorkerDepartment`(:ID_ESTIMATE, :ID_ACT, :FLFullMonth,' +
        ' :PLACE_COUNT, :EMbyHVR, :EMbyKM, :RoadALength, :RoadGLength, :R' +
        'oadGrLength, :RoadASpeed, :RoadGSpeed, :RoadGrSpeed, :FactDay, :' +
        'TravelCount, :InOut, :TimeIn, :TimeOut);')
    Left = 35
    Top = 94
    ParamData = <
      item
        Name = 'ID_ESTIMATE'
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'ID_ACT'
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'FLFULLMONTH'
        ParamType = ptInput
      end
      item
        Name = 'PLACE_COUNT'
        ParamType = ptInput
      end
      item
        Name = 'EMBYHVR'
        ParamType = ptInput
      end
      item
        Name = 'EMBYKM'
        ParamType = ptInput
      end
      item
        Name = 'ROADALENGTH'
        ParamType = ptInput
      end
      item
        Name = 'ROADGLENGTH'
        ParamType = ptInput
      end
      item
        Name = 'ROADGRLENGTH'
        ParamType = ptInput
      end
      item
        Name = 'ROADASPEED'
        ParamType = ptInput
      end
      item
        Name = 'ROADGSPEED'
        ParamType = ptInput
      end
      item
        Name = 'ROADGRSPEED'
        ParamType = ptInput
      end
      item
        Name = 'FACTDAY'
        ParamType = ptInput
      end
      item
        Name = 'TRAVELCOUNT'
        ParamType = ptInput
      end
      item
        Name = 'INOUT'
        ParamType = ptInput
      end
      item
        Name = 'TIMEIN'
        ParamType = ptInput
      end
      item
        Name = 'TIMEOUT'
        ParamType = ptInput
      end>
  end
  object qrActList: TFDQuery
    MasterSource = fTravelList.dsObject
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
    SQL.Strings = (
      'SELECT '
      '  `card_acts`.`ID`,'
      '  `card_acts`.`NAME`'
      'FROM '
      '  `card_acts`, `smetasourcedata`'
      'WHERE `ID_ESTIMATE_OBJECT`=`SM_ID` AND `OBJ_ID`=:OBJ_ID;')
    Left = 233
    Top = 96
    ParamData = <
      item
        Name = 'OBJ_ID'
        DataType = ftString
        ParamType = ptInput
        Value = '0'
      end>
  end
  object dsActList: TDataSource
    DataSet = qrActList
    Left = 280
    Top = 96
  end
  object qrSmetaList: TFDQuery
    MasterSource = fTravelList.dsObject
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
    SQL.Strings = (
      'SELECT '
      '  `smetasourcedata`.`SM_ID`,'
      
        '  CONCAT(`smetasourcedata`.`SM_NUMBER`, '#39' '#39', `smetasourcedata`.`' +
        'NAME`) AS NAME'
      'FROM '
      '  `smetasourcedata`'
      'WHERE `OBJ_ID`=:OBJ_ID AND `SM_TYPE`<>3;')
    Left = 233
    Top = 152
    ParamData = <
      item
        Name = 'OBJ_ID'
        DataType = ftString
        ParamType = ptInput
        Value = '40'
      end>
  end
  object dsSmetaList: TDataSource
    DataSet = qrSmetaList
    Left = 280
    Top = 152
  end
end
