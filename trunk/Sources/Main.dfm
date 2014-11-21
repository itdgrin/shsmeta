object FormMain: TFormMain
  Left = 0
  Top = 0
  Caption = #1056#1072#1089#1095#1105#1090' '#1089#1084#1077#1090#1099
  ClientHeight = 461
  ClientWidth = 593
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = MainMenu
  OldCreateOrder = False
  Position = poDesigned
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PanelOpenWindows: TPanel
    Left = 0
    Top = 434
    Width = 593
    Height = 27
    Hint = #1055#1072#1085#1077#1083#1100' '#1086#1090#1082#1088#1099#1090#1099#1093' '#1086#1082#1086#1085
    Align = alBottom
    DoubleBuffered = True
    ParentBackground = False
    ParentDoubleBuffered = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
  end
  object PanelCover: TPanel
    Left = 0
    Top = 0
    Width = 593
    Height = 434
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    Visible = False
  end
  object MainMenu: TMainMenu
    Left = 32
    Top = 8
    object MenuFile: TMenuItem
      Caption = #1060#1072#1081#1083
      object FileSaveAs: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1082#1072#1082'...'
        OnClick = FileSaveAsClick
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object FileClose: TMenuItem
        Caption = #1042#1099#1093#1086#1076
        OnClick = FileCloseClick
      end
    end
    object MenuHRR: TMenuItem
      Caption = #1053#1056#1056'-2012'
      object HRRReferenceData: TMenuItem
        Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1099#1077' '#1076#1072#1085#1085#1099#1077
        OnClick = HRRReferenceDataClick
      end
      object HRROwnData: TMenuItem
        Caption = #1057#1086#1073#1089#1090#1074#1077#1085#1085#1099#1077' '#1076#1072#1085#1085#1099#1077
        OnClick = HRROwnDataClick
      end
      object HRRPrices: TMenuItem
        Caption = #1058#1072#1088#1080#1092#1099' / '#1062#1077#1085#1099' / '#1048#1085#1076#1077#1082#1089#1099
        object HRRPricesReferenceData: TMenuItem
          Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1099#1077
          OnClick = HRRPricesReferenceDataClick
        end
        object HRRPricesOwnData: TMenuItem
          Caption = #1057#1086#1073#1089#1090#1074#1077#1085#1085#1099#1077
          OnClick = HRRPricesOwnDataClick
        end
      end
    end
    object MenuCatalogs: TMenuItem
      Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      object MenuSetCoefficients: TMenuItem
        Caption = #1053#1072#1073#1086#1088' '#1082#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090#1086#1074
        OnClick = MenuSetCoefficientsClick
      end
      object MenuLists: TMenuItem
        Caption = #1057#1087#1080#1089#1082#1080
        object MenuListsTypesActs: TMenuItem
          Caption = #1058#1080#1087#1099' '#1072#1082#1090#1086#1074
          OnClick = MenuListsTypesActsClick
        end
        object MenuListsIndexesChangeCost: TMenuItem
          Caption = #1048#1085#1076#1077#1082#1089#1099' '#1080#1079#1084#1077#1085#1077#1085#1080#1103' '#1089#1090#1086#1080#1084#1086#1089#1090#1080
          OnClick = MenuListsIndexesChangeCostClick
        end
        object MenuListsСategoriesObjects: TMenuItem
          Caption = #1050#1072#1090#1077#1075#1086#1088#1080#1080' '#1086#1073#1098#1077#1082#1090#1086#1074
          OnClick = MenuListsСategoriesObjectsClick
        end
        object MenuListsSeparator: TMenuItem
          Caption = '-'
        end
        object MenuListsPartsEstimates: TMenuItem
          Caption = #1063#1072#1089#1090#1080' '#1089#1084#1077#1090
          OnClick = MenuPartsEstimatesClick
        end
        object MenuListsSectionsEstimates: TMenuItem
          Caption = #1056#1072#1079#1076#1077#1083#1099' '#1089#1084#1077#1090
          OnClick = MenuListsSectionsEstimatesClick
        end
        object MenuListsTypesWorks: TMenuItem
          Caption = #1042#1080#1076#1099' '#1088#1072#1073#1086#1090
          OnClick = MenuListsTypesWorksClick
        end
      end
      object MenuOrganizations: TMenuItem
        Caption = #1054#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080
        OnClick = MenuOrganizationsClick
      end
    end
    object MenuService: TMenuItem
      Caption = #1057#1077#1088#1074#1080#1089
      object MenuConnectDatabase: TMenuItem
        Caption = #1055#1086#1076#1082#1083#1102#1095#1077#1085#1080#1077' '#1082' MySQL '#1089#1077#1088#1074#1077#1088#1091
        Enabled = False
        OnClick = MenuConnectDatabaseClick
      end
      object ServiceSettings: TMenuItem
        Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
        OnClick = ServiceSettingsClick
      end
      object ServiceOptions: TMenuItem
        Caption = #1054#1087#1094#1080#1080
      end
      object ServiceBackup: TMenuItem
        Caption = #1056#1077#1079#1077#1088#1074#1085#1086#1077' '#1082#1086#1087#1080#1088#1086#1074#1072#1085#1080#1077
      end
      object ServiceRecovery: TMenuItem
        Caption = #1042#1086#1089#1089#1090#1072#1085#1086#1074#1083#1077#1085#1080#1077' ('#1072#1076#1084')'
      end
      object ServiceUpdate: TMenuItem
        Caption = #1054#1073#1085#1086#1074#1083#1077#1085#1080#1077' '#1055#1054
      end
      object ServiceAssistant: TMenuItem
        Caption = #1055#1088#1086#1075#1088#1072#1084#1084#1099'-'#1087#1086#1084#1086#1097#1085#1080#1082#1080
        Hint = #1047#1072#1087#1091#1089#1090#1080#1090#1100' '#1087#1088#1086#1075#1088#1072#1084#1084#1091' '#1091#1076#1072#1083#1105#1085#1085#1086#1075#1086' '#1091#1087#1088#1072#1074#1083#1077#1085#1080#1103
        object MMAeroAdmin: TMenuItem
          Tag = 1
          Caption = 'AeroAdmin'
          OnClick = RunProgramsRemoteControl
        end
        object MMAmmyyAdmin: TMenuItem
          Tag = 2
          Caption = 'Ammyy Admin'
          OnClick = RunProgramsRemoteControl
        end
      end
    end
    object MenuWindows: TMenuItem
      Caption = #1054#1082#1085#1072
      object WindowsHorizontal: TMenuItem
        Caption = #1055#1086' '#1075#1086#1088#1080#1079#1086#1085#1090#1072#1083#1080
        OnClick = WindowsHorizontalClick
      end
      object WindowsVertical: TMenuItem
        Caption = #1055#1086' '#1074#1077#1088#1090#1080#1082#1072#1083#1080
        OnClick = WindowsVerticalClick
      end
      object WindowsCascade: TMenuItem
        Caption = #1050#1072#1089#1082#1072#1076#1086#1084
        OnClick = WindowsCascadeClick
      end
      object N4: TMenuItem
        Caption = #1054#1076#1085#1086' '#1086#1082#1085#1086
        Enabled = False
      end
      object N5: TMenuItem
        Caption = #1057#1077#1090#1082#1072
        Enabled = False
      end
      object WindowsSeparator: TMenuItem
        Caption = '-'
      end
      object WindowsMinimize: TMenuItem
        Caption = #1057#1074#1077#1088#1085#1091#1090#1100' '#1074#1089#1077
        OnClick = WindowsMinimizeClick
      end
      object WindowsExpand: TMenuItem
        Caption = #1056#1072#1079#1074#1077#1088#1085#1091#1090#1100' '#1074#1089#1077
        OnClick = WindowsExpandClick
      end
      object WindowsClose: TMenuItem
        Caption = #1047#1072#1082#1088#1099#1090#1100' '#1074#1089#1077
        OnClick = WindowsCloseClick
      end
    end
    object MenuHelp: TMenuItem
      Caption = #1057#1087#1088#1072#1074#1082#1072
      object HelpSupport: TMenuItem
        Caption = #1055#1086#1084#1086#1097#1100
      end
      object HelpRegistration: TMenuItem
        Caption = #1056#1077#1075#1080#1089#1090#1088#1072#1094#1080#1103
      end
      object HelpSite: TMenuItem
        Caption = #1057#1072#1081#1090
      end
      object HelpAbout: TMenuItem
        Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
        OnClick = HelpAboutClick
      end
    end
    object N17: TMenuItem
      Caption = #1042#1056#1045#1052#1045#1053#1053#1054#1045
      Visible = False
      object N1: TMenuItem
        Caption = #1043#1088#1072#1092#1080#1082' '#1087#1088#1086#1080#1079#1074#1086#1076#1089#1090#1074#1072' '#1088#1072#1073#1086#1090
        OnClick = N1Click
      end
      object ActC6: TMenuItem
        Caption = #1040#1082#1090' '#1057'-6'
        OnClick = ActC6Click
      end
      object N13: TMenuItem
        Caption = #1050#1072#1088#1090#1086#1095#1082#1072' '#1055#1058#1052
        OnClick = N13Click
      end
      object CalculationSettings: TMenuItem
        Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1088#1072#1089#1095#1105#1090#1086#1074
        OnClick = CalculationSettingsClick
      end
      object HRRTariffs: TMenuItem
        Caption = #1058#1072#1088#1080#1092#1099' / '#1062#1077#1085#1099' / '#1048#1085#1076#1077#1082#1089#1099
        object TariffsSalary: TMenuItem
          Caption = #1058#1072#1088#1080#1092#1099' '#1087#1086' '#1079#1072#1088#1087#1083#1072#1090#1077
          Enabled = False
          OnClick = TariffsSalaryClick
        end
        object TariffsMechanism: TMenuItem
          Caption = #1062#1077#1085#1099' '#1085#1072' '#1084#1077#1093#1072#1085#1080#1079#1084#1099
          OnClick = TariffsMechanismClick
        end
        object TariffsTransportation: TMenuItem
          Caption = #1058#1072#1088#1080#1094#1099' '#1087#1086' '#1075#1088#1091#1079#1086#1087#1077#1088#1077#1074#1086#1079#1082#1072#1084
          OnClick = TariffsTransportationClick
        end
        object TariffsDump: TMenuItem
          Caption = #1058#1072#1088#1080#1092#1099' '#1087#1086' '#1089#1074#1072#1083#1082#1072#1084
          OnClick = TariffsDumpClick
        end
        object TariffsIndex: TMenuItem
          Caption = #1057#1090#1072#1090#1080#1095#1077#1089#1082#1080#1077' '#1080#1085#1076#1077#1082#1089#1099
          OnClick = TariffsIndexClick
        end
        object N16: TMenuItem
          Caption = #1047#1072#1075#1088#1091#1079#1082#1072
          OnClick = N16Click
        end
      end
      object N14: TMenuItem
        Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080' '#1076#1083#1103' '#1057#1057#1056
        OnClick = N14Click
      end
      object OXRandOPRg: TMenuItem
        Caption = #1058#1080#1087' '#1054#1061#1056' '#1080' '#1054#1055#1056
        OnClick = OXRandOPRgClick
      end
      object N9: TMenuItem
        Caption = #1057#1087#1088#1072#1074#1082#1072
        object N31: TMenuItem
          Caption = #1057'-3'
          OnClick = N31Click
        end
        object N51: TMenuItem
          Caption = #1057'-5'
          Enabled = False
          Visible = False
          OnClick = N51Click
        end
        object N62: TMenuItem
          Caption = #1057'-6'
          Enabled = False
          Visible = False
        end
      end
    end
    object N61: TMenuItem
      Caption = #1046#1091#1088#1085#1072#1083' '#1050#1057'-6'
      OnClick = N61Click
    end
    object N2: TMenuItem
      Caption = #1056#1072#1089#1095#1077#1090' '#1089#1090#1086#1080#1084#1086#1089#1090#1080' '#1088#1077#1089#1091#1088#1089#1086#1074
      OnClick = N2Click
    end
  end
  object TimerCover: TTimer
    Enabled = False
    Interval = 100
    OnTimer = TimerCoverTimer
    Left = 32
    Top = 56
  end
end
