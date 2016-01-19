{ Модуль редактирования параметров отчета }
unit SmReportParams;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Tools, DataModule, Vcl.StdCtrls, Vcl.ExtCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.Mask, JvExMask, JvSpin, JvDBSpinEdit, GlobsAndConst, System.DateUtils, Vcl.Buttons, JvExControls,
  JvDBLookup;

type
  TfSmReportParams = class(TSmForm)
    qrReportParam: TFDQuery;
    lbl1: TLabel;
    procedure qrReportParamAfterOpen(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
  private
    // procedure OnResizePanel(Sender: TObject);
    procedure OnChangeParam(Sender: TObject);
  public
    Params: Variant;
    procedure ReloadReportParams(AReport: Integer);
    procedure WriteReportParams(AQuery: TFDQuery);
  end;

implementation

{$R *.dfm}

procedure TfSmReportParams.FormCreate(Sender: TObject);
begin
  if not VarIsNull(InitParams) then
    ReloadReportParams(InitParams);
end;
{
  procedure TfSmReportParams.OnResizePanel(Sender: TObject);
  var
  i: Integer;
  begin
  for i := (Sender as TWinControl).ComponentCount - 1 downto 0 do
  if ((Sender as TWinControl).Components[i].ClassType = TLabel) then
  ((Sender as TWinControl).Components[i] as TWinControl).Width := (Sender as TWinControl).Width div 2;
  end;
}

procedure TfSmReportParams.OnChangeParam(Sender: TObject);
var
  paramId: Integer;
begin
  paramId := TControl(Sender).Tag;
  // Процедура синхронизации параметров
  if Sender is TEdit then
  begin
    Params[paramId] := string((Sender as TEdit).Text);
  end
  else if Sender is TCheckBox then
  begin
    if TCheckBox(Sender).Checked then
      Params[paramId] := Null;
  end
  else if Sender is TBitBtn then
  begin
    ShowMessage('ToDo');
    Params[paramId] := 0;
  end
  else if Sender is TJvDBLookupCombo then
  begin
    Params[paramId] := TJvDBLookupCombo(Sender).KeyValue;
  end
  else if Sender is TComboBox then
  begin
    ShowMessage('ToDo');
    Params[paramId] := StrToDate('01.' + IntToStr(TComboBox(Sender).ItemIndex + 1) + '.' + '2015');
  end
  else if Sender is TJvSpinEdit then
  begin
    ShowMessage('ToDo');
    { Params[paramId] := StrToDate('01.01'  + IntToStr(TComboBox(Sender).ItemIndex + 1)  + '.' +
      IntToStr(Integer(TJvSpinEdit(Sender).Value))); }
  end;
end;

procedure TfSmReportParams.qrReportParamAfterOpen(DataSet: TDataSet);
begin
  // Создаем массив параметров
  Params := VarArrayCreate([0, qrReportParam.RecordCount - 1], varVariant);
end;

procedure TfSmReportParams.ReloadReportParams(AReport: Integer);
  function addPanel(AType, AParamId: Integer): TPanel;
  var
    newPanel, newSubPanel: TPanel;
    newLabel: TLabel;
    newCheck: TCheckBox;
    cbbMonth: TComboBox;
    seYear: TJvSpinEdit;
    newButton: TBitBtn;
    newEdit: TEdit;
    ds: TDataSource;
    qr: TFDQuery;
    lcb: TJvDBLookupCombo;
    i: Integer;
  begin
    newPanel := TPanel.Create(Self);
    newPanel.Parent := Self;
    newPanel.Tag := qrReportParam.FieldByName('REPORT_PARAM_ID').AsInteger;
    newPanel.Align := alTop;
    newPanel.AlignWithMargins := True;
    newPanel.Margins.Bottom := 0;
    newPanel.Caption := '';
    newPanel.Height := 28;
    newPanel.BevelOuter := bvNone;
    newPanel.BevelKind := bkSoft;
    // newPanel.OnResize := OnResizePanel;

    newLabel := TLabel.Create(newPanel);
    newLabel.Parent := newPanel;
    newLabel.AlignWithMargins := True;
    newLabel.Tag := qrReportParam.FieldByName('REPORT_PARAM_ID').AsInteger;
    newLabel.Align := alLeft;
    // newLabel.WordWrap := True;
    newLabel.Constraints.MinWidth := 70;
    newLabel.Caption := qrReportParam.FieldByName('REPORT_PARAM_LABEL').AsString +
      IIF(qrReportParam.FieldByName('FL_REQUIRED').Value = 1, '*', '');
    newLabel.AutoSize := False;
    newLabel.AutoSize := True;
    // newLabel.Width := newPanel.Width div 2;

    if qrReportParam.FieldByName('FL_ALLOW_ALL').Value = 1 then
    begin
      newCheck := TCheckBox.Create(newPanel);
      newCheck.Parent := newPanel;
      newCheck.AlignWithMargins := True;
      newCheck.Tag := AParamId;
      newCheck.Caption := 'Все';
      newCheck.Width := 35;
      newCheck.Align := alRight;
      newCheck.Checked := True;
      newCheck.Hint := 'Выбрать все значения по данному параметру';
      newCheck.ShowHint := True;
      newCheck.OnClick := OnChangeParam;
    end;

    // Панель ввода значения
    newSubPanel := TPanel.Create(newPanel);
    newSubPanel.Parent := newPanel;
    newSubPanel.Tag := qrReportParam.FieldByName('REPORT_PARAM_ID').AsInteger;
    newSubPanel.Align := alClient;
    newSubPanel.AlignWithMargins := True;
    newSubPanel.Margins.Bottom := 0;
    newSubPanel.Margins.Top := 0;
    newSubPanel.Caption := '';
    newSubPanel.BevelOuter := bvNone;
    newSubPanel.BevelKind := bkNone;

    case AType of
      // Целое число
      1:
        begin
          seYear := TJvSpinEdit.Create(newSubPanel);
          // seYear.Name := 'seYear';
          seYear.Parent := newSubPanel;
          seYear.AlignWithMargins := True;
          seYear.Margins.Bottom := 1;
          seYear.Margins.Top := 1;
          seYear.Margins.Right := 0;
          seYear.Align := alLeft;
          seYear.Color := clInfoBk;
          seYear.Width := 100;
          seYear.Tag := AParamId;
          seYear.OnChange := OnChangeParam;
        end;
      // Строка
      2:
        begin
          newEdit := TEdit.Create(newSubPanel);
          newEdit.Parent := newSubPanel;
          newEdit.AlignWithMargins := True;
          newEdit.Margins.Top := 1;
          newEdit.Margins.Right := 0;
          newEdit.Margins.Bottom := 1;
          newEdit.Align := alClient;
          newEdit.Color := clInfoBk;
          newEdit.Tag := AParamId;
          newEdit.OnChange := OnChangeParam;
        end;
      // Дата
      3:
        ;
      // Месяц/год
      4:
        begin
          // Выбор года
          seYear := TJvSpinEdit.Create(newSubPanel);
          // seYear.Name := 'seYear';
          seYear.Parent := newSubPanel;
          seYear.AlignWithMargins := True;
          seYear.Margins.Bottom := 1;
          seYear.Margins.Top := 1;
          seYear.Margins.Right := 0;
          seYear.Align := alRight;
          seYear.Color := clInfoBk;
          seYear.Width := 60;
          seYear.Value := YearOf(Now);
          seYear.Tag := AParamId;
          seYear.OnChange := OnChangeParam;

          // Комбик выбора месяца
          cbbMonth := TComboBox.Create(newSubPanel);
          // cbbMonth.Name := 'cbbMonth';
          cbbMonth.Parent := newSubPanel;
          cbbMonth.AlignWithMargins := True;
          cbbMonth.Margins.Bottom := 1;
          cbbMonth.Margins.Top := 1;
          cbbMonth.Margins.Right := 0;
          cbbMonth.Align := alClient;
          // cbbMonth.Width := 100;
          cbbMonth.Style := csDropDownList;
          cbbMonth.DropDownCount := 12;
          cbbMonth.Tag := AParamId;
          for i := 1 to 12 do
            cbbMonth.Items.Add(arraymes[i, 1]);
          cbbMonth.ItemIndex := MonthOf(Now) - 1;
          cbbMonth.OnChange := OnChangeParam;
        end;
      // Список
      5:
        begin
          ds := TDataSource.Create(newSubPanel);
          qr := TFDQuery.Create(newSubPanel);
          lcb := TJvDBLookupCombo.Create(newSubPanel);

          ds.DataSet := qr;

          qr.Connection := DM.Connect;
          qr.Transaction := DM.Read;
          qr.UpdateTransaction := DM.Write;
          qr.FetchOptions.AssignedValues := [evCache];
          qr.FetchOptions.Cache := [fiBlobs, fiMeta];
          qr.SQL.Text := qrReportParam.FieldByName('REPORT_LIST_SQL_SRC').AsString;
          qr.Active := True;

          lcb.Parent := newSubPanel;
          lcb.AlignWithMargins := True;
          lcb.Margins.Top := 1;
          lcb.Margins.Right := 0;
          lcb.Margins.Bottom := 1;
          lcb.Align := alClient;
          lcb.Color := clInfoBk;
          lcb.LookupField := 'CODE';
          lcb.LookupDisplay := 'VALUE';
          lcb.LookupSource := ds;
          lcb.DisplayEmpty := '<Все>';
          lcb.Tag := AParamId;
          lcb.OnChange := OnChangeParam;
        end;
      // Список с выбором из справочника
      6:
        begin
          // Кнопка выбора из справочника
          newButton := TBitBtn.Create(newSubPanel);
          newButton.Parent := newSubPanel;
          newButton.AlignWithMargins := True;
          newButton.Width := 25;
          newButton.Hint := 'Выбрать из справочника';
          newButton.Margins.Top := 1;
          newButton.Margins.Right := 0;
          newButton.Margins.Bottom := 1;
          newButton.Margins.Left := 1;
          newButton.Align := alRight;
          newButton.Caption := '...';
          newButton.ShowHint := True;
          newButton.Tag := AParamId;
          newButton.OnClick := OnChangeParam;

          // Поле для показа выбранного значения
          newEdit := TEdit.Create(newSubPanel);
          newEdit.Parent := newSubPanel;
          newEdit.AlignWithMargins := True;
          newEdit.Margins.Top := 1;
          newEdit.Margins.Right := 0;
          newEdit.Margins.Bottom := 1;
          newEdit.Align := alClient;
          newEdit.Color := clInfoBk;
          newEdit.ReadOnly := True;
          newEdit.Enabled := False;
          if qrReportParam.FieldByName('FL_ALLOW_ALL').Value = 1 then
            newEdit.Text := '<Все>';
        end;
    end;

    Result := newPanel;
  end;

var
  i, paramId: Integer;

begin
  // Процедура отрисовки параметров отчета
  Visible := False;
  // Удаляем все элементы
  for i := ComponentCount - 1 downto 0 do
    if (Components[i].ClassType = TPanel) then
      Components[i].Free;
  // Создаем панельки для ввода параметров динамически
  qrReportParam.Active := False;
  qrReportParam.ParamByName('REPORT_ID').Value := AReport;
  qrReportParam.Active := True;
  qrReportParam.First;
  Height := 34 * qrReportParam.RecordCount + 25;
  if qrReportParam.IsEmpty then
    Exit;
  paramId := 0;
  while not qrReportParam.Eof do
  begin
    // Определяем тип параметра
    addPanel(qrReportParam.FieldByName('REPORT_PARAM_TYPE_ID').AsInteger, paramId);
    Inc(paramId);
    qrReportParam.Next;
  end;

  Visible := True;
end;

procedure TfSmReportParams.WriteReportParams(AQuery: TFDQuery);
// Процедура для записи значений параметров в датасет
var
  paramId: Integer;
  ParamName: string;
begin
  if not CheckQrActiveEmpty(qrReportParam) then
    Exit;

  qrReportParam.First;
  paramId := 0;
  while not qrReportParam.Eof do
  begin
    ParamName := qrReportParam.FieldByName('REPORT_PARAM_NAME').AsString;
    if AQuery.FindParam(ParamName) <> nil then
      AQuery.ParamByName(ParamName).Value := Params[paramId];
    Inc(paramId);
    qrReportParam.Next;
  end;
end;

end.
