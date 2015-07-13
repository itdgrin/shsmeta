unit TravelList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Vcl.DBCtrls, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids,
  Vcl.DBGrids, JvExDBGrids, JvDBGrid, Tools, Main, Vcl.ComCtrls, JvComponentBase, JvFormPlacement;

type
  TfTravelList = class(TForm)
    qrObject: TFDQuery;
    dsObject: TDataSource;
    pnlTop: TPanel;
    lbl1: TLabel;
    dblkcbbNAME: TDBLookupComboBox;
    pnl1: TPanel;
    qrTravel: TFDQuery;
    dsTravel: TDataSource;
    dbnvgr1: TDBNavigator;
    pgc1: TPageControl;
    ts1: TTabSheet;
    ts2: TTabSheet;
    ts3: TTabSheet;
    grTravel: TJvDBGrid;
    grTravelWork: TJvDBGrid;
    grWorkerDepartment: TJvDBGrid;
    qrTravelWork: TFDQuery;
    dsTravelWork: TDataSource;
    qrWorkerDepartment: TFDQuery;
    dsWorkerDepartment: TDataSource;
    spl1: TSplitter;
    pnlTravel: TPanel;
    FormStorage: TJvFormStorage;
    spl2: TSplitter;
    pnlTravelWork: TPanel;
    spl3: TSplitter;
    pnlWorkerDepartment: TPanel;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure qrTravelNewRecord(DataSet: TDataSet);
    procedure pgc1Change(Sender: TObject);
    procedure qrTravelAfterScroll(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure qrTravelBeforePost(DataSet: TDataSet);
    procedure qrTravelAfterPost(DataSet: TDataSet);
    procedure qrTravelWorkAfterScroll(DataSet: TDataSet);
    procedure qrTravelWorkAfterPost(DataSet: TDataSet);
    procedure qrTravelWorkBeforePost(DataSet: TDataSet);
    procedure qrWorkerDepartmentAfterScroll(DataSet: TDataSet);
    procedure qrWorkerDepartmentAfterPost(DataSet: TDataSet);
    procedure qrWorkerDepartmentBeforePost(DataSet: TDataSet);
  private
  public
    defIdEstimate, defIdAct: Integer; // ид сметы и акта по умолчанию
    procedure LocateObject(Object_ID: Integer);
  end;

var
  fTravelList: TfTravelList;

implementation

{$R *.dfm}

uses CalcTravel, CalcTravelWork, CalcWorkerDepartment, DataModule,
  GlobsAndConst;

procedure TfTravelList.FormActivate(Sender: TObject);
begin
  // Если нажата клавиша Ctrl и выбираем форму, то делаем
  // каскадирование с переносом этой формы на передний план
  FormMain.CascadeForActiveWindow;
  // Делаем нажатой кнопку активной формы (на главной форме внизу)
  FormMain.SelectButtonActiveWindow(Caption);
end;

procedure TfTravelList.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // Закрываем формы
  if Assigned(fCalcTravel) then
    fCalcTravel.Release;
  if Assigned(fCalcTravelWork) then
    fCalcTravelWork.Release;
  if Assigned(fCalcWorkerDepartment) then
    fCalcWorkerDepartment.Release;

  Action := caFree;
end;

procedure TfTravelList.FormCreate(Sender: TObject);
begin
  // Создаём кнопку от этого окна (на главной форме внизу)
  FormMain.CreateButtonOpenWindow(Caption, Caption, Self, 1);

  LoadDBGridSettings(grTravel);
  LoadDBGridSettings(grTravelWork);
  LoadDBGridSettings(grWorkerDepartment);
  CloseOpen(qrObject);
  pgc1.ActivePageIndex := 0;

  // Создаем форму расчета командировочных
  if (not Assigned(fCalcTravel)) then
    fCalcTravel := TfCalcTravel.Create(pnlTravel);
  // FormMain.ReplaceButtonOpenWindow(Self, fCalcTravel);
  fCalcTravel.BorderStyle := bsNone;
  fCalcTravel.Parent := pnlTravel;
  fCalcTravel.Align := alClient;
  fCalcTravel.Show;

  // Создаем форму разъездного характера работ
  if (not Assigned(fCalcTravelWork)) then
    fCalcTravelWork := TfCalcTravelWork.Create(pnlTravelWork);
  // FormMain.ReplaceButtonOpenWindow(Self, fCalcTravelWork);
  fCalcTravelWork.BorderStyle := bsNone;
  fCalcTravelWork.Parent := pnlTravelWork;
  fCalcTravelWork.Align := alClient;
  // fCalcTravelWork.InitParams;
  fCalcTravelWork.Show;

  // Создаем форму перевозки рабочих
  if (not Assigned(fCalcWorkerDepartment)) then
    fCalcWorkerDepartment := TfCalcWorkerDepartment.Create(pnlWorkerDepartment);
  // FormMain.ReplaceButtonOpenWindow(Self, fCalcWorkerDepartment);
  fCalcWorkerDepartment.BorderStyle := bsNone;
  fCalcWorkerDepartment.Parent := pnlWorkerDepartment;
  fCalcWorkerDepartment.Align := alClient;
  // fCalcWorkerDepartment.InitParams;
  fCalcWorkerDepartment.Show;
end;

procedure TfTravelList.FormDestroy(Sender: TObject);
begin
  fTravelList := nil;
  // Удаляем кнопку от этого окна (на главной форме внизу)
  FormMain.DeleteButtonCloseWindow(Caption);
end;

procedure TfTravelList.FormShow(Sender: TObject);
begin
  pgc1Change(Self);
end;

procedure TfTravelList.LocateObject(Object_ID: Integer);
begin
  dblkcbbNAME.KeyValue := Object_ID;
end;

procedure TfTravelList.pgc1Change(Sender: TObject);
begin
  case pgc1.ActivePageIndex of
    0:
      begin
        dbnvgr1.DataSource := dsTravel;
        if not(qrTravel.State in [dsInsert, dsEdit]) then
          CloseOpen(qrTravel);
      end;
    1:
      begin
        dbnvgr1.DataSource := dsTravelWork;
        if not(qrTravelWork.State in [dsInsert, dsEdit]) then
          CloseOpen(qrTravelWork);
      end;
    2:
      begin
        dbnvgr1.DataSource := dsWorkerDepartment;
        if not(qrWorkerDepartment.State in [dsInsert, dsEdit]) then
          CloseOpen(qrWorkerDepartment);
      end;
  end;
end;

procedure TfTravelList.qrTravelAfterPost(DataSet: TDataSet);
begin
  CloseOpen(qrTravel);
end;

procedure TfTravelList.qrTravelAfterScroll(DataSet: TDataSet);
begin
  if Assigned(fCalcTravel) then
  begin
    fCalcTravel.Visible := CheckQrActiveEmpty(qrTravel);
    if fCalcTravel.Visible then
      fCalcTravel.InitParams;
  end;
end;

procedure TfTravelList.qrTravelBeforePost(DataSet: TDataSet);
begin
  case Application.MessageBox('Сохранить изменения в документе?', 'Расчет', MB_YESNOCANCEL + MB_ICONQUESTION +
    MB_TOPMOST) of
    IDCANCEL:
      Abort;
    IDNO:
      DataSet.Cancel;
    IDYES:
      begin
        if fCalcTravel.qrCalc.IsEmpty then
        begin
          if fCalcTravel.cbbSource.ItemIndex = 0 then
            Application.MessageBox('Не указан акт!', 'Расчет командировочных',
              MB_OK + MB_ICONSTOP + MB_TOPMOST)
          else
            Application.MessageBox('Не указана смета!', 'Расчет командировочных',
              MB_OK + MB_ICONSTOP + MB_TOPMOST);
          Abort;
        end;
        fCalcTravel.qrCalc.Last;
        qrTravel.FieldByName('summ').Value := fCalcTravel.qrCalc.FieldByName('TOTAL').Value;
      end;
  end;
end;

procedure TfTravelList.qrTravelNewRecord(DataSet: TDataSet);
var NewId: Integer;
begin
  DM.qrDifferent.Active := False;
  DM.qrDifferent.SQL.Text := 'SELECT GetNewID(:IDType)';
  if DataSet = qrTravel then
    DM.qrDifferent.ParamByName('IDType').Value := C_ID_TRAVEL
  else if DataSet = qrTravelWork then
    DM.qrDifferent.ParamByName('IDType').Value := C_ID_TRWORK
  else if DataSet = qrWorkerDepartment then
    DM.qrDifferent.ParamByName('IDType').Value := C_ID_WORKDEP
  else
    raise Exception.Create('Неизвестный DataSet.');
  DM.qrDifferent.Active := True;
  NewId := 0;
  if not DM.qrDifferent.Eof then
    NewId := DM.qrDifferent.Fields[0].AsInteger;
  DM.qrDifferent.Active := False;

  if DataSet = qrTravel then
    DataSet.FieldByName('travel_id').AsInteger := NewId
  else if DataSet = qrTravelWork then
    DataSet.FieldByName('travel_work_id').AsInteger := NewId
  else if DataSet = qrWorkerDepartment then
    DataSet.FieldByName('worker_department_id').AsInteger := NewId;

  DataSet.FieldByName('OnDate').AsDateTime := Now;
  if defIdEstimate <> 0 then
  begin
    DataSet.FieldByName('id_estimate').Value := defIdEstimate;
    DataSet.FieldByName('SOURCE_TYPE').Value := 1;
  end
  else if defIdAct <> 0 then
  begin
    DataSet.FieldByName('id_act').Value := defIdAct;
    DataSet.FieldByName('SOURCE_TYPE').Value := 0;
  end;
end;

procedure TfTravelList.qrTravelWorkAfterPost(DataSet: TDataSet);
begin
  CloseOpen(qrTravelWork);
end;

procedure TfTravelList.qrTravelWorkAfterScroll(DataSet: TDataSet);
begin
  if Assigned(fCalcTravelWork) then
  begin
    fCalcTravelWork.Visible := CheckQrActiveEmpty(qrTravelWork);
    if fCalcTravelWork.Visible then
      fCalcTravelWork.InitParams;
  end;
end;

procedure TfTravelList.qrTravelWorkBeforePost(DataSet: TDataSet);
begin
  case Application.MessageBox('Сохранить изменения в документе?', 'Расчет', MB_YESNOCANCEL + MB_ICONQUESTION +
    MB_TOPMOST) of
    IDCANCEL:
      Abort;
    IDNO:
      DataSet.Cancel;
    IDYES:
      begin
        if fCalcTravelWork.qrCalc.IsEmpty then
        begin
          if fCalcTravelWork.cbbSource.ItemIndex = 0 then
            Application.MessageBox('Не указан акт!', 'Расчет командировочных',
              MB_OK + MB_ICONSTOP + MB_TOPMOST)
          else
            Application.MessageBox('Не указана смета!', 'Расчет командировочных',
              MB_OK + MB_ICONSTOP + MB_TOPMOST);
          Abort;
        end;
        fCalcTravelWork.qrCalc.Last;
        qrTravelWork.FieldByName('summ').Value := fCalcTravelWork.qrCalc.FieldByName('TOTAL').Value;
      end;
  end;
end;

procedure TfTravelList.qrWorkerDepartmentAfterPost(DataSet: TDataSet);
begin
  CloseOpen(qrWorkerDepartment);
end;

procedure TfTravelList.qrWorkerDepartmentAfterScroll(DataSet: TDataSet);
begin
  if Assigned(fCalcWorkerDepartment) then
  begin
    fCalcWorkerDepartment.Visible := CheckQrActiveEmpty(qrWorkerDepartment);
    if fCalcWorkerDepartment.Visible then
      fCalcWorkerDepartment.InitParams;
  end;
end;

procedure TfTravelList.qrWorkerDepartmentBeforePost(DataSet: TDataSet);
begin
  case Application.MessageBox('Сохранить изменения в документе?', 'Расчет', MB_YESNOCANCEL + MB_ICONQUESTION +
    MB_TOPMOST) of
    IDCANCEL:
      Abort;
    IDNO:
      DataSet.Cancel;
    IDYES:
      begin
        if fCalcWorkerDepartment.qrCalc.IsEmpty then
        begin
          if fCalcWorkerDepartment.cbbSource.ItemIndex = 0 then
            Application.MessageBox('Не указан акт!', 'Расчет командировочных',
              MB_OK + MB_ICONSTOP + MB_TOPMOST)
          else
            Application.MessageBox('Не указана смета!', 'Расчет командировочных',
              MB_OK + MB_ICONSTOP + MB_TOPMOST);
          Abort;
        end;
        fCalcWorkerDepartment.qrCalc.Last;
        qrWorkerDepartment.FieldByName('summ').Value := fCalcWorkerDepartment.qrCalc.FieldByName
          ('TOTAL').Value;
      end;
  end;
end;

end.
