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
unit vlo.lib.properties.Edge;

interface

uses
  vlo.lib.properties.abstract, XMLDoc, XMLIntf;

type
  TEdgeProperty = class(TAbstractProperty)
  private
    FLenArrow: integer;
    FInclinationAngle: integer;
    procedure SetInclinationAngle(const Value: integer);
    procedure SetLenArrow(const Value: integer);
  public
    property LenArrow: integer read FLenArrow write SetLenArrow;
    property InclinationAngle: integer read FInclinationAngle write SetInclinationAngle;
    function MarshalToXML(XMLDoc: IXMLDocument; iXMLRootNode: IXMLNode; sNode: string): IXMLNode; override;
    function UnMarshalFromXML(XMLDoc: IXMLDocument; iXMLRootNode: IXMLNode; sNode: string): IXMLNode; override;
    procedure Assign(obj: TObject); override;
    constructor Create();
    destructor Destroy(); override;
  end;

implementation

uses
  SysUtils;

{ TEdgeProperty }

procedure TEdgeProperty.Assign(obj: TObject);
var
  absObj: TEdgeProperty;
begin
  inherited Assign(obj);
  if obj is TEdgeProperty then
  begin
    absObj := (obj as TEdgeProperty);
    if absObj <> nil then
    begin
      Self.FLenArrow := absObj.LenArrow;
      Self.FInclinationAngle := absObj.InclinationAngle;
    end;
  end;
end;

constructor TEdgeProperty.Create;
begin
  inherited;
  FLenArrow := 20;
  FInclinationAngle := 20;
end;

destructor TEdgeProperty.Destroy;
begin
  inherited;
end;

function TEdgeProperty.MarshalToXML(XMLDoc: IXMLDocument; iXMLRootNode: IXMLNode; sNode: string): IXMLNode;
begin
  iXMLRootNode.attributes['FLenArrow'] := IntToStr(Self.FLenArrow);
  iXMLRootNode.attributes['FInclinationAngle'] := IntToStr(Self.FInclinationAngle);
  inherited MarshalToXML(XMLDoc, iXMLRootNode, sNode);
end;

procedure TEdgeProperty.SetInclinationAngle(const Value: integer);
begin
  FInclinationAngle := Value;
end;

procedure TEdgeProperty.SetLenArrow(const Value: integer);
begin
  FLenArrow := Value;
end;

function TEdgeProperty.UnMarshalFromXML(XMLDoc: IXMLDocument; iXMLRootNode: IXMLNode; sNode: string): IXMLNode;
begin
  Self.FLenArrow := StrToInt(iXMLRootNode.attributes['FLenArrow']);
  Self.FInclinationAngle := StrToInt(iXMLRootNode.attributes['FInclinationAngle']);
  inherited UnMarshalFromXML(XMLDoc, iXMLRootNode, sNode);
end;

end.
