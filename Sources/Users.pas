unit Users;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.DBCtrls, JvComponentBase,
  JvFormPlacement, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.Buttons, Vcl.ToolWin, Vcl.Mask, JvExComCtrls,
  JvDBTreeView, Tools, Vcl.Grids, Vcl.DBGrids, JvExDBGrids, JvDBGrid, JvComCtrls, JvCheckTreeView;

type
  TfUsers = class(TSmForm)
    pgc1: TPageControl;
    ts1: TTabSheet;
    ts2: TTabSheet;
    spl1: TSplitter;
    FormStorage: TJvFormStorage;
    qrUserGroup: TFDQuery;
    dsUserGroup: TDataSource;
    pnl1: TPanel;
    lbl1: TLabel;
    pnl2: TPanel;
    lbl2: TLabel;
    tlb3: TToolBar;
    btnAddGroup: TToolButton;
    btnCopyGroup: TToolButton;
    btnEditGroup: TToolButton;
    btnDelGroup: TToolButton;
    tlb1: TToolBar;
    btnAddUser: TToolButton;
    btnCopyUser: TToolButton;
    btnEditUser: TToolButton;
    btnDelUser: TToolButton;
    pnl3: TPanel;
    lbl3: TLabel;
    spl2: TSplitter;
    pnl4: TPanel;
    lbl4: TLabel;
    qrUser: TFDQuery;
    dsUser: TDataSource;
    pnl5: TPanel;
    lbl5: TLabel;
    dbedtUSER_GROUP_NAME: TDBEdit;
    pnl6: TPanel;
    lbl6: TLabel;
    dbedtUSER_NAME: TDBEdit;
    lbl7: TLabel;
    lbl8: TLabel;
    lbl9: TLabel;
    dblkcbbUSER_GROUP_ID: TDBLookupComboBox;
    dbedtUSER_PASS: TDBEdit;
    edt1: TEdit;
    qrTreeData: TFDQuery;
    dsTreeData: TDataSource;
    JvDBGrid1: TJvDBGrid;
    JvDBGrid2: TJvDBGrid;
    btnCancel: TToolButton;
    btnCancelGr: TToolButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnEditUserClick(Sender: TObject);
    procedure btnEditGroupClick(Sender: TObject);
    procedure qrUserAfterScroll(DataSet: TDataSet);
    procedure qrUserBeforePost(DataSet: TDataSet);
    procedure pgc1Changing(Sender: TObject; var AllowChange: Boolean);
    procedure qrUserAfterEdit(DataSet: TDataSet);
    procedure qrUserAfterPost(DataSet: TDataSet);
    procedure btnAddUserClick(Sender: TObject);
    procedure btnAddGroupClick(Sender: TObject);
    procedure btnCopyUserClick(Sender: TObject);
    procedure btnDelUserClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnDelGroupClick(Sender: TObject);
    procedure btnCopyGroupClick(Sender: TObject);
    procedure btnCancelGrClick(Sender: TObject);
    procedure qrUserGroupAfterPost(DataSet: TDataSet);
    procedure qrUserGroupAfterEdit(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fUsers: TfUsers;

implementation

{$R *.dfm}

uses Main, DataModule, GlobsAndConst;

procedure TfUsers.btnAddGroupClick(Sender: TObject);
begin
  qrUserGroup.Insert;
end;

procedure TfUsers.btnEditGroupClick(Sender: TObject);
begin
  pnl2.Enabled := not pnl2.Enabled;
  if qrUserGroup.State in [dsEdit, dsInsert] then
    qrUserGroup.Post
  else
    qrUserGroup.Edit;
end;

procedure TfUsers.btnAddUserClick(Sender: TObject);
begin
  qrUser.Insert;
end;

procedure TfUsers.btnCancelClick(Sender: TObject);
begin
  qrUser.Cancel;
end;

procedure TfUsers.btnCancelGrClick(Sender: TObject);
begin
  qrUserGroup.Cancel;
end;

procedure TfUsers.btnCopyGroupClick(Sender: TObject);
begin
  // Создание копии группы
  if Application.MessageBox(PChar('Создать копию группы ' + qrUserGroup.FieldByName('USER_GROUP_NAME')
    .AsString + '?'), PChar(Caption), MB_YESNO + MB_ICONQUESTION + MB_TOPMOST) = IDYES then
  begin
    FastExecSQL('CALL CopyUserGroup(:0);', VarArrayOf([qrUserGroup.FieldByName('USER_GROUP_ID').Value]));
    CloseOpen(qrUserGroup);
  end;
end;

procedure TfUsers.btnCopyUserClick(Sender: TObject);
begin
  // Создание копии пользователя
  if Application.MessageBox(PChar('Создать копию пользователя ' + qrUser.FieldByName('USER_NAME').AsString +
    '?'), PChar(Caption), MB_YESNO + MB_ICONQUESTION + MB_TOPMOST) = IDYES then
  begin
    FastExecSQL('CALL CopyUser(:0);', VarArrayOf([qrUser.FieldByName('USER_ID').Value]));
    CloseOpen(qrUser);
  end;
end;

procedure TfUsers.btnDelGroupClick(Sender: TObject);
begin
  // Создание копии группы
  if Application.MessageBox(PChar('Удалить группу ' + qrUserGroup.FieldByName('USER_GROUP_NAME').AsString +
    '?'), PChar(Caption), MB_YESNO + MB_ICONQUESTION + MB_TOPMOST) = IDYES then
  begin
    qrUserGroup.Delete;
  end;
end;

procedure TfUsers.btnDelUserClick(Sender: TObject);
begin
  // Создание копии пользователя
  if Application.MessageBox(PChar('Удалить пользователя ' + qrUser.FieldByName('USER_NAME').AsString + '?'),
    PChar(Caption), MB_YESNO + MB_ICONQUESTION + MB_TOPMOST) = IDYES then
  begin
    qrUser.Delete;
  end;
end;

procedure TfUsers.btnEditUserClick(Sender: TObject);
begin
  pnl4.Enabled := not pnl4.Enabled;
  if qrUser.State in [dsEdit, dsInsert] then
    qrUser.Post
  else
    qrUser.Edit;
end;

procedure TfUsers.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfUsers.FormCreate(Sender: TObject);
begin
  inherited;
  pgc1.ActivePageIndex := 0;
  CloseOpen(qrUserGroup);
  CloseOpen(qrUser);
end;

procedure TfUsers.FormDestroy(Sender: TObject);
begin
  fUsers := nil;
end;

procedure TfUsers.pgc1Changing(Sender: TObject; var AllowChange: Boolean);
begin
  { AllowChange := False;
    qrUser.CheckBrowseMode;
    qrUserGroup.CheckBrowseMode;
    AllowChange := True; }
  AllowChange := (qrUser.State in [dsBrowse]) and (qrUserGroup.State in [dsBrowse]);
end;

procedure TfUsers.qrUserAfterEdit(DataSet: TDataSet);
begin
  btnEditUser.Caption := 'Сохранить';
  btnEditUser.ImageIndex := 56;
  btnCancel.Visible := True;
  btnDelUser.Visible := False;
  btnAddUser.Visible := False;
  btnCopyUser.Visible := False;
end;

procedure TfUsers.qrUserAfterPost(DataSet: TDataSet);
begin
  btnEditUser.Caption := 'Редактировать';
  btnEditUser.ImageIndex := 44;
  btnCancel.Visible := False;
  btnDelUser.Visible := True;
  btnAddUser.Visible := True;
  btnCopyUser.Visible := True;
end;

procedure TfUsers.qrUserAfterScroll(DataSet: TDataSet);
begin
  edt1.Text := '';
end;

procedure TfUsers.qrUserBeforePost(DataSet: TDataSet);
begin
  if edt1.Text <> dbedtUSER_PASS.Text then
  begin
    Application.MessageBox('Ошибка повторного набора пароля!', 'Учетные записи пользователей',
      MB_OK + MB_ICONSTOP + MB_TOPMOST);
    edt1.SetFocus;
    Abort;
  end;
end;

procedure TfUsers.qrUserGroupAfterEdit(DataSet: TDataSet);
begin
  btnEditGroup.Caption := 'Сохранить';
  btnEditGroup.ImageIndex := 56;
  btnCancelGr.Visible := True;
  btnDelGroup.Visible := False;
  btnAddGroup.Visible := False;
  btnCopyGroup.Visible := False;
end;

procedure TfUsers.qrUserGroupAfterPost(DataSet: TDataSet);
begin
  btnEditGroup.Caption := 'Редактировать';
  btnEditGroup.ImageIndex := 44;
  btnCancelGr.Visible := False;
  btnDelGroup.Visible := True;
  btnAddGroup.Visible := True;
  btnCopyGroup.Visible := True;
end;

end.
