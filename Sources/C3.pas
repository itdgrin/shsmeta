unit C3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.Mask, JvExMask, JvSpin,
  JvDBSpinEdit, Tools, DataModule, Main, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, JvExDBGrids, JvDBGrid;

type
  TfC3 = class(TSmForm)
    pnlTop: TPanel;
    lblDate: TLabel;
    cbbMonth: TComboBox;
    dbedt1: TDBEdit;
    lblObject: TLabel;
    seYear: TJvSpinEdit;
    btn1: TBitBtn;
    btn2: TBitBtn;
    btn3: TBitBtn;
    btn4: TBitBtn;
    pnl1: TPanel;
    JvDBGrid1: TJvDBGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FidObject: Integer;
  public
  end;

var
  fC3: TfC3;

implementation

{$R *.dfm}

procedure TfC3.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // Создаём кнопку от этого окна (на главной форме внизу)
  FormMain.CreateButtonOpenWindow(Caption, Caption, Self, 1);
  Action := caFree;
end;

procedure TfC3.FormCreate(Sender: TObject);
begin
  FidObject := InitParams;
end;

procedure TfC3.FormDestroy(Sender: TObject);
begin
  fC3 := nil;
  // Удаляем кнопку от этого окна (на главной форме внизу)
  FormMain.DeleteButtonCloseWindow(Caption);
end;

end.
