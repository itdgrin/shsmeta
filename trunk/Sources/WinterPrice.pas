unit WinterPrice;

interface

uses
  Windows, SysUtils, Classes, Controls, Forms, StdCtrls, Grids, Buttons, ExtCtrls, DB, Menus, Clipbrd,
  fFrameProgressBar, fFrameStatusBar, ComCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TSplitter = class(ExtCtrls.TSplitter)
  private
    procedure Paint(); override;
  end;

type
  TFormWinterPrice = class(TForm)
    PanelRight: TPanel;
    PanelTable: TPanel;
    GroupBox1: TGroupBox;
    LabelCoef: TLabel;
    LabelCoefZP: TLabel;
    LabelCoefZPMach: TLabel;
    EditCoefZPMach: TEdit;
    EditCoefZP: TEdit;
    EditCoef: TEdit;
    GroupBox2: TGroupBox;
    Label6: TLabel;
    DateTimePicker1: TDateTimePicker;
    Label7: TLabel;
    DateTimePicker2: TDateTimePicker;
    TreeView: TTreeView;
    x: TGroupBox;
    StringGridNormatives: TStringGrid;
    PopupMenuTreeView: TPopupMenu;
    PopupMenuTreeViewExpandTrue: TMenuItem;
    PopupMenuTreeViewExpandFalse: TMenuItem;
    ADOQueryTemp1_1: TFDQuery;
    ADOQueryTemp3: TFDQuery;
    ADOQueryTemp2: TFDQuery;
    ADOQueryTemp1: TFDQuery;
    ADOQueryTable: TFDQuery;

    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure RepaintImagesForSplitters();
    procedure FillingTree;
    procedure StringGridTableDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure StringGridTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure StringGridTableClick(Sender: TObject);
    procedure StringGridTableMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; x, Y: Integer);
    procedure StringGridTableEnter(Sender: TObject);
    procedure StringGridTableExit(Sender: TObject);
    procedure ConfigurationTableNormatives;
    procedure TreeViewChanging(Sender: TObject; Node: TTreeNode; var AllowChange: Boolean);
    procedure PopupMenuTreeViewExpandTrueClick(Sender: TObject);
    procedure PopupMenuTreeViewExpandFalseClick(Sender: TObject);

  private
    StrQuery: String; // Строка для формирования запроса

  public

  end;

const
  // Название кнопки для этого окна
  CaptionForm = 'Зимнее удорожание';

  // Подсказка при наведении на кнопку для этого окна
  HintButton = 'Окно зинмее удорожание';

var
  FormWinterPrice: TFormWinterPrice;

implementation

uses Main, DataModule;

{$R *.dfm}
// ---------------------------------------------------------------------------------------------------------------------

{ TSplitter }
procedure TSplitter.Paint();
begin
  // inherited;
  FormWinterPrice.RepaintImagesForSplitters();
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormWinterPrice.FormCreate(Sender: TObject);
begin
  // Настройка размеров и положения формы
  ClientWidth := FormMain.ClientWidth div 2;
  ClientHeight := FormMain.ClientHeight div 2;
  Top := 20;
  Left := 20;

  WindowState := wsMaximized;

  Caption := CaptionForm;

  // -----------------------------------------

  // Загружаем изображения для сплиттеров
  with DM.ImageListVerticalDots do
  begin
    // GetIcon(0, ImageSplitterCenter.Picture.Icon);
  end;

  // -----------------------------------------

  ConfigurationTableNormatives;

  FillingTree;

  // -----------------------------------------

  // Создаём кнопку от этого окна (на главной форме внизу)
  FormMain.CreateButtonOpenWindow(CaptionForm, HintButton, FormMain.ShowWinterPrice);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormWinterPrice.FormActivate(Sender: TObject);
begin
  // Если нажата клавиша Ctrl и выбираем форму, то делаем
  // каскадирование с переносом этой формы на передний план
  FormMain.CascadeForActiveWindow;

  // Делаем нажатой кнопку активной формы (на главной форме внизу)
  FormMain.SelectButtonActiveWindow(CaptionForm);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormWinterPrice.FormShow(Sender: TObject);
begin
  // Устанавливаем фокус
  TreeView.SetFocus;
end;

procedure TFormWinterPrice.PopupMenuTreeViewExpandTrueClick(Sender: TObject);
begin
  TreeView.FullExpand;
end;

procedure TFormWinterPrice.PopupMenuTreeViewExpandFalseClick(Sender: TObject);
begin
  TreeView.FullCollapse;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormWinterPrice.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormWinterPrice.FormDestroy(Sender: TObject);
begin
  FormWinterPrice := nil;

  // Удаляем кнопку от этого окна (на главной форме внизу)
  FormMain.DeleteButtonCloseWindow(CaptionForm);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormWinterPrice.RepaintImagesForSplitters();
begin
  // ImageSplitterCenter.Top := SplitterCenter.Top + (SplitterCenter.Height - ImageSplitterCenter.Height) div 2;
  // ImageSplitterCenter.Left := SplitterCenter.Left;
end;

procedure TFormWinterPrice.StringGridTableClick(Sender: TObject);
begin
  with (Sender as TStringGrid) do
    Repaint;
end;

procedure TFormWinterPrice.StringGridTableDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
  State: TGridDrawState);
begin
  // Так как свойство таблицы DefaultDrawing отключено (иначе ячейка таблицы будет обведена пунктирной линией)
  // необходимо самому прорисовывать шапку и все строки таблицы

  with (Sender as TStringGrid) do
  begin
    // Прорисовка шапки таблицы
    if (ARow = 0) or (ACol = 0) then
    begin
      Canvas.Brush.Color := PS.BackgroundHead;
      Canvas.Font.Color := PS.FontHead;
      Canvas.FillRect(Rect);
      Canvas.TextOut(Rect.Left + 3, Rect.Top + 3, Cells[ACol, ARow]);
    end
    else // Прорисовка всех остальных строк
    begin
      Canvas.Brush.Color := PS.BackgroundRows;
      Canvas.Font.Color := PS.FontRows;
      Canvas.FillRect(Rect);
      Canvas.TextOut(Rect.Left + 3, Rect.Top + 3, Cells[ACol, ARow]);
    end;

    // Если таблица в фокусе и строка не равна первой строке
    if focused and (Row = ARow) and (Row > 0) then
    begin
      Canvas.Brush.Color := PS.BackgroundSelectRow;
      Canvas.Font.Color := PS.FontSelectRow;
      Canvas.FillRect(Rect);
      Canvas.TextOut(Rect.Left + 3, Rect.Top + 3, Cells[ACol, Row]);
    end;
  end;
end;

procedure TFormWinterPrice.StringGridTableEnter(Sender: TObject);
begin
  with (Sender as TStringGrid) do
    Repaint;
end;

procedure TFormWinterPrice.StringGridTableExit(Sender: TObject);
begin
  with (Sender as TStringGrid) do
    Repaint;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormWinterPrice.StringGridTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  // Запрещаем переход курсора на невидимые ячейки
  with (Sender as TStringGrid) do
    if (ColWidths[col + 1] = -1) and (Key = Ord(#39)) then
      Key := Ord(#0);
end;

procedure TFormWinterPrice.StringGridTableMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState;
  x, Y: Integer);
begin
  with (Sender as TStringGrid) do
    Repaint;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormWinterPrice.TreeViewChanging(Sender: TObject; Node: TTreeNode; var AllowChange: Boolean);
var
  StrNum: String;
  i, j: Integer;
begin
  StrNum := Node.Text;
  Delete(StrNum, Pos(' ', StrNum) - 1, length(StrNum) - Pos(' ', StrNum) + 2);

  // Caption := StrNum;

  with StringGridNormatives do
  begin
    for i := 1 to RowCount - 1 do
      for j := 0 to ColCount - 1 do
        Cells[j, i] := '';

    RowCount := 2;
  end;

  try
    with ADOQueryTemp1 do
    begin
      Active := False;
      SQL.Clear;

      StrQuery :=
        'SELECT id, s, po, coef as "Coef", coef_zp as "CoefZP", coef_zp_mach as "CoefZPMach" FROM znormativs WHERE num = "'
        + StrNum + '" and s <> "" ORDER BY s';

      SQL.Add(StrQuery);
      Active := True;

      if RecordCount <= 0 then
        Exit;

      First;
      i := 1;
      StringGridNormatives.RowCount := RecordCount + 1;

      while not Eof do
        with StringGridNormatives do
        begin
          Cells[0, i] := IntToStr(i);
          Cells[1, i] := FieldByName('s').AsVariant;
          Cells[2, i] := FieldByName('po').AsVariant;
          Cells[3, i] := IntToStr(FieldByName('Id').AsVariant);
          Cells[4, i] := MyFloatToStr(FieldByName('Coef').AsVariant);
          Cells[5, i] := MyFloatToStr(FieldByName('CoefZP').AsVariant);
          Cells[6, i] := MyFloatToStr(FieldByName('CoefZPMach').AsVariant);

          EditCoef.Text := Cells[4, Row];
          EditCoefZP.Text := Cells[5, Row];
          EditCoefZPMach.Text := Cells[6, Row];

          Inc(i);
          Next;
        end;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('При запросе номеров расценок возникла ошибка:' + sLineBreak + E.Message), CaptionForm,
        MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormWinterPrice.FillingTree;
var
  i1, i2, i2_1, i3: Integer;
  Num1, Num2: String;
begin
  try
    StrQuery := 'SELECT num, name FROM znormativ' + FMEndTables + ' WHERE not num LIKE "%.%" ORDER BY id;';

    with ADOQueryTable do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add(StrQuery);
      Active := True;

      First;

      while not Eof do
      begin
        i1 := TreeView.Items.Add(Nil, FieldByName('num').AsVariant + '. ' + FieldByName('name').AsVariant)
          .AbsoluteIndex;

        // ----- ВТОРОЙ УРОВЕНЬ

        with ADOQueryTemp1 do
        begin
          Active := False;
          SQL.Clear;

          Num1 := ADOQueryTable.FieldByName('num').AsVariant;

          // StrQuery := 'SELECT num, name FROM ' + NameTable + ' WHERE num LIKE "' + Num1 + '.%" GROUP BY num;';

          StrQuery := 'SELECT num, name, s FROM znormativ' + FMEndTables + ' WHERE num LIKE "' + Num1 +
            '.%" and not num LIKE "%.%.%" GROUP BY name ORDER BY num';

          SQL.Add(StrQuery);
          Active := True;

          First;

          while not Eof do
          begin
            i2 := TreeView.Items.AddChild(TreeView.Items.Item[i1], FieldByName('num').AsVariant + '. ' +
              FieldByName('Name').AsVariant).AbsoluteIndex;

            // ----- ТРЕТИЙ УРОВЕНЬ

            if ADOQueryTemp1.FieldByName('s').AsVariant = '' then
            begin
              with ADOQueryTemp2 do
              begin
                Active := False;
                SQL.Clear;

                Num2 := ADOQueryTemp1.FieldByName('num').AsVariant;

                StrQuery := 'SELECT num, name FROM znormativ' + FMEndTables + ' WHERE num LIKE "' + Num2 +
                  '.%" GROUP BY name ORDER BY num';

                SQL.Add(StrQuery);
                Active := True;

                First;

                while not Eof do
                begin
                  TreeView.Items.AddChild(TreeView.Items.Item[i2], FieldByName('num').AsVariant + '. ' +
                    FieldByName('Name').AsVariant).AbsoluteIndex;

                  Next;
                end;
              end;
            end;

            // ----- ТРЕТИЙ УРОВЕНЬ

            Next;
          end;
        end;

        // ----- ВТОРОЙ УРОВЕНЬ

        Next;
      end;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar('При выводе данных в таблицу возникла ошибка:' + sLineBreak + E.Message), CaptionForm,
        MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormWinterPrice.ConfigurationTableNormatives;
begin
  with StringGridNormatives do
  begin
    ColCount := 7; // Количество колонок
    RowCount := 2; // Количество строк

    FixedCols := 1;
    FixedRows := 1;

    // Подписываем шапку таблицы
    Cells[0, 0] := '№ п/п';
    Cells[1, 0] := 'C';
    Cells[2, 0] := 'ПО';
    Cells[3, 0] := 'Id';
    Cells[4, 0] := 'Coef';
    Cells[5, 0] := 'CoefZP';
    Cells[6, 0] := 'CoefZPMach';

    // Ширина колонок
    ColWidths[0] := 40;
    ColWidths[1] := 80;
    ColWidths[2] := 80;
    ColWidths[3] := -1;
    ColWidths[4] := -1;
    ColWidths[5] := -1;
    ColWidths[6] := -1;
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

end.
