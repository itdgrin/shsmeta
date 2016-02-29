unit ImportExportModule;

interface

uses
  System.Classes, System.SysUtils, System.IOUtils, System.UITypes, System.Variants,
  Winapi.Windows, Vcl.Forms, Vcl.Dialogs, Vcl.Controls, Data.DB, XMLIntf, XMLDoc,
  ActiveX, FireDAC.Comp.DataSet, FireDAC.Comp.Client, GlobsAndConst;

type
  TFromRateRec = record
    LocalType,
    DataType,
    OldId,
    NewId: Integer;
  end;
  TFromRateArray = array of TFromRateRec;

  function ImportObject(const AFileName: string): Boolean;
  procedure ExportObject(const AIdObject: Integer; const AFileName: string);
  function PasteSmetaRow(const ASmClipArray: array of TSmClipRec;
    ADestSmID, AIterator, ASMSubType: Integer): Boolean;
  function GetCopySmeta(const ASoursSmetaID: Integer; const AIsAct: Boolean = False): boolean;

implementation

uses DataModule, Tools;

////////////////////////////////////////////////////////////////////////////////
function GetNewId(const ALastID: Variant; const AType: Integer;
  var AIdConvert: TIDConvertArray): Variant;
var i: Integer;
begin
  if VarIsNull(ALastID) or (ALastID = 0) then
  begin
    Result := ALastID;
    Exit;
  end;

  //Сперва проверяется на наличие этого ID
  for i := 0 to Length(AIdConvert[AType][0]) - 1 do
    if AIdConvert[AType][0][i] = ALastID then
    begin
      Result := AIdConvert[AType][1][i];
      Exit;
    end;

  DM.qrDifferent2.Active := False;
  DM.qrDifferent2.SQL.Text := 'SELECT GetNewID(:IDType)';
  DM.qrDifferent2.ParamByName('IDType').Value := AType;
  DM.qrDifferent2.Active := True;
  Result := DM.qrDifferent2.Fields[0].AsInteger;
  DM.qrDifferent2.Active := False;

  SetLength(AIdConvert[AType][0], Length(AIdConvert[AType][0]) + 1);
  SetLength(AIdConvert[AType][1], Length(AIdConvert[AType][1]) + 1);

  AIdConvert[AType][0][Length(AIdConvert[AType][0]) - 1] := ALastID;
  AIdConvert[AType][1][Length(AIdConvert[AType][1]) - 1] := Result;
end;

function GetNewManId(const ALastID: Variant; const AType: Integer;
  var AIdConvert: TManIDConvertArray; AInsertMode: Boolean): Variant;
var i: Integer;
begin
  if VarIsNull(ALastID) or (ALastID = 0) then
  begin
    Result := ALastID;
    Exit;
  end;

  //Сперва проверяется на наличие этого ID
  for i := 0 to Length(AIdConvert[AType][0]) - 1 do
    if AIdConvert[AType][0][i] = ALastID then
    begin
      Result := AIdConvert[AType][1][i];
      Exit;
    end;

  if AInsertMode then
  begin
    DM.qrDifferent2.Active := False;
    DM.qrDifferent2.SQL.Text := 'SELECT GetNewManualID(:IDType)';
    DM.qrDifferent2.ParamByName('IDType').Value := AType;
    DM.qrDifferent2.Active := True;
    Result := DM.qrDifferent2.Fields[0].AsInteger;
    DM.qrDifferent2.Active := False;

    SetLength(AIdConvert[AType][0], Length(AIdConvert[AType][0]) + 1);
    SetLength(AIdConvert[AType][1], Length(AIdConvert[AType][1]) + 1);

    AIdConvert[AType][0][Length(AIdConvert[AType][0]) - 1] := ALastID;
    AIdConvert[AType][1][Length(AIdConvert[AType][1]) - 1] := Result;
  end
  else
    Result := 0;
end;

//Формирует строку запроса
function GetQueryStr(AQuery: TFDQuery; ATabName: string): string;
var i: Integer;
    As1, As2: string;
begin
  As1 := '';
  As2 := '';
  for i := 0 to AQuery.Fields.Count - 1 do
  begin
    if As1 <> '' then As1 := As1 + ',';
    if As2 <> '' then As2 := As2 + ',';

    As1 := As1 + AQuery.Fields[i].FieldName.ToUpper;
    As2 := As2 + ':' + AQuery.Fields[i].FieldName.ToUpper;
  end;
  Result := 'Insert into ' + ATabName + ' (' + As1 + ') values (' + As2 + ')';
end;

////////////////////////////////////////////////////////////////////////////////
function ImportObject(const AFileName: string): Boolean;
var XML : IXMLDocument;
    MainNode, Node1, Node2: IXMLNode;
    i, j: Integer;
    IdConvert: TIDConvertArray;
    ManIdConvert: TManIDConvertArray;
    ds: char;
    AutoCommitValue: Boolean;
    IgnoreRates: TStringList;

  procedure GetStrAndExcec(ANode: IXMLNode; ATabName: string);
  var i: Integer;
      As1, As2: string;
      FieldName: string;
      FieldValue: Variant;
  begin
    As1 := '';
    As2 := '';
    for i := 0 to ANode.ChildNodes.Count - 1 do
    begin
      if As1 <> '' then As1 := As1 + ',';
      if As2 <> '' then As2 := As2 + ',';

      As1 := As1 + ANode.ChildNodes.Nodes[i].NodeName;
      As2 := As2 + ':' + ANode.ChildNodes.Nodes[i].NodeName;
    end;

    DM.qrDifferent.Params.Clear; //Без очистки случаются неожиданные глюки
    DM.qrDifferent.SQL.Text :=
      'Insert into ' + ATabName + ' (' + As1 + ') values (' + As2 + ')';

    for i := 0 to ANode.ChildNodes.Count - 1 do
    begin
      //Добавлено для удобства отладки
      FieldName := ANode.ChildNodes.Nodes[i].NodeName;
      FieldValue := ANode.ChildNodes.Nodes[i].NodeValue;

      DM.qrDifferent.ParamByName(FieldName).Value := FieldValue;
    end;

    DM.qrDifferent.ExecSQL;
  end;
begin
  Result := False;
  CoInitialize(nil);

  AutoCommitValue :=DM.qrDifferent.Transaction.Options.AutoCommit;
  DM.qrDifferent.Transaction.Options.AutoCommit := False;
  DM.qrDifferent.Active := False;

  IgnoreRates := TStringList.Create;
  ds := FormatSettings.DecimalSeparator;
  FormatSettings.DecimalSeparator := '.';
  DM.qrDifferent.Transaction.StartTransaction;
  try
    try
      XML := TXMLDocument.Create(nil);
      XML.LoadFromFile(AFileName);

      MainNode := XML.ChildNodes.FindNode('Object');
      if not Assigned(MainNode) then
        raise Exception.Create('Главная нода не найдена.');

      if Assigned(MainNode.ChildNodes.FindNode('Manual_Rates')) or
         Assigned(MainNode.ChildNodes.FindNode('Manual_Materials')) or
         Assigned(MainNode.ChildNodes.FindNode('Manual_Mechanizms')) or
         Assigned(MainNode.ChildNodes.FindNode('Manual_Devices')) or
         Assigned(MainNode.ChildNodes.FindNode('Manual_Units')) then
      begin
        if MessageBox(0, PChar('Объект "' + VarToStr(MainNode.Attributes['Name']) +
          '" содержит собственные справочные данные, загрузить их?'),
          'Импорт объекта',
          MB_ICONINFORMATION + MB_YESNO + MB_TASKMODAL) = mrYes then
        begin
          Node2 := MainNode.ChildNodes.FindNode('Manual_Units');
          if Assigned(Node2) then
            for j := 0 to Node2.ChildNodes.Count - 1 do
            begin
              Node1 := Node2.ChildNodes.Nodes[j];

              DM.qrDifferent2.Active := False;
              DM.qrDifferent2.SQL.Text :=
                'SELECT UNIT_ID from units where lower(UNIT_NAME) = lower(:NAME)';
              DM.qrDifferent2.ParamByName('NAME').Value :=
                Node1.ChildNodes.Nodes['UNIT_NAME'].NodeValue;
              DM.qrDifferent2.Active := True;
              if not DM.qrDifferent2.Eof then
              begin
                SetLength(ManIdConvert[C_MANID_UNIT][0],
                  Length(ManIdConvert[C_MANID_UNIT][0]) + 1);
                SetLength(ManIdConvert[C_MANID_UNIT][1],
                  Length(ManIdConvert[C_MANID_UNIT][1]) + 1);

                ManIdConvert[C_MANID_UNIT][0]
                  [Length(ManIdConvert[C_MANID_UNIT][0]) - 1] :=
                    Node1.ChildNodes.Nodes['UNIT_ID'].NodeValue;
                ManIdConvert[C_MANID_UNIT][1]
                  [Length(ManIdConvert[C_MANID_UNIT][1]) - 1] :=
                    DM.qrDifferent2.Fields[0].AsInteger;
                //Если найдеено совпадение, единица в бд не вносится
                Continue;
              end;
              DM.qrDifferent2.Active := False;

              Node1.ChildNodes.Nodes['UNIT_ID'].NodeValue :=
                GetNewManId(Node1.ChildNodes.Nodes['UNIT_ID'].NodeValue,
                  C_MANID_UNIT, ManIdConvert, True);
              GetStrAndExcec(Node1, 'units');
            end;

          Node2 := MainNode.ChildNodes.FindNode('Manual_Materials');
          if Assigned(Node2) then
            for j := 0 to Node2.ChildNodes.Count - 1 do
            begin
              Node1 := Node2.ChildNodes.Nodes[j];

              DM.qrDifferent2.Active := False;
              DM.qrDifferent2.SQL.Text :=
                'SELECT MATERIAL_ID from material where ' +
                '(MAT_CODE = :MAT_CODE) and (MAT_TYPE = :MAT_TYPE) and ' +
                '(MAT_NAME = :MAT_NAME)';
              DM.qrDifferent2.ParamByName('MAT_CODE').Value :=
                Node1.ChildNodes.Nodes['MAT_CODE'].NodeValue;
              DM.qrDifferent2.ParamByName('MAT_TYPE').Value :=
                Node1.ChildNodes.Nodes['MAT_TYPE'].NodeValue;
              DM.qrDifferent2.ParamByName('MAT_NAME').Value :=
                Node1.ChildNodes.Nodes['MAT_NAME'].NodeValue;
              DM.qrDifferent2.Active := True;
              if not DM.qrDifferent2.Eof then
              begin
                SetLength(ManIdConvert[C_MANID_MAT][0],
                  Length(ManIdConvert[C_MANID_MAT][0]) + 1);
                SetLength(ManIdConvert[C_MANID_MAT][1],
                  Length(ManIdConvert[C_MANID_MAT][1]) + 1);

                ManIdConvert[C_MANID_MAT][0]
                  [Length(ManIdConvert[C_MANID_MAT][0]) - 1] :=
                    Node1.ChildNodes.Nodes['MATERIAL_ID'].NodeValue;
                ManIdConvert[C_MANID_MAT][1]
                  [Length(ManIdConvert[C_MANID_MAT][1]) - 1] :=
                    DM.qrDifferent2.Fields[0].AsInteger;
                Continue;
              end;
              DM.qrDifferent2.Active := False;

              Node1.ChildNodes.Nodes['MATERIAL_ID'].NodeValue :=
                GetNewManId(Node1.ChildNodes.Nodes['MATERIAL_ID'].NodeValue,
                  C_MANID_MAT, ManIdConvert, True);
              GetStrAndExcec(Node1, 'material');
              Result := True;
            end;

          Node2 := MainNode.ChildNodes.FindNode('Manual_Mechanizms');
          if Assigned(Node2) then
            for j := 0 to Node2.ChildNodes.Count - 1 do
            begin
              Node1 := Node2.ChildNodes.Nodes[j];

              DM.qrDifferent2.Active := False;
              DM.qrDifferent2.SQL.Text :=
                'SELECT MECHANIZM_ID from mechanizm where ' +
                '(MECH_CODE = :MECH_CODE) and (MECH_NAME = :MECH_NAME)';
              DM.qrDifferent2.ParamByName('MECH_CODE').Value :=
                Node1.ChildNodes.Nodes['MECH_CODE'].NodeValue;
              DM.qrDifferent2.ParamByName('MECH_NAME').Value :=
                Node1.ChildNodes.Nodes['MECH_NAME'].NodeValue;
              DM.qrDifferent2.Active := True;
              if not DM.qrDifferent2.Eof then
              begin
                SetLength(ManIdConvert[C_MANID_MECH][0],
                  Length(ManIdConvert[C_MANID_MECH][0]) + 1);
                SetLength(ManIdConvert[C_MANID_MECH][1],
                  Length(ManIdConvert[C_MANID_MECH][1]) + 1);

                ManIdConvert[C_MANID_MECH][0]
                  [Length(ManIdConvert[C_MANID_MECH][0]) - 1] :=
                    Node1.ChildNodes.Nodes['MECHANIZM_ID'].NodeValue;
                ManIdConvert[C_MANID_MECH][1]
                  [Length(ManIdConvert[C_MANID_MECH][1]) - 1] :=
                    DM.qrDifferent2.Fields[0].AsInteger;
                Continue;
              end;
              DM.qrDifferent2.Active := False;

              Node1.ChildNodes.Nodes['MECHANIZM_ID'].NodeValue :=
                GetNewManId(Node1.ChildNodes.Nodes['MECHANIZM_ID'].NodeValue,
                  C_MANID_MECH, ManIdConvert, True);
              GetStrAndExcec(Node1, 'mechanizm');
              Result := True;
            end;

          Node2 := MainNode.ChildNodes.FindNode('Manual_Devices');
          if Assigned(Node2) then
            for j := 0 to Node2.ChildNodes.Count - 1 do
            begin
              Node1 := Node2.ChildNodes.Nodes[j];

              DM.qrDifferent2.Active := False;
              DM.qrDifferent2.SQL.Text :=
                'SELECT DEVICE_ID from devices where ' +
                '(DEVICE_CODE1 = :DEVICE_CODE1) and (NAME = :NAME)';
              DM.qrDifferent2.ParamByName('DEVICE_CODE1').Value :=
                Node1.ChildNodes.Nodes['DEVICE_CODE1'].NodeValue;
              DM.qrDifferent2.ParamByName('NAME').Value :=
                Node1.ChildNodes.Nodes['NAME'].NodeValue;
              DM.qrDifferent2.Active := True;
              if not DM.qrDifferent2.Eof then
              begin
                SetLength(ManIdConvert[C_MANID_DEV][0],
                  Length(ManIdConvert[C_MANID_DEV][0]) + 1);
                SetLength(ManIdConvert[C_MANID_DEV][1],
                  Length(ManIdConvert[C_MANID_DEV][1]) + 1);

                ManIdConvert[C_MANID_DEV][0]
                  [Length(ManIdConvert[C_MANID_DEV][0]) - 1] :=
                    Node1.ChildNodes.Nodes['DEVICE_ID'].NodeValue;
                ManIdConvert[C_MANID_DEV][1]
                  [Length(ManIdConvert[C_MANID_DEV][1]) - 1] :=
                    DM.qrDifferent2.Fields[0].AsInteger;
                Continue;
              end;
              DM.qrDifferent2.Active := False;

              Node1.ChildNodes.Nodes['DEVICE_ID'].NodeValue :=
                GetNewManId(Node1.ChildNodes.Nodes['DEVICE_ID'].NodeValue,
                  C_MANID_DEV, ManIdConvert, True);
              GetStrAndExcec(Node1, 'devices');
              Result := True;
            end;

          Node2 := MainNode.ChildNodes.FindNode('Manual_Rates');
          if Assigned(Node2) then
            for j := 0 to Node2.ChildNodes.Count - 1 do
            begin
              Node1 := Node2.ChildNodes.Nodes[j];

              DM.qrDifferent2.Active := False;
              DM.qrDifferent2.SQL.Text :=
                'SELECT NORMATIV_ID from normativg where ' +
                '(NORM_NUM = :NORM_NUM) and (NORM_CAPTION = :NORM_CAPTION) and ' +
                '(NORM_TYPE = :NORM_TYPE) and ' +
                '(normativ_directory_id = :normativ_directory_id) and ' +
                '(NORM_BASE = 1)';
              DM.qrDifferent2.ParamByName('NORM_NUM').Value :=
                Node1.ChildNodes.Nodes['NORM_NUM'].NodeValue;
              DM.qrDifferent2.ParamByName('NORM_CAPTION').Value :=
                Node1.ChildNodes.Nodes['NORM_CAPTION'].NodeValue;
              DM.qrDifferent2.ParamByName('NORM_TYPE').Value :=
                Node1.ChildNodes.Nodes['NORM_TYPE'].NodeValue;
              DM.qrDifferent2.ParamByName('normativ_directory_id').Value :=
                Node1.ChildNodes.Nodes['NORMATIV_DIRECTORY_ID'].NodeValue;
              DM.qrDifferent2.Active := True;
              if not DM.qrDifferent2.Eof then
              begin
                SetLength(ManIdConvert[C_MANID_NORM][0],
                  Length(ManIdConvert[C_MANID_NORM][0]) + 1);
                SetLength(ManIdConvert[C_MANID_NORM][1],
                  Length(ManIdConvert[C_MANID_NORM][1]) + 1);

                ManIdConvert[C_MANID_NORM][0]
                  [Length(ManIdConvert[C_MANID_NORM][0]) - 1] :=
                    Node1.ChildNodes.Nodes['NORMATIV_ID'].NodeValue;
                ManIdConvert[C_MANID_NORM][1]
                  [Length(ManIdConvert[C_MANID_NORM][1]) - 1] :=
                    DM.qrDifferent2.Fields[0].AsInteger;

                IgnoreRates.Add(Node1.ChildNodes.Nodes['NORMATIV_ID'].NodeValue);

                Continue;
              end;
              DM.qrDifferent2.Active := False;

              Node1.ChildNodes.Nodes['NORMATIV_ID'].NodeValue :=
                GetNewManId(Node1.ChildNodes.Nodes['NORMATIV_ID'].NodeValue,
                  C_MANID_NORM, ManIdConvert, True);
              GetStrAndExcec(Node1, 'normativg');
              Result := True;
            end;

          Node2 := MainNode.ChildNodes.FindNode('Manual_MatNorms');
          if Assigned(Node2) then
            for j := 0 to Node2.ChildNodes.Count - 1 do
            begin
              Node1 := Node2.ChildNodes.Nodes[j];

              if IgnoreRates.IndexOf(Node1.ChildNodes.Nodes['NORMATIV_ID'].NodeValue) > -1 then
                Continue;

              Node1.ChildNodes.Nodes['ID'].NodeValue :=
                GetNewManId(Node1.ChildNodes.Nodes['ID'].NodeValue,
                  C_MANID_NORM_MAT, ManIdConvert, True);

              Node1.ChildNodes.Nodes['NORMATIV_ID'].NodeValue :=
                GetNewManId(Node1.ChildNodes.Nodes['NORMATIV_ID'].NodeValue,
                  C_MANID_NORM, ManIdConvert, False);

              if Node1.ChildNodes.Nodes['MATERIAL_ID'].NodeValue > С_MANIDDELIMETER then
                GetNewManId(Node1.ChildNodes.Nodes['MATERIAL_ID'].NodeValue,
                  C_MANID_MAT, ManIdConvert, False);
              GetStrAndExcec(Node1, 'materialnorm');
            end;

          Node2 := MainNode.ChildNodes.FindNode('Manual_MechNorms');
          if Assigned(Node2) then
            for j := 0 to Node2.ChildNodes.Count - 1 do
            begin
              Node1 := Node2.ChildNodes.Nodes[j];

              if IgnoreRates.IndexOf(Node1.ChildNodes.Nodes['NORMATIV_ID'].NodeValue) > -1 then
                Continue;

              Node1.ChildNodes.Nodes['ID'].NodeValue :=
                GetNewManId(Node1.ChildNodes.Nodes['ID'].NodeValue,
                  C_MANID_NORM_MECH, ManIdConvert, True);

              Node1.ChildNodes.Nodes['NORMATIV_ID'].NodeValue :=
                GetNewManId(Node1.ChildNodes.Nodes['NORMATIV_ID'].NodeValue,
                  C_MANID_NORM, ManIdConvert, False);

              if Node1.ChildNodes.Nodes['MECHANIZM_ID'].NodeValue > С_MANIDDELIMETER then
                GetNewManId(Node1.ChildNodes.Nodes['MECHANIZM_ID'].NodeValue,
                  C_MANID_MECH, ManIdConvert, False);
              GetStrAndExcec(Node1, 'mechanizmnorm');
            end;

          Node2 := MainNode.ChildNodes.FindNode('Manual_NormWorks');
          if Assigned(Node2) then
            for j := 0 to Node2.ChildNodes.Count - 1 do
            begin
              Node1 := Node2.ChildNodes.Nodes[j];

              if IgnoreRates.IndexOf(Node1.ChildNodes.Nodes['NORMATIV_ID'].NodeValue) > -1 then
                Continue;

              Node1.ChildNodes.Nodes['ID'].NodeValue :=
                GetNewManId(Node1.ChildNodes.Nodes['ID'].NodeValue,
                  C_MANID_NORM_WORK, ManIdConvert, True);

              Node1.ChildNodes.Nodes['NORMATIV_ID'].NodeValue :=
                GetNewManId(Node1.ChildNodes.Nodes['NORMATIV_ID'].NodeValue,
                  C_MANID_NORM, ManIdConvert, False);

              GetStrAndExcec(Node1, 'normativwork');
            end;
        end;
      end;

      //загрузка объекта
      Node1 := MainNode.ChildNodes.FindNode('Data_object');

      if Pos(',', VarToStr(Node1.ChildNodes.Nodes['PER_CONTRACTOR'].NodeValue)) > 0 then
        raise Exception.Create('Запятая(,) неверный разделитель дробной части');

      Node1.ChildNodes.Nodes['OBJ_ID'].NodeValue :=
        GetNewId(Node1.ChildNodes.Nodes['OBJ_ID'].NodeValue, C_ID_OBJ, IdConvert);
      GetStrAndExcec(Node1, 'objcards');

      //загрузка смет и актов
      Node2 := MainNode.ChildNodes.FindNode('Smety');
      for j := 0 to Node2.ChildNodes.Count - 1 do
      begin
        Node1 := Node2.ChildNodes.Nodes[j];
        //замена IDшников
        Node1.ChildNodes.Nodes['SM_ID'].NodeValue :=
          GetNewId(Node1.ChildNodes.Nodes['SM_ID'].NodeValue, C_ID_SM, IdConvert);
        Node1.ChildNodes.Nodes['OBJ_ID'].NodeValue :=
          GetNewId(Node1.ChildNodes.Nodes['OBJ_ID'].NodeValue, C_ID_OBJ, IdConvert);
        Node1.ChildNodes.Nodes['SOURCE_ID'].NodeValue :=
          GetNewId(Node1.ChildNodes.Nodes['SOURCE_ID'].NodeValue, C_ID_SM, IdConvert);
        Node1.ChildNodes.Nodes['PARENT_ID'].NodeValue :=
          GetNewId(Node1.ChildNodes.Nodes['PARENT_ID'].NodeValue, C_ID_SM, IdConvert);

        GetStrAndExcec(Node1, 'smetasourcedata');
      end;

      //загрузка Data_row смет
      Node2 := MainNode.ChildNodes.FindNode('Smeta_data_row');
      if Assigned(Node2) then
        for j := 0 to Node2.ChildNodes.Count - 1 do
        begin
          Node1 := Node2.ChildNodes.Nodes[j];
          //замена IDшников
          Node1.ChildNodes.Nodes['ID'].NodeValue :=
            GetNewId(Node1.ChildNodes.Nodes['ID'].NodeValue, C_ID_DATA, IdConvert);
          Node1.ChildNodes.Nodes['SM_ID'].NodeValue :=
            GetNewId(Node1.ChildNodes.Nodes['SM_ID'].NodeValue, C_ID_SM, IdConvert);

          i := 0;
          case Node1.ChildNodes.Nodes['ID_TYPE_DATA'].NodeValue of
            1: i := C_ID_SMRAT;
            2: i := C_ID_SMMAT;
            3: i := C_ID_SMMEC;
            4: i := C_ID_SMDEV;
            5: i := C_ID_SMDUM;
            6, 7, 8, 9: i := C_ID_SMTR;
          end;

          if i > 0  then
            Node1.ChildNodes.Nodes['ID_TABLES'].NodeValue :=
              GetNewId(Node1.ChildNodes.Nodes['ID_TABLES'].NodeValue, i, IdConvert);

          GetStrAndExcec(Node1, 'data_row');
        end;

      //загрузка расценок
      Node2 := MainNode.ChildNodes.FindNode('Smeta_Rates');
      if Assigned(Node2) then
        for j := 0 to Node2.ChildNodes.Count - 1 do
        begin
          Node1 := Node2.ChildNodes.Nodes[j];
          Node1.ChildNodes.Nodes['SM_ID'].NodeValue :=
            GetNewId(Node1.ChildNodes.Nodes['SM_ID'].NodeValue, C_ID_SM, IdConvert);
          Node1.ChildNodes.Nodes['ID'].NodeValue :=
            GetNewId(Node1.ChildNodes.Nodes['ID'].NodeValue, C_ID_SMRAT, IdConvert);
          Node1.ChildNodes.Nodes['DATA_ROW_ID'].NodeValue :=
            GetNewId(Node1.ChildNodes.Nodes['DATA_ROW_ID'].NodeValue, C_ID_DATA, IdConvert);

          if Node1.ChildNodes.Nodes['RATE_ID'].NodeValue > С_MANIDDELIMETER then
            Node1.ChildNodes.Nodes['RATE_ID'].NodeValue :=
              GetNewManId(Node1.ChildNodes.Nodes['RATE_ID'].NodeValue,
                C_MANID_NORM, ManIdConvert, False);

          GetStrAndExcec(Node1, 'card_rate');
        end;

      //загрузка материалов
      Node2 := MainNode.ChildNodes.FindNode('Smeta_Materials');
      if Assigned(Node2) then
        for j := 0 to Node2.ChildNodes.Count - 1 do
        begin
          Node1 := Node2.ChildNodes.Nodes[j];
          Node1.ChildNodes.Nodes['SM_ID'].NodeValue :=
            GetNewId(Node1.ChildNodes.Nodes['SM_ID'].NodeValue, C_ID_SM, IdConvert);
          Node1.ChildNodes.Nodes['ID'].NodeValue :=
            GetNewId(Node1.ChildNodes.Nodes['ID'].NodeValue, C_ID_SMMAT, IdConvert);
          Node1.ChildNodes.Nodes['DATA_ROW_ID'].NodeValue :=
            GetNewId(Node1.ChildNodes.Nodes['DATA_ROW_ID'].NodeValue, C_ID_DATA, IdConvert);
          Node1.ChildNodes.Nodes['ID_CARD_RATE'].NodeValue :=
            GetNewId(Node1.ChildNodes.Nodes['ID_CARD_RATE'].NodeValue, C_ID_SMRAT, IdConvert);
          Node1.ChildNodes.Nodes['ID_REPLACED'].NodeValue :=
            GetNewId(Node1.ChildNodes.Nodes['ID_REPLACED'].NodeValue, C_ID_SMMAT, IdConvert);

          if Node1.ChildNodes.Nodes['MAT_ID'].NodeValue > С_MANIDDELIMETER then
            Node1.ChildNodes.Nodes['MAT_ID'].NodeValue :=
              GetNewManId(Node1.ChildNodes.Nodes['MAT_ID'].NodeValue,
                C_MANID_MAT, ManIdConvert, False);

          GetStrAndExcec(Node1, 'materialcard');
        end;

      //загрузка механизмов смет
      Node2 := MainNode.ChildNodes.FindNode('Smeta_Mechanizms');
      if Assigned(Node2) then
        for j := 0 to Node2.ChildNodes.Count - 1 do
        begin
          Node1 := Node2.ChildNodes.Nodes[j];
          Node1.ChildNodes.Nodes['SM_ID'].NodeValue :=
            GetNewId(Node1.ChildNodes.Nodes['SM_ID'].NodeValue, C_ID_SM, IdConvert);
          Node1.ChildNodes.Nodes['ID'].NodeValue :=
            GetNewId(Node1.ChildNodes.Nodes['ID'].NodeValue, C_ID_SMMEC, IdConvert);
          Node1.ChildNodes.Nodes['DATA_ROW_ID'].NodeValue :=
            GetNewId(Node1.ChildNodes.Nodes['DATA_ROW_ID'].NodeValue, C_ID_DATA, IdConvert);
          Node1.ChildNodes.Nodes['ID_CARD_RATE'].NodeValue :=
            GetNewId(Node1.ChildNodes.Nodes['ID_CARD_RATE'].NodeValue, C_ID_SMRAT, IdConvert);
          Node1.ChildNodes.Nodes['ID_REPLACED'].NodeValue :=
            GetNewId(Node1.ChildNodes.Nodes['ID_REPLACED'].NodeValue, C_ID_SMMEC, IdConvert);

          if Node1.ChildNodes.Nodes['MECH_ID'].NodeValue > С_MANIDDELIMETER then
            Node1.ChildNodes.Nodes['MECH_ID'].NodeValue :=
              GetNewManId(Node1.ChildNodes.Nodes['MECH_ID'].NodeValue,
                C_MANID_MECH, ManIdConvert, False);

          GetStrAndExcec(Node1, 'mechanizmcard');
        end;

      //загрузка оборудования смет
      Node2 := MainNode.ChildNodes.FindNode('Smeta_Devices');
      if Assigned(Node2) then
        for j := 0 to Node2.ChildNodes.Count - 1 do
        begin
          Node1 := Node2.ChildNodes.Nodes[j];
          Node1.ChildNodes.Nodes['SM_ID'].NodeValue :=
            GetNewId(Node1.ChildNodes.Nodes['SM_ID'].NodeValue, C_ID_SM, IdConvert);
          Node1.ChildNodes.Nodes['ID'].NodeValue :=
            GetNewId(Node1.ChildNodes.Nodes['ID'].NodeValue, C_ID_SMDEV, IdConvert);
          Node1.ChildNodes.Nodes['DATA_ROW_ID'].NodeValue :=
            GetNewId(Node1.ChildNodes.Nodes['DATA_ROW_ID'].NodeValue, C_ID_DATA, IdConvert);

          if Node1.ChildNodes.Nodes['DEVICE_ID'].NodeValue > С_MANIDDELIMETER then
            Node1.ChildNodes.Nodes['DEVICE_ID'].NodeValue :=
              GetNewManId(Node1.ChildNodes.Nodes['DEVICE_ID'].NodeValue,
                C_MANID_DEV, ManIdConvert, False);

          GetStrAndExcec(Node1, 'devicescard');
        end;

      //загрузка свалок смет
      Node2 := MainNode.ChildNodes.FindNode('Smeta_Dumps');
      if Assigned(Node2) then
        for j := 0 to Node2.ChildNodes.Count - 1 do
        begin
          Node1 := Node2.ChildNodes.Nodes[j];
          Node1.ChildNodes.Nodes['SM_ID'].NodeValue :=
            GetNewId(Node1.ChildNodes.Nodes['SM_ID'].NodeValue, C_ID_SM, IdConvert);
          Node1.ChildNodes.Nodes['ID'].NodeValue :=
            GetNewId(Node1.ChildNodes.Nodes['ID'].NodeValue, C_ID_SMDUM, IdConvert);
          Node1.ChildNodes.Nodes['DATA_ROW_ID'].NodeValue :=
            GetNewId(Node1.ChildNodes.Nodes['DATA_ROW_ID'].NodeValue, C_ID_DATA, IdConvert);
          GetStrAndExcec(Node1, 'dumpcard');
        end;

      //загрузка транспорта смет
      Node2 := MainNode.ChildNodes.FindNode('Smeta_Transps');
      if Assigned(Node2) then
        for j := 0 to Node2.ChildNodes.Count - 1 do
        begin
          Node1 := Node2.ChildNodes.Nodes[j];
          Node1.ChildNodes.Nodes['SM_ID'].NodeValue :=
            GetNewId(Node1.ChildNodes.Nodes['SM_ID'].NodeValue, C_ID_SM, IdConvert);
          Node1.ChildNodes.Nodes['ID'].NodeValue :=
            GetNewId(Node1.ChildNodes.Nodes['ID'].NodeValue, C_ID_SMTR, IdConvert);
          Node1.ChildNodes.Nodes['DATA_ROW_ID'].NodeValue :=
            GetNewId(Node1.ChildNodes.Nodes['DATA_ROW_ID'].NodeValue, C_ID_DATA, IdConvert);
          GetStrAndExcec(Node1, 'transpcard');
        end;

      //загрузка Data_estimate смет
      Node2 := MainNode.ChildNodes.FindNode('Smeta_calculation_coef');
      if Assigned(Node2) then
        for j := 0 to Node2.ChildNodes.Count - 1 do
        begin
          Node1 := Node2.ChildNodes.Nodes[j];
          //замена IDшников
          Node1.ChildNodes.Nodes['CALCULATION_COEF_ID'].NodeValue :=
            GetNewId(Node1.ChildNodes.Nodes['CALCULATION_COEF_ID'].NodeValue, C_ID_SMCOEF, IdConvert);
          Node1.ChildNodes.Nodes['SM_ID'].NodeValue :=
            GetNewId(Node1.ChildNodes.Nodes['SM_ID'].NodeValue, C_ID_SM, IdConvert);

          i := 0;
          case Node1.ChildNodes.Nodes['ID_TYPE_DATA'].NodeValue of
            1: i := C_ID_SMRAT;
            2: i := C_ID_SMMAT;
            3: i := C_ID_SMMEC;
            4: i := C_ID_SMDEV;
            5: i := C_ID_SMDUM;
            6, 7, 8, 9: i := C_ID_SMTR;
          end;

          if i > 0  then
            Node1.ChildNodes.Nodes['ID_OWNER'].NodeValue :=
              GetNewId(Node1.ChildNodes.Nodes['ID_OWNER'].NodeValue, i, IdConvert);

          Node1.ChildNodes.Nodes['ID_COEF'].NodeValue := null;

          GetStrAndExcec(Node1, 'calculation_coef');
        end;

      //загрузка Object_suppagreement
      Node2 := MainNode.ChildNodes.FindNode('Object_suppagreement');
      if Assigned(Node2) then
        for j := 0 to Node2.ChildNodes.Count - 1 do
        begin
          Node1 := Node2.ChildNodes.Nodes[j];

          Node1.ChildNodes.Nodes['supp_agreement_id'].NodeValue :=
            GetNewId(Node1.ChildNodes.Nodes['supp_agreement_id'].NodeValue, C_ID_SUPPAG, IdConvert);
          Node1.ChildNodes.Nodes['OBJ_ID'].NodeValue :=
            GetNewId(Node1.ChildNodes.Nodes['OBJ_ID'].NodeValue, C_ID_OBJ, IdConvert);

          GetStrAndExcec(Node1, 'supp_agreement');
        end;

      //загрузка Travel
      Node2 := MainNode.ChildNodes.FindNode('Travel');
      if Assigned(Node2) then
        for j := 0 to Node2.ChildNodes.Count - 1 do
        begin
          Node1 := Node2.ChildNodes.Nodes[j];

          Node1.ChildNodes.Nodes['TRAVEL_ID'].NodeValue :=
            GetNewId(Node1.ChildNodes.Nodes['TRAVEL_ID'].NodeValue, C_ID_TRAVEL, IdConvert);
          Node1.ChildNodes.Nodes['SM_ID'].NodeValue :=
            GetNewId(Node1.ChildNodes.Nodes['SM_ID'].NodeValue, C_ID_SM, IdConvert);

          GetStrAndExcec(Node1, 'travel');
        end;

      //загрузка Travel_work
      Node2 := MainNode.ChildNodes.FindNode('Travel_work');
      if Assigned(Node2) then
        for j := 0 to Node2.ChildNodes.Count - 1 do
        begin
          Node1 := Node2.ChildNodes.Nodes[j];

          Node1.ChildNodes.Nodes['TRAVEL_WORK_ID'].NodeValue :=
            GetNewId(Node1.ChildNodes.Nodes['TRAVEL_WORK_ID'].NodeValue, C_ID_TRWORK, IdConvert);
          Node1.ChildNodes.Nodes['SM_ID'].NodeValue :=
            GetNewId(Node1.ChildNodes.Nodes['SM_ID'].NodeValue, C_ID_SM, IdConvert);

          GetStrAndExcec(Node1, 'travel_work');
        end;

      //загрузка Worker_deartment
      Node2 := MainNode.ChildNodes.FindNode('Worker_deartment');
      if Assigned(Node2) then
        for j := 0 to Node2.ChildNodes.Count - 1 do
        begin
          Node1 := Node2.ChildNodes.Nodes[j];

          Node1.ChildNodes.Nodes['WORKER_DEPARTMENT_ID'].NodeValue :=
            GetNewId(Node1.ChildNodes.Nodes['WORKER_DEPARTMENT_ID'].NodeValue, C_ID_WORKDEP, IdConvert);
          Node1.ChildNodes.Nodes['SM_ID'].NodeValue :=
            GetNewId(Node1.ChildNodes.Nodes['SM_ID'].NodeValue, C_ID_SM, IdConvert);

          GetStrAndExcec(Node1, 'worker_deartment');
        end;

      //загрузка Summary_calculation
      Node2 := MainNode.ChildNodes.FindNode('Summary_calculation');
      if Assigned(Node2) then
        for j := 0 to Node2.ChildNodes.Count - 1 do
        begin
          Node1 := Node2.ChildNodes.Nodes[j];

          Node1.ChildNodes.Nodes['SM_ID'].NodeValue :=
            GetNewId(Node1.ChildNodes.Nodes['SM_ID'].NodeValue, C_ID_SM, IdConvert);

          GetStrAndExcec(Node1, 'summary_calculation');
        end;

      DM.qrDifferent.Transaction.Commit;
    except
      DM.qrDifferent.Transaction.Rollback;
      raise;
    end;
  finally
    FormatSettings.DecimalSeparator := ds;
    DM.qrDifferent.Transaction.Options.AutoCommit := AutoCommitValue;
    FreeAndNil(IgnoreRates);

    CoUninitialize;
  end;
end;

////////////////////////////////////////////////////////////////////////////////

procedure ExportObject(const AIdObject: Integer; const AFileName: string);
var XML : IXMLDocument;
    CurNode, Node1, Node2: IXMLNode;
    ds: char;
    TmpStr,
    NormIdStr,
    SmIdStr,
    UnitStr: string;
    UnitList: TStringList;
    i: Integer;

  procedure RowToNode(ANode: IXMLNode; AQ: TFDQuery);
  var i: Integer;
  begin
    for i := 0 to AQ.Fields.Count - 1 do
    begin
      try
        if (AQ.Fields[i].DataType in [ftFloat, ftCurrency, ftBCD, ftFMTBcd,
          ftExtended, ftSingle]) then
          ANode.ChildValues[AQ.Fields[i].FieldName.ToUpper] :=
            AQ.Fields[i].AsFloat
        else if AQ.Fields[i].DataType = ftDate then
          ANode.ChildValues[AQ.Fields[i].FieldName.ToUpper] :=
            FormatDateTime('yy/mm/dd', AQ.Fields[i].AsDateTime)
        else if AQ.Fields[i].DataType = ftString then
          ANode.ChildValues[AQ.Fields[i].FieldName.ToUpper] :=
            StripCharsInSet(AQ.Fields[i].AsString, [#0..#9,#11,#12,#14..#31,#127])
        else
          ANode.ChildValues[AQ.Fields[i].FieldName.ToUpper] :=
            AQ.Fields[i].Value;
      except
        on e: Exception do
        begin
          e.Message := e.Message + sLineBreak +
            '"' + AQ.Fields[i].AsString +'"';
          raise;
        end;
      end;
    end;
  end;
begin
  CoInitialize(nil);
  ds := FormatSettings.DecimalSeparator;
  FormatSettings.DecimalSeparator := '.';
  UnitList := TStringList.Create;
  try
    XML := TXMLDocument.Create(nil);
    XML.Active := True;
    XML.Encoding := 'unicode';
    XML.Version := '1.0';

    //Выгрузка информации об объекте
    CurNode := XML.AddChild('Object');
    DM.qrDifferent.Active := False;
    DM.qrDifferent.SQL.Text :=
      'Select * from objcards where obj_id = ' +  IntToStr(AIdObject);
    DM.qrDifferent.Active := True;
    if not DM.qrDifferent.IsEmpty then
    begin
      CurNode.SetAttributeNS('Type', '', 'Объект');
      CurNode.SetAttributeNS('Name', '', DM.qrDifferent.FieldByName('name').AsString);

      Node1 := CurNode.AddChild('Data_object');
      RowToNode(Node1, DM.qrDifferent);
    end
    else
    begin
      raise Exception.Create('Объект не найден.');
      Exit;
    end;

    SmIdStr := '';
    //Выгрузка информации об сметах и актах
    DM.qrDifferent.Active := False;
    DM.qrDifferent.SQL.Text := 'Select * from smetasourcedata where (obj_id = ' +
      IntToStr(AIdObject) + ') and (DELETED=0) order by SM_ID';
    DM.qrDifferent.Active := True;
    if not DM.qrDifferent.IsEmpty then
    begin
      Node1 := CurNode.AddChild('Smety');
      Node1.SetAttributeNS('Type', '', 'Сметы (акты)');
      while not DM.qrDifferent.Eof do
      begin
        if SmIdStr <> '' then
          SmIdStr := SmIdStr + ',';
        SmIdStr := SmIdStr + DM.qrDifferent.FieldByName('SM_ID').AsString;
        Node2 := Node1.AddChild('Smeta');

        if DM.qrDifferent.FieldByName('ACT').AsInteger = 1 then
          Node2.SetAttributeNS('Type', '', 'Акт')
        else
          Node2.SetAttributeNS('Type', '', 'Смета');

        Node2.SetAttributeNS('Name', '', DM.qrDifferent.FieldByName('name').AsString);
        RowToNode(Node2, DM.qrDifferent);
        DM.qrDifferent.Next;
      end;
    end
    else
    begin
      XML.SaveToFile(AFileName);
      Exit;
    end;

    TmpStr := '(SM_ID in (' + SmIdStr + '))';

    //Выгрузка информации из data_row
    DM.qrDifferent.Active := False;
    DM.qrDifferent.SQL.Text :=
      'Select * from data_row where ' + TmpStr + ' order by ID';
    DM.qrDifferent.Active := True;
    if not DM.qrDifferent.IsEmpty then
    begin
      Node1 := CurNode.AddChild('Smeta_data_row');
      Node1.SetAttributeNS('Type', '', 'Строки сметы (акта)');
      while not DM.qrDifferent.Eof do
      begin
        Node2 := Node1.AddChild('Line');
        RowToNode(Node2, DM.qrDifferent);
        DM.qrDifferent.Next;
      end;
    end;

    //Выгрузка информации об расценках
    DM.qrDifferent.Active := False;
    DM.qrDifferent.SQL.Text :=
      'Select * from card_rate where ' + TmpStr + ' order by ID';
    DM.qrDifferent.Active := True;
    if not DM.qrDifferent.IsEmpty then
    begin
      Node1 := CurNode.AddChild('Smeta_Rates');
      Node1.SetAttributeNS('Type', '', 'Расценки');
      while not DM.qrDifferent.Eof do
      begin
        Node2 := Node1.AddChild('Rate');
        Node2.SetAttributeNS('Type', '', 'Расценка');
        Node2.SetAttributeNS('CODE', '', DM.qrDifferent.FieldByName('RATE_CODE').AsString);
        RowToNode(Node2, DM.qrDifferent);
        DM.qrDifferent.Next;
      end;
    end;

    //Выгрузка информации об материалах
    DM.qrDifferent.Active := False;
    DM.qrDifferent.SQL.Text :=
      'Select * from materialcard where ' + TmpStr + ' order by ID';
    DM.qrDifferent.Active := True;
    if not DM.qrDifferent.IsEmpty then
    begin
      Node1 := CurNode.AddChild('Smeta_Materials');
      Node1.SetAttributeNS('Type', '', 'Материалы');
      while not DM.qrDifferent.Eof do
      begin
        Node2 := Node1.AddChild('Material');
        Node2.SetAttributeNS('Type', '', 'Материал');
        Node2.SetAttributeNS('CODE', '', DM.qrDifferent.FieldByName('MAT_CODE').AsString);
        RowToNode(Node2, DM.qrDifferent);
        DM.qrDifferent.Next;
      end;
    end;

    //Выгрузка информации об механизм
    DM.qrDifferent.Active := False;
    DM.qrDifferent.SQL.Text :=
      'Select * from mechanizmcard where ' + TmpStr + ' order by ID';
    DM.qrDifferent.Active := True;
    if not DM.qrDifferent.IsEmpty then
    begin
      Node1 := CurNode.AddChild('Smeta_Mechanizms');
      Node1.SetAttributeNS('Type', '', 'Механизмы');
      while not DM.qrDifferent.Eof do
      begin
        Node2 := Node1.AddChild('Mechanizm');
        Node2.SetAttributeNS('Type', '', 'Механизм');
        Node2.SetAttributeNS('CODE', '', DM.qrDifferent.FieldByName('MECH_CODE').AsString);
        RowToNode(Node2, DM.qrDifferent);
        DM.qrDifferent.Next;
      end;
    end;

    //Выгрузка информации об оборудовании
    DM.qrDifferent.Active := False;
    DM.qrDifferent.SQL.Text :=
      'Select * from devicescard where ' + TmpStr + ' order by ID';
    DM.qrDifferent.Active := True;
    if not DM.qrDifferent.IsEmpty then
    begin
      Node1 := CurNode.AddChild('Smeta_Devices');
      Node1.SetAttributeNS('Type', '', 'Оборудование');
      while not DM.qrDifferent.Eof do
      begin
        Node2 := Node1.AddChild('Device');
        Node2.SetAttributeNS('Type', '', 'Оборудование');
        Node2.SetAttributeNS('CODE', '', DM.qrDifferent.FieldByName('DEVICE_CODE').AsString);
        RowToNode(Node2, DM.qrDifferent);
        DM.qrDifferent.Next;
      end;
    end;

    //Выгрузка информации об свалках
    DM.qrDifferent.Active := False;
    DM.qrDifferent.SQL.Text :=
      'Select * from dumpcard where ' + TmpStr + ' order by ID';
    DM.qrDifferent.Active := True;
    if not DM.qrDifferent.IsEmpty then
    begin
      Node1 := CurNode.AddChild('Smeta_Dumps');
      Node1.SetAttributeNS('Type', '', 'Свалки');
      while not DM.qrDifferent.Eof do
      begin
        Node2 := Node1.AddChild('Dumpe');
        Node2.SetAttributeNS('Type', '', 'Свалка');
        Node2.SetAttributeNS('CODE', '', DM.qrDifferent.FieldByName('DUMP_CODE_JUST').AsString);
        RowToNode(Node2, DM.qrDifferent);
        DM.qrDifferent.Next;
      end;
    end;

    //Выгрузка информации об транспорте
    DM.qrDifferent.Active := False;
    DM.qrDifferent.SQL.Text :=
      'Select * from transpcard where ' + TmpStr + ' order by ID';
    DM.qrDifferent.Active := True;
    if not DM.qrDifferent.IsEmpty then
    begin
      Node1 := CurNode.AddChild('Smeta_Transps');
      Node1.SetAttributeNS('Type', '', 'Транспорт');
      while not DM.qrDifferent.Eof do
      begin
        Node2 := Node1.AddChild('Transp');
        Node2.SetAttributeNS('Type', '', 'Транспорт');
        Node2.SetAttributeNS('CODE', '', DM.qrDifferent.FieldByName('TRANSP_CODE_JUST').AsString);
        RowToNode(Node2, DM.qrDifferent);
        DM.qrDifferent.Next;
      end;
    end;

    //Выгрузка информации из calculation_coef
    DM.qrDifferent.Active := False;
    DM.qrDifferent.SQL.Text :=
      'Select * from calculation_coef where ' + TmpStr +
        ' order by calculation_coef_id';
    DM.qrDifferent.Active := True;
    if not DM.qrDifferent.IsEmpty then
    begin
      Node1 := CurNode.AddChild('Smeta_calculation_coef');
      Node1.SetAttributeNS('Type', '', 'Коэффициенты по смете (акту)');
      while not DM.qrDifferent.Eof do
      begin
        Node2 := Node1.AddChild('Line');
        RowToNode(Node2, DM.qrDifferent);
        DM.qrDifferent.Next;
      end;
    end;

    DM.qrDifferent.Active := False;
    DM.qrDifferent.SQL.Text :=
      'Select * from supp_agreement where (OBJ_ID = ' +
      IntToStr(AIdObject) + ') order by supp_agreement_id';
    DM.qrDifferent.Active := True;
    if not DM.qrDifferent.IsEmpty then
    begin
      Node1 := CurNode.AddChild('Object_suppagreement');
      Node1.SetAttributeNS('Type', '', 'Доп. соглашения');
      while not DM.qrDifferent.Eof do
      begin
        Node2 := Node1.AddChild('Line');
        RowToNode(Node2, DM.qrDifferent);
        DM.qrDifferent.Next;
      end;
    end;

    DM.qrDifferent.Active := False;
    DM.qrDifferent.SQL.Text :=
      'Select * from travel where ' + TmpStr + ' order by travel_id';
    DM.qrDifferent.Active := True;
    if not DM.qrDifferent.IsEmpty then
    begin
      Node1 := CurNode.AddChild('Travel');
      while not DM.qrDifferent.Eof do
      begin
        Node2 := Node1.AddChild('Line');
        RowToNode(Node2, DM.qrDifferent);
        DM.qrDifferent.Next;
      end;
    end;

    DM.qrDifferent.Active := False;
    DM.qrDifferent.SQL.Text :=
      'Select * from travel_work where ' + TmpStr + ' order by travel_work_id';
    DM.qrDifferent.Active := True;
    if not DM.qrDifferent.IsEmpty then
    begin
      Node1 := CurNode.AddChild('Travel_work');
      while not DM.qrDifferent.Eof do
      begin
        Node2 := Node1.AddChild('Line');
        RowToNode(Node2, DM.qrDifferent);
        DM.qrDifferent.Next;
      end;
    end;

    DM.qrDifferent.Active := False;
    DM.qrDifferent.SQL.Text :=
      'Select * from worker_deartment where ' + TmpStr + ' order by worker_department_id';
    DM.qrDifferent.Active := True;
    if not DM.qrDifferent.IsEmpty then
    begin
      Node1 := CurNode.AddChild('Worker_deartment');
      while not DM.qrDifferent.Eof do
      begin
        Node2 := Node1.AddChild('Line');
        RowToNode(Node2, DM.qrDifferent);
        DM.qrDifferent.Next;
      end;
    end;

    DM.qrDifferent.Active := False;
    DM.qrDifferent.SQL.Text :=
      'Select * from summary_calculation where ' + TmpStr ;
    DM.qrDifferent.Active := True;
    if not DM.qrDifferent.IsEmpty then
    begin
      Node1 := CurNode.AddChild('Summary_calculation');
      Node1.SetAttributeNS('Type', '', 'Суммации по смете (акту)');
      while not DM.qrDifferent.Eof do
      begin
        Node2 := Node1.AddChild('Line');
        RowToNode(Node2, DM.qrDifferent);
        DM.qrDifferent.Next;
      end;
    end;

    //Раздел содержащий информацию о собственных справочных данных
    NormIdStr := '';
    DM.qrDifferent.Active := False;
    DM.qrDifferent.SQL.Text :=
      'Select normativg.* from normativg, (Select distinct RATE_ID from ' +
        'card_rate where (BASE = 1) and ' + TmpStr +') as ratecard ' +
      'where normativg.NORMATIV_ID = ratecard.RATE_ID order by NORMATIV_ID';
    DM.qrDifferent.Active := True;
    if not DM.qrDifferent.IsEmpty then
    begin
      Node1 := CurNode.AddChild('Manual_Rates');
      Node1.SetAttributeNS('Type', '', 'Собственные справочные расценки');
      while not DM.qrDifferent.Eof do
      begin
        if NormIdStr <> '' then
          NormIdStr := NormIdStr + ',';
        NormIdStr := NormIdStr + DM.qrDifferent.FieldByName('NORMATIV_ID').AsString;

        if (DM.qrDifferent.FieldByName('UNIT_ID').AsInteger > С_MANIDDELIMETER) and
           (UnitList.IndexOf(DM.qrDifferent.FieldByName('UNIT_ID').AsString) = -1) then
          UnitList.Add(DM.qrDifferent.FieldByName('UNIT_ID').AsString);

        Node2 := Node1.AddChild('Rate');
        Node2.SetAttributeNS('CODE', '', DM.qrDifferent.FieldByName('NORM_NUM').AsString);
        RowToNode(Node2, DM.qrDifferent);
        DM.qrDifferent.Next;
      end;
    end;

    if NormIdStr <> '' then
    begin
      DM.qrDifferent.Active := False;
      DM.qrDifferent.SQL.Text :=
        'Select * from materialnorm where NORMATIV_ID in (' + NormIdStr + ') order by ID';
      DM.qrDifferent.Active := True;
      if not DM.qrDifferent.IsEmpty then
      begin
        Node1 := CurNode.AddChild('Manual_MatNorms');
        Node1.SetAttributeNS('Type', '', 'Материалы расценок');
        while not DM.qrDifferent.Eof do
        begin
          Node2 := Node1.AddChild('MatNorm');
          RowToNode(Node2, DM.qrDifferent);
          DM.qrDifferent.Next;
        end;
      end;

      DM.qrDifferent.Active := False;
      DM.qrDifferent.SQL.Text :=
        'Select * from mechanizmnorm where NORMATIV_ID in (' + NormIdStr + ') order by ID';
      DM.qrDifferent.Active := True;
      if not DM.qrDifferent.IsEmpty then
      begin
        Node1 := CurNode.AddChild('Manual_MechNorms');
        Node1.SetAttributeNS('Type', '', 'Механизмы расценок');
        while not DM.qrDifferent.Eof do
        begin
          Node2 := Node1.AddChild('MechNorm');
          RowToNode(Node2, DM.qrDifferent);
          DM.qrDifferent.Next;
        end;
      end;

      DM.qrDifferent.Active := False;
      DM.qrDifferent.SQL.Text :=
        'Select * from normativwork where NORMATIV_ID in (' + NormIdStr + ') order by ID';
      DM.qrDifferent.Active := True;
      if not DM.qrDifferent.IsEmpty then
      begin
        Node1 := CurNode.AddChild('Manual_NormWorks');
        Node1.SetAttributeNS('Type', '', 'Работы по расценкам');
        while not DM.qrDifferent.Eof do
        begin
          Node2 := Node1.AddChild('NormWork');
          RowToNode(Node2, DM.qrDifferent);
          DM.qrDifferent.Next;
        end;
      end;
    end
    else
      NormIdStr := '-1';

    DM.qrDifferent.Active := False;
    DM.qrDifferent.SQL.Text :=
      'Select material.* from material, (Select distinct MAT_ID from ' +
        'materialcard where (BASE = 1) and ' + TmpStr +') as matcard ' +
        'where material.MATERIAL_ID = matcard.MAT_ID ' +
      'union ' +
      'Select material.* from material, (Select MATERIAL_ID from ' +
        'materialnorm where (NORMATIV_ID in (' + NormIdStr + ')) and ' +
        '(MATERIAL_ID > ' + IntToStr(С_MANIDDELIMETER) + ')) as matnorm ' +
        'where material.MATERIAL_ID = matnorm.MATERIAL_ID ' +
      'order by MATERIAL_ID';
    DM.qrDifferent.Active := True;
    if not DM.qrDifferent.IsEmpty then
    begin
      Node1 := CurNode.AddChild('Manual_Materials');
      Node1.SetAttributeNS('Type', '', 'Собственные справочные материалы');
      while not DM.qrDifferent.Eof do
      begin
        if (DM.qrDifferent.FieldByName('UNIT_ID').AsInteger > С_MANIDDELIMETER) and
           (UnitList.IndexOf(DM.qrDifferent.FieldByName('UNIT_ID').AsString) = -1) then
          UnitList.Add(DM.qrDifferent.FieldByName('UNIT_ID').AsString);

        Node2 := Node1.AddChild('Material');
        Node2.SetAttributeNS('CODE', '', DM.qrDifferent.FieldByName('MAT_CODE').AsString);
        RowToNode(Node2, DM.qrDifferent);
        DM.qrDifferent.Next;
      end;
    end;

    DM.qrDifferent.Active := False;
    DM.qrDifferent.SQL.Text :=
      'Select mechanizm.* from mechanizm, (Select distinct MECH_ID from ' +
        'mechanizmcard where (BASE = 1) and ' + TmpStr +') as mechcard ' +
        'where mechanizm.MECHANIZM_ID = mechcard.MECH_ID ' +
      'union ' +
      'Select mechanizm.* from mechanizm, (Select MECHANIZM_ID from ' +
        'mechanizmnorm where (NORMATIV_ID in (' + NormIdStr + ')) and ' +
        '(MECHANIZM_ID > ' + IntToStr(С_MANIDDELIMETER) + ')) as matnorm ' +
        'where mechanizm.MECHANIZM_ID = matnorm.MECHANIZM_ID ' +
      'order by MECHANIZM_ID';
    DM.qrDifferent.Active := True;
    if not DM.qrDifferent.IsEmpty then
    begin
      Node1 := CurNode.AddChild('Manual_Mechanizms');
      Node1.SetAttributeNS('Type', '', 'Собственные справочные механизмы');
      while not DM.qrDifferent.Eof do
      begin
        if (DM.qrDifferent.FieldByName('UNIT_ID').AsInteger > С_MANIDDELIMETER) and
           (UnitList.IndexOf(DM.qrDifferent.FieldByName('UNIT_ID').AsString) = -1) then
          UnitList.Add(DM.qrDifferent.FieldByName('UNIT_ID').AsString);

        Node2 := Node1.AddChild('Mechanizm');
        Node2.SetAttributeNS('CODE', '', DM.qrDifferent.FieldByName('MECH_CODE').AsString);
        RowToNode(Node2, DM.qrDifferent);
        DM.qrDifferent.Next;
      end;
    end;

    DM.qrDifferent.Active := False;
    DM.qrDifferent.SQL.Text :=
      'Select devices.* from devices, (Select distinct DEVICE_ID from ' +
        'devicescard where (BASE = 1) and ' + TmpStr +') as davcard ' +
      'where devices.DEVICE_ID = davcard.DEVICE_ID order by DEVICE_ID';
    DM.qrDifferent.Active := True;
    if not DM.qrDifferent.IsEmpty then
    begin
      Node1 := CurNode.AddChild('Manual_Devices');
      Node1.SetAttributeNS('Type', '', 'Собственное справочное оборудование');
      while not DM.qrDifferent.Eof do
      begin
        if (DM.qrDifferent.FieldByName('UNIT').AsInteger > С_MANIDDELIMETER) and
           (UnitList.IndexOf(DM.qrDifferent.FieldByName('UNIT').AsString) = -1) then
          UnitList.Add(DM.qrDifferent.FieldByName('UNIT').AsString);

        Node2 := Node1.AddChild('Device');
        Node2.SetAttributeNS('CODE', '', DM.qrDifferent.FieldByName('DEVICE_CODE1').AsString);
        RowToNode(Node2, DM.qrDifferent);
        DM.qrDifferent.Next;
      end;
    end;
    DM.qrDifferent.Active := False;

    UnitStr := '';
    for i := 0 to UnitList.Count - 1 do
    begin
      if UnitStr <> '' then
        UnitStr := UnitStr + ',';
      UnitStr := UnitStr + UnitList[i];
    end;

    if UnitStr <> '' then
    begin
      DM.qrDifferent.SQL.Text :=
        'Select * from units where UNIT_ID in (' + UnitStr + ')';
      DM.qrDifferent.Active := True;
      if not DM.qrDifferent.IsEmpty then
      begin
        Node1 := CurNode.AddChild('Manual_Units');
        Node1.SetAttributeNS('Type', '', 'Собственные единицы измерения');
        while not DM.qrDifferent.Eof do
        begin
          Node2 := Node1.AddChild('Unit');
          RowToNode(Node2, DM.qrDifferent);
          DM.qrDifferent.Next;
        end;
      end;
    end;

    XML.SaveToFile(AFileName);
  finally
    DM.qrDifferent.Active := False;
    FreeAndNil(UnitList);
    FormatSettings.DecimalSeparator := ds;
    CoUninitialize;
  end;
end;
////////////////////////////////////////////////////////////////////////////////

//Выполняет вставку строки в смету
function PasteSmetaRow(const ASmClipArray: array of TSmClipRec;
  ADestSmID, AIterator, ASMSubType: Integer): Boolean;
var i, j, ii,
    ind,
    NewID, NewRowID, NewRowID1,
    TmpID_N, TmpID_O: Integer;
    E1820COUNT: Extended;
    IdConvert: TIDConvertArray;
    TmpTab: string;
    FromRateArray,
    AllFromRateArray: TFromRateArray;
    Flag: Boolean;
    SmClipRec: PSmClipRec;
    AutoCommitValue: Boolean;
    InsertCount: Integer;

    //Просто кусок кода который надо выполнить из разных мест
    procedure CoefEstimCalc(ASourceSmId, ADataType, AOldId, ANewId: Integer);
    var i: Integer;
    begin
      //Перенос коэффициентов связаных со строчкой
      DM.qrDifferent3.Active := False;
      DM.qrDifferent3.SQL.Text := 'Select * from calculation_coef' + TmpTab + ' where ' +
        '(SM_ID = ' + IntToStr(ASourceSmId) + ') and ' +
        '(id_type_data = ' + IntToStr(ADataType) + ') and ' +
        '(id_owner = ' + IntToStr(AOldId) + ')';
      DM.qrDifferent3.Active := True;
      DM.qrDifferent1.Params.Clear;
      if not DM.qrDifferent3.IsEmpty then
        DM.qrDifferent1.SQL.Text := GetQueryStr(DM.qrDifferent3, 'calculation_coef_temp');

      while not DM.qrDifferent3.Eof do
      begin
        for i := 0 to DM.qrDifferent3.Fields.Count - 1 do
        begin
          if UpperCase(DM.qrDifferent3.Fields[i].FieldName) = 'CALCULATION_COEF_ID' then
          begin
            DM.qrDifferent1.ParamByName(DM.qrDifferent3.Fields[i].FieldName).Value :=
              GetNewId(DM.qrDifferent3.Fields[i].Value, C_ID_SMCOEF, IdConvert);
            Continue;
          end;

          if UpperCase(DM.qrDifferent3.Fields[i].FieldName) = 'SM_ID' then
          begin
            DM.qrDifferent1.ParamByName(DM.qrDifferent3.Fields[i].FieldName).Value :=
              ADestSmID;
            Continue;
          end;

          if UpperCase(DM.qrDifferent3.Fields[i].FieldName) = 'ID_OWNER' then
          begin
            DM.qrDifferent1.ParamByName(DM.qrDifferent3.Fields[i].FieldName).Value :=
              ANewId;
            Continue;
          end;

          DM.qrDifferent1.ParamByName(DM.qrDifferent3.Fields[i].FieldName).Value :=
            DM.qrDifferent3.Fields[i].Value;
        end;
        DM.qrDifferent1.ExecSQL;
        DM.qrDifferent3.Next;
      end;
      DM.qrDifferent3.Active := False;

      //Пересчитываем добавленную строчку
      DM.qrDifferent1.SQL.Text := 'CALL CalcRowInRateTab(:ID, :TYPE, :CalcMode);';
      DM.qrDifferent1.ParamByName('ID').Value := ANewId;
      DM.qrDifferent1.ParamByName('TYPE').Value := ADataType;
      DM.qrDifferent1.ParamByName('CalcMode').Value := G_CALCMODE;
      DM.qrDifferent1.ExecSQL;

      DM.qrDifferent1.SQL.Text := 'CALL CalcCalculation(:SM_ID, :TypeData_ID, :OWNER_ID, 0);';
      DM.qrDifferent1.ParamByName('SM_ID').Value := ADestSmID;
      DM.qrDifferent1.ParamByName('TypeData_ID').Value := ADataType;
      DM.qrDifferent1.ParamByName('OWNER_ID').Value := ANewId;
      DM.qrDifferent1.ExecSQL;
    end;
begin
  Result := False;

  AutoCommitValue :=DM.qrDifferent1.Transaction.Options.AutoCommit;
  DM.qrDifferent1.Transaction.Options.AutoCommit := False;
  try
    try
      DM.qrDifferent1.UpdateTransaction.StartTransaction;
      InsertCount := 0;
      for ii := Low(ASmClipArray) to High(ASmClipArray) do
      begin
        SmClipRec := @ASmClipArray[ii];

        if ((SmClipRec.RateType = 0) and (ASMSubType = 2)) or
           ((SmClipRec.RateType = 1) and (ASMSubType = 1)) then
          Continue;

        //Расценка вставляется вместе с вынесенными, если при копировании
        //зацепили такие и вынесенные, то они игнорируюся, что-бы не вставлялись дублем
        Flag := False;
        for i := 0 to Length(AllFromRateArray) - 1 do
          if (SmClipRec.DataID = AllFromRateArray[i].OldId) and
             (SmClipRec.DataType = AllFromRateArray[i].DataType) then
          begin
            Flag := True;
            Break;
          end;
        if Flag then
          Continue;

        ind := 0;
        case SmClipRec.DataType of
          1: ind := C_ID_SMRAT;
          2: ind := C_ID_SMMAT;
          3: ind := C_ID_SMMEC;
          4: ind := C_ID_SMDEV;
          5: ind := C_ID_SMDUM;
          6, 7, 8, 9: ind := C_ID_SMTR;
          10, 11: ind := -1;
        end;

        if ind = 0 then
          raise Exception.Create('Неизвестный тип данных (' +
            IntToStr(SmClipRec.DataType) + ').');

        TmpTab := '_temp';

        //Поиск источника в БД
        if ind > 0 then
        begin
          DM.qrDifferent.SQL.Text :=
            'Select * from ' + CTabNameAndID[ind][0] + TmpTab + ' where ' +
            '(' + CTabNameAndID[ind][1] + ' = ' + IntToStr(SmClipRec.DataID) + ') and ' +
            '(SM_ID = ' + IntToStr(SmClipRec.SmID) + ')';
        end
        else
        begin
          DM.qrDifferent.SQL.Text :=
            'Select E1820_COUNT from data_row' + TmpTab + ' where ' +
            '(SM_ID = ' + IntToStr(SmClipRec.SmID) + ') and ' +
            '(ID_TYPE_DATA = ' + IntToStr(SmClipRec.DataType) + ')';
        end;
        DM.qrDifferent.Active := True;

        if DM.qrDifferent.IsEmpty then
        begin
          //Во временных таблицах данных нет, проверяем в постоянных
          DM.qrDifferent.Active := False;
          TmpTab := '';

          if ind > 0 then
          begin
            DM.qrDifferent.SQL.Text :=
              'Select * from ' + CTabNameAndID[ind][0] + TmpTab + ' where ' +
              '(' + CTabNameAndID[ind][1] + ' = ' + IntToStr(SmClipRec.DataID) + ') and ' +
              '(SM_ID = ' + IntToStr(SmClipRec.SmID) + ')';
          end
          else
          begin
            DM.qrDifferent.SQL.Text :=
              'Select E1820_COUNT from data_row' + TmpTab + ' where ' +
              '(SM_ID = ' + IntToStr(SmClipRec.SmID) + ') and ' +
              '(ID_TYPE_DATA = ' + IntToStr(SmClipRec.DataType) + ')';
          end;
          DM.qrDifferent.Active := True;

          if DM.qrDifferent.IsEmpty then
            raise Exception.Create('Источник отсутствует в БД.');
        end;

        NewID := 0;
        case SmClipRec.DataType of
        1, 2, 3, 4, 5, 6, 7, 8, 9:
        begin
          NewID := GetNewId(DM.qrDifferent.FieldByName('ID').Value,
           ind, IdConvert);
          NewRowID := GetNewId(DM.qrDifferent.FieldByName('DATA_ROW_ID').Value,
           C_ID_DATA, IdConvert);

          //Обновление нумерации в смете
          AIterator := UpdateIterator(ADestSmID, AIterator, 0);
          //Добавление новой строки
          DM.qrDifferent1.Params.Clear;
          DM.qrDifferent1.SQL.Text :=
            'INSERT INTO data_row_temp (ID, SM_ID, id_type_data, id_tables, NUM_ROW) ' +
            'VALUE (:ID, :SM_ID, :id_type_data, :id_tables, :NUM_ROW);';
          DM.qrDifferent1.ParamByName('ID').Value := NewRowID;
          DM.qrDifferent1.ParamByName('SM_ID').Value := ADestSmID;
          DM.qrDifferent1.ParamByName('id_type_data').Value := SmClipRec.DataType;
          DM.qrDifferent1.ParamByName('id_tables').Value := NewID;
          DM.qrDifferent1.ParamByName('NUM_ROW').Value := AIterator;
          DM.qrDifferent1.ExecSQL;

          DM.qrDifferent1.Params.Clear;
          DM.qrDifferent1.SQL.Text :=
            GetQueryStr(DM.qrDifferent, CTabNameAndID[ind][0] + '_temp');

          for i := 0 to DM.qrDifferent.Fields.Count - 1 do
          begin
            if UpperCase(DM.qrDifferent.Fields[i].FieldName) = 'ID' then
            begin
              DM.qrDifferent1.ParamByName('ID').Value := NewID;
              Continue;
            end;

            if UpperCase(DM.qrDifferent.Fields[i].FieldName) = 'SM_ID' then
            begin
              DM.qrDifferent1.ParamByName('SM_ID').Value := ADestSmID;
              Continue;
            end;

            if UpperCase(DM.qrDifferent.Fields[i].FieldName) = 'DATA_ROW_ID' then
            begin
              DM.qrDifferent1.ParamByName('DATA_ROW_ID').Value := NewRowID;
              Continue;
            end;

            if SmClipRec.DataType in [2, 3] then
            begin
              //Гасим все специфические флаги
              if (UpperCase(DM.qrDifferent.Fields[i].FieldName) = 'ID_CARD_RATE') then
              begin
                DM.qrDifferent1.ParamByName(DM.qrDifferent.Fields[i].FieldName).Value := Null;
                Continue;
              end;

              if (UpperCase(DM.qrDifferent.Fields[i].FieldName) = 'ID_REPLACED') or
                 (UpperCase(DM.qrDifferent.Fields[i].FieldName) = 'REPLACED') or
                 (UpperCase(DM.qrDifferent.Fields[i].FieldName) = 'FROM_RATE') or
                 (UpperCase(DM.qrDifferent.Fields[i].FieldName) = 'CONS_REPLASED') or
                 (UpperCase(DM.qrDifferent.Fields[i].FieldName) = 'ADDED') or
                 (UpperCase(DM.qrDifferent.Fields[i].FieldName) = 'DELETED') then
              begin
                DM.qrDifferent1.ParamByName(DM.qrDifferent.Fields[i].FieldName).Value := 0;
                Continue;
              end;

              if (SmClipRec.DataType = 2) and
                 (UpperCase(DM.qrDifferent.Fields[i].FieldName) = 'CONSIDERED') then
              begin
                DM.qrDifferent1.ParamByName(DM.qrDifferent.Fields[i].FieldName).Value := 1;
                Continue;
              end;
            end;
            DM.qrDifferent1.ParamByName(DM.qrDifferent.Fields[i].FieldName).Value :=
              DM.qrDifferent.Fields[i].Value;
          end;
          DM.qrDifferent1.ExecSQL;
        end;
        10,11:
        begin
          NewID := 0;
          NewRowID := GetNewId(DM.qrDifferent.FieldByName('DATA_ROW_ID').Value,
           C_ID_DATA, IdConvert);

          E1820COUNT := DM.qrDifferent.Fields[0].Value;
          DM.qrDifferent.Active := False;
          //Проверка на то, что 10 или 11 уже есть в смете
          DM.qrDifferent.SQL.Text :=
            'Select E1820_COUNT from data_row' + TmpTab + ' where ' +
            '(SM_ID = ' + IntToStr(ADestSmID) + ') and ' +
            '(ID_TYPE_DATA = ' + IntToStr(SmClipRec.DataType) + ')';
          DM.qrDifferent.Active := True;
          if not DM.qrDifferent.IsEmpty then
          begin
            if SmClipRec.DataType = 10 then
              raise Exception.Create('ЕТ18 уже присутствует с смете.')
            else
              raise Exception.Create('ЕТ20 уже присутствует с смете.');
          end;
          DM.qrDifferent.Active := False;

          //Добавление новой строки
          DM.qrDifferent1.SQL.Text :=
            'INSERT INTO data_row_temp (ID, SM_ID, id_type_data, ' +
            'E1820_COUNT, NUM_ROW) VALUE (:ID, :SM_ID, :id_type_data, ' +
            ':E1820_COUNT, :NUM_ROW);';
          DM.qrDifferent1.ParamByName('ID').Value := NewRowID;
          DM.qrDifferent1.ParamByName('SM_ID').Value := ADestSmID;
          DM.qrDifferent1.ParamByName('id_type_data').Value := SmClipRec.DataType;
          DM.qrDifferent1.ParamByName('E1820_COUNT').Value := E1820COUNT;
          //Топятся в конец сметы
          if SmClipRec.DataType = 10 then
              DM.qrDifferent1.ParamByName('NUM_ROW').Value := C_ET18ITER
          else
              DM.qrDifferent1.ParamByName('NUM_ROW').Value := C_ET20ITER;
          DM.qrDifferent1.ExecSQL;
        end;
        end;

        //Для расценок копирует материалы и механизмы
        if SmClipRec.DataType = 1 then
        begin
          SetLength(FromRateArray, 0);

          DM.qrDifferent.Active := False;
          DM.qrDifferent.SQL.Text :=
            'Select * from materialcard' + TmpTab + ' where ' +
              '(ID_CARD_RATE = ' + IntToStr(SmClipRec.DataID) + ') and ' +
              '(SM_ID = ' + IntToStr(SmClipRec.SmID) + ') ORDER BY ID';
          DM.qrDifferent.Active := True;
          while not DM.qrDifferent.Eof do
          begin
            TmpID_O := DM.qrDifferent.FieldByName('ID').Value;
            TmpID_N := GetNewId(TmpID_O, C_ID_SMMAT, IdConvert);

            //Если материал в расценке то NewRowID1 будут равен NewRowID
            NewRowID1 := GetNewId(DM.qrDifferent.FieldByName('DATA_ROW_ID').Value,
              C_ID_DATA, IdConvert);

            if DM.qrDifferent.FieldByName('FROM_RATE').Value = 1 then
            begin
                Inc(AIterator);
                //Обновление нумерации в смете
                AIterator := UpdateIterator(ADestSmID, AIterator, 0);
                //Добавление новой строки
                DM.qrDifferent1.Params.Clear;
                DM.qrDifferent1.SQL.Text :=
                  'INSERT INTO data_row_temp (ID, SM_ID, id_type_data, id_tables, NUM_ROW) ' +
                  'VALUE (:ID, :SM_ID, :id_type_data, :id_tables, :NUM_ROW);';
                DM.qrDifferent1.ParamByName('ID').Value := NewRowID1;
                DM.qrDifferent1.ParamByName('SM_ID').Value := ADestSmID;
                DM.qrDifferent1.ParamByName('id_type_data').Value := 2;
                DM.qrDifferent1.ParamByName('id_tables').Value := TmpID_N;
                DM.qrDifferent1.ParamByName('NUM_ROW').Value := AIterator;
                DM.qrDifferent1.ExecSQL;

                j := Length(AllFromRateArray);
                SetLength(AllFromRateArray, j + 1);
                AllFromRateArray[j].DataType := 2;
                AllFromRateArray[j].OldId := TmpID_O;
            end;

            DM.qrDifferent1.Params.Clear;
            DM.qrDifferent1.SQL.Text := GetQueryStr(DM.qrDifferent, 'materialcard_temp');

            for i := 0 to DM.qrDifferent.Fields.Count - 1 do
            begin
              if UpperCase(DM.qrDifferent.Fields[i].FieldName) = 'ID' then
              begin
                DM.qrDifferent1.ParamByName('ID').Value := TmpID_N;
                Continue;
              end;

              if UpperCase(DM.qrDifferent.Fields[i].FieldName) = 'SM_ID' then
              begin
                DM.qrDifferent1.ParamByName('SM_ID').Value := ADestSmID;
                Continue;
              end;

              if UpperCase(DM.qrDifferent.Fields[i].FieldName) = 'DATA_ROW_ID' then
              begin
                DM.qrDifferent1.ParamByName('DATA_ROW_ID').Value := NewRowID1;
                Continue;
              end;

              if (UpperCase(DM.qrDifferent.Fields[i].FieldName) = 'ID_CARD_RATE') then
              begin
                DM.qrDifferent1.ParamByName('ID_CARD_RATE').Value := NewID;
                Continue;
              end;

              if (UpperCase(DM.qrDifferent.Fields[i].FieldName) = 'ID_REPLACED') then
              begin
                DM.qrDifferent1.ParamByName(DM.qrDifferent.Fields[i].FieldName).Value :=
                  GetNewId(DM.qrDifferent.Fields[i].Value, C_ID_SMMAT, IdConvert);
                Continue;
              end;

              DM.qrDifferent1.ParamByName(DM.qrDifferent.Fields[i].FieldName).Value :=
                DM.qrDifferent.Fields[i].Value;
            end;
            DM.qrDifferent1.ExecSQL;

            if DM.qrDifferent.FieldByName('FROM_RATE').Value = 1 then
              CoefEstimCalc(ADestSmID, 2, TmpID_O, TmpID_N);

            DM.qrDifferent.Next;
          end;
          DM.qrDifferent.Active := False;

          DM.qrDifferent.SQL.Text := 'Select * from mechanizmcard' + TmpTab + ' where ' +
            '(ID_CARD_RATE = ' + IntToStr(SmClipRec.DataID) + ') and ' +
            '(SM_ID = ' + IntToStr(SmClipRec.SmID) + ') ORDER BY ID';
          DM.qrDifferent.Active := True;
          while not DM.qrDifferent.Eof do
          begin
            TmpID_O := DM.qrDifferent.FieldByName('ID').Value;
            TmpID_N := GetNewId(TmpID_O, C_ID_SMMEC, IdConvert);

            //Если материал в расценке то NewRowID1 будут равен NewRowID
            NewRowID1 := GetNewId(DM.qrDifferent.FieldByName('DATA_ROW_ID').Value,
              C_ID_DATA, IdConvert);

            if DM.qrDifferent.FieldByName('FROM_RATE').Value = 1 then
            begin
                Inc(AIterator);
                //Обновление нумерации в смете
                AIterator := UpdateIterator(ADestSmID, AIterator, 0);
                //Добавление новой строки
                DM.qrDifferent1.Params.Clear;
                DM.qrDifferent1.SQL.Text :=
                  'INSERT INTO data_row_temp (ID, SM_ID, id_type_data, id_tables, NUM_ROW) ' +
                  'VALUE (:ID, :SM_ID, :id_type_data, :id_tables, :NUM_ROW);';
                DM.qrDifferent1.ParamByName('ID').Value := NewRowID1;
                DM.qrDifferent1.ParamByName('SM_ID').Value := ADestSmID;
                DM.qrDifferent1.ParamByName('id_type_data').Value := 3;
                DM.qrDifferent1.ParamByName('id_tables').Value := TmpID_N;
                DM.qrDifferent1.ParamByName('NUM_ROW').Value := AIterator;
                DM.qrDifferent1.ExecSQL;

                j := Length(AllFromRateArray);
                SetLength(AllFromRateArray, j + 1);
                AllFromRateArray[j].DataType := 3;
                AllFromRateArray[j].OldId := TmpID_O;
            end;

            DM.qrDifferent1.Params.Clear;
            DM.qrDifferent1.SQL.Text := GetQueryStr(DM.qrDifferent, 'mechanizmcard_temp');
            for i := 0 to DM.qrDifferent.Fields.Count - 1 do
            begin
              if UpperCase(DM.qrDifferent.Fields[i].FieldName) = 'ID' then
              begin
                DM.qrDifferent1.ParamByName('ID').Value := TmpID_N;
                Continue;
              end;

              if UpperCase(DM.qrDifferent.Fields[i].FieldName) = 'SM_ID' then
              begin
                DM.qrDifferent1.ParamByName('SM_ID').Value := ADestSmID;
                Continue;
              end;

              if UpperCase(DM.qrDifferent.Fields[i].FieldName) = 'DATA_ROW_ID' then
              begin
                DM.qrDifferent1.ParamByName('DATA_ROW_ID').Value := NewRowID1;
                Continue;
              end;

              if (UpperCase(DM.qrDifferent.Fields[i].FieldName) = 'ID_CARD_RATE') then
              begin
                DM.qrDifferent1.ParamByName('ID_CARD_RATE').Value := NewID;
                Continue;
              end;

              //Гасим все специфические флаги
              if (UpperCase(DM.qrDifferent.Fields[i].FieldName) = 'ID_CARD_RATE') then
              begin
                DM.qrDifferent1.ParamByName(DM.qrDifferent.Fields[i].FieldName).Value :=
                  NewID;
                Continue;
              end;

              if (UpperCase(DM.qrDifferent.Fields[i].FieldName) = 'ID_REPLACED') then
              begin
                DM.qrDifferent1.ParamByName(DM.qrDifferent.Fields[i].FieldName).Value :=
                  GetNewId(DM.qrDifferent.Fields[i].Value, C_ID_SMMEC, IdConvert);
                Continue;
              end;

              DM.qrDifferent1.ParamByName(DM.qrDifferent.Fields[i].FieldName).Value :=
                DM.qrDifferent.Fields[i].Value;
            end;
            DM.qrDifferent1.ExecSQL;

            if DM.qrDifferent.FieldByName('FROM_RATE').Value = 1 then
              CoefEstimCalc(ADestSmID, 3, TmpID_O, TmpID_N);

            DM.qrDifferent.Next;
          end;
          DM.qrDifferent.Active := False;
        end;

        //Переносит коэффициенты, переносит строку в смету, выполняет пересчет строки
        CoefEstimCalc(SmClipRec.SmID, SmClipRec.DataType, SmClipRec.DataID, NewId);

        Inc(InsertCount);
        Inc(AIterator);
      end;

      DM.qrDifferent1.SQL.Text := 'CALL UpdateNomManual(:SM_ID, 0, 0);';
      DM.qrDifferent1.ParamByName('SM_ID').Value := ADestSmID;
      DM.qrDifferent1.ExecSQL;

      DM.qrDifferent1.Transaction.Commit;
      Result := InsertCount > 0;
    except
      DM.qrDifferent1.Transaction.Rollback;
      raise;
    end;
  finally
    DM.qrDifferent1.Transaction.Options.AutoCommit := AutoCommitValue;
  end;
  if DM.qrDifferent.Active then
    DM.qrDifferent.Active := False;
end;

////////////////////////////////////////////////////////////////////////////////
// если AIsAct (новый параметр, необяз.) = True, то при копировании не нужно назначать
// новые ID для таблиц card_rate, materialcard, transpcard и др. зависящих от data_row,
// чтобы сохранились связи с записями из сметы. Копировать 1 в 1 из источника.
function GetCopySmeta(const ASoursSmetaID: Integer; const AIsAct: Boolean = False): boolean;
var IdConvert: TIDConvertArray;
    i, j: Integer;
    TmpId: Integer;
    SmIdStr: string;
    TmpStr: string;
    AutoCommitValue: Boolean;
begin

  AutoCommitValue :=DM.qrDifferent1.Transaction.Options.AutoCommit;
  DM.qrDifferent1.Transaction.Options.AutoCommit := False;
  try
    DM.qrDifferent1.Transaction.StartTransaction;
    try
      DM.qrDifferent.Active := False;
      DM.qrDifferent.SQL.Text := 'SELECT * FROM smetasourcedata WHERE ' +
        '((SM_ID = ' + ASoursSmetaID.ToString + ') OR ' +
         '(((PARENT_ID = ' + ASoursSmetaID.ToString + ')) OR ' +
         '((PARENT_ID IN (SELECT smetasourcedata.SM_ID FROM ' +
          'smetasourcedata WHERE smetasourcedata.PARENT_ID = ' +
            ASoursSmetaID.ToString + '))) AND (DELETED=0))) ORDER BY SM_ID';
      DM.qrDifferent.Active := True;
      if not DM.qrDifferent.IsEmpty then
        DM.qrDifferent1.SQL.Text := GetQueryStr(DM.qrDifferent, 'smetasourcedata')
      else
      begin
        //Если смет с таким ID не обнаружено
        DM.qrDifferent.Active := False;
        raise Exception.Create('Смета источник не найдена.');
      end;

      SmIdStr := '';
      while not DM.qrDifferent.Eof do
      begin
        TmpId := DM.qrDifferent.FieldByName('SM_ID').AsInteger;

        //Строка идшников, что-бы не тягать за собой длинный запрос
        if SmIdStr <> '' then
          SmIdStr := SmIdStr + ',';
        SmIdStr := SmIdStr + IntToStr(TmpId);

        for i := 0 to DM.qrDifferent.Fields.Count - 1 do
        begin
          if UpperCase(DM.qrDifferent.Fields[i].FieldName) = 'SM_ID' then
          begin
            DM.qrDifferent1.ParamByName(DM.qrDifferent.Fields[i].FieldName).Value :=
              GetNewId(DM.qrDifferent.Fields[i].Value, C_ID_SM, IdConvert);
            Continue;
          end;

          if UpperCase(DM.qrDifferent.Fields[i].FieldName) = 'NAME' then
          begin
            DM.qrDifferent1.ParamByName(DM.qrDifferent.Fields[i].FieldName).Value :=
              DM.qrDifferent.Fields[i].Value + ' (Копия)';
            Continue;
          end;

          //Копия сметы должна быть прикреплена к той же ветке, что и иточник
          if (UpperCase(DM.qrDifferent.Fields[i].FieldName) = 'PARENT_ID') and
             (TmpId <> ASoursSmetaID) then
          begin
            DM.qrDifferent1.ParamByName(DM.qrDifferent.Fields[i].FieldName).Value :=
              GetNewId(DM.qrDifferent.Fields[i].Value, C_ID_SM, IdConvert);
            Continue;
          end;

          DM.qrDifferent1.ParamByName(DM.qrDifferent.Fields[i].FieldName).Value :=
            DM.qrDifferent.Fields[i].Value;
        end;
        DM.qrDifferent1.ExecSQL;
        DM.qrDifferent.Next;
      end;
      DM.qrDifferent.Active := False;

      DM.qrDifferent.SQL.Text :=
        'Select * from data_row where (SM_ID in (' + SmIdStr + ')) order by ID';
      DM.qrDifferent.Active := True;

      while not DM.qrDifferent.Eof do
      begin
        DM.qrDifferent1.Params.Clear;
        DM.qrDifferent1.SQL.Text := GetQueryStr(DM.qrDifferent, 'data_row');
        for i := 0 to DM.qrDifferent.Fields.Count - 1 do
        begin
          if UpperCase(DM.qrDifferent.Fields[i].FieldName) = 'ID' then
          begin
            DM.qrDifferent1.ParamByName(DM.qrDifferent.Fields[i].FieldName).Value :=
              GetNewId(DM.qrDifferent.Fields[i].Value, C_ID_DATA, IdConvert);
            Continue;
          end;

          if UpperCase(DM.qrDifferent.Fields[i].FieldName) = 'SM_ID' then
          begin
            DM.qrDifferent1.ParamByName(DM.qrDifferent.Fields[i].FieldName).Value :=
              GetNewId(DM.qrDifferent.Fields[i].Value, C_ID_SM, IdConvert);
            Continue;
          end;

          if UpperCase(DM.qrDifferent.Fields[i].FieldName) = 'ID_TABLES' then
          begin
            Continue;
          end;

          if (UpperCase(DM.qrDifferent.Fields[i].FieldName) = 'ID_TYPE_DATA') then
          begin
            if not AIsAct then
            begin
              j := 0;
              case DM.qrDifferent.Fields[i].Value of
                1: j := C_ID_SMRAT;
                2: j := C_ID_SMMAT;
                3: j := C_ID_SMMEC;
                4: j := C_ID_SMDEV;
                5: j := C_ID_SMDUM;
                6, 7, 8, 9: j := C_ID_SMTR;
              end;

              if (j > 0) then
                DM.qrDifferent1.ParamByName('ID_TABLES').Value :=
                  GetNewId(DM.qrDifferent.FieldByName('ID_TABLES').Value, j, IdConvert)
              else
                DM.qrDifferent1.ParamByName('ID_TABLES').Value := 0;
            end
            else
              DM.qrDifferent1.ParamByName('ID_TABLES').Value :=
                DM.qrDifferent.FieldByName('ID_TABLES').Value;
          end;

          DM.qrDifferent1.ParamByName(DM.qrDifferent.Fields[i].FieldName).Value :=
            DM.qrDifferent.Fields[i].Value;
        end;
        DM.qrDifferent1.ExecSQL;
        DM.qrDifferent.Next;
      end;
      DM.qrDifferent.Active := False;


      DM.qrDifferent.SQL.Text :=
        'Select * from card_rate where (SM_ID in (' + SmIdStr + ')) order by ID';
      DM.qrDifferent.Active := True;

      DM.qrDifferent1.Params.Clear;
      if not DM.qrDifferent.IsEmpty then
        DM.qrDifferent1.SQL.Text := GetQueryStr(DM.qrDifferent, 'card_rate');

      while not DM.qrDifferent.Eof do
      begin
        for i := 0 to DM.qrDifferent.Fields.Count - 1 do
        begin
          if UpperCase(DM.qrDifferent.Fields[i].FieldName) = 'SM_ID' then
          begin
            DM.qrDifferent1.ParamByName(DM.qrDifferent.Fields[i].FieldName).Value :=
              GetNewId(DM.qrDifferent.Fields[i].Value, C_ID_SM, IdConvert);
            Continue;
          end;
          if not AIsAct and
             (UpperCase(DM.qrDifferent.Fields[i].FieldName) = 'ID') then
          begin
            DM.qrDifferent1.ParamByName(DM.qrDifferent.Fields[i].FieldName).Value :=
              GetNewId(DM.qrDifferent.Fields[i].Value, C_ID_SMRAT, IdConvert);
            Continue;
          end;
          if UpperCase(DM.qrDifferent.Fields[i].FieldName) = 'DATA_ROW_ID' then
          begin
            DM.qrDifferent1.ParamByName(DM.qrDifferent.Fields[i].FieldName).Value :=
              GetNewId(DM.qrDifferent.Fields[i].Value, C_ID_DATA, IdConvert);
            Continue;
          end;
          DM.qrDifferent1.ParamByName(DM.qrDifferent.Fields[i].FieldName).Value :=
            DM.qrDifferent.Fields[i].Value;
        end;
        DM.qrDifferent1.ExecSQL;
        DM.qrDifferent.Next;
      end;
      DM.qrDifferent.Active := False;

      DM.qrDifferent.SQL.Text :=
        'Select * from materialcard where (SM_ID in (' + SmIdStr + ')) order by ID';
      DM.qrDifferent.Active := True;

      DM.qrDifferent1.Params.Clear;
      if not DM.qrDifferent.IsEmpty then
        DM.qrDifferent1.SQL.Text := GetQueryStr(DM.qrDifferent, 'materialcard');

      while not DM.qrDifferent.Eof do
      begin
        for i := 0 to DM.qrDifferent.Fields.Count - 1 do
        begin
          if UpperCase(DM.qrDifferent.Fields[i].FieldName) = 'SM_ID' then
          begin
            DM.qrDifferent1.ParamByName(DM.qrDifferent.Fields[i].FieldName).Value :=
              GetNewId(DM.qrDifferent.Fields[i].Value, C_ID_SM, IdConvert);
            Continue;
          end;
          if not AIsAct and
             (UpperCase(DM.qrDifferent.Fields[i].FieldName) = 'ID') then
          begin
            DM.qrDifferent1.ParamByName(DM.qrDifferent.Fields[i].FieldName).Value :=
              GetNewId(DM.qrDifferent.Fields[i].Value, C_ID_SMMAT, IdConvert);
            Continue;
          end;
          if UpperCase(DM.qrDifferent.Fields[i].FieldName) = 'DATA_ROW_ID' then
          begin
            DM.qrDifferent1.ParamByName(DM.qrDifferent.Fields[i].FieldName).Value :=
              GetNewId(DM.qrDifferent.Fields[i].Value, C_ID_DATA, IdConvert);
            Continue;
          end;
          if not AIsAct and
             (UpperCase(DM.qrDifferent.Fields[i].FieldName) = 'ID_CARD_RATE') then
          begin
            DM.qrDifferent1.ParamByName(DM.qrDifferent.Fields[i].FieldName).Value :=
              GetNewId(DM.qrDifferent.Fields[i].Value, C_ID_SMRAT, IdConvert);
            Continue;
          end;
          if not AIsAct and
             (UpperCase(DM.qrDifferent.Fields[i].FieldName) = 'ID_REPLACED') then
          begin
            DM.qrDifferent1.ParamByName(DM.qrDifferent.Fields[i].FieldName).Value :=
              GetNewId(DM.qrDifferent.Fields[i].Value, C_ID_SMMAT, IdConvert);
            Continue;
          end;
          DM.qrDifferent1.ParamByName(DM.qrDifferent.Fields[i].FieldName).Value :=
            DM.qrDifferent.Fields[i].Value;
        end;
        DM.qrDifferent1.ExecSQL;
        DM.qrDifferent.Next;
      end;
      DM.qrDifferent.Active := False;

      DM.qrDifferent.SQL.Text :=
        'Select * from mechanizmcard where (SM_ID in (' + SmIdStr + ')) order by ID';
      DM.qrDifferent.Active := True;

      DM.qrDifferent1.Params.Clear;
      if not DM.qrDifferent.IsEmpty then
        DM.qrDifferent1.SQL.Text := GetQueryStr(DM.qrDifferent, 'mechanizmcard');

      while not DM.qrDifferent.Eof do
      begin
        for i := 0 to DM.qrDifferent.Fields.Count - 1 do
        begin
          if UpperCase(DM.qrDifferent.Fields[i].FieldName) = 'SM_ID' then
          begin
            DM.qrDifferent1.ParamByName(DM.qrDifferent.Fields[i].FieldName).Value :=
              GetNewId(DM.qrDifferent.Fields[i].Value, C_ID_SM, IdConvert);
            Continue;
          end;
          if not AIsAct and
             (UpperCase(DM.qrDifferent.Fields[i].FieldName) = 'ID') then
          begin
            DM.qrDifferent1.ParamByName(DM.qrDifferent.Fields[i].FieldName).Value :=
              GetNewId(DM.qrDifferent.Fields[i].Value, C_ID_SMMEC, IdConvert);
            Continue;
          end;
          if UpperCase(DM.qrDifferent.Fields[i].FieldName) = 'DATA_ROW_ID' then
          begin
            DM.qrDifferent1.ParamByName(DM.qrDifferent.Fields[i].FieldName).Value :=
              GetNewId(DM.qrDifferent.Fields[i].Value, C_ID_DATA, IdConvert);
            Continue;
          end;
          if not AIsAct and
             (UpperCase(DM.qrDifferent.Fields[i].FieldName) = 'ID_CARD_RATE') then
          begin
            DM.qrDifferent1.ParamByName(DM.qrDifferent.Fields[i].FieldName).Value :=
              GetNewId(DM.qrDifferent.Fields[i].Value, C_ID_SMRAT, IdConvert);
            Continue;
          end;
          if not AIsAct and
             (UpperCase(DM.qrDifferent.Fields[i].FieldName) = 'ID_REPLACED') then
          begin
            DM.qrDifferent1.ParamByName(DM.qrDifferent.Fields[i].FieldName).Value :=
              GetNewId(DM.qrDifferent.Fields[i].Value, C_ID_SMMEC, IdConvert);
            Continue;
          end;
          DM.qrDifferent1.ParamByName(DM.qrDifferent.Fields[i].FieldName).Value :=
            DM.qrDifferent.Fields[i].Value;
        end;
        DM.qrDifferent1.ExecSQL;
        DM.qrDifferent.Next;
      end;
      DM.qrDifferent.Active := False;

      DM.qrDifferent.SQL.Text :=
        'Select * from devicescard where (SM_ID in (' + SmIdStr + ')) order by ID';
      DM.qrDifferent.Active := True;

      DM.qrDifferent1.Params.Clear;
      if not DM.qrDifferent.IsEmpty then
        DM.qrDifferent1.SQL.Text := GetQueryStr(DM.qrDifferent, 'devicescard');

      while not DM.qrDifferent.Eof do
      begin
        for i := 0 to DM.qrDifferent.Fields.Count - 1 do
        begin
          if UpperCase(DM.qrDifferent.Fields[i].FieldName) = 'SM_ID' then
          begin
            DM.qrDifferent1.ParamByName(DM.qrDifferent.Fields[i].FieldName).Value :=
              GetNewId(DM.qrDifferent.Fields[i].Value, C_ID_SM, IdConvert);
            Continue;
          end;
          if not AIsAct and
             (UpperCase(DM.qrDifferent.Fields[i].FieldName) = 'ID') then
          begin
            DM.qrDifferent1.ParamByName(DM.qrDifferent.Fields[i].FieldName).Value :=
              GetNewId(DM.qrDifferent.Fields[i].Value, C_ID_SMDEV, IdConvert);
            Continue;
          end;
          if UpperCase(DM.qrDifferent.Fields[i].FieldName) = 'DATA_ROW_ID' then
          begin
            DM.qrDifferent1.ParamByName(DM.qrDifferent.Fields[i].FieldName).Value :=
              GetNewId(DM.qrDifferent.Fields[i].Value, C_ID_DATA, IdConvert);
            Continue;
          end;
          DM.qrDifferent1.ParamByName(DM.qrDifferent.Fields[i].FieldName).Value :=
            DM.qrDifferent.Fields[i].Value;
        end;
        DM.qrDifferent1.ExecSQL;
        DM.qrDifferent.Next;
      end;
      DM.qrDifferent.Active := False;

      DM.qrDifferent.SQL.Text :=
        'Select * from dumpcard where (SM_ID in (' + SmIdStr + ')) order by ID';
      DM.qrDifferent.Active := True;

      DM.qrDifferent1.Params.Clear;
      if not DM.qrDifferent.IsEmpty then
        DM.qrDifferent1.SQL.Text := GetQueryStr(DM.qrDifferent, 'dumpcard');

      while not DM.qrDifferent.Eof do
      begin
        for i := 0 to DM.qrDifferent.Fields.Count - 1 do
        begin
          if UpperCase(DM.qrDifferent.Fields[i].FieldName) = 'SM_ID' then
          begin
            DM.qrDifferent1.ParamByName(DM.qrDifferent.Fields[i].FieldName).Value :=
              GetNewId(DM.qrDifferent.Fields[i].Value, C_ID_SM, IdConvert);
            Continue;
          end;
          if not AIsAct and
             (UpperCase(DM.qrDifferent.Fields[i].FieldName) = 'ID') then
          begin
            DM.qrDifferent1.ParamByName(DM.qrDifferent.Fields[i].FieldName).Value :=
              GetNewId(DM.qrDifferent.Fields[i].Value, C_ID_SMDUM, IdConvert);
            Continue;
          end;
          if UpperCase(DM.qrDifferent.Fields[i].FieldName) = 'DATA_ROW_ID' then
          begin
            DM.qrDifferent1.ParamByName(DM.qrDifferent.Fields[i].FieldName).Value :=
              GetNewId(DM.qrDifferent.Fields[i].Value, C_ID_DATA, IdConvert);
            Continue;
          end;
          DM.qrDifferent1.ParamByName(DM.qrDifferent.Fields[i].FieldName).Value :=
            DM.qrDifferent.Fields[i].Value;
        end;
        DM.qrDifferent1.ExecSQL;
        DM.qrDifferent.Next;
      end;
      DM.qrDifferent.Active := False;

      DM.qrDifferent.SQL.Text :=
        'Select * from transpcard where (SM_ID in (' + SmIdStr + ')) order by ID';
      DM.qrDifferent.Active := True;

      DM.qrDifferent1.Params.Clear;
      if not DM.qrDifferent.IsEmpty then
        DM.qrDifferent1.SQL.Text := GetQueryStr(DM.qrDifferent, 'transpcard');

      while not DM.qrDifferent.Eof do
      begin
        for i := 0 to DM.qrDifferent.Fields.Count - 1 do
        begin
          if UpperCase(DM.qrDifferent.Fields[i].FieldName) = 'SM_ID' then
          begin
            DM.qrDifferent1.ParamByName(DM.qrDifferent.Fields[i].FieldName).Value :=
              GetNewId(DM.qrDifferent.Fields[i].Value, C_ID_SM, IdConvert);
            Continue;
          end;
          if not AIsAct and
             (UpperCase(DM.qrDifferent.Fields[i].FieldName) = 'ID') then
          begin
            DM.qrDifferent1.ParamByName(DM.qrDifferent.Fields[i].FieldName).Value :=
              GetNewId(DM.qrDifferent.Fields[i].Value, C_ID_SMTR, IdConvert);
            Continue;
          end;
          if UpperCase(DM.qrDifferent.Fields[i].FieldName) = 'DATA_ROW_ID' then
          begin
            DM.qrDifferent1.ParamByName(DM.qrDifferent.Fields[i].FieldName).Value :=
              GetNewId(DM.qrDifferent.Fields[i].Value, C_ID_DATA, IdConvert);
            Continue;
          end;
          DM.qrDifferent1.ParamByName(DM.qrDifferent.Fields[i].FieldName).Value :=
            DM.qrDifferent.Fields[i].Value;
        end;
        DM.qrDifferent1.ExecSQL;
        DM.qrDifferent.Next;
      end;
      DM.qrDifferent.Active := False;

      DM.qrDifferent.SQL.Text :=
        'Select * from calculation_coef ' +
        'where (SM_ID in (' + SmIdStr + ')) order by calculation_coef_id';
      DM.qrDifferent.Active := True;

      DM.qrDifferent1.Params.Clear;
      if not DM.qrDifferent.IsEmpty then
        DM.qrDifferent1.SQL.Text := GetQueryStr(DM.qrDifferent, 'calculation_coef');

      while not DM.qrDifferent.Eof do
      begin
        for i := 0 to DM.qrDifferent.Fields.Count - 1 do
        begin
          if UpperCase(DM.qrDifferent.Fields[i].FieldName) = 'CALCULATION_COEF_ID' then
          begin
            DM.qrDifferent1.ParamByName(DM.qrDifferent.Fields[i].FieldName).Value :=
              GetNewId(DM.qrDifferent.Fields[i].Value, C_ID_SMCOEF, IdConvert);
            Continue;
          end;
          if UpperCase(DM.qrDifferent.Fields[i].FieldName) = 'SM_ID' then
          begin
            DM.qrDifferent1.ParamByName(DM.qrDifferent.Fields[i].FieldName).Value :=
              GetNewId(DM.qrDifferent.Fields[i].Value, C_ID_SM, IdConvert);
            Continue;
          end;
          if UpperCase(DM.qrDifferent.Fields[i].FieldName) = 'ID_OWNER' then
          begin
            Continue;
          end;

          if (UpperCase(DM.qrDifferent.Fields[i].FieldName) = 'ID_TYPE_DATA') then
          begin
            if AIsAct then
            begin
              j := 0;

              case DM.qrDifferent.Fields[i].Value of
                1: j := C_ID_SMRAT;
                2: j := C_ID_SMMAT;
                3: j := C_ID_SMMEC;
                4: j := C_ID_SMDEV;
                5: j := C_ID_SMDUM;
                6, 7, 8, 9: j := C_ID_SMTR;
              end;

              if j > 0  then
                DM.qrDifferent1.ParamByName('ID_OWNER').Value :=
                  GetNewId(DM.qrDifferent.FieldByName('ID_OWNER').Value, j, IdConvert);
            end
            else
              DM.qrDifferent1.ParamByName('ID_OWNER').Value :=
                DM.qrDifferent.FieldByName('ID_OWNER').Value;
          end;

          DM.qrDifferent1.ParamByName(DM.qrDifferent.Fields[i].FieldName).Value :=
            DM.qrDifferent.Fields[i].Value;
        end;
        DM.qrDifferent1.ExecSQL;
        DM.qrDifferent.Next;
      end;
      DM.qrDifferent.Active := False;

      DM.qrDifferent.SQL.Text := 'Select * from travel where ' +
        '(SOURCE_TYPE = 1) and (SM_ID in (' + SmIdStr + ')) order by travel_id';
      DM.qrDifferent.Active := True;

      DM.qrDifferent1.Params.Clear;
      if not DM.qrDifferent.IsEmpty then
        DM.qrDifferent1.SQL.Text := GetQueryStr(DM.qrDifferent, 'travel');

      while not DM.qrDifferent.Eof do
      begin
        for i := 0 to DM.qrDifferent.Fields.Count - 1 do
        begin
          if UpperCase(DM.qrDifferent.Fields[i].FieldName) = 'TRAVEL_ID' then
          begin
            DM.qrDifferent1.ParamByName(DM.qrDifferent.Fields[i].FieldName).Value :=
              GetNewId(DM.qrDifferent.Fields[i].Value, C_ID_TRAVEL, IdConvert);
            Continue;
          end;
          if UpperCase(DM.qrDifferent.Fields[i].FieldName) = 'SM_ID' then
          begin
            DM.qrDifferent1.ParamByName(DM.qrDifferent.Fields[i].FieldName).Value :=
              GetNewId(DM.qrDifferent.Fields[i].Value, C_ID_SM, IdConvert);
            Continue;
          end;
          DM.qrDifferent1.ParamByName(DM.qrDifferent.Fields[i].FieldName).Value :=
            DM.qrDifferent.Fields[i].Value;
        end;
        DM.qrDifferent1.ExecSQL;
        DM.qrDifferent.Next;
      end;
      DM.qrDifferent.Active := False;

      DM.qrDifferent.SQL.Text := 'Select * from travel_work where ' +
        '(SOURCE_TYPE = 1) and (SM_ID in (' + SmIdStr + ')) order by travel_work_id';
      DM.qrDifferent.Active := True;

      DM.qrDifferent1.Params.Clear;
      if not DM.qrDifferent.IsEmpty then
        DM.qrDifferent1.SQL.Text := GetQueryStr(DM.qrDifferent, 'travel_work');

      while not DM.qrDifferent.Eof do
      begin
        for i := 0 to DM.qrDifferent.Fields.Count - 1 do
        begin
          if UpperCase(DM.qrDifferent.Fields[i].FieldName) = 'TRAVEL_WORK_ID' then
          begin
            DM.qrDifferent1.ParamByName(DM.qrDifferent.Fields[i].FieldName).Value :=
              GetNewId(DM.qrDifferent.Fields[i].Value, C_ID_TRWORK, IdConvert);
            Continue;
          end;
          if UpperCase(DM.qrDifferent.Fields[i].FieldName) = 'SM_ID' then
          begin
            DM.qrDifferent1.ParamByName(DM.qrDifferent.Fields[i].FieldName).Value :=
              GetNewId(DM.qrDifferent.Fields[i].Value, C_ID_SM, IdConvert);
            Continue;
          end;
          DM.qrDifferent1.ParamByName(DM.qrDifferent.Fields[i].FieldName).Value :=
            DM.qrDifferent.Fields[i].Value;
        end;
        DM.qrDifferent1.ExecSQL;
        DM.qrDifferent.Next;
      end;
      DM.qrDifferent.Active := False;

      DM.qrDifferent.SQL.Text := 'Select * from worker_deartment where ' +
        '(SOURCE_TYPE = 1) and (SM_ID in (' + SmIdStr + ')) order by worker_department_id';
      DM.qrDifferent.Active := True;

      DM.qrDifferent1.Params.Clear;
      if not DM.qrDifferent.IsEmpty then
        DM.qrDifferent1.SQL.Text := GetQueryStr(DM.qrDifferent, 'worker_deartment');

      while not DM.qrDifferent.Eof do
      begin
        for i := 0 to DM.qrDifferent.Fields.Count - 1 do
        begin
          if UpperCase(DM.qrDifferent.Fields[i].FieldName) = 'WORKER_DEPARTMENT_ID' then
          begin
            DM.qrDifferent1.ParamByName(DM.qrDifferent.Fields[i].FieldName).Value :=
              GetNewId(DM.qrDifferent.Fields[i].Value, C_ID_WORKDEP, IdConvert);
            Continue;
          end;

          if UpperCase(DM.qrDifferent.Fields[i].FieldName) = 'SM_ID' then
          begin
            DM.qrDifferent1.ParamByName(DM.qrDifferent.Fields[i].FieldName).Value :=
              GetNewId(DM.qrDifferent.Fields[i].Value, C_ID_SM, IdConvert);
            Continue;
          end;

          DM.qrDifferent1.ParamByName(DM.qrDifferent.Fields[i].FieldName).Value :=
            DM.qrDifferent.Fields[i].Value;
        end;
        DM.qrDifferent1.ExecSQL;
        DM.qrDifferent.Next;
      end;
      DM.qrDifferent.Active := False;

      DM.qrDifferent.SQL.Text :=
        'Select * from summary_calculation where (SM_ID in (' + SmIdStr + '))';
      DM.qrDifferent.Active := True;

      DM.qrDifferent1.Params.Clear;
      if not DM.qrDifferent.IsEmpty then
        DM.qrDifferent1.SQL.Text := GetQueryStr(DM.qrDifferent, 'summary_calculation');

      while not DM.qrDifferent.Eof do
      begin
        for i := 0 to DM.qrDifferent.Fields.Count - 1 do
        begin
          if UpperCase(DM.qrDifferent.Fields[i].FieldName) = 'SM_ID' then
          begin
            DM.qrDifferent1.ParamByName(DM.qrDifferent.Fields[i].FieldName).Value :=
              GetNewId(DM.qrDifferent.Fields[i].Value, C_ID_SM, IdConvert);
            Continue;
          end;
          DM.qrDifferent1.ParamByName(DM.qrDifferent.Fields[i].FieldName).Value :=
            DM.qrDifferent.Fields[i].Value;
        end;
        DM.qrDifferent1.ExecSQL;
        DM.qrDifferent.Next;
      end;
      DM.qrDifferent.Active := False;

      DM.qrDifferent1.Transaction.Commit;
      Result := True;
    except
      DM.qrDifferent1.Transaction.Rollback;
      raise;
    end;
  finally
    DM.qrDifferent1.Transaction.Options.AutoCommit := AutoCommitValue;
  end;
end;

end.
