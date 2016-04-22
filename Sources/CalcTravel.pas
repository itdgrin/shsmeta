unit CalcTravel;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, Vcl.DBCtrls, Vcl.Grids,
  Vcl.DBGrids, JvExDBGrids, JvDBGrid, Tools, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, JvComponentBase, JvFormPlacement, System.UITypes,
  Vcl.ExtCtrls;

type
  TfCalcTravel = class(TSmForm)
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
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure qrCalcAfterPost(DataSet: TDataSet);
    procedure grCalcKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure qrCalcBeforePost(DataSet: TDataSet);
    procedure chkEnableEditingClick(Sender: TObject);
    procedure qrMainNewRecord(DataSet: TDataSet);
  private
    OBJ_ID, SM_ID: Variant;
  public
    procedure ReloadMain;
  end;

var
  fCalcTravel: TfCalcTravel;

implementation

{$R *.dfm}

uses Main, EditExpression, GlobsAndConst;

procedure TfCalcTravel.chkEnableEditingClick(Sender: TObject);
begin
  if chkEnableEditing.Checked then
    grCalc.Options := grCalc.Options - [dgRowSelect] + [dgEditing]
  else
    grCalc.Options := grCalc.Options - [dgEditing] + [dgRowSelect];
end;

procedure TfCalcTravel.FormActivate(Sender: TObject);
begin
  // Если нажата клавиша Ctrl и выбираем форму, то делаем
  // каскадирование с переносом этой формы на передний план
  FormMain.CascadeForActiveWindow;
  // Делаем нажатой кнопку активной формы (на главной форме внизу)
  FormMain.SelectButtonActiveWindow(Caption);
end;

procedure TfCalcTravel.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfCalcTravel.FormCreate(Sender: TObject);
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

procedure TfCalcTravel.FormDestroy(Sender: TObject);
begin
  fCalcTravel := nil;
end;

procedure TfCalcTravel.ReloadMain;
begin
  if qrMain.State in [dsEdit, dsInsert] then
    qrMain.Post;
  // Заполняем параметры расчета
  qrCalc.ParamByName('OBJ_ID').Value := qrMain.FieldByName('OBJ_ID').Value;
  qrCalc.ParamByName('ID_ESTIMATE').Value := qrMain.FieldByName('SM_ID').Value;
  CloseOpen(qrCalc);
end;

procedure TfCalcTravel.grCalcKeyPress(Sender: TObject; var Key: Char);
begin
  if (Ord(Key) = VK_RETURN) and (qrCalc.State = dsEdit) then
    qrCalc.Post;
end;

procedure TfCalcTravel.qrCalcAfterPost(DataSet: TDataSet);
begin
  qrMain.Edit;
  if qrCalc.FieldByName('NUMPP').AsString = '06' then
    qrMain.FieldByName('SUTKI_KOMANDIR').AsInteger := qrCalc.FieldByName('CALC').AsInteger;
  if qrCalc.FieldByName('NUMPP').AsString = '07' then
    qrMain.FieldByName('HOUSING_KOMANDIR').AsInteger := qrCalc.FieldByName('CALC').AsInteger;
  if qrCalc.FieldByName('NUMPP').AsString = '08' then
    qrMain.FieldByName('STOIM_KM').AsInteger := qrCalc.FieldByName('CALC').AsInteger;
  if qrCalc.FieldByName('NUMPP').AsString = '09' then
    qrMain.FieldByName('KM').AsFloat := qrCalc.FieldByName('CALC').AsInteger;

  if qrCalc.FieldByName('NUMPP').AsString = '10' then
    if qrCalc.FieldByName('CALC').Value = '' then
      qrMain.FieldByName('HOUR_IN_DAY').Value := null
    else
      qrMain.FieldByName('HOUR_IN_DAY').Value := qrCalc.FieldByName('CALC').Value;

  if qrCalc.FieldByName('NUMPP').AsString = '11' then
    if qrCalc.FieldByName('CALC').Value = '' then
      qrMain.FieldByName('COUNT_WORK_DAY_IN_MONTH').Value := null
    else
      qrMain.FieldByName('COUNT_WORK_DAY_IN_MONTH').Value := qrCalc.FieldByName('CALC').Value;

  if qrCalc.FieldByName('NUMPP').AsString = '12' then
    if qrCalc.FieldByName('CALC').Value = '' then
      qrMain.FieldByName('CUNT_DAY_IN_MONTH').Value := null
    else
      qrMain.FieldByName('CUNT_DAY_IN_MONTH').Value := qrCalc.FieldByName('CALC').Value;

  if qrCalc.FieldByName('NUMPP').AsString = '26' then
    qrMain.FieldByName('summ').AsFloat := qrCalc.FieldByName('TOTAL').AsInteger;

  ReloadMain;
end;

procedure TfCalcTravel.qrCalcBeforePost(DataSet: TDataSet);
begin
  // Нормативная трудоемкость
  // Если изменили результат вычисления
  if (qrCalc.FieldByName('NUMPP').AsString = '14') and
    (qrCalc.FieldByName('TOTAL').Value <> qrCalc.FieldByName('TOTAL').OldValue) then
  begin
    qrMain.Edit;
    qrMain.FieldByName('NORMAT').Value := qrCalc.FieldByName('TOTAL').Value;
  end;
  // Если изменили формулу
  if (qrCalc.FieldByName('NUMPP').AsString = '14') and
    (qrCalc.FieldByName('CALC').Value <> qrCalc.FieldByName('CALC').OldValue) then
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

  // Суточные
  // Если изменили результат вычисления
  if (qrCalc.FieldByName('NUMPP').AsString = '23') and
    (qrCalc.FieldByName('TOTAL').Value <> qrCalc.FieldByName('TOTAL').OldValue) then
  begin
    qrMain.Edit;
    qrMain.FieldByName('SUTKI').Value := qrCalc.FieldByName('TOTAL').Value;
  end;
  // Если изменили формулу
  if (qrCalc.FieldByName('NUMPP').AsString = '23') and
    (qrCalc.FieldByName('CALC').Value <> qrCalc.FieldByName('CALC').OldValue) then
  begin
    qrMain.Edit;
    if qrCalc.FieldByName('CALC').Value = '' then
    begin
      qrMain.FieldByName('SUTKIF').Value := null;
      qrMain.FieldByName('SUTKI').Value := null;
    end
    else
    begin
      qrMain.FieldByName('SUTKIF').Value := qrCalc.FieldByName('CALC').Value;
      qrMain.FieldByName('SUTKI').Value := CalcExpression(qrCalc.FieldByName('CALC').AsString, False);
    end;
  end;

  // Квартирные
  // Если изменили результат вычисления
  if (qrCalc.FieldByName('NUMPP').AsString = '24') and
    (qrCalc.FieldByName('TOTAL').Value <> qrCalc.FieldByName('TOTAL').OldValue) then
  begin
    qrMain.Edit;
    qrMain.FieldByName('KVARTIR').Value := qrCalc.FieldByName('TOTAL').Value;
  end;
  // Если изменили формулу
  if (qrCalc.FieldByName('NUMPP').AsString = '24') and
    (qrCalc.FieldByName('CALC').Value <> qrCalc.FieldByName('CALC').OldValue) then
  begin
    qrMain.Edit;
    if qrCalc.FieldByName('CALC').Value = '' then
    begin
      qrMain.FieldByName('KVARTIRF').Value := null;
      qrMain.FieldByName('KVARTIR').Value := null;
    end
    else
    begin
      qrMain.FieldByName('KVARTIRF').Value := qrCalc.FieldByName('CALC').Value;
      qrMain.FieldByName('KVARTIR').Value := CalcExpression(qrCalc.FieldByName('CALC').AsString, False);
    end;
  end;

  // Проездные
  // Если изменили результат вычисления
  if (qrCalc.FieldByName('NUMPP').AsString = '25') and
    (qrCalc.FieldByName('TOTAL').Value <> qrCalc.FieldByName('TOTAL').OldValue) then
  begin
    qrMain.Edit;
    qrMain.FieldByName('PROEZD').Value := qrCalc.FieldByName('TOTAL').Value;
  end;
  // Если изменили формулу
  if (qrCalc.FieldByName('NUMPP').AsString = '25') and
    (qrCalc.FieldByName('CALC').Value <> qrCalc.FieldByName('CALC').OldValue) then
  begin
    qrMain.Edit;
    if qrCalc.FieldByName('CALC').Value = '' then
    begin
      qrMain.FieldByName('PROEZDF').Value := null;
      qrMain.FieldByName('PROEZD').Value := null;
    end
    else
    begin
      qrMain.FieldByName('PROEZDF').Value := qrCalc.FieldByName('CALC').Value;
      qrMain.FieldByName('PROEZD').Value := CalcExpression(qrCalc.FieldByName('CALC').AsString, False);
    end;
  end;

  // Итог
  // Если изменили результат вычисления
  if (qrCalc.FieldByName('NUMPP').AsString = '26') and
    (qrCalc.FieldByName('TOTAL').Value <> qrCalc.FieldByName('TOTAL').OldValue) then
  begin
    qrMain.Edit;
    qrMain.FieldByName('TOTAL').Value := qrCalc.FieldByName('TOTAL').Value;
  end;
  // Если изменили формулу
  if (qrCalc.FieldByName('NUMPP').AsString = '26') and
    (qrCalc.FieldByName('CALC').Value <> qrCalc.FieldByName('CALC').OldValue) then
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

procedure TfCalcTravel.qrMainNewRecord(DataSet: TDataSet);
begin
  qrMain.FieldByName('travel_id').Value := FastSelectSQLOne('SELECT GetNewID(:0)', VarArrayOf([C_ID_TRAVEL]));
  qrMain.FieldByName('OBJ_ID').Value := OBJ_ID;
  qrMain.FieldByName('SM_ID').Value := SM_ID;
  ReloadMain;
end;

end.
