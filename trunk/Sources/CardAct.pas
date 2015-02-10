unit CardAct;

interface

uses Windows, SysUtils, Classes, Controls, Forms, StdCtrls, ExtCtrls, DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Mask,
  JvExMask, JvToolEdit, JvDBControls, Vcl.DBCtrls;

type
  TKindForm = (kdInsert, kdEdit);

  TfCardAct = class(TForm)
    PanelDate: TPanel;
    PanelName: TPanel;
    PanelDescription: TPanel;
    LabelDate: TLabel;
    LabelName: TLabel;
    LabelDescription: TLabel;
    ButtonSave: TButton;
    ButtonClose: TButton;
    Bevel: TBevel;
    qrTemp: TFDQuery;
    edDate: TJvDBDateEdit;
    qrAct: TFDQuery;
    dsAct: TDataSource;
    dbmmoDESCRIPTION: TDBMemo;
    dbedtNAME: TDBEdit;
    procedure FormShow(Sender: TObject);
    procedure ButtonCloseClick(Sender: TObject);
    procedure ButtonSaveClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  public
    Kind: TKindForm;
    id: Integer;
  end;

implementation

uses Main, DataModule, CalculationEstimate, Tools;

{$R *.dfm}

procedure TfCardAct.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfCardAct.FormShow(Sender: TObject);
var
  cnt: Integer;
begin
  Left := FormMain.Left + (FormMain.Width - Width) div 2;
  Top := FormMain.Top + (FormMain.Height - Height) div 2;
  case Kind of
    kdInsert:
      begin
        if (GetKeyState(VK_CAPITAL) and $01) <> 0 then // Если нажат CapsLock
        begin
          keybd_event(VK_CAPITAL, 0, 0, 0);
          keybd_event(VK_CAPITAL, 0, KEYEVENTF_KEYUP, 0);
        end;
        CloseOpen(qrAct);
        qrTemp.Active := False;
        qrTemp.SQL.Text :=
          'SELECT COUNT(*) AS CNT from card_acts WHERE id_estimate_object=:id_estimate_object;';
        qrTemp.ParamByName('id_estimate_object').Value := FormCalculationEstimate.GetIdEstimate;
        qrTemp.Active := True;
        cnt := qrTemp.FieldByName('CNT').AsInteger + 1;
        qrTemp.Active := False;

        edDate.Date := Now();
        dbedtNAME.Text := 'Акт№' + IntToStr(cnt) + 'от' + DateToStr(Now) + 'для' +
          FormCalculationEstimate.EditNameObject.Text;

        dbmmoDESCRIPTION.Text := dbedtNAME.Text;
        dbedtNAME.SetFocus;
      end;
    kdEdit:
      begin
        qrAct.ParamByName('id').AsInteger := id;
        CloseOpen(qrAct);
      end;
  end;
end;

procedure TfCardAct.ButtonCloseClick(Sender: TObject);
begin
  case Kind of
    kdInsert:
      begin
        if MessageBox(0, PChar('Если сейчас выйти, акт не будет сохранён.' + sLineBreak +
          'Выйти без сохранения акта?'), PWideChar(Caption), MB_ICONWARNING + MB_YESNO + mb_TaskModal) = mryes
        then
        begin
          FormCalculationEstimate.ConfirmCloseForm := False;
          FormCalculationEstimate.Close;
          Close;
        end;
      end;
    kdEdit:
      begin
        Close;
      end;
  end;
end;

procedure TfCardAct.ButtonSaveClick(Sender: TObject);
begin
  case Kind of
    kdInsert:
      begin
        try
          with qrTemp do
          begin
            Active := False;
            SQL.Clear;
            SQL.Add('INSERT INTO card_acts (id_estimate_object, name, description, date) ' +
              'VALUE (:id_estimate_object, :name, :description, :date);');
            ParamByName('id_estimate_object').Value := FormCalculationEstimate.GetIdEstimate;
            ParamByName('name').Value := dbedtNAME.Text;
            ParamByName('description').Value := dbmmoDESCRIPTION.Text;
            ParamByName('date').AsDate := edDate.Date;
            ExecSQL;
            SQL.Clear;
            SQL.Add('CALL SaveDataAct((SELECT last_insert_id()));');
            ExecSQL;
          end;
          FormCalculationEstimate.ConfirmCloseForm := False;
          FormCalculationEstimate.Close;
          Close;
        except
          on E: Exception do
            MessageBox(0, PChar('При создании нового акта возникла ошибка:' + sLineBreak + sLineBreak +
              E.Message), PWideChar(Caption), MB_ICONERROR + MB_OK + mb_TaskModal);
        end;
      end;
    kdEdit:
      begin
        if qrAct.State in [dsEdit] then
          qrAct.Post;
        Close;
      end;
  end;
end;

end.
