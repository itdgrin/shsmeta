unit fPartsEstimates;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, DB, VirtualTrees, Menus, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFramePartsEstimates = class(TFrame)
    VST: TVirtualStringTree;
    PopupMenu: TPopupMenu;
    PMAdd: TMenuItem;
    PMEdit: TMenuItem;
    PMDelete: TMenuItem;
    ADOQueryTemp: TFDQuery;
    ADOQuery: TFDQuery;

    constructor Create(AOwner: TComponent);

    procedure TableFilling;

    procedure VSTAfterCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; CellRect: TRect);
    procedure VSTBeforeCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
    procedure VSTFocusChanged(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex);
    procedure VSTGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: string);
    procedure VSTResize(Sender: TObject);
    procedure PMAddClick(Sender: TObject);
    procedure PMEditClick(Sender: TObject);
    procedure PMDeleteClick(Sender: TObject);
  end;

implementation

uses DataModule, DrawingTables, CardPartsEstimates;

const
  CaptionFrame = '����� ������ ����';

{$R *.dfm}

  // ---------------------------------------------------------------------------------------------------------------------

constructor TFramePartsEstimates.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  VSTSetting(VST);
  TableFilling;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePartsEstimates.TableFilling;
begin
  try
    // if ADOQuery.Active then
    // Exit;

    with ADOQuery do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT * FROM parts_estimates ORDER BY code;');
      Active := True;
    end;

    VST.RootNodeCount := ADOQuery.RecordCount;
    VST.Selected[VST.GetFirst] := True;
    VST.FocusedNode := VST.GetFirst;
  except
    on E: Exception do
      MessageBox(0, PChar('��� ������� � �� �������� ������:' + sLineBreak + sLineBreak + E.Message), CaptionFrame,
        MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePartsEstimates.VSTAfterCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode;
  Column: TColumnIndex; CellRect: TRect);
var
  CellText: string;
begin
  if not ADOQuery.Active or (ADOQuery.RecordCount <= 0) then
    Exit;

  ADOQuery.RecNo := Node.Index + 1;

  case Column of
    1:
      CellText := ADOQuery.FieldByName('code').AsVariant;
    2:
      CellText := ADOQuery.FieldByName('name').AsVariant;
  end;

  VSTAfterCellPaintDefault(Sender, TargetCanvas, Node, Column, CellRect, CellText);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePartsEstimates.VSTBeforeCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode;
  Column: TColumnIndex; CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
begin
  VSTBeforeCellPaintDefault(Sender, TargetCanvas, Node, Column, CellPaintMode, CellRect, ContentRect);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePartsEstimates.VSTFocusChanged(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex);
begin
  VSTFocusChangedDefault(Sender, Node, Column);

  if not ADOQuery.Active or (ADOQuery.RecordCount <= 0) or (VST.RootNodeCount <> ADOQuery.RecordCount) then
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

procedure TFramePartsEstimates.VSTGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType; var CellText: string);
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
        CellText := '';
      2:
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
      CellText := ADOQuery.FieldByName('code').AsVariant;
    2:
      CellText := ADOQuery.FieldByName('name').AsVariant;
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePartsEstimates.VSTResize(Sender: TObject);
begin
  AutoWidthColumn(VST, 2);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePartsEstimates.PMAddClick(Sender: TObject);
begin
  FormCardPartsEstimates.ShowForm(-1, ADOQueryTemp);
  TableFilling;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePartsEstimates.PMEditClick(Sender: TObject);
begin
  FormCardPartsEstimates.ShowForm(ADOQuery.FieldByName('id').AsInteger, ADOQueryTemp);
  TableFilling;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFramePartsEstimates.PMDeleteClick(Sender: TObject);
begin
  if not ADOQuery.Active or (ADOQuery.RecordCount <= 0) then
  begin
    MessageBox(0, PChar('� ������� ��� ������� ��� ��������!'), CaptionFrame,
      MB_ICONINFORMATION + MB_OK + mb_TaskModal);
    Exit;
  end;

  if MessageBox(0, PChar('������� ���������� ������?'), CaptionFrame, MB_ICONINFORMATION + MB_YESNO + mb_TaskModal)
    = mrYes then
    try
      ADOQuery.RecNo := VST.FocusedNode.Index + 1;

      with ADOQueryTemp do
      begin
        Active := False;
        SQL.Clear;
        SQL.Add('DELETE FROM parts_estimates WHERE id = :id;');
        ParamByName('id').Value := ADOQuery.FieldByName('id').AsInteger;
        ExecSQL;
        Active := False;
      end;

      TableFilling;
    except
      on E: Exception do
        MessageBox(0, PChar('��� �������� ������ �� �� �������� ������:' + sLineBreak + sLineBreak + E.Message),
          CaptionFrame, MB_ICONERROR + MB_OK + mb_TaskModal);
    end;
end;

// ---------------------------------------------------------------------------------------------------------------------

end.
