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
    mtRightItemSumm: TCurrencyField;
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
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actObjectUpdateUpdate(Sender: TObject);
    procedure btnObjInfoClick(Sender: TObject);
    procedure cbObjNameClick(Sender: TObject);
    procedure qrObjectBeforeOpen(DataSet: TDataSet);
    procedure pcReportTypeChange(Sender: TObject);
    procedure cbShowTypeClick(Sender: TObject);
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

procedure TFormReportC2B.OwnPanelButtonClick;
begin
  if Assigned(FOwnPanelButton) then
    FOwnPanelButton.OnClick(FOwnPanelButton);
end;

procedure TFormReportC2B.pcReportTypeChange(Sender: TObject);
begin
  if pcReportType.ActivePage = tsRepObj then
  begin
      lbShowTypeTitle.Parent := pnlRepObjDate;
      cbShowType.Parent := pnlRepObjDate;
      pnlGrids.Parent := pnlRepObj;

      grLeft.Columns[4].Visible := False;
      grLeft.Columns[5].Visible := False;
      grLeft.Columns[6].Visible := True;
      grLeft.Columns[7].Visible := True;
      grLeft.Columns[8].Visible := True;
      grLeft.Columns[9].Visible := True;
      grLeft.Columns[10].Visible := True;
  end;
  if pcReportType.ActivePage = tsRepAct then
  begin
      lbShowTypeTitle.Parent := pnlRepActDate;
      cbShowType.Parent := pnlRepActDate;
      pnlGrids.Parent := pnlRepAct;

      grLeft.Columns[4].Visible := True;
      grLeft.Columns[5].Visible := True;
      grLeft.Columns[6].Visible := False;
      grLeft.Columns[7].Visible := False;
      grLeft.Columns[8].Visible := False;
      grLeft.Columns[9].Visible := False;
      grLeft.Columns[10].Visible := False;
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
    SelectPriceStr,
    SelectPriceStr1,
    SelectPriceStr2,
    SelectPriceStr3: string;
    LeftArray: array of TLeftRec;
    I, J, Ind: Integer;
    TmpPrice: Currency;
begin
  RepType := pcReportType.ActivePageIndex;

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

  if not mtLeft.Active then
    mtLeft.Active :=True;
  mtLeft.EmptyDataSet;

  mtLeft.BeginBatch();
  try
    SelectPriceStr1 :=
      'Select SM_ID SM_ID, Sum(CONTRACT_PRICE) CPRICE from contract_price cprice ' +
      'where (OnDate BETWEEN :DateBergin AND :DateEnd) and ' +
        '(SM_ID IN (SELECT SM_ID FROM smetasourcedata ' +
          'WHERE (OBJ_ID = :OBJ_ID) and (SM_TYPE in (' + ContPriceTypeStr + '))))' +
      'group by SM_ID';

    SelectPriceStr2 :=
      'Select PARENT_ID SM_ID, kctab.CPRICE CPRICE from ' +
      'smetasourcedata sm, (' + SelectPriceStr1 + ') kctab ' +
      'where sm.SM_ID = kctab.SM_ID ' +
      'group by SM_ID';

    SelectPriceStr3 :=
      'Select PARENT_ID SM_ID, kctab.CPRICE CPRICE from ' +
      'smetasourcedata sm, (' + SelectPriceStr2 + ') kctab ' +
      'where sm.SM_ID = kctab.SM_ID ' +
      'group by SM_ID';

    SelectPriceStr := SelectPriceStr1 + ' union ' +
      SelectPriceStr2 + ' union ' + SelectPriceStr3;

    qrTemp1.SQL.Text :=
      'SELECT FN_getSortSM(sm.SM_ID) SortSM, sm.SM_TYPE SM_TYPE, ' +
        'CONCAT(IF(sm.SM_TYPE = 2, "", IF(sm.SM_TYPE = 1, "  ", "    ")), ' +
          'IFNULL(sm.SM_NUMBER, ""), " ",  IFNULL(sm.NAME, "")) SmNAME, ' +
        'sm.SM_NUMBER SM_NUMBER, sm.SM_ID SM_ID, cp.CPRICE, sm.PARENT_ID PARENT_ID ' +
      'FROM smetasourcedata sm ' +
      'LEFT JOIN (' + SelectPriceStr + ') cp on sm.SM_ID = cp.SM_ID ' +
      'WHERE sm.SM_ID IN (SELECT SM_ID FROM smetasourcedata ' +
        'WHERE (SM_ID = sm.SM_ID) OR (PARENT_ID = sm.SM_ID) OR ' +
        '(PARENT_ID IN (SELECT SM_ID FROM smetasourcedata ' +
          'WHERE PARENT_ID = sm.SM_ID))) ' +
      'AND sm.SM_TYPE in (' + ShowTypeStr + ') and sm.DELETED=0 ' +
      'and sm.ACT = 0 AND sm.OBJ_ID = :OBJ_ID ' +
      'ORDER BY 1,4,5';
    qrTemp1.ParamByName('OBJ_ID').Value := FObjectID;
    qrTemp1.ParamByName('DateBergin').AsDate := FBeginDate;
    qrTemp1.ParamByName('DateEnd').AsDate := FEndDate;
    qrTemp1.Active := True;
    Ind := 0;
    while not qrTemp1.Eof do
    begin
      inc(Ind);
      SetLength(LeftArray, Ind);
      LeftArray[Ind - 1].SmId := qrTemp1.FieldByName('SM_ID').AsInteger;
      LeftArray[Ind - 1].ParId := qrTemp1.FieldByName('PARENT_ID').AsInteger;
      LeftArray[Ind - 1].SmType := qrTemp1.FieldByName('SM_TYPE').AsInteger;
      LeftArray[Ind - 1].Price := qrTemp1.FieldByName('CPRICE').AsFloat;

      mtLeft.Append;
      mtLeftSmName.Value := qrTemp1.FieldByName('SmNAME').AsAnsiString;
      mtLeftSmId.Value := LeftArray[Ind - 1].SmId;
      mtLeftSmType.Value := LeftArray[Ind - 1].SmType;
      mtLeftSmTotalPrice.Value := LeftArray[Ind - 1].Price;
      mtLeft.Post;

      qrTemp1.Next;
    end;
    qrTemp1.Close;

    //Расчет цен локальных смет
    for I := Low(LeftArray) to High(LeftArray) do
    begin
      if (LeftArray[I].SmType = 1) and (LeftArray[I].Price = 0) then
      begin
        TmpPrice := 0;
        for J := Low(LeftArray) to High(LeftArray) do
          if LeftArray[J].ParId = LeftArray[I].SmId then
            TmpPrice := TmpPrice + LeftArray[J].Price;
        LeftArray[I].Price := TmpPrice;
      end;
    end;

    //Расчет цен объектных смет
    for I := Low(LeftArray) to High(LeftArray) do
    begin
      if (LeftArray[I].SmType = 2) and (LeftArray[I].Price = 0) then
      begin
        TmpPrice := 0;
        for J := Low(LeftArray) to High(LeftArray) do
          if LeftArray[J].ParId = LeftArray[I].SmId then
            TmpPrice := TmpPrice + LeftArray[J].Price;
        LeftArray[I].Price := TmpPrice;
      end;
    end;

    mtLeft.First;
    if not mtLeft.IsEmpty then
    begin
      for I := Low(LeftArray) to High(LeftArray) do
      begin
        if (mtLeftSmType.Value in [1,2]) and
           (mtLeftSmTotalPrice.Value = 0) then
        begin
          mtLeft.Edit;
          mtLeftSmTotalPrice.Value := LeftArray[I].Price;
          mtLeft.Post;
        end;
        mtLeft.Next;
      end;
    end;
  finally
    mtLeft.EndBatch;
  end;
end;

end.
