unit UniDict;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids,
  JvExDBGrids, JvDBGrid, Tools, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Vcl.DBCtrls, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Samples.Spin, System.DateUtils,
  Vcl.Mask, JvComponentBase, JvFormPlacement;

type
  TfUniDict = class(TForm)
    qrUniDict: TFDQuery;
    dsUniDict: TDataSource;
    dbmmoparam_description: TDBMemo;
    seYear: TSpinEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    dbedtcode: TDBEdit;
    lbl3: TLabel;
    qrUniDictid_unidictparam: TFDAutoIncField;
    strngfldUniDictcode: TStringField;
    strngfldUniDictparam_name: TStringField;
    strngfldUniDictparam_description: TStringField;
    qrUniDictMONTH_1: TFloatField;
    qrUniDictMONTH_2: TFloatField;
    qrUniDictMONTH_3: TFloatField;
    qrUniDictMONTH_4: TFloatField;
    qrUniDictMONTH_5: TFloatField;
    qrUniDictMONTH_6: TFloatField;
    qrUniDictMONTH_7: TFloatField;
    qrUniDictMONTH_8: TFloatField;
    qrUniDictMONTH_9: TFloatField;
    qrUniDictMONTH_10: TFloatField;
    qrUniDictMONTH_11: TFloatField;
    qrUniDictMONTH_12: TFloatField;
    qrSetParamValue: TFDQuery;
    qrUniDictType: TFDQuery;
    dsUniDictType: TDataSource;
    qrUniDictTypeLook: TFDQuery;
    dsUniDictTypeLook: TDataSource;
    qrUniDictid_unidicttype: TIntegerField;
    strngfldUniDictLookIDUniDictType: TStringField;
    pnlClient: TPanel;
    pnlLeft: TPanel;
    spl1: TSplitter;
    pnlClientCh: TPanel;
    gtUniDictType: TJvDBGrid;
    grUniDictParam: TJvDBGrid;
    FormStorage: TJvFormStorage;
    dbmmoparam_description1: TDBMemo;
    dbnvgr1: TDBNavigator;
    spl2: TSplitter;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure seYearChange(Sender: TObject);
    procedure qrUniDictMONTHChange(Sender: TField);
    procedure gtUniDictTypeEnter(Sender: TObject);
    procedure grUniDictParamEnter(Sender: TObject);
    procedure qrUniDictTypeAfterPost(DataSet: TDataSet);
    procedure qrUniDictTypeAfterScroll(DataSet: TDataSet);
    procedure qrUniDictTypeUpdateError(ASender: TDataSet; AException: EFDException; ARow: TFDDatSRow;
      ARequest: TFDUpdateRequest; var AAction: TFDErrorAction);
    procedure qrUniDictAfterPost(DataSet: TDataSet);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure changeEditMode;
  private
    editMode: Boolean;
  public
    procedure SetConstactorService;
    { Public declarations }
  end;

var
  fUniDict: TfUniDict;

implementation

{$R *.dfm}

uses Main;

procedure TfUniDict.FormActivate(Sender: TObject);
begin
  // ���� ������ ������� Ctrl � �������� �����, �� ������
  // �������������� � ��������� ���� ����� �� �������� ����
  FormMain.CascadeForActiveWindow;
  // ������ ������� ������ �������� ����� (�� ������� ����� �����)
  FormMain.SelectButtonActiveWindow(Caption);
  dbnvgr1.Visible := editMode;
  grUniDictParam.Columns[1].Visible := editMode;
end;

procedure TfUniDict.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfUniDict.FormCreate(Sender: TObject);
begin
  // ������ ������ �� ����� ���� (�� ������� ����� �����)
  FormMain.CreateButtonOpenWindow(Caption, Caption, fUniDict, 1);
  LoadDBGridSettings(grUniDictParam);
  LoadDBGridSettings(gtUniDictType);
  CloseOpen(qrUniDictType);
  CloseOpen(qrUniDictTypeLook);
  seYear.Value := YearOf(Now);
  seYearChange(Sender);
end;

procedure TfUniDict.FormDestroy(Sender: TObject);
begin
  fUniDict := nil;
  // ������� ������ �� ����� ���� (�� ������� ����� �����)
  FormMain.DeleteButtonCloseWindow(Caption);
end;

procedure TfUniDict.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_F11:
      changeEditMode;
  end;
end;

procedure TfUniDict.changeEditMode;
begin
  editMode := not editMode;

  qrUniDictType.Filtered := not editMode;
  lbl3.Visible := editMode;
  lbl2.Visible := editMode;
  dbedtcode.Visible := editMode;
  dbmmoparam_description.Visible := editMode;
  grUniDictParam.Columns[1].Visible := editMode;
  dbnvgr1.Visible := editMode;
  gtUniDictType.ReadOnly := not editMode;
  grUniDictParam.ReadOnly := not editMode;
end;

procedure TfUniDict.grUniDictParamEnter(Sender: TObject);
begin
  dbnvgr1.DataSource := dsUniDict;
end;

procedure TfUniDict.gtUniDictTypeEnter(Sender: TObject);
begin
  dbnvgr1.DataSource := dsUniDictType;
end;

procedure TfUniDict.qrUniDictAfterPost(DataSet: TDataSet);
begin
  CloseOpen(qrUniDict);
end;

procedure TfUniDict.qrUniDictMONTHChange(Sender: TField);
begin
  qrSetParamValue.ParamByName('inPARAM_CODE').AsString := dbedtcode.Text;
  qrSetParamValue.ParamByName('inMONTH').AsInteger := Sender.Tag;
  qrSetParamValue.ParamByName('inYEAR').AsInteger := seYear.Value;
  qrSetParamValue.ParamByName('inValue').Value := Sender.Value;
  qrSetParamValue.ExecSQL;
end;

procedure TfUniDict.qrUniDictTypeAfterPost(DataSet: TDataSet);
begin
  CloseOpen(qrUniDictTypeLook);
  CloseOpen(qrUniDictType);
end;

procedure TfUniDict.qrUniDictTypeAfterScroll(DataSet: TDataSet);
begin
  seYearChange(Self);
  // ������� ����� ���� ������� �� ��������� �����
  if (qrUniDictType.FieldByName('unidicttype_first_month').Value = 1) and not editMode then
  begin
    // ��������
    grUniDictParam.Columns[2].Title.Caption := '��������';
    grUniDictParam.Columns[3].Visible := False;
    grUniDictParam.Columns[4].Visible := False;
    grUniDictParam.Columns[5].Visible := False;
    grUniDictParam.Columns[6].Visible := False;
    grUniDictParam.Columns[7].Visible := False;
    grUniDictParam.Columns[8].Visible := False;
    grUniDictParam.Columns[9].Visible := False;
    grUniDictParam.Columns[10].Visible := False;
    grUniDictParam.Columns[11].Visible := False;
    grUniDictParam.Columns[12].Visible := False;
    grUniDictParam.Columns[13].Visible := False;
  end
  else
  begin
    // ����������
    grUniDictParam.Columns[2].Title.Caption := '������';
    grUniDictParam.Columns[3].Visible := True;
    grUniDictParam.Columns[4].Visible := True;
    grUniDictParam.Columns[5].Visible := True;
    grUniDictParam.Columns[6].Visible := True;
    grUniDictParam.Columns[7].Visible := True;
    grUniDictParam.Columns[8].Visible := True;
    grUniDictParam.Columns[9].Visible := True;
    grUniDictParam.Columns[10].Visible := True;
    grUniDictParam.Columns[11].Visible := True;
    grUniDictParam.Columns[12].Visible := True;
    grUniDictParam.Columns[13].Visible := True;
  end;
end;

procedure TfUniDict.qrUniDictTypeUpdateError(ASender: TDataSet; AException: EFDException; ARow: TFDDatSRow;
  ARequest: TFDUpdateRequest; var AAction: TFDErrorAction);
begin
  ASender.Cancel;
  AAction := eaDefault;
  Application.MessageBox('������ ��� ������ �� ����� ���� �������', '��������������',
    MB_OK + MB_ICONWARNING + MB_TOPMOST);
end;

procedure TfUniDict.seYearChange(Sender: TObject);
begin
  qrUniDict.ParamByName('year').AsInteger := seYear.Value;
  qrUniDict.ParamByName('id_unidicttype').AsInteger := qrUniDictType.FieldByName('unidicttype_id').AsInteger;
  CloseOpen(qrUniDict);
end;

procedure TfUniDict.SetConstactorService;
var
  RecNo: Integer;
  ev: TDataSetNotifyEvent;
begin
  if not qrUniDictType.Active then
    Exit;
  RecNo := qrUniDictType.RecNo;
  qrUniDictType.DisableControls;
  try
    ev := qrUniDictType.AfterScroll;
    qrUniDictType.AfterScroll := nil;
    qrUniDictType.First;
    while not qrUniDictType.Eof do
    begin
      if qrUniDictType.FieldByName('unidicttype_id').AsInteger = 7 then
      begin
        RecNo := qrUniDictType.RecNo;
        Exit;
      end;
      qrUniDictType.Next
    end;
    qrUniDictType.AfterScroll := ev;
    qrUniDictType.RecNo := RecNo;
  finally
    qrUniDictType.EnableControls;
  end;
end;

end.
