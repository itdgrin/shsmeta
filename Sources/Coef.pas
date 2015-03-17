unit Coef;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Vcl.DBCtrls, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, JvExDBGrids, JvDBGrid, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Buttons, Vcl.Menus;

type
  TfCoefficients = class(TForm)
    qrCoef: TFDQuery;
    dsCoef: TDataSource;
    grCoef: TJvDBGrid;
    pnl1: TPanel;
    btnClose: TButton;
    dbnvgr1: TDBNavigator;
    btnAdd: TButton;
    pm1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure qrCoefAfterPost(DataSet: TDataSet);
    procedure qrCoefNewRecord(DataSet: TDataSet);
  private
    SelectEnabled: Boolean;
  public
    { Public declarations }
  end;

var
  fCoefficients: TfCoefficients;

implementation

{$R *.dfm}

uses Main, Tools, CalculationEstimate;

procedure TfCoefficients.btnAddClick(Sender: TObject);
begin
  if not SelectEnabled then
    Exit;

  if qrCoef.State in [dsEdit, dsInsert] then
    qrCoef.Post;

  if FormCalculationEstimate.GetCountCoef = 5 then
  begin
    MessageBox(0, PChar('Уже добавлено 5 наборов коэффициентов!' + sLineBreak + sLineBreak +
      'Добавление больше 5 наборов невозможно.'), 'Смета', MB_ICONINFORMATION + MB_OK + mb_TaskModal);
    Close;
  end
  else
    FormCalculationEstimate.AddCoefToRate(qrCoef.FieldByName('coef_id').AsInteger);
end;

procedure TfCoefficients.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfCoefficients.FormShow(Sender: TObject);
begin
  CloseOpen(qrCoef);
  LoadDBGridSettings(grCoef);

  Left := FormMain.Left + (FormMain.Width - Width) div 2;
  Top := FormMain.Top + (FormMain.Height - Height) div 2;

  SelectEnabled := Assigned(FormCalculationEstimate);

  btnAdd.Visible := SelectEnabled;
  N4.Visible := SelectEnabled;
  N5.Visible := SelectEnabled;
end;

procedure TfCoefficients.N1Click(Sender: TObject);
begin
  dbnvgr1.BtnClick(nbInsert);
end;

procedure TfCoefficients.N2Click(Sender: TObject);
begin
  dbnvgr1.BtnClick(nbEdit);
end;

procedure TfCoefficients.N3Click(Sender: TObject);
begin
  dbnvgr1.BtnClick(nbDelete);
end;

procedure TfCoefficients.qrCoefAfterPost(DataSet: TDataSet);
begin
  grCoef.Options := grCoef.Options - [dgEditing] + [dgRowSelect];
end;

procedure TfCoefficients.qrCoefNewRecord(DataSet: TDataSet);
begin
  grCoef.Options := grCoef.Options - [dgRowSelect] + [dgEditing];
end;

end.
