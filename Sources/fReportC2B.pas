unit fReportC2B;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, System.UITypes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.Buttons, Vcl.StdCtrls, Tools, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Vcl.Mask, Vcl.DBCtrls,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtCtrls,
  System.Actions, Vcl.ActnList, Vcl.ComCtrls, Vcl.Samples.Spin, Vcl.Grids,
  Vcl.DBGrids, JvExDBGrids, JvDBGrid;

const
  OwnActCount = 15;
  SybActCount = 10;

type
   TFormReportC2B = class(TSmForm)
    pnlObject: TPanel;
    gbObject: TGroupBox;
    qrObject: TFDQuery;
    dsObject: TDataSource;
    lbObjContNum: TLabel;
    lbObjContDate: TLabel;
    lbObjName: TLabel;
    ActionList1: TActionList;
    actObjectUpdate: TAction;
    cbObjName: TDBLookupComboBox;
    btnObjInfo: TSpeedButton;
    pcReportType: TPageControl;
    tsRepObj: TTabSheet;
    tsRepAct: TTabSheet;
    pnlRepObj: TPanel;
    Bevel1: TBevel;
    lbDateSmetDocTitle: TLabel;
    lbDateBegStrojTitle: TLabel;
    lbDateSmetDoc: TLabel;
    lbDateBegStroj: TLabel;
    lbSrokStrojTitle: TLabel;
    lbDateEndStrojTitle: TLabel;
    lbSrokStroj: TLabel;
    lbDateEndStroj: TLabel;
    edtObjContNum: TEdit;
    edtObjContDate: TEdit;
    pnlRepObjDate: TPanel;
    lbRepObjDataTitle: TLabel;
    pnlRepAct: TPanel;
    pnlRepActDate: TPanel;
    lbRepActTitle: TLabel;
    cbRepObjMonth: TComboBox;
    seRepObjYear: TSpinEdit;
    tsRegActs: TTabSheet;
    qrActs: TFDQuery;
    dsActs: TDataSource;
    cbActs: TDBLookupComboBox;
    lbPIBeginTitle: TLabel;
    lbPIBegin: TLabel;
    mtLeft: TFDMemTable;
    mtRight: TFDMemTable;
    dsLeft: TDataSource;
    dsRight: TDataSource;
    mtLeftSmName: TStringField;
    mtLeftUnit: TStringField;
    mtLeftSmCount: TFloatField;
    mtLeftSmTotalPrice: TCurrencyField;
    mtLeftActCount: TFloatField;
    mtLeftActTotalPrice: TCurrencyField;
    mtLeftDevFromBeg: TCurrencyField;
    mtLeftDevForMonth: TCurrencyField;
    mtRightDevItem: TStringField;
    mtRightActSumm: TCurrencyField;
    qrTemp1: TFDQuery;
    mtLeftSmId: TIntegerField;
    dsCONTRACT_PRICE_TYPE: TDataSource;
    qrCONTRACT_PRICE_TYPE: TFDQuery;
    mtLeftSmType: TIntegerField;
    mtLeftAllActsCount: TFloatField;
    mtLeftAllActsTotalPrice: TCurrencyField;
    mtLeftManthActsCount: TFloatField;
    mtLeftManthActsTotalPrice: TCurrencyField;
    mtLeftRestPrice: TCurrencyField;
    pnlGrids: TPanel;
    grLeft: TJvDBGrid;
    grRight: TJvDBGrid;
    lbShowTypeTitle: TLabel;
    cbShowType: TDBLookupComboBox;
    mtRightAllSumm: TCurrencyField;
    mtRightManthSumm: TCurrencyField;
    mtRightNum: TIntegerField;
    pnlMemos: TPanel;
    memLeft: TDBMemo;
    memRight: TDBMemo;
    pnlRegActs: TPanel;
    pnlRegActsDate: TPanel;
    lbRegActsDataTitle: TLabel;
    cbRegActsMonth: TComboBox;
    seRegActsYear: TSpinEdit;
    grRegActs: TJvDBGrid;
    mtRegActs: TFDMemTable;
    mtRegActsNum: TIntegerField;
    mtRegActsDevItem: TStringField;
    mtRegActsAllSumm: TCurrencyField;
    mtRegActsManthSumm: TCurrencyField;
    dsRegActs: TDataSource;
    mtRegActsYearSumm: TCurrencyField;
    memRegActs: TDBMemo;
    mtRegActsOwnAct1: TCurrencyField;
    mtRegActsOwnAct2: TCurrencyField;
    mtRegActsOwnAct3: TCurrencyField;
    mtRegActsOwnAct4: TCurrencyField;
    mtRegActsOwnAct5: TCurrencyField;
    mtRegActsOwnAct6: TCurrencyField;
    mtRegActsOwnAct7: TCurrencyField;
    mtRegActsOwnAct8: TCurrencyField;
    mtRegActsOwnAct9: TCurrencyField;
    mtRegActsOwnAct10: TCurrencyField;
    mtRegActsOwnAct11: TCurrencyField;
    mtRegActsOwnAct12: TCurrencyField;
    mtRegActsOwnAct13: TCurrencyField;
    mtRegActsOwnAct14: TCurrencyField;
    mtRegActsOwnAct15: TCurrencyField;
    mtRegActsOwnActs: TCurrencyField;
    mtRegActsSubAct1: TCurrencyField;
    mtRegActsSubAct2: TCurrencyField;
    mtRegActsSubAct3: TCurrencyField;
    mtRegActsSubAct4: TCurrencyField;
    mtRegActsSubAct5: TCurrencyField;
    mtRegActsSubAct6: TCurrencyField;
    mtRegActsSubAct7: TCurrencyField;
    mtRegActsSubAct8: TCurrencyField;
    mtRegActsSubAct9: TCurrencyField;
    mtRegActsSubAct10: TCurrencyField;
    mtRegActsSubActs: TCurrencyField;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actObjectUpdateUpdate(Sender: TObject);
    procedure btnObjInfoClick(Sender: TObject);
    procedure cbObjNameClick(Sender: TObject);
    procedure qrObjectBeforeOpen(DataSet: TDataSet);
    procedure pcReportTypeChange(Sender: TObject);
    procedure cbShowTypeClick(Sender: TObject);
    procedure grLeftDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormResize(Sender: TObject);
    procedure DateChange(Sender: TObject);
  private const
    CaptionButton = 'Отчет С2-Б';
    HintButton = 'Окно отчета С2-Б';
  private
    FOwnPanelButton: TSpeedButton;
    FOwnPointer: Pointer;
    FObjectID: Integer;
    FDocDate,
    FBeginDate,
    FEndDate: TDateTime;

    FPIBegin,
    FPIEnd,
    FPICur: Double;

    FCurMonth,
    FCurYear: Word;

    procedure BuildReport();
    { Private declarations }
  public
    procedure OwnPanelButtonClick;
    destructor Destroy; override;
    property OwnPointer: Pointer read FOwnPointer write FOwnPointer;
    property ObjectID: Integer read FObjectID write FObjectID;
  end;

var
  FormReportC2B: TFormReportC2B;

implementation

uses
  System.DateUtils, Main, DataModule, CardObject, GlobsAndConst;

{$R *.dfm}

const DevItems: array[1..24] of AnsiString =
  ('Суммы, учитываемые при расчетах в связи с корректировкой контрактной цены, в т.ч.',
   '- Отклонение в стоимости эксплуатации машин и механизмов',
   '- Отклонение в стоимости материалов',
   '- Отклонение в стоимости транспорта',
   '- Отклонение в стоимости прочих затрат',
   '- Отклонение в стоимости налогов и отчислений, уплачиваемых подрядчиком',
   '- Отклонение в стоимости материалов заказчика',
   '- Отклонение в стоимости Налога при упрощенной системе',
   '- Отклонение в стоимости НДС',
   '- Отклонение в стоимости оборудования подрядчика с налогами',
   '- Компенсация стоимости материалов предыдущего месяца',
   '- Компенсация стоимости аренды машин и механизмов',
   'Суммы, учитываемые при расчетах, в т.ч.',
   '- Зачет целевого аванса (-)',
   '- Зачет текущего аванса (-)',
   '- Индексация аванса (-)',
   '- Mатериалы поставки генподрядчика (-)',
   '- Bозмещение стоимости (электроэнергия. вода. газ. тепло) (-)',
   '- Другие (-)',
   'BCEГO К OПЛATE:',
   'Сумма налога при упрощенной системе налогообложения по ставке, %',
   'HДC, ставка, %',
   'Mатериалы заказчика с НДС',
   'Итого объем работ для статистической отчетности подрядной организации');

procedure TFormReportC2B.actObjectUpdateUpdate(Sender: TObject);
begin
  edtObjContNum.Enabled :=  cbObjName.KeyValue <> null;
  edtObjContDate.Enabled :=  cbObjName.KeyValue <> null;
  btnObjInfo.Enabled :=  cbObjName.KeyValue <> null;
end;

procedure TFormReportC2B.btnObjInfoClick(Sender: TObject);
var fCardObject: TfCardObject;
begin
  fCardObject := TfCardObject.Create(Self);
  try
    fCardObject.IdObject := qrObject.FieldByName('obj_id').AsInteger;
    if fCardObject.ShowModal = mrOk then
      CloseOpen(qrObject);
  finally
    FreeAndNil(fCardObject);
  end;
end;

procedure TFormReportC2B.cbObjNameClick(Sender: TObject);
begin
  if not VarIsNull(cbObjName.KeyValue) then
  begin
    FDocDate := qrObject.FieldByName('beg_stroj').AsDateTime;
    if FDocDate > 1000 then
      lbDateSmetDoc.Caption := arraymes[MonthOf(FDocDate)][1] + ' ' +
        IntToStr(YearOf(FDocDate)) + 'г.'
    else
      lbDateSmetDoc.Caption := '---';

    FBeginDate := qrObject.FieldByName('beg_stroj2').AsDateTime;
    if FBeginDate > 1000 then
      lbDateBegStroj.Caption :=arraymes[MonthOf(FBeginDate)][1] + ' ' +
        IntToStr(YearOf(FBeginDate)) + 'г.'
    else
      lbDateBegStroj.Caption := '---';

    FEndDate := IncMonth(qrObject.FieldByName('beg_stroj2').AsDateTime,
      qrObject.FieldByName('srok_stroj').AsInteger);
    lbSrokStroj.Caption := IntToStr(qrObject.FieldByName('srok_stroj').AsInteger);
    if FEndDate > 1000 then
      lbDateEndStroj.Caption := arraymes[MonthOf(FEndDate)][1] + ' ' +
        IntToStr(YearOf(FEndDate)) + 'г.'
    else
      lbDateEndStroj.Caption := '---';

    lbPIBegin.Caption := FloatToStr(qrObject.FieldByName('pibeg').AsFloat);
    FPIBegin := qrObject.FieldByName('pibeg').AsFloat;
    FPIEnd := qrObject.FieldByName('piend').AsFloat;

    edtObjContNum.Text := qrObject.FieldByName('num_dog').AsString;
    edtObjContDate.Text := qrObject.FieldByName('date_dog').AsString;

    qrActs.ParamByName('OBJ_ID').Value := qrObject.FieldByName('obj_id').AsInteger;
    CloseOpen(qrActs);

    qrCONTRACT_PRICE_TYPE.ParamByName('CONTRACT_PRICE_TYPE_ID').Value :=
      qrObject.FieldByName('CONTRACT_PRICE_TYPE_ID').Value;
    CloseOpen(qrCONTRACT_PRICE_TYPE);
    cbShowType.KeyValue := qrObject.FieldByName('CONTRACT_PRICE_TYPE_ID').Value;
  end
  else
  begin
    FDocDate := 0;
    FBeginDate := 0;
    FEndDate := 0;
    lbDateSmetDoc.Caption := '---';
    lbDateBegStroj.Caption := '---';
    lbSrokStroj.Caption := '---';
    lbDateEndStroj.Caption := '---';
    lbPIBegin.Caption := '---';
    edtObjContNum.Text := '';
    edtObjContDate.Text := '';
    qrActs.Active := False;
    qrCONTRACT_PRICE_TYPE.Active := False;
  end;
end;

procedure TFormReportC2B.DateChange(Sender: TObject);
begin
  if Sender is TComboBox then
    FCurMonth := (Sender as TComboBox).ItemIndex + 1;

  if Sender is TSpinEdit then
    FCurYear := (Sender as TSpinEdit).Value;

  BuildReport();
end;

procedure TFormReportC2B.cbShowTypeClick(Sender: TObject);
begin
  BuildReport();
end;

destructor TFormReportC2B.Destroy;
begin
  inherited;
  if Assigned(FOwnPointer) then
    Pointer(FOwnPointer^) := nil;
end;

procedure TFormReportC2B.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFormReportC2B.FormCreate(Sender: TObject);
var D: Word;
begin
  WindowState := wsMaximized;
  // Создаём кнопку от этого окна (на главной форме внизу)
  FOwnPanelButton :=
    FormMain.CreateButtonOpenWindow(CaptionButton, HintButton, Self, 1);

  FObjectID := 0;
  if not VarIsNull(InitParams) then
    FObjectID := InitParams;

  if not qrObject.Active then
    qrObject.Active := True;

  if FObjectID > 0 then
  begin
    qrObject.Locate('obj_id', FObjectID, []);
    cbObjName.Enabled := False;
  end
  else
  begin
    ShowMessage('Не задан объект!');
    PostMessage(Handle, WM_CLOSE, 0, 0);
    Exit;
  end;

  cbObjName.KeyValue := qrObject.FieldByName('obj_id').Value;
  cbObjName.OnClick(cbObjName);

  DecodeDate(Now, FCurYear, FCurMonth, D);

  pcReportTypeChange(pcReportType);
end;

procedure TFormReportC2B.FormDestroy(Sender: TObject);
begin
  // Удаляем кнопку от этого окна (на главной форме внизу)
  FormMain.DeleteButtonCloseWindow(CaptionButton);
end;

procedure TFormReportC2B.FormResize(Sender: TObject);
begin
  grLeft.Width := 5 * (Width div 9);
  memLeft.Width := grLeft.Width;
end;

procedure TFormReportC2B.grLeftDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if mtLeftSmId.Value = -1 then
  begin
    (Sender as TJvDBGrid).Canvas.Font.Style :=
      (Sender as TJvDBGrid).Canvas.Font.Style + [fsBold];
  end;
  TSmForm.DrawColumnCell(Sender, Rect, DataCol, Column, State);
end;

procedure TFormReportC2B.OwnPanelButtonClick;
begin
  if Assigned(FOwnPanelButton) then
    FOwnPanelButton.OnClick(FOwnPanelButton);
end;

procedure TFormReportC2B.pcReportTypeChange(Sender: TObject);
var ev: TNotifyEvent;
begin
  grLeft.Columns[1].Visible := False;
  grLeft.Columns[2].Visible := False;
  if pcReportType.ActivePage = tsRepObj then
  begin
    lbShowTypeTitle.Parent := pnlRepObjDate;
    cbShowType.Parent := pnlRepObjDate;
    pnlGrids.Parent := pnlRepObj;
    pnlMemos.Parent := pnlRepObj;

    grLeft.Columns[4].Visible := False;
    grLeft.Columns[5].Visible := False;
    grLeft.Columns[6].Visible := False;//True;
    grLeft.Columns[7].Visible := True;
    grLeft.Columns[8].Visible := False;//True;
    grLeft.Columns[9].Visible := True;
    grLeft.Columns[10].Visible := True;

    grRight.Columns[2].Visible := False;
    grRight.Columns[3].Visible := True;
    grRight.Columns[4].Visible := True;

    ev := cbRepObjMonth.OnChange;
    try
      cbRepObjMonth.OnChange := nil;
      seRepObjYear.OnChange := nil;
      cbRepObjMonth.ItemIndex := FCurMonth - 1;
      seRepObjYear.Value := FCurYear;
    finally
      cbRepObjMonth.OnChange := ev;
      seRepObjYear.OnChange := ev;
    end;
  end;
  if pcReportType.ActivePage = tsRepAct then
  begin
    lbShowTypeTitle.Parent := pnlRepActDate;
    cbShowType.Parent := pnlRepActDate;
    pnlGrids.Parent := pnlRepAct;
    pnlMemos.Parent := pnlRepAct;

    grLeft.Columns[4].Visible := False;//True;
    grLeft.Columns[5].Visible := True;
    grLeft.Columns[6].Visible := False;
    grLeft.Columns[7].Visible := False;
    grLeft.Columns[8].Visible := False;
    grLeft.Columns[9].Visible := False;
    grLeft.Columns[10].Visible := False;

    grRight.Columns[2].Visible := True;
    grRight.Columns[3].Visible := False;
    grRight.Columns[4].Visible := False;
  end;

  if pcReportType.ActivePage = tsRegActs then
  begin
    ev := cbRepObjMonth.OnChange;
    try
      cbRegActsMonth.OnChange := nil;
      seRegActsYear.OnChange := nil;
      cbRegActsMonth.ItemIndex := FCurMonth - 1;
      seRegActsYear.Value := FCurYear;
    finally
      cbRegActsMonth.OnChange := ev;
      seRegActsYear.OnChange := ev;
    end;
  end;

  BuildReport();
end;

procedure TFormReportC2B.qrObjectBeforeOpen(DataSet: TDataSet);
begin
  if (DataSet as TFDQuery).FindParam('USER_ID') <> nil then
    (DataSet as TFDQuery).ParamByName('USER_ID').Value := G_USER_ID;
end;

procedure TFormReportC2B.BuildReport();
var //RepType: Integer;
    ShowTypeStr: string;
    ContPriceTypeStr: string;
    CurActId: Integer;
    SelPriceStr,
    SelSmStr,
    SelCurAct,
    SelAllActs,
    SelMonthActs,
    SelRightSm,
    SelRightCurAct,
    SelRightAllActs,
    SelRightMonthActs,
    SelRightYearActs,
    SelActs, SelSumActs: string;
    CurYearDateBegin,
    CurManthDateBegin,
    CurManthDateEnd: TDateTime;

    SumSmTotalPrice, SumActTotalPrice,
    SumAllActsTotalPrice, SumManthActsTotalPrice,
    SumRestPrice: Double;

    I, J: Integer;
    TmpCol: TColumn;
begin

  CurYearDateBegin := EncodeDate(FCurYear, 1, 1);
  CurManthDateBegin := EncodeDate(FCurYear, FCurMonth, 1);
  CurManthDateEnd :=  IncMonth(CurManthDateBegin, 1) - 1;

  case cbShowType.KeyValue of
    2: ShowTypeStr := '2,1';
    3: ShowTypeStr := '2';
  else ShowTypeStr := '2,1,3';
  end;

  case qrObject.FieldByName('CONTRACT_PRICE_TYPE_ID').AsInteger of
    2: ContPriceTypeStr := '1';
    3: ContPriceTypeStr := '2';
  else ContPriceTypeStr := '3';
  end;

  if VarIsNull(cbActs.KeyValue) then
    CurActId := 0
  else
    CurActId := cbActs.KeyValue;

  qrTemp1.SQL.Text := 'Select FN_getIndex(:DateBeg, :DateEnd, 1)';
  qrTemp1.ParamByName('DateBeg').Value :=  FBeginDate;
  qrTemp1.ParamByName('DateEnd').Value := CurManthDateBegin;
  qrTemp1.Active := True;
  FPICur := qrTemp1.Fields[0].AsFloat;
  qrTemp1.Active := False;
 //*****************************************************************************
 //Секция запросов

    //Получение контрактной цены
    SelPriceStr :=
      'Select s.SM_ID SM_ID, Sum(cp.CONTRACT_PRICE) CPRICE ' +
      'from smetasourcedata s left join contract_price cp ' +
      'on cp.SM_ID IN (SELECT SM_ID FROM smetasourcedata WHERE ' +
        '(DELETED=0) AND (SM_TYPE in (' + ContPriceTypeStr + ')) AND ' +
        '(OBJ_ID = :OBJ_ID)  and (ACT = 0) AND ' +
        '((smetasourcedata.SM_ID = s.SM_ID) OR ' +
        '(smetasourcedata.PARENT_ID = s.SM_ID) OR ' +
        '(smetasourcedata.PARENT_ID IN (SELECT SM_ID FROM smetasourcedata ' +
          'WHERE PARENT_ID = s.SM_ID)))) ' +
      'where (cp.OnDate BETWEEN :DateBergin AND :DateEnd) and ' +
        '(s.OBJ_ID = :OBJ_ID) and (s.DELETED=0) and (s.ACT = 0) ' +
      'group by SM_ID';

    //Получение списка смет с контрактными ценами
    SelSmStr :=
      'SELECT FN_getSortSM(sm.SM_ID) SortSM, sm.SM_TYPE SM_TYPE, ' +
        'CONCAT(IF(sm.SM_TYPE = 2, "", IF(sm.SM_TYPE = 1, "  ", "    ")), ' +
          'IFNULL(sm.SM_NUMBER, ""), " ",  IFNULL(sm.NAME, "")) SmNAME, ' +
        'sm.SM_NUMBER SM_NUMBER, sm.SM_ID SM_ID, cp.CPRICE CPRICE, ' +
        'sm.PARENT_ID PARENT_ID ' +
      'FROM smetasourcedata sm ' +
      'LEFT JOIN (' + SelPriceStr + ') cp on sm.SM_ID = cp.SM_ID ' +
      'WHERE sm.SM_ID IN (SELECT SM_ID FROM smetasourcedata ' +
        'WHERE (SM_ID = sm.SM_ID) OR (PARENT_ID = sm.SM_ID) OR ' +
        '(PARENT_ID IN (SELECT SM_ID FROM smetasourcedata ' +
          'WHERE PARENT_ID = sm.SM_ID))) ' +
      'AND sm.DELETED=0 ' +
      'and sm.ACT = 0 AND sm.OBJ_ID = :OBJ_ID ' +
      'union ' +
      'Select 99999999999 SortSM, 2 SM_TYPE, null SmNAME, null SM_NUMBER, ' +
        '0 SM_ID, null CPRICE, null PARENT_ID';

    //Получения стоимости текущего акта с раскладкой по сметам источникам
    SelCurAct :=
      'Select s.SM_ID SM_ID, Sum(at.ACTPRICE) ACTPRICE ' +
      'from smetasourcedata s left join ' +
        '(Select s.SOURCE_ID SOURCE_ID, SUM(IFNULL(d.STOIMF, d.STOIM )) AS ACTPRICE ' +
        'FROM smetasourcedata s, summary_calculation d ' +
        'WHERE (s.DELETED = 0) AND (s.OBJ_ID = :OBJ_ID) AND ' +
        '(d.SM_ID = s.SM_ID) AND (s.SM_ID in ' +
          '(SELECT SM_ID FROM smetasourcedata WHERE (smetasourcedata.PARENT_ID IN ' +
          '(SELECT SM_ID FROM smetasourcedata WHERE PARENT_ID = :SM_ID)))) ' +
        'GROUP BY SOURCE_ID) at ' +
      'on at.SOURCE_ID IN (SELECT SM_ID FROM smetasourcedata ' +
        'WHERE (DELETED=0) AND ' +
          '(OBJ_ID = :OBJ_ID)  and (ACT = 0) AND ' +
          '((smetasourcedata.SM_ID = s.SM_ID) OR ' +
          '(smetasourcedata.PARENT_ID = s.SM_ID) OR ' +
          '(smetasourcedata.PARENT_ID IN (SELECT SM_ID FROM smetasourcedata ' +
            'WHERE PARENT_ID = s.SM_ID)))) ' +
      'where (s.OBJ_ID = :OBJ_ID) and (s.DELETED=0) and (s.ACT = 0) ' +
      'group by SM_ID ' +
      'union ' +  //union нужен так как MySql не поддерживает full outer join
      'Select 0 SM_ID, SUM(IFNULL(d.STOIMF, d.STOIM )) AS ACTPRICE ' +
        'FROM smetasourcedata s, summary_calculation d ' +
        'WHERE (s.DELETED = 0) AND (s.OBJ_ID = :OBJ_ID) AND (s.SOURCE_ID is null) AND ' +
        '(d.SM_ID = s.SM_ID) AND (s.SM_ID in ' +
          '(SELECT SM_ID FROM smetasourcedata WHERE (smetasourcedata.PARENT_ID IN ' +
          '(SELECT SM_ID FROM smetasourcedata WHERE PARENT_ID = :SM_ID)))) ' +
        'GROUP BY SM_ID';

    //Получения стоимости по всем актам с раскладкой по сметам источникам
    SelAllActs :=
      'Select s.SM_ID SM_ID, Sum(at.AllACTSPRICE) AllACTSPRICE ' +
      'from smetasourcedata s left join ' +
        '(Select s.SOURCE_ID SOURCE_ID, SUM(IFNULL(d.STOIMF, d.STOIM )) AS AllACTSPRICE ' +
        'FROM smetasourcedata s, summary_calculation d ' +
        'WHERE (s.DELETED = 0) AND (s.OBJ_ID = :OBJ_ID) AND ' +
        '(d.SM_ID = s.SM_ID) AND (s.SM_ID in ' +
          '(Select SM_ID FROM smetasourcedata WHERE (PARENT_ID in ' +
          '(Select SM_ID FROM smetasourcedata WHERE (PARENT_ID in ' +
          '(Select SM_ID FROM smetasourcedata WHERE (OBJ_ID = :OBJ_ID) AND ' +
            '(DELETED = 0) AND (ACT = 1) AND (SM_TYPE = 2) AND ' +
            '(DATE BETWEEN :AllActsDateBegin AND :AllActsDateEnd))))))) ' +
        'GROUP BY SOURCE_ID) at ' +
      'on at.SOURCE_ID IN (SELECT SM_ID FROM smetasourcedata ' +
        'WHERE (DELETED=0) AND ' +
          '(OBJ_ID = :OBJ_ID)  and (ACT = 0) AND ' +
          '((smetasourcedata.SM_ID = s.SM_ID) OR ' +
          '(smetasourcedata.PARENT_ID = s.SM_ID) OR ' +
          '(smetasourcedata.PARENT_ID IN (SELECT SM_ID FROM smetasourcedata ' +
            'WHERE PARENT_ID = s.SM_ID)))) ' +
      'where (s.OBJ_ID = :OBJ_ID) and (s.DELETED=0) and (s.ACT = 0) ' +
      'group by SM_ID ' +
      'union ' +  //union нужен так как MySql не поддерживает full outer join
      'Select 0 SM_ID, SUM(IFNULL(d.STOIMF, d.STOIM )) AS AllACTSPRICE ' +
        'FROM smetasourcedata s, summary_calculation d ' +
        'WHERE (s.DELETED = 0) AND (s.OBJ_ID = :OBJ_ID) AND (s.SOURCE_ID is null) AND ' +
        '(d.SM_ID = s.SM_ID) AND (s.SM_ID in ' +
          '(Select SM_ID FROM smetasourcedata WHERE (PARENT_ID in ' +
          '(Select SM_ID FROM smetasourcedata WHERE (PARENT_ID in ' +
          '(Select SM_ID FROM smetasourcedata WHERE (OBJ_ID = :OBJ_ID) AND ' +
          '(DELETED = 0) AND (ACT = 1) AND (SM_TYPE = 2) AND ' +
          '(DATE BETWEEN :AllActsDateBegin AND :AllActsDateEnd))))))) ' +
        'GROUP BY SM_ID';

    //Получения стоимости по актам за месяц с раскладкой по сметам источникам
    SelMonthActs :=
      'Select s.SM_ID SM_ID, Sum(at.MONTHACTSPRICE) MONTHACTSPRICE ' +
      'from smetasourcedata s left join ' +
        '(Select s.SOURCE_ID SOURCE_ID, SUM(IFNULL(d.STOIMF, d.STOIM )) AS MONTHACTSPRICE ' +
        'FROM smetasourcedata s, summary_calculation d ' +
        'WHERE (s.DELETED = 0) AND (s.OBJ_ID = :OBJ_ID) AND ' +
        '(d.SM_ID = s.SM_ID) AND (s.SM_ID in ' +
          '(Select SM_ID FROM smetasourcedata WHERE (PARENT_ID in ' +
          '(Select SM_ID FROM smetasourcedata WHERE (PARENT_ID in ' +
          '(Select SM_ID FROM smetasourcedata WHERE (OBJ_ID = :OBJ_ID) AND ' +
            '(DELETED = 0) AND (ACT = 1) AND (SM_TYPE = 2) AND ' +
            '(DATE BETWEEN :MonthActsDateBegin AND :MonthActsDateEnd))))))) ' +
        'GROUP BY SOURCE_ID) at ' +
      'on at.SOURCE_ID IN (SELECT SM_ID FROM smetasourcedata ' +
        'WHERE (DELETED=0) AND ' +
          '(OBJ_ID = :OBJ_ID)  and (ACT = 0) AND ' +
          '((smetasourcedata.SM_ID = s.SM_ID) OR ' +
          '(smetasourcedata.PARENT_ID = s.SM_ID) OR ' +
          '(smetasourcedata.PARENT_ID IN (SELECT SM_ID FROM smetasourcedata ' +
            'WHERE PARENT_ID = s.SM_ID)))) ' +
      'where (s.OBJ_ID = :OBJ_ID) and (s.DELETED=0) and (s.ACT = 0) ' +
      'group by SM_ID ' +
      'union ' +  //union нужен так как MySql не поддерживает full outer join
      'Select 0 SM_ID, SUM(IFNULL(d.STOIMF, d.STOIM )) AS MONTHACTSPRICE ' +
        'FROM smetasourcedata s, summary_calculation d ' +
        'WHERE (s.DELETED = 0) AND (s.OBJ_ID = :OBJ_ID) AND (s.SOURCE_ID is null) AND ' +
        '(d.SM_ID = s.SM_ID) AND (s.SM_ID in ' +
          '(Select SM_ID FROM smetasourcedata WHERE (PARENT_ID in ' +
          '(Select SM_ID FROM smetasourcedata WHERE (PARENT_ID in ' +
          '(Select SM_ID FROM smetasourcedata WHERE (OBJ_ID = :OBJ_ID) AND ' +
            '(DELETED = 0) AND (ACT = 1) AND (SM_TYPE = 2) AND ' +
            '(DATE BETWEEN :MonthActsDateBegin AND :MonthActsDateEnd))))))) ' +
      'GROUP BY SM_ID';

    //Cуммы по сметам объекта с учета ПИ для расчета отклонений
    SelRightSm :=
      'Select Round(SUM(COALESCE(d.EMiMF, d.EMiM, 0)) * :CurPi) AS SmEMiM, ' +
             'Round(SUM(COALESCE(d.MRF, d.MR, 0)) * :CurPi) AS SmMr, ' +
             'Round(SUM(COALESCE(d.TRANSPF, d.TRANSP, 0)) * :CurPi) AS SmTransp, ' +
             'Round(SUM(COALESCE(d.OTHERF, d.OTHER, 0)) * :CurPi) AS SmOther, ' +
             'Round(SUM(COALESCE(d.TOTAL_NALF, d.TOTAL_NAL, 0)) * :CurPi) AS SmNal, ' +
             'Round(SUM(COALESCE(d.MAT_ZAKF, d.MAT_ZAK, 0)) * :CurPi) AS SmMATZAK, ' +
             'Round(SUM(COALESCE(d.NAL_USNF, d.NAL_USN, 0))) AS SmNalYpr, ' +
             'Round(SUM(COALESCE(d.NDSF, d.NDS, 0)) * :CurPi) AS SmNDS, ' +
             'Round(SUM(COALESCE(d.TOTAL_DEVICE, d.TOTAL_DEVICE, 0)) * :CurPi) AS SmDevice ' +
      'FROM smetasourcedata s, summary_calculation d ' +
      'WHERE (s.DELETED = 0) AND (s.ACT = 0) AND ' +
            '(s.OBJ_ID = :OBJ_ID) AND (d.SM_ID = s.SM_ID)';

    //Суммы по текущему акту
    SelRightCurAct :=
      'Select Round(SUM(COALESCE(d.EMiMF, d.EMiM, 0))) AS CurActEMiM, ' +
             'Round(SUM(COALESCE(d.MRF, d.MR, 0))) AS CurActMr, ' +
             'Round(SUM(COALESCE(d.TRANSPF, d.TRANSP, 0))) AS CurActTransp, ' +
             'Round(SUM(COALESCE(d.OTHERF, d.OTHER, 0))) AS CurActOther, ' +
             'Round(SUM(COALESCE(d.TOTAL_NALF, d.TOTAL_NAL, 0))) AS CurActNal, ' +
             'Round(SUM(COALESCE(d.MAT_ZAKF, d.MAT_ZAK, 0))) AS CurActMATZAK, ' +
             'Round(SUM(COALESCE(d.NAL_USNF, d.NAL_USN, 0))) AS CurActNalYpr, ' +
             'Round(SUM(COALESCE(d.NDSF, d.NDS, 0))) AS CurActNDS, ' +
             'Round(SUM(COALESCE(d.TOTAL_DEVICE, d.TOTAL_DEVICE, 0))) AS CurActDevice, ' +
             'Round(SUM(COALESCE(d.MAT_COST_COMPF, d.MAT_COST_COMP, 0))) AS CurActKompMat, ' +
             'Round(SUM(COALESCE(d.MECH_RENT_COMPF, d.MECH_RENT_COMP, 0))) AS CurActKompMech, ' +
             'Round(SUM(COALESCE(d.ADVANCE_TARGETF, d.ADVANCE_TARGET, 0))) AS CurActAdvTarg, ' +
             'Round(SUM(COALESCE(d.ADVANCE_CURRENTF, d.ADVANCE_CURRENT, 0))) AS CurActAdvCur, ' +
             'Round(SUM(COALESCE(d.ADVANCE_INDEXF, d.ADVANCE_INDEX, 0))) AS CurActAdvInd, ' +
             'Round(SUM(COALESCE(d.MR_GEN_PODRF, d.MR_GEN_PODR, 0))) AS CurActMrGenPodr, ' +
             'Round(SUM(COALESCE(d.CASHBACKF, d.CASHBACK, 0))) AS CurActCashBack, ' +
             'Round(SUM(COALESCE(d.ADVANCE_OTHERF, d.ADVANCE_OTHER, 0))) AS CurActAdvOther, ' +
             'Round(SUM(COALESCE(d.STOIMF, d.STOIM, 0))) AS CurActSTOIM, ' +
             'Round(SUM(COALESCE(d.MAT_ZAK_NDSF, d.MAT_ZAK_NDS, 0))) AS CurActMatZakNDS, ' +
             'Round(SUM(COALESCE(d.TOTAL_STATF, d.TOTAL_STAT, 0))) AS CurActTotalStat ' +
        'FROM smetasourcedata s, summary_calculation d ' +
        'WHERE (s.DELETED = 0) AND (s.OBJ_ID = :OBJ_ID) AND (d.SM_ID = s.SM_ID) AND ' +
              '(s.ACT = 1) AND (s.SM_ID in (SELECT SM_ID FROM smetasourcedata WHERE ' +
                '(smetasourcedata.PARENT_ID IN ' +
                '(SELECT SM_ID FROM smetasourcedata WHERE PARENT_ID = :SM_ID))))';

    //Суммы по всем актам до конца текущего масяца
    SelRightAllActs :=
      'Select Round(SUM(COALESCE(d.EMiMF, d.EMiM, 0))) AS AllActsEMiM, ' +
             'Round(SUM(COALESCE(d.MRF, d.MR, 0)) ) AS AllActsMr, ' +
             'Round(SUM(COALESCE(d.TRANSPF, d.TRANSP, 0))) AS AllActsTransp, ' +
             'Round(SUM(COALESCE(d.OTHERF, d.OTHER, 0))) AS AllActsOther, ' +
             'Round(SUM(COALESCE(d.TOTAL_NALF, d.TOTAL_NAL, 0))) AS AllActsNal, ' +
             'Round(SUM(COALESCE(d.MAT_ZAKF, d.MAT_ZAK, 0))) AS AllActsMATZAK, ' +
             'Round(SUM(COALESCE(d.NAL_USNF, d.NAL_USN, 0))) AS AllActsNalYpr, ' +
             'Round(SUM(COALESCE(d.NDSF, d.NDS, 0))) AS AllActsNDS, ' +
             'Round(SUM(COALESCE(d.TOTAL_DEVICE, d.TOTAL_DEVICE, 0))) AS AllActsDevice, ' +
             'Round(SUM(COALESCE(d.MAT_COST_COMPF, d.MAT_COST_COMP, 0))) AS AllActsKompMat, ' +
             'Round(SUM(COALESCE(d.MECH_RENT_COMPF, d.MECH_RENT_COMP, 0))) AS AllActsKompMech, ' +
             'Round(SUM(COALESCE(d.ADVANCE_TARGETF, d.ADVANCE_TARGET, 0))) AS AllActsAdvTarg, ' +
             'Round(SUM(COALESCE(d.ADVANCE_CURRENTF, d.ADVANCE_CURRENT, 0))) AS AllActsAdvCur, ' +
             'Round(SUM(COALESCE(d.ADVANCE_INDEXF, d.ADVANCE_INDEX, 0))) AS AllActsAdvInd, ' +
             'Round(SUM(COALESCE(d.MR_GEN_PODRF, d.MR_GEN_PODR, 0))) AS AllActsMrGenPodr, ' +
             'Round(SUM(COALESCE(d.CASHBACKF, d.CASHBACK, 0))) AS AllActsCashBack, ' +
             'Round(SUM(COALESCE(d.ADVANCE_OTHERF, d.ADVANCE_OTHER, 0))) AS AllActsAdvOther, ' +
             'Round(SUM(COALESCE(d.STOIMF, d.STOIM, 0))) AS AllActsSTOIM, ' +
             'Round(SUM(COALESCE(d.MAT_ZAK_NDSF, d.MAT_ZAK_NDS, 0))) AS AllActsMatZakNDS, ' +
             'Round(SUM(COALESCE(d.TOTAL_STATF, d.TOTAL_STAT, 0))) AS AllActsTotalStat ' +
        'FROM smetasourcedata s, summary_calculation d ' +
        'WHERE (s.DELETED = 0) AND (s.OBJ_ID = :OBJ_ID) AND (d.SM_ID = s.SM_ID) AND ' +
              '(s.ACT = 1) AND (s.SM_ID in (Select SM_ID FROM smetasourcedata ' +
                'WHERE (PARENT_ID in (Select SM_ID FROM smetasourcedata ' +
                  'WHERE (PARENT_ID in (Select SM_ID FROM smetasourcedata ' +
                  'WHERE (OBJ_ID = :OBJ_ID) AND (DELETED = 0) AND (ACT = 1) AND ' +
                  '(SM_TYPE = 2) AND (DATE BETWEEN :AllActsDateBegin AND :AllActsDateEnd)))))))';

    //Суммы по актам с начала года до текущего месяца
    SelRightYearActs :=
      'Select Round(SUM(COALESCE(d.EMiMF, d.EMiM, 0))) AS YearActsEMiM, ' +
             'Round(SUM(COALESCE(d.MRF, d.MR, 0))) AS YearActsMr, ' +
             'Round(SUM(COALESCE(d.TRANSPF, d.TRANSP, 0))) AS YearActsTransp, ' +
             'Round(SUM(COALESCE(d.OTHERF, d.OTHER, 0))) AS YearActsOther, ' +
             'Round(SUM(COALESCE(d.TOTAL_NALF, d.TOTAL_NAL, 0))) AS YearActsNal, ' +
             'Round(SUM(COALESCE(d.MAT_ZAKF, d.MAT_ZAK, 0))) AS YearActsMATZAK, ' +
             'Round(SUM(COALESCE(d.NAL_USNF, d.NAL_USN, 0))) AS YearActsNalYpr, ' +
             'Round(SUM(COALESCE(d.NDSF, d.NDS, 0))) AS YearActsNDS, ' +
             'Round(SUM(COALESCE(d.TOTAL_DEVICE, d.TOTAL_DEVICE, 0))) AS YearActsDevice, ' +
             'Round(SUM(COALESCE(d.MAT_COST_COMPF, d.MAT_COST_COMP, 0))) AS YearActsKompMat, ' +
             'Round(SUM(COALESCE(d.MECH_RENT_COMPF, d.MECH_RENT_COMP, 0))) AS YearActsKompMech, ' +
             'Round(SUM(COALESCE(d.ADVANCE_TARGETF, d.ADVANCE_TARGET, 0))) AS YearActsAdvTarg, ' +
             'Round(SUM(COALESCE(d.ADVANCE_CURRENTF, d.ADVANCE_CURRENT, 0))) AS YearActsAdvCur, ' +
             'Round(SUM(COALESCE(d.ADVANCE_INDEXF, d.ADVANCE_INDEX, 0))) AS YearActsAdvInd, ' +
             'Round(SUM(COALESCE(d.MR_GEN_PODRF, d.MR_GEN_PODR, 0))) AS YearActsMrGenPodr, ' +
             'Round(SUM(COALESCE(d.CASHBACKF, d.CASHBACK, 0))) AS YearActsCashBack, ' +
             'Round(SUM(COALESCE(d.ADVANCE_OTHERF, d.ADVANCE_OTHER, 0))) AS YearActsAdvOther, ' +
             'Round(SUM(COALESCE(d.STOIMF, d.STOIM, 0))) AS YearActsSTOIM, ' +
             'Round(SUM(COALESCE(d.MAT_ZAK_NDSF, d.MAT_ZAK_NDS, 0))) AS YearActsMatZakNDS, ' +
             'Round(SUM(COALESCE(d.TOTAL_STATF, d.TOTAL_STAT, 0))) AS YearActsTotalStat ' +
        'FROM smetasourcedata s, summary_calculation d ' +
        'WHERE (s.DELETED = 0) AND (s.OBJ_ID = :OBJ_ID) AND (d.SM_ID = s.SM_ID) AND ' +
              '(s.ACT = 1) AND (s.SM_ID in (Select SM_ID FROM smetasourcedata ' +
                'WHERE (PARENT_ID in (Select SM_ID FROM smetasourcedata ' +
                  'WHERE (PARENT_ID in (Select SM_ID FROM smetasourcedata ' +
                  'WHERE (OBJ_ID = :OBJ_ID) AND (DELETED = 0) AND (ACT = 1) AND ' +
                  '(SM_TYPE = 2) AND (DATE BETWEEN :YearActsDateBegin AND :MonthActsDateEnd)))))))';

    //Суммы по актам за текущий масяца
    SelRightMonthActs :=
      'Select Round(SUM(COALESCE(d.EMiMF, d.EMiM, 0))) AS MonActsEMiM, ' +
             'Round(SUM(COALESCE(d.MRF, d.MR, 0)) ) AS MonActsMr, ' +
             'Round(SUM(COALESCE(d.TRANSPF, d.TRANSP, 0))) AS MonActsTransp, ' +
             'Round(SUM(COALESCE(d.OTHERF, d.OTHER, 0))) AS MonActsOther, ' +
             'Round(SUM(COALESCE(d.TOTAL_NALF, d.TOTAL_NAL, 0))) AS MonActsNal, ' +
             'Round(SUM(COALESCE(d.MAT_ZAKF, d.MAT_ZAK, 0))) AS MonActsMATZAK, ' +
             'Round(SUM(COALESCE(d.NAL_USNF, d.NAL_USN, 0))) AS MonActsNalYpr, ' +
             'Round(SUM(COALESCE(d.NDSF, d.NDS, 0))) AS MonActsNDS, ' +
             'Round(SUM(COALESCE(d.TOTAL_DEVICE, d.TOTAL_DEVICE, 0))) AS MonActsDevice, ' +
             'Round(SUM(COALESCE(d.MAT_COST_COMPF, d.MAT_COST_COMP, 0))) AS MonActsKompMat, ' +
             'Round(SUM(COALESCE(d.MECH_RENT_COMPF, d.MECH_RENT_COMP, 0))) AS MonActsKompMech, ' +
             'Round(SUM(COALESCE(d.ADVANCE_TARGETF, d.ADVANCE_TARGET, 0))) AS MonActsAdvTarg, ' +
             'Round(SUM(COALESCE(d.ADVANCE_CURRENTF, d.ADVANCE_CURRENT, 0))) AS MonActsAdvCur, ' +
             'Round(SUM(COALESCE(d.ADVANCE_INDEXF, d.ADVANCE_INDEX, 0))) AS MonActsAdvInd, ' +
             'Round(SUM(COALESCE(d.MR_GEN_PODRF, d.MR_GEN_PODR, 0))) AS MonActsMrGenPodr, ' +
             'Round(SUM(COALESCE(d.CASHBACKF, d.CASHBACK, 0))) AS MonActsCashBack, ' +
             'Round(SUM(COALESCE(d.ADVANCE_OTHERF, d.ADVANCE_OTHER, 0))) AS MonActsAdvOther, ' +
             'Round(SUM(COALESCE(d.STOIMF, d.STOIM, 0))) AS MonActsSTOIM, ' +
             'Round(SUM(COALESCE(d.MAT_ZAK_NDSF, d.MAT_ZAK_NDS, 0))) AS MonActsMatZakNDS, ' +
             'Round(SUM(COALESCE(d.TOTAL_STATF, d.TOTAL_STAT, 0))) AS MonActsTotalStat ' +
        'FROM smetasourcedata s, summary_calculation d ' +
        'WHERE (s.DELETED = 0) AND (s.OBJ_ID = :OBJ_ID) AND (d.SM_ID = s.SM_ID) AND ' +
              '(s.ACT = 1) AND (s.SM_ID in (Select SM_ID FROM smetasourcedata ' +
                'WHERE (PARENT_ID in (Select SM_ID FROM smetasourcedata ' +
                  'WHERE (PARENT_ID in (Select SM_ID FROM smetasourcedata ' +
                  'WHERE (OBJ_ID = :OBJ_ID) AND (DELETED = 0) AND (ACT = 1) AND ' +
                  '(SM_TYPE = 2) AND (DATE BETWEEN :MonthActsDateBegin AND :MonthActsDateEnd)))))))';

    //Суммы по актам за текущий масяца
    SelActs :=
      'Select ' +
       '(Select SM_ID FROM smetasourcedata WHERE ' +
         '(SM_ID = (Select PARENT_ID FROM smetasourcedata WHERE ' +
         '(SM_ID = s.PARENT_ID)))) SSM_ID, ' +
       '(Select NAME FROM smetasourcedata WHERE ' +
         '(SM_ID = (Select PARENT_ID FROM smetasourcedata WHERE ' +
         '(SM_ID = s.PARENT_ID)))) SNAME, ' +
             'Round(SUM(COALESCE(d.EMiMF, d.EMiM, 0))) AS MonActsEMiM, ' +
             'Round(SUM(COALESCE(d.MRF, d.MR, 0)) ) AS MonActsMr, ' +
             'Round(SUM(COALESCE(d.TRANSPF, d.TRANSP, 0))) AS MonActsTransp, ' +
             'Round(SUM(COALESCE(d.OTHERF, d.OTHER, 0))) AS MonActsOther, ' +
             'Round(SUM(COALESCE(d.TOTAL_NALF, d.TOTAL_NAL, 0))) AS MonActsNal, ' +
             'Round(SUM(COALESCE(d.MAT_ZAKF, d.MAT_ZAK, 0))) AS MonActsMATZAK, ' +
             'Round(SUM(COALESCE(d.NAL_USNF, d.NAL_USN, 0))) AS MonActsNalYpr, ' +
             'Round(SUM(COALESCE(d.NDSF, d.NDS, 0))) AS MonActsNDS, ' +
             'Round(SUM(COALESCE(d.TOTAL_DEVICE, d.TOTAL_DEVICE, 0))) AS MonActsDevice, ' +
             'Round(SUM(COALESCE(d.MAT_COST_COMPF, d.MAT_COST_COMP, 0))) AS MonActsKompMat, ' +
             'Round(SUM(COALESCE(d.MECH_RENT_COMPF, d.MECH_RENT_COMP, 0))) AS MonActsKompMech, ' +
             'Round(SUM(COALESCE(d.ADVANCE_TARGETF, d.ADVANCE_TARGET, 0))) AS MonActsAdvTarg, ' +
             'Round(SUM(COALESCE(d.ADVANCE_CURRENTF, d.ADVANCE_CURRENT, 0))) AS MonActsAdvCur, ' +
             'Round(SUM(COALESCE(d.ADVANCE_INDEXF, d.ADVANCE_INDEX, 0))) AS MonActsAdvInd, ' +
             'Round(SUM(COALESCE(d.MR_GEN_PODRF, d.MR_GEN_PODR, 0))) AS MonActsMrGenPodr, ' +
             'Round(SUM(COALESCE(d.CASHBACKF, d.CASHBACK, 0))) AS MonActsCashBack, ' +
             'Round(SUM(COALESCE(d.ADVANCE_OTHERF, d.ADVANCE_OTHER, 0))) AS MonActsAdvOther, ' +
             'Round(SUM(COALESCE(d.STOIMF, d.STOIM, 0))) AS MonActsSTOIM, ' +
             'Round(SUM(COALESCE(d.MAT_ZAK_NDSF, d.MAT_ZAK_NDS, 0))) AS MonActsMatZakNDS, ' +
             'Round(SUM(COALESCE(d.TOTAL_STATF, d.TOTAL_STAT, 0))) AS MonActsTotalStat ' +
        'FROM smetasourcedata s, summary_calculation d ' +
        'WHERE (s.DELETED = 0) AND (s.OBJ_ID = :OBJ_ID) AND (d.SM_ID = s.SM_ID) AND ' +
              '(s.ACT = 1) AND ((s.TYPE_ACT = :TYPE_ACT1) or (s.TYPE_ACT = :TYPE_ACT2)) AND ' +
              '(s.SM_ID in (Select SM_ID FROM smetasourcedata ' +
                'WHERE (PARENT_ID in (Select SM_ID FROM smetasourcedata ' +
                  'WHERE (PARENT_ID in (Select SM_ID FROM smetasourcedata ' +
                  'WHERE (OBJ_ID = :OBJ_ID) AND (DELETED = 0) AND (ACT = 1) AND ' +
                  '(SM_TYPE = 2) AND ' +
                  '(DATE BETWEEN :MonthActsDateBegin AND :MonthActsDateEnd))))))) ' +
        'GROUP BY SSM_ID, SNAME';

    //Суммы по актам за текущий масяца
    SelSumActs :=
      'Select Round(SUM(COALESCE(d.EMiMF, d.EMiM, 0))) AS MonActsEMiM, ' +
             'Round(SUM(COALESCE(d.MRF, d.MR, 0)) ) AS MonActsMr, ' +
             'Round(SUM(COALESCE(d.TRANSPF, d.TRANSP, 0))) AS MonActsTransp, ' +
             'Round(SUM(COALESCE(d.OTHERF, d.OTHER, 0))) AS MonActsOther, ' +
             'Round(SUM(COALESCE(d.TOTAL_NALF, d.TOTAL_NAL, 0))) AS MonActsNal, ' +
             'Round(SUM(COALESCE(d.MAT_ZAKF, d.MAT_ZAK, 0))) AS MonActsMATZAK, ' +
             'Round(SUM(COALESCE(d.NAL_USNF, d.NAL_USN, 0))) AS MonActsNalYpr, ' +
             'Round(SUM(COALESCE(d.NDSF, d.NDS, 0))) AS MonActsNDS, ' +
             'Round(SUM(COALESCE(d.TOTAL_DEVICE, d.TOTAL_DEVICE, 0))) AS MonActsDevice, ' +
             'Round(SUM(COALESCE(d.MAT_COST_COMPF, d.MAT_COST_COMP, 0))) AS MonActsKompMat, ' +
             'Round(SUM(COALESCE(d.MECH_RENT_COMPF, d.MECH_RENT_COMP, 0))) AS MonActsKompMech, ' +
             'Round(SUM(COALESCE(d.ADVANCE_TARGETF, d.ADVANCE_TARGET, 0))) AS MonActsAdvTarg, ' +
             'Round(SUM(COALESCE(d.ADVANCE_CURRENTF, d.ADVANCE_CURRENT, 0))) AS MonActsAdvCur, ' +
             'Round(SUM(COALESCE(d.ADVANCE_INDEXF, d.ADVANCE_INDEX, 0))) AS MonActsAdvInd, ' +
             'Round(SUM(COALESCE(d.MR_GEN_PODRF, d.MR_GEN_PODR, 0))) AS MonActsMrGenPodr, ' +
             'Round(SUM(COALESCE(d.CASHBACKF, d.CASHBACK, 0))) AS MonActsCashBack, ' +
             'Round(SUM(COALESCE(d.ADVANCE_OTHERF, d.ADVANCE_OTHER, 0))) AS MonActsAdvOther, ' +
             'Round(SUM(COALESCE(d.STOIMF, d.STOIM, 0))) AS MonActsSTOIM, ' +
             'Round(SUM(COALESCE(d.MAT_ZAK_NDSF, d.MAT_ZAK_NDS, 0))) AS MonActsMatZakNDS, ' +
             'Round(SUM(COALESCE(d.TOTAL_STATF, d.TOTAL_STAT, 0))) AS MonActsTotalStat ' +
        'FROM smetasourcedata s, summary_calculation d ' +
        'WHERE (s.DELETED = 0) AND (s.OBJ_ID = :OBJ_ID) AND (d.SM_ID = s.SM_ID) AND ' +
              '(s.ACT = 1) AND ((s.TYPE_ACT = :TYPE_ACT1) or (s.TYPE_ACT = :TYPE_ACT2)) AND ' +
              '(s.SM_ID in (Select SM_ID FROM smetasourcedata ' +
                'WHERE (PARENT_ID in (Select SM_ID FROM smetasourcedata ' +
                  'WHERE (PARENT_ID in (Select SM_ID FROM smetasourcedata ' +
                  'WHERE (OBJ_ID = :OBJ_ID) AND (DELETED = 0) AND (ACT = 1) AND ' +
                  '(SM_TYPE = 2) AND ' +
                  '(DATE BETWEEN :MonthActsDateBegin AND :MonthActsDateEnd)))))))';
 //*****************************************************************************

  if (pcReportType.ActivePage = tsRepObj) or
     (pcReportType.ActivePage = tsRepAct)  then
  begin
    //Заполнение левой таблицы
    if not mtLeft.Active then
      mtLeft.Active :=True;
    mtLeft.EmptyDataSet;

    mtLeft.BeginBatch();
    try
      qrTemp1.SQL.Text := 'Select SortSM, SM_TYPE, SmNAME, SM_NUMBER, SmTab.SM_ID SM_ID, ' +
        'CPRICE, PARENT_ID, ACTPRICE, AllACTSPRICE, MONTHACTSPRICE ' +
        'from (' + SelSmStr + ') SmTab ' +
        'LEFT JOIN (' + SelCurAct + ') CurActTab ON SmTab.SM_ID = CurActTab.SM_ID ' +
        'LEFT JOIN (' + SelAllActs + ') AllActsTab ON SmTab.SM_ID = AllActsTab.SM_ID ' +
        'LEFT JOIN (' + SelMonthActs + ') MonthActsTab ON SmTab.SM_ID = MonthActsTab.SM_ID ' +
        'WHERE (SM_TYPE in (' + ShowTypeStr + ')) ' +
        'ORDER BY 1,4,5';
      qrTemp1.ParamByName('OBJ_ID').Value := FObjectID;
      qrTemp1.ParamByName('DateBergin').AsDate := FBeginDate;
      qrTemp1.ParamByName('DateEnd').AsDate := FEndDate;
      qrTemp1.ParamByName('SM_ID').Value := CurActId;
      qrTemp1.ParamByName('AllActsDateBegin').AsDate := FBeginDate;
      qrTemp1.ParamByName('AllActsDateEnd').AsDate := CurManthDateEnd;
      qrTemp1.ParamByName('MonthActsDateBegin').AsDate := CurManthDateBegin;
      qrTemp1.ParamByName('MonthActsDateEnd').AsDate := CurManthDateEnd;
      qrTemp1.Active := True;

      SumSmTotalPrice := 0;
      SumActTotalPrice := 0;
      SumAllActsTotalPrice := 0;
      SumManthActsTotalPrice := 0;
      SumRestPrice := 0;

      while not qrTemp1.Eof do
      begin
        mtLeft.Append;
        mtLeftSmName.Value := qrTemp1.FieldByName('SmNAME').AsAnsiString;
        mtLeftSmId.Value := qrTemp1.FieldByName('SM_ID').AsInteger;
        mtLeftSmType.Value := qrTemp1.FieldByName('SM_TYPE').AsInteger;
        mtLeftSmTotalPrice.Value := qrTemp1.FieldByName('CPRICE').AsFloat;
        mtLeftActTotalPrice.Value := qrTemp1.FieldByName('ACTPRICE').AsFloat;
        mtLeftAllActsTotalPrice.Value := qrTemp1.FieldByName('AllACTSPRICE').AsFloat;
        mtLeftManthActsTotalPrice.Value := qrTemp1.FieldByName('MONTHACTSPRICE').AsFloat;
        mtLeftRestPrice.Value := mtLeftSmTotalPrice.Value - mtLeftAllActsTotalPrice.Value;
        if mtLeftSmType.Value = 2 then
        begin
          SumSmTotalPrice := SumSmTotalPrice + mtLeftSmTotalPrice.Value;
          SumActTotalPrice := SumActTotalPrice + mtLeftActTotalPrice.Value;
          SumAllActsTotalPrice := SumAllActsTotalPrice + mtLeftAllActsTotalPrice.Value;
          SumManthActsTotalPrice := SumManthActsTotalPrice + mtLeftManthActsTotalPrice.Value;
          SumRestPrice := SumRestPrice + mtLeftRestPrice.Value;
        end;
        mtLeft.Post;
        qrTemp1.Next;
      end;
      qrTemp1.Active := False;

      mtLeft.Append;
      mtLeftSmName.Value := 'Итого';
      mtLeftSmId.Value := -1;
      mtLeftSmTotalPrice.Value := SumSmTotalPrice;
      mtLeftActTotalPrice.Value := SumActTotalPrice;
      mtLeftAllActsTotalPrice.Value := SumAllActsTotalPrice;
      mtLeftManthActsTotalPrice.Value := SumManthActsTotalPrice;
      mtLeftRestPrice.Value := SumRestPrice;
      mtLeft.Post;
    finally
      mtLeft.EndBatch;
    end;

    //Заполнение правой таблицы
    if not mtRight.Active then
      mtRight.Active :=True;
    mtRight.EmptyDataSet;
    mtRight.BeginBatch();
    try
      qrTemp1.SQL.Text :=
        'Select ' +
        '(SmEMiM + SmMr + SmTransp + SmOther + SmNal + ' +
         'SmMATZAK + SmNalYpr + SmNDS + SmDevice - ' +
         'CurActEMiM - CurActMr - CurActTransp - CurActOther - CurActNal - ' +
         'CurActMATZAK - CurActNalYpr - CurActNDS - CurActDevice) DevCurActSum, ' +
        '(SmEMiM - CurActEMiM) DevCurActEMiM, ' +
        '(SmMr - CurActMr) DevCurActMr, ' +
        '(SmTransp - CurActTransp) DevCurActTransp, ' +
        '(SmOther - CurActOther) DevCurActOther, ' +
        '(SmNal - CurActNal) DevCurActNal, ' +
        '(SmMATZAK - CurActMATZAK) DevCurActMATZAK, ' +
        '(SmNalYpr - CurActNalYpr) DevCurActNalYpr, ' +
        '(SmNDS - CurActNDS) DevCurActNDS, ' +
        '(SmDevice - CurActDevice) DevCurActDevice, ' +
        'CurActKompMat, CurActKompMech, ' +
        '(CurActAdvTarg + CurActAdvCur + CurActAdvInd + CurActMrGenPodr + ' +
          'CurActCashBack + CurActAdvOther) CurActNoCalcSum, ' +
        'CurActAdvTarg, CurActAdvCur, CurActAdvInd, CurActMrGenPodr, ' +
        'CurActCashBack, CurActAdvOther, CurActSTOIM, CurActNalYpr, ' +
        'CurActNDS, CurActMatZakNDS, CurActTotalStat, ' +

        '(SmEMiM + SmMr + SmTransp + SmOther + SmNal + ' +
         'SmMATZAK + SmNalYpr + SmNDS + SmDevice - ' +
         'AllActsEMiM - AllActsMr - AllActsTransp - AllActsOther - AllActsNal - ' +
         'AllActsMATZAK - AllActsNalYpr - AllActsNDS - AllActsDevice) DevAllActsSum, ' +
        '(SmEMiM - AllActsEMiM) DevAllActsEMiM, ' +
        '(SmMr - AllActsMr) DevAllActsMr, ' +
        '(SmTransp - AllActsTransp) DevAllActsTransp, ' +
        '(SmOther - AllActsOther) DevAllActsOther, ' +
        '(SmNal - AllActsNal) DevAllActsNal, ' +
        '(SmMATZAK - AllActsMATZAK) DevAllActsMATZAK, ' +
        '(SmNalYpr - AllActsNalYpr) DevAllActsNalYpr, ' +
        '(SmNDS - AllActsNDS) DevAllActsNDS, ' +
        '(SmDevice - AllActsDevice) DevAllActsDevice, ' +
        'AllActsKompMat, AllActsKompMech, ' +
        '(AllActsAdvTarg + AllActsAdvCur + AllActsAdvInd + AllActsMrGenPodr + ' +
          'AllActsCashBack + AllActsAdvOther) AllActsNoCalcSum, ' +
        'AllActsAdvTarg, AllActsAdvCur, AllActsAdvInd, AllActsMrGenPodr, ' +
        'AllActsCashBack, AllActsAdvOther, AllActsSTOIM, AllActsNalYpr, ' +
        'AllActsNDS, AllActsMatZakNDS, AllActsTotalStat, ' +

        '(SmEMiM + SmMr + SmTransp + SmOther + SmNal + ' +
         'SmMATZAK + SmNalYpr + SmNDS + SmDevice - ' +
         'MonActsEMiM - MonActsMr - MonActsTransp - MonActsOther - MonActsNal - ' +
         'MonActsMATZAK - MonActsNalYpr - MonActsNDS - MonActsDevice) DevMonActsSum, ' +
        '(SmEMiM - MonActsEMiM) DevMonActsEMiM, ' +
        '(SmMr - MonActsMr) DevMonActsMr, ' +
        '(SmTransp - MonActsTransp) DevMonActsTransp, ' +
        '(SmOther - MonActsOther) DevMonActsOther, ' +
        '(SmNal - MonActsNal) DevMonActsNal, ' +
        '(SmMATZAK - MonActsMATZAK) DevMonActsMATZAK, ' +
        '(SmNalYpr - MonActsNalYpr) DevMonActsNalYpr, ' +
        '(SmNDS - MonActsNDS) DevMonActsNDS, ' +
        '(SmDevice - MonActsDevice) DevMonActsDevice, ' +
        'MonActsKompMat, MonActsKompMech, ' +
        '(MonActsAdvTarg + MonActsAdvCur + MonActsAdvInd + MonActsMrGenPodr + ' +
          'MonActsCashBack + MonActsAdvOther) MonActsNoCalcSum, ' +
        'MonActsAdvTarg, MonActsAdvCur, MonActsAdvInd, MonActsMrGenPodr, ' +
        'MonActsCashBack, MonActsAdvOther, MonActsSTOIM, MonActsNalYpr, ' +
        'MonActsNDS, MonActsMatZakNDS, MonActsTotalStat ' +

        'from (' + SelRightSm + ') sm, (' + SelRightCurAct + ') curact, ' +
             '(' + SelRightAllActs + ') allacts, (' + SelRightMonthActs + ') monacts';
      qrTemp1.ParamByName('OBJ_ID').Value := FObjectID;
      qrTemp1.ParamByName('CurPi').Value := FPICur;
      qrTemp1.ParamByName('SM_ID').Value := CurActId;
      qrTemp1.ParamByName('AllActsDateBegin').AsDate := FBeginDate;
      qrTemp1.ParamByName('AllActsDateEnd').AsDate := CurManthDateEnd;
      qrTemp1.ParamByName('MonthActsDateBegin').AsDate := CurManthDateBegin;
      qrTemp1.ParamByName('MonthActsDateEnd').AsDate := CurManthDateEnd;
      qrTemp1.Active := True;

      for I := Low(DevItems) to High(DevItems) do
      begin
        mtRight.Append;
        mtRightNum.Value := I;
        mtRightDevItem.Value := DevItems[I];
        case I of
        1:
        begin
          mtRightActSumm.Value := qrTemp1.FieldByName('DevCurActSum').AsFloat;
          mtRightAllSumm.Value := qrTemp1.FieldByName('DevAllActsSum').AsFloat;
          mtRightManthSumm.Value := qrTemp1.FieldByName('DevMonActsSum').AsFloat;
        end;
        2:
        begin
          mtRightActSumm.Value := qrTemp1.FieldByName('DevCurActEMiM').AsFloat;
          mtRightAllSumm.Value := qrTemp1.FieldByName('DevAllActsEMiM').AsFloat;
          mtRightManthSumm.Value := qrTemp1.FieldByName('DevMonActsEMiM').AsFloat;
        end;
        3:
        begin
          mtRightActSumm.Value := qrTemp1.FieldByName('DevCurActMr').AsFloat;
          mtRightAllSumm.Value := qrTemp1.FieldByName('DevAllActsMr').AsFloat;
          mtRightManthSumm.Value := qrTemp1.FieldByName('DevMonActsMr').AsFloat;
        end;
        4:
        begin
          mtRightActSumm.Value := qrTemp1.FieldByName('DevCurActTransp').AsFloat;
          mtRightAllSumm.Value := qrTemp1.FieldByName('DevAllActsTransp').AsFloat;
          mtRightManthSumm.Value := qrTemp1.FieldByName('DevMonActsTransp').AsFloat;
        end;
        5:
        begin
          mtRightActSumm.Value := qrTemp1.FieldByName('DevCurActOther').AsFloat;
          mtRightAllSumm.Value := qrTemp1.FieldByName('DevAllActsOther').AsFloat;
          mtRightManthSumm.Value := qrTemp1.FieldByName('DevMonActsOther').AsFloat;
        end;
        6:
        begin
          mtRightActSumm.Value := qrTemp1.FieldByName('DevCurActNal').AsFloat;
          mtRightAllSumm.Value := qrTemp1.FieldByName('DevAllActsNal').AsFloat;
          mtRightManthSumm.Value := qrTemp1.FieldByName('DevMonActsNal').AsFloat;
        end;
        7:
        begin
          mtRightActSumm.Value := qrTemp1.FieldByName('DevCurActMATZAK').AsFloat;
          mtRightAllSumm.Value := qrTemp1.FieldByName('DevAllActsMATZAK').AsFloat;
          mtRightManthSumm.Value := qrTemp1.FieldByName('DevMonActsMATZAK').AsFloat;
        end;
        8:
        begin
          mtRightActSumm.Value := qrTemp1.FieldByName('DevCurActNalYpr').AsFloat;
          mtRightAllSumm.Value := qrTemp1.FieldByName('DevAllActsNalYpr').AsFloat;
          mtRightManthSumm.Value := qrTemp1.FieldByName('DevMonActsNalYpr').AsFloat;
        end;
        9:
        begin
          mtRightActSumm.Value := qrTemp1.FieldByName('DevCurActNDS').AsFloat;
          mtRightAllSumm.Value := qrTemp1.FieldByName('DevAllActsNDS').AsFloat;
          mtRightManthSumm.Value := qrTemp1.FieldByName('DevMonActsNDS').AsFloat;
        end;
        10:
        begin
          mtRightActSumm.Value := qrTemp1.FieldByName('DevCurActDevice').AsFloat;
          mtRightAllSumm.Value := qrTemp1.FieldByName('DevAllActsDevice').AsFloat;
          mtRightManthSumm.Value := qrTemp1.FieldByName('DevMonActsDevice').AsFloat;
        end;
        11:
        begin
          mtRightActSumm.Value := qrTemp1.FieldByName('CurActKompMat').AsFloat;
          mtRightAllSumm.Value := qrTemp1.FieldByName('AllActsKompMat').AsFloat;
          mtRightManthSumm.Value := qrTemp1.FieldByName('MonActsKompMat').AsFloat;
        end;
        12:
        begin
          mtRightActSumm.Value := qrTemp1.FieldByName('CurActKompMech').AsFloat;
          mtRightAllSumm.Value := qrTemp1.FieldByName('AllActsKompMech').AsFloat;
          mtRightManthSumm.Value := qrTemp1.FieldByName('MonActsKompMech').AsFloat;
        end;
        13:
        begin
          mtRightActSumm.Value := qrTemp1.FieldByName('CurActNoCalcSum').AsFloat;
          mtRightAllSumm.Value := qrTemp1.FieldByName('AllActsNoCalcSum').AsFloat;
          mtRightManthSumm.Value := qrTemp1.FieldByName('MonActsNoCalcSum').AsFloat;
        end;
        14:
        begin
          mtRightActSumm.Value := qrTemp1.FieldByName('CurActAdvTarg').AsFloat;
          mtRightAllSumm.Value := qrTemp1.FieldByName('AllActsAdvTarg').AsFloat;
          mtRightManthSumm.Value := qrTemp1.FieldByName('MonActsAdvTarg').AsFloat;
        end;
        15:
        begin
          mtRightActSumm.Value := qrTemp1.FieldByName('CurActAdvCur').AsFloat;
          mtRightAllSumm.Value := qrTemp1.FieldByName('AllActsAdvCur').AsFloat;
          mtRightManthSumm.Value := qrTemp1.FieldByName('MonActsAdvCur').AsFloat;
        end;
        16:
        begin
          mtRightActSumm.Value := qrTemp1.FieldByName('CurActAdvInd').AsFloat;
          mtRightAllSumm.Value := qrTemp1.FieldByName('AllActsAdvInd').AsFloat;
          mtRightManthSumm.Value := qrTemp1.FieldByName('MonActsAdvInd').AsFloat;
        end;
        17:
        begin
          mtRightActSumm.Value := qrTemp1.FieldByName('CurActMrGenPodr').AsFloat;
          mtRightAllSumm.Value := qrTemp1.FieldByName('AllActsMrGenPodr').AsFloat;
          mtRightManthSumm.Value := qrTemp1.FieldByName('MonActsMrGenPodr').AsFloat;
        end;
        18:
        begin
          mtRightActSumm.Value := qrTemp1.FieldByName('CurActCashBack').AsFloat;
          mtRightAllSumm.Value := qrTemp1.FieldByName('AllActsCashBack').AsFloat;
          mtRightManthSumm.Value := qrTemp1.FieldByName('MonActsCashBack').AsFloat;
        end;
        19:
        begin
          mtRightActSumm.Value := qrTemp1.FieldByName('CurActAdvOther').AsFloat;
          mtRightAllSumm.Value := qrTemp1.FieldByName('AllActsAdvOther').AsFloat;
          mtRightManthSumm.Value := qrTemp1.FieldByName('MonActsAdvOther').AsFloat;
        end;
        20:
        begin
          mtRightActSumm.Value := qrTemp1.FieldByName('CurActSTOIM').AsFloat;
          mtRightAllSumm.Value := qrTemp1.FieldByName('AllActsSTOIM').AsFloat;
          mtRightManthSumm.Value := qrTemp1.FieldByName('MonActsSTOIM').AsFloat;
        end;
        21:
        begin
          mtRightActSumm.Value := qrTemp1.FieldByName('CurActNalYpr').AsFloat;
          mtRightAllSumm.Value := qrTemp1.FieldByName('AllActsNalYpr').AsFloat;
          mtRightManthSumm.Value := qrTemp1.FieldByName('MonActsNalYpr').AsFloat;
        end;
        22:
        begin
          mtRightActSumm.Value := qrTemp1.FieldByName('CurActNDS').AsFloat;
          mtRightAllSumm.Value := qrTemp1.FieldByName('AllActsNDS').AsFloat;
          mtRightManthSumm.Value := qrTemp1.FieldByName('MonActsNDS').AsFloat;
        end;
        23:
        begin
          mtRightActSumm.Value := qrTemp1.FieldByName('CurActMatZakNDS').AsFloat;
          mtRightAllSumm.Value := qrTemp1.FieldByName('AllActsMatZakNDS').AsFloat;
          mtRightManthSumm.Value := qrTemp1.FieldByName('MonActsMatZakNDS').AsFloat;
        end;
        24:
        begin
          mtRightActSumm.Value := qrTemp1.FieldByName('CurActTotalStat').AsFloat;
          mtRightAllSumm.Value := qrTemp1.FieldByName('AllActsTotalStat').AsFloat;
          mtRightManthSumm.Value := qrTemp1.FieldByName('MonActsTotalStat').AsFloat;
        end;
        end;
        mtRight.Post;
      end;
      qrTemp1.Active := False;
    finally
      mtRight.EndBatch;
    end;
  end;

  if pcReportType.ActivePage = tsRegActs then
  begin
    for I := grRegActs.Columns.Count - 1 downto 5 do
      grRegActs.Columns.Delete(I);

    if not mtRegActs.Active then
      mtRegActs.Active :=True;
    mtRegActs.EmptyDataSet;

    mtRegActs.BeginBatch();
    try
      qrTemp1.SQL.Text :=
        'Select ' +
        '(SmEMiM + SmMr + SmTransp + SmOther + SmNal + ' +
         'SmMATZAK + SmNalYpr + SmNDS + SmDevice - ' +
         'AllActsEMiM - AllActsMr - AllActsTransp - AllActsOther - AllActsNal - ' +
         'AllActsMATZAK - AllActsNalYpr - AllActsNDS - AllActsDevice) DevAllActsSum, ' +
        '(SmEMiM - AllActsEMiM) DevAllActsEMiM, ' +
        '(SmMr - AllActsMr) DevAllActsMr, ' +
        '(SmTransp - AllActsTransp) DevAllActsTransp, ' +
        '(SmOther - AllActsOther) DevAllActsOther, ' +
        '(SmNal - AllActsNal) DevAllActsNal, ' +
        '(SmMATZAK - AllActsMATZAK) DevAllActsMATZAK, ' +
        '(SmNalYpr - AllActsNalYpr) DevAllActsNalYpr, ' +
        '(SmNDS - AllActsNDS) DevAllActsNDS, ' +
        '(SmDevice - AllActsDevice) DevAllActsDevice, ' +
        'AllActsKompMat, AllActsKompMech, ' +
        '(AllActsAdvTarg + AllActsAdvCur + AllActsAdvInd + AllActsMrGenPodr + ' +
          'AllActsCashBack + AllActsAdvOther) AllActsNoCalcSum, ' +
        'AllActsAdvTarg, AllActsAdvCur, AllActsAdvInd, AllActsMrGenPodr, ' +
        'AllActsCashBack, AllActsAdvOther, AllActsSTOIM, AllActsNalYpr, ' +
        'AllActsNDS, AllActsMatZakNDS, AllActsTotalStat, ' +

        '(SmEMiM + SmMr + SmTransp + SmOther + SmNal + ' +
         'SmMATZAK + SmNalYpr + SmNDS + SmDevice - ' +
         'YearActsEMiM - YearActsMr - YearActsTransp - YearActsOther - YearActsNal - ' +
         'YearActsMATZAK - YearActsNalYpr - YearActsNDS - YearActsDevice) DevYearActsSum, ' +
        '(SmEMiM - YearActsEMiM) DevYearActsEMiM, ' +
        '(SmMr - YearActsMr) DevYearActsMr, ' +
        '(SmTransp - YearActsTransp) DevYearActsTransp, ' +
        '(SmOther - YearActsOther) DevYearActsOther, ' +
        '(SmNal - YearActsNal) DevYearActsNal, ' +
        '(SmMATZAK - YearActsMATZAK) DevYearActsMATZAK, ' +
        '(SmNalYpr - YearActsNalYpr) DevYearActsNalYpr, ' +
        '(SmNDS - YearActsNDS) DevYearActsNDS, ' +
        '(SmDevice - YearActsDevice) DevYearActsDevice, ' +
        'YearActsKompMat, YearActsKompMech, ' +
        '(YearActsAdvTarg + YearActsAdvCur + YearActsAdvInd + YearActsMrGenPodr + ' +
          'YearActsCashBack + YearActsAdvOther) YearActsNoCalcSum, ' +
        'YearActsAdvTarg, YearActsAdvCur, YearActsAdvInd, YearActsMrGenPodr, ' +
        'YearActsCashBack, YearActsAdvOther, YearActsSTOIM, YearActsNalYpr, ' +
        'YearActsNDS, YearActsMatZakNDS, YearActsTotalStat, ' +

        '(SmEMiM + SmMr + SmTransp + SmOther + SmNal + ' +
         'SmMATZAK + SmNalYpr + SmNDS + SmDevice - ' +
         'MonActsEMiM - MonActsMr - MonActsTransp - MonActsOther - MonActsNal - ' +
         'MonActsMATZAK - MonActsNalYpr - MonActsNDS - MonActsDevice) DevMonActsSum, ' +
        '(SmEMiM - MonActsEMiM) DevMonActsEMiM, ' +
        '(SmMr - MonActsMr) DevMonActsMr, ' +
        '(SmTransp - MonActsTransp) DevMonActsTransp, ' +
        '(SmOther - MonActsOther) DevMonActsOther, ' +
        '(SmNal - MonActsNal) DevMonActsNal, ' +
        '(SmMATZAK - MonActsMATZAK) DevMonActsMATZAK, ' +
        '(SmNalYpr - MonActsNalYpr) DevMonActsNalYpr, ' +
        '(SmNDS - MonActsNDS) DevMonActsNDS, ' +
        '(SmDevice - MonActsDevice) DevMonActsDevice, ' +
        'MonActsKompMat, MonActsKompMech, ' +
        '(MonActsAdvTarg + MonActsAdvCur + MonActsAdvInd + MonActsMrGenPodr + ' +
          'MonActsCashBack + MonActsAdvOther) MonActsNoCalcSum, ' +
        'MonActsAdvTarg, MonActsAdvCur, MonActsAdvInd, MonActsMrGenPodr, ' +
        'MonActsCashBack, MonActsAdvOther, MonActsSTOIM, MonActsNalYpr, ' +
        'MonActsNDS, MonActsMatZakNDS, MonActsTotalStat ' +

        'from (' + SelRightSm + ') sm, (' + SelRightYearActs + ') yearacts, ' +
             '(' + SelRightAllActs + ') allacts, (' + SelRightMonthActs + ') monacts';
      qrTemp1.ParamByName('OBJ_ID').Value := FObjectID;
      qrTemp1.ParamByName('CurPi').Value := FPICur;
      qrTemp1.ParamByName('AllActsDateBegin').AsDate := FBeginDate;
      qrTemp1.ParamByName('AllActsDateEnd').AsDate := CurManthDateEnd;
      qrTemp1.ParamByName('YearActsDateBegin').AsDate := CurYearDateBegin;
      qrTemp1.ParamByName('MonthActsDateBegin').AsDate := CurManthDateBegin;
      qrTemp1.ParamByName('MonthActsDateEnd').AsDate := CurManthDateEnd;
      qrTemp1.Active := True;

      for I := Low(DevItems) to High(DevItems) do
      begin
        mtRegActs.Append;
        mtRegActsNum.Value := I;
        mtRegActsDevItem.Value := DevItems[I];
        case I of
        1:
        begin
          mtRegActsAllSumm.Value := qrTemp1.FieldByName('DevAllActsSum').AsFloat;
          mtRegActsYearSumm.Value := qrTemp1.FieldByName('DevYearActsSum').AsFloat;
          mtRegActsManthSumm.Value := qrTemp1.FieldByName('DevMonActsSum').AsFloat;
        end;
        2:
        begin
          mtRegActsAllSumm.Value := qrTemp1.FieldByName('DevAllActsEMiM').AsFloat;
          mtRegActsYearSumm.Value := qrTemp1.FieldByName('DevYearActsEMiM').AsFloat;
          mtRegActsManthSumm.Value := qrTemp1.FieldByName('DevMonActsEMiM').AsFloat;
        end;
        3:
        begin
          mtRegActsAllSumm.Value := qrTemp1.FieldByName('DevAllActsMr').AsFloat;
          mtRegActsYearSumm.Value := qrTemp1.FieldByName('DevYearActsMr').AsFloat;
          mtRegActsManthSumm.Value := qrTemp1.FieldByName('DevMonActsMr').AsFloat;
        end;
        4:
        begin
          mtRegActsAllSumm.Value := qrTemp1.FieldByName('DevAllActsTransp').AsFloat;
          mtRegActsYearSumm.Value := qrTemp1.FieldByName('DevYearActsTransp').AsFloat;
          mtRegActsManthSumm.Value := qrTemp1.FieldByName('DevMonActsTransp').AsFloat;
        end;
        5:
        begin
          mtRegActsAllSumm.Value := qrTemp1.FieldByName('DevAllActsOther').AsFloat;
          mtRegActsYearSumm.Value := qrTemp1.FieldByName('DevYearActsOther').AsFloat;
          mtRegActsManthSumm.Value := qrTemp1.FieldByName('DevMonActsOther').AsFloat;
        end;
        6:
        begin
          mtRegActsAllSumm.Value := qrTemp1.FieldByName('DevAllActsNal').AsFloat;
          mtRegActsYearSumm.Value := qrTemp1.FieldByName('DevYearActsNal').AsFloat;
          mtRegActsManthSumm.Value := qrTemp1.FieldByName('DevMonActsNal').AsFloat;
        end;
        7:
        begin
          mtRegActsAllSumm.Value := qrTemp1.FieldByName('DevAllActsMATZAK').AsFloat;
          mtRegActsYearSumm.Value := qrTemp1.FieldByName('DevYearActsMATZAK').AsFloat;
          mtRegActsManthSumm.Value := qrTemp1.FieldByName('DevMonActsMATZAK').AsFloat;
        end;
        8:
        begin
          mtRegActsAllSumm.Value := qrTemp1.FieldByName('DevAllActsNalYpr').AsFloat;
          mtRegActsYearSumm.Value := qrTemp1.FieldByName('DevYearActsNalYpr').AsFloat;
          mtRegActsManthSumm.Value := qrTemp1.FieldByName('DevMonActsNalYpr').AsFloat;
        end;
        9:
        begin
          mtRegActsAllSumm.Value := qrTemp1.FieldByName('DevAllActsNDS').AsFloat;
          mtRegActsYearSumm.Value := qrTemp1.FieldByName('DevYearActsNDS').AsFloat;
          mtRegActsManthSumm.Value := qrTemp1.FieldByName('DevMonActsNDS').AsFloat;
        end;
        10:
        begin
          mtRegActsAllSumm.Value := qrTemp1.FieldByName('DevAllActsDevice').AsFloat;
          mtRegActsYearSumm.Value := qrTemp1.FieldByName('DevYearActsDevice').AsFloat;
          mtRegActsManthSumm.Value := qrTemp1.FieldByName('DevMonActsDevice').AsFloat;
        end;
        11:
        begin
          mtRegActsAllSumm.Value := qrTemp1.FieldByName('AllActsKompMat').AsFloat;
          mtRegActsYearSumm.Value := qrTemp1.FieldByName('YearActsKompMat').AsFloat;
          mtRegActsManthSumm.Value := qrTemp1.FieldByName('MonActsKompMat').AsFloat;
        end;
        12:
        begin
          mtRegActsAllSumm.Value := qrTemp1.FieldByName('AllActsKompMech').AsFloat;
          mtRegActsYearSumm.Value := qrTemp1.FieldByName('YearActsKompMech').AsFloat;
          mtRegActsManthSumm.Value := qrTemp1.FieldByName('MonActsKompMech').AsFloat;
        end;
        13:
        begin
          mtRegActsAllSumm.Value := qrTemp1.FieldByName('AllActsNoCalcSum').AsFloat;
          mtRegActsYearSumm.Value := qrTemp1.FieldByName('YearActsNoCalcSum').AsFloat;
          mtRegActsManthSumm.Value := qrTemp1.FieldByName('MonActsNoCalcSum').AsFloat;
        end;
        14:
        begin
          mtRegActsAllSumm.Value := qrTemp1.FieldByName('AllActsAdvTarg').AsFloat;
          mtRegActsYearSumm.Value := qrTemp1.FieldByName('YearActsAdvTarg').AsFloat;
          mtRegActsManthSumm.Value := qrTemp1.FieldByName('MonActsAdvTarg').AsFloat;
        end;
        15:
        begin
          mtRegActsAllSumm.Value := qrTemp1.FieldByName('AllActsAdvCur').AsFloat;
          mtRegActsYearSumm.Value := qrTemp1.FieldByName('YearActsAdvCur').AsFloat;
          mtRegActsManthSumm.Value := qrTemp1.FieldByName('MonActsAdvCur').AsFloat;
        end;
        16:
        begin
          mtRegActsAllSumm.Value := qrTemp1.FieldByName('AllActsAdvInd').AsFloat;
          mtRegActsYearSumm.Value := qrTemp1.FieldByName('YearActsAdvInd').AsFloat;
          mtRegActsManthSumm.Value := qrTemp1.FieldByName('MonActsAdvInd').AsFloat;
        end;
        17:
        begin
          mtRegActsAllSumm.Value := qrTemp1.FieldByName('AllActsMrGenPodr').AsFloat;
          mtRegActsYearSumm.Value := qrTemp1.FieldByName('YearActsMrGenPodr').AsFloat;
          mtRegActsManthSumm.Value := qrTemp1.FieldByName('MonActsMrGenPodr').AsFloat;
        end;
        18:
        begin
          mtRegActsAllSumm.Value := qrTemp1.FieldByName('AllActsCashBack').AsFloat;
          mtRegActsYearSumm.Value := qrTemp1.FieldByName('YearActsCashBack').AsFloat;
          mtRegActsManthSumm.Value := qrTemp1.FieldByName('MonActsCashBack').AsFloat;
        end;
        19:
        begin
          mtRegActsAllSumm.Value := qrTemp1.FieldByName('AllActsAdvOther').AsFloat;
          mtRegActsYearSumm.Value := qrTemp1.FieldByName('YearActsAdvOther').AsFloat;
          mtRegActsManthSumm.Value := qrTemp1.FieldByName('MonActsAdvOther').AsFloat;
        end;
        20:
        begin
          mtRegActsAllSumm.Value := qrTemp1.FieldByName('AllActsSTOIM').AsFloat;
          mtRegActsYearSumm.Value := qrTemp1.FieldByName('YearActsSTOIM').AsFloat;
          mtRegActsManthSumm.Value := qrTemp1.FieldByName('MonActsSTOIM').AsFloat;
        end;
        21:
        begin
          mtRegActsAllSumm.Value := qrTemp1.FieldByName('AllActsNalYpr').AsFloat;
          mtRegActsYearSumm.Value := qrTemp1.FieldByName('YearActsNalYpr').AsFloat;
          mtRegActsManthSumm.Value := qrTemp1.FieldByName('MonActsNalYpr').AsFloat;
        end;
        22:
        begin
          mtRegActsAllSumm.Value := qrTemp1.FieldByName('AllActsNDS').AsFloat;
          mtRegActsYearSumm.Value := qrTemp1.FieldByName('YearActsNDS').AsFloat;
          mtRegActsManthSumm.Value := qrTemp1.FieldByName('MonActsNDS').AsFloat;
        end;
        23:
        begin
          mtRegActsAllSumm.Value := qrTemp1.FieldByName('AllActsMatZakNDS').AsFloat;
          mtRegActsYearSumm.Value := qrTemp1.FieldByName('YearActsMatZakNDS').AsFloat;
          mtRegActsManthSumm.Value := qrTemp1.FieldByName('MonActsMatZakNDS').AsFloat;
        end;
        24:
        begin
          mtRegActsAllSumm.Value := qrTemp1.FieldByName('AllActsTotalStat').AsFloat;
          mtRegActsYearSumm.Value := qrTemp1.FieldByName('YearActsTotalStat').AsFloat;
          mtRegActsManthSumm.Value := qrTemp1.FieldByName('MonActsTotalStat').AsFloat;
        end;
        end;
        mtRegActs.Post;
      end;
      qrTemp1.Active := False;
    finally
      mtRegActs.EndBatch;
    end;

    mtRegActs.BeginBatch();
    try
      qrTemp1.SQL.Text :=
        'Select SSM_ID, SNAME, ' +
        '(SmEMiM + SmMr + SmTransp + SmOther + SmNal + ' +
         'SmMATZAK + SmNalYpr + SmNDS + SmDevice - ' +
         'MonActsEMiM - MonActsMr - MonActsTransp - MonActsOther - MonActsNal - ' +
         'MonActsMATZAK - MonActsNalYpr - MonActsNDS - MonActsDevice) DevMonActsSum, ' +
        '(SmEMiM - MonActsEMiM) DevMonActsEMiM, ' +
        '(SmMr - MonActsMr) DevMonActsMr, ' +
        '(SmTransp - MonActsTransp) DevMonActsTransp, ' +
        '(SmOther - MonActsOther) DevMonActsOther, ' +
        '(SmNal - MonActsNal) DevMonActsNal, ' +
        '(SmMATZAK - MonActsMATZAK) DevMonActsMATZAK, ' +
        '(SmNalYpr - MonActsNalYpr) DevMonActsNalYpr, ' +
        '(SmNDS - MonActsNDS) DevMonActsNDS, ' +
        '(SmDevice - MonActsDevice) DevMonActsDevice, ' +
        'MonActsKompMat, MonActsKompMech, ' +
        '(MonActsAdvTarg + MonActsAdvCur + MonActsAdvInd + MonActsMrGenPodr + ' +
          'MonActsCashBack + MonActsAdvOther) MonActsNoCalcSum, ' +
        'MonActsAdvTarg, MonActsAdvCur, MonActsAdvInd, MonActsMrGenPodr, ' +
        'MonActsCashBack, MonActsAdvOther, MonActsSTOIM, MonActsNalYpr, ' +
        'MonActsNDS, MonActsMatZakNDS, MonActsTotalStat ' +

        'from (' + SelRightSm + ') sm, (' + SelActs + ') monacts';
      qrTemp1.ParamByName('OBJ_ID').Value := FObjectID;
      qrTemp1.ParamByName('CurPi').Value := FPICur;
      qrTemp1.ParamByName('MonthActsDateBegin').AsDate := CurManthDateBegin;
      qrTemp1.ParamByName('MonthActsDateEnd').AsDate := CurManthDateEnd;
      qrTemp1.ParamByName('TYPE_ACT1').AsInteger := 0;
      qrTemp1.ParamByName('TYPE_ACT2').AsInteger := 0;
      qrTemp1.Active := True;

      I := 0;
      while not qrTemp1.Eof do
      begin
        inc(I);
        //Ограничение по кол-ву актов
        if I > OwnActCount then
          Break;

        TmpCol := grRegActs.Columns.Add;
        TmpCol.FieldName := 'OwnAct' + I.ToString;
        TmpCol.Title.Alignment := taCenter;
        TmpCol.Title.Caption := qrTemp1.FieldByName('SNAME').AsString;
        TmpCol.Width := 100;

        mtRegActs.First;
        J := 0;
        while not mtRegActs.Eof do
        begin
          Inc(J);
          mtRegActs.Edit;
          case J of
          1: mtRegActs.FieldByName('OwnAct' + I.ToString).Value :=
            qrTemp1.FieldByName('DevMonActsSum').AsFloat;
          2: mtRegActs.FieldByName('OwnAct' + I.ToString).Value :=
            qrTemp1.FieldByName('DevMonActsEMiM').AsFloat;
          3: mtRegActs.FieldByName('OwnAct' + I.ToString).Value :=
            qrTemp1.FieldByName('DevMonActsMr').AsFloat;
          4: mtRegActs.FieldByName('OwnAct' + I.ToString).Value :=
            qrTemp1.FieldByName('DevMonActsTransp').AsFloat;
          5: mtRegActs.FieldByName('OwnAct' + I.ToString).Value :=
            qrTemp1.FieldByName('DevMonActsOther').AsFloat;
          6: mtRegActs.FieldByName('OwnAct' + I.ToString).Value :=
            qrTemp1.FieldByName('DevMonActsNal').AsFloat;
          7: mtRegActs.FieldByName('OwnAct' + I.ToString).Value :=
            qrTemp1.FieldByName('DevMonActsMATZAK').AsFloat;
          8: mtRegActs.FieldByName('OwnAct' + I.ToString).Value :=
            qrTemp1.FieldByName('DevMonActsNalYpr').AsFloat;
          9: mtRegActs.FieldByName('OwnAct' + I.ToString).Value :=
            qrTemp1.FieldByName('DevMonActsNDS').AsFloat;
          10: mtRegActs.FieldByName('OwnAct' + I.ToString).Value :=
            qrTemp1.FieldByName('DevMonActsDevice').AsFloat;
          11: mtRegActs.FieldByName('OwnAct' + I.ToString).Value :=
            qrTemp1.FieldByName('MonActsKompMat').AsFloat;
          12: mtRegActs.FieldByName('OwnAct' + I.ToString).Value :=
            qrTemp1.FieldByName('MonActsKompMech').AsFloat;
          13: mtRegActs.FieldByName('OwnAct' + I.ToString).Value :=
            qrTemp1.FieldByName('MonActsNoCalcSum').AsFloat;
          14: mtRegActs.FieldByName('OwnAct' + I.ToString).Value :=
            qrTemp1.FieldByName('MonActsAdvTarg').AsFloat;
          15: mtRegActs.FieldByName('OwnAct' + I.ToString).Value :=
            qrTemp1.FieldByName('MonActsAdvCur').AsFloat;
          16: mtRegActs.FieldByName('OwnAct' + I.ToString).Value :=
            qrTemp1.FieldByName('MonActsAdvInd').AsFloat;
          17: mtRegActs.FieldByName('OwnAct' + I.ToString).Value :=
            qrTemp1.FieldByName('MonActsMrGenPodr').AsFloat;
          18: mtRegActs.FieldByName('OwnAct' + I.ToString).Value :=
            qrTemp1.FieldByName('MonActsCashBack').AsFloat;
          19: mtRegActs.FieldByName('OwnAct' + I.ToString).Value :=
            qrTemp1.FieldByName('MonActsAdvOther').AsFloat;
          20: mtRegActs.FieldByName('OwnAct' + I.ToString).Value :=
            qrTemp1.FieldByName('MonActsSTOIM').AsFloat;
          21: mtRegActs.FieldByName('OwnAct' + I.ToString).Value :=
            qrTemp1.FieldByName('MonActsNalYpr').AsFloat;
          22: mtRegActs.FieldByName('OwnAct' + I.ToString).Value :=
            qrTemp1.FieldByName('MonActsNDS').AsFloat;
          23: mtRegActs.FieldByName('OwnAct' + I.ToString).Value :=
            qrTemp1.FieldByName('MonActsMatZakNDS').AsFloat;
          24: mtRegActs.FieldByName('OwnAct' + I.ToString).Value :=
            qrTemp1.FieldByName('MonActsTotalStat').AsFloat;
          end;
          mtRegActs.Post;
          mtRegActs.Next;
        end;

        qrTemp1.Next
      end;
      qrTemp1.Active := False;

      if I > 0 then
      begin
        qrTemp1.SQL.Text :=
          'Select (SmEMiM + SmMr + SmTransp + SmOther + SmNal + ' +
           'SmMATZAK + SmNalYpr + SmNDS + SmDevice - ' +
           'MonActsEMiM - MonActsMr - MonActsTransp - MonActsOther - MonActsNal - ' +
           'MonActsMATZAK - MonActsNalYpr - MonActsNDS - MonActsDevice) DevMonActsSum, ' +
          '(SmEMiM - MonActsEMiM) DevMonActsEMiM, ' +
          '(SmMr - MonActsMr) DevMonActsMr, ' +
          '(SmTransp - MonActsTransp) DevMonActsTransp, ' +
          '(SmOther - MonActsOther) DevMonActsOther, ' +
          '(SmNal - MonActsNal) DevMonActsNal, ' +
          '(SmMATZAK - MonActsMATZAK) DevMonActsMATZAK, ' +
          '(SmNalYpr - MonActsNalYpr) DevMonActsNalYpr, ' +
          '(SmNDS - MonActsNDS) DevMonActsNDS, ' +
          '(SmDevice - MonActsDevice) DevMonActsDevice, ' +
          'MonActsKompMat, MonActsKompMech, ' +
          '(MonActsAdvTarg + MonActsAdvCur + MonActsAdvInd + MonActsMrGenPodr + ' +
            'MonActsCashBack + MonActsAdvOther) MonActsNoCalcSum, ' +
          'MonActsAdvTarg, MonActsAdvCur, MonActsAdvInd, MonActsMrGenPodr, ' +
          'MonActsCashBack, MonActsAdvOther, MonActsSTOIM, MonActsNalYpr, ' +
          'MonActsNDS, MonActsMatZakNDS, MonActsTotalStat ' +

          'from (' + SelRightSm + ') sm, (' + SelActs + ') monacts';
        qrTemp1.ParamByName('OBJ_ID').Value := FObjectID;
        qrTemp1.ParamByName('CurPi').Value := FPICur;
        qrTemp1.ParamByName('MonthActsDateBegin').AsDate := CurManthDateBegin;
        qrTemp1.ParamByName('MonthActsDateEnd').AsDate := CurManthDateEnd;
        qrTemp1.ParamByName('TYPE_ACT1').AsInteger := 0;
        qrTemp1.ParamByName('TYPE_ACT2').AsInteger := 0;
        qrTemp1.Active := True;

        TmpCol := grRegActs.Columns.Add;
        TmpCol.FieldName := 'OwnActs';
        TmpCol.Title.Alignment := taCenter;
        TmpCol.Title.Caption := 'Итого собств.';
        TmpCol.Width := 100;

        mtRegActs.First;
        J := 0;
        while not mtRegActs.Eof do
        begin
          Inc(J);
          mtRegActs.Edit;
          case J of
          1: mtRegActsOwnActs.Value := qrTemp1.FieldByName('DevMonActsSum').AsFloat;
          2: mtRegActsOwnActs.Value := qrTemp1.FieldByName('DevMonActsEMiM').AsFloat;
          3: mtRegActsOwnActs.Value := qrTemp1.FieldByName('DevMonActsMr').AsFloat;
          4: mtRegActsOwnActs.Value := qrTemp1.FieldByName('DevMonActsTransp').AsFloat;
          5: mtRegActsOwnActs.Value := qrTemp1.FieldByName('DevMonActsOther').AsFloat;
          6: mtRegActsOwnActs.Value := qrTemp1.FieldByName('DevMonActsNal').AsFloat;
          7: mtRegActsOwnActs.Value := qrTemp1.FieldByName('DevMonActsMATZAK').AsFloat;
          8: mtRegActsOwnActs.Value := qrTemp1.FieldByName('DevMonActsNalYpr').AsFloat;
          9: mtRegActsOwnActs.Value := qrTemp1.FieldByName('DevMonActsNDS').AsFloat;
          10: mtRegActsOwnActs.Value := qrTemp1.FieldByName('DevMonActsDevice').AsFloat;
          11: mtRegActsOwnActs.Value := qrTemp1.FieldByName('MonActsKompMat').AsFloat;
          12: mtRegActsOwnActs.Value := qrTemp1.FieldByName('MonActsKompMech').AsFloat;
          13: mtRegActsOwnActs.Value := qrTemp1.FieldByName('MonActsNoCalcSum').AsFloat;
          14: mtRegActsOwnActs.Value := qrTemp1.FieldByName('MonActsAdvTarg').AsFloat;
          15: mtRegActsOwnActs.Value := qrTemp1.FieldByName('MonActsAdvCur').AsFloat;
          16: mtRegActsOwnActs.Value := qrTemp1.FieldByName('MonActsAdvInd').AsFloat;
          17: mtRegActsOwnActs.Value := qrTemp1.FieldByName('MonActsMrGenPodr').AsFloat;
          18: mtRegActsOwnActs.Value := qrTemp1.FieldByName('MonActsCashBack').AsFloat;
          19: mtRegActsOwnActs.Value := qrTemp1.FieldByName('MonActsAdvOther').AsFloat;
          20: mtRegActsOwnActs.Value := qrTemp1.FieldByName('MonActsSTOIM').AsFloat;
          21: mtRegActsOwnActs.Value := qrTemp1.FieldByName('MonActsNalYpr').AsFloat;
          22: mtRegActsOwnActs.Value := qrTemp1.FieldByName('MonActsNDS').AsFloat;
          23: mtRegActsOwnActs.Value := qrTemp1.FieldByName('MonActsMatZakNDS').AsFloat;
          24: mtRegActsOwnActs.Value := qrTemp1.FieldByName('MonActsTotalStat').AsFloat;
          end;
          mtRegActs.Post;
          mtRegActs.Next;
        end;

        qrTemp1.Active := False;
      end;

      qrTemp1.SQL.Text :=
        'Select SSM_ID, SNAME, ' +
        '(SmEMiM + SmMr + SmTransp + SmOther + SmNal + ' +
         'SmMATZAK + SmNalYpr + SmNDS + SmDevice - ' +
         'MonActsEMiM - MonActsMr - MonActsTransp - MonActsOther - MonActsNal - ' +
         'MonActsMATZAK - MonActsNalYpr - MonActsNDS - MonActsDevice) DevMonActsSum, ' +
        '(SmEMiM - MonActsEMiM) DevMonActsEMiM, ' +
        '(SmMr - MonActsMr) DevMonActsMr, ' +
        '(SmTransp - MonActsTransp) DevMonActsTransp, ' +
        '(SmOther - MonActsOther) DevMonActsOther, ' +
        '(SmNal - MonActsNal) DevMonActsNal, ' +
        '(SmMATZAK - MonActsMATZAK) DevMonActsMATZAK, ' +
        '(SmNalYpr - MonActsNalYpr) DevMonActsNalYpr, ' +
        '(SmNDS - MonActsNDS) DevMonActsNDS, ' +
        '(SmDevice - MonActsDevice) DevMonActsDevice, ' +
        'MonActsKompMat, MonActsKompMech, ' +
        '(MonActsAdvTarg + MonActsAdvCur + MonActsAdvInd + MonActsMrGenPodr + ' +
          'MonActsCashBack + MonActsAdvOther) MonActsNoCalcSum, ' +
        'MonActsAdvTarg, MonActsAdvCur, MonActsAdvInd, MonActsMrGenPodr, ' +
        'MonActsCashBack, MonActsAdvOther, MonActsSTOIM, MonActsNalYpr, ' +
        'MonActsNDS, MonActsMatZakNDS, MonActsTotalStat ' +

        'from (' + SelRightSm + ') sm, (' + SelActs + ') monacts';
      qrTemp1.ParamByName('OBJ_ID').Value := FObjectID;
      qrTemp1.ParamByName('CurPi').Value := FPICur;
      qrTemp1.ParamByName('MonthActsDateBegin').AsDate := CurManthDateBegin;
      qrTemp1.ParamByName('MonthActsDateEnd').AsDate := CurManthDateEnd;
      qrTemp1.ParamByName('TYPE_ACT1').AsInteger := 1;
      qrTemp1.ParamByName('TYPE_ACT2').AsInteger := 1;
      qrTemp1.Active := True;

      I := 0;
      while not qrTemp1.Eof do
      begin
        inc(I);
        //Ограничение по кол-ву актов
        if I > SybActCount then
          Break;

        TmpCol := grRegActs.Columns.Add;
        TmpCol.FieldName := 'SubAct' + I.ToString;
        TmpCol.Title.Alignment := taCenter;
        TmpCol.Title.Caption := qrTemp1.FieldByName('SNAME').AsString;
        TmpCol.Width := 100;

        mtRegActs.First;
        J := 0;
        while not mtRegActs.Eof do
        begin
          Inc(J);
          mtRegActs.Edit;
          case J of
          1: mtRegActs.FieldByName('SubAct' + I.ToString).Value :=
            qrTemp1.FieldByName('DevMonActsSum').AsFloat;
          2: mtRegActs.FieldByName('SubAct' + I.ToString).Value :=
            qrTemp1.FieldByName('DevMonActsEMiM').AsFloat;
          3: mtRegActs.FieldByName('SubAct' + I.ToString).Value :=
            qrTemp1.FieldByName('DevMonActsMr').AsFloat;
          4: mtRegActs.FieldByName('SubAct' + I.ToString).Value :=
            qrTemp1.FieldByName('DevMonActsTransp').AsFloat;
          5: mtRegActs.FieldByName('SubAct' + I.ToString).Value :=
            qrTemp1.FieldByName('DevMonActsOther').AsFloat;
          6: mtRegActs.FieldByName('SubAct' + I.ToString).Value :=
            qrTemp1.FieldByName('DevMonActsNal').AsFloat;
          7: mtRegActs.FieldByName('SubAct' + I.ToString).Value :=
            qrTemp1.FieldByName('DevMonActsMATZAK').AsFloat;
          8: mtRegActs.FieldByName('SubAct' + I.ToString).Value :=
            qrTemp1.FieldByName('DevMonActsNalYpr').AsFloat;
          9: mtRegActs.FieldByName('SubAct' + I.ToString).Value :=
            qrTemp1.FieldByName('DevMonActsNDS').AsFloat;
          10: mtRegActs.FieldByName('SubAct' + I.ToString).Value :=
            qrTemp1.FieldByName('DevMonActsDevice').AsFloat;
          11: mtRegActs.FieldByName('SubAct' + I.ToString).Value :=
            qrTemp1.FieldByName('MonActsKompMat').AsFloat;
          12: mtRegActs.FieldByName('SubAct' + I.ToString).Value :=
            qrTemp1.FieldByName('MonActsKompMech').AsFloat;
          13: mtRegActs.FieldByName('SubAct' + I.ToString).Value :=
            qrTemp1.FieldByName('MonActsNoCalcSum').AsFloat;
          14: mtRegActs.FieldByName('SubAct' + I.ToString).Value :=
            qrTemp1.FieldByName('MonActsAdvTarg').AsFloat;
          15: mtRegActs.FieldByName('SubAct' + I.ToString).Value :=
            qrTemp1.FieldByName('MonActsAdvCur').AsFloat;
          16: mtRegActs.FieldByName('SubAct' + I.ToString).Value :=
            qrTemp1.FieldByName('MonActsAdvInd').AsFloat;
          17: mtRegActs.FieldByName('SubAct' + I.ToString).Value :=
            qrTemp1.FieldByName('MonActsMrGenPodr').AsFloat;
          18: mtRegActs.FieldByName('SubAct' + I.ToString).Value :=
            qrTemp1.FieldByName('MonActsCashBack').AsFloat;
          19: mtRegActs.FieldByName('SubAct' + I.ToString).Value :=
            qrTemp1.FieldByName('MonActsAdvOther').AsFloat;
          20: mtRegActs.FieldByName('SubAct' + I.ToString).Value :=
            qrTemp1.FieldByName('MonActsSTOIM').AsFloat;
          21: mtRegActs.FieldByName('SubAct' + I.ToString).Value :=
            qrTemp1.FieldByName('MonActsNalYpr').AsFloat;
          22: mtRegActs.FieldByName('SubAct' + I.ToString).Value :=
            qrTemp1.FieldByName('MonActsNDS').AsFloat;
          23: mtRegActs.FieldByName('SubAct' + I.ToString).Value :=
            qrTemp1.FieldByName('MonActsMatZakNDS').AsFloat;
          24: mtRegActs.FieldByName('SubAct' + I.ToString).Value :=
            qrTemp1.FieldByName('MonActsTotalStat').AsFloat;
          end;
          mtRegActs.Post;
          mtRegActs.Next;
        end;

        qrTemp1.Next
      end;
      qrTemp1.Active := False;

      if I > 0 then
      begin
        qrTemp1.SQL.Text :=
          'Select (SmEMiM + SmMr + SmTransp + SmOther + SmNal + ' +
           'SmMATZAK + SmNalYpr + SmNDS + SmDevice - ' +
           'MonActsEMiM - MonActsMr - MonActsTransp - MonActsOther - MonActsNal - ' +
           'MonActsMATZAK - MonActsNalYpr - MonActsNDS - MonActsDevice) DevMonActsSum, ' +
          '(SmEMiM - MonActsEMiM) DevMonActsEMiM, ' +
          '(SmMr - MonActsMr) DevMonActsMr, ' +
          '(SmTransp - MonActsTransp) DevMonActsTransp, ' +
          '(SmOther - MonActsOther) DevMonActsOther, ' +
          '(SmNal - MonActsNal) DevMonActsNal, ' +
          '(SmMATZAK - MonActsMATZAK) DevMonActsMATZAK, ' +
          '(SmNalYpr - MonActsNalYpr) DevMonActsNalYpr, ' +
          '(SmNDS - MonActsNDS) DevMonActsNDS, ' +
          '(SmDevice - MonActsDevice) DevMonActsDevice, ' +
          'MonActsKompMat, MonActsKompMech, ' +
          '(MonActsAdvTarg + MonActsAdvCur + MonActsAdvInd + MonActsMrGenPodr + ' +
            'MonActsCashBack + MonActsAdvOther) MonActsNoCalcSum, ' +
          'MonActsAdvTarg, MonActsAdvCur, MonActsAdvInd, MonActsMrGenPodr, ' +
          'MonActsCashBack, MonActsAdvOther, MonActsSTOIM, MonActsNalYpr, ' +
          'MonActsNDS, MonActsMatZakNDS, MonActsTotalStat ' +

          'from (' + SelRightSm + ') sm, (' + SelActs + ') monacts';
        qrTemp1.ParamByName('OBJ_ID').Value := FObjectID;
        qrTemp1.ParamByName('CurPi').Value := FPICur;
        qrTemp1.ParamByName('MonthActsDateBegin').AsDate := CurManthDateBegin;
        qrTemp1.ParamByName('MonthActsDateEnd').AsDate := CurManthDateEnd;
        qrTemp1.ParamByName('TYPE_ACT1').AsInteger := 1;
        qrTemp1.ParamByName('TYPE_ACT2').AsInteger := 1;
        qrTemp1.Active := True;

        TmpCol := grRegActs.Columns.Add;
        TmpCol.FieldName := 'SubActs';
        TmpCol.Title.Alignment := taCenter;
        TmpCol.Title.Caption := 'Итого субподряд.';
        TmpCol.Width := 100;

        mtRegActs.First;
        J := 0;
        while not mtRegActs.Eof do
        begin
          Inc(J);
          mtRegActs.Edit;
          case J of
          1: mtRegActsSubActs.Value := qrTemp1.FieldByName('DevMonActsSum').AsFloat;
          2: mtRegActsSubActs.Value := qrTemp1.FieldByName('DevMonActsEMiM').AsFloat;
          3: mtRegActsSubActs.Value := qrTemp1.FieldByName('DevMonActsMr').AsFloat;
          4: mtRegActsSubActs.Value := qrTemp1.FieldByName('DevMonActsTransp').AsFloat;
          5: mtRegActsSubActs.Value := qrTemp1.FieldByName('DevMonActsOther').AsFloat;
          6: mtRegActsSubActs.Value := qrTemp1.FieldByName('DevMonActsNal').AsFloat;
          7: mtRegActsSubActs.Value := qrTemp1.FieldByName('DevMonActsMATZAK').AsFloat;
          8: mtRegActsSubActs.Value := qrTemp1.FieldByName('DevMonActsNalYpr').AsFloat;
          9: mtRegActsSubActs.Value := qrTemp1.FieldByName('DevMonActsNDS').AsFloat;
          10: mtRegActsSubActs.Value := qrTemp1.FieldByName('DevMonActsDevice').AsFloat;
          11: mtRegActsSubActs.Value := qrTemp1.FieldByName('MonActsKompMat').AsFloat;
          12: mtRegActsSubActs.Value := qrTemp1.FieldByName('MonActsKompMech').AsFloat;
          13: mtRegActsSubActs.Value := qrTemp1.FieldByName('MonActsNoCalcSum').AsFloat;
          14: mtRegActsSubActs.Value := qrTemp1.FieldByName('MonActsAdvTarg').AsFloat;
          15: mtRegActsSubActs.Value := qrTemp1.FieldByName('MonActsAdvCur').AsFloat;
          16: mtRegActsSubActs.Value := qrTemp1.FieldByName('MonActsAdvInd').AsFloat;
          17: mtRegActsSubActs.Value := qrTemp1.FieldByName('MonActsMrGenPodr').AsFloat;
          18: mtRegActsSubActs.Value := qrTemp1.FieldByName('MonActsCashBack').AsFloat;
          19: mtRegActsSubActs.Value := qrTemp1.FieldByName('MonActsAdvOther').AsFloat;
          20: mtRegActsSubActs.Value := qrTemp1.FieldByName('MonActsSTOIM').AsFloat;
          21: mtRegActsSubActs.Value := qrTemp1.FieldByName('MonActsNalYpr').AsFloat;
          22: mtRegActsSubActs.Value := qrTemp1.FieldByName('MonActsNDS').AsFloat;
          23: mtRegActsSubActs.Value := qrTemp1.FieldByName('MonActsMatZakNDS').AsFloat;
          24: mtRegActsSubActs.Value := qrTemp1.FieldByName('MonActsTotalStat').AsFloat;
          end;
          mtRegActs.Post;
          mtRegActs.Next;
        end;

        qrTemp1.Active := False;
      end;
    finally
      mtRegActs.EndBatch;
    end;
  end;
end;

end.
