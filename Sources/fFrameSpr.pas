unit fFrameSpr;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.Samples.Spin, Vcl.ExtCtrls, GlobsAndConst, Vcl.ComCtrls, Vcl.Buttons;

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
    StatusBar: TStatusBar;
    Memo: TMemo;
    SpeedButtonShowHide: TSpeedButton;
    ListSpr: TListView;
    procedure SpeedButtonShowHideClick(Sender: TObject);
  private
    procedure LoadSpr;
  protected
    { Private declarations }
    FPriceColumn: Boolean;
    function GetSprSQL: string; virtual; abstract;
    procedure OnLoadStart; virtual;
    procedure OnLoadDone; virtual;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; const APriceColumn: Boolean;
      const AStarYear, AStarMonth: Integer); reintroduce;
  end;

implementation

{$R *.dfm}

uses DataModule, Tools;

{ TSprFrame }

constructor TSprFrame.Create(AOwner: TComponent; const APriceColumn: Boolean;
      const AStarYear, AStarMonth: Integer);
var i: Integer;
begin
  inherited Create(AOwner);

  cmbMonth.Items.Clear;
  for i := Low(arraymes) to High(arraymes) do
    cmbMonth.Items.Add(arraymes[i][1]);

  FPriceColumn := APriceColumn;

  edtYear.Value := AStarYear;
  cmbMonth.ItemIndex := AStarMonth - 1;

  SpeedButtonShowHide.Hint := 'Свернуть панель';
  DM.ImageListArrowsBottom.GetBitmap(0, SpeedButtonShowHide.Glyph);
  LoadSpr;
end;

procedure TSprFrame.LoadSpr;
var TmpStr: string;
begin
  TmpStr := GetSprSQL;
  //Вызов нити выполняющей запрос на данные справлчника
  TThreadQuery.Create(TmpStr, Handle);
  OnLoadStart;
end;

procedure TSprFrame.OnLoadStart;
begin
  btnShow.Enabled := False;
  edtYear.Enabled := False;
  cmbMonth.Enabled := False;
  edtFind.Enabled := False;
  btnFind.Enabled := False;
end;

procedure TSprFrame.OnLoadDone;
begin
  btnShow.Enabled := True;
  edtYear.Enabled := True;
  cmbMonth.Enabled := True;
  edtFind.Enabled := True;
  btnFind.Enabled := True;
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
      Memo.Visible := True;
      Hint := 'Свернуть панель';
      DM.ImageListArrowsBottom.GetBitmap(0, Glyph);
    end;
  end;
end;

end.
