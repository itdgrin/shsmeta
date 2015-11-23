unit uSelectColumn;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.CheckLst,
  Generics.Collections,
  Generics.Defaults;

type
  TCheckColumnPair = TPair<Boolean, String>;
  TCheckColumnArray = TArray<TCheckColumnPair>;

  TfSelectColumn = class(TForm)
    clbList: TCheckListBox;
    Panel1: TPanel;
    ButtonOK: TButton;
    procedure ResizeForm;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure clbListClickCheck(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FDefaultDialog: Boolean;
    FColumns: TCheckColumnArray;
  public
    property Columns: TCheckColumnArray read FColumns write FColumns;
    property DefaultDialog: Boolean read FDefaultDialog write FDefaultDialog;
  end;

implementation

{$R *.dfm}

procedure TfSelectColumn.clbListClickCheck(Sender: TObject);
begin
  if clbList.ItemIndex > -1 then
    FColumns[clbList.ItemIndex].Key := clbList.Checked[clbList.ItemIndex];
end;

procedure TfSelectColumn.FormActivate(Sender: TObject);
var I, J:  integer;
begin
  clbList.Items.Clear;
  for I := Low(FColumns) to High(FColumns) do
  begin
    J := clbList.Items.AddObject(FColumns[I].Value, TObject(I));
    clbList.Checked[J] := FColumns[I].Key;
  end;
  if clbList.Items.Count > 0 then
  begin
    clbList.ItemIndex := 0;
    clbList.Selected[0] := True;
  end;
  clbList.SetFocus;

  ResizeForm;
end;

procedure TfSelectColumn.FormClose(Sender: TObject; var Action: TCloseAction);
var I: Integer;
    TmpFlag: Boolean;
begin
  TmpFlag := False;
  for I := Low(FColumns) to High(FColumns) do
    TmpFlag := TmpFlag or FColumns[I].Key;

  if (ModalResult = mrOk) and not TmpFlag then
    ModalResult := mrCancel;
end;

procedure TfSelectColumn.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  FDefaultDialog := (Shift = [ssCtrl]) and (Key = 68); //(Ctrl + D)
end;

procedure TfSelectColumn.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then //Esc
    ModalResult := mrCancel;
end;

procedure TfSelectColumn.FormResize(Sender: TObject);
var
  NewHeight: Integer;
begin
  NewHeight := clbList.ClientHeight div clbList.ItemHeight * clbList.ItemHeight;
  Height := Height - clbList.ClientHeight + NewHeight;
end;

procedure TfSelectColumn.ResizeForm;
var
  MinHeight: Integer;
begin
  // Restrict Listbox to min 6 items, max 30 items and to screen height
  MinHeight := clbList.ItemHeight * 6;
  Constraints.MinHeight := Height - clbList.ClientHeight + MinHeight;
  MinHeight := clbList.ItemHeight * clbList.Items.Count;
  if MinHeight >= clbList.ItemHeight * 30 then MinHeight := clbList.ItemHeight * 30;
  MinHeight := Height - clbList.ClientHeight + MinHeight;
  if (Top + MinHeight) > Screen.MonitorFromRect(BoundsRect).Height then
    Top := Screen.MonitorFromRect(BoundsRect).Height - MinHeight;
  Height := MinHeight;
end;

end.
