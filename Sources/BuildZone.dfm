object fBuildZone: TfBuildZone
  Left = 0
  Top = 0
  Caption = #1047#1086#1085#1099' '#1089#1090#1088#1086#1080#1090#1077#1083#1100#1089#1090#1074#1072
  ClientHeight = 495
  ClientWidth = 591
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 363
    Height = 495
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitHeight = 409
    object gbZone: TGroupBox
      Left = 0
      Top = 0
      Width = 363
      Height = 105
      Margins.Left = 1
      Margins.Top = 100
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alTop
      Caption = ' '#1047#1072#1085#1099' '#1089#1090#1088#1086#1080#1090#1077#1083#1100#1089#1090#1074#1072' '
      TabOrder = 0
      object grdZone: TJvDBGrid
        Left = 2
        Top = 15
        Width = 359
        Height = 88
        Align = alClient
        DataSource = dsObjRegion
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        ScrollBars = ssNone
        SelectColumnsDialogStrings.Caption = 'Select columns'
        SelectColumnsDialogStrings.OK = '&OK'
        SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
        EditControls = <>
        RowsHeight = 17
        TitleRowHeight = 17
        Columns = <
          item
            Expanded = False
            FieldName = 'OBJ_REGION_ID'
            Title.Alignment = taCenter
            Title.Caption = #1050#1086#1076' '#1079#1086#1085#1099
            Width = 60
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TITLE'
            Title.Alignment = taCenter
            Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1079#1086#1085#1099
            Width = 250
            Visible = True
          end>
      end
    end
    object gbDescript: TGroupBox
      Left = 0
      Top = 105
      Width = 363
      Height = 104
      Align = alTop
      Caption = #1054#1087#1080#1089#1072#1085#1080#1077' '#1079#1086#1085#1099' '
      TabOrder = 1
      object DBMemo1: TDBMemo
        Left = 2
        Top = 15
        Width = 359
        Height = 87
        Align = alClient
        DataField = 'DESCRIPT'
        DataSource = dsObjRegion
        TabOrder = 0
        ExplicitHeight = 66
      end
    end
  end
  object Panel2: TPanel
    Left = 363
    Top = 0
    Width = 228
    Height = 495
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitHeight = 409
    object gbObject: TGroupBox
      Left = 0
      Top = 0
      Width = 228
      Height = 495
      Align = alClient
      Caption = #1055#1077#1088#1077#1095#1077#1085#1100' '#1088#1072#1081#1086#1085#1086#1074
      TabOrder = 0
      ExplicitHeight = 409
      object Panel3: TPanel
        Left = 2
        Top = 15
        Width = 224
        Height = 34
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object cbRegions: TComboBox
          Left = 4
          Top = 7
          Width = 213
          Height = 21
          Style = csDropDownList
          TabOrder = 0
          OnChange = cbRegionsChange
        end
      end
      object grdObject: TJvDBGrid
        Left = 2
        Top = 49
        Width = 224
        Height = 444
        Align = alClient
        DataSource = dsRegionObject
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        SelectColumnsDialogStrings.Caption = 'Select columns'
        SelectColumnsDialogStrings.OK = '&OK'
        SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
        EditControls = <>
        RowsHeight = 17
        TitleRowHeight = 17
        Columns = <
          item
            Expanded = False
            FieldName = 'NUM'
            Title.Alignment = taCenter
            Title.Caption = #8470
            Width = 25
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NAME'
            Title.Alignment = taCenter
            Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
            Width = 150
            Visible = True
          end>
      end
    end
  end
  object dsObjRegion: TDataSource
    AutoEdit = False
    DataSet = qrObjRegion
    Left = 296
    Top = 64
  end
  object qrObjRegion: TFDQuery
    AfterScroll = qrObjRegionAfterScroll
    Connection = DM.Connect
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    SQL.Strings = (
      
        'Select OBJ_REGION_ID, TITLE, DESCRIPT from objregion order by OB' +
        'J_REGION_ID;')
    Left = 296
    Top = 16
  end
  object qrRegionObject: TFDQuery
    OnCalcFields = qrRegionObjectCalcFields
    MasterSource = dsObjRegion
    MasterFields = 'OBJ_REGION_ID'
    Connection = DM.Connect
    FetchOptions.AssignedValues = [evCache]
    FetchOptions.Cache = [fiBlobs, fiMeta]
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    SQL.Strings = (
      
        'Select ID_OBL, NAME from region_object where ID_REGION = :OBJ_RE' +
        'GION_ID order by NAME')
    Left = 136
    Top = 232
    ParamData = <
      item
        Name = 'OBJ_REGION_ID'
        DataType = ftWord
        ParamType = ptInput
        Size = 2
        Value = 1
      end>
    object qrRegionObjectID_OBL: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'ID_OBL'
      Origin = 'ID_OBL'
    end
    object qrRegionObjectNAME: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'NAME'
      Origin = 'NAME'
      Size = 50
    end
    object qrRegionObjectNUM: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'NUM'
      Calculated = True
    end
  end
  object dsRegionObject: TDataSource
    AutoEdit = False
    DataSet = qrRegionObject
    Left = 216
    Top = 232
  end
  object qrRegions: TFDQuery
    Connection = DM.Connect
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    SQL.Strings = (
      'Select REGION_ID, REGION_NAME from regions where REGION_ID < 7')
    Left = 136
    Top = 288
  end
end
