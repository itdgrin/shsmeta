unit About;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, ExtCtrls, StdCtrls;

type
  TFormAbout = class(TForm)
    Label1: TLabel;
    Image1: TImage;
    Label2: TLabel;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses Main;

{$R *.dfm}
// ---------------------------------------------------------------------------------------------------------------------

procedure TFormAbout.FormShow(Sender: TObject);
begin
  Left := FormMain.Left + (FormMain.Width - Width) div 2;
  Top := FormMain.Top + (FormMain.Height - Height) div 2;
end;

// ---------------------------------------------------------------------------------------------------------------------

end.
