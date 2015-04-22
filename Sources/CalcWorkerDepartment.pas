unit CalcWorkerDepartment;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, Vcl.DBCtrls, Vcl.Grids,
  Vcl.DBGrids, JvExDBGrids, JvDBGrid, Tools, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfCalcWorkerDepartment = class(TForm)
    lbl1: TLabel;
    dbedtPREPARER: TDBEdit;
    lbl3: TLabel;
    dbedtNAME: TDBEdit;
    lbl4: TLabel;
    JvDBGrid1: TJvDBGrid;
    dsCalc: TDataSource;
    qrCalc: TFDQuery;
    dblkcbbAct: TDBLookupComboBox;
    cbbSource: TComboBox;
    dbchkFL_Full_month: TDBCheckBox;
    qrActList: TFDQuery;
    dsActList: TDataSource;
    qrSmetaList: TFDQuery;
    dsSmetaList: TDataSource;
    dblkcbbSmeta: TDBLookupComboBox;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure qrCalcAfterPost(DataSet: TDataSet);
    procedure JvDBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure dblkcbbActClick(Sender: TObject);
    procedure cbbSourceChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    procedure InitParams;
  public
  end;

var
  fCalcWorkerDepartment: TfCalcWorkerDepartment;

implementation

{$R *.dfm}

uses Main, TravelList;

procedure TfCalcWorkerDepartment.cbbSourceChange(Sender: TObject);
begin
  case cbbSource.ItemIndex of
    0:
      begin
        dblkcbbAct.Visible := True;
        dblkcbbSmeta.Visible := False;
      end;
    1:
      begin
        dblkcbbAct.Visible := False;
        dblkcbbSmeta.Visible := True;
      end;
  end;
  dblkcbbActClick(Sender);
end;

procedure TfCalcWorkerDepartment.dblkcbbActClick(Sender: TObject);
begin
  InitParams;
  if not VarIsNull(qrCalc.ParamByName('ID_ACT').Value) or
    not VarIsNull(qrCalc.ParamByName('ID_ESTIMATE').Value) then
    CloseOpen(qrCalc);
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

procedure TfCalcWorkerDepartment.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  case Application.MessageBox('Сохранить изменения в документе?', 'Расчет', MB_YESNOCANCEL + MB_ICONQUESTION +
    MB_TOPMOST) of
    IDCANCEL:
      begin
        CanClose := False;
      end;
    IDYES:
      begin
        qrCalc.Last;
        fTravelList.qrWorkerDepartment.FieldByName('summ').AsInteger := qrCalc.FieldByName('TOTAL').AsInteger;
        if fTravelList.qrWorkerDepartment.State in [dsEdit, dsInsert] then
          fTravelList.qrWorkerDepartment.Post;
        CanClose := True;
      end;
    IDNO:
      begin
        fTravelList.qrWorkerDepartment.Cancel;
        CanClose := True;
      end;
  end;
end;

procedure TfCalcWorkerDepartment.FormCreate(Sender: TObject);
begin
  // Создаём кнопку от этого окна (на главной форме внизу)
  // FormMain.CreateButtonOpenWindow(Caption, Caption, fTravelList.qrTravelNewRecord(fTravelList.qrTravel));
  LoadDBGridSettings(JvDBGrid1);
  CloseOpen(qrActList);
  CloseOpen(qrSmetaList);
  if not VarIsNull(fTravelList.qrWorkerDepartment.FieldByName('ID_ESTIMATE').Value) then
  begin
    cbbSource.ItemIndex := 1;
    dblkcbbAct.Visible := False;
    dblkcbbSmeta.Visible := True;
  end;
  if fTravelList.qrWorkerDepartment.State in [dsEdit, dsBrowse] then
    InitParams;
  if not VarIsNull(qrCalc.ParamByName('ID_ACT').Value) or
    not VarIsNull(qrCalc.ParamByName('ID_ESTIMATE').Value) then
    CloseOpen(qrCalc);
  dbchkFL_Full_month.OnClick := dblkcbbActClick;
end;

procedure TfCalcWorkerDepartment.FormDestroy(Sender: TObject);
begin
  fCalcWorkerDepartment := nil;
  // Удаляем кнопку от этого окна (на главной форме внизу)
  FormMain.DeleteButtonCloseWindow(Caption);
end;

procedure TfCalcWorkerDepartment.InitParams;
begin
  // Заполняем параметры расчета
  case cbbSource.ItemIndex of
    // акт
    0:
      begin
        qrCalc.ParamByName('ID_ACT').Value := fTravelList.qrWorkerDepartment.FieldByName('ID_ACT').Value;
        qrCalc.ParamByName('ID_ESTIMATE').Value := null;
      end;
    // смета
    1:
      begin
        qrCalc.ParamByName('ID_ACT').Value := null;
        qrCalc.ParamByName('ID_ESTIMATE').Value := fTravelList.qrWorkerDepartment.FieldByName
          ('ID_ESTIMATE').Value;
      end;
  end;
  qrCalc.ParamByName('FLFullMonth').Value := fTravelList.qrWorkerDepartment.FieldByName
    ('FL_Full_month').Value;
  qrCalc.ParamByName('PLACE_COUNT').Value := fTravelList.qrWorkerDepartment.FieldByName('PLACE_COUNT').Value;
  qrCalc.ParamByName('EMbyHVR').Value := fTravelList.qrWorkerDepartment.FieldByName('EMbyHVR').Value;
  qrCalc.ParamByName('EMbyKM').Value := fTravelList.qrWorkerDepartment.FieldByName('EMbyKM').Value;
  qrCalc.ParamByName('RoadALength').Value := fTravelList.qrWorkerDepartment.FieldByName('RoadALength').Value;
  qrCalc.ParamByName('RoadGLength').Value := fTravelList.qrWorkerDepartment.FieldByName('RoadGLength').Value;
  qrCalc.ParamByName('RoadGrLength').Value := fTravelList.qrWorkerDepartment.FieldByName
    ('RoadGrLength').Value;
  qrCalc.ParamByName('RoadASpeed').Value := fTravelList.qrWorkerDepartment.FieldByName('RoadASpeed').Value;
  qrCalc.ParamByName('RoadGSpeed').Value := fTravelList.qrWorkerDepartment.FieldByName('RoadGSpeed').Value;
  qrCalc.ParamByName('RoadGrSpeed').Value := fTravelList.qrWorkerDepartment.FieldByName('RoadGrSpeed').Value;
  qrCalc.ParamByName('TravelCount').Value := fTravelList.qrWorkerDepartment.FieldByName('TravelCount').Value;
  qrCalc.ParamByName('InOut').Value := fTravelList.qrWorkerDepartment.FieldByName('InOut').Value;
  qrCalc.ParamByName('TimeIN').Value := fTravelList.qrWorkerDepartment.FieldByName('TimeIN').Value;
  qrCalc.ParamByName('TimeOUT').Value := fTravelList.qrWorkerDepartment.FieldByName('TimeOUT').Value;
end;

procedure TfCalcWorkerDepartment.JvDBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
  if (Ord(Key) = VK_RETURN) and (qrCalc.State = dsEdit) then
    qrCalc.Post;
end;

procedure TfCalcWorkerDepartment.qrCalcAfterPost(DataSet: TDataSet);
begin
  if qrCalc.RecNo = 2 then
    fTravelList.qrWorkerDepartment.FieldByName('PLACE_COUNT').AsInteger := qrCalc.FieldByName('CALC')
      .AsInteger;
  if qrCalc.RecNo = 3 then
    fTravelList.qrWorkerDepartment.FieldByName('EMbyHVR').AsInteger := qrCalc.FieldByName('CALC').AsInteger;
  if qrCalc.RecNo = 4 then
    fTravelList.qrWorkerDepartment.FieldByName('EMbyKM').AsInteger := qrCalc.FieldByName('CALC').AsInteger;
  if qrCalc.RecNo = 6 then
    fTravelList.qrWorkerDepartment.FieldByName('RoadALength').AsInteger := qrCalc.FieldByName('CALC')
      .AsInteger;
  if qrCalc.RecNo = 7 then
    fTravelList.qrWorkerDepartment.FieldByName('RoadGLength').AsInteger := qrCalc.FieldByName('CALC')
      .AsInteger;
  if qrCalc.RecNo = 8 then
    fTravelList.qrWorkerDepartment.FieldByName('RoadGrLength').AsInteger := qrCalc.FieldByName('CALC')
      .AsInteger;
  if qrCalc.RecNo = 10 then
    fTravelList.qrWorkerDepartment.FieldByName('RoadASpeed').AsInteger := qrCalc.FieldByName('CALC')
      .AsInteger;
  if qrCalc.RecNo = 11 then
    fTravelList.qrWorkerDepartment.FieldByName('RoadGSpeed').AsInteger := qrCalc.FieldByName('CALC')
      .AsInteger;
  if qrCalc.RecNo = 12 then
    fTravelList.qrWorkerDepartment.FieldByName('RoadGrSpeed').AsInteger := qrCalc.FieldByName('CALC')
      .AsInteger;
  if qrCalc.RecNo = 15 then
    fTravelList.qrWorkerDepartment.FieldByName('TravelCount').AsInteger := qrCalc.FieldByName('CALC')
      .AsInteger;
  if qrCalc.RecNo = 16 then
    fTravelList.qrWorkerDepartment.FieldByName('InOut').AsInteger := qrCalc.FieldByName('CALC').AsInteger;
  if qrCalc.RecNo = 17 then
    fTravelList.qrWorkerDepartment.FieldByName('TimeIN').AsInteger := qrCalc.FieldByName('CALC').AsInteger;
  if qrCalc.RecNo = 18 then
    fTravelList.qrWorkerDepartment.FieldByName('TimeOUT').AsInteger := qrCalc.FieldByName('CALC').AsInteger;
  InitParams;
  CloseOpen(qrCalc);
end;

end.
