inherited FrameRates: TFrameRates
  Width = 754
  Height = 463
  ParentFont = False
  OnResize = FrameResize
  ExplicitWidth = 754
  ExplicitHeight = 463
  object PanelRates: TPanel
    Left = 0
    Top = 0
    Width = 754
    Height = 444
    Align = alClient
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 0
    object SplitterLeft: TSplitter
      Left = 110
      Top = 0
      Width = 5
      Height = 444
      ResizeStyle = rsUpdate
      OnMoved = SplitterLeftMoved
      ExplicitLeft = 128
      ExplicitTop = 1
      ExplicitHeight = 430
    end
    object ImageSplitterLeft: TImage
      Left = 106
      Top = 20
      Width = 5
      Height = 15
      Cursor = crHSplit
      AutoSize = True
    end
    object ImageSplitterRight: TImage
      Left = 433
      Top = 105
      Width = 5
      Height = 15
      Cursor = crHSplit
      AutoSize = True
    end
    object SplitterRight: TSplitter
      Left = 699
      Top = 0
      Width = 5
      Height = 444
      Align = alRight
      ResizeStyle = rsUpdate
      OnMoved = SplitterRightMoved
      ExplicitLeft = 128
      ExplicitTop = 1
      ExplicitHeight = 458
    end
    object PanelLeft: TPanel
      Left = 0
      Top = 0
      Width = 110
      Height = 444
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 0
      object VST: TVirtualStringTree
        Left = 0
        Top = 21
        Width = 110
        Height = 423
        Align = alClient
        Header.AutoSizeIndex = 0
        Header.Font.Charset = DEFAULT_CHARSET
        Header.Font.Color = clWindowText
        Header.Font.Height = -11
        Header.Font.Name = 'Tahoma'
        Header.Font.Style = []
        Header.Options = []
        PopupMenu = pmRates
        RootNodeCount = 10
        ScrollBarOptions.AlwaysVisible = True
        ScrollBarOptions.ScrollBars = ssVertical
        TabOrder = 1
        TreeOptions.MiscOptions = [toAcceptOLEDrop, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning, toEditOnClick]
        TreeOptions.PaintOptions = [toHideFocusRect, toShowButtons, toShowDropmark, toShowHorzGridLines, toShowVertGridLines, toThemeAware, toUseBlendedImages]
        TreeOptions.SelectionOptions = [toExtendedFocus, toFullRowSelect]
        OnDblClick = VSTDblClick
        OnEnter = VSTEnter
        OnExit = VSTExit
        OnFocusChanged = VSTFocusChanged
        OnGetText = VSTGetText
        OnKeyPress = VSTKeyPress
        OnResize = VSTResize
        ExplicitLeft = -1
        ExplicitTop = 15
        Columns = <
          item
            Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coFixed]
            Position = 0
            WideText = #8470' '#1087'/'#1087
          end
          item
            Position = 1
            Width = 90
            WideText = #1050#1086#1076
          end>
        WideDefaultText = 'node'
      end
      object EditRate: TEdit
        Left = 0
        Top = 0
        Width = 110
        Height = 21
        Align = alTop
        Alignment = taCenter
        TabOrder = 0
        OnChange = EditRateChange
        OnEnter = EditRateEnter
        OnKeyPress = EditRateKeyPress
      end
    end
    object PanelRight: TPanel
      Left = 704
      Top = 0
      Width = 50
      Height = 444
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 2
    end
    object PanelCenter: TPanel
      Left = 115
      Top = 0
      Width = 584
      Height = 444
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object PanelShowHideButton: TPanel
        Left = 569
        Top = 0
        Width = 15
        Height = 444
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 1
        object SpeedButtonShowHideRightPanel: TSpeedButton
          Left = 0
          Top = 0
          Width = 15
          Height = 444
          Align = alClient
          Flat = True
          ParentShowHint = False
          ShowHint = True
          OnClick = SpeedButtonShowHideRightPanelClick
          ExplicitTop = 120
          ExplicitHeight = 89
        end
      end
      object PanelCenterClient: TPanel
        Left = 0
        Top = 0
        Width = 569
        Height = 444
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        OnResize = PanelCenterClientResize
        object ImageSplitterTop: TImage
          Left = 312
          Top = 0
          Width = 15
          Height = 5
          Cursor = crVSplit
        end
        object SplitterTop: TSplitter
          Left = 0
          Top = 96
          Width = 569
          Height = 5
          Cursor = crVSplit
          Align = alTop
          ResizeStyle = rsUpdate
          OnMoved = SplitterTopMoved
          ExplicitTop = 245
          ExplicitWidth = 470
        end
        object PanelCollection: TPanel
          Left = 0
          Top = 0
          Width = 569
          Height = 96
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object PanelHeaderCollection: TPanel
            Left = 0
            Top = 25
            Width = 569
            Height = 25
            Align = alTop
            BevelOuter = bvNone
            ParentBackground = False
            TabOrder = 1
            DesignSize = (
              569
              25)
            object LabelSbornik: TLabel
              Left = 8
              Top = 6
              Width = 51
              Height = 13
              Hint = #1054#1090#1082#1088#1099#1090#1100' '#1086#1082#1085#1086' '#1080#1089#1093#1086#1076#1085#1099#1093' '#1076#1072#1085#1085#1099#1093
              Caption = #1057#1073#1086#1088#1085#1080#1082':'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
              OnClick = LabelSbornikClick
              OnMouseEnter = LabelSbornikMouseEnter
              OnMouseLeave = LabelSbornikMouseLeave
            end
            object EditCollection: TEdit
              Left = 65
              Top = 2
              Width = 504
              Height = 21
              Hint = 
                #1042#1074#1077#1076#1080#1090#1077' '#1095#1072#1089#1090#1100' '#1086#1087#1080#1089#1072#1085#1080#1103' '#1088#1072#1073#1086#1090' '#1080' '#1085#1072#1078#1084#1080#1090#1077' - Enter, '#1076#1083#1103' '#1086#1095#1080#1089#1090#1082#1080' '#1085#1072#1078#1084 +
                #1080#1090#1077' - Esc'
              Anchors = [akLeft, akTop, akRight]
              Color = 14802912
              ParentShowHint = False
              ReadOnly = True
              ShowHint = True
              TabOrder = 0
              OnKeyPress = EditSearchNormativeKeyPress
            end
          end
          object MemoDescription: TMemo
            Left = 0
            Top = 50
            Width = 569
            Height = 46
            Align = alClient
            ReadOnly = True
            ScrollBars = ssVertical
            TabOrder = 2
          end
          object PanelSearchNormative: TPanel
            Left = 0
            Top = 0
            Width = 569
            Height = 25
            Align = alTop
            BevelOuter = bvNone
            ParentBackground = False
            TabOrder = 0
            DesignSize = (
              569
              25)
            object LabelSearchNormative: TLabel
              Left = 25
              Top = 6
              Width = 34
              Height = 13
              Caption = #1055#1086#1080#1089#1082':'
            end
            object EditSearchNormative: TEdit
              Left = 65
              Top = 2
              Width = 336
              Height = 21
              Hint = 
                #1042#1074#1077#1076#1080#1090#1077' '#1095#1072#1089#1090#1100' '#1086#1087#1080#1089#1072#1085#1080#1103' '#1088#1072#1073#1086#1090' '#1080' '#1085#1072#1078#1084#1080#1090#1077' - Enter, '#1076#1083#1103' '#1086#1095#1080#1089#1090#1082#1080' '#1085#1072#1078#1084 +
                #1080#1090#1077' - Esc'
              Anchors = [akLeft, akTop, akRight]
              ParentShowHint = False
              ShowHint = True
              TabOrder = 0
              OnEnter = EditSearchNormativeEnter
              OnKeyPress = EditSearchNormativeKeyPress
            end
            object chk1: TCheckBox
              Left = 407
              Top = 4
              Width = 66
              Height = 17
              Anchors = [akTop, akRight]
              Caption = #1056#1072#1089#1094#1077#1085#1082#1080
              Checked = True
              State = cbChecked
              TabOrder = 1
              OnClick = chk1Click
            end
            object chk2: TCheckBox
              Left = 479
              Top = 6
              Width = 90
              Height = 15
              Anchors = [akTop, akRight]
              Caption = #1055#1091#1089#1082#1086#1085#1072#1083#1072#1076#1082#1072
              TabOrder = 2
              OnClick = chk1Click
            end
          end
        end
        object Panel1: TPanel
          Left = 0
          Top = 101
          Width = 569
          Height = 343
          Align = alClient
          BevelOuter = bvNone
          Caption = 'Panel1'
          ShowCaption = False
          TabOrder = 1
          object ImageSplitter1: TImage
            Left = 320
            Top = 8
            Width = 15
            Height = 5
            Cursor = crVSplit
          end
          object ImageSplitter2: TImage
            Left = 328
            Top = 16
            Width = 15
            Height = 5
            Cursor = crVSplit
          end
          object PanelHorizontal1: TPanel
            Left = 0
            Top = 0
            Width = 569
            Height = 25
            Align = alTop
            BevelOuter = bvNone
            ParentBackground = False
            TabOrder = 0
            object LabelJustification: TLabel
              Left = 6
              Top = 6
              Width = 71
              Height = 13
              Caption = #1054#1073#1086#1089#1085#1086#1074#1072#1085#1080#1077':'
            end
            object LabelUnit: TLabel
              Left = 304
              Top = 6
              Width = 103
              Height = 13
              Caption = #1045#1076#1080#1085#1080#1094#1072' '#1080#1079#1084#1077#1088#1077#1085#1080#1103':'
            end
            object EditJustification: TEdit
              Left = 83
              Top = 2
              Width = 100
              Height = 21
              Color = 14802912
              ReadOnly = True
              TabOrder = 0
            end
            object Edit5: TEdit
              Left = 189
              Top = 2
              Width = 109
              Height = 21
              Alignment = taCenter
              Color = 8454016
              Enabled = False
              ReadOnly = True
              TabOrder = 1
              Text = #1044#1077#1081#1089#1090#1074#1091#1102#1097#1072#1103
            end
            object EditUnit: TEdit
              Left = 413
              Top = 2
              Width = 100
              Height = 21
              Color = 14802912
              ReadOnly = True
              TabOrder = 2
            end
          end
          object PanelHorizontal2: TPanel
            Left = 0
            Top = 50
            Width = 569
            Height = 25
            Align = alTop
            BevelOuter = bvNone
            ParentBackground = False
            TabOrder = 2
            OnResize = PanelHorizontal2Resize
            DesignSize = (
              569
              25)
            object LabelWinterPrice: TLabel
              Left = 6
              Top = 6
              Width = 121
              Height = 13
              Caption = #1047#1080#1084#1085#1077#1077' '#1091#1076#1086#1088#1086#1078#1072#1085#1080#1077' '#1085#1072':'
            end
            object EditWinterPrice: TEdit
              Left = 133
              Top = 2
              Width = 433
              Height = 21
              Anchors = [akLeft, akTop, akRight]
              Color = 14802912
              ReadOnly = True
              TabOrder = 0
            end
          end
          object PanelHorizontal3: TPanel
            Left = 0
            Top = 75
            Width = 569
            Height = 25
            Align = alTop
            BevelOuter = bvNone
            ParentBackground = False
            TabOrder = 3
            object Label2: TLabel
              Left = 8
              Top = 6
              Width = 127
              Height = 13
              Caption = #1057#1082#1088#1099#1090'/'#1087#1086#1082#1072#1079#1072#1090#1100' '#1087#1072#1085#1077#1083#1080':'
            end
            object CheckBoxNormСonsumption: TCheckBox
              Left = 141
              Top = 4
              Width = 97
              Height = 17
              Caption = #1053#1086#1088#1084#1099' '#1088#1072#1089#1093#1086#1076#1072
              Checked = True
              State = cbChecked
              TabOrder = 0
              OnClick = ShowHidePanels
            end
            object CheckBoxStructureWorks: TCheckBox
              Left = 244
              Top = 4
              Width = 90
              Height = 17
              Caption = #1057#1086#1089#1090#1072#1074' '#1088#1072#1073#1086#1090
              Checked = True
              State = cbChecked
              TabOrder = 1
              OnClick = ShowHidePanels
            end
            object CheckBoxChangesAdditions: TCheckBox
              Left = 340
              Top = 4
              Width = 155
              Height = 17
              Caption = #1048#1079#1084#1077#1085#1077#1085#1080#1103' '#1080' '#1076#1086#1087#1086#1083#1085#1077#1085#1080#1103
              Checked = True
              State = cbChecked
              TabOrder = 2
              OnClick = ShowHidePanels
            end
          end
          object Panel2: TPanel
            Left = 0
            Top = 25
            Width = 569
            Height = 25
            Align = alTop
            BevelOuter = bvNone
            ParentBackground = False
            TabOrder = 1
            OnResize = PanelHorizontal2Resize
            DesignSize = (
              569
              25)
            object LabelOXROPR: TLabel
              Left = 6
              Top = 6
              Width = 141
              Height = 13
              Caption = #1054#1061#1056' '#1080' '#1054#1055#1056' '#1080' '#1055#1083#1072#1085' '#1087#1088#1080#1073#1099#1083#1080':'
            end
            object ComboBoxOXROPR: TComboBox
              Left = 153
              Top = 2
              Width = 413
              Height = 21
              Style = csDropDownList
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 0
            end
          end
          object Panel3: TPanel
            Left = 0
            Top = 100
            Width = 569
            Height = 243
            Align = alClient
            BevelOuter = bvNone
            Caption = 'Panel3'
            ShowCaption = False
            TabOrder = 4
            object Splitter2: TSplitter
              Left = 0
              Top = 238
              Width = 569
              Height = 5
              Cursor = crVSplit
              Align = alBottom
              ResizeStyle = rsUpdate
              ExplicitTop = 0
            end
            object Splitter1: TSplitter
              Left = 0
              Top = 233
              Width = 569
              Height = 5
              Cursor = crVSplit
              Align = alBottom
              ResizeStyle = rsUpdate
              ExplicitTop = 0
            end
            object PanelChangesAdditions: TPanel
              Left = 0
              Top = 151
              Width = 505
              Height = 58
              BevelOuter = bvNone
              TabOrder = 2
              object PanelCAHeader: TPanel
                Left = 0
                Top = 0
                Width = 505
                Height = 20
                Align = alTop
                BevelOuter = bvNone
                Caption = #1048#1079#1084#1077#1085#1077#1085#1080#1103' '#1080' '#1076#1086#1087#1086#1083#1085#1077#1085#1080#1103
                Color = clActiveCaption
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWhite
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentBackground = False
                ParentFont = False
                TabOrder = 0
              end
              object grHistory: TJvDBGrid
                Left = 0
                Top = 20
                Width = 505
                Height = 38
                Align = alClient
                DataSource = dsHistory
                Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
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
                    Alignment = taCenter
                    Expanded = False
                    FieldName = 'date_beginer'
                    Title.Alignment = taCenter
                    Title.Caption = #1044#1072#1090#1072
                    Width = 96
                    Visible = True
                  end
                  item
                    Expanded = False
                    FieldName = 'prikaz'
                    Title.Alignment = taCenter
                    Title.Caption = #1054#1089#1085#1086#1074#1072#1085#1080#1077
                    Width = 403
                    Visible = True
                  end>
              end
            end
            object PanelNormСonsumption: TPanel
              Left = 0
              Top = 8
              Width = 505
              Height = 65
              BevelOuter = bvNone
              TabOrder = 0
              OnResize = PanelNormСonsumptionResize
              object PanelNCHeader: TPanel
                Left = 0
                Top = 0
                Width = 505
                Height = 20
                Align = alTop
                BevelOuter = bvNone
                Caption = #1053#1086#1088#1084#1072' '#1088#1072#1089#1093#1086#1076#1072
                Color = clActiveCaption
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWhite
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentBackground = False
                ParentFont = False
                TabOrder = 0
              end
              object StringGridNC: TStringGrid
                Left = 0
                Top = 20
                Width = 505
                Height = 45
                Align = alClient
                DefaultRowHeight = 20
                DefaultDrawing = False
                FixedCols = 0
                RowCount = 2
                Options = [goFixedVertLine, goVertLine, goHorzLine, goRowSelect, goThumbTracking]
                ScrollBars = ssVertical
                TabOrder = 1
                OnDrawCell = StringGridNCDrawCell
              end
            end
            object PanelStructureWorks: TPanel
              Left = 1
              Top = 79
              Width = 505
              Height = 66
              BevelOuter = bvNone
              ParentBackground = False
              TabOrder = 1
              object PanelSWHeader: TPanel
                Left = 0
                Top = 0
                Width = 505
                Height = 20
                Align = alTop
                BevelOuter = bvNone
                Caption = #1057#1086#1089#1090#1072#1074' '#1088#1072#1073#1086#1090
                Color = clActiveCaption
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWhite
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentBackground = False
                ParentFont = False
                TabOrder = 0
              end
              object grSostav: TJvDBGrid
                Left = 0
                Top = 20
                Width = 505
                Height = 46
                Align = alClient
                DataSource = dsSW
                Options = [dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleHotTrack]
                ReadOnly = True
                TabOrder = 1
                TitleFont.Charset = DEFAULT_CHARSET
                TitleFont.Color = clWindowText
                TitleFont.Height = -11
                TitleFont.Name = 'Tahoma'
                TitleFont.Style = []
                AutoAppend = False
                AutoSizeColumns = True
                SelectColumnsDialogStrings.Caption = 'Select columns'
                SelectColumnsDialogStrings.OK = '&OK'
                SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
                CanDelete = False
                EditControls = <>
                RowsHeight = 17
                TitleRowHeight = 17
                WordWrap = True
                WordWrapAllFields = True
                Columns = <
                  item
                    Expanded = False
                    FieldName = 'FULL_NAME'
                    Title.Alignment = taCenter
                    Title.Caption = #1057#1086#1089#1090#1072#1074' '#1088#1072#1073#1086#1090
                    Width = 500
                    Visible = True
                  end>
              end
            end
          end
        end
      end
    end
  end
  inline FrameStatusBar: TFrameStatusBar
    Left = 0
    Top = 444
    Width = 754
    Height = 19
    Align = alBottom
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 1
    ExplicitTop = 444
    ExplicitWidth = 754
    inherited StatusBar: TStatusBar
      Width = 754
      ExplicitWidth = 754
    end
  end
  object pmRates: TPopupMenu
    Left = 8
    Top = 400
    object FindToRates: TMenuItem
      Caption = #1053#1072#1081#1090#1080' '#1074' '#1089#1073#1086#1088#1085#1080#1082#1077
      OnClick = FindToRatesClick
    end
  end
  object qrNormativ: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FetchOptions.AssignedValues = [evRecordCountMode]
    Left = 36
    Top = 24
  end
  object ADOQueryNC: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    Left = 28
    Top = 168
  end
  object ADOQuerySW: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    Left = 28
    Top = 216
  end
  object ADOQueryTemp: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    Left = 28
    Top = 272
  end
  object tmrFilter: TTimer
    Enabled = False
    Interval = 400
    OnTimer = tmrFilterTimer
    Left = 32
    Top = 96
  end
  object dsHistory: TDataSource
    DataSet = qrHistory
    Left = 587
    Top = 376
  end
  object qrHistory: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FetchOptions.AssignedValues = [evRecordCountMode]
    SQL.Strings = (
      'select distinct date_beginer, prikaz'
      'from normativg'
      
        'where (NORM_NUM like :NORM_NUM) AND ((`normativg`.`date_end` IS ' +
        'NOT NULL) OR (`normativg`.`date_beginer` IS NOT NULL))'
      'ORDER BY date_beginer DESC, date_end DESC')
    Left = 556
    Top = 376
    ParamData = <
      item
        Name = 'NORM_NUM'
        DataType = ftString
        ParamType = ptInput
        Value = ''
      end>
  end
  object dsNormativ: TDataSource
    DataSet = qrNormativ
    Left = 72
    Top = 24
  end
  object qrSW: TFDQuery
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FetchOptions.AssignedValues = [evCache]
    FetchOptions.Cache = [fiBlobs, fiMeta]
    FormatOptions.AssignedValues = [fvDefaultParamDataType]
    FormatOptions.DefaultParamDataType = ftBCD
    SQL.Strings = (
      'SELECT FIRST_NAME AS FULL_NAME, normativ_directory_id'
      'FROM normativ_directory'
      'WHERE type_directory = 6 AND parent_id=:normativ_directory_id'
      'ORDER BY FIRST_NAME')
    Left = 489
    Top = 296
    ParamData = <
      item
        Name = 'NORMATIV_DIRECTORY_ID'
        ParamType = ptInput
      end>
  end
  object dsSW: TDataSource
    DataSet = qrSW
    Left = 536
    Top = 296
  end
end
