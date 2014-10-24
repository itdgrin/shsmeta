unit SelectObject;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids;

type
  TFormSelectObject = class(TForm)
    DBGrid1: TDBGrid;
    Button1: TButton;
    Button2: TButton;
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormSelectObject: TFormSelectObject;

implementation

{$R *.dfm}

procedure TFormSelectObject.Button2Click(Sender: TObject);
begin
  Close;
end;

end.
