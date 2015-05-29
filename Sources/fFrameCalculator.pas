unit fFrameCalculator;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  JvExStdCtrls, JvEdit, JvExDBGrids, JvDBGrid, Vcl.ExtCtrls;

type
  TCalculator = class(TFrame)
    Panel: TPanel;
    edtCoast: TJvEdit;
    edtCount: TJvEdit;
    edtNDS: TJvEdit;
    lbCoast: TLabel;
    lbNDS: TLabel;
    lbCount: TLabel;
    edtPriceNDS: TJvEdit;
    lbPriceNDS: TLabel;
    ButtonPanel: TPanel;
    btnSetResult: TButton;
    btnHide: TButton;
    procedure FrameExit(Sender: TObject);
    procedure btnHideClick(Sender: TObject);
  private
    FGrd: TJvDBGrid;
    { Private declarations }
  public
    procedure ShowCalculator(AGrd: TJvDBGrid);
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TCalculator.ShowCalculator(AGrd: TJvDBGrid);
var p: TPoint;
begin
  if not Assigned(AGrd) then
    Exit;

  FGrd := AGrd;
  p := AGrd.ClientToParent(AGrd.CellRect(AGrd.Col, AGrd.Row).BottomRight,
    Self.Parent);

  Top := p.Y + 1;
  Left := p.X - Width + 2;

  Visible := True;
  btnHide.SetFocus;
end;

procedure TCalculator.btnHideClick(Sender: TObject);
begin
  FrameExit(Sender);
end;

procedure TCalculator.FrameExit(Sender: TObject);
begin
  if Assigned(FGrd) then
    if FGrd.CanFocus then
      FGrd.SetFocus;
  FGrd := nil;
  Visible := False;
end;

end.
