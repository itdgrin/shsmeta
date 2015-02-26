program SmUpd;

{$SETPEFlAGS $0001}

uses
  System.SysUtils,
  System.IOUtils,
  System.Types,
  Winapi.Windows,
  ShellAPI,
  IniFiles;

var MHandle: THandle;
    i: integer;
    TmpFiles: TStringDynArray;
    DestPath,
    UpdPath,
    TmpStr,
    FileName: string;
    TxFile: TextFile;
    ini: TIniFile;

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

    MHandle := OpenMutex(MUTEX_ALL_ACCESS, false, '5q7b3g1p0b5n3x6v9e6s');
    if MHandle <> 0 then
      if WaitForSingleObject(MHandle, 10000) = WAIT_TIMEOUT then
      begin
        CloseHandle(MHandle);
        Exit;
      end;
    try
      try
        DestPath := ExtractFilePath(ParamStr(0));
        UpdPath := IncludeTrailingPathDelimiter(ParamStr(1));

        //Проерка на всякий случай, так как папка ParamStr(1) будет в конце удалена
        if (Pos(AnsiLowerCase(DestPath), AnsiLowerCase(UpdPath)) = 0) or
          (Pos('updates', AnsiLowerCase(UpdPath)) = 0) then
          Exit;

        TmpFiles := TDirectory.GetFiles(UpdPath, '*', TSearchOption.soAllDirectories);
        for i := Low(TmpFiles) to High(TmpFiles) do
        begin
          FileName := StringReplace(TmpFiles[i], UpdPath, '', [rfReplaceAll, rfIgnoreCase]);
          ForceDirectories(ExtractFileDir(DestPath + FileName));
          TFile.Copy(TmpFiles[i], DestPath + FileName, True);
        end;

        KillDir(UpdPath);

        //Жестко забито имя!!! можно добавить отдельный параметр
        ini := TIniFile.Create(DestPath +  'Smeta.ini');
        try
          ini.WriteInteger('system', 'version', StrToInt(ParamStr(2)));
        finally
          FreeAndNil(ini);
        end;

      except
        on e: Exception do
        begin
          AssignFile(TxFile, DestPath + 'logs\update.log');
          if FileExists(DestPath + 'logs\update.log') then
            Append(TxFile)
          else
            Rewrite(TxFile);
          writeln(TxFile, '[' + DateToStr(Date) + ' : ' +
            ExtractFileName(ParamStr(0)) + '] ' +
            e.ClassName + ': ' + e.Message);
          CloseFile(TxFile);
        end;
      end;
    finally
      SetLength(TmpFiles, 0);
    end;
end.


