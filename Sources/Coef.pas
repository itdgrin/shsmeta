unit Coef;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Vcl.DBCtrls, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, JvExDBGrids, JvDBGrid, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Buttons, Vcl.Menus, JvComponentBase, JvFormPlacement;

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
    qrCoef_Type: TFDQuery;
    dsCoef_Type: TDataSource;
    strngfldCoefCoefTypeLook: TStringField;
    qrCoefcoef_id: TFDAutoIncField;
    strngfldCoefcoef_name: TStringField;
    qrCoefosn_zp: TFloatField;
    qrCoefeksp_mach: TFloatField;
    qrCoefmat_res: TFloatField;
    qrCoefwork_pers: TFloatField;
    qrCoefwork_mach: TFloatField;
    qrCoefcoef_type_id: TIntegerField;
    qrCoefoxropr: TFloatField;
    qrCoefplanprib: TFloatField;
    FormStorage: TJvFormStorage;
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

  ModalResult := mrOk;
end;

procedure TfCoefficients.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfCoefficients.FormShow(Sender: TObject);
begin
  CloseOpen(qrCoef_Type);
  CloseOpen(qrCoef);
  LoadDBGridSettings(grCoef);

  Left := FormMain.Left + (FormMain.Width - Width) div 2;
  Top := FormMain.Top + (FormMain.Height - Height) div 2;

  SelectEnabled := fsModal in FormState;

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
