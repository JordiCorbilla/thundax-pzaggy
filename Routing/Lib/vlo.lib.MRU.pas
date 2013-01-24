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
unit vlo.lib.MRU;

interface

uses
  menus, iniFiles;

type
  TMRU = class(TObject)
    sCaption: array [0 .. 4] of string;
    sPath: array [0 .. 4] of string;
  private
    function GetCaption(Index: Integer): string;
    procedure SetCaption(Index: Integer; Value: string);
    function GetPath(Index: Integer): string;
    procedure SetPath(Index: Integer; Value: string);
  public
    property Caption[Index: Integer]: string read GetCaption write SetCaption;
    property Path[Index: Integer]: string read GetPath write SetPath;
    constructor create();
  end;

  TMRUGather = Class(TObject)
  private
    FMRU: TMRU;
    FMenuItems: array [0 .. 4] of TMenuItem;
    FSeparator: TMenuItem;
    FIniFile: TInifile;
    procedure GetElements();
    procedure SetMRU(const Value: TMRU);
    procedure LoadMRUtoMENU();
  public
    property MRU: TMRU read FMRU write SetMRU;
    constructor create(ini: String; MRU1, MRU2, MRU3, MRU4, MRU5: TMenuItem; separator: TMenuItem);
    destructor Destroy(); override;
    procedure Clear;
    procedure AddToMRU(Path: string; Caption: string);
  End;

implementation

uses
  SysUtils;

{ MRUObject }

constructor TMRU.create;
begin
  self.sCaption[0] := 'MRU1';
  self.sCaption[1] := 'MRU2';
  self.sCaption[2] := 'MRU3';
  self.sCaption[3] := 'MRU4';
  self.sCaption[4] := 'MRU5';

  self.sPath[0] := '';
  self.sPath[1] := '';
  self.sPath[2] := '';
  self.sPath[3] := '';
  self.sPath[4] := '';
end;

function TMRU.GetCaption(Index: Integer): string;
begin
  if (Index >= 0) and (Index <= 4) then
    Result := sCaption[Index]
  else
    Result := '';
end;

function TMRU.GetPath(Index: Integer): string;
begin
  if (Index >= 0) and (Index <= 4) then
    Result := sPath[Index]
  else
    Result := '';
end;

procedure TMRU.SetCaption(Index: Integer; Value: string);
begin
  if (Index >= 0) and (Index <= 4) then
    sCaption[Index] := Value;
end;

procedure TMRU.SetPath(Index: Integer; Value: string);
begin
  if (Index >= 0) and (Index <= 4) then
    sPath[Index] := Value;
end;

{ MRUGather }

procedure TMRUGather.AddToMRU(Path, Caption: string);
var
  MRU1, MRU2, MRU3, MRU4, MRU5: TMenuItem;
  i: Integer;
begin
  MRU1 := FMenuItems[0];
  MRU2 := FMenuItems[1];
  MRU3 := FMenuItems[2];
  MRU4 := FMenuItems[3];
  MRU5 := FMenuItems[4];

  if MRU1.Caption = 'MRU1' then
  begin
    MRU1.Caption := Caption;
    MRU1.Hint := Path;
    MRU.Caption[0] := Caption;
    MRU.Path[0] := Path;
  end
  else if MRU2.Caption = 'MRU2' then
  begin
    MRU2.Caption := Caption;
    MRU2.Hint := Path;
    MRU.Caption[1] := Caption;
    MRU.Path[1] := Path;
  end
  else if MRU3.Caption = 'MRU3' then
  begin
    MRU3.Caption := Caption;
    MRU3.Hint := Path;
    MRU.Caption[2] := Caption;
    MRU.Path[2] := Path;
  end
  else if MRU4.Caption = 'MRU4' then
  begin
    MRU4.Caption := Caption;
    MRU4.Hint := Path;
    MRU.Caption[3] := Caption;
    MRU.Path[3] := Path;
  end
  else if MRU5.Caption = 'MRU5' then
  begin
    MRU5.Caption := Caption;
    MRU5.Hint := Path;
    MRU.Caption[4] := Caption;
    MRU.Path[4] := Path;
  end
  else if (MRU1.Caption <> 'MRU1') and (MRU2.Caption <> 'MRU2') and (MRU3.Caption <> 'MRU3') and (MRU4.Caption <> 'MRU4') and (MRU5.Caption <> 'MRU5') then
  begin
    MRU5.Caption := MRU4.Caption;
    MRU5.Hint := MRU4.Hint;
    MRU4.Caption := MRU3.Caption;
    MRU4.Hint := MRU3.Hint;
    MRU3.Caption := MRU2.Caption;
    MRU3.Hint := MRU2.Hint;
    MRU2.Caption := MRU1.Caption;
    MRU2.Hint := MRU1.Hint;

    MRU1.Caption := Caption;
    MRU1.Hint := Path;
    for i := 0 to 3 do
    begin
      MRU.Caption[4 - i] := MRU.Caption[3 - i];
      MRU.Path[4 - i] := MRU.Path[3 - i];
    end;
    MRU.Caption[0] := Caption;
    MRU.Path[0] := Path;
  end;

  for i := 0 to 4 do
  begin
    FIniFile.WriteString('MENU', 'MRU' + intToStr(i + 1), MRU.Caption[i]);
    FIniFile.WriteString('MENU', 'PATHMRU' + intToStr(i + 1), MRU.Path[i]);
  end;
  LoadMRUtoMENU();
end;

procedure TMRUGather.Clear;
var
  i: Integer;
begin
  for i := 0 to 4 do
  begin
    FMenuItems[i].Caption := 'MRU' + intToStr(i + 1);
  end;
  for i := 0 to 4 do
  begin
    FIniFile.WriteString('MENU', 'MRU' + intToStr(i + 1), 'MRU' + intToStr(i + 1));
    FIniFile.WriteString('MENU', 'PATHMRU' + intToStr(i + 1), 'PATHMRU' + intToStr(i + 1));
  end;
  LoadMRUtoMENU();
end;

constructor TMRUGather.create(ini: String; MRU1, MRU2, MRU3, MRU4, MRU5: TMenuItem; separator: TMenuItem);
begin
  FMRU := TMRU.create();
  FMenuItems[0] := MRU1;
  FMenuItems[1] := MRU2;
  FMenuItems[2] := MRU3;
  FMenuItems[3] := MRU4;
  FMenuItems[4] := MRU5;
  FSeparator := separator;
  FIniFile := TInifile.create(ini);
  GetElements();
  LoadMRUtoMENU();
end;

destructor TMRUGather.Destroy;
begin
  FreeAndNil(FIniFile);
  FreeAndNil(FMRU);
  inherited;
end;

procedure TMRUGather.GetElements();
var
  i: Integer;
begin
  for i := 0 to 4 do
  begin
    MRU.Caption[i] := FIniFile.ReadString('MENU', 'MRU' + intToStr(i + 1), 'MRU' + intToStr(i + 1));
    MRU.Path[i] := FIniFile.ReadString('MENU', 'PATHMRU' + intToStr(i + 1), '');
    FMenuItems[i].Caption := MRU.Caption[i];
    FMenuItems[i].Hint := MRU.Caption[i];
  end;
end;

procedure TMRUGather.LoadMRUtoMENU();
var
  i: Integer;
  allVisible: boolean;
begin
  allVisible := true;
  for i := 0 to 4 do
  begin
    FMenuItems[i].Visible := (FMenuItems[i].Caption <> 'MRU' + intToStr(i + 1));
    allVisible := allVisible and FMenuItems[i].Visible;
  end;
  FSeparator.Visible := allVisible;
end;

procedure TMRUGather.SetMRU(const Value: TMRU);
begin
  FMRU := Value;
end;

end.
