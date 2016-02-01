unit fReportSSR;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Tools,
  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, System.UITypes,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.Grids, Vcl.DBGrids,
  JvExDBGrids, JvDBGrid, FireDAC.Stan.Async, FireDAC.DApt, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Buttons,
  Vcl.ExtCtrls;

type
  TKoefRec = record
    LineNom: string;
    Pers: Variant;
    Koef1: Variant;
    Koef2: Variant;
    SprID: Variant;
  end;
  TKoefArray = array of TKoefRec;

  TRepSSRLine = record
    ZP,
    ZP5,
    EMiM,
    ZPMash,
    Mat,
    MatTransp,
    OXROPR,
    PlanPrib,
    Devices,
    Transp,
    Other,
    Total,
    Trud: Double;
    procedure CalcTotal;
  end;

  TFormReportSSR = class(TSmForm)
    pnlGrid: TPanel;
    grSSR: TJvDBGrid;
    mtSSR: TFDMemTable;
    dsSSR: TDataSource;
    mtSSRNum: TStringField;
    mtSSRPepcent: TFloatField;
    mtSSRKoef1: TFloatField;
    mtSSRKoef2: TFloatField;
    mtSSRTransp: TCurrencyField;
    mtSSROXROPR: TCurrencyField;
    mtSSRPlanPrib: TCurrencyField;
    mtSSRDevices: TCurrencyField;
    mtSSRZP: TCurrencyField;
    mtSSRZP5: TCurrencyField;
    mtSSREMiM: TCurrencyField;
    mtSSRZPMash: TCurrencyField;
    mtSSRMat: TCurrencyField;
    mtSSRMatTransp: TCurrencyField;
    mtSSROther: TCurrencyField;
    mtSSRTotal: TCurrencyField;
    mtSSRTrud: TCurrencyField;
    gbObject: TGroupBox;
    lbObjName: TLabel;
    cbObjName: TDBLookupComboBox;
    edtObjContNum: TEdit;
    lbObjContNum: TLabel;
    edtObjContDate: TEdit;
    lbObjContDate: TLabel;
    btnObjInfo: TSpeedButton;
    dsObject: TDataSource;
    qrObject: TFDQuery;
    qrTemp: TFDQuery;
    mtSSRName: TStringField;
    mtSSRCID: TIntegerField;
    mtSSRSCID: TIntegerField;
    mtSSRSM_ID: TIntegerField;
    mtSSRSM_TYPE: TIntegerField;
    mtSSRItog: TSmallintField;
    UpdateTimer: TTimer;
    procedure qrObjectBeforeOpen(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure btnObjInfoClick(Sender: TObject);
    procedure cbObjNameClick(Sender: TObject);
    procedure grSSRDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure mtSSRKoefChange(Sender: TField);
    procedure grSSRCanEditCell(Grid: TJvDBGrid; Field: TField;
      var AllowEdit: Boolean);
    procedure UpdateTimerTimer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    FObjectID: Integer;
    FKoefArray: TKoefArray;
    FKVrem,
    FKZim: Double;
    FKSocStrax: Double;

    procedure GetSSRReport();
    procedure RecalcReport();
    procedure CalcTotal();
    procedure InitKoefArray(var AArray: TKoefArray);
    function FindLineNom(const AArray: TKoefArray; const ALineNom: string): Integer;
    procedure AddNewKoef(const AKoef: TKoefRec);
    procedure UpdateNewKoef(const AKoef: TKoefRec);
  public
    property ObjectID: Integer read FObjectID write FObjectID;
  end;

implementation

uses Main, DataModule, CardObject, GlobsAndConst;

{$R *.dfm}

const SSRItems: array[0..12, 0..2] of string =
  (('90.1','ÑÐÅÄÑÒÂÀ ÍÀ ÍÅÏÐÅÄÂÈÄÅÍÍÛÅ ÐÀÁÎÒÛ È ÇÀÒÐÀÒÛ','0'),
   ('90.11','ÈÒÎÃÎ Ñ Ó×ÅÒÎÌ ÍÅÏÐÅÄÂÈÄÅÍÍÛÕ','1'),
   ('90.12','ÍÀËÎÃÈ È ÎÒ×ÈÑËÅÍÈß Â ÑÎÎÒÂÅÒÑÒÂÈÈ Ñ ÄÅÉÑÒÂÓÞÙÈÌ ÇÀÊÎÍÎÄÀÒÅËÜÑÒÂÎÌ ÍÀ ÄÀÒÓ ÐÀÇÐÀÁÎÒÊÈ ÑÌÅÒÍÎÉ ÄÎÊÓÌÅÍÒÀÖÈÈ','0'),
   ('90.12.0.1','.       â ò.÷.  Èííîâàöèîííûé ôîíä','0'),
   ('90.12.0.2','.       Íàëîã îò âûðó÷êè ïðè óïðîùåííîé ñèñòåìå íàëîãîîáëîæåíèÿ','0'),
   ('90.12.0.3','.       ÍÄÑ (äëÿ îáúåêòîâ íå îñâîáîæäåííûõ îò ÍÄÑ)','0'),
   ('90.12.0.4','.       Ãîñïîøëèíà','0'),
   ('90.13','ÈÒÎÃÎ Ñ Ó×ÅÒÎÌ ÍÀËÎÃÎÂ','1'),
   ('90.14','ÑÐÅÄÑÒÂÀ, Ó×ÈÒÛÂÀÞÙÈÅ ÏÐÈÌÅÍÅÍÈÅ ÏÐÎÃÍÎÇÍÛÕ ÈÍÄÅÊÑÎÂ ÖÅÍ Â ÑÒÐÎÈÒÅËÜÑÒÂÅ','0'),
   ('90.15','ÈÒÎÃÎ ÏÎ ÑÂÎÄÍÎÌÓ ÑÌÅÒÍÎÌÓ ÐÀÑ×ÅÒÓ','1'),
   ('90.19','ÂÎÇÂÐÀÒÍÛÅ ÑÓÌÌÛ','0'),
   ('90.20','ÑÌÅÒÍÀß ÑÒÎÈÌÎÑÒÜ ÄÎËÅÂÎÃÎ Ó×ÀÑÒÈß Â ÑÒÐÎÈÒÅËÜÑÒÂÅ ÎÁÚÅÊÒÎÂ ÈËÈ ÈÕ ×ÀÑÒÅÉ ÂÑÏÎÌÎÃÀÒÅËÜÍÎÃÎ ÏÐÎÈÇÂÎÄÑÒÂÀ È ÍÀÇÍÀ×ÅÍÈß, ÏÐÅÄÍÀÇÍÀ×ÅÍÍÛÕ ÄËß ÎÁÑËÓÆÈÂÀÍÈß ÍÅÑÊÎËÜÊÈÕ ÇÀÊÀÇ×ÈÊÎÂ, ÇÀÑÒÐÎÉÙÈÊÎÂ','0'),
   ('90.30','ÂÑÅÃÎ Ê ÓÒÂÅÐÆÄÅÍÈÞ','1'));

{ TRepSSRLine }

procedure TRepSSRLine.CalcTotal;
begin
  Total := ZP + EMiM + Mat + MatTransp + OXROPR +
    PlanPrib + Devices + Transp + Other;
end;

procedure TFormReportSSR.btnObjInfoClick(Sender: TObject);
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

procedure TFormReportSSR.Button1Click(Sender: TObject);
begin
  UpdateTimer.OnTimer(UpdateTimer);
end;

procedure TFormReportSSR.cbObjNameClick(Sender: TObject);
begin
  if not VarIsNull(cbObjName.KeyValue) then
  begin
    edtObjContNum.Text := qrObject.FieldByName('num_dog').AsString;
    edtObjContDate.Text := qrObject.FieldByName('date_dog').AsString;
  end
  else
  begin
    edtObjContNum.Text := '';
    edtObjContDate.Text := '';
  end;
end;

procedure TFormReportSSR.FormCreate(Sender: TObject);
begin
  WindowState := wsMaximized;

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
    ShowMessage('Íå çàäàí îáúåêò!');
    PostMessage(Handle, WM_CLOSE, 0, 0);
    Exit;
  end;
  //Ìåñÿ÷íûå âåëè÷èíû ó÷àñòâóþùèå â îò÷åòå
  FKVrem := qrObject.FieldByName('KVREM').AsFloat;
  FKZim := qrObject.FieldByName('KZIM').AsFloat;
  FKSocStrax := qrObject.FieldByName('KSOCSTRAX').AsFloat;

  cbObjName.KeyValue := qrObject.FieldByName('obj_id').Value;
  cbObjName.OnClick(cbObjName);
  GetSSRReport();
end;

procedure TFormReportSSR.qrObjectBeforeOpen(DataSet: TDataSet);
begin
  if (DataSet as TFDQuery).FindParam('USER_ID') <> nil then
    (DataSet as TFDQuery).ParamByName('USER_ID').Value := G_USER_ID;
end;

function TFormReportSSR.FindLineNom(const AArray: TKoefArray;
  const ALineNom: string): Integer;
var I: Integer;
begin
  Result := -1;
  for I := Low(AArray) to High(AArray) do
    if AArray[I].LineNom = ALineNom then
      Result := I;
end;

procedure TFormReportSSR.AddNewKoef(const AKoef: TKoefRec);
begin
  qrTemp.Active := False;
  qrTemp.Params.Clear;
  qrTemp.SQL.Text := 'Insert into ssr_calc ' +
    '(OBJ_ID, LINE_NUM, PERS, KOEF1, KOEF2, SPR_ID) ' +
    'values (:OBJ_ID, :LINE_NUM, :PERS, :KOEF1, :KOEF2, :SPR_ID)';
  qrTemp.ParamByName('OBJ_ID').Value := FObjectID;
  qrTemp.ParamByName('LINE_NUM').Value := AKoef.LineNom;

  qrTemp.ParamByName('PERS').DataType := TFieldType.ftFloat;
  qrTemp.ParamByName('KOEF1').DataType := TFieldType.ftFloat;
  qrTemp.ParamByName('KOEF2').DataType := TFieldType.ftFloat;
  qrTemp.ParamByName('SPR_ID').DataType := TFieldType.ftInteger;

  qrTemp.ParamByName('PERS').Value := AKoef.Pers;
  qrTemp.ParamByName('KOEF1').Value := AKoef.Koef1;
  qrTemp.ParamByName('KOEF2').Value := AKoef.Koef2;
  qrTemp.ParamByName('SPR_ID').Value := AKoef.SprID;
  qrTemp.ExecSQL;
end;

procedure TFormReportSSR.UpdateNewKoef(const AKoef: TKoefRec);
begin
  qrTemp.Active := False;
  qrTemp.Params.Clear;
  qrTemp.SQL.Text :=
    'Update ssr_calc set PERS = :PERS, KOEF1 = :KOEF1, ' +
    'KOEF2 = :KOEF2, SPR_ID = :SPR_ID ' +
    'where (OBJ_ID = :OBJ_ID) and (LINE_NUM = :LINE_NUM)';

  qrTemp.ParamByName('PERS').DataType := TFieldType.ftFloat;
  qrTemp.ParamByName('KOEF1').DataType := TFieldType.ftFloat;
  qrTemp.ParamByName('KOEF2').DataType := TFieldType.ftFloat;
  qrTemp.ParamByName('SPR_ID').DataType := TFieldType.ftInteger;

  qrTemp.ParamByName('PERS').Value := AKoef.Pers;
  qrTemp.ParamByName('KOEF1').Value := AKoef.Koef1;
  qrTemp.ParamByName('KOEF2').Value := AKoef.Koef2;
  qrTemp.ParamByName('SPR_ID').Value := AKoef.SprID;
  qrTemp.ParamByName('OBJ_ID').Value := FObjectID;
  qrTemp.ParamByName('LINE_NUM').Value := AKoef.LineNom;
  qrTemp.ExecSQL;
end;

procedure TFormReportSSR.UpdateTimerTimer(Sender: TObject);
var TempBookmark: TBookMark;
begin
  UpdateTimer.Enabled := False;

  try
    mtSSR.DisableControls;
    TempBookmark := mtSSR.GetBookmark;
    RecalcReport();
  finally
    if mtSSR.BookmarkValid(TempBookmark) then
    begin
      mtSSR.GotoBookmark(TempBookmark);
      mtSSR.FreeBookmark(TempBookmark);
    end;
    mtSSR.EnableControls;
  end;
end;

procedure TFormReportSSR.InitKoefArray(var AArray: TKoefArray);
var I: Integer;
begin
  qrTemp.Active := False;
  qrTemp.SQL.Text := 'select * from ssr_calc where OBJ_ID = :OBJ_ID order by LINE_NUM';
  qrTemp.ParamByName('OBJ_ID').Value := FObjectID;
  qrTemp.Active := True;
  I := 0;
  while not qrTemp.Eof do
  begin
    SetLength(AArray, I + 1);
    AArray[I].LineNom := qrTemp.FieldByName('LINE_NUM').AsString;
    AArray[I].Pers := qrTemp.FieldByName('PERS').Value;
    AArray[I].Koef1 := qrTemp.FieldByName('KOEF1').Value;
    AArray[I].Koef2 := qrTemp.FieldByName('KOEF2').Value;
    AArray[I].SprID := qrTemp.FieldByName('SPR_ID').Value;
    Inc(I);
    qrTemp.Next;
  end;
  qrTemp.Active := False;

  I := FindLineNom(AArray, '8.1');
  if I = -1 then
  begin
    I := Length(AArray);
    SetLength(AArray, Length(AArray) + 1);
    AArray[I].LineNom := '8.1';
    AArray[I].SprID := 191;

    qrTemp.SQL.Text := 'select COEF_NORM from ssrdetail where ID = :ID';
    qrTemp.ParamByName('ID').Value := AArray[I].SprID;
    qrTemp.Active := True;
    if not qrTemp.IsEmpty then
      AArray[I].Pers := qrTemp.Fields[0].Value;
    qrTemp.Active := False;
    AArray[I].Koef1 := 1;
    AArray[I].Koef2 := 1;

    AddNewKoef(AArray[I]);
  end;

  I := FindLineNom(AArray, '8.2');
  if I = -1 then
  begin
    I := Length(AArray);
    SetLength(AArray, Length(AArray) + 1);
    AArray[I].LineNom := '8.2';
    AArray[I].Pers := 15;
    AArray[I].Koef1 := 1;
    AArray[I].Koef2 := 1;
    AddNewKoef(AArray[I]);
  end;

  I := FindLineNom(AArray, '9.1');
  if I = -1 then
  begin
    I := Length(AArray);
    SetLength(AArray, Length(AArray) + 1);
    AArray[I].LineNom := '9.1';
    AArray[I].SprID := 88;

    qrTemp.SQL.Text := 'select COEF_NORM from ssrdetail where ID = :ID';
    qrTemp.ParamByName('ID').Value := AArray[I].SprID;
    qrTemp.Active := True;
    if not qrTemp.IsEmpty then
      AArray[I].Pers := qrTemp.Fields[0].Value;
    qrTemp.Active := False;
    AArray[I].Koef1 := 1;
    AArray[I].Koef2 := 1;

    AddNewKoef(AArray[I]);
  end;

  I := FindLineNom(AArray, '9.2');
  if I = -1 then
  begin
    I := Length(AArray);
    SetLength(AArray, Length(AArray) + 1);
    AArray[I].LineNom := '9.2';
    AArray[I].Pers := FKSocStrax;
    AArray[I].Koef1 := 1;
    AArray[I].Koef2 := 1;
    AddNewKoef(AArray[I]);
  end;

  I := FindLineNom(AArray, '9.3');
  if I = -1 then
  begin
    I := Length(AArray);
    SetLength(AArray, Length(AArray) + 1);
    AArray[I].LineNom := '9.3';
    AArray[I].SprID := 2;

    qrTemp.SQL.Text := 'select VALUE from ssrcost where ID = :ID';
    qrTemp.ParamByName('ID').Value := AArray[I].SprID;
    qrTemp.Active := True;
    if not qrTemp.IsEmpty then
      AArray[I].Pers := qrTemp.Fields[0].Value;
    qrTemp.Active := False;

    AArray[I].Koef1 := 1;
    AArray[I].Koef2 := 1;
    AddNewKoef(AArray[I]);
  end;

  I := FindLineNom(AArray, '9.10');
  if I = -1 then
  begin
    I := Length(AArray);
    SetLength(AArray, Length(AArray) + 1);
    AArray[I].LineNom := '9.10';
    AArray[I].Pers := 0.306;
    AArray[I].Koef1 := 1;
    AArray[I].Koef2 := 1;
    AddNewKoef(AArray[I]);
  end;

  I := FindLineNom(AArray, '10.1');
  if I = -1 then
  begin
    I := Length(AArray);
    SetLength(AArray, Length(AArray) + 1);
    AArray[I].LineNom := '10.1';
    AArray[I].Pers := 1.8;
    AArray[I].Koef1 := 1;
    AArray[I].Koef2 := 1;
    AddNewKoef(AArray[I]);
  end;

  I := FindLineNom(AArray, '10.2');
  if I = -1 then
  begin
    I := Length(AArray);
    SetLength(AArray, Length(AArray) + 1);
    AArray[I].LineNom := '10.2';
    AArray[I].Pers := 0.09;
    AArray[I].Koef1 := 1;
    AArray[I].Koef2 := 1;
    AddNewKoef(AArray[I]);
  end;

  I := FindLineNom(AArray, '10.3');
  if I = -1 then
  begin
    I := Length(AArray);
    SetLength(AArray, Length(AArray) + 1);
    AArray[I].LineNom := '10.3';
    AArray[I].Pers := 0.2;
    AArray[I].Koef1 := 1;
    AArray[I].Koef2 := 1;
    AddNewKoef(AArray[I]);
  end;

  I := FindLineNom(AArray, '10.7');
  if I = -1 then
  begin
    I := Length(AArray);
    SetLength(AArray, Length(AArray) + 1);
    AArray[I].LineNom := '10.7';
    AArray[I].Pers := 0.35;
    AArray[I].Koef1 := 1;
    AArray[I].Koef2 := 1;
    AddNewKoef(AArray[I]);
  end;

  I := FindLineNom(AArray, '90.1');
  if I = -1 then
  begin
    I := Length(AArray);
    SetLength(AArray, Length(AArray) + 1);
    AArray[I].LineNom := '90.1';
    AArray[I].Pers := 3;
    AArray[I].Koef1 := 1;
    AArray[I].Koef2 := 1;
    AddNewKoef(AArray[I]);
  end;
end;

procedure TFormReportSSR.CalcTotal();
begin
  mtSSRTotal.Value :=
    mtSSRZP.Value + mtSSREMiM.Value + mtSSRMat.Value +
    mtSSRMatTransp.Value + mtSSROXROPR.Value +
    mtSSRPlanPrib.Value + mtSSRDevices.Value +
    mtSSRTransp.Value + mtSSROther.Value;
end;

procedure TFormReportSSR.mtSSRKoefChange(Sender: TField);
var I: Integer;
    IsNew: Boolean;
begin
  IsNew := False;
  I := FindLineNom(FKoefArray, mtSSRNum.AsString);
  if I = -1 then
  begin
    I := Length(FKoefArray);
    SetLength(FKoefArray, I + 1);
    IsNew := True;
  end;
  FKoefArray[I].LineNom := mtSSRNum.AsString;
  FKoefArray[I].Pers := TField(mtSSRPepcent).Value;
  FKoefArray[I].Koef1 := TField(mtSSRKoef1).Value;
  FKoefArray[I].Koef2 := TField(mtSSRKoef2).Value;
  if IsNew then
    AddNewKoef(FKoefArray[I])
  else
    UpdateNewKoef(FKoefArray[I]);

  mtSSR.Post;
  UpdateTimer.Enabled := False;
  UpdateTimer.Enabled := True;

end;

//Ïðîöåäóðà äîáàâëÿåò â ðàñ÷åò âñå íåîáõîäèìûå ñòðîêè è âûòÿãèâàåò èíôó ïî ñìåòàì
procedure TFormReportSSR.GetSSRReport();
var SmStr, CaptStr: string;
    LastC, LastSC: Integer;
    I, J: Integer;
    ev: TFieldNotifyEvent;

procedure AddItog();
begin
  mtSSR.Append;
  mtSSRNum.AsString := LastC.ToString + '.90';
  mtSSRName.AsString := 'ÈÒÎÃÎ ÏÎ ÃËÀÂÅ ' + LastC.ToString;
  mtSSRCID.Value := LastC;
  mtSSRSCID.Value := 0;
  mtSSRItog.Value := 1;
  mtSSR.Post;
  if (LastC >= 7) and (LastC <> 10) then
  begin
    mtSSR.Append;
    mtSSRNum.AsString := LastC.ToString + '.95';
    mtSSRName.AsString := 'ÈÒÎÃÎ ÏÎ ÃËÀÂÀÌ 1-' + LastC.ToString;
    mtSSRCID.Value := LastC;
    mtSSRSCID.Value := 0;
    mtSSRItog.Value := 2;
    mtSSR.Post;
  end;
end;

procedure AddKoef(ALineNom: string);
var I: Integer;
begin
  I :=  FindLineNom(FKoefArray, ALineNom);
  if I > -1 then
  begin
    TField(mtSSRPepcent).Value := FKoefArray[I].Pers;
    TField(mtSSRKoef1).Value := FKoefArray[I].Koef1;
    TField(mtSSRKoef2).Value := FKoefArray[I].Koef2;
  end;
end;

begin
  SmStr :=
    'Select (Select SM_ID FROM smetasourcedata WHERE SM_ID = ' +
      '(Select PARENT_ID FROM smetasourcedata WHERE SM_ID = s.PARENT_ID)) SM_ID, ' +
    '(Select CONCAT(IFNULL(SM_NUMBER, ""), " ",  IFNULL(NAME, "")) SM_NAME ' +
      'FROM smetasourcedata WHERE SM_ID = ' +
      '(Select PARENT_ID FROM smetasourcedata WHERE SM_ID = s.PARENT_ID)) SM_NAME, ' +
    '(Select SM_TYPE FROM smetasourcedata WHERE SM_ID = ' +
      '(Select PARENT_ID FROM smetasourcedata WHERE SM_ID = s.PARENT_ID)) SM_TYPE, ' +
    '(Select CHAPTER FROM smetasourcedata WHERE SM_ID = ' +
      '(Select PARENT_ID FROM smetasourcedata WHERE SM_ID = s.PARENT_ID)) CHAPTER, ' +
    '(Select ROW_NUMBER FROM smetasourcedata WHERE SM_ID = ' +
      '(Select PARENT_ID FROM smetasourcedata WHERE SM_ID = s.PARENT_ID)) ROW_NUMBER, ' +
    'Round(SUM(COALESCE(d.ZPF, d.ZP, 0))) ZP, ' +
    'Round(SUM(COALESCE(d.ZP_PRF, d.ZP_PR, 0))) ZP_PR, ' +
    'Round(SUM(COALESCE(d.EMiMF, d.EMiM, 0))) EMiM, ' +
    'Round(SUM(COALESCE(d.ZP_MASHF, d.ZP_MASH, 0))) ZP_MASH, ' +
    'Round(SUM(COALESCE(d.MRF, d.MR, 0))) MR, ' +
    'Round(SUM(COALESCE(d.TRANSPF, d.TRANSP, 0))) TRANSP, ' +
    'Round(SUM(COALESCE(d.OHROPRF, d.OHROPR, 0))) OHROPR, ' +
    'Round(SUM(COALESCE(d.PLAN_PRIBF, d.PLAN_PRIB, 0))) PLAN_PRIB, ' +
    'Round(SUM(COALESCE(d.MR_DEVICEF, d.MR_DEVICE, 0))) MR_DEVICE, ' +
    'Round(SUM(COALESCE(d.TRANSP_DEVICEF, d.TRANSP_DEVICE, 0))) TRANSP_DEVICE, ' +
    'Round(SUM(COALESCE(d.OTHERF, d.OTHER, 0))) OTHER, ' +
    'Round(SUM(COALESCE(d.TRUDF, d.TRUD, 0))) TRUD ' +
    'FROM smetasourcedata s, summary_calculation d ' +
    'WHERE (s.DELETED = 0) AND (s.OBJ_ID = :OBJ_ID) AND ' +
          '(d.SM_ID = s.SM_ID) AND (s.ACT = 0) AND ' +
          '(s.SM_ID in (Select SM_ID FROM smetasourcedata WHERE ' +
            '(PARENT_ID in (Select SM_ID FROM smetasourcedata WHERE ' +
            '(PARENT_ID in (Select SM_ID FROM smetasourcedata WHERE ' +
            '(OBJ_ID = :OBJ_ID) AND (DELETED = 0) AND (ACT = 0) AND (SM_TYPE = 2))))))) ' +
    'GROUP BY SM_ID ' +
    'UNION ALL ' +
    'Select (Select SM_ID FROM smetasourcedata WHERE SM_ID = s.PARENT_ID) SM_ID, ' +
    '(Select CONCAT(IFNULL(SM_NUMBER, ""), " ",  IFNULL(NAME, "")) SM_NAME ' +
      'FROM smetasourcedata WHERE SM_ID = s.PARENT_ID) SM_NAME, ' +
    '(Select SM_TYPE FROM smetasourcedata WHERE SM_ID = s.PARENT_ID) SM_TYPE, ' +
    '(Select CHAPTER FROM smetasourcedata WHERE SM_ID = ' +
      '(Select PARENT_ID FROM smetasourcedata WHERE SM_ID = s.PARENT_ID)) CHAPTER, ' +
    '(Select ROW_NUMBER FROM smetasourcedata WHERE SM_ID = ' +
      '(Select PARENT_ID FROM smetasourcedata WHERE SM_ID = s.PARENT_ID)) ROW_NUMBER, ' +
    'Round(SUM(COALESCE(d.ZPF, d.ZP, 0))) ZP, ' +
    'Round(SUM(COALESCE(d.ZP_PRF, d.ZP_PR, 0))) ZP_PR, ' +
    'Round(SUM(COALESCE(d.EMiMF, d.EMiM, 0))) EMiM, ' +
    'Round(SUM(COALESCE(d.ZP_MASHF, d.ZP_MASH, 0))) ZP_MASH, ' +
    'Round(SUM(COALESCE(d.MRF, d.MR, 0))) MR, ' +
    'Round(SUM(COALESCE(d.TRANSPF, d.TRANSP, 0))) TRANSP, ' +
    'Round(SUM(COALESCE(d.OHROPRF, d.OHROPR, 0))) OHROPR, ' +
    'Round(SUM(COALESCE(d.PLAN_PRIBF, d.PLAN_PRIB, 0))) PLAN_PRIB, ' +
    'Round(SUM(COALESCE(d.MR_DEVICEF, d.MR_DEVICE, 0))) MR_DEVICE, ' +
    'Round(SUM(COALESCE(d.TRANSP_DEVICEF, d.TRANSP_DEVICE, 0))) TRANSP_DEVICE, ' +
    'Round(SUM(COALESCE(d.OTHERF, d.OTHER, 0))) OTHER, ' +
    'Round(SUM(COALESCE(d.TRUDF, d.TRUD, 0))) TRUD ' +
    'FROM smetasourcedata s, summary_calculation d ' +
    'WHERE (s.DELETED = 0) AND (s.OBJ_ID = :OBJ_ID) AND ' +
          '(d.SM_ID = s.SM_ID) AND (s.ACT = 0) AND ' +
          '(s.SM_ID in (Select SM_ID FROM smetasourcedata WHERE ' +
          '(PARENT_ID in (Select SM_ID FROM smetasourcedata WHERE ' +
          '(PARENT_ID in (Select SM_ID FROM smetasourcedata WHERE ' +
          '(OBJ_ID = :OBJ_ID) AND (DELETED = 0) AND (ACT = 0) AND (SM_TYPE = 2))))))) ' +
    'GROUP BY SM_ID';

  CaptStr := 'Select sc.CID, COALESCE(sc.SCID, 0) SCID, sc.CNAME, sm.SM_ID, ' +
    'IF(sm.SM_ID is NULL, NULL, FN_getSortSM(sm.SM_ID)) SM_SORT, sm.SM_NAME, ' +
    'sm.SM_TYPE, ZP, ZP_PR, EMiM, ZP_MASH, MR, TRANSP, OHROPR, PLAN_PRIB, ' +
    'MR_DEVICE, TRANSP_DEVICE, OTHER, TRUD ' +
    'FROM ssr_chapters sc left join (' + SmStr + ') sm ' +
    'on (sc.CID = sm.CHAPTER) and (COALESCE(sc.SCID, 0) = COALESCE(sm.ROW_NUMBER, 0)) ' +
    'order by sc.CID, SCID, SM_SORT';

  InitKoefArray(FKoefArray);

  if not mtSSR.Active then
    mtSSR.Active :=True;
  mtSSR.EmptyDataSet;

  ev := mtSSRPepcent.OnChange;
  mtSSR.BeginBatch();
  try
    mtSSRPepcent.OnChange := nil;
    mtSSRKoef1.OnChange := nil;
    mtSSRKoef2.OnChange := nil;

    //Ïîëó÷åíèå äàííûõ ïî ñìåòàì
    qrTemp.Active := False;
    qrTemp.SQL.Text := CaptStr;
    qrTemp.ParamByName('OBJ_ID').Value := FObjectID;
    qrTemp.Active := True;
    LastC := 0;
    LastSC := 0;

    while not qrTemp.Eof do
    begin
      //Äîáàâëÿåò ñòðîêó 8.2
      if LastC <> qrTemp.FieldByName('CID').AsInteger then
      begin
        if (LastC = 8) then
        begin
          mtSSR.Append;
          mtSSRNum.AsString := '8.2';
          AddKoef(mtSSRNum.AsString);
          mtSSRName.AsString :=
            'â ò.÷. ÂÎÇÂÐÀÒ ÌÀÒÅÐÈÀËÎÂ, ÈÇÄÅËÈÉ È ÊÎÍÑÒÐÓÊÖÈÉ ÎÒ ÐÀÇÁÎÐÊÈ ÂÐÅÌÅÍÍÛÕ ÇÄÀÍÈÉ È ÑÎÎÐÓÆÅÍÈÉ';

          mtSSRCID.Value := 8;
          mtSSRSCID.Value := 2;

          mtSSR.Post;
        end;

        if LastC > 0 then
          AddItog();

        if (LastC = 9) then
        begin
          mtSSR.Append;
          mtSSRNum.AsString := '9.96';
          AddKoef(mtSSRNum.AsString);
          mtSSRName.AsString :=
            'â ò.÷. ÂÎÇÂÐÀÒ ÌÀÒÅÐÈÀËÎÂ';

          mtSSRCID.Value := 9;
          mtSSRSCID.Value := 96;

          mtSSR.Post;
        end;

        LastC := qrTemp.FieldByName('CID').AsInteger;
        LastSC := 0;
        I := 0;
        J := 0;

        mtSSR.Append;
        mtSSRNum.AsString := LastC.ToString + '.' + LastSC.ToString;
        AddKoef(mtSSRNum.AsString);
        mtSSRName.AsString :=
          'ÃËÀÂÀ ' + LastC.ToString + ' ' + qrTemp.FieldByName('CNAME').AsString;

        mtSSRCID.Value := LastC;
        mtSSRSCID.Value := LastSC;

        mtSSR.Post;
      end;

      //Äîáàâëÿåò ñòðîêó ñòðîêè
      if LastSC <> qrTemp.FieldByName('SCID').AsInteger then
      begin
        LastSC := qrTemp.FieldByName('SCID').AsInteger;
        I := 0;
        J := 0;

        mtSSR.Append;
        mtSSRNum.AsString := LastC.ToString + '.' + LastSC.ToString;
        AddKoef(mtSSRNum.AsString);
        mtSSRName.AsString := qrTemp.FieldByName('CNAME').AsString;
        mtSSRCID.Value := qrTemp.FieldByName('CID').AsInteger;
        mtSSRSCID.Value := qrTemp.FieldByName('SCID').AsInteger;
        mtSSR.Post;
      end;

      if qrTemp.FieldByName('SM_ID').AsInteger > 0 then
      begin

        mtSSR.Append;
        if qrTemp.FieldByName('SM_TYPE').AsInteger = 2 then
        begin
          inc(I);
          mtSSRNum.AsString :=
            LastC.ToString + '.' + LastSC.ToString + '.' + I.ToString;
        end
        else
        begin
          inc(J);
          mtSSRNum.AsString :=
            LastC.ToString + '.' + LastSC.ToString + '.' +
            I.ToString + '.' + J.ToString;
        end;

        mtSSRName.AsString := qrTemp.FieldByName('SM_NAME').AsString;

        mtSSRZP.Value := qrTemp.FieldByName('ZP').AsFloat;
        mtSSRZP5.Value := qrTemp.FieldByName('ZP_PR').AsFloat;
        mtSSREMiM.Value := qrTemp.FieldByName('EMiM').AsFloat;
        mtSSRZPMash.Value := qrTemp.FieldByName('ZP_MASH').AsFloat;
        mtSSRMat.Value := qrTemp.FieldByName('MR').AsFloat;
        mtSSRMatTransp.Value := qrTemp.FieldByName('TRANSP').AsFloat;
        mtSSROXROPR.Value := qrTemp.FieldByName('OHROPR').AsFloat;
        mtSSRPlanPrib.Value := qrTemp.FieldByName('PLAN_PRIB').AsFloat;
        mtSSRDevices.Value := qrTemp.FieldByName('MR_DEVICE').AsFloat;
        mtSSRTransp.Value := qrTemp.FieldByName('TRANSP_DEVICE').AsFloat;
        mtSSROther.Value := qrTemp.FieldByName('OTHER').AsFloat;
        mtSSRTrud.Value := qrTemp.FieldByName('TRUD').AsFloat;
        CalcTotal();

        mtSSRCID.Value := qrTemp.FieldByName('CID').AsInteger;
        mtSSRSCID.Value := qrTemp.FieldByName('SCID').AsInteger;
        mtSSRSM_ID.Value := qrTemp.FieldByName('SM_ID').AsInteger;
        mtSSRSM_TYPE.Value := qrTemp.FieldByName('SM_TYPE').AsInteger;

        mtSSR.Post;
      end;

      qrTemp.Next;
    end;
    qrTemp.Active := False;

    if LastC > 0 then
      AddItog();

    for I := Low(SSRItems) to High(SSRItems) do
    begin
      mtSSR.Append;
      mtSSRNum.AsString := SSRItems[I][0];
      mtSSRName.AsString := SSRItems[I][1];
      mtSSRItog.Value := StrToIntDef(SSRItems[I][2], 0);
      if mtSSRItog.Value = 0 then
        AddKoef(mtSSRNum.AsString);
      mtSSR.Post;
    end;

  finally
    mtSSR.EndBatch;
    mtSSRPepcent.OnChange := ev;
    mtSSRKoef1.OnChange := ev;
    mtSSRKoef2.OnChange := ev;
  end;

  //Âûïîëíÿåò ïîñëåäóþùèå ðàñ÷åòû è ñóììàöèè
  RecalcReport();
  mtSSR.First;
end;

//Âûïîëíÿåò ïîñëåäóþùèå ðàñ÷åòû è ñóììàöèè
procedure TFormReportSSR.RecalcReport();
var I: Integer;
    TmpLine,
    TmpLine1,
    AllLine,
    Line795,
    Line895,
    Line98: TRepSSRLine;
    SmCount: Integer;
    Bookmark82, Bookmark996: TBookMark;
    Mat81: Double;
    KZp, KEmim, KEmimZp, KMr: Double;

procedure NullLine();
begin
  mtSSR.Edit;
  TField(mtSSRZP).Value := Null;
  TField(mtSSRZP5).Value := Null;
  TField(mtSSREMiM).Value := Null;
  TField(mtSSRZPMash).Value := Null;
  TField(mtSSRMat).Value := Null;
  TField(mtSSRMatTransp).Value := Null;
  TField(mtSSROXROPR).Value := Null;
  TField(mtSSRPlanPrib).Value := Null;
  TField(mtSSRDevices).Value := Null;
  TField(mtSSRTransp).Value := Null;
  TField(mtSSROther).Value := Null;
  TField(mtSSRTotal).Value := Null;
  TField(mtSSRTrud).Value := Null;
  mtSSR.Post;
end;

procedure AssignLine(const ALine: TRepSSRLine);
begin
  mtSSRZP.Value := ALine.ZP;
  mtSSRZP5.Value := ALine.ZP5;
  mtSSREMiM.Value := ALine.EMiM;
  mtSSRZPMash.Value := ALine.ZPMash;
  mtSSRMat.Value := ALine.Mat;
  mtSSRMatTransp.Value := ALine.MatTransp;
  mtSSROXROPR.Value := ALine.OXROPR;
  mtSSRPlanPrib.Value := ALine.PlanPrib;
  mtSSRDevices.Value := ALine.Devices;
  mtSSRTransp.Value := ALine.Transp;
  mtSSROther.Value := ALine.Other;
  mtSSRTotal.Value := ALine.Total;
  mtSSRTrud.Value := ALine.Trud;
end;

procedure AssignLineIfNoNull(const ALine: TRepSSRLine);
begin
  if (ALine.Total + ALine.Trud) > 0 then
  begin
    mtSSR.Edit;
    AssignLine(ALine);
    mtSSR.Post;
  end;
end;

procedure SummToLine(var ALine: TRepSSRLine);
begin
  ALine.ZP := ALine.ZP + mtSSRZP.Value;
  ALine.ZP5 := ALine.ZP5 + mtSSRZP5.Value;
  ALine.EMiM := ALine.EMiM + mtSSREMiM.Value;
  ALine.ZPMash := ALine.ZPMash + mtSSRZPMash.Value;
  ALine.Mat := ALine.Mat + mtSSRMat.Value;
  ALine.MatTransp := ALine.MatTransp + mtSSRMatTransp.Value;
  ALine.OXROPR := ALine.OXROPR + mtSSROXROPR.Value;
  ALine.PlanPrib := ALine.PlanPrib + mtSSRPlanPrib.Value;
  ALine.Devices := ALine.Devices + mtSSRDevices.Value;
  ALine.Transp := ALine.Transp + mtSSRTransp.Value;
  ALine.Other := ALine.Other + mtSSROther.Value;
  ALine.Total := ALine.Total + mtSSRTotal.Value;
  ALine.Trud := ALine.Trud + mtSSRTrud.Value;
end;

procedure CalcLineWithKoef(var ALine: TRepSSRLine);
var Perc, Koef1, Koef2: Double;

function VarIsAssign(AValue: Variant): Boolean;
begin
  Result := VarIsOrdinal(AValue) or VarIsFloat(AValue);
end;

begin
  Perc := 1;
  Koef1 := 1;
  Koef2 := 1;

  if VarIsAssign(TField(mtSSRPepcent).Value) then
    Perc := mtSSRPepcent.Value / 100;
  if VarIsAssign(TField(mtSSRKoef1).Value) then
    Koef1 := mtSSRKoef1.Value;
  if VarIsAssign(TField(mtSSRKoef2).Value) then
    Koef2 := mtSSRKoef2.Value;

  ALine.ZP := ALine.ZP * Perc * Koef1 * Koef2;
  ALine.ZP5 := ALine.ZP5 * Perc * Koef1 * Koef2;
  ALine.EMiM := ALine.EMiM * Perc * Koef1 * Koef2;
  ALine.ZPMash := ALine.ZPMash * Perc * Koef1 * Koef2;
  ALine.Mat := ALine.Mat * Perc * Koef1 * Koef2;
  ALine.MatTransp := ALine.MatTransp * Perc * Koef1 * Koef2;
  ALine.OXROPR := ALine.OXROPR * Perc * Koef1 * Koef2;
  ALine.PlanPrib := ALine.PlanPrib * Perc * Koef1 * Koef2;
  ALine.Devices := ALine.Devices * Perc * Koef1 * Koef2;
  ALine.Transp := ALine.Transp * Perc * Koef1 * Koef2;
  ALine.Other := ALine.Other * Perc * Koef1 * Koef2;
  ALine.CalcTotal;
  ALine.Trud := ALine.Trud * Perc * Koef1 * Koef2;
end;

begin
  mtSSR.DisableControls;
  try
    TmpLine := default(TRepSSRLine);
    SmCount := 0;
    Mat81 := 0;
    //Ïîëóåíèå èòîãîâ ïî ñòðîêàì
    mtSSR.Last;
    while not mtSSR.Bof do
    begin
      if (mtSSRSM_ID.Value = 0) and (mtSSRItog.Value = 0) then
      begin
        //Äëÿ 8.1 ðàñ÷åò îòëè÷àåòñÿ
        if mtSSRNum.AsString <> '8.1' then
          CalcLineWithKoef(TmpLine);
        AssignLineIfNoNull(TmpLine);

        if mtSSRNum.AsString = '8.2' then
          Bookmark82 := mtSSR.GetBookmark;

        if mtSSRNum.AsString = '9.96' then
          Bookmark996 := mtSSR.GetBookmark;

        if mtSSRNum.AsString = '9.8' then
          Line98 := TmpLine;

        TmpLine := default(TRepSSRLine);
        SmCount := 0;
      end;

      if (mtSSRSM_ID.Value > 0) and (mtSSRSM_TYPE.Value = 2) then
      begin
        SummToLine(TmpLine);
        Inc(SmCount);
      end;

      mtSSR.Prior;
    end;

    TmpLine := default(TRepSSRLine);
    AllLine := default(TRepSSRLine);

    //Ïîäáèâàåò èòîã ïî êîæäîé èç ãëàâ äî ãëàâû 7
    while not mtSSR.Eof do
    begin
      if (mtSSRItog.Value = 2) then  //Èòîã ïî 1-11
      begin
        mtSSR.Edit;
        AssignLine(AllLine);
        mtSSR.Post;

        if mtSSRNum.AsString = '7.95' then
          Line795 := AllLine;

        if mtSSRNum.AsString = '8.95' then
          Line895 := AllLine;

        if mtSSRNum.AsString = '11.95' then
          Break;
      end;

      if (mtSSRItog.Value = 1) then
      begin
        AssignLineIfNoNull(TmpLine);
        SummToLine(AllLine);
        TmpLine := default(TRepSSRLine);
      end;

      if (mtSSRSM_ID.Value = 0) and (mtSSRItog.Value = 0) then
      begin
        SummToLine(TmpLine);

        if mtSSRNum.AsString = '8.1' then
        begin
          NullLine();
          TmpLine1 := default(TRepSSRLine);
          I := FindLineNom(FKoefArray, mtSSRNum.AsString);
          if I > -1 then
          begin
            KZp := 0;
            KEmim := 0;
            KEmimZp := 0;
            KMr := 0;

            qrTemp.SQL.Text :=
              'select COEF_ZP, COEF_EK_MASH, COEF_ZP_MASH, COEF_MAT from ssrdetail where ID = :ID';
            qrTemp.ParamByName('ID').Value := FKoefArray[I].SprID;
            qrTemp.Active := True;
            if not qrTemp.IsEmpty then
            begin
              KZp := qrTemp.Fields[0].Value;
              KEmim := qrTemp.Fields[1].Value;
              KEmimZp := qrTemp.Fields[2].Value;
              KMr := qrTemp.Fields[3].Value;
            end;
            qrTemp.Active := False;

            TmpLine1.ZP := (Line795.ZP - Line795.ZP5 + Line795.ZPMash) * KZp * FKVrem;
            TmpLine1.EMiM := (Line795.ZP - Line795.ZP5 + Line795.ZPMash) * KEmim * FKVrem;
            TmpLine1.ZPMash := TmpLine1.EMiM * KEmimZp;
            TmpLine1.Mat := (Line795.ZP - Line795.ZP5 + Line795.ZPMash) * KMr * FKVrem;
          end;
          CalcLineWithKoef(TmpLine1);
          Mat81 := TmpLine1.Mat;
          AssignLineIfNoNull(TmpLine1);
          SummToLine(TmpLine);
        end;

        if mtSSRNum.AsString = '9.1' then
        begin
          NullLine();
          TmpLine1 := default(TRepSSRLine);
          I := FindLineNom(FKoefArray, mtSSRNum.AsString);
          if I > -1 then
          begin
            KZp := 0;
            KEmim := 0;
            KEmimZp := 0;
            KMr := 0;

            qrTemp.SQL.Text :=
              'select COEF_ZP, COEF_EK_MASH, COEF_ZP_MASH, COEF_MAT from ssrdetail where ID = :ID';
            qrTemp.ParamByName('ID').Value := FKoefArray[I].SprID;
            qrTemp.Active := True;
            if not qrTemp.IsEmpty then
            begin
              KZp := qrTemp.Fields[0].Value;
              KEmim := qrTemp.Fields[1].Value;
              KEmimZp := qrTemp.Fields[2].Value;
              KMr := qrTemp.Fields[3].Value;
            end;
            qrTemp.Active := False;

            TmpLine1.ZP := (Line795.ZP - Line795.ZP5 + Line795.ZPMash) * KZp * FKZim;
            TmpLine1.EMiM := (Line795.ZP - Line795.ZP5 + Line795.ZPMash) * KEmim * FKZim;
            TmpLine1.ZPMash := TmpLine1.EMiM * KEmimZp;
            TmpLine1.Mat := (Line795.ZP - Line795.ZP5 + Line795.ZPMash) * KMr * FKZim;
          end;
          CalcLineWithKoef(TmpLine1);
          AssignLineIfNoNull(TmpLine1);
          SummToLine(TmpLine);
        end;

        if mtSSRNum.AsString = '9.2' then
        begin
          NullLine();
          TmpLine1 := default(TRepSSRLine);
          TmpLine1.Other := (Line795.ZP + Line795.ZPMash +
            Line98.ZP + Line98.ZPMash);
          CalcLineWithKoef(TmpLine1);
          AssignLineIfNoNull(TmpLine1);
          SummToLine(TmpLine);
        end;

        if mtSSRNum.AsString = '9.3' then
        begin
          NullLine();
          TmpLine1 := default(TRepSSRLine);
          TmpLine1.Other := (Line795.ZP - Line795.ZP5 + Line795.ZPMash);
          CalcLineWithKoef(TmpLine1);
          AssignLineIfNoNull(TmpLine1);
          SummToLine(TmpLine);
        end;

        if mtSSRNum.AsString = '9.10' then
        begin
          NullLine();
          TmpLine1 := default(TRepSSRLine);
          TmpLine1.Other :=
           (Line895.ZP - Line895.ZP5 + Line895.EMiM +
            Line895.Mat + Line895.MatTransp + Line895.OXROPR +
            Line895.PlanPrib + Line895.Other);
          CalcLineWithKoef(TmpLine1);
          AssignLineIfNoNull(TmpLine1);
          SummToLine(TmpLine);
        end;

      end;

      mtSSR.Next;
    end;

    //Ðàñ÷åò ïóíêòà 8.2  è 9.96
    if mtSSR.BookmarkValid(Bookmark82) then
    begin
      mtSSR.GotoBookmark(Bookmark82);
      TmpLine := default(TRepSSRLine);
      TmpLine.Mat := Mat81;
      CalcLineWithKoef(TmpLine);
      if (TmpLine.Total + TmpLine.Trud) > 0 then
      begin
        mtSSR.Edit;
        AssignLine(TmpLine);
        mtSSR.Post;
      end;
      if mtSSR.BookmarkValid(Bookmark996) then
      begin
        mtSSR.GotoBookmark(Bookmark996);
        CalcLineWithKoef(TmpLine);
        if (TmpLine.Total + TmpLine.Trud) > 0 then
        begin
          mtSSR.Edit;
          AssignLine(TmpLine);
          mtSSR.Post;
        end;
      end;
    end;
  finally
    mtSSR.EnableControls;
  end;
end;

procedure TFormReportSSR.grSSRCanEditCell(Grid: TJvDBGrid; Field: TField;
  var AllowEdit: Boolean);
begin
  AllowEdit := (mtSSRSM_ID.Value = 0) and (mtSSRItog.Value = 0);
end;

procedure TFormReportSSR.grSSRDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
var headerLines: Integer;
begin
  // Ïðîöåäóðà íàëîæåíèÿ ñòèëåé îòðèñîâêè òàáëèö ïî óìîë÷àíèþ
  with (Sender AS TJvDBGrid).Canvas do
  begin
    Brush.Color := PS.BackgroundRows;
    Font.Color := PS.FontRows;

    headerLines := 1;
    if not(dgTitles in (Sender AS TJvDBGrid).Options) then
      headerLines := 0;

    if (mtSSRSM_ID.Value = 0) then //Øàïêè ãëàâ
    begin
      Brush.Color := $00E3E3CE;
      if mtSSRSCID.Value = 0 then
      begin
        Font.Style := Font.Style + [fsBold];
        Brush.Color := $00CACAA2;
      end;
    end;

    if (mtSSRItog.Value > 0) then  //Èòîãè
    begin
      Brush.Color := clNavy;
      Font.Color := clWhite;
      Font.Style := Font.Style + [fsBold];
    end;

    if (mtSSRSM_ID.Value > 0) and (mtSSRName.Index = Column.Index) then
    begin
      if (mtSSRSM_TYPE.Value = 2) then
        Brush.Color := $00CACEC8
      else
        Brush.Color := $00DEE1E3;
    end;

    // Ñòðîêà â ôîêóñå
    if (Assigned(TMyDBGrid((Sender AS TJvDBGrid)).DataLink) and
      ((Sender AS TJvDBGrid).Row = TMyDBGrid((Sender AS TJvDBGrid)).DataLink.ActiveRecord + headerLines)) then
    begin
      Brush.Color := PS.BackgroundSelectRow;
      Font.Color := PS.FontSelectRow;
    end;
    // ß÷åéêà â ôîêóñå
    if (gdSelected in State) then
    begin
      Brush.Color := PS.BackgroundSelectCell;
      Font.Color := PS.FontSelectCell;
      Font.Style := Font.Style + [fsBold];
    end;
  end;
  (Sender AS TJvDBGrid).DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

end.
