unit fFrameSpr;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  System.Masks, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.Samples.Spin, Vcl.ExtCtrls, GlobsAndConst, Vcl.ComCtrls, Vcl.Buttons,
  JvExControls, JvAnimatedImage, JvGIFCtrl, Data.DB,
  Generics.Collections,
  Generics.Defaults,
  System.IOUtils,
  SprController;

type
  TSortRec = TPair<Integer, Pointer>;

  TSprItemSelectEvent = procedure(ASprRecord: PSprRecord) of object;

  //Базовый класс для построения справочников
  TSprFrame = class(TFrame)
    PanelSettings: TPanel;
    lbYear: TLabel;
    lbMonth: TLabel;
    cmbMonth: TComboBox;
    edtYear: TSpinEdit;
    PanelFind: TPanel;
    lbFindCode: TLabel;
    edtFindName: TEdit;
    btnFind: TButton;
    btnShow: TButton;
    Memo: TMemo;
    SpeedButtonShowHide: TSpeedButton;
    ListSpr: TListView;
    LoadAnimator: TJvGIFAnimator;
    LoadLabel: TLabel;
    StatusBar: TStatusBar;
    edtFindCode: TEdit;
    lbFindName: TLabel;
    procedure SpeedButtonShowHideClick(Sender: TObject);
    procedure ListSprCustomDrawItem(Sender: TCustomListView; Item: TListItem;
      State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure ListSprSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure btnShowClick(Sender: TObject);
    procedure edtYearChange(Sender: TObject);
    procedure edtFindNameKeyPress(Sender: TObject; var Key: Char);
    procedure btnFindClick(Sender: TObject);
    procedure ListSprResize(Sender: TObject);

  private
    //Фаг того, что справочник загружен
    FLoaded: Boolean;
    FSprArray: TSprArray;
    FOnAfterLoad: TNotifyEvent;

    procedure WMSprLoad(var Mes: TMessage); message WM_SPRLOAD;
    procedure WMPriceLoad(var Mes: TMessage); message WM_PRICELOAD;
    procedure CopySprArray;
  protected
    //Тип справочника
    FSprType: Integer;
    FPriceColumn: Boolean;
    //Не показывать колонку едениц измерения
    FNoEdCol: Boolean;
    FOnSprItemSelect: TSprItemSelectEvent;

    function GetSprType: Integer; virtual; abstract;
    function GetRegion: Integer; virtual;
    //Заполняет таблицу исходя из поискового запроса
    procedure FillSprList(AFindCode, AFindName: string); virtual;
    function CheckFindCode(AFindCode: string): string; virtual;
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
    function FindCode(const ACode: string): PSprRecord;

    property OnSprItemSelect: TSprItemSelectEvent
      read FOnSprItemSelect write FOnSprItemSelect;
    property OnAfterLoad: TNotifyEvent read FOnAfterLoad write FOnAfterLoad;
    property SprLoaded: Boolean read FLoaded;
  end;

implementation

{$R *.dfm}

uses DataModule, Tools;

{ TSprFrame }

constructor TSprFrame.Create(AOwner: TComponent; const APriceColumn: Boolean;
      const AStarDate: TDateTime);
var i: Integer;
    y,m,d: Word;
    lc: TListColumn;
begin
  inherited Create(AOwner);
  btnShow.Visible := False;

  FLoaded := False;

  cmbMonth.Items.Clear;
  for i := Low(arraymes) to High(arraymes) do
    cmbMonth.Items.Add(arraymes[i][1]);

  FPriceColumn := APriceColumn;
  if not FPriceColumn then
  begin
    ListSpr.Columns.Delete(4);
    ListSpr.Columns.Delete(3);
  end;

  if FNoEdCol then
  begin
    if FPriceColumn then
    begin
      ListSpr.Columns.Delete(4);
      ListSpr.Columns.Delete(3);
    end;
    ListSpr.Columns.Delete(2);
    if FPriceColumn then
    begin
      lc := ListSpr.Columns.Add;
      lc.Caption := 'Цена без НДС, руб';
      lc := ListSpr.Columns.Add;
      lc.Caption := 'Цена с НДС, руб';
    end;
  end;

  PanelSettings.Visible :=  FPriceColumn;

  DecodeDate(AStarDate,y,m,d);
  edtYear.Value := y;
  cmbMonth.ItemIndex := m - 1;

  SpeedButtonShowHide.Hint := 'Свернуть панель';
  DM.ImageListArrowsBottom.GetBitmap(0, SpeedButtonShowHide.Glyph);

  Update
end;

function TSprFrame.GetRegion;
begin
  Result := 0;
end;

procedure TSprFrame.LoadSpr;
var FRegion: Integer;
begin
  FSprType := GetSprType;
  if FPriceColumn then
  begin
    FRegion := GetRegion;
    SprControl.SetPriceNotify(edtYear.Value, cmbMonth.ItemIndex + 1, FRegion,
      Handle, FSprType);
  end
  else
    SprControl.SetSprNotify(Handle, FSprType);

  OnLoadStart;
end;

procedure TSprFrame.OnLoadStart;
begin
  btnShow.Enabled := False;
  edtYear.Enabled := False;
  cmbMonth.Enabled := False;
  edtFindCode.Enabled := False;
  edtFindName.Enabled := False;
  btnFind.Enabled := False;

  ListSpr.Items.Clear;
  ListSpr.Visible := False;
  StatusBar.Panels[0].Text := '';
  Memo.Text := '';

  LoadLabel.Visible := True;
  LoadAnimator.Visible := True;
  LoadAnimator.Animate := True;

  FLoaded := False;
end;

procedure TSprFrame.CopySprArray;
var I: Integer;
begin
  SetLength(FSprArray, SprControl.SprCount[FSprType]);
  for I := Low(FSprArray) to High(FSprArray) do
  begin
    FSprArray[I].ID := SprControl.SprList[FSprType][I].ID;
    FSprArray[I].Code := SprControl.SprList[FSprType][I].Code;
    FSprArray[I].Name := SprControl.SprList[FSprType][I].Name;
    FSprArray[I].Unt := SprControl.SprList[FSprType][I].Unt;
    FSprArray[I].CoastNDS := SprControl.SprList[FSprType][I].CoastNDS;
    FSprArray[I].CoastNoNDS := SprControl.SprList[FSprType][I].CoastNoNDS;
    FSprArray[I].ZpMach := SprControl.SprList[FSprType][I].ZpMach;
    FSprArray[I].TrZatr := SprControl.SprList[FSprType][I].TrZatr;
  end;
end;

procedure TSprFrame.WMSprLoad(var Mes: TMessage);
begin
  try
    //FSprArray := SprControl.SprList[FSprType];
    CopySprArray;
    FillSprList(edtFindCode.Text, edtFindName.Text);
  finally
    OnLoadDone;
  end;
end;

procedure TSprFrame.WMPriceLoad(var Mes: TMessage);
begin
  try
    //FSprArray := SprControl.SprList[FSprType];
    CopySprArray;
    FillSprList(edtFindCode.Text, edtFindName.Text);
  finally
    OnLoadDone;
  end;
end;

procedure TSprFrame.OnLoadDone;
begin
  if FPriceColumn then
  begin
    edtYear.Enabled := True;
    cmbMonth.Enabled := True;
  end;

  edtFindCode.Enabled := True;
  edtFindName.Enabled := True;
  btnFind.Enabled := True;
  ListSpr.Visible := True;

  LoadLabel.Visible := False;
  LoadAnimator.Visible := False;
  LoadAnimator.Animate := False;

  FLoaded := True;

  if Assigned(FOnAfterLoad) then
    FOnAfterLoad(Self);
end;

function TSprFrame.FindCode(const ACode: string): PSprRecord;
var i: Integer;
begin
  Result := nil;
  for i := Low(FSprArray) to High(FSprArray) do
    if SameText(ACode, FSprArray[i].Code) then
    begin
      Result := @FSprArray[i];
      Exit;
    end;
end;

procedure TSprFrame.btnFindClick(Sender: TObject);
begin
  FillSprList(edtFindCode.Text, edtFindName.Text);
end;

procedure TSprFrame.btnShowClick(Sender: TObject);
begin
  LoadSpr;
end;

function TSprFrame.CheckFindCode(AFindCode: string): string;
begin
  Result := AFindCode;
end;

function CompareRel(const Left, Right: TSortRec): Integer;
begin
  Result := Right.Key - Left.Key;
  if Result = 0 then
    Result := CompareText(TSprRecord(Left.Value^).Code,
      TSprRecord(Right.Value^).Code);
end;

 //заполняет справочник
procedure TSprFrame.FillSprList(AFindCode, AFindName: string);
var i, j,
    TmpInd,
    TmpRel,
    TmpCount: Integer;
    TmpCode: string;
    Item: TListItem;
    WordList: TStringList;
    TmpStr: string;
    LastSpase : Boolean;
    //, Cont: Boolean;
    FSortArray: TArray<TSortRec>;
begin
  if Length(FSprArray) = 0 then
    Exit;

  WordList := TStringList.Create;
  try
    AFindCode := CheckFindCode(Trim(AFindCode.ToLower));
    AFindName := Trim(AFindName.ToLower);

    //Определяем тип поиска по имени или по коду
    if (Length(AFindName) > 0) then
    begin
       TmpStr := '';
       LastSpase := False;
       for i := Low(AFindName) to High(AFindName) do
       begin
          if (AFindName[i] = ' ') then
          begin
            if LastSpase then
              Continue
            else
              LastSpase := True;
          end
          else
            LastSpase := False;

          TmpStr := TmpStr + AFindName[i];
       end;
       TmpStr := StringReplace(TmpStr, ' ', sLineBreak,[rfReplaceAll]);
       WordList.Text := TmpStr;
    end;

    //Видимый список обновляется намного дольше
    ListSpr.Visible :=  False;
    ListSpr.Items.Clear;
    SetLength(FSortArray, Length(FSprArray));
    TmpCount := -1;
    for i := Low(FSprArray) to High(FSprArray) do
    begin
      if SpecialFillList(i) then
        Continue;

      //Cont := False;
      TmpRel := 0;

      if (AFindCode <> '') then
      begin
        if (CompareText(AFindCode, FSprArray[i].Code.ToLower) = 0) then
          TmpRel := 20
        else if MatchesMask(FSprArray[i].Code.ToLower, AFindCode + '*') then
          TmpRel := 15
        else
        begin
          TmpCode := copy(AFindCode, 1, Length(AFindCode) - 1);
          if ((Length(TmpCode) > 0) and
              (MatchesMask(FSprArray[i].Code.ToLower, TmpCode + '*'))) then
            TmpRel := 10
          else
            if (Pos(AFindCode, FSprArray[i].Code.ToLower) <> 0) then
              TmpRel := 5;
        end;

        if TmpRel = 0 then
          Continue;
      end;

      TmpStr := Trim(FSprArray[i].Name.ToLower);

      for j := 0 to WordList.Count - 1 do
      begin
        TmpInd := Pos(WordList[j], TmpStr);
        if TmpInd = 0 then
        begin
        //  Cont := True;
        //  Break;
          Continue;
        end;

        if CompareText(WordList[j], TmpStr) = 0 then
          TmpRel := TmpRel + 5
        else if (TmpInd = 1) or
                (TmpStr[TmpInd - 1] = ' ') or
                (Length(TmpStr) = (TmpInd + Length(WordList[j]) - 1)) or
                (TmpStr[TmpInd + Length(WordList[j])] = ' ') then
          TmpRel := TmpRel + 3
        else TmpRel := TmpRel + 1;
      end;

      //if Cont then
      if (TmpRel = 0) and (WordList.Count > 0) then
        Continue;

      if (i mod 1000) = 0 then
          Application.ProcessMessages;

      inc(TmpCount);

      FSortArray[TmpCount].Key := TmpRel;
      FSortArray[TmpCount].Value := @FSprArray[i];
    end;

    SetLength(FSortArray, TmpCount + 1);

    TArray.Sort<TSortRec>(FSortArray,
      TComparer<TSortRec>.Construct(CompareRel));

    for i := 0 to Length(FSortArray) - 1 do
    begin
      if (i mod 1000) = 0 then
          Application.ProcessMessages;

      //Создаем пустые итемы, заполним их при отображении
      Item := ListSpr.Items.Add;
      Item.Data := FSortArray[i].Value;
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

procedure TSprFrame.edtFindNameKeyPress(Sender: TObject; var Key: Char);
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
  ListSpr.Visible := False;
  btnShow.Click;
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

    if not FNoEdCol then
      Item.SubItems.Add(TSprRecord(Item.Data^).Unt);

    if FPriceColumn then
    begin
      if TSprRecord(Item.Data^).CoastNoNDS > 0 then
        Item.SubItems.Add(FloatToStr(TSprRecord(Item.Data^).CoastNoNDS))
      else
        Item.SubItems.Add('');

      if TSprRecord(Item.Data^).CoastNDS > 0 then
        Item.SubItems.Add(FloatToStr(TSprRecord(Item.Data^).CoastNDS))
      else
        Item.SubItems.Add('');
    end;
  end;
  DefaultDraw := True;
end;

procedure TSprFrame.ListSprResize(Sender: TObject);
var i, j: Integer;
begin
  j := ListSpr.Width;

  ListSpr.Columns[0].Width := 100;

  if FNoEdCol then
    i := 2
  else
  begin
    ListSpr.Columns[2].Width := 60;
    i := 3;
  end;

  if FPriceColumn then
  begin
    ListSpr.Columns[i].Width := 110;
    ListSpr.Columns[i + 1].Width := 100;
  end;
  for i := 0 to ListSpr.Columns.Count - 1 do
    if i <> 1 then
      j := j - ListSpr.Columns[i].Width;
  ListSpr.Columns[1].Width := j - 25;
end;

procedure TSprFrame.ListSprSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  if Assigned(Item) then
  begin
    if Assigned(FOnSprItemSelect) then
      FOnSprItemSelect(Item.Data);

    if Assigned(Item.Data) then
    begin
      StatusBar.Panels[0].Text := '   ' +
        (Item.Index + 1).ToString + '/' + ListSpr.Items.Count.ToString;
      Memo.Text := TSprRecord(Item.Data^).Name;
    end;
  end;
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
