{///////////////////////////////////////////////////}
{  Универсальная форма реализующая замену           }
{  материалов и механизмов в расценке, добавление   }
{  материалов и механизмов к расценке               }
{                                                   }
{///////////////////////////////////////////////////}

unit ReplacementMatAndMech;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, System.RTLConsts, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.Grids, Vcl.DBGrids, JvExDBGrids, JvDBGrid, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Clipbrd, JvExControls,
  JvAnimatedImage, JvGIFCtrl, FireDAC.Phys.MySQL, Vcl.ValEdit, Vcl.Buttons,
  Vcl.Menus, GlobsAndConst;

type
  TEntryRecord = record
    Select: Boolean;
    EID,
    RID,
    MID: Integer;
    EName,
    RCode,
    MCode,
    MUnt: string;
    MNorma,
    MCount: Extended;
    MRep: Boolean; 
  end;

  TEntryArray = array of TEntryRecord;

  TMyGrid = class(TCustomGrid)
  public
    property InplaceEditor;
  end;

  TfrmReplacement = class(TForm)
    Panel1: TPanel;
    groupReplace: TGroupBox;
    Label2: TLabel;
    edtSourceCode: TEdit;
    Label3: TLabel;
    groupEntry: TGroupBox;
    groupCatalog: TGroupBox;
    Panel4: TPanel;
    btnReplace: TButton;
    btnCancel: TButton;
    qrRep: TFDQuery;
    qrTemp: TFDQuery;
    Panel5: TPanel;
    StatusBar1: TStatusBar;
    Panel3: TPanel;
    Label1: TLabel;
    edtFind: TEdit;
    btnFind: TButton;
    btnSelect: TButton;
    LoadAnimator: TJvGIFAnimator;
    LoadLabel: TLabel;
    ListSpr: TListView;
    edtSourceName: TMemo;
    ListEntry: TListView;
    rgroupType: TRadioGroup;
    groupRep: TGroupBox;
    Panel2: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    grdRep: TStringGrid;
    PMEntry: TPopupMenu;
    N1: TMenuItem;
    pmSelectAll: TMenuItem;
    pmDeselectAll: TMenuItem;
    pmCurRate: TMenuItem;
    pmSelectRate: TMenuItem;
    pmDeselectRate: TMenuItem;
    pmShowRep: TMenuItem;
    btnDelReplacement: TButton;
    cbMat: TCheckBox;
    cbJBI: TCheckBox;
    procedure btnCancelClick(Sender: TObject);
    procedure rgroupTypeClick(Sender: TObject);
    procedure ListSprCustomDrawItem(Sender: TCustomListView; Item: TListItem;
      State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure btnFindClick(Sender: TObject);
    procedure btnSelectClick(Sender: TObject);
    procedure ListSprSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure ListEntryCustomDrawItem(Sender: TCustomListView; Item: TListItem;
      State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure ListEntryChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure grdRepSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure grdRepKeyPress(Sender: TObject; var Key: Char);
    procedure edtFindKeyPress(Sender: TObject; var Key: Char);
    procedure grdRepSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: string);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure grdRepMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PMEntryPopup(Sender: TObject);
    procedure pmSelectAllClick(Sender: TObject);
    procedure pmSelectRateClick(Sender: TObject);
    procedure pmShowRepClick(Sender: TObject);
    procedure btnReplaceClick(Sender: TObject);
    procedure ListSprDblClick(Sender: TObject);

  private
    FCurType: Byte;
    FTemp, //Режим работы с временными таблицами (По невременным не реализовано)
    FAddMode: Boolean; //False - режим замены True - режим вставки

    FObjectID,
    FEstimateID,
    FRateID,
    FMatMechID: Integer;

    FObjectName,
    FEstimateName,
    FRateCode: String;

    FMonth,
    FYear,
    FRegion: Word;
    FRegionName: string;

    FSprArray: TSprArray;
    FEntryArray: TEntryArray;

    FFlag: Boolean;

    //Для хинтов в стринг гриде
    FActRow: Integer;

    FRateIDArray,
    FEstIDArray: array of Integer;

    procedure ChangeType(AType: byte);
    procedure LoadObjEstInfo;
    procedure LoadRepInfo;
    procedure LoadEntry;

    procedure OnActivate(var Mes: TMessage); message WM_EXCECUTE;
    procedure FillSprList(AFindStr: string);
    procedure ShowDelRep(const AName: string; const AID: Integer;
      ADel: Boolean = False);

    function GetCount: Integer;
    function GetRateIDs(AIndex: Integer): Integer;
    function GetEstIDs(AIndex: Integer): Integer;
    { Private declarations }
  public
    constructor Create(const AObjectID, AEstimateID, ARateID,
      AMatMechID: Integer; AType: Byte; ATemp, AAdd: Boolean); reintroduce;
    destructor Destroy; override;

    property Count: Integer read GetCount;
    property RateIDs[AIndex: Integer] : Integer read GetRateIDs;
    property EstIDs[AIndex: Integer] : Integer read GetEstIDs;
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses DataModule, Tools;

//Событие выполняющееся при получении данных из справочника
//Заполняет массив справочника
procedure TfrmReplacement.OnActivate(var Mes: TMessage);
var ind: Integer;
    TmpDS: TDataSet;
    TmpCount: Integer;
begin
  LoadLabel.Visible := False;
  LoadAnimator.Visible := False;
  LoadAnimator.Animate := False;

  ind := 0;
  TmpCount := 0;
  SetLength(FSprArray, ind);

  //Если в потоке возникло исключение воспроизводим его
  if Assigned(Exception(Mes.LParam)) or
    not Assigned(TDataSet(Mes.WParam)) then
  begin
    ListSpr.Items.Clear;
    ListSpr.Visible := True;
    if Assigned(Exception(Mes.LParam)) then
      raise Exception(Mes.LParam);
    Exit;
  end;

  TmpDS := TDataSet(Mes.WParam);

  if TmpDS.Active then
  begin
    while not TmpDS.Eof do
    begin
      inc(ind);

      if (ind > TmpCount) then
      begin
        TmpCount := TmpCount + 1000;
        SetLength(FSprArray, TmpCount);
      end;

      //Для того что-бы не подвисало
      if (ind mod 2000) = 0 then
        Application.ProcessMessages;
      //не по именам для быстродействия
      //Id, Code, Name, Unit, PriceVAT, PriceNotVAT, MAT_TYPE
      FSprArray[ind - 1].ID := TmpDS.Fields[0].AsInteger;
      FSprArray[ind - 1].Code := TmpDS.Fields[1].AsString;
      FSprArray[ind - 1].Name := TmpDS.Fields[2].AsString;
      FSprArray[ind - 1].Unt := TmpDS.Fields[3].AsString;
      if FFlag then
      begin
        FSprArray[ind - 1].CoastNDS := TmpDS.Fields[4].AsFloat;
        FSprArray[ind - 1].CoactNoNDS := TmpDS.Fields[5].AsFloat;
      end;
      if FCurType = 0 then
        FSprArray[ind - 1].MType := TmpDS.Fields[6].AsInteger;
      TmpDS.Next;
    end;
    SetLength(FSprArray, ind);
  end;

  //Заполнение справочника
  FillSprList(edtFind.Text);
end;

procedure TfrmReplacement.PMEntryPopup(Sender: TObject);
var ind: Integer;
begin
  //Добавляет данные по выделенной смете
  if (ListEntry.ItemIndex > -1) and
    Assigned(ListEntry.Items[ListEntry.ItemIndex].Data) then
  begin
    ind := Integer(ListEntry.Items[ListEntry.ItemIndex].Data) - 1;
    pmCurRate.Visible := True;
    pmCurRate.Caption := FEntryArray[ind].EName;
    pmCurRate.Tag := FEntryArray[ind].EID;
    if FEntryArray[ind].MRep then
    begin
      pmShowRep.Visible := True;
      pmShowRep.Caption := 'Заменяющие ' + FEntryArray[ind].MCode;
      pmShowRep.Tag := FEntryArray[ind].MID;
    end
    else
      pmShowRep.Visible := False;
  end
  else
  begin
    pmCurRate.Visible := False;
    pmShowRep.Visible := False;
  end;
end;

procedure TfrmReplacement.pmSelectAllClick(Sender: TObject);
var i: Integer;
begin
  //Выделяет или отменяет все
  for i := Low(FEntryArray) to High(FEntryArray) do
    if TComponent(Sender).Tag = 0 then
      FEntryArray[i].Select := False
    else
      FEntryArray[i].Select := True;
  ListEntry.Repaint;
end;

procedure TfrmReplacement.pmSelectRateClick(Sender: TObject);
var i: Integer;
begin
  //Выделяет или отменяет смету
  for i := Low(FEntryArray) to High(FEntryArray) do
  begin
    if TMenuItem(Sender).Parent.Tag = FEntryArray[i].EID then
    begin
      if TComponent(Sender).Tag = 0 then
        FEntryArray[i].Select := False
      else
        FEntryArray[i].Select := True;
    end;
  end;
  ListEntry.Repaint;
end;

//Идаляет заменяющие материалы по ид заменяемого
//Или выводит сообщение со списком заменяющих ADel = true
procedure TfrmReplacement.ShowDelRep(const AName: string; const AID: Integer;
      ADel: Boolean = False);
var TmpStr: string;
  i: Integer;
begin
  if FTemp then
    TmpStr := '_temp';

  if FCurType = 0 then
    qrRep.SQL.Text :=
      'select MAT_CODE, MAT_NAME, MAT_NORMA, MAT_COUNT, MAT_UNIT, ID ' +
        'from materialcard' + TmpStr + ' where ID_REPLACED = ' + AID.ToString
  else
    qrRep.SQL.Text :=
      'Select MECH_CODE, MECH_NAME, MECH_NORMA, MECH_COUNT, MECH_UNIT, ID ' +
        'from mechanizmcard' + TmpStr + ' where ID_REPLACED = ' + AID.ToString;

  qrRep.Active := True;
  if not ADel then
    TmpStr := AName + ':' + sLineBreak;
  i := 0;
  if not qrRep.Eof then
  begin
    Inc(i);
    if ADel then
    begin
      //Удаляет заменяющие материалы или механизмы
      if FCurType = 0 then
        qrTemp.SQL.Text := 'CALL DeleteMaterial(:id);'
      else
        qrTemp.SQL.Text := 'CALL DeleteMechanism(:id);';
      qrTemp.ParamByName('id').Value := qrRep.FieldByName('ID').Value;
      qrTemp.ExecSQL;
    end
    else
      TmpStr := TmpStr +
        i.ToString + '. Код: ' + qrRep.Fields[0].AsString + sLineBreak +
        '    Наименование: ' + qrRep.Fields[1].AsString + sLineBreak +
        '    Норма: ' + qrRep.Fields[2].AsString + sLineBreak +
        '    Кол-во: ' + qrRep.Fields[3].AsString + ' ' +
          qrRep.Fields[4].AsString  + sLineBreak + sLineBreak;
    qrRep.Next;
  end;
  qrRep.Active := False;

  if not ADel then
    ShowMessage(TmpStr);
end;

procedure TfrmReplacement.pmShowRepClick(Sender: TObject);
begin
  ShowDelRep(TMenuItem(Sender).Caption, TMenuItem(Sender).Tag);
end;

//заполняет справочник
procedure TfrmReplacement.FillSprList(AFindStr: string);
var i, j: Integer;
    FindType: Byte;
    Item: TListItem;
    WordList: TStringList;
    TmpStr: string;
    LastSpase, Cont: Boolean;
begin
  if Length(FSprArray) = 0 then
    Exit;

  WordList := TStringList.Create;
  try
    AFindStr := Trim(AFindStr);

    //Определяем тип поиска по имени или по коду
    FindType := 0;
    if (Length(AFindStr) > 0) then
    begin
       FindType := 1;
       if (Length(AFindStr) > 1) then
       if FCurType = 0 then
       begin
        if (((AFindStr[1] = 'C') or (AFindStr[1] = 'c') or
            (AFindStr[1] = 'С') or (AFindStr[1] = 'с')) and
          CharInSet(AFindStr[2], ['1'..'9'])) then
        begin
          AFindStr[1] := 'С';
          FindType := 2;
        end;
       end
       else
       begin
        if (((AFindStr[1] = 'M') or (AFindStr[1] = 'm') or
            (AFindStr[1] = 'М') or (AFindStr[1] = 'м')) and
          CharInSet(AFindStr[2], ['1'..'9'])) then
        begin
          AFindStr[1] := 'М';
          FindType := 2;
        end;
       end;

       TmpStr := '';
       LastSpase := False;
       for i := Low(AFindStr) to High(AFindStr) do
       begin
          if (AFindStr[i] = ' ') then
          begin
            if LastSpase then
              Continue
            else
              LastSpase := True;
          end
          else
            LastSpase := False;

          TmpStr := TmpStr + AFindStr[i];
       end;
       TmpStr := StringReplace(TmpStr, ' ', sLineBreak,[rfReplaceAll]);
       WordList.Text := TmpStr;
    end;

    //Видимый список обновляется намного дольше
    ListSpr.Visible :=  False;

    ListSpr.Items.Clear;
    for i := Low(FSprArray) to High(FSprArray) do
    begin
      if FCurType = 0 then
        if ((FSprArray[i].MType = 1) and not cbMat.Checked) or
           ((FSprArray[i].MType = 2) and not cbJBI.Checked) then
          Continue;

      case FindType of
        1:
        begin
          Cont := False;
          for j := 0 to WordList.Count - 1 do
            if Pos(WordList[j].ToLower, FSprArray[i].Name.ToLower) = 0 then
            begin
              Cont := True;
              break;
            end;
          if Cont then
            Continue;
        end;
        2:
          if Pos(AFindStr.ToLower, FSprArray[i].Code.ToLower) = 0 then
            Continue;
      end;
      //Создаем пустые итемы, заполним их при отображении
      Item := ListSpr.Items.Add;
      Item.Data := @FSprArray[i];
    end;
    btnFind.Enabled := True;
    btnSelect.Enabled := True;
    cbMat.Enabled := True;
    cbJBI.Enabled := True;
    ListSpr.Visible :=  True;
    if (ListSpr.Items.Count > 0) then
      ListSpr.ItemIndex := 0
    else
    begin
      StatusBar1.Panels[0].Text := '';
      StatusBar1.Panels[1].Text := '   0/0';
    end;
  finally
    WordList.Free;
  end;
end;

procedure TfrmReplacement.grdRepKeyPress(Sender: TObject; var Key: Char);
var f: Extended;
    s: string;
begin
  if (grdRep.Col = 1) then
  begin
    if (Key = #3) or (Key = #$16) then //Копирование и  вставка
      Exit;

    if (FCurType = 0) then
    begin
      if (Key = 'C') or (Key = 'c') or (Key = 'с') then
        Key := 'С'; //Кирилица
      if not (CharInSet(Key, ['0'..'9', '-', #8]) or (Key = 'С')) then
        Key := #0;
    end;

    if (FCurType = 1) then
    begin
      if (Key = 'M') or (Key = 'm') or (Key = 'м') then
        Key := 'М'; //Кирилица
      if not (CharInSet(Key, ['0'..'9', #8]) or (Key = 'М')) then
        Key := #0;
    end;
  end;

  //Правила редактирования коэф. пересчета
  if (grdRep.Col = 4) then
  begin
    if CharInSet(Key, [^C, ^X, ^Z]) then
      Exit;

    if (Key = ^V) then
    begin
      //Проверка на корректность вставляемого текста
      if TryStrToFloat(Clipboard.AsText, f) then
      begin
        s :=
          Copy(TMyGrid(grdRep).InplaceEditor.Text, 1,
            TMyGrid(grdRep).InplaceEditor.SelStart) +
          Clipboard.AsText +
          Copy(TMyGrid(grdRep).InplaceEditor.Text,
            TMyGrid(grdRep).InplaceEditor.SelStart +
              TMyGrid(grdRep).InplaceEditor.SelLength + 1,
            Length(TMyGrid(grdRep).InplaceEditor.Text) -
              TMyGrid(grdRep).InplaceEditor.SelStart -
              TMyGrid(grdRep).InplaceEditor.SelLength);
        if TryStrToFloat(s, f) then
          Exit;
      end;
    end;

    case Key of
      '0'..'9',#8: ;
      '.',',':
       begin
         Key := FormatSettings.DecimalSeparator;
         if (pos(FormatSettings.DecimalSeparator ,
          grdRep.Cells[grdRep.Col, grdRep.Row]) <> 0) or
            (grdRep.Cells[grdRep.Col, grdRep.Row] = '') then
          Key:= #0;
       end;
       else Key:= #0;
    end;
  end;
end;

procedure TfrmReplacement.grdRepMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var r, c: Integer;
    TextWidth: Integer;
begin
  //Показывает хинт для тех наименование которые не влазят в строку
  grdRep.MouseToCell(X, Y, c, r);
  if (c = 2) and (r >= grdRep.FixedRows) and (r < grdRep.RowCount) then
  begin
    if FActRow <> r then
    begin
      FActRow := r;
      TextWidth := grdRep.Canvas.TextWidth(grdRep.Cells[c,r]);
      if (TextWidth > grdRep.ColWidths[c]) then
      begin
        Application.CancelHint;
        grdRep.Hint := grdRep.Cells[c, r];
        grdRep.ShowHint :=  True;
      end;
    end;
  end
  else
  begin
    Application.CancelHint;
    grdRep.Hint := '';
    grdRep.ShowHint := False;
    FActRow := -1;
  end;
end;

procedure TfrmReplacement.grdRepSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
var s: string;
begin
  if ACol in [1,4] then
    grdRep.Options := grdRep.Options + [goEditing]
  else
    grdRep.Options := grdRep.Options - [goEditing];

  //Убирает разделитель в конце, если не ввели дробную часть
  if (grdRep.Col = 4)then
  begin
    s := grdRep.Cells[grdRep.Col, grdRep.Row];
    if (Length(s) > 0) and (s[High(s)] = FormatSettings.DecimalSeparator) then
      SetLength(s, Length(s)-1);
    grdRep.Cells[grdRep.Col, grdRep.Row] := s;

    if grdRep.Cells[grdRep.Col, grdRep.Row] = '' then
      grdRep.Cells[grdRep.Col, grdRep.Row] := '1';
  end;
end;

procedure TfrmReplacement.grdRepSetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: string);
var i: Integer;
begin
  if (ACol = 1) then
  begin
    //Если ввели код находит соответсткие и подставляет наименование
    for i := Low(FSprArray) to High(FSprArray) do
      if SameText(grdRep.Cells[1, ARow], FSprArray[i].Code) then
      begin
        grdRep.Cells[5, ARow] := FSprArray[i].ID.ToString;
        grdRep.Cells[2, ARow] := FSprArray[i].Name;
        Exit;
      end;
    grdRep.Cells[2, ARow] := '';
    grdRep.Cells[5, ARow] := '';
  end;
end;

procedure TfrmReplacement.ListEntryChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
var i: Integer;
begin
  if Assigned(Item.Data) then
    FEntryArray[Integer(Item.Data) - 1].Select := Item.Checked;

  btnDelReplacement.Visible := False;
  for i := Low(FEntryArray) to High(FEntryArray) do
    if FEntryArray[i].Select then
      btnDelReplacement.Visible :=
        btnDelReplacement.Visible or FEntryArray[i].MRep;
end;

procedure TfrmReplacement.ListEntryCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
var ind: Integer;
begin
  if Assigned(Item) and
    Assigned(Item.Data) then
  begin
    ind := Integer(Item.Data) - 1;
    Item.Checked := FEntryArray[ind].Select;
    if Item.Caption.IsEmpty then
    begin
      Item.Caption := FEntryArray[ind].EName;
      Item.SubItems.Add(FEntryArray[ind].RCode);
      if FEntryArray[ind].MRep then
        Item.SubItems.Add(FEntryArray[ind].MCode + ' (З)')
      else
        Item.SubItems.Add(FEntryArray[ind].MCode);

      Item.SubItems.Add(FEntryArray[ind].MNorma.ToString);
      Item.SubItems.Add(FEntryArray[ind].MCount.ToString);
      Item.SubItems.Add(FEntryArray[ind].MUnt);
    end;
    //Подсветка серым уже замененных
    if FEntryArray[ind].MRep then
      Sender.Canvas.Brush.Color := $00DDDDDD;
  end;
  DefaultDraw := True;
end;

procedure TfrmReplacement.ListSprCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  //лист справочника заполняется при отрисовки, для ускорения работы
  if Assigned(Item) and
    (Item.Caption.IsEmpty) and
    Assigned(Item.Data) then
  begin
    Item.Caption := TSprRecord(Item.Data^).Code;
    Item.SubItems.Add(TSprRecord(Item.Data^).Name);
    Item.SubItems.Add(TSprRecord(Item.Data^).Unt);

    if FFlag then
    begin
      Item.SubItems.Add(FloatToStr(TSprRecord(Item.Data^).CoastNDS));
      Item.SubItems.Add(FloatToStr(TSprRecord(Item.Data^).CoactNoNDS));
    end;
  end;
  DefaultDraw := True;
end;

procedure TfrmReplacement.ListSprDblClick(Sender: TObject);
begin
  btnSelectClick(nil);
end;

procedure TfrmReplacement.ListSprSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  if Assigned(Item) and Assigned(Item.Data) then
  begin
    StatusBar1.Panels[0].Text := TSprRecord(Item.Data^).Name;
    StatusBar1.Panels[1].Text := '   ' +
      (Item.Index + 1).ToString + '/' + ListSpr.Items.Count.ToString;
  end;
end;

destructor TfrmReplacement.Destroy;
begin
  SetLength(FSprArray, 0);
  SetLength(FEntryArray, 0);
  inherited;
end;

function TfrmReplacement.GetCount: Integer;
begin //Count у FRateIDArray и FEstIDArray одинаков
  Result := Length(FRateIDArray);
end;

function TfrmReplacement.GetRateIDs(AIndex: Integer): Integer;
begin
  if (AIndex < 0) or
    (AIndex + 1 > Length(FRateIDArray)) then
    raise Exception.Create(Format(SListIndexError, [AIndex]));
  Result := FRateIDArray[AIndex];
end;

function TfrmReplacement.GetEstIDs(AIndex: Integer): Integer;
begin
  if (AIndex < 0) or
    (AIndex + 1 > Length(FEstIDArray)) then
    raise Exception.Create(Format(SListIndexError, [AIndex]));
  Result := FEstIDArray[AIndex];
end;

constructor TfrmReplacement.Create(const AObjectID, AEstimateID, ARateID,
      AMatMechID: Integer; AType: Byte; ATemp, AAdd: Boolean);
begin
  inherited Create(nil);

  FTemp := ATemp;
  FAddMode := AAdd;

  //Зачем этот код именно в Create не известно
  grdRep.ColWidths[0] := 20;
  grdRep.ColWidths[1] := 100;
  grdRep.ColWidths[2] := 440;
  grdRep.ColWidths[3] := 70;
  if FAddMode then
    grdRep.ColWidths[4] := -1
  else
    grdRep.ColWidths[4] := 70;
  grdRep.ColWidths[5] := -1;

  grdRep.Cells[0,0] := '№';
  grdRep.Cells[1,0] := 'Код';
  grdRep.Cells[2,0] := 'Наименование';
  grdRep.Cells[3,0] := 'Ед. изм.';
  grdRep.Cells[4,0] := 'Коэф. пер.';
  grdRep.Cells[5,0] := 'ID';

  grdRep.Cells[0,1] := '1';
  grdRep.Cells[4,1] := '1';


  if grdRep.Col = 1 then
    grdRep.Options := grdRep.Options - [goEditing];

  //Просто левое число, что-бы onClick отработал
  FCurType := 9;

  FMonth := 0;
  FYear := 0;
  FRegion := 0;

  FObjectID := AObjectID;
  FEstimateID := AEstimateID;
  FRateID := ARateID;
  FMatMechID := AMatMechID;
  FObjectName := '';
  FEstimateName := '';
  FRateCode := '';

  LoadObjEstInfo;

  if FAddMode then
  begin
     Panel1.Visible := False;
     groupEntry.Visible := False;
     groupRep.Height := 200;
     groupRep.Caption := ' Добавить в расценку ' + FRateCode + ': ';
     Caption := 'Добавление материалов и механизмов';
     btnReplace.Caption := 'Добавить';
  end;

  //Установка типа приводит к загрузке справочника
  if (AType > 0) then
    rgroupType.ItemIndex := 1
  else
    rgroupType.ItemIndex := 0;

  if not FAddMode then
  begin
    LoadRepInfo;
    LoadEntry;
  end;
end;

procedure TfrmReplacement.edtFindKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    btnFindClick(nil);
    Key := #0;
  end;
end;

procedure TfrmReplacement.LoadObjEstInfo;
var TmpStr: string;
begin
  qrRep.Active := False;
  qrRep.SQL.Text := 'SELECT ob.region_id, reg.region_name, ob.NAME ' +
    'FROM objcards as ob, regions as reg ' +
    'WHERE (ob.region_id = reg.region_id) and ' +
    '(ob.obj_id = ' + IntToStr(FObjectID) + ');';
  qrRep.Active := True;
  if not qrRep.IsEmpty then
  begin
    FRegion := qrRep.Fields[0].AsInteger;
    FRegionName := qrRep.Fields[1].AsString;
    FObjectName := qrRep.Fields[2].AsString;
  end;
  qrRep.Active := False;

  qrRep.SQL.Text := 'SELECT IFNULL(monat,0) as monat, ' +
    'IFNULL(year,0) as year, CONCAT(SM_NUMBER, " ",  NAME) as SMNAME ' +
    'FROM smetasourcedata ' +
    'LEFT JOIN stavka ON stavka.stavka_id = smetasourcedata.stavka_id ' +
    'WHERE sm_id = ' + IntToStr(FEstimateID) + ';';
  qrRep.Active := True;
  if not qrRep.IsEmpty then
  begin
    FMonth := qrRep.Fields[0].AsInteger;
    FYear := qrRep.Fields[1].AsInteger;
    FEstimateName := qrRep.Fields[2].AsString;
  end;
  qrRep.Active := False;

  TmpStr := '';
  if FTemp then
    TmpStr := '_temp';

  qrRep.SQL.Text := 'SELECT RATE_CODE FROM card_rate' + TmpStr +
    ' WHERE (ID = ' + IntToStr(FRateID) + ');';
  qrRep.Active := True;
  if not qrRep.IsEmpty then
  begin
    FRateCode := qrRep.Fields[0].AsString;
  end;
  qrRep.Active := False;
end;

procedure TfrmReplacement.LoadRepInfo;
var TmpStr: string;
begin
  if FTemp then
    TmpStr := '_temp';

  if FCurType = 0 then
    qrRep.SQL.Text :=
      'select MAT_CODE, MAT_NAME from materialcard' + TmpStr + ' where ID = ' +
      FMatMechID.ToString
  else
    qrRep.SQL.Text :=
      'Select MECH_CODE, MECH_NAME from mechanizmcard' + TmpStr + ' where ID = ' +
      FMatMechID.ToString;

  qrRep.Active := True;
  if not qrRep.IsEmpty then
  begin
    edtSourceCode.Text := qrRep.Fields[0].AsString;
    edtSourceName.Text := qrRep.Fields[1].AsString;
    edtFind.Text := edtSourceName.Text;
  end;
  qrRep.Active := False;
end;

procedure TfrmReplacement.LoadEntry;
var Item: TListItem;
    ind: Integer;
    TmpStr,
    WhereStr: string;
begin

  TmpStr := '';
  WhereStr := '';

  if FTemp then
    TmpStr := '_temp';

  //Поиск по смете
  if (FEstimateName <> '') then
  begin
    groupEntry.Caption := ' Вхождения в ' + FEstimateName + ':';
    if FTemp then
      WhereStr := ' AND ((SM.SM_ID = ' + FEstimateID.ToString + ') OR ' +
        '(SM.PARENT_ID = ' + FEstimateID.ToString + ') OR ' +
        '(SM.PARENT_ID IN (SELECT smetasourcedata.SM_ID FROM ' +
        'smetasourcedata WHERE smetasourcedata.PARENT_ID = ' +
        FEstimateID.ToString + ')))';
  end
  else
  begin
    groupEntry.Caption := ' Вхождения в ' + FObjectName + ':';
    if FTemp then
      WhereStr := ' AND (SM.OBJ_ID = ' + FObjectID.ToString + ')';
  end;

  qrTemp.Active := False;
  if (FCurType = 0) then
    qrTemp.SQL.Text := 'SELECT SM.SM_ID as SMID, ' +
      'CONCAT(SM.SM_NUMBER, " ",  SM.NAME) as SMNAME, ' +
      'RT.ID as RTID, RT.RATE_CODE as RTCODE, MT.ID as MTID, ' +
      'MT.MAT_CODE as MTCODE, MT.MAT_COUNT as MTCOUNT, ' +
      'MT.MAT_UNIT as MTUNIT, MT.MAT_NORMA as MTNORMA, ' +
      'MT.REPLACED as MTREP ' +
      'FROM smetasourcedata as SM, data_estimate' + TmpStr + ' as ES, ' +
      'card_rate' + TmpStr + ' as RT, materialcard' + TmpStr + ' as MT ' +
      'WHERE (SM.SM_ID = ES.ID_ESTIMATE) AND (ES.ID_TYPE_DATA = 1) AND ' +
      '(ES.ID_TABLES = RT.ID) AND (RT.ID = MT.ID_CARD_RATE) AND ' +
      '(MT.ID_REPLACED = 0) AND ' +
      '(MT.MAT_CODE = ''' + edtSourceCode.Text + ''')' + WhereStr
  else
    qrTemp.SQL.Text :=
      'SELECT SM.SM_ID as SMID, ' +
      'CONCAT(SM.SM_NUMBER, " ",  SM.NAME) as SMNAME, ' +
      'RT.ID as RTID, RT.RATE_CODE as RTCODE, MT.ID as MTID, ' +
      'MT.MECH_CODE as MTCODE, MT.MECH_COUNT as MTCOUNT, ' +
      'MT.MECH_UNIT as MTUNIT, MT.MECH_NORMA as MTNORMA, ' +
      'MT.REPLACED as MTREP ' +
      'FROM smetasourcedata as SM, data_estimate' + TmpStr + ' as ES, ' +
      'card_rate' + TmpStr + ' as RT, mechanizmcard' + TmpStr + ' as MT ' +
      'WHERE (SM.SM_ID = ES.ID_ESTIMATE) AND (ES.ID_TYPE_DATA = 1) AND ' +
      '(ES.ID_TABLES = RT.ID) AND (RT.ID = MT.ID_CARD_RATE) AND ' +
      '(MT.ID_REPLACED = 0) AND ' +
      '(MT.MECH_CODE = ''' + edtSourceCode.Text + ''')' + WhereStr;

  ListEntry.Visible := False;
  ListEntry.Items.Clear;

  ind := 0;
  SetLength(FEntryArray, 0);
  qrTemp.Active := True;
  while not qrTemp.Eof do
  begin
    Inc(ind);
    SetLength(FEntryArray, ind);
    FEntryArray[ind - 1].EID := qrTemp.FieldByName('SMID').AsInteger;
    FEntryArray[ind - 1].EName := qrTemp.FieldByName('SMNAME').AsString;
    FEntryArray[ind - 1].RID := qrTemp.FieldByName('RTID').AsInteger;
    FEntryArray[ind - 1].RCode := qrTemp.FieldByName('RTCODE').AsString;
    FEntryArray[ind - 1].MID := qrTemp.FieldByName('MTID').AsInteger;
    FEntryArray[ind - 1].MCode := qrTemp.FieldByName('MTCODE').AsString;
    FEntryArray[ind - 1].MUnt := qrTemp.FieldByName('MTUNIT').AsString;
    FEntryArray[ind - 1].MNorma := qrTemp.FieldByName('MTNORMA').AsFloat;
    FEntryArray[ind - 1].MCount := qrTemp.FieldByName('MTCOUNT').AsFloat;
    if (qrTemp.FieldByName('MTREP').AsInteger > 0) then
      FEntryArray[ind - 1].MRep := True
    else
      FEntryArray[ind - 1].MRep := False;

    if (FMatMechID > 0) then
      FEntryArray[ind - 1].Select :=
        (FMatMechID = qrTemp.FieldByName('MTID').AsInteger) and
        (not FEntryArray[ind - 1].MRep)
    else //Замененные не выделены
      FEntryArray[ind - 1].Select := not FEntryArray[ind - 1].MRep;

    Item := ListEntry.Items.Add;
    //Так как лист заполняется вместе с массивом
    //сохраняется не ссылка на структуру, а её индекс
    Item.Data := Pointer(ind);
    qrTemp.Next;
  end;
  qrTemp.Active := False;
  ListEntry.Visible := True;
end;

procedure TfrmReplacement.btnFindClick(Sender: TObject);
begin
  //Заполняет справочник с поисковой строкой
  FillSprList(edtFind.Text);
end;

procedure TfrmReplacement.btnReplaceClick(Sender: TObject);
var i, j, ind:  Integer;
    Flag: Boolean;
    IDArray: array of Integer;
    CoefArray: array of Double;
    DelOnly: Boolean;
begin
  DelOnly := (TButton(Sender).Tag = 1);
  if not FAddMode then
  begin
    Flag := False;
    for i := Low(FEntryArray) to High(FEntryArray) do
      if FEntryArray[i].Select then
      begin
        Flag := True;
        Break;
      end;

    if not Flag then
    begin
      if FCurType = 0 then
        Showmessage('Не задан заменяемый материал!')
      else
        Showmessage('Не задан заменяемый механизм!');
      Exit;
    end;
  end;

  ind := 0;
  SetLength(IDArray, ind);
  SetLength(CoefArray, ind);
  SetLength(FRateIDArray, ind);
  SetLength(FEstIDArray, ind);

  for i := grdRep.FixedRows to grdRep.RowCount - 1 do
    if (grdRep.Cells[5, i] <> '') then
    begin
      Inc(ind);
      SetLength(IDArray, ind);
      SetLength(CoefArray, ind);
      IDArray[ind - 1] := grdRep.Cells[5, i].ToInteger;
      CoefArray[ind - 1] := grdRep.Cells[4, i].ToDouble;
    end;

  if (Length(IDArray) = 0) and ((not DelOnly) or FAddMode) then
  begin
    if FCurType = 0 then
      Showmessage('Не задано ни одного заменяющего материала!')
    else
      Showmessage('Не задано ни одного заменяющего механизма!');
    Exit;
  end;

  Screen.Cursor := crHourGlass;
  try
    if FAddMode then
    begin
      //Выполняются замены
      for j := Low(IDArray) to High(IDArray) do
      begin
        if FCurType = 0 then
          qrTemp.SQL.Text := 'CALL ReplacedMaterial(:IdEst, :IdRate, 1, :IdMS, 0, 0, :CalcMode);'
        else
          qrTemp.SQL.Text := 'CALL ReplacedMechanism(:IdEst, :IdRate, 1, :IdMS, 0, 0, :CalcMode);';
        qrTemp.ParamByName('IdEst').Value := FEstimateID;
        qrTemp.ParamByName('IdRate').Value := FRateID;
        qrTemp.ParamByName('IdMS').Value := IDArray[j];
        qrTemp.ParamByName('CalcMode').Value := CalcMode;
        qrTemp.ExecSQL;
      end;
    end
    else
    begin
      for i := Low(FEntryArray) to High(FEntryArray) do
      begin
        //Не отмеченные пропускаются
        if not FEntryArray[i].Select then
          Continue;

        //Новые запронутые расценки запоминиаются для последующего пересчета
        Flag := False;
        for j := Low(FRateIDArray) to High(FRateIDArray) do
          if FRateIDArray[j] = FEntryArray[i].RID then
            Flag := True;

        if not Flag then
        begin
          j := Length(FRateIDArray);
          SetLength(FRateIDArray, j + 1);
          SetLength(FEstIDArray, j + 1);
          FRateIDArray[j] := FEntryArray[i].RID;
          FEstIDArray[j] := FEntryArray[i].EID;
        end;

        //Если ранее были замены, удаляются
        if FEntryArray[i].MRep then
          ShowDelRep('', FEntryArray[i].MID, True);

        if not DelOnly then
        begin
          //Выполняются замены
          for j := Low(IDArray) to High(IDArray) do
          begin
            if FCurType = 0 then
              qrTemp.SQL.Text := 'CALL ReplacedMaterial(:IdEst, 0, 0, :IdMS, :IdMR, :Coef, :CalcMode);'
            else
              qrTemp.SQL.Text := 'CALL ReplacedMechanism(:IdEst, 0, 0, :IdMS, :IdMR, :Coef, :CalcMode);';
            qrTemp.ParamByName('IdEst').Value := FEntryArray[i].EID;
            qrTemp.ParamByName('IdMR').Value := FEntryArray[i].MID;
            qrTemp.ParamByName('IdMS').Value := IDArray[j];
            qrTemp.ParamByName('Coef').Value := CoefArray[j];
            qrTemp.ParamByName('CalcMode').Value := CalcMode;
            qrTemp.ExecSQL;
          end;
        end;
      end;
    end;
  finally
    Screen.Cursor := crDefault;
    ModalResult := mrYes;
  end;
end;

procedure TfrmReplacement.btnSelectClick(Sender: TObject);
begin
  //Выбор из справочника
  if (ListSpr.ItemIndex > -1) then
  begin
    grdRep.Cells[1, grdRep.Row] :=
      TSprRecord(ListSpr.Items[ListSpr.ItemIndex].Data^).Code;
    grdRep.Cells[2, grdRep.Row] :=
      TSprRecord(ListSpr.Items[ListSpr.ItemIndex].Data^).Name;
    grdRep.Cells[3, grdRep.Row] :=
      TSprRecord(ListSpr.Items[ListSpr.ItemIndex].Data^).Unt;
    grdRep.Cells[5, grdRep.Row] :=
      TSprRecord(ListSpr.Items[ListSpr.ItemIndex].Data^).ID.ToString;
  end;
end;

procedure TfrmReplacement.ChangeType(AType: byte);
var TmpStr: string;
begin
  case AType of
    //Материалы
    0:
    begin
      groupReplace.Caption := 'Материал:';
      ListEntry.Columns[2].Caption := 'Материал';

      cbMat.Visible := True;
      cbJBI.Visible := True;

      if FFlag then
      begin
        groupCatalog.Caption := 'Справочник материалов за ' +
          AnsiLowerCase(arraymes[FMonth][1]) + ' ' + IntToStr(FYear) + 'г. ' +
          FRegionName + ':';
        TmpStr := 'SELECT material.material_id as "Id", mat_code as "Code", ' +
          'cast(mat_name as char(1024)) as "Name", unit_name as "Unit", ' +
          'coast' + IntToStr(FRegion) + '_1 as "PriceVAT", ' +
          'coast' + IntToStr(FRegion) + '_2 as "PriceNotVAT", ' +
          'MAT_TYPE ' +
          'FROM material, units, materialcoastg ' +
          'WHERE (material.unit_id = units.unit_id) ' +
          'and (material.material_id = materialcoastg.material_id) ' +
          'and (material.MAT_TYPE in (1,2)) and (year=' + IntToStr(FYear) +
          ') and (monat=' + IntToStr(FMonth) +') ORDER BY mat_code;';
      end
      else
      begin
        groupCatalog.Caption := 'Справочник материалов:';
        TmpStr := 'SELECT material.material_id as "Id", mat_code as "Code", ' +
          'cast(mat_name as char(1024)) as "Name", unit_name as "Unit", ' +
          'MAT_TYPE ' +
          'FROM material, units ' +
          'WHERE (material.unit_id = units.unit_id) ' +
          'and (material.MAT_TYPE in (1,2)) ORDER BY mat_code;';
      end;
    end;
    //Механизмы
    1:
    begin
      groupReplace.Caption := 'Механизм:';
      ListEntry.Columns[2].Caption := 'Механизм';

      cbMat.Visible := False;
      cbJBI.Visible := False;

      if FFlag then
      begin
        groupCatalog.Caption := 'Справочник механизмов за ' +
          AnsiLowerCase(arraymes[FMonth][1]) + ' ' + IntToStr(FYear) + 'г.:';
        TmpStr := 'SELECT mechanizm.mechanizm_id as "Id", mech_code as "Code", ' +
          'cast(mech_name as char(1024)) as "Name", unit_name as "Unit", ' +
          'coast1 as "PriceVAT", coast2 as "PriceNotVAT" ' +
          'FROM mechanizm, units, mechanizmcoastg' +
          ' WHERE (mechanizm.unit_id = units.unit_id) and ' +
          '(mechanizm.mechanizm_id = mechanizmcoastg.mechanizm_id) and ' +
          '(year=' + IntToStr(FYear) + ') and (monat=' + IntToStr(FMonth) +
          ') ORDER BY mech_code;';
      end
      else
      begin
        groupCatalog.Caption := 'Справочник механизмов:';
        TmpStr := 'SELECT mechanizm.mechanizm_id as "Id", mech_code as "Code", ' +
          'cast(mech_name as char(1024)) as "Name", unit_name as "Unit" ' +
          'FROM mechanizm, units, mechanizmcoastg' +
          ' WHERE (mechanizm.unit_id = units.unit_id) ORDER BY mech_code;';
      end;
    end;
  end;

  LoadLabel.Visible := True;
  LoadAnimator.Visible := True;
  LoadAnimator.Animate := True;
  ListSpr.Visible := False;
  btnFind.Enabled := False;
  cbMat.Enabled := False;
  cbJBI.Enabled := False;
  btnSelect.Enabled := False;
  StatusBar1.Panels[0].Text := '';
  StatusBar1.Panels[1].Text := '';

  //Вызов нити выполняющей запрос на данные справлчника
  TThreadQuery.Create(TmpStr, Handle);

  edtSourceCode.Text := '';
  edtSourceName.Text := '';
end;

procedure TfrmReplacement.rgroupTypeClick(Sender: TObject);
begin
  if FCurType <> rgroupType.ItemIndex then
  begin
    FCurType := rgroupType.ItemIndex;
    //Флаг показывать цены или нет
    FFlag :=
      ((FCurType = 0) and (FMonth > 0) and (FYear > 0) and (FRegion > 0))
      or
      ((FCurType = 1) and (FMonth > 0) and (FYear > 0));
    ChangeType(FCurType);
  end;
end;

procedure TfrmReplacement.SpeedButton1Click(Sender: TObject);
begin
  //Добавляет строку в таблицу заменяющих
  grdRep.RowCount := grdRep.RowCount + 1;
  grdRep.Cells[0, grdRep.RowCount - 1] := (grdRep.RowCount - 1).ToString;
  grdRep.Cells[4, grdRep.RowCount - 1] := '1';
  grdRep.Row := grdRep.RowCount - 1;
end;

procedure TfrmReplacement.SpeedButton2Click(Sender: TObject);
var i, j: Integer;
begin
  //Удаляет строку из таблицы заменяющих
  if (grdRep.RowCount > grdRep.FixedRows + 1) then
  begin
    for i := grdRep.Row to grdRep.RowCount - 2 do
      for j := grdRep.FixedCols to grdRep.ColCount - 1 do
        grdRep.Cells[j, i] := grdRep.Cells[j, i + 1];

    for j := 0 to grdRep.ColCount - 1 do
        grdRep.Cells[j, grdRep.RowCount - 1] := '';

    grdRep.RowCount := grdRep.RowCount - 1;
  end;
end;

procedure TfrmReplacement.btnCancelClick(Sender: TObject);
begin
  Close;
end;

end.
