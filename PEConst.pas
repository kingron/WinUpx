unit PEConst;

interface

uses windows, Sysutils;

type
  TPEFiles = class
  Private
    FFileHandle: integer;
    FFileName: string;
    FDosHeader: TImageDosHeader;
    FWinHeader: TImageNTHeaders;
    FSectionHeaderArray: array of TImageSectionHeader;
    procedure OpenPEFile;
    procedure ClosePEFile;
  Public
    destructor Destroy; Override;
    constructor Create(FileName: string);
    function IsPEFile: boolean;
    function IsAspack: boolean;
    function IsDosFile: boolean;
    function IsUpxFile: boolean;
    function IsDosPKLiteFile:boolean;
  end;

implementation

{ TPEFiles }

procedure TPEFiles.ClosePEFile;
begin
  if FFileHandle <> 0 then
    FileClose(FFileHandle);
end;

constructor TPEFiles.Create(FileName: string);
begin
  inherited Create;
  FillChar(FDosHeader, SizeOf(FDosHeader), 0);
  FillChar(FWinHeader, SizeOf(FWinHeader), 0);
  if FileExists(FileName) then
  begin
    FFileName := FileName;
    OpenPEFile;
  end;
end;

destructor TPEFiles.Destroy;
begin
  ClosePEFile;
  inherited;
end;

function TPEFiles.IsAspack: boolean;
var
  nRead: integer;
  p: pchar;
begin
  Result := False;
  for nRead := Low(FSectionHeaderArray) to High(FSectionHeaderArray) do
  begin
    p := @FSectionHeaderArray[nRead].Name[0];
    if Lowercase(p) = '.aspack'  then
    begin
      Result := True;
      break;
    end;
  end;
end;

function TPEFiles.IsDosFile: boolean;
begin
  Result := (FDosHeader.e_magic = $5A4D) and not IsPEFile;
end;

function TPEFiles.IsDosPKLiteFile: boolean;
begin                         //PK                             LI                              TE
  Result:=(FDosHeader.e_res[1]=19280) and (FDosHeader.e_res[2]=18764) and (FDosHeader.e_res[3]=17748);
end;

function TPEFiles.IsPEFile: boolean;
begin
  Result := (FWinHeader.Signature = IMAGE_NT_SIGNATURE); ///'PE#0#0'
end;

function TPEFiles.IsUpxFile: boolean;
var
  nRead: integer;
  p: pchar;
begin
  Result := False;
  for nRead := Low(FSectionHeaderArray) to High(FSectionHeaderArray) do
  begin
    p := @FSectionHeaderArray[nRead].Name[0];
    if (p = 'UPX0') or (p = 'UPX1') or (p = 'UPX2') then
    begin
      Result := True;
      break;
    end;
  end;
end;

procedure TPEFiles.OpenPEFile;
var
  nRead: integer;
begin
  FFileHandle := FileOpen(FFileName, fmOpenRead);
  nRead := FileRead(FFileHandle, FDosHeader, SizeOf(FDosHeader));
  if nRead = SizeOf(FDosHeader) then
  begin
    FileSeek(FFileHandle, FDosHeader._lfanew, 0);
    nRead := FileRead(FFileHandle, FWinHeader, SizeOf(FWinHeader));
    if nRead = SizeOf(FWinHeader) then ///
    begin
      SetLength(FSectionHeaderArray, FWinHeader.FileHeader.NumberOfSections);
      FileRead(FFileHandle, FSectionHeaderArray[0], SizeOf(TImageSectionHeader) * FWinHeader.FileHeader.NumberOfSections);
    end;
  end;
end;

end.

