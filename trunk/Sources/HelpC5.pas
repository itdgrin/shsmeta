unit HelpC5;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, ComCtrls, StdCtrls, ExtCtrls,
  Grids, DBGrids;

type
  TFormHelpC5 = class(TForm)
    PanelMenu: TPanel;
    PanelMenu1: TPanel;
    LabelObject: TLabel;
    Label1: TLabel;
    EditObject: TEdit;
    DateTimePicker1: TDateTimePicker;
    PanelMenu2: TPanel;
    Label2: TLabel;
    Edit1: TEdit;
    PanelMenu3: TPanel;
    Label3: TLabel;
    Edit2: TEdit;
    PanelMenu4: TPanel;
    Label4: TLabel;
    Edit3: TEdit;
    PanelMenu5: TPanel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    DateTimePicker2: TDateTimePicker;
    DateTimePicker3: TDateTimePicker;
    PanelMenu6: TPanel;
    Label8: TLabel;
    PanelMenu7: TPanel;
    Label9: TLabel;
    Label10: TLabel;
    Edit4: TEdit;
    Edit5: TEdit;
    PanelBottom: TPanel;
    PanelBottomButtons: TPanel;
    Panel1: TPanel;
    Label11: TLabel;
    Edit6: TEdit;
    DBGrid1: TDBGrid;

    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private

  public

  end;

const
  // �������� ������ ��� ����� ����
  CaptionButton = '������� �-5';

  // ��������� ��� ��������� �� ������ ��� ����� ����
  HintButton = '���� ������� �-5';

var
  FormHelpC5: TFormHelpC5;

implementation

uses Main;

{$R *.dfm}
// ---------------------------------------------------------------------------------------------------------------------

procedure TFormHelpC5.FormCreate(Sender: TObject);
begin
  // ��������� �������� � ��������� �����
  ClientWidth := FormMain.ClientWidth div 2;
  ClientHeight := FormMain.ClientHeight div 2;
  Top := 20;
  Left := 20;

  WindowState := wsMaximized;

  // -----------------------------------------

  // ������ ������ �� ����� ���� (�� ������� ����� �����)
  FormMain.CreateButtonOpenWindow(CaptionButton, HintButton, FormMain.ShowHelpC5);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormHelpC5.FormActivate(Sender: TObject);
begin
  // ���� ������ ������� Ctrl � �������� �����, �� ������
  // �������������� � ��������� ���� ����� �� �������� ����
  FormMain.CascadeForActiveWindow;

  // ������ ������� ������ �������� ����� (�� ������� ����� �����)
  FormMain.SelectButtonActiveWindow(CaptionButton);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormHelpC5.FormShow(Sender: TObject);
begin
  // ������������� �����
  EditObject.SetFocus;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormHelpC5.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormHelpC5.FormDestroy(Sender: TObject);
begin
  FormHelpC5 := nil;

  // ������� ������ �� ����� ���� (�� ������� ����� �����)
  FormMain.DeleteButtonCloseWindow(CaptionButton);
end;

// ---------------------------------------------------------------------------------------------------------------------

end.
