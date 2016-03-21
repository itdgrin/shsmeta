unit fReportSSR;
//Отчет по возможности формируется по внутренним номерам CNUM, но привязка
//к номерам строк NUM в отчете частично сохраняется
//Так-же ожидается некоторый определенный порядок строк в SSRItems
//Если порядок строк изменится надо доработать код!!

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
  Vcl.ExtCtrls, fReportSSRPI, Vcl.Menus, GlobsAndConst;

type

  TFormReportSSR = class(TSmForm)
    pnlGrid: TPanel;
    grSSR: TJvDBGrid;
    mtSSR: TFDMemTable;
    dsSSR: TDataSource;
    mtSSRNum: TStringField;
    mtSSRPepcent: TFloatField;
    mtSSRKoef1: TFloatField;
    mtSSRKoef2: TFloatField;
    mtSSRTransp: TFloatField;
    mtSSROXROPR: TFloatField;
    mtSSRPlanPrib: TFloatField;
    mtSSRDevices: TFloatField;
    mtSSRZP: TFloatField;
    mtSSRZP5: TFloatField;
    mtSSREMiM: TFloatField;
    mtSSRZPMash: TFloatField;
    mtSSRMat: TFloatField;
    mtSSRMatTransp: TFloatField;
    mtSSROther: TFloatField;
    mtSSRTotal: TFloatField;
    mtSSRTrud: TFloatField;
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
    pmSSR: TPopupMenu;
    pmSSRIndex: TMenuItem;
    pmTempBuilds: TMenuItem;
    pmZimUdor: TMenuItem;
    pmRazRaboti: TMenuItem;
    pmEdinZakaz: TMenuItem;
    pmNepredvid: TMenuItem;
    mtSSRCNUM: TStringField;
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
    procedure FormDestroy(Sender: TObject);
    procedure pmSSRIndexClick(Sender: TObject);
    procedure pmTempBuildsClick(Sender: TObject);
    procedure pmSSRPopup(Sender: TObject);
  private
    FObjectID: Integer;
    FKoefArray: TKoefArray;
    FKVrem,
    FKZim: Double;
    FKSocStrax: Double;
    FReportSSRPI: TFormReportSSRPI;

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

uses Main, DataModule, CardObject, SSR;

{$R *.dfm}

const SSRItems: array[0..12, 0..3] of string =
  (('90.10','9010','СРЕДСТВА НА НЕПРЕДВИДЕННЫЕ РАБОТЫ И ЗАТРАТЫ','0'),
   ('90.11','9011','ИТОГО С УЧЕТОМ НЕПРЕДВИДЕННЫХ','1'),
   ('90.12','9012','НАЛОГИ И ОТЧИСЛЕНИЯ В СООТВЕТСТВИИ С ДЕЙСТВУЮЩИМ ЗАКОНОДАТЕЛЬСТВОМ НА ДАТУ РАЗРАБОТКИ СМЕТНОЙ ДОКУМЕНТАЦИИ','0'),
   ('90.12.0.1','901201','.   в т.ч. Инновационный фонд','0'),
   ('90.12.0.2','901202','.   Налог от выручки при упрощенной системе налогообложения','0'),
   ('90.12.0.3','901203','.   НДС (для объектов не освобожденных от НДС)','0'),
   ('90.12.0.4','901204','.   Госпошлина','0'),
   ('90.13','9013','ИТОГО С УЧЕТОМ НАЛОГОВ','1'),
   ('90.14','9014','СРЕДСТВА, УЧИТЫВАЮЩИЕ ПРИМЕНЕНИЕ ПРОГНОЗНЫХ ИНДЕКСОВ ЦЕН В СТРОИТЕЛЬСТВЕ','0'),
   ('90.15','9015','ИТОГО ПО СВОДНОМУ СМЕТНОМУ РАСЧЕТУ','1'),
   ('90.19','9019','ВОЗВРАТНЫЕ СУММЫ','0'),
   ('90.20','9020','СМЕТНАЯ СТОИМОСТЬ ДОЛЕВОГО УЧАСТИЯ В СТРОИТЕЛЬСТВЕ ОБЪЕКТОВ ИЛИ ИХ ЧАСТЕЙ ВСПОМОГАТЕЛЬНОГО ПРОИЗВОДСТВА И НАЗНАЧЕНИЯ, ПРЕДНАЗНАЧЕННЫХ ДЛЯ ОБСЛУЖИВАНИЯ НЕСКОЛЬКИХ ЗАКАЗЧИКОВ, ЗАСТРОЙЩИКОВ','0'),
   ('90.30','9030','ВСЕГО К УТВЕРЖДЕНИЮ','1'));

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
    ShowMessage('Не задан объект!');
    PostMessage(Handle, WM_CLOSE, 0, 0);
    Exit;
  end;
  //Месячные величины участвующие в отчете
  FKVrem := qrObject.FieldByName('KVREM').AsFloat;
  FKZim := qrObject.FieldByName('KZIM').AsFloat;
  FKSocStrax := qrObject.FieldByName('KSOCSTRAX').AsFloat;

  cbObjName.KeyValue := qrObject.FieldByName('obj_id').Value;
  cbObjName.OnClick(cbObjName);

  FReportSSRPI := TFormReportSSRPI.Create(Self, FObjectID);
  GetSSRReport();
end;

procedure TFormReportSSR.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FReportSSRPI);
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

  I := FindLineNom(AArray, '0801');
  if I = -1 then
  begin
    I := Length(AArray);
    SetLength(AArray, Length(AArray) + 1);
    AArray[I].LineNom := '0801';
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

  I := FindLineNom(AArray, '0802');
  if I = -1 then
  begin
    I := Length(AArray);
    SetLength(AArray, Length(AArray) + 1);
    AArray[I].LineNom := '0802';
    AArray[I].Pers := 15;
    AArray[I].Koef1 := 1;
    AArray[I].Koef2 := 1;
    AddNewKoef(AArray[I]);
  end;

  I := FindLineNom(AArray, '0901');
  if I = -1 then
  begin
    I := Length(AArray);
    SetLength(AArray, Length(AArray) + 1);
    AArray[I].LineNom := '0901';
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

  I := FindLineNom(AArray, '0902');
  if I = -1 then
  begin
    I := Length(AArray);
    SetLength(AArray, Length(AArray) + 1);
    AArray[I].LineNom := '0902';
    AArray[I].Pers := FKSocStrax;
    AArray[I].Koef1 := 1;
    AArray[I].Koef2 := 1;
    AddNewKoef(AArray[I]);
  end;

  I := FindLineNom(AArray, '0903');
  if I = -1 then
  begin
    I := Length(AArray);
    SetLength(AArray, Length(AArray) + 1);
    AArray[I].LineNom := '0903';
    AArray[I].Pers := '9.7';
    AArray[I].Koef1 := 1;
    AArray[I].Koef2 := 1;
    AddNewKoef(AArray[I]);
  end;

  I := FindLineNom(AArray, '0910');
  if I = -1 then
  begin
    I := Length(AArray);
    SetLength(AArray, Length(AArray) + 1);
    AArray[I].LineNom := '0910';
    AArray[I].Pers := 0.306;
    AArray[I].Koef1 := 1;
    AArray[I].Koef2 := 1;
    AddNewKoef(AArray[I]);
  end;

  I := FindLineNom(AArray, '1001');
  if I = -1 then
  begin
    I := Length(AArray);
    SetLength(AArray, Length(AArray) + 1);
    AArray[I].LineNom := '1001';
    AArray[I].Pers := 1.8;
    AArray[I].Koef1 := 1;
    AArray[I].Koef2 := 1;
    AddNewKoef(AArray[I]);
  end;

  I := FindLineNom(AArray, '1002');
  if I = -1 then
  begin
    I := Length(AArray);
    SetLength(AArray, Length(AArray) + 1);
    AArray[I].LineNom := '1002';
    AArray[I].Pers := 0.2; //????????????
    AArray[I].Koef1 := 1;
    AArray[I].Koef2 := 1;
    AddNewKoef(AArray[I]);
  end;

  I := FindLineNom(AArray, '1006');
  if I = -1 then
  begin
    I := Length(AArray);
    SetLength(AArray, Length(AArray) + 1);
    AArray[I].LineNom := '1006';
    AArray[I].Pers := 0.35; //????????????????
    AArray[I].Koef1 := 1;
    AArray[I].Koef2 := 1;
    AddNewKoef(AArray[I]);
  end;

  I := FindLineNom(AArray, '1007');
  if I = -1 then
  begin
    I := Length(AArray);
    SetLength(AArray, Length(AArray) + 1);
    AArray[I].LineNom := '1007';
    AArray[I].Pers := 0.09;
    AArray[I].Koef1 := 1;
    AArray[I].Koef2 := 1;
    AddNewKoef(AArray[I]);
  end;

  I := FindLineNom(AArray, '9010');
  if I = -1 then
  begin
    I := Length(AArray);
    SetLength(AArray, Length(AArray) + 1);
    AArray[I].LineNom := '9010';
    AArray[I].Pers := 3;
    AArray[I].Koef1 := 1;
    AArray[I].Koef2 := 1;
    AddNewKoef(AArray[I]);
  end;

  I := FindLineNom(AArray, '901203');
  if I = -1 then
  begin
    I := Length(AArray);
    SetLength(AArray, Length(AArray) + 1);
    AArray[I].LineNom := '901203';
    AArray[I].Pers := G_NDS/100;
    AArray[I].Koef1 := 1;
    AArray[I].Koef2 := 1;
    AddNewKoef(AArray[I]);
  end;

  I := FindLineNom(AArray, '901204');
  if I = -1 then
  begin
    I := Length(AArray);
    SetLength(AArray, Length(AArray) + 1);
    AArray[I].LineNom := '901204';
    AArray[I].Pers := 0.015;
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
  I := FindLineNom(FKoefArray, mtSSRCNum.AsString);
  if I = -1 then
  begin
    I := Length(FKoefArray);
    SetLength(FKoefArray, I + 1);
    IsNew := True;
  end;
  FKoefArray[I].LineNom := mtSSRCNum.AsString;
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

procedure TFormReportSSR.pmSSRIndexClick(Sender: TObject);
begin
  if FReportSSRPI.ShowModal = mrYes then
    UpdateTimerTimer(nil);
end;

procedure TFormReportSSR.pmSSRPopup(Sender: TObject);
begin
  pmTempBuilds.Visible := mtSSRCNum.AsString = '0801';
  pmZimUdor.Visible := mtSSRCNum.AsString = '0901';
  pmRazRaboti.Visible := mtSSRCNum.AsString = '0903';
  pmEdinZakaz.Visible := mtSSRCNum.AsString = '1001';
  pmNepredvid.Visible := mtSSRCNum.AsString = '9010';
  pmSSRIndex.Visible := mtSSRCNum.AsString = '9014';
end;

procedure TFormReportSSR.pmTempBuildsClick(Sender: TObject);
var fSSR: TfSSR;
    I: Integer;
    IsNew: Boolean;
    TmpStr: string;
begin
  case (Sender as TMenuItem).Tag of
  1: TmpStr := 'Сметные нормы для дополнительных затрат при производстве работ в зимнее время';
  2: TmpStr := 'Сметные нормы затрат на строительство временных зданий и сооружений';
  3: TmpStr := 'Резерв на непредвиденные затраты';
  4: TmpStr := 'Содержание единых заказчиков';
  5: TmpStr := 'Затраты, связанные с подвижным и разъездным характером работ';
  end;

  fSSR := TfSSR.Create(Self, VarArrayOf([(Sender as TMenuItem).Tag, TmpStr, True]));
  try
    if fSSR.ShowModal = mrOk then
    begin
        IsNew := False;
        I := FindLineNom(FKoefArray, mtSSRCNum.AsString);
        if I = -1 then
        begin
          I := Length(FKoefArray);
          SetLength(FKoefArray, I + 1);
          IsNew := True;
        end;

        FKoefArray[I].LineNom := mtSSRCNum.AsString;
        FKoefArray[I].SprID := fSSR.SprID;
        case (Sender as TMenuItem).Tag of
        1, 2: qrTemp.SQL.Text := 'select COEF_NORM from ssrdetail where ID = :ID';
        3: qrTemp.SQL.Text := 'select VALUE from ssrclients where ID = :ID';
        4: qrTemp.SQL.Text := 'select VALUE from ssrreserve where ID = :ID';
        5: qrTemp.SQL.Text := 'select VALUE from ssrcost where ID = :ID';
        end;
        qrTemp.ParamByName('ID').Value := FKoefArray[I].SprID;
        qrTemp.Active := True;
        if not qrTemp.IsEmpty then
          FKoefArray[I].Pers := qrTemp.Fields[0].Value;
        qrTemp.Active := False;
        FKoefArray[I].Koef1 := TField(mtSSRKoef1).Value;
        FKoefArray[I].Koef2 := TField(mtSSRKoef2).Value;

        if IsNew then
          AddNewKoef(FKoefArray[I])
        else
          UpdateNewKoef(FKoefArray[I]);

        //Приведет по ситу к повторному выполнению всех операторов + пересчету отчета
        mtSSR.Edit;
        TField(mtSSRPepcent).Value := FKoefArray[I].Pers;
    end;
  finally
    FreeAndNil(fSSR);
  end;
end;

//Процедура добавляет в расчет все необходимые строки и вытягивает инфу по сметам
procedure TFormReportSSR.GetSSRReport();
var SmStr, CaptStr: string;
    LastC, LastSC: Integer;
    I, J: Integer;
    ev: TFieldNotifyEvent;

procedure AddItog();
begin
  mtSSR.Append;
  mtSSRNum.AsString := LastC.ToString + '.90';
  mtSSRCNum.AsString := Copy((100 + LastC).ToString, 2, 2) + '90';
  mtSSRName.AsString := 'ИТОГО ПО ГЛАВЕ ' + LastC.ToString;
  mtSSRCID.Value := LastC;
  mtSSRSCID.Value := 0;
  mtSSRItog.Value := 1;
  mtSSR.Post;
  if (LastC >= 7) and (LastC <> 10) then
  begin
    mtSSR.Append;
    mtSSRNum.AsString := LastC.ToString + '.95';
    mtSSRCNum.AsString := Copy((100 + LastC).ToString, 2, 2) + '95';
    mtSSRName.AsString := 'ИТОГО ПО ГЛАВАМ 1-' + LastC.ToString;
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
    '(SELECT IFNULL(`CID`, 2) FROM `ssr_chapters` WHERE ID = ' +
      '(Select CHAP_ID FROM smetasourcedata WHERE SM_ID = ' +
      '(Select PARENT_ID FROM smetasourcedata WHERE SM_ID = s.PARENT_ID))) CHAPTER, ' +
    '(SELECT IFNULL(`SCID`, 1) FROM `ssr_chapters` WHERE ID = ' +
      '(Select CHAP_ID FROM smetasourcedata WHERE SM_ID = ' +
      '(Select PARENT_ID FROM smetasourcedata WHERE SM_ID = s.PARENT_ID))) ROW_NUMBER, ' +
    'SUM(COALESCE(d.ZPF, d.ZP, 0)) ZP, ' +
    'SUM(COALESCE(d.ZP_PRF, d.ZP_PR, 0)) ZP_PR, ' +
    'SUM(COALESCE(d.EMiMF, d.EMiM, 0)) EMiM, ' +
    'SUM(COALESCE(d.ZP_MASHF, d.ZP_MASH, 0)) ZP_MASH, ' +
    'SUM(COALESCE(d.MRF, d.MR, 0)) MR, ' +
    'SUM(COALESCE(d.TRANSPF, d.TRANSP, 0)) TRANSP, ' +
    'SUM(COALESCE(d.OHROPRF, d.OHROPR, 0)) OHROPR, ' +
    'SUM(COALESCE(d.PLAN_PRIBF, d.PLAN_PRIB, 0)) PLAN_PRIB, ' +
    'SUM(COALESCE(d.MR_DEVICEF, d.MR_DEVICE, 0)) MR_DEVICE, ' +
    'SUM(COALESCE(d.TRANSP_DEVICEF, d.TRANSP_DEVICE, 0)) TRANSP_DEVICE, ' +
    'SUM(COALESCE(d.OTHERF, d.OTHER, 0)) OTHER, ' +
    'SUM(COALESCE(d.TRUDF, d.TRUD, 0)) TRUD ' +
    'FROM smetasourcedata s, summary_calculation d ' +
    'WHERE (s.DELETED = 0) AND (s.OBJ_ID = :OBJ_ID) AND ' +
          '(d.SM_ID = s.SM_ID) AND (s.ACT = 0) AND ' +
          '(s.SM_ID in (Select SM_ID FROM smetasourcedata WHERE ' +
            '(PARENT_ID in (Select SM_ID FROM smetasourcedata WHERE ' +
            '(PARENT_ID in (Select SM_ID FROM smetasourcedata WHERE ' +
            '(OBJ_ID = :OBJ_ID) AND (DELETED = 0) AND (ACT = 0) AND (SM_TYPE = 2)))' +
            ' and (IFNULL(SM_SUBTYPE, 0) <> 2))))) ' +
    'GROUP BY SM_ID ' +
    'UNION ALL ' +
    'Select (Select SM_ID FROM smetasourcedata WHERE SM_ID = s.PARENT_ID) SM_ID, ' +
    '(Select CONCAT(IFNULL(SM_NUMBER, ""), " ",  IFNULL(NAME, "")) SM_NAME ' +
      'FROM smetasourcedata WHERE SM_ID = s.PARENT_ID) SM_NAME, ' +
    '(Select SM_TYPE FROM smetasourcedata WHERE SM_ID = s.PARENT_ID) SM_TYPE, ' +
    '(SELECT IFNULL(`CID`, 2) FROM `ssr_chapters` WHERE ID = ' +
      '(Select CHAP_ID FROM smetasourcedata WHERE SM_ID = ' +
      '(Select PARENT_ID FROM smetasourcedata WHERE SM_ID = s.PARENT_ID))) CHAPTER, ' +
    '(SELECT IFNULL(`SCID`, 1) FROM `ssr_chapters` WHERE ID = ' +
      '(Select CHAP_ID FROM smetasourcedata WHERE SM_ID = ' +
      '(Select PARENT_ID FROM smetasourcedata WHERE SM_ID = s.PARENT_ID))) ROW_NUMBER, ' +
    'SUM(COALESCE(d.ZPF, d.ZP, 0)) ZP, ' +
    'SUM(COALESCE(d.ZP_PRF, d.ZP_PR, 0)) ZP_PR, ' +
    'SUM(COALESCE(d.EMiMF, d.EMiM, 0)) EMiM, ' +
    'SUM(COALESCE(d.ZP_MASHF, d.ZP_MASH, 0)) ZP_MASH, ' +
    'SUM(COALESCE(d.MRF, d.MR, 0)) MR, ' +
    'SUM(COALESCE(d.TRANSPF, d.TRANSP, 0)) TRANSP, ' +
    'SUM(COALESCE(d.OHROPRF, d.OHROPR, 0)) OHROPR, ' +
    'SUM(COALESCE(d.PLAN_PRIBF, d.PLAN_PRIB, 0)) PLAN_PRIB, ' +
    'SUM(COALESCE(d.MR_DEVICEF, d.MR_DEVICE, 0)) MR_DEVICE, ' +
    'SUM(COALESCE(d.TRANSP_DEVICEF, d.TRANSP_DEVICE, 0)) TRANSP_DEVICE, ' +
    'SUM(COALESCE(d.OTHERF, d.OTHER, 0)) OTHER, ' +
    'SUM(COALESCE(d.TRUDF, d.TRUD, 0)) TRUD ' +
    'FROM smetasourcedata s, summary_calculation d ' +
    'WHERE (s.DELETED = 0) AND (s.OBJ_ID = :OBJ_ID) AND ' +
          '(d.SM_ID = s.SM_ID) AND (s.ACT = 0) AND ' +
          '(s.SM_ID in (Select SM_ID FROM smetasourcedata WHERE ' +
            '(PARENT_ID in (Select SM_ID FROM smetasourcedata WHERE ' +
            '((PARENT_ID in (Select SM_ID FROM smetasourcedata WHERE ' +
            '(OBJ_ID = :OBJ_ID) AND (DELETED = 0) AND (ACT = 0) AND (SM_TYPE = 2))))' +
            ' and (IFNULL(SM_SUBTYPE, 0) <> 2))))) ' +
    'GROUP BY SM_ID';

  CaptStr := 'Select sc.CID, COALESCE(sc.SCID, 0) SCID, sc.CNAME, sc.CNUM, sm.SM_ID, ' +
    'IF(sm.SM_ID is NULL, NULL, FN_getSortSM(sm.SM_ID)) SM_SORT, sm.SM_NAME, ' +
    'sm.SM_TYPE, ZP, ZP_PR, EMiM, ZP_MASH, MR, TRANSP, OHROPR, PLAN_PRIB, ' +
    'MR_DEVICE, TRANSP_DEVICE, OTHER, TRUD ' +
    'FROM ssr_chapters sc left join (' + SmStr + ') sm ' +
    'on (sc.CID = sm.CHAPTER) and (COALESCE(sc.SCID, 0) = COALESCE(sm.ROW_NUMBER, 0)) ' +
    'where ((DATES is Null) or (DATES >= :DATESM)) and ' +
          '((DATEPO is Null) or (DATEPO <= :DATESM)) ' +
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

    //Получение данных по сметам
    qrTemp.Active := False;
    qrTemp.SQL.Text := CaptStr;
    qrTemp.ParamByName('OBJ_ID').Value := FObjectID;
    qrTemp.ParamByName('DATESM').Value :=
      FastSelectSQLOne('Select BEG_STROJ from objcards where OBJ_ID = :0',
        VarArrayOf([FObjectID]));
    qrTemp.Active := True;
    LastC := 0;
    LastSC := 0;

    while not qrTemp.Eof do
    begin
      //Добавляет строку 8.2
      if LastC <> qrTemp.FieldByName('CID').AsInteger then
      begin
        if (LastC = 8) then
        begin
          mtSSR.Append;
          mtSSRNum.AsString := '8.2';
          mtSSRCNum.AsString := '0802';
          AddKoef(mtSSRCNum.AsString);
          mtSSRName.AsString :=
            'в т.ч. ВОЗВРАТ МАТЕРИАЛОВ, ИЗДЕЛИЙ И КОНСТРУКЦИЙ ОТ РАЗБОРКИ ВРЕМЕННЫХ ЗДАНИЙ И СООРУЖЕНИЙ';

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
          mtSSRCNum.AsString := '0996';
          AddKoef(mtSSRCNum.AsString);
          mtSSRName.AsString :=
            'в т.ч. ВОЗВРАТ МАТЕРИАЛОВ';

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
        mtSSRCNum.AsString := qrTemp.FieldByName('CNUM').AsString;
        AddKoef(mtSSRCNum.AsString);

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
        mtSSRName.AsString := qrTemp.FieldByName('CNAME').AsString;
        mtSSRCID.Value := qrTemp.FieldByName('CID').AsInteger;
        mtSSRSCID.Value := qrTemp.FieldByName('SCID').AsInteger;
        mtSSRCNUM.AsString := qrTemp.FieldByName('CNUM').AsString;
        AddKoef(mtSSRCNum.AsString);
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
        mtSSRCNUM.AsString := qrTemp.FieldByName('CNUM').AsString;
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
      mtSSRCNum.AsString := SSRItems[I][1];
      mtSSRName.AsString := SSRItems[I][2];
      mtSSRItog.Value := StrToIntDef(SSRItems[I][3], 0);
      if mtSSRItog.Value = 0 then
        AddKoef(mtSSRCNum.AsString);
      mtSSR.Post;
    end;

  finally
    mtSSR.EndBatch;
    mtSSRPepcent.OnChange := ev;
    mtSSRKoef1.OnChange := ev;
    mtSSRKoef2.OnChange := ev;
  end;

  //Выполняет последующие расчеты и суммации
  RecalcReport();
  mtSSR.First;
end;

//Выполняет последующие расчеты и суммации
procedure TFormReportSSR.RecalcReport();
var I, J: Integer;
    TmpLine,
    TmpLine1,
    AllLine,
    Line0190,
    Line0795,
    Line0801,
    Line0802,
    Line0895,
    Line0901,
    Line0902,
    Line0903,
    Line0904,
    Line0905,
    Line0906,
    Line0907,
    Line0908,
    Line0910,
    Line0911,
    Line0912,
    Line0990,
    Line0995,
    Line1001,
    Line1002,
    Line1003,
    Line1004,
    Line1195,
    Line9011,
    Line9013: TRepSSRLine;
    Bookmark0802,
    Bookmark0996,
    Bookmark9012,
    TmpBookmark: TBookMark;
    KZp, KEmim, KEmimZp, KMr: Double;
    TmpKoef, TmpKoef1: TKoefRec;

function VarIsAssign(AValue: Variant): Boolean;
begin
  Result := VarIsOrdinal(AValue) or VarIsFloat(AValue);
end;

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
  if (ALine.Total <> 0) or (ALine.Trud <> 0) then
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

  ALine.ZP := SmRound(ALine.ZP * Perc * Koef1 * Koef2);
  ALine.ZP5 := SmRound(ALine.ZP5 * Perc * Koef1 * Koef2);
  ALine.EMiM := SmRound(ALine.EMiM * Perc * Koef1 * Koef2);
  ALine.ZPMash := SmRound(ALine.ZPMash * Perc * Koef1 * Koef2);
  ALine.Mat := SmRound(ALine.Mat * Perc * Koef1 * Koef2);
  ALine.MatTransp := SmRound(ALine.MatTransp * Perc * Koef1 * Koef2);
  ALine.OXROPR := SmRound(ALine.OXROPR * Perc * Koef1 * Koef2);
  ALine.PlanPrib := SmRound(ALine.PlanPrib * Perc * Koef1 * Koef2);
  ALine.Devices := SmRound(ALine.Devices * Perc * Koef1 * Koef2);
  ALine.Transp := SmRound(ALine.Transp * Perc * Koef1 * Koef2);
  ALine.Other := SmRound(ALine.Other * Perc * Koef1 * Koef2);
  ALine.CalcTotal;
  ALine.Trud := SmRound(ALine.Trud * Perc * Koef1 * Koef2);
end;

begin
  TmpLine := default(TRepSSRLine);
  TmpLine1 := default(TRepSSRLine);
  AllLine := default(TRepSSRLine);
  Line0190 := default(TRepSSRLine);
  Line0795 := default(TRepSSRLine);
  Line0801 := default(TRepSSRLine);
  Line0802 := default(TRepSSRLine);
  Line0895 := default(TRepSSRLine);
  Line0901 := default(TRepSSRLine);
  Line0902 := default(TRepSSRLine);
  Line0903 := default(TRepSSRLine);
  Line0904 := default(TRepSSRLine);
  Line0905 := default(TRepSSRLine);
  Line0906 := default(TRepSSRLine);
  Line0907 := default(TRepSSRLine);
  Line0908 := default(TRepSSRLine);
  Line0910 := default(TRepSSRLine);
  Line0911 := default(TRepSSRLine);
  Line0912 := default(TRepSSRLine);
  Line0990 := default(TRepSSRLine);
  Line0995 := default(TRepSSRLine);
  Line1001 := default(TRepSSRLine);
  Line1002 := default(TRepSSRLine);
  Line1003 := default(TRepSSRLine);
  Line1004 := default(TRepSSRLine);
  Line1195 := default(TRepSSRLine);
  Line9011 := default(TRepSSRLine);
  Line9013 := default(TRepSSRLine);

  mtSSR.DisableControls;
  try
    //Полуение итогов по строкам
    mtSSR.Last;
    while not mtSSR.Bof do
    begin
      if (mtSSRSM_ID.Value = 0) and (mtSSRItog.Value = 0) then
      begin
        NullLine(); //Зануляем все строки и главы
        //Для 0801 расчет отличается
        if mtSSRCNum.AsString <> '0801' then
          CalcLineWithKoef(TmpLine);
        AssignLineIfNoNull(TmpLine);

        if mtSSRCNum.AsString = '0802' then
          Bookmark0802 := mtSSR.GetBookmark;

        if mtSSRCNum.AsString = '0996' then
          Bookmark0996 := mtSSR.GetBookmark;

        if mtSSRCNum.AsString = '0904' then
          Line0904 := TmpLine;
        if mtSSRCNum.AsString = '0905' then
          Line0905 := TmpLine;
        if mtSSRCNum.AsString = '0906' then
          Line0906 := TmpLine;
        if mtSSRCNum.AsString = '0907' then
          Line0907 := TmpLine;
        if mtSSRCNum.AsString = '0908' then
          Line0908 := TmpLine;
        if mtSSRCNum.AsString = '0911' then
          Line0911 := TmpLine;
        if mtSSRCNum.AsString = '0912' then
          Line0912 := TmpLine;
        if mtSSRCNum.AsString = '1003' then
          Line1003 := TmpLine;
        if mtSSRCNum.AsString = '1004' then
          Line1004 := TmpLine;

        TmpLine := default(TRepSSRLine);
      end;

      if (mtSSRItog.Value > 0) then
        NullLine(); //Зануляем все итоги

      if (mtSSRSM_ID.Value > 0) and (mtSSRSM_TYPE.Value = 2) then
      begin
        SummToLine(TmpLine);
      end;

      mtSSR.Prior;
    end;

    TmpLine := default(TRepSSRLine);
    AllLine := default(TRepSSRLine);

    //Подбивает итог по кождой из глав до главы 7
    while not mtSSR.Eof do
    begin
      if (mtSSRItog.Value = 2) then  //Итог по 1-11
      begin
        mtSSR.Edit;
        AssignLine(AllLine);
        mtSSR.Post;

        if mtSSRCNum.AsString = '0795' then
          Line0795 := AllLine;

        if mtSSRCNum.AsString = '0895' then
          Line0895 := AllLine;

        if mtSSRCNum.AsString = '0995' then
          Line0995 := AllLine;

       if mtSSRCNum.AsString = '1195' then
          Line1195 := AllLine;

        if mtSSRCNum.AsString = '1195' then
          Break;
      end;

      if (mtSSRItog.Value = 1) then
      begin
        AssignLineIfNoNull(TmpLine);
        SummToLine(AllLine);
        TmpLine := default(TRepSSRLine);

        if mtSSRCNum.AsString = '0190' then
          Line0190 := AllLine;

        if mtSSRCNum.AsString = '0990' then
          Line0990 := AllLine;
      end;

      if (mtSSRSM_ID.Value = 0) and (mtSSRItog.Value = 0) then
      begin
        SummToLine(TmpLine);

        if mtSSRCNum.AsString = '0801' then
        begin
          NullLine();
          I := FindLineNom(FKoefArray, mtSSRCNum.AsString);
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

            Line0801.ZP := (Line0795.ZP - Line0795.ZP5 + Line0795.ZPMash) * KZp * FKVrem;
            Line0801.EMiM := (Line0795.ZP - Line0795.ZP5 + Line0795.ZPMash) * KEmim * FKVrem;
            Line0801.ZPMash := Line0801.EMiM * KEmimZp;
            Line0801.Mat := (Line0795.ZP - Line0795.ZP5 + Line0795.ZPMash) * KMr * FKVrem;
          end;
          CalcLineWithKoef(Line0801);
          AssignLineIfNoNull(Line0801);
          SummToLine(TmpLine);
        end;

        if mtSSRCNum.AsString = '0901' then
        begin
          NullLine();
          I := FindLineNom(FKoefArray, mtSSRCNum.AsString);
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

            Line0901.ZP := (Line0795.ZP - Line0795.ZP5 + Line0795.ZPMash) * KZp * FKZim;
            Line0901.EMiM := (Line0795.ZP - Line0795.ZP5 + Line0795.ZPMash) * KEmim * FKZim;
            Line0901.ZPMash := Line0901.EMiM * KEmimZp;
            Line0901.Mat := (Line0795.ZP - Line0795.ZP5 + Line0795.ZPMash) * KMr * FKZim;
          end;
          CalcLineWithKoef(Line0901);
          AssignLineIfNoNull(Line0901);
          SummToLine(TmpLine);
        end;

        if mtSSRCNum.AsString = '0902' then
        begin
          NullLine();
          Line0902.Other := (Line0795.ZP + Line0795.ZPMash +
            Line0908.ZP + Line0908.ZPMash);
          CalcLineWithKoef(Line0902);
          AssignLineIfNoNull(Line0902);
          SummToLine(TmpLine);
        end;

        if mtSSRCNum.AsString = '0903' then
        begin
          NullLine();
          Line0903.Other := (Line0795.ZP - Line0795.ZP5 + Line0795.ZPMash);
          CalcLineWithKoef(Line0903);
          AssignLineIfNoNull(Line0903);
          SummToLine(TmpLine);
        end;

        if mtSSRCNum.AsString = '0910' then
        begin
          NullLine();
          Line0910.Other :=
           (Line0895.ZP - Line0895.ZP5 + Line0895.EMiM +
            Line0895.Mat + Line0895.MatTransp + Line0895.OXROPR +
            Line0895.PlanPrib + Line0895.Other);
          CalcLineWithKoef(Line0910);
          AssignLineIfNoNull(Line0910);
          SummToLine(TmpLine);
        end;

        if mtSSRCNum.AsString = '1001' then
        begin
          NullLine();
          Line1001.Other := (Line0995.Total - Line0995.ZP5);
          CalcLineWithKoef(Line1001);
          AssignLineIfNoNull(Line1001);
          SummToLine(TmpLine);
        end;

        if mtSSRCNum.AsString = '1002' then
        begin
          NullLine();
          Line1002.Other := (Line0995.ZP - Line0995.ZP5 + Line0995.EMiM +
            Line0995.Mat + Line0995.MatTransp + Line0995.OXROPR + Line0995.PlanPrib +
            Line0995.Other);
          CalcLineWithKoef(Line1002);
          AssignLineIfNoNull(Line1002);
          SummToLine(TmpLine);
        end;

        if mtSSRCNum.AsString = '1006' then
        begin
          NullLine();
          TmpLine1 := default(TRepSSRLine);
          TmpLine1.Other := (Line0895.ZP + Line0895.EMiM + Line0895.Mat +
            Line0895.MatTransp + Line0895.OXROPR + Line0895.PlanPrib +
            Line0895.Other + Line0990.Total);
          CalcLineWithKoef(TmpLine1);
          AssignLineIfNoNull(TmpLine1);
          SummToLine(TmpLine);
        end;

        if mtSSRCNum.AsString = '1007' then
        begin
          NullLine();
          TmpLine1 := default(TRepSSRLine);
          TmpLine1.Other := (Line0995.ZP - Line0995.ZP5 + Line0995.EMiM +
            Line0995.Mat + Line0995.MatTransp + Line0995.OXROPR + Line0995.PlanPrib +
            Line0995.Other - (Line0190.ZP  + Line0190.EMiM + Line0190.Mat +
            Line0190.MatTransp + Line0190.OXROPR + Line0190.PlanPrib + Line0190.Other));
          CalcLineWithKoef(TmpLine1);
          AssignLineIfNoNull(TmpLine1);
          SummToLine(TmpLine);
        end;
      end;
      mtSSR.Next;
    end;

    TmpBookmark := mtSSR.GetBookmark;
    //Расчет пункта 0802  и 0996
    if mtSSR.BookmarkValid(Bookmark0802) then
    begin
      mtSSR.GotoBookmark(Bookmark0802);
      Line0802.Mat := Line0801.Mat;
      CalcLineWithKoef(Line0802);
      AssignLineIfNoNull(Line0802);
      if mtSSR.BookmarkValid(Bookmark0996) then
      begin
        mtSSR.GotoBookmark(Bookmark0996);
        TmpLine := Line0802;   //Возможнно это лишнее
        CalcLineWithKoef(TmpLine);
        AssignLineIfNoNull(TmpLine);
      end;
      mtSSR.FreeBookmark(Bookmark0802);
      mtSSR.FreeBookmark(Bookmark0996);
    end;
    mtSSR.GotoBookmark(TmpBookmark);
    mtSSR.FreeBookmark(TmpBookmark);

    //Расчет оставшихся строк 90
    while not mtSSR.Eof do
    begin
      if mtSSRCNum.AsString = '9010' then
      begin
        NullLine();
        TmpLine := default(TRepSSRLine);
        TmpLine.ZP := Line1195.ZP - Line1195.ZP5;
        TmpLine.EMiM := Line1195.EMiM;
        TmpLine.ZPMash := Line1195.ZPMash;
        TmpLine.Mat := Line1195.Mat;
        TmpLine.MatTransp := Line1195.MatTransp;
        TmpLine.OXROPR := Line1195.OXROPR;
        TmpLine.PlanPrib := Line1195.PlanPrib;
        TmpLine.Devices := Line1195.Devices;
        TmpLine.Transp := Line1195.Transp;
        TmpLine.Other := Line1195.Other;
        CalcLineWithKoef(TmpLine);
        AssignLineIfNoNull(TmpLine);

        mtSSR.Next;
        if not mtSSR.Eof and (mtSSRCNum.AsString = '9011') then
        begin
          TmpLine.Summ(Line1195);
          Line9011 := TmpLine;
          AssignLineIfNoNull(TmpLine);
        end;
      end;

      if mtSSRCNum.AsString = '9012' then
      begin
        Bookmark9012 := mtSSR.GetBookmark;

        I := FindLineNom(FKoefArray, '9010');
        //Коэф по строке 9010
        TmpKoef.Pers := 1;
        TmpKoef.Koef1 := 1;
        TmpKoef.Koef2 := 1;
        if I > -1 then
        begin
          if VarIsAssign(FKoefArray[I].Pers) then
            TmpKoef.Pers := FKoefArray[I].Pers / 100;
          if VarIsAssign(FKoefArray[I].Koef1) then
            TmpKoef.Koef1 := FKoefArray[I].Koef1;
          if VarIsAssign(FKoefArray[I].Koef2) then
            TmpKoef.Koef2 := FKoefArray[I].Koef2;
        end;

        TmpLine1 := default(TRepSSRLine);

        mtSSR.Next;
        if mtSSR.Eof or (mtSSRCNum.AsString <> '901201') then
          Break;

        J := FindLineNom(FKoefArray, '901201');
        TmpKoef1.Pers := 1;
        TmpKoef1.Koef1 := 1;
        TmpKoef1.Koef2 := 1;
        if J > -1 then
        begin
          if VarIsAssign(FKoefArray[J].Pers) then
            TmpKoef1.Pers := FKoefArray[J].Pers / 100;
          if VarIsAssign(FKoefArray[J].Koef1) then
            TmpKoef1.Koef1 := FKoefArray[J].Koef1;
          if VarIsAssign(FKoefArray[J].Koef2) then
            TmpKoef1.Koef2 := FKoefArray[J].Koef2;
        end;

        TmpLine := default(TRepSSRLine);
        NullLine();
        TmpLine.Other :=
          SmRound((Line0795.ZP + Line0795.EMiM + Line0795.Mat +
            Line0795.MatTransp + Line0795.OXROPR * 0.421 + Line0795.Other +
            Line0801.Total + Line0901.Total + Line0902.Total + Line0903.Total +
            Line0904.Total + Line0905.Total + Line0907.Total + Line0908.Total) *
          (1 + TmpKoef.Pers * TmpKoef.Koef1 * TmpKoef.Koef2) * TmpKoef1.Pers +
          (Line0910.Total + Line0911.Total + Line0912.Total) *
          (1 + TmpKoef.Pers * TmpKoef.Koef1 * TmpKoef.Koef2) * TmpKoef1.Koef1/100 +
          (Line1001.Total + Line1002.Total) * 0.85 *
          (1 + TmpKoef.Pers * TmpKoef.Koef1 * TmpKoef.Koef2) * TmpKoef1.Koef2/100);
        TmpLine.CalcTotal;
        AssignLineIfNoNull(TmpLine);
        TmpLine1.Summ(TmpLine);

        mtSSR.Next;
        if mtSSR.Eof or (mtSSRCNum.AsString <> '901202') then
          Break;

        J := FindLineNom(FKoefArray, '901202');
        TmpKoef1.Pers := 1;
        TmpKoef1.Koef1 := 1;
        TmpKoef1.Koef2 := 1;
        if J > -1 then
        begin
          if VarIsAssign(FKoefArray[J].Pers) then
            TmpKoef1.Pers := FKoefArray[J].Pers / 100;
          if VarIsAssign(FKoefArray[J].Koef1) then
            TmpKoef1.Koef1 := FKoefArray[J].Koef1;
          if VarIsAssign(FKoefArray[J].Koef2) then
            TmpKoef1.Koef2 := FKoefArray[J].Koef2;
        end;

        TmpLine := default(TRepSSRLine);
        NullLine();
        TmpLine.Other :=
          SmRound((Line0795.Total + Line0801.Total + Line0901.Total + Line0902.Total +
            Line0903.Total + Line0904.Total + Line0905.Total + Line0906.Total +
            Line0907.Total + Line0908.Total + Line0910.Total+ Line0911.Total +
             (Line0795.Total - Line0795.ZP5 + Line0801.Total + Line0901.Total +
             Line0902.Total + Line0903.Total + Line0904.Total + Line0905.Total +
             Line0906.Total + Line0907.Total + Line0908.Total + Line0910.Total+
             Line0911.Total) * (TmpKoef.Pers * TmpKoef.Koef1 * TmpKoef.Koef2) -
             Line0802.Total) * TmpKoef1.Pers);
        TmpLine.CalcTotal;
        AssignLineIfNoNull(TmpLine);
        TmpLine1.Summ(TmpLine);

        mtSSR.Next;
        if mtSSR.Eof or (mtSSRCNum.AsString <> '901203') then
          Break;

        J := FindLineNom(FKoefArray, '901203');
        TmpKoef1.Pers := 1;
        TmpKoef1.Koef1 := 1;
        TmpKoef1.Koef2 := 1;
        if J > -1 then
        begin
          if VarIsAssign(FKoefArray[J].Pers) then
            TmpKoef1.Pers := FKoefArray[J].Pers / 100;
          if VarIsAssign(FKoefArray[J].Koef1) then
            TmpKoef1.Koef1 := FKoefArray[J].Koef1;
          if VarIsAssign(FKoefArray[J].Koef2) then
            TmpKoef1.Koef2 := FKoefArray[J].Koef2;
        end;

        TmpLine := default(TRepSSRLine);
        NullLine();
        TmpLine.Other :=
          SmRound((Line9011.Total - Line0802.Total - Line0911.Total -
          Line1003.Total -
          Line1004.Total + TmpLine1.Total {V901201+V901202}) * TmpKoef1.Pers);
        TmpLine.CalcTotal;
        AssignLineIfNoNull(TmpLine);
        TmpLine1.Summ(TmpLine);

        mtSSR.Next;
        if mtSSR.Eof or (mtSSRCNum.AsString <> '901204') then
          Break;

        J := FindLineNom(FKoefArray, '901204');
        TmpKoef1.Pers := 1;
        TmpKoef1.Koef1 := 1;
        TmpKoef1.Koef2 := 1;
        if J > -1 then
        begin
          if VarIsAssign(FKoefArray[J].Pers) then
            TmpKoef1.Pers := FKoefArray[J].Pers;
          if VarIsAssign(FKoefArray[J].Koef1) then
            TmpKoef1.Koef1 := FKoefArray[J].Koef1;
          if VarIsAssign(FKoefArray[J].Koef2) then
            TmpKoef1.Koef2 := FKoefArray[J].Koef2;
        end;

        TmpLine := default(TRepSSRLine);
        NullLine();
        TmpLine.Other :=
          SmRound((Line0795.Total - Line0795.Devices - Line0795.Transp + Line0801.Total +
          Line0901.Total + Line0902.Total + Line0903.Total + Line0904.Total +
          Line0905.Total + Line0907.Total + Line0908.Total +
          (Line0795.Total - Line0795.ZP5 - Line0795.Devices - Line0795.Transp +
          Line0801.Total + Line0901.Total + Line0902.Total + Line0903.Total +
          Line0904.Total + Line0905.Total + Line0906.Total + Line0907.Total +
          Line0908.Total + Line0910.Total+ Line0911.Total) *
          (TmpKoef.Pers * TmpKoef.Koef1 * TmpKoef.Koef2)) * TmpKoef1.Pers);
        TmpLine.CalcTotal;
        AssignLineIfNoNull(TmpLine);
        TmpLine1.Summ(TmpLine);

        //Cумма налогов
        TmpBookmark := mtSSR.GetBookmark;
        mtSSR.GotoBookmark(Bookmark9012);
        NullLine();
        AssignLineIfNoNull(TmpLine1);
        mtSSR.GotoBookmark(TmpBookmark);
        mtSSR.FreeBookmark(Bookmark9012);
        mtSSR.FreeBookmark(TmpBookmark);

        mtSSR.Next;
        if mtSSR.Eof or (mtSSRCNum.AsString <> '9013') then
          Break;
        //Сумма с налогами
        TmpLine1.Summ(Line9011);
        AssignLineIfNoNull(TmpLine1);
        Line9013 := TmpLine1;

        mtSSR.Next;
        if mtSSR.Eof or (mtSSRCNum.AsString <> '9014') then
          Break;

        FReportSSRPI.Line9013 := Line9013;
        FReportSSRPI.Line0802 := Line0802;
        FReportSSRPI.CalcPIIndex();
        TmpLine := default(TRepSSRLine);
        NullLine();
        TmpLine.Other := SmRound(FReportSSRPI.Result);
        TmpLine.CalcTotal;
        AssignLineIfNoNull(TmpLine);

        mtSSR.Next;
        if mtSSR.Eof or (mtSSRCNum.AsString <> '9015') then
          Break;

        TmpLine.Summ(Line9013);
        AssignLineIfNoNull(TmpLine);

        mtSSR.Next;
        if mtSSR.Eof or (mtSSRCNum.AsString <> '9019') then
          Break;

        AssignLineIfNoNull(Line0802);

        mtSSR.Next;
        if mtSSR.Eof then
          Break;
        mtSSR.Next;
        if mtSSR.Eof or (mtSSRCNum.AsString <> '9030') then
          Break;
        AssignLineIfNoNull(TmpLine);
      end;

      mtSSR.Next;
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
  // Процедура наложения стилей отрисовки таблиц по умолчанию
  with (Sender AS TJvDBGrid).Canvas do
  begin
    if Column.Index >= grSSR.FixedCols then
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
        ((Sender AS TJvDBGrid).Row =
          TMyDBGrid((Sender AS TJvDBGrid)).DataLink.ActiveRecord + headerLines)) then
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
  end;
  (Sender AS TJvDBGrid).DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

end.
