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
unit vlo.lib.treeLayout.ReingoldTilford;

interface

uses
  uGraph, uNode, Generics.Collections, vlo.lib.treeLayout.helper;

type
  TTreeJustification = (tTop, tCenter, TBottom);

  TReingoldTilfordAlgorithm = class(TObject)
  private
    FBufferHorizontal: Double;
    Fgraph: TGraph;
    FtreeJustification: TTreeJustification;
    FBufferHorizontalSubtree: Double;
    FOverallHeight: Double;
    FBufferVertical: Double;
    function PostOrderTraversalTreeWalk(node: TNode; level: integer): boolean;
    function PreOrderTraversalTreeWalk(graph: TGraph; level: integer): boolean;
    procedure SetBufferHorizontal(const Value: Double);
    procedure SetBufferHorizontalSubtree(const Value: Double);
    procedure SetBufferVertical(const Value: Double);
    procedure Setgraph(const Value: TGraph);
    procedure SetOverallHeight(const Value: Double);
    procedure SettreeJustification(const Value: TTreeJustification);
    procedure LayoutLeafNode(node: TNode);
    procedure LayoutInteriorNode(node: TNode; level: integer);
    procedure UpdateLayerHeight(node: TNode; level: integer);
    procedure LayoutAllOurChildren(level: integer; children: TObjectList<TNode>);
    procedure RepositionSubtree(nodeItem: integer; siblings: TObjectList<TNode>; lstLeftToBB: TList<Double>; lsttnResponsible: TList<integer>);
    function CalculateWidthFromInterChildDistances(node: TNode): Double;
    procedure CenterOverChildren(node: TNode; layeredTree: TLayeredTreeInfo);
    procedure DetermineParentRelativePositionsOfChildren(node: TNode);
    procedure CalculateBoundaryLists(node: TNode);
    procedure DetermineBoundary(children: TObjectList<TNode>; fleft: boolean; lstPos: TList<Double>);
    function PxCalculateNewPos(layeredTree: TLayeredTreeInfo; lstLeftToBB: TList<Double>; lstitnResponsible: TList<integer>; var itnResponsible: integer; var iLayerRet: integer): Double;
    procedure ApportionSlop(nodeItem: integer; lsttnResponsible: integer; siblings: TObjectList<TNode>);
  public
    constructor TreeDrawAlgorithm(graph: TGraph; BufferHorizontal: Double; BufferHorizontalSubtree: Double; BufferVertical: Double; treeJustification: TTreeJustification);
    procedure LayoutTree;
    property OverallHeight: Double read FOverallHeight write SetOverallHeight;
    property BufferHorizontal: Double read FBufferHorizontal write SetBufferHorizontal;
    property BufferHorizontalSubtree: Double read FBufferHorizontalSubtree write SetBufferHorizontalSubtree;
    property BufferVertical: Double read FBufferVertical write SetBufferVertical;
    property graph: TGraph read Fgraph write Setgraph;
    property treeJustification: TTreeJustification read FtreeJustification write SettreeJustification;
  end;

implementation

uses
  uConnector, SysUtils, Math;

{ TReingoldTilfordAlgorithm }

procedure TReingoldTilfordAlgorithm.ApportionSlop(nodeItem: integer; lsttnResponsible: integer; siblings: TObjectList<TNode>);
var
  layeredTree, temp: TLayeredTreeInfo;
  tnLeft: TNode;
  pxSlop: Double;
  i: integer;
begin
  layeredTree := siblings[nodeItem].PrivateNode;
  tnLeft := siblings[nodeItem - 1];
  pxSlop := layeredTree.pxToLeftSibling - graph.ConnectorList.getSubTreeWidth(tnLeft) - FBufferHorizontal;
  if pxSlop > 0 then
  begin
    for i := lsttnResponsible to nodeItem - 1 do
    begin
      temp := siblings[i].PrivateNode;
      temp.pxToLeftSibling := temp.pxToLeftSibling + (pxSlop * (i - lsttnResponsible) / (nodeItem - lsttnResponsible));
    end;
    layeredTree.pxToLeftSibling := layeredTree.pxToLeftSibling - ((nodeItem - lsttnResponsible - 1) * pxSlop / (nodeItem - lsttnResponsible));
  end;
end;

procedure TReingoldTilfordAlgorithm.CalculateBoundaryLists(node: TNode);
var
  layeredTree: TLayeredTreeInfo;
begin
  layeredTree := node.PrivateNode;
  layeredTree.lstPosLeftBoundaryRelativeToRoot.Add(0.0);
  layeredTree.lstPosRightBoundaryRelativeToRoot.Add(graph.ConnectorList.getSubTreeWidth(node));
  DetermineBoundary(graph.ConnectorList.getChildren(node), true, layeredTree.lstPosLeftBoundaryRelativeToRoot);
  DetermineBoundary(graph.ConnectorList.getChildren(node).Reverse(), false, layeredTree.lstPosRightBoundaryRelativeToRoot);
end;

function TReingoldTilfordAlgorithm.CalculateWidthFromInterChildDistances(node: TNode): Double;
var
  pxWidthCur, pxWidth: Double;
  layeredTree: TLayeredTreeInfo;
  leftMostNode: TNode;
  pxUndercut: Double;
  children: TChildrenList;
  i: integer;
begin
  pxWidth := 0.0;
  leftMostNode := graph.ConnectorList.LeftMost(node);
  layeredTree := leftMostNode.PrivateNode;
  pxWidthCur := layeredTree.pxLeftPosRelativeToBoundingBox;

  pxUndercut := 0.0;
  children := graph.ConnectorList.getChildren(node);
  for i := 0 to children.count - 1 do
  begin
    layeredTree := children[i].PrivateNode;
    pxWidthCur := pxWidthCur + layeredTree.pxToLeftSibling;

    if layeredTree.pxLeftPosRelativeToBoundingBox > pxWidthCur then
      pxUndercut := Math.Max(pxUndercut, layeredTree.pxLeftPosRelativeToBoundingBox - pxWidthCur);
    pxWidth := Math.Max(pxWidthCur, pxWidthCur + layeredTree.SubTreeWidth - layeredTree.pxLeftPosRelativeToBoundingBox);
    layeredTree.pxLeftPosRelativeToBoundingBox := pxWidthCur;
  end;
  if pxUndercut > 0.0 then
  begin
    children := graph.ConnectorList.getChildren(node);
    for i := 0 to children.count - 1 do
    begin
      layeredTree := children[i].PrivateNode;
      layeredTree.pxLeftPosRelativeToBoundingBox := layeredTree.pxLeftPosRelativeToBoundingBox + pxUndercut;
    end;
    pxWidth := pxWidth + pxUndercut;
  end;
  Result := Math.Max(graph.ConnectorList.getSubTreeWidth(node), pxWidth);
end;

procedure TReingoldTilfordAlgorithm.CenterOverChildren(node: TNode; layeredTree: TLayeredTreeInfo);
var
  leftMostNode, rightMostNode: TNode;
  pxLeftChild, pxRightChild: Double;
  i: integer;
  children: TChildrenList;
  templayeredTree: TLayeredTreeInfo;
begin
  leftMostNode := graph.ConnectorList.LeftMost(node);
  pxLeftChild := (leftMostNode.PrivateNode.pxLeftPosRelativeToBoundingBox + graph.ConnectorList.getSubTreeWidth(leftMostNode)) / 2;
  rightMostNode := graph.ConnectorList.RightMost(node);
  pxRightChild := (rightMostNode.PrivateNode.pxLeftPosRelativeToBoundingBox + graph.ConnectorList.getSubTreeWidth(rightMostNode)) / 2;
  layeredTree.pxLeftPosRelativeToBoundingBox := pxLeftChild + pxRightChild - graph.ConnectorList.getSubTreeWidth(node) / 2;

  if layeredTree.pxLeftPosRelativeToBoundingBox < 0 then
  begin
    children := graph.ConnectorList.getChildren(node);
    for i := 0 to children.count - 1 do
    begin
      templayeredTree := children[i].PrivateNode;
      templayeredTree.pxLeftPosRelativeToBoundingBox := templayeredTree.pxLeftPosRelativeToBoundingBox - layeredTree.pxLeftPosRelativeToBoundingBox;
    end;
    layeredTree.pxLeftPosRelativeToBoundingBox := 0;
  end;
end;

procedure TReingoldTilfordAlgorithm.DetermineBoundary(children: TObjectList<TNode>; fleft: boolean; lstPos: TList<Double>);
var
  cLayersDeep: integer;
  lstPosCur: TList<Double>;
  i: integer;
  templayeredTree: TLayeredTreeInfo;
begin
  cLayersDeep := 1;
  for i := 0 to children.count - 1 do
  begin
    templayeredTree := children[i].PrivateNode;
    if (fleft) then
      lstPosCur := templayeredTree.lstPosRightBoundaryRelativeToRoot
    else
      lstPosCur := templayeredTree.lstPosRightBoundaryRelativeToRoot;
    if lstPosCur.count >= lstPos.count then
    begin
      while cLayersDeep < lstPosCur.count do
      begin
        lstPos.Add(lstPosCur[cLayersDeep] + templayeredTree.pxLeftPosRelativeToParent);
        Inc(cLayersDeep);
      end;
    end;
  end;
end;

procedure TReingoldTilfordAlgorithm.DetermineParentRelativePositionsOfChildren(node: TNode);
var
  children: TChildrenList;
  layeredTree, templayeredTree: TLayeredTreeInfo;
  i: integer;
begin
  templayeredTree := node.PrivateNode;
  children := graph.ConnectorList.getChildren(node);
  for i := 0 to children.count - 1 do
  begin
    layeredTree := children[i].PrivateNode;
    layeredTree.pxLeftPosRelativeToParent := layeredTree.pxLeftPosRelativeToBoundingBox - templayeredTree.pxLeftPosRelativeToBoundingBox;
  end;
end;

procedure TReingoldTilfordAlgorithm.LayoutAllOurChildren(level: integer; children: TObjectList<TNode>);
var
  lstLeftToBB: TList<Double>;
  lstResponsible: TList<integer>;
  i: integer;
  node: TNode;
begin
  lstLeftToBB := TList<Double>.create;
  lstResponsible := TList<integer>.create;
  for i := 0 to children.count - 1 do
  begin
    node := children[i];
    PostOrderTraversalTreeWalk(node, level + 1);
    RepositionSubtree(i, children, lstLeftToBB, lstResponsible);
  end;
  freeAndNil(lstLeftToBB);
  freeAndNil(lstResponsible);
end;

procedure TReingoldTilfordAlgorithm.LayoutInteriorNode(node: TNode; level: integer);
var
  children: TChildrenList;
  width: Double;
  layeredTree: TLayeredTreeInfo;
begin
  children := graph.ConnectorList.getChildren(node);
  try
    LayoutAllOurChildren(level, children);
    width := CalculateWidthFromInterChildDistances(node);
    layeredTree := TLayeredTreeInfo.create(width, node);
    node.PrivateNode := layeredTree;
    CenterOverChildren(node, layeredTree);
    DetermineParentRelativePositionsOfChildren(node);
    CalculateBoundaryLists(node);
  finally
    children.Free;
  end;
end;

procedure TReingoldTilfordAlgorithm.LayoutLeafNode(node: TNode);
var
  width: Double;
  layeredTree: TLayeredTreeInfo;
begin
  width := graph.ConnectorList.getSubTreeWidth(node);
  layeredTree := TLayeredTreeInfo.create(width, node);
  layeredTree.lstPosLeftBoundaryRelativeToRoot.Add(0.0);
  layeredTree.lstPosRightBoundaryRelativeToRoot.Add(width);
  node.PrivateNode := layeredTree;
end;

procedure TReingoldTilfordAlgorithm.LayoutTree;
var
  root: TNode;
begin
  root := graph.getInitialState();
  PostOrderTraversalTreeWalk(root, 0);
  PreOrderTraversalTreeWalk(graph, 0);
end;

function TReingoldTilfordAlgorithm.PostOrderTraversalTreeWalk(node: TNode; level: integer): boolean;
begin
  if (graph.ConnectorList.getNumberConnections(node) = 0) then
    LayoutLeafNode(node)
  else
    LayoutInteriorNode(node, level);
  UpdateLayerHeight(node, level);
  Result := false;
end;

function TReingoldTilfordAlgorithm.PreOrderTraversalTreeWalk(graph: TGraph; level: integer): boolean;
begin
  Result := false;
end;

function TReingoldTilfordAlgorithm.PxCalculateNewPos(layeredTree: TLayeredTreeInfo; lstLeftToBB: TList<Double>; lstitnResponsible: TList<integer>; var itnResponsible, iLayerRet: integer): Double;
begin
  Result := 0.0;
end;

procedure TReingoldTilfordAlgorithm.RepositionSubtree(nodeItem: integer; siblings: TObjectList<TNode>; lstLeftToBB: TList<Double>; lsttnResponsible: TList<integer>);
var
  itnResponsible: integer;
  layeredTree: TLayeredTreeInfo;
  pxRelativeToRoot: Double;
  i: integer;
  pxHorizontalBuffer: Double;
  iLayer: integer;
  pxNewPosFromBB: Double;
  cLevels: integer;
begin
  layeredTree := siblings[nodeItem].PrivateNode;
  if nodeItem = 0 then
  begin
    for i := 0 to layeredTree.lstPosRightBoundaryRelativeToRoot.count - 1 do
    begin
      pxRelativeToRoot := layeredTree.lstPosRightBoundaryRelativeToRoot[i];
      lstLeftToBB.Add(pxRelativeToRoot + layeredTree.pxLeftPosRelativeToBoundingBox);
      lsttnResponsible.Add(0);
    end;
  end
  else
  begin
    layeredTree := siblings[nodeItem - 1].PrivateNode;
    pxHorizontalBuffer := FBufferHorizontal;
    pxNewPosFromBB := PxCalculateNewPos(layeredTree, lstLeftToBB, lsttnResponsible, itnResponsible, iLayer);
    if iLayer <> 0 then
    begin
      pxHorizontalBuffer := FBufferHorizontalSubtree;
    end;
    layeredTree.pxToLeftSibling := pxNewPosFromBB - lstLeftToBB[0] + graph.ConnectorList.getSubTreeWidth(siblings[nodeItem - 1]) + pxHorizontalBuffer;
    cLevels := Math.Min(layeredTree.lstPosRightBoundaryRelativeToRoot.count, lstLeftToBB.count);
    for i := 0 to cLevels - 1 do
    begin
      lstLeftToBB[i] := layeredTree.lstPosRightBoundaryRelativeToRoot[i] + pxNewPosFromBB + pxHorizontalBuffer;
      lsttnResponsible[i] := nodeItem;
    end;
    for i := lstLeftToBB.count to layeredTree.lstPosRightBoundaryRelativeToRoot.count - 1 do
    begin
      lstLeftToBB.Add(layeredTree.lstPosRightBoundaryRelativeToRoot[i] + pxNewPosFromBB + pxHorizontalBuffer);
      lsttnResponsible.Add(nodeItem);
    end;
    ApportionSlop(nodeItem, itnResponsible, siblings);
  end;
end;

procedure TReingoldTilfordAlgorithm.SetBufferHorizontal(const Value: Double);
begin
  FBufferHorizontal := Value;
end;

procedure TReingoldTilfordAlgorithm.SetBufferHorizontalSubtree(const Value: Double);
begin
  FBufferHorizontalSubtree := Value;
end;

procedure TReingoldTilfordAlgorithm.SetBufferVertical(const Value: Double);
begin
  FBufferVertical := Value;
end;

procedure TReingoldTilfordAlgorithm.Setgraph(const Value: TGraph);
begin
  Fgraph := Value;
end;

procedure TReingoldTilfordAlgorithm.SetOverallHeight(const Value: Double);
begin
  FOverallHeight := Value;
end;

procedure TReingoldTilfordAlgorithm.SettreeJustification(const Value: TTreeJustification);
begin
  FtreeJustification := Value;
end;

constructor TReingoldTilfordAlgorithm.TreeDrawAlgorithm(graph: TGraph; BufferHorizontal: Double; BufferHorizontalSubtree: Double; BufferVertical: Double; treeJustification: TTreeJustification);
begin
  if Assigned(graph) then
  begin
    SetBufferHorizontal(BufferHorizontal);
    Setgraph(graph);
    SetBufferHorizontalSubtree(BufferHorizontalSubtree);
    SetBufferVertical(BufferVertical);
    SettreeJustification(treeJustification);
    SetOverallHeight(0.0);
  end;
end;

procedure TReingoldTilfordAlgorithm.UpdateLayerHeight(node: TNode; level: integer);
begin
  // while (_lstLayerHeight.Count <= iLayer)
  // {
  // _lstLayerHeight.Add(0.0);
  // }
  // _lstLayerHeight[iLayer] = Math.Max(tnRoot.TreeHeight, _lstLayerHeight[iLayer]);
end;

end.
