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
unit vlo.lib.Graph;

interface

uses
  Windows, Messages, Classes, Graphics, Controls, Forms, ExtCtrls, vlo.lib.Node, vlo.lib.Connector, vlo.lib.Edge,
  vlo.lib.pattern.memento, vlo.lib.properties.Node, vlo.lib.properties.Edge, vlo.lib.Node.list,
  Menus, vlo.lib.options, vlo.lib.Layout, vlo.lib.grammar, vlo.lib.grammar.production, vlo.lib.properties.Abstract,
  vlo.lib.pattern.memento.Originator, vlo.lib.pattern.memento.Caretaker;

type
  TGraph = Class(TCustomControl)
  private
    FImage: TImage;
    SimpleLinesFactory: TSimpleEdgesFactory;
    DottedLinesFactory: TDottedEdgesFactory;
    FOnMouseDown: TMouseEvent;
    FOnMouseMove: TMouseMoveEvent;
    FOnMouseUp: TMouseEvent;
    FOnClick: TNotifyEvent;
    FImageBackground: String;
    ListTemp: TStringList;
    procedure drawRectangle(backgroundColor, ExternalColor: TColor);
    procedure DrawBackground;
    procedure ImageMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ImageMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure ImageMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ImageDblClick(Sender: TObject);
    procedure ImageClick(Sender: TObject);
    function SnapToGrid(X, Y: Integer): TPoint;
    function getTotalInside: Integer;
    procedure DrawLine(p1, p2: TPoint; color: TColor);
    procedure MarkSelected(p1, p2: TPoint);
    procedure DrawSelectionBox(p1, p2: TPoint);
    function ThereAreSelected: Boolean;
    procedure unMarkAll;
    procedure MoveBoxes(X, Y: Integer);
    procedure SetOnMouseDown(const Value: TMouseEvent);
    procedure SetOnMouseMove(const Value: TMouseMoveEvent);
    procedure SetOnMouseUp(const Value: TMouseEvent);
    procedure MarkBoxInside(X, Y: Integer);
    procedure DraggingVertexs(X, Y: Integer; var Drag1, Drag2, Drag3, Drag4: Boolean);
    procedure DraggingPointsLine(X, Y: Integer; var Point0, Point1, Point2: Boolean);
    function getMouseCursorBox(X, Y: Integer; cursorDef: smallint): smallint;
    function BoxAtNode(var box: TNode; X, Y: Integer; cursorDef: smallint): smallint;
    function MoveLine(var sLineTemp: TAbstractEdge; X, Y, index: Integer): TPoint;
    function MoveBox(BoxTemp: TNode; X, Y, index: Integer): TPoint;
    procedure SetOnClick(const Value: TNotifyEvent);
    procedure FillDefaultParams;
    procedure moveBoxesSelected(X, Y: Integer);
    procedure MoveIfisLoop(box: TNode; X, Y: Integer);
    procedure SetImageBackground(const Value: String);
  public
    FDefaultEdgeProperty: TEdgeProperty;
    FDefaultNodeProperty: TNodeProperty;
    FDefaultSelectedEdgeProperty: TEdgeProperty;
    FDefaultSelectedNodeProperty: TNodeProperty;
    FDefaultOriginNodeProperty: TNodeProperty;
    FDefaultLinkNodeProperty: TNodeProperty;
    FDefaultDestinyNodeProperty: TNodeProperty;
    nodeList: TNodeList;
    ConnectorList: TConnectorList;
    Rectangle: Boolean;
    Line: Boolean;
    LineConcept: TTypeEdge;
    StartDraw: Boolean;
    StartDraw2: Boolean;
    InitialPoint: TPoint;
    mBox: TNode;
    StarDrag: Boolean;
    dragPoint: TPoint;
    DragVertex1: Boolean;
    DragVertex2: Boolean;
    DragVertex3: Boolean;
    DragVertex4: Boolean;
    boxConnected: TNode;
    sbox: TNode;
    stepNode: TNode;
    sLine: TAbstractEdge;
    PointMouse: TPoint;
    zoom: Integer;
    doubleclick: Boolean;
    boxCopy: TNode;
    boxCopyList: TNodeList;
    AbstractProperty: TAbstractProperty;
    caretaker: TCaretaker;
    originator: TOriginator;
    Selection: Boolean;
    InitialSelection: TPoint;
    FinalSelection: TPoint;
    StartSelection: Boolean;
    multiSelect: Boolean;
    trobat: Boolean;
    gridSize: Integer;
    posTrobat: TPoint;
    DragVertexLine: Boolean;
    DragVertexLine2: Boolean;
    DragVertexLine0: Boolean;
    ShowGrid: Boolean;
    SnapToGridMark: Boolean;
    AfterDobleClick: Boolean;
    btLine: Boolean;
    btArrowLine: Boolean;
    btdArrowLine: Boolean;
    btlinkLine: Boolean;
    btdotdArrow: Boolean;
    btLinkdLine: Boolean;
    btdotarrow: Boolean;
    btdotLine: Boolean;
    PopupMenu: TPopupMenu;
    OwnerLeft: Integer;
    OwnerTop: Integer;
    OwnerWidth: Integer;
    options: TOptionsApplication;
    layout: TLayoutApplication;
    calculation_finished: Boolean;
    connected_components_count: Integer;
    overall_energie: extended;
    overall_energie_difference: extended;
    highest_energy: extended;
    thermal_energie: extended;
    timestep: Integer;
    speed: Integer;
    gravity: Integer;
    nodeType: TNodeType;
    max_repulsive_force_distance: Integer;
    isModified: Boolean;
    constructor Create(AOwner: TComponent); override;
    constructor CreateWithParams(AOwner: TComponent; Parent: TScrollBox; width, height: Integer; PopupMenu: TPopupMenu);
    destructor Destroy(); override;
    procedure Draw();
    procedure FillWithNumbers();
    procedure AutoFillConnectors();
    procedure Save(Project: String);
    procedure Load(Project: String);
    procedure ClearClipboard;
    procedure Copy;
    procedure SaveState;
    procedure SaveImagetoFile;
    procedure SelectAll;
    procedure SetConnectorLoop;
    procedure CopyProperties;
    procedure Delete;
    procedure MarkasDestination;
    procedure MarxasSource;
    procedure Paste;
    procedure OpenLayoutProperties;
    procedure PasteProperties;
    procedure MoveDown(precision: Integer);
    procedure MoveLeft(precision: Integer);
    procedure MoveRight(precision: Integer);
    procedure MoveUp(precision: Integer);
    procedure RestoreDefaults;
    procedure putBack;
    procedure putFront;
    procedure putOnDown;
    procedure putOnLeft;
    procedure putOnRight;
    procedure putOnTop;
    procedure UndoState;
    procedure OpenDefaultProperties;
    procedure showProperties;
    procedure MarxasNormal;
    procedure MarxasLink;
    procedure calculateStep();
    function CalculateConnectedComponents(): Boolean;
    procedure CenterGraph();
    function getLineFactory(kindof: TTypeEdge): TAbstractEdge;
    procedure applyDijkstra();
    procedure RestoreDefaultProperties();
    procedure FillWithValues();
    procedure OpenDefaultSelectedProperties;
    procedure OpenDefaultOriginProperties;
    procedure FillWithValuesNumeric();
    procedure RestoreProperties();
    procedure MarshalToXML(sFile: string);
    procedure UnMarshalFromXML(sFile: string);
    procedure SetAsMultiSource();
    procedure ConnectToDestination();
    function isThereStartNode(): Boolean;
    function isThereEndNode(): Boolean;
    procedure SetInitialState(color: TColor);
    function getInitialState(): TNode;
    function checkEverythinghasaName() : Boolean;
    function ProcessDFAStep(character: string; color : TColor; var isLambda : boolean): Boolean;
    function GetDFAStep(var status: Boolean): TNode;
    procedure ResetState();
    function getGrammar() : TGrammar;
    function recursiveNodes(node : TNode; grammar : TGrammar) : Boolean;
  protected
    procedure DblClick; override;
  published
    property OnMouseDown: TMouseEvent read FOnMouseDown write SetOnMouseDown;
    property OnMouseMove: TMouseMoveEvent read FOnMouseMove write SetOnMouseMove;
    property OnMouseUp: TMouseEvent read FOnMouseUp write SetOnMouseUp;
    property OnDblClick;
    property OnClick: TNotifyEvent read FOnClick write SetOnClick;
    property Image: TImage read FImage;
    property ImageBackground: String read FImageBackground write SetImageBackground;
  End;

implementation

uses
  sysutils, BoxProperties, LineProperties, vlo.lib.node.alignment, vlo.lib.intersection, Dialogs,
  defaultProperties, iniFiles, vlo.lib.Math, vlo.lib.vertex, vlo.lib.zoom, frmLayout, vlo.lib.Routing.Dijkstra,
  vlo.lib.Math.Line, defaultSelectProperties,
  defaultOriginProperties, vlo.lib.font.serializer, jpeg, vlo.lib.resources, XMLDoc, XMLIntf, StrUtils, PerlRegEx;

{ TGraph }

procedure TGraph.applyDijkstra;
var
  objDijkstra: TDijkstra;
begin
  objDijkstra := TDijkstra.Create(nodeList, ConnectorList, FDefaultSelectedNodeProperty, FDefaultSelectedEdgeProperty);
  try
    objDijkstra.ApplyAlgorithm;
  finally
    FreeAndNil(objDijkstra);
  end;
  Draw();
end;

procedure TGraph.AutoFillConnectors;
  function getConnexionsSource(id: string): Integer;
  var
    i, Count: Integer;
  begin
    Count := 0;
    for i := 0 to ConnectorList.Count - 1 do
    begin
      if ConnectorList[i].SourceNode.id = id then
        Count := Count + 1;
    end;
    Result := Count;
  end;

  procedure renameAllSources(id: string; num: Integer);
  var
    start, i: Integer;
    con: TConnector;
  begin
    case num of
      1:
        start := 1;
      2:
        start := 1;
    else
      start := 1;
    end;
    for i := 0 to ConnectorList.Count - 1 do
    begin
      con := ConnectorList[i];
      if (con.SourceNode.id = id) and (con.TargetNode.properties.fillColor <> clBlue) then
      begin
        con.Edge.properties.Description.Text := inttostr(start);
        start := start + 1;
      end;
    end;
  end;

var
  i: Integer;
  numConnexiones: Integer;
begin
  for i := 0 to nodeList.Count - 1 do
  begin
    if nodeList[i].properties.fillColor <> clBlue then
    begin
      numConnexiones := getConnexionsSource(nodeList[i].id);
      if numConnexiones <> 0 then
        renameAllSources(nodeList[i].id, numConnexiones);
    end;
  end;
  Draw();
end;

constructor TGraph.Create(AOwner: TComponent);
begin
  inherited;
end;

constructor TGraph.CreateWithParams(AOwner: TComponent; Parent: TScrollBox; width, height: Integer; PopupMenu: TPopupMenu);
begin
  Create(AOwner);
  Self.PopupMenu := PopupMenu;
  FImage := TImage.Create(AOwner);
  FImage.width := width;
  FImage.height := height;
  FImage.Top := 0;
  FImage.Left := 0;
  FImage.Align := alNone;
  FImage.Parent := Parent;
  FImage.OnMouseDown := ImageMouseDown;
  FImage.OnMouseMove := ImageMouseMove;
  FImage.OnMouseUp := ImageMouseUp;
  FImage.OnDblClick := ImageDblClick;
  FImage.OnClick := ImageClick;
  FImage.PopupMenu := Self.PopupMenu;
  zoom := 100;
  FImageBackground := '';
  nodeList := TNodeList.Create();
  ConnectorList := TConnectorList.Create();
  SimpleLinesFactory := TSimpleEdgesFactory.Create(FImage.Canvas);
  DottedLinesFactory := TDottedEdgesFactory.Create(FImage.Canvas);
  LineConcept := noEdge;
  AbstractProperty := nil;
  boxCopy := nil;
  ShowGrid := true;
  caretaker := TCaretaker.Create();
  originator := TOriginator.Create();
  ShowGrid := true;
  SnapToGridMark := true;
  AfterDobleClick := false;
  FDefaultEdgeProperty := TEdgeProperty.Create;
  FDefaultNodeProperty := TNodeProperty.Create;
  FDefaultSelectedEdgeProperty := TEdgeProperty.Create;
  FDefaultSelectedNodeProperty := TNodeProperty.Create;
  FDefaultOriginNodeProperty := TNodeProperty.Create;
  FDefaultDestinyNodeProperty := TNodeProperty.Create;
  FDefaultLinkNodeProperty := TNodeProperty.Create;
  FillDefaultParams();
  ListTemp := nil;
  calculation_finished := false;
  connected_components_count := 0;
  overall_energie := 0;
  overall_energie_difference := 1000;

  speed := 12;
  gravity := 96;
  max_repulsive_force_distance := 512;
  layout := TLayoutApplication.Create;
  nodeType := nNormal;
end;

procedure TGraph.FillDefaultParams();
var
  ini: TIniFile;
begin
  ini := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
  try
    FDefaultNodeProperty.penWidth := StrToInt(ini.ReadString('NODE', 'PenWidth', '1'));
    FDefaultNodeProperty.fillColor := StrToInt(ini.ReadString('NODE', 'BoxColor', '16777215'));
    FDefaultNodeProperty.LineColor := StrToInt(ini.ReadString('NODE', 'LineColor', '0'));
    FDefaultNodeProperty.SelectedColor := StrToInt(ini.ReadString('NODE', 'SelectedColor', '255'));
    FDefaultNodeProperty.ColorFontifImage := StrToInt(ini.ReadString('NODE', 'ColorFontifImage', '255'));
    FDefaultNodeProperty.ColorNodeifImage := StrToInt(ini.ReadString('NODE', 'ColorNodeifImage', '255'));
    FDefaultNodeProperty.ColorBorderIfImage := StrToInt(ini.ReadString('NODE', 'ColorBorderifImage', '255'));
    TFontParser.Deserializer(ini, 'NODE', FDefaultNodeProperty);

    FDefaultEdgeProperty.LenArrow := StrToInt(ini.ReadString('EDGE', 'ArrowLength', '12'));
    FDefaultEdgeProperty.penWidth := StrToInt(ini.ReadString('EDGE', 'PenWidth', '1'));
    FDefaultEdgeProperty.InclinationAngle := StrToInt(ini.ReadString('EDGE', 'ArrowAngle', '30'));
    FDefaultEdgeProperty.LineColor := StrToInt(ini.ReadString('EDGE', 'LineColor', '0'));
    FDefaultEdgeProperty.Filled := StrToBool(ini.ReadString('EDGE', 'Filled', '0'));
    FDefaultEdgeProperty.fillColor := StrToInt(ini.ReadString('EDGE', 'FillColor', '0'));
    FDefaultEdgeProperty.SelectedColor := StrToInt(ini.ReadString('EDGE', 'SelectedColor', '255'));
    TFontParser.Deserializer(ini, 'EDGE', FDefaultEdgeProperty);

    FDefaultSelectedNodeProperty.penWidth := StrToInt(ini.ReadString('SELECTEDNODE', 'PenWidth', '1'));
    FDefaultSelectedNodeProperty.fillColor := StrToInt(ini.ReadString('SELECTEDNODE', 'BoxColor', '16777215'));
    FDefaultSelectedNodeProperty.LineColor := StrToInt(ini.ReadString('SELECTEDNODE', 'LineColor', '0'));
    FDefaultSelectedNodeProperty.SelectedColor := StrToInt(ini.ReadString('SELECTEDNODE', 'SelectedColor', '255'));
    FDefaultSelectedNodeProperty.ColorFontifImage := StrToInt(ini.ReadString('SELECTEDNODE', 'ColorFontifImage', '255'));
    FDefaultSelectedNodeProperty.ColorNodeifImage := StrToInt(ini.ReadString('SELECTEDNODE', 'ColorNodeifImage', '255'));
    FDefaultSelectedNodeProperty.ColorBorderIfImage := StrToInt(ini.ReadString('SELECTEDNODE', 'ColorBorderifImage', '255'));
    TFontParser.Deserializer(ini, 'SELECTEDNODE', FDefaultSelectedNodeProperty);

    FDefaultSelectedEdgeProperty.LenArrow := StrToInt(ini.ReadString('SELECTEDEDGE', 'ArrowLength', '12'));
    FDefaultSelectedEdgeProperty.penWidth := StrToInt(ini.ReadString('SELECTEDEDGE', 'PenWidth', '1'));
    FDefaultSelectedEdgeProperty.InclinationAngle := StrToInt(ini.ReadString('SELECTEDEDGE', 'ArrowAngle', '30'));
    FDefaultSelectedEdgeProperty.LineColor := StrToInt(ini.ReadString('SELECTEDEDGE', 'LineColor', '0'));
    FDefaultSelectedEdgeProperty.Filled := StrToBool(ini.ReadString('SELECTEDEDGE', 'Filled', '0'));
    FDefaultSelectedEdgeProperty.fillColor := StrToInt(ini.ReadString('SELECTEDEDGE', 'FillColor', '0'));
    FDefaultSelectedEdgeProperty.SelectedColor := StrToInt(ini.ReadString('SELECTEDEDGE', 'SelectedColor', '255'));
    TFontParser.Deserializer(ini, 'SELECTEDEDGE', FDefaultSelectedEdgeProperty);

    FDefaultOriginNodeProperty.penWidth := StrToInt(ini.ReadString('ORIGINNODE', 'PenWidth', '4'));
    FDefaultOriginNodeProperty.fillColor := StrToInt(ini.ReadString('ORIGINNODE', 'BoxColor', '458496'));
    FDefaultOriginNodeProperty.LineColor := StrToInt(ini.ReadString('ORIGINNODE', 'LineColor', '0'));
    FDefaultOriginNodeProperty.SelectedColor := StrToInt(ini.ReadString('ORIGINNODE', 'SelectedColor', '255'));
    FDefaultOriginNodeProperty.ColorFontifImage := StrToInt(ini.ReadString('ORIGINNODE', 'ColorFontifImage', '255'));
    FDefaultOriginNodeProperty.ColorNodeifImage := StrToInt(ini.ReadString('ORIGINNODE', 'ColorNodeifImage', '255'));
    FDefaultOriginNodeProperty.ColorBorderIfImage := StrToInt(ini.ReadString('ORIGINNODE', 'ColorBorderifImage', '255'));
    TFontParser.Deserializer(ini, 'ORIGINNODE', FDefaultOriginNodeProperty);

    FDefaultDestinyNodeProperty.penWidth := StrToInt(ini.ReadString('DESTINYNODE', 'PenWidth', '4'));
    FDefaultDestinyNodeProperty.fillColor := StrToInt(ini.ReadString('DESTINYNODE', 'BoxColor', '16318719'));
    FDefaultDestinyNodeProperty.LineColor := StrToInt(ini.ReadString('DESTINYNODE', 'LineColor', '0'));
    FDefaultDestinyNodeProperty.SelectedColor := StrToInt(ini.ReadString('DESTINYNODE', 'SelectedColor', '255'));
    FDefaultDestinyNodeProperty.ColorFontifImage := StrToInt(ini.ReadString('DESTINYNODE', 'ColorFontifImage', '255'));
    FDefaultDestinyNodeProperty.ColorNodeifImage := StrToInt(ini.ReadString('DESTINYNODE', 'ColorNodeifImage', '255'));
    FDefaultDestinyNodeProperty.ColorBorderIfImage := StrToInt(ini.ReadString('DESTINYNODE', 'ColorBorderifImage', '255'));
    TFontParser.Deserializer(ini, 'DESTINYNODE', FDefaultDestinyNodeProperty);

    FDefaultLinkNodeProperty.penWidth := StrToInt(ini.ReadString('LINKNODE', 'PenWidth', '4'));
    FDefaultLinkNodeProperty.fillColor := StrToInt(ini.ReadString('LINKNODE', 'BoxColor', '33023'));
    FDefaultLinkNodeProperty.LineColor := StrToInt(ini.ReadString('LINKNODE', 'LineColor', '0'));
    FDefaultLinkNodeProperty.SelectedColor := StrToInt(ini.ReadString('LINKNODE', 'SelectedColor', '255'));
    FDefaultLinkNodeProperty.ColorFontifImage := StrToInt(ini.ReadString('LINKNODE', 'ColorFontifImage', '255'));
    FDefaultLinkNodeProperty.ColorNodeifImage := StrToInt(ini.ReadString('LINKNODE', 'ColorNodeifImage', '255'));
    FDefaultLinkNodeProperty.ColorBorderIfImage := StrToInt(ini.ReadString('LINKNODE', 'ColorBorderifImage', '255'));
    TFontParser.Deserializer(ini, 'LINKNODE', FDefaultLinkNodeProperty);
  finally
    ini.Free;
  end;
end;

procedure TGraph.DblClick;
begin
  inherited;
end;

destructor TGraph.Destroy;
var
  memento: TMemento;
  i: Integer;
begin
  FreeAndNil(FImage);
  FreeAndNil(ConnectorList);
  FreeAndNil(nodeList);
  FreeAndNil(SimpleLinesFactory);
  FreeAndNil(DottedLinesFactory);
  FreeAndNil(originator);
  for i := 0 to caretaker.FSavedStates.Count - 1 do
  begin
    memento := caretaker.FSavedStates.items[i] as TMemento;
    memento.clearObjects;
  end;
  FreeAndNil(caretaker);
  if Assigned(boxCopyList) then
    FreeAndNil(boxCopyList);

  sbox := nil;
  FreeAndNil(FDefaultEdgeProperty);
  FreeAndNil(FDefaultNodeProperty);
  FreeAndNil(FDefaultSelectedEdgeProperty);
  FreeAndNil(FDefaultSelectedNodeProperty);
  FreeAndNil(FDefaultOriginNodeProperty);
  FreeAndNil(FDefaultLinkNodeProperty);
  FreeAndNil(FDefaultDestinyNodeProperty);
  FreeAndNil(layout);
  if Assigned(ListTemp) then
    FreeAndNil(ListTemp);
  inherited;
end;

procedure TGraph.Draw;
var
  i: Integer;
  Points1, Points2: TPoint;
  Conn: TConnector;
  Bitmap: Graphics.TBitmap;
begin
  drawRectangle(options.backgroundColor, options.backgroundColor);
  if ShowGrid then
    DrawBackground();

  DrawSelectionBox(InitialSelection, FinalSelection);

  if (FImageBackground <> '') and FileExists(FImageBackground) then
  begin
    Bitmap := Graphics.TBitmap.Create;
    Bitmap.LoadFromFile(FImageBackground);
    FImage.Canvas.Draw(0, 0, Bitmap);
    FreeAndNil(Bitmap);
  end;

  for i := 0 to ConnectorList.Count - 1 do
  begin
    Conn := ConnectorList[i];
    if Conn.SourceNode.id <> Conn.TargetNode.id then
    begin
      Conn.Edge.FSource := Conn.SourceNode.Center.position;
      Points1 := TInstersection.GetPointInter(Conn.Edge.GetLastModified, Conn.TargetNode);
      if (Points1.X <> -1) and (Points1.Y <> -1) then
      begin
        Conn.Edge.FTarget := Conn.TargetNode.Center.position;
        Points2 := TInstersection.GetPointInter(Conn.Edge.GetFirstModified, Conn.SourceNode);
        if (Points2.X <> -1) and (Points2.Y <> -1) then
        begin
          Conn.Edge.Draw(TZoom.ClientToGraph(Conn.SourceNode.Center.position), TZoom.ClientToGraph(Conn.TargetNode.Center.position), TZoom.ClientToGraph(Points2), TZoom.ClientToGraph(Points1));
        end;
      end;
    end
    else
    begin
      Points1 := TInstersection.GetPointInter(Conn.Edge.GetLastModified, Conn.SourceNode);
      if (Points1.X <> -1) and (Points1.Y <> -1) then
      begin
        Conn.Edge.Draw(TZoom.ClientToGraph(Conn.SourceNode.Center.position), TZoom.ClientToGraph(Conn.TargetNode.Center.position), TZoom.ClientToGraph(Points1), TZoom.ClientToGraph(Points1));
      end;
    end;
  end;
  for i := 0 to nodeList.Count - 1 do
    nodeList.items[i].Draw(FImage.Canvas);
end;

procedure TGraph.drawRectangle(backgroundColor, ExternalColor: TColor);
begin
  FImage.Canvas.Brush.Style := bsSolid;
  FImage.Canvas.Brush.color := backgroundColor;
  FImage.Canvas.Pen.width := 3;
  FImage.Canvas.Pen.color := ExternalColor;
  FImage.Canvas.Rectangle(0, 0, FImage.width, FImage.height);
end;

procedure TGraph.FillWithNumbers;
var
  i: Integer;
begin
  for i := 0 to nodeList.Count - 1 do
    nodeList[i].properties.Description.Text := inttostr(i + 1);
  Draw();
end;

procedure TGraph.FillWithValues;
var
  i: Integer;
  connector: TConnector;
begin
  for i := 0 to nodeList.Count - 1 do
  begin
    if (nodeList[i].properties.getText = '') or options.RewriteOnFilling then
      nodeList[i].properties.Description.Text := inttostr(i + 1);
  end;
  for i := 0 to ConnectorList.Count - 1 do
  begin
    connector := ConnectorList[i];
    if not connector.Edge.ClassNameIs('TAbstractSimpleDoubleLinkedArrowEdge') and not connector.Edge.ClassNameIs('TAbstractDottedDoubleLinkedArrowEdge') then
      if (connector.SourceNode.nodeType <> nLink) and (connector.TargetNode.nodeType <> nLink) then
        if (connector.Edge.properties.getText = '') or options.RewriteOnFilling then
          connector.Edge.properties.Description.Text := inttostr(Round(Distance(connector.SourceNode.Center.position, connector.TargetNode.Center.position)));
  end;
  Draw();
end;

procedure TGraph.FillWithValuesNumeric;
  function getConnexionsSource(id: string): Integer;
  var
    i, Count: Integer;
  begin
    Count := 0;
    for i := 0 to ConnectorList.Count - 1 do
    begin
      if ConnectorList[i].SourceNode.id = id then
        Count := Count + 1;
    end;
    Result := Count;
  end;

  procedure renameAllSources(id: string; num: Integer);
  var
    start, i: Integer;
    con: TConnector;
  begin
    case num of
      1:
        start := 1;
      2:
        start := 1;
    else
      start := 1;
    end;
    for i := 0 to ConnectorList.Count - 1 do
    begin
      con := ConnectorList[i];
      if not con.Edge.ClassNameIs('TAbstractSimpleDoubleLinkedArrowEdge') and not con.Edge.ClassNameIs('TAbstractDottedDoubleLinkedArrowEdge') then
        if (con.SourceNode.id = id) and (con.TargetNode.nodeType <> nLink) then
        begin
          con.Edge.properties.Description.Text := inttostr(start);
          start := start + 1;
        end;
    end;
  end;

var
  i: Integer;
  numConnexiones: Integer;
begin
  for i := 0 to nodeList.Count - 1 do
  begin
    if (nodeList[i].properties.getText = '') or options.RewriteOnFilling then
      nodeList[i].properties.Description.Text := inttostr(i + 1);
  end;
  for i := 0 to nodeList.Count - 1 do
  begin
    if nodeList[i].nodeType <> nLink then
    begin
      numConnexiones := getConnexionsSource(nodeList[i].id);
      if numConnexiones <> 0 then
        renameAllSources(nodeList[i].id, numConnexiones);
    end;
  end;
  Draw();
end;

function TGraph.GetDFAStep(var status: Boolean): TNode;
begin
  status := false;
  if not Assigned(stepNode) then
    stepNode := getInitialState();
end;

procedure TGraph.ImageClick(Sender: TObject);
begin
  if Assigned(FOnClick) then
    FOnClick(Sender);
end;

procedure TGraph.OpenDefaultProperties();
var
  frmProperties: TfrmDefault;
begin
  Application.CreateForm(TfrmDefault, frmProperties);
  frmProperties.DefaultEdgeProperty := FDefaultEdgeProperty;
  frmProperties.DefaultNodeProperty := FDefaultNodeProperty;
  frmProperties.option := Self.options;
  frmProperties.Left := OwnerLeft + (OwnerWidth - frmProperties.width - 23);
  frmProperties.Top := OwnerTop + HeightForm + 25;
  frmProperties.ShowModal;
end;

procedure TGraph.OpenDefaultSelectedProperties();
var
  frmProperties: TfrmSelectProperties;
begin
  Application.CreateForm(TfrmSelectProperties, frmProperties);
  frmProperties.DefaultEdgeProperty := FDefaultEdgeProperty;
  frmProperties.DefaultNodeProperty := FDefaultNodeProperty;
  frmProperties.DefaultSelectedEdgeProperty := FDefaultSelectedEdgeProperty;
  frmProperties.DefaultSelectedNodeProperty := FDefaultSelectedNodeProperty;
  frmProperties.DefaultOriginNodeProperty := FDefaultOriginNodeProperty;
  frmProperties.DefaultDestinyNodeProperty := FDefaultDestinyNodeProperty;
  frmProperties.option := Self.options;
  frmProperties.Left := OwnerLeft + (OwnerWidth - frmProperties.width - 23);
  frmProperties.Top := OwnerTop + HeightForm + 25;
  frmProperties.ShowModal;
end;

procedure TGraph.OpenDefaultOriginProperties();
var
  frmProperties: TfrmOriginProperties;
begin
  Application.CreateForm(TfrmOriginProperties, frmProperties);
  frmProperties.DefaultOriginNodeProperty := FDefaultOriginNodeProperty;
  frmProperties.DefaultDestinyNodeProperty := FDefaultDestinyNodeProperty;
  frmProperties.DefaultLinkNodeProperty := FDefaultLinkNodeProperty;
  frmProperties.option := Self.options;
  frmProperties.Left := OwnerLeft + (OwnerWidth - frmProperties.width - 23);
  frmProperties.Top := OwnerTop + HeightForm + 25;
  frmProperties.ShowModal;
end;

procedure TGraph.OpenLayoutProperties();
var
  frmLayout: TfLayout;
begin
  Application.CreateForm(TfLayout, frmLayout);
  frmLayout.layout := Self.layout;
  frmLayout.Left := OwnerLeft + (OwnerWidth - frmLayout.width - 23);
  frmLayout.Top := OwnerTop + HeightForm + 25;
  frmLayout.ShowModal;
end;

procedure TGraph.showProperties();
begin
  ImageDblClick(Self.FImage);
end;

procedure TGraph.ImageDblClick(Sender: TObject);
var
  i: Integer;
  frmBoxProp: TFrmBoxProp;
  frmLineProp: TFrmLineProp;
begin
  // Line := false;
  // LineConcept := noEdge;
  // Selection := false;
  for i := 0 to nodeList.Count - 1 do
  begin
    if nodeList.items[i].Inside then
    begin
      Application.CreateForm(TFrmBoxProp, frmBoxProp);
      frmBoxProp.node := nodeList.items[i];
      frmBoxProp.nodeList := nodeList;
      frmBoxProp.Left := OwnerLeft + (OwnerWidth - frmBoxProp.width - 23);
      frmBoxProp.Top := OwnerTop + HeightForm + 25;
      frmBoxProp.ShowModal;
      break;
    end;
  end;
  StarDrag := false;
  for i := 0 to nodeList.Count - 1 do
  begin
    nodeList.items[i].Inside := false;
  end;
  doubleclick := true;

  for i := 0 to ConnectorList.Count - 1 do
  begin
    if ConnectorList[i].Edge.Inside then
    begin
      sLine := nil;
      if not ConnectorList[i].Edge.ClassNameIs('TAbstractSimpleDoubleLinkedArrowEdge') and not ConnectorList[i].Edge.ClassNameIs('TAbstractDottedDoubleLinkedArrowEdge') then
      begin
        Application.CreateForm(TFrmLineProp, frmLineProp);
        frmLineProp.Line := ConnectorList[i].Edge;
        frmLineProp.Left := OwnerLeft + (OwnerWidth - frmLineProp.width - 23);
        frmLineProp.Top := OwnerTop + HeightForm + 25;
        frmLineProp.ShowModal;
        if frmLineProp.validate then
        begin
          FreeAndNil(ConnectorList[i].Edge);
          ConnectorList[i].Edge := frmLineProp.Line;
          ConnectorList[i].Edge.Inside := false;
        end;
      end;
      DragVertexLine := false;
      DragVertexLine0 := false;
      DragVertexLine2 := false;
      sLine := nil;
      AfterDobleClick := true;
      break;
    end;
  end;
  for i := 0 to ConnectorList.Count - 1 do
  begin
    ConnectorList[i].Edge.Inside := false;
  end;
end;

procedure TGraph.MarkBoxInside(X, Y: Integer);
var
  i: Integer;
begin
  for i := 0 to nodeList.Count - 1 do
  begin
    if nodeList.items[i].isInside(X, Y) then
      nodeList.items[i].Inside := true;
  end;
end;

procedure TGraph.DraggingVertexs(X, Y: Integer; var Drag1: Boolean; var Drag2: Boolean; var Drag3: Boolean; var Drag4: Boolean);
var
  i: Integer;
begin
  for i := 0 to nodeList.Count - 1 do
  begin
    if nodeList.items[i].isInVertex(1, X, Y) then
    begin
      Drag1 := true;
      break;
    end;
    if nodeList.items[i].isInVertex(2, X, Y) then
    begin
      Drag2 := true;
      break;
    end;
    if nodeList.items[i].isInVertex(3, X, Y) then
    begin
      Drag3 := true;
      break;
    end;
    if nodeList.items[i].isInVertex(4, X, Y) then
    begin
      Drag4 := true;
      break;
    end;
  end;
end;

procedure TGraph.DraggingPointsLine(X, Y: Integer; var Point0: Boolean; var Point1: Boolean; var Point2: Boolean);
begin
  if sLine.InsideVertex(1, X, Y) then
    Point1 := true
  else if sLine.InsideVertex(2, X, Y) then
    Point2 := true
  else if sLine.InsideVertex(0, X, Y) then
    Point0 := true;
end;

procedure TGraph.ImageMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i, j: Integer;
  boxSelected: TNode;
  pt: TPoint;
begin
  pt := point(X, Y); // ClientToGraph(x,y);
  if ssShift in Shift then
  begin
    MarkBoxInside(pt.X, pt.Y);
    multiSelect := (getTotalInside() > 1);
    Draw();
  end
  else if multiSelect then
  begin
    trobat := false;
    for i := 0 to nodeList.Count - 1 do
    begin
      if nodeList.items[i].isInside(pt.X, pt.Y) then
      begin
        trobat := true;
        posTrobat := point(pt.X, pt.Y);
        break;
      end;
    end;
    if not trobat then
    begin
      multiSelect := false;
      posTrobat := point(-1, -1);
      unMarkAll();
      Draw();
    end;
  end
  else
  begin
    if Selection then
    begin
      InitialSelection := point(pt.X, pt.Y);
      StartSelection := true;
    end
    else
    begin
      sbox := nil;
      if Rectangle then
      begin
        StartDraw := true;
        InitialPoint := SnapToGrid(pt.X, pt.Y);
        mBox := TNode.Create();
        mBox.options := Self.options;
        mBox.properties.Assign(FDefaultNodeProperty);
      end;
      boxSelected := nil;
      for i := 0 to nodeList.Count - 1 do
      begin
        if nodeList.items[i].isInside(pt.X, pt.Y) then
        begin
          if Line then
          begin
            StartDraw2 := true;
            InitialPoint := TZoom.ClientToGraph(nodeList.items[i].Center.position);
            nodeList.items[i].Drawing := true;
            nodeType := nodeList.items[i].nodeType;
            boxConnected := nodeList.items[i];
          end;
          nodeList.items[i].Inside := true;
          boxSelected := nodeList.items[i];
          break;
        end
        else
          nodeList.items[i].Inside := false;
      end;

      if boxSelected = nil then
      begin
        for i := 0 to ConnectorList.Count - 1 do
        begin
          if ConnectorList[i].Edge.PointOnLine(point(pt.X, pt.Y)) and not AfterDobleClick then
          begin
            ConnectorList[i].Edge.Inside := true;
            sLine := ConnectorList[i].Edge;
            AfterDobleClick := false;
          end
          else
            ConnectorList[i].Edge.Inside := false;
        end;
      end
      else
        for i := 0 to ConnectorList.Count - 1 do
          ConnectorList[i].Edge.Inside := false;

      if boxSelected <> nil then
        for j := 0 to nodeList.Count - 1 do
        begin
          if nodeList.items[j] <> boxSelected then
            nodeList.items[j].Inside := false;
        end;
      Draw();
      if not Rectangle and not Line then
      begin
        DraggingVertexs(TZoom.GraphToClient(pt).X, TZoom.GraphToClient(pt).Y, DragVertex1, DragVertex2, DragVertex3, DragVertex4);
        if (sLine <> nil) and not sLine.ClassNameIs('TAbstractSimpleDoubleLinkedArrowEdge') and not sLine.ClassNameIs('TAbstractDottedDoubleLinkedArrowEdge') then
        begin
          DraggingPointsLine(TZoom.GraphToClient(pt).X, TZoom.GraphToClient(pt).Y, DragVertexLine0, DragVertexLine, DragVertexLine2);
        end;
        if not DragVertex1 and not DragVertex2 and not DragVertex3 and not DragVertex4 then
          StarDrag := true;
        dragPoint := SnapToGrid(pt.X, pt.Y);
      end;
    end;
  end;
  if Assigned(FOnMouseDown) then
    FOnMouseDown(Sender, Button, Shift, X, Y);
end;

function TGraph.getMouseCursorBox(X, Y: Integer; cursorDef: smallint): smallint;
var
  i: Integer;
  cursor: smallint;
begin
  cursor := cursorDef;
  for i := 0 to nodeList.Count - 1 do
  begin
    if nodeList.items[i].isInVertex(1, X, Y) or nodeList.items[i].isInVertex(2, X, Y) then
    begin
      cursor := crSizeNWSE;
      break;
    end
    else if nodeList.items[i].isInVertex(3, X, Y) or nodeList.items[i].isInVertex(4, X, Y) then
    begin
      cursor := crSizeNESW;
      break;
    end
    else if nodeList.items[i].isInside(X, Y) then
    begin
      cursor := crSizeAll;
      break;
    end
    else
      cursor := cursorDef;
  end;
  Result := cursor;
end;

function TGraph.BoxAtNode(var box: TNode; X, Y: Integer; cursorDef: smallint): smallint;
var
  i: Integer;
  resCursor: smallint;
begin
  resCursor := cursorDef;
  if box = nil then
  begin
    for i := 0 to nodeList.Count - 1 do
    begin
      if nodeList.items[i].isInVertex(1, X, Y) or nodeList.items[i].isInVertex(2, X, Y) then
      begin
        box := nodeList.items[i];
        resCursor := crSizeNWSE;
        break;
      end
      else if nodeList.items[i].isInVertex(3, X, Y) or nodeList.items[i].isInVertex(4, X, Y) then
      begin
        box := nodeList.items[i];
        resCursor := crSizeNESW;
        break;
      end
      else if nodeList.items[i].isInside(X, Y) then
      begin
        // if (LineConcept <> SimpleDoubleLinkedArrowEdge) and (LineConcept <> DottedDoubleLinkedArrowEdge) then
        // begin
        box := nodeList.items[i];
        resCursor := crSizeAll;
        break;
        // end
        // else if (nodeType <> nLink) and (nodeList.Items[i].nodeType = nLink) and
        // ((LineConcept = SimpleDoubleLinkedArrowEdge) or
        // (LineConcept = DottedDoubleLinkedArrowEdge)) then
        // begin
        // //Si vinc de normal cap a nLink, només haig d'habilitar si es nLink si tinc LineConcept.
        // box := nodeList.items[i];
        // resCursor := crSizeAll;
        // break;
        // end
        // else if (nodeType = nLink) and (nodeList.Items[i].nodeType <> nLink) and
        // ((LineConcept = SimpleDoubleLinkedArrowEdge) or
        // (LineConcept = DottedDoubleLinkedArrowEdge)) then
        // begin
        // //Si vinc de normal cap a nLink, només haig d'habilitar si es nLink si tinc LineConcept.
        // box := nodeList.items[i];
        // resCursor := crSizeAll;
        // break;
        // end
        // else
        // begin
        // resCursor := cursorDef;
        // Break;
        // end;
      end
      else
        resCursor := cursorDef;
    end;
  end
  else
  begin
    if box.isInVertex(1, X, Y) or box.isInVertex(2, X, Y) then
      resCursor := crSizeNWSE
    else if box.isInVertex(3, X, Y) or box.isInVertex(4, X, Y) then
      resCursor := crSizeNESW;
  end;
  Result := resCursor;
end;

function TGraph.CalculateConnectedComponents(): Boolean;
var
  all_node_ids, node_ids_to_process, visited_node_ids: TStringList;
  i: Integer;
  last_item: String;
  anchor_node_id: String;
  anchor_node: TNode;
  neighbour_node_id: String;
  connected_component_number: Integer;
  bOK: Boolean;
begin
  bOK := false;
  all_node_ids := TStringList.Create;
  node_ids_to_process := TStringList.Create;
  visited_node_ids := TStringList.Create;

  for i := 0 to nodeList.Count - 1 do
  begin
    all_node_ids.add(nodeList.items[i].id);
  end;
  connected_component_number := 0;
  while (all_node_ids.Count > 0) do
  begin
    last_item := all_node_ids[all_node_ids.Count - 1];
    all_node_ids.Delete(all_node_ids.Count - 1);
    node_ids_to_process.add(last_item);
    connected_component_number := connected_component_number + 1;
    while (node_ids_to_process.Count > 0) do
    begin
      anchor_node_id := node_ids_to_process[node_ids_to_process.Count - 1];
      node_ids_to_process.Delete(node_ids_to_process.Count - 1);
      anchor_node := nodeList.GetNode(anchor_node_id);
      if not Assigned(anchor_node) then
      begin
        showMessage('Integrity error!, send this bug to thundaxsoftware.blogspot.com');
        Result := bOK;
        exit;
      end;
      anchor_node.connections := connected_component_number;
      for i := 0 to anchor_node.Neighbour.Count - 1 do
      begin
        neighbour_node_id := anchor_node.Neighbour[i];
        if not ExistsItem(visited_node_ids, neighbour_node_id) then
        begin
          node_ids_to_process.add(neighbour_node_id);
          if ExistsItem(all_node_ids, neighbour_node_id) then
            RemoveItem(all_node_ids, neighbour_node_id);
        end;
      end;
      visited_node_ids.add(anchor_node_id);
    end;
  end;
  connected_components_count := connected_component_number;
  bOK := true;

  FreeAndNil(all_node_ids);
  FreeAndNil(node_ids_to_process);
  FreeAndNil(visited_node_ids);
  Result := bOK;
end;

procedure TGraph.calculateStep;
var
  new_overall_energie: extended;
  i, j: Integer;
  node, node2: TNode;
  con_number, con_number2: Integer;
  Distance, vector, replacement: TPointEx;
  radius: extended;
  float: single;
  connector: TConnector;
  harmonic, coulomb: TPointEx;
  minMax: TArrMinMax;
  Center: TCenter;
  distances: Integer;
  k: Integer;
  neighbour_node_id: string;
  min, max: TPoint;
  BeyondMinX, BeyondMaxX, BeyondMinY, BeyondMaxY: Boolean;
  minimum, maximum: TPoint;
begin
  new_overall_energie := 0;

  // calculate the repulsive force for each node
  for i := 0 to nodeList.Count - 1 do
  begin
    node := nodeList.items[i];
    node.CoulombForce.setVal(0, 0);
    for j := 0 to nodeList.Count - 1 do
    begin
      node2 := nodeList.items[j];
      if (node.id <> node2.id) and (node.connections = node2.connections) then
      begin
        Distance.X := node.Center.X - node2.Center.X;
        Distance.Y := node.Center.Y - node2.Center.Y;
        radius := Sqrt(sqr(Distance.X) + sqr(Distance.Y));
        if Comparar(radius, 0.0, '<>') then
        begin
          vector.X := Distance.X / radius;
          vector.Y := Distance.Y / radius;
          node.CoulombForce.sr0(node.CoulombForce.r0 + (((layout.epsilon_repulsive_force * node.mass) * vector.X) / radius));
          node.CoulombForce.sR1(node.CoulombForce.r1 + (((layout.epsilon_repulsive_force * node.mass) * vector.Y) / radius));
          // Add this force to the overall energy
          new_overall_energie := new_overall_energie + ((layout.epsilon_repulsive_force * node.mass) / radius);
        end
        else
        begin
          // if the nodes lie on each other, randomly replace them a bit
          float := Random;
          node.CoulombForce.sr0(node.CoulombForce.r0 + ((layout.epsilon_repulsive_lying_nodes * float) - layout.epsilon_attractive_lying_nodes_offset));
          float := Random;
          node.CoulombForce.sR1(node.CoulombForce.r1 + ((layout.epsilon_repulsive_lying_nodes * float) - layout.epsilon_attractive_lying_nodes_offset));
          new_overall_energie := new_overall_energie - layout.epsilon_attractive_lying_nodes_offset;
        end;
      end;
    end;
  end;

  // calculate the attractive force for each node
  for i := 0 to nodeList.Count - 1 do
  begin
    node := nodeList.items[i];
    node.HookeForce.setVal(0, 0);
    for j := 0 to node.Neighbour.Count - 1 do
    begin
      neighbour_node_id := node.Neighbour[j];
      node2 := nodeList.GetNode(neighbour_node_id);

      Distance.X := node.Center.X - node2.Center.X;
      Distance.Y := node.Center.Y - node2.Center.Y;
      radius := Sqrt(sqr(Distance.X) + sqr(Distance.Y));
      if Comparar(radius, 0.0, '<>') then
      begin
        vector.X := -1 * (Distance.X / radius);
        vector.Y := -1 * (Distance.Y / radius);
        harmonic.X := (vector.X * sqr(radius) / (100 * layout.epsilon_attractive_force * node.mass));
        harmonic.Y := (vector.Y * sqr(radius) / (100 * layout.epsilon_attractive_force * node.mass));
        new_overall_energie := new_overall_energie + (sqr(radius) / (100 * layout.epsilon_attractive_force * node.mass));
      end
      else
      begin
        // if the nodes lie on each other, randomly replace them a bit
        float := Random;
        harmonic.X := ((layout.epsilon_attractive_lying_nodes * float - layout.epsilon_attractive_lying_nodes_offset));
        float := Random;
        harmonic.Y := ((layout.epsilon_attractive_lying_nodes * float - layout.epsilon_attractive_lying_nodes_offset));
        new_overall_energie := new_overall_energie + (layout.epsilon_attractive_lying_nodes * float - layout.epsilon_attractive_lying_nodes_offset);
      end;
      node.HookeForce.sr0(node.HookeForce.r0 + harmonic.X);
      node.HookeForce.sR1(node.HookeForce.r1 + harmonic.Y);
    end;
  end;

  Self.overall_energie_difference := Self.overall_energie - new_overall_energie;
  Self.overall_energie := new_overall_energie;

  if Comparar(Self.overall_energie, highest_energy, '>') then
    highest_energy := Self.overall_energie;

  if ((Comparar(Self.overall_energie_difference, layout.energy_change_limit, '<')) and (Comparar(Self.overall_energie_difference, -layout.energy_change_limit, '>'))) then
    Self.calculation_finished := true;

  if (timestep = 50) and Comparar(thermal_energie, 0, '>') then
    thermal_energie := 0.2;
  if (timestep = 110) and Comparar(thermal_energie, 0, '>') then
    thermal_energie := 0.1;
  if (timestep = 180) and Comparar(thermal_energie, 0, '>') then
    thermal_energie := 0.0;

  for i := 0 to nodeList.Count - 1 do
  begin
    node := nodeList.items[i];
    coulomb.X := node.CoulombForce.r0;
    coulomb.Y := node.CoulombForce.r1;
    harmonic.X := node.HookeForce.r0;
    harmonic.Y := node.HookeForce.r1;

    node.speed.sr0(node.speed.r0 + (coulomb.X + harmonic.X) * layout.speed_offset);
    node.speed.sR1(node.speed.r1 + (coulomb.Y + harmonic.Y) * layout.speed_offset);
    // ensure maximum velocity
    if (Comparar(node.speed.r0, layout.maximum_speed, '>')) then
      node.speed.sr0(layout.maximum_speed);
    if (Comparar(node.speed.r1, layout.maximum_speed, '>')) then
      node.speed.sR1(layout.maximum_speed);
    if (Comparar(node.speed.r0, -layout.maximum_speed, '<')) then
      node.speed.sr0(-layout.maximum_speed);
    if (Comparar(node.speed.r1, -layout.maximum_speed, '<')) then
      node.speed.sR1(-layout.maximum_speed);

    // get friction into play
    if (Comparar(node.speed.r0, layout.friction, '>')) then
      node.speed.sr0(node.speed.r0 - layout.friction);
    if (Comparar(node.speed.r0, -layout.friction, '<')) then
      node.speed.sr0(node.speed.r0 + layout.friction);
    if (Comparar(node.speed.r1, layout.friction, '>')) then
      node.speed.sR1(node.speed.r1 - layout.friction);
    if (Comparar(node.speed.r1, -layout.friction, '<')) then
      node.speed.sR1(node.speed.r1 + layout.friction);

    // FINALLY SET THE NEW POSITION
    node.Move(node.speed.r0, node.speed.r1);

    if Comparar(thermal_energie, 0, '>') then
    begin
      float := Random;
      node.Move(float * thermal_energie * 2 - thermal_energie, float * thermal_energie * 2 - thermal_energie);
    end;
  end;

  setLength(minMax, 0);
  setLength(Center, 0);
  for i := 0 to Self.connected_components_count do
    AppendMinMax(minMax, 1000, 1000, -1000, -1000);

  for i := 0 to Self.connected_components_count do
  begin
    for j := 0 to nodeList.Count - 1 do
    begin
      node := nodeList.items[j];
      if node.connections = i + 1 then
      begin
        if Comparar(node.Center.X, minMax[i].p0, '<') then
          minMax[i].p0 := node.Center.X;
        if Comparar(node.Center.Y, minMax[i].p1, '<') then
          minMax[i].p1 := node.Center.Y;
        if Comparar(node.Center.X, minMax[i].p0, '>') then
          minMax[i].p2 := node.Center.X;
        if Comparar(node.Center.X, minMax[i].p0, '>') then
          minMax[i].p3 := node.Center.Y;
      end;
    end;
    AppendCenter(Center, minMax[i].p0 + (minMax[i].p2 - minMax[i].p0) / 2, minMax[i].p1 + (minMax[i].p3 - minMax[i].p1) / 2);
  end;

  for i := 0 to Self.connected_components_count do
  begin
    for j := 0 to Self.connected_components_count do
    begin
      if i <> j then
      begin
        distances := 1;
        if ((Comparar(minMax[i].p0 + distances, minMax[j].p0, '>') and Comparar(minMax[i].p0 - distances, minMax[j].p2, '<')) or (Comparar(minMax[i].p2 + distances, minMax[j].p0, '>') and Comparar
                (minMax[i].p2 - distances, minMax[j].p2, '<'))) and ((Comparar(minMax[i].p1 + distances, minMax[j].p1, '>') and Comparar(minMax[i].p1 - distances, minMax[j].p3, '<')) or
              (Comparar(minMax[i].p3 + distances, minMax[j].p1, '>') and Comparar(minMax[i].p3 - distances, minMax[j].p3, '<'))) then
        begin
          // calculate replacement with help of the distance vector of the centers
          Distance.X := Center[i].X - Center[j].X;
          Distance.Y := Center[i].Y - Center[j].Y;
          radius := Sqrt(sqr(Distance.X) + sqr(Distance.Y));
          replacement.X := Distance.X / radius * -1;
          replacement.Y := Distance.Y / radius * -1;
          float := Random;
          replacement.X := replacement.X * float * -0.1;
          float := Random;
          replacement.Y := replacement.Y * float * -0.1;
          for k := 0 to nodeList.Count - 1 do
          begin
            node := nodeList.items[k];
            if node.connections = i + 1 then
            begin
              node.Move(replacement.X, replacement.Y);
            end;
          end;
        end;
      end;
    end;
  end;

  // Corregir el zoom
  min := point(FImage.Left, FImage.Top);
  max := point(FImage.width, FImage.height);
  minimum := point(0, 0);
  maximum := point(0, 0);
  BeyondMinX := false;
  BeyondMaxX := false;
  BeyondMinY := false;
  BeyondMaxY := false;
  for i := 0 to nodeList.Count - 1 do
  begin
    if nodeList.items[i].Vertex1.X < minimum.X then
      minimum.X := nodeList.items[i].Vertex1.X;
    if nodeList.items[i].Vertex1.Y < minimum.Y then
      minimum.Y := nodeList.items[i].Vertex1.Y;
    if nodeList.items[i].Vertex2.X > maximum.X then
      maximum.X := nodeList.items[i].Vertex2.X;
    if nodeList.items[i].Vertex2.Y > maximum.Y then
      maximum.Y := nodeList.items[i].Vertex2.Y;
  end;

  if (TZoom.ClientToGraph(minimum).X < min.X) then
    BeyondMinX := true;
  if (TZoom.ClientToGraph(minimum).Y < min.Y) then
    BeyondMinY := true;

  if (TZoom.ClientToGraph(maximum).X > max.X) then
    BeyondMaxX := true;
  if (TZoom.ClientToGraph(maximum).Y > max.Y) then
    BeyondMaxY := true;

  for i := 0 to nodeList.Count - 1 do
  begin
    if BeyondMinX and not BeyondMaxX then
      nodeList.items[i].Move(min.X - TZoom.ClientToGraph(minimum).X, 0)
    else if BeyondMinY and not BeyondMaxY then
      nodeList.items[i].Move(0, min.Y - TZoom.ClientToGraph(minimum).Y)
    else if BeyondMaxX and not BeyondMinX then
      nodeList.items[i].Move(max.X - TZoom.ClientToGraph(maximum).X, 0)
    else if BeyondMaxY and not BeyondMinY then
      nodeList.items[i].Move(0, max.Y - TZoom.ClientToGraph(maximum).Y)
  end;

  if (BeyondMinX and BeyondMaxX) or (BeyondMinY and BeyondMaxY) then
  begin
    if globalZoom <= 1000 then
    begin
      globalZoom := globalZoom + 25;
      //TODO
      //frmMain.StatusBar1.Panels[2].Text := 'Zoom: ' + inttostr(globalZoom) + '%';
    end;
  end;
end;

function TGraph.MoveLine(var sLineTemp: TAbstractEdge; X, Y: Integer; index: Integer): TPoint;
var
  p2: TPoint;
  xdespla, ydespla: Integer;
begin
  p2 := SnapToGrid(X, Y);
  xdespla := p2.X - dragPoint.X;
  ydespla := p2.Y - dragPoint.Y;
  sLineTemp.Move(index, xdespla, ydespla);
  Result := p2;
  Draw();
end;

function TGraph.MoveBox(BoxTemp: TNode; X, Y: Integer; index: Integer): TPoint;
var
  p2: TPoint;
  xdespla, ydespla: Integer;
begin
  p2 := SnapToGrid(X, Y);
  if BoxTemp <> nil then
  begin
    xdespla := p2.X - dragPoint.X;
    ydespla := p2.Y - dragPoint.Y;
    sbox.MoveVertex(index, xdespla, ydespla);
    Draw();
  end;
  Result := p2;
end;

function TGraph.getGrammar: TGrammar;
var
  grammar : TGrammar;
  node : Tnode;
  I: Integer;
  production : TProductionGrammar;
begin
  grammar := TGrammar.Create;
  node := getInitialState;
  recursiveNodes(node, grammar);
  for I := 0 to ConnectorList.count - 1 do
  begin
    if connectorList[i].SourceNode.nodeType = nDestiny then
    begin
      production := TProductionGrammar.Create(ConnectorList[i].SourceNode.Properties.getText, 'λ');
      if not grammar.exists(production) then
        grammar.Add(production)
      else
        production.Free;
    end;
  end;
  grammar.sortItems;
  result := grammar;
end;

function TGraph.getInitialState: TNode;
var
  i: Integer;
  node: TNode;
begin
  node := nil;
  for i := 0 to nodeList.Count - 1 do
  begin
    if nodeList[i].nodeType = nOrigin then
    begin
      node := nodeList[i];
      break;
    end;
  end;
  Result := node;
end;

function TGraph.getLineFactory(kindof: TTypeEdge): TAbstractEdge;
var
  concept: TAbstractEdge;
begin
  concept := nil;
  case kindof of
    SimpleEdge:
      concept := SimpleLinesFactory.GetEdge();
    SimpleArrowEdge:
      concept := SimpleLinesFactory.GetEdgeArrow();
    SimpleDoubleArrowEdge:
      concept := SimpleLinesFactory.GetEdgeDoubleArrow();
    SimpleDoubleLinkedArrowEdge:
      concept := SimpleLinesFactory.GetEdgeLinkedArrow();
    DottedEdge:
      concept := DottedLinesFactory.GetEdge();
    DottedArrowEdge:
      concept := DottedLinesFactory.GetEdgeArrow();
    DottedDoubleArrowEdge:
      concept := DottedLinesFactory.GetEdgeDoubleArrow();
    DottedDoubleLinkedArrowEdge:
      concept := DottedLinesFactory.GetEdgeLinkedArrow();
  end;
  if concept = nil then
    showMessage('Error Line concept = nil');
  concept.properties.Assign(FDefaultEdgeProperty);
  Result := concept;
end;

procedure TGraph.moveBoxesSelected(X, Y: Integer);
var
  i: Integer;
  con: TConnector;
begin
  for i := 0 to nodeList.Count - 1 do
    if nodeList.items[i].Inside then
      nodeList.items[i].Move(X, Y);
  for i := 0 to ConnectorList.Count - 1 do
  begin
    con := ConnectorList.items[i];
    if con.SourceNode.Inside and con.TargetNode.Inside then
      con.Edge.Move(X, Y);
  end;
end;

procedure TGraph.MoveIfisLoop(box: TNode; X, Y: Integer);
var
  i: Integer;
  con: TConnector;
begin
  for i := 0 to ConnectorList.Count - 1 do
  begin
    con := ConnectorList.items[i];
    if (con.SourceNode.id = box.id) and (con.TargetNode.id = box.id) then
      con.Edge.Move(X, Y);
  end;
end;

procedure TGraph.ImageMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  i: Integer;
  xdespla: Integer;
  ydespla: Integer;
  p2, pt: TPoint;
  drawingLine: Integer;
begin
  pt := point(X, Y); // ClientToGraph(x,y);
  // PointMouse := Point(pt.X, pt.Y);
  Screen.cursor := crDefault;
  drawingLine := 0;
  if doubleclick then
  begin
    StarDrag := false;
    doubleclick := false;
  end
  else if StartDraw then
  begin
    Draw();
    FImage.Canvas.Brush.Style := bsSolid;
    FImage.Canvas.Brush.color := FDefaultNodeProperty.fillColor;
    FImage.Canvas.Pen.width := FDefaultNodeProperty.penWidth;
    FImage.Canvas.Pen.color := FDefaultNodeProperty.LineColor;
    p2 := SnapToGrid(pt.X, pt.Y);
    FImage.Canvas.RoundRect(InitialPoint.X, InitialPoint.Y, p2.X, p2.Y, options.RoundedIndex, options.RoundedIndex);
    mBox.Vertex1 := InitialPoint;
    mBox.Vertex2 := point(p2.X, p2.Y);
  end
  else if StartSelection then
  begin
    FinalSelection := point(pt.X, pt.Y);
    Draw();
  end
  else if StartDraw2 then
  begin
    Draw();
    p2 := SnapToGrid(pt.X, pt.Y);
    DrawLine(InitialPoint, p2, FDefaultEdgeProperty.LineColor);
    drawingLine := 1;
    for i := 0 to nodeList.Count - 1 do
      if nodeList.items[i].isInside(p2.X, p2.Y) and not nodeList.items[i].Drawing then
        drawingLine := 2;
  end;

  if nodeList = nil then
    exit;

  if drawingLine > 0 then
  begin
    getMouseCursorBox(pt.X, pt.Y, Screen.cursor);
    BoxAtNode(sbox, pt.X, pt.Y, Screen.cursor);
    case drawingLine of
      1:
        Screen.cursor := crNo;
      2:
        Screen.cursor := crCross;
    end;
  end
  else
  begin
    Screen.cursor := getMouseCursorBox(pt.X, pt.Y, Screen.cursor);
    Screen.cursor := BoxAtNode(sbox, pt.X, pt.Y, Screen.cursor);
  end;
  if sLine <> nil then
  begin
    if DragVertexLine then
    begin
      dragPoint := MoveLine(sLine, pt.X, pt.Y, 1);
      Screen.cursor := crSizeAll;
    end
    else if DragVertexLine2 then
    begin
      dragPoint := MoveLine(sLine, pt.X, pt.Y, 2);
      Screen.cursor := crSizeAll;
    end
    else if DragVertexLine0 then
    begin
      dragPoint := MoveLine(sLine, pt.X, pt.Y, 0);
      Screen.cursor := crSizeAll;
    end;
  end;
  if StarDrag then
  begin
    if (sbox <> nil) and (sbox.Inside) then
    begin
      p2 := SnapToGrid(pt.X, pt.Y);
      xdespla := p2.X - dragPoint.X;
      ydespla := p2.Y - dragPoint.Y;
      dragPoint.X := p2.X;
      dragPoint.Y := p2.Y;
      sbox.Move(xdespla, ydespla);
      MoveIfisLoop(sbox, xdespla, ydespla);
      Draw();
    end;
  end
  else if trobat then
  begin
    p2 := SnapToGrid(pt.X, pt.Y);
    xdespla := p2.X - posTrobat.X;
    ydespla := p2.Y - posTrobat.Y;
    posTrobat.X := p2.X;
    posTrobat.Y := p2.Y;
    moveBoxesSelected(xdespla, ydespla);
    Draw();
  end
  else if DragVertex1 then
    dragPoint := MoveBox(sbox, pt.X, pt.Y, 1)
  else if DragVertex2 then
    dragPoint := MoveBox(sbox, pt.X, pt.Y, 2)
  else if DragVertex3 then
    dragPoint := MoveBox(sbox, pt.X, pt.Y, 3)
  else if DragVertex4 then
    dragPoint := MoveBox(sbox, pt.X, pt.Y, 4);

  FImage.cursor := Screen.cursor;
  if drawingLine = 0 then
    Screen.cursor := crDefault;

  FImage.invalidate;
  FImage.refresh;

  if Assigned(FOnMouseMove) then
    FOnMouseMove(Sender, Shift, X, Y);
end;

procedure TGraph.ImageMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i: Integer;
  Conn: TConnector;
  concept: TAbstractEdge;
  p2, pt: TPoint;
begin
  isModified := false;
  pt := point(X, Y); // ClientToGraph(x,y);
  Screen.cursor := crDefault;
  if Rectangle then
  begin
    StartDraw := false;
    Rectangle := false;
    mBox.CalcCenter();
    mBox.properties.zOrder := 999999;
    mBox.CalcPoints();
    nodeList.add(mBox);
    nodeList.Sort(@Compare);
    Draw();
    isModified := true;
  end
  else if Line then
  begin
    p2 := SnapToGrid(pt.X, pt.Y);
    for i := 0 to nodeList.Count - 1 do
    begin
      if nodeList.items[i].isInside(p2.X, p2.Y) and not nodeList.items[i].Drawing then
      begin
        concept := getLineFactory(LineConcept);
        if sbox <> nil then
        begin
          Conn := TConnector.Create(sbox, nodeList.items[i], concept);
          if not ConnectorList.Exists(Conn) then
          begin
            ConnectorList.add(Conn);
            // if nodeList.items[i].id <> sbox.id then
            // begin
            sbox.AddNeighBour(nodeList.items[i].id);
            nodeList.items[i].AddNeighBour(sbox.id);
            // end;
          end
          else
          begin
            FreeAndNil(Conn);
            showMessage('Node already connected!');
          end;
        end
        else
          showMessage('Error with the movement precision. Drop the line again.');
        StartDraw2 := false;
        Draw();
        isModified := true;
        break;
      end;
      // Draw();
    end;

    StartDraw2 := false;
    if btLine or btArrowLine or btdArrowLine or btlinkLine or btdotdArrow or btLinkdLine or btdotarrow or btdotLine then
      Line := true
    else
    begin
      Line := false;
      LineConcept := noEdge;
    end;
  end
  else if multiSelect then
  begin
    multiSelect := false;
    trobat := false;
    multiSelect := ThereAreSelected();
  end
  else if Selection then
  begin
    StartSelection := false;
    Selection := false;
    MarkSelected(TZoom.GraphToClient(InitialSelection), TZoom.GraphToClient(FinalSelection));
    InitialSelection := point(-1, -1);
    FinalSelection := point(-1, -1);
    Draw();
  end;

  StarDrag := false;
  DragVertex1 := false;
  DragVertex2 := false;
  DragVertex3 := false;
  DragVertex4 := false;
  DragVertexLine := false;
  DragVertexLine0 := false;
  DragVertexLine2 := false;
  AfterDobleClick := false;
  sLine := nil;
  sbox := nil;
  for i := 0 to nodeList.Count - 1 do
    nodeList.items[i].Drawing := false;
  FImage.cursor := Screen.cursor;
  if Assigned(FOnMouseUp) then
    FOnMouseUp(Sender, Button, Shift, X, Y);
end;

function TGraph.isThereEndNode: Boolean;
var
  i: Integer;
  bfound: Boolean;
begin
  bfound := false;
  i := 0;
  while i < nodeList.Count do
  begin
    if nodeList[i].nodeType = nDestiny then
      bfound := true;
    Inc(i);
  end;
  if bfound then
    Result := true
  else
  begin
    raise Exception.Create('There is no final state!. Edit the diagram and try again.');
    Result := false;
  end;
end;

function TGraph.isThereStartNode: Boolean;
var
  i, j: Integer;
  bfound: Boolean;
  isStart: Boolean;
begin
  isStart := false;
  bfound := false;
  i := 0;
  j := 0;
  while i < nodeList.Count do
  begin
    if nodeList[i].nodeType = nOrigin then
    begin
      bfound := true;
      Inc(j);
    end;
    Inc(i);
  end;
  if (j = 1) and bfound then
    isStart := true;
  if (j > 1) and bfound then
  begin
    raise Exception.Create('There can only be one initial state!. Edit the diagram and try again.');
    isStart := false;
  end;
  if not bfound then
  begin
    raise Exception.Create('There is no initial state!. Edit the diagram and try again.');
    isStart := false;
  end;
  Result := isStart;
end;

procedure TGraph.Load(Project: String);
begin
  if FileExists(Project + '\boxList.xml') and FileExists(Project + '\connectorList.xml') then
  begin
    nodeList.options := Self.options;
    nodeList.UnMarshalFromXML(Project + '\boxList.xml');
    ConnectorList.UnMarshalFromXML(FImage.Canvas, nodeList, Project + '\connectorList.xml');
  end;
  if FileExists(Project + '\graph.xml') then
    Self.UnMarshalFromXML(Project + '\graph.xml');
end;

procedure TGraph.DrawBackground();
var
  DC: HDC;
  Rect: TRect;
  X, Y: Integer;
  DotColor: Integer;
begin
  FImage.Canvas.Brush.Style := bsSolid;
  FImage.Canvas.Brush.color := options.backgroundColor;
  Rect := FImage.Canvas.ClipRect;
  FImage.Canvas.FillRect(Rect);
  if true then
  begin
    DotColor := ColorToRGB(options.GridColor);
    DC := FImage.Canvas.Handle;
    Y := 0;
    while Y < Rect.Bottom do
    begin
      X := 0;
      while X < Rect.Right do
      begin
        SetPixel(DC, X, Y, DotColor);
        Inc(X, Self.gridSize);
      end;
      Inc(Y, Self.gridSize);
    end;
  end;
end;

procedure TGraph.Save(Project: String);
  function ResizeBmp(bitmp: TBitmap; wid, hei: Integer): Boolean;
  var
    TmpBmp: TBitmap;
    ARect: TRect;
  begin
    try
      TmpBmp := TBitmap.Create;
      try
        TmpBmp.width := wid;
        TmpBmp.height := hei;
        ARect := Rect(0, 0, wid, hei);
        TmpBmp.Canvas.StretchDraw(ARect, bitmp);
        bitmp.Assign(TmpBmp);
      finally
        TmpBmp.Free;
      end;
      Result := true;
    except
      Result := false;
    end;
  end;

var
  jpeg: TJPEGImage;
begin
  Self.MarshalToXML(Project + '\graph.xml');
  nodeList.MarshalToXML(Project + '\boxList.xml');
  ConnectorList.MarshalToXML(Project + '\connectorList.xml');

  jpeg := TJPEGImage.Create;
  jpeg.Assign(FImage.Picture.Bitmap);
  jpeg.SaveToFile(Project + '\preview.jpg');
  FreeAndNil(jpeg);
end;

function TGraph.SnapToGrid(X, Y: Integer): TPoint;
var
  p: TPoint;
  pt: TPoint;
begin
  pt := point(X, Y);
  if SnapToGridMark then
    p := point(pt.X div gridSize * gridSize, pt.Y div gridSize * gridSize)
  else
    p := point(pt.X, pt.Y);
  Result := p;
end;

function TGraph.getTotalInside(): Integer;
var
  i, j: Integer;
begin
  j := 0;
  for i := 0 to nodeList.Count - 1 do
  begin
    if nodeList.items[i].Inside then
      j := j + 1;
  end;
  Result := j;
end;

procedure TGraph.DrawLine(p1, p2: TPoint; color: TColor);
begin
  FImage.Canvas.Brush.Style := bsSolid;
  FImage.Canvas.Pen.width := 1;
  FImage.Canvas.Pen.color := color;
  FImage.Canvas.MoveTo(p1.X, p1.Y);
  FImage.Canvas.LineTo(p2.X, p2.Y);
end;

procedure TGraph.CenterGraph;
var
  Center, CenterGraph: TPoint;
  Vertex1, Vertex2: TPoint;
  i: Integer;
begin
  // Center of the image
  Center := point(FImage.width div 2, FImage.height div 2);
  Vertex1 := point(9999, 9999);
  Vertex2 := point(0, 0);
  for i := 0 to nodeList.Count - 1 do
  begin
    if nodeList.items[i].Vertex1.X < Vertex1.X then
      Vertex1.X := nodeList.items[i].Vertex1.X;
    if nodeList.items[i].Vertex1.Y < Vertex1.Y then
      Vertex1.Y := nodeList.items[i].Vertex1.Y;
    if nodeList.items[i].Vertex2.X > Vertex2.X then
      Vertex2.X := nodeList.items[i].Vertex2.X;
    if nodeList.items[i].Vertex2.Y > Vertex2.Y then
      Vertex2.Y := nodeList.items[i].Vertex2.Y;
  end;
  CenterGraph := point(((Vertex1.X + Vertex2.X) div 2), ((Vertex1.Y + Vertex2.Y) div 2));

  for i := 0 to nodeList.Count - 1 do
  begin
    nodeList.items[i].Move(Center.X - CenterGraph.X, Center.Y - CenterGraph.Y);
  end;
end;

function TGraph.checkEverythinghasaName: Boolean;
var
  I: Integer;
  named : Boolean;
begin
  named := true;
  for I := 0 to nodeList.count - 1 do
  begin
    if nodelist[i].Properties.getText() = '' then
    begin
      named := false;
      Break;
    end;
  end;
  if named then
  begin
    for i := 0 to ConnectorList.count - 1 do
    begin
      if ConnectorList[i].Edge.Properties.getText() = '' then
      begin
        named := false;
        Break;
      end;
    end;
  end;
  result := named;
end;

procedure TGraph.ClearClipboard();
begin
  AbstractProperty := nil;
  boxCopy := nil;
end;

procedure TGraph.ConnectToDestination;
var
  i: Integer;
  j: Integer;
  found: Boolean;
  node, target: TNode;
  concept: TAbstractEdge;
  Conn: TConnector;
begin
  if Assigned(ListTemp) then
  begin
    // Search if the new node is inside the list
    found := false;
    for i := 0 to nodeList.Count - 1 do
    begin
      for j := 0 to ListTemp.Count - 1 do
      begin
        if nodeList[i].Inside then
          if nodeList[i].id = ListTemp[j] then
          begin
            found := true;
          end;
      end;
    end;
    if found then
    begin
      showMessage('There is at least one node inside the source list, unselect nodes and try again!');
      exit;
    end
    else
    begin
      for i := 0 to ListTemp.Count - 1 do
      begin
        node := nodeList.GetNode(ListTemp[i]);
        if not Assigned(node) then
        begin
          showMessage('There is no id ' + ListTemp[i] + ' assosicated to a node');
          exit;
        end;
        for j := 0 to nodeList.Count - 1 do
        begin
          if nodeList[j].Inside then
          begin
            target := nodeList[j];
            if not ConnectorList.existConnection(node, target) then
            begin
              concept := getLineFactory(SimpleArrowEdge); // preparar un parametro de opciones
              Conn := TConnector.Create(node, target, concept);
              if not ConnectorList.Exists(Conn) then
              begin
                ConnectorList.add(Conn);
                node.AddNeighBour(target.id);
                target.AddNeighBour(node.id);
              end;
            end;
          end;
        end;
      end;
    end;
  end;
  Draw();
end;

procedure TGraph.Copy();
var
  i: Integer;
begin
  if Assigned(boxCopyList) then
    FreeAndNil(boxCopyList);
  boxCopyList := TNodeList.Create();
  for i := 0 to nodeList.Count - 1 do
  begin
    if nodeList.items[i].Inside then
    begin
      boxCopy := nodeList.items[i];
      boxCopy.Inside := false;
      boxCopyList.add((boxCopy.Clone as TNode));
    end
  end;
end;

procedure TGraph.SaveState();
begin
  originator.SetState(nodeList, ConnectorList);
  caretaker.addMemento(originator.SaveToMemento());
end;

procedure TGraph.SaveImagetoFile();
begin
  FImage.Picture.Bitmap.SaveToFile('C:\ThundaxImage.bmp');
  showMessage('Image saved on C:\ThundaxImage.bmp');
end;

procedure TGraph.SelectAll();
var
  i, j: Integer;
begin
  j := 0;
  for i := 0 to nodeList.Count - 1 do
  begin
    nodeList[i].Inside := true;
    j := j + 1;
  end;
  if j > 1 then
    multiSelect := true;
  Draw();
end;

procedure TGraph.SetAsMultiSource;
var
  i: Integer;
begin
  if Assigned(ListTemp) then
    FreeAndNil(ListTemp);
  ListTemp := TStringList.Create();
  for i := 0 to nodeList.Count - 1 do
  begin
    if nodeList[i].Inside then
      ListTemp.add(nodeList[i].id);
  end;
end;

procedure TGraph.SetConnectorLoop();
var
  i: Integer;
  objLine: TAbstractEdge;
  boxLoop: TNode;
  Conn: TConnector;
begin
  for i := 0 to nodeList.Count - 1 do
  begin
    if nodeList.items[i].Inside then
    begin
      boxLoop := nodeList.items[i];
      objLine := SimpleLinesFactory.GetEdgeArrow;
      objLine.FBendPoint[0] := point(Round(boxLoop.Center.X), Round((boxLoop.Center.Y - (boxLoop.Center.Y - boxLoop.Vertex1.Y) - (boxLoop.Center.Y - boxLoop.Vertex1.Y))));
      objLine.FBendPoint[1] := point(Round(boxLoop.Center.X + (boxLoop.Vertex2.X - boxLoop.Center.X) + (boxLoop.Vertex2.X - boxLoop.Center.X)), Round
            ((boxLoop.Center.Y - (boxLoop.Center.Y - boxLoop.Vertex1.Y) - (boxLoop.Center.Y - boxLoop.Vertex1.Y))));
      objLine.FBendPoint[2] := point(Round(boxLoop.Center.X + (boxLoop.Vertex2.X - boxLoop.Center.X) + (boxLoop.Vertex2.X - boxLoop.Center.X)), Round(boxLoop.Center.Y));
      objLine.FBendModified[0] := true;
      objLine.FBendModified[1] := true;
      objLine.FBendModified[2] := true;
      objLine.properties.Assign(FDefaultEdgeProperty);
      Conn := TConnector.Create(boxLoop, boxLoop, objLine);
      if not ConnectorList.Exists(Conn) then
        ConnectorList.add(Conn)
      else
      begin
        FreeAndNil(Conn);
        showMessage('Box already connected!');
      end;
      break;
    end
  end;
  Draw();
end;

procedure TGraph.SetImageBackground(const Value: String);
begin
  FImageBackground := Value;
end;

procedure TGraph.SetInitialState(color: TColor);
var
  i: Integer;
begin
  for i := 0 to nodeList.Count - 1 do
  begin
    if nodeList[i].nodeType = nOrigin then
    begin
      nodeList[i].properties.fillColor := color;
      break;
    end;
  end;
end;

procedure TGraph.SetOnClick(const Value: TNotifyEvent);
begin
  FOnClick := Value;
end;

procedure TGraph.SetOnMouseDown(const Value: TMouseEvent);
begin
  FOnMouseDown := Value;
end;

procedure TGraph.SetOnMouseMove(const Value: TMouseMoveEvent);
begin
  FOnMouseMove := Value;
end;

procedure TGraph.SetOnMouseUp(const Value: TMouseEvent);
begin
  FOnMouseUp := Value;
end;

procedure TGraph.CopyProperties();
var
  i: Integer;
  Conn: TConnector;
begin
  for i := 0 to nodeList.Count - 1 do
  begin
    if nodeList.items[i].Inside then
    begin
      AbstractProperty := nodeList.items[i].properties;
      break;
    end;
  end;
  for i := 0 to ConnectorList.Count - 1 do
  begin
    Conn := ConnectorList.items[i];
    if Conn.Edge.Inside then
    begin
      AbstractProperty := Conn.Edge.properties;
      break;
    end;
  end;
end;

procedure TGraph.Delete();
var
  i, number: Integer;
  OldBox: TNode;
  OldConnector: TConnector;
  bSortir: Boolean;
begin
  OldBox := nil;
  for i := 0 to nodeList.Count - 1 do
    if nodeList.items[i].Inside then
    begin
      OldBox := nodeList.items[i];
      break;
    end;

  i := 0;
  bSortir := false;
  while (i < ConnectorList.Count) and (not bSortir) do
  begin
    OldConnector := ConnectorList.items[i];
    if Assigned(OldBox) then
    begin
      if (OldConnector.SourceNode.id = OldBox.id) or (OldConnector.TargetNode.id = OldBox.id) then
      begin
        OldConnector.SourceNode.DeleteNeighBour(OldConnector.TargetNode.id);
        OldConnector.TargetNode.DeleteNeighBour(OldConnector.SourceNode.id);
        ConnectorList.Extract(OldConnector);
        FreeAndNil(OldConnector);
        i := i - 1;
      end
    end
    else if OldConnector.Edge.Inside then
    begin
      number := ConnectorList.getNumberConnections(OldConnector.SourceNode, OldConnector.TargetNode);
      if number = 1 then // Only 1 connection
      begin
        OldConnector.SourceNode.DeleteNeighBour(OldConnector.TargetNode.id);
        OldConnector.TargetNode.DeleteNeighBour(OldConnector.SourceNode.id);
      end;
      ConnectorList.Extract(OldConnector);
      FreeAndNil(OldConnector);
      bSortir := true;
    end;
    i := i + 1;
  end;
  if Assigned(OldBox) then
  begin
    nodeList.Extract(OldBox);
    FreeAndNil(OldBox);
  end;
  sbox := nil;
  Draw();
end;

procedure TGraph.MarkasDestination();
var
  i: Integer;
begin
  for i := 0 to nodeList.Count - 1 do
  begin
    if nodeList.items[i].Inside then
    begin
      nodeList.items[i].nodeType := nDestiny;
      nodeList.items[i].properties.Assign(FDefaultDestinyNodeProperty);
      break;
    end;
  end;
  Draw();
end;

procedure TGraph.MarkSelected(p1, p2: TPoint);
var
  i, j: Integer;
begin
  if (p1.X > 0) and (p2.X > 0) then
  begin
    j := 0;
    for i := 0 to nodeList.Count - 1 do
    begin
      j := j + 1;
      if (nodeList[i].Vertex1.X > p1.X) and (nodeList[i].Vertex1.Y > p1.Y) and (nodeList[i].Vertex3.X < p2.X) and (nodeList[i].Vertex3.Y < p2.Y) then
        nodeList[i].Inside := true;
    end;
    if j > 1 then
      multiSelect := (j > 1);
  end;
end;

procedure TGraph.MarshalToXML(sFile: string);
var
  XMLDoc: TXMLDocument;
  iNode: IXMLNode;
begin
  XMLDoc := TXMLDocument.Create(nil);
  XMLDoc.Active := true;
  iNode := XMLDoc.AddChild('TGraph');
  iNode.attributes['Image'] := FImageBackground;
  iNode.attributes['Zoom'] := inttostr(globalZoom);

  XMLDoc.SaveToFile(sFile);
end;

procedure TGraph.MarxasLink();
var
  i: Integer;
begin
  for i := 0 to nodeList.Count - 1 do
  begin
    if nodeList.items[i].Inside then
    begin
      nodeList.items[i].nodeType := nLink;
      nodeList.items[i].properties.Assign(FDefaultLinkNodeProperty);
      break;
    end;
  end;
  Draw();
end;

procedure TGraph.MarxasNormal();
var
  i: Integer;
begin
  for i := 0 to nodeList.Count - 1 do
  begin
    if nodeList.items[i].Inside then
    begin
      nodeList.items[i].nodeType := nNormal;
      nodeList.items[i].properties.Assign(FDefaultNodeProperty);
      break;
    end;
  end;
  Draw();
end;

procedure TGraph.MarxasSource();
var
  i: Integer;
begin
  for i := 0 to nodeList.Count - 1 do
  begin
    if nodeList.items[i].Inside then
    begin
      nodeList.items[i].nodeType := nOrigin;
      nodeList.items[i].properties.Assign(FDefaultOriginNodeProperty);
      break;
    end;
  end;
  Draw();
end;

procedure TGraph.DrawSelectionBox(p1, p2: TPoint);
var
  st: TPenStyle;
begin
  if (p1.X > 0) and (p2.X > 0) then
  begin
    st := FImage.Canvas.Pen.Style;
    FImage.Canvas.Pen.width := 0;
    FImage.Canvas.Pen.color := options.SelectionColorMark;
    FImage.Canvas.Pen.Style := psDot;
    FImage.Canvas.Rectangle(p1.X, p1.Y, p2.X, p2.Y);
    FImage.Canvas.Pen.Style := st;
  end;
end;

function TGraph.ThereAreSelected(): Boolean;
var
  i, j: Integer;
begin
  j := 0;
  for i := 0 to nodeList.Count - 1 do
  begin
    if nodeList[i].Inside then
      j := j + 1;
  end;
  Result := (j > 1);
end;

procedure TGraph.unMarkAll();
var
  i: Integer;
begin
  for i := 0 to nodeList.Count - 1 do
  begin
    nodeList[i].Inside := false;
  end;
end;

procedure TGraph.UnMarshalFromXML(sFile: string);
var
  Document: IXMLDocument;
  iXMLRootNode: IXMLNode;
begin
  Document := TXMLDocument.Create(nil);
  try
    Document.LoadFromFile(sFile);
    iXMLRootNode := Document.ChildNodes.first;
    Self.FImageBackground := iXMLRootNode.attributes['Image'];
    globalZoom := StrToInt(iXMLRootNode.attributes['Zoom']);
  finally
    Document := nil;
  end;
end;

procedure TGraph.MoveBoxes(X: Integer; Y: Integer);
var
  i: Integer;
begin
  for i := 0 to nodeList.Count - 1 do
  begin
    if nodeList.items[i].Inside then
    begin
      nodeList.items[i].Move(X, Y);
    end;
  end;
  Draw();
end;

procedure TGraph.Paste();
var
  i, j: Integer;
  boxClone: TNode;
begin
  if Assigned(boxCopyList) then
  begin
    j := 0;
    for i := 0 to boxCopyList.Count - 1 do
    begin
      j := j + 1;
      boxCopyList[i].Inside := false;
      boxClone := (boxCopyList[i].Clone as TNode);
      boxClone.Move(Self.gridSize, Self.gridSize);
      boxClone.Inside := true;
      nodeList.add(boxClone);
    end;
    if j > 1 then
      multiSelect := true;
    FreeAndNil(boxCopyList);
    Draw();
  end;
end;

procedure TGraph.PasteProperties();
var
  i: Integer;
  Conn: TConnector;
begin
  if Assigned(AbstractProperty) then
  begin
    for i := 0 to nodeList.Count - 1 do
    begin
      if nodeList.items[i].Inside then
      begin
        nodeList.items[i].properties.Assign(AbstractProperty);
        break;
      end;
    end;
    for i := 0 to ConnectorList.Count - 1 do
    begin
      Conn := ConnectorList.items[i];
      if Conn.Edge.Inside then
      begin
        Conn.Edge.properties.Assign(AbstractProperty);
        break;
      end;
    end;
    Draw();
  end;
end;

function TGraph.ProcessDFAStep(character: string; color : TColor; var isLambda : boolean): Boolean;
var
  i: Integer;
  status: Boolean;
  state: string;
  position: Integer;
  ProcessText: string;
  perl: TPerlRegEx;
begin
  status := false;
  if not Assigned(stepNode) then
    stepNode := getInitialState();

  isLambda := false;
  for i := 0 to ConnectorList.Count - 1 do
  begin
    if ConnectorList.items[i].SourceNode = stepNode then
    begin
      state := ConnectorList.items[i].Edge.properties.getText();
      if state = lambda then
      begin
          RestoreDefaults();
          stepNode := ConnectorList.items[i].TargetNode;
          stepNode.properties.fillColor := color;
          status := true;
          isLambda := true;
          break;
      end
      else if state[1] = '^' then // is a regular expression
      begin
        perl := TPerlRegEx.Create;
        try
          perl.RegEx := UTF8String(state);
          perl.Subject := UTF8String(character);
          if perl.Match then
          begin
            RestoreDefaults();
            stepNode := ConnectorList.items[i].TargetNode;
            stepNode.properties.fillColor := color;
            status := true;
            break;
          end;
        finally
          perl.Free;
        end;
      end
      else
      begin
        if AnsiContainsStr(state, ',') then
        begin
          while state <> '' do
          begin
            position := AnsiPos(',', state);
            if position = 0 then
              ProcessText := state
            else
              ProcessText := AnsiLeftStr(state, position - 1);
            state := AnsiRightStr(state, Length(state) - Length(ProcessText) - 1);
            if ProcessText = character then
            begin
              RestoreDefaults();
              stepNode := ConnectorList.items[i].TargetNode;
              stepNode.properties.fillColor := color;
              status := true;
              state := '';
            end;
          end;
          if state = '' then
            break;
        end
        else
        begin
          if ConnectorList.items[i].Edge.properties.getText() = character then
          begin
            RestoreDefaults();
            stepNode := ConnectorList.items[i].TargetNode;
            stepNode.properties.fillColor := color;
            status := true;
            break;
          end;
        end;
      end;
    end;
  end;
  Self.Draw;
  Result := status;
end;

procedure TGraph.ResetState;
begin
  stepNode := nil;
  RestoreDefaults();
end;

procedure TGraph.RestoreDefaultProperties;
var
  j: Integer;
  Conn: TConnector;
begin
  for j := 0 to ConnectorList.Count - 1 do
  begin
    Conn := ConnectorList.items[j];
    // Is Source
    if (Conn.SourceNode.properties.fillColor = clLime) and (Conn.SourceNode.properties.penWidth = 4) then
    begin
      Conn.SourceNode.properties.Assign(FDefaultNodeProperty);
      Conn.SourceNode.properties.fillColor := clLime;
      Conn.SourceNode.properties.penWidth := 4;
      Conn.SourceNode.properties.FontText.Style := [fsbold];
      if Conn.SourceNode.Image <> '' then
        Conn.SourceNode.properties.FontText.color := clLime
      else
        Conn.SourceNode.properties.FontText.color := clWhite;
    end
    else
      Conn.SourceNode.properties.Assign(FDefaultNodeProperty);

    // Is Destination
    if (Conn.TargetNode.properties.fillColor = clFuchsia) and (Conn.TargetNode.properties.penWidth = 4) then
    begin
      Conn.TargetNode.properties.Assign(FDefaultNodeProperty);
      Conn.TargetNode.properties.fillColor := clFuchsia;
      Conn.TargetNode.properties.penWidth := 4;
      Conn.TargetNode.properties.FontText.Style := [fsbold];
      if Conn.TargetNode.Image <> '' then
        Conn.TargetNode.properties.FontText.color := clFuchsia
      else
        Conn.TargetNode.properties.FontText.color := clWhite;
    end
    else
      Conn.TargetNode.properties.Assign(FDefaultNodeProperty);

    Conn.Edge.properties.Assign(FDefaultEdgeProperty);
  end;
end;

procedure TGraph.RestoreDefaults();
var
  j: Integer;
  Conn: TConnector;
begin
  for j := 0 to ConnectorList.Count - 1 do
  begin
    Conn := ConnectorList.items[j];
    case Conn.SourceNode.nodeType of
      nOrigin:
        Conn.SourceNode.properties.Assign(FDefaultOriginNodeProperty);
      nDestiny:
        Conn.SourceNode.properties.Assign(FDefaultDestinyNodeProperty);
      nNormal:
        Conn.SourceNode.properties.Assign(FDefaultNodeProperty);
    end;
    case Conn.SourceNode.nodeType of
      nOrigin:
        Conn.SourceNode.properties.Assign(FDefaultOriginNodeProperty);
      nDestiny:
        Conn.SourceNode.properties.Assign(FDefaultDestinyNodeProperty);
      nNormal:
        Conn.SourceNode.properties.Assign(FDefaultNodeProperty);
    end;
    // Conn.SourceNode.properties.LineColor := clblack;
    // Conn.SourceNode.properties.penWidth := 1;
    // Conn.TargetNode.properties.LineColor := clblack;
    // Conn.TargetNode.properties.penWidth := 1;
    Conn.Edge.properties.Assign(FDefaultEdgeProperty);
    // Conn.Edge.properties.LineColor := clblack;
    // Conn.Edge.properties.penWidth := 1;
  end;
  Draw();
end;

procedure TGraph.RestoreProperties;
var
  j: Integer;
  Conn: TConnector;
begin
  for j := 0 to nodeList.Count - 1 do
  begin
    case nodeList[j].nodeType of
      nNormal:
        nodeList[j].properties.Assign(FDefaultNodeProperty);
      nOrigin:
        nodeList[j].properties.Assign(FDefaultOriginNodeProperty);
      nDestiny:
        nodeList[j].properties.Assign(FDefaultDestinyNodeProperty);
      nLink:
        nodeList[j].properties.Assign(FDefaultLinkNodeProperty);
    end;
  end;
  for j := 0 to ConnectorList.Count - 1 do
  begin
    Conn := ConnectorList.items[j];
    Conn.Edge.properties.Assign(FDefaultEdgeProperty);
  end;
  Draw();
end;

procedure TGraph.putFront();
begin
  if TNodeHelper.PositionNodes(nodeList, zFront) then
    Draw();
end;

procedure TGraph.putBack();
begin
  if TNodeHelper.PositionNodes(nodeList, zBack) then
    Draw();
end;

procedure TGraph.putOnTop();
begin
  if TNodeHelper.AlignNodes(nodeList, OnTop) then
    Draw();
end;

function TGraph.recursiveNodes(node: TNode; grammar: TGrammar): Boolean;
var
  I: Integer;
  production : TProductionGrammar;
  FromNode : String;
  ToNode : String;
  transition : String;
  found : Boolean;
begin
  found := false;
  for I := 0 to ConnectorList.count - 1 do
  begin
    if ConnectorList.Items[i].SourceNode = node then
    begin
      FromNode := node.Properties.getText;
      ToNode := ConnectorList.Items[i].TargetNode.Properties.getText;
      transition := ConnectorList.Items[i].Edge.Properties.getText;
      production := TProductionGrammar.Create(FromNode, transition + ToNode);
      if not grammar.exists(production) then
      begin
        grammar.Add(production);
        found := True;
        recursiveNodes(ConnectorList.Items[i].TargetNode, grammar);
      end
      else
      begin
        production.Free;
        found := false;
      end;
    end;
  end;
  result := found;
end;

procedure TGraph.putOnRight();
begin
  if TNodeHelper.AlignNodes(nodeList, OnRight) then
    Draw();
end;

procedure TGraph.putOnDown();
begin
  if TNodeHelper.AlignNodes(nodeList, OnBottom) then
    Draw();
end;

procedure TGraph.putOnLeft();
begin
  if TNodeHelper.AlignNodes(nodeList, Onleft) then
    Draw();
end;

procedure TGraph.UndoState();
var
  memento: TMemento;
begin
  if caretaker.thereAreMementos() then
  begin
    sbox := nil;
    FreeAndNil(nodeList);
    memento := caretaker.getLastMemento();
    nodeList := originator.restoreBoxFromMemento(memento);
    FreeAndNil(ConnectorList);
    ConnectorList := originator.restoreConnectorFromMemento(memento);
    caretaker.RemoveLastMemento();
    Draw();
  end;
end;

procedure TGraph.MoveUp(precision: Integer);
begin
  MoveBoxes(0, -(precision));
end;

procedure TGraph.MoveDown(precision: Integer);
begin
  MoveBoxes(0, (precision));
end;

procedure TGraph.MoveLeft(precision: Integer);
begin
  MoveBoxes(-(precision), 0);
end;

procedure TGraph.MoveRight(precision: Integer);
begin
  MoveBoxes((precision), 0);
end;

end.
