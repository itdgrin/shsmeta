unit ImportExportModule;

interface

uses
  System.Classes, System.SysUtils, System.IOUtils, System.UITypes, System.Variants,
  Winapi.Windows, Vcl.Forms, Vcl.Dialogs, Vcl.Controls, Data.DB, XMLIntf, XMLDoc,
  ActiveX, FireDAC.Comp.Client;

const
  CTabNameAndID: array [0..16, 0..1] of string =
    (('objcards', 'obj_id'),
    ('smetasourcedata', 'SM_ID'),
    ('card_rate', 'ID'),
    ('materialcard', 'ID'),
    ('mechanizmcard', 'ID'),
    ('devicescard', 'ID'),
    ('dumpcard', 'ID'),
    ('transpcard', 'ID'),
    ('data_estimate', 'ID'),
    ('card_acts', 'ID'),
    ('card_rate_act', 'ID'),
    ('materialcard_act', 'ID'),
    ('mechanizmcard_act', 'ID'),
    ('devicescard_act', 'ID'),
    ('dumpcard_act', 'ID'),
    ('transpcard_act', 'ID'),
    ('data_act', 'ID'));

  procedure ImportObject(const AFileName: string);
  procedure ExportObject(const AIdObject: Integer; const AFileName: string);

implementation

uses DataModule, Tools;

procedure ImportObject(const AFileName: string);
var XML : IXMLDocument;
    CurNode, Node1, Node2: IXMLNode;
    i, j: Integer;
    IdConvert: array [0..16, 0..1] of array of Integer;

  procedure GetStrAndExcec(ANode: IXMLNode; AType: Integer);
  var i: Integer;
      As1, As2: string;
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

    DM.qrDifferent.SQL.Text := 'Insert into ' + CTabNameAndID[AType][0] +
      ' (' + As1 + ') values (' + As2 + ')';
    for i := 0 to ANode.ChildNodes.Count - 1 do
      DM.qrDifferent.ParamByName(ANode.ChildNodes.Nodes[i].NodeName).Value :=
        ANode.ChildNodes.Nodes[i].NodeValue;
    DM.qrDifferent.ExecSQL;
  end;

  function GetNewId(const ALastID: Variant; const AType: Integer): Variant;
  var i: Integer;
      TabName,
      FieldName: string;
  begin
    //Расшифровка типов
    //0 - объект
    //1 - смета
    //2 - смета расценка
    //3 - смета материал
    //4 - смета механизм
    //5 - смета оборудование
    //6 - смета свалки
    //7 - смета транспорт
    //8 - смета data_estimate
    //9 - акт
    //10 - акт расценка
    //11 - акт материал
    //12 - акт механизм
    //13 - акт оборудование
    //14 - акт свалки
    //15 - акт транспорт
    //16 - акт data_act

    if VarIsNull(ALastID) or (ALastID = 0) then
    begin
      Result := ALastID;
      Exit;
    end;

    //Сперва проверяется на наличие этого ID
    for i := 0 to Length(IdConvert[AType][0]) - 1 do
      if IdConvert[AType][0][i] = ALastID then
      begin
        Result := IdConvert[AType][1][i];
        Exit;
      end;

    TabName := CTabNameAndID[AType][0];
    FieldName := CTabNameAndID[AType][1];

    DM.qrDifferent.Active := False;
    DM.qrDifferent.SQL.Text := 'Select MAX(' + FieldName + ') from ' + TabName;
    DM.qrDifferent.Active := True;
    if not DM.qrDifferent.IsEmpty then
      Result := DM.qrDifferent.Fields[0].AsInteger + 1
    else
      Result := 1;

    DM.qrDifferent.Active := False;
    DM.qrDifferent.SQL.Text := 'Alter table ' + TabName + ' auto_increment = ' +
      IntToStr(Result + 1);
    DM.qrDifferent.ExecSQL;

    SetLength(IdConvert[AType][0], Length(IdConvert[AType][0]) + 1);
    SetLength(IdConvert[AType][1], Length(IdConvert[AType][1]) + 1);

    IdConvert[AType][0][Length(IdConvert[AType][0]) - 1] := ALastID;
    IdConvert[AType][1][Length(IdConvert[AType][1]) - 1] := Result;
  end;

  procedure RollBackImport;
  var i, j: Integer;
  begin
    for i := 0 to High(IdConvert) do
      for j := 0 to High(IdConvert[i][0]) do
      begin
        DM.qrDifferent.SQL.Text := 'Delete from ' + CTabNameAndID[i][0] +
          ' where ' + CTabNameAndID[i][1] + ' = ' + IntToStr(IdConvert[i][1][j]);
        DM.qrDifferent.ExecSQL;
      end;
  end;

begin
  for i := 0 to Length(IdConvert) - 1 do
  begin
    SetLength(IdConvert[i][0], 0);
    SetLength(IdConvert[i][1], 0);
  end;
  DM.qrDifferent.Active := False;
  Application.ProcessMessages;
  CoInitialize(nil);
  try
    try
      XML := TXMLDocument.Create(nil);
      XML.LoadFromFile(AFileName);
      //загрузка объекта
      Node1 := XML.ChildNodes.FindNode('Object').ChildNodes.FindNode('Data_object');
      Node1.ChildNodes.Nodes['OBJ_ID'].NodeValue :=
        GetNewId(Node1.ChildNodes.Nodes['OBJ_ID'].NodeValue,0);

      GetStrAndExcec(Node1, 0);
      Node1 := nil;
      Application.ProcessMessages;
      //загрузка смет
      Node2 := XML.ChildNodes.FindNode('Object').ChildNodes.FindNode('Smety');
      for j := 0 to Node2.ChildNodes.Count - 1 do
      begin
        Node1 := Node2.ChildNodes.Nodes[j];
        //замена IDшников
        Node1.ChildNodes.Nodes['SM_ID'].NodeValue :=
          GetNewId(Node1.ChildNodes.Nodes['SM_ID'].NodeValue,1);
        Node1.ChildNodes.Nodes['OBJ_ID'].NodeValue :=
          GetNewId(Node1.ChildNodes.Nodes['OBJ_ID'].NodeValue,0);
        Node1.ChildNodes.Nodes['PARENT_ID'].NodeValue :=
          GetNewId(Node1.ChildNodes.Nodes['PARENT_ID'].NodeValue,1);

        GetStrAndExcec(Node1, 1);
        Node1 := nil;
      end;
      Node2 := nil;
      Application.ProcessMessages;
      //загрузка расценок смет
      Node2 := XML.ChildNodes.FindNode('Object').ChildNodes.FindNode('Smeta_Rates');
      if Assigned(Node2) then
        for j := 0 to Node2.ChildNodes.Count - 1 do
        begin
          Node1 := Node2.ChildNodes.Nodes[j];
          //замена IDшников
          Node1.ChildNodes.Nodes['ID'].NodeValue :=
            GetNewId(Node1.ChildNodes.Nodes['ID'].NodeValue,2);

          GetStrAndExcec(Node1, 2);
          Node1 := nil;
        end;
      Node2 := nil;
      Application.ProcessMessages;
      //загрузка материалов смет
      Node2 := XML.ChildNodes.FindNode('Object').ChildNodes.FindNode('Smeta_Materials');
      if Assigned(Node2) then
        for j := 0 to Node2.ChildNodes.Count - 1 do
        begin
          Node1 := Node2.ChildNodes.Nodes[j];
          //замена IDшников
          Node1.ChildNodes.Nodes['ID'].NodeValue :=
            GetNewId(Node1.ChildNodes.Nodes['ID'].NodeValue,3);
          Node1.ChildNodes.Nodes['ID_CARD_RATE'].NodeValue :=
            GetNewId(Node1.ChildNodes.Nodes['ID_CARD_RATE'].NodeValue,2);
          Node1.ChildNodes.Nodes['ID_REPLACED'].NodeValue :=
            GetNewId(Node1.ChildNodes.Nodes['ID_REPLACED'].NodeValue,3);

          GetStrAndExcec(Node1, 3);
          Node1 := nil;
        end;
      Node2 := nil;
      Application.ProcessMessages;
      //загрузка механизмов смет
      Node2 := XML.ChildNodes.FindNode('Object').ChildNodes.FindNode('Smeta_Mechanizms');
      if Assigned(Node2) then
        for j := 0 to Node2.ChildNodes.Count - 1 do
        begin
          Node1 := Node2.ChildNodes.Nodes[j];
          //замена IDшников
          Node1.ChildNodes.Nodes['ID'].NodeValue :=
            GetNewId(Node1.ChildNodes.Nodes['ID'].NodeValue,4);
          Node1.ChildNodes.Nodes['ID_CARD_RATE'].NodeValue :=
            GetNewId(Node1.ChildNodes.Nodes['ID_CARD_RATE'].NodeValue,2);
          Node1.ChildNodes.Nodes['ID_REPLACED'].NodeValue :=
            GetNewId(Node1.ChildNodes.Nodes['ID_REPLACED'].NodeValue,4);

          GetStrAndExcec(Node1, 4);
          Node1 := nil;
        end;
      Node2 := nil;
      Application.ProcessMessages;
      //загрузка оборудования смет
      Node2 := XML.ChildNodes.FindNode('Object').ChildNodes.FindNode('Smeta_Devices');
      if Assigned(Node2) then
        for j := 0 to Node2.ChildNodes.Count - 1 do
        begin
          Node1 := Node2.ChildNodes.Nodes[j];
          //замена IDшников
          Node1.ChildNodes.Nodes['ID'].NodeValue :=
            GetNewId(Node1.ChildNodes.Nodes['ID'].NodeValue,5);

          GetStrAndExcec(Node1, 5);
          Node1 := nil;
        end;
      Node2 := nil;
      Application.ProcessMessages;
      //загрузка свалок смет
      Node2 := XML.ChildNodes.FindNode('Object').ChildNodes.FindNode('Smeta_Dumps');
      if Assigned(Node2) then
        for j := 0 to Node2.ChildNodes.Count - 1 do
        begin
          Node1 := Node2.ChildNodes.Nodes[j];
          //замена IDшников
          Node1.ChildNodes.Nodes['ID'].NodeValue :=
            GetNewId(Node1.ChildNodes.Nodes['ID'].NodeValue,6);

          GetStrAndExcec(Node1, 6);
          Node1 := nil;
        end;
      Node2 := nil;
      Application.ProcessMessages;
      //загрузка транспорта смет
      Node2 := XML.ChildNodes.FindNode('Object').ChildNodes.FindNode('Smeta_Transps');
      if Assigned(Node2) then
        for j := 0 to Node2.ChildNodes.Count - 1 do
        begin
          Node1 := Node2.ChildNodes.Nodes[j];
          //замена IDшников
          Node1.ChildNodes.Nodes['ID'].NodeValue :=
            GetNewId(Node1.ChildNodes.Nodes['ID'].NodeValue,7);

          GetStrAndExcec(Node1, 7);
          Node1 := nil;
        end;
      Node2 := nil;
      Application.ProcessMessages;
      //загрузка Data_estimate смет
      Node2 := XML.ChildNodes.FindNode('Object').ChildNodes.FindNode('Smeta_Data_estimate');
      if Assigned(Node2) then
        for j := 0 to Node2.ChildNodes.Count - 1 do
        begin
          Node1 := Node2.ChildNodes.Nodes[j];
          //замена IDшников
          Node1.ChildNodes.Nodes['ID'].NodeValue :=
            GetNewId(Node1.ChildNodes.Nodes['ID'].NodeValue,8);
          Node1.ChildNodes.Nodes['ID_ESTIMATE'].NodeValue :=
            GetNewId(Node1.ChildNodes.Nodes['ID_ESTIMATE'].NodeValue,1);

          i := 0;
          case Node1.ChildNodes.Nodes['ID_TYPE_DATA'].NodeValue of
            1: i := 2;
            2: i := 3;
            3: i := 4;
            4: i := 5;
            5: i := 6;
            6, 7, 8, 9: i := 7;
          end;

          if i > 0  then
            Node1.ChildNodes.Nodes['ID_TABLES'].NodeValue :=
              GetNewId(Node1.ChildNodes.Nodes['ID_TABLES'].NodeValue,i);

          GetStrAndExcec(Node1, 8);
          Node1 := nil;
        end;
      Node2 := nil;
      Application.ProcessMessages;
      //загрузка актов
      Node2 := XML.ChildNodes.FindNode('Object').ChildNodes.FindNode('Acts');
      if Assigned(Node2) then
        for j := 0 to Node2.ChildNodes.Count - 1 do
        begin
          Node1 := Node2.ChildNodes.Nodes[j];
          //замена IDшников
          Node1.ChildNodes.Nodes['ID'].NodeValue :=
            GetNewId(Node1.ChildNodes.Nodes['ID'].NodeValue,9);
          Node1.ChildNodes.Nodes['ID_ESTIMATE_OBJECT'].NodeValue :=
            GetNewId(Node1.ChildNodes.Nodes['ID_ESTIMATE_OBJECT'].NodeValue,1);

          GetStrAndExcec(Node1, 9);
          Node1 := nil;
        end;
      Node2 := nil;
      Application.ProcessMessages;
      //загрузка расценок актов
      Node2 := XML.ChildNodes.FindNode('Object').ChildNodes.FindNode('Act_Rates');
      if Assigned(Node2) then
        for j := 0 to Node2.ChildNodes.Count - 1 do
        begin
          Node1 := Node2.ChildNodes.Nodes[j];
          //замена IDшников
          Node1.ChildNodes.Nodes['ID_ACT'].NodeValue :=
            GetNewId(Node1.ChildNodes.Nodes['ID_ACT'].NodeValue,9);
          Node1.ChildNodes.Nodes['ID'].NodeValue :=
            GetNewId(Node1.ChildNodes.Nodes['ID'].NodeValue,10);

          GetStrAndExcec(Node1, 10);
          Node1 := nil;
        end;
      Node2 := nil;
      Application.ProcessMessages;
      //загрузка материалов актов
      Node2 := XML.ChildNodes.FindNode('Object').ChildNodes.FindNode('Act_Materials');
      if Assigned(Node2) then
        for j := 0 to Node2.ChildNodes.Count - 1 do
        begin
          Node1 := Node2.ChildNodes.Nodes[j];
          //замена IDшников
          Node1.ChildNodes.Nodes['ID_ACT'].NodeValue :=
            GetNewId(Node1.ChildNodes.Nodes['ID_ACT'].NodeValue,9);
          Node1.ChildNodes.Nodes['ID'].NodeValue :=
            GetNewId(Node1.ChildNodes.Nodes['ID'].NodeValue,11);
          Node1.ChildNodes.Nodes['ID_CARD_RATE'].NodeValue :=
            GetNewId(Node1.ChildNodes.Nodes['ID_CARD_RATE'].NodeValue,10);
          Node1.ChildNodes.Nodes['ID_REPLACED'].NodeValue :=
            GetNewId(Node1.ChildNodes.Nodes['ID_REPLACED'].NodeValue,11);

          GetStrAndExcec(Node1, 11);
          Node1 := nil;
        end;
      Node2 := nil;
      Application.ProcessMessages;
      //загрузка механизмов актов
      Node2 := XML.ChildNodes.FindNode('Object').ChildNodes.FindNode('Act_Mechanizms');
      if Assigned(Node2) then
        for j := 0 to Node2.ChildNodes.Count - 1 do
        begin
          Node1 := Node2.ChildNodes.Nodes[j];
          //замена IDшников
          Node1.ChildNodes.Nodes['ID_ACT'].NodeValue :=
            GetNewId(Node1.ChildNodes.Nodes['ID_ACT'].NodeValue,9);
          Node1.ChildNodes.Nodes['ID'].NodeValue :=
            GetNewId(Node1.ChildNodes.Nodes['ID'].NodeValue,12);
          Node1.ChildNodes.Nodes['ID_CARD_RATE'].NodeValue :=
            GetNewId(Node1.ChildNodes.Nodes['ID_CARD_RATE'].NodeValue,10);
          Node1.ChildNodes.Nodes['ID_REPLACED'].NodeValue :=
            GetNewId(Node1.ChildNodes.Nodes['ID_REPLACED'].NodeValue,12);

          GetStrAndExcec(Node1, 12);
          Node1 := nil;
        end;
      Node2 := nil;
      Application.ProcessMessages;
      //загрузка оборудования актов
      Node2 := XML.ChildNodes.FindNode('Object').ChildNodes.FindNode('Act_Devices');
      if Assigned(Node2) then
        for j := 0 to Node2.ChildNodes.Count - 1 do
        begin
          Node1 := Node2.ChildNodes.Nodes[j];
          //замена IDшников
          Node1.ChildNodes.Nodes['ID_ACT'].NodeValue :=
            GetNewId(Node1.ChildNodes.Nodes['ID_ACT'].NodeValue,9);
          Node1.ChildNodes.Nodes['ID'].NodeValue :=
            GetNewId(Node1.ChildNodes.Nodes['ID'].NodeValue,13);

          GetStrAndExcec(Node1, 13);
          Node1 := nil;
        end;
      Node2 := nil;
      Application.ProcessMessages;
      //загрузка свалок актов
      Node2 := XML.ChildNodes.FindNode('Object').ChildNodes.FindNode('Act_Dumps');
      if Assigned(Node2) then
        for j := 0 to Node2.ChildNodes.Count - 1 do
        begin
          Node1 := Node2.ChildNodes.Nodes[j];
          //замена IDшников
          Node1.ChildNodes.Nodes['ID_ACT'].NodeValue :=
            GetNewId(Node1.ChildNodes.Nodes['ID_ACT'].NodeValue,9);
          Node1.ChildNodes.Nodes['ID'].NodeValue :=
            GetNewId(Node1.ChildNodes.Nodes['ID'].NodeValue,14);

          GetStrAndExcec(Node1, 14);
          Node1 := nil;
        end;
      Node2 := nil;
      Application.ProcessMessages;
      //загрузка транспорта актов
      Node2 := XML.ChildNodes.FindNode('Object').ChildNodes.FindNode('Act_Transps');
      if Assigned(Node2) then
        for j := 0 to Node2.ChildNodes.Count - 1 do
        begin
          Node1 := Node2.ChildNodes.Nodes[j];
          //замена IDшников
          Node1.ChildNodes.Nodes['ID_ACT'].NodeValue :=
            GetNewId(Node1.ChildNodes.Nodes['ID_ACT'].NodeValue,9);
          Node1.ChildNodes.Nodes['ID'].NodeValue :=
            GetNewId(Node1.ChildNodes.Nodes['ID'].NodeValue,15);

          GetStrAndExcec(Node1, 15);
          Node1 := nil;
        end;
      Node2 := nil;
      Application.ProcessMessages;
      //загрузка data_act актов
      Node2 := XML.ChildNodes.FindNode('Object').ChildNodes.FindNode('Act_Data_act');
      if Assigned(Node2) then
        for j := 0 to Node2.ChildNodes.Count - 1 do
        begin
          Node1 := Node2.ChildNodes.Nodes[j];
          //замена IDшников
          Node1.ChildNodes.Nodes['ID'].NodeValue :=
            GetNewId(Node1.ChildNodes.Nodes['ID'].NodeValue,16);
          Node1.ChildNodes.Nodes['ID_ACT'].NodeValue :=
            GetNewId(Node1.ChildNodes.Nodes['ID_ACT'].NodeValue,9);
          Node1.ChildNodes.Nodes['ID_ESTIMATE'].NodeValue :=
            GetNewId(Node1.ChildNodes.Nodes['ID_ESTIMATE'].NodeValue,1);

          i := 0;
          case Node1.ChildNodes.Nodes['ID_TYPE_DATA'].NodeValue of
            1: i := 10;
            2: i := 11;
            3: i := 12;
            4: i := 13;
            5: i := 14;
            6, 7, 8, 9: i := 15;
          end;

          if i > 0  then
            Node1.ChildNodes.Nodes['ID_TABLES'].NodeValue :=
              GetNewId(Node1.ChildNodes.Nodes['ID_TABLES'].NodeValue,i);

          GetStrAndExcec(Node1, 16);
          Node1 := nil;
        end;
      Node2 := nil;
      Application.ProcessMessages;
    except
      on e: Exception do
      begin
        RollBackImport;
        raise;
      end;
    end;
  finally
    Node2 := nil;
    Node1 := nil;
    CurNode := nil;
    XML := nil;
    CoUninitialize;
  end;
end;

procedure ExportObject(const AIdObject: Integer; const AFileName: string);
var XML : IXMLDocument;
    CurNode, Node1, Node2: IXMLNode;
  procedure RowToNode(ANode: IXMLNode; AQ: TFDQuery);
  var i: Integer;
  begin
    for i := 0 to AQ.Fields.Count - 1 do
    begin
        if AQ.Fields[i].DataType = ftBCD then
          ANode.ChildValues[AQ.Fields[i].FieldName] :=
            AQ.Fields[i].AsFloat
        else if AQ.Fields[i].DataType = ftDate then
          ANode.ChildValues[AQ.Fields[i].FieldName] :=
            FormatDateTime('yy/mm/dd', AQ.Fields[i].AsDateTime)
        else
          ANode.ChildValues[AQ.Fields[i].FieldName] :=
            AQ.Fields[i].Value;
    end;
  end;
begin
  if TFile.Exists(AFileName) then
    if MessageDlg('Файл ' + AFileName + ' уже существует. Перезаписать его?',
      mtConfirmation, mbOKCancel, 0) = mrCancel  then
      Exit;

  CoInitialize(nil);
  Application.ProcessMessages;
  try
    XML := TXMLDocument.Create(nil);
    XML.Active := True;
    XML.Encoding := 'unicode';
    XML.Version := '1.0';

    //Выгрузка информации об объекте
    CurNode := XML.AddChild('Object');
    DM.qrDifferent.Active := False;
    DM.qrDifferent.SQL.Text := 'Select * from objcards where obj_id = ' +
      IntToStr(AIdObject);
    DM.qrDifferent.Active := True;
    if not DM.qrDifferent.IsEmpty then
    begin
      CurNode.SetAttributeNS('Type', '', 'Объект');
      CurNode.SetAttributeNS('Name', '', DM.qrDifferent.FieldByName('name').AsString);

      Node1 := CurNode.AddChild('Data_object');
      RowToNode(Node1, DM.qrDifferent);
      Node1 := nil;
    end
    else
    begin
      XML.SaveToFile(AFileName);
      Exit;
    end;
    Application.ProcessMessages;
    //Выгрузка информации об сметах
    DM.qrDifferent.Active := False;
    DM.qrDifferent.SQL.Text := 'Select * from smetasourcedata where obj_id = ' +
      IntToStr(AIdObject) + ' order by SM_ID';
    DM.qrDifferent.Active := True;
    if not DM.qrDifferent.IsEmpty then
    begin
      Node1 := CurNode.AddChild('Smety');
      Node1.SetAttributeNS('Type', '', 'Сметы');
      while not DM.qrDifferent.Eof do
      begin
        Node2 := Node1.AddChild('Smeta');
        Node2.SetAttributeNS('Type', '', 'Смета');
        Node2.SetAttributeNS('Name', '', DM.qrDifferent.FieldByName('name').AsString);
        RowToNode(Node2, DM.qrDifferent);
        DM.qrDifferent.Next;
        Node2 := nil;
      end;
      Node1 := nil;
    end
    else
    begin
      XML.SaveToFile(AFileName);
      Exit;
    end;
    Application.ProcessMessages;
    //Выгрузка информации об расценках
    DM.qrDifferent.Active := False;
    DM.qrDifferent.SQL.Text := 'Select * from card_rate where ID in ' +
    '(select ID_TABLES from data_estimate where (ID_TYPE_DATA = 1) and (ID_ESTIMATE in ' +
    '(select SM_ID from smetasourcedata where obj_id = ' + IntToStr(AIdObject) +
    '))) order by ID';
    DM.qrDifferent.Active := True;
    if not DM.qrDifferent.IsEmpty then
    begin
      Node1 := CurNode.AddChild('Smeta_Rates');
      Node1.SetAttributeNS('Type', '', 'Смета_Расценки');
      while not DM.qrDifferent.Eof do
      begin
        Node2 := Node1.AddChild('Rate');
        Node2.SetAttributeNS('Type', '', 'Расценка');
        Node2.SetAttributeNS('CODE', '', DM.qrDifferent.FieldByName('RATE_CODE').AsString);
        RowToNode(Node2, DM.qrDifferent);
        DM.qrDifferent.Next;
        Node2 := nil;
      end;
      Node1 := nil;
    end;
    Application.ProcessMessages;
    //Выгрузка информации об материалах
    DM.qrDifferent.Active := False;
    DM.qrDifferent.SQL.Text := 'Select * from materialcard where (ID in ' +
    '(select ID_TABLES from data_estimate where (ID_TYPE_DATA = 2) and (ID_ESTIMATE in ' +
    '(select SM_ID from smetasourcedata where obj_id = ' + IntToStr(AIdObject) +
    ')))) or (ID_CARD_RATE in (select ID_TABLES from data_estimate where ' +
    '(ID_TYPE_DATA = 1) and (ID_ESTIMATE in (select SM_ID from smetasourcedata ' +
    'where obj_id = ' + IntToStr(AIdObject) + ')))) order by ID';
    DM.qrDifferent.Active := True;
    if not DM.qrDifferent.IsEmpty then
    begin
      Node1 := CurNode.AddChild('Smeta_Materials');
      Node1.SetAttributeNS('Type', '', 'Смета_Материалы');
      while not DM.qrDifferent.Eof do
      begin
        Node2 := Node1.AddChild('Material');
        Node2.SetAttributeNS('Type', '', 'Материал');
        Node2.SetAttributeNS('CODE', '', DM.qrDifferent.FieldByName('MAT_CODE').AsString);
        RowToNode(Node2, DM.qrDifferent);
        DM.qrDifferent.Next;
        Node2 := nil;
      end;
      Node1 := nil;
    end;
    Application.ProcessMessages;
     //Выгрузка информации об механизм
    DM.qrDifferent.Active := False;
    DM.qrDifferent.SQL.Text := 'Select * from mechanizmcard where (ID in ' +
    '(select ID_TABLES from data_estimate where (ID_TYPE_DATA = 3) and (ID_ESTIMATE in ' +
    '(select SM_ID from smetasourcedata where obj_id = ' + IntToStr(AIdObject) +
    ')))) or (ID_CARD_RATE in (select ID_TABLES from data_estimate where ' +
    '(ID_TYPE_DATA = 1) and (ID_ESTIMATE in (select SM_ID from smetasourcedata ' +
    'where obj_id = ' + IntToStr(AIdObject) + ')))) order by ID';
    DM.qrDifferent.Active := True;
    if not DM.qrDifferent.IsEmpty then
    begin
      Node1 := CurNode.AddChild('Smeta_Mechanizms');
      Node1.SetAttributeNS('Type', '', 'Смета_Механизмы');
      while not DM.qrDifferent.Eof do
      begin
        Node2 := Node1.AddChild('Mechanizm');
        Node2.SetAttributeNS('Type', '', 'Механизм');
        Node2.SetAttributeNS('CODE', '', DM.qrDifferent.FieldByName('MECH_CODE').AsString);
        RowToNode(Node2, DM.qrDifferent);
        DM.qrDifferent.Next;
        Node2 := nil;
      end;
      Node1 := nil;
    end;
    Application.ProcessMessages;
    //Выгрузка информации об оборудовании
    DM.qrDifferent.Active := False;
    DM.qrDifferent.SQL.Text := 'Select * from devicescard where ID in ' +
    '(select ID_TABLES from data_estimate where (ID_TYPE_DATA = 4) and (ID_ESTIMATE in ' +
    '(select SM_ID from smetasourcedata where obj_id = ' + IntToStr(AIdObject) +
    '))) order by ID';
    DM.qrDifferent.Active := True;
    if not DM.qrDifferent.IsEmpty then
    begin
      Node1 := CurNode.AddChild('Smeta_Devices');
      Node1.SetAttributeNS('Type', '', 'Смета_Оборудование');
      while not DM.qrDifferent.Eof do
      begin
        Node2 := Node1.AddChild('Device');
        Node2.SetAttributeNS('Type', '', 'Оборудование');
        Node2.SetAttributeNS('CODE', '', DM.qrDifferent.FieldByName('DEVICE_CODE').AsString);
        RowToNode(Node2, DM.qrDifferent);
        DM.qrDifferent.Next;
        Node2 := nil;
      end;
      Node1 := nil;
    end;
    Application.ProcessMessages;
    //Выгрузка информации об свалках
    DM.qrDifferent.Active := False;
    DM.qrDifferent.SQL.Text := 'Select * from dumpcard where ID in ' +
    '(select ID_TABLES from data_estimate where (ID_TYPE_DATA = 5) and (ID_ESTIMATE in ' +
    '(select SM_ID from smetasourcedata where obj_id = ' + IntToStr(AIdObject) +
    '))) order by ID';
    DM.qrDifferent.Active := True;
    if not DM.qrDifferent.IsEmpty then
    begin
      Node1 := CurNode.AddChild('Smeta_Dumps');
      Node1.SetAttributeNS('Type', '', 'Смета_Свалки');
      while not DM.qrDifferent.Eof do
      begin
        Node2 := Node1.AddChild('Dumpe');
        Node2.SetAttributeNS('Type', '', 'Свалка');
        Node2.SetAttributeNS('CODE', '', DM.qrDifferent.FieldByName('DUMP_CODE_JUST').AsString);
        RowToNode(Node2, DM.qrDifferent);
        DM.qrDifferent.Next;
        Node2 := nil;
      end;
      Node1 := nil;
    end;
    Application.ProcessMessages;
    //Выгрузка информации об транспорте
    DM.qrDifferent.Active := False;
    DM.qrDifferent.SQL.Text := 'Select * from transpcard where ID in ' +
    '(select ID_TABLES from data_estimate where (ID_TYPE_DATA in (6,7,8,9)) and (ID_ESTIMATE in ' +
    '(select SM_ID from smetasourcedata where obj_id = ' + IntToStr(AIdObject) +
    '))) order by ID';
    DM.qrDifferent.Active := True;
    if not DM.qrDifferent.IsEmpty then
    begin
      Node1 := CurNode.AddChild('Smeta_Transps');
      Node1.SetAttributeNS('Type', '', 'Смета_Транспорт');
      while not DM.qrDifferent.Eof do
      begin
        Node2 := Node1.AddChild('Transp');
        Node2.SetAttributeNS('Type', '', 'Транспорт');
        Node2.SetAttributeNS('CODE', '', DM.qrDifferent.FieldByName('TRANSP_CODE_JUST').AsString);
        RowToNode(Node2, DM.qrDifferent);
        DM.qrDifferent.Next;
        Node2 := nil;
      end;
      Node1 := nil;
    end;
    Application.ProcessMessages;
    //Выгрузка информации из data_estimate
    DM.qrDifferent.Active := False;
    DM.qrDifferent.SQL.Text := 'Select * from data_estimate where ' +
      '(ID_ESTIMATE in (select SM_ID from smetasourcedata where obj_id = ' +
      IntToStr(AIdObject) + '))order by ID';
    DM.qrDifferent.Active := True;
    if not DM.qrDifferent.IsEmpty then
    begin
      Node1 := CurNode.AddChild('Smeta_Data_estimate');
      while not DM.qrDifferent.Eof do
      begin
        Node2 := Node1.AddChild('Line');
        RowToNode(Node2, DM.qrDifferent);
        DM.qrDifferent.Next;
        Node2 := nil;
      end;
      Node1 := nil;
    end;
    Application.ProcessMessages;
    //Выгрузка информации об актах
    DM.qrDifferent.Active := False;
    DM.qrDifferent.SQL.Text := 'Select * from card_acts where ID_ESTIMATE_OBJECT in ' +
    '(select SM_ID from smetasourcedata where obj_id = ' + IntToStr(AIdObject) +
    ') order by ID';
    DM.qrDifferent.Active := True;
    if not DM.qrDifferent.IsEmpty then
    begin
      Node1 := CurNode.AddChild('Acts');
      Node1.SetAttributeNS('Type', '', 'Акты');
      while not DM.qrDifferent.Eof do
      begin
        Node2 := Node1.AddChild('Act');
        Node2.SetAttributeNS('Type', '', 'Акт');
        Node2.SetAttributeNS('NAME', '', DM.qrDifferent.FieldByName('NAME').AsString);
        RowToNode(Node2, DM.qrDifferent);
        DM.qrDifferent.Next;
        Node2 := nil;
      end;
      Node1 := nil;
    end
    else
    begin
      XML.SaveToFile(AFileName);
      Exit;
    end;
    Application.ProcessMessages;
    //Выгрузка информации об расценках
    DM.qrDifferent.Active := False;
    DM.qrDifferent.SQL.Text := 'Select * from card_rate_act where ID in ' +
    '(select ID_TABLES from data_act where (ID_TYPE_DATA = 1) and (ID_ESTIMATE in ' +
    '(select SM_ID from smetasourcedata where obj_id = ' + IntToStr(AIdObject) +
    '))) order by ID';
    DM.qrDifferent.Active := True;
    if not DM.qrDifferent.IsEmpty then
    begin
      Node1 := CurNode.AddChild('Act_Rates');
      Node1.SetAttributeNS('Type', '', 'Акт_Расценки');
      while not DM.qrDifferent.Eof do
      begin
        Node2 := Node1.AddChild('Rate');
        Node2.SetAttributeNS('Type', '', 'Расценка');
        Node2.SetAttributeNS('CODE', '', DM.qrDifferent.FieldByName('RATE_CODE').AsString);
        RowToNode(Node2, DM.qrDifferent);
        DM.qrDifferent.Next;
        Node2 := nil;
      end;
      Node1 := nil;
    end;
    Application.ProcessMessages;
    //Выгрузка информации об материалах
    DM.qrDifferent.Active := False;
    DM.qrDifferent.SQL.Text := 'Select * from materialcard_act where (ID in ' +
    '(select ID_TABLES from data_act where (ID_TYPE_DATA = 2) and (ID_ESTIMATE in ' +
    '(select SM_ID from smetasourcedata where obj_id = ' + IntToStr(AIdObject) +
    ')))) or (ID_CARD_RATE in (select ID_TABLES from data_act where ' +
    '(ID_TYPE_DATA = 1) and (ID_ESTIMATE in (select SM_ID from smetasourcedata ' +
    'where obj_id = ' + IntToStr(AIdObject) + ')))) order by ID';
    DM.qrDifferent.Active := True;
    if not DM.qrDifferent.IsEmpty then
    begin
      Node1 := CurNode.AddChild('Act_Materials');
      Node1.SetAttributeNS('Type', '', 'Акт_Материалы');
      while not DM.qrDifferent.Eof do
      begin
        Node2 := Node1.AddChild('Material');
        Node2.SetAttributeNS('Type', '', 'Материал');
        Node2.SetAttributeNS('CODE', '', DM.qrDifferent.FieldByName('MAT_CODE').AsString);
        RowToNode(Node2, DM.qrDifferent);
        DM.qrDifferent.Next;
        Node2 := nil;
      end;
      Node1 := nil;
    end;
    Application.ProcessMessages;
     //Выгрузка информации об механизм
    DM.qrDifferent.Active := False;
    DM.qrDifferent.SQL.Text := 'Select * from mechanizmcard_act where (ID in ' +
    '(select ID_TABLES from data_act where (ID_TYPE_DATA = 3) and (ID_ESTIMATE in ' +
    '(select SM_ID from smetasourcedata where obj_id = ' + IntToStr(AIdObject) +
    ')))) or (ID_CARD_RATE in (select ID_TABLES from data_act where ' +
    '(ID_TYPE_DATA = 1) and (ID_ESTIMATE in (select SM_ID from smetasourcedata ' +
    'where obj_id = ' + IntToStr(AIdObject) + ')))) order by ID';
    DM.qrDifferent.Active := True;
    if not DM.qrDifferent.IsEmpty then
    begin
      Node1 := CurNode.AddChild('Act_Mechanizms');
      Node1.SetAttributeNS('Type', '', 'Акт_Механизмы');
      while not DM.qrDifferent.Eof do
      begin
        Node2 := Node1.AddChild('Mechanizm');
        Node2.SetAttributeNS('Type', '', 'Механизм');
        Node2.SetAttributeNS('CODE', '', DM.qrDifferent.FieldByName('MECH_CODE').AsString);
        RowToNode(Node2, DM.qrDifferent);
        DM.qrDifferent.Next;
        Node2 := nil;
      end;
      Node1 := nil;
    end;
    Application.ProcessMessages;
    //Выгрузка информации об оборудовании
    DM.qrDifferent.Active := False;
    DM.qrDifferent.SQL.Text := 'Select * from devicescard_act where ID in ' +
    '(select ID_TABLES from data_act where (ID_TYPE_DATA = 4) and (ID_ESTIMATE in ' +
    '(select SM_ID from smetasourcedata where obj_id = ' + IntToStr(AIdObject) +
    '))) order by ID';
    DM.qrDifferent.Active := True;
    if not DM.qrDifferent.IsEmpty then
    begin
      Node1 := CurNode.AddChild('Act_Devices');
      Node1.SetAttributeNS('Type', '', 'Акт_Оборудование');
      while not DM.qrDifferent.Eof do
      begin
        Node2 := Node1.AddChild('Device');
        Node2.SetAttributeNS('Type', '', 'Оборудование');
        Node2.SetAttributeNS('CODE', '', DM.qrDifferent.FieldByName('DEVICE_CODE').AsString);
        RowToNode(Node2, DM.qrDifferent);
        DM.qrDifferent.Next;
        Node2 := nil;
      end;
      Node1 := nil;
    end;
    Application.ProcessMessages;
    //Выгрузка информации об свалках
    DM.qrDifferent.Active := False;
    DM.qrDifferent.SQL.Text := 'Select * from dumpcard_act where ID in ' +
    '(select ID_TABLES from data_act where (ID_TYPE_DATA = 5) and (ID_ESTIMATE in ' +
    '(select SM_ID from smetasourcedata where obj_id = ' + IntToStr(AIdObject) +
    '))) order by ID';
    DM.qrDifferent.Active := True;
    if not DM.qrDifferent.IsEmpty then
    begin
      Node1 := CurNode.AddChild('Act_Dumps');
      Node1.SetAttributeNS('Type', '', 'Акт_Свалки');
      while not DM.qrDifferent.Eof do
      begin
        Node2 := Node1.AddChild('Dumpe');
        Node2.SetAttributeNS('Type', '', 'Свалка');
        Node2.SetAttributeNS('CODE', '', DM.qrDifferent.FieldByName('DUMP_CODE_JUST').AsString);
        RowToNode(Node2, DM.qrDifferent);
        DM.qrDifferent.Next;
        Node2 := nil;
      end;
      Node1 := nil;
    end;
    Application.ProcessMessages;
    //Выгрузка информации об транспорте
    DM.qrDifferent.Active := False;
    DM.qrDifferent.SQL.Text := 'Select * from transpcard_act where ID in ' +
    '(select ID_TABLES from data_act where (ID_TYPE_DATA in (6,7,8,9)) and (ID_ESTIMATE in ' +
    '(select SM_ID from smetasourcedata where obj_id = ' + IntToStr(AIdObject) +
    '))) order by ID';
    DM.qrDifferent.Active := True;
    if not DM.qrDifferent.IsEmpty then
    begin
      Node1 := CurNode.AddChild('Act_Transps');
      Node1.SetAttributeNS('Type', '', 'Акт_Транспорт');
      while not DM.qrDifferent.Eof do
      begin
        Node2 := Node1.AddChild('Transp');
        Node2.SetAttributeNS('Type', '', 'Транспорт');
        Node2.SetAttributeNS('CODE', '', DM.qrDifferent.FieldByName('TRANSP_CODE_JUST').AsString);
        RowToNode(Node2, DM.qrDifferent);
        DM.qrDifferent.Next;
        Node2 := nil;
      end;
      Node1 := nil;
    end;
    Application.ProcessMessages;
    //Выгрузка информации из data_act
    DM.qrDifferent.Active := False;
    DM.qrDifferent.SQL.Text := 'Select * from data_act where ' +
      '(ID_ESTIMATE in (select SM_ID from smetasourcedata where obj_id = ' +
      IntToStr(AIdObject) + '))order by ID';
    DM.qrDifferent.Active := True;
    if not DM.qrDifferent.IsEmpty then
    begin
      Node1 := CurNode.AddChild('Act_Data_act');
      while not DM.qrDifferent.Eof do
      begin
        Node2 := Node1.AddChild('Line');
        RowToNode(Node2, DM.qrDifferent);
        DM.qrDifferent.Next;
        Node2 := nil;
      end;
      Node1 := nil;
    end;
    Application.ProcessMessages;
    XML.SaveToFile(AFileName);
  finally
    Node2 := nil;
    Node1 := nil;
    CurNode := nil;
    XML := nil;
    CoUninitialize;
  end;
end;

end.
