// модуль создания отчетов (Вадим)
unit dmReportU;

interface

uses
  System.SysUtils, System.Classes, frxClass, frxDBSet, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Dialogs, Tools, DateUtils,
  frxExportRTF, frxExportHTML, frxExportPDF, frxExportText;

type
  TdmReportF = class(TDataModule)
    frxZP_OBJ: TfrxDBDataset;
    frxReport: TfrxReport;
    qrZP_OBJ: TFDQuery;
    trReportRead: TFDTransaction;
    trReportWrite: TFDTransaction;
    qrTMP: TFDQuery;
    frxZP_OBJ_ACT: TfrxDBDataset;
    qrZP_OBJ_ACT: TFDQuery;
    qrRASX_MAT: TFDQuery;
    frxRASX_MAT: TfrxDBDataset;
    qrRASX_MAT2: TFDQuery;
    frxRASX_MAT2: TfrxDBDataset;
    frxPDFExport1: TfrxPDFExport;
    frxHTMLExport1: TfrxHTMLExport;
    frxRTFExport1: TfrxRTFExport;
    frxSimpleTextExport1: TfrxSimpleTextExport;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Report_ZP_OBJ(SM_ID: integer; FileReportPath: string);
    procedure Report_ZP_OBJ_ACT(ID_ACT: integer; FileReportPath: string);
    procedure Report_RASX_MAT(ID_ACT: integer; FileReportPath: string);
  end;

const arraymes: array[1..12, 1..2] of string = (('Январь',   'Января'),
                                                ('Февраль',  'Февраля'),
                                                ('Март',     'Марта'),
                                                ('Апрель',   'Апреля'),
                                                ('Май',      'Мая'),
                                                ('Июнь',     'Июня'),
                                                ('Июль',     'Июля'),
                                                ('Август',   'Августа'),
                                                ('Сентябрь', 'Сентября'),
                                                ('Октябрь',  'Октября'),
                                                ('Ноябрь',   'Ноября'),
                                                ('Декабрь',  'Декабря'));

var
  dmReportF: TdmReportF;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

Uses DataModule;

// отчет Расчет стоимости заработной платы рабочих строителей (Вадим)
procedure TdmReportF.Report_ZP_OBJ(SM_ID: integer; FileReportPath: string);
var
  SM_ID_0: integer;
begin
  frxReport.LoadFromFile(FileReportPath + 'frZP_OBJ.fr3');


  qrTMP.SQL.Text := 'SELECT COALESCE(ssd_2.SM_ID, ssd_1.SM_ID, ssd.SM_ID) as SM_ID_0'#13#10 +
                    'FROM smetasourcedata ssd'#13#10 +
                    'LEFT JOIN smetasourcedata ssd_1 ON ssd_1.SM_ID = (ssd.PARENT_LOCAL_ID + ssd.PARENT_PTM_ID)'#13#10 +
                    'LEFT JOIN smetasourcedata ssd_2 ON ssd_2.SM_ID = (ssd_1.PARENT_LOCAL_ID + ssd_1.PARENT_PTM_ID)'#13#10 +
                    'WHERE ssd.sm_id = :SM_ID';
  qrTMP.ParamByName('SM_ID').AsInteger := SM_ID;
  CloseOpen(qrTMP);
  SM_ID_0 := qrTMP.FieldByName('SM_ID_0').AsInteger;
  qrTMP.Close;

  qrTMP.SQL.Text := 'SELECT CONCAT(oc.NUM, " ", oc.NAME) as Name, IFNULL(s.MONAT, 0) as Month, IFNULL(s.YEAR, 0) as Year,'#13#10 +
                    '       IF(os.OBJ_REGION = 3, s.STAVKA_M_RAB, s.STAVKA_RB_RAB) as Tarif,'#13#10 +
                    '       ssd.PREPARER, ssd.POST_PREPARER, ssd.EXAMINER, ssd.POST_EXAMINER'#13#10 +
                    'FROM smetasourcedata as ssd'#13#10 +
                    'LEFT JOIN objcards as oc ON oc.OBJ_ID = ssd.OBJ_ID'#13#10 +
                    'LEFT JOIN objstroj as os ON os.STROJ_ID = oc.STROJ_ID'#13#10 +
                    'LEFT JOIN stavka as s ON s.STAVKA_ID = ssd.STAVKA_ID'#13#10 +
                    'WHERE ssd.SM_ID = :SM_ID';
  qrTMP.ParamByName('SM_ID').AsInteger := SM_ID_0;
  CloseOpen(qrTMP);

  qrZP_OBJ.SQL.Text := 'call smeta.Report_ZP_OBJ(:SM_ID, :MONTH, :YEAR)';
  qrZP_OBJ.ParamByName('SM_ID').AsInteger := SM_ID_0;
  qrZP_OBJ.ParamByName('MONTH').AsInteger := qrTMP.FieldByName('Month').AsInteger;
  qrZP_OBJ.ParamByName('YEAR').AsInteger := qrTMP.FieldByName('Year').AsInteger;
  CloseOpen(qrZP_OBJ);

  frxReport.Script.Variables['sm_obj_name'] := AnsiUpperCase(qrTMP.FieldByName('Name').AsString);
  frxReport.Script.Variables['sm_date_dog'] := '1 ' + AnsiUpperCase(arraymes[qrTMP.FieldByName('Month').AsInteger, 2]) +
                                               ' ' + IntToStr(qrTMP.FieldByName('Year').AsInteger) + ' г.';
  frxReport.Script.Variables['sm_tarif'] := FormatFloat('#,##0', qrTMP.FieldByName('Tarif').AsFloat);

  frxReport.Script.Variables['preparer'] := qrTMP.FieldByName('preparer').AsString;
  frxReport.Script.Variables['post_preparer'] := qrTMP.FieldByName('post_preparer').AsString;
  frxReport.Script.Variables['examiner'] := qrTMP.FieldByName('examiner').AsString;
  frxReport.Script.Variables['post_examiner'] := qrTMP.FieldByName('post_examiner').AsString;

  try
    frxReport.PrepareReport;
    frxReport.ShowPreparedReport;
  except
    ShowMessage('Ошибка при формировании отчета');
  end;

  qrTMP.Close;
end;

// отчет Расчет стоимости заработной платы рабочих строителей по акту (Вадим)
procedure TdmReportF.Report_ZP_OBJ_ACT(ID_ACT: integer; FileReportPath: string);
begin
  frxReport.LoadFromFile(FileReportPath + 'frZP_OBJ_AKT.fr3');

  qrTMP.SQL.Text := 'SELECT CONCAT(oc.`NUM`, " ", oc.`NAME`) as Name, IFNULL(s.`MONAT`, 0) as Month, IFNULL(s.`YEAR`, 0) as Year,'#13#10 +
                    '       IF(os.`OBJ_REGION` = 3, s.`STAVKA_M_RAB`, s.`STAVKA_RB_RAB`) as Tarif,'#13#10 +
                    '       ca.`NAME` as Act_Name'#13#10 +
                    'FROM `smetasourcedata` as ssd'#13#10 +
                    'LEFT JOIN `objcards` as oc ON oc.`OBJ_ID` = ssd.`OBJ_ID`'#13#10 +
                    'LEFT JOIN `objstroj` as os ON os.`STROJ_ID` = oc.`STROJ_ID`'#13#10 +
                    'LEFT JOIN `stavka` as s ON s.`STAVKA_ID` = ssd.`STAVKA_ID`'#13#10 +
	          				'INNER JOIN `card_acts` ca ON ca.`ID_ESTIMATE_OBJECT` = ssd.`SM_ID`'#13#10 +
                    'WHERE ca.`ID` = :ID_ACT';
  qrTMP.ParamByName('ID_ACT').AsInteger := ID_ACT;
  CloseOpen(qrTMP);

  qrZP_OBJ_ACT.ParamByName('ID_ACT').AsInteger := ID_ACT;
  qrZP_OBJ_ACT.ParamByName('MONTH').AsInteger := qrTMP.FieldByName('Month').AsInteger;
  qrZP_OBJ_ACT.ParamByName('YEAR').AsInteger := qrTMP.FieldByName('Year').AsInteger;
  CloseOpen(qrZP_OBJ_ACT);

  frxReport.Script.Variables['act_obj_name'] := AnsiUpperCase(qrTMP.FieldByName('Name').AsString);
  frxReport.Script.Variables['act_date_dog'] := '1 ' + AnsiUpperCase(arraymes[qrTMP.FieldByName('Month').AsInteger, 2]) +
                                               ' ' + IntToStr(qrTMP.FieldByName('Year').AsInteger) + ' г.';
  frxReport.Script.Variables['act_tarif'] := FormatFloat('#,##0', qrTMP.FieldByName('Tarif').AsFloat);
  frxReport.Script.Variables['act_number'] := qrTMP.FieldByName('Act_Name').AsString;
  frxReport.Script.Variables['contractor_dolg'] := '';
  frxReport.Script.Variables['contractor_fio'] := '';
  frxReport.Script.Variables['customer_dolg'] := '';
  frxReport.Script.Variables['customer_fio'] := '';
  try
    frxReport.PrepareReport;
    frxReport.ShowPreparedReport;
  except
    ShowMessage('Ошибка при формировании отчета');
  end;

  qrTMP.Close;
end;

// отчет по расходу материалов по акту (Вадим)
procedure TdmReportF.Report_RASX_MAT(ID_ACT: integer; FileReportPath: string);
begin
  frxReport.LoadFromFile(FileReportPath + 'frRASX_MAT.fr3');

  qrTMP.SQL.Text := 'SELECT CONCAT(oc.`NUM`, " ", oc.`NAME`) as Name, IFNULL(s.`MONAT`, 0) as Month, IFNULL(s.`YEAR`, 0) as Year,'#13#10 +
                    '       IF(os.`OBJ_REGION` = 3, s.`STAVKA_M_RAB`, s.`STAVKA_RB_RAB`) as Tarif,'#13#10 +
                    '       ca.`NAME` as Act_Name, d.`DUMP_NAME`'#13#10 +
                    'FROM `smetasourcedata` as ssd'#13#10 +
                    'LEFT JOIN `objcards` as oc ON oc.`OBJ_ID` = ssd.`OBJ_ID`'#13#10 +
                    'LEFT JOIN `objstroj` as os ON os.`STROJ_ID` = oc.`STROJ_ID`'#13#10 +
                    'LEFT JOIN `stavka` as s ON s.`STAVKA_ID` = ssd.`STAVKA_ID`'#13#10 +
	          				'INNER JOIN `card_acts` ca ON ca.`ID_ESTIMATE_OBJECT` = ssd.`SM_ID`'#13#10 +
                    'LEFT JOIN `dump` d ON d.`DUMP_ID` = ssd.`DUMP_ID`'#13#10 +
                    'WHERE ca.`ID` = :ID_ACT';
  qrTMP.ParamByName('ID_ACT').AsInteger := ID_ACT;
  CloseOpen(qrTMP);

  qrRASX_MAT.ParamByName('ID_ACT').AsInteger := ID_ACT;
  CloseOpen(qrRASX_MAT);
  qrRASX_MAT2.ParamByName('ID_ACT').AsInteger := ID_ACT;
  CloseOpen(qrRASX_MAT);

  frxReport.Script.Variables['name_org'] := qrTMP.FieldByName('DUMP_NAME').AsString;
  frxReport.Script.Variables['name_obj'] := AnsiUpperCase(qrTMP.FieldByName('Name').AsString);
  frxReport.Script.Variables['data_act'] := AnsiUpperCase(arraymes[qrTMP.FieldByName('Month').AsInteger, 1]) +
                                    ' ' + IntToStr(qrTMP.FieldByName('Year').AsInteger) + ' г.';

  frxReport.Script.Variables['num_act'] := qrTMP.FieldByName('Act_Name').AsString;
  try
    frxReport.PrepareReport;
    frxReport.ShowPreparedReport;
  except
    ShowMessage('Ошибка при формировании отчета');
  end;

  qrTMP.Close;
end;

end.
