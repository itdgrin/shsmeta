unit CalcTravelWork;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Tools,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, Vcl.DBCtrls, Vcl.Grids,
  Vcl.DBGrids, JvExDBGrids, JvDBGrid, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, JvComponentBase, JvFormPlacement, System.UITypes,
  Vcl.ExtCtrls;

type
  TfCalcTravelWork = class(TSmForm)
    grCalc: TJvDBGrid;
    dsCalc: TDataSource;
    qrCalc: TFDQuery;
    FormStorage: TJvFormStorage;
    qrMain: TFDQuery;
    dsMain: TDataSource;
    pnlTop: TPanel;
    lbl4: TLabel;
    dbedtPREPARER: TDBEdit;
    chkEnableEditing: TCheckBox;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure qrCalcAfterPost(DataSet: TDataSet);
    procedure grCalcKeyPress(Sender: TObject; var Key: Char);
    procedure qrCalcBeforePost(DataSet: TDataSet);
    procedure chkEnableEditingClick(Sender: TObject);
    procedure qrMainNewRecord(DataSet: TDataSet);
  private
    OBJ_ID, SM_ID: Variant;
  public
    procedure ReloadMain;
  end;

var
  fCalcTravelWork: TfCalcTravelWork;

implementation

{$R *.dfm}

uses Main, EditExpression, GlobsAndConst;

procedure TfCalcTravelWork.chkEnableEditingClick(Sender: TObject);
begin
  if chkEnableEditing.Checked then
    grCalc.Options := grCalc.Options - [dgRowSelect] + [dgEditing]
  else
    grCalc.Options := grCalc.Options - [dgEditing] + [dgRowSelect];
end;

procedure TfCalcTravelWork.FormActivate(Sender: TObject);
begin
  // Если нажата клавиша Ctrl и выбираем форму, то делаем
  // каскадирование с переносом этой формы на передний план
  FormMain.CascadeForActiveWindow;
  // Делаем нажатой кнопку активной формы (на главной форме внизу)
  FormMain.SelectButtonActiveWindow(Caption);
end;

procedure TfCalcTravelWork.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // FormMain.ReplaceButtonOpenWindow(Self, fTravelList);
  Action := caFree;
end;

procedure TfCalcTravelWork.FormCreate(Sender: TObject);
begin
  inherited;
  OBJ_ID := InitParams[0];
  SM_ID := InitParams[1];

  qrMain.ParamByName('OBJ_ID').Value := OBJ_ID;
  qrMain.ParamByName('SM_ID').Value := SM_ID;
  qrMain.Active := True;
  // Если записи о расчете еще нету, то добавляем новую
  if qrMain.IsEmpty then
    qrMain.Append
  else
    ReloadMain;
end;

procedure TfCalcTravelWork.FormDestroy(Sender: TObject);
begin
  fCalcTravelWork := nil;
end;

procedure TfCalcTravelWork.ReloadMain;
begin
  // Заполняем параметры расчета
  if qrMain.State in [dsEdit, dsInsert] then
    qrMain.Post;
  qrCalc.ParamByName('OBJ_ID').Value := qrMain.FieldByName('OBJ_ID').Value;
  qrCalc.ParamByName('ID_ESTIMATE').Value := qrMain.FieldByName('SM_ID').Value;
  CloseOpen(qrCalc)
end;

procedure TfCalcTravelWork.grCalcKeyPress(Sender: TObject; var Key: Char);
begin
  if (Ord(Key) = VK_RETURN) and (qrCalc.State = dsEdit) then
    qrCalc.Post;
end;

procedure TfCalcTravelWork.qrCalcAfterPost(DataSet: TDataSet);
begin
  ReloadMain;
end;

procedure TfCalcTravelWork.qrCalcBeforePost(DataSet: TDataSet);
begin
  if (qrCalc.RecNo = 1) and (qrCalc.FieldByName('CALC').Value <> qrCalc.FieldByName('CALC').OldValue) then
  begin
    qrMain.Edit;
    if qrCalc.FieldByName('CALC').Value = '' then
      qrMain.FieldByName('SUTKI_KOMANDIR').Value := null
    else
      qrMain.FieldByName('SUTKI_KOMANDIR').Value := qrCalc.FieldByName('CALC').Value;
  end;

  // Нормативная трудоемкость
  // Если изменили результат вычисления
  if (qrCalc.RecNo = 2) and (qrCalc.FieldByName('TOTAL').Value <> qrCalc.FieldByName('TOTAL').OldValue) then
  begin
    qrMain.Edit;
    qrMain.FieldByName('NORMAT').Value := qrCalc.FieldByName('TOTAL').Value;
  end;
  // Если изменили формулу
  if (qrCalc.RecNo = 2) and (qrCalc.FieldByName('CALC').Value <> qrCalc.FieldByName('CALC').OldValue) then
  begin
    qrMain.Edit;
    if qrCalc.FieldByName('CALC').Value = '' then
    begin
      qrMain.FieldByName('NORMATF').Value := null;
      qrMain.FieldByName('NORMAT').Value := null;
    end
    else
    begin
      qrMain.FieldByName('NORMATF').Value := qrCalc.FieldByName('CALC').Value;
      qrMain.FieldByName('NORMAT').Value := CalcExpression(qrCalc.FieldByName('CALC').AsString, False);
    end;
  end;

  // Итог
  // Если изменили результат вычисления
  if (qrCalc.RecNo = 3) and (qrCalc.FieldByName('TOTAL').Value <> qrCalc.FieldByName('TOTAL').OldValue) then
  begin
    qrMain.Edit;
    qrMain.FieldByName('TOTAL').Value := qrCalc.FieldByName('TOTAL').Value;
  end;
  // Если изменили формулу
  if (qrCalc.RecNo = 3) and (qrCalc.FieldByName('CALC').Value <> qrCalc.FieldByName('CALC').OldValue) then
  begin
    qrMain.Edit;
    if qrCalc.FieldByName('CALC').Value = '' then
    begin
      qrMain.FieldByName('TOTALF').Value := null;
      qrMain.FieldByName('TOTAL').Value := null;
    end
    else
    begin
      qrMain.FieldByName('TOTALF').Value := qrCalc.FieldByName('CALC').Value;
      qrMain.FieldByName('TOTAL').Value := CalcExpression(qrCalc.FieldByName('CALC').AsString, False);
    end;
  end;
end;

procedure TfCalcTravelWork.qrMainNewRecord(DataSet: TDataSet);
begin
  qrMain.FieldByName('travel_work_id').Value := FastSelectSQLOne('SELECT GetNewID(:0)', VarArrayOf([C_ID_TRWORK]));
  qrMain.FieldByName('OBJ_ID').Value := OBJ_ID;
  qrMain.FieldByName('SM_ID').Value := SM_ID;
  ReloadMain;
end;

end.
