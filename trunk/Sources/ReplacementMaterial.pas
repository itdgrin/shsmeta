unit ReplacementMaterial;

interface

uses
  Windows, SysUtils, Classes, Controls, Forms, StdCtrls, ExtCtrls, DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFormReplacementMaterial = class(TForm)
    LabelCode: TLabel;
    EditCode: TEdit;
    Bevel1: TBevel;
    ButtonReplacement: TButton;
    ButtonCancel: TButton;
    ADOQuery: TFDQuery;

    procedure FormShow(Sender: TObject);
    procedure ButtonCancelClick(Sender: TObject);
    procedure ButtonReplacementClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EditCodeEnter(Sender: TObject);
    procedure SetDataBase(const vDataBase: Char);

  private
    DataBase: Char;

  end;

implementation

uses Main, DataModule, CalculationEstimate;

{$R *.dfm}
// ---------------------------------------------------------------------------------------------------------------------

procedure TFormReplacementMaterial.ButtonCancelClick(Sender: TObject);
begin
  Close;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormReplacementMaterial.ButtonReplacementClick(Sender: TObject);
begin
  try
    with ADOQuery do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT material_id FROM material WHERE mat_code = :mat_code;');
      ParamByName('mat_code').Value := EditCode.Text;
      Active := True;

      if RecordCount = 0 then
      begin
        MessageBox(0, PChar('Введёный Вами материал не найден.'), FormNameReplacementMaterial,
          MB_ICONINFORMATION + MB_OK + mb_TaskModal);
        Exit;
      end;

      FormCalculationEstimate.ReplacementMaterial(FieldByName('material_id').AsInteger);
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('При сохранении всех данных сметы возникла ошибка:' + sLineBreak + sLineBreak + E.Message),
        FormNameReplacementMaterial, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;

  Close;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormReplacementMaterial.EditCodeEnter(Sender: TObject);
begin
  LoadKeyboardLayout('00000419', KLF_ACTIVATE); // Русский
  // LoadKeyboardLayout('00000409', KLF_ACTIVATE); // Английский
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormReplacementMaterial.FormCreate(Sender: TObject);
begin
  Caption := FormNameReplacementMaterial;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormReplacementMaterial.FormShow(Sender: TObject);
begin
  Left := FormMain.Left + (FormMain.Width - Width) div 2;
  Top := FormMain.Top + (FormMain.Height - Height) div 2;

  EditCode.Text := '';
  EditCode.SetFocus;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormReplacementMaterial.SetDataBase(const vDataBase: Char);
begin
  DataBase := vDataBase;
end;

// ---------------------------------------------------------------------------------------------------------------------

end.
