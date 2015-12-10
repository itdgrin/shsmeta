unit ContractPriceEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Tools, DataModule, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, JvExDBGrids,
  JvDBGrid, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls;

type
  TfContractPriceEdit = class(TSmForm)
    pnlTopEstimate: TPanel;
    pnlTopSourceData: TPanel;
    pnlClient: TPanel;
    pnlBottom: TPanel;
    lblEstimate: TLabel;
    dbedt1: TDBEdit;
    grMain: TJvDBGrid;
    lbl1: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    idObject, idEstimate, calcType: Integer;
  public
    { Public declarations }
  end;

var
  fContractPriceEdit: TfContractPriceEdit;

implementation

{$R *.dfm}

procedure TfContractPriceEdit.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfContractPriceEdit.FormCreate(Sender: TObject);
begin
  idObject := InitParams[0];
  idEstimate := InitParams[1];
  calcType := InitParams[2];
end;

procedure TfContractPriceEdit.FormDestroy(Sender: TObject);
begin
  fContractPriceEdit := nil;
end;

end.
