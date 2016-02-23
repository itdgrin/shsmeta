object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = #1054#1073#1085#1086#1074#1083#1077#1085#1080#1077' '#1089#1087#1088#1072#1074#1086#1095#1085#1080#1082#1086#1074' '#1041#1044
  ClientHeight = 463
  ClientWidth = 753
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pcMain: TPageControl
    Left = 0
    Top = 0
    Width = 753
    Height = 463
    ActivePage = tsMaterial
    Align = alClient
    TabOrder = 0
    object tsMaterial: TTabSheet
      Caption = #1052#1072#1090#1077#1088#1080#1072#1083#1099' '#1080' '#1046#1041#1048
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      object pnlUpdMat: TPanel
        Left = 0
        Top = 0
        Width = 745
        Height = 50
        Align = alTop
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
        DesignSize = (
          741
          46)
        object lbUpdMatTitle: TLabel
          Left = 8
          Top = 1
          Width = 171
          Height = 13
          Caption = #1047#1072#1075#1088#1091#1079#1082#1072' '#1085#1086#1074#1099#1093' '#1084#1072#1090#1077#1088#1080#1072#1083#1086#1074':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object btnUpdMat: TButton
          Left = 631
          Top = 16
          Width = 93
          Height = 25
          Action = actUpdMat
          Anchors = [akTop, akRight]
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object edtUpdMat: TButtonedEdit
          Left = 6
          Top = 20
          Width = 441
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          Images = ImageList
          RightButton.ImageIndex = 0
          RightButton.Visible = True
          TabOrder = 1
          OnRightButtonClick = edtRightButtonClick
        end
        object cbMonthMat: TComboBox
          Left = 451
          Top = 20
          Width = 100
          Height = 21
          Style = csDropDownList
          Anchors = [akTop, akRight]
          TabOrder = 2
        end
        object edtYearMat: TSpinEdit
          Left = 555
          Top = 19
          Width = 73
          Height = 22
          Anchors = [akTop, akRight]
          MaxValue = 3000
          MinValue = 2000
          TabOrder = 3
          Value = 2000
        end
      end
      object pnlUpdMatPrice: TPanel
        Left = 0
        Top = 100
        Width = 745
        Height = 50
        Align = alTop
        BevelKind = bkTile
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 1
        DesignSize = (
          741
          46)
        object lbUpdMatPriceTitle: TLabel
          Left = 8
          Top = 1
          Width = 155
          Height = 13
          Caption = #1047#1072#1075#1088#1091#1079#1082#1072' '#1094#1077#1085' '#1084#1072#1090#1077#1088#1080#1072#1083#1086#1074':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtUpdMatPrice: TButtonedEdit
          Left = 8
          Top = 20
          Width = 439
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          Images = ImageList
          RightButton.ImageIndex = 0
          RightButton.Visible = True
          TabOrder = 0
          OnRightButtonClick = edtRightButtonClick
        end
        object btnUpdMatPrice: TButton
          Left = 631
          Top = 17
          Width = 93
          Height = 25
          Action = actUpdMatPrice
          Anchors = [akTop, akRight]
          TabOrder = 1
        end
        object cbMonthMatPrice: TComboBox
          Left = 451
          Top = 20
          Width = 100
          Height = 21
          Style = csDropDownList
          Anchors = [akTop, akRight]
          TabOrder = 2
        end
        object edtYearMatPrice: TSpinEdit
          Left = 555
          Top = 19
          Width = 73
          Height = 22
          Anchors = [akTop, akRight]
          MaxValue = 3000
          MinValue = 2000
          TabOrder = 3
          Value = 2000
        end
      end
      object pnlUpdMatNoTrans: TPanel
        Left = 0
        Top = 150
        Width = 745
        Height = 50
        Align = alTop
        BevelKind = bkTile
        BevelOuter = bvNone
        ParentBackground = False
        TabOrder = 2
        DesignSize = (
          741
          46)
        object lbUpdMatNoTransTitle: TLabel
          Left = 8
          Top = 1
          Width = 225
          Height = 13
          Caption = #1047#1072#1075#1088#1091#1079#1082#1072' '#1084#1072#1090#1077#1088#1080#1072#1083#1086#1074' '#1073#1077#1079' '#1090#1088#1072#1085#1089#1087#1086#1088#1090#1072':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtUpdMatNoTrans: TButtonedEdit
          Left = 6
          Top = 20
          Width = 622
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          Images = ImageList
          RightButton.ImageIndex = 0
          RightButton.Visible = True
          TabOrder = 0
          OnRightButtonClick = edtRightButtonClick
        end
        object btnUpdMatNoTrans: TButton
          Left = 631
          Top = 17
          Width = 93
          Height = 25
          Action = actUpdMatNoTrans
          Anchors = [akTop, akRight]
          TabOrder = 1
        end
      end
      object pnlUpdJBI: TPanel
        Left = 0
        Top = 200
        Width = 745
        Height = 50
        Align = alTop
        BevelKind = bkTile
        BevelOuter = bvNone
        ParentBackground = False
        TabOrder = 3
        DesignSize = (
          741
          46)
        object lbUpdJBITitle: TLabel
          Left = 6
          Top = 1
          Width = 128
          Height = 13
          Caption = #1047#1072#1075#1088#1091#1079#1082#1072' '#1094#1077#1085' '#1085#1072' '#1046#1041#1048':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtUpdJBI: TButtonedEdit
          Left = 6
          Top = 20
          Width = 441
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          Images = ImageList
          RightButton.ImageIndex = 0
          RightButton.Visible = True
          TabOrder = 0
          OnRightButtonClick = edtRightButtonClick
        end
        object btnUpdJBI: TButton
          Left = 631
          Top = 18
          Width = 93
          Height = 25
          Action = actUpdJBI
          Anchors = [akTop, akRight]
          TabOrder = 1
        end
        object cbMonthJBI: TComboBox
          Left = 451
          Top = 20
          Width = 100
          Height = 21
          Style = csDropDownList
          Anchors = [akTop, akRight]
          TabOrder = 2
        end
        object edtYearJBI: TSpinEdit
          Left = 555
          Top = 19
          Width = 73
          Height = 22
          Anchors = [akTop, akRight]
          MaxValue = 3000
          MinValue = 2000
          TabOrder = 3
          Value = 2000
        end
        object cboxUpdJBIName: TCheckBox
          Left = 451
          Top = 0
          Width = 202
          Height = 17
          Anchors = [akTop, akRight]
          Caption = #1054#1073#1085#1086#1074#1083#1103#1090#1100' '#1085#1072#1079#1074#1072#1085#1080#1103' '#1046#1041#1048
          TabOrder = 4
        end
      end
      object pnlUpdMatNoPrice: TPanel
        Left = 0
        Top = 50
        Width = 745
        Height = 50
        Align = alTop
        BevelKind = bkTile
        BevelOuter = bvNone
        ParentBackground = False
        TabOrder = 4
        DesignSize = (
          741
          46)
        object Label1: TLabel
          Left = 8
          Top = 1
          Width = 178
          Height = 13
          Caption = #1047#1072#1075#1088#1091#1079#1082#1072' '#1084#1072#1090#1077#1088#1080#1072#1083#1086#1074' '#1073#1077#1079' '#1094#1077#1085':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtUpdMatNoPrice: TButtonedEdit
          Left = 6
          Top = 20
          Width = 441
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          Images = ImageList
          RightButton.ImageIndex = 0
          RightButton.Visible = True
          TabOrder = 0
          OnRightButtonClick = edtRightButtonClick
        end
        object Button1: TButton
          Left = 631
          Top = 17
          Width = 93
          Height = 25
          Action = actUpdMatNoPrice
          Anchors = [akTop, akRight]
          TabOrder = 1
        end
        object cbMonthMatNoPrice: TComboBox
          Left = 451
          Top = 20
          Width = 100
          Height = 21
          Style = csDropDownList
          Anchors = [akTop, akRight]
          TabOrder = 2
        end
        object edtYearMatNoPrice: TSpinEdit
          Left = 555
          Top = 19
          Width = 73
          Height = 22
          Anchors = [akTop, akRight]
          MaxValue = 3000
          MinValue = 2000
          TabOrder = 3
          Value = 2000
        end
        object cboxUpdMatName: TCheckBox
          Left = 451
          Top = 0
          Width = 202
          Height = 17
          Anchors = [akTop, akRight]
          Caption = #1054#1073#1085#1086#1074#1083#1103#1090#1100' '#1085#1072#1079#1074#1072#1085#1080#1103' '#1084#1072#1090#1077#1088#1080#1072#1083#1086#1074
          TabOrder = 4
        end
      end
    end
    object tsMechanism: TTabSheet
      Caption = #1069#1082#1089#1087#1083#1091#1072#1090#1072#1094#1080#1103' '#1084#1072#1096#1080#1085
      ImageIndex = 1
    end
    object tsTransp: TTabSheet
      Caption = #1054#1090#1093#1086#1076#1099' '#1080' '#1090#1088#1072#1085#1089#1087#1086#1088#1090
      ImageIndex = 2
    end
  end
  object MainMenu: TMainMenu
    Left = 464
    Top = 312
    object pmFile: TMenuItem
      Caption = #1060#1072#1081#1083
      object pmExit: TMenuItem
        Action = actClose
      end
    end
  end
  object ActionList: TActionList
    Left = 528
    Top = 312
    object actClose: TAction
      Category = #1060#1072#1081#1083
      Caption = #1042#1099#1093#1086#1076
      OnExecute = actCloseExecute
    end
    object actUpdMat: TAction
      Caption = #1047#1072#1075#1088#1091#1079#1082#1072
      OnExecute = actUpdMatExecute
    end
    object actUpdJBI: TAction
      Caption = #1047#1072#1075#1088#1091#1079#1082#1072
      OnExecute = actUpdJBIExecute
    end
    object actUpdMatNoPrice: TAction
      Caption = #1047#1072#1075#1088#1091#1079#1082#1072
      OnExecute = actUpdMatNoPriceExecute
    end
    object actUpdMatPrice: TAction
      Caption = #1047#1072#1075#1088#1091#1079#1082#1072
      OnExecute = actUpdMatPriceExecute
    end
    object actUpdMatNoTrans: TAction
      Caption = #1047#1072#1075#1088#1091#1079#1082#1072
      OnExecute = actUpdMatNoTransExecute
    end
  end
  object ImageList: TImageList
    Left = 396
    Top = 312
    Bitmap = {
      494C0101010008002C0010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FCFC
      FC00F9F9F900F6F6F600F2F2F200F0F0F000EEEEEE00EEEEEE00F0F0F000F2F2
      F200F6F6F600F9F9F900FCFCFC00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F9F9F900F0F0
      F000E4E4E400D7D7D700CACACA00BFBFBF00B6B6B600B6B6B600BFBFBF00A5B3
      BD009EADB800E5E5E500F0F0F000F9F9F9000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F9F9F900F0F0
      F000E4E4E400D7D7D700CACACA00BFBFBF00B6B6B600B6B6B60094A8B7003F88
      BD00497B9C0094A6B300F0F0F000F9F9F9000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FCFC
      FC00F9F9F900F6F6F600F2F2F200F0F0F000EEEEEE00BED0DD00418BBF009CD1
      F5004B95CD00B3C9D800FCFCFC00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000D2E2ED00478EC2009CD1F5005099
      D2009EC1DB000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000005C95BF0091C9EE00539CD40096BC
      D800000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FDFDFD00BDBE
      BE00A6A8A900B0B1B100A8AAAA00A6A7A800737A84004B89B8008FB7D5000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009FA1A100D2CC
      C100DCC29500DEC39200ECDABB00E7E1D9008E8F910000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D8D9D900B6B5B500CEAE
      7700CEAB7000D9BB8600E3CB9E00EAD8B600CAC7C300D3D4D400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B4B5B500DACFBF00D1B4
      8300CFAC7400D2B17700D9BB8600DDC39300EADECA00B1B3B300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B7B8B800DCD3C500DECB
      AA00D7BD9300D2B37F00CFAE7400D1B07700E5D9C300B5B6B600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E2E3E300BABBBA00E0CE
      B000E6D7BE00DBC5A000D2B58500D0B17D00C6C5C200DDDEDE00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000B5B6B600D5D3
      CE00E5D6BE00DECBAB00E0CDAE00DAD6CE00ADAFAF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C8C9
      C900AFB0B000ADAFAF00B0B1B100BDBEBE00FDFDFD0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFF000000000000E001000000000000
      C000000000000000C000000000000000E001000000000000FF07000000000000
      FF0F000000000000C01F000000000000C07F000000000000803F000000000000
      803F000000000000803F000000000000803F000000000000C07F000000000000
      E07F000000000000FFFF00000000000000000000000000000000000000000000
      000000000000}
  end
  object OpenDialog: TOpenDialog
    Filter = 'EXCEL|*.xls;*.xlsx'
    Left = 316
    Top = 312
  end
end
