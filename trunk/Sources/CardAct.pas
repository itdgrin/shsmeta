unit CardAct;

interface

uses Windows, SysUtils, Classes, Controls, Forms, StdCtrls, ExtCtrls, DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFormCardAct = class(TForm)

    PanelDate: TPanel;
    PanelName: TPanel;
    PanelDescription: TPanel;

    LabelDate: TLabel;
    LabelName: TLabel;
    LabelDescription: TLabel;

    EditDate: TEdit;
    EditName: TEdit;

    ButtonSave: TButton;
    ButtonClose: TButton;

    MemoDescription: TMemo;
    Bevel: TBevel;
    ADOQueryTemp: TFDQuery;

    procedure FormShow(Sender: TObject);
    procedure ButtonCloseClick(Sender: TObject);
    procedure ButtonSaveClick(Sender: TObject);

  end;

var
  FormCardAct: TFormCardAct;

implementation

uses Main, DataModule, CalculationEstimate;

{$R *.dfm}
// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCardAct.FormShow(Sender: TObject);
var
  cnt: integer;
begin
  if (GetKeyState(VK_CAPITAL) and $01) <> 0 then // Если нажат CapsLock
  begin
    keybd_event(VK_CAPITAL, 0, 0, 0);
    keybd_event(VK_CAPITAL, 0, KEYEVENTF_KEYUP, 0);
  end;

  // ----------------------------------------

  Left := FormMain.Left + (FormMain.Width - Width) div 2;
  Top := FormMain.Top + (FormMain.Height - Height) div 2;

  // ----------------------------------------

  ADOQueryTemp.Active := False;
  ADOQueryTemp.SQL.Text :=
    'SELECT COUNT(*) AS CNT from card_acts WHERE id_estimate_object=:id_estimate_object;';
  ADOQueryTemp.ParamByName('id_estimate_object').Value := FormCalculationEstimate.GetIdEstimate;
  ADOQueryTemp.Active := True;
  cnt := ADOQueryTemp.FieldByName('CNT').AsInteger + 1;
  ADOQueryTemp.Active := False;

  EditDate.Text := FormatDateTime('dd/mm/yyyy', Now());
  EditName.Text := 'Акт№' + IntToStr(cnt) + 'от' + DateToStr(Now) + 'для' +
    FormCalculationEstimate.EditNameObject.Text;

  MemoDescription.Text := EditName.Text;
  EditName.SetFocus;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCardAct.ButtonCloseClick(Sender: TObject);
begin
  if MessageBox(0, PChar('Если сейчас выйти, акт не будет сохранён.' + sLineBreak +
    'Выйти без сохранения акта?'), PWideChar(Caption), MB_ICONWARNING + MB_YESNO + mb_TaskModal) = mryes then
  begin
    FormCalculationEstimate.ConfirmCloseForm := False;
    FormCalculationEstimate.Close;
    Close;
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormCardAct.ButtonSaveClick(Sender: TObject);
begin
  try
    with ADOQueryTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('INSERT INTO card_acts (id_estimate_object, name, description, date) ' +
        'VALUE (:id_estimate_object, :name, :description, :date);');
      ParamByName('id_estimate_object').Value := FormCalculationEstimate.GetIdEstimate;
      ParamByName('name').Value := EditName.Text;
      ParamByName('description').Value := MemoDescription.Text;
      ParamByName('date').Value := FormatDateTime('yyyy/mm/dd tt', Now());
      ExecSQL;
      // ----------------------------------------
      {R
      SQL.Clear;
      SQL.Add('UPDATE data_act_temp SET id_act = (SELECT last_insert_id());');
      ExecSQL;
      }
      // ----------------------------------------
      SQL.Clear;
      SQL.Add('CALL SaveDataAct((SELECT last_insert_id()));');
      ExecSQL;
      // FormCalculationEstimate.UpdateTableDataEstimateTemp;
    end;
    FormCalculationEstimate.ConfirmCloseForm := False;
    FormCalculationEstimate.Close;
    Close;
  except
    on E: Exception do
      MessageBox(0, PChar('При создании нового акта возникла ошибка:' + sLineBreak + sLineBreak + E.Message),
        PWideChar(Caption), MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

end.
