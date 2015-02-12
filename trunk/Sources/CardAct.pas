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
    procedure FormCreate(Sender: TObject);
    procedure edDateChange(Sender: TObject);
    procedure dbedtNAMEChange(Sender: TObject);
  private
    cnt: Integer;
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

procedure TfCardAct.FormCreate(Sender: TObject);
begin
  Left := FormMain.Left + (FormMain.Width - Width) div 2;
  Top := FormMain.Top + (FormMain.Height - Height) div 2;
end;

procedure TfCardAct.FormShow(Sender: TObject);
begin
  case Kind of
    kdInsert:
      begin
        qrAct.ParamByName('id').AsInteger := 0;
        CloseOpen(qrAct);
        qrTemp.Active := False;
        qrTemp.SQL.Text :=
          'SELECT COUNT(*) AS CNT from card_acts WHERE id_estimate_object=:id_estimate_object;';
        qrTemp.ParamByName('id_estimate_object').Value := FormCalculationEstimate.GetIdEstimate;
        qrTemp.Active := True;
        cnt := qrTemp.FieldByName('CNT').AsInteger + 1;
        qrTemp.Active := False;

        qrAct.Insert;
        qrAct.FieldByName('DATE').AsDateTime := Now();
        qrAct.FieldByName('NAME').AsString := 'Акт№' + IntToStr(cnt) + 'от' + qrAct.FieldByName('DATE')
          .AsString + 'для' + FormCalculationEstimate.EditNameObject.Text;
        qrAct.FieldByName('DESCRIPTION').AsString := dbedtNAME.Text;
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
          if qrAct.State in [dsEdit, dsInsert] then
            qrAct.Cancel;
          FormCalculationEstimate.ConfirmCloseForm := False;
          FormCalculationEstimate.Close;
          Close;
        end;
      end;
    kdEdit:
      begin
        if qrAct.State in [dsEdit, dsInsert] then
          qrAct.Cancel;
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
            if qrAct.State in [dsInsert] then
              qrAct.Cancel;
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

procedure TfCardAct.dbedtNAMEChange(Sender: TObject);
begin
  if not CheckQrActiveEmpty(qrAct) or (Kind <> kdInsert) then
    Exit;
  qrAct.FieldByName('DESCRIPTION').AsString := dbedtNAME.Text;
end;

procedure TfCardAct.edDateChange(Sender: TObject);
begin
  if not CheckQrActiveEmpty(qrAct) or (Kind <> kdInsert) then
    Exit;
  qrAct.FieldByName('NAME').AsString := 'Акт№' + IntToStr(cnt) + 'от' + qrAct.FieldByName('DATE').AsString +
    'для' + FormCalculationEstimate.EditNameObject.Text;
end;

end.
