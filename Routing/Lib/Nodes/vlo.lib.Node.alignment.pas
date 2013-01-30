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
unit vlo.lib.node.alignment;

interface

uses
  vlo.lib.Node, types, vlo.lib.Node.list;

type
  TAlignment = (Onleft, OnRight, OnTop, OnBottom);
  TOrder = (zFront, zBack);

  TNodeHelper = class(TObject)
    class function AlignNodes(nodeList: TNodeList; alignment: TAlignment): boolean;
    class function PositionNodes(nodeList: TNodeList; zOrder: TOrder): boolean;
  end;

implementation

uses
  vlo.lib.properties.Node;

class function TNodeHelper.AlignNodes(nodeList: TNodeList; alignment: TAlignment): boolean;
var
  i: Integer;
  Count: Integer;
  vertex, dist: Integer;
begin
  Count := 0;
  for i := 0 to nodeList.Count - 1 do
    if nodeList.items[i].Inside then
      Count := Count + 1;

  vertex := -1;
  if Count > 1 then
  begin
    for i := 0 to nodeList.Count - 1 do
    begin
      if nodeList.items[i].Inside then
      begin
        if (vertex = -1) then
        begin
          case alignment of
            Onleft:
              vertex := nodeList.items[i].Vertex1.x;
            OnRight:
              vertex := nodeList.items[i].Vertex2.x;
            OnTop:
              vertex := nodeList.items[i].Vertex1.Y;
            OnBottom:
              vertex := nodeList.items[i].Vertex2.Y;
          end;
        end
        else
        begin
          case alignment of
            Onleft:
              begin
                dist := nodeList.items[i].Vertex2.x - nodeList.items[i].Vertex1.x;
                nodeList.items[i].Vertex1 := Point(vertex, nodeList.items[i].Vertex1.Y);
                nodeList.items[i].Vertex2 := Point(vertex + dist, nodeList.items[i].Vertex2.Y);
              end;
            OnRight:
              begin
                dist := nodeList.items[i].Vertex2.x - nodeList.items[i].Vertex1.x;
                nodeList.items[i].Vertex2 := Point(vertex, nodeList.items[i].Vertex2.Y);
                nodeList.items[i].Vertex1 := Point(vertex - dist, nodeList.items[i].Vertex1.Y);
              end;
            OnTop:
              begin
                dist := nodeList.items[i].Vertex2.Y - nodeList.items[i].Vertex1.Y;
                nodeList.items[i].Vertex1 := Point(nodeList.items[i].Vertex1.x, vertex);
                nodeList.items[i].Vertex2 := Point(nodeList.items[i].Vertex2.x, dist + vertex);
              end;
            OnBottom:
              begin
                dist := nodeList.items[i].Vertex2.Y - nodeList.items[i].Vertex1.Y;
                nodeList.items[i].Vertex2 := Point(nodeList.items[i].Vertex2.x, vertex);
                nodeList.items[i].Vertex1 := Point(nodeList.items[i].Vertex1.x, vertex - dist);
              end;
          end;
          nodeList.items[i].CalcPoints();
          nodeList.items[i].CalcCenter();
        end;
      end;
    end;
  end;
  result := (Count > 1);
end;

class function TNodeHelper.PositionNodes(nodeList: TNodeList; zOrder: TOrder): boolean;
var
  i: Integer;
  pos: Integer;
  ordered: boolean;
begin
  ordered := false;
  pos := 0;
  case zOrder of
    zFront:
      pos := 1;
    zBack:
      pos := -1;
  end;
  for i := 0 to nodeList.Count - 1 do
  begin
    if nodeList.items[i].Inside then
    begin
      TNodeProperty(nodeList.items[i].properties).zOrder := TNodeProperty(nodeList.items[i].properties).zOrder + pos;
      ordered := true;
    end;
  end;
  nodeList.SortList;
  result := ordered;
end;

end.
