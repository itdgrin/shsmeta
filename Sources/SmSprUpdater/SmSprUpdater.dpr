program SmSprUpdater;

uses
  Vcl.Forms,
  DataModule in '..\DataModule.pas' {DM: TDataModule},
  uMain in 'uMain.pas' {MainForm},
  GlobsAndConst in '..\GlobsAndConst.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
