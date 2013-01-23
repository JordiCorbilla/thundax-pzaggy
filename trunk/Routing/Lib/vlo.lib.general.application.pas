(*
  * Copyright (c) 2010-2013 Thundax P-Zaggy (VLO Framework)
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
  * modification, are permitted provided that the following conditions are
  * met:
  *
  * * Redistributions of source code must retain the above copyright
  *   notice, this list of conditions and the following disclaimer.
  *
  * * Redistributions in binary form must reproduce the above copyright
  *   notice, this list of conditions and the following disclaimer in the
  *   documentation and/or other materials provided with the distribution.
  *
  * * Neither the name of 'Thundax P-Zaggy' nor the names of its contributors
  *   may be used to endorse or promote products derived from this software
  *   without specific prior written permission.
  *
  * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
  * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
  * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
  * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
  * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
  * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
  * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
  * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
  * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
  * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *)
unit vlo.lib.general.application;

interface

uses
  Windows, SysUtils, ShlObj;

type
  TAppHelper = class
    class function GetAppVersion: string;
    class function GetFolderDialog(Handle: Integer; Caption: string; var strFolder: string): Boolean;
    class function BrowseCallbackProc(hwnd: hwnd; uMsg: UINT; lParam, lpData: lParam): Integer; stdcall; static;
  end;

implementation

class function TAppHelper.BrowseCallbackProc(hwnd: hwnd; uMsg: UINT; lParam: lParam; lpData: lParam): Integer; stdcall;
begin
  if (uMsg = BFFM_INITIALIZED) then
    SendMessage(hwnd, BFFM_SETSELECTION, 1, lpData);
  BrowseCallbackProc := 0;
end;

class function TAppHelper.GetFolderDialog(Handle: Integer; Caption: string; var strFolder: string): Boolean;
const
  BIF_STATUSTEXT = $0004;
  BIF_NEWDIALOGSTYLE = $0040;
  BIF_RETURNONLYFSDIRS = $0080;
  BIF_SHAREABLE = $0100;
  BIF_USENEWUI = BIF_EDITBOX or BIF_NEWDIALOGSTYLE;
var
  BrowseInfo: TBrowseInfo;
  ItemIDList: PItemIDList;
  JtemIDList: PItemIDList;
  Path: PWideChar;
begin
  Result := False;
  Path := StrAlloc(MAX_PATH);
  SHGetSpecialFolderLocation(Handle, CSIDL_DRIVES, JtemIDList);
  with BrowseInfo do
  begin
    hwndOwner := GetActiveWindow;
    pidlRoot := JtemIDList;
    SHGetSpecialFolderLocation(hwndOwner, CSIDL_DRIVES, JtemIDList);
    pszDisplayName := StrAlloc(MAX_PATH);
    lpszTitle := PChar(Caption);
    lpfn := @BrowseCallbackProc;
    lParam := LongInt(PChar(strFolder));
  end;
  ItemIDList := SHBrowseForFolder(BrowseInfo);
  if (ItemIDList <> nil) then
    if SHGetPathFromIDList(ItemIDList, Path) then
    begin
      strFolder := Path;
      Result := True
    end;
end;

class function TAppHelper.GetAppVersion: string;
var
  Size, Size2: DWord;
  Pt, Pt2: Pointer;
begin
  Size := GetFileVersionInfoSize(PChar(ParamStr(0)), Size2);
  if Size > 0 then
  begin
    GetMem(Pt, Size);
    try
      GetFileVersionInfo(PChar(ParamStr(0)), 0, Size, Pt);
      VerQueryValue(Pt, '\', Pt2, Size2);
      with TVSFixedFileInfo(Pt2^) do
      begin
        Result := ' v' + IntToStr(HiWord(dwFileVersionMS)) + '.' +
          IntToStr(LoWord(dwFileVersionMS)) + '.' +
          IntToStr(HiWord(dwFileVersionLS)) + ' Build ' +
          IntToStr(LoWord(dwFileVersionLS));
      end;
    finally
      FreeMem(Pt);
    end;
  end;
end;

end.
