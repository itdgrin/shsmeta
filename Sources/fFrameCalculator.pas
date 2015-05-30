unit fFrameCalculator;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  JvExStdCtrls, JvEdit, JvExDBGrids, JvDBGrid, Vcl.ExtCtrls, Clipbrd;

type
  TCalculator = class(TFrame)
    Panel: TPanel;
    edtCoast: TJvEdit;
    edtCount: TJvEdit;
    edtNDS: TJvEdit;
    lbCoast: TLabel;
    lbNDS: TLabel;
    lbCount: TLabel;
    edtPriceNDS: TJvEdit;
    lbPriceNDS: TLabel;
    ButtonPanel: TPanel;
    btnSetResult: TButton;
    btnHide: TButton;
    procedure FrameExit(Sender: TObject);
    procedure btnHideClick(Sender: TObject);
    procedure edtCountKeyPress(Sender: TObject; var Key: Char);
    procedure btnSetResultClick(Sender: TObject);
    procedure edtPriceNDSChange(Sender: TObject);
    procedure edtCountChange(Sender: TObject);
    procedure edtCoastChange(Sender: TObject);
  private
    FGrd: TJvDBGrid;
    FFieldName: string;
    FCalc: Boolean;
    FCoast,
    FCount,
    FNDS,
    FPrice: Extended;
    { Private declarations }
  public
    procedure ShowCalculator(AGrd: TJvDBGrid; ACoast, ACount, ANDS,
      APrice: Extended; AFieldName: string);
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TCalculator.ShowCalculator(AGrd: TJvDBGrid; ACoast, ACount, ANDS,
      APrice: Extended; AFieldName: string);
var p: TPoint;
begin
  if not Assigned(AGrd) then
    Exit;
  FGrd := AGrd;
  FFieldName := AFieldName;

  FCalc := True;
  if ACount > 0 then
    edtCount.Text := FloatToStr(ACount)
  else edtCount.Text :=  '0';

  if ANDS > 0 then
    edtNDS.Text := IntToStr(Trunc(ANDS))
  else edtNDS.Text :=  '0';

  if ACoast > 0 then
    edtCoast.Text := IntToStr(Trunc(ACoast))
  else edtCoast.Text :=  '0';

  if APrice > 0 then
    edtPriceNDS.Text := IntToStr(Trunc(APrice))
  else edtPriceNDS.Text :=  '0';

  FCoast := StrToInt(edtCoast.Text);
  FCount := StrToFloat(edtCount.Text);
  FNDS := StrToInt(edtNDS.Text);
  FPrice := StrToInt(edtPriceNDS.Text);

  FCalc := False;

  p := AGrd.ClientToParent(AGrd.CellRect(AGrd.Col, AGrd.Row).BottomRight,
    Self.Parent);

  Top := p.Y + 1;
  Left := p.X - Width + 2;

  Visible := True;
  btnHide.SetFocus;
end;

procedure TCalculator.btnHideClick(Sender: TObject);
begin
  FrameExit(Sender);
end;

procedure TCalculator.btnSetResultClick(Sender: TObject);
begin
  FGrd.DataSource.DataSet.Edit;
  FGrd.DataSource.DataSet.FieldByName(FFieldName).Value := FCoast;
  FrameExit(Sender);
end;

procedure TCalculator.edtCountKeyPress(Sender: TObject; var Key: Char);
var f: Extended;
    s: string;
begin
  if CharInSet(Key, [^C, ^X, ^Z]) then
      Exit;

  if (Key = ^V) then
  begin
    //Проверка на корректность вставляемого текста
    if TryStrToFloat(Clipboard.AsText, f) then
    begin
      s :=
        Copy(edtCount.Text, 1, edtCount.SelStart) +
        Clipboard.AsText +
        Copy(edtCount.Text, edtCount.SelStart + edtCount.SelLength + 1,
          Length(edtCount.Text) - edtCount.SelStart - edtCount.SelLength);
      if TryStrToFloat(s, f) then
        Exit;
    end;
  end;

  case Key of
    '0'..'9',#8: ;
    '.',',':
     begin
       Key := FormatSettings.DecimalSeparator;
       if (pos(FormatSettings.DecimalSeparator, edtCount.Text) <> 0) or
          (edtCount.Text = '') then
        Key:= #0;
     end;
     else Key:= #0;
  end;
end;

procedure TCalculator.edtCoastChange(Sender: TObject);
begin
  if not FCalc then
  begin
    FCalc := True;
    FCoast := StrToIntDef(edtCoast.Text, 0);
    FPrice := Round(FCount * FCoast);
    edtPriceNDS.Text := IntToStr(Round(FPrice));
    FCalc := False;
  end;
end;

procedure TCalculator.edtCountChange(Sender: TObject);
begin
  if not FCalc then
  begin
    FCalc := True;
    FCount := StrToFloatDef(edtCount.Text, 0);
    if FCount > 0 then
      FCoast := Round(FPrice/FCount)
    else FCoast := 0;
    edtCoast.Text := IntToStr(Round(FCoast));
    FCalc := False;
  end;
end;

procedure TCalculator.edtPriceNDSChange(Sender: TObject);
begin
  if not FCalc then
  begin
    FCalc := True;
    FPrice := StrToIntDef(edtPriceNDS.Text, 0);
    if FCount > 0 then
      FCoast := Round(FPrice/FCount)
    else FCoast := 0;
    edtCoast.Text := IntToStr(Round(FCoast));
    FCalc := False;
  end;
end;

procedure TCalculator.FrameExit(Sender: TObject);
begin
  if Assigned(FGrd) then
    if FGrd.CanFocus then
      FGrd.SetFocus;
  FGrd := nil;
  Visible := False;
end;

end.
