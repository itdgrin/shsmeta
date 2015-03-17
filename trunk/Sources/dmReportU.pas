// модуль создания отчетов (Вадим)
unit dmReportU;

interface

uses
  System.SysUtils, System.Classes, frxClass, frxDBSet, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Dialogs, Tools, DateUtils,
  frxExportRTF, frxExportHTML, frxExportPDF, frxExportText, FireDAC.UI.Intf,
  FireDAC.VCLUI.Wait, FireDAC.Comp.UI;

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
    frxRSMO_OBJ: TfrxDBDataset;
    qRSMO_OBJ: TFDQuery;
    qRSMEH_OBJ: TFDQuery;
    frxRSMEH_OBJ: TfrxDBDataset;
    qVED_OANDPWV1: TFDQuery;
    frxqVED_OANDPWV1: TfrxDBDataset;

    qVED_OBRAB_RASHRES_SMET: TFDQuery;
    frxVED_OBRAB_RASHRES_SMET: TfrxDBDataset;    
    qrSMETA_OBJ_E: TFDQuery;
    frxSMETA_OBJ_E: TfrxDBDataset;
    qrSMETA_OBJ_MAT: TFDQuery;
    frxSMETA_OBJ_MAT: TfrxDBDataset;
    qrSMETA_OBJ_MEH: TFDQuery;
    frxSMETA_OBJ_MEH: TfrxDBDataset;
    qrSMETA_OBJ_DEV: TFDQuery;
    frxSMETA_OBJ_DEV: TfrxDBDataset;
    FDGUIxWaitCursor: TFDGUIxWaitCursor;
    frxSMETA_OBJ_GraphC: TfrxDBDataset;
    qrSMETA_OBJ_GraphC: TFDQuery;  private
   { Private decla
    FDQuery1: TFDQuery;rations }
  public
    { Public declarations }
    procedure Report_ZP_OBJ(SM_ID: integer; FileReportPath: string);
    procedure Report_ZP_OBJ_ACT(ID_ACT: integer; FileReportPath: string);
    procedure Report_RASX_MAT(ID_ACT: integer; FileReportPath: string);
    procedure Report_WINTER_RS_OBJ(SM_ID: integer; FileReportPath: string);
    procedure Report_RSMO_OBJ(  with_nds,SM_ID: integer;OBJ_ID: integer; FileReportPath: string);
    procedure Report_RSMEH_OBJ( with_nds,SM_ID: integer;OBJ_ID: integer; FileReportPath: string);
    procedure Report_RSDEV_OBJ( with_nds,SM_ID: integer;OBJ_ID: integer; FileReportPath: string);
    procedure Report_VED_OANDPWV1_OBJ(xvar,with_nds,OBJ_ID: integer; FileReportPath: string);       //ВЕДОМОСТЬ ОБЪЁМОВ И СТОИМОСТИ РАБОТ
    procedure Report_VED_OBRAB_RASHRES_SMET_OBJ( SM_ID: integer;FileReportPath: string);            //Ведомость объемов работ и расхода ресурсов по смете v1.02
    procedure Report_SMETA_OBJ_BUILD(SM_ID: integer; FileReportPath: string); // "СМЕТА по объекту строительства" v1.03
  end;

var
  dmReportF: TdmReportF;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

Uses DataModule, GlobsAndConst;

 // vk зимнее удорожание
procedure TdmReportF.Report_WINTER_RS_OBJ(SM_ID: integer; FileReportPath: string);
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

// vk Расчет стоимости материалов по объекту
procedure TdmReportF.Report_RSMO_OBJ(with_nds,SM_ID: integer;OBJ_ID: integer; FileReportPath: string);
begin

if with_nds = 0 then frxReport.LoadFromFile(FileReportPath + 'frRSMO_OBJ.fr3');
if with_nds = 1 then frxReport.LoadFromFile(FileReportPath + 'frRSMO_NDS_OBJ.fr3');

qrTMP.SQL.Text :=  'select 	CONCAT(`oc`.`NUM`, " ", `oc`.`NAME`) `NAME`,'#13#10 +
                  '		IFNULL(`s`.`MONAT`, 0) `MONTH`,'#13#10 +
                  '		IFNULL(`s`.`YEAR`, 0) `YEAR`'#13#10 +
                  'from `smetasourcedata` as `ssd`'#13#10 +
                  'inner join`objcards` `oc` on `oc`.`OBJ_ID` = `ssd`.`OBJ_ID`'#13#10 +
                  'inner join `objstroj` `os` on `os`.`STROJ_ID` = `oc`.`STROJ_ID`'#13#10 +
                  'inner join `stavka` `s` on `s`.`STAVKA_ID` = `ssd`.`STAVKA_ID`'#13#10 +
                  'where (:SM_ID is null or `ssd`.`SM_ID` = :SM_ID) and (:OBJ_ID is null or `ssd`.`OBJ_ID` = :OBJ_ID)'#13#10 ;

with qrTMP.ParamByName('SM_ID') do begin
DataType := ftInteger;
Clear;
end;
with qrTMP.ParamByName('OBJ_ID') do begin
DataType := ftInteger;
Clear;
end;
//qrTMP.ParamByName('ID_ACT').AsInteger := ID_ACT;
CloseOpen(qrTMP);

qRSMO_OBJ.SQL.Text:=
' select '#13#10 +
'     `Mat_code`,'#13#10 +
'     `mat_name`,'#13#10 +
'     `mat_unit`,'#13#10 +
'     sum(`mat_count`) as `mat_count`,'#13#10 +
'     `coast_no_nds` 	 as `coast_no_nds` ,'#13#10 +
'     sum(`MAT_SUM_NO_NDS`) as `MAT_SUM_NO_NDS`,'#13#10 +
'     `proc_transp`as `proc_transp`,'#13#10 +
'     sum(`TRANSP_NO_NDS`)  as `coast_transp`,'#13#10 +
'     `materialcard`.`NDS`,'#13#10 +
'     sum(`MAT_SUM_NO_NDS`*(1+`materialcard`.`NDS`/100)) as `NDS_RUB`,'#13#10 +
'     sum(`TRANSP_NDS`)  as `transp_nds`,'#13#10 +
'     sum(`MAT_SUM_NDS`) as `MAT_SUM_NDS`'#13#10 +
' from materialcard '#13#10 +
' left join  card_rate on card_rate.id = materialcard.ID_CARD_RATE'#13#10 +
' left join  data_estimate on ID_TABLES = card_rate.id'#13#10 +
' left join  smetasourcedata on  smetasourcedata.sm_id = data_estimate.ID_ESTIMATE '#13#10 +
' where `materialcard`.`CONSIDERED` = 1 and  (:SM_ID is null or `smetasourcedata`.`SM_ID` = :SM_ID) and (:OBJ_ID is null or `smetasourcedata`.`OBJ_ID` = :OBJ_ID)'#13#10 +
' group by  `mat_code`,`mat_name`,`mat_unit`,`coast_no_nds`,`proc_transp`'#13#10 +
' order by `mat_code`' ;

  with qRSMO_OBJ.ParamByName('SM_ID') do begin
  DataType := ftInteger;
  Clear;
  end;
  with qRSMO_OBJ.ParamByName('OBJ_ID') do begin
  DataType := ftInteger;
  Clear;
  end;

  if SM_ID>0  then  qRSMO_OBJ.ParamByName('SM_ID').AsInteger  := SM_ID;
  if OBJ_ID>0 then  qRSMO_OBJ.ParamByName('OBJ_ID').AsInteger := OBJ_ID;
  CloseOpen(qRSMO_OBJ);

  frxReport.Script.Variables['sm_obj_name'] := AnsiUpperCase(qrTMP.FieldByName('NAME').AsString);
  frxReport.Script.Variables['sm_date_dog'] := '1 ' + AnsiUpperCase(arraymes[qrTMP.FieldByName('MONTH').AsInteger, 2]) +
   ' ' + IntToStr(qrTMP.FieldByName('YEAR').AsInteger) + ' г.';
  try
    frxReport.PrepareReport;
    frxReport.ShowPreparedReport;
  except
    ShowMessage('Ошибка при формировании отчета');
  end;


end;

// vk Расчет стоимости механизмов по объекту
 procedure TdmReportF.Report_RSMEH_OBJ(with_nds,SM_ID: integer;OBJ_ID: integer; FileReportPath: string);
begin

if with_nds = 0 then frxReport.LoadFromFile(FileReportPath + 'frRSMEH_OBJ.fr3');
if with_nds = 1 then frxReport.LoadFromFile(FileReportPath + 'frRSMEH_NDS_OBJ.fr3');

qrTMP.SQL.Text :=  'select 	CONCAT(`oc`.`NUM`, " ", `oc`.`NAME`) `NAME`,'#13#10 +
                  '		IFNULL(`s`.`MONAT`, 0) `MONTH`,'#13#10 +
                  '		IFNULL(`s`.`YEAR`, 0) `YEAR`'#13#10 +
                  'from `smetasourcedata` as `ssd`'#13#10 +
                  'inner join`objcards` `oc` on `oc`.`OBJ_ID` = `ssd`.`OBJ_ID`'#13#10 +
                  'inner join `objstroj` `os` on `os`.`STROJ_ID` = `oc`.`STROJ_ID`'#13#10 +
                  'inner join `stavka` `s` on `s`.`STAVKA_ID` = `ssd`.`STAVKA_ID`'#13#10 +
                  'where (:SM_ID is null or `ssd`.`SM_ID` = :SM_ID) and (:OBJ_ID is null or `ssd`.`OBJ_ID` = :OBJ_ID)'#13#10 ;

with qrTMP.ParamByName('SM_ID') do begin
DataType := ftInteger;
Clear;
end;
with qrTMP.ParamByName('OBJ_ID') do begin
DataType := ftInteger;
Clear;
end;
//qrTMP.ParamByName('ID_ACT').AsInteger := ID_ACT;
CloseOpen(qrTMP);

qRSMEH_OBJ.SQL.Text:=
' select '#13#10 +
'     `mech_code`,'#13#10 +
'     `mech_name`,'#13#10 +
'     `mech_unit`,'#13#10 +
'     sum(`mech_count`) as `mech_count`,'#13#10 +
'     `coast_no_nds` 	 as `coast_no_nds` ,'#13#10 +
'     sum(`mech_SUM_NO_NDS`) as `SUM_NO_NDS`,'#13#10 +
'     sum(`mech_ZPSUM_NO_NDS`) as `ZP_SUM_NO_NDS`,'#13#10 +
'     `mechanizmcard`.`NDS`,'#13#10 +
'     `mechanizmcard`.`ZP_MACH_NO_NDS`,'#13#10 +
'     sum(`mech_SUM_NO_NDS`*(1+`mechanizmcard`.`NDS`/100)) as `NDS_RUB`,'#13#10 +
'     sum(`mech_SUM_NDS`) as `SUM_NDS`'#13#10 +
' from mechanizmcard '#13#10 +
' left join  card_rate on card_rate.id = mechanizmcard.ID_CARD_RATE'#13#10 +
' left join  data_estimate on ID_TABLES = card_rate.id'#13#10 +
' left join  smetasourcedata on  smetasourcedata.sm_id = data_estimate.ID_ESTIMATE '#13#10 +
' where (:SM_ID is null or `smetasourcedata`.`SM_ID` = :SM_ID) and (:OBJ_ID is null or `smetasourcedata`.`OBJ_ID` = :OBJ_ID)'#13#10 +
' group by  `mech_code`,`mech_name`,`mech_unit`,`NDS`,`ZP_MACH_NO_NDS`'#13#10 +
' order by `mech_code`' ;



  with qRSMEH_OBJ.ParamByName('SM_ID') do begin
  DataType := ftInteger;
  Clear;
  end;
  with qRSMEH_OBJ.ParamByName('OBJ_ID') do begin
  DataType := ftInteger;
  Clear;
  end;

  if SM_ID>0  then  qRSMEH_OBJ.ParamByName('SM_ID').AsInteger  := SM_ID;
  if OBJ_ID>0 then  qRSMEH_OBJ.ParamByName('OBJ_ID').AsInteger := OBJ_ID;
  CloseOpen(qRSMEH_OBJ);

  frxReport.Script.Variables['sm_obj_name'] := AnsiUpperCase(qrTMP.FieldByName('NAME').AsString);
  frxReport.Script.Variables['sm_date_dog'] := '1 ' + AnsiUpperCase(arraymes[qrTMP.FieldByName('MONTH').AsInteger, 2]) +
   ' ' + IntToStr(qrTMP.FieldByName('YEAR').AsInteger) + ' г.';
  try
    frxReport.PrepareReport;
    frxReport.ShowPreparedReport;
  except
    ShowMessage('Ошибка при формировании отчета');
  end;


end;

// vk Расчет стоимости оборудования по объекту
procedure TdmReportF.Report_RSDEV_OBJ(with_nds,SM_ID: integer;OBJ_ID: integer; FileReportPath: string);
begin

if with_nds = 0 then frxReport.LoadFromFile(FileReportPath + 'frRSMEH_OBJ.fr3');
if with_nds = 1 then frxReport.LoadFromFile(FileReportPath + 'frRSMEH_NDS_OBJ.fr3');

qrTMP.SQL.Text :=  'select 	CONCAT(`oc`.`NUM`, " ", `oc`.`NAME`) `NAME`,'#13#10 +
                  '		IFNULL(`s`.`MONAT`, 0) `MONTH`,'#13#10 +
                  '		IFNULL(`s`.`YEAR`, 0) `YEAR`'#13#10 +
                  'from `smetasourcedata` as `ssd`'#13#10 +
                  'inner join`objcards` `oc` on `oc`.`OBJ_ID` = `ssd`.`OBJ_ID`'#13#10 +
                  'inner join `objstroj` `os` on `os`.`STROJ_ID` = `oc`.`STROJ_ID`'#13#10 +
                  'inner join `stavka` `s` on `s`.`STAVKA_ID` = `ssd`.`STAVKA_ID`'#13#10 +
                  'where (:SM_ID is null or `ssd`.`SM_ID` = :SM_ID) and (:OBJ_ID is null or `ssd`.`OBJ_ID` = :OBJ_ID)'#13#10 ;

with qrTMP.ParamByName('SM_ID') do begin
DataType := ftInteger;
Clear;
end;
with qrTMP.ParamByName('OBJ_ID') do begin
DataType := ftInteger;
Clear;
end;
//qrTMP.ParamByName('ID_ACT').AsInteger := ID_ACT;
CloseOpen(qrTMP);

qRSMEH_OBJ.SQL.Text:=
' select '#13#10 +
'     `mech_code`,'#13#10 +
'     `mech_name`,'#13#10 +
'     `mech_unit`,'#13#10 +
'     sum(`mech_count`) as `mech_count`,'#13#10 +
'     `coast_no_nds` 	 as `coast_no_nds` ,'#13#10 +
'     sum(`mech_SUM_NO_NDS`) as `SUM_NO_NDS`,'#13#10 +
'     sum(`mech_ZPSUM_NO_NDS`) as `ZP_SUM_NO_NDS`,'#13#10 +
'     `mechanizmcard`.`NDS`,'#13#10 +
'     `mechanizmcard`.`ZP_MACH_NO_NDS`,'#13#10 +
'     sum(`mech_SUM_NO_NDS`*(1+`mechanizmcard`.`NDS`/100)) as `NDS_RUB`,'#13#10 +
'     sum(`mech_SUM_NDS`) as `SUM_NDS`'#13#10 +
' from mechanizmcard '#13#10 +
' left join  card_rate on card_rate.id = mechanizmcard.ID_CARD_RATE'#13#10 +
' left join  data_estimate on ID_TABLES = card_rate.id'#13#10 +
' left join  smetasourcedata on  smetasourcedata.sm_id = data_estimate.ID_ESTIMATE '#13#10 +
' where (:SM_ID is null or `smetasourcedata`.`SM_ID` = :SM_ID) and (:OBJ_ID is null or `smetasourcedata`.`OBJ_ID` = :OBJ_ID)'#13#10 +
' group by  `mech_code`,`mech_name`,`mech_unit`,`NDS`,`ZP_MACH_NO_NDS`'#13#10 +
' order by `mech_code`' ;



  with qRSMEH_OBJ.ParamByName('SM_ID') do begin
  DataType := ftInteger;
  Clear;
  end;
  with qRSMEH_OBJ.ParamByName('OBJ_ID') do begin
  DataType := ftInteger;
  Clear;
  end;

  if SM_ID>0  then  qRSMEH_OBJ.ParamByName('SM_ID').AsInteger  := SM_ID;
  if OBJ_ID>0 then  qRSMEH_OBJ.ParamByName('OBJ_ID').AsInteger := OBJ_ID;
  CloseOpen(qRSMEH_OBJ);

  frxReport.Script.Variables['sm_obj_name'] := AnsiUpperCase(qrTMP.FieldByName('NAME').AsString);
  frxReport.Script.Variables['sm_date_dog'] := '1 ' + AnsiUpperCase(arraymes[qrTMP.FieldByName('MONTH').AsInteger, 2]) +
   ' ' + IntToStr(qrTMP.FieldByName('YEAR').AsInteger) + ' г.';
  try
    frxReport.PrepareReport;
    frxReport.ShowPreparedReport;
  except
    ShowMessage('Ошибка при формировании отчета');
  end;


end;

// vk ВЕДОМОСТЬ ОБЪЁМОВ И СТОИМОСТИ РАБОТ вариант-1
 procedure TdmReportF.Report_VED_OANDPWV1_OBJ(xvar,with_nds,OBJ_ID: integer; FileReportPath: string);
begin

//if with_nds = 0 then frxReport.LoadFromFile(FileReportPath + 'frRSMEH_OBJ.fr3');
//if with_nds = 1 then frxReport.LoadFromFile(FileReportPath + 'frRSMEH_NDS_OBJ.fr3');

if xvar = 1 then frxReport.LoadFromFile(FileReportPath + 'frOANDPWV1_OBJ.fr3');
if xvar = 2 then frxReport.LoadFromFile(FileReportPath + 'frVOSR_OBJ.fr3');

qrTMP.SQL.Text :=  'select 		`ssd`.`sm_id`,CONCAT(`oc`.`NUM`, " ", `oc`.`NAME`) `NAME`,'#13#10 +
                  '		IFNULL(`s`.`MONAT`, 0) `MONTH`,'#13#10 +
                  '		IFNULL(`s`.`YEAR`, 0) `YEAR`'#13#10 +
                  'from `smetasourcedata` as `ssd`'#13#10 +
                  'inner join`objcards` `oc` on `oc`.`OBJ_ID` = `ssd`.`OBJ_ID`'#13#10 +
                  'inner join `objstroj` `os` on `os`.`STROJ_ID` = `oc`.`STROJ_ID`'#13#10 +
                  'inner join `stavka` `s` on `s`.`STAVKA_ID` = `ssd`.`STAVKA_ID`'#13#10 +
                  'where  (:OBJ_ID is null or `ssd`.`OBJ_ID` = :OBJ_ID)  and sm_type=2 '#13#10 ;

qrTMP.ParamByName('OBJ_ID').AsInteger := OBJ_ID;
CloseOpen(qrTMP);

qVED_OANDPWV1.SQL.Text:=
' SELECT'#13#10 +
' smetasourcedata.sm_id,'#13#10 +
' smetasourcedata.SM_NUMBER,'#13#10 +
' NAME,'#13#10 +
' NAME_O,'#13#10 +
' NAME_L,'#13#10 +
' SM_VID,'#13#10 +
' S_TRUD,'#13#10 +
' ROUND(S_ZP/100) as S_ZP,'#13#10 +
' S_TRUD_MASH,'#13#10 +
' ROUND(S_EMiM/1000) as S_EMiM,'#13#10 +
' ROUND(S_ZP_MASH/1000) as S_ZP_MASH,'#13#10 +
' ROUND(S_MR/1000) as S_MR,'#13#10 +
' ROUND(S_TRANSP/1000) as S_TRANSP,'#13#10 +
' ROUND(S_OHROPR/1000) as S_OHROPR,'#13#10 +
' ROUND(S_ST_OHROPR/1000) as S_ST_OHROPR,'#13#10 +
' ROUND(S_PLAN_PRIB/1000) as S_PLAN_PRIB,'#13#10 +
' ROUND(S_STOIM/1000) as S_STOIM,'#13#10 +
' PARENT_ID '#13#10 +
' FROM smeta.smetasourcedata'#13#10 +
' left join (SELECT  ssd.SM_ID, ssd.OBJ_ID, 0 as SM_VID,'#13#10 +
' CONCAT(ssd.SM_NUMBER, " ",  ssd.NAME) as NAME_O, "" AS NAME_L '#13#10 +
' FROM smetasourcedata ssd'#13#10 +
' WHERE ssd.SM_ID = :SM_ID '#13#10 +
' AND ssd.SM_TYPE = 2'#13#10 +
' UNION'#13#10 +
''#13#10 +
'SELECT ssd_local.SM_ID, ssd_local.OBJ_ID, 1 as SM_VID,'#13#10 +
'CONCAT(ssd.SM_NUMBER, " ",  ssd.NAME) as NAME_O, CONCAT(ssd_local.SM_NUMBER, " ",  ssd_local.NAME) as NAME_L'#13#10 +
'FROM smetasourcedata ssd_local'#13#10 +
'JOIN smetasourcedata ssd ON ssd.SM_ID = ssd_local.PARENT_ID'#13#10 +
'				AND ssd.SM_TYPE = 2'#13#10 +
'WHERE ssd_local.PARENT_ID = :SM_ID'#13#10 +
'AND ssd_local.SM_TYPE = 1'#13#10 +
'UNION'#13#10 +
''#13#10 +
'SELECT ssd_ptm.SM_ID, ssd_ptm.OBJ_ID,  2 as SM_VID, '#13#10 +
'CONCAT(ssd.SM_NUMBER, " ",  ssd.NAME) as NAME_O, CONCAT(ssd_local.SM_NUMBER, " ",  ssd_local.NAME) as NAME_L'#13#10 +
'FROM smetasourcedata ssd_ptm'#13#10 +
'JOIN smetasourcedata ssd_local ON ssd_local.SM_ID = ssd_ptm.PARENT_ID '#13#10 +
'					  AND ssd_local.SM_TYPE = 1'#13#10 +
'					  AND ssd_local.PARENT_ID = :SM_ID'#13#10 +
'JOIN smetasourcedata ssd ON ssd.SM_ID = ssd_local.PARENT_ID'#13#10 +
'				AND ssd.SM_TYPE = 2'#13#10 +
'WHERE ssd_ptm.SM_TYPE = 3'#13#10 +
'ORDER BY SM_VID) as  cr_nam on cr_nam.sm_id = smetasourcedata.sm_id'#13#10 +
'where sm_vid>1'#13#10 +
'order by SM_ID,PARENT_ID' ;


qVED_OANDPWV1.ParamByName('SM_ID').AsInteger := qrTMP.FieldByName('SM_ID').AsInteger ;
CloseOpen(qVED_OANDPWV1);

  frxReport.Script.Variables['sm_obj_name'] := AnsiUpperCase(qrTMP.FieldByName('NAME').AsString);
  frxReport.Script.Variables['sm_date_dog'] := '1 ' + AnsiUpperCase(arraymes[qrTMP.FieldByName('MONTH').AsInteger, 2]) +
   ' ' + IntToStr(qrTMP.FieldByName('YEAR').AsInteger) + ' г.';
  try
    frxReport.PrepareReport;
    frxReport.ShowPreparedReport;
  except
    ShowMessage('Ошибка при формировании отчета');
  end;


end;

//vk Ведомость объемов работ и расхода ресурсов по смете
procedure TdmReportF.Report_VED_OBRAB_RASHRES_SMET_OBJ( SM_ID: integer;FileReportPath: string);
begin
 frxReport.LoadFromFile(FileReportPath + 'frVED_OBRAB_RASHRES_SMET_OBJ.fr3');

 qrTMP.SQL.Text :=  'select `SM_TYPE`'#13#10 +
                    'from `smetasourcedata` ssd'#13#10 +
                    'where (`ssd`.`SM_ID` = :SM_ID)'#13#10 ;

 qrTMP.ParamByName('SM_ID').AsInteger := SM_ID ;
 CloseOpen(qrTMP);

if qRTMP.FieldByName('SM_TYPE').AsInteger =2 then
qVED_OBRAB_RASHRES_SMET.SQL.Text:=
' SELECT * FROM '#13#10 +
' ('#13#10 +
' SELECT'#13#10 +
' `ssd`.`sm_id`  as `sm_id1`,'#13#10 +
' `ssd1`.`sm_id` as `sm_id2`,'#13#10 +
' `ssd2`.`sm_id` as `sm_id3`,'#13#10 +
' `ssd`.`name`  as `name`,'#13#10 +
' `ssd1`.`name` as `name_o`,'#13#10 +
' `ssd2`.`name` as `name_l`,'#13#10 +
' `ssd`.`sm_number` as `sm_number`,'#13#10 +
' `ssd1`.`sm_number` as `sm_number1`,'#13#10 +
' `ssd2`.`sm_number` as `sm_number2`,'#13#10 +
' `mtc`.`MAT_CODE`,   '#13#10 +
' UCASE(`mtc`.`MAT_NAME`) as `MAT_NAME`,'#13#10 +
' `mtc`.`MAT_UNIT`,'#13#10 +
' sum(`mtc`.`MAT_COUNT`) as MAT_COUNT'#13#10 +
' FROM `smetasourcedata` `ssd`'#13#10 +
' INNER JOIN `smetasourcedata` `ssd1` ON `ssd1`.`PARENT_ID` = `ssd`.`SM_ID`  AND `ssd1`.`SM_TYPE` = 1'#13#10 +
' INNER JOIN `smetasourcedata` `ssd2` ON `ssd2`.`PARENT_ID` = `ssd1`.`SM_ID` AND `ssd2`.`SM_TYPE` = 3'#13#10 +
' INNER JOIN `data_estimate` `de` ON `de`.`ID_ESTIMATE` = `ssd2`.`SM_ID`     AND `de`.`ID_TYPE_DATA` IN (1, 2, 5) '#13#10 +
' INNER JOIN `card_rate` `cr` ON `cr`.`ID` = `de`.`ID_TABLES`'#13#10 +
' INNER JOIN `materialcard` `mtc` ON `mtc`.`ID_CARD_RATE` = `cr`.`ID`'#13#10 +
' WHERE `ssd`.`SM_ID` = :SM_ID  AND `ssd`.`SM_TYPE` = 2   '#13#10 +
' group by `sm_id3`,`MAT_CODE` '#13#10 +
' union'#13#10 +
' SELECT'#13#10 +
' `ssd`.`sm_id`  as `sm_id1`, '#13#10 +
' `ssd1`.`sm_id` as `sm_id2`,'#13#10 +
' `ssd2`.`sm_id` as `sm_id3`, '#13#10 +
' `ssd`.`name`  as `name`,'#13#10 +
' `ssd1`.`name` as `name_o`, '#13#10 +
' `ssd2`.`name` as `name_l`,'#13#10 +
' `ssd`.`sm_number` as `sm_number`,'#13#10 +
' `ssd1`.`sm_number` as `sm_number1`,  '#13#10 +
' `ssd2`.`sm_number` as `sm_number2`,'#13#10 +
' "1-1" as `MAT_CODE`,  '#13#10 +
' "ЗАТРАТЫ ТРУДА РАБОЧИХ-СТРОИТЕЛЕЙ" as MAT_NAME, '#13#10 +
' "чел/ч" as `MAT_UNIT`,  '#13#10 +
' `ssd2`.`s_trud` as `MAT_COUNT`'#13#10 +
' FROM `smetasourcedata` `ssd` '#13#10 +
' inner JOIN `smetasourcedata` `ssd1` ON `ssd1`.`PARENT_ID` = `ssd`.`SM_ID`'#13#10 +
' inner JOIN `smetasourcedata` `ssd2` ON `ssd2`.`PARENT_ID` = `ssd1`.`SM_ID`'#13#10 +
' where `ssd`.`sm_id`= :SM_ID '#13#10 +
' union  '#13#10 +
' SELECT '#13#10 +
' `ssd`.`sm_id`  as `sm_id1`,'#13#10 +
' `ssd1`.`sm_id` as `sm_id2`, '#13#10 +
' `ssd2`.`sm_id` as `sm_id3`,'#13#10 +
' `ssd`.`name`  as `name`, '#13#10 +
' `ssd1`.`name` as `name_o`, '#13#10 +
' `ssd2`.`name` as `name_l`, '#13#10 +
' `ssd`.`sm_number` as `sm_number`, '#13#10 +
' `ssd1`.`sm_number` as `sm_number1`,'#13#10 +
' `ssd2`.`sm_number` as `sm_number2`, '#13#10 +
' "1-3" as MAT_CODE, '#13#10 +
' "ЗАТРАТЫ ТРУДА МАШИНИСТОВ" as `MAT_NAME`, '#13#10 +
' "чел/ч" as `MAT_UNIT`,'#13#10 +
' ssd2.s_trud_mash as `MAT_COUNT` '#13#10 +
' FROM `smetasourcedata` `ssd`'#13#10 +
' inner JOIN `smetasourcedata` `ssd1` ON `ssd1`.`PARENT_ID` = `ssd`.`SM_ID`'#13#10 +
' inner JOIN `smetasourcedata` `ssd2` ON `ssd2`.`PARENT_ID` = `ssd1`.`SM_ID`'#13#10 +
' where `ssd`.`sm_id`= :SM_ID '#13#10 +
' union  '#13#10 +
' SELECT '#13#10 +
' `ssd`.`sm_id`  as `sm_id1`, '#13#10 +
' `ssd1`.`sm_id` as `sm_id2`,'#13#10 +
' `ssd2`.`sm_id` as `sm_id3`,'#13#10 +
' `ssd`.`name`  as `name`, '#13#10 +
' `ssd1`.`name` as `name_o`,'#13#10 +
' `ssd2`.`name` as `name_l`,'#13#10 +
' `ssd`.`sm_number` as `sm_number`,'#13#10 +
' `ssd1`.`sm_number` as `sm_number1`,'#13#10 +
' `ssd2`.`sm_number` as `sm_number2`, '#13#10 +
' `mch`.`MECH_CODE` as `MAT_CODE`, '#13#10 +
' UCASE(`mch`.`MECH_NAME`) as `MAT_NAME`, '#13#10 +
' `mch`.`MECH_UNIT`,   '#13#10 +
' sum(`mch`.`MECH_COUNT`) as `MAT_COUNT` '#13#10 +
' FROM `smetasourcedata` `ssd`'#13#10 +
' INNER JOIN `smetasourcedata` `ssd1` ON `ssd1`.`PARENT_ID` = `ssd`.`SM_ID`  AND `ssd1`.`SM_TYPE` = 1 '#13#10 +
' INNER JOIN `smetasourcedata` `ssd2` ON `ssd2`.`PARENT_ID` = `ssd1`.`SM_ID` AND `ssd2`.`SM_TYPE` = 3  '#13#10 +
' INNER JOIN `data_estimate` `de` ON `de`.`ID_ESTIMATE` = `ssd2`.`SM_ID`     AND `de`.`ID_TYPE_DATA` IN (1, 2, 5) '#13#10 +
' INNER JOIN `card_rate` `cr` ON `cr`.`ID` = `de`.`ID_TABLES` '#13#10 +
' INNER JOIN `mechanizmcard` `mch` ON `mch`.`ID_CARD_RATE` = `cr`.`ID` '#13#10 +
' WHERE `ssd`.`SM_ID` =  :SM_ID   AND `ssd`.`SM_TYPE` = 2   '#13#10 +
' group by `sm_id3`,`MECH_CODE` ) sm  order by `sm_id2`,`sm_id3`,`MAT_CODE`;';


if qRTMP.FieldByName('SM_TYPE').AsInteger =1 then
qVED_OBRAB_RASHRES_SMET.SQL.Text:=
' SELECT * FROM '#13#10 +
' ('#13#10 +
' SELECT'#13#10 +
' 0  as `sm_id1`,'#13#10 +
' `ssd1`.`sm_id` as `sm_id2`,'#13#10 +
' `ssd2`.`sm_id` as `sm_id3`,'#13#10 +
' ""  as `name`,'#13#10 +
' `ssd1`.`name` as `name_o`,'#13#10 +
' `ssd2`.`name` as `name_l`,'#13#10 +
' "" as `sm_number`,'#13#10 +
' `ssd1`.`sm_number` as `sm_number1`,'#13#10 +
' `ssd2`.`sm_number` as `sm_number2`,'#13#10 +
' `mtc`.`MAT_CODE`,   '#13#10 +
' UCASE(`mtc`.`MAT_NAME`) as `MAT_NAME`,'#13#10 +
' `mtc`.`MAT_UNIT`,'#13#10 +
' sum(`mtc`.`MAT_COUNT`) as MAT_COUNT'#13#10 +
' FROM `smetasourcedata` `ssd1`'#13#10 +
' INNER JOIN `smetasourcedata` `ssd2` ON `ssd2`.`PARENT_ID` = `ssd1`.`SM_ID` AND `ssd2`.`SM_TYPE` = 3'#13#10 +
' INNER JOIN `data_estimate` `de` ON `de`.`ID_ESTIMATE` = `ssd2`.`SM_ID`     AND `de`.`ID_TYPE_DATA` IN (1, 2, 5) '#13#10 +
' INNER JOIN `card_rate` `cr` ON `cr`.`ID` = `de`.`ID_TABLES`'#13#10 +
' INNER JOIN `materialcard` `mtc` ON `mtc`.`ID_CARD_RATE` = `cr`.`ID`'#13#10 +
' WHERE `ssd1`.`SM_ID` = :SM_ID  AND `ssd1`.`SM_TYPE` = 1   '#13#10 +
' group by `sm_id3`,`MAT_CODE` '#13#10 +
' union'#13#10 +
' SELECT'#13#10 +
' 0  as `sm_id1`, '#13#10 +
' `ssd1`.`sm_id` as `sm_id2`,'#13#10 +
' `ssd2`.`sm_id` as `sm_id3`, '#13#10 +
' "" as `name`,'#13#10 +
' `ssd1`.`name` as `name_o`, '#13#10 +
' `ssd2`.`name` as `name_l`,'#13#10 +
' "" as `sm_number`,'#13#10 +
' `ssd1`.`sm_number` as `sm_number1`,  '#13#10 +
' `ssd2`.`sm_number` as `sm_number2`,'#13#10 +
' "1-1" as `MAT_CODE`,  '#13#10 +
' "ЗАТРАТЫ ТРУДА РАБОЧИХ-СТРОИТЕЛЕЙ" as MAT_NAME, '#13#10 +
' "чел/ч" as `MAT_UNIT`,  '#13#10 +
' `ssd2`.`s_trud` as `MAT_COUNT`'#13#10 +
' FROM `smetasourcedata` `ssd1` '#13#10 +
' inner JOIN `smetasourcedata` `ssd2` ON `ssd2`.`PARENT_ID` = `ssd1`.`SM_ID`'#13#10 +
' where `ssd1`.`sm_id`= :SM_ID '#13#10 +
' union  '#13#10 +
' SELECT '#13#10 +
' 0  as `sm_id1`,'#13#10 +
' `ssd1`.`sm_id` as `sm_id2`, '#13#10 +
' `ssd2`.`sm_id` as `sm_id3`,'#13#10 +
' ""  as `name`, '#13#10 +
' `ssd1`.`name` as `name_o`, '#13#10 +
' `ssd2`.`name` as `name_l`, '#13#10 +
' "" as `sm_number`, '#13#10 +
' `ssd1`.`sm_number` as `sm_number1`,'#13#10 +
' `ssd2`.`sm_number` as `sm_number2`, '#13#10 +
' "1-3" as MAT_CODE, '#13#10 +
' "ЗАТРАТЫ ТРУДА МАШИНИСТОВ" as `MAT_NAME`, '#13#10 +
' "чел/ч" as `MAT_UNIT`,'#13#10 +
' ssd2.s_trud_mash as `MAT_COUNT` '#13#10 +
' FROM `smetasourcedata` `ssd1`'#13#10 +
' inner JOIN `smetasourcedata` `ssd2` ON `ssd2`.`PARENT_ID` = `ssd1`.`SM_ID`'#13#10 +
' where `ssd1`.`sm_id`= :SM_ID '#13#10 +
' union  '#13#10 +
' SELECT '#13#10 +
' 0 as `sm_id1`, '#13#10 +
' `ssd1`.`sm_id` as `sm_id2`,'#13#10 +
' `ssd2`.`sm_id` as `sm_id3`,'#13#10 +
' ""  as `name`, '#13#10 +
' `ssd1`.`name` as `name_o`,'#13#10 +
' `ssd2`.`name` as `name_l`,'#13#10 +
' "" as `sm_number`,'#13#10 +
' `ssd1`.`sm_number` as `sm_number1`,'#13#10 +
' `ssd2`.`sm_number` as `sm_number2`, '#13#10 +
' `mch`.`MECH_CODE` as `MAT_CODE`, '#13#10 +
' UCASE(`mch`.`MECH_NAME`) as `MAT_NAME`, '#13#10 +
' `mch`.`MECH_UNIT`,   '#13#10 +
' sum(`mch`.`MECH_COUNT`) as `MAT_COUNT` '#13#10 +
' FROM `smetasourcedata` `ssd1`'#13#10 +
' INNER JOIN `smetasourcedata` `ssd2` ON `ssd2`.`PARENT_ID` = `ssd1`.`SM_ID` AND `ssd2`.`SM_TYPE` = 3  '#13#10 +
' INNER JOIN `data_estimate` `de` ON `de`.`ID_ESTIMATE` = `ssd2`.`SM_ID`     AND `de`.`ID_TYPE_DATA` IN (1, 2, 5) '#13#10 +
' INNER JOIN `card_rate` `cr` ON `cr`.`ID` = `de`.`ID_TABLES` '#13#10 +
' INNER JOIN `mechanizmcard` `mch` ON `mch`.`ID_CARD_RATE` = `cr`.`ID` '#13#10 +
' WHERE `ssd1`.`SM_ID` =  :SM_ID   AND `ssd1`.`SM_TYPE` = 1   '#13#10 +
' group by `sm_id3`,`MECH_CODE` ) sm  order by `sm_id2`,`sm_id3`,`MAT_CODE`;';



if qRTMP.FieldByName('SM_TYPE').AsInteger =3 then
qVED_OBRAB_RASHRES_SMET.SQL.Text:=
' SELECT * FROM '#13#10 +
' ('#13#10 +
' SELECT'#13#10 +
' 0  as `sm_id1`,'#13#10 +
' 0 as `sm_id2`,'#13#10 +
' `ssd2`.`sm_id` as `sm_id3`,'#13#10 +
' ""  as `name`,'#13#10 +
' `ssd2`.`name` as `name_o`,'#13#10 +
' `ssd2`.`name` as `name_l`,'#13#10 +
' "" as `sm_number`,'#13#10 +
' `ssd2`.`sm_number` as `sm_number1`,'#13#10 +
' `ssd2`.`sm_number` as `sm_number2`,'#13#10 +
' `mtc`.`MAT_CODE`,   '#13#10 +
' UCASE(`mtc`.`MAT_NAME`) as `MAT_NAME`,'#13#10 +
' `mtc`.`MAT_UNIT`,'#13#10 +
' sum(`mtc`.`MAT_COUNT`) as MAT_COUNT'#13#10 +
' FROM `smetasourcedata` `ssd2`'#13#10 +
' INNER JOIN `data_estimate` `de` ON `de`.`ID_ESTIMATE` = `ssd2`.`SM_ID`     AND `de`.`ID_TYPE_DATA` IN (1, 2, 5) '#13#10 +
' INNER JOIN `card_rate` `cr` ON `cr`.`ID` = `de`.`ID_TABLES`'#13#10 +
' INNER JOIN `materialcard` `mtc` ON `mtc`.`ID_CARD_RATE` = `cr`.`ID`'#13#10 +
' WHERE `ssd2`.`SM_ID` = :SM_ID  AND `ssd2`.`SM_TYPE` = 3   '#13#10 +
' group by `sm_id3`,`MAT_CODE` '#13#10 +

' union'#13#10 +

' SELECT'#13#10 +
' 0  as `sm_id1`, '#13#10 +
' 0 as `sm_id2`,'#13#10 +
' `ssd2`.`sm_id` as `sm_id3`, '#13#10 +
' "" as `name`,'#13#10 +
' `ssd2`.`name` as `name_o`, '#13#10 +
' `ssd2`.`name` as `name_l`,'#13#10 +
' "" as `sm_number`,'#13#10 +
' `ssd2`.`sm_number` as `sm_number1`,  '#13#10 +
' `ssd2`.`sm_number` as `sm_number2`,'#13#10 +
' "1-1" as `MAT_CODE`,  '#13#10 +
' "ЗАТРАТЫ ТРУДА РАБОЧИХ-СТРОИТЕЛЕЙ" as MAT_NAME, '#13#10 +
' "чел/ч" as `MAT_UNIT`,  '#13#10 +
' `ssd2`.`s_trud` as `MAT_COUNT`'#13#10 +
' FROM `smetasourcedata` `ssd2` '#13#10 +
' where `ssd2`.`sm_id`= :SM_ID '#13#10 +

' union  '#13#10 +

' SELECT '#13#10 +
' 0  as `sm_id1`,'#13#10 +
' 0 as `sm_id2`, '#13#10 +
' `ssd2`.`sm_id` as `sm_id3`,'#13#10 +
' ""  as `name`, '#13#10 +
' `ssd2`.`name` as `name_o`, '#13#10 +
' `ssd2`.`name` as `name_l`, '#13#10 +
' "" as `sm_number`, '#13#10 +
' `ssd2`.`sm_number` as `sm_number1`,'#13#10 +
' `ssd2`.`sm_number` as `sm_number2`, '#13#10 +
' "1-3" as MAT_CODE, '#13#10 +
' "ЗАТРАТЫ ТРУДА МАШИНИСТОВ" as `MAT_NAME`, '#13#10 +
' "чел/ч" as `MAT_UNIT`,'#13#10 +
' ssd2.s_trud_mash as `MAT_COUNT` '#13#10 +
' FROM `smetasourcedata` `ssd2`'#13#10 +
' where `ssd2`.`sm_id`= :SM_ID '#13#10 +

' union  '#13#10 +

' SELECT '#13#10 +
' 0 as `sm_id1`, '#13#10 +
' 0 as `sm_id2`,'#13#10 +
' `ssd2`.`sm_id` as `sm_id3`,'#13#10 +
' ""  as `name`, '#13#10 +
' `ssd2`.`name` as `name_o`,'#13#10 +
' `ssd2`.`name` as `name_l`,'#13#10 +
' "" as `sm_number`,'#13#10 +
' `ssd2`.`sm_number` as `sm_number1`,'#13#10 +
' `ssd2`.`sm_number` as `sm_number2`, '#13#10 +
' `mch`.`MECH_CODE` as `MAT_CODE`, '#13#10 +
' UCASE(`mch`.`MECH_NAME`) as `MAT_NAME`, '#13#10 +
' `mch`.`MECH_UNIT`,   '#13#10 +
' sum(`mch`.`MECH_COUNT`) as `MAT_COUNT` '#13#10 +
' FROM `smetasourcedata` `ssd2`'#13#10 +
' INNER JOIN `data_estimate` `de` ON `de`.`ID_ESTIMATE` = `ssd2`.`SM_ID`     AND `de`.`ID_TYPE_DATA` IN (1, 2, 5) '#13#10 +
' INNER JOIN `card_rate` `cr` ON `cr`.`ID` = `de`.`ID_TABLES` '#13#10 +
' INNER JOIN `mechanizmcard` `mch` ON `mch`.`ID_CARD_RATE` = `cr`.`ID` '#13#10 +
' WHERE `ssd2`.`SM_ID` =  :SM_ID   AND `ssd2`.`SM_TYPE` = 3   '#13#10 +
' group by `sm_id3`,`MECH_CODE` ) sm  order by `sm_id2`,`sm_id3`,`MAT_CODE`;';
qVED_OBRAB_RASHRES_SMET.ParamByName('SM_ID').AsInteger := SM_ID ;
 CloseOpen(qVED_OBRAB_RASHRES_SMET);

  try
    frxReport.PrepareReport;
    frxReport.ShowPreparedReport;
  except
    ShowMessage('Ошибка при формировании отчета');
  end;
end;

// отчет Расчет стоимости заработной платы рабочих строителей (Вадим) v1.00
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

// отчет Расчет стоимости заработной платы рабочих строителей по акту (Вадим)  v1.01
procedure TdmReportF.Report_ZP_OBJ_ACT(ID_ACT: integer; FileReportPath: string);
begin
  qrTMP.SQL.Text := 'select CONCAT(`oc`.`NUM`, " ", `oc`.`NAME`) `NAME`,'#13#10 +
                    '       IFNULL(`s`.`MONAT`, 0) `MONTH`,'#13#10 +
                    '       IFNULL(`s`.`YEAR`, 0) `YEAR`,'#13#10 +
                    '       IF(`os`.`OBJ_REGION` = 3, `s`.`STAVKA_M_RAB`, `s`.`STAVKA_RB_RAB`) `TARIF`,'#13#10 +
                    '       `ca`.`NAME` `ACT_NAME`'#13#10 +
                    'from `smetasourcedata` as `ssd`'#13#10 +
                    'inner join `objcards` `oc` on `oc`.`OBJ_ID` = `ssd`.`OBJ_ID`'#13#10 +
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

// отчет по расходу материалов по акту (Вадим) v1.02
procedure TdmReportF.Report_RASX_MAT(ID_ACT: integer; FileReportPath: string);
begin
  qrTMP.SQL.Text := 'SELECT CONCAT(`oc`.`NUM`, " ", `oc`.`NAME`) `NAME`,'#13#10 +
                    '       IFNULL(`s`.`MONAT`, 0) `MONTH`,'#13#10 +
                    '       IFNULL(`s`.`YEAR`, 0) `YEAR`,'#13#10 +
                    '       IF(`os`.`OBJ_REGION` = 3, `s`.`STAVKA_M_RAB`, `s`.`STAVKA_RB_RAB`) `TARIF`,'#13#10 +
                    '       `ca`.`NAME` `ACT_NAME`,'#13#10 +
                    '       `d`.`DUMP_NAME`'#13#10 +
                    'FROM `smetasourcedata` `ssd`'#13#10 +
                    'inner join `objcards` `oc` on `oc`.`OBJ_ID` = `ssd`.`OBJ_ID`'#13#10 +
                    'inner join `objstroj` `os` on `os`.`STROJ_ID` = `oc`.`STROJ_ID`'#13#10 +
                    'inner join `stavka` `s` on `s`.`STAVKA_ID` = `ssd`.`STAVKA_ID`'#13#10 +
	          				'inner join `card_acts` `ca` on `ca`.`ID_ESTIMATE_OBJECT` = `ssd`.`SM_ID`'#13#10 +
                    'left join `dump` `d` on `d`.`DUMP_ID` = `ssd`.`DUMP_ID`'#13#10 +
                    'WHERE `ca`.`ID` = :ID_ACT';
  qrTMP.ParamByName('ID_ACT').AsInteger := ID_ACT;
  CloseOpen(qrTMP);

  qrRASX_MAT.ParamByName('ID_ACT').AsInteger := ID_ACT;
  qrRASX_MAT2.ParamByName('ID_ACT').AsInteger := ID_ACT;

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

// --> "СМЕТА по объекту строительства" v.1.03
procedure TdmReportF.Report_SMETA_OBJ_BUILD(SM_ID: Integer; FileReportPath: string);
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
  // берем инфу для шапки
  qrTMP.Close;
  qrTMP.SQL.Text := 'select CONCAT(`oc`.`NUM`, '' '', `oc`.`NAME`) `NAME`,'#13#10 +
                    '       IFNULL(`s`.`MONAT`, 0) `MONTH`,'#13#10 +
                    '       IFNULL(`s`.`YEAR`, 0) `YEAR`,'#13#10 +
                    '       IF(`os`.`OBJ_REGION` = 3, `s`.`STAVKA_M_RAB`, `s`.`STAVKA_RB_RAB`) `TARIF`,'#13#10 +
                    '       `or`.`REGION`,'#13#10 +
                    '       `ssd`.`PREPARER`,'#13#10 +
                    '       `ssd`.`POST_PREPARER`,'#13#10 +
                    '       `ssd`.`EXAMINER`,'#13#10 +
                    '       `ssd`.`POST_EXAMINER`'#13#10 +
                    'from `smetasourcedata` `ssd`'#13#10 +
                    'inner join `stavka` `s` on `s`.`STAVKA_ID` = `ssd`.`STAVKA_ID`'#13#10 +
                    'inner join `objcards` `oc` on `oc`.`OBJ_ID` = `ssd`.`OBJ_ID`'#13#10 +
                    'inner join `objstroj` `os` on `os`.`STROJ_ID` = `oc`.`STROJ_ID`'#13#10 +
                    'inner join `objregion` `or` on `or`.`OBJ_REGION_ID` = `os`.`OBJ_REGION`'#13#10 +
                    'where `ssd`.`SM_ID` = :SM_ID';
  qrTMP.ParamByName('SM_ID').AsInteger := SM_ID_ROOT;
  CloseOpen(qrTMP);

  qrSMETA_OBJ_E.ParamByName('SM_ID').AsInteger := SM_ID_ROOT;
  qrSMETA_OBJ_MAT.ParamByName('SM_ID').AsInteger := SM_ID_ROOT;
  qrSMETA_OBJ_MEH.ParamByName('SM_ID').AsInteger := SM_ID_ROOT;
  qrSMETA_OBJ_DEV.ParamByName('SM_ID').AsInteger := SM_ID_ROOT;
  qrSMETA_OBJ_GraphC.ParamByName('SM_ID').AsInteger := SM_ID_ROOT;

  frxReport.LoadFromFile(FileReportPath + 'frSMETA_OBJ_BUILD.fr3');

  frxReport.Script.Variables['sm_obj_name'] := AnsiUpperCase(qrTMP.FieldByName('NAME').AsString);
  frxReport.Script.Variables['date_sost'] := '1 ' + AnsiUpperCase(arraymes[qrTMP.FieldByName('MONTH').AsInteger, 2]) +
                                               ' ' + qrTMP.FieldByName('YEAR').AsString + ' г.';
  frxReport.Script.Variables['cust_name'] := ''; // ??
  frxReport.Script.Variables['podr_name'] := ''; // ??
  frxReport.Script.Variables['reg_build'] := qrTMP.FieldByName('REGION').AsString;
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
// <-- "СМЕТА по объекту строительства" v.1.03

end.
