unit fOrganizations;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, DB, VirtualTrees, StdCtrls, ExtCtrls, Menus,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TFrameOrganizations = class(TFrame)
    VST: TVirtualStringTree;

    PopupMenu: TPopupMenu;

    PMAdd: TMenuItem;
    PMEdit: TMenuItem;
    PMDelete: TMenuItem;

    PanelListOrganizations: TPanel;
    PanelFullNameOrganization: TPanel;
    PanelTopFullNameOrganization: TPanel;

    LabelFullNameOrganization: TLabel;
    MemoFullNameOrganization: TMemo;
    ADOQueryTemp: TFDQuery;
    ADOQuery: TFDQuery;

    constructor Create(AOwner: TComponent);

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

uses DataModule, DrawingTables, CardOrganization;

const
  CaptionFrame = 'Фрейм «Организации»';

{$R *.dfm}

  // ---------------------------------------------------------------------------------------------------------------------

constructor TFrameOrganizations.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  VSTSetting(VST);
  TableFilling;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFrameOrganizations.TableFilling;
begin
  try
    with ADOQuery do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT * FROM clients ORDER BY name;');
      Active := True;
    end;

    VST.RootNodeCount := ADOQuery.RecordCount;
    VST.Selected[VST.GetFirst] := True;
    VST.FocusedNode := VST.GetFirst;
  except
    on E: Exception do
      MessageBox(0, PChar('При запросе к БД возникла ошибка:' + sLineBreak + sLineBreak + E.Message),
        CaptionFrame, MB_ICONERROR + MB_OK + mb_TaskModal);
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFrameOrganizations.VSTAfterCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas;
  Node: PVirtualNode; Column: TColumnIndex; CellRect: TRect);
var
  CellText: string;
begin
  if not ADOQuery.Active or (ADOQuery.RecordCount <= 0) then
    Exit;

  ADOQuery.RecNo := Node.Index + 1;

  case Column of
    1:
      CellText := ADOQuery.FieldByName('name').AsVariant;
    2:
      CellText := ADOQuery.FieldByName('bank').AsVariant;
    3:
      CellText := ADOQuery.FieldByName('code').AsVariant;
    4:
      CellText := ADOQuery.FieldByName('account').AsVariant;
    5:
      CellText := ADOQuery.FieldByName('unn').AsVariant;
    6:
      CellText := ADOQuery.FieldByName('okpo').AsVariant;
    7:
      CellText := ADOQuery.FieldByName('address').AsVariant;
    8:
      CellText := ADOQuery.FieldByName('ruk_prof').AsVariant;
    9:
      CellText := ADOQuery.FieldByName('ruk_fio').AsVariant;
    10:
      CellText := ADOQuery.FieldByName('phone').AsVariant;
    11:
      CellText := ADOQuery.FieldByName('contact_fio').AsVariant;
  end;

  VSTAfterCellPaintDefault(Sender, TargetCanvas, Node, Column, CellRect, CellText);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFrameOrganizations.VSTBeforeCellPaint(Sender: TBaseVirtualTree; TargetCanvas: TCanvas;
  Node: PVirtualNode; Column: TColumnIndex; CellPaintMode: TVTCellPaintMode; CellRect: TRect;
  var ContentRect: TRect);
begin
  VSTBeforeCellPaintDefault(Sender, TargetCanvas, Node, Column, CellPaintMode, CellRect, ContentRect);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFrameOrganizations.VSTFocusChanged(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex);
begin
  VSTFocusChangedDefault(Sender, Node, Column);

  if not ADOQuery.Active or (ADOQuery.RecordCount <= 0) or (ADOQuery.RecordCount <> VST.RootNodeCount) then
    Exit;

  ADOQuery.RecNo := Node.Index + 1;
  MemoFullNameOrganization.Text := ADOQuery.FieldByName('full_name').AsVariant;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFrameOrganizations.VSTGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType; var CellText: string);
begin
  if not ADOQuery.Active then
    Exit;

  if (ADOQuery.RecordCount <= 0) then
  begin
    case Column of
      0:
        CellText := '';
      1:
        CellText := 'Записей не найдено!';
      2:
        CellText := '';
      3:
        CellText := '';
      4:
        CellText := '';
      5:
        CellText := '';
      6:
        CellText := '';
      7:
        CellText := '';
      8:
        CellText := '';
      9:
        CellText := '';
      10:
        CellText := '';
      11:
        CellText := '';
      12:
        CellText := '';
    end;

    Exit;
  end;

  if Column > 0 then
    ADOQuery.RecNo := Node.Index + 1;

  case Column of
    0:
      CellText := IntToStr(Node.Index + 1);
    1:
      CellText := ADOQuery.FieldByName('name').AsVariant;
    2:
      CellText := ADOQuery.FieldByName('bank').AsVariant;
    3:
      CellText := ADOQuery.FieldByName('code').AsVariant;
    4:
      CellText := ADOQuery.FieldByName('account').AsVariant;
    5:
      CellText := ADOQuery.FieldByName('unn').AsVariant;
    6:
      CellText := ADOQuery.FieldByName('okpo').AsVariant;
    7:
      CellText := ADOQuery.FieldByName('address').AsVariant;
    8:
      CellText := ADOQuery.FieldByName('ruk_prof').AsVariant;
    9:
      CellText := ADOQuery.FieldByName('ruk_fio').AsVariant;
    10:
      CellText := ADOQuery.FieldByName('phone').AsVariant;
    11:
      CellText := ADOQuery.FieldByName('contact_fio').AsVariant;
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFrameOrganizations.VSTResize(Sender: TObject);
begin
  AutoWidthColumn(VST, 2);
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFrameOrganizations.PMAddClick(Sender: TObject);
begin
  FormCardOrganization.ShowForm(-1);
  TableFilling;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFrameOrganizations.PMEditClick(Sender: TObject);
begin
  FormCardOrganization.ShowForm(ADOQuery.FieldByName('client_id').AsInteger);
  TableFilling;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFrameOrganizations.PMDeleteClick(Sender: TObject);
begin
  if not ADOQuery.Active or (ADOQuery.RecordCount <= 0) then
  begin
    MessageBox(0, PChar('В таблице нет записей для удаления!'), CaptionFrame,
      MB_ICONINFORMATION + MB_OK + mb_TaskModal);
    Exit;
  end;

  if MessageBox(0, PChar('Удалить выделенную строку?'), CaptionFrame, MB_ICONINFORMATION + MB_YESNO +
    mb_TaskModal) = mrYes then
    try
      ADOQuery.RecNo := VST.FocusedNode.Index + 1;

      with ADOQueryTemp do
      begin
        Active := False;
        SQL.Clear;
        SQL.Add('DELETE FROM clients WHERE client_id = :client_id;');
        ParamByName('client_id').Value := ADOQuery.FieldByName('client_id').AsInteger;
        ExecSQL;
        Active := False;
      end;

      TableFilling;
    except
      on E: Exception do
        MessageBox(0, PChar('При удалении записи из БД возникла ошибка:' + sLineBreak + sLineBreak +
          E.Message), CaptionFrame, MB_ICONERROR + MB_OK + mb_TaskModal);
    end;
end;

// ---------------------------------------------------------------------------------------------------------------------

end.
