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
unit vlo.lib.Edge.Adapter;

interface

uses
  vlo.lib.Edge, Graphics, Classes, SysUtils;

type
  TAdaptedEdge = class(TObject)
    FObject: TAbstractEdge;
    procedure getProperties(const Abstract1: TAbstractEdge; var Abstract2: TAbstractEdge);
    constructor Create(kind: TTypeEdge; obj: TAbstractEdge);
  end;

function getAdaptedLine(kind: TTypeEdge; obj: TAbstractEdge): TAbstractEdge;

implementation

{ TAdaptedLine }

constructor TAdaptedEdge.Create(kind: TTypeEdge; obj: TAbstractEdge);
var
  simple: TSimpleEdgesFactory;
  dotted: TDottedEdgesFactory;
begin
  simple := TSimpleEdgesFactory.Create(obj.FCanvas);
  dotted := TDottedEdgesFactory.Create(obj.FCanvas);
  case kind of
    SimpleEdge:
      FObject := simple.GetEdge;
    SimpleArrowEdge:
      FObject := simple.GetEdgeArrow;
    SimpleDoubleArrowEdge:
      FObject := simple.GetEdgeDoubleArrow;
    SimpleDoubleLinkedArrowEdge:
      FObject := simple.GetEdgeLinkedArrow;
    DottedEdge:
      FObject := dotted.GetEdge;
    DottedArrowEdge:
      FObject := dotted.GetEdgeArrow;
    DottedDoubleArrowEdge:
      FObject := dotted.GetEdgeDoubleArrow;
    DottedDoubleLinkedArrowEdge:
      FObject := dotted.GetEdgeLinkedArrow;
    noEdge:
      FObject := nil;
  end;
  getProperties(obj, FObject);
  FreeAndNil(simple);
  FreeAndNil(dotted);
end;

function getAdaptedLine(kind: TTypeEdge; obj: TAbstractEdge): TAbstractEdge;
var
  adapted: TAdaptedEdge;
  resObj: TAbstractEdge;
begin
  adapted := TAdaptedEdge.Create(kind, obj);
  resObj := adapted.FObject;
  FreeAndNil(adapted);
  result := resObj;
end;

procedure TAdaptedEdge.getProperties(const Abstract1: TAbstractEdge; var Abstract2: TAbstractEdge);
begin
  Abstract2.FSource := Abstract1.FSource;
  Abstract2.FTarget := Abstract1.FTarget;
  Abstract2.FBendPoint[0] := Abstract1.FBendPoint[0];
  Abstract2.FBendPoint[1] := Abstract1.FBendPoint[1];
  Abstract2.FBendPoint[2] := Abstract1.FBendPoint[2];
  Abstract2.FBendModified[0] := Abstract1.FBendModified[0];
  Abstract2.FBendModified[1] := Abstract1.FBendModified[1];
  Abstract2.FBendModified[2] := Abstract1.FBendModified[2];
  Abstract2.Properties.Assign(Abstract1.Properties);
  Abstract2.ArrowKind := Abstract1.ArrowKind;
  Abstract2.Inside := Abstract1.Inside;
end;

end.
