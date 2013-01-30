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
unit vlo.lib.routing;

interface

uses
  StdCtrls, vlo.lib.arrays, vlo.lib.logging;

type
  TNode = record
    source: integer;
    destiny: integer;
    pes: integer;
    visited: boolean;
    brother: boolean;
    father: integer;
    isSource: boolean;
    isDestination: boolean;
  end;

  TAdjacentArray = array of TNode;

  TRoute = array of array of TAdjacentArray;

  TRouting = class(TObject)
    class function GetConnections2(lista: TAdjacentArray; source: integer): TArrayInteger;
    class procedure SetAdjacentValue(var a: TAdjacentArray; valor1, valor2: integer); overload;
    class procedure SetAdjacentValue(var a: TAdjacentArray; valor: TNode); overload;
    class function isVisited(AdjacentList: TAdjacentArray; source: integer; destiny: integer; var pes: integer): boolean;
    class function getPes(AdjacentList: TAdjacentArray; source: integer): integer;
    class procedure Visit(AdjacentList: TAdjacentArray; source: integer; destiny: integer);
    class function ExamineNodes2(memo1: TMemo; firstNode: integer; lastNode: integer; AdjacentList: TAdjacentArray): string;
    class procedure PrintAdjacentList(FLog: TLogObject; AdjacentList: TAdjacentArray);
    class procedure GetOrderedList(var lista: TAdjacentArray);
    class function GetInterlockList(Interlocklist: TAdjacentArray; id: integer): TArrayInteger;
    class procedure SetCheckArrayValue(var a: TArrayInteger; valor: integer);
  end;

var
  rutes: TAdjacentArray;

implementation

uses
  SysUtils, Dialogs;

class function TRouting.GetConnections2(lista: TAdjacentArray; source: integer): TArrayInteger;
var
  res: TArrayInteger;
  i: integer;
  lista2: TAdjacentArray;
begin
  for i := 0 to length(lista) - 1 do
  begin
    if lista[i].source = source then
      SetAdjacentValue(lista2, lista[i]);
    // SetArrayValue(res, lista[i].destiny);
  end;

  GetOrderedList(lista2);

  for i := (length(lista2) - 1) downto 0 do
  begin
    TArray.SetValue(res, lista2[i].destiny);
  end;
  // for i := 0 to (length(lista2) - 1)  do
  // begin
  // SetArrayValue(res, lista2[i].destiny);
  // end;
  result := res;
end;

class procedure TRouting.GetOrderedList(var lista: TAdjacentArray);
var
  x, y: integer;
  aux: TNode;
begin
  for x := 0 to length(lista) - 1 do // Metodo de burbuja
  begin
    for y := 0 to length(lista) - 2 do
    begin
      if lista[y].pes > lista[y + 1].pes then
      begin
        aux := lista[y];
        lista[y] := lista[y + 1];
        lista[y + 1] := aux;
      end;
    end;
  end;
end;

class procedure TRouting.SetCheckArrayValue(var a: TArrayInteger; valor: integer);
var
  iPosArray: integer;
  i: integer;
  trobat: boolean;
begin
  trobat := false;
  for i := 0 to length(a) - 1 do
  begin
    trobat := (a[i] = valor);
  end;
  if not trobat then
  begin
    iPosArray := length(a);
    SetLength(a, iPosArray + 1);
    a[iPosArray] := valor;
  end;
end;

class procedure TRouting.SetAdjacentValue(var a: TAdjacentArray; valor1, valor2: integer);
var
  iPosArray: integer;
begin
  iPosArray := length(a);
  SetLength(a, iPosArray + 1);
  a[iPosArray].source := valor1;
  a[iPosArray].destiny := valor2;
end;

class procedure TRouting.SetAdjacentValue(var a: TAdjacentArray; valor: TNode);
var
  iPosArray: integer;
begin
  iPosArray := length(a);
  SetLength(a, iPosArray + 1);
  a[iPosArray] := valor;
end;

class function TRouting.getPes(AdjacentList: TAdjacentArray; source: integer): integer;
var
  count, count2, i: integer;
begin
  count := 0;
  count2 := 0;
  for i := 0 to length(AdjacentList) - 1 do
  begin
    if AdjacentList[i].source = source then
      count := count + 1;
  end;
  // for i := 0 to length(AdjacentList) - 1 do
  // begin
  // if AdjacentList[i].destiny = source then
  // count2 := count2 + 1;
  // if AdjacentList[i].destiny = 19 then
  // begin
  // count2 := 0;
  // break;
  // end;
  // end;
  if count > count2 then
    result := count
  else
    result := count2;
end;

class function TRouting.isVisited(AdjacentList: TAdjacentArray; source: integer; destiny: integer; var pes: integer): boolean;
var
  i, j: integer;
  val: integer;
begin
  val := 0;
  for i := 0 to length(AdjacentList) - 1 do
  begin
    if (AdjacentList[i].source = source) and (AdjacentList[i].destiny = destiny) then
    begin
      val := AdjacentList[i].pes;
      pes := val;
      if not AdjacentList[i].brother then
      begin
        for j := 0 to length(AdjacentList) - 1 do
        begin
          if AdjacentList[j].brother then
            AdjacentList[j].pes := 1;
        end;
      end;

      break;
    end;
  end;
  result := (val > 0);
end;

class procedure TRouting.Visit(AdjacentList: TAdjacentArray; source: integer; destiny: integer);
var
  i: integer;
begin
  for i := 0 to length(AdjacentList) - 1 do
  begin
    if (AdjacentList[i].source = source) and (AdjacentList[i].destiny = destiny) then
    begin
      AdjacentList[i].pes := AdjacentList[i].pes - 1;
      break;
    end;
  end;
end;

class function TRouting.ExamineNodes2(memo1: TMemo; firstNode: integer; lastNode: integer; AdjacentList: TAdjacentArray): string;
var
  nodeVisited: integer;
  res: TArrayInteger;
  i, iPosArray: integer;
  father: integer;
  val: string;
  pes: integer;
begin
  nodeVisited := firstNode;
  val := Inttostr(nodeVisited) + ' ';
  // 1
  father := nodeVisited; // 1
  while (nodeVisited <> lastNode) do
  begin
    // Aquí hay el 4 y el 5
    res := GetConnections2(AdjacentList, nodeVisited);
    for i := 0 to length(res) - 1 do
    begin

      nodeVisited := res[i]; // 4
      if isVisited(AdjacentList, father, nodeVisited, pes) then
      begin
        Visit(AdjacentList, father, nodeVisited);
        memo1.lines.add('  Father: ' + Inttostr(father) + ' Visited: ' + Inttostr(nodeVisited));
        iPosArray := length(rutes);
        SetLength(rutes, iPosArray + 1);
        rutes[iPosArray].source := nodeVisited;
        rutes[iPosArray].father := father;
        val := val + ExamineNodes2(memo1, nodeVisited, lastNode, AdjacentList) + ' ';
      end
      else
      begin
        memo1.lines.add('       **No visited' + ' Visited: ' + Inttostr(nodeVisited));
      end;
      memo1.lines.add('       ****Peso' + Inttostr(pes) + ' Visited: ' + Inttostr(nodeVisited));
    end;
    if length(res) = 0 then
    begin
      showmessage('Error' + Inttostr(father));
      exit;
    end;
  end;
  result := result + val + ' ';
end;

class procedure TRouting.PrintAdjacentList(FLog: TLogObject; AdjacentList: TAdjacentArray);
var
  i: integer;
begin
  for i := 0 to length(AdjacentList) - 1 do
  begin
    FLog.add('Source ' + Inttostr(AdjacentList[i].source) + ' Destiny ' + Inttostr(AdjacentList[i].destiny) + ' isSource ' + BoolToStr(AdjacentList[i].isSource) + ' isDestination ' +
      BoolToStr(AdjacentList[i].isDestination));
  end;
end;

class function TRouting.GetInterlockList(Interlocklist: TAdjacentArray; id: integer): TArrayInteger;
var
  father: integer;
  i: integer;
  list: TArrayInteger;
begin
  SetLength(list, 0);
  father := 0;
  for i := 0 to length(Interlocklist) - 1 do
  begin
    if Interlocklist[i].source = id then
    begin
      father := Interlocklist[i].destiny;
      break;
    end;
  end;
  if father <> 0 then
  begin
    for i := 0 to length(Interlocklist) - 1 do
    begin
      if (Interlocklist[i].source = father) and (Interlocklist[i].destiny <> id) then
        SetCheckArrayValue(list, Interlocklist[i].destiny);
    end;
  end;
  result := list;
end;

end.
