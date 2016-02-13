unit SSR;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fFrameSSR, Tools, Vcl.StdCtrls,
  Vcl.ExtCtrls;

type
  TfSSR = class(TSmForm)
    pnlBottons: TPanel;
    btnSelect: TButton;
    btnCancel: TButton;
    procedure FormCreate(Sender: TObject);
  private
    FFrameSSR: TFrameSSR;
    FSSRID: Integer;
    FSprID: Integer;
    procedure GetSprID(AValue: Integer);
  public
    property SprID: Integer read FSprID;
  end;

implementation

{$R *.dfm}

uses Main;

procedure TfSSR.GetSprID(AValue: Integer);
begin
  FSprID := AValue;
  btnSelect.Enabled := FSprID > 0;
end;

procedure TfSSR.FormCreate(Sender: TObject);
begin
  FSSRID := InitParams[0];
  Caption := InitParams[1];
  pnlBottons.Visible := InitParams[2];

  FFrameSSR := TFrameSSR.Create(Self);
  FFrameSSR.Parent := Self;
  FFrameSSR.Align := alClient;
  FFrameSSR.PanelMenu.Visible := False;
  FFrameSSR.ComboBox.ItemIndex := FSSRID - 1;

  if pnlBottons.Visible then
  begin
    FFrameSSR.OnSelectSprItem := GetSprID;
    GetSprID(0);
  end;

  with FFrameSSR do
    case FSSRID of
      1:
        lbPrikazRef.Caption := 'ÍÐÐ 8.01.103 - 2012';
      2:
        lbPrikazRef.Caption := 'ÍÐÐ 8.01.102 - 2012';
    else
      lbPrikazRef.Caption := '';
    end;

  if (FSSRID >= 3) and (FSSRID <= 5) then
    FFrameSSR.ReceivingAll2
  else
    FFrameSSR.ReceivingAll;
  FFrameSSR.Visible := True;
end;

end.
