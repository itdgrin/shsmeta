program SmUpd;

{$SETPEFlAGS $0001}

uses
  System.SysUtils,
  System.IOUtils,
  System.Types,
  Winapi.Windows,
 // Dialogs,
  ShellAPI,
  IniFiles,
  GlobsAndConst in 'GlobsAndConst.pas';

var MHandle: THandle;
    i: integer;
    TmpFiles: TStringDynArray;
    DestPath,
    UpdPath,
    TmpStr,
    FileName: string;
    TxFile: TextFile;
    ini: TIniFile;

    UpdType: byte;
    StartApp: Boolean;
    NewAppVers: integer;

    //Удаление директории с содержимым
    procedure KillDir(const ADirName: string);
    var
      FileFolderOperation: TSHFileOpStruct;
    begin
      FillChar(FileFolderOperation, SizeOf(FileFolderOperation), 0);
      FileFolderOperation.wFunc := FO_DELETE;
      FileFolderOperation.pFrom := PChar(ExcludeTrailingPathDelimiter(ADirName) + #0);
      FileFolderOperation.fFlags := FOF_SILENT or FOF_NOERRORUI or FOF_NOCONFIRMATION;
      SHFileOperation(FileFolderOperation);
    end;
begin
    MHandle := OpenMutex(MUTEX_ALL_ACCESS, False, '5q7b3g1p0b5n3x6v9e6s');
    if MHandle <> 0 then
      if WaitForSingleObject(MHandle, 20000) = WAIT_TIMEOUT then
      begin
        CloseHandle(MHandle);
        Exit;
      end;

    try
      try
        DestPath := ExtractFilePath(ParamStr(0));
        UpdType := 0;
        UpdPath := '';
        StartApp := False;
        NewAppVers := 0;

        for i := 1 to ParamCount do
        begin
          if (ParamStr(i) = C_UPD_UPDATE) then
            UpdType := 1;

          if (ParamStr(i) = C_UPD_RESTOR) then
            UpdType := 2;

          if (Pos(C_UPD_PATH, ParamStr(i)) = 1) then
            UpdPath :=
              IncludeTrailingPathDelimiter(Copy(ParamStr(i),
                Length(C_UPD_PATH) + 2, MAX_PATH));

          if (Pos(C_UPD_VERS, ParamStr(i)) = 1) then
            NewAppVers := StrToInt(Copy(ParamStr(i),
              Length(C_UPD_VERS) + 2, 10));

          if (ParamStr(i) = C_UPD_START) then
            StartApp := True;
        end;

        if (UpdType = 0) or (UpdPath = '') then
          Exit;

        if (UpdType = 1) and (NewAppVers = 0) then
          Exit;

        if (UpdType = 1) then
        begin
          //Проерка на всякий случай, так как папка UpdPath будет в конце удалена
          if (Pos(AnsiLowerCase(DestPath), AnsiLowerCase(UpdPath)) <> 1) or
            (Pos(AnsiLowerCase(C_UPDATEDIR), AnsiLowerCase(UpdPath)) = 0) then
            Exit;
        end;

        if (UpdType = 2) then
        begin
          //Проерка на всякий случай, так как папка UpdPath будет в конце удалена
          if (Pos(AnsiLowerCase(DestPath), AnsiLowerCase(UpdPath)) <> 1) or
            (Pos(AnsiLowerCase(C_ARHDIR), AnsiLowerCase(UpdPath)) = 0) then
            Exit;
        end;

        //Ждет пока отпустит все файлы
        Sleep(5000);
        TmpFiles := TDirectory.GetFiles(UpdPath, '*', TSearchOption.soAllDirectories);
        for i := Low(TmpFiles) to High(TmpFiles) do
        begin
          try
            FileName := StringReplace(TmpFiles[i], UpdPath, '', [rfReplaceAll, rfIgnoreCase]);
            ForceDirectories(ExtractFileDir(DestPath + FileName));
            TFile.Copy(TmpFiles[i], DestPath + FileName, True);
          except
            //Тупо гасится сообщение!!!!
            {on e : Exception do
              ShowMessage(e.Message);   }
          end;
        end;

        //Всеравно оставляет мусорную пустию папку которая удалится в след раз
        KillDir(UpdPath);

        if (UpdType = 1) then
        begin
          //Жестко забито имя!!! можно добавить отдельный параметр
          ini := TIniFile.Create(DestPath +  'Smeta.ini');
          try
            ini.WriteInteger('system', 'version', NewAppVers);
          finally
            FreeAndNil(ini);
          end;
        end;

        if StartApp then
          ShellExecute(0,'open', PChar(DestPath + 'Smeta.exe'),
            nil, nil ,SW_SHOWNORMAL);
      except
        on e: Exception do
        begin
          AssignFile(TxFile, DestPath + C_LOGDIR + C_UPDATELOG);
          if FileExists(DestPath + C_LOGDIR + C_UPDATELOG) then
            Append(TxFile)
          else
            Rewrite(TxFile);

          writeln(TxFile, '[' + DateToStr(Date) + ' : SmUpd (' +
            ExtractFileName(ParamStr(0)) + ')] ' +
            e.ClassName + ': ' + e.Message);
          CloseFile(TxFile);
        end;
      end;
    finally
      SetLength(TmpFiles, 0);

      ReleaseMutex(MHandle);
      CloseHandle(MHandle);
    end;
end.


