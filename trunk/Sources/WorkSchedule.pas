unit WorkSchedule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, ComCtrls,
  Grids, DBGrids;

type
  TFormWorkSchedule = class(TForm)
    PanelMenu: TPanel;
    PanelBottom: TPanel;
    PanelMenu1: TPanel;
    LabelObject: TLabel;
    EditObject: TEdit;
    PanelMenu2: TPanel;
    LabelDateBuilding: TLabel;
    LabelStart: TLabel;
    DateTimePickerStart: TDateTimePicker;
    LabelEnd: TLabel;
    DateTimePickerEnd: TDateTimePicker;
    Panel4: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel1: TPanel;
    Label1: TLabel;
    Edit2: TEdit;
    Label2: TLabel;
    Edit3: TEdit;
    Label3: TLabel;
    PanelBottomButtons: TPanel;
    Edit4: TEdit;
    Label4: TLabel;
    Edit5: TEdit;
    Label5: TLabel;
    Edit6: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    Edit7: TEdit;
    Label8: TLabel;
    Edit8: TEdit;
    Label9: TLabel;
    Edit9: TEdit;
    Label10: TLabel;
    Edit10: TEdit;
    Label11: TLabel;
    Edit11: TEdit;
    DBGrid1: TDBGrid;

    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private
    const CaptionButton = '������ ��������. �����';
    const HintButton = '���� ������� ������������ �����';
  public

  end;

var
  FormWorkSchedule: TFormWorkSchedule;

implementation

uses Main;

{$R *.dfm}
// ---------------------------------------------------------------------------------------------------------------------

procedure TFormWorkSchedule.FormCreate(Sender: TObject);
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

procedure TFormWorkSchedule.FormActivate(Sender: TObject);
begin
  // ���� ������ ������� Ctrl � �������� �����, �� ������
  // �������������� � ��������� ���� ����� �� �������� ����
  FormMain.CascadeForActiveWindow;

  // ������ ������� ������ �������� ����� (�� ������� ����� �����)
  FormMain.SelectButtonActiveWindow(CaptionButton);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormWorkSchedule.FormShow(Sender: TObject);
begin
  // ������������� �����
  EditObject.SetFocus;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormWorkSchedule.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormWorkSchedule.FormDestroy(Sender: TObject);
begin
  FormWorkSchedule := nil;

  // ������� ������ �� ����� ���� (�� ������� ����� �����)
  FormMain.DeleteButtonCloseWindow(CaptionButton);
end;

// ---------------------------------------------------------------------------------------------------------------------

end.
