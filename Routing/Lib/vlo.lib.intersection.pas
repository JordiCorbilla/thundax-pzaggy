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
unit vlo.lib.intersection;

interface

uses
  vlo.lib.Node, Types;

type
  Tline = array [1 .. 2] of TPoint; { starting and ending points of a line segment }

  TInstersection = class(Tobject)
    class function Linesintersect(line1, line2: Tline; var position: TPoint): boolean;
    class function GetPointInter(Source, Dest: TNode): TPoint; overload;
    class function GetPointInter(Source: TPoint; Dest: TNode): TPoint; overload;
  end;

implementation

uses
  Math, vlo.lib.Math;

{ TInstersection }

class function TInstersection.Linesintersect(line1, line2: Tline; var position: TPoint): boolean;
  procedure getequation(line: Tline; var slope, intercept: extended);
  begin
    if line[1].x <> line[2].x then
      slope := (line[2].y - line[1].y) / (line[2].x - line[1].x)
    else
      slope := 1E100;
    intercept := line[1].y - slope * line[1].x;
  end;

  function overlap(const x, y: extended; const line: Tline): boolean;
  begin
    if (x >= min(line[1].x, line[2].x)) and (x <= max(line[1].x, line[2].x)) and (y >= min(line[1].y, line[2].y)) and (y <= max(line[1].y, line[2].y)) then
      result := true
    else
      result := false;
  end;

var
  m1, m2, b1, b2: extended;
  x, y: extended;

begin
  result := false;
  x := 0;
  y := 0;
  try
    getequation(line1, m1, b1);
    getequation(line2, m2, b2);
  except
    //
  end;
  if m1 <> m2 then
  begin

    try
      x := round((b2 - b1) / (m1 - m2));
      if abs(m1) < abs(m2) then
        y := round(m1 * x + b1)
      else
        y := round(m2 * x + b2);
    except

    end;
    if ((line1[1].x - x) * (x - line1[2].x) >= 0) and ((line1[1].y - y) * (y - line1[2].y) >= 0) and ((line2[1].x - x) * (x - line2[2].x) >= 0) and ((line2[1].y - y) * (y - line2[2].y) >= 0) then
      result := true;
  end
  else if Comparar(b1, b2, '=') then
  begin
    with line1[1] do
      result := overlap(x, y, line2);
    if not result then
      with line1[2] do
        result := overlap(x, y, line2);
    if not result then
      with line2[1] do
        result := overlap(x, y, line1);
    if not result then
      with line2[2] do
        result := overlap(x, y, line1);
  end;
  if result then
    position := Point(round(x), round(y));
end;

class function TInstersection.GetPointInter(Source, Dest: TNode): TPoint;
var
  l: Tline;
  l2: Tline;
  points: TPoint;
begin
  points := Point(-1, -1);
  l[1] := Source.Center.position;
  l[2] := Dest.Center.position;

  l2[1] := Dest.Vertex1;
  l2[2] := Dest.Vertex4;
  try
    if Linesintersect(l, l2, points) then
      result := points
    else
    begin
      l2[1] := Dest.Vertex1;
      l2[2] := Dest.Vertex3;
      if Linesintersect(l, l2, points) then
        result := points
      else
      begin
        l2[1] := Dest.Vertex3;
        l2[2] := Dest.Vertex2;
        if Linesintersect(l, l2, points) then
          result := points
        else
        begin
          l2[1] := Dest.Vertex2;
          l2[2] := Dest.Vertex4;
          if Linesintersect(l, l2, points) then
            result := points
        end;
      end;
    end;
  except
    //
  end;
end;

class function TInstersection.GetPointInter(Source: TPoint; Dest: TNode): TPoint;
var
  l: Tline;
  l2: Tline;
  points: TPoint;
  resPoint: TPoint;
begin
  points := Point(-1, -1);
  resPoint := points;
  l[1] := Source;
  l[2] := Dest.Center.position;

  l2[1] := Dest.Vertex1;
  l2[2] := Dest.Vertex4;
  try
    if Linesintersect(l, l2, points) then
      resPoint := points
    else
    begin
      l2[1] := Dest.Vertex1;
      l2[2] := Dest.Vertex3;
      if Linesintersect(l, l2, points) then
        resPoint := points
      else
      begin
        l2[1] := Dest.Vertex3;
        l2[2] := Dest.Vertex2;
        if Linesintersect(l, l2, points) then
          resPoint := points
        else
        begin
          l2[1] := Dest.Vertex2;
          l2[2] := Dest.Vertex4;
          if Linesintersect(l, l2, points) then
            resPoint := points
        end;
      end;
    end;
  except
    //
  end;
  result := resPoint;
end;

end.
