object FormReportC2B: TFormReportC2B
  Left = 0
  Top = 0
  Caption = #1054#1090#1095#1077#1090' '#1057'2-'#1041
  ClientHeight = 482
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
  OnResize = FormResize
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
        Width = 212
        Height = 13
        Anchors = [akTop, akRight]
        Caption = #1044#1072#1090#1072' '#1088#1072#1079#1088#1072#1073#1086#1090#1082#1080' '#1089#1084#1077#1090#1085#1086#1081' '#1076#1086#1082#1091#1084#1077#1085#1090#1072#1094#1080#1080':'
      end
      object lbDateBegStrojTitle: TLabel
        Left = 12
        Top = 76
        Width = 148
        Height = 13
        Anchors = [akTop, akRight]
        Caption = #1044#1072#1090#1072' '#1085#1072#1095#1072#1083#1072' '#1089#1090#1088#1086#1080#1090#1077#1083#1100#1089#1090#1074#1072':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
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
        Width = 121
        Height = 13
        Anchors = [akTop, akRight]
        Caption = #1057#1088#1086#1082' '#1089#1090#1088#1086#1080#1090#1077#1083#1100#1089#1090#1074#1072', '#1084':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lbDateEndStrojTitle: TLabel
        Left = 345
        Top = 76
        Width = 166
        Height = 13
        Anchors = [akTop, akRight]
        Caption = #1044#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103' '#1089#1090#1088#1086#1080#1090#1077#1083#1100#1089#1090#1074#1072':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
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
      end
    end
  end
  object pcReportType: TPageControl
    Left = 0
    Top = 96
    Width = 857
    Height = 386
    ActivePage = tsRegActs
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnChange = pcReportTypeChange
    object tsRepAct: TTabSheet
      Caption = #1055#1086' '#1072#1082#1090#1091
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ImageIndex = 2
      ParentFont = False
      object pnlRepAct: TPanel
        Left = 0
        Top = 0
        Width = 849
        Height = 358
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
          DesignSize = (
            845
            36)
          object lbRepActTitle: TLabel
            Left = 13
            Top = 10
            Width = 157
            Height = 13
            Caption = #1056#1072#1073#1086#1090#1099' '#1074#1099#1087#1086#1083#1085#1077#1085#1085#1099#1077' '#1087#1086' '#1072#1082#1090#1091':'
          end
          object lbShowTypeTitle: TLabel
            Left = 605
            Top = 10
            Width = 107
            Height = 13
            Anchors = [akTop, akRight]
            Caption = #1056#1077#1078#1080#1084' '#1086#1090#1086#1073#1088#1072#1078#1077#1085#1080#1103':'
            ExplicitLeft = 531
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
            OnClick = cbShowTypeClick
          end
          object cbShowType: TDBLookupComboBox
            Left = 716
            Top = 7
            Width = 100
            Height = 21
            Anchors = [akTop, akRight]
            KeyField = 'CONTRACT_PRICE_TYPE_ID'
            ListField = 'CONTRACT_PRICE_TYPE_NAME'
            ListSource = dsCONTRACT_PRICE_TYPE
            TabOrder = 1
            OnClick = cbShowTypeClick
          end
        end
        object pnlGrids: TPanel
          Left = 0
          Top = 36
          Width = 845
          Height = 285
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          object grLeft: TJvDBGrid
            Left = 1
            Top = 1
            Width = 587
            Height = 283
            Align = alLeft
            DataSource = dsLeft
            DefaultDrawing = False
            DrawingStyle = gdsClassic
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
            ParentFont = False
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'Tahoma'
            TitleFont.Style = []
            OnDrawColumnCell = grLeftDrawColumnCell
            AutoAppend = False
            AutoSort = False
            AutoSizeColumns = True
            AutoSizeColumnIndex = 0
            SelectColumnsDialogStrings.Caption = 'Select columns'
            SelectColumnsDialogStrings.OK = '&OK'
            SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
            CanDelete = False
            EditControls = <>
            RowsHeight = 17
            TitleRowHeight = 17
            Columns = <
              item
                Expanded = False
                FieldName = 'SmName'
                Title.Alignment = taCenter
                Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1101#1083#1077#1084#1077#1085#1090#1072
                Width = 184
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'Unit'
                Title.Alignment = taCenter
                Title.Caption = #1045#1076'. '#1080#1079#1084'.'
                Width = 58
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'SmCount'
                Title.Alignment = taCenter
                Title.Caption = #1050#1086#1083'-'#1074#1086
                Width = 80
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'SmTotalPrice'
                Title.Alignment = taCenter
                Title.Caption = #1042#1089#1077#1075#1086
                Width = 100
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'ActCount'
                Title.Alignment = taCenter
                Title.Caption = #1050#1086#1083'-'#1074#1086
                Width = 80
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'ActTotalPrice'
                Title.Alignment = taCenter
                Title.Caption = #1055#1086' '#1072#1082#1090#1091
                Width = 100
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'AllActsCount'
                Title.Alignment = taCenter
                Title.Caption = #1050#1086#1083'-'#1074#1086
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'AllActsTotalPrice'
                Title.Alignment = taCenter
                Title.Caption = #1057' '#1085#1072#1095#1072#1083#1072' '#1089#1090#1088'-'#1074#1072
                Width = 100
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'ManthActsCount'
                Title.Alignment = taCenter
                Title.Caption = #1050#1086#1083'-'#1074#1086
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'ManthActsTotalPrice'
                Title.Alignment = taCenter
                Title.Caption = #1047#1072' '#1084#1077#1089#1103#1094
                Width = 100
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'RestPrice'
                Title.Alignment = taCenter
                Title.Caption = #1054#1089#1090#1072#1090#1086#1082
                Width = 100
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'DevFromBeg'
                Title.Alignment = taCenter
                Title.Caption = #1054#1090#1082#1083'. '#1089' '#1085#1072#1095'. '#1089#1090#1088'-'#1074#1072
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'DevForMonth'
                Title.Alignment = taCenter
                Title.Caption = #1054#1090#1082#1083'. '#1079#1072' '#1084#1077#1089#1103#1094
                Width = 100
                Visible = True
              end>
          end
          object grRight: TJvDBGrid
            AlignWithMargins = True
            Left = 590
            Top = 1
            Width = 254
            Height = 283
            Margins.Left = 2
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            Align = alClient
            DataSource = dsRight
            DrawingStyle = gdsClassic
            ReadOnly = True
            TabOrder = 1
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'Tahoma'
            TitleFont.Style = []
            AutoSort = False
            AutoSizeColumns = True
            AutoSizeColumnIndex = 1
            SelectColumnsDialogStrings.Caption = 'Select columns'
            SelectColumnsDialogStrings.OK = '&OK'
            SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
            EditControls = <>
            RowsHeight = 17
            TitleRowHeight = 17
            Columns = <
              item
                Expanded = False
                FieldName = 'Num'
                Title.Caption = #8470
                Width = 20
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'DevItem'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                Title.Alignment = taCenter
                Title.Caption = #1057#1090#1072#1090#1100#1080' '#1086#1090#1082#1083#1086#1085#1077#1085#1080#1081
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'ActSumm'
                Title.Alignment = taCenter
                Title.Caption = #1057#1091#1084#1084#1072
                Width = 100
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'AllSumm'
                Title.Alignment = taCenter
                Title.Caption = #1057' '#1085#1072#1095#1072#1083#1072' '#1089#1090#1088'-'#1074#1072
                Width = 100
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'ManthSumm'
                Title.Alignment = taCenter
                Title.Caption = #1047#1072' '#1084#1077#1089#1103#1094
                Width = 100
                Visible = True
              end>
          end
        end
        object pnlMemos: TPanel
          Left = 0
          Top = 321
          Width = 845
          Height = 33
          Align = alBottom
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          ExplicitTop = 313
          ExplicitHeight = 41
          object memLeft: TDBMemo
            Left = 1
            Top = 1
            Width = 587
            Height = 31
            Align = alLeft
            DataField = 'SmName'
            DataSource = dsLeft
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
            ExplicitHeight = 39
          end
          object memRight: TDBMemo
            AlignWithMargins = True
            Left = 590
            Top = 1
            Width = 254
            Height = 31
            Margins.Left = 2
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            Align = alClient
            DataField = 'DevItem'
            DataSource = dsRight
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 1
            ExplicitTop = 16
            ExplicitHeight = 24
          end
        end
      end
    end
    object tsRepObj: TTabSheet
      Caption = #1055#1086' '#1086#1073#1098#1077#1082#1090#1091
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ImageIndex = 1
      ParentFont = False
      object pnlRepObj: TPanel
        Left = 0
        Top = 0
        Width = 849
        Height = 358
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
          object lbRepObjDataTitle: TLabel
            Left = 13
            Top = 10
            Width = 59
            Height = 13
            Caption = #1044#1072#1085#1085#1099#1077' '#1087#1086':'
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
            TabOrder = 0
            Text = #1057#1077#1085#1090#1103#1073#1088#1100
            OnChange = DateChange
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
            TabOrder = 1
            Value = 2015
            OnChange = DateChange
          end
        end
      end
    end
    object tsRegActs: TTabSheet
      Caption = #1056#1077#1077#1089#1090#1088' '#1072#1082#1090#1086#1074
      ImageIndex = 2
      object pnlRegActs: TPanel
        Left = 0
        Top = 0
        Width = 849
        Height = 358
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
        object pnlRegActsDate: TPanel
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
          object lbRegActsDataTitle: TLabel
            Left = 13
            Top = 10
            Width = 59
            Height = 13
            Caption = #1044#1072#1085#1085#1099#1077' '#1087#1086':'
          end
          object cbRegActsMonth: TComboBox
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
            TabOrder = 0
            Text = #1057#1077#1085#1090#1103#1073#1088#1100
            OnChange = DateChange
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
          object seRegActsYear: TSpinEdit
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
            TabOrder = 1
            Value = 2015
            OnChange = DateChange
          end
        end
        object grRegActs: TJvDBGrid
          AlignWithMargins = True
          Left = 1
          Top = 37
          Width = 843
          Height = 279
          Margins.Left = 1
          Margins.Top = 1
          Margins.Right = 1
          Margins.Bottom = 1
          Align = alClient
          DataSource = dsRegActs
          DrawingStyle = gdsClassic
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          AutoSort = False
          AutoSizeColumnIndex = 1
          SelectColumnsDialogStrings.Caption = 'Select columns'
          SelectColumnsDialogStrings.OK = '&OK'
          SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
          EditControls = <>
          RowsHeight = 17
          TitleRowHeight = 17
          Columns = <
            item
              Expanded = False
              FieldName = 'Num'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              Title.Caption = #8470
              Width = 20
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DevItem'
              Title.Alignment = taCenter
              Title.Caption = #1057#1090#1072#1090#1100#1080' '#1086#1090#1082#1083#1086#1085#1077#1085#1080#1081
              Width = 251
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'AllSumm'
              Title.Alignment = taCenter
              Title.Caption = #1057' '#1085#1072#1095#1072#1083#1072' '#1089#1090#1088'-'#1074#1072
              Width = 100
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'YearSumm'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              Title.Alignment = taCenter
              Title.Caption = #1057' '#1085#1072#1095#1072#1083#1072' '#1075#1086#1076#1072
              Width = 100
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'ManthSumm'
              Title.Alignment = taCenter
              Title.Caption = #1047#1072' '#1084#1077#1089#1103#1094
              Width = 100
              Visible = True
            end>
        end
        object memRegActs: TDBMemo
          AlignWithMargins = True
          Left = 1
          Top = 319
          Width = 843
          Height = 34
          Margins.Left = 1
          Margins.Top = 2
          Margins.Right = 1
          Margins.Bottom = 1
          Align = alBottom
          DataField = 'DevItem'
          DataSource = dsRegActs
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 2
          ExplicitLeft = 2
          ExplicitTop = 320
        end
      end
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
      '    srok_stroj,'
      
        '    FN_getIndex(beg_stroj, DATE_ADD(beg_stroj2, INTERVAL -1 MONT' +
        'H), 1) as pibeg,'
      
        '    FN_getIndex(beg_stroj2, DATE_ADD(beg_stroj2, INTERVAL +srok_' +
        'stroj MONTH), 1) as piend,'
      '    CONTRACT_PRICE_TYPE_ID'
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
        Value = Null
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
  object mtLeft: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    StoreDefs = True
    Left = 244
    Top = 284
    object mtLeftSmName: TStringField
      FieldName = 'SmName'
      Size = 100
    end
    object mtLeftUnit: TStringField
      FieldName = 'Unit'
    end
    object mtLeftSmCount: TFloatField
      FieldName = 'SmCount'
    end
    object mtLeftSmTotalPrice: TCurrencyField
      DisplayWidth = 10
      FieldName = 'SmTotalPrice'
      DisplayFormat = '#,0'
      currency = False
    end
    object mtLeftActCount: TFloatField
      FieldName = 'ActCount'
    end
    object mtLeftActTotalPrice: TCurrencyField
      FieldName = 'ActTotalPrice'
      DisplayFormat = '#,0'
      currency = False
    end
    object mtLeftAllActsCount: TFloatField
      FieldName = 'AllActsCount'
    end
    object mtLeftAllActsTotalPrice: TCurrencyField
      FieldName = 'AllActsTotalPrice'
      DisplayFormat = '#,0'
      currency = False
    end
    object mtLeftManthActsCount: TFloatField
      FieldName = 'ManthActsCount'
    end
    object mtLeftManthActsTotalPrice: TCurrencyField
      FieldName = 'ManthActsTotalPrice'
      DisplayFormat = '#,0'
      currency = False
    end
    object mtLeftRestPrice: TCurrencyField
      FieldName = 'RestPrice'
      DisplayFormat = '#,0'
      currency = False
    end
    object mtLeftDevFromBeg: TCurrencyField
      FieldName = 'DevFromBeg'
      DisplayFormat = '#,0'
      currency = False
    end
    object mtLeftDevForMonth: TCurrencyField
      FieldName = 'DevForMonth'
      DisplayFormat = '#,0'
      currency = False
    end
    object mtLeftSmId: TIntegerField
      FieldName = 'SmId'
    end
    object mtLeftSmType: TIntegerField
      FieldName = 'SmType'
    end
  end
  object mtRight: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    StoreDefs = True
    Left = 348
    Top = 276
    object mtRightNum: TIntegerField
      FieldName = 'Num'
    end
    object mtRightDevItem: TStringField
      FieldName = 'DevItem'
      Size = 150
    end
    object mtRightActSumm: TCurrencyField
      FieldName = 'ActSumm'
      DisplayFormat = '#,0'
      currency = False
    end
    object mtRightAllSumm: TCurrencyField
      FieldName = 'AllSumm'
      DisplayFormat = '#,0'
      currency = False
    end
    object mtRightManthSumm: TCurrencyField
      FieldName = 'ManthSumm'
      DisplayFormat = '#,0'
      currency = False
    end
  end
  object dsLeft: TDataSource
    DataSet = mtLeft
    Left = 248
    Top = 336
  end
  object dsRight: TDataSource
    DataSet = mtRight
    Left = 352
    Top = 336
  end
  object qrTemp1: TFDQuery
    Connection = DM.Connect
    Left = 516
    Top = 236
  end
  object dsCONTRACT_PRICE_TYPE: TDataSource
    DataSet = qrCONTRACT_PRICE_TYPE
    Left = 688
    Top = 320
  end
  object qrCONTRACT_PRICE_TYPE: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FetchOptions.AssignedValues = [evCache]
    FetchOptions.Cache = [fiBlobs, fiMeta]
    FormatOptions.AssignedValues = [fvMapRules, fvDefaultParamDataType, fvFmtDisplayNumeric, fvFmtEditNumeric]
    FormatOptions.OwnMapRules = True
    FormatOptions.MapRules = <>
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvCheckReadOnly]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.CheckReadOnly = False
    SQL.Strings = (
      'select * from CONTRACT_PRICE_TYPE '
      'WHERE CONTRACT_PRICE_TYPE_ID >= :CONTRACT_PRICE_TYPE_ID'
      'ORDER BY CONTRACT_PRICE_TYPE_ID')
    Left = 737
    Top = 304
    ParamData = <
      item
        Name = 'CONTRACT_PRICE_TYPE_ID'
        ParamType = ptInput
      end>
  end
  object mtRegActs: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    StoreDefs = True
    Left = 428
    Top = 276
    object mtRegActsNum: TIntegerField
      FieldName = 'Num'
    end
    object mtRegActsDevItem: TStringField
      FieldName = 'DevItem'
      Size = 150
    end
    object mtRegActsAllSumm: TCurrencyField
      FieldName = 'AllSumm'
      DisplayFormat = '#,0'
      currency = False
    end
    object mtRegActsYearSumm: TCurrencyField
      FieldName = 'YearSumm'
      DisplayFormat = '#,0'
      currency = False
    end
    object mtRegActsManthSumm: TCurrencyField
      FieldName = 'ManthSumm'
      DisplayFormat = '#,0'
      currency = False
    end
    object mtRegActsOwnAct1: TCurrencyField
      FieldName = 'OwnAct1'
      DisplayFormat = '#,0'
      currency = False
    end
    object mtRegActsOwnAct2: TCurrencyField
      FieldName = 'OwnAct2'
      DisplayFormat = '#,0'
      currency = False
    end
    object mtRegActsOwnAct3: TCurrencyField
      FieldName = 'OwnAct3'
      DisplayFormat = '#,0'
      currency = False
    end
    object mtRegActsOwnAct4: TCurrencyField
      FieldName = 'OwnAct4'
      DisplayFormat = '#,0'
      currency = False
    end
    object mtRegActsOwnAct5: TCurrencyField
      FieldName = 'OwnAct5'
      DisplayFormat = '#,0'
      currency = False
    end
    object mtRegActsOwnAct6: TCurrencyField
      FieldName = 'OwnAct6'
      DisplayFormat = '#,0'
      currency = False
    end
    object mtRegActsOwnAct7: TCurrencyField
      FieldName = 'OwnAct7'
      DisplayFormat = '#,0'
      currency = False
    end
    object mtRegActsOwnAct8: TCurrencyField
      FieldName = 'OwnAct8'
      DisplayFormat = '#,0'
      currency = False
    end
    object mtRegActsOwnAct9: TCurrencyField
      FieldName = 'OwnAct9'
      DisplayFormat = '#,0'
      currency = False
    end
    object mtRegActsOwnAct10: TCurrencyField
      FieldName = 'OwnAct10'
      DisplayFormat = '#,0'
      currency = False
    end
    object mtRegActsOwnAct11: TCurrencyField
      FieldName = 'OwnAct11'
      DisplayFormat = '#,0'
      currency = False
    end
    object mtRegActsOwnAct12: TCurrencyField
      FieldName = 'OwnAct12'
      DisplayFormat = '#,0'
      currency = False
    end
    object mtRegActsOwnAct13: TCurrencyField
      FieldName = 'OwnAct13'
      DisplayFormat = '#,0'
      currency = False
    end
    object mtRegActsOwnAct14: TCurrencyField
      FieldName = 'OwnAct14'
      DisplayFormat = '#,0'
      currency = False
    end
    object mtRegActsOwnAct15: TCurrencyField
      FieldName = 'OwnAct15'
      DisplayFormat = '#,0'
      currency = False
    end
    object mtRegActsOwnActs: TCurrencyField
      FieldName = 'OwnActs'
      DisplayFormat = '#,0'
      currency = False
    end
    object mtRegActsSubAct1: TCurrencyField
      FieldName = 'SubAct1'
      DisplayFormat = '#,0'
      currency = False
    end
    object mtRegActsSubAct2: TCurrencyField
      FieldName = 'SubAct2'
      DisplayFormat = '#,0'
      currency = False
    end
    object mtRegActsSubAct3: TCurrencyField
      FieldName = 'SubAct3'
      DisplayFormat = '#,0'
      currency = False
    end
    object mtRegActsSubAct4: TCurrencyField
      FieldName = 'SubAct4'
      DisplayFormat = '#,0'
      currency = False
    end
    object mtRegActsSubAct5: TCurrencyField
      FieldName = 'SubAct5'
      DisplayFormat = '#,0'
      currency = False
    end
    object mtRegActsSubAct6: TCurrencyField
      FieldName = 'SubAct6'
      DisplayFormat = '#,0'
      currency = False
    end
    object mtRegActsSubAct7: TCurrencyField
      FieldName = 'SubAct7'
      DisplayFormat = '#,0'
      currency = False
    end
    object mtRegActsSubAct8: TCurrencyField
      FieldName = 'SubAct8'
      DisplayFormat = '#,0'
      currency = False
    end
    object mtRegActsSubAct9: TCurrencyField
      FieldName = 'SubAct9'
      DisplayFormat = '#,0'
      currency = False
    end
    object mtRegActsSubAct10: TCurrencyField
      FieldName = 'SubAct10'
      DisplayFormat = '#,0'
      currency = False
    end
    object mtRegActsSubActs: TCurrencyField
      FieldName = 'SubActs'
      DisplayFormat = '#,0'
      currency = False
    end
  end
  object dsRegActs: TDataSource
    DataSet = mtRegActs
    Left = 432
    Top = 336
  end
end
