unit CalcTravel;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, Vcl.DBCtrls, Vcl.Grids,
  Vcl.DBGrids, JvExDBGrids, JvDBGrid, Tools, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfCalcTravel = class(TForm)
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

  public
    procedure InitParams;
  end;

var
  fCalcTravel: TfCalcTravel;

implementation

{$R *.dfm}

uses Main, TravelList;

procedure TfCalcTravel.cbbSourceChange(Sender: TObject);
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

procedure TfCalcTravel.dblkcbbActClick(Sender: TObject);
begin
  Application.ProcessMessages;
  InitParams;
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
  FormMain.ReplaceButtonOpenWindow(Self, fTravelList);
  Action := caFree;
end;

procedure TfCalcTravel.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  case Application.MessageBox('Сохранить изменения в документе?', 'Расчет', MB_YESNOCANCEL + MB_ICONQUESTION +
    MB_TOPMOST) of
    IDCANCEL:
      begin
        CanClose := False;
      end;
    IDYES:
      begin
        if qrCalc.IsEmpty then
        begin
          if cbbSource.ItemIndex = 0 then
            Application.MessageBox('Не указан акт!', 'Расчет командировочных',
              MB_OK + MB_ICONSTOP + MB_TOPMOST)
          else
            Application.MessageBox('Не указана смета!', 'Расчет командировочных',
              MB_OK + MB_ICONSTOP + MB_TOPMOST);
          Abort;
        end;
        qrCalc.Last;
        fTravelList.qrTravel.FieldByName('summ').AsInteger := qrCalc.FieldByName('TOTAL').AsInteger;
        if fTravelList.qrTravel.State in [dsEdit, dsInsert] then
          fTravelList.qrTravel.Post;
        CloseOpen(fTravelList.qrTravel);
        CanClose := True;
      end;
    IDNO:
      begin
        fTravelList.qrTravel.Cancel;
        CanClose := True;
      end;
  end;
end;

procedure TfCalcTravel.FormCreate(Sender: TObject);
begin
  LoadDBGridSettings(JvDBGrid1);
  CloseOpen(qrActList);
  CloseOpen(qrSmetaList);
  if not VarIsNull(fTravelList.qrTravel.FieldByName('ID_ESTIMATE').Value) then
  begin
    cbbSource.ItemIndex := 1;
    dblkcbbAct.Visible := False;
    dblkcbbSmeta.Visible := True;
  end;
  dbchkFL_Full_month.OnClick := dblkcbbActClick;
end;

procedure TfCalcTravel.FormDestroy(Sender: TObject);
begin
  fTravelList.Show;
  fCalcTravel := nil;
end;

procedure TfCalcTravel.InitParams;
begin
  // Заполняем параметры расчета
  case cbbSource.ItemIndex of
    // акт
    0:
      begin
        qrCalc.ParamByName('ID_ACT').Value := fTravelList.qrTravel.FieldByName('ID_ACT').Value;
        qrCalc.ParamByName('ID_ESTIMATE').Value := null;
      end;
    // смета
    1:
      begin
        qrCalc.ParamByName('ID_ACT').Value := null;
        qrCalc.ParamByName('ID_ESTIMATE').Value := fTravelList.qrTravel.FieldByName('ID_ESTIMATE').Value;
      end;
  end;
  qrCalc.ParamByName('FLFullMonth').Value := fTravelList.qrTravel.FieldByName('FL_Full_month').Value;
  qrCalc.ParamByName('SUTKI_KOMANDIR').Value := fTravelList.qrTravel.FieldByName('SUTKI_KOMANDIR').Value;
  qrCalc.ParamByName('HOUSING_KOMANDIR').Value := fTravelList.qrTravel.FieldByName('HOUSING_KOMANDIR').Value;
  qrCalc.ParamByName('STOIM_KM').Value := fTravelList.qrTravel.FieldByName('STOIM_KM').Value;
  qrCalc.ParamByName('KM').Value := fTravelList.qrTravel.FieldByName('KM').Value;
  if not VarIsNull(qrCalc.ParamByName('ID_ACT').Value) or
    not VarIsNull(qrCalc.ParamByName('ID_ESTIMATE').Value) then
    CloseOpen(qrCalc)
  else if qrCalc.Active then
    qrCalc.Active := False;
end;

procedure TfCalcTravel.JvDBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
  if (Ord(Key) = VK_RETURN) and (qrCalc.State = dsEdit) then
    qrCalc.Post;
end;

procedure TfCalcTravel.qrCalcAfterPost(DataSet: TDataSet);
begin
  if qrCalc.FieldByName('NUMPP').AsString = '06' then
    fTravelList.qrTravel.FieldByName('SUTKI_KOMANDIR').AsInteger := qrCalc.FieldByName('CALC').AsInteger;
  if qrCalc.FieldByName('NUMPP').AsString = '07' then
    fTravelList.qrTravel.FieldByName('HOUSING_KOMANDIR').AsInteger := qrCalc.FieldByName('CALC').AsInteger;
  if qrCalc.FieldByName('NUMPP').AsString = '08' then
    fTravelList.qrTravel.FieldByName('STOIM_KM').AsInteger := qrCalc.FieldByName('CALC').AsInteger;
  if qrCalc.FieldByName('NUMPP').AsString = '09' then
    fTravelList.qrTravel.FieldByName('KM').AsFloat := qrCalc.FieldByName('CALC').AsInteger;
  if qrCalc.FieldByName('NUMPP').AsString = '26' then
    fTravelList.qrTravel.FieldByName('summ').AsFloat := qrCalc.FieldByName('TOTAL').AsInteger;
  InitParams;
end;

end.
