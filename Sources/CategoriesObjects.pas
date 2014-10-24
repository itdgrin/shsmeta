unit CategoriesObjects;

interface

uses
  Classes, Controls, Forms, ExtCtrls, SysUtils;

type
  TFormCategoriesObjects = class(TForm)
    Panel: TPanel;

    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  end;

var
  FormCategoriesObjects: TFormCategoriesObjects;

implementation

uses Main, fCategoriesObjects;

var
  FrameÑategoriesObjects: TFrameCategoriesObjects;

{$R *.dfm}
  // ---------------------------------------------------------------------------------------------------------------------

procedure TFormCategoriesObjects.FormCreate(Sender: TObject);
begin
  // Íàñòðîéêà ðàçìåðîâ è ïîëîæåíèÿ ôîðìû

  ClientWidth := FormMain.ClientWidth div 2;
  ClientHeight := FormMain.ClientHeight div 2;

  Left := FormMain.Left + (FormMain.Width - Width) div 2;
  Top := FormMain.Top + (FormMain.Height - Height) div 2;

  // -----------------------------------------

  Caption := FormNameCategoriesObjects;

  Panel.Align := alClient;
end;

procedure TFormCategoriesObjects.FormShow(Sender: TObject);
begin
  FrameÑategoriesObjects := TFrameCategoriesObjects.Create(Self);
  with FrameÑategoriesObjects do
  begin
    Parent := Panel;
    Align := alClient;
    Visible := True;
  end;

  FrameÑategoriesObjects.TableFilling;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCategoriesObjects.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(FrameÑategoriesObjects);
end;

// ---------------------------------------------------------------------------------------------------------------------

end.
