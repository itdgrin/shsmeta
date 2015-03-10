unit ListCollections;

interface

uses
  Windows, SysUtils, Classes, Controls, Forms, StdCtrls, ExtCtrls, ComCtrls, DB, ShellAPI, Menus,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, System.Types;

type
  TFormListCollections = class(TForm)
    TreeView: TTreeView;
    PanelTop: TPanel;
    LabelPage: TLabel;
    EditPage: TEdit;
    PanelSostav: TPanel;
    MemoSostav: TMemo;
    PopupMenu: TPopupMenu;
    PMOpen: TMenuItem;
    LabelSearch: TLabel;
    EditSearch: TEdit;
    ButtonSearchUp: TButton;
    ButtonSearchDown: TButton;
    ADOQuerySbornik: TFDQuery;
    ADOQueryTemp: TFDQuery;
    ADOQueryRazdel: TFDQuery;
    ADOQueryPodrazdel: TFDQuery;
    ADOQueryTable: TFDQuery;

    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);

    procedure Sbornik;
    procedure Razdel(ParentNode: TTreeNode; SbornikId: Integer);
    procedure Podrazdel(ParentNode: TTreeNode; SbornikId, RazdelId: Integer);
    procedure Table(ParentNode: TTreeNode; SbornikId, RazdelId, PordazdelId: Integer);

    procedure SostavAndPage(Node: TTreeNode);

    procedure ExpandSbornik(RateNum: string);
    procedure ExpandRazdel(RateNum: string);
    procedure ExpandPodrazdel(RateNum: string);

    procedure TreeViewClick(Sender: TObject);
    procedure ExpandNodes;
    function ClearSbornikName(const Value: string): string;
    procedure TreeViewDblClick(Sender: TObject);
    procedure Filling(const vRateNum: string);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

    function GetSbornikId(const Value: string): Integer;
    function GetRazdelId(const vSbornikId: Integer; const Value: string): Integer;
    function GetPodRazdelId(const vSbornikId, vRazdelId: Integer; const Value: string): Integer;
    function GetTabIds(const vSbornikId, vRazdelId, vPodrazdelId: Integer): string;
    procedure PMOpenClick(Sender: TObject);
    procedure EditSearchKeyPress(Sender: TObject; var Key: Char);
    procedure Search(const Direction: Integer);
    procedure ButtonSearchDownClick(Sender: TObject);
    procedure ButtonSearchUpClick(Sender: TObject);

  private

  public
    RateNum: string;
    Open: Boolean;
  end;

var
  FormListCollections: TFormListCollections;

implementation

uses Main, DataModule, Waiting, ReferenceData, AdditionData, fFrameRates;

const
  FormCaption = 'Перечень сборников';

{$R *.dfm}

procedure TFormListCollections.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(FormReferenceData) then
    FormReferenceData.FrameRates.FilteredRates('')
  else if Assigned(FormAdditionData) then
    FormAdditionData.FrameRates.FilteredRates('');
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormListCollections.FormCreate(Sender: TObject);
begin
  Caption := FormCaption;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormListCollections.FormShow(Sender: TObject);
var
  Point1: TPoint;
begin
  if Assigned(FormReferenceData) then
  begin
    Width := FormReferenceData.Width - FormReferenceData.GetLeftIndentForFormSborniks -
      (GetSystemMetrics(SM_CXFRAME) * 2);
    Height := FormReferenceData.Height - FormReferenceData.GetTopIndentForFormSborniks - 19;

    Point1 := FormMain.ClientToScreen(Point(FormReferenceData.Left, FormReferenceData.Top));

    Left := Point1.X + FormReferenceData.GetLeftIndentForFormSborniks + GetSystemMetrics(SM_CXFRAME);
    Top := Point1.Y + FormReferenceData.GetTopIndentForFormSborniks;

    // Exit;
  end
  else if Assigned(FormAdditionData) then
  begin
    Point1 := FormMain.ClientToScreen(Point(FormAdditionData.Left, FormAdditionData.Top));

    Left := Point1.X + 5 + GetSystemMetrics(SM_CYBORDER) + FormAdditionData.FrameRates.vst.Width + 5;
    Top := Point1.Y + 2 + GetSystemMetrics(SM_CYCAPTION) + FormAdditionData.FrameRates.Top +
      FormAdditionData.FrameRates.MemoDescription.Top;

    Width := Screen.Width - Left - 3;
    Height := FormAdditionData.Height - (GetSystemMetrics(SM_CYCAPTION) + FormAdditionData.FrameRates.Top +
      FormAdditionData.FrameRates.MemoDescription.Top);
  end;

  // WindowState := wsMaximized;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormListCollections.Sbornik;
var
  RootNode: TTreeNode;
begin
  try
    with ADOQuerySbornik do
    begin
      First;

      while not Eof do
      begin
        Application.ProcessMessages;

        RootNode := TreeView.Items.Add(Nil, FieldByName('sbornik_type').asString +
          ClearSbornikName(FieldByName('sbornik_name').asString) + ' - ' + FieldByName('sbornik_caption')
          .asString);

        Razdel(RootNode, FieldByName('sbornik_id').AsInteger);

        Next;
      end;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('При получении сборников возникла ошибка:' + sLineBreak + E.Message), FormCaption,
        MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormListCollections.Razdel(ParentNode: TTreeNode; SbornikId: Integer);
var
  NextParentNode: TTreeNode;
begin
  try
    with ADOQueryRazdel do
    begin
      Filtered := False;
      Filter := 'sbornik_id = ' + IntToStr(SbornikId);
      Filtered := True;

      First;

      while not Eof do
      begin
        Application.ProcessMessages;

        NextParentNode := TreeView.Items.AddChild(ParentNode, FieldByName('razd_name').asString + ' - ' +
          FieldByName('razd_caption').asString);

        Podrazdel(NextParentNode, SbornikId, FieldByName('razd_id').AsInteger);

        Next;
      end;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('При получении разделов сборника возникла ошибка:' + sLineBreak + E.Message),
        FormCaption, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormListCollections.Podrazdel(ParentNode: TTreeNode; SbornikId, RazdelId: Integer);
var
  NextParentNode: TTreeNode;
begin
  try
    with ADOQueryPodrazdel do
    begin
      Filtered := False;
      Filter := 'sbornik_id = ' + IntToStr(SbornikId) + ' and razd_id = ' + IntToStr(RazdelId);
      Filtered := True;

      First;

      while not Eof do
      begin
        Application.ProcessMessages;

        NextParentNode := TreeView.Items.AddChild(ParentNode, FieldByName('podrazd_name').asString + ' - ' +
          FieldByName('podrazd_caption').asString);

        FormListCollections.Table(NextParentNode, SbornikId, RazdelId, FieldByName('podrazd_id').AsInteger);

        Next;
      end;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('При получении подразделов сборника возникла ошибка:' + sLineBreak + E.Message),
        FormCaption, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormListCollections.Table(ParentNode: TTreeNode; SbornikId, RazdelId, PordazdelId: Integer);
begin
  try
    with ADOQueryTable do
    begin
      Filtered := False;
      Filter := 'sbornik_id = ' + IntToStr(SbornikId) + ' and razd_id = ' + IntToStr(RazdelId) +
        ' and podrazd_id = ' + IntToStr(PordazdelId);
      Filtered := True;

      First;

      while not Eof do
      begin
        Application.ProcessMessages;

        TreeView.Items.AddChild(ParentNode, FieldByName('tab_name').asString + ' - ' +
          FieldByName('tab_caption').asString);

        Next;
      end;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('При получении таблиц сборника возникла ошибка:' + sLineBreak + E.Message),
        FormCaption, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormListCollections.SostavAndPage(Node: TTreeNode);
var
  TabId: Integer;
begin
  try
    with ADOQueryTemp do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT tab_id, tab_name, page FROM tab WHERE tab_name = :tn;');
      ParamByName('tn').Value := Copy(Node.Text, 1, Pos(' - ', Node.Text) - 1);
      Active := True;

      TabId := FieldByName('tab_id').AsInteger;
      EditPage.Text := FieldByName('page').asString;

      // ----------------------------------------

      Active := False;
      SQL.Clear;
      SQL.Add('SELECT * FROM sostav WHERE tab_id = :ti ORDER BY sostav_id;');
      ParamByName('ti').Value := TabId;
      Active := True;
      First;

      MemoSostav.Lines.Clear;

      while not Eof do
      begin
        MemoSostav.Lines.Add(FieldByName('sostav_name').asString);

        Next;
      end;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('При получении состава работ и номера страницы возникла ошибка:' + sLineBreak +
        E.Message), FormCaption, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormListCollections.ExpandSbornik(RateNum: string);
var
  SbornikNum, SbornikNumTemp: string;
  Node: TTreeNode;
begin
  SbornikNum := Copy(RateNum, 1, Pos('-', RateNum) - 1);

  Node := TreeView.Items.Item[0];
  SbornikNumTemp := Copy(Node.Text, 1, Pos(' - ', Node.Text) - 1);

  while SbornikNum <> SbornikNumTemp do
  begin
    Node := Node.getNextSibling;
    SbornikNumTemp := Copy(Node.Text, 1, Pos(' - ', Node.Text) - 1);
  end;

  Node.Expand(False); // Раскрываем узел
  TreeView.Selected := Node.getFirstChild; // Выделяем первыый дочерний узел в раскрытом узле
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormListCollections.ExpandRazdel(RateNum: string);
var
  RazdelName, RazdelNameTemp: string;
  Node: TTreeNode;
begin
  with ADOQueryTemp do
  begin
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT DISTINCT razd_name FROM razdel, (SELECT sbornik_id, razd_id FROM normativg WHERE norm_num = :nn) rate '
      + 'WHERE razdel.sbornik_id = rate.sbornik_id and razdel.razd_id = rate.razd_id;');
    ParamByName('nn').Value := RateNum;
    Active := True;

    RazdelName := FieldByName('razd_name').asString;
  end;

  Node := TreeView.Selected;
  RazdelNameTemp := Copy(Node.Text, 1, Pos(' - ', Node.Text) - 1);

  while RazdelName <> RazdelNameTemp do
  begin
    Node := Node.getNextSibling;
    RazdelNameTemp := Copy(Node.Text, 1, Pos(' - ', Node.Text) - 1);
  end;

  Node.Expand(False); // Раскрываем узел
  TreeView.Selected := Node.getFirstChild; // Выделяем первыый дочерний узел в раскрытом узле
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormListCollections.ExpandPodrazdel(RateNum: string);
var
  PodrazdelName, PodrazdelNameTemp: string;
  Node: TTreeNode;
begin
  with ADOQueryTemp do
  begin
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT podrazd_name FROM razdel, (SELECT sbornik_id, razd_id, tab_id FROM normativg WHERE norm_num = :nn) rate, '
      + '(SELECT podrazd_id FROM tab WHERE tab_id = rate.tab_id) podrazd_id' +
      'WHERE razdel.sbornik_id = rate.sbornik_id and razdel.razd_id = rate.razd_id;');
    ParamByName('nn').Value := RateNum;
    Active := True;

    PodrazdelName := FieldByName('razd_name').asString;
  end;

  Node := TreeView.Selected;
  PodrazdelNameTemp := Copy(Node.Text, 1, Pos(' - ', Node.Text) - 1);

  while PodrazdelName <> PodrazdelNameTemp do
  begin
    Node := Node.getNextSibling;
    PodrazdelNameTemp := Copy(Node.Text, 1, Pos(' - ', Node.Text) - 1);
  end;

  Node.Expand(False); // Раскрываем узел
  TreeView.Selected := Node.getFirstChild; // Выделяем первыый дочерний узел в раскрытом узле
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormListCollections.TreeViewClick(Sender: TObject);
var
  str: string;
  IdSbornik, IdRazdel, PodrazdId: Integer;
begin
  if TreeView.Selected.Count = 0 then
    SostavAndPage(TreeView.Selected);

  str := TreeView.Selected.Text;
  str := Copy(str, 1, Pos(' - ', str) - 1);

  if (str[1] = 'Е') or (str[1] = 'Ц') then // Сборник
  begin
    str := 'NumberNormative LIKE ''' + str + '-%''';

    if Assigned(FormReferenceData) then
      FormReferenceData.FrameRates.FilteredRates(str)
    else if Assigned(FormAdditionData) then
      FormAdditionData.FrameRates.FilteredRates(str);
  end
  else if (Pos('Раздел', str) = 1) or (Pos('Отдел', str) = 1) then // Раздел
  begin
    IdSbornik := GetSbornikId(TreeView.Selected.Parent.Text);
    IdRazdel := GetRazdelId(IdSbornik, TreeView.Selected.Text);

    str := TreeView.Selected.Parent.Text;
    str := Copy(str, 1, Pos(' - ', str) - 1);

    str := 'NumberNormative LIKE ''' + str + '-%'' and razd_id = ' + IntToStr(IdRazdel);

    if Assigned(FormReferenceData) then
      FormReferenceData.FrameRates.FilteredRates(str)
    else if Assigned(FormAdditionData) then
      FormAdditionData.FrameRates.FilteredRates(str);
  end
  else if (Pos('Таблица', str) = 1) or (Pos('Группа', str) = 1) then // Таблица
  begin
    if (Pos('Таблица', str) = 1) then
    begin
      Delete(str, 1, 8);
      str := 'NumberNormative LIKE ''Е' + str + '-%''';
    end
    else
    begin
      IdSbornik := GetSbornikId(TreeView.Selected.Parent.Parent.Parent.Text);
      IdRazdel := GetRazdelId(IdSbornik, TreeView.Selected.Parent.Parent.Text);

      PodrazdId := GetPodRazdelId(IdSbornik, IdRazdel, TreeView.Selected.Parent.Text);
      str := 'sbornik_id = ' + IntToStr(IdSbornik) + ' and razd_id = ' + IntToStr(IdRazdel) + ' and ' +
        GetTabIds(IdSbornik, IdRazdel, PodrazdId);
    end;

    if Assigned(FormReferenceData) then
      FormReferenceData.FrameRates.FilteredRates(str)
    else if Assigned(FormAdditionData) then
      FormAdditionData.FrameRates.FilteredRates(str);
  end
  else // Подраздел
  begin
    IdSbornik := GetSbornikId(TreeView.Selected.Parent.Parent.Text);
    IdRazdel := GetRazdelId(IdSbornik, TreeView.Selected.Parent.Text);

    PodrazdId := GetPodRazdelId(IdSbornik, IdRazdel, TreeView.Selected.Text);
    str := 'sbornik_id = ' + IntToStr(IdSbornik) + ' and razd_id = ' + IntToStr(IdRazdel) + ' and ' +
      GetTabIds(IdSbornik, IdRazdel, PodrazdId);

    if Assigned(FormReferenceData) then
      FormReferenceData.FrameRates.FilteredRates(str)
    else if Assigned(FormAdditionData) then
      FormAdditionData.FrameRates.FilteredRates(str);
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormListCollections.TreeViewDblClick(Sender: TObject);
var
  NumberNormativ: String;
  FirstChar: Char;
  Path: String;
begin
  NumberNormativ := RateNum;

  // В условии - русские символы, в переменной NumberNormativ - английские
  if (NumberNormativ > 'Е121-1-1') and (NumberNormativ < 'Е121-137-1') then
    NumberNormativ := 'E121_p1'
  else if (NumberNormativ > 'Е121-141-1') and (NumberNormativ < 'Е121-222-2') then
    NumberNormativ := 'E121_p2'
  else if (NumberNormativ > 'Е121-241-1') and (NumberNormativ < 'Е121-439-8') then
    NumberNormativ := 'E121_p3'
  else if (NumberNormativ > 'Е121-451-1') and (NumberNormativ < 'Е121-639-1') then
    NumberNormativ := 'E121_p4'
  else if (NumberNormativ > 'Е29-6-1') and (NumberNormativ < 'Е29-92-12') then
    NumberNormativ := 'E29_p1'
  else if (NumberNormativ > 'Е29-93-1') and (NumberNormativ < 'Е29-277-1') then
    NumberNormativ := 'E29_p2'
  else if (NumberNormativ > 'Е35-9-1') and (NumberNormativ < 'Е35-233-2') then
    NumberNormativ := 'E35_p1'
  else if (NumberNormativ > 'Е35-234-1') and (NumberNormativ < 'Е35-465-1') then
    NumberNormativ := 'E35_p2'
  else if (NumberNormativ > 'Ц12-1-1') and (NumberNormativ < 'Ц12-331-3') then
    NumberNormativ := 'C12_p1'
  else if (NumberNormativ > 'Ц12-362-1') and (NumberNormativ < 'Ц12-1314-10') then
    NumberNormativ := 'C12_p2'
  else if (NumberNormativ > 'Ц13-1-1') and (NumberNormativ < 'Ц13-230-7') then
    NumberNormativ := 'C13_p1'
  else if (NumberNormativ > 'Ц13-250-1') and (NumberNormativ < 'Ц13-383-3') then
    NumberNormativ := 'C13_p2'
  else if (NumberNormativ > 'Ц8-1-1') and (NumberNormativ < 'Ц8-477-1') then
    NumberNormativ := 'C8_p1'
  else if (NumberNormativ > 'Ц8-481-1') and (NumberNormativ < 'Ц8-914-3') then
    NumberNormativ := 'C8_p2'
  else
  begin
    FirstChar := NumberNormativ[1];

    Delete(NumberNormativ, 1, 1);

    // В условии - русские символы, в переменной NumberNormativ - английские
    if FirstChar = 'Е' then
      NumberNormativ := 'E' + NumberNormativ
    else if FirstChar = 'С' then
      NumberNormativ := 'C' + NumberNormativ;

    // Удаляем символы начиная с первого символа '-' и до конца строки
    Delete(NumberNormativ, Pos('-', NumberNormativ), Length(NumberNormativ) - Pos('-', NumberNormativ) + 1);
  end;

  Path := ExtractFilePath(Application.ExeName) + 'Normative documents\' + NumberNormativ + '\data.doc';

  if not FileExists(Path) then
  begin
    MessageBox(0, PChar('Вы пытаетесь открыть файл:' + sLineBreak + sLineBreak + Path + sLineBreak +
      sLineBreak + 'которого не существует!'), FormCaption, MB_ICONWARNING + MB_OK + mb_TaskModal);
    Exit;
  end;

  ShellExecute(FormListCollections.Handle, nil, PChar(Path), nil, nil, SW_SHOWMAXIMIZED);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormListCollections.EditSearchKeyPress(Sender: TObject; var Key: Char);
begin
  with (Sender as TEdit) do
    if (Key = #13) and (EditSearch.Text <> '') then // Если нажата клавиша "Enter" и строка поиска не пуста
      Search(0)
    else if (Key = #27) then // Нажата клавиша ESC
    begin
      EditSearch.Text := '';
    end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormListCollections.ExpandNodes;
var
  TabName, TabNameTemp: string;
  Node: TTreeNode;
  i, Count: Integer;
begin
  TreeView.FullCollapse;

  with ADOQueryTemp do
  begin
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT tab_name FROM tab WHERE tab_id = (SELECT tab_id FROM normativg WHERE norm_num = :nn);');
    ParamByName('nn').Value := RateNum;
    Active := True;

    TabName := FieldByName('tab_name').asString;
  end;

  Node := TreeView.Items.Item[0];
  TabNameTemp := Copy(Node.Text, 1, Pos(' - ', Node.Text) - 1);

  i := 0;
  Count := TreeView.Items.Count - 1;

  while TabName <> TabNameTemp do
  begin
    if (i = Count) then
    begin
      MessageBox(0, PChar('Справочник не найден!'), FormCaption, MB_ICONWARNING + MB_OK + mb_TaskModal);
      Open := False;
      Exit;
    end;

    Inc(i);

    Node := Node.getNext;
    TabNameTemp := Copy(Node.Text, 1, Pos(' - ', Node.Text) - 1);
  end;

  TreeView.Selected := Node;
  Node := Node.Parent;

  while Node.Parent <> nil do
  begin
    Node.Expand(False); // Раскрываем узел
    Node := Node.Parent;
  end;

  TreeViewClick(TreeView);

  Open := True;

  // ExpandSbornik('Е11-53-1');
  // ExpandRazdel('Е11-53-1');
  // ExpandPodrazdel('Е11-53-1');
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormListCollections.ButtonSearchDownClick(Sender: TObject);
begin
  Search(1);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormListCollections.ButtonSearchUpClick(Sender: TObject);
begin
  Search(-1);
end;

// ---------------------------------------------------------------------------------------------------------------------

function TFormListCollections.ClearSbornikName(const Value: string): string;
var
  str: string;
begin
  str := Value;
  Delete(str, 1, 8);
  Delete(str, Length(str) - 1, 2);
  Result := str;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormListCollections.Filling(const vRateNum: string);
begin
  RateNum := vRateNum;

  if FormListCollections.TreeView.Items.Count > 0 then
  begin
    ExpandNodes;
    Exit;
  end;

  FormMain.PanelCover.Visible := True;
  FormWaiting.Show;
  Application.ProcessMessages;

  with FormListCollections.ADOQuerySbornik do
  begin
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT * FROM sbornik ORDER BY 1;');
    Active := True;
  end;

  with FormListCollections.ADOQueryRazdel do
  begin
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT DISTINCT sbornik_id, razd_id, razd_name, razd_caption FROM razdel ' +
      'WHERE not razd_name = "" ORDER BY 1, 2;');
    Active := True;
  end;

  with FormListCollections.ADOQueryPodrazdel do
  begin
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT sbornik_id, razd_id, podrazd_id, podrazd_name, podrazd_caption FROM razdel ' +
      'WHERE podrazd_id > 0 ORDER BY 1, 2, 3;');
    Active := True;
  end;

  with FormListCollections.ADOQueryTable do
  begin
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT sbornik_id, razd_id, podrazd_id, tab_id, tab_name, tab_caption, page FROM tab ' +
      'ORDER BY 1, 2, 3, 4;');
    Active := True;
  end;

  with FormListCollections do
  begin
    Sbornik;
    ExpandNodes;

    ADOQuerySbornik.Active := False;
    ADOQueryRazdel.Active := False;
    ADOQueryPodrazdel.Active := False;
    ADOQueryTable.Active := False;
  end;

  FormWaiting.Close;
  FormMain.PanelCover.Visible := False;

  Application.ProcessMessages;

  // FormListCollections.Left := FormMain.Left + (FormMain.Width - FormListCollections.Width) div 2;;
end;

// ---------------------------------------------------------------------------------------------------------------------

function TFormListCollections.GetSbornikId(const Value: string): Integer;
var
  str: string;
  ch: Char;
begin
  str := Copy(Value, 1, Pos(' - ', Value) - 1);

  ch := str[1];
  Delete(str, 1, 1);
  str := 'Сборник ' + str + '.';

  with ADOQueryTemp do
  begin
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT sbornik_id FROM sbornik WHERE sbornik_name = :sbornik_name and sbornik_type = :sbornik_type;');
    ParamByName('sbornik_name').Value := str;
    ParamByName('sbornik_type').Value := ch;
    Active := True;

    Result := FieldByName('sbornik_id').AsInteger;
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

function TFormListCollections.GetRazdelId(const vSbornikId: Integer; const Value: string): Integer;
var
  str: string;
begin
  str := Copy(Value, 1, Pos(' - ', Value) - 1);

  with ADOQueryTemp do
  begin
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT DISTINCT razd_id FROM razdel WHERE sbornik_id = :sbornik_id and razd_name = :razd_name;');
    ParamByName('sbornik_id').Value := vSbornikId;
    ParamByName('razd_name').Value := str;
    Active := True;

    Result := FieldByName('razd_id').AsInteger;
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

function TFormListCollections.GetPodRazdelId(const vSbornikId, vRazdelId: Integer;
  const Value: string): Integer;
var
  str: string;
begin
  str := Copy(Value, 1, Pos(' - ', Value) - 1);

  with ADOQueryTemp do
  begin
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT DISTINCT podrazd_id FROM razdel WHERE sbornik_id = :sbornik_id and razd_id = :razd_id ' +
      'and podrazd_name = :podrazd_name;');
    ParamByName('sbornik_id').Value := vSbornikId;
    ParamByName('razd_id').Value := vRazdelId;
    ParamByName('podrazd_name').Value := str;
    Active := True;

    Result := FieldByName('podrazd_id').AsInteger;
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

function TFormListCollections.GetTabIds(const vSbornikId, vRazdelId, vPodrazdelId: Integer): string;
var
  str: string;
begin
  with ADOQueryTemp do
  begin
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT min(tab_id) as "min", max(tab_id) as "max" FROM tab WHERE sbornik_id = :sbornik_id and razd_id = :razd_id and podrazd_id = :podrazd_id;');
    ParamByName('sbornik_id').Value := vSbornikId;
    ParamByName('razd_id').Value := vRazdelId;
    ParamByName('podrazd_id').Value := vPodrazdelId;
    Active := True;

    // First;

    // str := '';

    // while not Eof do
    // begin
    str := 'tab_id >= ' + IntToStr(FieldByName('min').AsInteger) + ' and tab_id <= ' +
      IntToStr(FieldByName('max').AsInteger);
    // Next;
    // end;
  end;

  // Delete(str, Length(str) - 3, 4);

  Result := str;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormListCollections.PMOpenClick(Sender: TObject);
begin
  TreeViewDblClick(TreeView);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormListCollections.Search(const Direction: Integer);
var
  StringSearch: String;
  CountWords, i, j: Integer;
  Words: array of String;
  Coincides: Integer;
begin
  StringSearch := EditSearch.Text;

  // Если в конце нет пробела, ставим
  if Length(StringSearch) > 0 then
    if StringSearch[Length(StringSearch)] <> ' ' then
      StringSearch := StringSearch + ' ';

  CountWords := 0; // Обнуляем счётчик количества слов

  // Подсчитываем количество пробелов (столько же будет и слов)
  for i := 1 to Length(StringSearch) do
    if StringSearch[i] = ' ' then
      Inc(CountWords);

  SetLength(Words, CountWords); // Создаём массив для слов

  i := 0;

  // Заносим слова в массив
  while Pos(' ', StringSearch) > 0 do
  begin
    Words[i] := Copy(StringSearch, 1, Pos(' ', StringSearch) - 1);
    Delete(StringSearch, 1, Pos(' ', StringSearch));
    Inc(i);
  end;

  case Direction of
    0: // Поиск вниз начиная с самого первого узла
      begin
        for i := 0 to TreeView.Items.Count - 1 do // Цикл по узлам дерева
        begin
          Coincides := 0; // Количество совпавших слов

          for j := 0 to CountWords - 1 do // Цикл по словам
            if Pos(WideLowerCase(Words[j]), WideLowerCase(TreeView.Items.Item[i].Text)) > 0 then
              Inc(Coincides);

          if Coincides = CountWords then // Если все слова совпали
          begin
            TreeView.Selected := TreeView.Items.Item[i];
            TreeView.SetFocus;
            Exit;
          end;
        end;

        MessageBox(0, PChar('Совпадений не найдено!'), FormCaption, MB_ICONWARNING + MB_OK + mb_TaskModal);
      end;
    1: // Поиск вниз начиная с текущего узла
      begin
        for i := TreeView.Selected.AbsoluteIndex + 1 to TreeView.Items.Count - 1 do // Цикл по узлам дерева
        begin
          Coincides := 0; // Количество совпавших слов

          for j := 0 to CountWords - 1 do // Цикл по словам
            if Pos(WideLowerCase(Words[j]), WideLowerCase(TreeView.Items.Item[i].Text)) > 0 then
              Inc(Coincides);

          if Coincides = CountWords then // Если все слова совпали
          begin
            TreeView.Selected := TreeView.Items.Item[i];
            TreeView.SetFocus;
            Exit;
          end;
        end;

        MessageBox(0, PChar('Достигнут последний элемент дерева, совпадений не найдено!'), FormCaption,
          MB_ICONWARNING + MB_OK + mb_TaskModal);
      end;
    -1: // Поиск вверх начиная с текущего узла
      begin
        for i := TreeView.Selected.AbsoluteIndex - 1 downto 0 do // Цикл по узлам дерева
        begin
          Coincides := 0; // Количество совпавших слов

          for j := 0 to CountWords - 1 do // Цикл по словам
            if Pos(WideLowerCase(Words[j]), WideLowerCase(TreeView.Items.Item[i].Text)) > 0 then
              Inc(Coincides);

          if Coincides = CountWords then // Если все слова совпали
          begin
            TreeView.Selected := TreeView.Items.Item[i];
            TreeView.SetFocus;
            Exit;
          end;
        end;

        MessageBox(0, PChar('Достигнут первый элемент дерева, совпадений не найдено!'), FormCaption,
          MB_ICONWARNING + MB_OK + mb_TaskModal);
      end;
  end;
end;

end.





