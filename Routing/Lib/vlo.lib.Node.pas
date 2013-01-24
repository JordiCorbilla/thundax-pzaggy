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
unit vlo.lib.Node;

interface

uses
  types, contnrs, Graphics, vlo.lib.Edge, Classes, vlo.lib.cloner.contract,
  vlo.lib.XML.Serializer, XMLDoc, XMLIntf, vlo.lib.vertex, vlo.lib.properties.Node,
  vlo.lib.Layout, vlo.lib.options, vlo.lib.treeLayout.helper;

type
  // Vertex Position
  // 1-----3
  // |     |
  // |     |
  // 4-----2

  TNodeType = (nOrigin, nDestiny, nNormal, nLink);

  TNode = class(TInterfacedObject, ICloneable, ISerializable)
  private
    FVertex: array [1 .. 4] of TVertex;
    FCenter: TVertex;
    FInside: Boolean;
    FDrawing: Boolean;
    FAttachedObject: Pointer;
    FId: string;
    FProperties: TNodeProperty;
    FImage: string;
    FHookeForce: TForce;
    FSpeed: TForce;
    FCoulombForce: TForce;
    Fconnections: integer;
    Fmass: Double;
    FNeighbour: TStringList;
    FnodeType: TNodeType;
    Foptions: TOptionsApplication;
    FPrivateNode: TLayeredTreeInfo;
    procedure SetCenter(const Value: TVertex);
    procedure SetInside(const Value: Boolean);
    procedure SetDrawing(const Value: Boolean);
    function GetVertex(Index: integer): TPoint;
    procedure SetVertex(Index: integer; Value: TPoint);
    procedure SetAttachedObject(const Value: Pointer);
    procedure SetId(const Value: string);
    procedure SetProperties(const Value: TNodeProperty);
    procedure SetImage(const Value: string);
    procedure SetCoulombForce(const Value: TForce);
    procedure SetHookeForce(const Value: TForce);
    procedure SetSpeed(const Value: TForce);
    function ExistsNeighbour(id: string): Boolean;
    procedure Setconnections(const Value: integer);
    procedure Setmass(const Value: Double);
    procedure SetNeighbour(const Value: TStringList);
    procedure SetnodeType(const Value: TNodeType);
    procedure Setoptions(const Value: TOptionsApplication);
    procedure SetPrivateNode(const Value: TLayeredTreeInfo);
  public
    property options: TOptionsApplication read Foptions write Setoptions;
    property Neighbour: TStringList read FNeighbour write SetNeighbour;
    property id: string read FId write SetId;
    property Image: string read FImage write SetImage;
    property Properties: TNodeProperty read FProperties write SetProperties;
    property Vertex1: TPoint index 1 read GetVertex write SetVertex;
    property Vertex2: TPoint index 2 read GetVertex write SetVertex;
    property Vertex3: TPoint index 3 read GetVertex write SetVertex;
    property Vertex4: TPoint index 4 read GetVertex write SetVertex;
    property Center: TVertex read FCenter write SetCenter;
    property Inside: Boolean read FInside write SetInside;
    property Drawing: Boolean read FDrawing write SetDrawing;
    property AttachedObject: Pointer read FAttachedObject write SetAttachedObject;
    property CoulombForce: TForce read FCoulombForce write SetCoulombForce;
    property HookeForce: TForce read FHookeForce write SetHookeForce;
    property Speed: TForce read FSpeed write SetSpeed;
    property mass: Double read Fmass write Setmass;
    property connections: integer read Fconnections write Setconnections;
    property nodeType: TNodeType read FnodeType write SetnodeType;
    property PrivateNode: TLayeredTreeInfo read FPrivateNode write SetPrivateNode;
    function isInside(x, y: integer): Boolean;
    function isInVertex(Index: integer; x, y: integer): Boolean;
    procedure MoveVertex(Index: integer; x, y: integer);
    procedure Draw(canvas: TCanvas);
    procedure CalcCenter();
    constructor Create();
    constructor CreateExternal(position: TPoint; ImageName: string);
    destructor Destroy(); override;
    procedure CalcPoints();
    procedure CalcPoints2();
    procedure Move(x, y: Double);
    function Clone: TObject;
    function MarshalToXML(XMLDoc: IXMLDocument; iXMLRootNode: IXMLNode; sNode: string): IXMLNode;
    function UnMarshalFromXML(XMLDoc: IXMLDocument; iXMLRootNode: IXMLNode; sNode: string): IXMLNode;
    procedure AddNeighbour(id: string);
    procedure DeleteNeighBour(id: string);
    function NodeTypeToStr(Value: TNodeType): string;
    function StrToNodeType(Value: String): TNodeType;
    function DefaultDescription(mark: Boolean): string;
  end;

function Compare(Item1, Item2: Pointer): integer;

implementation

uses
  SysUtils, vlo.lib.text, vlo.lib.GUID.Generator, StrUtils, Windows, vlo.lib.zoom;

{ TNode }

procedure TNode.CalcCenter;
begin
  if (Vertex2.x > Vertex1.x) then
  begin
    FCenter.x := Vertex1.x + ((Vertex2.x - Vertex1.x) div 2);
    if (Vertex2.y > Vertex1.y) then
      FCenter.y := Vertex1.y + ((Vertex2.y - Vertex1.y) div 2)
    else
      FCenter.y := Vertex2.y + ((Vertex1.y - Vertex2.y) div 2);
  end
  else
  begin
    FCenter.x := Vertex2.x + ((Vertex1.x - Vertex2.x) div 2);
    if (Vertex2.y > Vertex1.y) then
      FCenter.y := Vertex1.y + ((Vertex2.y - Vertex1.y) div 2)
    else
      FCenter.y := Vertex2.y + ((Vertex1.y - Vertex2.y) div 2);
  end;
end;

procedure TNode.CalcPoints;
begin
  FVertex[3].x := FVertex[2].x;
  FVertex[3].y := FVertex[1].y;
  FVertex[4].x := FVertex[1].x;
  FVertex[4].y := FVertex[2].y;
end;

procedure TNode.CalcPoints2;
begin
  FVertex[2].x := FVertex[3].x;
  FVertex[1].y := FVertex[3].y;
  FVertex[1].x := FVertex[4].x;
  FVertex[2].y := FVertex[4].y;
end;

function TNode.Clone: TObject;
var
  newNode: TNode;
  i: integer;
begin
  newNode := TNode.Create;
  newNode.Vertex1 := Point(Round(Self.FVertex[1].x), Round(Self.FVertex[1].y));
  newNode.Vertex2 := Point(Round(Self.FVertex[2].x), Round(Self.FVertex[2].y));
  newNode.Vertex3 := Point(Round(Self.FVertex[3].x), Round(Self.FVertex[3].y));
  newNode.Vertex4 := Point(Round(Self.FVertex[4].x), Round(Self.FVertex[4].y));
  newNode.Center.x := Self.FCenter.x;
  newNode.Center.y := Self.FCenter.y;
  newNode.Properties.assign(Self.Properties);
  newNode.Image := Self.FImage;
  newNode.nodeType := Self.nodeType;
  newNode.HookeForce.SetVal(Self.FHookeForce.r0, Self.FHookeForce.r1);
  newNode.Speed.SetVal(Self.FSpeed.r0, Self.FSpeed.r1);
  newNode.CoulombForce.SetVal(Self.FCoulombForce.r0, Self.FCoulombForce.r1);
  newNode.connections := Self.Fconnections;
  newNode.mass := Self.Fmass;
  for i := 0 to Self.FNeighbour.Count - 1 do
  begin
    newNode.Neighbour.Add(Self.FNeighbour[i]);
  end;
  newNode.options := Self.options;
  result := newNode;
end;

constructor TNode.Create;
var
  i: integer;
begin
  FNeighbour := TStringList.Create;
  for i := 1 to 4 do
    FVertex[i] := TVertex.Create(0, 0);
  Properties := TNodeProperty.Create();
  FAttachedObject := nil;
  FCenter := TVertex.Create(0, 0);
  FId := TGuidGenerator.CreateGuid();
  FImage := '';
  FHookeForce.SetVal(0, 0);
  FSpeed.SetVal(0, 0);
  FCoulombForce.SetVal(0, 0);
  Fconnections := 0;
  Fmass := 1;
  FnodeType := nNormal;
end;

constructor TNode.CreateExternal(position: TPoint; ImageName: string);
var
  Bitmap: Graphics.TBitmap;
begin
  Self.Create;
  Self.FImage := 'resources\images\' + ImageName;
  Bitmap := Graphics.TBitmap.Create;
  Bitmap.LoadFromFile(ExtractFilePath(ParamStr(0)) + Self.FImage);
  Self.FVertex[1].x := position.x;
  Self.FVertex[1].y := position.y;
  Self.FVertex[2].x := Self.FVertex[1].x + Bitmap.Width;
  Self.FVertex[2].y := Self.FVertex[1].y + Bitmap.height;
  FreeAndNil(Bitmap);
  Self.CalcCenter;
  Self.CalcPoints;
end;

function TNode.DefaultDescription(mark: Boolean): string;
var
  text: string;
begin
  text := '';
  if (mark) and (Self.Properties.getText <> '') then
    text := Self.Properties.getText
  else
    text := Self.id;
  result := text;
end;

procedure TNode.DeleteNeighBour(id: string);
var
  i: integer;
  found: Boolean;
begin
  found := false;
  i := 0;
  while (not found) and (i < FNeighbour.Count) do
  begin
    found := (FNeighbour[i] = id);
    inc(i);
  end;
  if found then
    FNeighbour.Delete(i - 1);
end;

destructor TNode.Destroy;
var
  i: integer;
begin
  for i := 1 to 4 do
    FreeAndNil(FVertex[i]);
  FreeAndNil(FProperties);
  FreeAndNil(FCenter);
  FreeAndNil(FNeighbour);
  if Assigned(FPrivateNode) then
    FreeAndNil(FPrivateNode);
end;

procedure TNode.Draw(canvas: TCanvas);
var
  NewRect: TRect;
  i: integer;
  Bitmap: Graphics.TBitmap;
  FontSize: integer;
  p: TPoint;
begin
  if FImage <> '' then
  begin
    canvas.Brush.Style := bsSolid;
    canvas.Brush.Color := Properties.ColorNodeifImage;
    canvas.Pen.Width := Properties.penWidth;
    canvas.Brush.Color := Properties.ColorNodeifImage;
  end
  else
  begin
    canvas.Brush.Style := bsSolid;
    canvas.Brush.Color := Properties.FillColor;
    canvas.Pen.Width := Properties.penWidth;
    canvas.Brush.Color := Properties.FillColor;
  end;

  if Inside then
  begin
    canvas.Pen.Color := Properties.selectedColor;
  end
  else
  begin
    if FImage <> '' then
      canvas.Pen.Color := Properties.ColorBorderIfImage
    else
      canvas.Pen.Color := Properties.linecolor;
  end;

  canvas.RoundRect(TZoom.ClientToGraph(Vertex1).x, TZoom.ClientToGraph(Vertex1).y, TZoom.ClientToGraph(Vertex2).x, TZoom.ClientToGraph(Vertex2).y, options.RoundedIndex, options.RoundedIndex);

  if (FImage <> '') and FileExists(ExtractFilePath(ParamStr(0)) + Self.FImage) then
  begin
    Bitmap := Graphics.TBitmap.Create;
    Bitmap.LoadFromFile(ExtractFilePath(ParamStr(0)) + Self.FImage);
    Bitmap.Transparent := true;
    Bitmap.TransparentColor := Bitmap.canvas.Pixels[0, 0];
    Bitmap.TransparentMode := tmFixed;
    canvas.Draw(TZoom.ClientToGraph(Vertex1).x, TZoom.ClientToGraph(Vertex1).y, Bitmap);
    FreeAndNil(Bitmap);
  end;

  if Inside then
  begin
    canvas.Brush.Style := bsSolid;
    canvas.Brush.Color := Properties.selectedColor;
    NewRect := Rect(TZoom.ClientToGraph(Vertex1).x - 2, TZoom.ClientToGraph(Vertex1).y - 2, TZoom.ClientToGraph(Vertex1).x + 2, TZoom.ClientToGraph(Vertex1).y + 2);
    canvas.FillRect(NewRect);
    NewRect := Rect(TZoom.ClientToGraph(Vertex2).x - 2, TZoom.ClientToGraph(Vertex2).y - 2, TZoom.ClientToGraph(Vertex2).x + 2, TZoom.ClientToGraph(Vertex2).y + 2);
    canvas.FillRect(NewRect);
    NewRect := Rect(TZoom.ClientToGraph(Center).x - 2, TZoom.ClientToGraph(Center).y - 2, TZoom.ClientToGraph(Center).x + 2, TZoom.ClientToGraph(Center).y + 2);
    canvas.FillRect(NewRect);
    NewRect := Rect(TZoom.ClientToGraph(Vertex3).x - 2, TZoom.ClientToGraph(Vertex3).y - 2, TZoom.ClientToGraph(Vertex3).x + 2, TZoom.ClientToGraph(Vertex3).y + 2);
    canvas.FillRect(NewRect);
    NewRect := Rect(TZoom.ClientToGraph(Vertex4).x - 2, TZoom.ClientToGraph(Vertex4).y - 2, TZoom.ClientToGraph(Vertex4).x + 2, TZoom.ClientToGraph(Vertex4).y + 2);
    canvas.FillRect(NewRect);
  end;

  if Properties.description.text <> '' then
  begin
    // DrawText(canvas);
    FontSize := MulDiv(FProperties.FontText.Size, 100, globalZoom);
    for i := 0 to Properties.description.Count - 1 do
    begin
      p := Point(TZoom.ClientToGraph(Vertex1).x + 2, TZoom.ClientToGraph(Vertex1).y + 1 + (i * FontSize));
      TGDIText.DrawTextOrientation(canvas, p, 0, Properties.FontText, Properties.description[i], FImage <> '', Properties.ColorFontifImage, true);
    end;
  end;
end;

function TNode.ExistsNeighbour(id: string): Boolean;
var
  found: Boolean;
  i: integer;
begin
  found := false;
  i := 0;
  while (not found) and (i < FNeighbour.Count) do
  begin
    found := (FNeighbour[i] = id);
    inc(i);
  end;
  result := found;
end;

function TNode.GetVertex(Index: integer): TPoint;
begin
  result := FVertex[Index].position;
end;

function TNode.isInside(x, y: integer): Boolean;
var
  xinside: Boolean;
  yinside: Boolean;
begin
  if (TZoom.ClientToGraph(Vertex2).x > TZoom.ClientToGraph(Vertex1).x) then
  begin
    xinside := (TZoom.ClientToGraph(Vertex2).x >= x) and (TZoom.ClientToGraph(Vertex1).x <= x);
    if (TZoom.ClientToGraph(Vertex2).y > TZoom.ClientToGraph(Vertex1).y) then
    begin
      yinside := (TZoom.ClientToGraph(Vertex2).y >= y) and (TZoom.ClientToGraph(Vertex1).y <= y);
    end
    else
      yinside := (TZoom.ClientToGraph(Vertex1).y >= y) and (TZoom.ClientToGraph(Vertex2).y <= y);
  end
  else
  begin
    xinside := (TZoom.ClientToGraph(Vertex1).x >= x) and (TZoom.ClientToGraph(Vertex2).x <= x);
    if (TZoom.ClientToGraph(Vertex2).y > TZoom.ClientToGraph(Vertex1).y) then
    begin
      yinside := (TZoom.ClientToGraph(Vertex2).y >= y) and (TZoom.ClientToGraph(Vertex1).y <= y);
    end
    else
      yinside := (TZoom.ClientToGraph(Vertex1).y >= y) and (TZoom.ClientToGraph(Vertex2).y <= y);
  end;
  result := xinside and yinside;
end;

function TNode.isInVertex(Index: integer; x, y: integer): Boolean;
begin
  result := FVertex[Index].Inside(x, y);
end;

function TNode.MarshalToXML(XMLDoc: IXMLDocument; iXMLRootNode: IXMLNode; sNode: string): IXMLNode;
var
  iNodoObjeto: IXMLNode;
  i: integer;
begin
  iXMLRootNode.attributes['FId'] := Self.FId;
  iXMLRootNode.attributes['FInside'] := BoolToStr(Self.FInside);
  iXMLRootNode.attributes['FDrawing'] := BoolToStr(Self.FDrawing);
  Self.Properties.MarshalToXML(XMLDoc, iXMLRootNode, sNode);

  for i := 1 to 4 do
  begin
    iNodoObjeto := iXMLRootNode.AddChild('Vertex' + IntToStr(i));
    FVertex[i].MarshalToXML(XMLDoc, iNodoObjeto, 'Vertex' + IntToStr(i));
  end;

  iNodoObjeto := iXMLRootNode.AddChild('Center');
  FCenter.MarshalToXML(XMLDoc, iNodoObjeto, 'Center');
  iXMLRootNode.attributes['FImage'] := Self.FImage;

  // New version (Force - Directed)
  // ******************************
  iXMLRootNode.attributes['FHarmonicForcex'] := FloatToStr(Self.FHookeForce.r0);
  iXMLRootNode.attributes['FHarmonicForcey'] := FloatToStr(Self.FHookeForce.r1);
  iXMLRootNode.attributes['FSpeedx'] := FloatToStr(Self.FSpeed.r0);
  iXMLRootNode.attributes['FSpeedy'] := FloatToStr(Self.FSpeed.r1);
  iXMLRootNode.attributes['FCoulombForcex'] := FloatToStr(Self.FCoulombForce.r0);
  iXMLRootNode.attributes['FCoulombForcey'] := FloatToStr(Self.FCoulombForce.r1);
  iXMLRootNode.attributes['Fcc_number'] := IntToStr(Self.Fconnections);
  iXMLRootNode.attributes['FMass'] := FloatToStr(Self.Fmass);
  iXMLRootNode.attributes['FNodeType'] := NodeTypeToStr(Self.FnodeType);

  for i := 0 to FNeighbour.Count - 1 do
  begin
    iNodoObjeto := iXMLRootNode.AddChild('Neighbours' + IntToStr(i));
    iNodoObjeto.attributes['Id'] := FNeighbour[i];
  end;
  // *****************************
end;

procedure TNode.Move(x, y: Double);
var
  pt: TPointR;
begin
  pt := TZoom.GraphToClient(x, y);
  FVertex[2].x := FVertex[2].x + pt.x;
  FVertex[1].x := FVertex[1].x + pt.x;
  FVertex[3].x := FVertex[3].x + pt.x;
  FVertex[4].x := FVertex[4].x + pt.x;

  FVertex[2].y := FVertex[2].y + pt.y;
  FVertex[1].y := FVertex[1].y + pt.y;
  FVertex[3].y := FVertex[3].y + pt.y;
  FVertex[4].y := FVertex[4].y + pt.y;

  FCenter.x := FCenter.x + pt.x;
  FCenter.y := FCenter.y + pt.y;
end;

procedure TNode.MoveVertex(Index: integer; x, y: integer);
begin
  FVertex[Index].Move(x, y);
  if Index >= 3 then
    CalcPoints2()
  else
    CalcPoints();
  CalcCenter();
end;

function TNode.NodeTypeToStr(Value: TNodeType): string;
var
  res: string;
begin
  res := '';
  case Value of
    nOrigin:
      res := 'nOrigin';
    nDestiny:
      res := 'nDestiny';
    nNormal:
      res := 'nNormal';
    nLink:
      res := 'nLink'
  end;
  result := res;
end;

procedure TNode.SetAttachedObject(const Value: Pointer);
begin
  FAttachedObject := Value;
end;

procedure TNode.Setconnections(const Value: integer);
begin
  Fconnections := Value;
end;

procedure TNode.SetCenter(const Value: TVertex);
begin
  FCenter := Value;
end;

procedure TNode.SetCoulombForce(const Value: TForce);
begin
  FCoulombForce.SetVal(Value.r0, Value.r1);
end;

procedure TNode.SetDrawing(const Value: Boolean);
begin
  FDrawing := Value;
end;

procedure TNode.SetHookeForce(const Value: TForce);
begin
  FHookeForce.SetVal(Value.r0, Value.r1);
end;

procedure TNode.SetId(const Value: string);
begin
  FId := Value;
end;

procedure TNode.SetImage(const Value: string);
begin
  FImage := Value;
end;

procedure TNode.SetInside(const Value: Boolean);
begin
  FInside := Value;
end;

procedure TNode.Setmass(const Value: Double);
begin
  Fmass := Value;
end;

procedure TNode.SetNeighbour(const Value: TStringList);
begin
  FNeighbour := Value;
end;

procedure TNode.SetnodeType(const Value: TNodeType);
begin
  FnodeType := Value;
end;

procedure TNode.Setoptions(const Value: TOptionsApplication);
begin
  Foptions := Value;
end;

procedure TNode.AddNeighbour(id: string);
begin
  if not ExistsNeighbour(id) then
    FNeighbour.Add(id);
end;

procedure TNode.SetPrivateNode(const Value: TLayeredTreeInfo);
begin
  FPrivateNode := Value;
end;

procedure TNode.SetProperties(const Value: TNodeProperty);
begin
  FProperties := Value;
end;

procedure TNode.SetSpeed(const Value: TForce);
begin
  FSpeed.SetVal(Value.r0, Value.r1);
end;

procedure TNode.SetVertex(Index: integer; Value: TPoint);
begin
  FVertex[Index].x := Value.x;
  FVertex[Index].y := Value.y;
end;

function TNode.StrToNodeType(Value: String): TNodeType;
var
  res: TNodeType;
begin
  res := nNormal;
  if Value = 'nOrigin' then
    res := nOrigin;
  if Value = 'nDestiny' then
    res := nDestiny;
  if Value = 'nLink' then
    res := nLink;
  result := res;
end;

function TNode.UnMarshalFromXML(XMLDoc: IXMLDocument; iXMLRootNode: IXMLNode; sNode: string): IXMLNode;
var
  iNodoObjeto, iNodoAtributo: IXMLNode;
begin
  iNodoObjeto := iXMLRootNode;
  if iNodoObjeto.nodeName = sNode then
  begin
    Self.FId := iXMLRootNode.attributes['FId'];
    Self.FInside := StrToBool(iXMLRootNode.attributes['FInside']);
    Self.FDrawing := StrToBool(iXMLRootNode.attributes['FDrawing']);
    Self.Properties.UnMarshalFromXML(XMLDoc, iXMLRootNode, sNode);
    iNodoAtributo := iNodoObjeto.ChildNodes.first;
    while iNodoAtributo <> nil do
    begin
      Self.FVertex[1].UnMarshalFromXML(XMLDoc, iNodoAtributo, 'Vertex1');
      Self.FVertex[2].UnMarshalFromXML(XMLDoc, iNodoAtributo, 'Vertex2');
      Self.FVertex[3].UnMarshalFromXML(XMLDoc, iNodoAtributo, 'Vertex3');
      Self.FVertex[4].UnMarshalFromXML(XMLDoc, iNodoAtributo, 'Vertex4');
      Self.FCenter.UnMarshalFromXML(XMLDoc, iNodoAtributo, 'Center');
      // New version (Force - Directed)
      // ******************************
      if AnsiContainsStr(iNodoAtributo.nodeName, 'Neighbours') then
        Self.AddNeighbour(iNodoAtributo.attributes['Id']);
      // *****************************
      iNodoAtributo := iNodoAtributo.nextSibling;
    end;
    Self.FImage := iXMLRootNode.attributes['FImage'];

    // New version (Force - Directed)
    // ******************************
    Self.FHookeForce.sR0(StrToFloat(ReplaceStr(iXMLRootNode.attributes['FHarmonicForcex'],',','.')));
    Self.FHookeForce.sR1(StrToFloat(ReplaceStr(iXMLRootNode.attributes['FHarmonicForcey'],',','.')));
    Self.FSpeed.sR0(StrToFloat(ReplaceStr(iXMLRootNode.attributes['FSpeedx'],',','.')));
    Self.FSpeed.sR1(StrToFloat(ReplaceStr(iXMLRootNode.attributes['FSpeedy'],',','.')));
    Self.FCoulombForce.sR0(StrToFloat(ReplaceStr(iXMLRootNode.attributes['FCoulombForcex'],',','.')));
    Self.FCoulombForce.sR1(StrToFloat(ReplaceStr(iXMLRootNode.attributes['FCoulombForcey'],',','.')));
    Self.Fconnections := StrToInt(iXMLRootNode.attributes['Fcc_number']);
    Self.Fmass := StrToFloat(ReplaceStr(iXMLRootNode.attributes['FMass'],',','.'));
    try
      Self.FnodeType := StrToNodeType(iXMLRootNode.attributes['FNodeType']);
    except
      Self.FnodeType := nNormal;
    end;
    // *****************************
  end;
end;

function Compare(Item1, Item2: Pointer): integer;
begin
  if (TNode(Item1).Properties.zOrder > TNode(Item2).Properties.zOrder) then
    result := 1
  else if (TNode(Item1).Properties.zOrder = TNode(Item2).Properties.zOrder) then
    result := 0
  else
    result := -1
end;

end.
