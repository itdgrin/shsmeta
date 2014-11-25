object fCalcResource: TfCalcResource
  Left = 0
  Top = 0
  Caption = #1056#1072#1089#1095#1077#1090' '#1089#1090#1086#1080#1084#1086#1089#1090#1080' '#1088#1077#1089#1091#1088#1089#1086#1074
  ClientHeight = 362
  ClientWidth = 616
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
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 616
    Height = 32
    Align = alTop
    TabOrder = 0
    DesignSize = (
      616
      32)
    object lbl1: TLabel
      Left = 8
      Top = 8
      Width = 39
      Height = 13
      Caption = #1054#1073#1098#1077#1082#1090
    end
    object dblkcbbNAME: TDBLookupComboBox
      Left = 53
      Top = 5
      Width = 554
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      KeyField = 'OBJ_ID'
      ListField = 'NAME'
      ListSource = dsObject
      TabOrder = 0
    end
  end
  object pgc1: TPageControl
    Left = 0
    Top = 32
    Width = 616
    Height = 330
    ActivePage = ts2
    Align = alClient
    MultiLine = True
    TabOrder = 1
    OnChange = pgc1Change
    object ts1: TTabSheet
      Caption = #1056#1072#1089#1095#1077#1090' '#1089#1090#1086#1080#1084#1086#1089#1090#1080
      object lbl2: TLabel
        Left = 0
        Top = 0
        Width = 608
        Height = 302
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = #1042' '#1088#1072#1079#1088#1072#1073#1086#1090#1082#1077'...'
        Layout = tlCenter
        ExplicitWidth = 80
        ExplicitHeight = 13
      end
    end
    object ts2: TTabSheet
      Caption = #1056#1072#1089#1095#1077#1090' '#1084#1072#1090#1077#1088#1080#1072#1083#1086#1074
      ImageIndex = 1
      object spl2: TSplitter
        Left = 0
        Top = 233
        Width = 608
        Height = 3
        Cursor = crVSplit
        Align = alBottom
        ExplicitTop = 57
        ExplicitWidth = 179
      end
      object pnlMatTop: TPanel
        Left = 0
        Top = 0
        Width = 608
        Height = 57
        Align = alTop
        TabOrder = 0
        DesignSize = (
          608
          57)
        object lbl6: TLabel
          Left = 4
          Top = 3
          Width = 87
          Height = 13
          Caption = #1056#1072#1089#1095#1077#1090#1085#1099#1081' '#1084#1077#1089#1103#1094
        end
        object cbbFromMonth: TComboBox
          Left = 97
          Top = 0
          Width = 75
          Height = 21
          Style = csDropDownList
          DropDownCount = 12
          ItemIndex = 1
          TabOrder = 0
          Text = #1060#1077#1074#1088#1072#1083#1100
          Items.Strings = (
            #1071#1085#1074#1072#1088#1100
            #1060#1077#1074#1088#1072#1083#1100
            #1052#1072#1088#1090
            #1040#1087#1088#1077#1083#1100
            #1052#1072#1081
            #1048#1102#1085#1100
            #1048#1102#1083#1100
            #1040#1074#1075#1091#1089#1090
            #1057#1077#1085#1090#1103#1073#1088#1100
            #1054#1082#1090#1103#1073#1088#1100
            #1053#1086#1103#1073#1088#1100
            #1044#1077#1082#1072#1073#1088#1100)
        end
        object seFromYear: TSpinEdit
          Left = 175
          Top = 0
          Width = 49
          Height = 22
          MaxValue = 2100
          MinValue = 1900
          TabOrder = 1
          Value = 2014
        end
        object chk1: TCheckBox
          Left = 230
          Top = 3
          Width = 179
          Height = 17
          Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1091#1076#1072#1083#1077#1085#1085#1099#1077' '#1079#1085#1072#1095#1077#1085#1080#1103
          TabOrder = 2
        end
        object edt1: TEdit
          Left = 4
          Top = 27
          Width = 121
          Height = 21
          TabOrder = 3
          TextHint = #1055#1086#1080#1089#1082' '#1087#1086' '#1082#1086#1076#1091'...'
        end
        object edt2: TEdit
          Left = 131
          Top = 27
          Width = 472
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 4
          TextHint = #1055#1086#1080#1089#1082' '#1087#1086' '#1085#1072#1079#1074#1072#1085#1080#1102'...'
        end
        object cbb1: TComboBox
          Left = 536
          Top = 0
          Width = 67
          Height = 21
          Style = csDropDownList
          Anchors = [akTop, akRight]
          DropDownCount = 12
          ItemIndex = 0
          TabOrder = 5
          Text = #1089' '#1053#1044#1057
          Items.Strings = (
            #1089' '#1053#1044#1057
            #1073#1077#1079' '#1053#1044#1057)
        end
      end
      object pnlMatClient: TPanel
        Left = 0
        Top = 57
        Width = 608
        Height = 176
        Align = alClient
        BevelOuter = bvNone
        Caption = 'pnlMatClient'
        TabOrder = 1
        object pnlMatFooter: TPanel
          Left = 0
          Top = 152
          Width = 608
          Height = 24
          Align = alBottom
          Caption = 'pnlMatSumFooter'
          TabOrder = 0
        end
        object grMaterial: TJvDBGrid
          Left = 0
          Top = 0
          Width = 608
          Height = 152
          Align = alClient
          DataSource = dsMaterialData
          DrawingStyle = gdsClassic
          PopupMenu = pmMat
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
          WordWrap = True
          WordWrapAllFields = True
          Columns = <
            item
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = #1050#1086#1076
              Visible = True
            end
            item
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
              Visible = True
            end
            item
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = #1045#1076'. '#1080#1079#1084'.'
              Visible = True
            end
            item
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = #1050#1086#1083'-'#1074#1086
              Visible = True
            end
            item
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = #1062#1077#1085#1072
              Visible = True
            end
            item
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100
              Visible = True
            end
            item
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = '% '#1090#1088#1072#1085#1089#1087'.'
              Visible = True
            end
            item
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = #1058#1088#1072#1085#1089#1087#1086#1088#1090
              Visible = True
            end
            item
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = #1053#1072#1082#1083'. '#1076#1072#1090#1072
              Visible = True
            end
            item
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = #1053#1072#1082#1083'. '#8470
              Visible = True
            end>
        end
      end
      object pnlMatBott: TPanel
        Left = 0
        Top = 236
        Width = 608
        Height = 66
        Align = alBottom
        Caption = 'pnlMatBott'
        TabOrder = 2
        object spl1: TSplitter
          Left = 1
          Top = 22
          Width = 606
          Height = 3
          Cursor = crVSplit
          Align = alBottom
          ExplicitTop = 1
          ExplicitWidth = 129
        end
        object grMaterialBott: TJvDBGrid
          Left = 1
          Top = 25
          Width = 606
          Height = 40
          Align = alBottom
          Constraints.MinHeight = 40
          DrawingStyle = gdsClassic
          TabOrder = 0
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
              Title.Alignment = taCenter
              Title.Caption = #8470#1087#1087
              Visible = True
            end
            item
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = #1054#1073#1086#1089#1085#1086#1074#1072#1085#1080#1077
              Visible = True
            end
            item
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = #1054#1073#1098#1077#1084' '#1088#1072#1073#1086#1090
              Visible = True
            end
            item
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = #1056#1072#1089#1093#1086#1076
              Visible = True
            end
            item
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = #1062#1077#1085#1072
              Visible = True
            end>
        end
        object dbmmo1: TDBMemo
          Left = 1
          Top = 1
          Width = 606
          Height = 21
          Align = alClient
          Constraints.MinHeight = 21
          TabOrder = 1
        end
      end
    end
    object ts3: TTabSheet
      Caption = #1056#1072#1089#1095#1077#1090' '#1084#1077#1093#1072#1085#1080#1079#1084#1086#1074
      ImageIndex = 2
      object lbl3: TLabel
        Left = 0
        Top = 0
        Width = 608
        Height = 302
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = #1042' '#1088#1072#1079#1088#1072#1073#1086#1090#1082#1077'...'
        Layout = tlCenter
        ExplicitWidth = 80
        ExplicitHeight = 13
      end
    end
    object ts4: TTabSheet
      Caption = #1056#1072#1089#1095#1077#1090' '#1086#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1103
      ImageIndex = 3
      object lbl4: TLabel
        Left = 0
        Top = 0
        Width = 608
        Height = 302
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = #1042' '#1088#1072#1079#1088#1072#1073#1086#1090#1082#1077'...'
        Layout = tlCenter
        ExplicitWidth = 80
        ExplicitHeight = 13
      end
    end
    object ts5: TTabSheet
      Caption = #1056#1072#1089#1095#1077#1090' '#1079#1072#1088#1087#1083#1072#1090#1099
      ImageIndex = 4
      object lbl5: TLabel
        Left = 0
        Top = 0
        Width = 608
        Height = 302
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = #1042' '#1088#1072#1079#1088#1072#1073#1086#1090#1082#1077'...'
        Layout = tlCenter
        ExplicitWidth = 80
        ExplicitHeight = 13
      end
    end
  end
  object dsObject: TDataSource
    DataSet = qrObject
    Left = 56
    Top = 1
  end
  object qrObject: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    SQL.Strings = (
      'SELECT OBJ_ID, FULL_NAME as NAME, BEG_STROJ as DATE'
      'FROM objcards '
      'ORDER BY NAME')
    Left = 25
  end
  object pmMat: TPopupMenu
    Left = 12
    Top = 120
    object N1: TMenuItem
      Caption = #1042#1099#1076#1077#1083#1080#1090#1100
    end
    object N2: TMenuItem
      Caption = #1042#1099#1076#1077#1083#1080#1090#1100' '#1074#1089#1077
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object N3: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100
    end
    object N5: TMenuItem
      Caption = #1042#1086#1089#1089#1090#1072#1085#1086#1074#1080#1090#1100
    end
  end
  object qrMaterialData: TFDQuery
    MasterFields = 'SM_ID'
    DetailFields = 'SM_ID'
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FetchOptions.AssignedValues = [evCache]
    FetchOptions.Cache = [fiBlobs, fiMeta]
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
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.CheckUpdatable = False
    SQL.Strings = (
      '/* '#1056#1040#1057#1062#1045#1053#1050#1048' */'
      'SELECT '
      '  ID_ESTIMATE,'
      '  ID_TYPE_DATA,'
      '  card_rate.ID as ID_TABLES,'
      '  RATE_CODE AS CODE, /* '#1054#1073#1086#1089#1085#1086#1074#1072#1085#1080#1077'*/'
      '  RATE_CAPTION AS NAME, /* '#1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' */'
      '  RATE_UNIT AS UNIT, /* '#1045#1076'. '#1080#1079#1084#1077#1088#1077#1085#1080#1103' */'
      '  COALESCE(RATE_COUNT, 0) AS CNT, /* '#1050#1086#1083'-'#1074#1086' */'
      
        '  COALESCE((SELECT SUM(RATE_COUNT) FROM card_rate_act where id=d' +
        'ata_estimate.ID_TABLES), 0) AS CntDone, /* '#1042#1099#1087#1086#1083#1085#1077#1085#1086' */'
      
        '  COALESCE((COALESCE(RATE_COUNT, 0) - COALESCE((SELECT SUM(RATE_' +
        'COUNT) FROM card_rate_act where id=data_estimate.ID_TABLES), 0))' +
        ', 0) AS CntOut /* '#1054#1089#1090#1072#1090#1086#1082' */'
      'FROM '
      '  data_estimate, card_rate'
      'WHERE '
      'data_estimate.ID_TYPE_DATA = 1 AND'
      'card_rate.ID = data_estimate.ID_TABLES AND'
      '((ID_ESTIMATE = :SM_ID) OR /* '#1054#1073#1098#1077#1082#1090#1085#1099#1081' '#1091#1088#1086#1074#1077#1085#1100' */'
      
        ' (ID_ESTIMATE IN (SELECT s1.SM_ID FROM smetasourcedata s1 WHERE ' +
        '(s1.PARENT_LOCAL_ID + s1.PARENT_PTM_ID) = :SM_ID)) OR /* '#1051#1086#1082#1072#1083#1100#1085 +
        #1099#1081' '#1091#1088#1086#1074#1077#1085#1100' */'
      
        ' (ID_ESTIMATE IN (SELECT s2.SM_ID FROM smetasourcedata s2 WHERE ' +
        '(s2.PARENT_LOCAL_ID + s2.PARENT_PTM_ID) IN '
      
        '   (SELECT s1.SM_ID FROM smetasourcedata s1 WHERE (s1.PARENT_LOC' +
        'AL_ID + s1.PARENT_PTM_ID) = :SM_ID))'
      ' ) /* '#1055#1058#1052' '#1091#1088#1086#1074#1077#1085#1100' */'
      ')'
      ''
      'UNION ALL'
      ''
      '/* '#1052#1040#1058#1045#1056#1048#1040#1051#1067' '#1042' '#1056#1040#1057#1062#1045#1053#1050#1045'*/'
      'SELECT '
      '  ID_ESTIMATE,'
      '  ID_TYPE_DATA,'
      '  materialcard.ID AS ID_TABLES,'
      '  CONCAT('#39'    '#39', MAT_CODE) AS CODE, /* '#1054#1073#1086#1089#1085#1086#1074#1072#1085#1080#1077'*/'
      '  MAT_NAME AS NAME, /* '#1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' */'
      '  MAT_UNIT AS UNIT, /* '#1045#1076'. '#1080#1079#1084#1077#1088#1077#1085#1080#1103' */'
      '  COALESCE(MAT_COUNT, 0) AS CNT, /* '#1050#1086#1083'-'#1074#1086' */'
      
        '  COALESCE((SELECT SUM(MAT_COUNT) FROM materialcard_act where id' +
        '=data_estimate.ID_TABLES), 0) AS CntDone, /* '#1042#1099#1087#1086#1083#1085#1077#1085#1086' */'
      
        '  COALESCE((COALESCE(MAT_COUNT, 0) - COALESCE((SELECT SUM(MAT_CO' +
        'UNT) FROM materialcard_act where id=data_estimate.ID_TABLES), 0)' +
        '), 0) AS CntOut /* '#1054#1089#1090#1072#1090#1086#1082' */'
      'FROM '
      '  data_estimate, card_rate, materialcard'
      'WHERE '
      'data_estimate.ID_TYPE_DATA = 1 AND'
      'card_rate.ID = data_estimate.ID_TABLES AND'
      'materialcard.ID_CARD_RATE = card_rate.ID AND'
      'materialcard.CONSIDERED = 0 AND'
      '((ID_ESTIMATE = :SM_ID) OR /* '#1054#1073#1098#1077#1082#1090#1085#1099#1081' '#1091#1088#1086#1074#1077#1085#1100' */'
      
        ' (ID_ESTIMATE IN (SELECT s1.SM_ID FROM smetasourcedata s1 WHERE ' +
        '(s1.PARENT_LOCAL_ID + s1.PARENT_PTM_ID) = :SM_ID)) OR /* '#1051#1086#1082#1072#1083#1100#1085 +
        #1099#1081' '#1091#1088#1086#1074#1077#1085#1100' */'
      
        ' (ID_ESTIMATE IN (SELECT s2.SM_ID FROM smetasourcedata s2 WHERE ' +
        '(s2.PARENT_LOCAL_ID + s2.PARENT_PTM_ID) IN '
      
        '   (SELECT s1.SM_ID FROM smetasourcedata s1 WHERE (s1.PARENT_LOC' +
        'AL_ID + s1.PARENT_PTM_ID) = :SM_ID))'
      ' ) /* '#1055#1058#1052' '#1091#1088#1086#1074#1077#1085#1100' */'
      ')'
      ''
      'UNION ALL'
      ''
      '/* '#1052#1040#1058#1045#1056#1048#1040#1051#1067' '#1042#1067#1053#1045#1057#1045#1053#1053#1067#1045' '#1047#1040' '#1056#1040#1057#1062#1045#1053#1050#1059'*/'
      'SELECT '
      '  ID_ESTIMATE,'
      '  2 as ID_TYPE_DATA,'
      '  materialcard.ID AS ID_TABLES,'
      '  MAT_CODE AS CODE, /* '#1054#1073#1086#1089#1085#1086#1074#1072#1085#1080#1077'*/'
      '  MAT_NAME AS NAME, /* '#1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' */'
      '  MAT_UNIT AS UNIT, /* '#1045#1076'. '#1080#1079#1084#1077#1088#1077#1085#1080#1103' */'
      '  COALESCE(MAT_COUNT, 0) AS CNT, /* '#1050#1086#1083'-'#1074#1086' */'
      
        '  COALESCE((SELECT SUM(MAT_COUNT) FROM materialcard_act where id' +
        '=data_estimate.ID_TABLES), 0) AS CntDone, /* '#1042#1099#1087#1086#1083#1085#1077#1085#1086' */'
      
        '  COALESCE((COALESCE(MAT_COUNT, 0) - COALESCE((SELECT SUM(MAT_CO' +
        'UNT) FROM materialcard_act where id=data_estimate.ID_TABLES), 0)' +
        '), 0) AS CntOut /* '#1054#1089#1090#1072#1090#1086#1082' */'
      'FROM '
      '  data_estimate, card_rate, materialcard'
      'WHERE '
      'data_estimate.ID_TYPE_DATA = 1 AND'
      'card_rate.ID = data_estimate.ID_TABLES AND'
      'materialcard.ID_CARD_RATE = card_rate.ID AND'
      'materialcard.FROM_RATE = 1 AND'
      '((ID_ESTIMATE = :SM_ID) OR /* '#1054#1073#1098#1077#1082#1090#1085#1099#1081' '#1091#1088#1086#1074#1077#1085#1100' */'
      
        ' (ID_ESTIMATE IN (SELECT s1.SM_ID FROM smetasourcedata s1 WHERE ' +
        '(s1.PARENT_LOCAL_ID + s1.PARENT_PTM_ID) = :SM_ID)) OR /* '#1051#1086#1082#1072#1083#1100#1085 +
        #1099#1081' '#1091#1088#1086#1074#1077#1085#1100' */'
      
        ' (ID_ESTIMATE IN (SELECT s2.SM_ID FROM smetasourcedata s2 WHERE ' +
        '(s2.PARENT_LOCAL_ID + s2.PARENT_PTM_ID) IN '
      
        '   (SELECT s1.SM_ID FROM smetasourcedata s1 WHERE (s1.PARENT_LOC' +
        'AL_ID + s1.PARENT_PTM_ID) = :SM_ID))'
      ' ) /* '#1055#1058#1052' '#1091#1088#1086#1074#1077#1085#1100' */'
      ')'
      ''
      'UNION ALL'
      ''
      '/* '#1052#1040#1058#1045#1056#1048#1040#1051#1067'*/'
      'SELECT '
      '  ID_ESTIMATE,'
      '  ID_TYPE_DATA,'
      '  materialcard.ID AS ID_TABLES,'
      '  MAT_CODE AS CODE, /* '#1054#1073#1086#1089#1085#1086#1074#1072#1085#1080#1077'*/'
      '  MAT_NAME AS NAME, /* '#1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' */'
      '  MAT_UNIT AS UNIT, /* '#1045#1076'. '#1080#1079#1084#1077#1088#1077#1085#1080#1103' */'
      '  COALESCE(MAT_COUNT, 0) AS CNT, /* '#1050#1086#1083'-'#1074#1086' */'
      
        '  COALESCE((SELECT SUM(MAT_COUNT) FROM materialcard_act where id' +
        '=data_estimate.ID_TABLES), 0) AS CntDone, /* '#1042#1099#1087#1086#1083#1085#1077#1085#1086' */'
      
        '  COALESCE((COALESCE(MAT_COUNT, 0) - COALESCE((SELECT SUM(MAT_CO' +
        'UNT) FROM materialcard_act where id=data_estimate.ID_TABLES), 0)' +
        '), 0) AS CntOut /* '#1054#1089#1090#1072#1090#1086#1082' */'
      'FROM '
      '  data_estimate, materialcard'
      'WHERE '
      'data_estimate.ID_TYPE_DATA = 2 AND'
      'materialcard.ID = data_estimate.ID_TABLES AND'
      '((ID_ESTIMATE = :SM_ID) OR /* '#1054#1073#1098#1077#1082#1090#1085#1099#1081' '#1091#1088#1086#1074#1077#1085#1100' */'
      
        ' (ID_ESTIMATE IN (SELECT s1.SM_ID FROM smetasourcedata s1 WHERE ' +
        '(s1.PARENT_LOCAL_ID + s1.PARENT_PTM_ID) = :SM_ID)) OR /* '#1051#1086#1082#1072#1083#1100#1085 +
        #1099#1081' '#1091#1088#1086#1074#1077#1085#1100' */'
      
        ' (ID_ESTIMATE IN (SELECT s2.SM_ID FROM smetasourcedata s2 WHERE ' +
        '(s2.PARENT_LOCAL_ID + s2.PARENT_PTM_ID) IN '
      
        '   (SELECT s1.SM_ID FROM smetasourcedata s1 WHERE (s1.PARENT_LOC' +
        'AL_ID + s1.PARENT_PTM_ID) = :SM_ID))'
      ' ) /* '#1055#1058#1052' '#1091#1088#1086#1074#1077#1085#1100' */'
      ')'
      '/* '#1052#1045#1061#1040#1053#1048#1047#1052#1067' */'
      'ORDER BY 1,2'
      '')
    Left = 64
    Top = 160
    ParamData = <
      item
        Name = 'SM_ID'
        DataType = ftLongWord
        ParamType = ptInput
        Size = 4
        Value = 298
      end>
  end
  object dsMaterialData: TDataSource
    DataSet = qrMaterialData
    Left = 136
    Top = 160
  end
end
