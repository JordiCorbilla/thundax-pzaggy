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
unit vlo.lib.Routing.Dijkstra;

interface

uses
  vlo.lib.Node, vlo.lib.Connector, vlo.lib.arrays, vlo.lib.properties.Abstract, vlo.lib.Node.list;

type
  TDijkstra = Class(TObject)
  private
    nodeList: TNodeList;
    ConnectorList: TConnectorList;
    EdgeProperties: TAbstractProperty;
    NodeProperties: TAbstractProperty;
    function isValidDiagram(): boolean;
    procedure getFirstAndLastNode(var firstNode: integer; var lastNode: TArrayInteger);
  public
    constructor Create(nodeList: TNodeList; ConnectorList: TConnectorList; NodeProperties: TAbstractProperty; EdgeProperties: TAbstractProperty);
    destructor Destroy(); override;
    procedure ApplyAlgorithm();
  End;

implementation

uses
  Graphics, SysUtils, vlo.lib.utils, Dialogs, vlo.lib.properties.Node, vlo.lib.properties.Edge;

const
  NoWeight = 999999;
  MaxVertexs = 500;

type
  ArrayOfInteger = array [1 .. MaxVertexs] of integer;

  { TDijkstra }

procedure TDijkstra.ApplyAlgorithm;
var
  AdjacentList: array [1 .. MaxVertexs, 1 .. MaxVertexs] of integer;
  VertexList: ArrayOfInteger;
  predecessor: ArrayOfInteger;
  visiteds: array [1 .. MaxVertexs] of boolean;
  vertexs, edges, firstNode: integer;
  i, j, pos1, pos2, min, k: integer;
  Conn: TConnector;
  textList: string;
  DrawingList: ArrayOfInteger;
  lastNode: TArrayInteger;
begin
  if not isValidDiagram() then
    exit;

  vertexs := nodeList.Count;
  edges := ConnectorList.Count;
  firstNode := -1;
  SetLength(lastNode, 0);
  getFirstAndLastNode(firstNode, lastNode);
  if (firstNode = -1) or (Length(lastNode) = 0) then
    exit;

  for i := 1 to MaxVertexs do
  begin
    for j := 1 to MaxVertexs do
    begin
      AdjacentList[i, j] := NoWeight;
      if i = j then
        AdjacentList[i, j] := 0
    end;
    DrawingList[i] := NoWeight;
  end;

  for i := 0 to edges - 1 do
  begin
    Conn := ConnectorList.items[i];
    pos1 := StrToInt(Conn.SourceNode.properties.getText);
    pos2 := StrToInt(Conn.TargetNode.properties.getText);
    if (pos1 > MaxVertexs) or (pos2 > MaxVertexs) then
    begin
      ShowMessage('Too many Edges');
      exit;
    end;
    AdjacentList[pos1, pos2] := StrToInt(Conn.Edge.properties.getText);
    if Conn.Edge.ClassNameIs('TAbstractDottedDoubleArrowEdge') or Conn.Edge.ClassNameIs('TAbstractSimpleDoubleArrowEdge') or Conn.Edge.ClassNameIs('TAbstractSimpleEdge') or
      Conn.Edge.ClassNameIs('TAbstractDottedEdge') then
      AdjacentList[pos2, pos1] := StrToInt(Conn.Edge.properties.getText);
  end;

  for k := 0 to Length(lastNode) - 1 do
  begin

    for i := 1 to vertexs do
    begin
      VertexList[i] := AdjacentList[firstNode, i];
      predecessor[i] := firstNode;
      visiteds[i] := false;
    end;
    VertexList[firstNode] := 0;
    visiteds[firstNode] := True;

    j := firstNode;
    repeat
      for i := 1 to vertexs do
        if (not visiteds[i]) and (VertexList[i] > VertexList[j] + AdjacentList[j, i]) then
        begin
          VertexList[i] := VertexList[j] + AdjacentList[j, i];
          predecessor[i] := j;
        end;
      min := NoWeight;
      for i := 1 to vertexs do
        if (not visiteds[i]) and (VertexList[i] < min) then
        begin
          min := VertexList[i];
          j := i;
        end;
      if (min <> NoWeight) then
        visiteds[j] := True;
    until (visiteds[lastNode[k]]) or (min = NoWeight);

    textList := '';
    DrawingList[firstNode] := lastNode[k];
    j := firstNode;
    while (lastNode[k] <> firstNode) do
    begin
      j := j + 1;
      lastNode[k] := predecessor[lastNode[k]];
      DrawingList[j] := lastNode[k];
    end;

    i := 1;
    while i < Length(DrawingList) do
    begin
      for j := 0 to ConnectorList.Count - 1 do
      begin
        Conn := ConnectorList.items[j];
        if ((Conn.SourceNode.properties.getText = inttostr(DrawingList[i])) and (Conn.TargetNode.properties.getText = inttostr(DrawingList[i + 1]))) or
          ((Conn.SourceNode.properties.getText = inttostr(DrawingList[i + 1])) and (Conn.TargetNode.properties.getText = inttostr(DrawingList[i]))) then
        begin
          if (Conn.SourceNode.nodeType = nNormal) then
            Conn.SourceNode.properties.Assign(NodeProperties);
          if (Conn.TargetNode.nodeType = nNormal) then
            Conn.TargetNode.properties.Assign(NodeProperties);
          Conn.Edge.properties.Assign(EdgeProperties);
        end;
      end;
      i := i + 1;
    end;
  end;
end;

constructor TDijkstra.Create(nodeList: TNodeList; ConnectorList: TConnectorList; NodeProperties: TAbstractProperty; EdgeProperties: TAbstractProperty);
begin
  Self.nodeList := nodeList;
  Self.ConnectorList := ConnectorList;
  Self.EdgeProperties := EdgeProperties;
  Self.NodeProperties := NodeProperties;
end;

destructor TDijkstra.Destroy;
begin
  nodeList := nil;
  ConnectorList := nil;
  EdgeProperties := nil;
  NodeProperties := nil;
  inherited;
end;

procedure TDijkstra.getFirstAndLastNode(var firstNode: integer; var lastNode: TArrayInteger);
var
  i: integer;
begin
  for i := 0 to nodeList.Count - 1 do
  begin
    if nodeList.items[i].nodeType = nOrigin then
      firstNode := StrToInt(nodeList.items[i].properties.getText);
    if nodeList.items[i].nodeType = nDestiny then
      TArray.SetValue(lastNode, StrToInt(nodeList.items[i].properties.getText));
  end;
end;

function TDijkstra.isValidDiagram: boolean;
var
  i: integer;
  res: boolean;
begin
  res := True;
  for i := 0 to nodeList.Count - 1 do
    res := res and IsNumber(nodeList[i].properties.getText);

  if not res then
    ShowMessage('The nodes need an identificative number!')
  else
  begin
    for i := 0 to ConnectorList.Count - 1 do
      res := res and IsNumber(ConnectorList[i].Edge.properties.getText);
    if not res then
      ShowMessage('The edges need a weight number!');
  end;
  result := res;
end;

end.
