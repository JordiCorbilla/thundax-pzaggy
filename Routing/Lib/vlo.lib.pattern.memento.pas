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
unit vlo.lib.pattern.memento;

interface

uses
  vlo.lib.Node, contnrs, uConnector, vlo.lib.Node.list;

type
  TMemento = class(TObject)
    FboxListState: TNodeList;
    FConnectorListState: TConnectorList;
  public
    constructor Create(boxListState: TNodeList; ConnectorListState: TConnectorList);
    destructor Destroy(); override;
    procedure ClearObjects();
    function getSavedBoxState(): TNodeList;
    function getSavedConnectorState(): TConnectorList;
  end;

implementation

uses
  SysUtils;

{ TMemento }

procedure TMemento.ClearObjects;
begin
  if Assigned(Self.FboxListState) then
    FreeAndNil(Self.FboxListState);
  if Assigned(Self.FConnectorListState) then
    FreeAndNil(Self.FConnectorListState);
end;

constructor TMemento.Create(boxListState: TNodeList; ConnectorListState: TConnectorList);
begin
  Self.FboxListState := boxListState.Clone;
  Self.FConnectorListState := ConnectorListState.Clone;
end;

destructor TMemento.Destroy;
begin
  inherited;
end;

function TMemento.getSavedBoxState: TNodeList;
begin
  result := Self.FboxListState;
end;

function TMemento.getSavedConnectorState: TConnectorList;
begin
  result := Self.FConnectorListState;
end;

end.
