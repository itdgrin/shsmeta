unit HelpC3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Grids, DBGrids,
  ComCtrls, ExtCtrls;

type
  TFormHelpC3 = class(TForm)
    PanelMenu: TPanel;
    PanelMenu1: TPanel;
    LabelObject: TLabel;
    EditObject: TEdit;
    Label1: TLabel;
    DateTimePicker1: TDateTimePicker;
    Panel1: TPanel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    Panel2: TPanel;
    DBGrid1: TDBGrid;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Button1: TButton;

    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);

  private
    const CaptionButton = '������� �-3';
    const HintButton = '���� ������� �-3';
  public

  end;

var
  FormHelpC3: TFormHelpC3;

implementation

uses Main, Requisites;

{$R *.dfm}
// ---------------------------------------------------------------------------------------------------------------------

procedure TFormHelpC3.FormCreate(Sender: TObject);
begin
  // ��������� �������� � ��������� �����
  ClientWidth := FormMain.ClientWidth div 2;
  ClientHeight := FormMain.ClientHeight div 2;
  Top := 20;
  Left := 20;

  WindowState := wsMaximized;

  // ������ ������ �� ����� ���� (�� ������� ����� �����)
  FormMain.CreateButtonOpenWindow(CaptionButton, HintButton, Self);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormHelpC3.FormActivate(Sender: TObject);
begin
  // ���� ������ ������� Ctrl � �������� �����, �� ������
  // �������������� � ��������� ���� ����� �� �������� ����
  FormMain.CascadeForActiveWindow;

  // ������ ������� ������ �������� ����� (�� ������� ����� �����)
  FormMain.SelectButtonActiveWindow(CaptionButton);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormHelpC3.FormShow(Sender: TObject);
begin
  // ������������� �����
  EditObject.SetFocus;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormHelpC3.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormHelpC3.FormDestroy(Sender: TObject);
begin
  FormHelpC3 := nil;

  // ������� ������ �� ����� ���� (�� ������� ����� �����)
  FormMain.DeleteButtonCloseWindow(CaptionButton);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormHelpC3.Button1Click(Sender: TObject);
begin
  FormRequisites.ShowModal;
end;

// ---------------------------------------------------------------------------------------------------------------------

end.
