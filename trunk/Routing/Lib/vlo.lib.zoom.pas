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
unit vlo.lib.zoom;

interface

uses
  Classes, Windows, vlo.lib.vertex;

type
  TPointR = record
    x: double;
    y: double;
  end;

  TZoom = class(TObject)
    class function ClientToGraph(x, y: Integer): TPoint; overload;
    class function ClientToGraph(x, y: double): TPoint; overload;
    class function ClientToGraph(v: TPoint): TPoint; overload;
    class function ClientToGraph(v: TPoint; optionalZoom: Integer): TPoint; overload;
    class function ClientToGraph(v: TVertex): TPoint; overload;
    class function GraphToClient(x, y: Integer): TPoint; overload;
    class function GraphToClient(x, y: double): TPointR; overload;
    class function GraphToClient(p: TPoint): TPoint; overload;
    class function GraphToClient(p: TPoint; optionalZoom: Integer): TPoint; overload;
  end;

var
  globalZoom: Integer;
  lastZoom: Integer;

implementation

class function TZoom.ClientToGraph(x, y: Integer): TPoint;
begin
  result.x := Muldiv(x, 100, globalZoom);
  result.y := Muldiv(y, 100, globalZoom);
end;

class function TZoom.ClientToGraph(x, y: double): TPoint;
begin
  result.x := Muldiv(round(x), 100, globalZoom);
  result.y := Muldiv(round(y), 100, globalZoom);
end;

class function TZoom.ClientToGraph(v: TPoint): TPoint;
begin
  result.x := Muldiv(v.x, 100, globalZoom);
  result.y := Muldiv(v.y, 100, globalZoom);
end;

class function TZoom.ClientToGraph(v: TPoint; optionalZoom: Integer): TPoint;
begin
  result.x := v.x + ((v.x * optionalZoom) div 100);
  result.y := v.y + ((v.y * optionalZoom) div 100);
  // result.x := Muldiv(v.x, 100, optionalZoom);
  // result.y := Muldiv(v.y, 100, optionalZoom);
end;

class function TZoom.ClientToGraph(v: TVertex): TPoint;
begin
  result.x := Muldiv(round(v.x), 100, globalZoom);
  result.y := Muldiv(round(v.y), 100, globalZoom);
end;

class function TZoom.GraphToClient(x, y: Integer): TPoint;
begin
  result.x := Muldiv(x, globalZoom, 100);
  result.y := Muldiv(y, globalZoom, 100);
end;

class function TZoom.GraphToClient(x, y: double): TPointR;
begin
  result.x := x * globalZoom / 100;
  result.y := y * globalZoom / 100;
end;

class function TZoom.GraphToClient(p: TPoint): TPoint;
begin
  result.x := Muldiv(p.x, globalZoom, 100);
  result.y := Muldiv(p.y, globalZoom, 100);
end;

class function TZoom.GraphToClient(p: TPoint; optionalZoom: Integer): TPoint;
begin
  // result.x := Muldiv(p.x, optionalZoom, 100);
  // result.y := Muldiv(p.y, optionalZoom, 100);
  result.x := p.x - ((p.x * optionalZoom) div 100);
  result.y := p.y - ((p.y * optionalZoom) div 100);
end;

initialization

globalZoom := 100;
lastZoom := 100;

end.
