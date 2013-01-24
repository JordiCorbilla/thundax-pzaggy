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
unit vlo.lib.parser;

interface

uses Classes;

type
  TLineParser = class(TObject)
    class function GetNextToken(Const S: string; Separator: char; var StartPos: integer): String;
    class procedure Split(const S: String; Separator: char; MyStringList: TStringList);
    class function AddToken(const aToken, S: String; Separator: char; StringLimit: integer): String;
    class function TokenList(): TStringList;
    class function IsKeyWord(S: string): Boolean;
    class function IsSeparator(Car: char): Boolean;
    class function NextWord(var S: string; var PrevWord: string; var isFinal: Boolean): string;
    class function IsNumber(S: string): Boolean;
  end;

implementation

Uses Sysutils;

class function TLineParser.GetNextToken(Const S: string; Separator: char; var StartPos: integer): String;
var
  Index: integer;
begin
  Result := '';
  While (S[StartPos] = Separator) and (StartPos <= length(S)) do
    StartPos := StartPos + 1;
  if StartPos > length(S) then
    Exit;
  Index := StartPos;
  While (S[Index] <> Separator) and (Index <= length(S)) do
    Index := Index + 1;
  Result := Copy(S, StartPos, Index - StartPos);
  StartPos := Index + 1;
end;

class procedure TLineParser.Split(const S: String; Separator: char; MyStringList: TStringList);
var
  Start: integer;
begin
  Start := 1;
  While Start <= length(S) do
    MyStringList.Add(GetNextToken(S, Separator, Start));
end;

class function TLineParser.AddToken(const aToken, S: String; Separator: char; StringLimit: integer): String;
begin
  if length(aToken) + length(S) < StringLimit then
  begin
    if S = '' then
      Result := ''
    else
      Result := S + Separator;
    Result := Result + aToken;
  end
  else
    Raise Exception.Create('Cannot add token');
end;

class function TLineParser.IsSeparator(Car: char): Boolean;
begin
  case Car of
    '.', ';', ',', ':', '¡', '!', '·', '"', '''', '^', '+', '-', '*', '/', '\', '¨', ' ', '`', '[', ']', '(', ')', 'º', 'ª', '{', '}', '?', '¿', '%', '=':
      Result := True;
  else
    Result := False;
  end;
end;

class function TLineParser.NextWord(var S: string; var PrevWord: string; var isFinal: Boolean): string;
begin
  Result := '';
  PrevWord := '';
  if S = '' then
    Exit;
  isFinal := False;
  while (S <> '') and IsSeparator(S[1]) do
  begin
    isFinal := S[1] = ';';
    PrevWord := PrevWord + S[1];
    Delete(S, 1, 1);
  end;
  while (S <> '') and not IsSeparator(S[1]) do
  begin
    Result := Result + S[1];
    Delete(S, 1, 1);
  end;
end;

class function TLineParser.IsKeyWord(S: string): Boolean;
var
  i: integer;
  tokens: TStringList;
begin
  Result := False;
  if S = '' then
    Exit;
  tokens := TokenList;
  for i := 0 to tokens.Count - 1 do
  begin
    if tokens[i] = AnsiUpperCase(S) then
    begin
      Result := True;
      break;
    end;
  end;
  FreeAndNil(tokens);
end;

class function TLineParser.IsNumber(S: string): Boolean;
var
  i: integer;
begin
  Result := False;
  for i := 1 to length(S) do
    case S[i] of
      '0' .. '9':
        ;
    else
      Exit;
    end;
  Result := True;
end;

class function TLineParser.TokenList(): TStringList;
var
  res: TStringList;
begin
  res := TStringList.Create;
  res.Add('LAYOUT');
  res.Add('NODE');
  res.Add('TONODE');
  res.Add('PARAMETERS');
  res.Add(AnsiUpperCase('SimpleEdge'));
  res.Add(AnsiUpperCase('SimpleArrowEdge'));
  res.Add(AnsiUpperCase('SimpleDoubleArrowEdge'));
  res.Add(AnsiUpperCase('SimpleDoubleLinkedArrowEdge'));
  res.Add(AnsiUpperCase('DottedEdge'));
  res.Add(AnsiUpperCase('DottedArrowEdge'));
  res.Add(AnsiUpperCase('DottedDoubleArrowEdge'));
  res.Add(AnsiUpperCase('DottedDoubleLinkedArrowEdge'));
  res.Add(AnsiUpperCase('EdgeType'));
  res.Add(AnsiUpperCase('SizeBox'));
  res.Add(AnsiUpperCase('LineColor'));
  res.Add(AnsiUpperCase('PenWidth'));

  res.Add(AnsiUpperCase('clBlack'));
  res.Add(AnsiUpperCase('clMaroon'));
  res.Add(AnsiUpperCase('clGreen'));
  res.Add(AnsiUpperCase('clOlive'));
  res.Add(AnsiUpperCase('clNavy'));
  res.Add(AnsiUpperCase('clPurple'));
  res.Add(AnsiUpperCase('clTeal'));
  res.Add(AnsiUpperCase('clGray'));
  res.Add(AnsiUpperCase('clSilver'));
  res.Add(AnsiUpperCase('clRed'));
  res.Add(AnsiUpperCase('clLime'));
  res.Add(AnsiUpperCase('clYellow'));
  res.Add(AnsiUpperCase('clBlue'));
  res.Add(AnsiUpperCase('clFuchsia'));
  res.Add(AnsiUpperCase('clAqua'));
  res.Add(AnsiUpperCase('clLtGray'));
  res.Add(AnsiUpperCase('clDkGray'));
  res.Add(AnsiUpperCase('clWhite'));
  Result := res;
end;

end.
