unit fCategoriesObjects;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, DB, VirtualTrees, Menus, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFrameCategoriesObjects = class(TFrame)
    VST: TVirtualStringTree;
    PopupMenu: TPopupMenu;
    PMAdd: TMenuItem;
    PMEdit: TMenuItem;
    PMDelete: TMenuItem;
    ADOQueryTemp: TFDQuery;
    ADOQuery: TFDQuery;

    constructor Create(AOwner: TComponent); Override;

    procedure TableFilling;

    procedure VSTAfterCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; CellRect: TRect);
    procedure VSTBeforeCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
    procedure VSTFocusChanged(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex);
    procedure VSTGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
      TextType: TVSTTextType; var CellText: string);
    procedure VSTResize(Sender: TObject);
    procedure PMAddClick(Sender: TObject);
    procedure PMEditClick(Sender: TObject);
    procedure PMDeleteClick(Sender: TObject);
  end;

implementation

uses Main, DataModule, DrawingTables, CardCategoriesObjects;

const
  CaptionFrame = FormNameCategoriesObjects;

{$R *.dfm}

  // ---------------------------------------------------------------------------------------------------------------------

constructor TFrameCategoriesObjects.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  VSTSetting(VST);
  // TableFilling;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFrameCategoriesObjects.TableFilling;
begin
  try
    // if ADOQuery.Active then
    // Exit;

    with ADOQuery do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT * FROM objcategory ORDER BY cat_name;');
      Active := True;
    end;

    VST.RootNodeCount := ADOQuery.RecordCount;
    VST.Selected[VST.GetFirst] := True;
    VST.FocusedNode := VST.GetFirst;
  except
    on E: Exception do
      MessageBox(0, PChar('��� ������� � �� �������� ������:' + sLineBreak + sLineBreak + E.Message),
        CaptionFrame, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFrameCategoriesObjects.VSTAfterCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas;
  Node: PVirtualNode; Column: TColumnIndex; CellRect: TRect);
var
  CellText: string;
begin
  if not ADOQuery.Active or (ADOQuery.RecordCount <= 0) then
    Exit;

  ADOQuery.RecNo := Node.Index + 1;

  case Column of
    1:
      CellText := ADOQuery.FieldByName('cat_name').AsVariant;
  end;

  VSTAfterCellPaintDefault(Sender, TargetCanvas, Node, Column, CellRect, CellText);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFrameCategoriesObjects.VSTBeforeCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas;
  Node: PVirtualNode; Column: TColumnIndex; CellPaintMode: TVTCellPaintMode; CellRect: TRect;
  var ContentRect: TRect);
begin
  VSTBeforeCellPaintDefault(Sender, TargetCanvas, Node, Column, CellPaintMode, CellRect, ContentRect);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFrameCategoriesObjects.VSTFocusChanged(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex);
begin
  VSTFocusChangedDefault(Sender, Node, Column);

  if not ADOQuery.Active or (ADOQuery.RecordCount <= 0) or (VST.RootNodeCount <> Cardinal(ADOQuery.RecordCount)) then
    Exit;

  ADOQuery.RecNo := Node.Index + 1;

  PMEdit.Enabled := True;
  PMDelete.Enabled := True;

  if ADOQuery.FieldByName('constant').AsInteger = 1 then
  begin
    PMEdit.Enabled := False;
    PMDelete.Enabled := False;
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFrameCategoriesObjects.VSTGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
begin
  if not ADOQuery.Active then
    Exit;

  if (ADOQuery.RecordCount <= 0) then
  begin
    VST.RootNodeCount := 1;

    case Column of
      0:
        CellText := '';
      1:
        CellText := '������� �� �������!';
    end;

    Exit;
  end;

  if Column > 0 then
    ADOQuery.RecNo := Node.Index + 1;

  case Column of
    0:
      CellText := IntToStr(Node.Index + 1);
    1:
      CellText := ADOQuery.FieldByName('cat_name').AsVariant;
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFrameCategoriesObjects.VSTResize(Sender: TObject);
begin
  AutoWidthColumn(VST, 1);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFrameCategoriesObjects.PMAddClick(Sender: TObject);
begin
  FormCardCategoriesObjects.ShowForm(-1, ADOQueryTemp);
  TableFilling;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFrameCategoriesObjects.PMEditClick(Sender: TObject);
begin
  FormCardCategoriesObjects.ShowForm(ADOQuery.FieldByName('cat_id').AsInteger, ADOQueryTemp);
  TableFilling;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFrameCategoriesObjects.PMDeleteClick(Sender: TObject);
begin
  if not ADOQuery.Active or (ADOQuery.RecordCount <= 0) then
  begin
    MessageBox(0, PChar('� ������� ��� ������� ��� ��������!'), CaptionFrame,
      MB_ICONINFORMATION + MB_OK + mb_TaskModal);
    Exit;
  end;

  if MessageBox(0, PChar('������� ���������� ������?'), CaptionFrame, MB_ICONINFORMATION + MB_YESNO +
    mb_TaskModal) = mrYes then
    try
      ADOQuery.RecNo := VST.FocusedNode.Index + 1;

      with ADOQueryTemp do
      begin
        Active := False;
        SQL.Clear;
        SQL.Add('DELETE FROM objcategory WHERE cat_id = :cat_id;');
        ParamByName('cat_id').Value := ADOQuery.FieldByName('cat_id').AsInteger;
        ExecSQL;
        Active := False;
      end;

      TableFilling;
    except
      on E: Exception do
        MessageBox(0, PChar('��� �������� ������ �� �� �������� ������:' + sLineBreak + sLineBreak +
          E.Message), CaptionFrame, MB_ICONERROR + MB_OK + mb_TaskModal);
    end;
end;

// ---------------------------------------------------------------------------------------------------------------------

end.
