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
unit vlo.lib.pattern.memento.caretaker;

interface

uses
  vlo.lib.Node, contnrs, vlo.lib.Connector, vlo.lib.Node.list, vlo.lib.pattern.memento;

type
  TCareTaker = class(TObject)
    FSavedStates: TObjectList;
  public
    constructor Create();
    destructor Destroy(); override;
    procedure addMemento(memento: TMemento);
    function thereAreMementos(): boolean;
    function getLastMemento(): TMemento;
    procedure RemoveLastMemento();
  end;

implementation

uses
  SysUtils;

{ TCareTaker }

procedure TCareTaker.addMemento(memento: TMemento);
begin
  FSavedStates.Add(memento);
end;

constructor TCareTaker.Create;
begin
  FSavedStates := TObjectList.Create();
end;

destructor TCareTaker.Destroy;
begin
  FreeAndNil(FSavedStates);
  inherited;
end;

function TCareTaker.getLastMemento(): TMemento;
begin
  result := nil;
  if (FSavedStates.Count > 0) then
    result := (FSavedStates.Items[FSavedStates.Count - 1] as TMemento);
end;

procedure TCareTaker.RemoveLastMemento;
begin
  if (FSavedStates.Count > 0) then
    FSavedStates.Remove(FSavedStates.Items[FSavedStates.Count - 1]);
end;

function TCareTaker.thereAreMementos: boolean;
begin
  result := (FSavedStates.Count > 0);
end;

end.
