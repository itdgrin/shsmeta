object FormEstRowFinder: TFormEstRowFinder
  Left = 0
  Top = 0
  Caption = #1055#1086#1080#1089#1082' '#1087#1086' '#1089#1084#1077#1090#1077
  ClientHeight = 414
  ClientWidth = 610
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 610
    Height = 71
    Align = alTop
    TabOrder = 0
    object gbFilter: TGroupBox
      Left = 202
      Top = 1
      Width = 407
      Height = 69
      Align = alClient
      Caption = ' '#1056#1072#1089#1094#1077#1085#1082#1072': '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      DesignSize = (
        407
        69)
      object lbCodeTitle: TLabel
        Left = 60
        Top = 21
        Width = 24
        Height = 13
        Caption = #1050#1086#1076':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lbName: TLabel
        Left = 7
        Top = 45
        Width = 77
        Height = 13
        Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object edtCode: TEdit
        Left = 88
        Top = 18
        Width = 137
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnChange = edtChange
      end
      object edtName: TEdit
        Left = 88
        Top = 42
        Width = 312
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnChange = edtChange
      end
    end
    object rgTypeDate: TRadioGroup
      Left = 1
      Top = 1
      Width = 201
      Height = 69
      Align = alLeft
      Caption = ' '#1058#1080#1087' '#1076#1072#1085#1085#1099#1093' '
      Columns = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        #1056#1072#1089#1094#1077#1085#1082#1072
        #1052#1072#1090#1077#1088#1080#1072#1083
        #1052#1077#1093#1072#1085#1080#1079#1084
        #1054#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1077)
      ParentFont = False
      TabOrder = 0
      OnClick = rgTypeDateClick
    end
  end
  object gbEntry: TGroupBox
    Left = 0
    Top = 71
    Width = 610
    Height = 310
    Align = alClient
    Caption = ' '#1042#1093#1086#1078#1076#1077#1085#1080#1103
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object lvEntry: TListView
      Left = 2
      Top = 15
      Width = 606
      Height = 241
      Align = alClient
      Columns = <
        item
          Caption = #1050#1086#1076
          Width = 80
        end
        item
          Caption = #1057#1084#1077#1090#1072
          Width = 100
        end
        item
          Caption = #1056#1072#1089#1094#1077#1085#1082#1072
          Width = 80
        end
        item
          Caption = #1053#1086#1088#1084#1072
          Width = 70
        end
        item
          Caption = #1050#1086#1083'-'#1074#1086
          Width = 70
        end
        item
          Caption = #1062#1077#1085#1072
          Width = 80
        end
        item
          Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100
          Width = 100
        end>
      ColumnClick = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      GridLines = True
      ReadOnly = True
      RowSelect = True
      ParentFont = False
      TabOrder = 0
      ViewStyle = vsReport
      OnSelectItem = lvEntrySelectItem
    end
    object pnlSelection: TPanel
      Left = 2
      Top = 256
      Width = 606
      Height = 52
      Align = alBottom
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      object Label1: TLabel
        Left = 10
        Top = 8
        Width = 24
        Height = 13
        Caption = #1050#1086#1076':'
      end
      object Label3: TLabel
        Left = 134
        Top = 9
        Width = 77
        Height = 13
        Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object edtSelCode: TEdit
        Left = 37
        Top = 6
        Width = 90
        Height = 21
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
      end
      object memSelName: TMemo
        Left = 213
        Top = 6
        Width = 390
        Height = 43
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
      end
    end
  end
  object Panel4: TPanel
    Left = 0
    Top = 381
    Width = 610
    Height = 33
    Align = alBottom
    TabOrder = 2
    DesignSize = (
      610
      33)
    object btnGoToRow: TButton
      AlignWithMargins = True
      Left = 368
      Top = 4
      Width = 140
      Height = 25
      Action = actGoToRow
      Anchors = [akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object btnCancel: TButton
      AlignWithMargins = True
      Left = 512
      Top = 4
      Width = 93
      Height = 25
      Action = actCancel
      Anchors = [akTop, akRight]
      TabOrder = 0
    end
  end
  object TimerFilter: TTimer
    Interval = 200
    OnTimer = TimerFilterTimer
    Left = 434
    Top = 17
  end
  object ActionList: TActionList
    Left = 488
    Top = 15
    object actGoToRow: TAction
      Caption = #1055#1077#1088#1077#1081#1090#1080' '#1085#1072' '#1089#1090#1088#1086#1082#1091
      OnExecute = actGoToRowExecute
      OnUpdate = actGoToRowUpdate
    end
    object actCancel: TAction
      Caption = #1054#1090#1084#1077#1085#1072
      OnExecute = actCancelExecute
    end
  end
end
