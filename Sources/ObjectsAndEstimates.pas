unit ObjectsAndEstimates;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, ExtCtrls, Grids, Menus,
  DB, DBGrids, StdCtrls, ComCtrls, VirtualTrees, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, tools, System.UITypes, JvExDBGrids, JvDBGrid;

type
  TSplitter = class(ExtCtrls.TSplitter)
  public
    procedure Paint(); override;
  end;

type
  TFormObjectsAndEstimates = class(TForm)
    dsObjects: TDataSource;
    PanelMain: TPanel;
    PanelObjects: TPanel;
    PanelBottom: TPanel;
    PanelSelectedColumns: TPanel;
    PopupMenuObjects: TPopupMenu;
    PopupMenuObjectsAdd: TMenuItem;
    PopupMenuObjectsEdit: TMenuItem;
    PopupMenuObjectsDelete: TMenuItem;
    PopupMenuObjectsSeparator1: TMenuItem;
    PopupMenuObjectsColumns: TMenuItem;
    PopupMenuEstimates: TPopupMenu;
    PopupMenuEstimatesAdd: TMenuItem;
    PMEstimatesAddLocal: TMenuItem;
    PMEstimatesAddObject: TMenuItem;
    PMEstimatesAddPTM: TMenuItem;
    PMEstimatesEdit: TMenuItem;
    PMEstimatesDelete: TMenuItem;
    PopupMenuEstimatesSeparator1: TMenuItem;
    PMEstimatesBasicData: TMenuItem;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    CheckBox9: TCheckBox;
    CheckBox10: TCheckBox;
    CheckBox11: TCheckBox;
    CheckBox12: TCheckBox;
    CheckBox13: TCheckBox;
    CheckBox14: TCheckBox;
    CheckBox15: TCheckBox;
    CheckBox16: TCheckBox;
    CheckBox17: TCheckBox;
    ButtonSelectAll: TButton;
    ButtonSelectNone: TButton;
    ButtonCancel: TButton;
    dbgrdObjects: TDBGrid;
    Label1: TLabel;
    ImageSplitterCenter: TImage;
    SplitterCenter: TSplitter;
    ImageSplitterBottomCenter: TImage;
    SplitterBottomCenter: TSplitter;
    PanelEstimates: TPanel;
    PanelActs: TPanel;
    PMActs: TPopupMenu;
    PMActsAdd: TMenuItem;
    PMActsEdit: TMenuItem;
    PMActsDelete: TMenuItem;
    N1: TMenuItem;
    PMEstimateExpand: TMenuItem;
    PMEstimateCollapse: TMenuItem;
    TreeView: TTreeView;
    PMEstimateExpandSelected: TMenuItem;
    PMActsOpen: TMenuItem;
    qrActsEx: TFDQuery;
    qrEstimateObject: TFDQuery;
    qrEstimateLocal: TFDQuery;
    qrEstimatePTM: TFDQuery;
    qrTmp: TFDQuery;
    qrObjects: TFDQuery;
    pmActProperty: TMenuItem;
    dsActs: TDataSource;
    grActs: TJvDBGrid;
    procedure ResizeImagesForSplitters;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure PopupMenuObjectsAddClick(Sender: TObject);
    procedure PopupMenuObjectsEditClick(Sender: TObject);
    procedure PopupMenuObjectsDeleteClick(Sender: TObject);
    procedure PopupMenuObjectsColumnsClick(Sender: TObject);
    procedure RunQueryForEstimateObject;
    procedure RunQueryForEstimatelocal;
    procedure RunQueryForEstimatePTM;
    procedure qrObjectsAfterScroll(DataSet: TDataSet);
    procedure PanelBottomResize(Sender: TObject);
    procedure FillingTableObjects;
    procedure FillingTableEstimates;
    procedure PopupMenuEstimatesAddClick(Sender: TObject);
    procedure PMEstimatesEditClick(Sender: TObject);
    procedure PMEstimatesDeleteClick(Sender: TObject);
    procedure ButtonCancelClick(Sender: TObject);
    procedure CheckBoxColumnsClick(Sender: TObject);
    procedure ButtonSelectAllClick(Sender: TObject);
    procedure ButtonSelectNoneClick(Sender: TObject);
    procedure SelectedColumns(Value: Boolean);
    procedure PMEstimatesBasicDataClick(Sender: TObject);
    procedure StringGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure PMEstimateExpandClick(Sender: TObject);
    procedure PMEstimateCollapseClick(Sender: TObject);
    procedure TreeViewChange(Sender: TObject; Node: TTreeNode);
    procedure GetTypeEstimate;
    function GetNumberEstimate(): string;
    procedure PopupMenuEstimatesPopup(Sender: TObject);
    procedure TreeViewDblClick(Sender: TObject);
    procedure PMEstimateExpandSelectedClick(Sender: TObject);
    procedure PMActsAddClick(Sender: TObject);
    procedure FillingActs;
    procedure VSTDblClick(Sender: TObject);
    procedure PMActsPopup(Sender: TObject);
    procedure PMActsDeleteClick(Sender: TObject);
    procedure PMActsEditClick(Sender: TObject);
    procedure PMActsOpenClick(Sender: TObject);
    procedure OpenAct(const ActID: Integer);
    procedure pmActPropertyClick(Sender: TObject);
    procedure qrActsExAfterOpen(DataSet: TDataSet);
  private
    StrQuery: String; // Строка для формирования запросов
    IdObject: Integer;
    IdEstimate: Integer;
    IDAct: Integer;
    TypeEstimate: Integer;
  public
    ActReadOnly: Boolean;
    function getCurObject: Integer;
  protected
    procedure WMSysCommand(var Msg: TMessage); message WM_SYSCOMMAND;
  end;

var
  FormObjectsAndEstimates: TFormObjectsAndEstimates;

implementation

uses Main, DataModule, CardObject, CardEstimate, CalculationEstimate, Waiting,
  BasicData, DrawingTables, KC6, CardAct;

{$R *.dfm}

{ TSplitter }
procedure TSplitter.Paint();
begin
  // inherited;
  FormObjectsAndEstimates.ResizeImagesForSplitters;
end;

procedure TFormObjectsAndEstimates.WMSysCommand(var Msg: TMessage);
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
    ShowWindow(FormObjectsAndEstimates.Handle, SW_HIDE);
    // Скрываем панель свёрнутой формы
    FormMain.PanelCover.Visible := False;
  end
  else
    inherited;
end;

procedure TFormObjectsAndEstimates.ResizeImagesForSplitters;
begin
  ImageSplitterCenter.Top := SplitterCenter.Top;
  ImageSplitterCenter.Left := SplitterCenter.Left + (SplitterCenter.Width - ImageSplitterCenter.Width) div 2;

  ImageSplitterBottomCenter.Left := SplitterBottomCenter.Left;
  ImageSplitterBottomCenter.Top := SplitterBottomCenter.Top +
    (SplitterBottomCenter.Height - ImageSplitterBottomCenter.Height) div 2;
end;

procedure TFormObjectsAndEstimates.FormCreate(Sender: TObject);
begin
  LoadDBGridSettings(dbgrdObjects);
  FormMain.PanelCover.Visible := True;
  // Настройка размеров и положения формы
  ClientWidth := FormMain.ClientWidth div 2;
  ClientHeight := FormMain.ClientHeight div 2;
  Top := 10;
  // (GetSystemMetrics(SM_CYFRAME) + GetSystemMetrics(SM_CYCAPTION)) * -1;
  Left := 10; // GetSystemMetrics(SM_CXFRAME) * -1;
  WindowState := wsMaximized;
  // -----------------------------------------
  PanelSelectedColumns.Visible := False;
  // -----------------------------------------
  // ЗАГРУЖАЕМ ИЗОБРАЖЕНИЯ ДЛЯ СПЛИТТЕРОВ
  with DM.ImageListHorozontalDots do
  begin
    GetIcon(0, ImageSplitterCenter.Picture.Icon);
  end;

  with DM.ImageListVerticalDots do
  begin
    GetIcon(0, ImageSplitterBottomCenter.Picture.Icon);
  end;

  // Делим экран на 2 равные части для таблиц объектов и смет
  PanelObjects.Height := (FormMain.ClientHeight - FormMain.PanelOpenWindows.Height -
    SplitterCenter.Height) div 2;

  // Выводим данные в таблицу объектов
  FillingTableObjects;
  IdEstimate := 0;
  LoadDBGridSettings(grActs);

  // Создаём кнопку от этого окна (на главной форме внизу)
  FormMain.CreateButtonOpenWindow(CaptionButtonObjectsAndEstimates, HintButtonObjectsAndEstimates,
    FormMain.ShowObjectsAndEstimates);
end;

procedure TFormObjectsAndEstimates.FormShow(Sender: TObject);
begin
  dbgrdObjects.SetFocus; // Устанавливаем фокус

  FormMain.TimerCover.Enabled := True;
  // Запускаем таймер который скроет панель после отображения формы
end;

function TFormObjectsAndEstimates.getCurObject: Integer;
begin
  Result := IdObject;
end;

procedure TFormObjectsAndEstimates.FormResize(Sender: TObject);
begin
  PanelObjects.Height := (ClientHeight - SplitterCenter.Height) div 2;
end;

procedure TFormObjectsAndEstimates.FormActivate(Sender: TObject);
begin
  // Если нажата клавиша Ctrl и выбираем форму, то делаем
  // каскадирование с переносом этой формы на передний план
  FormMain.CascadeForActiveWindow;

  // Делаем нажатой кнопку активной формы (на главной форме внизу)
  FormMain.SelectButtonActiveWindow(CaptionButtonObjectsAndEstimates);
end;

procedure TFormObjectsAndEstimates.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFormObjectsAndEstimates.FormDestroy(Sender: TObject);
begin
  FormObjectsAndEstimates := nil;
  // Удаляем кнопку от этого окна (на главной форме внизу)
  FormMain.DeleteButtonCloseWindow(CaptionButtonObjectsAndEstimates);
end;

procedure TFormObjectsAndEstimates.PopupMenuObjectsAddClick(Sender: TObject);
begin
  FormCardObject.ShowModal;

  // Выводим данные в таблицу объектов
  FillingTableObjects;

  // Устанавливаем фокус
  dbgrdObjects.SetFocus;
end;

procedure TFormObjectsAndEstimates.PopupMenuObjectsEditClick(Sender: TObject);
begin
  if qrObjects.RecordCount <= 0 then
  begin
    MessageBox(0, PChar('Нет объектов для редактирования!'), CaptionForm,
      MB_ICONINFORMATION + mb_OK + mb_TaskModal);
    Exit;
  end;

  with FormCardObject, qrObjects do
  begin
    // Заносим значения в поля редактирования
    EditNumberObject.Text := FieldByName('NumberObject').AsVariant;
    EditCodeObject.Text := FieldByName('CodeObject').AsVariant;
    EditNumberContract.Text := FieldByName('NumberContract').AsVariant;
    DateTimePickerDataCreateContract.Date := FieldByName('DateContract').AsVariant;
    EditShortDescription.Text := FieldByName('Name').AsVariant;
    MemoFullDescription.Text := FieldByName('FullName').AsVariant;
    DateTimePickerStartBuilding.Date := FieldByName('BeginConstruction').AsVariant;
    CheckBoxCalculationEconom.Checked := FieldByName('CalculationEconom').AsVariant;

    if FieldByName('TermConstruction').AsVariant <> Null then
      EditCountMonth.Text := FieldByName('TermConstruction').AsVariant;

    // Для выпадающих списков
    if FieldByName('IdIstFin').AsVariant <> Null then
      SetSourceFinance(FieldByName('IdIstFin').AsVariant);

    if FieldByName('IdClient').AsVariant <> Null then
      SetClient(FieldByName('IdClient').AsVariant);

    if FieldByName('IdContractor').AsVariant <> Null then
      SetContractor(FieldByName('IdContractor').AsVariant);

    SetCategory(FieldByName('IdCategory').AsVariant);
    SetRegion(FieldByName('IdRegion').AsVariant);
    SetVAT(FieldByName('VAT').AsVariant);
    SetBasePrice(FieldByName('IdBasePrice').AsVariant);
    SetTypeOXR(FieldByName('IdOXROPR').AsVariant);
    SetMAIS(FieldByName('IdMAIS').AsVariant);

    // ID выделенной записи
    SetIdSelectRow(Fields[0].AsVariant);

    // Даём знать форме, что будет операция редактирования и чтобы не очищались поля
    EditingRecord(True);

    ShowModal;
  end;

  FillingTableObjects;

  // Устанавливаем фокус
  dbgrdObjects.SetFocus;
end;

procedure TFormObjectsAndEstimates.PopupMenuObjectsDeleteClick(Sender: TObject);
var
  NumberObject: string;
  ResultDialog: Integer;
begin
  if qrObjects.RecordCount <= 0 then
  begin
    MessageBox(0, PChar('Нет объектов для удаления!'), CaptionForm, MB_ICONINFORMATION + mb_OK +
      mb_TaskModal);
    Exit;
  end;

  NumberObject := IntToStr(qrObjects.FieldByName('NumberObject').AsVariant);

  ResultDialog := MessageBox(0, PChar('Вы действительно хотите удалить объект с номером: ' + NumberObject +
    sLineBreak + 'Внимание! Все сметы связанные с объектом будут удалены!' + sLineBreak + sLineBreak +
    'Подтверждаете удаление?'), CaptionForm, MB_ICONINFORMATION + MB_YESNO + mb_TaskModal);

  if ResultDialog = mrNo then
    Exit;

  // Устанавливаем фокус
  dbgrdObjects.SetFocus;

  try
    StrQuery := 'DELETE FROM objcards WHERE obj_id = ' + IntToStr(IdObject) + ';';

    with qrTmp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add(StrQuery);
      ExecSQL;
    end;

    StrQuery := 'DELETE FROM smetasourcedata WHERE obj_id = ' + IntToStr(IdObject) + ';';

    with qrTmp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add(StrQuery);
      ExecSQL;
    end;

  except
    on E: Exception do
      MessageBox(0, PChar('При удалении объекта возникла ошибка.' + sLineBreak +
        'Подробнее об ошибке смотрите ниже:' + sLineBreak + sLineBreak + E.message), CaptionForm,
        MB_ICONERROR + mb_OK + mb_TaskModal);
  end;

  FillingTableObjects;

  if qrObjects.RecordCount = 0 then
    FillingTableEstimates;
end;

procedure TFormObjectsAndEstimates.PopupMenuObjectsColumnsClick(Sender: TObject);
begin
  with PopupMenuObjectsColumns do
  begin
    Checked := not Checked;
    PanelSelectedColumns.Visible := Checked;
  end;
end;

procedure TFormObjectsAndEstimates.RunQueryForEstimateObject;
begin
  with qrEstimateObject do
  begin
    Active := False;
    SQL.Clear;

    StrQuery := 'SELECT smetasourcedata.sm_id as "IdEstimate", typesm.sm_type as "TypeEstimate", ' +
      'typesm.name as "TypeEstimate", sm_number as "NumberEstimate", smetasourcedata.name as "NameEstimate" '
      + 'FROM smetasourcedata, typesm ' + 'WHERE smetasourcedata.sm_type = typesm.sm_type and obj_id = ' +
      IntToStr(IdObject) + ' and smetasourcedata.sm_type = 2 ORDER BY sm_number';

    SQL.Add(StrQuery);
    Active := True;
  end;
end;

procedure TFormObjectsAndEstimates.RunQueryForEstimatelocal;
var
  vId: Integer;
begin
  vId := qrEstimateObject.FieldByName('IdEstimate').AsInteger;

  with qrEstimateLocal do
  begin
    Active := False;
    SQL.Clear;

    StrQuery := 'SELECT smetasourcedata.sm_id as "IdEstimate", typesm.sm_type as "TypeEstimate", ' +
      'typesm.name as "TypeEstimate", sm_number as "NumberEstimate", smetasourcedata.name as "NameEstimate" '
      + 'FROM smetasourcedata, typesm ' + 'WHERE smetasourcedata.sm_type = typesm.sm_type and obj_id = ' +
      IntToStr(IdObject) + ' and smetasourcedata.sm_type = 1 and parent_local_id = ' + IntToStr(vId) +
      ' ORDER BY sm_number;';

    SQL.Add(StrQuery);
    Active := True;
  end;
end;

procedure TFormObjectsAndEstimates.RunQueryForEstimatePTM;
var
  vId: Integer;
begin
  vId := qrEstimateLocal.FieldByName('IdEstimate').AsInteger;

  with qrEstimatePTM do
  begin
    Active := False;
    SQL.Clear;

    StrQuery := 'SELECT smetasourcedata.sm_id as "IdEstimate", typesm.sm_type as "TypeEstimate", ' +
      'typesm.name as "TypeEstimate", sm_number as "NumberEstimate", smetasourcedata.name as "NameEstimate" '
      + 'FROM smetasourcedata, typesm ' + 'WHERE smetasourcedata.sm_type = typesm.sm_type and obj_id = ' +
      IntToStr(IdObject) + ' and smetasourcedata.sm_type = 3 and parent_ptm_id = ' + IntToStr(vId) +
      ' ORDER BY sm_number;';

    SQL.Add(StrQuery);
    Active := True;
  end;
end;

procedure TFormObjectsAndEstimates.qrActsExAfterOpen(DataSet: TDataSet);
begin
  IDAct := qrActsEx.FieldByName('id').AsInteger;
end;

procedure TFormObjectsAndEstimates.qrObjectsAfterScroll(DataSet: TDataSet);
begin
  IdObject := DataSet.FieldByName('IdObject').AsVariant;
  IdEstimate := 0;

  FillingTableEstimates;
end;

procedure TFormObjectsAndEstimates.PanelBottomResize(Sender: TObject);
begin
  PanelEstimates.Width := ((Sender as TPanel).Width - SplitterBottomCenter.Width) div 2;
end;

procedure TFormObjectsAndEstimates.ButtonCancelClick(Sender: TObject);
begin
  PopupMenuObjectsColumnsClick(PopupMenuObjectsColumns);
end;

procedure TFormObjectsAndEstimates.SelectedColumns(Value: Boolean);
var
  i: Integer;
begin
  for i := 1 to 17 do
  begin
    (FindComponent('CheckBox' + IntToStr(i)) as TCheckBox).Checked := Value;
    dbgrdObjects.Columns[i + 7].Visible := Value;
  end;
end;

procedure TFormObjectsAndEstimates.ButtonSelectAllClick(Sender: TObject);
begin
  SelectedColumns(True);
end;

procedure TFormObjectsAndEstimates.ButtonSelectNoneClick(Sender: TObject);
begin
  SelectedColumns(False);
end;

procedure TFormObjectsAndEstimates.CheckBoxColumnsClick(Sender: TObject);
var
  Nom: Integer;
  { Visual: Boolean; }
begin
  with (Sender as TCheckBox) do
  begin
    Nom := StrToInt(Copy(Name, 9, Length(Name) - 8));
    dbgrdObjects.Columns[Nom + 7].Visible := Checked;
  end;
end;

procedure TFormObjectsAndEstimates.TreeViewChange(Sender: TObject; Node: TTreeNode);
{ var
  i: Integer; }
begin
  IdEstimate := Integer(TreeView.Selected.Data);

  GetTypeEstimate;

  FillingActs;
end;

// Открытие сметы
procedure TFormObjectsAndEstimates.TreeViewDblClick(Sender: TObject);
begin
  // Открываем форму ожидания
  FormWaiting.Show;
  Application.ProcessMessages;

  if (not Assigned(FormCalculationEstimate)) then
    FormCalculationEstimate := TFormCalculationEstimate.Create(FormMain);

  with FormCalculationEstimate, qrObjects do
  begin
    EditNameObject.Text := IntToStr(FieldByName('NumberObject').AsVariant) + ' ' + FieldByName('Name')
      .AsVariant;
    EditNumberContract.Text := FieldByName('NumberContract').AsVariant;
    EditDateContract.Text := FieldByName('DateContract').AsVariant;

    EditNameEstimate.Text := TreeView.Selected.Text;

    SetIdObject(IdObject);
    SetIdEstimate(IdEstimate);
    // Создание временных таблиц
    CreateTempTables;
    // Заполненя временных таблиц, заполнение формы
    OpenAllData;
  end;

  // FormCalculationEstimate.Show;

  // Закрываем форму ожидания
  FormWaiting.Close;

  Close;
end;

procedure TFormObjectsAndEstimates.VSTDblClick(Sender: TObject);
begin
  // Открываем форму ожидания
  FormWaiting.Show;
  Application.ProcessMessages;

  if (not Assigned(FormCalculationEstimate)) then
    FormCalculationEstimate := TFormCalculationEstimate.Create(FormMain);

  with FormCalculationEstimate, qrObjects do
  begin
    EditNameObject.Text := IntToStr(FieldByName('NumberObject').AsVariant) + ' ' + FieldByName('Name')
      .AsVariant;
    EditNumberContract.Text := FieldByName('NumberContract').AsVariant;
    EditDateContract.Text := FieldByName('DateContract').AsVariant;

    EditNameEstimate.Text := TreeView.Selected.Text;

    SetIdObject(IdObject);
    SetIdEstimate(IdEstimate);
    Act := True;
    IDAct := 0;

    CreateTempTables;
    OpenAllData;
  end;

  // Закрываем форму ожидания
  FormWaiting.Close;
  Close;

  FormKC6.caption := 'Выборка данных';
  FormKC6.MyShow(IdObject);
end;

procedure TFormObjectsAndEstimates.GetTypeEstimate;
begin
  try
    with qrTmp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT sm_type FROM smetasourcedata WHERE sm_id = :sm_id;');
      ParamByName('sm_id').Value := IdEstimate;
      Active := True;

      TypeEstimate := FieldByName('sm_type').AsInteger;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('При получении типа сметы возникла ошибка:' + sLineBreak + sLineBreak + E.message),
        PWideChar(caption), MB_ICONERROR + mb_OK + mb_TaskModal);
  end;
end;

procedure TFormObjectsAndEstimates.pmActPropertyClick(Sender: TObject);
var
  f: TfCardAct;
begin
  f := TfCardAct.Create(nil);
  f.Kind := kdEdit;
  f.id := IDAct;
  f.ShowModal;
end;

procedure TFormObjectsAndEstimates.OpenAct(const ActID: Integer);
begin
  // Открываем форму ожидания
  FormWaiting.Show;
  Application.ProcessMessages;

  if (not Assigned(FormCalculationEstimate)) then
    FormCalculationEstimate := TFormCalculationEstimate.Create(FormMain);

  FormCalculationEstimate.CreateTempTables;

  if not ActReadOnly then
  begin
    FormKC6.caption := 'Выборка данных';
    FormKC6.MyShow(IdObject);
  end;

  with FormCalculationEstimate, qrObjects do
  begin
    EditNameObject.Text := IntToStr(FieldByName('NumberObject').AsVariant) + ' ' + FieldByName('Name')
      .AsVariant;
    EditNumberContract.Text := FieldByName('NumberContract').AsVariant;
    EditDateContract.Text := FieldByName('DateContract').AsVariant;

    EditNameEstimate.Text := TreeView.Selected.Text;

    SetIdObject(IdObject);
    SetIdEstimate(IdEstimate);
    SetIdAct(ActID);
    SetActReadOnly(ActReadOnly);
    Act := True;

    OpenAllData;
  end;

  // Закрываем форму ожидания
  FormWaiting.Close;
  Close;
end;

procedure TFormObjectsAndEstimates.PMActsOpenClick(Sender: TObject);
begin
  ActReadOnly := True;
  OpenAct(FormObjectsAndEstimates.IDAct);
  ActReadOnly := False;
end;

procedure TFormObjectsAndEstimates.PMActsAddClick(Sender: TObject);
begin
  OpenAct(0);
end;

procedure TFormObjectsAndEstimates.PMActsDeleteClick(Sender: TObject);
begin
  if MessageDlg('Удалить запись?', mtWarning, mbYesNo, 0) <> mrYes then
    Exit;
  try
    with qrTmp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('CALL DeleteAct(:IdAct);');
      ParamByName('IdAct').Value := IDAct;
      ExecSQL;
      Active := False;

      FillingActs;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('При удалении акта возникла ошибка:' + sLineBreak + sLineBreak + E.message),
        PWideChar(caption), MB_ICONERROR + mb_OK + mb_TaskModal);
  end;
end;

procedure TFormObjectsAndEstimates.PMActsEditClick(Sender: TObject);
begin
  OpenAct(FormObjectsAndEstimates.IDAct);
end;

procedure TFormObjectsAndEstimates.PMActsPopup(Sender: TObject);
begin
  // Если не выделена смета или выделена, но не объектная
  PMActsOpen.Enabled := not((TreeView.Selected = nil) or (TypeEstimate <> 2));
  PMActsAdd.Enabled := not((TreeView.Selected = nil) or (TypeEstimate <> 2));
  PMActsEdit.Enabled := not((TreeView.Selected = nil) or (TypeEstimate <> 2));
  PMActsDelete.Enabled := not((TreeView.Selected = nil) or (TypeEstimate <> 2));
  pmActProperty.Enabled := not((TreeView.Selected = nil) or (TypeEstimate <> 2));
end;

function TFormObjectsAndEstimates.GetNumberEstimate(): string;
begin
  try
    with qrTmp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT sm_number FROM smetasourcedata WHERE sm_id = :sm_id;');
      ParamByName('sm_id').Value := IdEstimate;
      Active := True;

      Result := FieldByName('sm_number').AsString;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('При получении номера сметы возникла ошибка:' + sLineBreak + sLineBreak +
        E.message), PWideChar(caption), MB_ICONERROR + mb_OK + mb_TaskModal);
  end;
end;

procedure TFormObjectsAndEstimates.PMEstimateExpandClick(Sender: TObject);
begin
  TreeView.FullExpand;
end;

procedure TFormObjectsAndEstimates.PMEstimateExpandSelectedClick(Sender: TObject);
begin
  TreeView.Selected.Expand(True);
end;

procedure TFormObjectsAndEstimates.PMEstimateCollapseClick(Sender: TObject);
begin
  TreeView.FullCollapse;
end;

procedure TFormObjectsAndEstimates.FillingTableObjects;
{ var
  i: Integer; }
begin
  try
    CloseOpen(qrObjects);
  except
    on E: Exception do
      MessageBox(0, PChar('Запрос на получение данных об объектах не был выполнен.' + sLineBreak +
        'Подробнее об ошибке смотрите ниже:' + sLineBreak + sLineBreak + E.message), PWideChar(caption),
        MB_ICONERROR + mb_OK + mb_TaskModal);
  end;
end;

procedure TFormObjectsAndEstimates.FillingTableEstimates;
var
  l1, l2, l3: Integer;
begin
  TreeView.Items.Clear;
  // НАЧАЛО вывода ОБЪЕКТЫХ смет
  RunQueryForEstimateObject;
  with qrEstimateObject do
  begin
    First;
    while not Eof do
    begin
      l1 := TreeView.Items.Add(Nil, FieldByName('NumberEstimate').AsVariant + ' ' +
        FieldByName('NameEstimate').AsVariant).AbsoluteIndex;
      TreeView.Items.Item[l1].Data := Pointer(FieldByName('IdEstimate').AsInteger);
      // ---------- НАЧАЛО вывода ЛОКАЛЬНЫХ смет
      RunQueryForEstimatelocal;

      with qrEstimateLocal do
      begin
        First;
        while not Eof do
        begin
          l2 := TreeView.Items.AddChild(TreeView.Items.Item[l1], FieldByName('NumberEstimate').AsVariant + ' '
            + FieldByName('NameEstimate').AsVariant).AbsoluteIndex;
          TreeView.Items.Item[l2].Data := Pointer(FieldByName('IdEstimate').AsInteger);
          // -------------------- НАЧАЛО вывода смет ПТМ
          RunQueryForEstimatePTM;

          with qrEstimatePTM do
          begin
            First;
            while not Eof do
            begin
              l3 := TreeView.Items.AddChild(TreeView.Items.Item[l2], FieldByName('NumberEstimate').AsVariant +
                ' ' + FieldByName('NameEstimate').AsVariant).AbsoluteIndex;
              TreeView.Items.Item[l3].Data := Pointer(FieldByName('IdEstimate').AsInteger);

              Next;
            end;
          end;
          // -------------------- КОНЕЦ вывода смет ПТМ
          Next;
        end;
      end;
      // ---------- КОНЕЦ вывода ЛОКАЛЬНЫХ смет
      Next;
    end;
  end;
  // КОНЕЦ вывода ОБЪЕКТЫХ смет
end;

procedure TFormObjectsAndEstimates.PopupMenuEstimatesAddClick(Sender: TObject);
{ var
  Node: TTreeNode; }
begin
  // (Sender as TMenuItem).Tag - Устанавливаем тип сметы (1-локальная, 2-объектная, 3-ПТМ)
  FormCardEstimate.ShowForm(IdObject, IdEstimate, (Sender as TMenuItem).Tag, TreeView);
end;

procedure TFormObjectsAndEstimates.PMEstimatesBasicDataClick(Sender: TObject);
begin
  FormBasicData.ShowForm(IdObject, IdEstimate);
end;

procedure TFormObjectsAndEstimates.PMEstimatesDeleteClick(Sender: TObject);
var
  NumberEstimate, { StrIdEstimate, StrIdRates, } TextWarning: String;
begin
  NumberEstimate := GetNumberEstimate;

  case TypeEstimate of
    1:
      TextWarning := 'Вы пытаетесь удалить ЛОКАЛЬНУЮ смету с номером: ' + NumberEstimate + sLineBreak +
        'Вместе с ней будут удалены все разделы ПТМ которые с ней связаны!' + sLineBreak + sLineBreak +
        'Подтверждаете удаление?';
    2:
      TextWarning := 'Вы пытаетесь удалить ОБЪЕКТНУЮ смету с номером: ' + NumberEstimate + sLineBreak +
        'Вместе с ней будут удалены все локальные и разделы ПТМ которые с ней связаны!' + sLineBreak +
        sLineBreak + 'Подтверждаете удаление?';
    3:
      TextWarning := 'Вы действительно хотите удалить раздел ПТМ с номером: ' + NumberEstimate;
  end;

  if MessageBox(0, PChar(TextWarning), PWideChar(caption), MB_ICONINFORMATION + MB_YESNO + mb_TaskModal) = mrNo
  then
    Exit;

  // ----------------------------------------

  try
    with qrTmp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('CALL DeleteEstimate(:IdEstimate);');
      ParamByName('IdEstimate').Value := IdEstimate;
      ExecSQL;
      Active := False;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('При удалении сметы возникла ошибка:' + sLineBreak + E.message), PWideChar(caption),
        MB_ICONERROR + mb_OK + mb_TaskModal);
  end;

  TreeView.Selected.Delete;
end;

procedure TFormObjectsAndEstimates.PMEstimatesEditClick(Sender: TObject);
begin
  with FormCardEstimate do
  begin
    qrTmp.Active := False;

    qrTmp.SQL.Text :=
      'SELECT sm_id as "IdEstimate", obj_id as "IdObject", smetasourcedata.name as "NameEstimate", ' +
      'sm_number as "NumberEstimate", preparer as "Compose", post_preparer as "PostCompose", examiner as "Checked", '
      + 'post_examiner as "PostChecked", set_drawings as "SetDrawing", chapter as "NumberChapter", ' +
      'row_number as "NumberRow" FROM smetasourcedata WHERE sm_id = ' + IntToStr(IdEstimate);
    qrTmp.Active := True;

    ClearAllFields;

    EditNumberChapter.Text := qrTmp.FieldByName('NumberChapter').AsString;

    EditNumberRow.Text := qrTmp.FieldByName('NumberRow').AsString;

    EditNumberEstimate.Text := qrTmp.FieldByName('NumberEstimate').AsString;
    EditNameEstimate.Text := qrTmp.FieldByName('NameEstimate').AsString;
    EditCompose.Text := qrTmp.FieldByName('Compose').AsString;
    EditPostCompose.Text := qrTmp.FieldByName('PostCompose').AsString;
    EditChecked.Text := qrTmp.FieldByName('Checked').AsVariant;
    EditPostChecked.Text := qrTmp.FieldByName('PostChecked').AsString;
    EditSetDrawing.Text := qrTmp.FieldByName('SetDrawing').AsString;

    EditingRecord(True);

    FormCardEstimate.ShowForm(IdObject, IdEstimate, TypeEstimate, TreeView);
  end;
end;

procedure TFormObjectsAndEstimates.PopupMenuEstimatesPopup(Sender: TObject);
begin
  PMEstimatesEdit.Enabled := False;
  PMEstimatesDelete.Enabled := False;
  PMEstimatesBasicData.Enabled := False;
  PMEstimateExpand.Enabled := False;
  PMEstimateCollapse.Enabled := False;

  PMEstimatesAddObject.Enabled := False;
  PMEstimatesAddLocal.Enabled := False;
  PMEstimatesAddPTM.Enabled := False;

  if TreeView.Items.Count = 0 then
  begin
    PMEstimatesAddObject.Enabled := True;
    Exit;
  end;

  PMEstimatesEdit.Enabled := True;
  PMEstimatesDelete.Enabled := True;
  PMEstimatesBasicData.Enabled := True;
  PMEstimateExpand.Enabled := True;
  PMEstimateCollapse.Enabled := True;

  if TypeEstimate = 2 then
  begin
    PMEstimatesAddObject.Enabled := True;
    PMEstimatesAddLocal.Enabled := True;
  end
  else if TypeEstimate = 1 then
    PMEstimatesAddPTM.Enabled := True;
end;

procedure TFormObjectsAndEstimates.StringGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
  State: TGridDrawState);
{ var
  i: Integer; }
begin
  // Так как свойство таблицы DefaultDrawing отключено (иначе ячейка таблицы будет обведена пунктирной линией)
  // необходимо самому прорисовывать шапку и все строки таблицы

  with (Sender as TStringGrid) do
  begin
    // Прорисовка шапки таблицы
    if ARow = 0 then
    begin
      Canvas.Brush.Color := PS.BackgroundHead;
      Canvas.FillRect(Rect);
      Canvas.Font.Color := PS.FontHead;
      Canvas.TextOut(Rect.Left + 3, Rect.Top + 3, Cells[ACol, ARow]);
    end
    else
    // Прорисовка всех остальных строк
    begin
      Canvas.Brush.Color := PS.BackgroundRows;
      Canvas.FillRect(Rect);
      Canvas.Font.Color := PS.FontRows;
      Canvas.TextOut(Rect.Left + 3, Rect.Top + 3, Cells[ACol, ARow]);
    end;

    // Для выделенной строки в активной (в фокусе) таблице
    if focused and (Row = ARow) and (Row > 0) then
    begin
      Canvas.Brush.Color := PS.BackgroundSelectRow;
      Canvas.FillRect(Rect);
      Canvas.Font.Color := PS.FontSelectRow;
      Canvas.TextOut(Rect.Left + 3, Rect.Top + 3, Cells[ACol, Row]);
    end
  end;
end;

procedure TFormObjectsAndEstimates.FillingActs;
begin
  qrActsEx.ParamByName('sm_id').AsInteger := IdEstimate;
  CloseOpen(qrActsEx);
end;

end.
