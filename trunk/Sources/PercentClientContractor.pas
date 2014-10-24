unit PercentClientContractor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls,
  Buttons;

type
  TFormPercentClientContractor = class(TForm)
    Bevel1: TBevel;
    ButtonSave: TButton;
    GroupBoxPercent: TGroupBox;
    LabelClient: TLabel;
    LabelContractor: TLabel;
    EditMCon: TEdit;
    EditMC: TEdit;
    LabelPMC: TLabel;
    LabelPTC: TLabel;
    EditTC: TEdit;
    EditTCon: TEdit;
    LabelPMCon: TLabel;
    LabelPTCon: TLabel;
    LabelMaterials: TLabel;
    LabelTransport: TLabel;
    SpeedButtonMaterial: TSpeedButton;
    SpeedButtonTransport: TSpeedButton;
    ButtonCancel: TButton;

    procedure ButtonCancelClick(Sender: TObject);
    procedure ButtonSaveClick(Sender: TObject);

    procedure EditChange(Sender: TObject);
    procedure EditTCChange(Sender: TObject);
    procedure EditKeyPress(Sender: TObject; var Key: Char);

    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);

    procedure SpeedButtonMaterialClick(Sender: TObject);
    procedure SpeedButtonTransportClick(Sender: TObject);

    procedure LabelMouseLeave(Sender: TObject);
    procedure LabelMouseEnter(Sender: TObject);

    procedure LabelClientClick(Sender: TObject);
    procedure LabelContractorClick(Sender: TObject);

  private

  public
    StrPercent: string;

  end;

var
  FormPercentClientContractor: TFormPercentClientContractor;

implementation

uses Main, DataModule, CalculationEstimate;

{$R *.dfm}
// ---------------------------------------------------------------------------------------------------------------------

procedure TFormPercentClientContractor.ButtonCancelClick(Sender: TObject);
begin
  Close;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormPercentClientContractor.ButtonSaveClick(Sender: TObject);
begin
  StrPercent := 'TrClient=' + EditTC.Text + '--MatClient=' + EditMC.Text + '--TrContractor=' + EditTCon.Text +
    '--MatContractor=' + EditMCon.Text + '--';

  Close;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormPercentClientContractor.EditChange(Sender: TObject);
begin
  with (Sender as TEdit) do
  begin
    if (Text = '') or (Text = #8) then
      Text := '0'
    else if Text <> #8 then
    begin
      if Tag = 1 then
        EditMCon.Text := IntToStr(100 - StrToInt(Text))
      else if Tag = 2 then
        EditMC.Text := IntToStr(100 - StrToInt(Text));
    end;

    SelStart := Length(Text);
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormPercentClientContractor.EditTCChange(Sender: TObject);
begin
  with (Sender as TEdit) do
  begin
    if (Text = '') or (Text = #8) then
      Text := '0'
    else if Text <> #8 then
    begin
      if Tag = 1 then
        EditTCon.Text := IntToStr(100 - StrToInt(Text))
      else if Tag = 2 then
        EditTC.Text := IntToStr(100 - StrToInt(Text));
    end;

    SelStart := Length(Text);
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormPercentClientContractor.EditKeyPress(Sender: TObject; var Key: Char);
var
  i: Integer;
  c: Char;
begin
  if not(Key in ['0' .. '9', #8]) then // Не цифра и не BackSpace
    Key := #0
  else if Key <> #8 then
  begin
    i := StrToInt((Sender as TEdit).Text + Key);

    if i > 100 then
    begin
      c := Key;
      Key := #0;
      (Sender as TEdit).Text := c;
    end;
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormPercentClientContractor.FormCreate(Sender: TObject);
begin
  with DM.ImageList1 do
  begin
    GetBitmap(0, SpeedButtonMaterial.Glyph);
    GetBitmap(0, SpeedButtonTransport.Glyph);
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormPercentClientContractor.FormShow(Sender: TObject);
begin
  Left := FormMain.Left + (FormMain.Width - Width) div 2;
  Top := FormMain.Top + (FormMain.Height - Height) div 2;

  EditMC.Text := '0';
  EditTC.Text := '0';
  EditMCon.Text := '100';
  EditTCon.Text := '100';

  if StrPercent <> '' then
    with FormCalculationEstimate do
    begin
      // EditMC.Text := IntToStr(GetMatClient(StrPercent));
      // EditMCon.Text := IntToStr(GetMatContractor(StrPercent));
      // EditTC.Text := IntToStr(GetTrClient(StrPercent));
      // EditTCon.Text := IntToStr(GetTrContractor(StrPercent));
    end;

  EditMC.SetFocus;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormPercentClientContractor.LabelMouseLeave(Sender: TObject);
begin
  with (Sender as TLabel) do
  begin
    Cursor := crDefault;
    Font.Style := Font.Style - [fsUnderline];
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormPercentClientContractor.LabelClientClick(Sender: TObject);
begin
  EditMC.Text := '100';
  EditTC.Text := '100';
  EditMCon.Text := '0';
  EditTCon.Text := '0';
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormPercentClientContractor.LabelContractorClick(Sender: TObject);
begin
  EditMC.Text := '0';
  EditTC.Text := '0';
  EditMCon.Text := '100';
  EditTCon.Text := '100';
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormPercentClientContractor.LabelMouseEnter(Sender: TObject);
begin
  with (Sender as TLabel) do
  begin
    Cursor := crHandPoint;
    Font.Style := Font.Style + [fsUnderline];
  end;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormPercentClientContractor.SpeedButtonMaterialClick(Sender: TObject);
var
  Str: string;
begin
  Str := EditMC.Text;
  EditMC.Text := EditMCon.Text;
  EditMCon.Text := Str;
end;

// ---------------------------------------------------------------------------------------------------------------------

procedure TFormPercentClientContractor.SpeedButtonTransportClick(Sender: TObject);
var
  Str: string;
begin
  Str := EditTC.Text;
  EditTC.Text := EditTCon.Text;
  EditTCon.Text := Str;
end;

// ---------------------------------------------------------------------------------------------------------------------

end.
