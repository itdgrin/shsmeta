unit CoefficientOrders;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TFormCoefficientOrders = class(TForm)
    CheckBoxAll: TCheckBox;
    CheckBoxNone: TCheckBox;
    CheckBoxInThis: TCheckBox;
    RadioGroupCoefOrders: TRadioGroup;
    ButtonSave: TButton;
    ButtonClose: TButton;
    Bevel: TBevel;
    ADOQueryTemp: TFDQuery;

    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);

    procedure ShowForm(const vIdEstimate, vIdRate, vNumRow: Integer);
    procedure GetFlagCoefficientOrders; // Получаем флаг (применять/ не применять) коэффициента по приказам
    procedure SetFlagCoefficientOrders; // Устанавливаем флаг (применять/ не применять) коэффициента по приказам

    procedure ButtonSaveClick(Sender: TObject);
    procedure ButtonCloseClick(Sender: TObject);

  private
    FormCaption: PWideChar;
    ConfirmationClose: Boolean;

    IdEstimate: Integer;
    IdRate: Integer;
    NumRow: Integer;
  end;

var
  FormCoefficientOrders: TFormCoefficientOrders;

implementation

uses Main, DataModule;

{$R *.dfm}
// ---------------------------------------------------------------------------------------------------------------------s

procedure TFormCoefficientOrders.FormCreate(Sender: TObject);
begin
  FormCaption := FormNameCoefficientOrders;
  Caption := FormCaption;
end;

// ---------------------------------------------------------------------------------------------------------------------s

procedure TFormCoefficientOrders.FormShow(Sender: TObject);
begin
  Left := FormMain.Left + (FormMain.Width - Width) div 2;
  Top := FormMain.Top + (FormMain.Height - Height) div 2;

  ConfirmationClose := False;

  GetFlagCoefficientOrders;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCoefficientOrders.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if ConfirmationClose then
    if MessageBox(0, PChar('Выйти без сохранения сделанных изменений?'), FormCaption,
      MB_ICONINFORMATION + MB_YESNO + mb_TaskModal) = mrNo then
      CanClose := False;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCoefficientOrders.ShowForm(const vIdEstimate, vIdRate, vNumRow: Integer);
begin
  IdEstimate := vIdEstimate;
  IdRate := vIdRate;
  NumRow := vNumRow;

  ShowModal;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCoefficientOrders.GetFlagCoefficientOrders;
begin
  // Получаем флаг (применять/не применять) коэффициента по приказам
  try
    with ADOQueryTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT coef_orders FROM carddataestimate_temp WHERE sm_id = :sm_id and num_row = :num_row and ' +
        'data_id = :data_id;');
      ParamByName('sm_id').Value := IdEstimate;
      ParamByName('num_row').Value := NumRow;
      ParamByName('data_id').Value := IdRate;
      Active := True;

      RadioGroupCoefOrders.ItemIndex := 1 - FieldByName('coef_orders').AsInteger;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('При получении флага коэффициента по приказам возникла ошибка:' + sLineBreak + sLineBreak +
        E.Message), FormCaption, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCoefficientOrders.SetFlagCoefficientOrders;
begin
  // Устанавливаем флаг (применять/ не применять) коэффициента по приказам
  try
    with ADOQueryTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('UPDATE carddataestimate_temp SET coef_orders = :coef_orders WHERE sm_id = :sm_id and ' +
        'num_row = :num_row and data_id = :data_id;');
      ParamByName('sm_id').Value := IdEstimate;
      ParamByName('num_row').Value := NumRow;
      ParamByName('data_id').Value := IdRate;

      ParamByName('coef_orders').Value := 1 - RadioGroupCoefOrders.ItemIndex;

      ExecSQL;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('При установке флага коэффициента по приказам возникла ошибка:' + sLineBreak + sLineBreak +
        E.Message), FormCaption, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCoefficientOrders.ButtonSaveClick(Sender: TObject);
begin
  SetFlagCoefficientOrders;
  ConfirmationClose := False;
  Close;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCoefficientOrders.ButtonCloseClick(Sender: TObject);
begin
  Close;
end;

// ---------------------------------------------------------------------------------------------------------------------

end.
