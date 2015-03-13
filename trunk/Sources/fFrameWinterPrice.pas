unit fFrameWinterPrice;

interface

uses
  Windows, SysUtils, Classes, Controls, Forms, StdCtrls, Grids, ExtCtrls, DB, Menus, ComCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Masks, fFrameSmeta;

type
  TFrameWinterPrice = class(TSmetaFrame)
    PanelRight: TPanel;
    GroupBox1: TGroupBox;
    LabelCoef: TLabel;
    LabelCoefZP: TLabel;
    LabelCoefZPMach: TLabel;
    EditCoefZPMach: TEdit;
    EditCoefZP: TEdit;
    EditCoef: TEdit;
    GroupBox2: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    GroupBoxNormative: TGroupBox;
    StringGridNormatives: TStringGrid;
    PanelTable: TPanel;
    TreeView: TTreeView;
    PopupMenuTreeView: TPopupMenu;
    PopupMenuTreeViewExpandTrue: TMenuItem;
    PopupMenuTreeViewExpandFalse: TMenuItem;
    ADOQueryTable: TFDQuery;
    ADOQueryTemp1: TFDQuery;

    procedure SettingTable;
    procedure FillingTree;

    procedure PopupMenuTreeViewExpandFalseClick(Sender: TObject);
    procedure PopupMenuTreeViewExpandTrueClick(Sender: TObject);

    procedure StringGridNormativesClick(Sender: TObject);
    procedure StringGridNormativesDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure StringGridNormativesEnter(Sender: TObject);
    procedure StringGridNormativesExit(Sender: TObject);
    procedure StringGridNormativesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure StringGridNormativesMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; x, Y: Integer);
    procedure StringGridNormativesMouseMove(Sender: TObject; Shift: TShiftState; x, Y: Integer);

    procedure TreeViewChanging(Sender: TObject; Node: TTreeNode; var AllowChange: Boolean);
  public
     procedure ReceivingAll; override;
     constructor Create(AOwner: TComponent); override;
  end;

implementation

uses Main, DrawingTables, DataModule;

{$R *.dfm}

const
  // Название этого фрейма
  CaptionFrame = 'Фрейм «Зимнее удорожание»';

  // ---------------------------------------------------------------------------------------------------------------------

constructor TFrameWinterPrice.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  // ----------------------------------------

  SettingTable;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFrameWinterPrice.SettingTable;
begin
  // НАСТРАИВАЕМ ТАБЛИЦУ

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

    // Ширина ВИДИМЫХ колонок
    ColWidths[0] := 40;
    ColWidths[1] := 80;
    ColWidths[2] := 80;

    // Ширина СКРЫТЫХ колонок
    ColWidths[3] := -1;
    ColWidths[4] := -1;
    ColWidths[5] := -1;
    ColWidths[6] := -1;
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------
procedure TFrameWinterPrice.ReceivingAll;
begin
  FillingTree;
  fLoaded := true;
end;

procedure TFrameWinterPrice.FillingTree;
var
  i1, i2: Integer;
  Num, LastNum: String;
  StrQuery: string;
  NLevel : integer;
begin
  try
    if not ADOQueryTable.Active then
    begin
      with ADOQueryTable do
      begin
        //Сделано допущение что поле INTERVAL_ID сортирует num
        Active := False;
        StrQuery := 'SELECT DISTINCT INTERVAL_ID, num, name FROM znormativs ' +
          'order by INTERVAL_ID;';
        SQL.Clear;
        SQL.Add(StrQuery);
        Active := True;

        First;

        i1 := -1;
        i2 := -1;
        LastNum := '';

        while not Eof do
        begin
          //Определяем уровень ноды
          Num := FieldByName('num').AsString;

          if LastNum = Num then
          begin
            Next;
            Continue;
          end;

          LastNum := Num;

          if MatchesMask(num, '*.*.*') then NLevel := 3
          else if MatchesMask(num, '*.*') then NLevel := 2
          else NLevel := 1;


          if NLevel = 1 then
          begin
            i1 := TreeView.Items.Add(Nil, Num + '. ' +
              FieldByName('name').AsString).AbsoluteIndex;
            i2 := -1;
          end;

          if NLevel = 2 then
          begin
            if i1 = -1 then  //Все косяки в бд игнорируются
            begin
              Next;
              continue;
            end;

            i2 := TreeView.Items.AddChild(TreeView.Items.Item[i1], num + '. ' +
              FieldByName('Name').AsString).AbsoluteIndex;
          end;

          if NLevel = 3 then
          begin
            if (i2 = -1) then
            begin
              Next;
              continue;
            end;

            TreeView.Items.AddChild(TreeView.Items.Item[i2], num + '. ' +
              FieldByName('Name').AsVariant).AbsoluteIndex;
          end;

          Next;
        end;
      end;
    end;
  except
    on E: Exception do
    begin
      MessageBox(0, PChar('При выводе данных в дерево возникла ошибка:' + sLineBreak + E.Message), CaptionFrame,
        MB_ICONERROR + MB_OK + mb_TaskModal);
    end;
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFrameWinterPrice.PopupMenuTreeViewExpandFalseClick(Sender: TObject);
begin
  TreeView.FullCollapse;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFrameWinterPrice.PopupMenuTreeViewExpandTrueClick(Sender: TObject);
begin
  TreeView.FullExpand;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFrameWinterPrice.StringGridNormativesClick(Sender: TObject);
begin
  (Sender as TStringGrid).Repaint;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFrameWinterPrice.StringGridNormativesDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
  State: TGridDrawState);
begin
  StringGridDrawCellDefault(Sender, ACol, ARow, Rect, State);

  with (Sender as TStringGrid) do
    if (Row = ARow) and (Row > 0) and (ACol > 0) and (gdFocused in State) then
    begin
      Canvas.Brush.Color := PS.BackgroundSelectRow;
      Canvas.Font.Color := PS.FontSelectRow;
      Canvas.FillRect(Rect);
      Canvas.TextOut(Rect.Left + 3, Rect.Top + 3, Cells[ACol, Row]);
    end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFrameWinterPrice.StringGridNormativesEnter(Sender: TObject);
begin
  (Sender as TStringGrid).Repaint;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFrameWinterPrice.StringGridNormativesExit(Sender: TObject);
begin
  (Sender as TStringGrid).Repaint;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFrameWinterPrice.StringGridNormativesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  with (Sender as TStringGrid) do
    if (Key = Ord(#39)) and (ColWidths[Col + 1] = -1) then
      Key := Ord(#0);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFrameWinterPrice.StringGridNormativesMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState;
  x, Y: Integer);
begin
  (Sender as TStringGrid).Repaint;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFrameWinterPrice.StringGridNormativesMouseMove(Sender: TObject; Shift: TShiftState; x, Y: Integer);
begin
  if ssLeft in Shift then
    (Sender as TStringGrid).Repaint;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFrameWinterPrice.TreeViewChanging(Sender: TObject; Node: TTreeNode; var AllowChange: Boolean);
var
  StrNum: String;
  i, j: Integer;
  StrQuery: string;
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
      MessageBox(0, PChar('При запросе номеров расценок возникла ошибка:' + sLineBreak + E.Message), CaptionFrame,
        MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

end.
