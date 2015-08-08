object fCalcResource: TfCalcResource
  Left = 0
  Top = 0
  Caption = #1056#1072#1089#1095#1077#1090' '#1089#1090#1086#1080#1084#1086#1089#1090#1080' '#1088#1077#1089#1091#1088#1089#1086#1074' ['#1088#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1079#1072#1087#1088#1077#1097#1077#1085#1086']'
  ClientHeight = 362
  ClientWidth = 616
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
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
    Height = 56
    Align = alTop
    TabOrder = 0
    DesignSize = (
      616
      56)
    object lbl1: TLabel
      Left = 8
      Top = 8
      Width = 35
      Height = 13
      Caption = #1057#1084#1077#1090#1072':'
    end
    object lbl6: TLabel
      Left = 8
      Top = 32
      Width = 87
      Height = 13
      Caption = #1056#1072#1089#1095#1077#1090#1085#1099#1081' '#1084#1077#1089#1103#1094
    end
    object edtEstimateName: TEdit
      Left = 49
      Top = 5
      Width = 437
      Height = 21
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      Color = clMenuBar
      ReadOnly = True
      TabOrder = 1
      Text = #1057#1084#1077#1090#1072
    end
    object cbbFromMonth: TComboBox
      Left = 101
      Top = 29
      Width = 75
      Height = 21
      Style = csDropDownList
      DropDownCount = 12
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemIndex = 0
      ParentFont = False
      TabOrder = 2
      Text = #1071#1085#1074#1072#1088#1100
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
      Left = 179
      Top = 29
      Width = 49
      Height = 22
      Enabled = False
      MaxValue = 2100
      MinValue = 1900
      ReadOnly = True
      TabOrder = 3
      Value = 2014
    end
    object cbbNDS: TComboBox
      Left = 544
      Top = 29
      Width = 67
      Height = 21
      Style = csDropDownList
      Anchors = [akTop, akRight]
      DropDownCount = 12
      Enabled = False
      ItemIndex = 0
      TabOrder = 4
      Text = #1073#1077#1079' '#1053#1044#1057
      OnChange = pgcChange
      Items.Strings = (
        #1073#1077#1079' '#1053#1044#1057
        #1089' '#1053#1044#1057)
    end
    object pnlCalculationYesNo: TPanel
      Tag = 1
      Left = 492
      Top = 3
      Width = 120
      Height = 23
      Cursor = crHandPoint
      Anchors = [akTop, akRight]
      Caption = #1056#1072#1089#1095#1105#1090#1099' '#1079#1072#1087#1088#1077#1097#1077#1085#1099
      Color = clRed
      ParentBackground = False
      TabOrder = 0
      OnClick = pnlCalculationYesNoClick
    end
  end
  object pgc: TPageControl
    Left = 0
    Top = 56
    Width = 616
    Height = 306
    ActivePage = ts2
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
    OnChange = pgcChange
    object ts1: TTabSheet
      Caption = #1056#1072#1089#1095#1077#1090' '#1089#1090#1086#1080#1084#1086#1089#1090#1080
      object lbl2: TLabel
        Left = 0
        Top = 0
        Width = 608
        Height = 278
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
        Top = 193
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
        Height = 29
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        DesignSize = (
          608
          29)
        object edtMatCodeFilter: TEdit
          Left = 4
          Top = 2
          Width = 121
          Height = 21
          TabOrder = 0
          TextHint = #1055#1086#1080#1089#1082' '#1087#1086' '#1082#1086#1076#1091'...'
          OnChange = edtMatCodeFilterChange
          OnClick = edtMatCodeFilterClick
        end
        object edtMatNameFilter: TEdit
          Left = 131
          Top = 2
          Width = 472
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 1
          TextHint = #1055#1086#1080#1089#1082' '#1087#1086' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1102'...'
          OnChange = edtMatCodeFilterChange
          OnClick = edtMatCodeFilterClick
        end
      end
      object pnlMatClient: TPanel
        Left = 0
        Top = 29
        Width = 608
        Height = 164
        Align = alClient
        BevelOuter = bvNone
        Caption = 'pnlMatClient'
        TabOrder = 1
        ExplicitTop = 41
        ExplicitHeight = 152
        object grMaterial: TJvDBGrid
          Left = 0
          Top = 0
          Width = 608
          Height = 145
          Align = alClient
          DataSource = dsMaterialData
          DrawingStyle = gdsClassic
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          PopupMenu = pm
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          OnDrawColumnCell = grMaterialDrawColumnCell
          AutoAppend = False
          IniStorage = FormStorage
          OnTitleBtnClick = grMaterialTitleBtnClick
          AutoSizeColumns = True
          SelectColumnsDialogStrings.Caption = 'Select columns'
          SelectColumnsDialogStrings.OK = '&OK'
          SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
          EditControls = <>
          RowsHeight = 17
          TitleRowHeight = 17
          OnCanEditCell = grMaterialCanEditCell
          Columns = <
            item
              Expanded = False
              FieldName = 'CODE'
              Title.Alignment = taCenter
              Title.Caption = #1050#1086#1076
              Width = 16
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
              Width = 20
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CNT'
              Title.Alignment = taCenter
              Title.Caption = #1050#1086#1083'-'#1074#1086
              Width = 18
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'COAST'
              Title.Alignment = taCenter
              Title.Caption = #1062#1077#1085#1072
              Width = 53
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PRICE'
              Title.Alignment = taCenter
              Title.Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100
              Width = 53
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PROC_TRANSP'
              Title.Alignment = taCenter
              Title.Caption = '% '#1090#1088#1072#1085#1089#1087'.'
              Width = 37
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'TRANSP'
              Title.Alignment = taCenter
              Title.Caption = #1058#1088#1072#1085#1089#1087#1086#1088#1090
              Width = 53
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DOC_DATE'
              Title.Alignment = taCenter
              Title.Caption = #1053#1072#1082#1083'. '#1076#1072#1090#1072
              Width = 37
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DOC_NUM'
              Title.Alignment = taCenter
              Title.Caption = #1053#1072#1082#1083'. '#8470
              Width = 56
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'MAT_PROC_ZAC'
              Title.Caption = '% '#1079#1072#1082#1072#1079#1095#1080#1082#1072
              Width = 37
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'MAT_PROC_PODR'
              Title.Caption = '% '#1087#1086#1076#1088#1103#1076#1095#1080#1082#1072
              Width = 42
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'TRANSP_PROC_ZAC'
              Title.Caption = '% '#1090#1088#1072#1085#1089'. '#1079#1072#1082#1072#1079#1095#1080#1082#1072
              Width = 46
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'TRANSP_PROC_PODR'
              Title.Caption = '% '#1090#1088#1072#1085#1089'. '#1087#1086#1076#1088#1103#1076#1095#1080#1082#1072
              Width = 52
              Visible = True
            end>
        end
        object JvDBGridFooter1: TJvDBGridFooter
          Left = 0
          Top = 145
          Width = 608
          Height = 19
          SizeGrip = True
          Columns = <
            item
              Alignment = taRightJustify
              FieldName = 'PRICE'
            end
            item
              Alignment = taRightJustify
              FieldName = 'TRANSP'
            end>
          DataSource = dsMaterialData
          DBGrid = grMaterial
          OnCalculate = JvDBGridFooter1Calculate
          ExplicitTop = 133
        end
      end
      object pnlMatBott: TPanel
        Left = 0
        Top = 196
        Width = 608
        Height = 82
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
          Height = 56
          Align = alClient
          Constraints.MinHeight = 40
          DataSource = dsMaterialDetail
          DrawingStyle = gdsClassic
          TabOrder = 1
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          OnDrawColumnCell = grMaterialBottDrawColumnCell
          AutoAppend = False
          IniStorage = FormStorage
          AutoSizeColumns = True
          SelectColumnsDialogStrings.Caption = 'Select columns'
          SelectColumnsDialogStrings.OK = '&OK'
          SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
          EditControls = <>
          RowsHeight = 17
          TitleRowHeight = 17
          OnCanEditCell = grMaterialCanEditCell
          Columns = <
            item
              Expanded = False
              FieldName = 'F1'
              Title.Alignment = taCenter
              Title.Caption = #8470#1087#1087
              Width = 61
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CODE'
              Title.Alignment = taCenter
              Title.Caption = #1054#1073#1086#1089#1085#1086#1074#1072#1085#1080#1077
              Width = 61
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CNT'
              Title.Alignment = taCenter
              Title.Caption = #1054#1073#1098#1077#1084' '#1088#1072#1073#1086#1090
              Width = 61
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CNT_DONE'
              Title.Alignment = taCenter
              Title.Caption = #1056#1072#1089#1093#1086#1076
              Width = 61
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'COAST'
              Title.Alignment = taCenter
              Title.Caption = #1062#1077#1085#1072
              Width = 61
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PROC_TRANSP'
              Title.Caption = '% '#1090#1088#1072#1085#1089#1087'.'
              Width = 35
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'TRANSP'
              Title.Caption = #1058#1088#1072#1085#1089#1087#1086#1088#1090
              Width = 40
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'MAT_PROC_ZAC'
              Title.Caption = '% '#1079#1072#1082#1072#1079#1095#1080#1082#1072
              Width = 40
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'MAT_PROC_PODR'
              Title.Caption = '% '#1087#1086#1076#1088#1103#1076#1095#1080#1082#1072
              Width = 49
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'TRANSP_PROC_ZAC'
              Title.Caption = '% '#1090#1088#1072#1085#1089'. '#1079#1072#1082#1072#1079#1095#1080#1082#1072
              Width = 53
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'TRANSP_PROC_PODR'
              Title.Caption = '% '#1090#1088#1072#1085#1089'. '#1087#1086#1076#1088#1103#1076#1095#1080#1082#1072
              Width = 57
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
        Top = 209
        Width = 608
        Height = 3
        Cursor = crVSplit
        Align = alBottom
        ExplicitTop = 224
      end
      object pnlMechClient: TPanel
        Left = 0
        Top = 29
        Width = 608
        Height = 180
        Align = alClient
        BevelOuter = bvNone
        Caption = 'pnlMatClient'
        TabOrder = 1
        ExplicitTop = 41
        ExplicitHeight = 168
        object grMech: TJvDBGrid
          Left = 0
          Top = 0
          Width = 608
          Height = 161
          Align = alClient
          DataSource = dsMechData
          DrawingStyle = gdsClassic
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          PopupMenu = pm
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          OnDrawColumnCell = grMechDrawColumnCell
          AutoAppend = False
          IniStorage = FormStorage
          OnTitleBtnClick = grMechTitleBtnClick
          AutoSizeColumns = True
          SelectColumnsDialogStrings.Caption = 'Select columns'
          SelectColumnsDialogStrings.OK = '&OK'
          SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
          EditControls = <>
          RowsHeight = 17
          TitleRowHeight = 17
          WordWrap = True
          WordWrapAllFields = True
          OnCanEditCell = grMaterialCanEditCell
          Columns = <
            item
              Expanded = False
              FieldName = 'CODE'
              Title.Alignment = taCenter
              Title.Caption = #1050#1086#1076
              Width = 40
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'NAME'
              Title.Alignment = taCenter
              Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
              Visible = False
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'UNIT'
              Title.Alignment = taCenter
              Title.Caption = #1045#1076'. '#1080#1079#1084'.'
              Width = 26
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
              Width = 94
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PRICE'
              Title.Alignment = taCenter
              Title.Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100
              Width = 94
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'ZP_1'
              Title.Alignment = taCenter
              Title.Caption = #1047#1072#1088#1087#1083'. '#1084#1072#1096'.'
              Width = 94
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'ZP_2'
              Title.Alignment = taCenter
              Title.Caption = #1057#1090'-'#1089#1090#1100' '#1079#1072#1088#1087#1083#1072#1090#1099
              Width = 101
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PROC_ZAC'
              Title.Alignment = taCenter
              Title.Caption = '% '#1079#1072#1082#1072#1079#1095#1080#1082#1072
              Width = 59
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PROC_PODR'
              Title.Alignment = taCenter
              Title.Caption = '% '#1087#1086#1076#1088#1103#1076#1095#1080#1082#1072
              Width = 53
              Visible = True
            end>
        end
        object JvDBGridFooter2: TJvDBGridFooter
          Left = 0
          Top = 161
          Width = 608
          Height = 19
          SizeGrip = True
          Columns = <
            item
              Alignment = taRightJustify
              FieldName = 'PRICE'
            end
            item
              Alignment = taRightJustify
              FieldName = 'CNT'
            end
            item
              Alignment = taRightJustify
              FieldName = 'ZP_1'
            end
            item
              Alignment = taRightJustify
              FieldName = 'ZP_2'
            end>
          DataSource = dsMechData
          DBGrid = grMech
          OnCalculate = JvDBGridFooter1Calculate
          ExplicitTop = 149
        end
      end
      object pnlMechBott: TPanel
        Left = 0
        Top = 212
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
          DataSource = dsMechDetail
          DrawingStyle = gdsClassic
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          TabOrder = 1
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          OnDrawColumnCell = grMechBottDrawColumnCell
          AutoAppend = False
          IniStorage = FormStorage
          AutoSizeColumns = True
          SelectColumnsDialogStrings.Caption = 'Select columns'
          SelectColumnsDialogStrings.OK = '&OK'
          SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
          EditControls = <>
          RowsHeight = 17
          TitleRowHeight = 17
          OnCanEditCell = grMaterialCanEditCell
          Columns = <
            item
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = #8470#1087#1087
              Width = 85
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CODE'
              Title.Alignment = taCenter
              Title.Caption = #1054#1073#1086#1089#1085#1086#1074#1072#1085#1080#1077
              Width = 85
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CNT'
              Title.Alignment = taCenter
              Title.Caption = #1054#1073#1098#1077#1084' '#1088#1072#1073#1086#1090
              Width = 85
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CNT_DONE'
              Title.Alignment = taCenter
              Title.Caption = #1056#1072#1089#1093#1086#1076
              Width = 85
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'COAST'
              Title.Alignment = taCenter
              Title.Caption = #1062#1077#1085#1072
              Width = 85
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'ZP_MASH'
              Title.Alignment = taCenter
              Title.Caption = #1047#1055' '#1084#1072#1096'.'
              Width = 48
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PROC_ZAC'
              Title.Alignment = taCenter
              Title.Caption = '% '#1079#1072#1082#1072#1079#1095#1080#1082#1072
              Width = 54
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PROC_PODR'
              Title.Alignment = taCenter
              Title.Caption = '% '#1087#1086#1076#1088#1103#1076#1095#1080#1082#1072
              Width = 55
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
        Height = 29
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        DesignSize = (
          608
          29)
        object edtMechCodeFilter: TEdit
          Left = 4
          Top = 2
          Width = 121
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          TextHint = #1055#1086#1080#1089#1082' '#1087#1086' '#1082#1086#1076#1091'...'
          OnChange = edtMechCodeFilterChange
          OnClick = edtMatCodeFilterClick
        end
        object edtMechNameFilter: TEdit
          Left = 131
          Top = 2
          Width = 472
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 1
          TextHint = #1055#1086#1080#1089#1082' '#1087#1086' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1102'...'
          OnChange = edtMechCodeFilterChange
          OnClick = edtMatCodeFilterClick
        end
      end
    end
    object ts4: TTabSheet
      Caption = #1056#1072#1089#1095#1077#1090' '#1086#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1103
      ImageIndex = 3
      object spl5: TSplitter
        Left = 0
        Top = 209
        Width = 608
        Height = 3
        Cursor = crVSplit
        Align = alBottom
        ExplicitLeft = 3
        ExplicitTop = 225
      end
      object pnlDevTop: TPanel
        Left = 0
        Top = 0
        Width = 608
        Height = 29
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        DesignSize = (
          608
          29)
        object edt1: TEdit
          Left = 4
          Top = 2
          Width = 121
          Height = 21
          TabOrder = 0
          TextHint = #1055#1086#1080#1089#1082' '#1087#1086' '#1082#1086#1076#1091'...'
          OnClick = edtMatCodeFilterClick
        end
        object edt2: TEdit
          Left = 131
          Top = 2
          Width = 472
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 1
          TextHint = #1055#1086#1080#1089#1082' '#1087#1086' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1102'...'
          OnClick = edtMatCodeFilterClick
        end
      end
      object pnlDevClient: TPanel
        Left = 0
        Top = 29
        Width = 608
        Height = 180
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
        ExplicitTop = 41
        ExplicitHeight = 168
        object grDev: TJvDBGrid
          Left = 0
          Top = 0
          Width = 608
          Height = 161
          Align = alClient
          DataSource = dsDevices
          DrawingStyle = gdsClassic
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          OnDrawColumnCell = grDevDrawColumnCell
          AutoAppend = False
          IniStorage = FormStorage
          AutoSizeColumns = True
          SelectColumnsDialogStrings.Caption = 'Select columns'
          SelectColumnsDialogStrings.OK = '&OK'
          SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
          EditControls = <>
          RowsHeight = 17
          TitleRowHeight = 17
          WordWrap = True
          WordWrapAllFields = True
          OnCanEditCell = grMaterialCanEditCell
          Columns = <
            item
              Expanded = False
              FieldName = 'CODE'
              Title.Alignment = taCenter
              Title.Caption = #1050#1086#1076
              Width = 49
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'NAME'
              Title.Alignment = taCenter
              Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
              Visible = False
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'UNIT'
              Title.Alignment = taCenter
              Title.Caption = #1045#1076'. '#1080#1079#1084'.'
              Width = 49
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CNT'
              Title.Alignment = taCenter
              Title.Caption = #1050#1086#1083'-'#1074#1086
              Width = 49
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'COAST'
              Title.Alignment = taCenter
              Title.Caption = #1062#1077#1085#1072
              Width = 49
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PRICE'
              Title.Alignment = taCenter
              Title.Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100
              Width = 49
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PROC_TRANSP'
              Title.Alignment = taCenter
              Title.Caption = '% '#1090#1088#1072#1085#1089#1087'.'
              Visible = False
            end
            item
              Expanded = False
              FieldName = 'TRANSP'
              Title.Alignment = taCenter
              Title.Caption = #1058#1088#1072#1085#1089#1087#1086#1088#1090
              Width = 43
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DOC_DATE'
              Title.Alignment = taCenter
              Title.Caption = #1053#1072#1082#1083'. '#1076#1072#1090#1072
              Width = 49
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DOC_NUM'
              Title.Alignment = taCenter
              Title.Caption = #1053#1072#1082#1083'. '#8470
              Width = 44
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PROC_ZAC'
              Title.Caption = '% '#1079#1072#1082#1072#1079#1095#1080#1082#1072
              Width = 44
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PROC_PODR'
              Title.Caption = '% '#1087#1086#1076#1088#1103#1076#1095#1080#1082#1072
              Width = 48
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'TRANSP_PROC_ZAC'
              Title.Caption = '% '#1090#1088#1072#1085#1089'. '#1079#1072#1082#1072#1079#1095#1080#1082#1072
              Width = 52
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'TRANSP_PROC_PODR'
              Title.Caption = '% '#1090#1088#1072#1085#1089'. '#1087#1086#1076#1088#1103#1076#1095#1080#1082#1072
              Width = 55
              Visible = True
            end>
        end
        object JvDBGridFooter3: TJvDBGridFooter
          Left = 0
          Top = 161
          Width = 608
          Height = 19
          SizeGrip = True
          Columns = <
            item
              Alignment = taRightJustify
              FieldName = 'PRICE'
            end
            item
              Alignment = taRightJustify
              FieldName = 'CNT'
            end
            item
              Alignment = taRightJustify
              FieldName = 'TRANSP'
            end>
          DataSource = dsDevices
          DBGrid = grDev
          OnCalculate = JvDBGridFooter1Calculate
          ExplicitTop = 149
        end
      end
      object pnlDevBott: TPanel
        Left = 0
        Top = 212
        Width = 608
        Height = 66
        Align = alBottom
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
        object grDevBott: TJvDBGrid
          Left = 1
          Top = 25
          Width = 606
          Height = 40
          Align = alClient
          Constraints.MinHeight = 40
          DataSource = dsDevicesDetail
          DrawingStyle = gdsClassic
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          TabOrder = 1
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          AutoAppend = False
          IniStorage = FormStorage
          AutoSizeColumns = True
          SelectColumnsDialogStrings.Caption = 'Select columns'
          SelectColumnsDialogStrings.OK = '&OK'
          SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
          EditControls = <>
          RowsHeight = 17
          TitleRowHeight = 17
          OnCanEditCell = grMaterialCanEditCell
          Columns = <
            item
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = #8470#1087#1087
              Width = 66
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CODE'
              Title.Alignment = taCenter
              Title.Caption = #1054#1073#1086#1089#1085#1086#1074#1072#1085#1080#1077
              Width = 66
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CNT'
              Title.Alignment = taCenter
              Title.Caption = #1054#1073#1098#1077#1084' '#1088#1072#1073#1086#1090
              Width = 66
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CNT_DONE'
              Title.Alignment = taCenter
              Title.Caption = #1056#1072#1089#1093#1086#1076
              Width = 66
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'COAST'
              Title.Alignment = taCenter
              Title.Caption = #1062#1077#1085#1072
              Width = 66
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'TRANSP'
              Title.Caption = #1058#1088#1072#1085#1089#1087#1086#1088#1090
              Width = 37
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PROC_ZAC'
              Title.Caption = '% '#1079#1072#1082#1072#1079#1095#1080#1082#1072
              Width = 63
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PROC_PODR'
              Title.Caption = '% '#1087#1086#1076#1088#1103#1076#1095#1080#1082#1072
              Width = 42
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'TRANSP_PROC_ZAC'
              Title.Caption = '% '#1090#1088#1072#1085#1089'. '#1079#1072#1082#1072#1079#1095#1080#1082#1072
              Width = 52
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'TRANSP_PROC_PODR'
              Title.Caption = '% '#1090#1088#1072#1085#1089'. '#1087#1086#1076#1088#1103#1076#1095#1080#1082#1072
              Width = 56
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
      object pnlRatesClient: TPanel
        Left = 0
        Top = 0
        Width = 608
        Height = 278
        Align = alClient
        Caption = 'pnlRatesClient'
        TabOrder = 0
        ExplicitTop = 26
        ExplicitHeight = 252
        object grRates: TJvDBGrid
          Left = 1
          Top = 1
          Width = 606
          Height = 212
          Align = alClient
          DataSource = dsRates
          DrawingStyle = gdsClassic
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          ParentFont = False
          PopupMenu = pm
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          OnDrawColumnCell = grRatesDrawColumnCell
          AutoAppend = False
          IniStorage = FormStorage
          AutoSizeColumns = True
          SelectColumnsDialogStrings.Caption = 'Select columns'
          SelectColumnsDialogStrings.OK = '&OK'
          SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
          EditControls = <>
          RowsHeight = 17
          TitleRowHeight = 17
          WordWrap = True
          WordWrapAllFields = True
          OnCanEditCell = grMaterialCanEditCell
          Columns = <
            item
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = #8470#1087#1087
              Width = 28
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CODE'
              Title.Alignment = taCenter
              Title.Caption = #1054#1073#1086#1089#1085#1086#1074#1072#1085#1080#1077
              Width = 20
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CNT'
              Title.Alignment = taCenter
              Title.Caption = #1050#1086#1083'-'#1074#1086
              Width = 23
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
              FieldName = 'TRUD_ONE'
              Title.Alignment = taCenter
              Title.Caption = #1058#1088#1091#1076'-'#1090#1099' '#1085#1072' '#1077#1076'.'
              Width = 68
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'K_TRUD'
              Title.Alignment = taCenter
              Title.Caption = #1050#1092' '#1082' '#1090#1088#1091#1076
              Width = 68
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'TRUD'
              Title.Alignment = taCenter
              Title.Caption = #1058#1088#1091#1076#1086#1079#1072#1090#1088#1072#1090#1099
              Width = 48
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Rank'
              Title.Alignment = taCenter
              Title.Caption = #1056#1072#1079#1088#1103#1076
              Width = 68
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'MRCOEF'
              Title.Alignment = taCenter
              Title.Caption = #1052#1077#1078#1088#1072#1079#1088'. '#1082#1092
              Width = 48
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Tariff'
              Title.Alignment = taCenter
              Title.Caption = #1058#1072#1088#1080#1092
              Width = 73
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'K_ZP'
              Title.Alignment = taCenter
              Title.Caption = #1050'-'#1092
              Width = 51
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'ZP'
              Title.Alignment = taCenter
              Title.Caption = #1047#1072#1088#1087#1083#1072#1090#1072
              Width = 58
              Visible = True
            end>
        end
        object JvDBGridFooter4: TJvDBGridFooter
          Left = 1
          Top = 213
          Width = 606
          Height = 19
          SizeGrip = True
          Columns = <
            item
              Alignment = taRightJustify
              FieldName = 'ZP'
            end
            item
              Alignment = taRightJustify
              FieldName = 'CNT'
            end
            item
              Alignment = taRightJustify
              FieldName = 'TRUD'
            end>
          DataSource = dsRates
          DBGrid = grRates
          OnCalculate = JvDBGridFooter1Calculate
          ExplicitTop = 187
        end
        object dbmmoNAME3: TDBMemo
          Left = 1
          Top = 232
          Width = 606
          Height = 45
          Align = alBottom
          DataField = 'NAME'
          DataSource = dsRates
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 2
          ExplicitTop = 206
        end
      end
    end
  end
  object pm: TPopupMenu
    OnPopup = pmPopup
    Left = 556
    Top = 168
    object N1: TMenuItem
      Caption = #1042#1099#1076#1077#1083#1080#1090#1100
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = #1042#1099#1076#1077#1083#1080#1090#1100' '#1074#1089#1077
      OnClick = N2Click
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object mDetete: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100
      OnClick = mDeteteClick
    end
    object mRestore: TMenuItem
      Caption = #1042#1086#1089#1089#1090#1072#1085#1086#1074#1080#1090#1100
      OnClick = mRestoreClick
    end
    object mReplace: TMenuItem
      Caption = #1047#1072#1084#1077#1085#1080#1090#1100
      OnClick = mReplaceClick
    end
    object mN7: TMenuItem
      Caption = '-'
    end
    object mShowDeleted: TMenuItem
      AutoCheck = True
      Caption = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1091#1076#1072#1083#1077#1085#1085#1099#1077
      OnClick = pgcChange
    end
  end
  object qrMaterialData: TFDQuery
    BeforeOpen = qrMaterialDataBeforeOpen
    AfterOpen = qrMaterialDataAfterOpen
    BeforePost = qrMaterialDataBeforePost
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FetchOptions.AssignedValues = [evCache, evAutoFetchAll]
    FetchOptions.Cache = [fiBlobs, fiMeta]
    FormatOptions.AssignedValues = [fvMapRules, fvDefaultParamDataType, fvFmtDisplayNumeric]
    FormatOptions.OwnMapRules = True
    FormatOptions.MapRules = <
      item
        SourceDataType = dtMemo
        TargetDataType = dtAnsiString
      end>
    FormatOptions.DefaultParamDataType = ftBCD
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvUpdateChngFields, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.CheckUpdatable = False
    SQL.Strings = (
      'SELECT '
      '  MIN(IF(ID_REPLACED<>0, ID_REPLACED, ID)),'
      '  MAT_CODE AS CODE, /* '#1054#1073#1086#1089#1085#1086#1074#1072#1085#1080#1077'*/'
      '  MAT_NAME AS NAME, /* '#1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' */'
      '  MAT_UNIT AS UNIT, /* '#1045#1076'. '#1080#1079#1084#1077#1088#1077#1085#1080#1103' */'
      '  SUM(COALESCE(MAT_COUNT, 0)) AS CNT, /* '#1050#1086#1083'-'#1074#1086' */'
      ''
      '  DOC_DATE, /* '#1044#1072#1090#1072' '#1076#1086#1082#1091#1084#1077#1085#1090#1072' */'
      '  DOC_NUM, /* '#1053#1086#1084#1077#1088' '#1076#1086#1082#1091#1084#1077#1085#1090#1072' */'
      '  PROC_TRANSP, /* % '#1090#1088#1072#1085#1089#1087'. */'
      
        '  IF(:NDS=1, IF(FCOAST_NDS<>0, 1, 0), IF(FCOAST_NO_NDS<>0, 1, 0)' +
        ') AS FCOAST, /* '#1062#1077#1085#1072' F */ '
      
        '  IF(:NDS=1, IF(FCOAST_NDS<>0, FCOAST_NDS, COAST_NDS), IF(FCOAST' +
        '_NO_NDS<>0, FCOAST_NO_NDS, COAST_NO_NDS)) AS COAST, /* '#1062#1077#1085#1072' */ '
      
        '  SUM(ROUND(IF(:NDS=1, IF(FCOAST_NDS<>0, FCOAST_NDS, COAST_NDS),' +
        ' IF(FCOAST_NO_NDS<>0, FCOAST_NO_NDS, COAST_NO_NDS))*COALESCE(MAT' +
        '_COUNT, 0))) AS PRICE, /* '#1057#1090#1086#1080#1084#1086#1089#1090#1100' */ '
      
        '  SUM(IF(:NDS=1, IF(FTRANSP_NDS<>0, FTRANSP_NDS, TRANSP_NDS), IF' +
        '(FTRANSP_NO_NDS<>0, FTRANSP_NO_NDS, TRANSP_NO_NDS))) AS TRANSP, ' +
        '/* '#1090#1088#1072#1085#1089#1087'. */ '
      '  DELETED,'
      '  MAT_PROC_ZAC,'
      '  MAT_PROC_PODR,'
      '  TRANSP_PROC_ZAC,'
      '  TRANSP_PROC_PODR,'
      '  MAT_ID,'
      '  REPLACED,'
      '  (ID_REPLACED<>0) AS FREPLACED'
      'FROM '
      '  materialcard_temp'
      'WHERE ((DELETED = 0) OR (:SHOW_DELETED)) /*AND REPLACED = 0*/'
      
        'GROUP BY CODE, NAME, UNIT, DOC_DATE, DOC_NUM, PROC_TRANSP, FCOAS' +
        'T, COAST, DELETED,  '
      
        'MAT_PROC_ZAC, MAT_PROC_PODR, TRANSP_PROC_ZAC, TRANSP_PROC_PODR, ' +
        'MAT_ID, REPLACED, FREPLACED'
      'ORDER BY 1, REPLACED DESC, 2')
    Left = 27
    Top = 168
    ParamData = <
      item
        Name = 'NDS'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end
      item
        Name = 'SHOW_DELETED'
        DataType = ftBCD
        ParamType = ptInput
      end>
    object strngfldMaterialDataCODE: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'CODE'
      Origin = 'MAT_CODE'
      Size = 15
    end
    object strngfldMaterialDataNAME: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'NAME'
      Origin = 'MAT_NAME'
      Size = 300
    end
    object strngfldMaterialDataUNIT: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'UNIT'
      Origin = 'MAT_UNIT'
      Size = 100
    end
    object qrMaterialDataCNT: TFMTBCDField
      AutoGenerateValue = arDefault
      FieldName = 'CNT'
      Origin = 'CNT'
      ProviderFlags = []
      Precision = 46
    end
    object qrMaterialDataDOC_DATE: TDateField
      AutoGenerateValue = arDefault
      FieldName = 'DOC_DATE'
      Origin = 'DOC_DATE'
    end
    object strngfldMaterialDataDOC_NUM: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'DOC_NUM'
      Origin = 'DOC_NUM'
      Size = 50
    end
    object qrMaterialDataPROC_TRANSP: TFMTBCDField
      AutoGenerateValue = arDefault
      FieldName = 'PROC_TRANSP'
      Origin = 'PROC_TRANSP'
      Precision = 24
    end
    object qrMaterialDataCOAST: TFMTBCDField
      AutoGenerateValue = arDefault
      FieldName = 'COAST'
      Origin = 'COAST'
      ProviderFlags = []
      Precision = 26
    end
    object qrMaterialDataPRICE: TFMTBCDField
      AutoGenerateValue = arDefault
      FieldName = 'PRICE'
      Origin = 'PRICE'
      ProviderFlags = []
      Precision = 55
      Size = 0
    end
    object qrMaterialDataTRANSP: TFMTBCDField
      AutoGenerateValue = arDefault
      FieldName = 'TRANSP'
      Origin = 'TRANSP'
      ProviderFlags = []
      Precision = 46
    end
    object qrMaterialDataDELETED: TByteField
      AutoGenerateValue = arDefault
      FieldName = 'DELETED'
      Origin = 'DELETED'
    end
    object qrMaterialDataMAT_PROC_ZAC: TWordField
      AutoGenerateValue = arDefault
      FieldName = 'MAT_PROC_ZAC'
      Origin = 'MAT_PROC_ZAC'
      OnChange = qrMaterialDataMAT_PROC_ZACChange
    end
    object qrMaterialDataMAT_PROC_PODR: TWordField
      AutoGenerateValue = arDefault
      FieldName = 'MAT_PROC_PODR'
      Origin = 'MAT_PROC_PODR'
      OnChange = qrMaterialDataMAT_PROC_PODRChange
    end
    object qrMaterialDataTRANSP_PROC_ZAC: TWordField
      AutoGenerateValue = arDefault
      FieldName = 'TRANSP_PROC_ZAC'
      Origin = 'TRANSP_PROC_ZAC'
      OnChange = qrMaterialDataTRANSP_PROC_ZACChange
    end
    object qrMaterialDataTRANSP_PROC_PODR: TWordField
      AutoGenerateValue = arDefault
      FieldName = 'TRANSP_PROC_PODR'
      Origin = 'TRANSP_PROC_PODR'
      OnChange = qrMaterialDataTRANSP_PROC_PODRChange
    end
    object qrMaterialDataMAT_ID: TLongWordField
      AutoGenerateValue = arDefault
      FieldName = 'MAT_ID'
      Origin = 'MAT_ID'
    end
    object qrMaterialDataFCOAST: TIntegerField
      FieldName = 'FCOAST'
    end
    object qrMaterialDataREPLACED: TIntegerField
      FieldName = 'REPLACED'
    end
    object qrMaterialDataFREPLACED: TIntegerField
      FieldName = 'FREPLACED'
    end
  end
  object dsMaterialData: TDataSource
    DataSet = qrMaterialData
    Left = 27
    Top = 216
  end
  object qrMechData: TFDQuery
    BeforeOpen = qrMaterialDataBeforeOpen
    AfterOpen = qrMaterialDataAfterOpen
    BeforePost = qrMechDataBeforePost
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
      'SELECT '
      '  MIN(IF(ID_REPLACED<>0, ID_REPLACED, ID)),'
      '  MECH_CODE AS CODE, /* '#1054#1073#1086#1089#1085#1086#1074#1072#1085#1080#1077'*/'
      '  MECH_NAME AS NAME, /* '#1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' */'
      '  MECH_UNIT AS UNIT, /* '#1045#1076'. '#1080#1079#1084#1077#1088#1077#1085#1080#1103' */'
      '  SUM(COALESCE(MECH_COUNT, 0)) AS CNT, /* '#1050#1086#1083'-'#1074#1086' */'
      ''
      '  DOC_DATE, /* '#1044#1072#1090#1072' '#1076#1086#1082#1091#1084#1077#1085#1090#1072' */'
      '  DOC_NUM, /* '#1053#1086#1084#1077#1088' '#1076#1086#1082#1091#1084#1077#1085#1090#1072' */'
      ''
      
        '  IF(:NDS=1, IF(FCOAST_NDS<>0, FCOAST_NDS, COAST_NDS), IF(FCOAST' +
        '_NO_NDS<>0, FCOAST_NO_NDS, COAST_NO_NDS)) AS COAST, /* '#1062#1077#1085#1072' */ '
      
        '  SUM(IF(:NDS=1, IF(FPRICE_NDS<>0, FPRICE_NDS, PRICE_NDS), IF(FP' +
        'RICE_NO_NDS<>0, FPRICE_NO_NDS, PRICE_NO_NDS))) AS PRICE, /* '#1057#1090#1086#1080 +
        #1084#1086#1089#1090#1100' */  '
      '  '
      
        '  IF(:NDS=1, IF(FZP_MACH_NDS<>0, FZP_MACH_NDS, ZP_MACH_NDS), IF(' +
        'FZP_MACH_NO_NDS<>0, FZP_MACH_NO_NDS, ZP_MACH_NO_NDS)) AS ZP_1, /' +
        '* '#1047#1055' '#1084#1072#1096#1080#1085#1080#1089#1090#1072' */ '
      
        '  SUM(IF(:NDS=1, IF(FZPPRICE_NDS <>0, FZPPRICE_NDS, ZPPRICE_NDS)' +
        ', IF(FZPPRICE_NO_NDS<>0, FZPPRICE_NO_NDS, ZPPRICE_NO_NDS))) AS Z' +
        'P_2, /* '#1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1047#1055' '#1084#1072#1096#1080#1085#1080#1089#1090#1072' */ '
      ' '
      '  DELETED,'
      '  PROC_ZAC,'
      '  PROC_PODR,'
      '  MECH_ID,'
      '  REPLACED,'
      '  (ID_REPLACED<>0) AS FREPLACED'
      'FROM '
      '  mechanizmcard_temp'
      'WHERE ((DELETED = 0) OR (:SHOW_DELETED)) /*AND REPLACED = 0*/'
      
        'GROUP BY CODE, NAME, UNIT, DOC_DATE, DOC_NUM, COAST, ZP_1, DELET' +
        'ED, PROC_ZAC, PROC_PODR, MECH_ID, REPLACED, FREPLACED'
      'ORDER BY 1, REPLACED DESC, 2')
    Left = 99
    Top = 168
    ParamData = <
      item
        Name = 'NDS'
        DataType = ftInteger
        ParamType = ptInput
        Value = 0
      end
      item
        Name = 'SHOW_DELETED'
        DataType = ftInteger
        ParamType = ptInput
        Value = 0
      end>
    object strngfldMechDataCODE: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'CODE'
      Origin = 'MECH_CODE'
      Size = 15
    end
    object strngfldMechDataNAME: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'NAME'
      Origin = 'MECH_NAME'
      Size = 300
    end
    object strngfldMechDataUNIT: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'UNIT'
      Origin = 'MECH_UNIT'
      Size = 100
    end
    object qrMechDataCNT: TFMTBCDField
      AutoGenerateValue = arDefault
      FieldName = 'CNT'
      Origin = 'CNT'
      ProviderFlags = []
      Precision = 46
    end
    object qrMechDataDOC_DATE: TDateField
      AutoGenerateValue = arDefault
      FieldName = 'DOC_DATE'
      Origin = 'DOC_DATE'
    end
    object strngfldMechDataDOC_NUM: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'DOC_NUM'
      Origin = 'DOC_NUM'
      Size = 50
    end
    object qrMechDataCOAST: TFMTBCDField
      AutoGenerateValue = arDefault
      FieldName = 'COAST'
      Origin = 'COAST'
      ProviderFlags = []
      Precision = 25
    end
    object qrMechDataPRICE: TFMTBCDField
      AutoGenerateValue = arDefault
      FieldName = 'PRICE'
      Origin = 'PRICE'
      ProviderFlags = []
      Precision = 46
    end
    object qrMechDataZP_1: TFMTBCDField
      AutoGenerateValue = arDefault
      FieldName = 'ZP_1'
      Origin = 'ZP_1'
      ProviderFlags = []
      Precision = 25
    end
    object qrMechDataZP_2: TFMTBCDField
      AutoGenerateValue = arDefault
      FieldName = 'ZP_2'
      Origin = 'ZP_2'
      ProviderFlags = []
      Precision = 46
    end
    object qrMechDataDELETED: TByteField
      AutoGenerateValue = arDefault
      FieldName = 'DELETED'
      Origin = 'DELETED'
    end
    object qrMechDataPROC_ZAC: TWordField
      AutoGenerateValue = arDefault
      FieldName = 'PROC_ZAC'
      Origin = 'PROC_ZAC'
      OnChange = qrMechDataPROC_ZACChange
    end
    object qrMechDataPROC_PODR: TWordField
      AutoGenerateValue = arDefault
      FieldName = 'PROC_PODR'
      Origin = 'PROC_PODR'
      OnChange = qrMechDataPROC_PODRChange
    end
    object qrMechDataMECH_ID: TLongWordField
      AutoGenerateValue = arDefault
      FieldName = 'MECH_ID'
      Origin = 'MECH_ID'
    end
    object qrMechDataREPLACED: TIntegerField
      FieldName = 'REPLACED'
    end
    object qrMechDataFREPLACED: TIntegerField
      FieldName = 'FREPLACED'
    end
  end
  object dsMechData: TDataSource
    DataSet = qrMechData
    Left = 99
    Top = 216
  end
  object qrDevices: TFDQuery
    BeforeOpen = qrMaterialDataBeforeOpen
    AfterOpen = qrMaterialDataAfterOpen
    BeforePost = qrDevicesBeforePost
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
      '  DEVICE_CODE AS CODE, /* '#1054#1073#1086#1089#1085#1086#1074#1072#1085#1080#1077'*/'
      '  DEVICE_NAME AS NAME, /* '#1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' */'
      '  DEVICE_UNIT AS UNIT, /* '#1045#1076'. '#1080#1079#1084#1077#1088#1077#1085#1080#1103' */'
      '  SUM(COALESCE(DEVICE_COUNT, 0)) AS CNT, /* '#1050#1086#1083'-'#1074#1086' */'
      ''
      '  DOC_DATE, /* '#1044#1072#1090#1072' '#1076#1086#1082#1091#1084#1077#1085#1090#1072' */'
      '  DOC_NUM, /* '#1053#1086#1084#1077#1088' '#1076#1086#1082#1091#1084#1077#1085#1090#1072' */'
      ''
      
        '  IF(:NDS=1, IF(FCOAST_NDS<>0, FCOAST_NDS, 0), IF(FCOAST_NO_NDS<' +
        '>0, FCOAST_NO_NDS, 0)) AS COAST, /* '#1062#1077#1085#1072' */ '
      
        '  SUM(IF(:NDS=1, IF(FPRICE_NDS<>0, FPRICE_NDS, 0), IF(FPRICE_NO_' +
        'NDS<>0, FPRICE_NO_NDS, 0))) AS PRICE, /* '#1057#1090#1086#1080#1084#1086#1089#1090#1100' */ '
      
        '  SUM(IF(:NDS=1, IF(DEVICE_TRANSP_NDS<>0, DEVICE_TRANSP_NDS, 0),' +
        ' IF(DEVICE_TRANSP_NO_NDS<>0, DEVICE_TRANSP_NO_NDS, 0))) AS TRANS' +
        'P,  /* '#1090#1088#1072#1085#1089#1087'. */'
      '  PROC_ZAC,'
      '  PROC_PODR,'
      '  TRANSP_PROC_ZAC,'
      '  TRANSP_PROC_PODR,'
      '  0 AS DELETED,'
      '  DEVICE_ID'
      'FROM devicescard_temp'
      
        'GROUP BY CODE,NAME,UNIT,DOC_DATE,DOC_NUM,COAST,PROC_ZAC,PROC_POD' +
        'R,TRANSP_PROC_ZAC,TRANSP_PROC_PODR,DELETED,DEVICE_ID'
      'ORDER BY 1')
    Left = 155
    Top = 168
    ParamData = <
      item
        Name = 'NDS'
        DataType = ftString
        ParamType = ptInput
        Value = '1'
      end>
    object strngfldDevicesCODE: TStringField
      FieldName = 'CODE'
      Origin = 'DEVICE_CODE'
      Required = True
      Size = 15
    end
    object strngfldDevicesNAME: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'NAME'
      Origin = 'DEVICE_NAME'
      Size = 300
    end
    object strngfldDevicesUNIT: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'UNIT'
      Origin = 'DEVICE_UNIT'
    end
    object qrDevicesCNT: TFMTBCDField
      AutoGenerateValue = arDefault
      FieldName = 'CNT'
      Origin = 'CNT'
      ProviderFlags = []
      Precision = 46
    end
    object qrDevicesDOC_DATE: TDateField
      AutoGenerateValue = arDefault
      FieldName = 'DOC_DATE'
      Origin = 'DOC_DATE'
    end
    object strngfldDevicesDOC_NUM: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'DOC_NUM'
      Origin = 'DOC_NUM'
      Size = 50
    end
    object qrDevicesCOAST: TFMTBCDField
      AutoGenerateValue = arDefault
      FieldName = 'COAST'
      Origin = 'COAST'
      ProviderFlags = []
      Precision = 25
    end
    object qrDevicesPRICE: TFMTBCDField
      AutoGenerateValue = arDefault
      FieldName = 'PRICE'
      Origin = 'PRICE'
      ProviderFlags = []
      Precision = 46
    end
    object qrDevicesTRANSP: TFMTBCDField
      AutoGenerateValue = arDefault
      FieldName = 'TRANSP'
      Origin = 'TRANSP'
      ProviderFlags = []
      Precision = 46
    end
    object qrDevicesPROC_ZAC: TWordField
      AutoGenerateValue = arDefault
      FieldName = 'PROC_ZAC'
      Origin = 'PROC_ZAC'
      OnChange = qrDevicesPROC_ZACChange
    end
    object qrDevicesPROC_PODR: TWordField
      AutoGenerateValue = arDefault
      FieldName = 'PROC_PODR'
      Origin = 'PROC_PODR'
      OnChange = qrDevicesPROC_PODRChange
    end
    object qrDevicesTRANSP_PROC_ZAC: TWordField
      AutoGenerateValue = arDefault
      FieldName = 'TRANSP_PROC_ZAC'
      Origin = 'TRANSP_PROC_ZAC'
      OnChange = qrDevicesTRANSP_PROC_ZACChange
    end
    object qrDevicesTRANSP_PROC_PODR: TWordField
      AutoGenerateValue = arDefault
      FieldName = 'TRANSP_PROC_PODR'
      Origin = 'TRANSP_PROC_PODR'
      OnChange = qrDevicesTRANSP_PROC_PODRChange
    end
    object qrDevicesDELETED: TLargeintField
      AutoGenerateValue = arDefault
      FieldName = 'DELETED'
      Origin = 'DELETED'
      ProviderFlags = []
    end
    object qrDevicesDEVICE_ID: TLongWordField
      FieldName = 'DEVICE_ID'
      Origin = 'DEVICE_ID'
      Required = True
    end
  end
  object dsDevices: TDataSource
    DataSet = qrDevices
    Left = 155
    Top = 216
  end
  object qrRates: TFDQuery
    BeforeOpen = qrMaterialDataBeforeOpen
    AfterOpen = qrMaterialDataAfterOpen
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
      'SELECT '
      '  ID_ESTIMATE,'
      '  ID_TYPE_DATA,'
      '  card_rate_temp.ID AS ID_TABLES,'
      ''
      '  RATE_CODE AS CODE, /* '#1054#1073#1086#1089#1085#1086#1074#1072#1085#1080#1077'*/'
      '  RATE_CAPTION AS NAME, /* '#1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' */'
      '  RATE_UNIT AS UNIT, /* '#1045#1076'. '#1080#1079#1084#1077#1088#1077#1085#1080#1103' */'
      '  COALESCE(RATE_COUNT, 0) AS CNT, /* '#1050#1086#1083'-'#1074#1086' */'
      ''
      
        '  data_row_temp.TRUD / COALESCE(RATE_COUNT, 0) AS TRUD_ONE, /* '#1090 +
        #1088#1091#1076#1086#1079#1072#1090#1088#1072#1090#1099' '#1085#1072' '#1077#1076'. */'
      '  data_row_temp.TRUD AS TRUD, /* '#1090#1088#1091#1076#1086#1079#1072#1090#1088#1072#1090#1099' */'
      '  data_row_temp.K_TRUD, /* '#1082#1086#1101#1092'. '#1082' '#1076#1088#1091#1076' */'
      
        '  (SELECT norma FROM normativwork WHERE normativ_id = card_rate_' +
        'temp.RATE_ID and work_id = 1 LIMIT 1) AS Rank, /* '#1088#1072#1079#1088#1103#1076' */'
      '  (SELECT IFNULL(c.`COEF`, 0.0) '
      '   FROM `category` c'
      
        '   WHERE c.`VALUE` = (SELECT norma FROM normativwork WHERE norma' +
        'tiv_id = card_rate_temp.RATE_ID and work_id = 1 LIMIT 1) and '
      
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
        'tiv_id = card_rate_temp.RATE_ID and work_id = 1 LIMIT 1) and '
      
        '   c.`DATE_BEG` <= (SELECT CONVERT(CONCAT(stavka.YEAR,"-",stavka' +
        '.MONAT,"-01"), DATE) FROM stavka WHERE stavka.STAVKA_ID = smetas' +
        'ourcedata.STAVKA_ID)'
      '   ORDER BY c.`DATE_BEG` DESC '
      '   LIMIT 1)) AS Tariff, /* '#1058#1072#1088#1080#1092' */'
      '  data_row_temp.K_ZP,  /* KZP */'
      '  ROUND(data_row_temp.ZP) AS ZP /* ZP */'
      ', 0 AS DELETED'
      'FROM '
      '  smetasourcedata, data_row_temp, card_rate_temp, stavka'
      'WHERE '
      'data_row_temp.ID_TYPE_DATA = 1 AND'
      'card_rate_temp.ID = data_row_temp.ID_TABLES AND'
      '  ((smetasourcedata.SM_ID = :SM_ID) OR'
      '           (smetasourcedata.PARENT_ID = :SM_ID) OR '
      '           (smetasourcedata.PARENT_ID IN ('
      '             SELECT SM_ID'
      '             FROM smetasourcedata'
      '             WHERE PARENT_ID = :SM_ID AND DELETED=0))) AND '
      'stavka.STAVKA_ID = smetasourcedata.STAVKA_ID AND'
      'data_row_temp.ID_ESTIMATE = smetasourcedata.SM_ID'
      ''
      'ORDER BY 5')
    Left = 211
    Top = 168
    ParamData = <
      item
        Name = 'SM_ID'
        ParamType = ptInput
      end>
  end
  object dsRates: TDataSource
    DataSet = qrRates
    Left = 211
    Top = 216
  end
  object FormStorage: TJvFormStorage
    AppStorage = FormMain.AppIni
    AppStoragePath = '%FORM_NAME%\'
    Options = []
    StoredProps.Strings = (
      'pnlMatBott.Height'
      'pnlMechBott.Height'
      'pnlDevBott.Height')
    StoredValues = <>
    Left = 552
    Top = 216
  end
  object qrMaterialDetail: TFDQuery
    BeforeOpen = qrMaterialDataBeforeOpen
    BeforePost = qrMaterialDetailBeforePost
    MasterSource = dsMaterialData
    MasterFields = 'MAT_ID'
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FetchOptions.AssignedValues = [evCache, evAutoFetchAll]
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
      end>
    FormatOptions.DefaultParamDataType = ftBCD
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.CheckUpdatable = False
    SQL.Strings = (
      'SELECT '
      '  IF(m.ID_REPLACED<>0, m.ID_REPLACED, m.ID) AS F1,'
      '  COALESCE(c.RATE_CODE, m.MAT_CODE) AS CODE, '
      
        '  COALESCE(c.RATE_COUNT, IFNULL(m.MAT_COUNT, 0)) AS CNT, /* '#1050#1086#1083'-' +
        #1074#1086' */'
      
        '  IF(:NDS=1, IF(m.FCOAST_NDS<>0, 1, 0), IF(m.FCOAST_NO_NDS<>0, 1' +
        ', 0)) AS FCOAST, /* '#1062#1077#1085#1072' F */ '
      
        '  IF(:NDS=1, IF(m.FCOAST_NDS<>0, m.FCOAST_NDS, m.COAST_NDS), IF(' +
        'm.FCOAST_NO_NDS<>0, m.FCOAST_NO_NDS, m.COAST_NO_NDS)) AS COAST, ' +
        '/* '#1062#1077#1085#1072' */'
      
        '  /* IFNULL((SELECT SUM(MAT_COUNT) FROM MATERIALCARD_ACT WHERE I' +
        'D=m.ID AND DELETED = 0), 0) AS CNT_DONE, '#1042#1099#1087#1086#1083#1085#1077#1085#1086'*/ '
      '  IFNULL(m.MAT_COUNT, 0) AS CNT_DONE, /* '#1056#1072#1089#1093#1086#1076' */'
      '  m.DELETED,'
      '  d.ID AS data_estimate_id,'
      '  m.MAT_PROC_ZAC,'
      '  m.MAT_PROC_PODR,'
      '  m.TRANSP_PROC_ZAC,'
      '  m.TRANSP_PROC_PODR,'
      '  m.PROC_TRANSP,'
      
        '  IF(:NDS=1, IF(m.FTRANSP_NDS<>0, m.FTRANSP_NDS, m.TRANSP_NDS), ' +
        'IF(m.FTRANSP_NO_NDS<>0, m.FTRANSP_NO_NDS, m.TRANSP_NO_NDS)) AS T' +
        'RANSP,'
      '  m.MAT_ID,'
      '  m.ID,'
      '  m.REPLACED,'
      '  m.ID_REPLACED'
      'FROM        '
      'data_row_temp AS d '
      
        'left join card_rate_temp AS c on d.ID_TYPE_DATA = 1 AND c.ID = d' +
        '.ID_TABLES '
      
        'join materialcard_temp AS m on ((d.ID_TYPE_DATA = 2 AND m.ID = d' +
        '.ID_TABLES) OR (m.ID_CARD_RATE = c.ID)) AND m.MAT_ID = :MAT_ID'
      'WHERE'
      '  ((m.DELETED = 0) OR (:SHOW_DELETED))'
      'ORDER BY 1,2')
    Left = 27
    Top = 264
    ParamData = <
      item
        Name = 'NDS'
        DataType = ftInteger
        ParamType = ptInput
        Value = 0
      end
      item
        Name = 'MAT_ID'
        DataType = ftBCD
        ParamType = ptInput
      end
      item
        Name = 'SHOW_DELETED'
        DataType = ftBCD
        ParamType = ptInput
      end>
  end
  object dsMaterialDetail: TDataSource
    DataSet = qrMaterialDetail
    Left = 27
    Top = 312
  end
  object qrEstimate: TFDQuery
    AfterOpen = qrMaterialDataAfterOpen
    BeforePost = qrMaterialDataBeforePost
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FetchOptions.AssignedValues = [evCache, evAutoFetchAll]
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
      end>
    FormatOptions.DefaultParamDataType = ftBCD
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvUpdateChngFields, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.CheckUpdatable = False
    SQL.Strings = (
      
        'SELECT CONCAT(SM_NUMBER, " ",  NAME) AS NAME, NDS, stavka.MONAT ' +
        'AS MONTH, stavka.YEAR'
      'FROM '
      '  smetasourcedata, stavka'
      'WHERE '
      'smetasourcedata.SM_ID=:SM_ID AND  '
      'stavka.STAVKA_ID = smetasourcedata.STAVKA_ID')
    Left = 331
    Top = 8
    ParamData = <
      item
        Name = 'SM_ID'
        ParamType = ptInput
      end>
  end
  object qrMechDetail: TFDQuery
    BeforeOpen = qrMaterialDataBeforeOpen
    BeforePost = qrMechDetailBeforePost
    MasterSource = dsMechData
    MasterFields = 'MECH_ID'
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FetchOptions.AssignedValues = [evCache, evAutoFetchAll]
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
      end>
    FormatOptions.DefaultParamDataType = ftBCD
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.CheckUpdatable = False
    SQL.Strings = (
      'SELECT '
      '  IF(m.ID_REPLACED<>0, m.ID_REPLACED, m.ID),'
      '  COALESCE(c.RATE_CODE, m.MECH_CODE) AS CODE, '
      
        '  COALESCE(c.RATE_COUNT, IFNULL(m.MECH_COUNT, 0)) AS CNT, /* '#1050#1086#1083 +
        '-'#1074#1086' */'
      
        '  IF(:NDS=1, IF(m.FCOAST_NDS<>0, m.FCOAST_NDS, m.COAST_NDS), IF(' +
        'm.FCOAST_NO_NDS<>0, m.FCOAST_NO_NDS, m.COAST_NO_NDS)) AS COAST, ' +
        '/* '#1062#1077#1085#1072' */'
      
        '  IF(:NDS=1, IF(m.FZP_MACH_NDS<>0, m.FZP_MACH_NDS, m.ZP_MACH_NDS' +
        '), IF(m.FZP_MACH_NO_NDS<>0, m.FZP_MACH_NO_NDS, m.ZP_MACH_NO_NDS)' +
        ') AS ZP_MASH, /* '#1047#1055' '#1084#1072#1096#1080#1085#1080#1089#1090#1072' */ '
      '  IFNULL(m.MECH_COUNT, 0) AS CNT_DONE, /* '#1056#1072#1089#1093#1086#1076' */'
      '  m.DELETED,'
      '  d.ID AS data_estimate_id,'
      '  m.PROC_ZAC,'
      '  m.PROC_PODR,'
      '  m.MECH_ID,'
      '  m.ID,'
      '  m.REPLACED,'
      '  m.ID_REPLACED'
      'FROM        '
      'data_row_temp AS d '
      
        'left join card_rate_temp AS c on d.ID_TYPE_DATA = 1 AND c.ID = d' +
        '.ID_TABLES '
      
        'join mechanizmcard_temp AS m on ((d.ID_TYPE_DATA = 3 AND m.ID = ' +
        'd.ID_TABLES) OR (m.ID_CARD_RATE = c.ID)) AND m.MECH_ID = :MECH_I' +
        'D'
      'WHERE'
      '  ((m.DELETED = 0) OR (:SHOW_DELETED))'
      'ORDER BY 1,2')
    Left = 99
    Top = 264
    ParamData = <
      item
        Name = 'NDS'
        DataType = ftInteger
        ParamType = ptInput
        Value = 0
      end
      item
        Name = 'MECH_ID'
        DataType = ftBCD
        ParamType = ptInput
      end
      item
        Name = 'SHOW_DELETED'
        DataType = ftBCD
        ParamType = ptInput
      end>
  end
  object dsMechDetail: TDataSource
    DataSet = qrMechDetail
    Left = 99
    Top = 312
  end
  object qrDevicesDetail: TFDQuery
    BeforeOpen = qrMaterialDataBeforeOpen
    BeforePost = qrDevicesDetailBeforePost
    MasterSource = dsDevices
    MasterFields = 'DEVICE_ID'
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FetchOptions.AssignedValues = [evCache, evAutoFetchAll]
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
      end>
    FormatOptions.DefaultParamDataType = ftBCD
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.CheckUpdatable = False
    SQL.Strings = (
      'SELECT '
      '  m.DEVICE_CODE AS CODE, '
      '  IFNULL(m.DEVICE_COUNT, 0) AS CNT, /* '#1050#1086#1083'-'#1074#1086' */'
      
        '  IF(:NDS=1, IF(m.FCOAST_NDS<>0, m.FCOAST_NDS, 0), IF(m.FCOAST_N' +
        'O_NDS<>0, m.FCOAST_NO_NDS, 0)) AS COAST, /* '#1062#1077#1085#1072' */'
      
        '  IF(:NDS=1, IF(DEVICE_TRANSP_NDS<>0, DEVICE_TRANSP_NDS, 0), IF(' +
        'DEVICE_TRANSP_NO_NDS<>0, DEVICE_TRANSP_NO_NDS, 0)) AS TRANSP,  /' +
        '* '#1090#1088#1072#1085#1089#1087'. */'
      '  IFNULL(m.DEVICE_COUNT, 0) AS CNT_DONE, /* '#1056#1072#1089#1093#1086#1076' */'
      '  0 as DELETED,'
      '  d.ID AS data_estimate_id,'
      '  m.PROC_ZAC,'
      '  m.PROC_PODR,'
      '  m.TRANSP_PROC_ZAC,'
      '  m.TRANSP_PROC_PODR,'
      '  m.DEVICE_ID,'
      '  m.ID'
      'FROM        '
      'data_row_temp AS d '
      
        'join devicescard_temp AS m on d.ID_TYPE_DATA = 4 AND m.ID = d.ID' +
        '_TABLES AND m.DEVICE_ID = :DEVICE_ID'
      '')
    Left = 155
    Top = 264
    ParamData = <
      item
        Name = 'NDS'
        DataType = ftInteger
        ParamType = ptInput
        Value = 0
      end
      item
        Name = 'DEVICE_ID'
        DataType = ftBCD
        ParamType = ptInput
      end>
  end
  object dsDevicesDetail: TDataSource
    DataSet = qrDevicesDetail
    Left = 155
    Top = 312
  end
end
