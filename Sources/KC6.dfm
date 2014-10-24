object FormKC6: TFormKC6
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = #1046#1091#1088#1085#1072#1083' 6-'#1050#1057
  ClientHeight = 428
  ClientWidth = 651
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ImageSplitterTop: TImage
    Left = 320
    Top = 114
    Width = 15
    Height = 5
    Cursor = crVSplit
  end
  object splTop: TSplitter
    Left = 0
    Top = 125
    Width = 651
    Height = 5
    Cursor = crVSplit
    Align = alTop
    ResizeStyle = rsUpdate
    ExplicitTop = 33
    ExplicitWidth = 659
  end
  object PanelBottomButton: TPanel
    Left = 0
    Top = 387
    Width = 651
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'Panel3'
    ShowCaption = False
    TabOrder = 0
    DesignSize = (
      651
      41)
    object Button1: TButton
      Left = 437
      Top = 8
      Width = 100
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #1055#1077#1088#1077#1085#1077#1089#1090#1080
      Default = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = Button1Click
    end
    object ButtonCancel: TButton
      Left = 543
      Top = 8
      Width = 100
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #1054#1090#1084#1077#1085#1072
      TabOrder = 1
      OnClick = ButtonCancelClick
    end
  end
  object PanelObject: TPanel
    Left = 0
    Top = 0
    Width = 651
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    ShowCaption = False
    TabOrder = 1
    TabStop = True
    DesignSize = (
      651
      25)
    object LabelObject: TLabel
      Left = 8
      Top = 6
      Width = 43
      Height = 13
      Caption = #1054#1073#1098#1077#1082#1090':'
    end
    object EditObject: TEdit
      Left = 57
      Top = 2
      Width = 591
      Height = 21
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      Color = 14802912
      ReadOnly = True
      TabOrder = 0
    end
  end
  object PanelTree: TPanel
    Left = 0
    Top = 25
    Width = 651
    Height = 100
    Align = alTop
    BevelOuter = bvNone
    Caption = 'PanelTree'
    ShowCaption = False
    TabOrder = 2
    object TreeView: TTreeView
      Left = 0
      Top = 0
      Width = 651
      Height = 100
      Align = alClient
      Indent = 19
      ReadOnly = True
      TabOrder = 0
      OnAdvancedCustomDrawItem = TreeViewAdvancedCustomDrawItem
      OnChange = TreeViewChange
    end
  end
  object PanelClient: TPanel
    Left = 0
    Top = 130
    Width = 651
    Height = 257
    Align = alClient
    BevelOuter = bvNone
    Caption = 'PanelClient'
    ShowCaption = False
    TabOrder = 3
    OnResize = PanelClientResize
    object ImageSplitterBottom: TImage
      Left = 312
      Top = 106
      Width = 15
      Height = 5
      Cursor = crVSplit
    end
    object splBottom: TSplitter
      Left = 0
      Top = 128
      Width = 651
      Height = 5
      Cursor = crVSplit
      Align = alBottom
      ResizeStyle = rsUpdate
      ExplicitTop = 97
      ExplicitWidth = 661
    end
    object PanelKoef: TPanel
      Left = 0
      Top = 0
      Width = 651
      Height = 25
      Align = alTop
      BevelOuter = bvNone
      Caption = 'PanelKoef'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ShowCaption = False
      TabOrder = 0
      DesignSize = (
        651
        25)
      object LabelKoef: TLabel
        Left = 445
        Top = 6
        Width = 115
        Height = 13
        Anchors = [akTop, akRight]
        Caption = #1055#1088#1086#1094#1077#1085#1090' '#1087#1077#1088#1077#1088#1072#1089#1095#1105#1090#1072':'
        ExplicitLeft = 455
      end
      object Label1: TLabel
        Left = 636
        Top = 4
        Width = 8
        Height = 16
        Cursor = crHandPoint
        Anchors = [akTop, akRight]
        Caption = 'C'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clHotLight
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        OnClick = Label1Click
        ExplicitLeft = 646
      end
      object EditKoef: TSpinEdit
        Left = 566
        Top = 1
        Width = 64
        Height = 22
        Anchors = [akTop, akRight]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        MaxValue = 100
        MinValue = 0
        ParentFont = False
        TabOrder = 0
        Value = 0
        OnChange = EditKoefChange
      end
    end
    object StringGridDataEstimates: TStringGrid
      Left = 0
      Top = 25
      Width = 651
      Height = 103
      Align = alClient
      DefaultRowHeight = 20
      DefaultDrawing = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = StringGridDataEstimatesClick
      OnDrawCell = StringGridDataEstimatesDrawCell
      OnEnter = StringGridDataEstimatesEnter
      OnExit = StringGridDataEstimatesEnter
      OnKeyDown = StringGridDataEstimatesKeyDown
      OnKeyPress = StringGridDataEstimatesKeyPress
      OnMouseDown = StringGridDataEstimatesMouseDown
      OnMouseWheelDown = StringGridDataEstimatesMouseWheelDown
      OnMouseWheelUp = StringGridDataEstimatesMouseWheelUp
    end
    object PanelBottom: TPanel
      Left = 0
      Top = 133
      Width = 651
      Height = 124
      Align = alBottom
      BevelOuter = bvNone
      Caption = 'PanelBottom'
      ShowCaption = False
      TabOrder = 2
      object dbgrd1: TDBGrid
        Left = 0
        Top = 0
        Width = 651
        Height = 124
        Align = alClient
        DataSource = dsOtherActs
        DrawingStyle = gdsClassic
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        ParentFont = False
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'date'
            Title.Alignment = taCenter
            Title.Caption = #1052#1077#1089#1103#1094
            Width = 70
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Number'
            Title.Alignment = taCenter
            Title.Caption = #8470' '#1087#1087
            Width = 121
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'osnov'
            Title.Alignment = taCenter
            Title.Caption = #1054#1073#1086#1089#1085#1086#1074#1072#1085#1080#1077
            Width = 122
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'cnt'
            Title.Alignment = taCenter
            Title.Caption = #1050#1086#1083'-'#1074#1086
            Width = 85
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'docname'
            Title.Alignment = taCenter
            Title.Caption = #1044#1086#1082#1091#1084#1077#1085#1090
            Width = 119
            Visible = True
          end>
      end
    end
  end
  object ADOQueryTemp: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    Left = 33
    Top = 32
  end
  object ADOQObjectEstimates: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    Left = 129
    Top = 32
  end
  object ADOQLocalEstimates: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    Left = 241
    Top = 32
  end
  object ADOQPTMEstimates: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    SQL.Strings = (
      'SELECT * FROM istfin;')
    Left = 361
    Top = 32
  end
  object ADOQueryDataEstimate: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    Left = 89
    Top = 168
  end
  object ADOQueryCardRates: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    Left = 89
    Top = 224
  end
  object ADOQueryMaterialCard: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    Left = 225
    Top = 168
  end
  object ADOQueryMechanizmCard: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    Left = 225
    Top = 224
  end
  object qrOtherActs: TFDQuery
    OnCalcFields = qrOtherActsCalcFields
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FormatOptions.AssignedValues = [fvMapRules, fvFmtDisplayDateTime, fvFmtDisplayDate, fvStrsTrim2Len]
    FormatOptions.OwnMapRules = True
    FormatOptions.MapRules = <
      item
        SourceDataType = dtMemo
        TargetDataType = dtAnsiString
      end>
    FormatOptions.StrsTrim2Len = True
    FormatOptions.FmtDisplayDateTime = 'mmyyyy'
    FormatOptions.FmtDisplayDate = 'mmyyyy'
    SQL.Strings = (
      'select Trim(`card_acts`.name) as docname,'
      '       `card_acts`.`DATE`,'
      '       `card_rate_act`.`RATE_CODE` as osnov,'
      '       `card_rate_act`.`RATE_COUNT` as cnt'
      'from `card_acts`,'
      '     `card_rate_act`'
      'where `card_acts`.`ID_ESTIMATE_OBJECT` = :idestimate and'
      '      `card_rate_act`.`ID_ACT` = `card_acts`.`ID` and '
      '     `card_rate_act`.`RATE_CODE` like :p_osnov '
      'UNION ALL'
      'select Trim(`card_acts`.name) as docname,'
      '       `card_acts`.`DATE`,'
      '       `materialcard_act`.`MAT_CODE` as osnov,'
      '       `materialcard_act`.`MAT_COUNT` as cnt'
      'from `card_acts`,'
      '     `materialcard_act`,'
      '     `card_rate_act`      '
      'where `card_acts`.`ID_ESTIMATE_OBJECT` = :idestimate and'
      '      `card_rate_act`.`ID_ACT` = `card_acts`.`ID` and'
      
        '      `materialcard_act`.`ID_CARD_RATE`=`card_rate_act`.`ID` and' +
        ' '
      '      `materialcard_act`.`MAT_CODE` like :p_osnov '
      'UNION ALL'
      'select Trim(`card_acts`.name) as docname,'
      '       `card_acts`.`DATE`,'
      '       `mechanizmcard_act`.`MECH_CODE` as osnov,'
      '       `mechanizmcard_act`.`MECH_COUNT` as cnt'
      'from `card_acts`,'
      '     `mechanizmcard_act`,'
      '     `card_rate_act`      '
      'where `card_acts`.`ID_ESTIMATE_OBJECT` = :idestimate and'
      '      `card_rate_act`.`ID_ACT` = `card_acts`.`ID` and'
      
        '      `mechanizmcard_act`.`ID_CARD_RATE`=`card_rate_act`.`ID` an' +
        'd '
      '      `mechanizmcard_act`.`MECH_CODE` like  :p_osnov;')
    Left = 249
    Top = 312
    ParamData = <
      item
        Name = 'IDESTIMATE'
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'P_OSNOV'
        ParamType = ptInput
      end>
    object qrOtherActsNumber: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'Number'
      Calculated = True
    end
    object qrOtherActsdocname: TStringField
      FieldName = 'docname'
    end
    object qrOtherActsdate: TDateField
      FieldName = 'date'
    end
    object qrOtherActsosnov: TStringField
      FieldName = 'osnov'
    end
    object qrOtherActscnt: TFMTBCDField
      FieldName = 'cnt'
    end
  end
  object dsOtherActs: TDataSource
    DataSet = qrOtherActs
    Left = 312
    Top = 311
  end
end
