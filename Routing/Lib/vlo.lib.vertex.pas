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
unit vlo.lib.vertex;

interface

uses
  vlo.lib.XML.Serializer, XMLDoc, XMLIntf, types, SysUtils;

type
  TVertex = class(TInterfacedObject, ISerializable)
  private
    Fx: double;
    Fy: double;
    procedure SetX(x: double);
    procedure SetY(y: double);
    function GetPosition(): TPoint;
  public
    property x: double read Fx write SetX;
    property y: double read Fy write SetY;
    property Position: TPoint read GetPosition;
    function Inside(x, y: double): boolean;
    procedure Move(x, y: double);
    constructor Create(x, y: double);
    function MarshalToXML(XMLDoc: IXMLDocument; iXMLRootNode: IXMLNode; sNode: string): IXMLNode;
    function UnMarshalFromXML(XMLDoc: IXMLDocument; iXMLRootNode: IXMLNode; sNode: string): IXMLNode;
  end;

function DistancePoints(node1: TVertex; node2: TVertex): double;

implementation

uses
  vlo.lib.zoom, StrUtils;

{ TVertex }

constructor TVertex.Create(x, y: double);
begin
  Fx := x;
  Fy := y;
end;

function TVertex.GetPosition: TPoint;
begin
  result := Point(Round(Fx), Round(Fy));
end;

function TVertex.Inside(x, y: double): boolean;
var
  xinside: boolean;
  yinside: boolean;
  pt: TPoint;
begin
  try
    pt := TZoom.ClientToGraph(Fx, Fy);
    xinside := (pt.x + 2 >= x) and (pt.x - 2 <= x);
    yinside := (pt.y + 2 >= y) and (pt.y - 2 <= y);
  except
    // result := false;
  end;
  result := xinside and yinside;
end;

function TVertex.MarshalToXML(XMLDoc: IXMLDocument; iXMLRootNode: IXMLNode; sNode: string): IXMLNode;
begin
  iXMLRootNode.attributes['Fx'] := FloatToStr(Self.Fx);
  iXMLRootNode.attributes['Fy'] := FloatToStr(Self.Fy);
end;

procedure TVertex.Move(x, y: double);
begin
  x := x * globalZoom / 100;
  y := y * globalZoom / 100;
  Fx := Fx + x;
  Fy := Fy + y;
end;

procedure TVertex.SetX(x: double);
begin
  Fx := x;
end;

procedure TVertex.SetY(y: double);
begin
  Fy := y;
end;

function TVertex.UnMarshalFromXML(XMLDoc: IXMLDocument; iXMLRootNode: IXMLNode; sNode: string): IXMLNode;
var
  Coordenate: string;
begin
  if iXMLRootNode.NodeName = sNode then
  begin
    Coordenate := StringReplace(iXMLRootNode.attributes['Fx'], ',', '.', [rfReplaceAll, rfIgnoreCase]);
    Self.Fx := StrToFloat(Coordenate);
    Self.Fy := StrToFloat(StringReplace(iXMLRootNode.attributes['Fy'], ',', '.', [rfReplaceAll, rfIgnoreCase]));
  end;
end;

function DistancePoints(node1: TVertex; node2: TVertex): double;
begin
  result := Sqrt(sqr(node1.x - node2.x) + sqr(node1.y - node2.y));
end;

end.
