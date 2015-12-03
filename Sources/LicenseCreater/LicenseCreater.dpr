program LicenseCreater;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {MainForm},
  SerialKeyModule in '..\SerialKeyModule.pas',
  RC6 in '..\RC6.pas',
  hwid_impl in '..\hwid_impl.pas',
  winioctl in '..\winioctl.pas',
  GlobsAndConst in '..\GlobsAndConst.pas',
  uMemoryLoader in '..\uMemoryLoader.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
