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
        object edtMatCodeFilter: TEdit
          Left = 4
          Top = 27
          Width = 121
          Height = 21
          TabOrder = 3
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
          TabOrder = 4
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
          TabOrder = 5
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
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          PopupMenu = pmMat
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
          WordWrap = True
          WordWrapAllFields = True
          Columns = <
            item
              Expanded = False
              FieldName = 'CODE'
              Title.Alignment = taCenter
              Title.Caption = #1050#1086#1076
              Width = 27
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'NAME'
              Title.Alignment = taCenter
              Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
              Width = 112
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'UNIT'
              Title.Alignment = taCenter
              Title.Caption = #1045#1076'. '#1080#1079#1084'.'
              Width = 14
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CNT'
              Title.Alignment = taCenter
              Title.Caption = #1050#1086#1083'-'#1074#1086
              Width = 15
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'COAST'
              Title.Alignment = taCenter
              Title.Caption = #1062#1077#1085#1072
              Width = 64
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PRICE'
              Title.Alignment = taCenter
              Title.Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100
              Width = 64
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PROC_TRANSP'
              Title.Alignment = taCenter
              Title.Caption = '% '#1090#1088#1072#1085#1089#1087'.'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'TRANSP'
              Title.Alignment = taCenter
              Title.Caption = #1058#1088#1072#1085#1089#1087#1086#1088#1090
              Width = 64
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DOC_DATE'
              Title.Alignment = taCenter
              Title.Caption = #1053#1072#1082#1083'. '#1076#1072#1090#1072
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DOC_NUM'
              Title.Alignment = taCenter
              Title.Caption = #1053#1072#1082#1083'. '#8470
              Width = 94
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
          TabOrder = 1
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
        TabOrder = 0
        object pnl2: TPanel
          Left = 0
          Top = 152
          Width = 608
          Height = 24
          Align = alBottom
          Caption = #1048#1090#1086#1075#1086':'
          TabOrder = 0
        end
        object grMech: TJvDBGrid
          Left = 0
          Top = 0
          Width = 608
          Height = 152
          Align = alClient
          DataSource = dsMechData
          DrawingStyle = gdsClassic
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          PopupMenu = pmMech
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
        TabOrder = 1
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
          TabOrder = 1
        end
      end
      object pnlMechTop: TPanel
        Left = 0
        Top = 0
        Width = 608
        Height = 57
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 2
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
          TabOrder = 2
        end
        object edtMechCodeFilter: TEdit
          Left = 4
          Top = 27
          Width = 121
          Height = 21
          TabOrder = 3
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
          TabOrder = 4
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
          TabOrder = 5
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
          TabOrder = 2
        end
        object edt1: TEdit
          Left = 4
          Top = 27
          Width = 121
          Height = 21
          TabOrder = 3
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
          TabOrder = 4
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
          TabOrder = 5
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
          TabOrder = 0
        end
        object JvDBGrid1: TJvDBGrid
          Left = 0
          Top = 0
          Width = 608
          Height = 152
          Align = alClient
          DataSource = dsMechData
          DrawingStyle = gdsClassic
          PopupMenu = pmMech
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
        ExplicitTop = 233
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
          DataSource = dsMechData
          ScrollBars = ssVertical
          TabOrder = 1
        end
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
    Left = 28
    Top = 128
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
      
        '  IF(:NDS=1, IF(FTRANSP_NDS<>0, FTRANSP_NDS, TRANS_NDS), IF(FTRA' +
        'NSP_NO_NDS<>0, FTRANSP_NO_NDS, TRANSP_NO_NDS)) AS TRANSP, /* '#1090#1088#1072 +
        #1085#1089#1087'. */ '
      ''
      
        '  IF(FCOAST_NDS<>0, FCOAST_NDS, COAST_NDS) AS COAST_NDS, /* '#1062#1077#1085#1072 +
        ' '#1089' '#1053#1044#1057' */'
      
        '  IF(FCOAST_NO_NDS<>0, FCOAST_NO_NDS, COAST_NO_NDS) AS COAST_NO_' +
        'NDS, /* '#1062#1077#1085#1072' '#1073#1077#1079' '#1053#1044#1057' */'
      
        '  IF(FPRICE_NDS<>0, FPRICE_NDS, PRICE_NDS) AS PRICE_NDS, /* '#1057#1090#1086#1080 +
        #1084#1086#1089#1090#1100' '#1089' '#1053#1044#1057' */'
      
        '  IF(FPRICE_NO_NDS<>0, FPRICE_NO_NDS, PRICE_NO_NDS) AS PRICE_NO_' +
        'NDS, /* '#1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1073#1077#1079' '#1053#1044#1057' */'
      
        '  IF(FTRANSP_NDS<>0, FTRANSP_NDS, TRANS_NDS) AS TRANSP_NDS, /* '#1090 +
        #1088#1072#1085#1089#1087'. '#1089' '#1053#1044#1057'*/'
      
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
      
        '  IF(:NDS=1, IF(FTRANSP_NDS<>0, FTRANSP_NDS, TRANS_NDS), IF(FTRA' +
        'NSP_NO_NDS<>0, FTRANSP_NO_NDS, TRANSP_NO_NDS)) AS TRANSP, /* '#1090#1088#1072 +
        #1085#1089#1087'. */'
      ''
      
        '  IF(FCOAST_NDS<>0, FCOAST_NDS, COAST_NDS) AS COAST_NDS, /* '#1062#1077#1085#1072 +
        ' '#1089' '#1053#1044#1057' */'
      
        '  IF(FCOAST_NO_NDS<>0, FCOAST_NO_NDS, COAST_NO_NDS) AS COAST_NO_' +
        'NDS, /* '#1062#1077#1085#1072' '#1073#1077#1079' '#1053#1044#1057' */'
      
        '  IF(FPRICE_NDS<>0, FPRICE_NDS, PRICE_NDS) AS PRICE_NDS, /* '#1057#1090#1086#1080 +
        #1084#1086#1089#1090#1100' '#1089' '#1053#1044#1057' */'
      
        '  IF(FPRICE_NO_NDS<>0, FPRICE_NO_NDS, PRICE_NO_NDS) AS PRICE_NO_' +
        'NDS, /* '#1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1073#1077#1079' '#1053#1044#1057' */'
      
        '  IF(FTRANSP_NDS<>0, FTRANSP_NDS, TRANS_NDS) AS TRANSP_NDS, /* '#1090 +
        #1088#1072#1085#1089#1087'. '#1089' '#1053#1044#1057'*/'
      
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
    object qrMaterialDataID_ESTIMATE: TLongWordField
      AutoGenerateValue = arDefault
      FieldName = 'ID_ESTIMATE'
      Origin = 'ID_ESTIMATE'
      ProviderFlags = []
    end
    object qrMaterialDataID_TYPE_DATA: TLongWordField
      AutoGenerateValue = arDefault
      FieldName = 'ID_TYPE_DATA'
      Origin = 'ID_TYPE_DATA'
      ProviderFlags = []
    end
    object qrMaterialDataID_TABLES: TLongWordField
      AutoGenerateValue = arDefault
      FieldName = 'ID_TABLES'
      Origin = 'ID_TABLES'
      ProviderFlags = []
    end
    object qrMaterialDataOBJ_ID: TLongWordField
      AutoGenerateValue = arDefault
      FieldName = 'OBJ_ID'
      Origin = 'OBJ_ID'
      ProviderFlags = []
    end
    object qrMaterialDataCODE: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'CODE'
      Origin = 'CODE'
      ProviderFlags = []
      Size = 15
    end
    object qrMaterialDataNAME: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'NAME'
      Origin = 'NAME'
      ProviderFlags = []
      Size = 32767
    end
    object qrMaterialDataUNIT: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'UNIT'
      Origin = 'UNIT'
      ProviderFlags = []
      Size = 100
    end
    object qrMaterialDataCNT: TFMTBCDField
      AutoGenerateValue = arDefault
      FieldName = 'CNT'
      Origin = 'CNT'
      ProviderFlags = []
      Precision = 10
      Size = 5
    end
    object qrMaterialDataDOC_DATE: TDateField
      AutoGenerateValue = arDefault
      FieldName = 'DOC_DATE'
      Origin = 'DOC_DATE'
      ProviderFlags = []
    end
    object qrMaterialDataDOC_NUM: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'DOC_NUM'
      Origin = 'DOC_NUM'
      ProviderFlags = []
      Size = 50
    end
    object qrMaterialDataPROC_TRANSP: TFloatField
      AutoGenerateValue = arDefault
      FieldName = 'PROC_TRANSP'
      Origin = 'PROC_TRANSP'
      ProviderFlags = []
    end
    object qrMaterialDataCOAST: TLargeintField
      AutoGenerateValue = arDefault
      FieldName = 'COAST'
      Origin = 'COAST'
      ProviderFlags = []
      DisplayFormat = '### ### ### ### ###'
    end
    object qrMaterialDataPRICE: TLargeintField
      AutoGenerateValue = arDefault
      FieldName = 'PRICE'
      Origin = 'PRICE'
      ProviderFlags = []
      DisplayFormat = '### ### ### ### ###'
    end
    object qrMaterialDataTRANSP: TLargeintField
      AutoGenerateValue = arDefault
      FieldName = 'TRANSP'
      Origin = 'TRANSP'
      ProviderFlags = []
      DisplayFormat = '### ### ### ### ###'
    end
    object qrMaterialDataCOAST_NDS: TLargeintField
      AutoGenerateValue = arDefault
      FieldName = 'COAST_NDS'
      Origin = 'COAST_NDS'
      ProviderFlags = []
    end
    object qrMaterialDataCOAST_NO_NDS: TLargeintField
      AutoGenerateValue = arDefault
      FieldName = 'COAST_NO_NDS'
      Origin = 'COAST_NO_NDS'
      ProviderFlags = []
    end
    object qrMaterialDataPRICE_NDS: TLargeintField
      AutoGenerateValue = arDefault
      FieldName = 'PRICE_NDS'
      Origin = 'PRICE_NDS'
      ProviderFlags = []
    end
    object qrMaterialDataPRICE_NO_NDS: TLargeintField
      AutoGenerateValue = arDefault
      FieldName = 'PRICE_NO_NDS'
      Origin = 'PRICE_NO_NDS'
      ProviderFlags = []
    end
    object qrMaterialDataTRANSP_NDS: TLargeintField
      AutoGenerateValue = arDefault
      FieldName = 'TRANSP_NDS'
      Origin = 'TRANSP_NDS'
      ProviderFlags = []
    end
    object qrMaterialDataTRANSP_NO_NDS: TLargeintField
      AutoGenerateValue = arDefault
      FieldName = 'TRANSP_NO_NDS'
      Origin = 'TRANSP_NO_NDS'
      ProviderFlags = []
    end
  end
  object dsMaterialData: TDataSource
    DataSet = qrMaterialData
    Left = 27
    Top = 216
  end
  object pmMech: TPopupMenu
    Left = 100
    Top = 128
    object MenuItem1: TMenuItem
      Caption = #1042#1099#1076#1077#1083#1080#1090#1100
    end
    object MenuItem2: TMenuItem
      Caption = #1042#1099#1076#1077#1083#1080#1090#1100' '#1074#1089#1077
    end
    object MenuItem3: TMenuItem
      Caption = '-'
    end
    object MenuItem4: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100
    end
    object MenuItem5: TMenuItem
      Caption = #1042#1086#1089#1089#1090#1072#1085#1086#1074#1080#1090#1100
    end
  end
  object qrMechData: TFDQuery
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
    object qrMechDataID_ESTIMATE: TLongWordField
      AutoGenerateValue = arDefault
      FieldName = 'ID_ESTIMATE'
      Origin = 'ID_ESTIMATE'
      ProviderFlags = []
    end
    object qrMechDataID_TYPE_DATA: TLongWordField
      AutoGenerateValue = arDefault
      FieldName = 'ID_TYPE_DATA'
      Origin = 'ID_TYPE_DATA'
      ProviderFlags = []
    end
    object qrMechDataID_TABLES: TLongWordField
      AutoGenerateValue = arDefault
      FieldName = 'ID_TABLES'
      Origin = 'ID_TABLES'
      ProviderFlags = []
    end
    object qrMechDataOBJ_ID: TLongWordField
      AutoGenerateValue = arDefault
      FieldName = 'OBJ_ID'
      Origin = 'OBJ_ID'
      ProviderFlags = []
    end
    object qrMechDataCODE: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'CODE'
      Origin = 'CODE'
      ProviderFlags = []
      Size = 15
    end
    object qrMechDataNAME: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'NAME'
      Origin = 'NAME'
      ProviderFlags = []
      Size = 32767
    end
    object qrMechDataUNIT: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'UNIT'
      Origin = 'UNIT'
      ProviderFlags = []
      Size = 100
    end
    object qrMechDataCNT: TFMTBCDField
      AutoGenerateValue = arDefault
      FieldName = 'CNT'
      Origin = 'CNT'
      ProviderFlags = []
      Precision = 10
      Size = 5
    end
    object qrMechDataDOC_DATE: TDateField
      AutoGenerateValue = arDefault
      FieldName = 'DOC_DATE'
      Origin = 'DOC_DATE'
      ProviderFlags = []
    end
    object qrMechDataDOC_NUM: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'DOC_NUM'
      Origin = 'DOC_NUM'
      ProviderFlags = []
      Size = 50
    end
    object qrMechDataCOAST: TLargeintField
      AutoGenerateValue = arDefault
      FieldName = 'COAST'
      Origin = 'COAST'
      ProviderFlags = []
      DisplayFormat = '### ### ### ### ###'
    end
    object qrMechDataPRICE: TLargeintField
      AutoGenerateValue = arDefault
      FieldName = 'PRICE'
      Origin = 'PRICE'
      ProviderFlags = []
      DisplayFormat = '### ### ### ### ###'
    end
    object qrMechDataCOAST_NDS: TLargeintField
      AutoGenerateValue = arDefault
      FieldName = 'COAST_NDS'
      Origin = 'COAST_NDS'
      ProviderFlags = []
    end
    object qrMechDataCOAST_NO_NDS: TLargeintField
      AutoGenerateValue = arDefault
      FieldName = 'COAST_NO_NDS'
      Origin = 'COAST_NO_NDS'
      ProviderFlags = []
    end
    object qrMechDataPRICE_NDS: TLargeintField
      AutoGenerateValue = arDefault
      FieldName = 'PRICE_NDS'
      Origin = 'PRICE_NDS'
      ProviderFlags = []
    end
    object qrMechDataPRICE_NO_NDS: TLargeintField
      AutoGenerateValue = arDefault
      FieldName = 'PRICE_NO_NDS'
      Origin = 'PRICE_NO_NDS'
      ProviderFlags = []
    end
  end
  object dsMechData: TDataSource
    DataSet = qrMechData
    Left = 99
    Top = 216
  end
  object pm1: TPopupMenu
    Left = 156
    Top = 128
    object MenuItem6: TMenuItem
      Caption = #1042#1099#1076#1077#1083#1080#1090#1100
    end
    object MenuItem7: TMenuItem
      Caption = #1042#1099#1076#1077#1083#1080#1090#1100' '#1074#1089#1077
    end
    object MenuItem8: TMenuItem
      Caption = '-'
    end
    object MenuItem9: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100
    end
    object MenuItem10: TMenuItem
      Caption = #1042#1086#1089#1089#1090#1072#1085#1086#1074#1080#1090#1100
    end
  end
  object qr1: TFDQuery
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
      '/* '#1052#1040#1058#1045#1056#1048#1040#1051#1067' '#1042' '#1056#1040#1057#1062#1045#1053#1050#1045'*/'
      'SELECT '
      '  ID_ESTIMATE,'
      '  ID_TYPE_DATA,'
      '  materialcard.ID AS ID_TABLES,'
      '  estim.NDS AS NDS, /* '#1053#1044#1057'*/'
      '  MAT_CODE AS CODE, /* '#1054#1073#1086#1089#1085#1086#1074#1072#1085#1080#1077'*/'
      '  MAT_NAME AS NAME, /* '#1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' */'
      '  MAT_UNIT AS UNIT, /* '#1045#1076'. '#1080#1079#1084#1077#1088#1077#1085#1080#1103' */'
      '  COALESCE(MAT_COUNT, 0) AS CNT, /* '#1050#1086#1083'-'#1074#1086' */'
      ''
      '  DOC_DATE, /* '#1044#1072#1090#1072' '#1076#1086#1082#1091#1084#1077#1085#1090#1072' */'
      '  DOC_NUM, /* '#1053#1086#1084#1077#1088' '#1076#1086#1082#1091#1084#1077#1085#1090#1072' */'
      '  PROC_TRANSP, /* % '#1090#1088#1072#1085#1089#1087'. */'
      ''
      
        '  IF(estim.NDS=1, IF(FCOAST_NDS<>0, FCOAST_NDS, COAST_NDS), IF(F' +
        'COAST_NO_NDS<>0, FCOAST_NO_NDS, COAST_NO_NDS)) AS COAST, /* '#1062#1077#1085#1072 +
        ' */ '
      
        '  IF(estim.NDS=1, IF(FPRICE_NDS<>0, FPRICE_NDS, PRICE_NDS), IF(F' +
        'PRICE_NO_NDS<>0, FPRICE_NO_NDS, PRICE_NO_NDS)) AS PRICE, /* '#1057#1090#1086#1080 +
        #1084#1086#1089#1090#1100' */ '
      
        '  IF(estim.NDS=1, IF(FTRANSP_NDS<>0, FTRANSP_NDS, TRANS_NDS), IF' +
        '(FTRANSP_NO_NDS<>0, FTRANSP_NO_NDS, TRANSP_NO_NDS)) AS TRANSP, /' +
        '* '#1090#1088#1072#1085#1089#1087'. */ '
      ''
      
        '  IF(FCOAST_NDS<>0, FCOAST_NDS, COAST_NDS) AS COAST_NDS, /* '#1062#1077#1085#1072 +
        ' '#1089' '#1053#1044#1057' */'
      
        '  IF(FCOAST_NO_NDS<>0, FCOAST_NO_NDS, COAST_NO_NDS) AS COAST_NO_' +
        'NDS, /* '#1062#1077#1085#1072' '#1073#1077#1079' '#1053#1044#1057' */'
      
        '  IF(FPRICE_NDS<>0, FPRICE_NDS, PRICE_NDS) AS PRICE_NDS, /* '#1057#1090#1086#1080 +
        #1084#1086#1089#1090#1100' '#1089' '#1053#1044#1057' */'
      
        '  IF(FPRICE_NO_NDS<>0, FPRICE_NO_NDS, PRICE_NO_NDS) AS PRICE_NO_' +
        'NDS, /* '#1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1073#1077#1079' '#1053#1044#1057' */'
      
        '  IF(FTRANSP_NDS<>0, FTRANSP_NDS, TRANS_NDS) AS TRANSP_NDS, /* '#1090 +
        #1088#1072#1085#1089#1087'. '#1089' '#1053#1044#1057'*/'
      
        '  IF(FTRANSP_NO_NDS<>0, FTRANSP_NO_NDS, TRANSP_NO_NDS) AS TRANSP' +
        '_NO_NDS /* '#1090#1088#1072#1085#1089#1087'. '#1073#1077#1079' '#1053#1044#1057'*/'
      'FROM '
      '  data_estimate, card_rate, materialcard, estim'
      'WHERE '
      'data_estimate.ID_TYPE_DATA = 1 AND'
      'card_rate.ID = data_estimate.ID_TABLES AND'
      'materialcard.ID_CARD_RATE = card_rate.ID AND'
      'materialcard.CONSIDERED = 0 AND'
      'estim.OBJ_ID=:OBJ_ID AND '
      '((ID_ESTIMATE = estim.SM_ID) OR /* '#1054#1073#1098#1077#1082#1090#1085#1099#1081' '#1091#1088#1086#1074#1077#1085#1100' */'
      
        ' (ID_ESTIMATE IN (SELECT s1.SM_ID FROM smetasourcedata s1 WHERE ' +
        '(s1.PARENT_LOCAL_ID + s1.PARENT_PTM_ID) = estim.SM_ID)) OR /* '#1051#1086 +
        #1082#1072#1083#1100#1085#1099#1081' '#1091#1088#1086#1074#1077#1085#1100' */'
      
        ' (ID_ESTIMATE IN (SELECT s2.SM_ID FROM smetasourcedata s2 WHERE ' +
        '(s2.PARENT_LOCAL_ID + s2.PARENT_PTM_ID) IN '
      
        '   (SELECT s1.SM_ID FROM smetasourcedata s1 WHERE (s1.PARENT_LOC' +
        'AL_ID + s1.PARENT_PTM_ID) = estim.SM_ID))'
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
      '  estim.NDS AS NDS, /* '#1053#1044#1057'*/'
      '  MAT_CODE AS CODE, /* '#1054#1073#1086#1089#1085#1086#1074#1072#1085#1080#1077'*/'
      '  MAT_NAME AS NAME, /* '#1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' */'
      '  MAT_UNIT AS UNIT, /* '#1045#1076'. '#1080#1079#1084#1077#1088#1077#1085#1080#1103' */'
      '  COALESCE(MAT_COUNT, 0) AS CNT, /* '#1050#1086#1083'-'#1074#1086' */'
      ''
      '  DOC_DATE, /* '#1044#1072#1090#1072' '#1076#1086#1082#1091#1084#1077#1085#1090#1072' */'
      '  DOC_NUM, /* '#1053#1086#1084#1077#1088' '#1076#1086#1082#1091#1084#1077#1085#1090#1072' */'
      '  PROC_TRANSP, /* % '#1090#1088#1072#1085#1089#1087'. */'
      ''
      
        '  IF(estim.NDS=1, IF(FCOAST_NDS<>0, FCOAST_NDS, COAST_NDS), IF(F' +
        'COAST_NO_NDS<>0, FCOAST_NO_NDS, COAST_NO_NDS)) AS COAST, /* '#1062#1077#1085#1072 +
        ' */ '
      
        '  IF(estim.NDS=1, IF(FPRICE_NDS<>0, FPRICE_NDS, PRICE_NDS), IF(F' +
        'PRICE_NO_NDS<>0, FPRICE_NO_NDS, PRICE_NO_NDS)) AS PRICE, /* '#1057#1090#1086#1080 +
        #1084#1086#1089#1090#1100' */ '
      
        '  IF(estim.NDS=1, IF(FTRANSP_NDS<>0, FTRANSP_NDS, TRANS_NDS), IF' +
        '(FTRANSP_NO_NDS<>0, FTRANSP_NO_NDS, TRANSP_NO_NDS)) AS TRANSP, /' +
        '* '#1090#1088#1072#1085#1089#1087'. */'
      ''
      
        '  IF(FCOAST_NDS<>0, FCOAST_NDS, COAST_NDS) AS COAST_NDS, /* '#1062#1077#1085#1072 +
        ' '#1089' '#1053#1044#1057' */'
      
        '  IF(FCOAST_NO_NDS<>0, FCOAST_NO_NDS, COAST_NO_NDS) AS COAST_NO_' +
        'NDS, /* '#1062#1077#1085#1072' '#1073#1077#1079' '#1053#1044#1057' */'
      
        '  IF(FPRICE_NDS<>0, FPRICE_NDS, PRICE_NDS) AS PRICE_NDS, /* '#1057#1090#1086#1080 +
        #1084#1086#1089#1090#1100' '#1089' '#1053#1044#1057' */'
      
        '  IF(FPRICE_NO_NDS<>0, FPRICE_NO_NDS, PRICE_NO_NDS) AS PRICE_NO_' +
        'NDS, /* '#1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1073#1077#1079' '#1053#1044#1057' */'
      
        '  IF(FTRANSP_NDS<>0, FTRANSP_NDS, TRANS_NDS) AS TRANSP_NDS, /* '#1090 +
        #1088#1072#1085#1089#1087'. '#1089' '#1053#1044#1057'*/'
      
        '  IF(FTRANSP_NO_NDS<>0, FTRANSP_NO_NDS, TRANSP_NO_NDS) AS TRANSP' +
        '_NO_NDS /* '#1090#1088#1072#1085#1089#1087'. '#1073#1077#1079' '#1053#1044#1057'*/'
      'FROM '
      '  data_estimate, card_rate, materialcard, estim'
      'WHERE '
      'data_estimate.ID_TYPE_DATA = 1 AND'
      'card_rate.ID = data_estimate.ID_TABLES AND'
      'materialcard.ID_CARD_RATE = card_rate.ID AND'
      'materialcard.FROM_RATE = 1 AND'
      'estim.OBJ_ID=:OBJ_ID AND '
      '((ID_ESTIMATE = estim.SM_ID) OR /* '#1054#1073#1098#1077#1082#1090#1085#1099#1081' '#1091#1088#1086#1074#1077#1085#1100' */'
      
        ' (ID_ESTIMATE IN (SELECT s1.SM_ID FROM smetasourcedata s1 WHERE ' +
        '(s1.PARENT_LOCAL_ID + s1.PARENT_PTM_ID) = estim.SM_ID)) OR /* '#1051#1086 +
        #1082#1072#1083#1100#1085#1099#1081' '#1091#1088#1086#1074#1077#1085#1100' */'
      
        ' (ID_ESTIMATE IN (SELECT s2.SM_ID FROM smetasourcedata s2 WHERE ' +
        '(s2.PARENT_LOCAL_ID + s2.PARENT_PTM_ID) IN '
      
        '   (SELECT s1.SM_ID FROM smetasourcedata s1 WHERE (s1.PARENT_LOC' +
        'AL_ID + s1.PARENT_PTM_ID) = estim.SM_ID))'
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
      '  estim.NDS AS NDS, /* '#1053#1044#1057'*/'
      '  MAT_CODE AS CODE, /* '#1054#1073#1086#1089#1085#1086#1074#1072#1085#1080#1077'*/'
      '  MAT_NAME AS NAME, /* '#1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' */'
      '  MAT_UNIT AS UNIT, /* '#1045#1076'. '#1080#1079#1084#1077#1088#1077#1085#1080#1103' */'
      '  COALESCE(MAT_COUNT, 0) AS CNT, /* '#1050#1086#1083'-'#1074#1086' */'
      ''
      '  DOC_DATE, /* '#1044#1072#1090#1072' '#1076#1086#1082#1091#1084#1077#1085#1090#1072' */'
      '  DOC_NUM, /* '#1053#1086#1084#1077#1088' '#1076#1086#1082#1091#1084#1077#1085#1090#1072' */'
      '  PROC_TRANSP, /* % '#1090#1088#1072#1085#1089#1087'. */'
      ''
      
        '  IF(estim.NDS=1, IF(FCOAST_NDS<>0, FCOAST_NDS, COAST_NDS), IF(F' +
        'COAST_NO_NDS<>0, FCOAST_NO_NDS, COAST_NO_NDS)) AS COAST, /* '#1062#1077#1085#1072 +
        ' */ '
      
        '  IF(estim.NDS=1, IF(FPRICE_NDS<>0, FPRICE_NDS, PRICE_NDS), IF(F' +
        'PRICE_NO_NDS<>0, FPRICE_NO_NDS, PRICE_NO_NDS)) AS PRICE, /* '#1057#1090#1086#1080 +
        #1084#1086#1089#1090#1100' */ '
      
        '  IF(estim.NDS=1, IF(FTRANSP_NDS<>0, FTRANSP_NDS, TRANS_NDS), IF' +
        '(FTRANSP_NO_NDS<>0, FTRANSP_NO_NDS, TRANSP_NO_NDS)) AS TRANSP, /' +
        '* '#1090#1088#1072#1085#1089#1087'. */'
      ''
      
        '  IF(FCOAST_NDS<>0, FCOAST_NDS, COAST_NDS) AS COAST_NDS, /* '#1062#1077#1085#1072 +
        ' '#1089' '#1053#1044#1057' */'
      
        '  IF(FCOAST_NO_NDS<>0, FCOAST_NO_NDS, COAST_NO_NDS) AS COAST_NO_' +
        'NDS, /* '#1062#1077#1085#1072' '#1073#1077#1079' '#1053#1044#1057' */'
      
        '  IF(FPRICE_NDS<>0, FPRICE_NDS, PRICE_NDS) AS PRICE_NDS, /* '#1057#1090#1086#1080 +
        #1084#1086#1089#1090#1100' '#1089' '#1053#1044#1057' */'
      
        '  IF(FPRICE_NO_NDS<>0, FPRICE_NO_NDS, PRICE_NO_NDS) AS PRICE_NO_' +
        'NDS, /* '#1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1073#1077#1079' '#1053#1044#1057' */'
      
        '  IF(FTRANSP_NDS<>0, FTRANSP_NDS, TRANS_NDS) AS TRANSP_NDS, /* '#1090 +
        #1088#1072#1085#1089#1087'. '#1089' '#1053#1044#1057'*/'
      
        '  IF(FTRANSP_NO_NDS<>0, FTRANSP_NO_NDS, TRANSP_NO_NDS) AS TRANSP' +
        '_NO_NDS /* '#1090#1088#1072#1085#1089#1087'. '#1073#1077#1079' '#1053#1044#1057'*/'
      'FROM '
      '  data_estimate, materialcard, estim'
      'WHERE '
      'data_estimate.ID_TYPE_DATA = 2 AND'
      'materialcard.ID = data_estimate.ID_TABLES AND'
      'estim.OBJ_ID=:OBJ_ID AND '
      '((ID_ESTIMATE = estim.SM_ID) OR  /* '#1054#1073#1098#1077#1082#1090#1085#1099#1081' '#1091#1088#1086#1074#1077#1085#1100' */'
      
        ' (ID_ESTIMATE IN (SELECT s1.SM_ID FROM smetasourcedata s1 WHERE ' +
        '(s1.PARENT_LOCAL_ID + s1.PARENT_PTM_ID) = estim.SM_ID)) OR /* '#1051#1086 +
        #1082#1072#1083#1100#1085#1099#1081' '#1091#1088#1086#1074#1077#1085#1100' */'
      
        ' (ID_ESTIMATE IN (SELECT s2.SM_ID FROM smetasourcedata s2 WHERE ' +
        '(s2.PARENT_LOCAL_ID + s2.PARENT_PTM_ID) IN '
      
        '   (SELECT s1.SM_ID FROM smetasourcedata s1 WHERE (s1.PARENT_LOC' +
        'AL_ID + s1.PARENT_PTM_ID) = estim.SM_ID))'
      ' ) /* '#1055#1058#1052' '#1091#1088#1086#1074#1077#1085#1100' */'
      ')'
      'ORDER BY 1,2')
    Left = 155
    Top = 168
    ParamData = <
      item
        Name = 'OBJ_ID'
        DataType = ftString
        ParamType = ptInput
        Value = '38'
      end>
  end
  object ds1: TDataSource
    DataSet = qr1
    Left = 155
    Top = 216
  end
end
