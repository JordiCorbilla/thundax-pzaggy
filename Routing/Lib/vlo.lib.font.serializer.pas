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
unit vlo.lib.font.serializer;

interface

uses
  vlo.lib.properties.Abstract, inifiles, Graphics;

type
  TFontParser = class(TObject)
    class procedure Serializer(ini: TIniFile; section: String; objFont: TFont); overload;
    class procedure Deserializer(ini: TIniFile; section: String; var objFont: TAbstractProperty); overload;
    //class procedure Deserializer(ini: TIniFile; section: String; var objFont: TEdgeProperty); overload;
  end;

const
  Fdesc = 'Font';

implementation

uses
  SysUtils, Windows;

class procedure TFontParser.Serializer(ini: TIniFile; section: String; objFont: TFont);
  function iif(condition: boolean; resultTrue: integer; resultFalse: integer): integer;
  begin
    result := resultFalse;
    if condition then
      result := resultTrue
  end;

begin
  if Assigned(ini) and Assigned(objFont) then
  begin
    ini.WriteString(section, Fdesc + 'Name', objFont.Name);
    ini.WriteString(section, Fdesc + 'Size', IntToStr(objFont.Size));
    ini.WriteString(section, Fdesc + 'Color', IntToStr(objFont.Color));

    ini.WriteString(section, Fdesc + 'fsBold', IntToStr(iif(fsBold in objFont.Style, FW_BOLD, FW_NORMAL)));
    ini.WriteString(section, Fdesc + 'fsItalic', IntToStr(iif(fsItalic in objFont.Style, 1, 0)));
    ini.WriteString(section, Fdesc + 'fsUnderline', IntToStr(iif(fsUnderline in objFont.Style, 1, 0)));
    ini.WriteString(section, Fdesc + 'fsStrikeOut', IntToStr(iif(fsStrikeOut in objFont.Style, 1, 0)));
  end;
end;

class procedure TFontParser.Deserializer(ini: TIniFile; section: String; var objFont: TAbstractProperty);
begin
  if Assigned(ini) and Assigned(objFont) then
  begin
    objFont.FontText.Name := ini.ReadString(section, Fdesc + 'Name', 'Calibri');
    objFont.FontText.Size := StrToInt(ini.ReadString(section, Fdesc + 'Size', '12'));
    objFont.FontText.Color := StrToInt(ini.ReadString(section, Fdesc + 'Color', '0'));
    if StrToInt(ini.ReadString(section, Fdesc + 'fsBold', '0')) = FW_BOLD then
      objFont.FontText.Style := objFont.FontText.Style + [fsBold];

    if StrToInt(ini.ReadString(section, Fdesc + 'fsItalic', '0')) = 1 then
      objFont.FontText.Style := objFont.FontText.Style + [fsItalic];

    if StrToInt(ini.ReadString(section, Fdesc + 'fsUnderline', '0')) = 1 then
      objFont.FontText.Style := objFont.FontText.Style + [fsUnderline];

    if StrToInt(ini.ReadString(section, Fdesc + 'fsStrikeOut', '0')) = 1 then
      objFont.FontText.Style := objFont.FontText.Style + [fsStrikeOut];
  end;
end;

//class procedure TFontParser.Deserializer(ini: TIniFile; section: String; var objFont: TAbstractProperty);
//begin
//  if Assigned(ini) and Assigned(objFont) then
//  begin
//    objFont.FontText.Name := ini.ReadString(section, Fdesc + 'Name', 'Calibri');
//    objFont.FontText.Size := StrToInt(ini.ReadString(section, Fdesc + 'Size', '12'));
//    objFont.FontText.Color := StrToInt(ini.ReadString(section, Fdesc + 'Color', '0'));
//    if StrToInt(ini.ReadString(section, Fdesc + 'fsBold', '0')) = FW_BOLD then
//      objFont.FontText.Style := objFont.FontText.Style + [fsBold];
//
//    if StrToInt(ini.ReadString(section, Fdesc + 'fsItalic', '0')) = 1 then
//      objFont.FontText.Style := objFont.FontText.Style + [fsItalic];
//
//    if StrToInt(ini.ReadString(section, Fdesc + 'fsUnderline', '0')) = 1 then
//      objFont.FontText.Style := objFont.FontText.Style + [fsUnderline];
//
//    if StrToInt(ini.ReadString(section, Fdesc + 'fsStrikeOut', '0')) = 1 then
//      objFont.FontText.Style := objFont.FontText.Style + [fsStrikeOut];
//  end;
//end;

end.
