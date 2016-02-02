{ Модуль редактирования параметров отчета }
unit SmReportParams;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Tools, DataModule, Vcl.StdCtrls, Vcl.ExtCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.Mask, JvExMask, JvSpin, JvDBSpinEdit, GlobsAndConst, System.DateUtils, Vcl.Buttons, JvExControls,
  JvDBLookup, SmReportParamSelect;

type
  TfSmReportParams = class(TSmForm)
    qrReportParam: TFDQuery;
    lblHint: TLabel;
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
  paramId, paramType, i, j, tmpMonth, tmpYear: Integer;
  res: Variant;
begin
  paramId := TControl(Sender).Tag;
  paramType := Params[paramId, 2];
  // Выбираем по типу
  case paramType of
    // Целое число +
    1:
      begin
        if Sender is TJvSpinEdit then
        begin
          Params[paramId, 0] := TJvSpinEdit(Sender).Value;
          SetGlob(Params[paramId, 3], Params[paramId, 0]);
        end;
      end;
    // Строка +
    2:
      begin
        if Sender is TEdit then
        begin
          Params[paramId, 0] := string((Sender as TEdit).Text);
          SetGlob(Params[paramId, 3], Params[paramId, 0]);
        end
      end;
    // Дата
    3:
      ;
    // Месяц/год  +
    4:
      begin
        tmpMonth := MonthOf(Now);
        tmpYear := YearOf(Now);
        for i := 0 to TWinControl(Sender).Parent.ComponentCount - 1 do
          // Ищем TComboBox и TJvSpinEdit на родителе для сбоки даты
          if TWinControl(Sender).Parent.Components[i] is TComboBox then
            tmpMonth := TComboBox(TWinControl(Sender).Parent.Components[i]).ItemIndex + 1
          else if TWinControl(Sender).Parent.Components[i] is TJvSpinEdit then
            tmpYear := Trunc(TJvSpinEdit(TWinControl(Sender).Parent.Components[i]).Value);

        Params[paramId, 0] := StrToDate('01.' + IntToStr(tmpMonth) + '.' + IntToStr(tmpYear));
        SetGlob(Params[paramId, 3], Params[paramId, 0]);
      end;
    // Список +
    5:
      begin
        if Sender is TJvDBLookupCombo then
        begin
          Params[paramId, 0] := TJvDBLookupCombo(Sender).KeyValue;
          SetGlob(Params[paramId, 3], Params[paramId, 0]);
          // Снимаем галочку Все, если установлена
          for i := 0 to TWinControl(Sender).Parent.Parent.ComponentCount - 1 do
            if TWinControl(Sender).Parent.Parent.Components[i] is TCheckBox then
              TCheckBox(TWinControl(Sender).Parent.Parent.Components[i]).Checked :=
                IIF(TJvDBLookupCombo(Sender).KeyValue = Null, True, False);
        end
        else if Sender is TCheckBox then
        begin
          if TCheckBox(Sender).Checked then
          begin
            Params[paramId, 0] := Null;
            SetGlob(Params[paramId, 3], Params[paramId, 0]);
            // Ищем поле TJvDBLookupCombo для прорисовки выбранного значения
            for i := 0 to TWinControl(Sender).Parent.ComponentCount - 1 do
              if TWinControl(Sender).Parent.Components[i] is TPanel then
                for j := 0 to TWinControl(Sender).Parent.Components[i].ComponentCount - 1 do
                  if TWinControl(Sender).Parent.Components[i].Components[j] is TJvDBLookupCombo then
                    TJvDBLookupCombo(TWinControl(Sender).Parent.Components[i].Components[j]).KeyValue := Null;
          end;
        end;
      end;
    // Список с выбором из справочника +
    6:
      begin
        if Sender is TCheckBox then
        begin
          if TCheckBox(Sender).Checked then
          begin
            Params[paramId, 0] := Null;
            SetGlob(Params[paramId, 3], Params[paramId, 0]);
            // Ищем поле TEdit для прорисовки выбранного значения
            for i := 0 to TWinControl(Sender).Parent.ComponentCount - 1 do
              if TWinControl(Sender).Parent.Components[i] is TPanel then
                for j := 0 to TWinControl(Sender).Parent.Components[i].ComponentCount - 1 do
                  if TWinControl(Sender).Parent.Components[i].Components[j] is TEdit then
                    TEdit(TWinControl(Sender).Parent.Components[i].Components[j]).Text := '<Все>';
          end;
        end
        else if Sender is TBitBtn then
        begin
          res := TfSmReportParamSelect.Select(Params[paramId, 1], Params[paramId, 0]);
          if not VarIsNull(res) then
          begin
            Params[paramId, 0] := res[0];
            SetGlob(Params[paramId, 3], Params[paramId, 0]);
            SetGlob(Params[paramId, 3] + '_text', res[1]);
            // Ищем поле TEdit для прорисовки выбранного значения res[1]
            for i := 0 to TWinControl(Sender).Parent.ComponentCount - 1 do
              if TWinControl(Sender).Parent.Components[i] is TEdit then
                TEdit(TWinControl(Sender).Parent.Components[i]).Text := res[1];
            // Снимаем галочку Все, если установлена
            for i := 0 to TWinControl(Sender).Parent.Parent.ComponentCount - 1 do
              if TWinControl(Sender).Parent.Parent.Components[i] is TCheckBox then
                TCheckBox(TWinControl(Sender).Parent.Parent.Components[i]).Checked := False;
          end;
        end
      end;
  end;
  // Процедура синхронизации параметров
  if Sender is TCheckBox then
  begin
    if TCheckBox(Sender).Checked then
      Params[paramId, 0] := Null;
  end;
end;

procedure TfSmReportParams.qrReportParamAfterOpen(DataSet: TDataSet);
var
  i, j: Integer;
begin
  // Создаем массив параметров
  // 0 - код/значение
  // 1 - REPORT_LIST_SQL_ID, если список
  // 2 - тип переменной
  // 3 - название переменной REPORT_PARAM_NAME
  Params := VarArrayCreate([0, qrReportParam.RecordCount - 1, 0, 3], varVariant);
  // Инициализируем
  for i := 0 to qrReportParam.RecordCount - 1 do
    for j := 0 to 3 do
      Params[i, j] := Null;
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
    // Записываем тип параметра
    Params[AParamId, 2] := AType;
    // Записываем название параметра
    Params[AParamId, 3] := qrReportParam.FieldByName('REPORT_PARAM_NAME').Value;

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
      newCheck.Checked := VarIsNull(GetGlob(Params[AParamId, 3]));
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
          seYear.Value := GetGlobDef(Params[AParamId, 3], 0);
          Params[AParamId, 0] := GetGlobDef(Params[AParamId, 3], 0);
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
          newEdit.Text := GetGlobDef(Params[AParamId, 3], '');
          Params[AParamId, 0] := GetGlobDef(Params[AParamId, 3], '');
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
          seYear.Value := YearOf(GetGlobDef(Params[AParamId, 3], Now));
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
          cbbMonth.ItemIndex := MonthOf(GetGlobDef(Params[AParamId, 3], Now)) - 1;
          cbbMonth.OnChange := OnChangeParam;

          Params[AParamId, 0] := GetGlobDef(Params[AParamId, 3], Now);
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
          lcb.DropDownCount := IIF(qr.RecordCount > 20, 20, qr.RecordCount + 1);
          lcb.OnChange := OnChangeParam;
          lcb.KeyValue := GetGlob(Params[AParamId, 3]);

          Params[AParamId, 0] := lcb.KeyValue;
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
          if not VarIsNull(GetGlob(Params[AParamId, 3])) then
            newEdit.Text := GetGlobDef(Params[AParamId, 3] + '_text', '')
          else if qrReportParam.FieldByName('FL_ALLOW_ALL').Value = 1 then
            newEdit.Text := '<Все>';
          // Код списка
          Params[AParamId, 1] := qrReportParam.FieldByName('REPORT_LIST_SQL_ID').Value;
          Params[AParamId, 0] := GetGlob(Params[AParamId, 3]);
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
  ParamName, ErrorParams, msg: string;
begin
  if not CheckQrActiveEmpty(qrReportParam) then
    Exit;
  ErrorParams := '';
  qrReportParam.First;
  paramId := 0;
  while not qrReportParam.Eof do
  begin
    // Проверяем параметр на заполненность, если обязательный
    if (qrReportParam.FieldByName('FL_REQUIRED').AsInteger = 1) and
      (qrReportParam.FieldByName('FL_ALLOW_ALL').AsInteger = 0) and VarIsNull(Params[paramId, 0]) then
      ErrorParams := ErrorParams + ' - ' + qrReportParam.FieldByName('REPORT_PARAM_LABEL').AsString + ''#13;

    ParamName := qrReportParam.FieldByName('REPORT_PARAM_NAME').AsString;
    if AQuery.FindParam(ParamName) <> nil then
      AQuery.ParamByName(ParamName).Value := Params[paramId, 0];
    Inc(paramId);
    qrReportParam.Next;
  end;
  if ErrorParams <> '' then
  begin
    msg := 'Не указаны обязательные для заполнения параметры отчета:'#13 + ErrorParams;
    Application.MessageBox(PChar(msg), 'Параметры отчета', MB_OK + MB_ICONSTOP + MB_TOPMOST);
    Abort;
  end;
end;

end.
