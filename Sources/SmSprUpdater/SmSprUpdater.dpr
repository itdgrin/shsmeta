program SmSprUpdater;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {MainForm},
  DataModule in '..\DataModule.pas' {DM: TDataModule},
  GlobsAndConst in '..\GlobsAndConst.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
