unit WinterPrise;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Vcl.ComCtrls, JvExComCtrls, JvDBTreeView, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, JvExDBGrids, JvDBGrid, Vcl.ExtCtrls, Vcl.Buttons,
  Vcl.Menus, Tools;

type
  TfWinterPrise = class(TForm)
    qrTreeData: TFDQuery;
    dsTreeData: TDataSource;
    tvEstimates: TJvDBTreeView;
    grp1: TGroupBox;
    lblCoef: TLabel;
    lblCoefZP: TLabel;
    lblCoefZPMach: TLabel;
    dbedtCOEF: TDBEdit;
    dbedtCOEF_ZP: TDBEdit;
    dbedtCOEF_ZP_MACH: TDBEdit;
    grRates: TJvDBGrid;
    qrZnormativs_detail: TFDQuery;
    dsZnormativs_detail: TDataSource;
    pnl1: TPanel;
    btnClose: TBitBtn;
    btnSelect: TBitBtn;
    pm1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    dbedtNUM: TDBEdit;
    dbedtNAME: TDBEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    qrTreeDataZNORMATIVS_ID: TFDAutoIncField;
    strngfldTreeDataNUM: TStringField;
    strngfldTreeDataNAME: TStringField;
    qrTreeDataPARENT_ID: TIntegerField;
    strngfldTreeDataNAME_EX_2: TStringField;
    tmr1: TTimer;
    pm2: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    grChangeDate: TJvDBGrid;
    qrZnormChangeDate: TFDQuery;
    dsZnormChangeDate: TDataSource;
    qrTreeDataDEL_FLAG: TShortintField;
    pm3: TPopupMenu;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    qrZnormativs_value: TFDQuery;
    dsZnormativs_value: TDataSource;
    dbnvgr1: TDBNavigator;
    chk1: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnSelectClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure qrTreeDataCalcFields(DataSet: TDataSet);
    procedure dbedtNUMExit(Sender: TObject);
    procedure tmr1Timer(Sender: TObject);
    procedure qrTreeDataBeforeDelete(DataSet: TDataSet);
    procedure N2Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure qrTreeDataAfterScroll(DataSet: TDataSet);
    procedure qrZnormativs_valueNewRecord(DataSet: TDataSet);
    procedure qrZnormChangeDateBeforeDelete(DataSet: TDataSet);
    procedure chk1Click(Sender: TObject);
  private

  public
    OutValue: Integer;
    Kind: TKindForm;
  end;

var
  fWinterPrise: TfWinterPrise;

implementation

uses DataModule;

{$R *.dfm}

procedure TfWinterPrise.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfWinterPrise.btnSelectClick(Sender: TObject);
begin
  OutValue := 0;
  if Application.MessageBox('�� ������������� ������ �������� ����. ������� ���������� � ��������� ��������?',
    'Application.Title', MB_OKCANCEL + MB_ICONQUESTION + MB_TOPMOST) = IDOK then
  begin
    OutValue := qrTreeData.FieldByName('ZNORMATIVS_ID').AsInteger;
    ModalResult := mrOk;
  end;
end;

procedure TfWinterPrise.chk1Click(Sender: TObject);
begin
  qrTreeData.ParamByName('SHOW_DELETED').AsBoolean := chk1.Checked;
  CloseOpen(qrTreeData);
end;

procedure TfWinterPrise.dbedtNUMExit(Sender: TObject);
begin
  if qrTreeData.State in [dsEdit, dsInsert] then
    qrTreeData.Post;
end;

procedure TfWinterPrise.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Kind := kdNone;
end;

procedure TfWinterPrise.FormCreate(Sender: TObject);
begin
  Kind := kdNone;
  LoadDBGridSettings(grRates);
  LoadDBGridSettings(grChangeDate);
end;

procedure TfWinterPrise.FormShow(Sender: TObject);
begin
  case Kind of
    kdSelect:
      begin
        btnSelect.Visible := True;
      end;
  else
    begin
      btnSelect.Visible := False;
    end;
  end;
  CloseOpen(qrTreeData);
  CloseOpen(qrZnormativs_detail);
  CloseOpen(qrZnormChangeDate);
end;

procedure TfWinterPrise.MenuItem3Click(Sender: TObject);
begin
  qrZnormChangeDate.Insert;
end;

procedure TfWinterPrise.MenuItem4Click(Sender: TObject);
begin
  qrZnormChangeDate.Delete;
end;

procedure TfWinterPrise.N2Click(Sender: TObject);
begin
  qrTreeData.Delete;
end;

procedure TfWinterPrise.qrTreeDataAfterScroll(DataSet: TDataSet);
begin
  if not CheckQrActiveEmpty(qrTreeData) or not CheckQrActiveEmpty(qrZnormChangeDate) then
    Exit;

  qrZnormativs_value.ParamByName('ZNORMATIVS_ID').AsInteger := qrTreeDataZNORMATIVS_ID.Value;
  qrZnormativs_value.ParamByName('ZNORMATIVS_ONDATE_ID').AsInteger := qrZnormChangeDate.FieldByName('ID')
    .AsInteger;
  CloseOpen(qrZnormativs_value);
end;

procedure TfWinterPrise.qrTreeDataBeforeDelete(DataSet: TDataSet);
begin
  case Application.MessageBox('�� ������������� ������ ������� ������?', '���������� ������ ����������',
    MB_YESNO + MB_ICONQUESTION + MB_TOPMOST) of
    IDYES:
      begin
        qrTreeData.Edit;
        qrTreeDataDEL_FLAG.Value := 1;
        qrTreeData.Post;
      end;
  end;
  CloseOpen(qrTreeData);
  Abort;
end;

procedure TfWinterPrise.qrTreeDataCalcFields(DataSet: TDataSet);
begin
  strngfldTreeDataNAME_EX_2.Value := strngfldTreeDataNUM.Value + ' ' + strngfldTreeDataNAME.Value;
end;

procedure TfWinterPrise.qrZnormativs_valueNewRecord(DataSet: TDataSet);
begin
  qrZnormativs_value.FieldByName('ZNORMATIVS_ID').AsInteger := qrTreeDataZNORMATIVS_ID.Value;
  qrZnormativs_value.FieldByName('ZNORMATIVS_ONDATE_ID').AsInteger := qrZnormChangeDate.FieldByName('ID')
    .AsInteger;
end;

procedure TfWinterPrise.qrZnormChangeDateBeforeDelete(DataSet: TDataSet);
begin
  case Application.MessageBox('�� ������������� ������ ������� ������?', '���������� ������ ����������',
    MB_YESNO + MB_ICONQUESTION + MB_TOPMOST) of
    IDYES:
      begin
        qrZnormChangeDate.Edit;
        qrZnormChangeDate.FieldByName('DEL_FLAG').AsInteger := 1;
        qrZnormChangeDate.Post;
      end;
  end;
  CloseOpen(qrZnormChangeDate);
  Abort;
end;

procedure TfWinterPrise.tmr1Timer(Sender: TObject);
begin
  // ��������� �������
  if qrTreeData.State in [dsEdit, dsInsert] then
    qrTreeData.Post;
end;

end.
