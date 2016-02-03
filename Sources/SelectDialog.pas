unit SelectDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.DBGrids, JvExDBGrids, JvDBGrid, JvComponentBase,
  JvFormPlacement, Data.DB, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, Tools,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.UITypes;

type
  TfSelectDialog = class(TSmForm)
    dsMain: TDataSource;
    FormStorage: TJvFormStorage;
    grMain: TJvDBGrid;
    pnlBot: TPanel;
    btnCancel: TBitBtn;
    btnOk: TBitBtn;
    procedure grMainDblClick(Sender: TObject);
  private
  public
  end;

function ShowSelectDialog(const ACapt: String; const ADataSet: TFDQuery): Boolean;

implementation

uses Main, DataModule, CalculationEstimate;

{$R *.dfm}

function ShowSelectDialog(const ACapt: String; const ADataSet: TFDQuery): Boolean;
var
  f: TfSelectDialog;
begin
  Result := False;
  f := nil;
  try
    if (not Assigned(f)) then
      f := TfSelectDialog.Create(nil);
    f.Caption := ACapt;
    f.dsMain.DataSet := ADataSet;
    if f.ShowModal = mrOk then
      Result := True;
  finally
    FreeAndNil(f);
  end;
end;

procedure TfSelectDialog.grMainDblClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

end.
