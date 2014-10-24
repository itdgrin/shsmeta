unit CardCategoriesObjects;

interface

uses
  Windows, SysUtils, Classes, Controls, Forms, StdCtrls, ExtCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFormCardCategoriesObjects = class(TForm)

    PanelName: TPanel;
    LabelName: TLabel;
    EditName: TEdit;

    Bevel: TBevel;
    ButtonSave: TButton;
    ButtonClose: TButton;

    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);

    procedure ShowForm(const vIdEdit: Integer; const vADOQuery: TFDQuery);

    procedure ButtonSaveClick(Sender: TObject);
    procedure ButtonCloseClick(Sender: TObject);

  private
    ADOQuery: TFDQuery;
    ConfirmationClose: Boolean;
    IdEdit: Integer; // Id редактируемой записи, если Id = -1, то идЄт добавление записи.
  end;

var
  FormCardCategoriesObjects: TFormCardCategoriesObjects;

implementation

uses Main;

const
  FormCaption = FormNameCardCategoriesObjects;

{$R *.dfm}
  // ---------------------------------------------------------------------------------------------------------------------

procedure TFormCardCategoriesObjects.FormCreate(Sender: TObject);
begin
  Caption := FormCaption;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCardCategoriesObjects.FormShow(Sender: TObject);
begin
  Left := FormMain.Left + (FormMain.Width - Width) div 2;
  Top := FormMain.Top + (FormMain.Height - Height) div 2;

  ConfirmationClose := True;

  // ----------------------------------------

  EditName.Text := '';

  EditName.SetFocus;

  if IdEdit = -1 then
    Exit;

  try
    with ADOQuery do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT * FROM objcategory WHERE cat_id = :cat_id;');
      ParamByName('cat_id').Value := IdEdit;
      Active := True;

      EditName.Text := FieldByName('cat_name').AsString;

      Active := False;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('ѕри получении данных редактируемой записи возникла ошибка:' + sLineBreak +
        sLineBreak + E.Message), FormCaption, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCardCategoriesObjects.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if ConfirmationClose then
    if MessageBox(0, PChar('«акрыть без сохранени€ сделанных изменений?'), FormCaption,
      MB_ICONINFORMATION + MB_YESNO + mb_TaskModal) = mrNo then
      CanClose := False;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCardCategoriesObjects.ShowForm(const vIdEdit: Integer; const vADOQuery: TFDQuery);
begin
  IdEdit := vIdEdit;
  ADOQuery := vADOQuery;

  ShowModal;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCardCategoriesObjects.ButtonSaveClick(Sender: TObject);
var
  Count: Integer;
begin
  Count := 0;

  if EditName.Text = '' then
    Inc(Count);

  if Count > 0 then
  begin
    MessageBox(0, PChar('ќдно или более полей не были заполнены!'), FormCaption,
      MB_ICONWARNING + MB_OK + mb_TaskModal);
    Exit;
  end;

  with ADOQuery do
  begin
    Active := False;
    SQL.Clear;

    if IdEdit = -1 then
      SQL.Add('INSERT INTO objcategory (cat_name) VALUE(:cat_name);')
    else
      SQL.Add('UPDATE objcategory SET cat_name = :cat_name WHERE cat_id = :cat_id;');

    ParamByName('cat_name').Value := EditName.Text;

    if IdEdit > -1 then
      ParamByName('cat_id').Value := IdEdit;

    ExecSQL;
    Active := False;
  end;

  ConfirmationClose := False;
  Close;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCardCategoriesObjects.ButtonCloseClick(Sender: TObject);
begin
  Close;
end;

// ---------------------------------------------------------------------------------------------------------------------

end.
