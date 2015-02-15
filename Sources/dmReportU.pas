// модуль создания отчетов (Вадим)
unit dmReportU;

interface

uses
  System.SysUtils, System.Classes, frxClass, frxDBSet, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Dialogs, Tools, DateUtils;

type
  TdmReportF = class(TDataModule)
    frxZP_OBJ: TfrxDBDataset;
    frxReport: TfrxReport;
    qrZP_OBJ: TFDQuery;
    trReportRead: TFDTransaction;
    trReportWrite: TFDTransaction;
    qrTMP: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Report_ZP_OBJ(SM_ID: integer; FileReportPath: string);
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
begin
  frxReport.LoadFromFile(FileReportPath + 'frZP_OBJ.fr3');

  qrTMP.SQL.Text := 'SELECT CONCAT(oc.NUM, " ", oc.NAME) as Name, IFNULL(s.MONAT, 0) as Month, IFNULL(s.YEAR, 0) as Year,'#13#10 +
                    '       IF(oc.REGION_ID = 7, s.STAVKA_M_RAB, s.STAVKA_RB_RAB) as Tarif'#13#10 +
                    'FROM smetasourcedata as ssd'#13#10 +
                    'LEFT JOIN objcards as oc ON oc.OBJ_ID = ssd.OBJ_ID'#13#10 +
                    'LEFT JOIN stavka as s ON s.STAVKA_ID = ssd.STAVKA_ID'#13#10 +
                    'WHERE ssd.SM_ID = :SM_ID';
  qrTMP.ParamByName('SM_ID').AsInteger := SM_ID;
  CloseOpen(qrTMP);

  qrZP_OBJ.SQL.Text := 'call smeta.Report_ZP_OBJ(:SM_ID, :MONTH, :YEAR)';
  qrZP_OBJ.ParamByName('SM_ID').AsInteger := SM_ID;
  qrZP_OBJ.ParamByName('MONTH').AsInteger := qrTMP.FieldByName('Month').AsInteger;
  qrZP_OBJ.ParamByName('YEAR').AsInteger := qrTMP.FieldByName('Year').AsInteger;;
  CloseOpen(qrZP_OBJ);

  frxReport.Script.Variables['sm_obj_name'] := AnsiUpperCase(qrTMP.FieldByName('Name').AsString);
  frxReport.Script.Variables['sm_date_dog'] := '1 ' + AnsiUpperCase(arraymes[qrTMP.FieldByName('Month').AsInteger, 2]) +
                                               ' ' + IntToStr(qrTMP.FieldByName('Year').AsInteger) + ' г.';
  frxReport.Script.Variables['sm_tarif'] := FormatFloat('#,##0', qrTMP.FieldByName('Tarif').AsFloat);

  frxReport.PrepareReport;
  try
    frxReport.ShowPreparedReport;
  except
    ShowMessage('Ошибка при формировании отчета');
  end;

  qrTMP.Close;
end;


end.
