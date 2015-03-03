object fCoefficients: TfCoefficients
  Left = 0
  Top = 0
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1085#1072#1073#1086#1088#1086#1074' '#1082#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090#1086#1074
  ClientHeight = 393
  ClientWidth = 547
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    547
    393)
  PixelsPerInch = 96
  TextHeight = 13
  object grCoef: TJvDBGrid
    Left = 8
    Top = 8
    Width = 531
    Height = 336
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = dsCoef
    DrawingStyle = gdsClassic
    Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    PopupMenu = pm1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = btnAddClick
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
        FieldName = 'coef_name'
        Title.Alignment = taCenter
        Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
        Width = 245
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'osn_zp'
        Title.Alignment = taCenter
        Title.Caption = #1047#1055
        Width = 55
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'eksp_mach'
        Title.Alignment = taCenter
        Title.Caption = #1069#1052#1080#1052
        Width = 55
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'mat_res'
        Title.Alignment = taCenter
        Title.Caption = #1052#1056
        Width = 55
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'work_pers'
        Title.Alignment = taCenter
        Title.Caption = #1058#1047' '#1088#1072#1073'.'
        Width = 55
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'work_mach'
        Title.Alignment = taCenter
        Title.Caption = #1058#1047' '#1084#1072#1096'.'
        Width = 56
        Visible = True
      end>
  end
  object pnl1: TPanel
    Left = 8
    Top = 350
    Width = 531
    Height = 35
    Anchors = [akLeft, akRight, akBottom]
    TabOrder = 1
    DesignSize = (
      531
      35)
    object btnClose: TButton
      Left = 451
      Top = 4
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #1047#1072#1082#1088#1099#1090#1100
      TabOrder = 0
      OnClick = btnCloseClick
    end
    object dbnvgr1: TDBNavigator
      Left = 5
      Top = 4
      Width = 216
      Height = 25
      DataSource = dsCoef
      VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbInsert, nbDelete, nbEdit, nbPost, nbCancel]
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
      TabOrder = 1
      TabStop = True
    end
    object btnAdd: TButton
      Left = 368
      Top = 4
      Width = 77
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #1042' '#1088#1072#1089#1094#1077#1085#1082#1091
      Default = True
      TabOrder = 2
      OnClick = btnAddClick
    end
  end
  object qrCoef: TFDQuery
    BeforeEdit = qrCoefNewRecord
    AfterPost = qrCoefAfterPost
    AfterCancel = qrCoefAfterPost
    OnNewRecord = qrCoefNewRecord
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FormatOptions.AssignedValues = [fvFmtDisplayNumeric]
    FormatOptions.FmtDisplayNumeric = '#0.00'
    SQL.Strings = (
      
        'SELECT coef_id, coef_name, osn_zp, eksp_mach, mat_res, work_pers' +
        ' , work_mach '
      'FROM coef '
      'ORDER BY coef_name')
    Left = 25
    Top = 66
  end
  object dsCoef: TDataSource
    DataSet = qrCoef
    Left = 72
    Top = 66
  end
  object pm1: TPopupMenu
    Left = 112
    Top = 64
    object N5: TMenuItem
      Caption = #1042' '#1088#1072#1089#1094#1077#1085#1082#1091
      OnClick = btnAddClick
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object N1: TMenuItem
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      OnClick = N2Click
    end
    object N3: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100
      OnClick = N3Click
    end
  end
end
