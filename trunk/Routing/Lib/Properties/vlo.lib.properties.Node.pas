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
unit vlo.lib.properties.Node;

interface

uses
  vlo.lib.properties.abstract, XMLDoc, XMLIntf, Graphics;

type
  TNodeProperty = class(TAbstractProperty)
  private
    FzOrder: integer;
    FColorFontifImage: TColor;
    FColorNodeifImage: TColor;
    FColorBorderIfImage: TColor;
    procedure SetzOrder(const Value: integer);
    procedure SetColorFontifImage(const Value: TColor);
    procedure SetColorBorderIfImage(const Value: TColor);
    procedure SetColorNodeifImage(const Value: TColor);
  public
    property zOrder: integer read FzOrder write SetzOrder;
    property ColorFontifImage: TColor read FColorFontifImage write SetColorFontifImage;
    property ColorNodeifImage: TColor read FColorNodeifImage write SetColorNodeifImage;
    property ColorBorderIfImage: TColor read FColorBorderIfImage write SetColorBorderIfImage;
    function MarshalToXML(XMLDoc: IXMLDocument; iXMLRootNode: IXMLNode; sNode: string): IXMLNode; override;
    function UnMarshalFromXML(XMLDoc: IXMLDocument; iXMLRootNode: IXMLNode; sNode: string): IXMLNode; override;
    procedure Assign(obj: TObject); override;
    constructor Create();
    destructor Destroy(); override;
  end;

implementation

uses
  SysUtils, Variants;

{ TNodeProperty }

procedure TNodeProperty.Assign(obj: TObject);
var
  absObj: TNodeProperty;
begin
  inherited Assign(obj);
  if obj is TNodeProperty then
  begin
    absObj := (obj as TNodeProperty);
    if absObj <> nil then
    begin
      Self.FzOrder := absObj.zOrder;
      Self.FColorFontifImage := absObj.FColorFontifImage;
      Self.FColorNodeifImage := absObj.FColorNodeifImage;
      Self.FColorBorderIfImage := absObj.FColorBorderIfImage;
    end;
  end;
end;

constructor TNodeProperty.Create;
begin
  FzOrder := 99999;
  inherited;
end;

destructor TNodeProperty.Destroy;
begin
  inherited;
end;

function TNodeProperty.MarshalToXML(XMLDoc: IXMLDocument; iXMLRootNode: IXMLNode; sNode: string): IXMLNode;
begin
  iXMLRootNode.attributes['FzOrder'] := IntToStr(Self.FzOrder);
  iXMLRootNode.attributes['FColorFontifImage'] := IntToStr(Self.FColorFontifImage);
  iXMLRootNode.attributes['FColorNodeifImage'] := IntToStr(Self.FColorNodeifImage);
  iXMLRootNode.attributes['FColorBorderifImage'] := IntToStr(Self.FColorBorderIfImage);
  inherited MarshalToXML(XMLDoc, iXMLRootNode, sNode);
end;

procedure TNodeProperty.SetColorBorderIfImage(const Value: TColor);
begin
  FColorBorderIfImage := Value;
end;

procedure TNodeProperty.SetColorFontifImage(const Value: TColor);
begin
  FColorFontifImage := Value;
end;

procedure TNodeProperty.SetColorNodeifImage(const Value: TColor);
begin
  FColorNodeifImage := Value;
end;

procedure TNodeProperty.SetzOrder(const Value: integer);
begin
  FzOrder := Value;
end;

function TNodeProperty.UnMarshalFromXML(XMLDoc: IXMLDocument; iXMLRootNode: IXMLNode; sNode: string): IXMLNode;
begin
  Self.FzOrder := StrToInt(iXMLRootNode.attributes['FzOrder']);
  try
    if iXMLRootNode.attributes['FColorFontifImage'] <> null then
      Self.FColorFontifImage := StrToInt(iXMLRootNode.attributes['FColorFontifImage'])
    else
      Self.FColorFontifImage := clWhite;
  except
    Self.FColorFontifImage := clWhite;
  end;
  try
    if iXMLRootNode.attributes['FColorNodeifImage'] <> null then
      Self.FColorNodeifImage := StrToInt(iXMLRootNode.attributes['FColorNodeifImage'])
    else
      Self.FColorFontifImage := clWhite;
  except
    Self.FColorNodeifImage := clWhite;
  end;
  try
    if iXMLRootNode.attributes['FColorBorderifImage'] <> null then
      Self.FColorBorderIfImage := StrToInt(iXMLRootNode.attributes['FColorBorderifImage'])
    else
      Self.FColorFontifImage := clWhite;
  except
    Self.FColorBorderIfImage := clWhite;
  end;
  inherited UnMarshalFromXML(XMLDoc, iXMLRootNode, sNode);
end;

end.




