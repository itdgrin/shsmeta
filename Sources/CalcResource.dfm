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
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 616
    Height = 32
    Align = alTop
    TabOrder = 0
    ExplicitTop = -6
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
    ActivePage = ts5
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    MultiLine = True
    ParentFont = False
    PopupMenu = pm
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
        BevelOuter = bvNone
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
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
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
          TabOrder = 3
        end
        object edtMatCodeFilter: TEdit
          Left = 4
          Top = 27
          Width = 121
          Height = 21
          TabOrder = 4
          TextHint = #1055#1086#1080#1089#1082' '#1087#1086' '#1082#1086#1076#1091'...'
          OnChange = edtMatCodeFilterChange
          OnClick = edtMatCodeFilterClick
        end
        object edtMatNameFilter: TEdit
          Left = 131
          Top = 27
          Width = 472
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 5
          TextHint = #1055#1086#1080#1089#1082' '#1087#1086' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1102'...'
          OnChange = edtMatCodeFilterChange
          OnClick = edtMatCodeFilterClick
        end
        object cbbMatNDS: TComboBox
          Left = 536
          Top = 0
          Width = 67
          Height = 21
          Style = csDropDownList
          Anchors = [akTop, akRight]
          DropDownCount = 12
          TabOrder = 2
          OnChange = cbbMatNDSChange
          Items.Strings = (
            #1073#1077#1079' '#1053#1044#1057
            #1089' '#1053#1044#1057)
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
          Caption = #1048#1090#1086#1075#1086':'
          TabOrder = 1
        end
        object grMaterial: TJvDBGrid
          Left = 0
          Top = 0
          Width = 608
          Height = 152
          Align = alClient
          DataSource = dsMaterialData
          DrawingStyle = gdsClassic
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect, dgTitleClick, dgTitleHotTrack]
          ParentFont = False
          PopupMenu = pm
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          MultiSelect = True
          AutoSizeColumns = True
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
              FieldName = 'CODE'
              Title.Alignment = taCenter
              Title.Caption = #1050#1086#1076
              Width = 23
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'NAME'
              Title.Alignment = taCenter
              Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
              Width = 92
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'UNIT'
              Title.Alignment = taCenter
              Title.Caption = #1045#1076'. '#1080#1079#1084'.'
              Width = 28
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CNT'
              Title.Alignment = taCenter
              Title.Caption = #1050#1086#1083'-'#1074#1086
              Width = 26
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'COAST'
              Title.Alignment = taCenter
              Title.Caption = #1062#1077#1085#1072
              Width = 76
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PRICE'
              Title.Alignment = taCenter
              Title.Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100
              Width = 76
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PROC_TRANSP'
              Title.Alignment = taCenter
              Title.Caption = '% '#1090#1088#1072#1085#1089#1087'.'
              Width = 53
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'TRANSP'
              Title.Alignment = taCenter
              Title.Caption = #1058#1088#1072#1085#1089#1087#1086#1088#1090
              Width = 76
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DOC_DATE'
              Title.Alignment = taCenter
              Title.Caption = #1053#1072#1082#1083'. '#1076#1072#1090#1072
              Width = 53
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DOC_NUM'
              Title.Alignment = taCenter
              Title.Caption = #1053#1072#1082#1083'. '#8470
              Width = 79
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
          Align = alTop
          ExplicitTop = 1
          ExplicitWidth = 129
        end
        object grMaterialBott: TJvDBGrid
          Left = 1
          Top = 25
          Width = 606
          Height = 40
          Align = alClient
          Constraints.MinHeight = 40
          DrawingStyle = gdsClassic
          TabOrder = 1
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
              Title.Alignment = taCenter
              Title.Caption = #8470#1087#1087
              Width = 117
              Visible = True
            end
            item
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = #1054#1073#1086#1089#1085#1086#1074#1072#1085#1080#1077
              Width = 117
              Visible = True
            end
            item
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = #1054#1073#1098#1077#1084' '#1088#1072#1073#1086#1090
              Width = 117
              Visible = True
            end
            item
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = #1056#1072#1089#1093#1086#1076
              Width = 117
              Visible = True
            end
            item
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = #1062#1077#1085#1072
              Width = 117
              Visible = True
            end>
        end
        object dbmmoNAME: TDBMemo
          Left = 1
          Top = 1
          Width = 606
          Height = 21
          Align = alTop
          Constraints.MinHeight = 21
          DataField = 'NAME'
          DataSource = dsMaterialData
          ScrollBars = ssVertical
          TabOrder = 0
        end
      end
    end
    object ts3: TTabSheet
      Caption = #1056#1072#1089#1095#1077#1090' '#1084#1077#1093#1072#1085#1080#1079#1084#1086#1074
      ImageIndex = 2
      object spl4: TSplitter
        Left = 0
        Top = 233
        Width = 608
        Height = 3
        Cursor = crVSplit
        Align = alBottom
        ExplicitTop = 224
      end
      object pnlMechClient: TPanel
        Left = 0
        Top = 57
        Width = 608
        Height = 176
        Align = alClient
        BevelOuter = bvNone
        Caption = 'pnlMatClient'
        TabOrder = 1
        object pnl2: TPanel
          Left = 0
          Top = 152
          Width = 608
          Height = 24
          Align = alBottom
          Caption = #1048#1090#1086#1075#1086':'
          TabOrder = 1
        end
        object grMech: TJvDBGrid
          Left = 0
          Top = 0
          Width = 608
          Height = 152
          Align = alClient
          DataSource = dsMechData
          DrawingStyle = gdsClassic
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect, dgTitleClick, dgTitleHotTrack]
          ParentFont = False
          PopupMenu = pm
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          MultiSelect = True
          AutoSizeColumns = True
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
              FieldName = 'CODE'
              Title.Alignment = taCenter
              Title.Caption = #1050#1086#1076
              Width = 38
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'NAME'
              Title.Alignment = taCenter
              Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
              Width = 128
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'UNIT'
              Title.Alignment = taCenter
              Title.Caption = #1045#1076'. '#1080#1079#1084'.'
              Width = 25
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CNT'
              Title.Alignment = taCenter
              Title.Caption = #1050#1086#1083'-'#1074#1086
              Width = 22
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'COAST'
              Title.Alignment = taCenter
              Title.Caption = #1062#1077#1085#1072
              Width = 91
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PRICE'
              Title.Alignment = taCenter
              Title.Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100
              Width = 91
              Visible = True
            end
            item
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = #1047#1072#1088#1087#1083'. '#1084#1072#1096'.'
              Width = 91
              Visible = True
            end
            item
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = #1057#1090'-'#1089#1090#1100' '#1079#1072#1088#1087#1083#1072#1090#1099
              Width = 98
              Visible = True
            end>
        end
      end
      object pnlMechBott: TPanel
        Left = 0
        Top = 236
        Width = 608
        Height = 66
        Align = alBottom
        Caption = 'pnlMatBott'
        TabOrder = 2
        object spl3: TSplitter
          Left = 1
          Top = 22
          Width = 606
          Height = 3
          Cursor = crVSplit
          Align = alTop
          ExplicitTop = 1
          ExplicitWidth = 129
        end
        object grMechBott: TJvDBGrid
          Left = 1
          Top = 25
          Width = 606
          Height = 40
          Align = alClient
          Constraints.MinHeight = 40
          DrawingStyle = gdsClassic
          TabOrder = 1
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
              Title.Alignment = taCenter
              Title.Caption = #8470#1087#1087
              Width = 117
              Visible = True
            end
            item
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = #1054#1073#1086#1089#1085#1086#1074#1072#1085#1080#1077
              Width = 117
              Visible = True
            end
            item
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = #1054#1073#1098#1077#1084' '#1088#1072#1073#1086#1090
              Width = 117
              Visible = True
            end
            item
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = #1056#1072#1089#1093#1086#1076
              Width = 117
              Visible = True
            end
            item
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = #1062#1077#1085#1072
              Width = 117
              Visible = True
            end>
        end
        object dbmmoNAME1: TDBMemo
          Left = 1
          Top = 1
          Width = 606
          Height = 21
          Align = alTop
          Constraints.MinHeight = 21
          DataField = 'NAME'
          DataSource = dsMechData
          ScrollBars = ssVertical
          TabOrder = 0
        end
      end
      object pnlMechTop: TPanel
        Left = 0
        Top = 0
        Width = 608
        Height = 57
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        DesignSize = (
          608
          57)
        object lbl3: TLabel
          Left = 4
          Top = 3
          Width = 87
          Height = 13
          Caption = #1056#1072#1089#1095#1077#1090#1085#1099#1081' '#1084#1077#1089#1103#1094
        end
        object cbb1: TComboBox
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
        object se1: TSpinEdit
          Left = 175
          Top = 0
          Width = 49
          Height = 22
          MaxValue = 2100
          MinValue = 1900
          TabOrder = 1
          Value = 2014
        end
        object chk2: TCheckBox
          Left = 230
          Top = 3
          Width = 179
          Height = 17
          Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1091#1076#1072#1083#1077#1085#1085#1099#1077' '#1079#1085#1072#1095#1077#1085#1080#1103
          TabOrder = 3
        end
        object edtMechCodeFilter: TEdit
          Left = 4
          Top = 27
          Width = 121
          Height = 21
          TabOrder = 4
          TextHint = #1055#1086#1080#1089#1082' '#1087#1086' '#1082#1086#1076#1091'...'
          OnChange = edtMechCodeFilterChange
          OnClick = edtMatCodeFilterClick
        end
        object edtMechNameFilter: TEdit
          Left = 131
          Top = 27
          Width = 472
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 5
          TextHint = #1055#1086#1080#1089#1082' '#1087#1086' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1102'...'
          OnChange = edtMechCodeFilterChange
          OnClick = edtMatCodeFilterClick
        end
        object cbbMechNDS: TComboBox
          Left = 536
          Top = 0
          Width = 67
          Height = 21
          Style = csDropDownList
          Anchors = [akTop, akRight]
          DropDownCount = 12
          TabOrder = 2
          OnChange = cbbMechNDSChange
          Items.Strings = (
            #1073#1077#1079' '#1053#1044#1057
            #1089' '#1053#1044#1057)
        end
      end
    end
    object ts4: TTabSheet
      Caption = #1056#1072#1089#1095#1077#1090' '#1086#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1103
      ImageIndex = 3
      object spl5: TSplitter
        Left = 0
        Top = 233
        Width = 608
        Height = 3
        Cursor = crVSplit
        Align = alBottom
        ExplicitLeft = 3
        ExplicitTop = 225
      end
      object pnl1: TPanel
        Left = 0
        Top = 0
        Width = 608
        Height = 57
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        DesignSize = (
          608
          57)
        object lbl4: TLabel
          Left = 4
          Top = 3
          Width = 87
          Height = 13
          Caption = #1056#1072#1089#1095#1077#1090#1085#1099#1081' '#1084#1077#1089#1103#1094
        end
        object cbb2: TComboBox
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
        object se2: TSpinEdit
          Left = 175
          Top = 0
          Width = 49
          Height = 22
          MaxValue = 2100
          MinValue = 1900
          TabOrder = 1
          Value = 2014
        end
        object chk3: TCheckBox
          Left = 230
          Top = 3
          Width = 179
          Height = 17
          Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1091#1076#1072#1083#1077#1085#1085#1099#1077' '#1079#1085#1072#1095#1077#1085#1080#1103
          TabOrder = 3
        end
        object edt1: TEdit
          Left = 4
          Top = 27
          Width = 121
          Height = 21
          TabOrder = 4
          TextHint = #1055#1086#1080#1089#1082' '#1087#1086' '#1082#1086#1076#1091'...'
          OnChange = edtMechCodeFilterChange
          OnClick = edtMatCodeFilterClick
        end
        object edt2: TEdit
          Left = 131
          Top = 27
          Width = 472
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 5
          TextHint = #1055#1086#1080#1089#1082' '#1087#1086' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1102'...'
          OnChange = edtMechCodeFilterChange
          OnClick = edtMatCodeFilterClick
        end
        object cbb3: TComboBox
          Left = 536
          Top = 0
          Width = 67
          Height = 21
          Style = csDropDownList
          Anchors = [akTop, akRight]
          DropDownCount = 12
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnChange = cbbMechNDSChange
          Items.Strings = (
            #1073#1077#1079' '#1053#1044#1057
            #1089' '#1053#1044#1057)
        end
      end
      object pnl3: TPanel
        Left = 0
        Top = 57
        Width = 608
        Height = 176
        Align = alClient
        BevelOuter = bvNone
        Caption = 'pnlMatClient'
        TabOrder = 1
        object pnl4: TPanel
          Left = 0
          Top = 152
          Width = 608
          Height = 24
          Align = alBottom
          Caption = #1048#1090#1086#1075#1086':'
          TabOrder = 1
        end
        object JvDBGrid1: TJvDBGrid
          Left = 0
          Top = 0
          Width = 608
          Height = 152
          Align = alClient
          DataSource = dsDevices
          DrawingStyle = gdsClassic
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect, dgTitleClick, dgTitleHotTrack]
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          MultiSelect = True
          AutoSizeColumns = True
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
              FieldName = 'CODE'
              Title.Alignment = taCenter
              Title.Caption = #1050#1086#1076
              Width = 58
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'NAME'
              Title.Alignment = taCenter
              Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
              Width = 58
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'UNIT'
              Title.Alignment = taCenter
              Title.Caption = #1045#1076'. '#1080#1079#1084'.'
              Width = 58
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CNT'
              Title.Alignment = taCenter
              Title.Caption = #1050#1086#1083'-'#1074#1086
              Width = 58
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'COAST'
              Title.Alignment = taCenter
              Title.Caption = #1062#1077#1085#1072
              Width = 58
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PRICE'
              Title.Alignment = taCenter
              Title.Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100
              Width = 58
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PROC_TRANSP'
              Title.Alignment = taCenter
              Title.Caption = '% '#1090#1088#1072#1085#1089#1087'.'
              Width = 58
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'TRANSP'
              Title.Alignment = taCenter
              Title.Caption = #1058#1088#1072#1085#1089#1087#1086#1088#1090
              Width = 58
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DOC_DATE'
              Title.Alignment = taCenter
              Title.Caption = #1053#1072#1082#1083'. '#1076#1072#1090#1072
              Width = 58
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DOC_NUM'
              Title.Alignment = taCenter
              Title.Caption = #1053#1072#1082#1083'. '#8470
              Width = 60
              Visible = True
            end>
        end
      end
      object pnl5: TPanel
        Left = 0
        Top = 236
        Width = 608
        Height = 66
        Align = alBottom
        Caption = 'pnlMatBott'
        TabOrder = 2
        object spl6: TSplitter
          Left = 1
          Top = 22
          Width = 606
          Height = 3
          Cursor = crVSplit
          Align = alTop
          ExplicitTop = 1
          ExplicitWidth = 129
        end
        object JvDBGrid2: TJvDBGrid
          Left = 1
          Top = 25
          Width = 606
          Height = 40
          Align = alClient
          Constraints.MinHeight = 40
          DrawingStyle = gdsClassic
          TabOrder = 1
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
              Title.Alignment = taCenter
              Title.Caption = #8470#1087#1087
              Width = 117
              Visible = True
            end
            item
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = #1054#1073#1086#1089#1085#1086#1074#1072#1085#1080#1077
              Width = 117
              Visible = True
            end
            item
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = #1054#1073#1098#1077#1084' '#1088#1072#1073#1086#1090
              Width = 117
              Visible = True
            end
            item
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = #1056#1072#1089#1093#1086#1076
              Width = 117
              Visible = True
            end
            item
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = #1062#1077#1085#1072
              Width = 117
              Visible = True
            end>
        end
        object dbmmoNAME2: TDBMemo
          Left = 1
          Top = 1
          Width = 606
          Height = 21
          Align = alTop
          Constraints.MinHeight = 21
          DataField = 'NAME'
          DataSource = dsDevices
          ScrollBars = ssVertical
          TabOrder = 0
        end
      end
    end
    object ts5: TTabSheet
      Caption = #1056#1072#1089#1095#1077#1090' '#1079#1072#1088#1087#1083#1072#1090#1099
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ImageIndex = 4
      ParentFont = False
      object pnl6: TPanel
        Left = 0
        Top = 0
        Width = 608
        Height = 26
        Align = alTop
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object lbl5: TLabel
          Left = 4
          Top = 4
          Width = 87
          Height = 13
          Caption = #1056#1072#1089#1095#1077#1090#1085#1099#1081' '#1084#1077#1089#1103#1094
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object lbl7: TLabel
          Left = 224
          Top = 4
          Width = 91
          Height = 13
          Caption = #1057#1090#1072#1074#1082#1072' 4 '#1088#1072#1079#1088#1103#1076#1072
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object dbedt1: TDBEdit
          Left = 99
          Top = 1
          Width = 121
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object dbedt2: TDBEdit
          Left = 323
          Top = 1
          Width = 121
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
      end
      object pnl7: TPanel
        Left = 0
        Top = 26
        Width = 608
        Height = 276
        Align = alClient
        Caption = 'pnl7'
        TabOrder = 1
        ExplicitLeft = 296
        ExplicitTop = 136
        ExplicitWidth = 185
        ExplicitHeight = 41
        object JvDBGrid3: TJvDBGrid
          Left = 1
          Top = 1
          Width = 606
          Height = 274
          Align = alClient
          DataSource = dsRates
          DrawingStyle = gdsClassic
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect, dgTitleClick, dgTitleHotTrack]
          ParentFont = False
          PopupMenu = pm
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          MultiSelect = True
          AutoSizeColumns = True
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
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              Title.Alignment = taCenter
              Title.Caption = #8470#1087#1087
              Width = 28
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CODE'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              Title.Alignment = taCenter
              Title.Caption = #1054#1073#1086#1089#1085#1086#1074#1072#1085#1080#1077
              Width = 20
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CNT'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              Title.Alignment = taCenter
              Title.Caption = #1050#1086#1083'-'#1074#1086
              Width = 23
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'UNIT'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              Title.Alignment = taCenter
              Title.Caption = #1045#1076'. '#1080#1079#1084'.'
              Width = 25
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'TRUD_ONE'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              Title.Alignment = taCenter
              Title.Caption = #1058#1088#1091#1076'-'#1090#1099' '#1085#1072' 1'
              Width = 68
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'K_TRUD'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              Title.Alignment = taCenter
              Title.Caption = #1050#1092' '#1082' '#1090#1088#1091#1076
              Width = 68
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'TRUD'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              Title.Alignment = taCenter
              Title.Caption = #1058#1088#1091#1076#1086#1079#1072#1090#1088#1072#1090#1099
              Width = 48
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Rank'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              Title.Alignment = taCenter
              Title.Caption = #1056#1072#1079#1088#1103#1076
              Width = 68
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'MRCOEF'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              Title.Alignment = taCenter
              Title.Caption = #1052#1077#1078#1088#1072#1079#1088'. '#1082#1092
              Width = 48
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Tariff'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              Title.Alignment = taCenter
              Title.Caption = #1058#1072#1088#1080#1092
              Width = 73
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'K_ZP'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              Title.Alignment = taCenter
              Title.Caption = #1050'-'#1092
              Width = 51
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'ZP'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              Title.Caption = #1047#1072#1088#1087#1083#1072#1090#1072
              Width = 58
              Visible = True
            end>
        end
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
  object pm: TPopupMenu
    Left = 572
    Top = 168
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
    MasterSource = dsObject
    MasterFields = 'OBJ_ID'
    DetailFields = 'OBJ_ID'
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
      '/* '#1052#1040#1058#1045#1056#1048#1040#1051#1067' '#1042'\'#1047#1040' '#1056#1040#1057#1062#1045#1053#1050#1045'*/'
      'SELECT '
      '  ID_ESTIMATE,'
      '  ID_TYPE_DATA,'
      '  materialcard.ID AS ID_TABLES,'
      '  smetasourcedata.OBJ_ID,'
      ''
      '  MAT_CODE AS CODE, /* '#1054#1073#1086#1089#1085#1086#1074#1072#1085#1080#1077'*/'
      '  MAT_NAME AS NAME, /* '#1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' */'
      '  MAT_UNIT AS UNIT, /* '#1045#1076'. '#1080#1079#1084#1077#1088#1077#1085#1080#1103' */'
      '  COALESCE(MAT_COUNT, 0) AS CNT, /* '#1050#1086#1083'-'#1074#1086' */'
      ''
      '  DOC_DATE, /* '#1044#1072#1090#1072' '#1076#1086#1082#1091#1084#1077#1085#1090#1072' */'
      '  DOC_NUM, /* '#1053#1086#1084#1077#1088' '#1076#1086#1082#1091#1084#1077#1085#1090#1072' */'
      '  PROC_TRANSP, /* % '#1090#1088#1072#1085#1089#1087'. */'
      ''
      
        '  IF(:NDS=1, IF(FCOAST_NDS<>0, FCOAST_NDS, COAST_NDS), IF(FCOAST' +
        '_NO_NDS<>0, FCOAST_NO_NDS, COAST_NO_NDS)) AS COAST, /* '#1062#1077#1085#1072' */ '
      
        '  IF(:NDS=1, IF(FPRICE_NDS<>0, FPRICE_NDS, PRICE_NDS), IF(FPRICE' +
        '_NO_NDS<>0, FPRICE_NO_NDS, PRICE_NO_NDS)) AS PRICE, /* '#1057#1090#1086#1080#1084#1086#1089#1090#1100 +
        ' */ '
      
        '  IF(:NDS=1, IF(FTRANSP_NDS<>0, FTRANSP_NDS, TRANSP_NDS), IF(FTR' +
        'ANSP_NO_NDS<>0, FTRANSP_NO_NDS, TRANSP_NO_NDS)) AS TRANSP, /* '#1090#1088 +
        #1072#1085#1089#1087'. */ '
      ''
      
        '  IF(FCOAST_NDS<>0, FCOAST_NDS, COAST_NDS) AS COAST_NDS, /* '#1062#1077#1085#1072 +
        ' '#1089' '#1053#1044#1057' */'
      
        '  IF(FCOAST_NO_NDS<>0, FCOAST_NO_NDS, COAST_NO_NDS) AS COAST_NO_' +
        'NDS, /* '#1062#1077#1085#1072' '#1073#1077#1079' '#1053#1044#1057' */'
      
        '  IF(FPRICE_NDS<>0, FPRICE_NDS, PRICE_NDS) AS PRICE_NDS, /* '#1057#1090#1086#1080 +
        #1084#1086#1089#1090#1100' '#1089' '#1053#1044#1057' */'
      
        '  IF(FPRICE_NO_NDS<>0, FPRICE_NO_NDS, PRICE_NO_NDS) AS PRICE_NO_' +
        'NDS, /* '#1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1073#1077#1079' '#1053#1044#1057' */'
      
        '  IF(FTRANSP_NDS<>0, FTRANSP_NDS, TRANSP_NDS) AS TRANSP_NDS, /* ' +
        #1090#1088#1072#1085#1089#1087'. '#1089' '#1053#1044#1057'*/'
      
        '  IF(FTRANSP_NO_NDS<>0, FTRANSP_NO_NDS, TRANSP_NO_NDS) AS TRANSP' +
        '_NO_NDS /* '#1090#1088#1072#1085#1089#1087'. '#1073#1077#1079' '#1053#1044#1057'*/'
      'FROM '
      '  smetasourcedata, data_estimate, card_rate, materialcard'
      'WHERE '
      'data_estimate.ID_TYPE_DATA = 1 AND'
      'card_rate.ID = data_estimate.ID_TABLES AND'
      'materialcard.ID_CARD_RATE = card_rate.ID AND'
      'smetasourcedata.OBJ_ID=:OBJ_ID AND '
      'data_estimate.ID_ESTIMATE = smetasourcedata.SM_ID'
      ''
      'UNION ALL'
      ''
      '/* '#1052#1040#1058#1045#1056#1048#1040#1051#1067'*/'
      'SELECT '
      '  ID_ESTIMATE,'
      '  ID_TYPE_DATA,'
      '  materialcard.ID AS ID_TABLES,'
      '  smetasourcedata.OBJ_ID,'
      ''
      '  MAT_CODE AS CODE, /* '#1054#1073#1086#1089#1085#1086#1074#1072#1085#1080#1077'*/'
      '  MAT_NAME AS NAME, /* '#1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' */'
      '  MAT_UNIT AS UNIT, /* '#1045#1076'. '#1080#1079#1084#1077#1088#1077#1085#1080#1103' */'
      '  COALESCE(MAT_COUNT, 0) AS CNT, /* '#1050#1086#1083'-'#1074#1086' */'
      ''
      '  DOC_DATE, /* '#1044#1072#1090#1072' '#1076#1086#1082#1091#1084#1077#1085#1090#1072' */'
      '  DOC_NUM, /* '#1053#1086#1084#1077#1088' '#1076#1086#1082#1091#1084#1077#1085#1090#1072' */'
      '  PROC_TRANSP, /* % '#1090#1088#1072#1085#1089#1087'. */'
      ''
      
        '  IF(:NDS=1, IF(FCOAST_NDS<>0, FCOAST_NDS, COAST_NDS), IF(FCOAST' +
        '_NO_NDS<>0, FCOAST_NO_NDS, COAST_NO_NDS)) AS COAST, /* '#1062#1077#1085#1072' */ '
      
        '  IF(:NDS=1, IF(FPRICE_NDS<>0, FPRICE_NDS, PRICE_NDS), IF(FPRICE' +
        '_NO_NDS<>0, FPRICE_NO_NDS, PRICE_NO_NDS)) AS PRICE, /* '#1057#1090#1086#1080#1084#1086#1089#1090#1100 +
        ' */ '
      
        '  IF(:NDS=1, IF(FTRANSP_NDS<>0, FTRANSP_NDS, TRANSP_NDS), IF(FTR' +
        'ANSP_NO_NDS<>0, FTRANSP_NO_NDS, TRANSP_NO_NDS)) AS TRANSP, /* '#1090#1088 +
        #1072#1085#1089#1087'. */'
      ''
      
        '  IF(FCOAST_NDS<>0, FCOAST_NDS, COAST_NDS) AS COAST_NDS, /* '#1062#1077#1085#1072 +
        ' '#1089' '#1053#1044#1057' */'
      
        '  IF(FCOAST_NO_NDS<>0, FCOAST_NO_NDS, COAST_NO_NDS) AS COAST_NO_' +
        'NDS, /* '#1062#1077#1085#1072' '#1073#1077#1079' '#1053#1044#1057' */'
      
        '  IF(FPRICE_NDS<>0, FPRICE_NDS, PRICE_NDS) AS PRICE_NDS, /* '#1057#1090#1086#1080 +
        #1084#1086#1089#1090#1100' '#1089' '#1053#1044#1057' */'
      
        '  IF(FPRICE_NO_NDS<>0, FPRICE_NO_NDS, PRICE_NO_NDS) AS PRICE_NO_' +
        'NDS, /* '#1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1073#1077#1079' '#1053#1044#1057' */'
      
        '  IF(FTRANSP_NDS<>0, FTRANSP_NDS, TRANSP_NDS) AS TRANSP_NDS, /* ' +
        #1090#1088#1072#1085#1089#1087'. '#1089' '#1053#1044#1057'*/'
      
        '  IF(FTRANSP_NO_NDS<>0, FTRANSP_NO_NDS, TRANSP_NO_NDS) AS TRANSP' +
        '_NO_NDS /* '#1090#1088#1072#1085#1089#1087'. '#1073#1077#1079' '#1053#1044#1057'*/'
      'FROM '
      '  smetasourcedata, data_estimate, materialcard'
      'WHERE '
      'data_estimate.ID_TYPE_DATA = 2 AND'
      'materialcard.ID = data_estimate.ID_TABLES AND'
      'smetasourcedata.OBJ_ID=:OBJ_ID AND '
      'data_estimate.ID_ESTIMATE = smetasourcedata.SM_ID'
      ''
      'ORDER BY 5')
    Left = 27
    Top = 168
    ParamData = <
      item
        Name = 'NDS'
        DataType = ftString
        ParamType = ptInput
        Value = '1'
      end
      item
        Name = 'OBJ_ID'
        DataType = ftString
        ParamType = ptInput
        Value = '36'
      end>
  end
  object dsMaterialData: TDataSource
    DataSet = qrMaterialData
    Left = 27
    Top = 216
  end
  object qrMechData: TFDQuery
    MasterSource = dsObject
    MasterFields = 'OBJ_ID'
    DetailFields = 'OBJ_ID'
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
      '/* '#1052#1077#1093#1072#1085#1080#1079#1084#1099' '#1042' '#1056#1040#1057#1062#1045#1053#1050#1045'*/'
      'SELECT '
      '  ID_ESTIMATE,'
      '  ID_TYPE_DATA,'
      '  mechanizmcard.ID AS ID_TABLES,'
      '  smetasourcedata.OBJ_ID,'
      '  MECH_CODE AS CODE, /* '#1054#1073#1086#1089#1085#1086#1074#1072#1085#1080#1077'*/'
      '  MECH_NAME AS NAME, /* '#1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' */'
      '  MECH_UNIT AS UNIT, /* '#1045#1076'. '#1080#1079#1084#1077#1088#1077#1085#1080#1103' */'
      '  COALESCE(MECH_COUNT, 0) AS CNT, /* '#1050#1086#1083'-'#1074#1086' */'
      ''
      '  DOC_DATE, /* '#1044#1072#1090#1072' '#1076#1086#1082#1091#1084#1077#1085#1090#1072' */'
      '  DOC_NUM, /*  '#1053#1086#1084#1077#1088' '#1076#1086#1082#1091#1084#1077#1085#1090#1072' */'
      '  /* PROC_TRANSP,  % '#1090#1088#1072#1085#1089#1087'. */'
      ''
      
        '  IF(:NDS=1, IF(FCOAST_NDS<>0, FCOAST_NDS, COAST_NDS), IF(FCOAST' +
        '_NO_NDS<>0, FCOAST_NO_NDS, COAST_NO_NDS)) AS COAST, /* '#1062#1077#1085#1072' */ '
      
        '  IF(:NDS=1, IF(FPRICE_NDS<>0, FPRICE_NDS, PRICE_NDS), IF(FPRICE' +
        '_NO_NDS<>0, FPRICE_NO_NDS, PRICE_NO_NDS)) AS PRICE, /* '#1057#1090#1086#1080#1084#1086#1089#1090#1100 +
        ' */ '
      
        '  /* IF(:NDS=1, IF(FTRANSP_NDS<>0, FTRANSP_NDS, TRANS_NDS), IF(F' +
        'TRANSP_NO_NDS<>0, FTRANSP_NO_NDS, TRANSP_NO_NDS)) AS TRANSP, /* ' +
        #1090#1088#1072#1085#1089#1087'. */ '
      ''
      
        '  IF(FCOAST_NDS<>0, FCOAST_NDS, COAST_NDS) AS COAST_NDS, /* '#1062#1077#1085#1072 +
        ' '#1089' '#1053#1044#1057' */'
      
        '  IF(FCOAST_NO_NDS<>0, FCOAST_NO_NDS, COAST_NO_NDS) AS COAST_NO_' +
        'NDS, /* '#1062#1077#1085#1072' '#1073#1077#1079' '#1053#1044#1057' */'
      
        '  IF(FPRICE_NDS<>0, FPRICE_NDS, PRICE_NDS) AS PRICE_NDS, /* '#1057#1090#1086#1080 +
        #1084#1086#1089#1090#1100' '#1089' '#1053#1044#1057' */'
      
        '  IF(FPRICE_NO_NDS<>0, FPRICE_NO_NDS, PRICE_NO_NDS) AS PRICE_NO_' +
        'NDS /* '#1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1073#1077#1079' '#1053#1044#1057' */'
      
        '  /* IF(FTRANSP_NDS<>0, FTRANSP_NDS, TRANS_NDS) AS TRANSP_NDS,  ' +
        #1090#1088#1072#1085#1089#1087'. '#1089' '#1053#1044#1057'*/'
      
        '  /* IF(FTRANSP_NO_NDS<>0, FTRANSP_NO_NDS, TRANSP_NO_NDS) AS TRA' +
        'NSP_NO_NDS  '#1090#1088#1072#1085#1089#1087'. '#1073#1077#1079' '#1053#1044#1057'*/'
      'FROM '
      '  data_estimate, card_rate, mechanizmcard, smetasourcedata'
      'WHERE '
      'smetasourcedata.OBJ_ID=:OBJ_ID AND  '
      'data_estimate.ID_ESTIMATE = smetasourcedata.SM_ID AND '
      'data_estimate.ID_TYPE_DATA = 1 AND'
      'card_rate.ID = data_estimate.ID_TABLES AND'
      'mechanizmcard.ID_CARD_RATE = card_rate.ID'
      ''
      'UNION ALL'
      ''
      '/* '#1052#1077#1093#1072#1085#1080#1079#1084#1099' */'
      'SELECT '
      '  ID_ESTIMATE,'
      '  ID_TYPE_DATA,'
      '  mechanizmcard.ID AS ID_TABLES,'
      '  smetasourcedata.OBJ_ID,'
      '  MECH_CODE AS CODE, /* '#1054#1073#1086#1089#1085#1086#1074#1072#1085#1080#1077'*/'
      '  MECH_NAME AS NAME, /* '#1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' */'
      '  MECH_UNIT AS UNIT, /* '#1045#1076'. '#1080#1079#1084#1077#1088#1077#1085#1080#1103' */'
      '  COALESCE(MECH_COUNT, 0) AS CNT, /* '#1050#1086#1083'-'#1074#1086' */'
      ''
      '  DOC_DATE, /* '#1044#1072#1090#1072' '#1076#1086#1082#1091#1084#1077#1085#1090#1072' */'
      '  DOC_NUM, /*  '#1053#1086#1084#1077#1088' '#1076#1086#1082#1091#1084#1077#1085#1090#1072' */'
      '  /* PROC_TRANSP, /* % '#1090#1088#1072#1085#1089#1087'. */'
      ''
      
        '  IF(:NDS=1, IF(FCOAST_NDS<>0, FCOAST_NDS, COAST_NDS), IF(FCOAST' +
        '_NO_NDS<>0, FCOAST_NO_NDS, COAST_NO_NDS)) AS COAST, /* '#1062#1077#1085#1072' */ '
      
        '  IF(:NDS=1, IF(FPRICE_NDS<>0, FPRICE_NDS, PRICE_NDS), IF(FPRICE' +
        '_NO_NDS<>0, FPRICE_NO_NDS, PRICE_NO_NDS)) AS PRICE, /* '#1057#1090#1086#1080#1084#1086#1089#1090#1100 +
        ' */ '
      
        '  /* IF(:NDS=1, IF(FTRANSP_NDS<>0, FTRANSP_NDS, TRANS_NDS), IF(F' +
        'TRANSP_NO_NDS<>0, FTRANSP_NO_NDS, TRANSP_NO_NDS)) AS TRANSP,  '#1090#1088 +
        #1072#1085#1089#1087'. */ '
      ''
      
        '  IF(FCOAST_NDS<>0, FCOAST_NDS, COAST_NDS) AS COAST_NDS, /* '#1062#1077#1085#1072 +
        ' '#1089' '#1053#1044#1057' */'
      
        '  IF(FCOAST_NO_NDS<>0, FCOAST_NO_NDS, COAST_NO_NDS) AS COAST_NO_' +
        'NDS, /* '#1062#1077#1085#1072' '#1073#1077#1079' '#1053#1044#1057' */'
      
        '  IF(FPRICE_NDS<>0, FPRICE_NDS, PRICE_NDS) AS PRICE_NDS, /* '#1057#1090#1086#1080 +
        #1084#1086#1089#1090#1100' '#1089' '#1053#1044#1057' */'
      
        '  IF(FPRICE_NO_NDS<>0, FPRICE_NO_NDS, PRICE_NO_NDS) AS PRICE_NO_' +
        'NDS /* '#1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1073#1077#1079' '#1053#1044#1057' */'
      
        '  /* IF(FTRANSP_NDS<>0, FTRANSP_NDS, TRANS_NDS) AS TRANSP_NDS,  ' +
        #1090#1088#1072#1085#1089#1087'. '#1089' '#1053#1044#1057'*/'
      
        '  /* IF(FTRANSP_NO_NDS<>0, FTRANSP_NO_NDS, TRANSP_NO_NDS) AS TRA' +
        'NSP_NO_NDS  '#1090#1088#1072#1085#1089#1087'. '#1073#1077#1079' '#1053#1044#1057'*/'
      'FROM '
      '  data_estimate, mechanizmcard, smetasourcedata'
      'WHERE '
      'data_estimate.ID_TYPE_DATA = 3 AND'
      'mechanizmcard.ID = data_estimate.ID_TABLES AND'
      'smetasourcedata.OBJ_ID=:OBJ_ID AND '
      'data_estimate.ID_ESTIMATE = smetasourcedata.SM_ID'
      'ORDER BY 5')
    Left = 99
    Top = 168
    ParamData = <
      item
        Name = 'NDS'
        DataType = ftString
        ParamType = ptInput
        Value = '1'
      end
      item
        Name = 'OBJ_ID'
        DataType = ftString
        ParamType = ptInput
        Value = '36'
      end>
  end
  object dsMechData: TDataSource
    DataSet = qrMechData
    Left = 99
    Top = 216
  end
  object qrDevices: TFDQuery
    MasterSource = dsObject
    MasterFields = 'OBJ_ID'
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
      '/* '#1054#1041#1054#1056#1059#1044#1054#1042#1040#1053#1048#1045' */'
      'SELECT '
      '  ID_ESTIMATE,'
      '  ID_TYPE_DATA,'
      '  devicescard.ID AS ID_TABLES,'
      '  smetasourcedata.OBJ_ID,'
      ''
      '  DEVICE_CODE AS CODE, /* '#1054#1073#1086#1089#1085#1086#1074#1072#1085#1080#1077'*/'
      '  DEVICE_NAME AS NAME, /* '#1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' */'
      '  DEVICE_UNIT AS UNIT, /* '#1045#1076'. '#1080#1079#1084#1077#1088#1077#1085#1080#1103' */'
      '  COALESCE(DEVICE_COUNT, 0) AS CNT, /* '#1050#1086#1083'-'#1074#1086' */'
      ''
      '  DOC_DATE, /* '#1044#1072#1090#1072' '#1076#1086#1082#1091#1084#1077#1085#1090#1072' */'
      '  DOC_NUM, /* '#1053#1086#1084#1077#1088' '#1076#1086#1082#1091#1084#1077#1085#1090#1072' */'
      '  /* PROC_TRANSP,  % '#1090#1088#1072#1085#1089#1087'. */'
      ''
      
        '  IF(:NDS=1, IF(FCOAST_NDS<>0, FCOAST_NDS, 0), IF(FCOAST_NO_NDS<' +
        '>0, FCOAST_NO_NDS, 0)) AS COAST, /* '#1062#1077#1085#1072' */ '
      
        '  IF(:NDS=1, IF(FPRICE_NDS<>0, FPRICE_NDS, 0), IF(FPRICE_NO_NDS<' +
        '>0, FPRICE_NO_NDS, 0)) AS PRICE, /* '#1057#1090#1086#1080#1084#1086#1089#1090#1100' */ '
      
        '  /* IF(:NDS=1, IF(FTRANSP_NDS<>0, FTRANSP_NDS, TRANS_NDS), IF(F' +
        'TRANSP_NO_NDS<>0, FTRANSP_NO_NDS, TRANSP_NO_NDS)) AS TRANSP,  '#1090#1088 +
        #1072#1085#1089#1087'. */'
      ''
      
        '  IF(FCOAST_NDS<>0, FCOAST_NDS, 0) AS COAST_NDS, /* '#1062#1077#1085#1072' '#1089' '#1053#1044#1057' *' +
        '/'
      
        '  IF(FCOAST_NO_NDS<>0, FCOAST_NO_NDS, 0) AS COAST_NO_NDS, /* '#1062#1077#1085 +
        #1072' '#1073#1077#1079' '#1053#1044#1057' */'
      
        '  IF(FPRICE_NDS<>0, FPRICE_NDS, 0) AS PRICE_NDS, /* '#1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1089' ' +
        #1053#1044#1057' */'
      
        '  IF(FPRICE_NO_NDS<>0, FPRICE_NO_NDS, 0) AS PRICE_NO_NDS /* '#1057#1090#1086#1080 +
        #1084#1086#1089#1090#1100' '#1073#1077#1079' '#1053#1044#1057' */'
      
        '  /* IF(FTRANSP_NDS<>0, FTRANSP_NDS, TRANS_NDS) AS TRANSP_NDS,  ' +
        #1090#1088#1072#1085#1089#1087'. '#1089' '#1053#1044#1057'*/'
      
        '  /* IF(FTRANSP_NO_NDS<>0, FTRANSP_NO_NDS, TRANSP_NO_NDS) AS TRA' +
        'NSP_NO_NDS '#1090#1088#1072#1085#1089#1087'. '#1073#1077#1079' '#1053#1044#1057'*/'
      'FROM '
      '  smetasourcedata, data_estimate, devicescard'
      'WHERE '
      'data_estimate.ID_TYPE_DATA = 4 AND'
      'devicescard.ID = data_estimate.ID_TABLES AND'
      'smetasourcedata.OBJ_ID=:OBJ_ID AND '
      'data_estimate.ID_ESTIMATE = smetasourcedata.SM_ID'
      ''
      'ORDER BY 5')
    Left = 155
    Top = 168
    ParamData = <
      item
        Name = 'NDS'
        DataType = ftString
        ParamType = ptInput
        Value = '1'
      end
      item
        Name = 'OBJ_ID'
        DataType = ftString
        ParamType = ptInput
        Value = '38'
      end>
  end
  object dsDevices: TDataSource
    DataSet = qrDevices
    Left = 155
    Top = 216
  end
  object qrRates: TFDQuery
    MasterSource = dsObject
    MasterFields = 'OBJ_ID'
    DetailFields = 'OBJ_ID'
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
      '/* '#1052#1040#1058#1045#1056#1048#1040#1051#1067'*/'
      'SELECT '
      '  ID_ESTIMATE,'
      '  ID_TYPE_DATA,'
      '  card_rate.ID AS ID_TABLES,'
      '  smetasourcedata.OBJ_ID,'
      ''
      '  RATE_CODE AS CODE, /* '#1054#1073#1086#1089#1085#1086#1074#1072#1085#1080#1077'*/'
      '  RATE_CAPTION AS NAME, /* '#1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' */'
      '  RATE_UNIT AS UNIT, /* '#1045#1076'. '#1080#1079#1084#1077#1088#1077#1085#1080#1103' */'
      '  COALESCE(RATE_COUNT, 0) AS CNT, /* '#1050#1086#1083'-'#1074#1086' */'
      ''
      
        '  data_estimate.TRUD / COALESCE(RATE_COUNT, 0) AS TRUD_ONE, /* '#1090 +
        #1088#1091#1076#1086#1079#1072#1090#1088#1072#1090#1099' '#1085#1072' '#1077#1076'. */'
      '  data_estimate.TRUD AS TRUD, /* '#1090#1088#1091#1076#1086#1079#1072#1090#1088#1072#1090#1099' '#1085#1072' '#1077#1076'. */'
      '  data_estimate.K_TRUD, /* '#1082#1086#1101#1092'. '#1082' '#1076#1088#1091#1076' */'
      
        '  (SELECT norma FROM normativwork WHERE normativ_id = card_rate.' +
        'RATE_ID and work_id = 1 LIMIT 1) AS Rank, /* '#1088#1072#1079#1088#1103#1076' */'
      '  (SELECT IFNULL(c.`COEF`, 0.0) '
      '   FROM `category` c'
      
        '   WHERE c.`VALUE` = (SELECT norma FROM normativwork WHERE norma' +
        'tiv_id = card_rate.RATE_ID and work_id = 1 LIMIT 1) and '
      
        '   c.`DATE_BEG` <= (SELECT CONVERT(CONCAT(stavka.YEAR,"-",stavka' +
        '.MONAT,"-01"), DATE) FROM stavka WHERE stavka.STAVKA_ID = smetas' +
        'ourcedata.STAVKA_ID)'
      '   ORDER BY c.`DATE_BEG` DESC '
      '   LIMIT 1)'
      '  AS MRCOEF,  /* '#1084#1077#1078#1088#1072#1079#1088#1103#1076#1085#1099#1081' '#1082#1086#1101#1092'. */'
      '  ROUND(smetasourcedata.STAVKA_RAB * '
      '  (SELECT IFNULL(c.`COEF`, 0.0) '
      '   FROM `category` c'
      
        '   WHERE c.`VALUE` = (SELECT norma FROM normativwork WHERE norma' +
        'tiv_id = card_rate.RATE_ID and work_id = 1 LIMIT 1) and '
      
        '   c.`DATE_BEG` <= (SELECT CONVERT(CONCAT(stavka.YEAR,"-",stavka' +
        '.MONAT,"-01"), DATE) FROM stavka WHERE stavka.STAVKA_ID = smetas' +
        'ourcedata.STAVKA_ID)'
      '   ORDER BY c.`DATE_BEG` DESC '
      '   LIMIT 1)) AS Tariff, /* '#1058#1072#1088#1080#1092' */'
      '  data_estimate.K_ZP,  /* KZP */'
      '  ROUND(data_estimate.ZP) AS ZP /* ZP */'
      'FROM '
      '  smetasourcedata, data_estimate, card_rate'
      'WHERE '
      'data_estimate.ID_TYPE_DATA = 1 AND'
      'card_rate.ID = data_estimate.ID_TABLES AND'
      'smetasourcedata.OBJ_ID=:OBJ_ID AND '
      'data_estimate.ID_ESTIMATE = smetasourcedata.SM_ID'
      ''
      'ORDER BY 5')
    Left = 211
    Top = 168
    ParamData = <
      item
        Name = 'OBJ_ID'
        DataType = ftString
        ParamType = ptInput
        Value = '40'
      end>
  end
  object dsRates: TDataSource
    DataSet = qrRates
    Left = 211
    Top = 216
  end
end
