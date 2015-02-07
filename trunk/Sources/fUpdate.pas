unit fUpdate;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.StdCtrls, UpdateModule, Vcl.ComCtrls, IdAntiFreezeBase, Vcl.IdAntiFreeze,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP;

type
  TUpdateForm = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    Image1: TImage;
    btnUpdate: TButton;
    btnCancel: TButton;
    btnOk: TButton;
    Panel4: TPanel;
    Label2: TLabel;
    Panel3: TPanel;
    ProgressBar1: TProgressBar;
    Memo1: TMemo;
    Label3: TLabel;
    Label4: TLabel;
    IdHTTP1: TIdHTTP;
    IdAntiFreeze1: TIdAntiFreeze;
    procedure btnCancelClick(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure IdHTTP1WorkBegin(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCountMax: Int64);
    procedure IdHTTP1WorkEnd(ASender: TObject; AWorkMode: TWorkMode);
    procedure IdHTTP1Work(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCount: Int64);
  private
    FCurVersion: TVersion; //Текущая версия приложения
    FSR: TServiceResponse;
    procedure SetButtonStyle;
    { Private declarations }
  public
    //Устанавливает версии но не изменяет внешний вид
    procedure SetVersion(const AVersion: TVersion; const AServiceResponse: TServiceResponse);
    { Public declarations }
  end;

var UpdateForm : TUpdateForm;

implementation

{$R *.dfm}

procedure TUpdateForm.SetVersion(const AVersion: TVersion;
  const AServiceResponse: TServiceResponse);
begin
  FSR.Assign(AServiceResponse);
  FCurVersion.App := AVersion.App;
  FCurVersion.Catalog := AVersion.Catalog;
  FCurVersion.User := AVersion.User;
end;

//Устанавливает внешний вид окна обновления
procedure TUpdateForm.SetButtonStyle;
var Style : integer;
begin
  //Текущая версия
  label2.Caption := 'Текущая версия программы: ' + IntToStr(FCurVersion.App);
  label3.Caption := 'справочников: ' + IntToStr(FCurVersion.Catalog);
  label4.Caption := 'пользовательских таблиц: ' + IntToStr(FCurVersion.User);

  //Вид нижних кнопочек
  case FSR.UpdeteStatys of
    1:  //Обновления есть
    begin
      btnUpdate.Visible := true;
      btnCancel.Visible := true;
      btnOk.Visible := false;
      btnCancel.Left := Panel1.Width - btnCancel.Width - 8;
      btnUpdate.Left := btnCancel.Left - btnUpdate.Width - 8;
    end;
    else //Обновлений нет
    begin
      btnUpdate.Visible := false;
      btnCancel.Visible := false;
      btnOk.Visible := true;
      btnOk.Left := Panel1.Width - btnOk.Width - 8;
    end;
  end;

  memo1.Lines.Clear;
  //Текстовка в мемо
  case FSR.UpdeteStatys of
    1:  //Обновления есть
    begin
      Memo1.Lines.Add('Доступны новые обновления на сервере:');

      if FCurVersion.App < FSR.AppVersion then
        Memo1.Lines.Add('верся приложения :' + IntToStr(FSR.AppVersion));

      if FCurVersion.Catalog < FSR.CatalogVersion then
        Memo1.Lines.Add('верся справочников :' +
          IntToStr(FSR.CatalogVersion));

      if FCurVersion.User < FSR.UserVersion then
        Memo1.Lines.Add('верся пользовательских таблиц :' +
          IntToStr(FSR.UserVersion));
    end;
    else //Обновлений нет
    begin
      Memo1.Lines.Add('На сервере новых обновлений нет.');
    end;
  end;

end;

procedure TUpdateForm.btnOkClick(Sender: TObject);
begin
  close;
end;

procedure TUpdateForm.btnCancelClick(Sender: TObject);
begin
  close;
end;

procedure TUpdateForm.btnUpdateClick(Sender: TObject);
begin
  close;
end;

procedure TUpdateForm.FormCreate(Sender: TObject);
begin
  FCurVersion.App := 0;
  FCurVersion.Catalog := 0;
  FCurVersion.User := 0;
  FSR := TServiceResponse.Create;
end;

procedure TUpdateForm.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FSR);
end;

procedure TUpdateForm.FormShow(Sender: TObject);
begin
  SetButtonStyle;
end;

procedure TUpdateForm.IdHTTP1Work(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCount: Int64);
begin
  if AWorkMode = wmRead then
    ProgressBar1.Position := AWorkCount div 100;

end;

procedure TUpdateForm.IdHTTP1WorkBegin(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCountMax: Int64);
begin
  if AWorkMode = wmRead then
  begin
    Panel3.Visible := True;
    ProgressBar1.Position := 0;
    ProgressBar1.Max := AWorkCountMax div 100;
  end;
end;

procedure TUpdateForm.IdHTTP1WorkEnd(ASender: TObject; AWorkMode: TWorkMode);
begin
  Panel3.Visible := False;
  ProgressBar1.Position := 0;
end;

end.
