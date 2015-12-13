object FormReportC2B: TFormReportC2B
  Left = 0
  Top = 0
  Caption = #1054#1090#1095#1077#1090' '#1057'2-'#1041
  ClientHeight = 403
  ClientWidth = 857
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
  object pnlObject: TPanel
    Left = 0
    Top = 0
    Width = 857
    Height = 96
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    ExplicitWidth = 783
    object gbObject: TGroupBox
      Left = 1
      Top = 1
      Width = 855
      Height = 94
      Align = alClient
      Caption = ' '#1054#1073#1098#1077#1082#1090' '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      ExplicitWidth = 781
      DesignSize = (
        855
        94)
      object lbObjContNum: TLabel
        Left = 486
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
        ExplicitLeft = 412
      end
      object lbObjContDate: TLabel
        Left = 601
        Top = 9
        Width = 81
        Height = 13
        Anchors = [akTop, akRight]
        Caption = #1044#1072#1090#1072' '#1076#1086#1075#1086#1074#1086#1088#1072':'
        ExplicitLeft = 527
      end
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
      object btnObjInfo: TSpeedButton
        Left = 713
        Top = 23
        Width = 108
        Height = 21
        Action = actObjectUpdate
        Anchors = [akTop, akRight]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsUnderline]
        ParentFont = False
        OnClick = btnObjInfoClick
        ExplicitLeft = 639
      end
      object Bevel1: TBevel
        Left = 11
        Top = 51
        Width = 833
        Height = 14
        Anchors = [akLeft, akTop, akRight]
        Shape = bsTopLine
        ExplicitWidth = 759
      end
      object lbDateSmetDocTitle: TLabel
        Left = 12
        Top = 57
        Width = 216
        Height = 13
        Anchors = [akTop, akRight]
        Caption = #1044#1072#1090#1072' '#1088#1072#1079#1088#1072#1073#1086#1090#1082#1080' '#1089#1084#1077#1090#1085#1086#1081' '#1076#1086#1082#1091#1084#1077#1085#1090#1072#1094#1080#1080':'
        ExplicitLeft = 11
      end
      object lbDateBegStrojTitle: TLabel
        Left = 12
        Top = 76
        Width = 152
        Height = 13
        Anchors = [akTop, akRight]
        Caption = #1044#1072#1090#1072' '#1085#1072#1095#1072#1083#1072' '#1089#1090#1088#1086#1080#1090#1077#1083#1100#1089#1090#1074#1072':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ExplicitLeft = 11
      end
      object lbDateSmetDoc: TLabel
        Left = 230
        Top = 57
        Width = 109
        Height = 13
        Anchors = [akTop, akRight]
        AutoSize = False
        Caption = 'lbDateSmetDoc'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitLeft = 229
      end
      object lbDateBegStroj: TLabel
        Left = 230
        Top = 76
        Width = 109
        Height = 13
        Anchors = [akTop, akRight]
        AutoSize = False
        Caption = 'lbDateBegStroj'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitLeft = 229
      end
      object lbSrokStrojTitle: TLabel
        Left = 345
        Top = 57
        Width = 125
        Height = 13
        Anchors = [akTop, akRight]
        Caption = #1057#1088#1086#1082' '#1089#1090#1088#1086#1080#1090#1077#1083#1100#1089#1090#1074#1072', '#1084':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ExplicitLeft = 344
      end
      object lbDateEndStrojTitle: TLabel
        Left = 345
        Top = 76
        Width = 170
        Height = 13
        Anchors = [akTop, akRight]
        Caption = #1044#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103' '#1089#1090#1088#1086#1080#1090#1077#1083#1100#1089#1090#1074#1072':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ExplicitLeft = 344
      end
      object lbSrokStroj: TLabel
        Left = 518
        Top = 57
        Width = 109
        Height = 13
        Anchors = [akTop, akRight]
        AutoSize = False
        Caption = 'lbSrokStroj'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitLeft = 517
      end
      object lbDateEndStroj: TLabel
        Left = 518
        Top = 76
        Width = 109
        Height = 13
        Anchors = [akTop, akRight]
        AutoSize = False
        Caption = 'lbDateEndStroj'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitLeft = 517
      end
      object lbPIBeginTitle: TLabel
        Left = 632
        Top = 57
        Width = 151
        Height = 13
        Anchors = [akTop, akRight]
        Caption = #1055#1048' '#1085#1072' '#1085#1072#1095#1072#1083#1086' '#1089#1090#1088#1086#1080#1090#1077#1083#1100#1089#1090#1074#1072':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ExplicitLeft = 631
      end
      object lbPIBegin: TLabel
        Left = 788
        Top = 57
        Width = 109
        Height = 13
        Anchors = [akTop, akRight]
        AutoSize = False
        Caption = 'lbPIBegin'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitLeft = 787
      end
      object cbObjName: TDBLookupComboBox
        Left = 72
        Top = 24
        Width = 405
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
        TabOrder = 0
        OnClick = cbObjNameClick
        ExplicitWidth = 331
      end
      object edtObjContNum: TEdit
        Left = 483
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
        Text = 'edtObjContNum'
        ExplicitLeft = 409
      end
      object edtObjContDate: TEdit
        Left = 598
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
        TabOrder = 2
        Text = 'edtObjContDate'
        ExplicitLeft = 524
      end
    end
  end
  object pcReportType: TPageControl
    Left = 0
    Top = 96
    Width = 857
    Height = 307
    ActivePage = tsRepAct
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnChange = pcReportTypeChange
    ExplicitWidth = 783
    object tsRepObj: TTabSheet
      Caption = #1055#1086' '#1086#1073#1098#1077#1082#1090#1091
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ImageIndex = 1
      ParentFont = False
      ExplicitWidth = 775
      object pnlRepObj: TPanel
        Left = 0
        Top = 0
        Width = 849
        Height = 279
        Align = alClient
        BevelKind = bkTile
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 0
        ExplicitWidth = 775
        object pnlRepObjDate: TPanel
          Left = 0
          Top = 0
          Width = 845
          Height = 36
          Align = alTop
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          ExplicitWidth = 771
          DesignSize = (
            845
            36)
          object lbShowTypeTitle: TLabel
            Left = 605
            Top = 10
            Width = 107
            Height = 13
            Anchors = [akTop, akRight]
            Caption = #1056#1077#1078#1080#1084' '#1086#1090#1086#1073#1088#1072#1078#1077#1085#1080#1103':'
            ExplicitLeft = 531
          end
          object lbRepObjDataTitle: TLabel
            Left = 13
            Top = 10
            Width = 59
            Height = 13
            Caption = #1044#1072#1085#1085#1099#1077' '#1087#1086':'
          end
          object cbShowType: TComboBox
            Left = 717
            Top = 7
            Width = 99
            Height = 21
            Style = csDropDownList
            Anchors = [akTop, akRight]
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ItemIndex = 0
            ParentFont = False
            TabOrder = 0
            Text = #1055#1086' '#1055#1058#1052
            Items.Strings = (
              #1055#1086' '#1055#1058#1052
              #1055#1086' '#1083#1086#1082#1072#1083#1100#1085#1086#1081
              #1055#1086' '#1086#1073#1098#1077#1082#1090#1085#1086#1081)
            ExplicitLeft = 643
          end
          object cbRepObjMonth: TComboBox
            Left = 78
            Top = 7
            Width = 98
            Height = 21
            Style = csDropDownList
            DropDownCount = 12
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ItemIndex = 8
            ParentFont = False
            TabOrder = 1
            Text = #1057#1077#1085#1090#1103#1073#1088#1100
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
          object seRepObjYear: TSpinEdit
            Left = 182
            Top = 7
            Width = 50
            Height = 22
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxValue = 2100
            MinValue = 2012
            ParentFont = False
            TabOrder = 2
            Value = 2015
          end
        end
      end
    end
    object tsRepAct: TTabSheet
      Caption = #1055#1086' '#1072#1082#1090#1091
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ImageIndex = 2
      ParentFont = False
      ExplicitWidth = 775
      object pnlRepAct: TPanel
        Left = 0
        Top = 0
        Width = 849
        Height = 279
        Align = alClient
        BevelKind = bkTile
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 0
        ExplicitWidth = 775
        object pnlRepActDate: TPanel
          Left = 0
          Top = 0
          Width = 845
          Height = 36
          Align = alTop
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          ExplicitWidth = 771
          object lbRepActTitle: TLabel
            Left = 13
            Top = 10
            Width = 157
            Height = 13
            Caption = #1056#1072#1073#1086#1090#1099' '#1074#1099#1087#1086#1083#1085#1077#1085#1085#1099#1077' '#1087#1086' '#1072#1082#1090#1091':'
          end
          object cbActs: TDBLookupComboBox
            Left = 176
            Top = 7
            Width = 377
            Height = 21
            KeyField = 'SM_ID'
            ListField = 'NAME'
            ListSource = dsActs
            TabOrder = 0
          end
        end
      end
    end
    object tsRegActs: TTabSheet
      Caption = #1056#1077#1077#1089#1090#1088' '#1072#1082#1090#1086#1074
      ImageIndex = 2
      ExplicitWidth = 775
    end
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
      '    srok_stroj'
      'FROM objcards '
      'WHERE (DEL_FLAG=0) AND'
      '      ((:USER_ID=1) OR '
      '       (objcards.USER_ID=:USER_ID) OR '
      
        '       EXISTS(SELECT USER_ID FROM user_access WHERE DOC_TYPE_ID=' +
        '2 AND MASTER_ID=objcards.obj_id AND ((USER_ID=0) OR (USER_ID=:US' +
        'ER_ID)) LIMIT 1))'
      'ORDER BY num, num_dog, full_name')
    Left = 729
    Top = 171
    ParamData = <
      item
        Name = 'USER_ID'
        ParamType = ptInput
      end>
  end
  object dsObject: TDataSource
    DataSet = qrObject
    Left = 680
    Top = 171
  end
  object ActionList1: TActionList
    Left = 623
    Top = 171
    object actObjectUpdate: TAction
      Caption = #1050#1072#1088#1090#1086#1095#1082#1072' '#1086#1073#1098#1077#1082#1090#1072
      OnUpdate = actObjectUpdateUpdate
    end
  end
  object qrActs: TFDQuery
    MasterSource = dsObject
    MasterFields = 'obj_id'
    Connection = DM.Connect
    SQL.Strings = (
      'SELECT SM_ID, ACT, OBJ_ID, DATE, NAME, TYPE_ACT'
      'FROM smetasourcedata'
      'WHERE SM_TYPE=2'
      '  AND OBJ_ID=:OBJ_ID'
      '  AND ACT=1'
      'ORDER BY DATE, NAME ')
    Left = 732
    Top = 240
    ParamData = <
      item
        Name = 'OBJ_ID'
        ParamType = ptInput
      end>
  end
  object dsActs: TDataSource
    DataSet = qrActs
    Left = 684
    Top = 240
  end
end
