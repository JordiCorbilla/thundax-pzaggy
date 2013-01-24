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
  types, Graphics, Classes, vlo.lib.XML.Serializer, XMLDoc, XMLIntf, vlo.lib.properties.Edge;

type
  TPointEx = packed record
    X: Extended;
    Y: Extended;
  end;

  TTypeEdge = (SimpleEdge, SimpleArrowEdge, SimpleDoubleArrowEdge, SimpleDoubleLinkedArrowEdge, DottedEdge, DottedArrowEdge, DottedDoubleArrowEdge, DottedDoubleLinkedArrowEdge, noEdge);
  TArrowKind = (Normal, Fashion);

  IArrow = interface(IInterface)
    ['{5A1664E5-C09F-45E4-B90E-19EE1625AFF3}']
    procedure DrawArrow(Source, Target: TPoint);
    procedure DrawFashionArrow(Source, Target: TPoint);
  end;

  IEdge = interface(IInterface)
    ['{B18EAAFF-30DA-4556-91A7-FC15720997E5}']
    procedure DrawEdge(Source, Target: TPoint; SourceI, TargetI: TPoint);
  end;

  IDottedEdge = interface(IInterface)
    ['{F989821E-10F1-4A25-AB3F-D4F3720D9409}']
    procedure DrawDottedEdge(Source, Target: TPoint; SourceI, TargetI: TPoint);
  end;

  TDrawable = class(TInterfacedObject, IArrow, IEdge, IDottedEdge, ISerializable)
    procedure DrawArrow(Source, Target: TPoint); virtual; abstract;
    procedure DrawFashionArrow(Source, Target: TPoint); virtual; abstract;
    procedure DrawEdge(Source, Target: TPoint; SourceI, TargetI: TPoint); virtual; abstract;
    procedure DrawDottedEdge(Source, Target: TPoint; SourceI, TargetI: TPoint); virtual; abstract;
    function MarshalToXML(XMLDoc: IXMLDocument; iXMLRootNode: IXMLNode; sNode: string): IXMLNode; virtual; abstract;
    function UnMarshalFromXML(XMLDoc: IXMLDocument; iXMLRootNode: IXMLNode; sNode: string): IXMLNode; virtual; abstract;
  end;

  // F[0]....F[1]....F[2] (Construcció de la línia)

  TAbstractEdge = class(TDrawable)
  private
    FArrowKind: TArrowKind;
    FAttachedObject: Pointer;
    Fid: string;
    FProperties: TEdgeProperty;
    FInside: boolean;
    procedure SetArrowKind(const Value: TArrowKind);
    procedure SetInside(const Value: boolean);
    function Distance(p1, p2: TPoint): double;
    procedure SetAttachedObject(const Value: Pointer);
    procedure Setid(const Value: string);
    procedure SetProperties(const Value: TEdgeProperty);
    procedure GetPointsToDrawText(Source, Target: TPoint; var First, Last: TPoint);
  public
    FSource: TPoint;
    FTarget: TPoint;
    FSourceInterSection: TPoint;
    FTargetInterSection: TPoint;
    FCanvas: TCanvas;
    FBendPoint: Array [0 .. 2] of TPoint;
    FBendModified: Array [0 .. 2] of boolean;
    property Inside: boolean read FInside write SetInside;
    property properties: TEdgeProperty read FProperties write SetProperties;
    property id: string read Fid write Setid;
    property ArrowKind: TArrowKind read FArrowKind write SetArrowKind;
    property AttachedObject: Pointer read FAttachedObject write SetAttachedObject;
    procedure Draw(Source, Target: TPoint; SourceI, TargetI: TPoint); virtual; abstract;
    constructor Create(Canvas: TCanvas);
    destructor Destroy(); override;
    procedure DrawArrow(Source, Target: TPoint); override;
    procedure DrawFashionArrow(Source, Target: TPoint); override;
    procedure DrawEdge(Source, Target: TPoint; SourceI, TargetI: TPoint); override;
    procedure DrawDottedEdge(Source, Target: TPoint; SourceI, TargetI: TPoint); override;
    procedure DrawTextOrientation(Source, Target: TPoint);
    procedure DrawText(Source, Target: TPoint);
    function CalcAngleTwoPoints(Source, Target: TPoint): double;
    function PointOnLine(p: TPoint): boolean;
    function MarshalToXML(XMLDoc: IXMLDocument; iXMLRootNode: IXMLNode; sNode: string): IXMLNode; override;
    function UnMarshalFromXML(XMLDoc: IXMLDocument; iXMLRootNode: IXMLNode; sNode: string): IXMLNode; override;
    function Clone: TAbstractEdge;
    procedure DrawImageLink(Source, Target: TPoint);
    procedure CalculatePoints(Source, Target: TPoint);
    function InsideVertex(Index: integer; X, Y: integer): boolean;
    procedure Move(Index: integer; X, Y: integer); overload;
    function GetLastModified(): TPoint;
    function GetFirstModified(): TPoint;
    procedure Move(X, Y: integer); overload;
  end;

  TAbstractSimpleEdge = class(TAbstractEdge)
    procedure Draw(Source, Target: TPoint; SourceI, TargetI: TPoint); override;
  end;

  TAbstractSimpleArrowEdge = class(TAbstractEdge)
    procedure Draw(Source, Target: TPoint; SourceI, TargetI: TPoint); override;
  end;

  TAbstractSimpleDoubleArrowEdge = class(TAbstractEdge)
    procedure Draw(Source, Target: TPoint; SourceI, TargetI: TPoint); override;
  end;

  TAbstractSimpleDoubleLinkedArrowEdge = class(TAbstractEdge)
    procedure Draw(Source, Target: TPoint; SourceI, TargetI: TPoint); override;
  end;

  TAbstractDottedEdge = class(TAbstractEdge)
    procedure Draw(Source, Target: TPoint; SourceI, TargetI: TPoint); override;
  end;

  TAbstractDottedArrowEdge = class(TAbstractEdge)
    procedure Draw(Source, Target: TPoint; SourceI, TargetI: TPoint); override;
  end;

  TAbstractDottedDoubleArrowEdge = class(TAbstractEdge)
    procedure Draw(Source, Target: TPoint; SourceI, TargetI: TPoint); override;
  end;

  TAbstractDottedDoubleLinkedArrowEdge = class(TAbstractEdge)
    procedure Draw(Source, Target: TPoint; SourceI, TargetI: TPoint); override;
  end;

  TAbstractFactory = class(TObject)
  private
    FCanvas: TCanvas;
  public
    constructor Create(Canvas: TCanvas);
    destructor Destroy; override;
    function GetEdge(): TAbstractEdge; virtual; abstract;
    function GetEdgeArrow(): TAbstractEdge; virtual; abstract;
    function GetEdgeDoubleArrow(): TAbstractEdge; virtual; abstract;
    function GetEdgeLinkedArrow(): TAbstractEdge; virtual; abstract;
    function GetEdgeByName(name: string): TAbstractEdge; virtual; abstract;
  end;

  TSimpleEdgesFactory = class(TAbstractFactory)
  public
    constructor Create(Canvas: TCanvas);
    destructor Destroy; override;
    function GetEdge(): TAbstractEdge; override;
    function GetEdgeArrow(): TAbstractEdge; override;
    function GetEdgeDoubleArrow(): TAbstractEdge; override;
    function GetEdgeLinkedArrow(): TAbstractEdge; override;
    function GetEdgeByName(name: string): TAbstractEdge; override;
  end;

  TDottedEdgesFactory = class(TAbstractFactory)
  public
    constructor Create(Canvas: TCanvas);
    destructor Destroy; override;
    function GetEdge(): TAbstractEdge; override;
    function GetEdgeArrow(): TAbstractEdge; override;
    function GetEdgeDoubleArrow(): TAbstractEdge; override;
    function GetEdgeLinkedArrow(): TAbstractEdge; override;
    function GetEdgeByName(name: string): TAbstractEdge; override;
  end;

function PointEx(X, Y: Extended): TPointEx;

var
  kleefPenStyle: array [1 .. 2] of DWORD = (
    10,
    10
  );

implementation

uses
  Windows, Math, SysUtils, vlo.lib.Math.Line, vlo.lib.GUID.Generator, StrUtils, vlo.lib.Math, vlo.lib.zoom;

function PointEx(X, Y: Extended): TPointEx;
begin
  Result.X := X;
  Result.Y := Y;
end;

{ TSimpleEdgesFactory }

constructor TSimpleEdgesFactory.Create(Canvas: TCanvas);
begin
  inherited;
end;

destructor TSimpleEdgesFactory.Destroy;
begin
  inherited;
end;

function TSimpleEdgesFactory.GetEdge(): TAbstractEdge;
begin
  Result := TAbstractSimpleEdge.Create(FCanvas);
end;

function TSimpleEdgesFactory.GetEdgeArrow(): TAbstractEdge;
begin
  Result := TAbstractSimpleArrowEdge.Create(FCanvas);
end;

function TSimpleEdgesFactory.GetEdgeByName(name: string): TAbstractEdge;
begin
  Result := nil;
  if (name = 'TAbstractSimpleEdge') or (name = 'TAbstractSimpleLine') then
    Result := GetEdge();
  if (name = 'TAbstractSimpleArrowEdge') or (name = 'TAbstractSimpleArrowLine') then
    Result := GetEdgeArrow();
  if (name = 'TAbstractSimpleDoubleArrowEdge') or (name = 'TAbstractSimpleDoubleArrowLine') then
    Result := GetEdgeDoubleArrow();
  if (name = 'TAbstractSimpleDoubleLinkedArrowEdge') or (name = 'TAbstractSimpleDoubleLinkedArrowLine') then
    Result := GetEdgeLinkedArrow();
end;

function TSimpleEdgesFactory.GetEdgeDoubleArrow(): TAbstractEdge;
begin
  Result := TAbstractSimpleDoubleArrowEdge.Create(FCanvas);
end;

function TSimpleEdgesFactory.GetEdgeLinkedArrow: TAbstractEdge;
begin
  Result := TAbstractSimpleDoubleLinkedArrowEdge.Create(FCanvas);
  Result.properties.FillColor := clBlue;
  Result.properties.Filled := true;
end;

{ TAbstractFactory }

constructor TAbstractFactory.Create(Canvas: TCanvas);
begin
  FCanvas := Canvas;
end;

destructor TAbstractFactory.Destroy;
begin
  inherited;
end;

{ TAbstractSimpleArrowLine }

procedure TAbstractSimpleArrowEdge.Draw(Source, Target: TPoint; SourceI, TargetI: TPoint);
begin
  FSource := Point(Source.X, Source.Y);
  FTarget := Point(Target.X, Target.Y);
  FSourceInterSection := SourceI;
  FTargetInterSection := TargetI;
  DrawEdge(Source, Target, SourceI, TargetI);
  case FArrowKind of
    Normal:
      DrawArrow(GetLastModified(), TargetI);
    Fashion:
      DrawFashionArrow(GetLastModified(), TargetI);
  end;
  DrawText(Source, Target);
end;

{ TAbstractDottedArrowLine }

procedure TAbstractDottedArrowEdge.Draw(Source, Target: TPoint; SourceI, TargetI: TPoint);
begin
  FSource := Point(Source.X, Source.Y);
  FTarget := Point(Target.X, Target.Y);
  FSourceInterSection := SourceI;
  FTargetInterSection := TargetI;
  DrawDottedEdge(Source, Target, SourceI, TargetI);
  case FArrowKind of
    Normal:
      DrawArrow(GetLastModified, TargetI);
    Fashion:
      DrawFashionArrow(GetLastModified, TargetI);
  end;
  DrawText(Source, Target);
end;

{ TAbstractLine }

function TAbstractEdge.CalcAngleTwoPoints(Source, Target: TPoint): double;
var
  angle: double;
begin
  angle := 180 * (1 + ArcTan2(Source.Y - Target.Y, Target.X - Source.X) / PI);
  if angle >= 360.0 then
    angle := angle - 360.0;
  Result := angle;
end;

procedure TAbstractEdge.CalculatePoints(Source, Target: TPoint);
begin
  // the other points are calculated from the first bend
  if not FBendModified[1] then // Source and target are automatically zoomed
    FBendPoint[1] := Point((Target.X - Source.X) div 2 + Source.X, (Target.Y - Source.Y) div 2 + Source.Y)
  else
  begin
    if lastZoom <> globalZoom then
    begin
      // FBendPoint[1] := ClientToGraph(FBendPoint[1]);
      if lastZoom > globalZoom then
      begin
        FBendPoint[1] := TZoom.ClientToGraph(FBendPoint[1], lastZoom - globalZoom);
      end
      else
      begin
        FBendPoint[1] := TZoom.GraphToClient(FBendPoint[1], globalZoom - lastZoom);
      end;
      lastZoom := globalZoom;
    end;
  end;

  if not FBendModified[0] then
    FBendPoint[0] := Point((FBendPoint[1].X - Source.X) div 2 + Source.X, (FBendPoint[1].Y - Source.Y) div 2 + Source.Y);
  if not FBendModified[2] then
    FBendPoint[2] := Point((Target.X - FBendPoint[1].X) div 2 + FBendPoint[1].X, (Target.Y - FBendPoint[1].Y) div 2 + FBendPoint[1].Y);
end;

function TAbstractEdge.Clone: TAbstractEdge;
var
  abstractLine: TAbstractEdge;
  SimpleLine: TSimpleEdgesFactory;
  DottedLine: TDottedEdgesFactory;
begin
  SimpleLine := TSimpleEdgesFactory.Create(Self.FCanvas);
  DottedLine := TDottedEdgesFactory.Create(Self.FCanvas);

  abstractLine := SimpleLine.GetEdgeByName(Self.ClassName);
  if not Assigned(abstractLine) then
    abstractLine := DottedLine.GetEdgeByName(Self.ClassName);

  abstractLine.FArrowKind := Self.FArrowKind;
  abstractLine.id := Self.Fid;
  abstractLine.properties.Assign(Self.FProperties);
  abstractLine.Inside := Self.FInside;
  abstractLine.FSource := Point(Self.FSource.X, Self.FSource.Y);
  abstractLine.FTarget := Point(Self.FTarget.X, Self.FTarget.Y);
  abstractLine.FSourceInterSection := Point(Self.FSourceInterSection.X, Self.FSourceInterSection.Y);
  abstractLine.FTargetInterSection := Point(Self.FTargetInterSection.X, Self.FTargetInterSection.Y);
  abstractLine.FBendPoint[0] := Self.FBendPoint[0];
  abstractLine.FBendPoint[1] := Self.FBendPoint[1];
  abstractLine.FBendPoint[2] := Self.FBendPoint[2];
  abstractLine.FBendModified[0] := Self.FBendModified[0];
  abstractLine.FBendModified[1] := Self.FBendModified[1];
  abstractLine.FBendModified[2] := Self.FBendModified[1];

  FreeAndNil(SimpleLine);
  FreeAndNil(DottedLine);
  Result := abstractLine;
end;

constructor TAbstractEdge.Create(Canvas: TCanvas);
begin
  FCanvas := Canvas;
  ArrowKind := Fashion;
  FAttachedObject := nil;
  Fid := TGuidGenerator.CreateGuid();
  FProperties := TEdgeProperty.Create();
end;

destructor TAbstractEdge.Destroy;
begin
  FreeAndNil(FProperties);
end;

function TAbstractEdge.Distance(p1, p2: TPoint): double;
begin
  try
    Result := sqrt(sqr(p1.X - p2.X) + sqr(p1.Y - p2.Y));
  except
    Result := 0;
  end;
end;

procedure TAbstractEdge.DrawArrow(Source, Target: TPoint);
var
  Triangulo: array [0 .. 2] of TPoint;
  LongitudVector, LongitudVectorNormal: double;
  DifLinea, BaseTriangulo, VectorNormal: TPoint;
  FlechaNormal: TPoint;
  DifUnitariaLinea, DifUnitariaNormal: TPointEx;
  restColor: TColor;
  lenArrow: integer;
begin
  if (Distance(Source, Target) < 20.0) or (Distance(Source, Target) > 2000.0) then
    exit;

  // Buscamos la diferencia de componentes y la longitud del vector
  if FInside then
    FCanvas.Pen.Color := FProperties.SelectedColor
  else
    FCanvas.Pen.Color := FProperties.LineColor;

  DifLinea := Point(Target.X - Source.X, Target.Y - Source.Y);
  LongitudVector := sqrt(sqr(DifLinea.X) + sqr(DifLinea.Y));
  if LongitudVector = 0 then
    exit;
  if LongitudVector <> 0 then
    DifUnitariaLinea := PointEx(DifLinea.X / LongitudVector, DifLinea.Y / LongitudVector);

  lenArrow := Muldiv(FProperties.lenArrow, 100, globalZoom);
  // BaseTriangulo donde la flecha es perpendicular a la base del triangulo
  BaseTriangulo := Point(Target.X - round(lenArrow * DifUnitariaLinea.X), Target.Y - round(lenArrow * DifUnitariaLinea.Y));

  VectorNormal := Point(DifLinea.Y, -DifLinea.X);

  LongitudVectorNormal := sqrt(sqr(VectorNormal.X) + sqr(VectorNormal.Y));

  DifUnitariaNormal := PointEx(VectorNormal.X / LongitudVectorNormal, VectorNormal.Y / LongitudVectorNormal);

  FlechaNormal := Point(round(lenArrow * DifUnitariaNormal.X), round(lenArrow * DifUnitariaNormal.Y));

  Triangulo[0] := Point(Target.X, Target.Y);
  Triangulo[1] := Point(BaseTriangulo.X + FlechaNormal.X, BaseTriangulo.Y + FlechaNormal.Y);
  Triangulo[2] := Point(BaseTriangulo.X - FlechaNormal.X, BaseTriangulo.Y - FlechaNormal.Y);

  // Dibujamos el poligono
  restColor := FCanvas.Brush.Color;
  if FProperties.Filled then
    FCanvas.Brush.Color := FProperties.FillColor;
  FCanvas.Polygon(Triangulo);
  FCanvas.Brush.Color := restColor;
end;

procedure TAbstractEdge.DrawDottedEdge(Source, Target: TPoint; SourceI, TargetI: TPoint);
var
  hand: cardinal;
  LogBrush: TLogBrush;
  NewRect: TRect;
  LastBrushStyle: TBrushStyle;
  LastBrushColor: TColor;
begin
  FCanvas.Pen.Width := FProperties.penWidth;
  if FInside then
    FCanvas.Pen.Color := FProperties.SelectedColor
  else
    FCanvas.Pen.Color := FProperties.LineColor;

  FCanvas.Brush.Style := bsSolid;

  LogBrush.lbStyle := BS_SOLID;
  LogBrush.lbColor := FCanvas.Pen.Color;
  hand := FCanvas.Pen.Handle;
  FCanvas.Pen.Handle := ExtCreatePen(PS_GEOMETRIC or PS_USERSTYLE, FCanvas.Pen.Width, LogBrush, Length(kleefPenStyle), @kleefPenStyle);

  if not FBendModified[0] and not FBendModified[1] and not FBendModified[2] then
  begin
    FCanvas.MoveTo(Source.X, Source.Y);
    FCanvas.LineTo(Target.X, Target.Y);
    CalculatePoints(SourceI, TargetI);
    if FInside then
    begin
      LastBrushStyle := FCanvas.Brush.Style;
      LastBrushColor := FCanvas.Brush.Color;
      FCanvas.Brush.Style := bsSolid;
      FCanvas.Brush.Color := FProperties.SelectedColor;
      NewRect := Rect(FBendPoint[1].X - 2, FBendPoint[1].Y - 2, FBendPoint[1].X + 2, FBendPoint[1].Y + 2);
      FCanvas.FillRect(NewRect);
      FCanvas.Brush.Style := LastBrushStyle;
      FCanvas.Brush.Color := LastBrushColor;
    end;
  end
  else
  begin
    CalculatePoints(SourceI, TargetI);
    FCanvas.MoveTo(Source.X, Source.Y);
    if FBendModified[0] then
    begin
      FCanvas.LineTo(FBendPoint[0].X, FBendPoint[0].Y);
      FCanvas.MoveTo(FBendPoint[0].X, FBendPoint[0].Y);
    end;
    if FBendModified[1] then
    begin
      FCanvas.LineTo(FBendPoint[1].X, FBendPoint[1].Y);
      FCanvas.MoveTo(FBendPoint[1].X, FBendPoint[1].Y);
    end;
    if FBendModified[2] then
    begin
      FCanvas.LineTo(FBendPoint[2].X, FBendPoint[2].Y);
      FCanvas.MoveTo(FBendPoint[2].X, FBendPoint[2].Y);
    end;
    FCanvas.LineTo(Target.X, Target.Y);
    if FInside then
    begin
      LastBrushStyle := FCanvas.Brush.Style;
      LastBrushColor := FCanvas.Brush.Color;
      FCanvas.Brush.Style := bsSolid;
      FCanvas.Brush.Color := FProperties.SelectedColor;
      if FBendModified[1] then
      begin
        NewRect := Rect(FBendPoint[0].X - 2, FBendPoint[0].Y - 2, FBendPoint[0].X + 2, FBendPoint[0].Y + 2);
        FCanvas.FillRect(NewRect);
      end;
      NewRect := Rect(FBendPoint[1].X - 2, FBendPoint[1].Y - 2, FBendPoint[1].X + 2, FBendPoint[1].Y + 2);
      FCanvas.FillRect(NewRect);
      if FBendModified[1] then
      begin
        NewRect := Rect(FBendPoint[2].X - 2, FBendPoint[2].Y - 2, FBendPoint[2].X + 2, FBendPoint[2].Y + 2);
        FCanvas.FillRect(NewRect);
      end;
      FCanvas.Brush.Style := LastBrushStyle;
      FCanvas.Brush.Color := LastBrushColor;
    end;
  end;

  FCanvas.Pen.Handle := hand;
  FCanvas.Pen.Width := FProperties.penWidth;
  if FInside then
    FCanvas.Pen.Color := FProperties.SelectedColor
  else
    FCanvas.Pen.Color := FProperties.LineColor;

  FCanvas.Brush.Style := bsSolid;
end;

procedure TAbstractEdge.DrawFashionArrow(Source, Target: TPoint);
  function CalcPoint(p: TPoint; angle: double; Distance: integer): TPoint;
  var
    X, Y, M: double;
  begin
    if Comparar(Abs(angle), (PI / 2), '<>') then
    begin
      if Comparar(Abs(angle), (PI / 2), '<') then
        Distance := -Distance;
      M := Tan(angle);
      X := p.X + Distance / sqrt(1 + sqr(M));
      Y := p.Y + M * (X - p.X);
      Result := Point(round(X), round(Y));
    end
    else
    begin
      if angle > 0 then
        Distance := -Distance;
      Result := Point(p.X, p.Y + Distance);
    end;
  end;

var
  angle: double;
  PArrow: array [1 .. 4] of TPoint;
  restColor: TColor;
  lenArrow: integer;
begin
  if (Distance(Source, Target) < 2.0) or (Distance(Source, Target) > 2000.0) then
    exit;
  angle := ArcTan2((Target.Y - Source.Y), (Target.X - Source.X));
  lenArrow := Muldiv(FProperties.lenArrow, 100, globalZoom);
  PArrow[1] := Target;
  PArrow[2] := CalcPoint(Target, angle + degToRad(FProperties.InclinationAngle), lenArrow);
  PArrow[3] := CalcPoint(Target, angle, 2 * lenArrow div 3);
  PArrow[4] := CalcPoint(Target, angle - degToRad(FProperties.InclinationAngle), lenArrow); // pi/9

  FCanvas.Pen.Width := FProperties.penWidth;
  if FInside then
    FCanvas.Pen.Color := FProperties.SelectedColor
  else
    FCanvas.Pen.Color := FProperties.LineColor;
  FCanvas.Brush.Style := bsSolid;
  restColor := FCanvas.Brush.Color;
  if FProperties.Filled then
    FCanvas.Brush.Color := FProperties.FillColor;
  FCanvas.Polygon(PArrow);
  FCanvas.Brush.Color := restColor;
end;

procedure TAbstractEdge.DrawImageLink(Source, Target: TPoint);
var
  Center: TPoint;
  bitmap2: Graphics.TBitmap;
  calc: double;
begin
  bitmap2 := Graphics.TBitmap.Create;
  try
    bitmap2.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'resources\images\link.bmp');
    Center := Point((Target.X + Source.X) div 2, (Target.Y + Source.Y) div 2);
    calc := (bitmap2.Width div 2);
    Center.X := Center.X - round(calc);
    calc := (bitmap2.Height div 2);
    Center.Y := Center.Y - round(calc);
    bitmap2.Transparent := true;
    bitmap2.TransparentColor := bitmap2.Canvas.Pixels[0, 0];
    bitmap2.TransparentMode := tmFixed;
    Self.FCanvas.Draw(Center.X, Center.Y, bitmap2);
  finally
    FreeAndNil(bitmap2);
  end;
end;

procedure TAbstractEdge.DrawText(Source, Target: TPoint);
var
  First, Last: TPoint;
begin
  GetPointsToDrawText(Source, Target, First, Last);
  DrawTextOrientation(First, Last);
end;

procedure TAbstractEdge.DrawTextOrientation(Source, Target: TPoint);

  function iif(condition: boolean; resultTrue: integer; resultFalse: integer): integer;
  begin
    Result := resultFalse;
    if condition then
      Result := resultTrue
  end;

var
  newFont, FontSelected: integer;
  angle: double;
  iAngle, i: integer;
  Position: TPoint;
  calc: double;
  FontSize: integer;
begin
  if FProperties.Description.text = '' then
    exit;
  angle := CalcAngleTwoPoints(Source, Target);
  iAngle := round(angle);

  if (iAngle >= 0) and (iAngle <= 90) then
    iAngle := iAngle;

  if (iAngle >= 91) and (iAngle <= 180) then
    iAngle := iAngle + 180;

  if (iAngle >= 181) and (iAngle <= 269) then
    iAngle := iAngle - 180;

  if (iAngle >= 270) and (iAngle <= 360) then
    iAngle := iAngle;

  for i := 0 to FProperties.Description.Count - 1 do
  begin
    Position := Point((Target.X + Source.X) div 2, (Target.Y + Source.Y) div 2);
    FCanvas.Font := FProperties.FontText;
    calc := (FCanvas.TextWidth(FProperties.Description[i]) div 2) * cos(degToRad(iAngle));
    Position.X := Position.X - round(calc);
    calc := (FCanvas.TextWidth(FProperties.Description[i]) div 2) * sin(degToRad(iAngle));
    Position.Y := Position.Y + round(calc);
    FontSize := Muldiv(FProperties.FontText.Size, 100, globalZoom);
    SetBkMode(FCanvas.Handle, Transparent);
    newFont := CreateFont(-FontSize, 0, iAngle * 10, 0, iif(fsBold in FProperties.FontText.Style, FW_BOLD, FW_NORMAL), iif(fsItalic in FProperties.FontText.Style, 1, 0),
      iif(fsUnderline in FProperties.FontText.Style, 1, 0), iif(fsStrikeOut in FProperties.FontText.Style, 1, 0), ANSI_CHARSET, OUT_TT_PRECIS, CLIP_DEFAULT_PRECIS, ANTIALIASED_QUALITY, FF_DONTCARE,
      PChar(FProperties.FontText.Name));

    FCanvas.Font.Color := FProperties.FontText.Color;
    FontSelected := SelectObject(FCanvas.Handle, newFont);
    TextOut(FCanvas.Handle, Position.X, Position.Y + (i * FontSize), PChar(FProperties.Description[i]), Length(FProperties.Description[i]));
    SelectObject(FCanvas.Handle, FontSelected);
    DeleteObject(newFont);
  end;
end;

function TAbstractEdge.GetFirstModified: TPoint;
var
  Last: TPoint;
begin
  if FBendModified[0] then
    Last := TZoom.ClientToGraph(FBendPoint[0])
  else if not FBendModified[0] and FBendModified[1] then
    Last := TZoom.ClientToGraph(FBendPoint[1])
  else if not FBendModified[1] and FBendModified[2] then
    Last := TZoom.ClientToGraph(FBendPoint[2])
  else
    Last := FTarget;
  Result := Last;
end;

function TAbstractEdge.GetLastModified: TPoint;
var
  Last: TPoint;
begin
  if FBendModified[2] then
    Last := (FBendPoint[2])
  else if not FBendModified[2] and FBendModified[1] then
    Last := (FBendPoint[1])
  else if not FBendModified[1] and FBendModified[0] then
    Last := (FBendPoint[0])
  else
    Last := FSource;
  Result := Last;
end;

procedure TAbstractEdge.GetPointsToDrawText(Source, Target: TPoint; var First, Last: TPoint);
begin
  if not FBendModified[2] and not FBendModified[1] and not FBendModified[0] then
  begin
    First := Source;
    Last := Target;
  end
  else
  begin
    if FBendModified[1] and not FBendModified[2] and not FBendModified[0] then
    begin
      First := Source;
      Last := TZoom.ClientToGraph(FBendPoint[1]);
    end
    else
    begin
      First := TZoom.ClientToGraph(FBendPoint[0]);
      Last := TZoom.ClientToGraph(FBendPoint[1]);
    end;
  end;
end;

function TAbstractEdge.InsideVertex(Index, X, Y: integer): boolean;
var
  xinside: boolean;
  yinside: boolean;
begin
  xinside := (FBendPoint[Index].X + 2 >= X) and (FBendPoint[Index].X - 2 <= X);
  yinside := (FBendPoint[Index].Y + 2 >= Y) and (FBendPoint[Index].Y - 2 <= Y);
  Result := xinside and yinside;
end;

function TAbstractEdge.MarshalToXML(XMLDoc: IXMLDocument; iXMLRootNode: IXMLNode; sNode: string): IXMLNode;
  function ArrowKindToStr(arrKind: TArrowKind): string;
  var
    sText: string;
  begin
    sText := '';
    case arrKind of
      Normal:
        sText := 'Normal';
      Fashion:
        sText := 'Fashion';
    end;
    Result := sText;
  end;

begin
  iXMLRootNode.attributes['FId'] := Self.Fid;
  iXMLRootNode.attributes['FClass'] := Self.ClassName;
  Self.FProperties.MarshalToXML(XMLDoc, iXMLRootNode, sNode);
  iXMLRootNode.attributes['FArrowKind'] := ArrowKindToStr(Self.FArrowKind);
  iXMLRootNode.attributes['FSourceX'] := IntToStr(Self.FSource.X);
  iXMLRootNode.attributes['FSourceY'] := IntToStr(Self.FSource.Y);
  iXMLRootNode.attributes['FTargetX'] := IntToStr(Self.FTarget.X);
  iXMLRootNode.attributes['FTargetY'] := IntToStr(Self.FTarget.Y);

  iXMLRootNode.attributes['FArrayPoint0X'] := IntToStr(FBendPoint[0].X);
  iXMLRootNode.attributes['FArrayPoint0Y'] := IntToStr(FBendPoint[0].Y);
  iXMLRootNode.attributes['FArrayPoint1X'] := IntToStr(FBendPoint[1].X);
  iXMLRootNode.attributes['FArrayPoint1Y'] := IntToStr(FBendPoint[1].Y);
  iXMLRootNode.attributes['FArrayPoint2X'] := IntToStr(FBendPoint[2].X);
  iXMLRootNode.attributes['FArrayPoint2Y'] := IntToStr(FBendPoint[2].Y);

  iXMLRootNode.attributes['modified0'] := BoolToStr(FBendModified[0]);
  iXMLRootNode.attributes['modified1'] := BoolToStr(FBendModified[1]);
  iXMLRootNode.attributes['modified2'] := BoolToStr(FBendModified[2]);

  iXMLRootNode.attributes['FSourceIntersectionX'] := IntToStr(Self.FSourceInterSection.X);
  iXMLRootNode.attributes['FSourceIntersectionY'] := IntToStr(Self.FSourceInterSection.Y);
  iXMLRootNode.attributes['FTargetIntersectionX'] := IntToStr(Self.FTargetInterSection.X);
  iXMLRootNode.attributes['FTargetIntersectionY'] := IntToStr(Self.FTargetInterSection.Y);
end;

procedure TAbstractEdge.Move(X, Y: integer);
var
  pt: TPoint;
begin
  pt := TZoom.GraphToClient(X, Y);
  if FBendModified[0] then
  begin
    FBendPoint[0].X := FBendPoint[0].X + pt.X;
    FBendPoint[0].Y := FBendPoint[0].Y + pt.Y;
  end;
  if FBendModified[1] then
  begin
    FBendPoint[1].X := FBendPoint[1].X + pt.X;
    FBendPoint[1].Y := FBendPoint[1].Y + pt.Y;
  end;
  if FBendModified[2] then
  begin
    FBendPoint[2].X := FBendPoint[2].X + pt.X;
    FBendPoint[2].Y := FBendPoint[2].Y + pt.Y;
  end;
  CalculatePoints(FSourceInterSection, FTargetInterSection);
end;

procedure TAbstractEdge.Move(Index, X, Y: integer);
var
  pt: TPoint;
begin
  FBendModified[Index] := true;
  pt := Point(X, Y); // GraphToClient(x,y);
  // pt := ClientToGraph(x,y);
  FBendPoint[Index].X := FBendPoint[Index].X + pt.X;
  FBendPoint[Index].Y := FBendPoint[Index].Y + pt.Y;
  CalculatePoints(FSourceInterSection, FTargetInterSection);
end;

function TAbstractEdge.PointOnLine(p: TPoint): boolean;
begin
  if not FBendModified[0] and not FBendModified[1] and not FBendModified[2] then
    Result := NearLine(p, FSource, FTarget)
  else
  begin
    Result := NearLine(p, FSource, TZoom.ClientToGraph(FBendPoint[0]));
    Result := Result or NearLine(p, TZoom.ClientToGraph(FBendPoint[0]), TZoom.ClientToGraph(FBendPoint[1]));
    Result := Result or NearLine(p, TZoom.ClientToGraph(FBendPoint[1]), TZoom.ClientToGraph(FBendPoint[2]));
    Result := Result or NearLine(p, TZoom.ClientToGraph(FBendPoint[2]), FTarget);
  end;
end;

procedure TAbstractEdge.SetArrowKind(const Value: TArrowKind);
begin
  FArrowKind := Value;
end;

procedure TAbstractEdge.SetAttachedObject(const Value: Pointer);
begin
  FAttachedObject := Value;
end;

procedure TAbstractEdge.Setid(const Value: string);
begin
  Fid := Value;
end;

procedure TAbstractEdge.SetInside(const Value: boolean);
begin
  FInside := Value;
end;

procedure TAbstractEdge.SetProperties(const Value: TEdgeProperty);
begin
  FProperties := Value;
end;

function TAbstractEdge.UnMarshalFromXML(XMLDoc: IXMLDocument; iXMLRootNode: IXMLNode; sNode: string): IXMLNode;
  function StrToArrowKind(arrKind: string): TArrowKind;
  var
    sText: TArrowKind;
  begin
    sText := Normal;
    if arrKind = 'Fashion' then
      sText := Fashion;

    Result := sText;
  end;

begin
  Self.Fid := iXMLRootNode.attributes['FId'];
  Self.FProperties.UnMarshalFromXML(XMLDoc, iXMLRootNode, sNode);
  Self.FArrowKind := StrToArrowKind(iXMLRootNode.attributes['FArrowKind']);
  Self.FSource.X := StrToInt(iXMLRootNode.attributes['FSourceX']);
  Self.FSource.Y := StrToInt(iXMLRootNode.attributes['FSourceY']);
  Self.FTarget.X := StrToInt(iXMLRootNode.attributes['FTargetX']);
  Self.FTarget.Y := StrToInt(iXMLRootNode.attributes['FTargetY']);

  Self.FBendPoint[0].X := StrToInt(iXMLRootNode.attributes['FArrayPoint0X']);
  Self.FBendPoint[0].Y := StrToInt(iXMLRootNode.attributes['FArrayPoint0Y']);
  Self.FBendPoint[1].X := StrToInt(iXMLRootNode.attributes['FArrayPoint1X']);
  Self.FBendPoint[1].Y := StrToInt(iXMLRootNode.attributes['FArrayPoint1Y']);
  Self.FBendPoint[2].X := StrToInt(iXMLRootNode.attributes['FArrayPoint2X']);
  Self.FBendPoint[2].Y := StrToInt(iXMLRootNode.attributes['FArrayPoint2Y']);

  Self.FBendModified[0] := StrToBool(iXMLRootNode.attributes['modified0']);
  Self.FBendModified[1] := StrToBool(iXMLRootNode.attributes['modified1']);
  Self.FBendModified[2] := StrToBool(iXMLRootNode.attributes['modified2']);

  Self.FSourceInterSection.X := StrToInt(iXMLRootNode.attributes['FSourceIntersectionX']);
  Self.FSourceInterSection.Y := StrToInt(iXMLRootNode.attributes['FSourceIntersectionY']);
  Self.FTargetInterSection.X := StrToInt(iXMLRootNode.attributes['FTargetIntersectionX']);
  Self.FTargetInterSection.Y := StrToInt(iXMLRootNode.attributes['FTargetIntersectionY']);
end;

procedure TAbstractEdge.DrawEdge(Source, Target: TPoint; SourceI, TargetI: TPoint);
var
  NewRect: TRect;
  LastBrushStyle: TBrushStyle;
  LastBrushColor: TColor;
begin
  FCanvas.Pen.Width := FProperties.penWidth;
  if FInside then
    FCanvas.Pen.Color := FProperties.SelectedColor
  else
    FCanvas.Pen.Color := FProperties.LineColor;
  FCanvas.Brush.Style := bsSolid;
  // this part works fine
  if not FBendModified[1] then
  begin
    FCanvas.MoveTo(Source.X, Source.Y);
    FCanvas.LineTo(Target.X, Target.Y);
    // If none of the bend points are modified, the calculation is correct
    CalculatePoints(SourceI, TargetI);
    if FInside then
    begin
      LastBrushStyle := FCanvas.Brush.Style;
      LastBrushColor := FCanvas.Brush.Color;
      FCanvas.Brush.Style := bsSolid;
      FCanvas.Brush.Color := FProperties.SelectedColor;
      NewRect := Rect((FBendPoint[1]).X - 2, (FBendPoint[1]).Y - 2, (FBendPoint[1]).X + 2, (FBendPoint[1]).Y + 2);
      FCanvas.FillRect(NewRect);
      FCanvas.Brush.Style := LastBrushStyle;
      FCanvas.Brush.Color := LastBrushColor;
    end;
  end
  else
  begin // The main point is modified
    CalculatePoints(SourceI, TargetI);
    FCanvas.MoveTo(Source.X, Source.Y);
    if FBendModified[0] then
    begin
      FCanvas.LineTo((FBendPoint[0]).X, (FBendPoint[0]).Y);
      FCanvas.MoveTo((FBendPoint[0]).X, (FBendPoint[0]).Y);
    end;
    if FBendModified[1] then
    begin
      FCanvas.LineTo((FBendPoint[1]).X, (FBendPoint[1]).Y);
      FCanvas.MoveTo((FBendPoint[1]).X, (FBendPoint[1]).Y);
    end;
    if FBendModified[2] then
    begin
      FCanvas.LineTo((FBendPoint[2]).X, (FBendPoint[2]).Y);
      FCanvas.MoveTo((FBendPoint[2]).X, (FBendPoint[2]).Y);
    end;
    FCanvas.LineTo(Target.X, Target.Y);
    if FInside then
    begin
      LastBrushStyle := FCanvas.Brush.Style;
      LastBrushColor := FCanvas.Brush.Color;
      FCanvas.Brush.Style := bsSolid;
      FCanvas.Brush.Color := FProperties.SelectedColor;
      if FBendModified[1] then
      begin
        NewRect := Rect((FBendPoint[0]).X - 2, (FBendPoint[0]).Y - 2, (FBendPoint[0]).X + 2, (FBendPoint[0]).Y + 2);
        FCanvas.FillRect(NewRect);
      end;
      NewRect := Rect((FBendPoint[1]).X - 2, (FBendPoint[1]).Y - 2, (FBendPoint[1]).X + 2, (FBendPoint[1]).Y + 2);
      FCanvas.FillRect(NewRect);
      if FBendModified[1] then
      begin
        NewRect := Rect((FBendPoint[2]).X - 2, (FBendPoint[2]).Y - 2, (FBendPoint[2]).X + 2, (FBendPoint[2]).Y + 2);
        FCanvas.FillRect(NewRect);
      end;
      FCanvas.Brush.Style := LastBrushStyle;
      FCanvas.Brush.Color := LastBrushColor;
    end;
  end;
end;

{ TAbstractSimpleLine }

procedure TAbstractSimpleEdge.Draw(Source, Target: TPoint; SourceI, TargetI: TPoint);
begin
  FSource := Point(Source.X, Source.Y);
  FTarget := Point(Target.X, Target.Y);
  FSourceInterSection := SourceI;
  FTargetInterSection := TargetI;
  DrawEdge(Source, Target, SourceI, TargetI);
  DrawText(Source, Target);
end;

{ TAbstractSimpleDoubleArrowLine }

procedure TAbstractSimpleDoubleArrowEdge.Draw(Source, Target: TPoint; SourceI, TargetI: TPoint);
begin
  FSource := Point(Source.X, Source.Y);
  FTarget := Point(Target.X, Target.Y);
  FSourceInterSection := SourceI;
  FTargetInterSection := TargetI;
  DrawEdge(Source, Target, SourceI, TargetI);

  case FArrowKind of
    Normal:
      begin
        DrawArrow(GetLastModified(), TargetI);
        DrawArrow(GetFirstModified(), SourceI);
      end;
    Fashion:
      begin
        DrawFashionArrow(GetLastModified(), TargetI);
        DrawFashionArrow(GetFirstModified(), SourceI);
      end;
  end;
  DrawText(Source, Target);
end;

{ TAbstractDottedDoubleArrowLine }

procedure TAbstractDottedDoubleArrowEdge.Draw(Source, Target: TPoint; SourceI, TargetI: TPoint);
begin
  FSource := Point(Source.X, Source.Y);
  FTarget := Point(Target.X, Target.Y);
  FSourceInterSection := SourceI;
  FTargetInterSection := TargetI;
  DrawDottedEdge(Source, Target, SourceI, TargetI);

  case FArrowKind of
    Normal:
      begin
        DrawArrow(GetLastModified, TargetI);
        DrawArrow(GetFirstModified, SourceI);
      end;
    Fashion:
      begin
        DrawFashionArrow(GetLastModified, TargetI);
        DrawFashionArrow(GetFirstModified, SourceI);
      end;
  end;
  DrawText(Source, Target);
end;

{ TAbstractDottedLine }

procedure TAbstractDottedEdge.Draw(Source, Target: TPoint; SourceI, TargetI: TPoint);
begin
  FSource := Point(Source.X, Source.Y);
  FTarget := Point(Target.X, Target.Y);
  FSourceInterSection := SourceI;
  FTargetInterSection := TargetI;
  DrawDottedEdge(Source, Target, SourceI, TargetI);
  DrawText(Source, Target);
end;

{ TDottedLinesFactory }

constructor TDottedEdgesFactory.Create(Canvas: TCanvas);
begin
  inherited;
end;

destructor TDottedEdgesFactory.Destroy;
begin

  inherited;
end;

function TDottedEdgesFactory.GetEdge: TAbstractEdge;
begin
  Result := TAbstractDottedEdge.Create(FCanvas);
end;

function TDottedEdgesFactory.GetEdgeArrow: TAbstractEdge;
begin
  Result := TAbstractDottedArrowEdge.Create(FCanvas);
end;

function TDottedEdgesFactory.GetEdgeByName(name: string): TAbstractEdge;
begin
  Result := nil;
  if (name = 'TAbstractDottedEdge') or (name = 'TAbstractDottedLine') then
    Result := GetEdge();
  if (name = 'TAbstractDottedArrowEdge') or (name = 'TAbstractDottedArrowLine') then
    Result := GetEdgeArrow();
  if (name = 'TAbstractDottedDoubleArrowEdge') or (name = 'TAbstractDottedDoubleArrowLine') then
    Result := GetEdgeDoubleArrow();
  if (name = 'TAbstractDottedDoubleLinkedArrowEdge') or (name = 'TAbstractDottedDoubleLinkedArrowLine') then
    Result := GetEdgeLinkedArrow();
end;

function TDottedEdgesFactory.GetEdgeDoubleArrow: TAbstractEdge;
begin
  Result := TAbstractDottedDoubleArrowEdge.Create(FCanvas);
end;

function TDottedEdgesFactory.GetEdgeLinkedArrow: TAbstractEdge;
begin
  Result := TAbstractDottedDoubleLinkedArrowEdge.Create(FCanvas);
  Result.properties.FillColor := clBlue;
  Result.properties.Filled := true;
end;

{ TAbstractSimpleDoubleLinkedArrowLine }

procedure TAbstractSimpleDoubleLinkedArrowEdge.Draw(Source, Target, SourceI, TargetI: TPoint);
begin
  FSource := Point(Source.X, Source.Y);
  FTarget := Point(Target.X, Target.Y);
  FSourceInterSection := SourceI;
  FTargetInterSection := TargetI;
  DrawEdge(Source, Target, SourceI, TargetI);

  case FArrowKind of
    Normal:
      begin
        DrawArrow(GetLastModified(), TargetI);
        DrawArrow(GetFirstModified(), SourceI);
      end;
    Fashion:
      begin
        DrawFashionArrow(GetLastModified(), TargetI);
        DrawFashionArrow(GetFirstModified(), SourceI);
      end;
  end;
  DrawImageLink(Source, Target);
  DrawTextOrientation(Source, Target);
end;

{ TAbstractDottedDoubleLinkedArrowLine }

procedure TAbstractDottedDoubleLinkedArrowEdge.Draw(Source, Target, SourceI, TargetI: TPoint);
begin
  FSource := Point(Source.X, Source.Y);
  FTarget := Point(Target.X, Target.Y);
  FSourceInterSection := SourceI;
  FTargetInterSection := TargetI;
  DrawDottedEdge(Source, Target, SourceI, TargetI);

  case FArrowKind of
    Normal:
      begin
        DrawArrow(GetLastModified, TargetI);
        DrawArrow(GetFirstModified, SourceI);
      end;
    Fashion:
      begin
        DrawFashionArrow(GetLastModified, TargetI);
        DrawFashionArrow(GetFirstModified, SourceI);
      end;
  end;
  DrawImageLink(Source, Target);
  DrawTextOrientation(Source, Target);
end;

end.
