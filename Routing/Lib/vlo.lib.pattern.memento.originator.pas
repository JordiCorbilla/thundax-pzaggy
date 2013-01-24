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
unit vlo.lib.pattern.memento.originator;

interface

uses
  vlo.lib.Node, contnrs, vlo.lib.Connector, vlo.lib.Node.list, vlo.lib.pattern.memento;

type
  TOriginator = class(TObject)
    FboxListState: TNodeList;
    FConnectorListState: TConnectorList;
  public
    procedure SetState(boxListState: TNodeList; ConnectorListState: TConnectorList);
    function SaveToMemento(): TMemento;
    function restoreBoxFromMemento(memento: TMemento): TNodeList;
    function restoreConnectorFromMemento(memento: TMemento): TConnectorList;
  end;

implementation


uses
  SysUtils;

{ TOriginator }

function TOriginator.restoreBoxFromMemento(memento: TMemento): TNodeList;
begin
  Self.FboxListState := memento.getSavedBoxState;
  result := Self.FboxListState;
end;

function TOriginator.restoreConnectorFromMemento(memento: TMemento): TConnectorList;
var
  i: integer;
  con: TConnector;
begin
  Self.FConnectorListState := memento.getSavedConnectorState;
  for i := 0 to Self.FConnectorListState.Count - 1 do
  begin
    con := Self.FConnectorListState.Items[i];
    con.SourceNode := Self.FboxListState.GetNode(con.HashSourceNode);
    con.TargetNode := Self.FboxListState.GetNode(con.HashTargetNode);
  end;
  result := Self.FConnectorListState;
end;

function TOriginator.SaveToMemento: TMemento;
begin
  result := TMemento.Create(Self.FboxListState, Self.FConnectorListState);
end;

procedure TOriginator.SetState(boxListState: TNodeList; ConnectorListState: TConnectorList);
begin
  Self.FboxListState := boxListState;
  Self.FConnectorListState := ConnectorListState;
end;

end.
