unit fCopyEstimRow;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  System.UITypes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Vcl.Grids, Vcl.DBGrids,
  JvExDBGrids, JvDBGrid, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, JvExComCtrls, JvDBTreeView,
  Tools, Vcl.Menus;

type
  TFormCopyEstimRow = class(TSmForm)
    pnlLeft: TPanel;
    pnlRigth: TPanel;
    gbObjects: TGroupBox;
    gbTreeData: TGroupBox;
    gbRate: TGroupBox;
    qrObjects: TFDQuery;
    dsObjects: TDataSource;
    dbgrdObjects: TJvDBGrid;
    qrTreeData: TFDQuery;
    dsTreeData: TDataSource;
    tvEstimates: TJvDBTreeView;
    qrRatesEx: TFDQuery;
    strngfldRatesExSORT_ID: TStringField;
    qrRatesExITERATOR: TIntegerField;
    qrRatesExOBJ_CODE: TStringField;
    qrRatesExOBJ_NAME: TStringField;
    qrRatesExOBJ_UNIT: TStringField;
    qrRatesExID_TYPE_DATA: TIntegerField;
    qrRatesExDATA_ESTIMATE_OR_ACT_ID: TIntegerField;
    qrRatesExID_TABLES: TIntegerField;
    qrRatesExSM_ID: TIntegerField;
    qrRatesExWORK_ID: TIntegerField;
    qrRatesExZNORMATIVS_ID: TIntegerField;
    qrRatesExAPPLY_WINTERPRISE_FLAG: TShortintField;
    qrRatesExID_RATE: TIntegerField;
    qrRatesExOBJ_COUNT: TFloatField;
    qrRatesExADDED_COUNT: TIntegerField;
    qrRatesExREPLACED_COUNT: TIntegerField;
    qrRatesExINCITERATOR: TIntegerField;
    strngfldRatesExSORT_ID2: TStringField;
    qrRatesExNUM_ROW: TIntegerField;
    qrRatesExID_REPLACED: TIntegerField;
    qrRatesExCONS_REPLASED: TIntegerField;
    qrRatesExCOEF_ORDERS: TIntegerField;
    qrRatesExNOM_ROW_MANUAL: TIntegerField;
    qrRatesExMarkRow: TShortintField;
    dsRatesEx: TDataSource;
    grRatesEx: TJvDBGrid;
    SplitterCenter: TSplitter;
    Splitter1: TSplitter;
    pmRetesEx: TPopupMenu;
    pmCopyRows: TMenuItem;
    N1: TMenuItem;
    procedure qrObjectsBeforeOpen(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure qrObjectsAfterScroll(DataSet: TDataSet);
    procedure qrTreeDataAfterScroll(DataSet: TDataSet);
    procedure grRatesExDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure qrRatesExAfterOpen(DataSet: TDataSet);
    procedure qrRatesExCalcFields(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure pmCopyRowsClick(Sender: TObject);
    procedure pmRetesExPopup(Sender: TObject);
  private
    const
      CaptionButton = 'Копирование строк смет';
    const
      HintButton = 'Окно копирования строк смет';
  private
    FOnCopyRowsToSM: TCopyRowsToSMEvent;
    procedure WMSysCommand(var Msg: TMessage); message WM_SYSCOMMAND;
  public
    property OnCopyRowsToSM: TCopyRowsToSMEvent read FOnCopyRowsToSM write FOnCopyRowsToSM;
  end;

var FormCopyEstimRow: TFormCopyEstimRow = nil;

implementation

uses Main, CalculationEstimate, GlobsAndConst, DataModule;

{$R *.dfm}

procedure TFormCopyEstimRow.WMSysCommand(var Msg: TMessage);
begin
  // SC_MAXIMIZE - Разворачивание формы во весь экран
  // SC_RESTORE - Сворачивание формы в окно
  // SC_MINIMIZE - Сворачивание формы в маленькую панель

  if (Msg.WParam = SC_MAXIMIZE) or (Msg.WParam = SC_RESTORE) then
  begin
    FormMain.PanelCover.Visible := True;
    inherited;
    FormMain.PanelCover.Visible := False;
  end
  else if Msg.WParam = SC_MINIMIZE then
  begin
    FormMain.PanelCover.Visible := True;
    inherited;
    ShowWindow(Self.Handle, SW_HIDE); // Скрываем панель свёрнутой формы
    FormMain.PanelCover.Visible := False;
  end
  else
    inherited;
end;

procedure TFormCopyEstimRow.FormActivate(Sender: TObject);
begin
  // Если нажата клавиша Ctrl и выбираем форму, то делаем
  // каскадирование с переносом этой формы на передний план
  FormMain.CascadeForActiveWindow;

  // Делаем нажатой кнопку активной формы (на главной форме внизу)
  FormMain.SelectButtonActiveWindow(CaptionButton);
end;

procedure TFormCopyEstimRow.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
  FormCalculationEstimate.WindowState := wsMaximized;
  FormCalculationEstimate.Refresh;
end;

procedure TFormCopyEstimRow.FormCreate(Sender: TObject);
begin
  FormMain.CreateButtonOpenWindow(CaptionButton, HintButton, Self, 1);
end;

procedure TFormCopyEstimRow.FormDestroy(Sender: TObject);
begin
  FormCopyEstimRow := nil;
  FormMain.DeleteButtonCloseWindow(CaptionButton);
end;

procedure TFormCopyEstimRow.FormShow(Sender: TObject);
begin
  CloseOpen(qrObjects);
end;

procedure TFormCopyEstimRow.grRatesExDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  with grRatesEx.Canvas do
  begin
    Brush.Color := PS.BackgroundRows;
    Font.Color := PS.FontRows;

    if qrRatesExID_TYPE_DATA.AsInteger = -3 then
      Brush.Color := clSilver;
    if qrRatesExID_TYPE_DATA.AsInteger = -1 then
    begin
      Font.Style := Font.Style + [fsBold];
      Brush.Color := clSilver;
    end;
    if (qrRatesExID_TYPE_DATA.AsInteger = -4) or
       (qrRatesExID_TYPE_DATA.AsInteger = -5) then
    begin
      Font.Color := PS.FontRows;
      Brush.Color := clInactiveBorder;
    end;

    // Подсветка нумерации строк как фиксированной облости
    if Column.Index = 0 then
      Brush.Color := grRatesEx.FixedColor;

    // Подсвечиваем расценку с добавленными материалами/механизмами
    if qrRatesExADDED_COUNT.Value > 0 then
      Font.Color := clBlue;
    // Подсветка отрицательного кол-ва
    if qrRatesExOBJ_COUNT.Value < 0 then
      Font.Color := clRed;
    // Подсветка отмеченных строк
    if qrRatesExMarkRow.Value > 0 then
      Font.Color := clPurple;
    // Подсветка выделения
    if (grRatesEx.SelectedRows.CurrentRowSelected) and
       (grRatesEx.SelectedRows.Count > 1) then
      Font.Color := $008080FF;

    if Assigned(TMyDBGrid(grRatesEx).DataLink) and
      (grRatesEx.Row = TMyDBGrid(grRatesEx).DataLink.ActiveRecord + 1)
    // and (grRatesEx = LastEntegGrd) // Подсвечивается жирным только если есть фокус
    then
    begin
      Font.Style := Font.Style + [fsBold];
    end;

    if gdFocused in State then // Ячейка в фокусе
    begin
      Brush.Color := PS.BackgroundSelectCell;
      Font.Color := PS.FontSelectCell;
    end;

    if qrRatesExREPLACED_COUNT.Value > 0 then
      Font.Style := Font.Style + [fsItalic];

    (Sender AS TJvDBGrid).DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
end;

procedure TFormCopyEstimRow.pmCopyRowsClick(Sender: TObject);
var
  DataObj: TSmClipData;
  TempBookmark: TBookMark;
  i, j: Integer;
begin
  if grRatesEx.SelectedRows.Count = 0 then
    grRatesEx.SelectedRows.CurrentRowSelected := True;

  DataObj := TSmClipData.Create;
  grRatesEx.DataSource.DataSet.DisableControls;
  TempBookmark := grRatesEx.DataSource.DataSet.GetBookmark;
  try
    with grRatesEx.SelectedRows do
      if Count <> 0 then
      begin
        for i := 0 to Count - 1 do
        begin
          if IndexOf(Items[i]) > -1 then
          begin
            grRatesEx.DataSource.DataSet.Bookmark := Items[i];

            if qrRatesExID_TYPE_DATA.Value > 0 then
            begin
              j := Length(DataObj.SmClipArray);
              SetLength(DataObj.SmClipArray, j + 1);

              DataObj.SmClipArray[j].ObjID := qrObjects.FieldByName('obj_id').Value;
              DataObj.SmClipArray[j].SmID := qrRatesExSM_ID.Value;
              DataObj.SmClipArray[j].DataID := qrRatesExID_TABLES.Value;
              DataObj.SmClipArray[j].DataType := qrRatesExID_TYPE_DATA.Value;
              DataObj.SmClipArray[j].RateType := 0;
              if DataObj.SmClipArray[j].DataType = 1 then
              begin
                DM.qrDifferent.Active := False;
                DM.qrDifferent.SQL.Text := 'Select NORM_TYPE from card_rate_temp ' +
                 'where ID = ' + DataObj.SmClipArray[j].DataID.ToString;
                DM.qrDifferent.Active := True;
                try
                  if not DM.qrDifferent.Eof then
                    DataObj.SmClipArray[j].RateType :=
                      DM.qrDifferent.Fields[0].AsInteger;
                finally
                  DM.qrDifferent.Active := False;
                end;
              end;
            end;
          end;
        end;

        if Assigned(FOnCopyRowsToSM) then
          FOnCopyRowsToSM(DataObj, TComponent(Sender).Tag);
      end;
  finally
    grRatesEx.DataSource.DataSet.GotoBookmark(TempBookmark);
    grRatesEx.DataSource.DataSet.FreeBookmark(TempBookmark);
    grRatesEx.DataSource.DataSet.EnableControls;
    DataObj.Free;
  end;
end;

procedure TFormCopyEstimRow.pmRetesExPopup(Sender: TObject);
begin
  if (grRatesEx.SelectedRows.Count > 0) and
     not (grRatesEx.SelectedRows.CurrentRowSelected) then
  begin
    grRatesEx.SelectedRows.Clear;
    grRatesEx.SelectedRows.CurrentRowSelected := True;
  end;
end;

procedure TFormCopyEstimRow.qrObjectsAfterScroll(DataSet: TDataSet);
begin
  qrTreeData.ParamByName('OBJ_ID').Value := qrObjects.FieldByName('obj_id').Value;
  CloseOpen(qrTreeData);
end;

procedure TFormCopyEstimRow.qrTreeDataAfterScroll(DataSet: TDataSet);
begin
  qrRatesEx.ParamByName('EAID').Value := qrTreeData.FieldByName('SM_ID').Value;
  CloseOpen(qrRatesEx);
  grRatesEx.SelectedRows.Clear;
end;

procedure TFormCopyEstimRow.qrObjectsBeforeOpen(DataSet: TDataSet);
begin
  if (DataSet as TFDQuery).FindParam('USER_ID') <> nil then
    (DataSet as TFDQuery).ParamByName('USER_ID').Value := G_USER_ID;
end;

procedure TFormCopyEstimRow.qrRatesExAfterOpen(DataSet: TDataSet);
var
  NumPP: Integer;
  Key: Variant;
begin
  if not CheckQrActiveEmpty(qrRatesEx) then
    Exit;
  Key := qrRatesEx.FieldByName('SORT_ID').Value;
  // Устанавливаем №пп
  qrRatesEx.DisableControls;
  qrRatesEx.OnCalcFields := nil;
  NumPP := 0;
  try
    qrRatesEx.First;
    while not qrRatesEx.Eof do
    begin
      NumPP := NumPP + qrRatesEx.FieldByName('INCITERATOR').AsInteger;
      qrRatesEx.Edit;
      if qrRatesEx.FieldByName('ID_TYPE_DATA').AsInteger < 0 then
        qrRatesEx.FieldByName('ITERATOR').Value := Null
      else
        qrRatesEx.FieldByName('ITERATOR').AsInteger := NumPP;
      qrRatesEx.Next;
    end;
  finally
    qrRatesEx.OnCalcFields := qrRatesExCalcFields;
    qrRatesEx.Locate('SORT_ID', Key, []);
    qrRatesEx.EnableControls;
    // grRatesEx.SelectedRows.Clear;
  end;
end;

procedure TFormCopyEstimRow.qrRatesExCalcFields(DataSet: TDataSet);
// Функция считает сколько добавленных материалов/механизмов в расценке
  function GetAddedCount(const ID_CARD_RATE: Integer): Integer;
  begin
    Result := 0;
    DM.qrDifferent.SQL.Text :=
      'SELECT ADDED FROM materialcard WHERE ID_CARD_RATE=:ID_CARD_RATE AND ADDED=1 LIMIT 1';
    DM.qrDifferent.ParamByName('ID_CARD_RATE').Value := ID_CARD_RATE;
    DM.qrDifferent.Active := True;
    Result := Result + DM.qrDifferent.FieldByName('ADDED').AsInteger;
    // Если уже что то нашли, то можно дальше не производить лишних действий
    if Result > 0 then
      Exit;
    DM.qrDifferent.SQL.Text :=
      'SELECT ADDED FROM mechanizmcard WHERE ID_CARD_RATE=:ID_CARD_RATE AND ADDED=1 LIMIT 1';
    DM.qrDifferent.ParamByName('ID_CARD_RATE').Value := ID_CARD_RATE;
    DM.qrDifferent.Active := True;
    Result := Result + DM.qrDifferent.FieldByName('ADDED').AsInteger;
    DM.qrDifferent.Active := False;
  end;
  function GetReplacedCount(const ID_CARD_RATE: Integer): Integer;
  begin
    Result := 0;
    DM.qrDifferent.SQL.Text :=
      'SELECT 1 AS R FROM materialcard WHERE ID_CARD_RATE=:ID_CARD_RATE AND ID_REPLACED>0 LIMIT 1';
    DM.qrDifferent.ParamByName('ID_CARD_RATE').Value := ID_CARD_RATE;
    DM.qrDifferent.Active := True;
    Result := Result + DM.qrDifferent.FieldByName('R').AsInteger;
    // Если уже что то нашли, то можно дальше не производить лишних действий
    if Result > 0 then
      Exit;
    DM.qrDifferent.SQL.Text :=
      'SELECT 1 AS R FROM mechanizmcard WHERE ID_CARD_RATE=:ID_CARD_RATE AND ID_REPLACED>0 LIMIT 1';
    DM.qrDifferent.ParamByName('ID_CARD_RATE').Value := ID_CARD_RATE;
    DM.qrDifferent.Active := True;
    Result := Result + DM.qrDifferent.FieldByName('R').AsInteger;
    DM.qrDifferent.Active := False;
  end;

begin
  if not CheckQrActiveEmpty(qrRatesEx) then
    Exit;

  if qrRatesExID_TYPE_DATA.Value = 1 then
    qrRatesExADDED_COUNT.Value := GetAddedCount(qrRatesExID_TABLES.Value);

  if qrRatesExID_TYPE_DATA.Value = 1 then
    qrRatesExREPLACED_COUNT.Value := GetReplacedCount(qrRatesExID_TABLES.Value);
end;

end.
