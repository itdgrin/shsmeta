unit TranspPersSelect;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Clipbrd;

type
  TfTrPersSelect = class(TForm)
    Panel4: TPanel;
    btnSelect: TButton;
    btnCancel: TButton;
    rbTrPers1: TRadioButton;
    rbTrPers2: TRadioButton;
    rbTrPers3: TRadioButton;
    rbTrPers4: TRadioButton;
    rbTrPers5: TRadioButton;
    rbTrPers6: TRadioButton;
    rbTrPers7: TRadioButton;
    edtrbTrPers: TEdit;
    procedure btnCancelClick(Sender: TObject);
    procedure btnSelectClick(Sender: TObject);
    procedure edtrbTrPersKeyPress(Sender: TObject; var Key: Char);
    procedure edtrbTrPersExit(Sender: TObject);
    procedure rbTrPers7Click(Sender: TObject);
  private
    FSelectRb: Integer;
    FIdEstimate: Integer;
    FMatCode: string;
    FTranspPers: Extended;
  public
    constructor Create(AOwner: TComponent; AIdEstimate: Integer;
      AMatCode: string); reintroduce;
    property TranspPers: Extended read FTranspPers;
  end;

implementation

uses DataModule;

{$R *.dfm}

procedure TfTrPersSelect.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfTrPersSelect.btnSelectClick(Sender: TObject);
var
  TmpCode: string;
begin
  FTranspPers := 0;
  case FSelectRb of
    1:
      TmpCode := FMatCode;
    2:
      TmpCode := 'С101-0000';
    3:
      TmpCode := 'С201-0000';
    4:
      TmpCode := 'С300-0000';
    5:
      TmpCode := 'С501-0000';
    6:
      TmpCode := 'С000-0000';
    7:
    begin
      FTranspPers := StrToIntDef(edtrbTrPers.Text, 0);
      ModalResult := mrOk;
      Exit;
    end;
  end;

  DM.qrDifferent.Active := False;
  DM.qrDifferent.SQL.Clear;
  DM.qrDifferent.SQL.Add('SELECT GetTranspPers(:IdEstimate, :MatCode);');
  DM.qrDifferent.ParamByName('IdEstimate').Value := FIdEstimate;
  DM.qrDifferent.ParamByName('MatCode').Value := TmpCode;
  DM.qrDifferent.Active := True;
  if not DM.qrDifferent.Eof then
    FTranspPers := DM.qrDifferent.Fields[0].AsFloat;
  DM.qrDifferent.Active := False;

  ModalResult := mrOk;
end;

constructor TfTrPersSelect.Create(AOwner: TComponent; AIdEstimate: Integer;
      AMatCode: string);
begin
  inherited Create(AOwner);
  FIdEstimate := AIdEstimate;
  FMatCode := AMatCode;
  FSelectRb := 1;
end;

procedure TfTrPersSelect.edtrbTrPersExit(Sender: TObject);
var s: string;
begin
  if (Length(TEdit(Sender).Text) > 0) and
    (TEdit(Sender).Text[High(TEdit(Sender).Text)] = FormatSettings.DecimalSeparator) then
  begin
    s := TEdit(Sender).Text;
    SetLength(s, Length(s) - 1);
    TEdit(Sender).Text := s;
  end;

  if TEdit(Sender).Text = '' then
    TEdit(Sender).Text := '0';
end;

procedure TfTrPersSelect.edtrbTrPersKeyPress(Sender: TObject; var Key: Char);
var s: string;
    f: Double;
begin
  if CharInSet(Key, [^C, ^X, ^Z]) then
      Exit;

  if (Key = ^V) then
  begin
    //Проверка на корректность вставляемого текста
    if TryStrToFloat(Clipboard.AsText, f) then
    begin
      s :=
        Copy(TEdit(Sender).Text, 1,
          TEdit(Sender).SelStart) + Clipboard.AsText +
          Copy(TEdit(Sender).Text, TEdit(Sender).SelStart +
            TEdit(Sender).SelLength + 1, Length(TEdit(Sender).Text) -
            TEdit(Sender).SelStart - TEdit(Sender).SelLength);
      if TryStrToFloat(s, f) then
        Exit;
    end;
  end;

  case Key of
    '0'..'9',#8: ;
    '.',',':
     begin
       Key := FormatSettings.DecimalSeparator;
       if (pos(FormatSettings.DecimalSeparator, TEdit(Sender).Text) <> 0) or
          (TEdit(Sender).Text = '') then
        Key:= #0;
     end;
     else Key:= #0;
  end;
end;

procedure TfTrPersSelect.rbTrPers7Click(Sender: TObject);
begin
  FSelectRb := (Sender as TControl).Tag;
end;

end.
