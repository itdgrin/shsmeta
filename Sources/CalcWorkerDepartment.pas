unit CalcWorkerDepartment;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Tools,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, Vcl.DBCtrls, Vcl.Grids,
  Vcl.DBGrids, JvExDBGrids, JvDBGrid, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, JvComponentBase, JvFormPlacement, System.UITypes,
  Vcl.ExtCtrls;

type
  TfCalcWorkerDepartment = class(TSmForm)
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
    procedure FormDestroy(Sender: TObject);
    procedure qrCalcAfterPost(DataSet: TDataSet);
    procedure grCalcKeyPress(Sender: TObject; var Key: Char);
    procedure qrCalcBeforePost(DataSet: TDataSet);
    procedure chkEnableEditingClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure qrMainNewRecord(DataSet: TDataSet);
  private
    OBJ_ID, SM_ID: Variant;
  public
    procedure ReloadMain;
  end;

var
  fCalcWorkerDepartment: TfCalcWorkerDepartment;

implementation

{$R *.dfm}

uses Main, EditExpression, GlobsAndConst;

procedure TfCalcWorkerDepartment.chkEnableEditingClick(Sender: TObject);
begin
  if chkEnableEditing.Checked then
    grCalc.Options := grCalc.Options - [dgRowSelect] + [dgEditing]
  else
    grCalc.Options := grCalc.Options - [dgEditing] + [dgRowSelect];
end;

procedure TfCalcWorkerDepartment.FormActivate(Sender: TObject);
begin
  // Если нажата клавиша Ctrl и выбираем форму, то делаем
  // каскадирование с переносом этой формы на передний план
  FormMain.CascadeForActiveWindow;
  // Делаем нажатой кнопку активной формы (на главной форме внизу)
  FormMain.SelectButtonActiveWindow(Caption);
end;

procedure TfCalcWorkerDepartment.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfCalcWorkerDepartment.FormCreate(Sender: TObject);
begin
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

procedure TfCalcWorkerDepartment.FormDestroy(Sender: TObject);
begin
  fCalcWorkerDepartment := nil;
end;

procedure TfCalcWorkerDepartment.ReloadMain;
begin
  if qrMain.State in [dsEdit, dsInsert] then
    qrMain.Post;
  // Заполняем параметры расчета
  qrCalc.ParamByName('OBJ_ID').Value := qrMain.FieldByName('OBJ_ID').Value;
  qrCalc.ParamByName('ID_ESTIMATE').Value := qrMain.FieldByName('SM_ID').Value;
  CloseOpen(qrCalc);
end;

procedure TfCalcWorkerDepartment.grCalcKeyPress(Sender: TObject; var Key: Char);
begin
  if (Ord(Key) = VK_RETURN) and (qrCalc.State = dsEdit) then
    qrCalc.Post;
end;

procedure TfCalcWorkerDepartment.qrCalcAfterPost(DataSet: TDataSet);
begin
  qrMain.Edit;
  if qrCalc.RecNo = 1 then
    qrMain.FieldByName('auto_mark').AsString := qrCalc.FieldByName('CALC').AsString;
  if qrCalc.RecNo = 2 then
    qrMain.FieldByName('PLACE_COUNT').AsInteger := qrCalc.FieldByName('CALC').AsInteger;
  if qrCalc.RecNo = 3 then
    qrMain.FieldByName('EMbyHVR').AsInteger := qrCalc.FieldByName('CALC').AsInteger;
  if qrCalc.RecNo = 4 then
    qrMain.FieldByName('EMbyKM').AsInteger := qrCalc.FieldByName('CALC').AsInteger;
  if qrCalc.RecNo = 6 then
    qrMain.FieldByName('RoadALength').AsInteger := qrCalc.FieldByName('CALC').AsInteger;

  if qrCalc.RecNo = 7 then
    qrMain.FieldByName('RoadGLength').AsInteger := qrCalc.FieldByName('CALC').AsInteger;
  if qrCalc.RecNo = 8 then
    qrMain.FieldByName('RoadGrLength').AsInteger := qrCalc.FieldByName('CALC').AsInteger;
  if qrCalc.RecNo = 10 then
    qrMain.FieldByName('RoadASpeed').AsInteger := qrCalc.FieldByName('CALC').AsInteger;
  if qrCalc.RecNo = 11 then
    qrMain.FieldByName('RoadGSpeed').AsInteger := qrCalc.FieldByName('CALC').AsInteger;
  if qrCalc.RecNo = 12 then
    qrMain.FieldByName('RoadGrSpeed').AsInteger := qrCalc.FieldByName('CALC').AsInteger;
  if qrCalc.RecNo = 13 then
    qrMain.FieldByName('HOUR_IN_DAY').AsFloat := qrCalc.FieldByName('CALC').AsFloat;
  if qrCalc.RecNo = 14 then
    qrMain.FieldByName('COUNT_WORK_DAY_IN_MONTH').AsInteger := qrCalc.FieldByName('CALC').AsInteger;
  if qrCalc.RecNo = 15 then
    qrMain.FieldByName('TravelCount').AsInteger := qrCalc.FieldByName('CALC').AsInteger;
  if qrCalc.RecNo = 16 then
    qrMain.FieldByName('InOut').AsInteger := qrCalc.FieldByName('CALC').AsInteger;
  if qrCalc.RecNo = 17 then
    qrMain.FieldByName('TimeIN').AsInteger := qrCalc.FieldByName('CALC').AsInteger;
  if qrCalc.RecNo = 18 then
    qrMain.FieldByName('TimeOUT').AsInteger := qrCalc.FieldByName('CALC').AsInteger;
  ReloadMain;
end;

procedure TfCalcWorkerDepartment.qrCalcBeforePost(DataSet: TDataSet);
begin
  // Нормативная трудоемкость
  // Если изменили результат вычисления
  if (qrCalc.RecNo = 19) and (qrCalc.FieldByName('TOTAL').Value <> qrCalc.FieldByName('TOTAL').OldValue) then
  begin
    qrMain.Edit;
    qrMain.FieldByName('NORMAT').Value := qrCalc.FieldByName('TOTAL').Value;
  end;
  // Если изменили формулу
  if (qrCalc.RecNo = 19) and (qrCalc.FieldByName('CALC').Value <> qrCalc.FieldByName('CALC').OldValue) then
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

  //
  // Если изменили результат вычисления
  if (qrCalc.RecNo = 20) and (qrCalc.FieldByName('TOTAL').Value <> qrCalc.FieldByName('TOTAL').OldValue) then
  begin
    qrMain.Edit;
    qrMain.FieldByName('NORM_WORKER_COUNT').Value := qrCalc.FieldByName('TOTAL').Value;
  end;
  // Если изменили формулу
  if (qrCalc.RecNo = 20) and (qrCalc.FieldByName('CALC').Value <> qrCalc.FieldByName('CALC').OldValue) then
  begin
    qrMain.Edit;
    if qrCalc.FieldByName('CALC').Value = '' then
    begin
      qrMain.FieldByName('NORM_WORKER_COUNTF').Value := null;
      qrMain.FieldByName('NORM_WORKER_COUNT').Value := null;
    end
    else
    begin
      qrMain.FieldByName('NORM_WORKER_COUNTF').Value := qrCalc.FieldByName('CALC').Value;
      qrMain.FieldByName('NORM_WORKER_COUNT').Value :=
        CalcExpression(qrCalc.FieldByName('CALC').AsString, False);
    end;
  end;

  //
  // Если изменили результат вычисления
  if (qrCalc.RecNo = 21) and (qrCalc.FieldByName('TOTAL').Value <> qrCalc.FieldByName('TOTAL').OldValue) then
  begin
    qrMain.Edit;
    qrMain.FieldByName('NORM_AUTO_COUNT').Value := qrCalc.FieldByName('TOTAL').Value;
  end;
  // Если изменили формулу
  if (qrCalc.RecNo = 21) and (qrCalc.FieldByName('CALC').Value <> qrCalc.FieldByName('CALC').OldValue) then
  begin
    qrMain.Edit;
    if qrCalc.FieldByName('CALC').Value = '' then
    begin
      qrMain.FieldByName('NORM_AUTO_COUNTF').Value := null;
      qrMain.FieldByName('NORM_AUTO_COUNT').Value := null;
    end
    else
    begin
      qrMain.FieldByName('NORM_AUTO_COUNTF').Value := qrCalc.FieldByName('CALC').Value;
      qrMain.FieldByName('NORM_AUTO_COUNT').Value :=
        CalcExpression(qrCalc.FieldByName('CALC').AsString, False);
    end;
  end;

  //
  // Если изменили результат вычисления
  if (qrCalc.RecNo = 22) and (qrCalc.FieldByName('TOTAL').Value <> qrCalc.FieldByName('TOTAL').OldValue) then
  begin
    qrMain.Edit;
    qrMain.FieldByName('FULL_AUTO_TIME').Value := qrCalc.FieldByName('TOTAL').Value;
  end;
  // Если изменили формулу
  if (qrCalc.RecNo = 22) and (qrCalc.FieldByName('CALC').Value <> qrCalc.FieldByName('CALC').OldValue) then
  begin
    qrMain.Edit;
    if qrCalc.FieldByName('CALC').Value = '' then
    begin
      qrMain.FieldByName('FULL_AUTO_TIMEF').Value := null;
      qrMain.FieldByName('FULL_AUTO_TIME').Value := null;
    end
    else
    begin
      qrMain.FieldByName('FULL_AUTO_TIMEF').Value := qrCalc.FieldByName('CALC').Value;
      qrMain.FieldByName('FULL_AUTO_TIME').Value :=
        CalcExpression(qrCalc.FieldByName('CALC').AsString, False);
    end;
  end;

  //
  // Если изменили результат вычисления
  if (qrCalc.RecNo = 23) and (qrCalc.FieldByName('TOTAL').Value <> qrCalc.FieldByName('TOTAL').OldValue) then
  begin
    qrMain.Edit;
    qrMain.FieldByName('AUTO_HVR').Value := qrCalc.FieldByName('TOTAL').Value;
  end;
  // Если изменили формулу
  if (qrCalc.RecNo = 23) and (qrCalc.FieldByName('CALC').Value <> qrCalc.FieldByName('CALC').OldValue) then
  begin
    qrMain.Edit;
    if qrCalc.FieldByName('CALC').Value = '' then
    begin
      qrMain.FieldByName('AUTO_HVRF').Value := null;
      qrMain.FieldByName('AUTO_HVR').Value := null;
    end
    else
    begin
      qrMain.FieldByName('AUTO_HVRF').Value := qrCalc.FieldByName('CALC').Value;
      qrMain.FieldByName('AUTO_HVR').Value := CalcExpression(qrCalc.FieldByName('CALC').AsString, False);
    end;
  end;

  //
  // Если изменили результат вычисления
  if (qrCalc.RecNo = 24) and (qrCalc.FieldByName('TOTAL').Value <> qrCalc.FieldByName('TOTAL').OldValue) then
  begin
    qrMain.Edit;
    qrMain.FieldByName('AUTOKM').Value := qrCalc.FieldByName('TOTAL').Value;
  end;
  // Если изменили формулу
  if (qrCalc.RecNo = 24) and (qrCalc.FieldByName('CALC').Value <> qrCalc.FieldByName('CALC').OldValue) then
  begin
    qrMain.Edit;
    if qrCalc.FieldByName('CALC').Value = '' then
    begin
      qrMain.FieldByName('AUTOKMF').Value := null;
      qrMain.FieldByName('AUTOKM').Value := null;
    end
    else
    begin
      qrMain.FieldByName('AUTOKMF').Value := qrCalc.FieldByName('CALC').Value;
      qrMain.FieldByName('AUTOKM').Value := CalcExpression(qrCalc.FieldByName('CALC').AsString, False);
    end;
  end;

  //
  // Если изменили результат вычисления
  if (qrCalc.RecNo = 25) and (qrCalc.FieldByName('TOTAL').Value <> qrCalc.FieldByName('TOTAL').OldValue) then
  begin
    qrMain.Edit;
    qrMain.FieldByName('TOTAL').Value := qrCalc.FieldByName('TOTAL').Value;
  end;
  // Если изменили формулу
  if (qrCalc.RecNo = 25) and (qrCalc.FieldByName('CALC').Value <> qrCalc.FieldByName('CALC').OldValue) then
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

procedure TfCalcWorkerDepartment.qrMainNewRecord(DataSet: TDataSet);
begin
  qrMain.FieldByName('worker_department_id').Value := FastSelectSQLOne('SELECT GetNewID(:0)',
    VarArrayOf([C_ID_WORKDEP]));
  qrMain.FieldByName('OBJ_ID').Value := OBJ_ID;
  qrMain.FieldByName('SM_ID').Value := SM_ID;
  ReloadMain;
end;

end.
