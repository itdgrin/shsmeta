unit fReportC2B;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.Buttons, Vcl.StdCtrls, Tools, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Vcl.Mask, Vcl.DBCtrls,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtCtrls,
  System.Actions, Vcl.ActnList, Vcl.ComCtrls, Vcl.Samples.Spin, Vcl.Grids,
  Vcl.DBGrids, JvExDBGrids, JvDBGrid;

type
  TLeftRec = record
    SmId: Integer;
    ParId: Integer;
    SmType: Integer;
    Price: Currency;
  end;

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

const DevItems: array[1..24] of string =
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
begin
  ClientWidth := FormMain.ClientWidth div 2;
  ClientHeight := FormMain.ClientHeight div 2;
  Top := 30;
  Left := 30;
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
  end;

  cbObjName.KeyValue := qrObject.FieldByName('obj_id').Value;
  cbObjName.OnClick(cbObjName);
  pcReportTypeChange(pcReportType);
end;

procedure TFormReportC2B.FormDestroy(Sender: TObject);
begin
  // Удаляем кнопку от этого окна (на главной форме внизу)
  FormMain.DeleteButtonCloseWindow(CaptionButton);
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
begin

  grLeft.Columns[1].Visible := False;
  grLeft.Columns[2].Visible := False;
  if pcReportType.ActivePage = tsRepObj then
  begin
      lbShowTypeTitle.Parent := pnlRepObjDate;
      cbShowType.Parent := pnlRepObjDate;
      pnlGrids.Parent := pnlRepObj;

      grLeft.Columns[4].Visible := False;
      grLeft.Columns[5].Visible := False;
      grLeft.Columns[6].Visible := False;//True;
      grLeft.Columns[7].Visible := True;
      grLeft.Columns[8].Visible := False;//True;
      grLeft.Columns[9].Visible := True;
      grLeft.Columns[10].Visible := True;

      grRight.Columns[1].Visible := True;
      grRight.Columns[2].Visible := False;
      grRight.Columns[3].Visible := False;
  end;
  if pcReportType.ActivePage = tsRepAct then
  begin
      lbShowTypeTitle.Parent := pnlRepActDate;
      cbShowType.Parent := pnlRepActDate;
      pnlGrids.Parent := pnlRepAct;

      grLeft.Columns[4].Visible := False;//True;
      grLeft.Columns[5].Visible := True;
      grLeft.Columns[6].Visible := False;
      grLeft.Columns[7].Visible := False;
      grLeft.Columns[8].Visible := False;
      grLeft.Columns[9].Visible := False;
      grLeft.Columns[10].Visible := False;

      grRight.Columns[1].Visible := False;
      grRight.Columns[2].Visible := True;
      grRight.Columns[3].Visible := True;
  end;

  BuildReport();
end;

procedure TFormReportC2B.qrObjectBeforeOpen(DataSet: TDataSet);
begin
  if (DataSet as TFDQuery).FindParam('USER_ID') <> nil then
    (DataSet as TFDQuery).ParamByName('USER_ID').Value := G_USER_ID;
end;

procedure TFormReportC2B.BuildReport();
var RepType: Integer;
    ShowTypeStr: string;
    ContPriceTypeStr: string;
    CurActId: Integer;
    SelectPriceStr,
    SelectSmStr,
    SelectCurAct,
    SelectAllActs,
    SelectMonthActs: string;
    CurManthDateBegin,
    CurManthDateEnd: TDateTime;

    SumSmTotalPrice, SumActTotalPrice,
    SumAllActsTotalPrice, SumManthActsTotalPrice,
    SumRestPrice: Double;

    I: Integer;
begin
  RepType := pcReportType.ActivePageIndex;

  //Заполнение левой таблицы
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

  CurManthDateBegin := EncodeDate(seRepObjYear.Value, cbRepObjMonth.ItemIndex + 1, 1);
  CurManthDateEnd :=  IncMonth(CurManthDateBegin, 1) - 1;

  if not mtLeft.Active then
    mtLeft.Active :=True;
  mtLeft.EmptyDataSet;

  mtLeft.BeginBatch();
  try
    //Получение контрактной цены
    SelectPriceStr :=
      'Select s.SM_ID SM_ID, Sum(cp.CONTRACT_PRICE) CPRICE ' +
      'from smetasourcedata s left join contract_price cp ' +
      'on cp.SM_ID IN (SELECT SM_ID FROM smetasourcedata WHERE ' +
        '(DELETED=0) AND (SM_TYPE in (' + ContPriceTypeStr + ')) AND ' +
        '(OBJ_ID = :OBJ_ID)  and (ACT = 0) AND ' +
        '((smetasourcedata.SM_ID = s.SM_ID) OR ' +
        '(smetasourcedata.PARENT_ID = s.SM_ID) OR ' +
        '(smetasourcedata.PARENT_ID IN (SELECT SM_ID FROM smetasourcedata ' +
          'WHERE PARENT_ID = s.SM_ID AND DELETED=0)))) ' +
      'where (cp.OnDate BETWEEN :DateBergin AND :DateEnd) and ' +
        '(s.OBJ_ID = :OBJ_ID) and (s.DELETED=0) and (s.ACT = 0) ' +
      'group by SM_ID';
    //Получение списка смет с ценами
    SelectSmStr :=
      'SELECT FN_getSortSM(sm.SM_ID) SortSM, sm.SM_TYPE SM_TYPE, ' +
        'CONCAT(IF(sm.SM_TYPE = 2, "", IF(sm.SM_TYPE = 1, "  ", "    ")), ' +
          'IFNULL(sm.SM_NUMBER, ""), " ",  IFNULL(sm.NAME, "")) SmNAME, ' +
        'sm.SM_NUMBER SM_NUMBER, sm.SM_ID SM_ID, cp.CPRICE CPRICE, ' +
        'sm.PARENT_ID PARENT_ID ' +
      'FROM smetasourcedata sm ' +
      'LEFT JOIN (' + SelectPriceStr + ') cp on sm.SM_ID = cp.SM_ID ' +
      'WHERE sm.SM_ID IN (SELECT SM_ID FROM smetasourcedata ' +
        'WHERE (SM_ID = sm.SM_ID) OR (PARENT_ID = sm.SM_ID) OR ' +
        '(PARENT_ID IN (SELECT SM_ID FROM smetasourcedata ' +
          'WHERE PARENT_ID = sm.SM_ID))) ' +
      'AND sm.DELETED=0 ' +
      'and sm.ACT = 0 AND sm.OBJ_ID = :OBJ_ID ' +
      'union ' +
      'Select 99999999999 SortSM, null SM_TYPE, null SmNAME, null SM_NUMBER, ' +
        'null SM_ID, null CPRICE, null PARENT_ID';
    //Получения стоимости текущего акта
    SelectCurAct :=
      'Select s.SM_ID SM_ID, Sum(at.ACTPRICE) ACTPRICE ' +
      'from smetasourcedata s left join ' +
	      '(Select s.SOURCE_ID SOURCE_ID, SUM(IFNULL(d.STOIMF, d.STOIM )) AS ACTPRICE ' +
        'FROM smetasourcedata s, summary_calculation d ' +
        'WHERE (s.DELETED = 0) AND (s.OBJ_ID = :OBJ_ID) AND ' +
        '(d.SM_ID = s.SM_ID) AND (s.SM_ID in ' +
          '(SELECT SM_ID FROM smetasourcedata WHERE (DELETED=0) AND ' +
          '(smetasourcedata.PARENT_ID IN ' +
          '(SELECT SM_ID FROM smetasourcedata WHERE PARENT_ID = :SM_ID AND DELETED=0)))) ' +
        'GROUP BY SOURCE_ID) at ' +
      'on at.SOURCE_ID IN (SELECT SM_ID FROM smetasourcedata ' +
        'WHERE (DELETED=0) AND ' +
          '(OBJ_ID = :OBJ_ID)  and (ACT = 0) AND ' +
          '((smetasourcedata.SM_ID = s.SM_ID) OR ' +
          '(smetasourcedata.PARENT_ID = s.SM_ID) OR ' +
          '(smetasourcedata.PARENT_ID IN (SELECT SM_ID FROM smetasourcedata ' +
            'WHERE PARENT_ID = s.SM_ID AND DELETED=0)))) ' +
      'where (s.OBJ_ID = :OBJ_ID) and (s.DELETED=0) and (s.ACT = 0) ' +
      'group by SM_ID ' +
      'union ' +  //union нужен так как MySql не поддерживает full outer join
      'Select s.SM_ID SM_ID, Sum(at.ACTPRICE) ACTPRICE ' +
      'from smetasourcedata s right join ' +
	      '(Select s.SOURCE_ID SOURCE_ID, SUM(IFNULL(d.STOIMF, d.STOIM )) AS ACTPRICE ' +
        'FROM smetasourcedata s, summary_calculation d ' +
        'WHERE (s.DELETED = 0) AND (s.OBJ_ID = :OBJ_ID) AND ' +
        '(d.SM_ID = s.SM_ID) AND (s.SM_ID in ' +
          '(SELECT SM_ID FROM smetasourcedata WHERE (DELETED=0) AND ' +
          '(smetasourcedata.PARENT_ID IN ' +
          '(SELECT SM_ID FROM smetasourcedata WHERE PARENT_ID = :SM_ID AND DELETED=0)))) ' +
        'GROUP BY SOURCE_ID) at ' +
      'on at.SOURCE_ID IN (SELECT SM_ID FROM smetasourcedata ' +
        'WHERE (DELETED=0) AND ' +
          '(OBJ_ID = :OBJ_ID)  and (ACT = 0) AND ' +
          '((smetasourcedata.SM_ID = s.SM_ID) OR ' +
          '(smetasourcedata.PARENT_ID = s.SM_ID) OR ' +
          '(smetasourcedata.PARENT_ID IN (SELECT SM_ID FROM smetasourcedata ' +
            'WHERE PARENT_ID = s.SM_ID AND DELETED=0)))) ' +
      'where (s.OBJ_ID = :OBJ_ID) and (s.DELETED=0) and (s.ACT = 0) ' +
      'group by SM_ID';
    //Получения стоимости по всем актам
    SelectAllActs :=
      'Select s.SM_ID SM_ID, Sum(at.AllACTSPRICE) AllACTSPRICE ' +
      'from smetasourcedata s left join ' +
	      '(Select s.SOURCE_ID SOURCE_ID, SUM(IFNULL(d.STOIMF, d.STOIM )) AS AllACTSPRICE ' +
        'FROM smetasourcedata s, summary_calculation d ' +
        'WHERE (s.DELETED = 0) AND (s.OBJ_ID = :OBJ_ID) AND ' +
        '(d.SM_ID = s.SM_ID) AND (s.SM_ID in ' +
          '(Select SM_ID FROM smetasourcedata ' +
          'WHERE (DELETED = 0) AND (PARENT_ID in (Select SM_ID FROM smetasourcedata ' +
            'WHERE (PARENT_ID in (Select SM_ID FROM smetasourcedata ' +
              'WHERE (OBJ_ID = :OBJ_ID) AND (DELETED = 0) AND (ACT = 1) AND ' +
              '(SM_TYPE = 2) AND (DATE BETWEEN :AllActsDateBegin AND :AllActsDateEnd))))))) ' +
        'GROUP BY SOURCE_ID) at ' +
      'on at.SOURCE_ID IN (SELECT SM_ID FROM smetasourcedata ' +
        'WHERE (DELETED=0) AND ' +
          '(OBJ_ID = :OBJ_ID)  and (ACT = 0) AND ' +
          '((smetasourcedata.SM_ID = s.SM_ID) OR ' +
          '(smetasourcedata.PARENT_ID = s.SM_ID) OR ' +
          '(smetasourcedata.PARENT_ID IN (SELECT SM_ID FROM smetasourcedata ' +
            'WHERE PARENT_ID = s.SM_ID AND DELETED=0)))) ' +
      'where (s.OBJ_ID = :OBJ_ID) and (s.DELETED=0) and (s.ACT = 0) ' +
      'group by SM_ID ' +
      'union ' +  //union нужен так как MySql не поддерживает full outer join
      'Select s.SM_ID SM_ID, Sum(at.AllACTSPRICE) AllACTSPRICE ' +
      'from smetasourcedata s right join ' +
	      '(Select s.SOURCE_ID SOURCE_ID, SUM(IFNULL(d.STOIMF, d.STOIM )) AS AllACTSPRICE ' +
        'FROM smetasourcedata s, summary_calculation d ' +
        'WHERE (s.DELETED = 0) AND (s.OBJ_ID = :OBJ_ID) AND ' +
        '(d.SM_ID = s.SM_ID) AND (s.SM_ID in ' +
          '(Select SM_ID FROM smetasourcedata ' +
          'WHERE (DELETED = 0) AND (PARENT_ID in (Select SM_ID FROM smetasourcedata ' +
            'WHERE (PARENT_ID in (Select SM_ID FROM smetasourcedata ' +
              'WHERE (OBJ_ID = :OBJ_ID) AND (DELETED = 0) AND (ACT = 1) AND ' +
              '(SM_TYPE = 2) AND (DATE BETWEEN :AllActsDateBegin AND :AllActsDateEnd))))))) ' +
        'GROUP BY SOURCE_ID) at ' +
      'on at.SOURCE_ID IN (SELECT SM_ID FROM smetasourcedata ' +
        'WHERE (DELETED=0) AND ' +
          '(OBJ_ID = :OBJ_ID)  and (ACT = 0) AND ' +
          '((smetasourcedata.SM_ID = s.SM_ID) OR ' +
          '(smetasourcedata.PARENT_ID = s.SM_ID) OR ' +
          '(smetasourcedata.PARENT_ID IN (SELECT SM_ID FROM smetasourcedata ' +
            'WHERE PARENT_ID = s.SM_ID AND DELETED=0)))) ' +
      'where (s.OBJ_ID = :OBJ_ID) and (s.DELETED=0) and (s.ACT = 0) ' +
      'group by SM_ID';
    //Получения стоимости по актамза месяц
    SelectMonthActs :=
      'Select s.SM_ID SM_ID, Sum(at.MONTHACTSPRICE) MONTHACTSPRICE ' +
      'from smetasourcedata s left join ' +
	      '(Select s.SOURCE_ID SOURCE_ID, SUM(IFNULL(d.STOIMF, d.STOIM )) AS MONTHACTSPRICE ' +
        'FROM smetasourcedata s, summary_calculation d ' +
        'WHERE (s.DELETED = 0) AND (s.OBJ_ID = :OBJ_ID) AND ' +
        '(d.SM_ID = s.SM_ID) AND (s.SM_ID in ' +
          '(Select SM_ID FROM smetasourcedata ' +
          'WHERE (DELETED = 0) AND (PARENT_ID in (Select SM_ID FROM smetasourcedata ' +
            'WHERE (PARENT_ID in (Select SM_ID FROM smetasourcedata ' +
              'WHERE (OBJ_ID = :OBJ_ID) AND (DELETED = 0) AND (ACT = 1) AND ' +
              '(SM_TYPE = 2) AND (DATE BETWEEN :MonthActsDateBegin AND :MonthActsDateEnd))))))) ' +
        'GROUP BY SOURCE_ID) at ' +
      'on at.SOURCE_ID IN (SELECT SM_ID FROM smetasourcedata ' +
        'WHERE (DELETED=0) AND ' +
          '(OBJ_ID = :OBJ_ID)  and (ACT = 0) AND ' +
          '((smetasourcedata.SM_ID = s.SM_ID) OR ' +
          '(smetasourcedata.PARENT_ID = s.SM_ID) OR ' +
          '(smetasourcedata.PARENT_ID IN (SELECT SM_ID FROM smetasourcedata ' +
            'WHERE PARENT_ID = s.SM_ID AND DELETED=0)))) ' +
      'where (s.OBJ_ID = :OBJ_ID) and (s.DELETED=0) and (s.ACT = 0) ' +
      'group by SM_ID ' +
      'union ' +  //union нужен так как MySql не поддерживает full outer join
      'Select s.SM_ID SM_ID, Sum(at.MONTHACTSPRICE) MONTHACTSPRICE ' +
      'from smetasourcedata s right join ' +
	      '(Select s.SOURCE_ID SOURCE_ID, SUM(IFNULL(d.STOIMF, d.STOIM )) AS MONTHACTSPRICE ' +
        'FROM smetasourcedata s, summary_calculation d ' +
        'WHERE (s.DELETED = 0) AND (s.OBJ_ID = :OBJ_ID) AND ' +
        '(d.SM_ID = s.SM_ID) AND (s.SM_ID in ' +
          '(Select SM_ID FROM smetasourcedata ' +
          'WHERE (DELETED = 0) AND (PARENT_ID in (Select SM_ID FROM smetasourcedata ' +
            'WHERE (PARENT_ID in (Select SM_ID FROM smetasourcedata ' +
              'WHERE (OBJ_ID = :OBJ_ID) AND (DELETED = 0) AND (ACT = 1) AND ' +
              '(SM_TYPE = 2) AND (DATE BETWEEN :MonthActsDateBegin AND :MonthActsDateEnd))))))) ' +
        'GROUP BY SOURCE_ID) at ' +
      'on at.SOURCE_ID IN (SELECT SM_ID FROM smetasourcedata ' +
        'WHERE (DELETED=0) AND ' +
          '(OBJ_ID = :OBJ_ID)  and (ACT = 0) AND ' +
          '((smetasourcedata.SM_ID = s.SM_ID) OR ' +
          '(smetasourcedata.PARENT_ID = s.SM_ID) OR ' +
          '(smetasourcedata.PARENT_ID IN (SELECT SM_ID FROM smetasourcedata ' +
            'WHERE PARENT_ID = s.SM_ID AND DELETED=0)))) ' +
      'where (s.OBJ_ID = :OBJ_ID) and (s.DELETED=0) and (s.ACT = 0) ' +
      'group by SM_ID';

    qrTemp1.SQL.Text := 'Select SortSM, SM_TYPE, SmNAME, SM_NUMBER, SmTab.SM_ID SM_ID, ' +
      'CPRICE, PARENT_ID, ACTPRICE, AllACTSPRICE, MONTHACTSPRICE ' +
      'from (' + SelectSmStr + ') SmTab ' +
      'LEFT JOIN (' + SelectCurAct + ') CurActTab ON SmTab.SM_ID = CurActTab.SM_ID ' +
      'LEFT JOIN (' + SelectAllActs + ') AllActsTab ON SmTab.SM_ID = AllActsTab.SM_ID ' +
      'LEFT JOIN (' + SelectMonthActs + ') MonthActsTab ON SmTab.SM_ID = MonthActsTab.SM_ID ' +
      'WHERE (SM_TYPE in (' + ShowTypeStr + ')) OR (SM_TYPE is NULL) ' +
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
    qrTemp1.Close;

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
    for I := Low(DevItems) to High(DevItems) do
    begin
      mtRight.Append;
      mtRightDevItem.Value := DevItems[I];
      mtRight.Post;
    end;
  finally
    mtRight.EndBatch;
  end;
end;

end.
