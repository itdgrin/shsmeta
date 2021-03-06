; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "SMR - HPP 2012"
#define MyAppVersion "1.0"
#define MyAppPublisher "����"
#define MyAppURL ""
#define MyAppExeName "SMR-HPP2012.exe"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{218AA622-38F4-49CF-8C37-40C6E0AA0DE6}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppCopyright=����
AppVerName={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={pf}\{#MyAppName}
DefaultGroupName={#MyAppName}
AllowNoIcons=yes
LicenseFile=D:\Work\Minsk\SmetaSRC\License.txt
OutputDir=D:\Work\Minsk\SmetaSRC\DISTR
OutputBaseFilename=setup
Compression=lzma
SolidCompression=yes

[Languages]
Name: "russian"; MessagesFile: "compiler:Languages\Russian.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "quicklaunchicon"; Description: "{cm:CreateQuickLaunchIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked; OnlyBelowVersion: 0,6.1
Name: "installODBC"; Description: "���������� ������� MySQL ODBC"; GroupDescription: "��������� �������������� ��������� �������:"; Flags: unchecked
Name: "installMYSQL"; Description: "���������� MySQL ������"; GroupDescription: "��������� �������������� ��������� �������:"; Flags: unchecked

[Files]
Source: "D:\Work\Minsk\SmetaSRC\Debug\Win32\SMR-HPP2012.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\Work\Minsk\SmetaSRC\Debug\Win32\SmUpd.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\Work\Minsk\SmetaSRC\SQL\mysql.exe"; DestDir: "{app}\SQL"; Flags: ignoreversion
Source: "D:\Work\Minsk\SmetaSRC\SQL\mysqldump.exe"; DestDir: "{app}\SQL"; Flags: ignoreversion
Source: "D:\Work\Minsk\SmetaSRC\libmySQL.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\Work\Minsk\SmetaSRC\Docs\*"; DestDir: "{app}\Docs"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "D:\Work\Minsk\SmetaSRC\Normative documents\*"; DestDir: "{app}\Normative documents"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "D:\Work\Minsk\SmetaSRC\Programs remote control\*"; DestDir: "{app}\Programs remote control"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "D:\Work\Minsk\Reports\*"; DestDir: "{app}\Reports"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "D:\Work\Minsk\SmetaSRC\XLS\*"; DestDir: "{app}\XLS"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "D:\Work\Minsk\SmetaSRC\Arhiv\*"; DestDir: "{app}\Arhiv"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "d:\Work\Minsk\SmetaSRC\Components\mysql-connector-odbc-5.2.7-win32.msi"; DestDir: "{app}\Distr"; Flags: ignoreversion
Source: "d:\Work\Minsk\SmetaSRC\Components\Setup-mysql5.2.exe"; DestDir: "{app}\Distr"; Flags: ignoreversion
Source: "d:\Work\Minsk\SmetaSRC\Components\mysql-query-browser-1.1.20-win.msi"; DestDir: "{app}\Distr"; Flags: ignoreversion

; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{group}\�������������\��������� MSQL-�������"; Filename: "{app}\Distr\Setup-mysql5.2.exe"
Name: "{group}\�������������\��������� ODBC"; Filename: "{app}\Distr\mysql-connector-odbc-5.2.7-win32.msi"
Name: "{group}\�������������\��������� ODBC"; Filename: "{app}\Distr\mysql-query-browser-1.1.20-win.msi"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon; Comment: "��� ����"
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: quicklaunchicon; Comment: "��� ����"

[Run]
Filename: "{app}\Distr\Setup-mysql5.2.exe"; Description: "MYSQL"; Tasks: installMYSQL
Filename: "msiexec.exe"; Parameters: "/i ""{app}\Distr\mysql-connector-odbc-5.2.7-win32.msi"" /passive"; Description: "ODBC"; Tasks: installODBC
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: postinstall

