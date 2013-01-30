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
unit vlo.lib.treeLayout;

interface

uses
  vlo.lib.Graph, vlo.lib.Node, vlo.lib.Connector;

type
  TInfoNode = class(TObject)
  private
    FNode: TNode;
    FSubtreeWidth: Double;
    procedure SetNode(const Value: TNode);
    procedure SetSubtreeWidth(const Value: Double);
  public
    property Node: TNode read FNode write SetNode;
    property SubtreeWidth: Double read FSubtreeWidth write SetSubtreeWidth;
    constructor Create(Node: TNode);
  end;

  TLayeredTree = class(TObject)
  private
    FGraph: TGraph;
    j: integer;
    function recursiveNodes(Node: TNode; infoNode: TInfoNode): Boolean;
  public
    constructor Create(graph: TGraph);
    procedure Layout;
  end;

implementation

uses
  SysUtils;

{ TLayeredTree }

constructor TLayeredTree.Create(graph: TGraph);
begin
  FGraph := graph;
  j := 0;
end;

procedure TLayeredTree.Layout;
var
  Node: TNode;
  infoNode: TInfoNode;
begin
  // Get the root node
  infoNode := nil;
  Node := FGraph.getInitialState();
  recursiveNodes(Node, infoNode);
end;

function TLayeredTree.recursiveNodes(Node: TNode; infoNode: TInfoNode): Boolean;
var
  i: integer;
begin
  for i := 0 to FGraph.ConnectorList.count - 1 do
  begin
    if FGraph.ConnectorList.Items[i].SourceNode = Node then
    begin
      // target := ConnectorList.Items[i].TargetNode;
      // if FGraph.ConnectorList.isLeaf(target) then
      // begin
      // formatTreeNode(
      // end;
      FGraph.ConnectorList.Items[i].SourceNode.properties.description.Text := IntToStr(j);
      inc(j);
      recursiveNodes(FGraph.ConnectorList.Items[i].TargetNode, infoNode);

    end;
  end;
  Result := true;
end;

{ TInfoNode }

constructor TInfoNode.Create(Node: TNode);
begin
  SetNode(Node);
end;

procedure TInfoNode.SetNode(const Value: TNode);
begin
  FNode := Value;
end;

procedure TInfoNode.SetSubtreeWidth(const Value: Double);
begin
  FSubtreeWidth := Value;
end;

end.
