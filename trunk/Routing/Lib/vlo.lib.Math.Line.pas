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
unit vlo.lib.Math.Line;

interface

uses
  Windows,
  Forms,
  ExtCtrls;

type
  TLineSelected = (lsNotSelected, lsPoint1, lsPoint2, lsLine);

  TLineOrientation = (loPoint, loHorizontal, loVertical);

  TVector = record
    StartPoint: TPoint;
    EndPoint: TPoint;
  end;

  TFigure = (TRectangle, TTriangle, TCircle);

  TPolygon = record
    X, Y: Real;
    case Tipo: TFigure of
      TRectangle:
        (Height, Width: Real);
      TTriangle:
        (Side1, Side2, Angle: Real);
      TCircle:
        (Radius: Real);
  end;

  TFigureType = (toLine, toPolygon);

  TObjeto = record
    Numero: integer;
    case Tipo: TFigureType of
      toLine:
        (line: TVector);
      toPolygon:
        (polygon: TPolygon);
  end;

  TMathLine = class(TObject)
    class function AddPoints(const PointA, PointB: TPoint): TPoint;
    class function SubtractPoints(const PointA, PointB: TPoint): TPoint;
    class procedure CalcParameters(const PointA, PointB: TPoint; var Slope, Intercept: double; var LineOrientation: TLineOrientation);
    class function Near(const Target, Point1, Point2: TPoint): BOOLEAN;
    class procedure RestrictCursorToDrawingArea(const Image: TImage);
    class procedure RemoveCursorRestrictions;
    class function SquareContainsPoint(const SquareCenter: TPoint; const SquareHalfSize: integer; const TestPoint: TPoint): BOOLEAN;
    class function Distance(p1, p2: TPoint): double;
  end;

implementation

uses
  Math,
  Classes;

class function TMathLine.AddPoints(const PointA, PointB: TPoint): TPoint;
begin
  result.X := PointA.X + PointB.X;
  result.Y := PointA.Y + PointB.Y
end;

class function TMathLine.SubtractPoints(const PointA, PointB: TPoint): TPoint;
begin
    result.X := PointA.X - PointB.X;
    result.Y := PointA.Y - PointB.Y
end;

class procedure TMathLine.CalcParameters(const PointA, PointB: TPoint; var Slope, Intercept: double; var LineOrientation: TLineOrientation);
var
  difference: TPoint;
begin
  difference := SubtractPoints(PointB, PointA);

  if (difference.X = 0) and (difference.Y = 0) then
  begin
    LineOrientation := loPoint;
    Slope := 0.0;
    Intercept := 0.0
  end
  else
  begin
    if ABS(difference.X) >= ABS(difference.Y) then
    begin
      LineOrientation := loHorizontal;
      try
        Slope := difference.Y / difference.X
      except
        Slope := 0.0
      end;
      Intercept := PointA.Y - PointA.X * Slope;
    end
    else
    begin
      LineOrientation := loVertical;
      try
        Slope := difference.X / difference.Y;
      except
        Slope := 0.0
      end;
      Intercept := PointA.X - PointA.Y * Slope;
    end

  end
end;

class function TMathLine.Near(const Target, Point1, Point2: TPoint): BOOLEAN;
const
  LineSelectFuzz = 4;
var
  Intercept: double;
  LineOrientation: TLineOrientation;
  maxX: integer;
  maxY: integer;
  minX: integer;
  minY: integer;
  Slope: double;
  xCalculated: integer;
  yCalculated: integer;
begin
  result := FALSE;
  CalcParameters(Point1, Point2, Slope, Intercept, LineOrientation);

  case LineOrientation of
    loHorizontal:
      begin
        minX := MinIntValue([Point1.X, Point2.X]);
        maxX := MaxIntValue([Point1.X, Point2.X]);
        if (Target.X >= minX) and (Target.X <= maxX) then
        begin
          yCalculated := round(Slope * Target.X + Intercept);
          if ABS(yCalculated - Target.Y) <= LineSelectFuzz then
            result := TRUE
        end
      end;

    loVertical:
      begin
        minY := MinIntValue([Point1.Y, Point2.Y]);
        maxY := MaxIntValue([Point1.Y, Point2.Y]);
        if (Target.Y >= minY) and (Target.Y <= maxY) then
        begin
          xCalculated := round(Slope * Target.Y + Intercept);
          if ABS(xCalculated - Target.X) <= LineSelectFuzz then
            result := TRUE
        end
      end;

    loPoint:
      begin

      end;
  end
end;

class procedure TMathLine.RestrictCursorToDrawingArea(const Image: TImage);
var
  CursorClipArea: TRect;
begin
  CursorClipArea := Bounds(Image.ClientOrigin.X, Image.ClientOrigin.Y, Image.Width, Image.Height);
  Windows.ClipCursor(@CursorClipArea)
end;

class procedure TMathLine.RemoveCursorRestrictions;
begin
  Windows.ClipCursor(nil)
end;

class function TMathLine.SquareContainsPoint(const SquareCenter: TPoint; const SquareHalfSize: integer; const TestPoint: TPoint): BOOLEAN;
begin
  result := (TestPoint.X >= SquareCenter.X - SquareHalfSize) and (TestPoint.X <= SquareCenter.X + SquareHalfSize) and (TestPoint.Y >= SquareCenter.Y - SquareHalfSize) and
    (TestPoint.Y <= SquareCenter.Y + SquareHalfSize)
end;

class function TMathLine.Distance(p1, p2: TPoint): double;
begin
  try
    result := sqrt(sqr(p1.X - p2.X) + sqr(p1.Y - p2.Y));
  except
    result := 0;
  end;
end;

end.
