unit fUpdate;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.StdCtrls, UpdateModule;

type
  TUpdateForm = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Label1: TLabel;
    Image1: TImage;
    btnUpdate: TButton;
    btnCancel: TButton;
    btnOk: TButton;
    Label6: TLabel;
    lbNewAppVersion: TLabel;
    lbNewDBVersion: TLabel;
    Label9: TLabel;
    Panel4: TPanel;
    Label2: TLabel;
    Label4: TLabel;
    lbAppVersion: TLabel;
    lbDBVersion: TLabel;
    ProcMemo: TMemo;
    procedure btnCancelClick(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    fVersion: TVersion; //������� ������ ����������
    fSR: TServiceResponse;
    fNoUpdate: boolean; //����� ������������ ����������
    fInUpdateProc: boolean; //���������� � ��������
    procedure SetButtonStyle;
    { Private declarations }
  public
    //������������� ������ �� �� �������� ������� ���
    procedure SetVersion(AVersion: TVersion; AServiceResponse: TServiceResponse);
    property NoUpdate : boolean read fNoUpdate;
    { Public declarations }
  end;

var UpdateForm : TUpdateForm;

implementation

{$R *.dfm}

procedure TUpdateForm.SetVersion(AVersion: TVersion; AServiceResponse: TServiceResponse);
begin
  {if Assigned(fSR) then fSR.Free;
  fVersion := AVersion;
  fSR := AServiceResponse;   }
end;

//������������� ������� ��� ���� ����������
procedure TUpdateForm.SetButtonStyle;
var Style : integer;
begin
  {if fInUpdateProc then exit;

  if Self.Tag  = 0 then //������� ��� ��� �����������
  begin
    ProcMemo.Visible := false;

    Label6.Caption := '�������� ����� ������ ���������:';
    Label9.Caption := '�������� ����� ������ ���� ������:';
    //lbAppVersion.Caption := IntToStr(fVersion.App);
    lbDBVersion.Caption := IntToStr(fVersion.RefDB);

    if not Assigned(fSR) then
    begin
      Label6.Caption := '������ � ����������� ����������.';
      lbNewAppVersion.Visible := False;
      lbNewDBVersion.Visible := False;
      Label9.Visible := False;
      Style := 1;
    end
    else
    begin
      //lbNewAppVersion.Caption := IntToStr(fSR.UpVersion.App);
      lbNewDBVersion.Caption := IntToStr(fSR.UpVersion.RefDB);

      lbNewAppVersion.Visible := True;
      Label6.Visible := True;
      lbNewDBVersion.Visible := True;
      Label9.Visible := True;

      {if (fVersion.DB < fSR.UpVersion.DB) or (fVersion.App < fSR.UpVersion.App) then
      begin //���� ����������
        if not(fVersion.App < fSR.UpVersion.App) then
        begin
          lbNewAppVersion.Visible := False;
          Label6.Visible := False;
        end;
        if (fVersion.App < fSR.UpVersion.App) then
        begin
          if not Label6.Visible then
          begin
            lbNewDBVersion.Top := Label6.top;
            Label9.Top := Label6.top;
          end;
        end
        else
        begin
          lbNewDBVersion.Visible := False;
          Label9.Visible := False;
        end;
        Style := 0;
      end
      else
      begin //���������� ���
        Label6.Caption := '��������� ���������� ���. � ��� ��������� ������.';
        lbNewAppVersion.Visible := False;
        lbNewDBVersion.Visible := False;
        Label9.Visible := False;
        Style := 1;
      end; }
   { end;
    case Style of
        0:
        begin
          btnUpdate.Visible := true;
          btnCancel.Visible := true;
          btnOk.Visible := false;
          btnCancel.Left := Panel1.Width - btnCancel.Width - 8;
          btnUpdate.Left := btnCancel.Left - btnUpdate.Width - 8;
        end;
        else
        begin
          btnUpdate.Visible := false;
          btnCancel.Visible := false;
          btnOk.Visible := true;
          btnOk.Left := Panel1.Width - btnOk.Width - 8;
        end;
      end;
  end
  else //������� ��� �������� ����������
  begin

  end;}

end;

procedure TUpdateForm.btnOkClick(Sender: TObject);
begin
  close;
end;

procedure TUpdateForm.btnCancelClick(Sender: TObject);
begin
  fNoUpdate := true;
  close;
end;

procedure TUpdateForm.btnUpdateClick(Sender: TObject);
begin
  fInUpdateProc := true;
  close;
end;

procedure TUpdateForm.FormCreate(Sender: TObject);
begin
{  fVersion.RefDB := 0;
  fSR := nil;
  fInUpdateProc := false;   }
end;

procedure TUpdateForm.FormDestroy(Sender: TObject);
begin
  {if Assigned(fSR) then fSR.Free;   }
end;

procedure TUpdateForm.FormShow(Sender: TObject);
begin
  {SetButtonStyle;  }
end;

end.
