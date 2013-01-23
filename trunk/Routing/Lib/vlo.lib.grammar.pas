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
unit vlo.lib.grammar;

interface

uses
  Contnrs, Generics.collections, Generics.Defaults, vlo.lib.grammar.production;

type
  TGrammar = class(TObjectList<TProductionGrammar>)
  public
    function exists(productionGramar: TProductionGrammar): Boolean;
    procedure sortItems;
  end;

const
  lambda = 'λ';

implementation

uses
  Dialogs;

{ TGrammar }

function TGrammar.exists(productionGramar: TProductionGrammar): Boolean;
var
  i: Integer;
  bfound: Boolean;
begin
  bfound := false;
  i := 0;
  while (i < self.Count) and (not bfound) do
  begin
    bfound := (self[i].ToString = productionGramar.ToString);
    Inc(i);
  end;
  result := bfound;
end;

procedure TGrammar.sortItems;
begin
  self.Sort(TComparer<TProductionGrammar>.Construct(
    function(const L, R: TProductionGrammar): Integer
    begin
        if L.FromTransition > R.FromTransition then
          result := 1
        else if L.FromTransition = R.FromTransition then
          result := 0
        else
          result := -1;
    end
    ));
end;

end.
