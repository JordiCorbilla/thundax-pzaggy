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
unit vlo.lib.XML.Serializer;

interface

uses
  XMLDoc, XMLIntf, Graphics;

type
  ISerializable = interface
    ['{67BF6F2C-A41B-4C8E-9233-89A6F1B4D79D}']
    function MarshalToXML(XMLDoc: IXMLDocument; iXMLRootNode: IXMLNode; sNode: string): IXMLNode;
    function UnMarshalFromXML(XMLDoc: IXMLDocument; iXMLRootNode: IXMLNode; sNode: string): IXMLNode;
  end;

function FontSerializer(objFont: TFont; XMLDoc: IXMLDocument; iXMLRootNode: IXMLNode; sNode: string): IXMLNode; overload;
function FontDeserializer(objFont: TFont; XMLDoc: IXMLDocument; iXMLRootNode: IXMLNode; sNode: string): IXMLNode; overload;

implementation

uses
  SysUtils, Windows;

function FontSerializer(objFont: TFont; XMLDoc: IXMLDocument; iXMLRootNode: IXMLNode; sNode: string): IXMLNode;
  function iif(condition: boolean; resultTrue: integer; resultFalse: integer): integer;
  begin
    result := resultFalse;
    if condition then
      result := resultTrue
  end;

begin
  iXMLRootNode.attributes['Name'] := objFont.Name;
  iXMLRootNode.attributes['Size'] := IntToStr(objFont.Size);
  iXMLRootNode.attributes['Color'] := IntToStr(objFont.Color);

  iXMLRootNode.attributes['fsBold'] := IntToStr(iif(fsBold in objFont.Style, FW_BOLD, FW_NORMAL));
  iXMLRootNode.attributes['fsItalic'] := IntToStr(iif(fsItalic in objFont.Style, 1, 0));
  iXMLRootNode.attributes['fsUnderline'] := IntToStr(iif(fsUnderline in objFont.Style, 1, 0));
  iXMLRootNode.attributes['fsStrikeOut'] := IntToStr(iif(fsStrikeOut in objFont.Style, 1, 0));
end;

function FontDeserializer(objFont: TFont; XMLDoc: IXMLDocument; iXMLRootNode: IXMLNode; sNode: string): IXMLNode;
begin
  objFont.Name := iXMLRootNode.attributes['Name'];
  objFont.Size := StrToInt(iXMLRootNode.attributes['Size']);
  objFont.Color := StrToInt(iXMLRootNode.attributes['Color']);
  if StrToInt(iXMLRootNode.attributes['fsBold']) = FW_BOLD then
    objFont.Style := objFont.Style + [fsBold];

  if StrToInt(iXMLRootNode.attributes['fsItalic']) = 1 then
    objFont.Style := objFont.Style + [fsItalic];

  if StrToInt(iXMLRootNode.attributes['fsUnderline']) = 1 then
    objFont.Style := objFont.Style + [fsUnderline];

  if StrToInt(iXMLRootNode.attributes['fsStrikeOut']) = 1 then
    objFont.Style := objFont.Style + [fsStrikeOut];
end;

end.
