unit fCoefficientsRates;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, DB, VirtualTrees, StdCtrls, ExtCtrls, Menus,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TFrameCoefficientsRates = class(TFrame)

    VST: TVirtualStringTree;

    PanelRight: TPanel;

    LabelSalary: TLabel;
    LabelExploitationCars: TLabel;
    LabelMaterialResources: TLabel;
    LabelWorkBuilders: TLabel;
    LabelWorkMachinist: TLabel;

    EditSalary: TEdit;
    EditExploitationCars: TEdit;
    EditMaterialResources: TEdit;
    EditWorkBuilders: TEdit;
    EditWorkMachinist: TEdit;
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
    procedure VSTGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: string);
    procedure VSTResize(Sender: TObject);
    procedure PMAddClick(Sender: TObject);
    procedure PMEditClick(Sender: TObject);
    procedure PMDeleteClick(Sender: TObject);
  end;

implementation

uses DataModule, DrawingTables, CardCoefficients;

const
  CaptionFrame = 'Фрейм «Коэффициенты»';

{$R *.dfm}

  // ---------------------------------------------------------------------------------------------------------------------

constructor TFrameCoefficientsRates.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  VSTSetting(VST);
  TableFilling;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFrameCoefficientsRates.TableFilling;
begin
  try
    with ADOQuery do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT * FROM coef ORDER BY coef_name;');
      Active := True;
    end;

    VST.RootNodeCount := ADOQuery.RecordCount;
    VST.Selected[VST.GetFirst] := True;
    VST.FocusedNode := VST.GetFirst;
  except
    on E: Exception do
      MessageBox(0, PChar('При запросе к БД возникла ошибка:' + sLineBreak + sLineBreak + E.Message), CaptionFrame,
        MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFrameCoefficientsRates.VSTAfterCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode;
  Column: TColumnIndex; CellRect: TRect);
var
  CellText: string;
begin
  if not ADOQuery.Active or (ADOQuery.RecordCount <= 0) then
    Exit;

  ADOQuery.RecNo := Node.Index + 1;

  case Column of
    1:
      CellText := ADOQuery.FieldByName('coef_name').AsVariant;
  end;

  VSTAfterCellPaintDefault(Sender, TargetCanvas, Node, Column, CellRect, CellText);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFrameCoefficientsRates.VSTBeforeCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas;
  Node: PVirtualNode; Column: TColumnIndex; CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
begin
  VSTBeforeCellPaintDefault(Sender, TargetCanvas, Node, Column, CellPaintMode, CellRect, ContentRect);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFrameCoefficientsRates.VSTFocusChanged(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex);
begin
  VSTFocusChangedDefault(Sender, Node, Column);

  if not ADOQuery.Active or (ADOQuery.RecordCount <= 0) or (VST.RootNodeCount <> Cardinal(ADOQuery.RecordCount)) then
    Exit;

  ADOQuery.RecNo := Node.Index + 1;

  with ADOQuery do
  begin
    PMEdit.Enabled := True;
    PMDelete.Enabled := True;

    if FieldByName('constant').AsInteger = 1 then
    begin
      PMEdit.Enabled := False;
      PMDelete.Enabled := False;
    end;

    // ----------------------------------------

    EditSalary.Text := FieldByName('osn_zp').AsVariant;
    EditExploitationCars.Text := FieldByName('eksp_mach').AsVariant;
    EditMaterialResources.Text := FieldByName('mat_res').AsVariant;
    EditWorkBuilders.Text := FieldByName('work_pers').AsVariant;
    EditWorkMachinist.Text := FieldByName('work_mach').AsVariant;
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFrameCoefficientsRates.VSTGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
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
        CellText := 'Записей не найдено!';
    end;

    Exit;
  end;

  if Column > 0 then
    ADOQuery.RecNo := Node.Index + 1;

  case Column of
    0:
      CellText := IntToStr(Node.Index + 1);
    1:
      CellText := ADOQuery.FieldByName('coef_name').AsVariant;
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFrameCoefficientsRates.VSTResize(Sender: TObject);
begin
  AutoWidthColumn(VST, 1);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFrameCoefficientsRates.PMAddClick(Sender: TObject);
begin
  FormCardCoefficients.ShowForm(-1, ADOQueryTemp);
  TableFilling;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFrameCoefficientsRates.PMEditClick(Sender: TObject);
begin
  FormCardCoefficients.ShowForm(ADOQuery.FieldByName('coef_id').AsInteger, ADOQueryTemp);
  TableFilling;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFrameCoefficientsRates.PMDeleteClick(Sender: TObject);
begin
  if not ADOQuery.Active or (ADOQuery.RecordCount <= 0) then
  begin
    MessageBox(0, PChar('В таблице нет записей для удаления!'), CaptionFrame,
      MB_ICONINFORMATION + MB_OK + mb_TaskModal);
    Exit;
  end;

  if MessageBox(0, PChar('Удалить выделенную строку?'), CaptionFrame, MB_ICONINFORMATION + MB_YESNO + mb_TaskModal)
    = mrYes then
    try
      ADOQuery.RecNo := VST.FocusedNode.Index + 1;

      with ADOQueryTemp do
      begin
        Active := False;
        SQL.Clear;
        SQL.Add('DELETE FROM coef WHERE coef_id = :coef_id;');
        ParamByName('coef_id').Value := ADOQuery.FieldByName('coef_id').AsInteger;
        ExecSQL;
        Active := False;
      end;

      TableFilling;
    except
      on E: Exception do
        MessageBox(0, PChar('При удалении записи из БД возникла ошибка:' + sLineBreak + sLineBreak + E.Message),
          CaptionFrame, MB_ICONERROR + MB_OK + mb_TaskModal);
    end;
end;

// ---------------------------------------------------------------------------------------------------------------------

end.
