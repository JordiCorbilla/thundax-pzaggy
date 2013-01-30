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
unit vlo.lib.Node.list;

interface

uses
  types, contnrs, Graphics, vlo.lib.Edge, Classes, vlo.lib.cloner.contract,
  vlo.lib.XML.Serializer, XMLDoc, XMLIntf, vlo.lib.vertex,
  vlo.lib.Layout, vlo.lib.options, vlo.lib.treeLayout.helper, vlo.lib.Node;

type
  TNodeList = class(TObjectList)
  private
    Foptions: TOptionsApplication;
    procedure Setoptions(const Value: TOptionsApplication);
  protected
    function GetItem(Index: integer): TNode; overload;
    procedure SetItem(Index: integer; AObject: TNode);
  public
    property options: TOptionsApplication read Foptions write Setoptions;
    property Items[Index: integer]: TNode read GetItem write SetItem; default;
    procedure MarshalToXML(sFile: string);
    procedure UnMarshalFromXML(sFile: string);
    function GetNode(id: string): TNode;
    function GetNodeByDescription(description: string): TNode;
    function Clone: TNodeList;
    procedure SortList();
  end;

implementation

{ TNodeList }

function TNodeList.Clone: TNodeList;
var
  res: TNodeList;
  i: integer;
  box: TNode;
  newBox: TNode;
begin
  res := TNodeList.Create();
  for i := 0 to Self.Count - 1 do
  begin
    box := Self.Items[i];
    newBox := (box.Clone as TNode);
    newBox.id := box.id;
    res.Add(newBox);
  end;
  result := res;
end;

function TNodeList.GetNode(id: string): TNode;
var
  bTrobat: Boolean;
  i: integer;
  box: TNode;
begin
  box := nil;
  bTrobat := false;
  i := 0;
  while not bTrobat and (i < Self.Count) do
  begin
    if Self.Items[i].id = id then
    begin
      bTrobat := true;
      box := Self.Items[i];
    end;
    i := i + 1;
  end;
  result := box;
end;

function TNodeList.GetNodeByDescription(description: string): TNode;
var
  bTrobat: Boolean;
  i: integer;
  box: TNode;
begin
  box := nil;
  bTrobat := false;
  i := 0;
  while not bTrobat and (i < Self.Count) do
  begin
    if Self.Items[i].Properties.getText = description then
    begin
      bTrobat := true;
      box := Self.Items[i];
    end;
    i := i + 1;
  end;
  result := box;
end;

function TNodeList.GetItem(Index: integer): TNode;
begin
  result := TNode( inherited Items[Index]);
end;

procedure TNodeList.MarshalToXML(sFile: string);
var
  XMLDoc: TXMLDocument;
  iNode, NodeSeccio: IXMLNode;
  i: integer;
begin
  XMLDoc := TXMLDocument.Create(nil);
  XMLDoc.Active := true;
  iNode := XMLDoc.AddChild('TBoxList');
  for i := 0 to Self.Count - 1 do
  begin
    NodeSeccio := iNode.AddChild('Box');
    Self.Items[i].MarshalToXML(XMLDoc, NodeSeccio, 'Box');
  end;
  XMLDoc.SaveToFile(sFile);
end;

procedure TNodeList.SetItem(Index: integer; AObject: TNode);
begin
  inherited Items[Index] := AObject;
end;

procedure TNodeList.Setoptions(const Value: TOptionsApplication);
begin
  Foptions := Value;
end;

procedure TNodeList.SortList;
begin
  Self.Sort(@Compare);
end;

procedure TNodeList.UnMarshalFromXML(sFile: string);
var
  Document: IXMLDocument;
  iXMLRootNode, iXMLRootNode2: IXMLNode;
  objBox: TNode;
begin
  Document := TXMLDocument.Create(nil);
  try
    Document.LoadFromFile(sFile);
    iXMLRootNode := Document.ChildNodes.first;
    iXMLRootNode2 := iXMLRootNode.ChildNodes.first;
    while iXMLRootNode2 <> nil do
    begin
      if iXMLRootNode2.nodeName = 'Box' then
      begin
        objBox := TNode.Create();
        objBox.UnMarshalFromXML(Document, iXMLRootNode2, 'Box');
        objBox.options := Self.options;
        Self.Add(objBox);
      end;
      iXMLRootNode2 := iXMLRootNode2.nextSibling;
    end;
  finally
    Document := nil;
  end;
end;

end.
