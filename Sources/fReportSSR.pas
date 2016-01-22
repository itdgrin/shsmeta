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
  FireDAC.DApt.Intf, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.Grids, Vcl.DBGrids,
  JvExDBGrids, JvDBGrid,
  Vcl.ExtCtrls, FireDAC.Stan.Async, FireDAC.DApt, Vcl.Buttons, Vcl.StdCtrls,
  Vcl.DBCtrls;

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
  private
    FObjectID: Integer;
    procedure GetSSRReport();
  public
    property ObjectID: Integer read FObjectID write FObjectID;
  end;

implementation

uses DataModule, CardObject, GlobsAndConst;

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

procedure TFormReportSSR.GetSSRReport();
var SmStr, CaptStr: string;
    LastC, LastSC: Integer;
    I, J: Integer;

procedure AddItog();
begin
  mtSSR.Append;
  mtSSRNum.AsString := LastC.ToString + '.90';
  mtSSRName.AsString := 'ИТОГО ПО ГЛАВЕ ' + LastC.ToString;
  mtSSRCID.Value := LastC;
  mtSSRSCID.Value := LastSC;
  mtSSRItog.Value := 1;
  mtSSR.Post;
  if (LastC >= 7) and (LastC <> 10) then
  begin
    mtSSR.Append;
    mtSSRNum.AsString := LastC.ToString + '.95';
    mtSSRName.AsString := 'ИТОГО ПО ГЛАВАМ 1-' + LastC.ToString;
    mtSSRCID.Value := LastC;
    mtSSRSCID.Value := LastSC;
    mtSSRItog.Value := 2;
    mtSSR.Post;
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
    'Round(SUM(COALESCE(d.EMiMF, d.EMiM, 0))) AllActsEMiM ' +
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
    'Round(SUM(COALESCE(d.EMiMF, d.EMiM, 0))) AllActsEMiM ' +
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
    'sm.SM_TYPE ' +
    'FROM ssr_chapters sc left join (' + SmStr + ') sm ' +
    'on (sc.CID = sm.CHAPTER) and (COALESCE(sc.SCID, 0) = COALESCE(sm.ROW_NUMBER, 0)) ' +
    'order by sc.CID, SCID, SM_SORT';

  //Заполнение левой таблицы
  if not mtSSR.Active then
    mtSSR.Active :=True;
  mtSSR.EmptyDataSet;

  mtSSR.BeginBatch();
  try
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
            LastC.ToString + '.' + LastSC.ToString +
            I.ToString + '.' + J.ToString;
        end;

        mtSSRName.AsString := qrTemp.FieldByName('SM_NAME').AsString;
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
end;

end.
