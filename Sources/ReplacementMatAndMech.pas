{///////////////////////////////////////////////////}
{  ������������� ����� ����������� ������           }
{  ���������� � ���������� � ��������, ����������   }
{  ���������� � ���������� � ��������               }
{                                                   }
{///////////////////////////////////////////////////}

unit ReplacementMatAndMech;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, System.RTLConsts, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.Grids, Vcl.DBGrids, JvExDBGrids, JvDBGrid, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Clipbrd, JvExControls,
  JvAnimatedImage, JvGIFCtrl, FireDAC.Phys.MySQL, Vcl.ValEdit, Vcl.Buttons,
  Vcl.Menus,
  fFrameMaterial,
  fFrameMechanizm,
  fFrameSpr,
  fFrameEquipment,
  GlobsAndConst,
  Generics.Collections,
  Generics.Defaults;

type
  TEntryRecord = record
    Select: Boolean;
    EID,                   //ID �����
    MID: Integer;          //ID ��������� ��� ���������
    EName,                 //�������� �����
    RCode,                 //��� ��������
    MCode,                 //��� ��������� ��� ���������
    MUnt: string;          //������� ���������
    MNorma,                //����� � ��������
    MCount: Extended;      //���-��
    MIdCardRate,           //ID �������� � ������� ������, ��� ������
    MIdReplaced: Integer;  //ID �������� �������� ������
    MCons,                 //������� ��������(1)\����������(0)
    MRep,                  //�������, ��� �������
    MFromRate,             //������� �� ��������
    MConsRep,              //�������, ��� �������� �������(1)\���������(0)
    MAdded: Byte;          //����������� � ��������
    MSort: Integer;        //���� ��� ����������
    DataID,                //�������� � date_estimate ID � ���
    DataType: Integer;
  end;

  TEntryArray =  TArray<TEntryRecord>;

  TMyGrid = class(TCustomGrid)
  public
    property InplaceEditor;
  end;

  TRecalcRec = record
    IDEstim,
    DataID,
    DataType: Integer;
  end;

  TfrmReplacement = class(TForm)
    Panel1: TPanel;
    groupReplace: TGroupBox;
    Label2: TLabel;
    edtSourceCode: TEdit;
    Label3: TLabel;
    groupEntry: TGroupBox;
    groupCatalog: TGroupBox;
    Panel4: TPanel;
    btnReplace: TButton;
    btnCancel: TButton;
    qrRep: TFDQuery;
    qrTemp: TFDQuery;
    Panel5: TPanel;
    edtSourceName: TMemo;
    ListEntry: TListView;
    rgroupType: TRadioGroup;
    groupRep: TGroupBox;
    Panel2: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    grdRep: TStringGrid;
    PMEntry: TPopupMenu;
    N1: TMenuItem;
    pmSelectAll: TMenuItem;
    pmDeselectAll: TMenuItem;
    pmCurRate: TMenuItem;
    pmSelectRate: TMenuItem;
    pmDeselectRate: TMenuItem;
    pmShowRep: TMenuItem;
    btnDelReplacement: TButton;
    procedure btnCancelClick(Sender: TObject);
    procedure rgroupTypeClick(Sender: TObject);
    procedure btnSelectClick(Sender: TObject);
    procedure ListEntryCustomDrawItem(Sender: TCustomListView; Item: TListItem;
      State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure ListEntryChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure grdRepSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure grdRepKeyPress(Sender: TObject; var Key: Char);
    procedure grdRepSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: string);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure grdRepMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PMEntryPopup(Sender: TObject);
    procedure pmSelectAllClick(Sender: TObject);
    procedure pmSelectRateClick(Sender: TObject);
    procedure pmShowRepClick(Sender: TObject);
    procedure btnReplaceClick(Sender: TObject);

  private
    FCurType: Byte;
    FTemp, //����� ������ � ���������� ��������� (�� ����������� �� �����������)
    FAddMode: Boolean; //False - ����� ������ True - ����� �������

    FObjectID,
    FEstimateID,
    FRateID,
    FMatMechID: Integer;
    FMatMechCode: string;

    FObjectName,
    FEstimateName,
    FRateCode: String;
    //����� ����� ��� �������������� ������
    FAutoRep: Boolean;
    FIdForAutoRep: Integer;

    FMonth,
    FYear,
    FRegion: Word;
    FRegionName: string;
    //������ ��������� ��������� � �����
    FEntryArray: TEntryArray;
    FFlag: Boolean; //���� ���������� ���� ��� ���

    //��� ������ � ������ �����
    FActRow: Integer;

    //���������� ���������� ��� ����������
    Frame: TSprFrame;

    procedure ChangeType(AType: byte);
    procedure LoadObjEstInfo;
    procedure LoadRepInfo;
    procedure LoadEntry;

    procedure ShowDelRep(const AID: Integer; ADel: Boolean = False);
    procedure AfterFrameLoad(ASender: TObject);
    { Private declarations }
  public
    constructor Create(const AObjectID, AEstimateID, ARateID,
      AMatMechID: Integer; AMatMechCode: string; AType: Byte;
      AAdd, AAutoRep: Boolean); reintroduce;
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses DataModule, Tools;

procedure TfrmReplacement.PMEntryPopup(Sender: TObject);
var PRec: ^TEntryRecord;
begin
  //��������� ������ �� ���������� �����
  if (ListEntry.ItemIndex > -1) and
    Assigned(ListEntry.Items[ListEntry.ItemIndex].Data) then
  begin
    PRec := ListEntry.Items[ListEntry.ItemIndex].Data;

    pmCurRate.Visible := True;
    pmCurRate.Caption := PRec^.EName;
    pmCurRate.Tag := PRec^.EID;

    if PRec^.MRep > 0 then
    begin
      pmShowRep.Visible := True;
      pmShowRep.Caption := '���������� ' + PRec^.MCode;
      pmShowRep.Tag := PRec^.MID;
    end
    else
      pmShowRep.Visible := False;
  end
  else
  begin
    pmCurRate.Visible := False;
    pmShowRep.Visible := False;
  end;
end;

procedure TfrmReplacement.pmSelectAllClick(Sender: TObject);
var i: Integer;
begin
  //�������� ��� �������� ���
  for i := Low(FEntryArray) to High(FEntryArray) do
    if TComponent(Sender).Tag = 0 then
      FEntryArray[i].Select := False
    else
      FEntryArray[i].Select := True;
  ListEntry.Repaint;
end;

procedure TfrmReplacement.pmSelectRateClick(Sender: TObject);
var i: Integer;
begin
  //�������� ��� �������� �����
  for i := Low(FEntryArray) to High(FEntryArray) do
  begin
    if TMenuItem(Sender).Parent.Tag = FEntryArray[i].EID then
    begin
      if TComponent(Sender).Tag = 0 then
        FEntryArray[i].Select := False
      else
        FEntryArray[i].Select := True;
    end;
  end;
  ListEntry.Repaint;
end;

//������� ���������� ��������� �� �� �����������
//��� ������� ��������� �� ������� ���������� ADel = true
procedure TfrmReplacement.ShowDelRep(const AID: Integer; ADel: Boolean = False);
var TmpStr: string;
  i, j: Integer;
  SprRec: PSprRecord;
begin
  if FTemp then
    TmpStr := '_temp';

  case FCurType of
    0:  qrRep.SQL.Text :=
        'select MAT_CODE, MAT_NAME, MAT_NORMA, MAT_COUNT, MAT_UNIT, ID ' +
          'from materialcard' + TmpStr + ' where ID_REPLACED = ' + AID.ToString +
          ' order by ID';
    1:  qrRep.SQL.Text :=
        'Select MECH_CODE, MECH_NAME, MECH_NORMA, MECH_COUNT, MECH_UNIT, ID ' +
          'from mechanizmcard' + TmpStr + ' where ID_REPLACED = ' + AID.ToString +
          ' order by ID';
  end;

  qrRep.Active := True;
  if not ADel then
  begin
    for i := grdRep.FixedRows to grdRep.RowCount - 1 do
      for j := 0 to grdRep.ColCount - 1 do
        grdRep.Cells[j, i] := '';
    grdRep.RowCount := grdRep.FixedRows + 1;
  end;

  i := 0;
  while not qrRep.Eof do
  begin
    Inc(i);
    if ADel then
    begin
      //������� ���������� ��������� ��� ���������
      //(���������� ��������� ��������� �� ���� ���������)
      case FCurType of
        0:  qrTemp.SQL.Text := 'CALL DeleteMaterial(:id, :CalcMode);';
        1:  qrTemp.SQL.Text := 'CALL DeleteMechanism(:id, :CalcMode);';
      end;
      qrTemp.ParamByName('id').Value := qrRep.FieldByName('ID').Value;
      qrTemp.ParamByName('CalcMode').Value := G_CALCMODE;
      qrTemp.ExecSQL;
    end
    else
    begin
      grdRep.RowCount := grdRep.FixedRows + i;
      grdRep.Cells[0, grdRep.RowCount - 1] := IntToStr(i);
      SprRec := Frame.FindCode(qrRep.Fields[0].AsString);
      if Assigned(SprRec) then
      begin
        grdRep.Cells[1, grdRep.RowCount - 1] := SprRec^.Code;
        grdRep.Cells[2, grdRep.RowCount - 1] := SprRec^.Name;
        grdRep.Cells[3, grdRep.RowCount - 1] := SprRec^.Unt;
        grdRep.Cells[4, grdRep.RowCount - 1] := IntToStr(Round(SprRec^.CoastNDS));
        grdRep.Cells[5, grdRep.RowCount - 1] := IntToStr(Round(SprRec^.CoastNoNDS));
        grdRep.Cells[6, grdRep.RowCount - 1] := '1';
        grdRep.Cells[7, grdRep.RowCount - 1] := SprRec^.ID.ToString;
      end;
    end;
    qrRep.Next;
  end;
  qrRep.Active := False;
end;

procedure TfrmReplacement.pmShowRepClick(Sender: TObject);
begin
  ShowDelRep(TMenuItem(Sender).Tag);
end;

procedure TfrmReplacement.grdRepKeyPress(Sender: TObject; var Key: Char);
var f: Extended;
    s: string;
begin
  if (grdRep.Col = 1) then
  begin
    if (Key = #3) or (Key = #$16) then //����������� �  �������
      Exit;
    //�������� ������������ ��������� ���� � ����������� �� ����
    case FCurType of
      0:
      begin
        if (Key = 'C') or (Key = 'c') or (Key = '�') then
          Key := '�'; //��������
        if not (CharInSet(Key, ['0'..'9', '-', #8]) or (Key = '�')) then
          Key := #0;
      end;
      1:
      begin
        if (Key = 'M') or (Key = 'm') or (Key = '�') then
          Key := '�'; //��������
        if not (CharInSet(Key, ['0'..'9', #8]) or (Key = '�')) then
          Key := #0;
      end;
      2:
      begin
        if not (CharInSet(Key, ['0'..'9', '-', #8])) then
          Key := #0;
      end;
    end;
  end;

  //������� �������������� ����. ���������
  if (grdRep.Col = 6) then
  begin
    if CharInSet(Key, [^C, ^X, ^Z]) then
      Exit;

    if (Key = ^V) then
    begin
      //�������� �� ������������ ������������ ������
      if TryStrToFloat(Clipboard.AsText, f) then
      begin
        s :=
          Copy(TMyGrid(grdRep).InplaceEditor.Text, 1,
            TMyGrid(grdRep).InplaceEditor.SelStart) +
          Clipboard.AsText +
          Copy(TMyGrid(grdRep).InplaceEditor.Text,
            TMyGrid(grdRep).InplaceEditor.SelStart +
              TMyGrid(grdRep).InplaceEditor.SelLength + 1,
            Length(TMyGrid(grdRep).InplaceEditor.Text) -
              TMyGrid(grdRep).InplaceEditor.SelStart -
              TMyGrid(grdRep).InplaceEditor.SelLength);
        if TryStrToFloat(s, f) then
          Exit;
      end;
    end;

    case Key of
      '0'..'9',#8: ;
      '.',',':
       begin
         Key := FormatSettings.DecimalSeparator;
         if (pos(FormatSettings.DecimalSeparator ,
          grdRep.Cells[grdRep.Col, grdRep.Row]) <> 0) or
            (grdRep.Cells[grdRep.Col, grdRep.Row] = '') then
          Key:= #0;
       end;
       else Key:= #0;
    end;
  end;
end;

procedure TfrmReplacement.grdRepMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var r, c: Integer;
    TextWidth: Integer;
begin
  //���������� ���� ��� ��� ������������ ������� �� ������ � ������
  grdRep.MouseToCell(X, Y, c, r);
  if (c = 2) and (r >= grdRep.FixedRows) and (r < grdRep.RowCount) then
  begin
    if FActRow <> r then
    begin
      FActRow := r;
      TextWidth := grdRep.Canvas.TextWidth(grdRep.Cells[c,r]);
      if (TextWidth > grdRep.ColWidths[c]) then
      begin
        Application.CancelHint;
        grdRep.Hint := grdRep.Cells[c, r];
        grdRep.ShowHint :=  True;
      end;
    end;
  end
  else
  begin
    Application.CancelHint;
    grdRep.Hint := '';
    grdRep.ShowHint := False;
    FActRow := -1;
  end;
end;

procedure TfrmReplacement.grdRepSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
var s: string;
begin
  //������������� ����� ������ ��� � �����������
  if ACol in [1,6] then
    grdRep.Options := grdRep.Options + [goEditing]
  else
    grdRep.Options := grdRep.Options - [goEditing];

  //������� ����������� � �����, ���� �� ����� ������� �����
  if (grdRep.Col = 6)then
  begin
    s := grdRep.Cells[grdRep.Col, grdRep.Row];
    if (Length(s) > 0) and (s[High(s)] = FormatSettings.DecimalSeparator) then
      SetLength(s, Length(s)-1);
    grdRep.Cells[grdRep.Col, grdRep.Row] := s;

    if grdRep.Cells[grdRep.Col, grdRep.Row] = '' then
      grdRep.Cells[grdRep.Col, grdRep.Row] := '1';
  end;
end;

//����� �� �����������
procedure TfrmReplacement.grdRepSetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: string);
var SprRec: PSprRecord;
begin
  if (ACol = 1) then
  begin
    SprRec := Frame.FindCode(grdRep.Cells[1, ARow]);
    if Assigned(SprRec) then
    begin
      grdRep.Cells[2, ARow] := SprRec^.Name;
      grdRep.Cells[3, ARow] := SprRec^.Unt;
      grdRep.Cells[4, ARow] := IntToStr(Round(SprRec^.CoastNDS));
      grdRep.Cells[5, ARow] := IntToStr(Round(SprRec^.CoastNoNDS));
      grdRep.Cells[7, ARow] := SprRec^.ID.ToString;
    end
    else
    begin
      grdRep.Cells[2, ARow] := '';
      grdRep.Cells[3, ARow] := '';
      grdRep.Cells[4, ARow] := '';
      grdRep.Cells[5, ARow] := '';
      grdRep.Cells[7, ARow] := '';
    end;
  end;
end;

procedure TfrmReplacement.ListEntryChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
var i: Integer;
begin
  if Assigned(Item.Data) then
    TEntryRecord(Item.Data^).Select := Item.Checked;
  //���� ������� ���������� ���������� ������ "������� ������"
  btnDelReplacement.Visible := False;
  for i := Low(FEntryArray) to High(FEntryArray) do
    if FEntryArray[i].Select then
      btnDelReplacement.Visible :=
        btnDelReplacement.Visible or (FEntryArray[i].MRep > 0);
end;

procedure TfrmReplacement.ListEntryCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  if Assigned(Item) and
    Assigned(Item.Data) then
  begin
    Item.Checked := TEntryRecord(Item.Data^).Select;
    if Item.Caption.IsEmpty then //���������� ������ ��� �� ����������� ������
    begin
      Item.Caption := TEntryRecord(Item.Data^).EName;
      Item.SubItems.Add(TEntryRecord(Item.Data^).RCode);
      if TEntryRecord(Item.Data^).MRep > 0 then
        Item.SubItems.Add(TEntryRecord(Item.Data^).MCode + ' (�)')
      else
        Item.SubItems.Add(TEntryRecord(Item.Data^).MCode);
      if TEntryRecord(Item.Data^).MNorma > 0 then
        Item.SubItems.Add(TEntryRecord(Item.Data^).MNorma.ToString)
      else
        Item.SubItems.Add('');
      Item.SubItems.Add(TEntryRecord(Item.Data^).MCount.ToString);
      Item.SubItems.Add(TEntryRecord(Item.Data^).MUnt);
    end;
    //��������� ����� ��� ����������
    if TEntryRecord(Item.Data^).MRep > 0 then
      Sender.Canvas.Brush.Color := $00DDDDDD;
  end;
  DefaultDraw := True;
end;

constructor TfrmReplacement.Create(const AObjectID, AEstimateID, ARateID,
  AMatMechID: Integer; AMatMechCode: string; AType: Byte;
  AAdd, AAutoRep: Boolean);
begin
  // FTemp := ATemp;
  //����������� ������ ��� ���������, ��� ������� �� ����� �������� ��������
  FTemp := True;
  FAddMode := AAdd;

  if (FAddMode and not(AType in [0,1])) or
     (not FAddMode and not(AType in [0,1,2])) then
    raise Exception.Create('����������� ���');

  inherited Create(nil);

  //����� ���� ��� ������ � Create �� ��������
  grdRep.ColWidths[0] := 20;
  grdRep.ColWidths[1] := 90;
  grdRep.ColWidths[2] := 260;
  grdRep.ColWidths[3] := 70;
  if AType = 2 then
  begin
    grdRep.ColWidths[4] := -1;
    grdRep.ColWidths[5] := -1;
  end
  else
  begin
    grdRep.ColWidths[4] := 100;
    grdRep.ColWidths[5] := 100;
  end;
  //�������� ������� ������������� ��� ������ ����������
  if FAddMode then
    grdRep.ColWidths[6] := -1
  else
    grdRep.ColWidths[6] := 70;
  grdRep.ColWidths[7] := -1;

  grdRep.Cells[0,0] := '�';
  grdRep.Cells[1,0] := '���';
  grdRep.Cells[2,0] := '������������';
  grdRep.Cells[3,0] := '��. ���.';
  grdRep.Cells[4,0] := '���� � ���, ���';
  grdRep.Cells[5,0] := '���� ��� ���, ���';
  grdRep.Cells[6,0] := '����. ���.';
  grdRep.Cells[7,0] := 'ID';

  grdRep.Cells[0,1] := '1';
  grdRep.Cells[6,1] := '1';

  grdRep.Col := 1;
  grdRep.Options := grdRep.Options + [goEditing];

  //������ ����� �����, ���-�� onClick ���������
  FCurType := 99;

  FMonth := 0;
  FYear := 0;
  FRegion := 0;

  FObjectID := AObjectID;
  FEstimateID := AEstimateID;
  FRateID := ARateID;
  FMatMechID := AMatMechID;
  //���� �� ����� ID ���������� ����� �� ����
  if FMatMechID = 0 then
    FMatMechCode := AMatMechCode;

  FAutoRep := AAutoRep;

  FObjectName := '';
  FEstimateName := '';
  FRateCode := '';

  LoadObjEstInfo;

  if FAddMode then
  begin
     Panel1.Visible := False;
     groupEntry.Visible := False;
     groupRep.Height := 200;
     groupRep.Caption := ' �������� � �������� ' + FRateCode + ': ';
     Caption := '���������� ���������� � ����������';
     btnReplace.Caption := '��������';
  end;

  //��������� ���� �������� � �������� �����������
  rgroupType.ItemIndex := AType;

  if not FAddMode then
  begin
    LoadRepInfo;
    LoadEntry;
  end;
end;

//���������� ���������� �� �������, ����� � ��������, ���� ����
procedure TfrmReplacement.LoadObjEstInfo;
var TmpStr: string;
begin
  qrRep.Active := False;

  if FObjectID > 0 then
    qrRep.SQL.Text := 'SELECT ob.region_id, reg.region_name, ob.NAME ' +
      'FROM objcards as ob, regions as reg ' +
      'WHERE (ob.region_id = reg.region_id) and ' +
      '(ob.obj_id = ' + IntToStr(FObjectID) + ');'
  else
    qrRep.SQL.Text := 'SELECT ob.region_id, reg.region_name, ob.NAME ' +
      'FROM objcards as ob, regions as reg ' +
      'WHERE (ob.region_id = reg.region_id) and ' +
      '(ob.obj_id = (SELECT obj_id FROM smetasourcedata WHERE sm_id = ' +
      IntToStr(FEstimateID) + '));';
  qrRep.Active := True;
  if not qrRep.IsEmpty then
  begin
    FRegion := qrRep.Fields[0].AsInteger;
    FRegionName := qrRep.Fields[1].AsString;
    FObjectName := qrRep.Fields[2].AsString;
  end;
  qrRep.Active := False;

  qrRep.SQL.Text := 'SELECT IFNULL(monat,0) as monat, ' +
    'IFNULL(year,0) as year, CONCAT(SM_NUMBER, " ",  NAME) as SMNAME ' +
    'FROM smetasourcedata ' +
    'LEFT JOIN stavka ON stavka.stavka_id = smetasourcedata.stavka_id ' +
    'WHERE sm_id = ' + IntToStr(FEstimateID) + ';';
  qrRep.Active := True;
  if not qrRep.IsEmpty then
  begin
    FMonth := qrRep.Fields[0].AsInteger;
    FYear := qrRep.Fields[1].AsInteger;
    FEstimateName := qrRep.Fields[2].AsString;
  end;
  qrRep.Active := False;

  if FRateID > 0 then
  begin
    TmpStr := '';
    if FTemp then
      TmpStr := '_temp';

    qrRep.SQL.Text := 'SELECT RATE_CODE FROM card_rate' + TmpStr +
      ' WHERE (ID = ' + IntToStr(FRateID) + ');';
    qrRep.Active := True;
    if not qrRep.IsEmpty then
    begin
      FRateCode := qrRep.Fields[0].AsString;
    end;
    qrRep.Active := False;
  end;
end;

//���������� ���������� � ���������� ���������
procedure TfrmReplacement.LoadRepInfo;
var TmpStr: string;
begin
  if FTemp then
    TmpStr := '_temp';

  case FCurType of
    0:
    begin
      if FMatMechCode <> '' then
        qrRep.SQL.Text :=
          'select MAT_CODE, MAT_NAME from material where MAT_CODE = ''' +
            FMatMechCode + ''''
      else
        qrRep.SQL.Text :=
          'select MAT_CODE, MAT_NAME from materialcard' + TmpStr + ' where ID = ' +
          FMatMechID.ToString;
    end;
    1:
    begin
      if FMatMechCode <> '' then
        qrRep.SQL.Text :=
          'Select MECH_CODE, MECH_NAME from mechanizm where MECH_CODE = ''' +
            FMatMechCode + ''''
      else
        qrRep.SQL.Text :=
          'Select MECH_CODE, MECH_NAME from mechanizmcard' + TmpStr + ' where ID = ' +
          FMatMechID.ToString;
    end;
    2:
    begin
      if FMatMechCode <> '' then
        qrRep.SQL.Text :=
          'Select DEVICE_CODE1, NAME from devices where DEVICE_CODE1 = ''' +
            FMatMechCode + ''''
      else
        qrRep.SQL.Text :=
          'Select DEVICE_CODE, DEVICE_NAME from devicescard' + TmpStr + ' where ID = ' +
          FMatMechID.ToString;
    end;
  end;

  qrRep.Active := True;
  if not qrRep.IsEmpty then
  begin
    edtSourceCode.Text := qrRep.Fields[0].AsString;
    edtSourceName.Text := qrRep.Fields[1].AsString;
    Frame.edtFindName.Text := edtSourceName.Text;
  end;
  qrRep.Active := False;
end;

function CompareEntryRecord(const Left, Right: TEntryRecord): Integer;
begin
  Result := Left.EID - Right.EID;
  if Result = 0 then
    Result := Left.MSort - Right.MSort;
  if Result = 0 then
    Result := Left.MID - Right.MID;
end;
//���������� ��������� ����������� ��������� � �����
procedure TfrmReplacement.LoadEntry;
var Item: TListItem;
    i, ind: Integer;
    TmpStr,
    WhereStr: string;
    TmpFlag: Boolean;

    procedure BrowsDataSet;
    begin
      while not qrTemp.Eof do
      begin
        Inc(ind);
        SetLength(FEntryArray, ind);
        FEntryArray[ind - 1].EID := qrTemp.FieldByName('SMID').AsInteger;
        FEntryArray[ind - 1].EName := qrTemp.FieldByName('SMNAME').AsString;
        FEntryArray[ind - 1].RCode := qrTemp.FieldByName('RTCODE').AsString;
        FEntryArray[ind - 1].MID := qrTemp.FieldByName('MTID').AsInteger;
        FEntryArray[ind - 1].MCode := qrTemp.FieldByName('MTCODE').AsString;
        FEntryArray[ind - 1].MUnt := qrTemp.FieldByName('MTUNIT').AsString;
        FEntryArray[ind - 1].MNorma := qrTemp.FieldByName('MTNORMA').AsFloat;
        FEntryArray[ind - 1].MCount := qrTemp.FieldByName('MTCOUNT').AsFloat;
        FEntryArray[ind - 1].MIdCardRate := qrTemp.FieldByName('MTIDRATE').AsInteger;
        FEntryArray[ind - 1].MIdReplaced := qrTemp.FieldByName('MTIDREP').AsInteger;
        FEntryArray[ind - 1].MCons := qrTemp.FieldByName('MTCONS').AsInteger;
        FEntryArray[ind - 1].MRep := qrTemp.FieldByName('MTREP').AsInteger;
        FEntryArray[ind - 1].MFromRate := qrTemp.FieldByName('MTFROMRATE').AsInteger;
        FEntryArray[ind - 1].MConsRep := qrTemp.FieldByName('MTCONREP').AsInteger;
        FEntryArray[ind - 1].MAdded := qrTemp.FieldByName('MTADDED').AsInteger;
        FEntryArray[ind - 1].MSort := qrTemp.FieldByName('NUMROW').AsInteger;
        FEntryArray[ind - 1].DataID := qrTemp.FieldByName('IDTABLES').AsInteger;
        FEntryArray[ind - 1].DataType := qrTemp.FieldByName('TYPEDATA').AsInteger;

        if (FMatMechID > 0) then
          FEntryArray[ind - 1].Select :=
            (FMatMechID = FEntryArray[ind - 1].MID) and
            (FEntryArray[ind - 1].MRep = 0)
        else
        begin
          FEntryArray[ind - 1].Select :=
            (FMatMechCode = FEntryArray[ind - 1].MCode);
        end;

        qrTemp.Next;
      end;
    end;
begin

  TmpStr := '';
  WhereStr := '';

  if FTemp then
    TmpStr := '_temp';

  //����� �� �����
  if (FEstimateName <> '') then
  begin
    groupEntry.Caption := ' ��������� � ' + FEstimateName + ':';
    if FTemp then
      WhereStr := ' AND ((SM.SM_ID = ' + FEstimateID.ToString + ') OR ' +
        '(SM.PARENT_ID = ' + FEstimateID.ToString + ') OR ' +
        '(SM.PARENT_ID IN (SELECT smetasourcedata.SM_ID FROM ' +
        'smetasourcedata WHERE smetasourcedata.PARENT_ID = ' +
        FEstimateID.ToString + ')))';
  end
  else
  begin
    groupEntry.Caption := ' ��������� � ' + FObjectName + ':';
    if FTemp then
      WhereStr := ' AND (SM.OBJ_ID = ' + FObjectID.ToString + ')';
  end;

  ind := 0;
  SetLength(FEntryArray, 0);
  if FCurType in [0, 1] then
  begin
    // ��������� � ��������
    qrTemp.Active := False;
    case FCurType of
      0: qrTemp.SQL.Text := 'SELECT SM.SM_ID as SMID, ' +
          'CONCAT(SM.SM_NUMBER, " ",  SM.NAME) as SMNAME, ' +
          'RT.RATE_CODE as RTCODE, MT.ID as MTID, ' +
          'MT.MAT_CODE as MTCODE, MT.MAT_COUNT as MTCOUNT, ' +
          'MT.MAT_UNIT as MTUNIT, MT.MAT_NORMA as MTNORMA, ' +
          'MT.ID_CARD_RATE as MTIDRATE, MT.ID_REPLACED as MTIDREP, ' +
          'MT.CONSIDERED as MTCONS, MT.REPLACED as MTREP, ' +
          'MT.FROM_RATE as MTFROMRATE, MT.CONS_REPLASED as MTCONREP, ' +
          'MT.ADDED as MTADDED, ES.NUM_ROW as NUMROW, ' +
          'ES.ID_TABLES as IDTABLES, ES.ID_TYPE_DATA as TYPEDATA ' +
          'FROM smetasourcedata as SM, data_estimate' + TmpStr + ' as ES, ' +
          'card_rate' + TmpStr + ' as RT, materialcard' + TmpStr + ' as MT ' +
          'WHERE (SM.SM_ID = ES.ID_ESTIMATE) AND (ES.ID_TYPE_DATA = 1) AND ' +
          '(ES.ID_TABLES = RT.ID) AND (RT.ID = MT.ID_CARD_RATE) AND ' +
          '(MT.FROM_RATE = 0) AND (MT.DELETED = 0) AND ' +
          '(MT.MAT_CODE = ''' + edtSourceCode.Text + ''')' +
          WhereStr;
      1: qrTemp.SQL.Text := 'SELECT SM.SM_ID as SMID, ' +
          'CONCAT(SM.SM_NUMBER, " ",  SM.NAME) as SMNAME, ' +
          'RT.RATE_CODE as RTCODE, MT.ID as MTID, ' +
          'MT.MECH_CODE as MTCODE, MT.MECH_COUNT as MTCOUNT, ' +
          'MT.MECH_UNIT as MTUNIT, MT.MECH_NORMA as MTNORMA, ' +
          'MT.ID_CARD_RATE as MTIDRATE, MT.ID_REPLACED as MTIDREP, ' +
          'null as MTCONS, MT.REPLACED as MTREP, ' +
          'MT.FROM_RATE as MTFROMRATE, null as MTCONREP, ' +
          'MT.ADDED as MTADDED, ES.NUM_ROW as NUMROW, ' +
          'ES.ID_TABLES as IDTABLES, ES.ID_TYPE_DATA as TYPEDATA ' +
          'FROM smetasourcedata as SM, data_estimate' + TmpStr + ' as ES, ' +
          'card_rate' + TmpStr + ' as RT, mechanizmcard' + TmpStr + ' as MT ' +
          'WHERE (SM.SM_ID = ES.ID_ESTIMATE) AND (ES.ID_TYPE_DATA = 1) AND ' +
          '(ES.ID_TABLES = RT.ID) AND (RT.ID = MT.ID_CARD_RATE) AND ' +
          '(MT.FROM_RATE = 0) AND (MT.DELETED = 0) AND ' +
          '(MT.MECH_CODE = ''' + edtSourceCode.Text + ''')' +
          WhereStr;
    end;
    qrTemp.Active := True;
    BrowsDataSet;
    qrTemp.Active := False;
  end;
  //��������� �� ��������
  qrTemp.Active := False;
  case FCurType of
    0: qrTemp.SQL.Text := 'SELECT SM.SM_ID as SMID, ' +
        'CONCAT(SM.SM_NUMBER, " ",  SM.NAME) as SMNAME, ' +
        'null as RTCODE, MT.ID as MTID, ' +
        'MT.MAT_CODE as MTCODE, MT.MAT_COUNT as MTCOUNT, ' +
        'MT.MAT_UNIT as MTUNIT, MT.MAT_NORMA as MTNORMA, ' +
        'MT.ID_CARD_RATE as MTIDRATE, MT.ID_REPLACED as MTIDREP, ' +
        'MT.CONSIDERED as MTCONS, MT.REPLACED as MTREP, ' +
        'MT.FROM_RATE as MTFROMRATE, MT.CONS_REPLASED as MTCONREP, ' +
        'MT.ADDED as MTADDED, ES.NUM_ROW as NUMROW, ' +
        'ES.ID_TABLES as IDTABLES, ES.ID_TYPE_DATA as TYPEDATA ' +
        'FROM smetasourcedata as SM, data_estimate' + TmpStr + ' as ES, ' +
        'materialcard' + TmpStr + ' as MT ' +
        'WHERE (SM.SM_ID = ES.ID_ESTIMATE) AND (ES.ID_TYPE_DATA = 2) AND ' +
        '(ES.ID_TABLES = MT.ID) AND (MT.MAT_CODE = ''' + edtSourceCode.Text + ''')' +
        WhereStr;
    1: qrTemp.SQL.Text := 'SELECT SM.SM_ID as SMID, ' +
        'CONCAT(SM.SM_NUMBER, " ",  SM.NAME) as SMNAME, ' +
        'null as RTCODE, MT.ID as MTID, ' +
        'MT.MECH_CODE as MTCODE, MT.MECH_COUNT as MTCOUNT, ' +
        'MT.MECH_UNIT as MTUNIT, MT.MECH_NORMA as MTNORMA, ' +
        'MT.ID_CARD_RATE as MTIDRATE, MT.ID_REPLACED as MTIDREP, ' +
        'null as MTCONS, MT.REPLACED as MTREP, ' +
        'MT.FROM_RATE as MTFROMRATE, null as MTCONREP, ' +
        'MT.ADDED as MTADDED, ES.NUM_ROW as NUMROW, ' +
        'ES.ID_TABLES as IDTABLES, ES.ID_TYPE_DATA as TYPEDATA ' +
        'FROM smetasourcedata as SM, data_estimate' + TmpStr + ' as ES, ' +
        'mechanizmcard' + TmpStr + ' as MT ' +
        'WHERE (SM.SM_ID = ES.ID_ESTIMATE) AND (ES.ID_TYPE_DATA = 3) AND ' +
        '(ES.ID_TABLES = MT.ID) AND (MT.MECH_CODE = ''' + edtSourceCode.Text + ''')' +
        WhereStr;
    2: qrTemp.SQL.Text := 'SELECT SM.SM_ID as SMID, ' +
        'CONCAT(SM.SM_NUMBER, " ",  SM.NAME) as SMNAME, ' +
        'null as RTCODE, MT.ID as MTID, ' +
        'MT.DEVICE_CODE as MTCODE, MT.DEVICE_COUNT as MTCOUNT, ' +
        'MT.DEVICE_UNIT as MTUNIT, null as MTNORMA, ' +
        'null as MTIDRATE, null as MTIDREP, ' +
        'null as MTCONS, null as MTREP, ' +
        'null as MTFROMRATE, null as MTCONREP, ' +
        'null as MTADDED, ES.NUM_ROW as NUMROW, ' +
        'ES.ID_TABLES as IDTABLES, ES.ID_TYPE_DATA as TYPEDATA ' +
        'FROM smetasourcedata as SM, data_estimate' + TmpStr + ' as ES, ' +
        'devicescard' + TmpStr + ' as MT ' +
        'WHERE (SM.SM_ID = ES.ID_ESTIMATE) AND (ES.ID_TYPE_DATA = 4) AND ' +
        '(ES.ID_TABLES = MT.ID) AND (MT.DEVICE_CODE = ''' + edtSourceCode.Text + ''')' +
        WhereStr;
  end;
  qrTemp.Active := True;
  BrowsDataSet;
  qrTemp.Active := False;

  TArray.Sort<TEntryRecord>(FEntryArray,
    TComparer<TEntryRecord>.Construct(CompareEntryRecord));

  ListEntry.Visible := False;
  ListEntry.Items.Clear;
  TmpFlag := False;
  for i := Low(FEntryArray) to High(FEntryArray) do
  begin
    Item := ListEntry.Items.Add;
    Item.Data := @FEntryArray[i];
    if FAutoRep and (not TmpFlag) and (FEntryArray[i].MRep > 0) then
    begin
      if Frame.Loaded then
        ShowDelRep(FEntryArray[i].MID)
      else
        FIdForAutoRep := FEntryArray[i].MID;
      TmpFlag := True;
    end;
  end;
  ListEntry.Visible := True;
end;

procedure TfrmReplacement.AfterFrameLoad(ASender: TObject);
begin
  if FIdForAutoRep > 0 then
  begin
    ShowDelRep(FIdForAutoRep);
    FIdForAutoRep := 0;
  end;
end;

procedure TfrmReplacement.btnReplaceClick(Sender: TObject);
var i, j, ind, iterator:  Integer;
    Flag: Boolean;
    IDArray: array of Integer;
    CoefArray: array of Double;
    DelOnly: Boolean;
    TmpStr: string;
begin
  if FTemp then
    TmpStr := '_temp';

  //���� �������� �����
  DelOnly := (TButton(Sender).Tag = 1);
  //�������� �� ������� ����������� �����������
  if not FAddMode then
  begin
    Flag := False;
    for i := Low(FEntryArray) to High(FEntryArray) do
      if FEntryArray[i].Select then
      begin
        Flag := True;
        Break;
      end;

    if not Flag then
    begin
      case FCurType of
        0: Showmessage('�� ����� ���������� ��������!');
        1: Showmessage('�� ����� ���������� ��������!');
        2: Showmessage('�� ������ ���������� ������������!');
      end;
      Exit;
    end;
  end;

  ind := 0;
  SetLength(IDArray, ind);
  SetLength(CoefArray, ind);

  //��������� ������ ����������
  for i := grdRep.FixedRows to grdRep.RowCount - 1 do
    if (grdRep.Cells[7, i] <> '') then
    begin
      Inc(ind);
      SetLength(IDArray, ind);
      SetLength(CoefArray, ind);
      IDArray[ind - 1] := grdRep.Cells[7, i].ToInteger;
      CoefArray[ind - 1] := grdRep.Cells[6, i].ToDouble;
    end;

  if (Length(IDArray) = 0) and ((not DelOnly) or FAddMode) then
  begin
    case FCurType of
      0: Showmessage('�� ������ �� ������ ����������� ���������!');
      1: Showmessage('�� ������ �� ������ ����������� ���������!');
      2: Showmessage('�� ������ �� ������ ����������� ������������!');
    end;
    Exit;
  end;

  Screen.Cursor := crHourGlass;
  try
    if FAddMode then
    begin
      //���� ���������� ����� ����������, ��������� ����� � ��������
      for j := Low(IDArray) to High(IDArray) do
      begin
        case FCurType of
          0: qrTemp.SQL.Text := 'CALL ReplacedMaterial(:IdEst, :IdRate, 1, :IdMS, 0, 0, 0, 0, 0, :CalcMode);';
          1: qrTemp.SQL.Text := 'CALL ReplacedMechanism(:IdEst, :IdRate, 1, :IdMS, 0, 0, 0, 0, 0, :CalcMode);';
        end;
        qrTemp.ParamByName('IdEst').Value := FEstimateID;
        qrTemp.ParamByName('IdRate').Value := FRateID;
        qrTemp.ParamByName('IdMS').Value := IDArray[j];
        qrTemp.ParamByName('CalcMode').Value := G_CALCMODE;
        qrTemp.ExecSQL;
      end;
    end
    else
    begin
      //���� ���������� ����� ������, ������������� ������, � � ����������� ��
      //���� ����������� ��������� ���� ������, ���� �������� � �������
      for i := Low(FEntryArray) to High(FEntryArray) do
      begin
        //�� ���������� ������������
        if not FEntryArray[i].Select then
          Continue;

        //���� ����� ���� ������, ��������� ����������
        //����� ����� �������� ��� �� ����� ���� ����������
        if FEntryArray[i].MRep > 0 then
          ShowDelRep(FEntryArray[i].MID, True);

        if not DelOnly then
        begin
          iterator := 0;
          //����� ��������� �������� �������� ������������� � ������ ������
          if (FEntryArray[i].MIdCardRate = 0) or (FEntryArray[i].MFromRate > 0) then
          begin
            case FCurType of
              0: qrTemp.SQL.Text := 'SELECT NUM_ROW FROM data_estimate' +
                  TmpStr + ' WHERE ' +
                  '(ID_ESTIMATE = :ID_ESTIMATE) AND (ID_TABLES = :ID_TABLES) ' +
                  'AND (ID_TYPE_DATA = 2)';
              1: qrTemp.SQL.Text := 'SELECT NUM_ROW FROM data_estimate' +
                  TmpStr + ' WHERE ' +
                  '(ID_ESTIMATE = :ID_ESTIMATE) AND (ID_TABLES = :ID_TABLES) ' +
                  'AND (ID_TYPE_DATA = 3)';
              2: qrTemp.SQL.Text := 'SELECT NUM_ROW FROM data_estimate' +
                  TmpStr + ' WHERE ' +
                  '(ID_ESTIMATE = :ID_ESTIMATE) AND (ID_TABLES = :ID_TABLES) ' +
                  'AND (ID_TYPE_DATA = 4)';
            end;
            qrTemp.ParamByName('ID_ESTIMATE').Value := FEntryArray[i].EID;
            qrTemp.ParamByName('ID_TABLES').Value := FEntryArray[i].MID;
            qrTemp.Active := True;
            if not qrTemp.IsEmpty then
              iterator := qrTemp.Fields[0].AsInteger;
            qrTemp.Active := False;
          end;

          if (FEntryArray[i].MFromRate > 0) or //���� ��� ��������� �� ��������
             (FEntryArray[i].MIdCardRate = 0) or //��� ��� ���������
             (FEntryArray[i].MIdReplaced > 0) or //��� ��� ����������
             (FEntryArray[i].MAdded > 0) then //��� ��� ����������� � ��������
          begin
            //�� ���������� ��������� �� ����
            case FCurType of
              0:  qrTemp.SQL.Text := 'CALL DeleteMaterial(:id, :CalcMode);';
              1:  qrTemp.SQL.Text := 'CALL DeleteMechanism(:id, :CalcMode);';
              2:  qrTemp.SQL.Text := 'CALL DeleteDevice(:id);';
            end;
            qrTemp.ParamByName('id').Value := FEntryArray[i].MID;
            if FCurType in [0,1] then
              qrTemp.ParamByName('CalcMode').Value := G_CALCMODE;
            qrTemp.ExecSQL;
          end;

          //����� �������� ���������� �� �������� �� ������������ � ��������
          //� ���� �� ��� � �������� ��� �������� �������� �� ������ ���� ������ �� ��������
          //��� ���������� ���������� �������� ���������� �������������
          if (FEntryArray[i].MFromRate > 0) and
             (((FEntryArray[i].MIdReplaced > 0) and
              ((FCurType = 1) or
              ((FCurType = 0) and (FEntryArray[i].MConsRep > 0)))) or
             (FEntryArray[i].MAdded > 0)) then
          begin
            //�� ���������� ��������� �� ����
            case FCurType of
              0:  qrTemp.SQL.Text := 'CALL DeleteMaterial(:id, :CalcMode);';
              1:  qrTemp.SQL.Text := 'CALL DeleteMechanism(:id, :CalcMode);';
            end;
            qrTemp.ParamByName('id').Value := FEntryArray[i].MID;
            qrTemp.ParamByName('CalcMode').Value := G_CALCMODE;
            qrTemp.ExecSQL;
          end;

          //����������� ������
          for j := Low(IDArray) to High(IDArray) do
          begin
            //������ ����������
            if (FEntryArray[i].MIdCardRate = 0) then
            begin
              case FCurType of
                0:  qrTemp.SQL.Text := 'CALL AddMaterial(:IdEstimate, ' +
                      ':IdMat, :MCount, :Iterator, :CALCMODE);';
                1:  qrTemp.SQL.Text := 'CALL AddMechanizm(:IdEstimate, ' +
                      ':IdMat, :MCount, :Iterator, :CALCMODE);';
                2:  qrTemp.SQL.Text := 'CALL AddDevice(:IdEstimate, ' +
                      ':IdMat, :MCount, :Iterator);';
              end;
              qrTemp.ParamByName('IdEstimate').Value := FEntryArray[i].EID;
              qrTemp.ParamByName('IdMat').Value := IDArray[j];
              qrTemp.ParamByName('MCount').Value := FEntryArray[i].MCount * CoefArray[j];
              qrTemp.ParamByName('Iterator').Value := iterator;
              if FCurType in [0,1] then
                qrTemp.ParamByName('CalcMode').Value := G_CALCMODE;
              qrTemp.ExecSQL;
              Continue;
            end;

            if (FEntryArray[i].MIdCardRate > 0) then
            begin
              case FCurType of
                0: qrTemp.SQL.Text := 'CALL ReplacedMaterial(:IdEst, :IdRate, :RType, ' +
                  ':IdMS, :IdMR, :MNorma, :MCount, :MFromRate, :Iterator, :CalcMode);';
                1: qrTemp.SQL.Text := 'CALL ReplacedMechanism(:IdEst, :IdRate, :RType, ' +
                  ':IdMS, :IdMR, :MNorma, :MCount, :MFromRate, :Iterator, :CalcMode);';
              end;
              qrTemp.ParamByName('IdEst').Value := FEstimateID;

              if (FEntryArray[i].MAdded > 0) then
              begin
                qrTemp.ParamByName('IdRate').Value := FEntryArray[i].MIdCardRate;
                qrTemp.ParamByName('RType').Value := 1;
              end
              else
              begin
                qrTemp.ParamByName('IdRate').Value := 0;
                qrTemp.ParamByName('RType').Value := 0;
              end;

              qrTemp.ParamByName('IdMS').Value := IDArray[j];

              if (FEntryArray[i].MAdded > 0) then
                qrTemp.ParamByName('IdMR').Value := 0
              else if (FEntryArray[i].MIdReplaced > 0) then
                qrTemp.ParamByName('IdMR').Value := FEntryArray[i].MIdReplaced
              else
                qrTemp.ParamByName('IdMR').Value := FEntryArray[i].MID;

              qrTemp.ParamByName('MNorma').Value := FEntryArray[i].MNorma * CoefArray[j];

              if FEntryArray[i].MFromRate > 0 then
              begin
                qrTemp.ParamByName('MCount').Value := FEntryArray[i].MCount * CoefArray[j];
                qrTemp.ParamByName('Iterator').Value := Iterator;
              end
              else
              begin
                qrTemp.ParamByName('MCount').Value := 0;
                qrTemp.ParamByName('Iterator').Value := 0;
              end;

              qrTemp.ParamByName('MFromRate').Value := FEntryArray[i].MFromRate;
              qrTemp.ParamByName('CalcMode').Value := G_CALCMODE;
              qrTemp.ExecSQL;
              Continue;
            end;
            inc(iterator);
          end;
        end;
      end;
    end;
  finally
    Screen.Cursor := crDefault;
    ModalResult := mrYes;
  end;
end;

procedure TfrmReplacement.btnSelectClick(Sender: TObject);
begin
  //����� �� �����������
  if (Frame.ListSpr.ItemIndex > -1) then
  begin
    grdRep.Cells[1, grdRep.Row] :=
      TSprRecord(Frame.ListSpr.Items[Frame.ListSpr.ItemIndex].Data^).Code;
    grdRep.Cells[2, grdRep.Row] :=
      TSprRecord(Frame.ListSpr.Items[Frame.ListSpr.ItemIndex].Data^).Name;
    grdRep.Cells[3, grdRep.Row] :=
      TSprRecord(Frame.ListSpr.Items[Frame.ListSpr.ItemIndex].Data^).Unt;
    grdRep.Cells[4, grdRep.Row] :=
      IntToStr(Round(TSprRecord(Frame.ListSpr.Items[Frame.ListSpr.ItemIndex].Data^).CoastNDS));
    grdRep.Cells[5, grdRep.Row] :=
      IntToStr(Round(TSprRecord(Frame.ListSpr.Items[Frame.ListSpr.ItemIndex].Data^).CoastNoNDS));
    grdRep.Cells[7, grdRep.Row] :=
      TSprRecord(Frame.ListSpr.Items[Frame.ListSpr.ItemIndex].Data^).ID.ToString;
  end;
end;

procedure TfrmReplacement.ChangeType(AType: byte);
begin
  case AType of
    //���������
    0:
    begin
      groupReplace.Caption := '��������:';
      ListEntry.Columns[2].Caption := '��������';
      groupCatalog.Caption := '���������� ����������:';

      Frame := TSprMaterial.Create(Self, True, False,
        EncodeDate(FYear, FMonth, 1), FRegion, True, False);
    end;
    //���������
    1:
    begin
      groupReplace.Caption := '��������:';
      ListEntry.Columns[2].Caption := '��������';
      groupCatalog.Caption := '���������� ����������:';

      Frame := TSprMechanizm.Create(Self, True, True,
        EncodeDate(FYear, FMonth, 1));
    end;
    //������������
    2:
    begin
      groupReplace.Caption := '������������:';
      ListEntry.Columns[2].Caption := '������������';
      groupCatalog.Caption := '���������� ������������:';

      Frame := TSprEquipment.Create(Self, False);
    end;
  end;
  Frame.Parent := groupCatalog;
  Frame.LoadSpr;
  Frame.Align := alClient;
  Frame.SpeedButtonShowHideClick(Frame.SpeedButtonShowHide);
  Frame.ListSpr.OnDblClick := btnSelectClick;
  Frame.OnAfterLoad := AfterFrameLoad;
  edtSourceCode.Text := '';
  edtSourceName.Text := '';
end;

procedure TfrmReplacement.rgroupTypeClick(Sender: TObject);
begin
  if FCurType <> rgroupType.ItemIndex then
  begin
    FCurType := rgroupType.ItemIndex;
    //���� ���������� ���� ��� ���
    FFlag :=
      ((FCurType = 0) and (FMonth > 0) and (FYear > 0) and (FRegion > 0))
      or
      ((FCurType = 1) and (FMonth > 0) and (FYear > 0));
    ChangeType(FCurType);
  end;
end;

procedure TfrmReplacement.SpeedButton1Click(Sender: TObject);
begin
  //��������� ������ � ������� ����������
  grdRep.RowCount := grdRep.RowCount + 1;
  grdRep.Cells[0, grdRep.RowCount - 1] := (grdRep.RowCount - 1).ToString;
  grdRep.Cells[6, grdRep.RowCount - 1] := '1';
  grdRep.Row := grdRep.RowCount - 1;
end;

procedure TfrmReplacement.SpeedButton2Click(Sender: TObject);
var i, j: Integer;
begin
  //������� ������ �� ������� ����������
  if (grdRep.RowCount > grdRep.FixedRows + 1) then
  begin
    for i := grdRep.Row to grdRep.RowCount - 2 do
      for j := grdRep.FixedCols to grdRep.ColCount - 1 do
        grdRep.Cells[j, i] := grdRep.Cells[j, i + 1];

    for j := 0 to grdRep.ColCount - 1 do
        grdRep.Cells[j, grdRep.RowCount - 1] := '';

    grdRep.RowCount := grdRep.RowCount - 1;
  end
  else
  begin
    for j := grdRep.FixedCols to grdRep.ColCount - 1 do
      grdRep.Cells[j, grdRep.RowCount - 1] := '';
    grdRep.Cells[6, grdRep.RowCount - 1] := '1';
  end;
end;

procedure TfrmReplacement.btnCancelClick(Sender: TObject);
begin
  Close;
end;

end.
