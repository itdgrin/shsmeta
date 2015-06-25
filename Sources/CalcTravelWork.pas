unit CalcTravelWork;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, Vcl.DBCtrls, Vcl.Grids,
  Vcl.DBGrids, JvExDBGrids, JvDBGrid, Tools, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfCalcTravelWork = class(TForm)
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
  fCalcTravelWork: TfCalcTravelWork;

implementation

{$R *.dfm}

uses Main, TravelList;

procedure TfCalcTravelWork.cbbSourceChange(Sender: TObject);
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

procedure TfCalcTravelWork.dblkcbbActClick(Sender: TObject);
begin
  InitParams;
  if not VarIsNull(qrCalc.ParamByName('ID_ACT').Value) or
    not VarIsNull(qrCalc.ParamByName('ID_ESTIMATE').Value) then
    CloseOpen(qrCalc);
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
  Action := caFree;
end;

procedure TfCalcTravelWork.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
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
        fTravelList.qrTravelWork.FieldByName('summ').AsInteger := qrCalc.FieldByName('TOTAL').AsInteger;
        if fTravelList.qrTravelWork.State in [dsEdit, dsInsert] then
          fTravelList.qrTravelWork.Post;
        CanClose := True;
      end;
    IDNO:
      begin
        fTravelList.qrTravelWork.Cancel;
        CanClose := True;
      end;
  end;
end;

procedure TfCalcTravelWork.FormCreate(Sender: TObject);
begin
  // Создаём кнопку от этого окна (на главной форме внизу)
  // FormMain.CreateButtonOpenWindow(Caption, Caption, fTravelList.qrTravelNewRecord(fTravelList.qrTravel));
  LoadDBGridSettings(JvDBGrid1);
  CloseOpen(qrActList);
  CloseOpen(qrSmetaList);
  if not VarIsNull(fTravelList.qrTravelWork.FieldByName('ID_ESTIMATE').Value) then
  begin
    cbbSource.ItemIndex := 1;
    dblkcbbAct.Visible := False;
    dblkcbbSmeta.Visible := True;
  end;
  if fTravelList.qrTravelWork.State in [dsEdit, dsBrowse] then
    InitParams;
  if not VarIsNull(qrCalc.ParamByName('ID_ACT').Value) or
    not VarIsNull(qrCalc.ParamByName('ID_ESTIMATE').Value) then
    CloseOpen(qrCalc);
  dbchkFL_Full_month.OnClick := dblkcbbActClick;
end;

procedure TfCalcTravelWork.FormDestroy(Sender: TObject);
begin
  fCalcTravelWork := nil;
  // Удаляем кнопку от этого окна (на главной форме внизу)
  FormMain.DeleteButtonCloseWindow(Caption);
end;

procedure TfCalcTravelWork.InitParams;
begin
  // Заполняем параметры расчета
  case cbbSource.ItemIndex of
    // акт
    0:
      begin
        qrCalc.ParamByName('ID_ACT').Value := fTravelList.qrTravelWork.FieldByName('ID_ACT').Value;
        qrCalc.ParamByName('ID_ESTIMATE').Value := null;
      end;
    // смета
    1:
      begin
        qrCalc.ParamByName('ID_ACT').Value := null;
        qrCalc.ParamByName('ID_ESTIMATE').Value := fTravelList.qrTravelWork.FieldByName('ID_ESTIMATE').Value;
      end;
  end;
  qrCalc.ParamByName('FLFullMonth').Value := fTravelList.qrTravelWork.FieldByName('FL_Full_month').Value;
  qrCalc.ParamByName('SUTKI_KOMANDIR').Value := fTravelList.qrTravelWork.FieldByName('SUTKI_KOMANDIR').Value;
end;

procedure TfCalcTravelWork.JvDBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
  if (Ord(Key) = VK_RETURN) and (qrCalc.State = dsEdit) then
    qrCalc.Post;
end;

procedure TfCalcTravelWork.qrCalcAfterPost(DataSet: TDataSet);
begin
  if qrCalc.RecNo = 1 then
    fTravelList.qrTravelWork.FieldByName('SUTKI_KOMANDIR').AsInteger := qrCalc.FieldByName('CALC').AsInteger;
  InitParams;
  CloseOpen(qrCalc);
end;

end.
