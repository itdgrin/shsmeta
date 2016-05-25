
{******************************************}
{                                          }
{             FastReport v5.0              }
{            Watches toolwindow            }
{                                          }
{         Copyright (c) 1998-2014          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit frxWatchForm;

interface

{$I frx.inc}

uses
  {$IFNDEF FPC}
  Windows, Messages,
  {$ENDIF}
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, fs_iinterpreter, CheckLst
  {$IFDEF FPC}
  ,LCLType
  {$ELSE}
  , StdCtrls, ToolWin
  {$ENDIF}
{$IFDEF Delphi6}
, Variants
{$ENDIF};

type
  TfrxWatchForm = class(TForm)
    ToolBar1: TToolBar;
    AddB: TToolButton;
    DeleteB: TToolButton;
    EditB: TToolButton;
    WatchLB: TCheckListBox;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure AddBClick(Sender: TObject);
    procedure DeleteBClick(Sender: TObject);
    procedure EditBClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure WatchLBClickCheck(Sender: TObject);
  private
    FScript: TfsScript;
    FScriptRunning: Boolean;
    FWatches: TStrings;
    function CalcWatch(const s: String): String;
  public
    procedure UpdateWatches;
    property Script: TfsScript read FScript write FScript;
    property ScriptRunning: Boolean read FScriptRunning write FScriptRunning;
    property Watches: TStrings read FWatches;
  end;


implementation
{$IFDEF FPC}
{$R *.lfm}
{$ELSE}
{$R *.DFM}
{$ENDIF}

uses frxRes, frxEvaluateForm;
{$IFNDEF FPC}
type
  THackWinControl = class(TWinControl);
{$ENDIF}


procedure TfrxWatchForm.FormCreate(Sender: TObject);
begin
  Caption := frxGet(5900);
  AddB.Hint := frxGet(5901);
  DeleteB.Hint := frxGet(5902);
  EditB.Hint := frxGet(5903);
  FWatches := TStringList.Create;
{$IFDEF UseTabset}
  WatchLB.BevelKind := bkFlat;
{$ELSE}
  WatchLB.BorderStyle := bsSingle;
{$ENDIF}

  if UseRightToLeftAlignment then
    FlipChildren(True);
end;

procedure TfrxWatchForm.FormDestroy(Sender: TObject);
begin
  FWatches.Free;
end;

procedure TfrxWatchForm.FormShow(Sender: TObject);
begin
  Toolbar1.Images := frxResources.MainButtonImages;
end;

procedure TfrxWatchForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
    frxResources.Help(Self);
end;

procedure TfrxWatchForm.AddBClick(Sender: TObject);
begin
  with TfrxEvaluateForm.Create(Owner) do
  begin
    IsWatch := True;
    if ShowModal = mrOk then
    begin
      //Watches.Add(ExpressionE.Text);
      Watches.AddObject(ExpressionE.Text, TObject(1));
      UpdateWatches;
    end;
    Free;
  end;
end;

procedure TfrxWatchForm.DeleteBClick(Sender: TObject);
begin
  if WatchLB.ItemIndex <> -1 then
  begin
    Watches.Delete(WatchLB.ItemIndex);
    UpdateWatches;
  end;
end;

procedure TfrxWatchForm.EditBClick(Sender: TObject);
begin
  if WatchLB.ItemIndex <> -1 then
    with TfrxEvaluateForm.Create(Owner) do
    begin
      IsWatch := True;
      ExpressionE.Text := Watches[WatchLB.ItemIndex];
      if ShowModal = mrOk then
      begin
        Watches[WatchLB.ItemIndex] := ExpressionE.Text;
        UpdateWatches;
      end;
      Free;
    end;
end;

function TfrxWatchForm.CalcWatch(const s: String): String;
var
  v: Variant;
begin
  if (FScript <> nil) and (FScriptRunning) then
  begin
    v := FScript.Evaluate(s);
    Result := VarToStr(v);
    if TVarData(v).VType = varBoolean then
      if Boolean(v) = True then
        Result := 'True' else
        Result := 'False'
    else if (TVarData(v).VType = varString) or (TVarData(v).VType = varOleStr)
    {$IFDEF Delphi12}or (TVarData(v).VType = varUString){$ENDIF} then
      Result := '''' + v + ''''
    else if v = Null then
      Result := 'Null';
  end
  else
    Result := 'not accessible';
end;

procedure TfrxWatchForm.UpdateWatches;
var
  i: Integer;
begin
  WatchLB.Items.BeginUpdate;
  WatchLB.Items.Clear;
  for i := 0 to Watches.Count - 1 do
  begin
    if Watches.Objects[i] = TObject(1) then
      WatchLB.Items.Add(Watches[i] + ': ' + CalcWatch(Watches[i]))
    else
      WatchLB.Items.Add(Watches[i] + ': disabled');
{$IFDEF FPC}
    WatchLB.Checked[i] := Boolean(PtrInt(Watches.Objects[i]));
{$ELSE}
    WatchLB.Checked[i] := Boolean(Watches.Objects[i]);
{$ENDIF}
  end;
  WatchLB.Items.EndUpdate;
end;

procedure TfrxWatchForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := False;
end;

procedure TfrxWatchForm.WatchLBClickCheck(Sender: TObject);
var
  Bool: Boolean;
begin
  if (WatchLB.ItemIndex <> -1) then
  begin
{$IFDEF FPC}
    Bool := Boolean(PtrInt(Watches.Objects[WatchLB.ItemIndex]));
    Watches.Objects[WatchLB.ItemIndex] := TObject(PtrInt(not Bool));
{$ELSE}
    Bool := Boolean(Watches.Objects[WatchLB.ItemIndex]);
    Watches.Objects[WatchLB.ItemIndex] := TObject(not Bool);
{$ENDIF}
    UpdateWatches;
  end;
end;

end.


