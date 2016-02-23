program SmSprUpdater;

{$SETPEFlAGS $0001}

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {MainForm},
  DataModule in 'DataModule.pas' {DM: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TDM, DM);
  Application.Run;
end.
