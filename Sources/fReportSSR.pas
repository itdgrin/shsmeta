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
    Pers: Double;
    Koef1: Double;
    Koef2: Double;
  end;
  TKoefArray = array of TKoefRec;

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
    procedure qrObjectBeforeOpen(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure btnObjInfoClick(Sender: TObject);
    procedure cbObjNameClick(Sender: TObject);
    procedure grSSRDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure mtSSRKoefChange(Sender: TField);
    procedure grSSRCanEditCell(Grid: TJvDBGrid; Field: TField;
      var AllowEdit: Boolean);
  private
    FObjectID: Integer;
    FKoefArray: TKoefArray;
    procedure GetSSRReport();
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
    ShowMessage('Не задан объект!');
    PostMessage(Handle, WM_CLOSE, 0, 0);
    Exit;
  end;

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
  qrTemp.SQL.Text := 'Insert into ssr_calc (OBJ_ID, LINE_NUM, PERS, KOEF1, KOEF2) ' +
    'values (:OBJ_ID, :LINE_NUM, :PERS, :KOEF1, :KOEF2)';
  qrTemp.ParamByName('OBJ_ID').Value := FObjectID;
  qrTemp.ParamByName('LINE_NUM').Value := AKoef.LineNom;
  qrTemp.ParamByName('PERS').Value := AKoef.Pers/100;
  qrTemp.ParamByName('KOEF1').Value := AKoef.Koef1;
  qrTemp.ParamByName('KOEF2').Value := AKoef.Koef2;
  qrTemp.ExecSQL;
end;

procedure TFormReportSSR.UpdateNewKoef(const AKoef: TKoefRec);
begin
  qrTemp.Active := False;
  qrTemp.SQL.Text := 'Update ssr_calc set PERS = :PERS, KOEF1 = :KOEF1, ' +
    'KOEF2 = :KOEF2 where (OBJ_ID = :OBJ_ID) and (LINE_NUM = :LINE_NUM)';
  qrTemp.ParamByName('PERS').Value := AKoef.Pers/100;
  qrTemp.ParamByName('KOEF1').Value := AKoef.Koef1;
  qrTemp.ParamByName('KOEF2').Value := AKoef.Koef2;
  qrTemp.ParamByName('OBJ_ID').Value := FObjectID;
  qrTemp.ParamByName('LINE_NUM').Value := AKoef.LineNom;
  qrTemp.ExecSQL;
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
    AArray[I].Pers := qrTemp.FieldByName('PERS').AsFloat;
    AArray[I].Koef1 := qrTemp.FieldByName('KOEF1').AsFloat;
    AArray[I].Koef2 := qrTemp.FieldByName('KOEF2').AsFloat;
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
    AArray[I].Pers := 0.084;
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
    AArray[I].Pers := 0.15;
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
    AArray[I].Pers := 0.0581;
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
    AArray[I].Pers := 0.34;
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
    AArray[I].Pers := 0.097;
    AArray[I].Koef1 := 1;
    AArray[I].Koef2 := 1;
    AddNewKoef(AArray[I]);
  end;
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
  FKoefArray[I].Pers := mtSSRPepcent.Value;
  FKoefArray[I].Koef1 := mtSSRKoef1.Value;
  FKoefArray[I].Koef2 := mtSSRKoef2.Value;
  if IsNew then
    AddNewKoef(FKoefArray[I])
  else
    UpdateNewKoef(FKoefArray[I]);

  //Добавить процедуру пересчета отчета
end;

procedure TFormReportSSR.GetSSRReport();
var SmStr, CaptStr: string;
    LastC, LastSC: Integer;
    I, J: Integer;

    CZP, CZP5, CEMiM, CZPMash, CMat,
    CMatTransp, COXROPR, CPlanPrib,
    CDevices, CTransp, COther, CTrud,
    CTotal: Double;

    AllZP, AllZP5, AllEMiM, AllZPMash, AllMat,
    AllMatTransp, AllOXROPR, AllPlanPrib,
    AllDevices, AllTransp, AllOther, AllTrud,
    AllTotal: Double;

    TmpKoef: TKoefRec;

    ev: TFieldNotifyEvent;

procedure AddItog();
begin
  mtSSR.Append;
  mtSSRNum.AsString := LastC.ToString + '.90';
  mtSSRName.AsString := 'ИТОГО ПО ГЛАВЕ ' + LastC.ToString;
  mtSSRCID.Value := LastC;
  mtSSRSCID.Value := 0;
  mtSSRItog.Value := 1;
  mtSSR.Post;
  if (LastC >= 7) and (LastC <> 10) then
  begin
    mtSSR.Append;
    mtSSRNum.AsString := LastC.ToString + '.95';
    mtSSRName.AsString := 'ИТОГО ПО ГЛАВАМ 1-' + LastC.ToString;
    mtSSRCID.Value := LastC;
    mtSSRSCID.Value := 0;
    mtSSRItog.Value := 2;
    mtSSR.Post;
  end;
end;

procedure AddTotal();
begin
  mtSSRTotal.Value :=
    mtSSRZP.Value + mtSSREMiM.Value + mtSSRMat.Value +
    mtSSRMatTransp.Value + mtSSROXROPR.Value +
    mtSSRPlanPrib.Value + mtSSRDevices.Value +
    mtSSRTransp.Value + mtSSROther.Value;
end;

procedure AddKoef(ALineNom: string);
var I: Integer;
begin
  I :=  FindLineNom(FKoefArray, ALineNom);
  if I > -1 then
  begin
    if FKoefArray[I].Pers > 0 then
      mtSSRPepcent.Value := FKoefArray[I].Pers * 100;
    if FKoefArray[I].Koef1 > 0 then
      mtSSRKoef1.Value := FKoefArray[I].Koef1;
    if FKoefArray[I].Koef2 > 0 then
      mtSSRKoef2.Value := FKoefArray[I].Koef2;
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
  ev := mtSSRPepcent.OnChange;
  try
    mtSSRPepcent.OnChange := nil;
    mtSSRKoef1.OnChange := nil;
    mtSSRKoef2.OnChange := nil;

    if not mtSSR.Active then
      mtSSR.Active :=True;
    mtSSR.EmptyDataSet;

    mtSSR.BeginBatch();
    try
      //Получение данных по сметам
      qrTemp.Active := False;
      qrTemp.SQL.Text := CaptStr;
      qrTemp.ParamByName('OBJ_ID').Value := FObjectID;
      qrTemp.Active := True;
      LastC := 0;
      LastSC := 0;

      while not qrTemp.Eof do
      begin
        //Добавляет строку главы
        if LastC <> qrTemp.FieldByName('CID').AsInteger then
        begin
          if LastC > 0 then
            AddItog();

          LastC := qrTemp.FieldByName('CID').AsInteger;
          LastSC := 0;
          I := 0;
          J := 0;

          mtSSR.Append;
          mtSSRNum.AsString := LastC.ToString + '.' + LastSC.ToString;

          AddKoef(mtSSRNum.AsString);

          mtSSRName.AsString :=
            'ГЛАВА ' + LastC.ToString + ' ' + qrTemp.FieldByName('CNAME').AsString;

          mtSSRCID.Value := LastC;
          mtSSRSCID.Value := LastSC;

          mtSSR.Post;
        end;

        //Добавляет строку строки
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
          AddTotal();

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

    finally
      mtSSR.EndBatch;
    end;

    mtSSR.BeginBatch();
    try
      CZP := 0;
      CZP5 := 0;
      CEMiM := 0;
      CZPMash := 0;
      CMat := 0;
      CMatTransp := 0;
      COXROPR := 0;
      CPlanPrib := 0;
      CDevices := 0;
      CTransp := 0;
      COther := 0;
      CTotal := 0;
      CTrud := 0;

      //Полуение итогов по строкам
      mtSSR.Last;
      while not mtSSR.Bof do
      begin
        if mtSSRSM_ID.Value = 0 then
        begin
          if (CTotal + CTrud) > 0 then
          begin
            //Добавить поддержку коэффициентов по строке
            mtSSR.Edit;
            mtSSRZP.Value := CZP;
            mtSSRZP5.Value := CZP5;
            mtSSREMiM.Value := CEMiM;
            mtSSRZPMash.Value := CZPMash;
            mtSSRMat.Value := CMat;
            mtSSRMatTransp.Value := CMatTransp;
            mtSSROXROPR.Value := COXROPR;
            mtSSRPlanPrib.Value := CPlanPrib;
            mtSSRDevices.Value := CDevices;
            mtSSRTransp.Value := CTransp;
            mtSSROther.Value := COther;
            mtSSRTotal.Value := CTotal;
            mtSSRTrud.Value := CTrud;
            mtSSR.Post;
          end;

          CZP := 0;
          CZP5 := 0;
          CEMiM := 0;
          CZPMash := 0;
          CMat := 0;
          CMatTransp := 0;
          COXROPR := 0;
          CPlanPrib := 0;
          CDevices := 0;
          CTransp := 0;
          COther := 0;
          CTotal := 0;
          CTrud := 0;
        end;

        if (mtSSRSM_ID.Value > 0) and (mtSSRSM_TYPE.Value = 2) then
        begin
          CZP := CZP + mtSSRZP.Value;
          CZP5 := CZP5 + mtSSRZP5.Value;
          CEMiM := CEMiM + mtSSREMiM.Value;
          CZPMash := CZPMash + mtSSRZPMash.Value;
          CMat := CMat + mtSSRMat.Value;
          CMatTransp := CMatTransp + mtSSRMatTransp.Value;
          COXROPR := COXROPR + mtSSROXROPR.Value;
          CPlanPrib := CPlanPrib + mtSSRPlanPrib.Value;
          CDevices := CDevices + mtSSRDevices.Value;
          CTransp := CTransp + mtSSRTransp.Value;
          COther := COther + mtSSROther.Value;
          CTotal := CTotal + mtSSRTotal.Value;
          CTrud := CTrud + mtSSRTrud.Value;
        end;

        mtSSR.Prior;
      end;

      CZP := 0;
      CZP5 := 0;
      CEMiM := 0;
      CZPMash := 0;
      CMat := 0;
      CMatTransp := 0;
      COXROPR := 0;
      CPlanPrib := 0;
      CDevices := 0;
      CTransp := 0;
      COther := 0;
      CTotal := 0;
      CTrud := 0;

      AllZP := 0;
      AllZP5 := 0;
      AllEMiM := 0;
      AllZPMash := 0;
      AllMat := 0;
      AllMatTransp := 0;
      AllOXROPR := 0;
      AllPlanPrib := 0;
      AllDevices := 0;
      AllTransp := 0;
      AllOther := 0;
      AllTotal := 0;
      AllTrud := 0;

      //Подбивает итог по кождой из глав до главы 7
      while not mtSSR.Eof do
      begin
        if (mtSSRItog.Value = 2) then  //Итог по 1-7
        begin
          mtSSR.Edit;
          mtSSRZP.Value := AllZP;
          mtSSRZP5.Value := AllZP5;
          mtSSREMiM.Value := AllEMiM;
          mtSSRZPMash.Value := AllZPMash;
          mtSSRMat.Value := AllMat;
          mtSSRMatTransp.Value := AllMatTransp;
          mtSSROXROPR.Value := AllOXROPR;
          mtSSRPlanPrib.Value := AllPlanPrib;
          mtSSRDevices.Value := AllDevices;
          mtSSRTransp.Value := AllTransp;
          mtSSROther.Value := AllOther;
          mtSSRTotal.Value := AllTotal;
          mtSSRTrud.Value := AllTrud;
          mtSSR.Post;

          Break;
        end;

        if (mtSSRItog.Value = 1) then
        begin
          if (CTotal + CTrud) > 0 then
          begin
            mtSSR.Edit;
            mtSSRZP.Value := CZP;
            mtSSRZP5.Value := CZP5;
            mtSSREMiM.Value := CEMiM;
            mtSSRZPMash.Value := CZPMash;
            mtSSRMat.Value := CMat;
            mtSSRMatTransp.Value := CMatTransp;
            mtSSROXROPR.Value := COXROPR;
            mtSSRPlanPrib.Value := CPlanPrib;
            mtSSRDevices.Value := CDevices;
            mtSSRTransp.Value := CTransp;
            mtSSROther.Value := COther;
            mtSSRTotal.Value := CTotal;
            mtSSRTrud.Value := CTrud;
            mtSSR.Post;
          end;

          AllZP := AllZP + CZP;
          AllZP5 := AllZP5 + CZP5;
          AllEMiM := AllEMiM + CEMiM;
          AllZPMash := AllZPMash + CZPMash;
          AllMat := AllMat + CMat;
          AllMatTransp := AllMatTransp + CMatTransp;
          AllOXROPR := AllOXROPR + COXROPR;
          AllPlanPrib := AllPlanPrib + CPlanPrib;
          AllDevices := AllDevices + CDevices;
          AllTransp := AllTransp + CTransp;
          AllOther := AllOther + COther;
          AllTotal := AllTotal+ CTotal;
          AllTrud := AllTrud + CTrud;

          CZP := 0;
          CZP5 := 0;
          CEMiM := 0;
          CZPMash := 0;
          CMat := 0;
          CMatTransp := 0;
          COXROPR := 0;
          CPlanPrib := 0;
          CDevices := 0;
          CTransp := 0;
          COther := 0;
          CTotal := 0;
          CTrud := 0;
        end;

        if (mtSSRSM_ID.Value = 0) and (mtSSRItog.Value = 0) then
        begin
          CZP := CZP + mtSSRZP.Value;
          CZP5 := CZP5 + mtSSRZP5.Value;
          CEMiM := CEMiM + mtSSREMiM.Value;
          CZPMash := CZPMash + mtSSRZPMash.Value;
          CMat := CMat + mtSSRMat.Value;
          CMatTransp := CMatTransp + mtSSRMatTransp.Value;
          COXROPR := COXROPR + mtSSROXROPR.Value;
          CPlanPrib := CPlanPrib + mtSSRPlanPrib.Value;
          CDevices := CDevices + mtSSRDevices.Value;
          CTransp := CTransp + mtSSRTransp.Value;
          COther := COther + mtSSROther.Value;
          CTotal := CTotal + mtSSRTotal.Value;
          CTrud := CTrud + mtSSRTrud.Value;
        end;

        mtSSR.Next;
      end;

      mtSSR.First;
    finally
      mtSSR.EndBatch;
    end;
  finally
    mtSSRPepcent.OnChange := ev;
    mtSSRKoef1.OnChange := ev;
    mtSSRKoef2.OnChange := ev;
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
  // Процедура наложения стилей отрисовки таблиц по умолчанию
  with (Sender AS TJvDBGrid).Canvas do
  begin
    Brush.Color := PS.BackgroundRows;
    Font.Color := PS.FontRows;

    headerLines := 1;
    if not(dgTitles in (Sender AS TJvDBGrid).Options) then
      headerLines := 0;

    if (mtSSRSM_ID.Value = 0) then //Шапки глав
    begin
      Brush.Color := $00E3E3CE;
      if mtSSRSCID.Value = 0 then
      begin
        Font.Style := Font.Style + [fsBold];
        Brush.Color := $00CACAA2;
      end;
    end;

    if (mtSSRItog.Value > 0) then  //Итоги
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

    // Строка в фокусе
    if (Assigned(TMyDBGrid((Sender AS TJvDBGrid)).DataLink) and
      ((Sender AS TJvDBGrid).Row = TMyDBGrid((Sender AS TJvDBGrid)).DataLink.ActiveRecord + headerLines)) then
    begin
      Brush.Color := PS.BackgroundSelectRow;
      Font.Color := PS.FontSelectRow;
    end;
    // Ячейка в фокусе
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
