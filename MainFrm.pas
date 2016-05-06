unit MainFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ActnList, ImgList, StdCtrls, CheckLst,
  Gauges, inifiles, shlobj, registry, shellapi, Buttons, ComCtrls, ExtCtrls,
  Menus, MySpeedButton, XPBarMenu, RxRichEdit;

const
  UPX_EXEFILENAME   = 'Upx.Kingron';
  REG_KEY           = 'Upx_Kingron';

type
  TExeFlag = (efPE, efPackDos, efDos, efAspack, efUpx, efDosPKLite, efPEPack, efOther);

type
  TMainForm = class(TForm)
    MainAction: TActionList;
    MainPC: TPageControl;
    ActionTB: TTabSheet;
    OptionsTB: TTabSheet;
    AboutTB: TTabSheet;
    Images: TImageList;
    StatusBar: TStatusBar;
    CompressSb: TSpeedButton;
    DeCompressSb: TSpeedButton;
    FileInfoGB: TGroupBox;
    OldFileNameLbl: TLabel;
    SourceNameEdt: TEdit;
    OpenAct: TAction;
    DeCompressAct: TAction;
    CompressAct: TAction;
    OldLenLbl: TLabel;
    RestoreSb: TSpeedButton;
    RestoreAct: TAction;
    NewLenLbl: TLabel;
    TmpPathEdt: TEdit;
    TempLbl: TLabel;
    BrowseSb: TSpeedButton;
    CompressLevelLbl: TLabel;
    CompressLevelTB: TTrackBar;
    CompressLevelAct: TAction;
    IconOptions: TRadioGroup;
    OverLapOptions: TRadioGroup;
    OtherOptions: TGroupBox;
    OtherCLB: TCheckListBox;
    NewFileNameLbl: TLabel;
    NewNameEdt: TEdit;
    CompressScale: TGauge;
    RadioLbl: TLabel;
    OldFileLenEdt: TEdit;
    NewFileLenEdt: TEdit;
    TestSb: TSpeedButton;
    TestAct: TAction;
    OpenDlg: TOpenDialog;
    SaveDlg: TSaveDialog;
    FileInfoStatusLbl: TLabel;
    BrowseFolderAct: TAction;
    AboutMemo: TRxRichEdit20;
    WwwSb: TSpeedButton;
    MailSb: TSpeedButton;
    EmailAct: TAction;
    WWWAct: TAction;
    SaveOptAct: TAction;
    SaveConfigSb: TSpeedButton;
    StatusLbl: TMemo;
    SpeedButton7: TSpeedButton;
    SaveAsAct: TAction;
    LanguageCB: TComboBox;
    Label1: TLabel;
    Bevel2: TBevel;
    RegLbl: TStaticText;
    Bevel1: TBevel;
    LogoLbl: TLabel;
    LogoImage: TImage;
    RegSb: TSpeedButton;
    RegAct: TAction;
    HistoryMenuPopAct: TAction;
    HistoryMenu: TPopupMenu;
    ClearHistorySb: TSpeedButton;
    ClearHistoryAct: TAction;
    FormMenu: TPopupMenu;
    OpenMI: TMenuItem;
    CompressMI: TMenuItem;
    DeComPressMI: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    ExitMenu: TMenuItem;
    BrowseFolderMenuItem: TMenuItem;
    OpenSb: TMySpeedButton;
    HistorySb: TMySpeedButton;
    TestMI: TMenuItem;
    RestoreMI: TMenuItem;
    ClearHistoryMI: TMenuItem;
    SaveOptMI: TMenuItem;
    EMailMI: TMenuItem;
    OptionMI: TMenuItem;
    N1: TMenuItem;
    ChangeFontAct: TAction;
    ChangMaxHistAct: TAction;
    FontDlg: TFontDialog;
    N5: TMenuItem;
    XPBarMenu1: TXPBarMenu;
    WWWMI: TMenuItem;
    procedure AppEventsHint(Sender: TObject);
    procedure CompressLevelActExecute(Sender: TObject);
    procedure BrowseFolderActExecute(Sender: TObject);
    procedure OpenActExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SaveOptActExecute(Sender: TObject);
    procedure TmpPathEdtChange(Sender: TObject);
    procedure EmailActExecute(Sender: TObject);
    procedure WWWActExecute(Sender: TObject);
    procedure CompressActExecute(Sender: TObject);
    procedure DeCompressActExecute(Sender: TObject);
    procedure ActionTBShow(Sender: TObject);
    procedure SaveAsActExecute(Sender: TObject);
    procedure SourceNameEdtChange(Sender: TObject);
    procedure TestActExecute(Sender: TObject);
    procedure RestoreActExecute(Sender: TObject);
    procedure LanguageCBChange(Sender: TObject);
    procedure OverLapOptionsClick(Sender: TObject);
    procedure HistoryMenuPopActExecute(Sender: TObject);
    procedure HistorySbMouseLeave(Sender: TObject);
    procedure HistorySbMouseEnter(Sender: TObject);
    procedure ClearHistoryActExecute(Sender: TObject);
    procedure ExitMenuClick(Sender: TObject);
    procedure FormContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure FormResize(Sender: TObject);
    procedure ChangMaxHistActExecute(Sender: TObject);
    procedure ChangeFontActExecute(Sender: TObject);
    procedure OtherCLBMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure AboutMemoURLClick(Sender: TObject; const URLText: String;
      Button: TMouseButton);
  private
    { Private declarations }
    UpxExeFileName: string; /// Shell Excutable File
    WinTmpDir: string; ///Windows Temp Directory
    TmpDir: string; ///Temp/Work Directory
    IniFileName: string; ///Config FileName
    SourceFileName: string; /// Source File Name
    SysImgLst: TImageList; ///ImageList For History Menu
    MaxHistoryItem: integer; ///History Menu Max Count
    function ProcessCommandLine(bCom: boolean = True): string; ///Process the Command Line Paramsters
    procedure ShowStatusHint(str: string); /// Custom Draw Hint on the StatusBar
    procedure GetOptions; /// Load Options
    procedure SetOptions; /// Save Options
    procedure ProcessFile(FileName: string); /// Process a File
    procedure GenUpxExeFile; /// Create Temp Shell file
    function CheckFileFlag: TExeFlag; /// Check the file flag
    procedure DisableControl(bDeCom, bTest, bRestore, bCom: boolean); /// Update UI
    procedure wmdropfiles(var msg: TMessage); message wm_dropfiles; ///File Drag&Drop
    procedure CmMouseEnter(var msg: TMessage); message CM_MOUSEENTER;
    procedure CmMouseLeave(var msg: TMessage); message CM_MOUSELEAVE;
    procedure ProcessMenu(fn: string);
    procedure HistoryMenuClick(Sender: TObject); ///History Menu Click Event Process
    procedure InitFormMenuBitmap;
  public
    { Public declarations }
  end;

var
  MainForm          : TMainForm;
  RootDir           : string; /// the Init Directory for the Browser Directory Dialog

implementation

{$R *.DFM}
{$R upx.res} /// Upx.Exe

uses PEConst, Lan;

procedure GetSystemImageList(imagelist: TImageList);
var
  SysIL             : THandle;
  SFI               : TSHFileInfo;
begin
    // 取小图标，如果将SHGFI_SMALLICON替换成
    //SHGFI_LARGEICON则表示取大图标
  SysIL := SHGetFileInfo('', 0, SFI, SizeOf(SFI), SHGFI_SYSICONINDEX or SHGFI_SMALLICON);
  if SysIL <> 0 then begin
        //将imagelist的图像列表句柄指向系统图像句柄
    imagelist.Handle := SysIL;
        //防止组件释放时释放图像句柄，很重要
    imagelist.ShareImages := TRUE;
  end;
end;

//获取一个文件的imageindex;

function GetIconIndex(const APath: string; Attrs: DWORD): integer;
var
  SFI               : TSHFileInfo;
begin
  if FileExists(APath) then
    // If the file or directory exists, just let Windows figure out it's attrs.
    SHGetFileInfo(PChar(APath), 0, SFI, SizeOf(TSHFileInfo),
      SHGFI_SYSICONINDEX + SHGFI_SMALLICON)
  else
    // File doesn't exist, so Windows doesn't know what to do with it.  We have
    // to tell it by passing the attributes we want, and specifying the
    // SHGFI_USEFILEATTRIBUTES flag so that the function knows to use them.
    SHGetFileInfo(PChar(APath), Attrs, SFI, SizeOf(TSHFileInfo),
      SHGFI_SYSICONINDEX or SHGFI_USEFILEATTRIBUTES or SHGFI_SMALLICON);
  Result := SFI.iIcon;
end;

/// Execute a External moduale and Waiting

function WinExecExW(ExeName, cmd, workdir: pchar; visiable: integer): DWORD;
var
  StartupInfo       : TStartupInfo;
  ProcessInfo       : TProcessInformation;
begin
  FillChar(StartupInfo, SizeOf(StartupInfo), #0);
  StartupInfo.cb := SizeOf(StartupInfo);
  StartupInfo.dwFlags := STARTF_USESHOWWINDOW;
  StartupInfo.wShowWindow := visiable;
  if not CreateProcess(ExeName, cmd, nil, nil, false, Create_new_console or Normal_priority_class, nil, WorkDir, StartupInfo, ProcessInfo) then
    result := $FF
  else begin
    waitforsingleobject(processinfo.hProcess, INFINITE);
    GetExitCodeProcess(ProcessInfo.hProcess, Result);
  end;
end;

///Self GetFileSize function,Delphi's GetFileSize function so bad!

function GetFileSize(FileName: string): integer;
var
  Rec               : TSearchRec;
begin
  FillChar(Rec, SizeOf(Rec), 0);
  FindFirst(FileName, faAnyFile, Rec);
  FindClose(Rec);
  Result := Rec.Size;
end;

/// the Callback function Set the Init Directory for the Browser Directory Dialog

function BrowseCallbackProc(hwnd: HWND; uMsg: UINT; lParam: Cardinal; lpData: Cardinal): integer; stdcall;
begin
  if uMsg = BFFM_INITIALIZED then
    result := SendMessage(Hwnd, BFFM_SETSELECTION, Ord(TRUE), Longint(PChar(RootDir)))
  else result := 1
end;

/// self Browser Directory Function,Delphi's so bad!

function SelectDirectory(handle: hwnd; const Caption: string; const Root: WideString; out Directory: string): Boolean;
var
  lpbi              : _browseinfo;
  buf               : array[0..MAX_PATH] of char;
begin
  result := false;
  lpbi.hwndOwner := handle;
  lpbi.lpfn := @BrowseCallBackProc;
  RootDir := Root;
  lpbi.lpszTitle := pchar(caption);
  lpbi.ulFlags := BIF_RETURNONLYFSDIRS + 16 + 32 + 64; /// if under win2000,64 can use the new style
  lpbi.pidlRoot := nil;
  getmem(lpbi.pszDisplayName, MAX_PATH);
  try
    result := shgetpathfromidlist(shbrowseforfolder(lpbi), buf);
  except
    freemem(lpbi.pszDisplayName);
  end;
  if result then begin
    directory := buf;
    if Directory[Length(Directory)] <> '\' then
      Directory := Directory + '\';
  end;
end;

procedure TMainForm.AppEventsHint(Sender: TObject);
begin
  ShowStatusHint(Application.Hint);
end;

procedure TMainForm.ShowStatusHint(str: string);
var
  ypos              : integer;
begin
  StatusBar.Refresh; /// Clear Canvas
  StatusBar.Canvas.Font.Assign(Font);
  StatusBar.Canvas.Brush.Style := bsClear; /// Transparent
  StatusBar.Canvas.Font.Color := clLime;
  ypos := StatusBar.Height div 2 - StatusBar.Canvas.TextHeight('H') div 2;
  if ypos < 2 then ypos := 2;
  StatusBar.Canvas.TextOut(2, ypos, str);
end;

procedure TMainForm.CompressLevelActExecute(Sender: TObject);
begin
  if CompressLevelTB.Position = 10 then /// --best
    CompressLevelTB.Hint := ss_msg[0]
  else CompressLevelTB.Hint := Format(ss_msg[1], [CompressLevelTB.Position]);
end;

procedure TMainForm.BrowseFolderActExecute(Sender: TObject);
var
  buf               : string;
begin
  if SelectDirectory(handle, ss_msg[2], TmpPathEdt.Text, buf) then
    TmpPathEdt.Text := Buf;
end;

procedure TMainForm.OpenActExecute(Sender: TObject);
begin
  if OpenDlg.Execute then begin
    SourceFileName := OpenDlg.FileName;
    ProcessFile(SourceFileName);
  end;
end;

procedure TMainForm.GetOptions;
var
  Ini               : TIniFile;
  Lan_File          : string;
  i                 : integer;
begin
  Ini := TIniFile.Create(IniFileName);
  /// Init History Menu
  HistoryMenu.Items.Clear;
  MaxHistoryItem := Ini.ReadInteger('Options', 'MaxHistoryItem', 9);
  Font.Color := Ini.ReadInteger('Font', 'Color', Font.Color);
  Font.Name := Ini.ReadString('Font', 'Name', Font.Name);
  Font.Charset := Ini.ReadInteger('Font', 'CharSet', 0);
  Font.Size := Ini.ReadInteger('Font', 'Size', 9);
  for i := 0 to MAXHISTORYITEM do /// Load History Item
    ProcessMenu(Ini.ReadString('History', 'File_' + inttostr(i), ''));
  Lan_File := Ini.ReadString('Options', 'Language', 'English');
  LanguageCB.ItemIndex := LanguageCB.Items.IndexOf(Lan_File);
  Lan_File := ExtractFilePath(ParamStr(0)) + Lan_File + '.Ini';
  if (Lan_File <> '') and FileExists(Lan_File) then
    SetLanguage(Lan_File, ss_msg); /// Init Form Language
  TmpPathEdt.Text := Ini.ReadString('Options', 'TempPath', '%TEMP%');
  if TmpPathEdt.Text = '%TEMP%' then /// Special process for %TEMP%
    TmpDir := pchar(WinTmpDir)
  else TmpDir := TmpPathEdt.Text;
 /// Init Other Options
  CompressLevelTB.Position := ini.ReadInteger('Options', 'Level', 7);
  OverLapOptions.ItemIndex := ini.ReadInteger('Options', 'OverLap', 0);
  IconOptions.ItemIndex := ini.ReadInteger('Options', 'Icon', 2);
  OtherCLB.Checked[0] := Ini.ReadBool('Options', 'Backup', False);
  OtherCLB.Checked[1] := Ini.ReadBool('Options', 'ContextMenu', False);
  OtherCLB.Checked[2] := Ini.ReadBool('Options', 'CompressRes', True);
  OtherCLB.Checked[3] := Ini.ReadBool('Options', 'CompressExport', True);
  OtherCLB.Checked[4] := Ini.ReadBool('Options', 'Strip_Relocs', True);
  OtherCLB.Checked[5] := Ini.ReadBool('Options', 'DefinOutput', False);
  OtherCLB.Checked[6] := Ini.ReadBool('Options', 'Force', False);
  OtherCLB.Checked[7] := Ini.ReadBool('Options', 'Auto', False);
  OtherCLB.Checked[8] := Ini.ReadBool('Options', '8086', True);
  OtherCLB.Checked[9] := Ini.ReadBool('Options', 'AutoSaveConfig', False);
  Ini.Free;
end;

/// Registered Explorer's Context Menu For the Special file type

procedure RegistryFileContext(Ext, ExeFN, Key, Caption: string);
///Ext:Extention Name; ExeFN:Exe File to Open this file type;Key,Caption:use for Registry
var
  reg               : TRegistry;
  buf               : string;
begin
  reg := TRegistry.Create;
  reg.RootKey := HKEY_CLASSES_ROOT;
  if reg.OpenKey(Ext, False) then begin
    buf := reg.ReadString('');
    reg.CloseKey;
    if reg.OpenKey(buf + '\Shell\' + Key, True) then begin
      reg.WriteString('', Caption);
      if reg.OpenKey('Command', True) then
        reg.WriteString('', '"' + ExeFN + '" "%1"');
    end;
  end;
  reg.Free;
end;

/// Delete Context Menu for special file type

procedure DeleteContext(Ext, Key: string);
/// Ext:Extention Name;Key :registry KeyName
var
  buf               : string;
  reg               : TRegistry;
begin
  reg := TRegistry.Create;
  reg.RootKey := HKEY_CLASSES_ROOT;
  if reg.OpenKey(Ext, False) then begin
    buf := reg.ReadString('');
    reg.CloseKey;
    if reg.OpenKey(buf + '\Shell', False) then reg.DeleteKey(Key);
  end;
  reg.Free;
end;

/// save Options

procedure TMainForm.SetOptions;
var
  Ini               : TIniFile;
begin
  Ini := TIniFile.Create(IniFileName);
  Ini.WriteString('Font', 'Name', Font.Name);
  Ini.WriteInteger('Font', 'Size', Font.Size);
  Ini.WriteInteger('Font', 'CharSet', Font.Charset);
  Ini.WriteInteger('Font', 'Color', Font.Color);
  Ini.WriteInteger('Options', 'MaxHistoryItem', MaxHistoryItem);
  Ini.WriteString('Options', 'TempPath', TmpPathEdt.Text);
  ini.WriteInteger('Options', 'Level', CompressLevelTB.Position);
  ini.WriteInteger('Options', 'OverLap', OverLapOptions.ItemIndex);
  ini.WriteInteger('Options', 'Icon', IconOptions.ItemIndex);
  Ini.WriteBool('Options', 'Backup', OtherCLB.Checked[0]);
  Ini.WriteBool('Options', 'ContextMenu', OtherCLB.Checked[1]);
  Ini.WriteBool('Options', 'CompressRes', OtherCLB.Checked[2]);
  Ini.WriteBool('Options', 'CompressExport', OtherCLB.Checked[3]);
  Ini.WriteBool('Options', 'Strip_Relocs', OtherCLB.Checked[4]);
  Ini.WriteBool('Options', 'DefinOutput', OtherCLB.Checked[5]);
  Ini.WriteBool('Options', 'Force', OtherCLB.Checked[6]);
  Ini.WriteBool('Options', 'Auto', OtherCLB.Checked[7]);
  Ini.WriteBool('Options', '8086', OtherCLB.Checked[8]);
  Ini.WriteBool('Options', 'AutoSaveConfig', OtherCLB.Checked[9]);
  Ini.WriteString('Options', 'Language', LanguageCB.Text);
  Ini.Free;
  if OtherCLB.Checked[1] then begin
    RegistryFileContext('.Exe', paramstr(0), REG_KEY, ss_msg[3]);
    RegistryFileContext('.Com', paramstr(0), REG_KEY, ss_msg[3]);
    RegistryFileContext('.Dll', paramstr(0), REG_KEY, ss_msg[3]);
    RegistryFileContext('.Ocx', paramstr(0), REG_KEY, ss_msg[3]);
    RegistryFileContext('.Scr', paramstr(0), REG_KEY, ss_msg[3]);
  end else begin
    DeleteContext('.Exe', REG_KEY);
    DeleteContext('.Scr', REG_KEY);
    DeleteContext('.Com', REG_KEY);
    DeleteContext('.Dll', REG_KEY);
    DeleteContext('.Ocx', REG_KEY);
  end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  WorkDir           : string;
  Rec               : TSearchRec;
begin
  Screen.Cursors[crHandPoint] := LoadCursor(0, IDC_HAND);
  Screen.Cursors[crHourGlass] := LoadCursor(0, IDC_WAIT);
  DeleteMenu(GetSystemMenu(Application.Handle, False), SC_CLOSE, MF_BYCOMMAND);
  DeleteMenu(GetSystemMenu(Application.Handle, False), SC_MINIMIZE, MF_BYCOMMAND);
  DeleteMenu(GetSystemMenu(Application.Handle, False), SC_RESTORE, MF_BYCOMMAND);
  DeleteMenu(GetSystemMenu(Application.Handle, False), 0, MF_SEPARATOR);
  InitFormMenuBitmap;
  SysImgLst := TImageList.Create(self); /// Init ImageList which for the History Menu
  SysImgLst.DrawingStyle := dsTransparent; /// Transparen
  SysImgLst.ShareImages := True; /// Must be ShareImages!
  GetSystemImageList(SysImgLst); /// Load
  HistoryMenu.Images := SysImgLst; /// Assoc With
  Application.OnHint := AppEventsHint;
  DragAcceptFiles(Handle, True); /// Registry File Drag&Drop
  WorkDir := ExtractFilePath(ParamStr(0));
  /// Init for Luanguage Choice
  LanguageCB.Items.Clear;
  if FindFirst(WorkDir + '*.ini', faanyfile, Rec) = 0 then
    LanguageCB.Items.Add(ChangeFileExt(Rec.FindData.cFileName, ''));
  while Findnext(Rec) = 0 do /// Search All Language INI file
    LanguageCB.Items.Add(ChangeFileExt(Rec.FindData.cFileName, ''));
  FindClose(Rec);
  IniFileName := WorkDir + 'Config.Ini'; /// Except
  LanguageCB.Items.Delete(LanguageCB.Items.IndexOf('Config'));
  SetLength(WinTmpDir, MAX_PATH);
  GetTempPath(MAX_PATH, @WinTmpDir[1]); /// Get Windows Temp Directory
  GetOptions; /// Load Options
  if FileExists(WorkDir + 'ReadMe.Txt') then
    AboutMemo.Lines.LoadFromFile(WorkDir + 'ReadMe.Txt')
  else AboutMemo.AnsiText := ss_msg[20];
  UpxExeFileName := WorkDir + UPX_EXEFILENAME;
  if not FileExists(UpxExeFileName) then begin
    UpxExeFileName := pchar(WinTmpDir) + UPX_EXEFILENAME;
    GenUpxExeFile;
  end;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  if ParamCount = 1 then begin /// Process Command Line Parameters
    SourceFileName := ParamStr(1);
    ProcessFile(SourceFileName);
  end else DisableControl(False, False, False, False);
end;

procedure TMainForm.ProcessFile(FileName: string);
begin
  ProcessMenu(FileName); /// Update Menu
  CompressScale.Progress := CompressScale.MinValue;
  OldFileLenEdt.Text := Inttostr(GetFileSize(FileName));
  NewFileLenEdt.Text := '';
  SourceNameEdt.Text := SourceFileName;
  NewNameEdt.Text := SourceFileName;
  case CheckFileFlag of
    efAspack: begin
        StatusLbl.Text := ss_msg[4];
        DisableControl(False, True, False, False);
      end;
    efDos: begin
        StatusLbl.Text := ss_msg[5];
        DisableControl(False, False, False, True);
      end;
    efPackDos: begin
        StatusLbl.Text := ss_msg[6];
        DisableControl(True, False, False, True);
      end;
    efDosPKLite: begin
        StatusLbl.Text := ss_msg[7];
        DisableControl(False, False, False, False);
      end;
    efUpx: begin
        StatusLbl.Text := ss_msg[8];
        DisableControl(True, False, False, False);
      end;
    efPEPack: begin
        StatusLbl.Text := ss_msg[9];
        DisableControl(True, False, False, False);
      end;
    efPE: begin
        StatusLbl.Text := ss_msg[10];
        DisableControl(False, False, False, True);
      end;
  else StatusLbl.Text := ss_msg[11];
    DisableControl(False, False, False, True);
  end;
  if OtherCLB.Checked[7] then CompressAct.Execute;
end;

procedure TMainForm.GenUpxExeFile;
var
  UpxExeStream      : TResourceStream;
begin
  UpxExeStream := TResourceStream.Create(HInstance, 'ExeFile', 'EXEFILE');
  UpxExeStream.SaveToFile(UpxExeFileName);
  UpxExeStream.Free;
end;
/// Free Resource

procedure TMainForm.FormDestroy(Sender: TObject);
var
  i                 : integer;
  ini               : TIniFile;
  Count             : integer;
begin
  SysImgLst.Free;
  if OtherCLB.Checked[9] then SaveOptAct.Execute;
  DeleteFile(pchar(WinTmpDir) + UPX_EXEFILENAME);
  ini := TIniFile.Create(IniFileName);
  Ini.WriteString('Options', 'Language', LanguageCB.Text);
  Ini.EraseSection('History');
  Count := HistoryMenu.Items.Count;
  for i := Count - 1 downto 0 do begin /// Save History
    Ini.WriteString('History', 'File_' + inttostr(Count - i), HistoryMenu.Items[i].Hint);
    HistoryMenu.Items[i].Free;
  end;
  Ini.Free;
end;

function TMainForm.CheckFileFlag: TExeFlag;
label
  quit;
var
  Exe               : TPEFiles;
begin
  Result := efOther;
  Exe := TPEFiles.Create(SourceFileName);
  if Exe.IsUpxFile then begin
    Result := efUpx;
    goto Quit;
  end;
  if Exe.IsDosPKLiteFile then begin
    Result := efDosPKLite;
    goto quit;
  end;
  if Exe.IsAspack then begin
    Result := efAspack;
    goto quit;
  end;
  if Exe.IsPEFile and not Exe.IsUpxFile then begin
    Result := efPE;
    goto Quit;
  end;
  if Exe.IsDosFile then begin
    Result := efDos;
    goto Quit;
  end;
  quit: Exe.Free;
end;

procedure TMainForm.SaveOptActExecute(Sender: TObject);
begin
  SetOptions;
end;

procedure TMainForm.TmpPathEdtChange(Sender: TObject);
begin
  if TmpPathEdt.Text = '%TEMP%' then begin
    TmpPathEdt.Hint := ss_msg[12];
    TmpDir := WinTmpDir;
  end else begin
    TmpPathEdt.Hint := '|' + TmpPathEdt.Text;
    TmpDir := TmpPathEdt.Text;
  end;
end;

procedure TMainForm.EmailActExecute(Sender: TObject);
begin
  ShellExecute(handle, 'open', 'MailTo:Kingron@163.net?subject=About_Upx_For_Win9x/NT/2000', '', '', SW_SHOW);
end;

procedure TMainForm.WWWActExecute(Sender: TObject);
begin
  ShellExecute(handle, 'open', 'explorer', 'http://kingron.myetang.com', nil, SW_SHOW);
end;

procedure TMainForm.CompressActExecute(Sender: TObject);
var
  ErrCode           : integer;
begin
  if not FileExists(UpxExeFileName) then GenUpxExeFile;
  OldFileLenEdt.Text := Inttostr(GetFileSize(SourceFileName));
  try
    Screen.Cursor := crHourGlass;
    Enabled := False;
    ShowStatusHint(ss_msg[13]);
    ErrCode := WinExecExW(pchar(UpxExeFileName), pchar(ProcessCommandLine), pchar(TmpDir), SW_HIDE);
    if ErrCode <> 0 then /// Error
    begin
      StatusLbl.Text := ss_msg[14];
      DisableControl(False, False, False, True);
    end else begin
      StatusLbl.Text := ss_msg[15]; /// Compress Ok
      DisableControl(True, True, True, False);
    end;
    NewFileLenEdt.Text := Inttostr(GetFileSize(NewNameEdt.Text));
    CompressScale.Progress := Round(100 * strtoint(NewFileLenEdt.Text) / strtoint(OldFileLenEdt.Text));
    if OtherCLB.Checked[5] then
      DeCompressAct.Enabled := False;
  finally
    ShowStatusHint('');
    Screen.Cursor := crDefault;
    Enabled := True;
  end;
end;

procedure TMainForm.DisableControl(bDeCom, bTest, bRestore, bCom: boolean);
begin
  DeCompressAct.Enabled := bDeCom;
  TestAct.Enabled := bTest;
  RestoreAct.Enabled := bRestore and OtherClb.Checked[0];
  CompressAct.Enabled := bCom;
end;

function TMainForm.ProcessCommandLine(bCom: boolean = True): string;
var
  sLevel            : string;
  sBackUp           : string;
  sOutput           : string;
  sForce            : string;
  sOverlay          : string;
  sDos              : string;
  sExports          : string;
  sIcons            : string;
  sResource         : string;
  sRelocs           : string;
//  sShortPathName: array[0..MAX_PATH] of char;
begin
//  GetShortPathName(pchar(SourceFileName), sShortPathName, SizeOf(sShortPathName));
  if CompressLevelTB.Position = 10 then
    sLevel := '--best'
  else
    sLevel := Format('-%d', [CompressLevelTB.Position]);
  if OtherCLB.Checked[0] then /// Back up
    sBackUp := '-k';
  if OtherCLB.Checked[5] then /// Define the Output file name
    sOutput := '-o "' + NewNameEdt.Text + '"';
  if CheckFileFlag = efPE then
  begin
    if not OtherCLB.Checked[3] then
      sExports := '--compress-exports=0';
    if not OtherCLB.Checked[2] then
      sResource := 'compress-resources=0';
    if not OtherCLB.Checked[4] then
      sRelocs := '--strip-relocs=0';
    case OverLapOptions.ItemIndex of
      1: sOverlay := '--overlay=strip';
      2: sOverlay := '--overlay=skip';
    end;
    if IconOptions.ItemIndex <> 2 then /// Item 2 for Default
      sIcons := '--compress-icons=' + inttostr(IconOptions.ItemIndex);
  end else if OtherCLB.Checked[8] then sDos := '--8086';
  if not bCom then
    Result := Format(' -d %s %s "%s"', [sBackup, sOutput, SourceFileName])
  else
    Result := Format(' %s %s %s %s %s %s %s %s %s %s "%s"', [sLevel, sForce, sDos, sIcons, sOverlay,
      sResource, sExports, sRelocs, sBackup, sOutput, SourceFileName]);
end;

procedure TMainForm.DeCompressActExecute(Sender: TObject);
begin
  if not FileExists(UpxExeFileName) then GenUpxExeFile;
  try
    Screen.Cursor := crHourGlass;
    Enabled := False;
    ShowStatusHint(ss_msg[16]);
    if WinExecExW(pchar(UpxExeFileName), pchar(ProcessCommandLine(False)), pchar(TmpDir), SW_HIDE) = 0 then
    begin
      StatusLbl.Text := ss_msg[17];
      NewFileLenEdt.Text := inttostr(GetFileSize(NewNameEdt.Text));
      DisableControl(False, True, True, True);
    end else begin
      StatusLbl.Text := ss_msg[18];
      DisableControl(True, False, False, False);
    end;
    CompressAct.Enabled := not OtherCLB.Checked[5];
  finally
    ShowStatusHint('');
    Screen.Cursor := crDefault;
    Enabled := True;
  end;
end;

procedure TMainForm.ActionTBShow(Sender: TObject);
begin
  NewNameEdt.ReadOnly := not OtherCLB.Checked[5];
  SaveAsAct.Enabled := OtherCLB.Checked[5];
  if not SaveAsAct.Enabled then NewNameEdt.Text := SourceNameEdt.Text;
  if not NewNameEdt.ReadOnly then
    NewNameEdt.Color := clLime
  else NewNameEdt.Color := clBtnFace;
end;

procedure TMainForm.SaveAsActExecute(Sender: TObject);
begin
  if SaveDlg.Execute then NewNameEdt.Text := SaveDlg.FileName;
end;

procedure TMainForm.SourceNameEdtChange(Sender: TObject);
begin
  (Sender as TEdit).Hint := '|' + (Sender as TEdit).Text;
end;

procedure TMainForm.TestActExecute(Sender: TObject);
var
  StartupInfo       : TStartupInfo;
  ProcessInfo       : TProcessInformation;
begin
  FillChar(StartupInfo, SizeOf(StartupInfo), #0);
  StartupInfo.cb := SizeOf(StartupInfo);
  StartupInfo.dwFlags := STARTF_USESHOWWINDOW;
  StartupInfo.wShowWindow := sw_show;
  if not CreateProcess(pchar(NewNameEdt.Text), nil, nil, nil, False, Normal_priority_class, nil, nil, StartupInfo, ProcessInfo) then
  begin
    MessageBox(handle, pchar(SysErrorMessage(GetLastError)), pchar(ss_msg[19]), MB_OK + MB_ICONINFORMATION);
    TestAct.Enabled := True;
  end else TestAct.Enabled := False;
end;

procedure TMainForm.RestoreActExecute(Sender: TObject);
var
  fn                : string;
  bakExt            : string;
  fnExt             : string;
  c                 : char;
begin
  fnExt := ExtractFileExt(SourceFileName);
  c := Copy(fnExt, 2, 1)[1];
  case c of
    'e', 'E': begin
        bakExt := '.Ex~';
        fnExt := '.Exe';
      end;
    'c', 'C': begin
        bakExt := '.Co~';
        fnExt := '.Com';
      end;
    'd', 'D': begin
        bakExt := '.Dl~';
        fnExt := '.Dll';
      end;
    'o', 'O': begin
        bakExt := '.Oc~';
        fnExt := '.Ocx';
      end;
    's', 'S': begin
        bakExt := '.Sc~';
        fnExt := '.Scr';
      end;
  end;
  fn := ChangeFileExt(SourceFileName, bakExt);
  if FileExists(fn) then
    if CopyFile(pchar(fn), pchar(SourceFileName), False) then
      DisableControl(False, False, False, False);
end;

procedure TMainForm.LanguageCBChange(Sender: TObject);
begin
  SetLanguage(ExtractFilePath(ParamStr(0)) + LanguageCB.Text + '.Ini', ss_msg);
end;

procedure TMainForm.wmdropfiles(var msg: TMessage);
var
  Buffer            : array[0..255] of Char;
  count             : Integer;
  intX              : Integer;
begin
  count := DragQueryFile(Msg.WParam, $FFFFFFFF, Buffer, 255);
  for intX := 0 to count - 1 do
  begin
    DragQueryFile(Msg.WParam, intX, Buffer, 255);
    SourceFileName := Buffer;
    Application.ProcessMessages;
    ProcessFile(SourceFileName);
    if not OtherCLB.Checked[7] then CompressAct.Execute;
  end;
  DragFinish(Msg.WParam);
end;

/// Hot Track Effect

procedure TMainForm.CmMouseEnter(var msg: TMessage);
begin
  if msg.LParam = integer(RegLbl) then begin
    RegLbl.Font.Color := clBlue; //clMaroon
    RegLbl.Font.Style := [fsUnderLine];
  end;
  if msg.LParam = integer(LogoImage) then LogoImage.Transparent := False;
  if msg.LParam = integer(LogoLbl) then LogoLbl.Font.Color := clRed;
  inherited;
end;

/// hot track effect

procedure TMainForm.CmMouseLeave(var msg: TMessage);
begin
  if msg.LParam = integer(RegLbl) then begin
    RegLbl.Font.Color := clMaroon;
    RegLbl.Font.Style := [];
  end;
  if msg.LParam = integer(LogoImage) then LogoImage.Transparent := True;
  if msg.LParam = integer(LogoLbl) then LogoLbl.Font.Color := clFuchsia;
  inherited;
end;

procedure TMainForm.OverLapOptionsClick(Sender: TObject);
begin
  OverLapOptions.Hint := '|' + OverLapOptions.Items.Strings[OverLapOptions.ItemIndex];
  IconOptions.Hint := '|' + IconOptions.Items.Strings[IconOptions.ItemIndex];
end;

/// Popup the history menu

procedure TMainForm.HistoryMenuPopActExecute(Sender: TObject);
var
  p                 : TPoint;
begin
  p.x := OpenSB.Left + ActionTB.Left;
  p.y := OpenSB.Top + OpenSB.Height + ActionTB.Top + MainPC.Top;
  p := ClientToScreen(p);
  HistoryMenu.Popup(p.x, p.y);
end;

procedure TMainForm.ProcessMenu(fn: string);
var
  Item              : TMenuItem;
  b                 : boolean;
  i                 : integer;
begin
  if fn = '' then exit;
  Item := TMenuItem.Create(HistoryMenu);
  Item.OnClick := HistoryMenuClick;
  Item.ImageIndex := GetIconIndex(fn, 0);
  Item.Caption := fn;
  Item.Hint := fn;
  b := False;
  for i := 0 to HistoryMenu.Items.Count - 1 do
    if lowercase(HistoryMenu.Items[i].Hint) = Lowercase(fn) then begin
      b := True;
      break;
    end;
  if not b then
    HistoryMenu.Items.Insert(0, Item)
  else Item.Free;
  if HistoryMenu.Items.Count > MaxHistoryItem then
    HistoryMenu.Items[HistoryMenu.Items.Count - 1].Free;
end;

procedure TMainForm.HistoryMenuClick(Sender: TObject);
var
  Temp              : TMenuItem;
  Item              : TMenuItem;
begin
  Temp := TMenuItem.Create(HistoryMenu);
  Item := Sender as TMenuItem;
  Temp.Caption := Item.Caption;
  Temp.OnClick := Item.OnClick;
  Temp.Hint := Item.Hint;
  Temp.ImageIndex := Item.ImageIndex;
  HistoryMenu.Items.Insert(0, Temp);
  Item.Free;
  SourceFileName := Temp.Hint;
  if Hi(GetKeyState(VK_SHIFT)) <> 0 then
    ShellExecute(handle, 'Open', pchar(SourceFileName), nil, nil, SW_SHOW)
  else ProcessFile(SourceFileName);
end;

procedure TMainForm.HistorySbMouseLeave(Sender: TObject);
begin
  HistorySb.Refresh;
  OpenSB.Refresh;
end;

procedure TMainForm.HistorySbMouseEnter(Sender: TObject);
var
  r                 : TRect;
begin
  R := OpenSB.BoundsRect;
  DrawEdge(GetDC(ActionTB.handle), r, BDR_RAISEDINNER, 1 or BF_RECT);
  R := HistorySb.BoundsRect;
  DrawEdge(GetDC(ActionTB.handle), r, BDR_RAISEDINNER, 1 or BF_RECT);
end;

procedure TMainForm.ClearHistoryActExecute(Sender: TObject);
begin
  HistoryMenu.Items.Clear;
end;

procedure TMainForm.ExitMenuClick(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.InitFormMenuBitmap;
var
  bmp               : TBitmap;
begin
  bmp := TBitmap.Create;
  Bmp.Handle := OpenSb.Glyph.MaskHandle;
  Images.Add(OpenSb.Glyph, bmp);

  Bmp.Handle := CompressSb.Glyph.MaskHandle;
  Images.Add(CompressSb.Glyph, bmp);

  Bmp.Handle := DeCompressSb.Glyph.MaskHandle;
  Images.Add(DeCompressSb.Glyph, bmp);

  Bmp.Handle := TestSb.Glyph.MaskHandle;
  Images.Add(TestSb.Glyph, bmp);

  Bmp.Handle := RestoreSb.Glyph.MaskHandle;
  Images.Add(RestoreSb.Glyph, bmp);

  Bmp.Handle := BrowseSb.Glyph.MaskHandle;
  Images.Add(BrowseSb.Glyph, bmp);

  Bmp.Handle := ClearHistorySb.Glyph.MaskHandle;
  Images.Add(ClearHistorySb.Glyph, bmp);

  Bmp.Handle := SaveConfigSb.Glyph.MaskHandle;
  Images.Add(SaveConfigSb.Glyph, bmp);

  Bmp.Handle := MailSb.Glyph.MaskHandle;
  Images.Add(MailSb.Glyph, bmp);

  Bmp.Handle := WwwSb.Glyph.MaskHandle;
  Images.Add(WwwSb.Glyph, bmp);
  Bmp.Free;
end;

procedure TMainForm.FormContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin
  if (Hi(GetKeyState(VK_SHIFT)) <> 0) or (Hi(GetKeyState(VK_LBUTTON)) <> 0) then
  begin
    Handled := True;
    HistoryMenu.Popup(Mouse.CursorPos.x, Mouse.CursorPos.y);
  end;
end;

procedure TMainForm.FormResize(Sender: TObject);
begin
  OtherClb.ItemHeight := OtherClb.Height div OtherClb.Items.Count;
  RegLbl.Refresh;
end;

procedure TMainForm.ChangMaxHistActExecute(Sender: TObject);
begin
  MaxHistoryItem := StrtoInt(InputBox(ss_msg[21], ss_msg[22], IntToStr(MaxHistoryItem)));
end;

procedure TMainForm.ChangeFontActExecute(Sender: TObject);
begin
  FontDlg.Font := Font;
  if FontDlg.Execute then Font := FontDlg.Font;
end;

procedure TMainForm.OtherCLBMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  i                 : integer;
begin
  i := OtherCLB.ItemAtPos(Point(x, y), False);
  if i > OtherCLB.Items.Count - 1 then i := OtherCLB.Items.Count - 1;
  OtherClb.Hint := OtherClb.Items.Strings[i];
  application.ActivateHint(Mouse.CursorPos);
end;

procedure TMainForm.AboutMemoURLClick(Sender: TObject;
  const URLText: String; Button: TMouseButton);
var
  URL:string;
begin
  if Pos('://',URLText)= 0 then URL:='http://'+URLText else URL:=URLText;
  ShellExecute(handle,'open','explorer.exe',pchar(URL),nil,SW_SHOW);
end;

end.

