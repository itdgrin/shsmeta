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
    frxWRS_OBJ: TfrxDBDataset;
    qWRS_OBJ: TFDQuery;
    frxReport1: TfrxReport;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Report_ZP_OBJ(SM_ID: integer; FileReportPath: string);
    procedure Report_ZP_OBJ_ACT(ID_ACT: integer; FileReportPath: string);
    procedure Report_RASX_MAT(ID_ACT: integer; FileReportPath: string);
    procedure Report_WINTER_RS_OBJ(SM_ID: integer; FileReportPath: string);
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


 procedure TdmReportF.Report_WINTER_RS_OBJ(SM_ID: integer; FileReportPath: string);
var
  SM_ID_0: integer;
begin
frxReport.LoadFromFile(FileReportPath + 'frWinter_RS_OBJ.fr3');

   qWRS_OBJ.SQL.Text:=
  ' SELECT 	DE.id_estimate,'+
  ' DE.ZP           as zp,'+
  ' round(DE.ZP_MASH,0)      as ZP_MASH,'+
  ' DE.Zim_udor     as Zim_udor,'+
  ' DE.ZP_ZIM_UDOR  as ZP_ZIM_UDOR,'+
  ' SSx.KZP         as KZP,'+
  ' CR.RATE_CODE    as RATE_CODE,'+
  ' CR.RATE_CAPTION as RATE_CAPTION,'+
  ' CR.RATE_COUNT   as RATE_COUNT,'+
  ' CR.RATE_UNIT    as RATE_UNIT,'+
  ' ssx.NAME1       as NAME1 ,'+
  ' round(if(SSx.KZP>0,DE.zp/SSx.KZP,0),0)     as zp_rab,'+
  ' round(if(SSx.KZP>0,ZP_MASH/RATE_COUNT,0),0) as v_mash,'+
  ' round(if(SSx.KZP*RATE_COUNT>0,DE.zp/(SSx.KZP*RATE_COUNT),0),0) as v_rab'+
  ' FROM data_estimate AS DE'+
  ' LEFT JOIN card_rate as CR ON DE.id_tables = CR.id'+
  ' left join'+
  ' (SELECT  ssd.SM_ID,0 as SM_VID,ssd.KZP, "" as NAME1'+
  ' FROM smetasourcedata ssd'+
  ' WHERE ssd.SM_ID = '+inttostr(SM_ID)+
  ' AND ssd.SM_TYPE = 2'+
  ' UNION '+
  ' SELECT ssd_local.SM_ID, 1 as SM_VID,ssd_local.KZP, CONCAT(ssd_local.SM_NUMBER, " ",  ssd_local.NAME) as NAME1'+
  ' FROM smetasourcedata ssd_local'+
  ' JOIN smetasourcedata ssd ON ssd.SM_ID = ssd_local.PARENT_ID'+
  ' AND ssd.SM_TYPE = 2'+
  ' WHERE ssd_local.PARENT_ID = '+inttostr(SM_ID)+
  ' AND ssd_local.SM_TYPE = 1'+
  ' UNION'+
  ' SELECT ssd_ptm.SM_ID,2 as SM_VID,ssd_ptm.KZP, CONCAT(ssd_local.SM_NUMBER, " ",  ssd_local.NAME) as NAME1'+
  ' FROM smetasourcedata ssd_ptm'+
  ' JOIN smetasourcedata ssd_local ON ssd_local.SM_ID = ssd_ptm.PARENT_ID'+
  ' AND ssd_local.SM_TYPE = 1'+
  ' AND ssd_local.PARENT_ID = '+inttostr(SM_ID)+
  ' JOIN smetasourcedata ssd ON ssd.SM_ID = ssd_local.PARENT_ID '+
  ' AND ssd.SM_TYPE = 2'+
  ' WHERE ssd_ptm.SM_TYPE = 3'+
  ' ORDER BY SM_VID) as ssx on ssx.sm_id = DE.ID_ESTIMATE'+
  ' where zim_udor+ZP_ZIM_UDOR>0' ;


   CloseOpen(qWRS_OBJ);

  try
    frxReport.PrepareReport;
    frxReport.ShowPreparedReport;
  except
    ShowMessage('Ошибка при формировании отчета');
  end;

  qrTMP.Close;
end;


// отчет Расчет стоимости заработной платы рабочих строителей (Вадим)
procedure TdmReportF.Report_ZP_OBJ(SM_ID: integer; FileReportPath: string);
var
  SM_ID_ROOT: integer;
begin
  // поиск корня по ветке
  qrTMP.SQL.Text := 'select IF(`ssd`.`PARENT_ID` = 0, `ssd`.`SM_ID`,'#13#10 +
                    '          (select IF(`ssd1`.`PARENT_ID` = 0, `ssd1`.`SM_ID`,'#13#10 +
                  	'                     (select IF(`ssd2`.`PARENT_ID` = 0, `ssd2`.`SM_ID`, NULL)'#13#10 +
                    '                      from `smetasourcedata` `ssd2`'#13#10 +
                    '               	  	 where `ssd2`.`SM_ID` = `ssd1`.`PARENT_ID`))'#13#10 +
                    '     		  from `smetasourcedata` `ssd1`'#13#10 +
		                '           where `ssd1`.`SM_ID` = `ssd`.`PARENT_ID`)) `SM_ID_ROOT`'#13#10 +
                    'from `smetasourcedata` `ssd`'#13#10 +
                    'where `ssd`.`SM_ID` = :SM_ID';

  qrTMP.ParamByName('SM_ID').AsInteger := SM_ID;
  CloseOpen(qrTMP);
  SM_ID_ROOT := qrTMP.FieldByName('SM_ID_ROOT').AsInteger;

  qrTMP.Close;
  qrTMP.SQL.Text := 'select CONCAT(`oc`.`NUM`, '' '', `oc`.`NAME`) `NAME`,'#13#10 +
                    '       IFNULL(`s`.`MONAT`, 0) `MONTH`,'#13#10 +
                    '       IFNULL(`s`.`YEAR`, 0) `YEAR`,'#13#10 +
                    '       IF(`os`.`OBJ_REGION` = 3, `s`.`STAVKA_M_RAB`, `s`.`STAVKA_RB_RAB`) `TARIF`,'#13#10 +
                    '       `ssd`.`PREPARER`,'#13#10 +
                    '       `ssd`.`POST_PREPARER`,'#13#10 +
                    '       `ssd`.`EXAMINER`,'#13#10 +
                    '       `ssd`.`POST_EXAMINER`'#13#10 +
                    'from `smetasourcedata` `ssd`'#13#10 +
                    'inner join `stavka` `s` on `s`.`STAVKA_ID` = `ssd`.`STAVKA_ID`'#13#10 +
                    'inner join `objcards` `oc` on `oc`.`OBJ_ID` = `ssd`.`OBJ_ID`'#13#10 +
                    'inner join `objstroj` `os` on `os`.`STROJ_ID` = `oc`.`STROJ_ID`'#13#10 +
                    'where `ssd`.`SM_ID` = :SM_ID';
  qrTMP.ParamByName('SM_ID').AsInteger := SM_ID_ROOT;
  CloseOpen(qrTMP);

  qrZP_OBJ.ParamByName('SM_ID').AsInteger := SM_ID_ROOT;
  qrZP_OBJ.ParamByName('MONTH').AsInteger := qrTMP.FieldByName('MONTH').AsInteger;
  qrZP_OBJ.ParamByName('YEAR').AsInteger := qrTMP.FieldByName('YEAR').AsInteger;
  CloseOpen(qrZP_OBJ);

  frxReport.LoadFromFile(FileReportPath + 'frZP_OBJ.fr3');

  frxReport.Script.Variables['sm_obj_name'] := AnsiUpperCase(qrTMP.FieldByName('NAME').AsString);
  frxReport.Script.Variables['sm_date_dog'] := '1 ' + AnsiUpperCase(arraymes[qrTMP.FieldByName('MONTH').AsInteger, 2]) +
                                               ' ' + IntToStr(qrTMP.FieldByName('YEAR').AsInteger) + ' г.';
  frxReport.Script.Variables['sm_tarif'] := FormatFloat('#,##0', qrTMP.FieldByName('TARIF').AsFloat);

  frxReport.Script.Variables['preparer'] := qrTMP.FieldByName('PREPARER').AsString;
  frxReport.Script.Variables['post_preparer'] := qrTMP.FieldByName('POST_PREPARER').AsString;
  frxReport.Script.Variables['examiner'] := qrTMP.FieldByName('EXAMINER').AsString;
  frxReport.Script.Variables['post_examiner'] := qrTMP.FieldByName('POST_EXAMINER').AsString;

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
  qrTMP.SQL.Text := 'select CONCAT(`oc`.`NUM`, " ", `oc`.`NAME`) `NAME`,'#13#10 +
                    '       IFNULL(`s`.`MONAT`, 0) `MONTH`,'#13#10 +
                    '       IFNULL(`s`.`YEAR`, 0) `YEAR`,'#13#10 +
                    '       IF(`os`.`OBJ_REGION` = 3, `s`.`STAVKA_M_RAB`, `s`.`STAVKA_RB_RAB`) `TARIF`,'#13#10 +
                    '       `ca`.`NAME` `ACT_NAME`'#13#10 +
                    'from `smetasourcedata` as `ssd`'#13#10 +
                    'inner `objcards` `oc` on `oc`.`OBJ_ID` = `ssd`.`OBJ_ID`'#13#10 +
                    'inner join `objstroj` `os` on `os`.`STROJ_ID` = `oc`.`STROJ_ID`'#13#10 +
                    'inner join `stavka` `s` on `s`.`STAVKA_ID` = `ssd`.`STAVKA_ID`'#13#10 +
	          				'inner join `card_acts` `ca` on `ca`.`ID_ESTIMATE_OBJECT` = `ssd`.`SM_ID`'#13#10 +
                    'WHERE `ca`.`ID` = :ID_ACT';
  qrTMP.ParamByName('ID_ACT').AsInteger := ID_ACT;
  CloseOpen(qrTMP);

  qrZP_OBJ_ACT.ParamByName('ID_ACT').AsInteger := ID_ACT;
  qrZP_OBJ_ACT.ParamByName('MONTH').AsInteger := qrTMP.FieldByName('MONTH').AsInteger;
  qrZP_OBJ_ACT.ParamByName('YEAR').AsInteger := qrTMP.FieldByName('YEAR').AsInteger;
  CloseOpen(qrZP_OBJ_ACT);

  frxReport.LoadFromFile(FileReportPath + 'frZP_OBJ_AKT.fr3');

  frxReport.Script.Variables['act_obj_name'] := AnsiUpperCase(qrTMP.FieldByName('NAME').AsString);
  frxReport.Script.Variables['act_date_dog'] := '1 ' + AnsiUpperCase(arraymes[qrTMP.FieldByName('MONTH').AsInteger, 2]) +
                                               ' ' + IntToStr(qrTMP.FieldByName('YEAR').AsInteger) + ' г.';
  frxReport.Script.Variables['act_tarif'] := FormatFloat('#,##0', qrTMP.FieldByName('TARIF').AsFloat);
  frxReport.Script.Variables['act_number'] := qrTMP.FieldByName('ACT_NAME').AsString;
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
  qrTMP.SQL.Text := 'SELECT CONCAT(`oc`.`NUM`, " ", `oc`.`NAME`) `NAME`,'#13#10 +
                    '       IFNULL(`s`.`MONAT`, 0) `MONTH`,'#13#10 +
                    '       IFNULL(`s`.`YEAR`, 0) `YEAR`,'#13#10 +
                    '       IF(`os`.`OBJ_REGION` = 3, `s`.`STAVKA_M_RAB`, `s`.`STAVKA_RB_RAB`) `TARIF`,'#13#10 +
                    '       `ca`.`NAME` `ACT_NAME`,'#13#10 +
                    '       `d`.`DUMP_NAME`'#13#10 +
                    'FROM `smetasourcedata` `ssd`'#13#10 +
                    'inner jion `objcards` `oc` on `oc`.`OBJ_ID` = `ssd`.`OBJ_ID`'#13#10 +
                    'inner join `objstroj` `os` on `os`.`STROJ_ID` = `oc`.`STROJ_ID`'#13#10 +
                    'inner join `stavka` `s` on `s`.`STAVKA_ID` = `ssd`.`STAVKA_ID`'#13#10 +
	          				'inner join `card_acts` `ca` on `ca`.`ID_ESTIMATE_OBJECT` = `ssd`.`SM_ID`'#13#10 +
                    'left join `dump` `d` on `d`.`DUMP_ID` = `ssd`.`DUMP_ID`'#13#10 +
                    'WHERE `ca`.`ID` = :ID_ACT';
  qrTMP.ParamByName('ID_ACT').AsInteger := ID_ACT;
  CloseOpen(qrTMP);

  qrRASX_MAT.ParamByName('ID_ACT').AsInteger := ID_ACT;
  CloseOpen(qrRASX_MAT);
  qrRASX_MAT2.ParamByName('ID_ACT').AsInteger := ID_ACT;
  CloseOpen(qrRASX_MAT);

  frxReport.LoadFromFile(FileReportPath + 'frRASX_MAT.fr3');

  frxReport.Script.Variables['name_org'] := qrTMP.FieldByName('DUMP_NAME').AsString;
  frxReport.Script.Variables['name_obj'] := AnsiUpperCase(qrTMP.FieldByName('NAME').AsString);
  frxReport.Script.Variables['data_act'] := AnsiUpperCase(arraymes[qrTMP.FieldByName('MONTH').AsInteger, 1]) +
                                    ' ' + IntToStr(qrTMP.FieldByName('YEAR').AsInteger) + ' г.';

  frxReport.Script.Variables['num_act'] := qrTMP.FieldByName('ACT_NAME').AsString;
  try
    frxReport.PrepareReport;
    frxReport.ShowPreparedReport;
  except
    ShowMessage('Ошибка при формировании отчета');
  end;

  qrTMP.Close;
end;

end.
