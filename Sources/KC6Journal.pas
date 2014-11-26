unit KC6Journal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Mask, Vcl.DBCtrls,
  Vcl.ButtonGroup, JvExComCtrls, JvDBTreeView, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, DataModule, Vcl.Grids, Vcl.DBGrids, Tools, JvExControls,
  JvTFManager, JvTFGlance, JvTFMonths, JvCalendar, JvMonthCalendar, Vcl.Samples.Spin, DateUtils;

type
  TfKC6Journal = class(TForm)
    pgcPage: TPageControl;
    ts1: TTabSheet;
    ts2: TTabSheet;
    pnl1: TPanel;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    cbbMode: TComboBox;
    rbRates: TRadioButton;
    rbPTM: TRadioButton;
    tvEstimates: TJvDBTreeView;
    qrTreeData: TFDQuery;
    dsTreeData: TDataSource;
    spl1: TSplitter;
    dbgrd2: TDBGrid;
    spl2: TSplitter;
    dbgrdData: TDBGrid;
    cbbFromMonth: TComboBox;
    cbbToMonth: TComboBox;
    seFromYear: TSpinEdit;
    seToYear: TSpinEdit;
    qrData: TFDQuery;
    dsData: TDataSource;
    qrDetail: TFDQuery;
    dsDetail: TDataSource;
    qrObject: TFDQuery;
    dsObject: TDataSource;
    dblkcbbNAME: TDBLookupComboBox;
    dbgrdPTM: TDBGrid;
    qrPTM: TFDQuery;
    dsPTM: TDataSource;
    qrDetaildocname: TStringField;
    qrDetailDATE: TDateTimeField;
    qrDetailosnov: TStringField;
    qrDetailcnt: TFMTBCDField;
    qrDetailNumber: TIntegerField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure rbRatesClick(Sender: TObject);
    procedure pgcPageChange(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbbFromMonthChange(Sender: TObject);
    procedure qrObjectAfterScroll(DataSet: TDataSet);
    procedure tvEstimatesClick(Sender: TObject);
    procedure qrDetailCalcFields(DataSet: TDataSet);
    procedure FormActivate(Sender: TObject);
  private
    procedure UpdateNumPP;
  public
    procedure LocateObject(Object_ID: Integer);
  end;

const
  BY_COUNT = 0;
  BY_COST = 1;

var
  fKC6Journal: TfKC6Journal;

implementation

{$R *.dfm}

uses Waiting, Main;

procedure TfKC6Journal.cbbFromMonthChange(Sender: TObject);
var
  year, month, i: Integer;
  col: TColumn;
  rateFields, rateMatFields, matFields, rateCNT, rateMatCNT, matCNT, rateCNTDone, rateMatCNTDone,
    matCNTDone, rateCNTOut, rateMatCNTOut, matCNTOut, PTMFields, PTMFieldsEmpty: string;

  procedure addCol(const Grid: TDBGrid; fieldName, titleCaption: String; const Width: Integer);
  begin
    col := Grid.Columns.Add;
    col.Title.Caption := titleCaption;
    col.Title.Alignment := taCenter;
    col.Width := Width;
    col.fieldName := fieldName;
  end;

begin
  //FormWaiting.Show;
  try
    qrData.DisableControls;
    qrPTM.DisableControls;

    // Добавляем основные колонки в таблицу
    dbgrdData.Columns.Clear;
    addCol(dbgrdData, 'ITERATOR', '№пп', 30);
    addCol(dbgrdData, 'CODE', 'Обоснование', 80);
    addCol(dbgrdData, 'NAME', 'Наименование', 250);
    addCol(dbgrdData, 'CNT', 'Кол-во', 60);
    addCol(dbgrdData, 'UNIT', 'Ед. изм.', 50);
    addCol(dbgrdData, 'CntDone', 'Выполнено', 80);
    addCol(dbgrdData, 'CntOut', 'Остаток', 80);

    dbgrdPTM.Columns.Clear;
    addCol(dbgrdPTM, '', '№пп', 30);
    addCol(dbgrdPTM, 'SM_NUMBER', 'Обоснование', 80);
    addCol(dbgrdPTM, 'NAME', 'Наименование', 250);
    addCol(dbgrdPTM, '', 'Кол-во', 60);
    addCol(dbgrdPTM, '', 'Ед. изм.', 50);
    addCol(dbgrdPTM, 'PTM_COST', 'Стоимость', 80);
    addCol(dbgrdPTM, 'PTM_COST_DONE', 'Выполнено', 80);
    addCol(dbgrdPTM, 'PTM_COST_OUT', 'Остаток', 80);

    month := cbbFromMonth.ItemIndex + 1;
    year := seFromYear.Value;

    rateFields := '';
    rateMatFields := '';
    matFields := '';
    PTMFields := '';
    PTMFieldsEmpty := '';

    case cbbMode.ItemIndex of
      BY_COUNT:
        begin
          rateCNT := '  COALESCE(RATE_COUNT, 0) AS CNT, /* Кол-во */'#13;
          rateMatCNT := '  COALESCE(MAT_COUNT, 0) AS CNT, /* Кол-во */'#13;
          matCNT := '  COALESCE(MAT_COUNT, 0) AS CNT, /* Кол-во */'#13;
          rateCNTDone :=
            '  COALESCE((SELECT SUM(RATE_COUNT) FROM card_rate_act where id=data_estimate.ID_TABLES), 0) AS CntDone, /* Выполнено */'#13;
          rateMatCNTDone :=
            '  COALESCE((SELECT SUM(MAT_COUNT) FROM materialcard_act where id=data_estimate.ID_TABLES), 0) AS CntDone, /* Выполнено */'#13;
          matCNTDone :=
            '  COALESCE((SELECT SUM(MAT_COUNT) FROM materialcard_act where id=data_estimate.ID_TABLES), 0) AS CntDone, /* Выполнено */'#13;
          rateCNTOut :=
            '  COALESCE((COALESCE(RATE_COUNT, 0) - COALESCE((SELECT SUM(RATE_COUNT) FROM card_rate_act where id=data_estimate.ID_TABLES), 0)), 0) AS CntOut /* Остаток */'#13;
          rateMatCNTOut :=
            '  COALESCE((COALESCE(MAT_COUNT, 0) - COALESCE((SELECT SUM(MAT_COUNT) FROM materialcard_act where id=data_estimate.ID_TABLES), 0)), 0) AS CntOut /* Остаток */'#13;
          matCNTOut :=
            '  COALESCE((COALESCE(MAT_COUNT, 0) - COALESCE((SELECT SUM(MAT_COUNT) FROM materialcard_act where id=data_estimate.ID_TABLES), 0)), 0) AS CntOut /* Остаток */'#13;
        end;
      BY_COST:
        begin
          rateCNT := '  COALESCE(RATE_SUM, 0) AS CNT, /* Кол-во */'#13;
          rateMatCNT := '  COALESCE(IF(FPRICE_NDS<>0, FPRICE_NDS, PRICE_NDS), 0) AS CNT, /* Кол-во */'#13;
          matCNT := '  COALESCE(IF(FPRICE_NDS<>0, FPRICE_NDS, PRICE_NDS), 0) AS CNT, /* Кол-во */'#13;
          rateCNTDone :=
            '  COALESCE((SELECT SUM(RATE_SUM) FROM card_rate_act where id=data_estimate.ID_TABLES), 0) AS CntDone, /* Выполнено */'#13;
          rateMatCNTDone :=
            '  COALESCE((SELECT SUM(MAT_SUM) FROM materialcard_act where id=data_estimate.ID_TABLES), 0) AS CntDone, /* Выполнено */'#13;
          matCNTDone :=
            '  COALESCE((SELECT SUM(MAT_SUM) FROM materialcard_act where id=data_estimate.ID_TABLES), 0) AS CntDone, /* Выполнено */'#13;
          rateCNTOut :=
            '  COALESCE((COALESCE(RATE_SUM, 0) - COALESCE((SELECT SUM(RATE_SUM) FROM card_rate_act where id=data_estimate.ID_TABLES), 0)), 0) AS CntOut /* Остаток */'#13;
          rateMatCNTOut :=
            '  COALESCE((COALESCE(IF(FPRICE_NDS<>0, FPRICE_NDS, PRICE_NDS), 0) - COALESCE((SELECT SUM(MAT_SUM) FROM materialcard_act where id=data_estimate.ID_TABLES), 0)), 0) AS CntOut /* Остаток */'#13;
          matCNTOut :=
            '  COALESCE((COALESCE(IF(FPRICE_NDS<>0, FPRICE_NDS, PRICE_NDS), 0) - COALESCE((SELECT SUM(MAT_SUM) FROM materialcard_act where id=data_estimate.ID_TABLES), 0)), 0) AS CntOut /* Остаток */'#13;
        end;
    end;
    // изменение периода
    for i := seFromYear.Value * 12 + cbbFromMonth.ItemIndex + 1 to seToYear.Value * 12 +
      cbbToMonth.ItemIndex + 1 do
    begin
      // Создаем новую колонки для месяцев в таблице
      addCol(dbgrdData, 'M' + IntToStr(month) + 'Y' + IntToStr(year),
        AnsiUpperCase(FormatDateTime('mmmm yyyy', StrToDate('01.' + IntToStr(month) + '.' +
        IntToStr(year)))), 80);
      addCol(dbgrdPTM, 'M' + IntToStr(month) + 'Y' + IntToStr(year),
        AnsiUpperCase(FormatDateTime('mmmm yyyy', StrToDate('01.' + IntToStr(month) + '.' +
        IntToStr(year)))), 80);

      PTMFieldsEmpty := PTMFieldsEmpty + ', (NULL) AS M' + IntToStr(month) + 'Y' + IntToStr(year) + ''#13;

      PTMFields := PTMFields +
        ', ((SELECT SUM(RATE_SUM) FROM card_rate_act, card_acts, data_estimate where data_estimate.ID_TYPE_DATA = 1 AND card_rate_act.id=data_estimate.ID_TABLES AND card_acts.ID=card_rate_act.ID_ACT AND EXTRACT(MONTH FROM card_acts.DATE)='
        + IntToStr(month) + ' AND EXTRACT(YEAR FROM card_acts.DATE)=' + IntToStr(year) + ' AND ID_ESTIMATE = SM_ID)' +
        ' + (SELECT SUM(MAT_SUM) FROM materialcard_act, card_acts, data_estimate where data_estimate.ID_TYPE_DATA = 2 AND materialcard_act.id=data_estimate.ID_TABLES AND card_acts.ID=materialcard_act.ID_ACT AND EXTRACT(MONTH FROM card_acts.DATE)='
        + IntToStr(month) + ' AND EXTRACT(YEAR FROM card_acts.DATE)=' + IntToStr(year) + ' AND ID_ESTIMATE = SM_ID)) AS M' +
        IntToStr(month) + 'Y' + IntToStr(year) + ''#13;

      case cbbMode.ItemIndex of
        BY_COUNT:
          begin
            rateFields := rateFields +
              ', (SELECT SUM(RATE_COUNT) FROM card_rate_act, card_acts where card_rate_act.id=data_estimate.ID_TABLES AND card_acts.ID=card_rate_act.ID_ACT AND EXTRACT(MONTH FROM card_acts.DATE)='
              + IntToStr(month) + ' AND EXTRACT(YEAR FROM card_acts.DATE)=' + IntToStr(year) + ') AS M' +
              IntToStr(month) + 'Y' + IntToStr(year) + ''#13;
            rateMatFields := rateMatFields +
              ', (SELECT SUM(MAT_COUNT) FROM materialcard_act, card_acts where materialcard_act.id=data_estimate.ID_TABLES AND card_acts.ID=materialcard_act.ID_ACT AND EXTRACT(MONTH FROM card_acts.DATE)='
              + IntToStr(month) + ' AND EXTRACT(YEAR FROM card_acts.DATE)=' + IntToStr(year) + ') AS M' +
              IntToStr(month) + 'Y' + IntToStr(year) + ''#13;
            matFields := matFields +
              ', (SELECT SUM(MAT_COUNT) FROM materialcard_act, card_acts where materialcard_act.id=data_estimate.ID_TABLES AND card_acts.ID=materialcard_act.ID_ACT AND EXTRACT(MONTH FROM card_acts.DATE)='
              + IntToStr(month) + ' AND EXTRACT(YEAR FROM card_acts.DATE)=' + IntToStr(year) + ') AS M' +
              IntToStr(month) + 'Y' + IntToStr(year) + ''#13;
          end;
        BY_COST:
          begin
            rateFields := rateFields +
              ', (SELECT SUM(RATE_SUM) FROM card_rate_act, card_acts where card_rate_act.id=data_estimate.ID_TABLES AND card_acts.ID=card_rate_act.ID_ACT AND EXTRACT(MONTH FROM card_acts.DATE)='
              + IntToStr(month) + ' AND EXTRACT(YEAR FROM card_acts.DATE)=' + IntToStr(year) + ') AS M' +
              IntToStr(month) + 'Y' + IntToStr(year) + ''#13;
            rateMatFields := rateMatFields +
              ', (SELECT SUM(MAT_SUM) FROM materialcard_act, card_acts where materialcard_act.id=data_estimate.ID_TABLES AND card_acts.ID=materialcard_act.ID_ACT AND EXTRACT(MONTH FROM card_acts.DATE)='
              + IntToStr(month) + ' AND EXTRACT(YEAR FROM card_acts.DATE)=' + IntToStr(year) + ') AS M' +
              IntToStr(month) + 'Y' + IntToStr(year) + ''#13;
            matFields := matFields +
              ', (SELECT SUM(MAT_SUM) FROM materialcard_act, card_acts where materialcard_act.id=data_estimate.ID_TABLES AND card_acts.ID=materialcard_act.ID_ACT AND EXTRACT(MONTH FROM card_acts.DATE)='
              + IntToStr(month) + ' AND EXTRACT(YEAR FROM card_acts.DATE)=' + IntToStr(year) + ') AS M' +
              IntToStr(month) + 'Y' + IntToStr(year) + ''#13;
          end;
      end;

      // Переход на следующий месяц
      if month = 12 then
      begin
        month := 1;
        Inc(year);
      end
      else
        Inc(month);
    end;
    // Собираем общий запрос
    qrData.SQL.Text :=
    '/* РАСЦЕНКИ */'#13 +
    'SELECT'#13 +
    '  ID_ESTIMATE,'#13 +
    '  ID_TYPE_DATA,'#13 +
    '  1 AS INCITERATOR,'#13 +
    '  0 AS ITERATOR,'#13 +
    '  card_rate.ID AS ID_TABLES,'#13 +
    '  RATE_CODE AS CODE, /* Обоснование*/'#13 +
    '  RATE_CAPTION AS NAME, /* Наименование */'#13 +
    '  RATE_UNIT AS UNIT, /* Ед. измерения */'#13 +
    rateCNT +
    rateCNTDone +
    rateCNTOut +
    rateFields +
    'FROM'#13 +
    '  data_estimate, card_rate'#13 +
    'WHERE'#13 +
    'data_estimate.ID_TYPE_DATA = 1 AND'#13 +
    'card_rate.ID = data_estimate.ID_TABLES AND'#13 +
    '((ID_ESTIMATE = :SM_ID) OR /* Объектный уровень */'#13 +
    ' (ID_ESTIMATE IN (SELECT SM_ID FROM smetasourcedata WHERE (PARENT_LOCAL_ID + PARENT_PTM_ID) = :SM_ID)) OR /* Локальный уровень */'#13 +
    ' (ID_ESTIMATE IN (SELECT SM_ID FROM smetasourcedata WHERE (PARENT_LOCAL_ID + PARENT_PTM_ID) IN'#13 +
    '   (SELECT SM_ID FROM smetasourcedata WHERE (PARENT_LOCAL_ID + PARENT_PTM_ID) = :SM_ID))'#13 +
    ' ) /* ПТМ уровень */'#13 +
    ')'#13 +
    'UNION ALL'#13 +
    '/* МАТЕРИАЛЫ В РАСЦЕНКЕ*/'#13 +
    'SELECT'#13 +
    '  ID_ESTIMATE,'#13 +
    '  ID_TYPE_DATA,'#13 +
    '  0 AS INCITERATOR,'#13 +
    '  0 AS ITERATOR,'#13 +
    '  materialcard.ID AS ID_TABLES,'#13 +
    '  CONCAT(''    '', MAT_CODE) AS CODE, /* Обоснование*/'#13 +
    '  MAT_NAME AS NAME, /* Наименование */'#13 +
    '  MAT_UNIT AS UNIT, /* Ед. измерения */'#13 +
    rateMatCNT +
    rateMatCNTDone +
    rateMatCNTOut +
    rateMatFields +
    'FROM'#13 +
    '  data_estimate, card_rate, materialcard'#13 +
    'WHERE'#13 +
    'data_estimate.ID_TYPE_DATA = 1 AND'#13 +
    'card_rate.ID = data_estimate.ID_TABLES AND'#13 +
    'materialcard.ID_CARD_RATE = card_rate.ID AND'#13 +
    'materialcard.CONSIDERED = 0 AND'#13 +
    '((ID_ESTIMATE = :SM_ID) OR /* Объектный уровень */'#13 +
    ' (ID_ESTIMATE IN (SELECT SM_ID FROM smetasourcedata WHERE (PARENT_LOCAL_ID + PARENT_PTM_ID) = :SM_ID)) OR /* Локальный уровень */'#13 +
    ' (ID_ESTIMATE IN (SELECT SM_ID FROM smetasourcedata WHERE (PARENT_LOCAL_ID + PARENT_PTM_ID) IN'#13 +
    '   (SELECT SM_ID FROM smetasourcedata WHERE (PARENT_LOCAL_ID + PARENT_PTM_ID) = :SM_ID))'#13 +
    ' ) /* ПТМ уровень */'#13 +
    ')'#13 +
    'UNION ALL'#13 +
    '/* МАТЕРИАЛЫ, ВЫНЕСЕННЫЕ ЗА РАСЦЕНКУ*/'#13 +
    'SELECT'#13 +
    '  ID_ESTIMATE,'#13 +
    '  2 AS ID_TYPE_DATA,'#13 +
    '  1 AS INCITERATOR,'#13 +
    '  0 AS ITERATOR,'#13 +
    '  materialcard.ID AS ID_TABLES,'#13 +
    '  MAT_CODE AS CODE, /* Обоснование*/'#13 +
    '  MAT_NAME AS NAME, /* Наименование */'#13 +
    '  MAT_UNIT AS UNIT, /* Ед. измерения */'#13 +
    rateMatCNT +
    rateMatCNTDone +
    rateMatCNTOut +
    rateMatFields +
    'FROM'#13 +
    '  data_estimate, card_rate, materialcard'#13 +
    'WHERE'#13 +
    'data_estimate.ID_TYPE_DATA = 1 AND'#13 +
    'card_rate.ID = data_estimate.ID_TABLES AND'#13 +
    'materialcard.ID_CARD_RATE = card_rate.ID AND'#13 +
    'materialcard.FROM_RATE = 1 AND'#13 +
    '((ID_ESTIMATE = :SM_ID) OR /* Объектный уровень */'#13 +
    ' (ID_ESTIMATE IN (SELECT SM_ID FROM smetasourcedata WHERE (PARENT_LOCAL_ID + PARENT_PTM_ID) = :SM_ID)) OR /* Локальный уровень */'#13 +
    ' (ID_ESTIMATE IN (SELECT SM_ID FROM smetasourcedata WHERE (PARENT_LOCAL_ID + PARENT_PTM_ID) IN'#13 +
    '   (SELECT SM_ID FROM smetasourcedata WHERE (PARENT_LOCAL_ID + PARENT_PTM_ID) = :SM_ID))'#13 +
    ' ) /* ПТМ уровень */'#13 +
    ')'#13 +
    'UNION ALL'#13 +
    '/* МАТЕРИАЛЫ*/'#13 +
    'SELECT'#13 +
    '  ID_ESTIMATE,'#13 +
    '  ID_TYPE_DATA,'#13 +
    '  1 AS INCITERATOR,'#13 +
    '  0 AS ITERATOR,'#13 +
    '  materialcard.ID AS ID_TABLES,'#13 +
    '  MAT_CODE AS CODE, /* Обоснование*/'#13 +
    '  MAT_NAME AS NAME, /* Наименование */'#13 +
    '  MAT_UNIT AS UNIT, /* Ед. измерения */'#13 +
    matCNT +
    matCNTDone +
    matCNTOut +
    matFields +
    'FROM'#13 +
    '  data_estimate, materialcard'#13 +
    'WHERE'#13 +
    'data_estimate.ID_TYPE_DATA = 2 AND'#13 +
    'materialcard.ID = data_estimate.ID_TABLES AND'#13 +
    '((ID_ESTIMATE = :SM_ID) OR /* Объектный уровень */'#13 +
    ' (ID_ESTIMATE IN (SELECT SM_ID FROM smetasourcedata WHERE (PARENT_LOCAL_ID + PARENT_PTM_ID) = :SM_ID)) OR /* Локальный уровень */'#13 +
    ' (ID_ESTIMATE IN (SELECT SM_ID FROM smetasourcedata WHERE (PARENT_LOCAL_ID + PARENT_PTM_ID) IN'#13 +
    '   (SELECT SM_ID FROM smetasourcedata WHERE (PARENT_LOCAL_ID + PARENT_PTM_ID) = :SM_ID))'#13 +
    ' ) /* ПТМ уровень */'#13 +
    ')'#13 +
    '/* МЕХАНИЗМЫ */'#13 +
    'ORDER BY 1,2';
    CloseOpen(qrData);

    //Собираем запрос по ПТМ
    qrPTM.SQL.Text :=
    '/* Объектные */'#13 +
    'SELECT SM_ID, SM_TYPE, NAME as NAME, SM_NUMBER, SM_ID as ID, (NULL) AS PTM_COST, (NULL) AS PTM_COST_DONE, (NULL) AS PTM_COST_OUT'#13 +
    PTMFieldsEmpty +
    'FROM smetasourcedata'#13 +
    'WHERE SM_TYPE=2 AND'#13 +
    '      OBJ_ID=:OBJ_ID'#13 +
    'UNION ALL'#13 +
    '/* Локальные */'#13 +
    'SELECT CONCAT((PARENT_LOCAL_ID+PARENT_PTM_ID), SM_ID) AS SM_ID, SM_TYPE, NAME as NAME, SM_NUMBER, SM_ID as ID, (NULL) AS PTM_COST,'#13 +
    '(NULL) AS PTM_COST_DONE, (NULL) AS PTM_COST_OUT'#13 +
    PTMFieldsEmpty +
    'FROM smetasourcedata'#13 +
    'WHERE SM_TYPE=1 AND'#13 +
    '      OBJ_ID=:OBJ_ID'#13 +
    'UNION ALL'#13 +
    '/* ПТМ */'#13 +
    'SELECT CONCAT('#13 +
    '(SELECT (s1.PARENT_LOCAL_ID+s1.PARENT_PTM_ID) FROM smetasourcedata s1 WHERE s1.SM_ID=(s2.PARENT_LOCAL_ID+s2.PARENT_PTM_ID)),'#13 +
    '(s2.PARENT_LOCAL_ID+s2.PARENT_PTM_ID), s2.SM_ID) AS SM_ID, s2.SM_TYPE, s2.NAME as NAME, CONCAT('' - '', s2.SM_NUMBER) as SM_NUMBER, SM_ID as ID,'#13 +
    '/*Стоимость по расценкам + Стоимость по материалам + Стоимость по материалам, вынсенным за расценку*/'#13 +
    '(COALESCE((SELECT SUM(RATE_SUM) FROM data_estimate, card_rate WHERE data_estimate.ID_TYPE_DATA = 1 AND card_rate.ID = data_estimate.ID_TABLES AND ID_ESTIMATE = SM_ID), 0) +'#13 +
    'COALESCE((SELECT SUM(MAT_SUM_NDS) FROM data_estimate, materialcard WHERE data_estimate.ID_TYPE_DATA = 2 AND materialcard.ID = data_estimate.ID_TABLES AND ID_ESTIMATE = SM_ID), 0) +'#13 +
    '(0)) AS PTM_COST,'#13 +
    '/*ВЫПОЛНЕНО Стоимость по расценкам + Стоимость по материалам + Стоимость по материалам, вынсенным за расценку*/'#13 +
    '(COALESCE((SELECT SUM(RATE_SUM) FROM card_rate_act, data_estimate where data_estimate.ID_TYPE_DATA = 1 AND card_rate_act.id=data_estimate.ID_TABLES AND ID_ESTIMATE = SM_ID), 0) +'#13 +
    'COALESCE((SELECT SUM(MAT_SUM) FROM data_estimate, materialcard_act WHERE data_estimate.ID_TYPE_DATA = 2 AND materialcard_act.ID = data_estimate.ID_TABLES AND ID_ESTIMATE = SM_ID), 0) +'#13 +
    '(0)) AS PTM_COST_DONE,'#13 +
    '/* ОСТАТОК */'#13 +
    '((COALESCE((SELECT SUM(RATE_SUM) FROM data_estimate, card_rate WHERE data_estimate.ID_TYPE_DATA = 1 AND card_rate.ID = data_estimate.ID_TABLES AND ID_ESTIMATE = SM_ID), 0) +'#13 +
    'COALESCE((SELECT SUM(MAT_SUM_NDS) FROM data_estimate, materialcard WHERE data_estimate.ID_TYPE_DATA = 2 AND materialcard.ID = data_estimate.ID_TABLES AND ID_ESTIMATE = SM_ID), 0) +'#13 +
    '(0))-(COALESCE((SELECT SUM(RATE_SUM) FROM card_rate_act, data_estimate where data_estimate.ID_TYPE_DATA = 1 AND card_rate_act.id=data_estimate.ID_TABLES AND ID_ESTIMATE = SM_ID), 0) +'#13 +
    'COALESCE((SELECT SUM(MAT_SUM) FROM data_estimate, materialcard_act WHERE data_estimate.ID_TYPE_DATA = 2 AND materialcard_act.ID = data_estimate.ID_TABLES AND ID_ESTIMATE = SM_ID), 0) +'#13 +
    '(0))) AS PTM_COST_OUT'#13 +
    PTMFields +
    'FROM smetasourcedata s2'#13 +
    'WHERE s2.SM_TYPE=3 AND'#13 +
    '      s2.OBJ_ID=:OBJ_ID'#13 +
    'ORDER BY 1,4,5';
    CloseOpen(qrPTM);

  finally
    UpdateNumPP;
    qrData.EnableControls;
    qrPTM.EnableControls;
    //FormWaiting.Close;
  end;
end;

procedure TfKC6Journal.FormActivate(Sender: TObject);
begin
  // Если нажата клавиша Ctrl и выбираем форму, то делаем
  // каскадирование с переносом этой формы на передний план
  FormMain.CascadeForActiveWindow;
  // Делаем нажатой кнопку активной формы (на главной форме внизу)
  FormMain.SelectButtonActiveWindow(Caption);
end;

procedure TfKC6Journal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfKC6Journal.FormCreate(Sender: TObject);
begin
  // Создаём кнопку от этого окна (на главной форме внизу)
  FormMain.CreateButtonOpenWindow(Caption, Caption, FormMain.N61Click);
  cbbToMonth.ItemIndex := MonthOf(Now) - 1;
  seToYear.Value := YearOf(Now);
  LoadDBGridSettings(dbgrdData);
  LoadDBGridSettings(dbgrd2);
  LoadDBGridSettings(dbgrdPTM);
  qrObject.Active := True;
  qrTreeData.Active := True;
  qrDetail.Active := True;
  pgcPage.ActivePageIndex := 0;
end;

procedure TfKC6Journal.FormDestroy(Sender: TObject);
begin
  fKC6Journal := nil;
  // Удаляем кнопку от этого окна (на главной форме внизу)
  FormMain.DeleteButtonCloseWindow(Caption);
end;

procedure TfKC6Journal.FormResize(Sender: TObject);
begin
  FixDBGridColumnsWidth(dbgrd2);
end;

procedure TfKC6Journal.tvEstimatesClick(Sender: TObject);
begin
  UpdateNumPP;
end;

procedure TfKC6Journal.LocateObject(Object_ID: Integer);
begin
  dblkcbbNAME.KeyValue := Object_ID;
end;

procedure TfKC6Journal.pgcPageChange(Sender: TObject);
begin
  rbRates.Checked := pgcPage.ActivePageIndex = 0;
  rbPTM.Checked := pgcPage.ActivePageIndex = 1;
  cbbMode.Visible := pgcPage.ActivePageIndex = 0;
end;

procedure TfKC6Journal.qrDetailCalcFields(DataSet: TDataSet);
begin
  qrDetailNumber.Value := DataSet.RecNo + 1;
end;

procedure TfKC6Journal.qrObjectAfterScroll(DataSet: TDataSet);
var
  e: TNotifyEvent;
begin
  e := cbbFromMonth.OnChange;
  cbbFromMonth.OnChange := nil;
  seFromYear.OnChange := nil;
  cbbToMonth.OnChange := nil;
  seToYear.OnChange := nil;

  cbbFromMonth.ItemIndex := MonthOf(qrObject.FieldByName('date').AsDateTime) - 1;
  seFromYear.Value := YearOf(qrObject.FieldByName('date').AsDateTime);

  cbbFromMonthChange(Self);

  cbbFromMonth.OnChange := e;
  seFromYear.OnChange := e;
  cbbToMonth.OnChange := e;
  seToYear.OnChange := e;
end;

procedure TfKC6Journal.rbRatesClick(Sender: TObject);
begin
  if rbRates.Checked then
    pgcPage.ActivePageIndex := 0
  else
    pgcPage.ActivePageIndex := 1;
end;

procedure TfKC6Journal.UpdateNumPP;
var
  NumPP: Integer;
begin
  if not CheckQrActiveEmpty(qrData) then
    Exit;
  // Устанавливаем №пп
  qrData.DisableControls;
  NumPP := 0;
  try
    qrData.First;
    while not qrData.Eof do
    begin
      NumPP := NumPP + qrData.FieldByName('INCITERATOR').AsInteger;
      qrData.Edit;
      qrData.FieldByName('ITERATOR').AsInteger := NumPP;
      qrData.Next;
    end;
  finally
    qrData.First;
    qrData.EnableControls;
  end;
end;

end.
