unit NormativDirectory;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Vcl.ComCtrls, JvExComCtrls, JvDBTreeView, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids,
  Vcl.DBGrids, JvExDBGrids, JvDBGrid, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Menus, ShellAPI, Vcl.Mask, Vcl.DBCtrls;

type
  TfNormativDirectory = class(TForm)
    qrMain: TFDQuery;
    dsMain: TDataSource;
    tvMain: TJvDBTreeView;
    grSostav: TJvDBGrid;
    spl1: TSplitter;
    qrDetail: TFDQuery;
    dsDetail: TDataSource;
    pnl1: TPanel;
    edtSearch: TEdit;
    lbl1: TLabel;
    btnSearchUp: TButton;
    btnSearchDown: TButton;
    pm1: TPopupMenu;
    mN1: TMenuItem;
    mN2: TMenuItem;
    mN3: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure tvMainDblClick(Sender: TObject);
    procedure tvMainChange(Sender: TObject; Node: TTreeNode);
    procedure btnSearchUpClick(Sender: TObject);
    procedure btnSearchDownClick(Sender: TObject);
    procedure edtSearchKeyPress(Sender: TObject; var Key: Char);
    procedure mN1Click(Sender: TObject);
    procedure mN2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure Search(const Direction: Integer);
  public
    skipReload: Boolean;
    function getChildList(const RootID: Integer): string;
  end;

var
  fNormativDirectory: TfNormativDirectory;

implementation

uses DataModule, Tools, ReferenceData, AdditionData, Main;
{$R *.dfm}

procedure TfNormativDirectory.btnSearchDownClick(Sender: TObject);
begin
  Search(1);
end;

procedure TfNormativDirectory.btnSearchUpClick(Sender: TObject);
begin
  Search(-1);
end;

procedure TfNormativDirectory.edtSearchKeyPress(Sender: TObject; var Key: Char);
begin
  with (Sender as TEdit) do
    if (Key = #13) and (edtSearch.Text <> '') then // Если нажата клавиша "Enter" и строка поиска не пуста
    begin
      Search(0)
    end
    else if (Key = #27) then // Нажата клавиша ESC
    begin
      edtSearch.Text := '';
    end;
end;

procedure TfNormativDirectory.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(FormReferenceData) then
    FormReferenceData.FrameRates.FilteredRates('')
  else if Assigned(FormAdditionData) then
    FormAdditionData.FrameRates.FilteredRates('');
end;

procedure TfNormativDirectory.FormCreate(Sender: TObject);
var
  Point1: TPoint;
begin
  if dm.Connect.Connected then
  begin
    if not qrMain.Active then
      qrMain.Active := True;
  end;
  LoadDBGridSettings(grSostav);

  if Assigned(FormReferenceData) then
  begin
    Width := FormReferenceData.Width - FormReferenceData.GetLeftIndentForFormSborniks -
      (GetSystemMetrics(SM_CXFRAME) * 2);
    Height := FormReferenceData.Height - FormReferenceData.GetTopIndentForFormSborniks - 19;

    Point1 := FormMain.ClientToScreen(Point(FormReferenceData.Left, FormReferenceData.Top));

    Left := Point1.X + FormReferenceData.GetLeftIndentForFormSborniks + GetSystemMetrics(SM_CXFRAME);
    Top := Point1.Y + FormReferenceData.GetTopIndentForFormSborniks;

  end
  else if Assigned(FormAdditionData) then
  begin
    Point1 := FormMain.ClientToScreen(Point(FormAdditionData.Left, FormAdditionData.Top));

    Left := Point1.X + 5 + GetSystemMetrics(SM_CYBORDER) + FormAdditionData.FrameRates.JvDBGrid1.Width + 5;
    Top := Point1.Y + 2 + GetSystemMetrics(SM_CYCAPTION) + FormAdditionData.FrameRates.Top +
      FormAdditionData.FrameRates.dbmmoCaptionNormative.Top;

    Width := Screen.Width - Left - 3;
    Height := FormAdditionData.Height - (GetSystemMetrics(SM_CYCAPTION) + FormAdditionData.FrameRates.Top +
      FormAdditionData.FrameRates.dbmmoCaptionNormative.Top);
  end;
end;

procedure TfNormativDirectory.Search(const Direction: Integer);
var
  StringSearch: String;
  CountWords, i, j: Integer;
  Words: array of String;
  Coincides: Integer;
begin
  StringSearch := edtSearch.Text;

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
        for i := 0 to tvMain.Items.Count - 1 do // Цикл по узлам дерева
        begin
          Coincides := 0; // Количество совпавших слов

          for j := 0 to CountWords - 1 do // Цикл по словам
            if Pos(WideLowerCase(Words[j]), WideLowerCase(tvMain.Items.Item[i].Text)) > 0 then
              Inc(Coincides);

          if Coincides = CountWords then // Если все слова совпали
          begin
            tvMain.Selected := tvMain.Items.Item[i];
            tvMain.SetFocus;
            Exit;
          end;
        end;

        MessageBox(0, PChar('Совпадений не найдено!'), '', MB_ICONWARNING + MB_OK + mb_TaskModal);
      end;
    1: // Поиск вниз начиная с текущего узла
      begin
        for i := tvMain.Selected.AbsoluteIndex + 1 to tvMain.Items.Count - 1 do // Цикл по узлам дерева
        begin
          Coincides := 0; // Количество совпавших слов

          for j := 0 to CountWords - 1 do // Цикл по словам
            if Pos(WideLowerCase(Words[j]), WideLowerCase(tvMain.Items.Item[i].Text)) > 0 then
              Inc(Coincides);

          if Coincides = CountWords then // Если все слова совпали
          begin
            tvMain.Selected := tvMain.Items.Item[i];
            tvMain.SetFocus;
            Exit;
          end;
        end;

        MessageBox(0, PChar('Достигнут последний элемент дерева, совпадений не найдено!'), '',
          MB_ICONWARNING + MB_OK + mb_TaskModal);
      end;
    -1: // Поиск вверх начиная с текущего узла
      begin
        for i := tvMain.Selected.AbsoluteIndex - 1 downto 0 do // Цикл по узлам дерева
        begin
          Coincides := 0; // Количество совпавших слов

          for j := 0 to CountWords - 1 do // Цикл по словам
            if Pos(WideLowerCase(Words[j]), WideLowerCase(tvMain.Items.Item[i].Text)) > 0 then
              Inc(Coincides);

          if Coincides = CountWords then // Если все слова совпали
          begin
            tvMain.Selected := tvMain.Items.Item[i];
            tvMain.SetFocus;
            Exit;
          end;
        end;

        MessageBox(0, PChar('Достигнут первый элемент дерева, совпадений не найдено!'), '',
          MB_ICONWARNING + MB_OK + mb_TaskModal);
      end;
  end;
end;

function TfNormativDirectory.getChildList(const RootID: Integer): string;
begin
  Result := '';

end;

procedure TfNormativDirectory.mN1Click(Sender: TObject);
begin
  tvMain.Visible := False;
  tvMain.FullExpand;
  tvMain.Visible := True;
end;

procedure TfNormativDirectory.mN2Click(Sender: TObject);
begin
  tvMain.Visible := False;
  tvMain.FullCollapse;
  tvMain.Visible := True;
end;

procedure TfNormativDirectory.tvMainChange(Sender: TObject; Node: TTreeNode);
begin
  qrDetail.ParamByName('normativ_directory_id').Value := qrMain.FieldByName('normativ_directory_id').Value;
  CloseOpen(qrDetail);
  if skipReload then
    Exit;
  if Assigned(FormReferenceData) then
    FormReferenceData.FrameRates.FilteredRates('tree_data LIKE ''' + qrMain.FieldByName('tree_data')
      .AsString + '%''')
  else if Assigned(FormAdditionData) then
    FormAdditionData.FrameRates.FilteredRates('tree_data LIKE ''' + qrMain.FieldByName('tree_data')
      .AsString + '%''');
end;

procedure TfNormativDirectory.tvMainDblClick(Sender: TObject);
var
  NumberNormativ: String;
  FirstChar: Char;
  Path: String;
begin
  if Assigned(FormReferenceData) then
    NumberNormativ := dm.qrNormativ.FieldByName('NumberNormative').AsString
  else if Assigned(FormAdditionData) then
    NumberNormativ := dm.qrNormativ.FieldByName('NumberNormative').AsString;

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
      sLineBreak + 'которого не существует!'), '', MB_ICONWARNING + MB_OK + mb_TaskModal);
    Exit;
  end;

  ShellExecute(fNormativDirectory.Handle, nil, PChar(Path), nil, nil, SW_SHOWMAXIMIZED);
end;

end.
