unit ContractPrice;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Tools, DataModule, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids,
  Vcl.DBGrids, JvExDBGrids, JvDBGrid, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TfContractPrice = class(TSmForm)
    pnlTop: TPanel;
    pnlClient: TPanel;
    JvDBGrid1: TJvDBGrid;
    dsMain: TDataSource;
    qrMain: TFDQuery;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    rgShowProgress: TRadioGroup;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    idObject, idEstimate: Integer;
  public
    { Public declarations }
  end;

var
  fContractPrice: TfContractPrice;

implementation

{$R *.dfm}

procedure TfContractPrice.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfContractPrice.FormCreate(Sender: TObject);
begin
  idObject := InitParams[0];
  idEstimate := InitParams[1];
end;

procedure TfContractPrice.FormDestroy(Sender: TObject);
begin
  fContractPrice := nil;
end;

end.
