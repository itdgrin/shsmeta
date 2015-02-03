unit ActC6;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, ExtCtrls, ComCtrls, StdCtrls,
  Grids, DBGrids;

type
  TSplitter = class(ExtCtrls.TSplitter)
  public
    procedure Paint(); override;
  end;

type
  TFormActC6 = class(TForm)
    ImageSplitterBottom: TImage;
    ImageSplitterTop: TImage;
    PanelMenu: TPanel;
    PanelBottom: TPanel;
    SplitterBottom: TSplitter;
    PanelTop: TPanel;
    PanelMenu1: TPanel;
    EditObject: TEdit;
    LabelPeriod: TLabel;
    DateTimePicker1: TDateTimePicker;
    PanelMenu2: TPanel;
    CheckBoxAddionalData: TCheckBox;
    LabelObject: TLabel;
    DBGrid1: TDBGrid;
    PanelBottomButtons: TPanel;
    DBGrid2: TDBGrid;
    PanelMenu8: TPanel;
    PanelMenu7: TPanel;
    PanelMenu6: TPanel;
    PanelMenu5: TPanel;
    PanelMenu4: TPanel;
    PanelMenu3: TPanel;
    Label1: TLabel;
    Edit1: TEdit;
    Label3: TLabel;
    Edit2: TEdit;
    Label4: TLabel;
    Edit3: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    DateTimePicker2: TDateTimePicker;
    Label7: TLabel;
    DateTimePicker3: TDateTimePicker;
    Label8: TLabel;
    Label9: TLabel;
    Edit4: TEdit;
    Label10: TLabel;
    Edit5: TEdit;

    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure RepaintImagesForSplitters();
    procedure CheckBoxAddionalDataClick(Sender: TObject);

  private

  public

  end;

const
  // �������� ������ ��� ����� ����
  CaptionButton = '��� �-6';

  // ��������� ��� ��������� �� ������ ��� ����� ����
  HintButton = '���� ��� �-6';

var
  FormActC6: TFormActC6;

implementation

uses Main, DataModule;

{$R *.dfm}
// ---------------------------------------------------------------------------------------------------------------------

{ TSplitter }
procedure TSplitter.Paint();
begin
  // inherited;
  FormActC6.RepaintImagesForSplitters();
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormActC6.FormCreate(Sender: TObject);
begin
  // ��������� �������� � ��������� �����
  ClientWidth := FormMain.ClientWidth div 2;
  ClientHeight := FormMain.ClientHeight div 2;
  Top := 20;
  Left := 20;

  WindowState := wsMaximized;

  // -----------------------------------------

  // ��������� ����������� ��� ����������
  with DM.ImageListHorozontalDots do
  begin
    GetIcon(0, ImageSplitterBottom.Picture.Icon);
  end;

  CheckBoxAddionalDataClick(nil);

  PanelBottom.Constraints.MinHeight := 150;

  // -----------------------------------------

  // ������ ������ �� ����� ���� (�� ������� ����� �����)
  FormMain.CreateButtonOpenWindow(CaptionButton, HintButton, FormMain.ShowActC6);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormActC6.FormActivate(Sender: TObject);
begin
  // ���� ������ ������� Ctrl � �������� �����, �� ������
  // �������������� � ��������� ���� ����� �� �������� ����
  FormMain.CascadeForActiveWindow;

  // ������ ������� ������ �������� ����� (�� ������� ����� �����)
  FormMain.SelectButtonActiveWindow(CaptionButton);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormActC6.FormShow(Sender: TObject);
begin
  // ������������� �����
  EditObject.SetFocus;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormActC6.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormActC6.FormDestroy(Sender: TObject);
begin
  FormActC6 := nil;

  // ������� ������ �� ����� ���� (�� ������� ����� �����)
  FormMain.DeleteButtonCloseWindow(CaptionButton);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormActC6.RepaintImagesForSplitters();
begin
  ImageSplitterBottom.Top := SplitterBottom.Top;
  ImageSplitterBottom.Left := SplitterBottom.Left + (SplitterBottom.Width - ImageSplitterBottom.Width) div 2;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormActC6.CheckBoxAddionalDataClick(Sender: TObject);
begin
  if CheckBoxAddionalData.Checked = True then
    PanelMenu.Height := 200
  else
    PanelMenu.Height := 50;
end;

// ---------------------------------------------------------------------------------------------------------------------

end.
