unit KC6;

interface

uses
  Forms, Dialogs, StdCtrls, ComCtrls, ExtCtrls, Grids, DBGrids, Classes,
  Controls, DB, SysUtils, Messages, Menus, Variants, Windows, Graphics, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.Samples.Spin, Vcl.Mask;

type
  TSplitter = class(ExtCtrls.TSplitter)
  private
    procedure Paint(); override;
  end;

type
  TFormKC6 = class(TForm)

    PanelObject: TPanel;
    LabelObject: TLabel;
    EditObject: TEdit;

    PanelTree: TPanel;
    TreeView: TTreeView;

    PanelKoef: TPanel;
    LabelKoef: TLabel;
    splTop: TSplitter;
    splBottom: TSplitter;

    PanelClient: TPanel;
    ImageSplitterTop: TImage;
    PanelBottomButton: TPanel;
    Button1: TButton;
    ButtonCancel: TButton;
    StringGridDataEstimates: TStringGrid;

    PanelBottom: TPanel;
    ImageSplitterBottom: TImage;
    qrTemp: TFDQuery;
    qrObjectEstimates: TFDQuery;
    qrLocalEstimates: TFDQuery;
    qrPTMEstimates: TFDQuery;
    qrDataEstimate: TFDQuery;
    qrCardRates: TFDQuery;
    qrMaterialCard: TFDQuery;
    qrMechanizmCard: TFDQuery;
    Label1: TLabel;
    EditKoef: TSpinEdit;
    qrOtherActs: TFDQuery;
    dsOtherActs: TDataSource;
    dbgrd1: TDBGrid;
    qrOtherActsNumber: TIntegerField;
    qrOtherActsdocname: TStringField;
    qrOtherActsdate: TDateField;
    qrOtherActsosnov: TStringField;
    qrOtherActscnt: TFMTBCDField;

    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);

    procedure MyShow(const vIdObject: Integer);
    procedure RepaintImagesForSplitters();
    procedure ButtonCancelClick(Sender: TObject);

    procedure GetNameObject;

    procedure QueryObjectEstimates;
    procedure QueryLocalEstimates;
    procedure QueryPTMEstimates;
    procedure FillingEstimates;

    procedure SettingTableRates;

    procedure FillingDataEstimate(const IdEstimate: Integer);
    procedure StringGridDataEstimatesDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
      State: TGridDrawState);
    procedure StringGridDataEstimatesClick(Sender: TObject);
    procedure StringGridDataEstimatesEnter(Sender: TObject);
    procedure TreeViewChange(Sender: TObject; Node: TTreeNode);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure PanelClientResize(Sender: TObject);
    procedure StringGridDataEstimatesMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer);
    procedure StringGridDataEstimatesMouseWheelDown(Sender: TObject; Shift: TShiftState; MousePos: TPoint;
      var Handled: Boolean);
    procedure StringGridDataEstimatesMouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint;
      var Handled: Boolean);
    procedure Button1Click(Sender: TObject);
    procedure CopyToAct(const vIdEstimate, vIdTypeData, vIdTables: Integer; const vCnt: Double);
    procedure StringGridDataEstimatesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure StringGridDataEstimatesKeyPress(Sender: TObject; var Key: Char);
    procedure TreeViewAdvancedCustomDrawItem(Sender: TCustomTreeView; Node: TTreeNode;
      State: TCustomDrawState; Stage: TCustomDrawStage; var PaintImages, DefaultDraw: Boolean);
    procedure AllocationRowInTable;
    procedure Label1Click(Sender: TObject);
    procedure EditKoefChange(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure qrOtherActsCalcFields(DataSet: TDataSet);
  private
    IdObject: Integer;
    nom: Integer;
    IdEstimateForSelection: Integer;
    procedure SetEstimateSelection;
    procedure RecalcOutCount;

  public
    procedure SelectDataEstimates(const idTypeData, IdTables: Integer; const cnt: Double);

  const
    Indent = '     ';

  end;

var
  FormKC6: TFormKC6;

implementation

uses Main, DataModule, DrawingTables, CalculationEstimate, Tools;

{$R *.dfm}

{ TSplitter }
procedure TSplitter.Paint();
begin
  // inherited;
  FormKC6.RepaintImagesForSplitters();
end;

function CtrlDown: Boolean;
var
  State: TKeyboardState;
begin
  GetKeyboardState(State);
  Result := ((State[vk_Control] and 128) <> 0);
end;

procedure TFormKC6.FormCreate(Sender: TObject);
begin
  // Загружаем изображения для сплиттеров
  with DM.ImageListHorozontalDots do
  begin
    GetIcon(0, ImageSplitterTop.Picture.Icon);
    GetIcon(0, ImageSplitterBottom.Picture.Icon);
  end;

  SettingTableRates;

  nom := 0;

  PanelBottom.Constraints.MinHeight := 100;
  PanelTree.Constraints.MinHeight := 100;
  // PanelClient.Constraints.MinHeight := 175;
  LoadDBGridSettings(dbgrd1);
end;

procedure TFormKC6.FormResize(Sender: TObject);
begin
  FixDBGridColumnsWidth(dbgrd1);
end;

procedure TFormKC6.FormShow(Sender: TObject);
begin
  // Настройка размеров и положения формы
  ClientWidth := FormMain.ClientWidth div 2;
  ClientHeight := FormMain.ClientHeight - 100;
  Top := 50;
  Left := ClientWidth div 2;
  // ----------------------------------------
  nom := 0;
  StringGridDataEstimates.SetFocus; // Устанавливаем фокус
end;

procedure TFormKC6.MyShow(const vIdObject: Integer);
begin
  IdObject := vIdObject;
  GetNameObject;
  FillingEstimates;
  Show;
end;

procedure TFormKC6.PanelClientResize(Sender: TObject);
begin
  AutoWidthColumn(StringGridDataEstimates, 1);
end;

procedure TFormKC6.qrOtherActsCalcFields(DataSet: TDataSet);
begin
  qrOtherActsNumber.Value := DataSet.RecNo;
end;

procedure TFormKC6.RecalcOutCount;
var
  ds: Char;
  i: Integer;
begin
  // Вычисляем остаток
  for i := 1 to StringGridDataEstimates.RowCount do
  begin
    StringGridDataEstimates.Cells[6, i] := MyFloatToStr(MyStrToFloatDef(StringGridDataEstimates.Cells[2, i],
      0) - MyStrToFloatDef(StringGridDataEstimates.Cells[4, i], 0) -
      MyStrToFloatDef(StringGridDataEstimates.Cells[5, i], 0));
  end;
end;

procedure TFormKC6.RepaintImagesForSplitters();
begin
  ImageSplitterTop.Top := splTop.Top;
  ImageSplitterTop.Left := splTop.Left + (splTop.Width - ImageSplitterTop.Width) div 2;

  ImageSplitterBottom.Top := splBottom.Top;
  ImageSplitterBottom.Left := splBottom.Left + (splBottom.Width - ImageSplitterBottom.Width) div 2;
end;

procedure TFormKC6.Button1Click(Sender: TObject);
var
  i: Integer;
begin
  if MessageBox(0, PChar('Перенести выделенные данные в акт?'), PWideChar(Caption),
    MB_ICONINFORMATION + MB_YESNO + mb_TaskModal) = mryes then
  begin
    qrTemp.SQL.Text := 'delete from data_act_temp;';
    qrTemp.ExecSQL;
    qrTemp.SQL.Text := 'delete from card_rate_temp;';
    qrTemp.ExecSQL;
    qrTemp.SQL.Text := 'delete from materialcard_temp;';
    qrTemp.ExecSQL;
    qrTemp.SQL.Text := 'delete from mechanizmcard_temp;';
    qrTemp.ExecSQL;
    qrTemp.SQL.Text := 'delete from devicescard_temp;';
    qrTemp.ExecSQL;
    qrTemp.SQL.Text := 'delete from dumpcard_temp;';
    qrTemp.ExecSQL;
    qrTemp.SQL.Text := 'delete from transpcard_temp;';
    qrTemp.ExecSQL;
    qrTemp.SQL.Text := 'delete from calculation_coef_temp;';
    qrTemp.ExecSQL;
    with StringGridDataEstimates do
      for i := 1 to RowCount - 1 do
        if (Cells[10, i] = '1') and (Cells[8, i] <> '') then
        begin
          CopyToAct(StrToInt(Cells[7, i]), StrToInt(Cells[8, i]), StrToInt(Cells[9, i]),
            MyStrToFloatDef(Cells[5, i], 0));
          // ShowMessage(Cells[7, i] + Cells[8, i] + Cells[9, i]);
        end;
  end;

  FormCalculationEstimate.OutputDataToTable(0);
end;

procedure TFormKC6.ButtonCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TFormKC6.GetNameObject;
begin
  try
    with qrTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT num, name FROM objcards WHERE obj_id = :obj_id;');
      ParamByName('obj_id').Value := IdObject;
      Active := True;

      EditObject.Text := IntToStr(FieldByName('num').AsInteger) + ' ' + FieldByName('name').AsString;
      Active := False;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('При получении имени и номера объекта возникла ошибка:' + sLineBreak + sLineBreak +
        E.Message), PWideChar(Caption), MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

procedure TFormKC6.Label1Click(Sender: TObject);
begin
  EditKoef.Value := 0;
end;

procedure TFormKC6.QueryObjectEstimates;
begin
  with qrObjectEstimates do
  begin
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT * FROM smetasourcedata WHERE sm_type = 2 and obj_id = :obj_id ORDER BY sm_number');
    ParamByName('obj_id').Value := IdObject;
    Active := True;
    First;
  end;
end;

procedure TFormKC6.QueryLocalEstimates;
begin
  with qrLocalEstimates do
  begin
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT * FROM smetasourcedata WHERE sm_type = 1 and parent_local_id = :parent_local_id and ' +
      'obj_id = :obj_id ORDER BY sm_number');
    ParamByName('parent_local_id').Value := qrObjectEstimates.FieldByName('sm_id').AsInteger;
    ParamByName('obj_id').Value := IdObject;
    Active := True;
    First;
  end;
end;

procedure TFormKC6.QueryPTMEstimates;
begin
  with qrPTMEstimates do
  begin
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT * FROM smetasourcedata WHERE sm_type = 3 and parent_ptm_id = :parent_ptm_id and ' +
      'obj_id = :obj_id ORDER BY sm_number');
    ParamByName('parent_ptm_id').Value := qrLocalEstimates.FieldByName('sm_id').AsInteger;
    ParamByName('obj_id').Value := IdObject;
    Active := True;
    First;
  end;
end;

procedure TFormKC6.FillingEstimates;
var
  n1, n2, n3: Integer;
begin
  TreeView.Items.Clear;

  // НАЧАЛО вывода ОБЪЕКТЫХ смет

  QueryObjectEstimates;

  with qrObjectEstimates do
    while not Eof do
    begin
      n1 := TreeView.Items.Add(Nil, FieldByName('sm_number').AsString + ' ' + FieldByName('name').AsString)
        .AbsoluteIndex;
      TreeView.Items.Item[n1].Data := Pointer(FieldByName('sm_id').AsInteger);

      // Вывод сметы в таблицу
      with StringGridDataEstimates do
      begin
        Inc(nom);
        // Cells[0, nom] := IntToStr(nom);
        // R Cells[1, nom] := 'Ж000';
        Cells[1, nom] := FieldByName('sm_number').AsString + ' ' + FieldByName('name').AsString;
        Cells[7, nom] := IntToStr(FieldByName('sm_id').AsInteger);
        Cells[10, nom] := '0';
      end;
      FillingDataEstimate(FieldByName('sm_id').AsInteger);
      // ---------- НАЧАЛО вывода ЛОКАЛЬНЫХ смет
      QueryLocalEstimates;
      with qrLocalEstimates do
        while not Eof do
        begin
          n2 := TreeView.Items.AddChild(TreeView.Items.Item[n1], FieldByName('sm_number').AsString + ' ' +
            FieldByName('name').AsString).AbsoluteIndex;
          TreeView.Items.Item[n2].Data := Pointer(FieldByName('sm_id').AsInteger);

          // Вывод сметы в таблицу
          with StringGridDataEstimates do
          begin
            Inc(nom);
            // Cells[0, nom] := IntToStr(nom);
            // R Cells[1, nom] := 'Ж000';
            Cells[1, nom] := FieldByName('sm_number').AsString + ' ' + FieldByName('name').AsString;
            // FieldByName('sm_number').AsString + ' ' + FieldByName('name').AsString;
            Cells[7, nom] := IntToStr(FieldByName('sm_id').AsInteger);
            Cells[10, nom] := '0';
          end;
          FillingDataEstimate(FieldByName('sm_id').AsInteger);
          // -------------------- НАЧАЛО вывода смет ПТМ
          QueryPTMEstimates;

          with qrPTMEstimates do
            while not Eof do
            begin
              n3 := TreeView.Items.AddChild(TreeView.Items.Item[n2], FieldByName('sm_number').AsString + ' ' +
                FieldByName('name').AsString).AbsoluteIndex;
              TreeView.Items.Item[n3].Data := Pointer(FieldByName('sm_id').AsInteger);

              // Вывод сметы в таблицу
              with StringGridDataEstimates do
              begin
                Inc(nom);
                // Cells[0, nom] := IntToStr(nom);
                Cells[1, nom] := FieldByName('sm_number').AsString;
                // + ' ' + FieldByName('name').AsString;
                Cells[7, nom] := IntToStr(FieldByName('sm_id').AsInteger);
                Cells[10, nom] := '0';
              end;
              FillingDataEstimate(FieldByName('sm_id').AsInteger);
              Next;
            end;
          // -------------------- КОНЕЦ вывода смет ПТМ
          Next;
        end;
      // ---------- КОНЕЦ вывода ЛОКАЛЬНЫХ смет
      Next;
    end;
  // КОНЕЦ вывода ОБЪЕКТЫХ смет
  TreeView.FullExpand;
  StringGridDataEstimates.RowCount := nom + 1;
end;

procedure TFormKC6.SelectDataEstimates(const idTypeData, IdTables: Integer; const cnt: Double);
var
  i: Integer;
  ds: Char;
begin

  // Процедура выделения строчки для редактируемого акта
  with StringGridDataEstimates do
    for i := 1 to RowCount - 1 do
      if (Cells[8, i] = IntToStr(idTypeData)) and (Cells[9, i] = IntToStr(IdTables)) then
      begin
        Cells[10, i] := '1';
        Cells[11, i] := '1';
        Cells[5, i] := MyFloatToStr(cnt);
        Cells[4, i] := MyFloatToStr(MyStrToFloatDef(Cells[4, i], 0) - cnt);
      end;
end;

procedure TFormKC6.SetEstimateSelection;
var
  i, indentSelCount: Integer;
begin
  with StringGridDataEstimates do
  begin
    Cells[10, Row] := IntToStr(1 - StrToInt(Cells[10, Row]));
    if (Cells[10, Row] = '0') then
      Cells[11, Row] := '0';
    // Если попали на подчиненную до двигаемся вверх по списку и выделяем корневую
    if (Pos(Indent, Cells[1, Row], 1) > 0) { and (Cells[10, Row] = '1') } then
    begin
      // считаем кол-во выделенных подчиненных
      indentSelCount := 0;
      for i := Row + 1 to RowCount - 1 do
        if Pos(Indent, Cells[1, i], 1) > 0 then
        begin
          if (Cells[10, i] = '1') then
            indentSelCount := indentSelCount + 1;
        end
        else
          Break;
      for i := Row downto 1 do
        if Pos(Indent, Cells[1, i], 1) > 0 then
        begin
          if (Cells[10, i] = '1') then
            indentSelCount := indentSelCount + 1;
          Continue;
        end
        else if (Cells[7, Row] = Cells[7, i]) and (((indentSelCount = 1) and (Cells[10, Row] = '1')) or
          (indentSelCount = 0)) then
        begin
          Cells[10, i] := Cells[10, Row];
          if (Cells[10, i] = '0') then
            Cells[11, i] := '0';
          Break;
        end;
    end
    // Иначе, двигаемся по списку вниз и выделяем подчиненные
    else
      for i := Row + 1 to RowCount - 1 do
      begin
        if Cells[7, i] <> Cells[7, Row] then
          Break;
        if ((Pos(Indent, Cells[1, i], 1) > 0) and (Pos(Indent, Cells[1, Row], 1) = 0)) or
          ((Cells[8, Row] = '') and (Cells[9, Row] = '')) then
        begin
          Cells[10, i] := Cells[10, Row];
          if (Cells[10, i] = '0') then
            Cells[11, i] := '0';
        end;
      end;
    Repaint;
  end;
end;

procedure TFormKC6.SettingTableRates;
begin
  with StringGridDataEstimates do
  begin
    ColCount := 12;
    RowCount := 100;

    Cells[0, 0] := '№ п/п';
    Cells[1, 0] := 'Обоснование';
    Cells[2, 0] := 'Кол-во';
    Cells[3, 0] := 'Ед. изм.';
    Cells[4, 0] := 'Выполнено';
    Cells[5, 0] := 'Процентовка';
    Cells[6, 0] := 'Остаток';
    Cells[7, 0] := 'IdEstimate';
    Cells[8, 0] := 'IdTypeData';
    Cells[9, 0] := 'IdTables';
    Cells[10, 0] := '';
    Cells[11, 0] := 'flFromEditAct';

    ColWidths[0] := 40;
    ColWidths[2] := 70;
    ColWidths[3] := 70;
    ColWidths[4] := 70;
    ColWidths[5] := 70;
    ColWidths[6] := 70;
    ColWidths[7] := -1;
    ColWidths[8] := -1;
    ColWidths[9] := -1;
    ColWidths[10] := 20; // Selected
    ColWidths[11] := -1; // flFromEditAct

    FixedCols := 1;
    FixedRows := 1;
  end;
end;

procedure TFormKC6.StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
  State: TGridDrawState);
begin
  DrawingTables.StringGridDrawCellDefault(Sender, ACol, ARow, Rect, State);
end;

procedure TFormKC6.StringGridDataEstimatesClick(Sender: TObject);
begin
  with StringGridDataEstimates do
  begin
    if (Col = 5) and (Cells[0, Row] <> '') then
      // Если находимся в столбце "Процентовка" и эта строка с данными
      Options := Options + [goEditing] // разрешаем редактирование
    else
      Options := Options - [goEditing]; // запрещаем редактирование

    if (Col = 10) and (Row > 0) then
      SetEstimateSelection;

    Repaint;
    IdEstimateForSelection := StrToInt(Cells[7, Row]); // Получаем ID сметы
  end;

  RecalcOutCount;

  // Заполнение смежных актов
  qrOtherActs.Active := False;
  qrOtherActs.ParamByName('idestimate').AsInteger := IdEstimateForSelection;
  qrOtherActs.ParamByName('p_osnov').AsString :=
    Trim(StringGridDataEstimates.Cells[1, StringGridDataEstimates.Row]);
  qrOtherActs.Active := True;
  qrOtherActs.Last;
  qrOtherActs.First;
  dbgrd1.Repaint;

  TreeView.Repaint;
end;

procedure TFormKC6.StringGridDataEstimatesDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
  State: TGridDrawState);
begin
  DrawingTables.StringGridDrawCellDefault(Sender, ACol, ARow, Rect, State);

  if (Sender.ClassName = 'TStringGrid') then
    with (Sender as TStringGrid) do
    begin
      // Выделение строки когда таблица находится не в фокусе
      if (ACol > 0) and (ARow = Row) and not Focused then
      begin
        Canvas.Brush.Color := PS.SelectRowUnfocusedTable;
        Canvas.FillRect(Rect);
        Canvas.TextOut(Rect.Left + 3, Rect.Top + 3, Cells[ACol, ARow]);
      end;

      // Выделение цветом выделенных строк
      if (ACol > 0) and (Cells[10, ARow] = '1') then
      begin
        Canvas.Brush.Color := RGB(140, 200, 125);
        Canvas.FillRect(Rect);
        Canvas.TextOut(Rect.Left + 3, Rect.Top + 3, Cells[ACol, ARow]);
      end;

      // Выделение цветом выделенных строк ранее добавленных
      if (ACol > 0) and (Cells[11, ARow] = '1') then
      begin
        Canvas.Brush.Color := RGB(140, 250, 125);
        Canvas.FillRect(Rect);
        Canvas.TextOut(Rect.Left + 3, Rect.Top + 3, Cells[ACol, ARow]);
      end;

      if (ACol > 0) and (ARow > 0) and (ARow <> Row) and (Cells[5, ARow] <> '') then

        if (MyStrToFloat(Cells[5, ARow]) > MyStrToFloat(Cells[2, ARow])) or (MyStrToFloat(Cells[2, ARow]) < 0)
        then
        // "Процентовка" > "Количество", или Количество < 0
        begin
          Canvas.Brush.Color := RGB(225, 128, 131);
          Canvas.FillRect(Rect);
          Canvas.TextOut(Rect.Left + 3, Rect.Top + 3, Cells[ACol, ARow]);
        end;
    end;

  // Прорисовка чекбокса
  if (ACol = 10) and (ARow > 0) then
    if (Sender as TStringGrid).Cells[10, ARow] = '1' then
      DrawGridCheckBox((Sender as TStringGrid).Canvas, Rect, True)
    else
      DrawGridCheckBox((Sender as TStringGrid).Canvas, Rect, False)
end;

procedure TFormKC6.StringGridDataEstimatesEnter(Sender: TObject);
begin
  StringGridDataEstimates.Repaint;
end;

procedure TFormKC6.StringGridDataEstimatesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_INSERT then
  begin
    SetEstimateSelection;
    if StringGridDataEstimates.Row < StringGridDataEstimates.RowCount - 1 then
      StringGridDataEstimates.Row := StringGridDataEstimates.Row + 1;
  end;
  // Запрещаем переход курсора на невидимые ячейки
  with (Sender as TStringGrid) do
    if (ColWidths[Col + 1] = -1) and (Key = Ord(#39)) then
      Key := Ord(#0);
end;

procedure TFormKC6.StringGridDataEstimatesKeyPress(Sender: TObject; var Key: Char);
begin
  with (Sender as TStringGrid) do
  begin
    if Col = 5 then // Выбран столбец "Процентовка"
    begin
      if not(Key in ['0' .. '9', #8, #13, ',', '.']) then
        Key := #0;

      if Key = ',' then
        Key := '.';
      // Разрешаем только одну точку
      if (Pos('.', Cells[5, Row], 1) > 0) and (Key = '.') then
        Key := #0;
      RecalcOutCount;
    end;
  end;
end;

procedure TFormKC6.StringGridDataEstimatesMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  if CtrlDown then
    SetEstimateSelection;
end;

procedure TFormKC6.StringGridDataEstimatesMouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  Handled := True;
  StringGridDataEstimates.Perform(WM_VSCROLL, SB_LINEDOWN, 0);
end;

procedure TFormKC6.StringGridDataEstimatesMouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint;
  var Handled: Boolean);
begin
  Handled := True;
  StringGridDataEstimates.Perform(WM_VSCROLL, SB_LINEUP, 0);
end;

procedure TFormKC6.TreeViewAdvancedCustomDrawItem(Sender: TCustomTreeView; Node: TTreeNode;
  State: TCustomDrawState; Stage: TCustomDrawStage; var PaintImages, DefaultDraw: Boolean);
begin
  if Integer(Node.Data) = IdEstimateForSelection then
  begin
    Sender.Canvas.Font.Color := clBlue;
    Sender.Canvas.Font.Style := Sender.Canvas.Font.Style + [fsItalic];
  end;
end;

procedure TFormKC6.TreeViewChange(Sender: TObject; Node: TTreeNode);
begin
  AllocationRowInTable;
end;

procedure TFormKC6.FillingDataEstimate(const IdEstimate: Integer);
var
  ds: Char;
begin
  try
    with qrDataEstimate do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT * FROM data_estimate WHERE id_estimate = :id_estimate ORDER BY 1;');
      ParamByName('id_estimate').Value := IdEstimate;
      Active := True;

      First;

      while not Eof do
      begin
        case FieldByName('id_type_data').AsInteger of
          1: // Выводим расценку
            try
              with qrCardRates do
              begin
                Active := False;
                SQL.Clear;
                SQL.Add('SELECT card_rate.*, (select sum(rate_count) from card_rate_act where id=:id) as cntDone FROM card_rate WHERE id = :id;');
                ParamByName('id').Value := qrDataEstimate.FieldByName('id_tables').AsInteger;
                Active := True;

                with StringGridDataEstimates do
                begin
                  Inc(nom);
                  Cells[0, nom] := IntToStr(nom);
                  Cells[1, nom] := FieldByName('rate_code').AsString;
                  Cells[2, nom] := MyFloatToStr(FieldByName('rate_count').AsFloat);
                  Cells[3, nom] := FieldByName('rate_unit').AsString;
                  Cells[4, nom] := MyFloatToStr(FieldByName('cntDone').AsFloat);
                  Cells[5, nom] := '0';
                  Cells[6, nom] := MyFloatToStr(FieldByName('rate_count').AsFloat - FieldByName('cntDone')
                    .AsFloat - MyStrToFloatDef(Cells[5, nom], 0));
                  Cells[7, nom] := IntToStr(qrDataEstimate.FieldByName('id_estimate').AsInteger);
                  Cells[8, nom] := '1';
                  Cells[9, nom] := IntToStr(FieldByName('id').AsInteger);
                  Cells[10, nom] := '0';
                end;
              end;

              // ----------------------------------------

              with qrMaterialCard do
              begin
                Active := False;
                SQL.Clear;
                SQL.Add('SELECT materialcard.*, (select sum(materialcard_act.mat_count) from materialcard_act where id_card_rate=:id_card_rate and materialcard_act.id=materialcard.id) as cntDone FROM materialcard WHERE id_card_rate = :id_card_rate ORDER BY 1;');
                ParamByName('id_card_rate').Value := qrCardRates.FieldByName('id').AsInteger;
                Active := True;

                // --------------------

                // Выводим все неучтённые материалы которые не были заменены
                Filtered := False;
                Filter := 'id_card_rate = ' + IntToStr(qrCardRates.FieldByName('id').AsInteger) +
                  ' and considered = 0 and replaced = 0';
                Filtered := True;

                First;

                while not Eof do
                begin
                  Inc(nom);
                  with StringGridDataEstimates do
                  begin
                    Cells[0, nom] := IntToStr(nom);
                    Cells[1, nom] := Indent + FieldByName('mat_code').AsString;
                    Cells[2, nom] := MyFloatToStr(FieldByName('mat_count').AsFloat);
                    Cells[3, nom] := FieldByName('mat_unit').AsString;
                    Cells[4, nom] := MyFloatToStr(FieldByName('cntDone').AsFloat);
                    Cells[5, nom] := '0';
                    Cells[6, nom] := MyFloatToStr(FieldByName('mat_count').AsFloat - FieldByName('cntDone')
                      .AsFloat - MyStrToFloatDef(Cells[5, nom], 0));
                    Cells[7, nom] := IntToStr(qrDataEstimate.FieldByName('id_estimate').AsInteger);
                    Cells[8, nom] := '2';
                    Cells[9, nom] := IntToStr(FieldByName('id').AsInteger);
                    Cells[10, nom] := '0';
                    // было пусто почему то...
                  end;
                  Next;
                end;

                // ----------------------------------------

                // Выводим все заменяющие материалы, т.е. материалы которыми были заменены неучтённые
                Filtered := False;
                Filter := 'id_card_rate = ' + IntToStr(qrCardRates.FieldByName('id').AsInteger) +
                  ' and considered = 1 and id_replaced > 0';
                Filtered := True;

                First;

                while not Eof do
                begin
                  Inc(nom);
                  with StringGridDataEstimates do
                  begin
                    Cells[0, nom] := IntToStr(nom);
                    Cells[1, nom] := FieldByName('mat_code').AsString;
                    Cells[2, nom] := MyFloatToStr(FieldByName('mat_count').AsFloat);
                    Cells[3, nom] := FieldByName('mat_unit').AsString;
                    Cells[4, nom] := MyFloatToStr(FieldByName('cntDone').AsFloat);
                    Cells[5, nom] := '0';
                    Cells[6, nom] := MyFloatToStr(FieldByName('mat_count').AsFloat - FieldByName('cntDone')
                      .AsFloat - MyStrToFloatDef(Cells[5, nom], 0));
                    Cells[7, nom] := IntToStr(qrDataEstimate.FieldByName('id_estimate').AsInteger);
                    Cells[8, nom] := '2';
                    Cells[9, nom] := IntToStr(FieldByName('id').AsInteger);
                    Cells[10, nom] := '0';
                  end;
                  Next;
                end;

                Filtered := False;
                Filter := '';
              end;
            except
              on E: Exception do
                MessageBox(0, PChar('При выводе расценки в таблицу возникла ошибка:' + sLineBreak + sLineBreak
                  + E.Message), PWideChar(Caption), MB_ICONERROR + MB_OK + mb_TaskModal);
            end;
          2: // Выводим материал
            try
              with qrMaterialCard do
              begin
                Active := False;
                SQL.Clear;
                SQL.Add('SELECT materialcard.*, (select sum(materialcard_act.mat_count) from materialcard_act where materialcard_act.id=:id1) as cntDone FROM materialcard WHERE id = :id1;');
                ParamByName('id1').Value := qrDataEstimate.FieldByName('id_tables').AsInteger;
                Active := True;

                with StringGridDataEstimates do
                begin
                  Inc(nom);
                  Cells[0, nom] := IntToStr(nom);
                  Cells[1, nom] := FieldByName('mat_code').AsString;
                  Cells[2, nom] := MyFloatToStr(FieldByName('mat_count').AsFloat);
                  Cells[3, nom] := FieldByName('mat_unit').AsString;
                  Cells[4, nom] := MyFloatToStr(FieldByName('cntDone').AsFloat);
                  Cells[5, nom] := '0';
                  Cells[6, nom] := MyFloatToStr(FieldByName('mat_count').AsFloat - FieldByName('cntDone')
                    .AsFloat - MyStrToFloatDef(Cells[5, nom], 0));
                  Cells[7, nom] := IntToStr(qrDataEstimate.FieldByName('id_estimate').AsInteger);
                  Cells[8, nom] := '2';
                  Cells[9, nom] := IntToStr(FieldByName('id').AsInteger);
                  Cells[10, nom] := '0';
                end;
              end;
            except
              on E: Exception do
                MessageBox(0, PChar('При выводе материала в таблицу возникла ошибка:' + sLineBreak +
                  sLineBreak + E.Message), PWideChar(Caption), MB_ICONERROR + MB_OK + mb_TaskModal);
            end;
          3: // Выводим механизм
            try
              with qrMechanizmCard do
              begin
                Active := False;
                SQL.Clear;
                SQL.Add('SELECT mechanizmcard.*, (select sum(mechanizmcard_act.mech_count) from mechanizmcard_act where mechanizmcard_act.id=:id) as cntDone FROM mechanizmcard WHERE id = :id;');
                ParamByName('id').Value := qrDataEstimate.FieldByName('id_tables').AsInteger;
                Active := True;

                with StringGridDataEstimates do
                begin
                  Inc(nom);
                  Cells[0, nom] := IntToStr(nom);
                  Cells[1, nom] := FieldByName('mech_code').AsString;
                  Cells[2, nom] := MyFloatToStr(FieldByName('mech_count').AsFloat);
                  Cells[3, nom] := FieldByName('mech_unit').AsString;
                  Cells[4, nom] := MyFloatToStr(FieldByName('cntDone').AsFloat);
                  Cells[5, nom] := '0';
                  Cells[6, nom] := MyFloatToStr(FieldByName('mech_count').AsFloat - FieldByName('cntDone')
                    .AsFloat - MyStrToFloatDef(Cells[5, nom], 0));
                  Cells[7, nom] := IntToStr(qrDataEstimate.FieldByName('id_estimate').AsInteger);
                  Cells[8, nom] := '3';
                  Cells[9, nom] := IntToStr(FieldByName('id').AsInteger);
                  Cells[10, nom] := '0';
                end;
              end;
            except
              on E: Exception do
                MessageBox(0, PChar('При выводе материала в таблицу возникла ошибка:' + sLineBreak +
                  sLineBreak + E.Message), PWideChar(Caption), MB_ICONERROR + MB_OK + mb_TaskModal);
            end;
          4: // Выводим оборудование
            try
              with qrTemp do
              begin
                Active := False;
                SQL.Clear;
                SQL.Add('SELECT devicescard.*, (select sum(devicescard_act.DEVICE_COUNT) from devicescard_act where devicescard_act.id=:id) as cntDone FROM devicescard WHERE id = :id;');
                ParamByName('id').Value := qrDataEstimate.FieldByName('id_tables').AsInteger;
                Active := True;

                with StringGridDataEstimates do
                begin
                  Inc(nom);
                  Cells[0, nom] := IntToStr(nom);
                  Cells[1, nom] := FieldByName('DEVICE_CODE').AsString;
                  Cells[2, nom] := MyFloatToStr(FieldByName('DEVICE_COUNT').AsFloat);
                  Cells[3, nom] := FieldByName('DEVICE_UNIT').AsString;
                  Cells[4, nom] := MyFloatToStr(FieldByName('cntDone').AsFloat);
                  Cells[5, nom] := '0';
                  Cells[6, nom] := MyFloatToStr(FieldByName('DEVICE_COUNT').AsFloat - FieldByName('cntDone')
                    .AsFloat - MyStrToFloatDef(Cells[5, nom], 0));
                  Cells[7, nom] := IntToStr(qrDataEstimate.FieldByName('id_estimate').AsInteger);
                  Cells[8, nom] := '4';
                  Cells[9, nom] := IntToStr(FieldByName('id').AsInteger);
                  Cells[10, nom] := '0';
                end;
              end;
            except
              on E: Exception do
                MessageBox(0, PChar('При выводе оборудования в таблицу возникла ошибка:' + sLineBreak +
                  sLineBreak + E.Message), PWideChar(Caption), MB_ICONERROR + MB_OK + mb_TaskModal);
            end;
          5: // Выводим вывоз мусора
            try
              with qrTemp do
              begin
                Active := False;
                SQL.Clear;
                SQL.Add('SELECT dumpcard.*, (select sum(dumpcard_act.DUMP_COUNT) from dumpcard_act where dumpcard_act.id=:id) as cntDone FROM dumpcard WHERE id = :id;');
                ParamByName('id').Value := qrDataEstimate.FieldByName('id_tables').AsInteger;
                Active := True;

                with StringGridDataEstimates do
                begin
                  Inc(nom);
                  Cells[0, nom] := IntToStr(nom);
                  Cells[1, nom] := FieldByName('DUMP_CODE_JUST').AsString;
                  Cells[2, nom] := MyFloatToStr(FieldByName('DUMP_COUNT').AsFloat);
                  Cells[3, nom] := FieldByName('DUMP_UNIT').AsString;
                  Cells[4, nom] := MyFloatToStr(FieldByName('cntDone').AsFloat);
                  Cells[5, nom] := '0';
                  Cells[6, nom] := MyFloatToStr(FieldByName('DUMP_COUNT').AsFloat - FieldByName('cntDone')
                    .AsFloat - MyStrToFloatDef(Cells[5, nom], 0));
                  Cells[7, nom] := IntToStr(qrDataEstimate.FieldByName('id_estimate').AsInteger);
                  Cells[8, nom] := '5';
                  Cells[9, nom] := IntToStr(FieldByName('id').AsInteger);
                  Cells[10, nom] := '0';
                end;
              end;
            except
              on E: Exception do
                MessageBox(0, PChar('При выводе оборудования в таблицу возникла ошибка:' + sLineBreak +
                  sLineBreak + E.Message), PWideChar(Caption), MB_ICONERROR + MB_OK + mb_TaskModal);
            end;
          6, 7, 8, 9: // Выводим транспортировку
            try
              with qrTemp do
              begin
                Active := False;
                SQL.Clear;
                SQL.Add('SELECT transpcard.*, (select sum(transpcard_act.TRANSP_COUNT) from transpcard_act where transpcard_act.id=:id) as cntDone FROM transpcard WHERE id = :id;');
                ParamByName('id').Value := qrDataEstimate.FieldByName('id_tables').AsInteger;
                Active := True;

                with StringGridDataEstimates do
                begin
                  Inc(nom);
                  Cells[0, nom] := IntToStr(nom);
                  Cells[1, nom] := FieldByName('TRANSP_CODE_JUST').AsString;
                  Cells[2, nom] := MyFloatToStr(FieldByName('TRANSP_COUNT').AsFloat);
                  Cells[3, nom] := FieldByName('CARG_UNIT').AsString;
                  Cells[4, nom] := MyFloatToStr(FieldByName('cntDone').AsFloat);
                  Cells[5, nom] := '0';
                  Cells[6, nom] := MyFloatToStr(FieldByName('TRANSP_COUNT').AsFloat - FieldByName('cntDone')
                    .AsFloat - MyStrToFloatDef(Cells[5, nom], 0));
                  Cells[7, nom] := IntToStr(qrDataEstimate.FieldByName('id_estimate').AsInteger);
                  Cells[8, nom] := FieldByName('TRANSP_TYPE').AsString;
                  Cells[9, nom] := IntToStr(FieldByName('id').AsInteger);
                  Cells[10, nom] := '0';
                end;
              end;
            except
              on E: Exception do
                MessageBox(0, PChar('При выводе оборудования в таблицу возникла ошибка:' + sLineBreak +
                  sLineBreak + E.Message), PWideChar(Caption), MB_ICONERROR + MB_OK + mb_TaskModal);
            end;
          10: // Выводим Е18
            begin
              with StringGridDataEstimates do
              begin
                Inc(nom);
                Cells[0, nom] := IntToStr(nom);
                Cells[1, nom] := 'Е18';
                Cells[2, nom] := '0'; // исправить
                Cells[3, nom] := '';
                Cells[4, nom] := ''; // исправить кол-во
                Cells[5, nom] := '0';
                Cells[6, nom] := '0';
                Cells[7, nom] := IntToStr(qrDataEstimate.FieldByName('id_estimate').AsInteger);
                Cells[8, nom] := '10';
                Cells[9, nom] := IntToStr(FieldByName('id').AsInteger);
                Cells[10, nom] := '0';
              end;
            end;
          11: // Выводим Е20
            begin
              with StringGridDataEstimates do
              begin
                Inc(nom);
                Cells[0, nom] := IntToStr(nom);
                Cells[1, nom] := 'Е20';
                Cells[2, nom] := '0'; // исправить
                Cells[3, nom] := '';
                Cells[4, nom] := '0'; // исправить кол-во
                Cells[5, nom] := '0';
                Cells[6, nom] := '0';
                Cells[7, nom] := IntToStr(qrDataEstimate.FieldByName('id_estimate').AsInteger);
                Cells[8, nom] := '11';
                Cells[9, nom] := IntToStr(FieldByName('id').AsInteger);
                Cells[10, nom] := '0';
              end;
            end;
        end;
        Next;
      end;
    end;
  except
    on E: Exception do
    begin
      MessageBox(0, PChar('При выводе данных всех смет текущего объекта возникла ошибка:' + sLineBreak +
        sLineBreak + E.Message), PWideChar(Caption), MB_ICONERROR + MB_OK + mb_TaskModal);
    end;
  end;
end;

procedure TFormKC6.CopyToAct(const vIdEstimate, vIdTypeData, vIdTables: Integer; const vCnt: Double);
begin
  try
    with qrTemp do
    begin
      SQL.Clear;
      SQL.Add('CALL DataToAct(:IdEstimate, :IdTypeData, :IdTables, :cnt);');
      ParamByName('IdEstimate').Value := vIdEstimate;
      ParamByName('IdTypeData').Value := vIdTypeData;
      ParamByName('IdTables').Value := vIdTables;
      ParamByName('cnt').Value := vCnt;
      ExecSQL;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('При занесении выделенных данные во временные таблицы возникла ошибка:' + sLineBreak
        + sLineBreak + E.Message), PWideChar(Caption), MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

procedure TFormKC6.EditKoefChange(Sender: TObject);
var
  i: Integer;
  ds: Char;
  fl: Boolean;
begin
  fl := False;
  with StringGridDataEstimates do
  begin
    Enabled := False;
    for i := 1 to RowCount - 1 do
      if Cells[10, i] = '1' then
      begin
        fl := True;
        Cells[5, i] := MyFloatToStr((EditKoef.Value / 100) * (MyStrToFloatDef(Cells[2, i],
          0) - MyStrToFloatDef(Cells[4, i], 0)));
        Cells[6, i] := MyFloatToStr(MyStrToFloatDef(Cells[2, i], 0) - MyStrToFloatDef(Cells[4, i], 0) -
          MyStrToFloatDef(Cells[5, i], 0));
      end;
    // Высчитываем на текущей строке
    if not fl then
    begin
      Cells[5, Row] := MyFloatToStr((EditKoef.Value / 100) * (MyStrToFloatDef(Cells[2, Row],
        0) - MyStrToFloatDef(Cells[4, Row], 0)));
      Cells[6, Row] := MyFloatToStr(MyStrToFloatDef(Cells[2, Row], 0) - MyStrToFloatDef(Cells[4, Row], 0) -
        MyStrToFloatDef(Cells[5, Row], 0));
    end;

    Enabled := True;
  end;
end;

procedure TFormKC6.AllocationRowInTable;
var
  i: Integer;
begin
  StringGridDataEstimates.Enabled := False;
  StringGridDataEstimates.Row := StringGridDataEstimates.RowCount - 1;
  with StringGridDataEstimates do
    for i := 1 to RowCount - 1 do
      if Integer(TreeView.Selected.Data) = StrToInt(Cells[7, i]) then
      begin
        Row := i;
        Break;
      end;
  StringGridDataEstimates.Enabled := True;
end;

end.
