unit TariffsSalary;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, ExtCtrls, Grids, DBGrids,
  StdCtrls, Buttons;

type
  TFormTariffsSalary = class(TForm)
    PanelLeft: TPanel;
    Splitter: TSplitter;
    PanelRight: TPanel;
    PanelBottom: TPanel;
    BitBtnFind: TBitBtn;
    BitBtnLoad: TBitBtn;
    PanelTop: TPanel;
    LabelData: TLabel;
    EditVAT: TEdit;
    EditMonth: TEdit;
    DBGrid2: TDBGrid;
    DBGrid1: TDBGrid;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  end;

  TFormSettings = Record
    Width: Integer;
    Height: Integer;
    Left: Integer;
    Top: Integer;
    WindowState: TWindowState;
    PanelLeftWidth: Integer;
  end;

const
  CaptionButton = 'Тар. по зарплате';

var
  FormTariffsSalary: TFormTariffsSalary;
  SettingsFormSave: Boolean = False;
  FS: TFormSettings;

implementation

uses Main;

{$R *.dfm}
// ---------------------------------------------------------------------------------------------------------------------

procedure TFormTariffsSalary.CreateParams(var Params: TCreateParams);
begin
  inherited;
  if SettingsFormSave = True then
  begin
    Params.Width := FS.Width;
    Params.Height := FS.Height;
    Params.X := FS.Left;
    Params.Y := FS.Top;
  end
  else
  begin
    Params.Width := FormMain.Width;
    Params.Height := FormMain.Height - 27;
    Params.X := -4;
    Params.Y := -30;
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormTariffsSalary.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FS.Width := Width;
  FS.Height := Height;
  FS.Top := Top;
  FS.Left := Left;
  FS.WindowState := WindowState;
  FS.PanelLeftWidth := PanelLeft.Width;

  SettingsFormSave := True;

  Action := caFree;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormTariffsSalary.FormActivate(Sender: TObject);
begin
  FormMain.CascadeForActiveWindow;

  // -----------------------------------------

  FormMain.SelectButtonActiveWindow(CaptionButton);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormTariffsSalary.FormCreate(Sender: TObject);
begin
  if SettingsFormSave = True then
  begin
    WindowState := FS.WindowState;
    PanelLeft.Width := FS.PanelLeftWidth;
  end;

  // -----------------------------------------

  FormMain.CreateButtonOpenWindow(CaptionButton, 'Окно тарифы по зарплате', FormMain.ShowTariffsSalary);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormTariffsSalary.FormDestroy(Sender: TObject);
begin
  FormTariffsSalary := nil;

  // -----------------------------------------

  FormMain.DeleteButtonCloseWindow(CaptionButton);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormTariffsSalary.FormShow(Sender: TObject);
begin
  if SettingsFormSave = False then
    PanelLeft.Width := (FormMain.ClientWidth - 6) div 2;
end;

// ---------------------------------------------------------------------------------------------------------------------

end.
