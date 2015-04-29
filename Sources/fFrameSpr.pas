unit fFrameSpr;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.Samples.Spin, Vcl.ExtCtrls, GlobsAndConst, Vcl.ComCtrls, Vcl.Buttons,
  JvExControls, JvAnimatedImage, JvGIFCtrl, Data.DB;

type
  //Базовый класс для построения справочников
  TSprFrame = class(TFrame)
    PanelSettings: TPanel;
    lbYear: TLabel;
    lbMonth: TLabel;
    cmbMonth: TComboBox;
    edtYear: TSpinEdit;
    PanelFind: TPanel;
    lbFind: TLabel;
    edtFind: TEdit;
    btnFind: TButton;
    btnShow: TButton;
    Memo: TMemo;
    SpeedButtonShowHide: TSpeedButton;
    ListSpr: TListView;
    LoadAnimator: TJvGIFAnimator;
    LoadLabel: TLabel;
    StatusBar: TStatusBar;
    procedure SpeedButtonShowHideClick(Sender: TObject);
    procedure ListSprCustomDrawItem(Sender: TCustomListView; Item: TListItem;
      State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure ListSprSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure btnShowClick(Sender: TObject);
    procedure edtYearChange(Sender: TObject);
    procedure edtFindKeyPress(Sender: TObject; var Key: Char);
    procedure btnFindClick(Sender: TObject);
    procedure ListSprResize(Sender: TObject);
  private
    procedure OnExcecute(var Mes: TMessage); message WM_EXCECUTE;
  protected
    { Private declarations }
    FPriceColumn: Boolean;
    //Основной массив справочника
    FSprArray: TSprArray;
    //Возвращает текст запроса
    function GetSprSQL: string; virtual; abstract;
    //Заполняет основной массив справочника
    procedure FillSprArray(ADataSet: TDataSet); virtual;
    //Особые индивидуальные условия (не реализованные в FillSprArray)
    procedure SpecialFillArray(const AInd: Integer; ADataSet: TDataSet); virtual;

    //Заполняет таблицу исходя из поискового запроса
    procedure FillSprList(AFindStr: string); virtual;
    //Проверяет поисковый запрос на код
    function CheckFindCode(AFindStr: string): Boolean; virtual;
    //Особые условия при заполнении таблицы
    function SpecialFillList(const AInd: Integer): Boolean; virtual;

    //Устанавливает внешний вид формы перед началом загрузки
    procedure OnLoadStart; virtual;
    //Устанавливает внешний вид формы после загрузки
    procedure OnLoadDone; virtual;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; const APriceColumn: Boolean;
      const AStarDate: TDateTime); reintroduce;
    procedure LoadSpr;
  end;

implementation

{$R *.dfm}

uses DataModule, Tools;

{ TSprFrame }

procedure TSprFrame.FillSprArray(ADataSet: TDataSet);
var ind: Integer;
    TmpCount: Integer;
begin
  ind := 0;
  TmpCount := 0;
  try
    if ADataSet.Active then
    begin
      while not ADataSet.Eof do
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
        FSprArray[ind - 1].ID := ADataSet.Fields[0].AsInteger;
        FSprArray[ind - 1].Code := ADataSet.Fields[1].AsString;
        FSprArray[ind - 1].Name := ADataSet.Fields[2].AsString;
        FSprArray[ind - 1].Unt := ADataSet.Fields[3].AsString;
        if FPriceColumn then
        begin
          FSprArray[ind - 1].CoastNDS := ADataSet.Fields[4].AsFloat;
          FSprArray[ind - 1].CoactNoNDS := ADataSet.Fields[5].AsFloat;
        end;

        SpecialFillArray(ind, ADataSet);
        ADataSet.Next;
      end;
    end;
  finally
    SetLength(FSprArray, ind);
  end;
end;

procedure TSprFrame.SpecialFillArray(const AInd: Integer; ADataSet: TDataSet);
begin

end;

procedure TSprFrame.btnFindClick(Sender: TObject);
begin
  FillSprList(edtFind.Text);
end;

procedure TSprFrame.btnShowClick(Sender: TObject);
begin
  LoadSpr;
end;

function TSprFrame.CheckFindCode(AFindStr: string): Boolean;
begin
  Result := False;
  {
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
  }

end;

 //заполняет справочник
procedure TSprFrame.FillSprList(AFindStr: string);
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
       if CheckFindCode(AFindStr) then
          FindType := 2;

       if FindType = 1 then
       begin
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
    end;

    //Видимый список обновляется намного дольше
    ListSpr.Visible :=  False;
    ListSpr.Items.Clear;
    for i := Low(FSprArray) to High(FSprArray) do
    begin
      if SpecialFillList(i) then
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

      if (i mod 2000) = 0 then
          Application.ProcessMessages;

      //Создаем пустые итемы, заполним их при отображении
      Item := ListSpr.Items.Add;
      Item.Data := @FSprArray[i];
    end;

    ListSpr.Visible :=  True;
    if (ListSpr.Items.Count > 0) then
      ListSpr.ItemIndex := 0
    else
    begin
      StatusBar.Panels[0].Text := '   0/0';
      Memo.Text := '';
    end;
  finally
    WordList.Free;
  end;
end;

function TSprFrame.SpecialFillList(const AInd: Integer): Boolean;
begin
  Result := False;
end;

procedure TSprFrame.OnExcecute(var Mes: TMessage);
begin
  try
    //Если в потоке возникло исключение воспроизводим его
    if Assigned(Exception(Mes.LParam)) or
      not Assigned(TDataSet(Mes.WParam)) then
    begin
      if Assigned(Exception(Mes.LParam)) then
        raise Exception(Mes.LParam);
      Exit;
    end;

    FillSprArray(TDataSet(Mes.WParam));
    //Заполнение справочника
    FillSprList(edtFind.Text);
  finally
    OnLoadDone;
  end;
end;

constructor TSprFrame.Create(AOwner: TComponent; const APriceColumn: Boolean;
      const AStarDate: TDateTime);
var i: Integer;
    y,m,d: Word;
begin
  inherited Create(AOwner);

  cmbMonth.Items.Clear;
  for i := Low(arraymes) to High(arraymes) do
    cmbMonth.Items.Add(arraymes[i][1]);

  FPriceColumn := APriceColumn;
  if not FPriceColumn then
  begin
    ListSpr.Columns.Delete(4);
    ListSpr.Columns.Delete(3);
  end;

  DecodeDate(AStarDate,y,m,d);
  edtYear.Value := y;
  cmbMonth.ItemIndex := m - 1;

  SpeedButtonShowHide.Hint := 'Свернуть панель';
  DM.ImageListArrowsBottom.GetBitmap(0, SpeedButtonShowHide.Glyph);
end;

procedure TSprFrame.edtFindKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    btnFindClick(nil);
    Key := #0;
  end;
end;

procedure TSprFrame.edtYearChange(Sender: TObject);
begin
  btnShow.Enabled := True;
end;

procedure TSprFrame.ListSprCustomDrawItem(Sender: TCustomListView;
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

    if FPriceColumn then
    begin
      Item.SubItems.Add(FloatToStr(TSprRecord(Item.Data^).CoastNDS));
      Item.SubItems.Add(FloatToStr(TSprRecord(Item.Data^).CoactNoNDS));
    end;
  end;
  DefaultDraw := True;
end;

procedure TSprFrame.ListSprResize(Sender: TObject);
var i, j: Integer;
begin
  j := ListSpr.Width;
  ListSpr.Columns[0].Width := 100;
  ListSpr.Columns[2].Width := 70;
  if FPriceColumn then
  begin
    ListSpr.Columns[3].Width := 100;
    ListSpr.Columns[4].Width := 100;
  end;
  for i := 0 to ListSpr.Columns.Count - 1 do
    if i <> 1 then
      j := j - ListSpr.Columns[i].Width;
  ListSpr.Columns[1].Width := j - 50;
end;

procedure TSprFrame.ListSprSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  if Assigned(Item) and Assigned(Item.Data) then
  begin
    StatusBar.Panels[0].Text := '   ' +
      (Item.Index + 1).ToString + '/' + ListSpr.Items.Count.ToString;
    Memo.Text := TSprRecord(Item.Data^).Name;
  end;
end;

procedure TSprFrame.LoadSpr;
var TmpStr: string;
begin
  TmpStr := GetSprSQL;
  //Вызов нити выполняющей запрос на данные справлчника
  TThreadQuery.Create(TmpStr, Handle);
  OnLoadStart;
  Application.ProcessMessages;
end;

procedure TSprFrame.OnLoadStart;
begin
  btnShow.Enabled := False;
  edtYear.Enabled := False;
  cmbMonth.Enabled := False;
  edtFind.Enabled := False;
  btnFind.Enabled := False;
  SetLength(FSprArray, 0);
  ListSpr.Items.Clear;
  ListSpr.Visible := False;
  StatusBar.Panels[0].Text := '';
  Memo.Text := '';

  LoadLabel.Visible := True;
  LoadAnimator.Visible := True;
  LoadAnimator.Animate := True;
end;

procedure TSprFrame.OnLoadDone;
begin
  if FPriceColumn then
  begin
    edtYear.Enabled := True;
    cmbMonth.Enabled := True;
  end;
  edtFind.Enabled := True;
  btnFind.Enabled := True;
  ListSpr.Visible := True;

  LoadLabel.Visible := False;
  LoadAnimator.Visible := False;
  LoadAnimator.Animate := False;
end;

procedure TSprFrame.SpeedButtonShowHideClick(Sender: TObject);
begin
  with (Sender as TSpeedButton) do
  begin
    Glyph.Assign(nil);

    if Tag = 1 then
    begin
      Tag := 0;
      Memo.Visible := False;
      DM.ImageListArrowsTop.GetBitmap(0, Glyph);
      Hint := 'Развернуть панель';
    end
    else
    begin
      Tag := 1;
      SpeedButtonShowHide.Align := alNone;
      Memo.Visible := True;
      SpeedButtonShowHide.Align := alBottom;
      Hint := 'Свернуть панель';
      DM.ImageListArrowsBottom.GetBitmap(0, Glyph);
    end;
  end;
end;

end.
