unit RoundSetup;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, JvExMask, JvSpin, JvDBSpinEdit,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Tools, Vcl.Grids, Vcl.DBGrids, JvExDBGrids, JvDBGrid;

type
  TfRoundSetup = class(TSmForm)
    btnCancel: TBitBtn;
    btnSave: TBitBtn;
    grMainEx: TJvDBGrid;
    qrMainEx: TFDQuery;
    dsMainEx: TDataSource;
    qrMainExACCURACY: TFloatField;
    qrMainExDESCRIPTION: TStringField;
    qrMainExROUND_TYPE: TIntegerField;
    qrRoundType: TFDQuery;
    qrMainExLOOK_TYPE: TStringField;
    qrMainExNAME: TStringField;
    qrMainExCODE: TIntegerField;
    procedure btnCancelClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fRoundSetup: TfRoundSetup;

implementation

{$R *.dfm}

uses Main, DataModule;

procedure TfRoundSetup.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfRoundSetup.btnSaveClick(Sender: TObject);
begin
  if qrMainEx.State in [dsEdit, dsInsert] then
    qrMainEx.Post;
  Close;
end;

procedure TfRoundSetup.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if qrMainEx.State in [dsEdit, dsInsert] then
    qrMainEx.Cancel;
  Action := caFree;
end;

procedure TfRoundSetup.FormCreate(Sender: TObject);
begin
  CloseOpen(qrRoundType);
  CloseOpen(qrMainEx);
end;

procedure TfRoundSetup.FormDestroy(Sender: TObject);
begin
  fRoundSetup := nil;
end;

end.
