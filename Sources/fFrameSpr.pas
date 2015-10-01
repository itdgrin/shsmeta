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
    ListSpr: TListView;
    LoadAnimator: TJvGIFAnimator;
    LoadLabel: TLabel;
    StatusBar: TStatusBar;
    edtFindCode: TEdit;
    lbFindName: TLabel;
    PanelManual: TPanel;
    rbNarmBase: TRadioButton;
    rbUserBase: TRadioButton;
    Bevel1: TBevel;
    PanelDetails: TPanel;
    SpeedButtonShowHide: TSpeedButton;
    gbDetails: TGroupBox;
    gbDetPrice: TGroupBox;
    lvDetPrice: TListView;
    lbDetCode: TLabel;
    edtDetCode: TEdit;
    lbDetEdIzm: TLabel;
    edtDetEdIzm: TEdit;
    lbDetName: TLabel;
    memDetName: TMemo;
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
    procedure PanelDetailsResize(Sender: TObject);
    procedure rbNarmBaseClick(Sender: TObject);
    procedure FrameResize(Sender: TObject);

  private const
    FAdjecEnding2 = 'ее.яя.ая.ое.ие.ые.ой.ей.им.ым.юю.ую.ей.ой.ем.ом.их.ых.ый.ий';
    FAdjecEnding3 = 'ого.его.ему.ому.ими.ыми';
  private
    //Фаг того, что справочник загружен
    FLoaded: Boolean;
    FSprArray: TSprArray;
    FOnAfterLoad: TNotifyEvent;
    FBaseType: Byte; //0 - оба типа, 1 - норматичная, 2 - собственная

    procedure WMSprLoad(var Mes: TMessage); message WM_SPRLOAD;
    procedure WMPriceLoad(var Mes: TMessage); message WM_PRICELOAD;
    procedure CopySprArray;
    procedure DetailsPanelStyle;
    procedure ClearDetailsPanel;
    procedure FillingDetailsPanel(ASprRecord: PSprRecord);

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
      const AStarDate: TDateTime; ABaseType: Byte); reintroduce;
    procedure LoadSpr;
    procedure CheckCurPeriod;
    procedure ChangeDetailsPanel(AStyle: Byte);

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
      const AStarDate: TDateTime; ABaseType: Byte);
var i: Integer;
    y,m,d: Word;
    lc: TListColumn;
    ev: TNotifyEvent;
begin
  if not ABaseType in [0,1,2] then
    raise Exception.Create('Неизвестный тип данных.');

  inherited Create(AOwner);

  FBaseType := ABaseType;
  ev := rbNarmBase.OnClick;
  try
    rbNarmBase.OnClick := nil;
    rbUserBase.OnClick := nil;
    case FBaseType of
      0:
      begin
        rbNarmBase.Checked := True;
        FBaseType := 1;
      end;
      1:
      begin
        rbNarmBase.Checked := True;
        //PanelManual.Enabled := False;
      end;
      2:
      begin
        rbUserBase.Checked := True;
       // PanelManual.Enabled := False;
      end;
    end;
  finally
    rbNarmBase.OnClick := ev;
    rbUserBase.OnClick := ev;
  end;

  ListSpr.Align := alClient;
  LoadAnimator.Align := alClient;
  LoadLabel.Align := alClient;

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

  lbYear.Visible := FPriceColumn;
  edtYear.Visible := FPriceColumn;
  lbMonth.Visible := FPriceColumn;
  cmbMonth.Visible := FPriceColumn;

  DecodeDate(AStarDate,y,m,d);
  ev := edtYear.OnChange;
  try
    edtYear.OnChange := nil;
    cmbMonth.OnChange := nil;
    edtYear.Value := y;
    cmbMonth.ItemIndex := m - 1;
  finally
    edtYear.OnChange := ev;
    cmbMonth.OnChange := ev;
  end;

  G_CURYEAR := edtYear.Value;
  G_CURMONTH := cmbMonth.ItemIndex;

  ChangeDetailsPanel(0);
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

  rbNarmBase.Enabled := False;
  rbUserBase.Enabled := False;

  ListSpr.Items.Clear;
  ListSpr.Visible := False;
  StatusBar.Panels[0].Text := '';

  LoadLabel.Visible := True;
  LoadAnimator.Visible := True;
  LoadAnimator.Animate := True;

  FLoaded := False;
end;

procedure TSprFrame.PanelDetailsResize(Sender: TObject);
begin
  memDetName.Width := PanelDetails.Width - memDetName.Left - 10;
end;

procedure TSprFrame.rbNarmBaseClick(Sender: TObject);
begin
  if rbNarmBase.Checked then FBaseType := 1;
  if rbUserBase.Checked then FBaseType := 2;
  if (SpeedButtonShowHide.Tag = 1) or (FBaseType = 2) then
    ChangeDetailsPanel(0);
  btnFindClick(nil);
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

  rbNarmBase.Enabled := True;
  rbUserBase.Enabled := True;

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

procedure TSprFrame.FrameResize(Sender: TObject);
begin
  if SpeedButtonShowHide.Tag = 1 then
    ChangeDetailsPanel(0);
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
    FSortArray: TArray<TSortRec>;
begin
  if Length(FSprArray) = 0 then
    Exit;

  WordList := TStringList.Create;
  try
    AFindCode := CheckFindCode(Trim(AFindCode.ToLower));
    AFindName := Trim(AFindName.ToLower);

    //разбивка поисковой строки на слова (не самым быстрым пособом)
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
    //добавляет доп слова с обрубленными окончаниями
    if WordList.Count > 0 then
    begin
      for i := 0 to WordList.Count - 1 do
      begin
        if WordList[i].Length < 7 then
          Continue;
        TmpStr := Copy(WordList[i], WordList[i].Length - 1, 2);
        if pos(TmpStr, FAdjecEnding2) > 0 then
          WordList.Add(Copy(WordList[i], 1, WordList[i].Length - 2))
        else
        begin
          TmpStr := Copy(WordList[i], WordList[i].Length - 2, 3);
          if pos(TmpStr, FAdjecEnding3) > 0 then
            WordList.Add(Copy(WordList[i], 1, WordList[i].Length - 3))
        end;
      end;
    end;

    //Видимый список обновляется намного дольше
    ListSpr.Visible :=  False;
    ListSpr.Items.Clear;
    SetLength(FSortArray, Length(FSprArray));
    TmpCount := -1;
    for i := Low(FSprArray) to High(FSprArray) do
    begin
      if (FBaseType = 1) and (FSprArray[i].Manual) then Continue;
      if (FBaseType = 2) and (not FSprArray[i].Manual) then Continue;

      if SpecialFillList(i) then
        Continue;

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

    ListSpr.Items.BeginUpdate;
    try
      for i := 0 to Length(FSortArray) - 1 do
      begin
        if (i mod 1000) = 0 then
            Application.ProcessMessages;

        //Создаем пустые итемы, заполним их при отображении
        Item := ListSpr.Items.Add;
        Item.Data := FSortArray[i].Value;
      end;
    finally
      ListSpr.Items.EndUpdate;
    end;

    ListSpr.Visible :=  True;
    if (ListSpr.Items.Count > 0) then
      ListSpr.ItemIndex := 0
    else
    begin
      StatusBar.Panels[0].Text := '   0/0';
      ClearDetailsPanel;
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
  if edtYear.Value < 2012 then //что-бы не лазили дальше 2012 года
  begin
    edtYear.Value := 2012;
    Exit;
  end;

  btnShow.Enabled := True;
  ListSpr.Visible := False;

  G_CURYEAR := edtYear.Value;
  G_CURMONTH := cmbMonth.ItemIndex;

  btnShow.Click;
end;

procedure TSprFrame.CheckCurPeriod;
var ev: TNotifyEvent;
begin
  if (G_CURYEAR <> edtYear.Value) or
     (G_CURMONTH <> cmbMonth.ItemIndex) then
  begin
    ev := edtYear.OnChange;
    try
      edtYear.OnChange := nil;
      cmbMonth.OnChange := nil;
      edtYear.Value := G_CURYEAR;
      cmbMonth.ItemIndex := G_CURMONTH;
      ev(nil);
    finally
      edtYear.OnChange := ev;
      cmbMonth.OnChange := ev;
    end;
  end;
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
      FillingDetailsPanel(Item.Data);
      StatusBar.Panels[0].Text := '   ' +
        (Item.Index + 1).ToString + '/' + ListSpr.Items.Count.ToString;
    end;
  end;
end;

procedure TSprFrame.ChangeDetailsPanel(AStyle: Byte);
begin
  SpeedButtonShowHide.Glyph.Assign(nil);
  if AStyle = 1 then
  begin
    SpeedButtonShowHide.Tag := 0;
    PanelDetails.Height := SpeedButtonShowHide.Height + 3;
    DM.ImageListArrowsTop.GetBitmap(0, SpeedButtonShowHide.Glyph);
    SpeedButtonShowHide.Hint := 'Развернуть панель';
    StatusBar.Top := Width;
    StatusBar.Align := alBottom;
  end
  else
  begin
    SpeedButtonShowHide.Tag := 1;
    DetailsPanelStyle;
    SpeedButtonShowHide.Hint := 'Свернуть панель';
    DM.ImageListArrowsBottom.GetBitmap(0, SpeedButtonShowHide.Glyph);
    StatusBar.Top := Width;
    StatusBar.Align := alBottom;
  end;
end;

procedure TSprFrame.SpeedButtonShowHideClick(Sender: TObject);
begin
  ChangeDetailsPanel(SpeedButtonShowHide.Tag);
end;

procedure TSprFrame.DetailsPanelStyle;
begin
  if FBaseType = 1 then
  begin
    lbDetCode.Visible := True;
    lbDetEdIzm.Visible := True;
    lbDetName.Visible := True;
    edtDetCode.Visible := True;
    edtDetEdIzm.Visible := True;
    memDetName.Visible := True;
    gbDetPrice.Visible := False;
    PanelDetails.Height := 96;
  end;

  if FBaseType = 2 then
  begin
    if (Self.Height - PanelSettings.Height -
        PanelFind.Height - StatusBar.Height) < 340  then
    begin
      lbDetCode.Visible := False;
      lbDetEdIzm.Visible := False;
      lbDetName.Visible := False;
      edtDetCode.Visible := False;
      edtDetEdIzm.Visible := False;
      memDetName.Visible := False;
      gbDetPrice.Top := 10;
      gbDetPrice.Visible := True;
      PanelDetails.Height := 110;
    end
    else
    begin
      lbDetCode.Visible := True;
      lbDetEdIzm.Visible := True;
      lbDetName.Visible := True;
      edtDetCode.Visible := True;
      edtDetEdIzm.Visible := True;
      memDetName.Visible := True;
      gbDetPrice.Top := 71;
      gbDetPrice.Visible := True;
      PanelDetails.Height := 180;
    end;
  end;
end;

procedure TSprFrame.ClearDetailsPanel;
begin
  edtDetCode.Text := '';
  edtDetEdIzm.Text := '';
  memDetName.Lines.Text := '';
  lvDetPrice.Items.Clear;
end;

procedure TSprFrame.FillingDetailsPanel(ASprRecord: PSprRecord);
begin
  ClearDetailsPanel;

  if Assigned(ASprRecord) then
  begin
    edtDetCode.Text := ASprRecord.Code;
    edtDetEdIzm.Text := ASprRecord.Unt;
    memDetName.Lines.Text := ASprRecord.Name;
  end;
end;

end.
