unit InstructionHelp;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Vcl.ComCtrls, JvExComCtrls, JvDBTreeView, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.Buttons;

type
  TfInstructionHelp = class(TForm)
    pnl1: TPanel;
    qrTreeData: TFDQuery;
    dsTreeData: TDataSource;
    tvDocuments: TJvDBTreeView;
    btn1: TBitBtn;
    btn2: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure tvDocumentsDblClick(Sender: TObject);
    procedure btn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fInstructionHelp: TfInstructionHelp;

implementation

{$R *.dfm}

uses Main, Tools, DataModule, FileStorage;

procedure TfInstructionHelp.btn2Click(Sender: TObject);
begin
  Close;
end;

procedure TfInstructionHelp.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfInstructionHelp.FormCreate(Sender: TObject);
begin
  CloseOpen(qrTreeData);
end;

procedure TfInstructionHelp.FormDestroy(Sender: TObject);
begin
  fInstructionHelp := nil;
end;

procedure TfInstructionHelp.tvDocumentsDblClick(Sender: TObject);
begin
  if not CheckQrActiveEmpty(qrTreeData) then
    Exit;
  RunDocument(qrTreeData, False);
end;

end.
