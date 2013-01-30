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
unit vlo.lib.Edge.Factory;

interface

uses
  Graphics, vlo.lib.Edge.Abstract;

type
  TAbstractFactory = class(TObject)
  private
    FCanvas: TCanvas;
  public
    constructor Create(Canvas: TCanvas);
    destructor Destroy; override;
    function GetEdge(): TAbstractEdge; virtual; abstract;
    function GetEdgeArrow(): TAbstractEdge; virtual; abstract;
    function GetEdgeDoubleArrow(): TAbstractEdge; virtual; abstract;
    function GetEdgeLinkedArrow(): TAbstractEdge; virtual; abstract;
    function GetEdgeByName(name: string): TAbstractEdge; virtual; abstract;
  end;

  TSimpleEdgesFactory = class(TAbstractFactory)
  public
    constructor Create(Canvas: TCanvas);
    destructor Destroy; override;
    function GetEdge(): TAbstractEdge; override;
    function GetEdgeArrow(): TAbstractEdge; override;
    function GetEdgeDoubleArrow(): TAbstractEdge; override;
    function GetEdgeLinkedArrow(): TAbstractEdge; override;
    function GetEdgeByName(name: string): TAbstractEdge; override;
  end;

  TDottedEdgesFactory = class(TAbstractFactory)
  public
    constructor Create(Canvas: TCanvas);
    destructor Destroy; override;
    function GetEdge(): TAbstractEdge; override;
    function GetEdgeArrow(): TAbstractEdge; override;
    function GetEdgeDoubleArrow(): TAbstractEdge; override;
    function GetEdgeLinkedArrow(): TAbstractEdge; override;
    function GetEdgeByName(name: string): TAbstractEdge; override;
  end;

implementation

uses
  vlo.lib.Edge.Simple, vlo.lib.Edge.Dotted;

{ TSimpleEdgesFactory }

constructor TSimpleEdgesFactory.Create(Canvas: TCanvas);
begin
  inherited;
end;

destructor TSimpleEdgesFactory.Destroy;
begin
  inherited;
end;

function TSimpleEdgesFactory.GetEdge(): TAbstractEdge;
begin
  Result := TAbstractSimpleEdge.Create(FCanvas);
end;

function TSimpleEdgesFactory.GetEdgeArrow(): TAbstractEdge;
begin
  Result := TAbstractSimpleArrowEdge.Create(FCanvas);
end;

function TSimpleEdgesFactory.GetEdgeByName(name: string): TAbstractEdge;
begin
  Result := nil;
  if (name = 'TAbstractSimpleEdge') or (name = 'TAbstractSimpleLine') then
    Result := GetEdge();
  if (name = 'TAbstractSimpleArrowEdge') or (name = 'TAbstractSimpleArrowLine') then
    Result := GetEdgeArrow();
  if (name = 'TAbstractSimpleDoubleArrowEdge') or (name = 'TAbstractSimpleDoubleArrowLine') then
    Result := GetEdgeDoubleArrow();
  if (name = 'TAbstractSimpleDoubleLinkedArrowEdge') or (name = 'TAbstractSimpleDoubleLinkedArrowLine') then
    Result := GetEdgeLinkedArrow();
end;

function TSimpleEdgesFactory.GetEdgeDoubleArrow(): TAbstractEdge;
begin
  Result := TAbstractSimpleDoubleArrowEdge.Create(FCanvas);
end;

function TSimpleEdgesFactory.GetEdgeLinkedArrow: TAbstractEdge;
begin
  Result := TAbstractSimpleDoubleLinkedArrowEdge.Create(FCanvas);
  Result.properties.FillColor := clBlue;
  Result.properties.Filled := true;
end;

{ TAbstractFactory }

constructor TAbstractFactory.Create(Canvas: TCanvas);
begin
  FCanvas := Canvas;
end;

destructor TAbstractFactory.Destroy;
begin
  inherited;
end;

{ TDottedLinesFactory }

constructor TDottedEdgesFactory.Create(Canvas: TCanvas);
begin
  inherited;
end;

destructor TDottedEdgesFactory.Destroy;
begin

  inherited;
end;

function TDottedEdgesFactory.GetEdge: TAbstractEdge;
begin
  Result := TAbstractDottedEdge.Create(FCanvas);
end;

function TDottedEdgesFactory.GetEdgeArrow: TAbstractEdge;
begin
  Result := TAbstractDottedArrowEdge.Create(FCanvas);
end;

function TDottedEdgesFactory.GetEdgeByName(name: string): TAbstractEdge;
begin
  Result := nil;
  if (name = 'TAbstractDottedEdge') or (name = 'TAbstractDottedLine') then
    Result := GetEdge();
  if (name = 'TAbstractDottedArrowEdge') or (name = 'TAbstractDottedArrowLine') then
    Result := GetEdgeArrow();
  if (name = 'TAbstractDottedDoubleArrowEdge') or (name = 'TAbstractDottedDoubleArrowLine') then
    Result := GetEdgeDoubleArrow();
  if (name = 'TAbstractDottedDoubleLinkedArrowEdge') or (name = 'TAbstractDottedDoubleLinkedArrowLine') then
    Result := GetEdgeLinkedArrow();
end;

function TDottedEdgesFactory.GetEdgeDoubleArrow: TAbstractEdge;
begin
  Result := TAbstractDottedDoubleArrowEdge.Create(FCanvas);
end;

function TDottedEdgesFactory.GetEdgeLinkedArrow: TAbstractEdge;
begin
  Result := TAbstractDottedDoubleLinkedArrowEdge.Create(FCanvas);
  Result.properties.FillColor := clBlue;
  Result.properties.Filled := true;
end;

end.
