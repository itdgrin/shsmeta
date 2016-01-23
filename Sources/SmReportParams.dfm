object fSmReportParams: TfSmReportParams
  Left = 0
  Top = 0
  Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1086#1090#1095#1077#1090#1072
  ClientHeight = 110
  ClientWidth = 275
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lblHint: TLabel
    AlignWithMargins = True
    Left = 10
    Top = 87
    Width = 262
    Height = 13
    Margins.Left = 10
    Margins.Bottom = 10
    Align = alBottom
    Caption = '* - '#1087#1086#1083#1103', '#1086#1073#1103#1079#1072#1090#1077#1083#1100#1085#1099#1077' '#1076#1083#1103' '#1079#1072#1087#1086#1083#1085#1077#1085#1080#1103
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
    ExplicitWidth = 235
  end
  object qrReportParam: TFDQuery
    AfterOpen = qrReportParamAfterOpen
    Connection = DM.Connect
    Transaction = DM.Read
    UpdateTransaction = DM.Write
    FetchOptions.AssignedValues = [evCache]
    FetchOptions.Cache = [fiBlobs, fiMeta]
    UpdateOptions.UpdateTableName = 'smeta.report_param'
    SQL.Strings = (
      'SELECT report_param.*, report_list_sql.REPORT_LIST_SQL_SRC'
      'FROM report_param'
      
        'LEFT JOIN report_list_sql ON report_list_sql.REPORT_LIST_SQL_ID ' +
        '= report_param.REPORT_LIST_SQL_ID'
      'WHERE REPORT_ID = :REPORT_ID'
      'ORDER BY POS DESC, REPORT_PARAM_ID DESC')
    Left = 30
    Top = 10
    ParamData = <
      item
        Name = 'REPORT_ID'
        ParamType = ptInput
      end>
  end
end
