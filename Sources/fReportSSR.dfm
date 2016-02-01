object FormReportSSR: TFormReportSSR
  Left = 57
  Top = 59
  Caption = #1054#1090#1095#1077#1090' '#1057#1057#1056
  ClientHeight = 378
  ClientWidth = 790
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlGrid: TPanel
    Left = 0
    Top = 52
    Width = 790
    Height = 326
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object grSSR: TJvDBGrid
      Left = 1
      Top = 1
      Width = 788
      Height = 324
      Align = alClient
      DataSource = dsSSR
      DrawingStyle = gdsClassic
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
      OnDrawColumnCell = grSSRDrawColumnCell
      AutoAppend = False
      AutoSort = False
      AlternateRowColor = 13290146
      SelectColumnsDialogStrings.Caption = 'Select columns'
      SelectColumnsDialogStrings.OK = '&OK'
      SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
      CanDelete = False
      EditControls = <>
      RowsHeight = 17
      TitleRowHeight = 17
      OnCanEditCell = grSSRCanEditCell
      Columns = <
        item
          Expanded = False
          FieldName = 'Num'
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = #8470
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Percent'
          Title.Alignment = taCenter
          Title.Caption = '%'
          Width = 30
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Koef1'
          Title.Alignment = taCenter
          Title.Caption = #1050#1060'1'
          Width = 40
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Koef2'
          Title.Alignment = taCenter
          Title.Caption = #1050#1060'2'
          Width = 40
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Name'
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
          Width = 400
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ZP'
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = #1047#1055
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ZP5'
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = #1047#1055' '#1087#1086' '#1087#1088'. '#8470'5'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'EMiM'
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = #1069#1052#1080#1052
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ZPMash'
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = #1047#1055' '#1084#1072#1096#1080#1085#1080#1089#1090#1072
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Mat'
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = #1052#1072#1090#1077#1088#1080#1072#1083#1099
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'MatTransp'
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = #1052#1072#1090'. '#1090#1088#1072#1085#1089#1087#1086#1088#1090
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'OXROPR'
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = #1054#1061#1056' '#1080' '#1054#1055#1056
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PlanPrib'
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = #1055#1083#1072#1085'. '#1087#1088#1080#1073'.'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Devices'
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = #1054#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1077
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Transp'
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = #1058#1088#1072#1085#1089#1087#1086#1088#1090
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Other'
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = #1055#1088#1086#1095#1077#1077
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Total'
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = #1042#1089#1077#1075#1086
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Trud'
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = #1058#1088#1091#1076#1086#1079#1072#1090#1088#1072#1090#1099
          Width = 100
          Visible = True
        end>
    end
  end
  object gbObject: TGroupBox
    Left = 0
    Top = 0
    Width = 790
    Height = 52
    Align = alTop
    Caption = ' '#1054#1073#1098#1077#1082#1090' '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      790
      52)
    object lbObjName: TLabel
      Left = 14
      Top = 27
      Width = 52
      Height = 13
      Caption = #1053#1072#1079#1074#1072#1085#1080#1077':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lbObjContNum: TLabel
      Left = 435
      Top = 9
      Width = 86
      Height = 13
      Anchors = [akTop, akRight]
      Caption = #1053#1086#1084#1077#1088' '#1076#1086#1075#1086#1074#1086#1088#1072':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lbObjContDate: TLabel
      Left = 551
      Top = 9
      Width = 81
      Height = 13
      Anchors = [akTop, akRight]
      Caption = #1044#1072#1090#1072' '#1076#1086#1075#1086#1074#1086#1088#1072':'
    end
    object btnObjInfo: TSpeedButton
      Left = 663
      Top = 24
      Width = 108
      Height = 21
      Anchors = [akTop, akRight]
      Caption = #1050#1072#1088#1090#1086#1095#1082#1072' '#1086#1073#1098#1077#1082#1090#1072
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsUnderline]
      ParentFont = False
      OnClick = btnObjInfoClick
    end
    object cbObjName: TDBLookupComboBox
      Left = 72
      Top = 25
      Width = 355
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      KeyField = 'obj_id'
      ListField = 'num_name'
      ListSource = dsObject
      NullValueKey = 16411
      ParentFont = False
      TabOrder = 2
      OnClick = cbObjNameClick
    end
    object edtObjContNum: TEdit
      Left = 433
      Top = 24
      Width = 110
      Height = 21
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      Text = 'edtObjContNum'
    end
    object edtObjContDate: TEdit
      Left = 548
      Top = 24
      Width = 110
      Height = 21
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
      Text = 'edtObjContDate'
    end
  end
  object mtSSR: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    StoreDefs = True
    Left = 136
    Top = 104
    object mtSSRNum: TStringField
      FieldName = 'Num'
    end
    object mtSSRPepcent: TFloatField
      FieldName = 'Percent'
      OnChange = mtSSRKoefChange
    end
    object mtSSRKoef1: TFloatField
      FieldName = 'Koef1'
      OnChange = mtSSRKoefChange
    end
    object mtSSRKoef2: TFloatField
      FieldName = 'Koef2'
      OnChange = mtSSRKoefChange
    end
    object mtSSRName: TStringField
      DisplayWidth = 200
      FieldName = 'Name'
      Size = 200
    end
    object mtSSRZP: TCurrencyField
      FieldName = 'ZP'
      DisplayFormat = '#,0'
      currency = False
    end
    object mtSSRZP5: TCurrencyField
      FieldName = 'ZP5'
      DisplayFormat = '#,0'
      currency = False
    end
    object mtSSREMiM: TCurrencyField
      FieldName = 'EMiM'
      DisplayFormat = '#,0'
      currency = False
    end
    object mtSSRZPMash: TCurrencyField
      FieldName = 'ZPMash'
      DisplayFormat = '#,0'
      currency = False
    end
    object mtSSRMat: TCurrencyField
      FieldName = 'Mat'
      DisplayFormat = '#,0'
      currency = False
    end
    object mtSSRMatTransp: TCurrencyField
      FieldName = 'MatTransp'
      DisplayFormat = '#,0'
      currency = False
    end
    object mtSSROXROPR: TCurrencyField
      FieldName = 'OXROPR'
      DisplayFormat = '#,0'
      currency = False
    end
    object mtSSRPlanPrib: TCurrencyField
      FieldName = 'PlanPrib'
      DisplayFormat = '#,0'
      currency = False
    end
    object mtSSRDevices: TCurrencyField
      FieldName = 'Devices'
      DisplayFormat = '#,0'
      currency = False
    end
    object mtSSRTransp: TCurrencyField
      FieldName = 'Transp'
      DisplayFormat = '#,0'
      currency = False
    end
    object mtSSROther: TCurrencyField
      FieldName = 'Other'
      DisplayFormat = '#,0'
      currency = False
    end
    object mtSSRTotal: TCurrencyField
      FieldName = 'Total'
      DisplayFormat = '#,0'
      currency = False
    end
    object mtSSRTrud: TCurrencyField
      FieldName = 'Trud'
      DisplayFormat = '#,0'
      currency = False
    end
    object mtSSRCID: TIntegerField
      FieldName = 'CID'
    end
    object mtSSRSCID: TIntegerField
      FieldName = 'SCID'
    end
    object mtSSRSM_ID: TIntegerField
      FieldName = 'SM_ID'
    end
    object mtSSRSM_TYPE: TIntegerField
      FieldName = 'SM_TYPE'
    end
    object mtSSRItog: TSmallintField
      FieldName = 'Itog'
    end
  end
  object dsSSR: TDataSource
    DataSet = mtSSR
    Left = 192
    Top = 104
  end
  object dsObject: TDataSource
    DataSet = qrObject
    Left = 280
    Top = 11
  end
  object qrObject: TFDQuery
    BeforeOpen = qrObjectBeforeOpen
    Connection = DM.Connect
    SQL.Strings = (
      'SELECT '
      '    obj_id, '
      '    num, '
      '    num_dog, '
      '    date_dog, '
      
        '    full_name, concat(cast(num as char(12)),'#39' '#39', full_name) as n' +
        'um_name, '
      '    beg_stroj,'
      '    beg_stroj2,'
      '    srok_stroj,'
      
        '    FN_getIndex(beg_stroj, DATE_ADD(beg_stroj2, INTERVAL -1 MONT' +
        'H), 1) as pibeg,'
      
        '    FN_getIndex(beg_stroj2, DATE_ADD(beg_stroj2, INTERVAL +srok_' +
        'stroj MONTH), 1) as piend,'
      '    CONTRACT_PRICE_TYPE_ID,'
      
        '    FN_getParamValue("K_VREM_ZDAN_SOOR", MONTH(beg_stroj), YEAR(' +
        'beg_stroj)) as KVREM,'
      
        '    FN_getParamValue("K_ZIM_UDOR_1", MONTH(beg_stroj), YEAR(beg_' +
        'stroj)) as KZIM,'
      
        '    FN_getParamValue("SOC_STRAH", MONTH(beg_stroj), YEAR(beg_str' +
        'oj)) as KSOCSTRAX'
      'FROM objcards '
      'WHERE (DEL_FLAG=0) AND'
      '      ((:USER_ID=1) OR '
      '       (objcards.USER_ID=:USER_ID) OR '
      
        '       EXISTS(SELECT USER_ID FROM user_access WHERE DOC_TYPE_ID=' +
        '2 AND MASTER_ID=objcards.obj_id AND ((USER_ID=0) OR (USER_ID=:US' +
        'ER_ID)) LIMIT 1))'
      'ORDER BY num, num_dog, full_name')
    Left = 329
    Top = 11
    ParamData = <
      item
        Name = 'USER_ID'
        ParamType = ptInput
        Value = Null
      end>
  end
  object qrTemp: TFDQuery
    Connection = DM.Connect
    Left = 288
    Top = 108
  end
  object UpdateTimer: TTimer
    Enabled = False
    Interval = 100
    OnTimer = UpdateTimerTimer
    Left = 480
    Top = 140
  end
end
