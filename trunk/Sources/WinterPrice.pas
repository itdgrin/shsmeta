unit WinterPrice;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Vcl.ComCtrls, JvExComCtrls, JvDBTreeView, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, JvExDBGrids, JvDBGrid, Vcl.ExtCtrls, Vcl.Buttons,
  Vcl.Menus, Tools;

type
  TfWinterPrice = class(TForm)
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
    pmZnormativ: TPopupMenu;
    mAddZnormativ: TMenuItem;
    mDelZnormativ: TMenuItem;
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
    pmZnormativDetail: TPopupMenu;
    mAddZnormativDetail: TMenuItem;
    mDelZnormativDetail: TMenuItem;
    grChangeDate: TJvDBGrid;
    qrZnormChangeDate: TFDQuery;
    dsZnormChangeDate: TDataSource;
    qrTreeDataDEL_FLAG: TShortintField;
    pmZnormativOnDate: TPopupMenu;
    mAddDate: TMenuItem;
    mDelDate: TMenuItem;
    qrZnormativs_value: TFDQuery;
    dsZnormativs_value: TDataSource;
    dbnvgr1: TDBNavigator;
    chkShowDeleted: TCheckBox;
    mRepair: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnSelectClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure qrTreeDataCalcFields(DataSet: TDataSet);
    procedure dbedtNUMExit(Sender: TObject);
    procedure tmr1Timer(Sender: TObject);
    procedure qrTreeDataBeforeDelete(DataSet: TDataSet);
    procedure mDelZnormativClick(Sender: TObject);
    procedure mDelDateClick(Sender: TObject);
    procedure mAddDateClick(Sender: TObject);
    procedure qrTreeDataAfterScroll(DataSet: TDataSet);
    procedure qrZnormativs_valueNewRecord(DataSet: TDataSet);
    procedure qrZnormChangeDateBeforeDelete(DataSet: TDataSet);
    procedure chkShowDeletedClick(Sender: TObject);
    procedure mAddZnormativDetailClick(Sender: TObject);
    procedure qrZnormativs_detailNewRecord(DataSet: TDataSet);
    procedure mDelZnormativDetailClick(Sender: TObject);
    procedure qrZnormativs_detailBeforeDelete(DataSet: TDataSet);
    procedure tvEstimatesExpanded(Sender: TObject; Node: TTreeNode);
    procedure tvEstimatesExpanding(Sender: TObject; Node: TTreeNode; var AllowExpansion: Boolean);
  private

  public
    OutValue: Integer;
    Kind: TKindForm;
  end;

var
  fWinterPrice: TfWinterPrice;

implementation

uses DataModule;

{$R *.dfm}

procedure TfWinterPrice.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfWinterPrice.btnSelectClick(Sender: TObject);
begin
  OutValue := 0;
  if Application.MessageBox('�� ������������� ������ �������� ����. ������� ���������� � ��������� ��������?',
    'Application.Title', MB_OKCANCEL + MB_ICONQUESTION + MB_TOPMOST) = IDOK then
  begin
    OutValue := qrTreeData.FieldByName('ZNORMATIVS_ID').AsInteger;
    ModalResult := mrOk;
  end;
end;

procedure TfWinterPrice.chkShowDeletedClick(Sender: TObject);
begin
  qrTreeData.AfterScroll := nil;
  qrTreeData.ParamByName('SHOW_DELETED').AsBoolean := chkShowDeleted.Checked;
  CloseOpen(qrTreeData);
  qrTreeData.AfterScroll := qrTreeDataAfterScroll;
end;

procedure TfWinterPrice.dbedtNUMExit(Sender: TObject);
begin
  if qrTreeData.State in [dsEdit, dsInsert] then
    qrTreeData.Post;
end;

procedure TfWinterPrice.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Kind := kdNone;
end;

procedure TfWinterPrice.FormCreate(Sender: TObject);
begin
  Kind := kdNone;
  LoadDBGridSettings(grRates);
  LoadDBGridSettings(grChangeDate);
end;

procedure TfWinterPrice.FormShow(Sender: TObject);
begin
  case Kind of
    kdSelect:
      btnSelect.Visible := True;
  else
    btnSelect.Visible := False;
  end;
  CloseOpen(qrTreeData);
  CloseOpen(qrZnormativs_detail);
  CloseOpen(qrZnormChangeDate);
end;

procedure TfWinterPrice.mAddDateClick(Sender: TObject);
begin
  qrZnormChangeDate.Insert;
end;

procedure TfWinterPrice.mDelDateClick(Sender: TObject);
begin
  qrZnormChangeDate.Delete;
end;

procedure TfWinterPrice.mAddZnormativDetailClick(Sender: TObject);
begin
  qrZnormativs_detail.Insert;
end;

procedure TfWinterPrice.mDelZnormativClick(Sender: TObject);
begin
  qrTreeData.Delete;
end;

procedure TfWinterPrice.mDelZnormativDetailClick(Sender: TObject);
begin
  qrZnormativs_detail.Delete;
end;

procedure TfWinterPrice.qrTreeDataAfterScroll(DataSet: TDataSet);
begin
  if not CheckQrActiveEmpty(qrTreeData) or not CheckQrActiveEmpty(qrZnormChangeDate) then
    Exit;

  qrZnormativs_value.ParamByName('ZNORMATIVS_ID').AsInteger := qrTreeDataZNORMATIVS_ID.Value;
  qrZnormativs_value.ParamByName('ZNORMATIVS_ONDATE_ID').AsInteger := qrZnormChangeDate.FieldByName('ID')
    .AsInteger;
  CloseOpen(qrZnormativs_value);
end;

procedure TfWinterPrice.qrTreeDataBeforeDelete(DataSet: TDataSet);
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

procedure TfWinterPrice.qrTreeDataCalcFields(DataSet: TDataSet);
begin
  strngfldTreeDataNAME_EX_2.Value := strngfldTreeDataNUM.Value + ' ' + strngfldTreeDataNAME.Value;
end;

procedure TfWinterPrice.qrZnormativs_detailBeforeDelete(DataSet: TDataSet);
begin
  case Application.MessageBox('�� ������������� ������ ������� ������?', '���������� ������ ����������',
    MB_YESNO + MB_ICONQUESTION + MB_TOPMOST) of
    IDNO:
      begin
        Abort;
      end;
  end;
end;

procedure TfWinterPrice.qrZnormativs_detailNewRecord(DataSet: TDataSet);
begin
  qrZnormativs_detail.FieldByName('ZNORMATIVS_ID').AsInteger := qrTreeDataZNORMATIVS_ID.Value;
end;

procedure TfWinterPrice.qrZnormativs_valueNewRecord(DataSet: TDataSet);
begin
  qrZnormativs_value.FieldByName('ZNORMATIVS_ID').AsInteger := qrTreeDataZNORMATIVS_ID.Value;
  qrZnormativs_value.FieldByName('ZNORMATIVS_ONDATE_ID').AsInteger := qrZnormChangeDate.FieldByName('ID')
    .AsInteger;
end;

procedure TfWinterPrice.qrZnormChangeDateBeforeDelete(DataSet: TDataSet);
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

procedure TfWinterPrice.tmr1Timer(Sender: TObject);
begin
  // ��������� �������
  if qrTreeData.State in [dsEdit, dsInsert] then
    qrTreeData.Post;
end;

procedure TfWinterPrice.tvEstimatesExpanded(Sender: TObject; Node: TTreeNode);
begin
  qrTreeData.AfterScroll := qrTreeDataAfterScroll;
end;

procedure TfWinterPrice.tvEstimatesExpanding(Sender: TObject; Node: TTreeNode; var AllowExpansion: Boolean);
begin
  qrTreeData.AfterScroll := nil;
end;

end.
