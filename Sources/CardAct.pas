unit CardAct;

interface

uses Windows, SysUtils, Classes, Controls, Forms, StdCtrls, ExtCtrls, DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Mask,
  JvExMask, JvToolEdit, JvDBControls, Vcl.DBCtrls, Tools, Vcl.Buttons, System.Variants;

type
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
    pnl1: TPanel;
    lbl1: TLabel;
    dbedtNAME1: TDBEdit;
    btn1: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure ButtonCloseClick(Sender: TObject);
    procedure ButtonSaveClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure edDateChange(Sender: TObject);
    procedure dbedtNAMEChange(Sender: TObject);
    procedure btn1Click(Sender: TObject);
  private
    cnt: Integer;
  public
    Kind: TKindForm;
    id: Integer;
  end;

implementation

uses Main, DataModule, CalculationEstimate, GlobsAndConst, ForemanList;

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
        qrTemp.SQL.Text := 'SELECT COUNT(*) AS CNT from card_acts WHERE id_object=:id_object;';
        qrTemp.ParamByName('id_object').Value := FormCalculationEstimate.IdObject;
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

procedure TfCardAct.btn1Click(Sender: TObject);
begin
  if (not Assigned(fForemanList)) then
    fForemanList := TfForemanList.Create(FormMain);
  fForemanList.Kind := kdSelect;
  if (fForemanList.ShowModal = mrOk) and (fForemanList.OutValue <> 0) then
  begin
    qrAct.Edit;
    qrAct.FieldByName('foreman_id').Value := fForemanList.OutValue;
    qrAct.FieldByName('foreman_').Value :=
      FastSelectSQLOne
      ('SELECT CONCAT(IFNULL(foreman_first_name, ""), " ", IFNULL(foreman_name, ""), " ", IFNULL(foreman_second_name, "")) FROM foreman WHERE foreman_id=:0',
      VarArrayOf([fForemanList.OutValue]));
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
var
  NewId: Integer;
begin
  case Kind of
    kdInsert:
      begin
        try
          with qrTemp do
          begin
            // ONNEWRECORD TODO GetNewID
            Active := False;
            SQL.Clear;
            SQL.Add('SELECT GetNewID(:IDType)');
            ParamByName('IDType').Value := C_ID_ACT;
            Active := True;
            NewId := 0;
            if not Eof then
              NewId := Fields[0].AsInteger;
            Active := False;

            if NewId = 0 then
              raise Exception.Create('Не удалось получить новый ID.');

            SQL.Clear;
            SQL.Add('INSERT INTO card_acts (ID, id_object, name, description, date, foreman_id) ' +
              'VALUE (:ID, :id_object, :name, :description, :date, :foreman_id);');
            ParamByName('ID').Value := NewId;
            ParamByName('id_object').Value := FormCalculationEstimate.IdObject;
            ParamByName('name').Value := dbedtNAME.Text;
            ParamByName('description').Value := dbmmoDESCRIPTION.Text;
            ParamByName('date').AsDate := edDate.Date;
            ParamByName('foreman_id').Value := qrAct.FieldByName('foreman_id').Value;
            ExecSQL;
            if qrAct.State in [dsInsert] then
              qrAct.Cancel;
            SQL.Clear;
            SQL.Add('CALL SaveDataAct(:ID);');
            ParamByName('ID').Value := NewId;
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
