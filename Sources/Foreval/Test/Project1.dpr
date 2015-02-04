program Project1;

uses
  Forms,
  TestG8 in 'TestG8.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
