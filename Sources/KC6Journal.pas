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
    pgc1: TPageControl;
    ts1: TTabSheet;
    ts2: TTabSheet;
    pnl1: TPanel;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    cbbMode: TComboBox;
    rbRates: TRadioButton;
    rbPTM: TRadioButton;
    JvDBTreeView1: TJvDBTreeView;
    qrTreeData: TFDQuery;
    dsTreeData: TDataSource;
    spl1: TSplitter;
    dbgrd2: TDBGrid;
    spl2: TSplitter;
    dbgrd1: TDBGrid;
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
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure rbRatesClick(Sender: TObject);
    procedure pgc1Change(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbbFromMonthChange(Sender: TObject);
    procedure qrObjectAfterScroll(DataSet: TDataSet);
    procedure qrDataAfterOpen(DataSet: TDataSet);
    procedure qrTreeDataAfterScroll(DataSet: TDataSet);
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

uses Waiting;

procedure TfKC6Journal.cbbFromMonthChange(Sender: TObject);
var
  year, month, i: Integer;
  col: TColumn;
  rateFields, rateMatFields, matFields, rateCNT, rateMatCNT, matCNT, rateCNTDone, rateMatCNTDone,
    matCNTDone, rateCNTOut, rateMatCNTOut, matCNTOut: string;

  procedure addCol(const fieldName, titleCaption: String; const Width: Integer);
  begin
    col := dbgrd1.Columns.Add;
    col.Title.Caption := titleCaption;
    col.Title.Alignment := taCenter;
    col.Width := Width;
    col.fieldName := fieldName;
  end;

begin
  FormWaiting.Show;
  try
    dbgrd1.Columns.Clear;
    // Добавляем основные колонки в таблицу
    addCol('ITERATOR', '№пп', 30);
    addCol('CODE', 'Обоснование', 80);
    addCol('NAME', 'Наименование', 250);
    addCol('CNT', 'Кол-во', 60);
    addCol('UNIT', 'Ед. изм.', 50);
    addCol('CntDone', 'Выполнено', 80);
    addCol('CntOut', 'Остаток', 80);
    month := cbbFromMonth.ItemIndex + 1;
    year := seFromYear.Value;
    rateFields := '';
    rateMatFields := '';
    matFields := '';
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
          rateCNT := '  (''x'') AS CNT, /* Кол-во */'#13;
          rateMatCNT := '  (''x'') AS CNT, /* Кол-во */'#13;
          matCNT := '  (''x'') AS CNT, /* Кол-во */'#13;
          rateCNTDone := '  (''x'') AS CntDone, /* Выполнено */'#13;
          rateMatCNTDone := '  (''x'') AS CntDone, /* Выполнено */'#13;
          matCNTDone := '  (''x'') AS CntDone, /* Выполнено */'#13;
          rateCNTOut := '  (''x'') AS CntOut /* Остаток */'#13;
          rateMatCNTOut := '  (''x'') AS CntOut /* Остаток */'#13;
          matCNTOut := '  (''x'') AS CntOut /* Остаток */'#13;
        end;
    end;
    // изменение периода
    for i := seFromYear.Value * 12 + cbbFromMonth.ItemIndex + 1 to seToYear.Value * 12 +
      cbbToMonth.ItemIndex + 1 do
    begin
      // Создаем новую колонку для месяца в таблице
      addCol('M' + IntToStr(month) + 'Y' + IntToStr(year),
        AnsiUpperCase(FormatDateTime('mmmm yyyy', StrToDate('01.' + IntToStr(month) + '.' +
        IntToStr(year)))), 80);

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
            rateFields := rateFields + ', (''x'') AS M' + IntToStr(month) + 'Y' + IntToStr(year) + ''#13;
            rateMatFields := rateMatFields + ', (''x'') AS M' + IntToStr(month) + 'Y' +
              IntToStr(year) + ''#13;
            matFields := matFields + ', (''x'') AS M' + IntToStr(month) + 'Y' + IntToStr(year) + ''#13;
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
    qrData.Active := False;
    qrData.SQL.Text :=
    '/* РАСЦЕНКИ */'#13 +
    'SELECT'#13 +
    '  ID_ESTIMATE,'#13 +
    '  ID_TYPE_DATA,'#13 +
    '  1 AS INCITERATOR,'#13 +
    '  0 AS ITERATOR,'#13 +
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
    '/* МАТЕРИАЛЫ*/'#13 +
    'SELECT'#13 +
    '  ID_ESTIMATE,'#13 +
    '  ID_TYPE_DATA,'#13 +
    '  1 AS INCITERATOR,'#13 +
    '  0 AS ITERATOR,'#13 +
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
    qrData.Active := True;

    while not qrData.Active do
     Application.ProcessMessages;
  finally
     FormWaiting.Close;
  end;
end;

procedure TfKC6Journal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfKC6Journal.FormCreate(Sender: TObject);
begin
  cbbToMonth.ItemIndex := MonthOf(Now) - 1;
  seToYear.Value := YearOf(Now);
  LoadDBGridSettings(dbgrd1);
  LoadDBGridSettings(dbgrd2);
  qrObject.Active := True;
  qrTreeData.Active := True;
  qrDetail.Active := True;
end;

procedure TfKC6Journal.FormDestroy(Sender: TObject);
begin
  fKC6Journal := nil;
end;

procedure TfKC6Journal.FormResize(Sender: TObject);
begin
  FixDBGridColumnsWidth(dbgrd2);
end;

procedure TfKC6Journal.LocateObject(Object_ID: Integer);
begin
  dblkcbbNAME.KeyValue := Object_ID;
end;

procedure TfKC6Journal.pgc1Change(Sender: TObject);
begin
  rbRates.Checked := pgc1.ActivePageIndex = 0;
  rbPTM.Checked := pgc1.ActivePageIndex = 1;
end;

procedure TfKC6Journal.qrDataAfterOpen(DataSet: TDataSet);
begin
  UpdateNumPP;
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

procedure TfKC6Journal.qrTreeDataAfterScroll(DataSet: TDataSet);
begin
  UpdateNumPP;
end;

procedure TfKC6Journal.rbRatesClick(Sender: TObject);
begin
  if rbRates.Checked then
    pgc1.ActivePageIndex := 0
  else
    pgc1.ActivePageIndex := 1;
end;

procedure TfKC6Journal.UpdateNumPP;
var
  NumPP: Integer;
begin
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
