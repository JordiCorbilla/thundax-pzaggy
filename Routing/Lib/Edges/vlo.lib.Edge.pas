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
unit vlo.lib.Edge;

interface

uses
  types, Graphics, Classes, vlo.lib.XML.Serializer, XMLDoc, XMLIntf,
  vlo.lib.Edge.contracts, vlo.lib.Edge.Points;

type
  TTypeEdge = (SimpleEdge, SimpleArrowEdge, SimpleDoubleArrowEdge, SimpleDoubleLinkedArrowEdge,
                DottedEdge, DottedArrowEdge, DottedDoubleArrowEdge, DottedDoubleLinkedArrowEdge, noEdge);
  TArrowKind = (Normal, Fashion);

  TDrawable = class(TInterfacedObject, IArrow, IEdge, IDottedEdge, ISerializable)
    procedure DrawArrow(Source, Target: TPoint); virtual; abstract;
    procedure DrawFashionArrow(Source, Target: TPoint); virtual; abstract;
    procedure DrawEdge(Source, Target: TPoint; SourceI, TargetI: TPoint); virtual; abstract;
    procedure DrawDottedEdge(Source, Target: TPoint; SourceI, TargetI: TPoint); virtual; abstract;
    function MarshalToXML(XMLDoc: IXMLDocument; iXMLRootNode: IXMLNode; sNode: string): IXMLNode; virtual; abstract;
    function UnMarshalFromXML(XMLDoc: IXMLDocument; iXMLRootNode: IXMLNode; sNode: string): IXMLNode; virtual; abstract;
  end;

function PointEx(X, Y: Extended): TPointEx;

var
  kleefPenStyle: array [1 .. 2] of DWORD = (10, 10);

implementation

uses
  Windows, Math, SysUtils, vlo.lib.Math.Line, vlo.lib.GUID.Generator, StrUtils, vlo.lib.Math, vlo.lib.zoom;

function PointEx(X, Y: Extended): TPointEx;
begin
  Result.X := X;
  Result.Y := Y;
end;



end.
