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
 unit ufrmMemento;

interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, ComCtrls, vlo.lib.pattern.memento, vlo.lib.pattern.memento.Originator, vlo.lib.pattern.memento.Caretaker;

type
    TtfrmMemento = class(TForm)
        TreeView1: TTreeView;
        procedure FormShow(Sender: TObject);
    private
        { Private declarations }
    public
        CareTaker: TCareTaker;
    end;

var
    tfrmMemento: TtfrmMemento;

implementation

{$R *.dfm}

procedure TtfrmMemento.FormShow(Sender: TObject);
    function CrearNode(Node: TTReeNode; Desc: string): TTreeNode;
    var
        res: TTreeNode;
    begin
        res := TreeView1.Items.AddChild(Node, Desc);
        result := res;
    end;
var
    Node: TTReeNode;
    i, j: integer;
    SubNode, SubSubNode: TTreeNode;
    memento: TMemento;
begin
    TreeView1.Visible := false;
    TreeView1.Items.clear;
    Node := TreeView1.Items.AddFirst(nil, 'SnapShots');
    Node.selected := true;
    Node := TreeView1.Items.getFirstNode;

    for i := 0 to Caretaker.FSavedStates.count - 1 do
    begin
        memento := (Caretaker.FSavedStates.items[i] as TMemento);
        SubNode := CrearNode(Node, 'Snapshot' + IntTostr(i + 1));
        SubSubNode := TreeView1.Items.AddChild(SubNode, 'boxList');
        for j := 0 to memento.getSavedBoxState.count - 1 do
        begin
            TreeView1.Items.AddChild(SubSubNode, 'Box Id = ' + memento.getSavedBoxState.items[j].Id);
        end;
        SubSubNode := TreeView1.Items.AddChild(SubNode, 'ConnectorList');
        for j := 0 to memento.getSavedConnectorState.count - 1 do
        begin
            TreeView1.Items.AddChild(SubSubNode, 'SourceBox Id ' + memento.getSavedConnectorState.items[j].HashSourceNode);
            TreeView1.Items.AddChild(SubSubNode, 'TargetBox Id ' + memento.getSavedConnectorState.items[j].HashTargetNode);
            TreeView1.Items.AddChild(SubSubNode, 'Line ' + memento.getSavedConnectorState.items[j].Edge.ClassName
                + ' Id ' + memento.getSavedConnectorState.items[j].Edge.Id);
        end;
    end;
    TreeView1.Visible := true;
end;

end.
