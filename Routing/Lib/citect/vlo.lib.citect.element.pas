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
unit vlo.lib.citect.element;

interface

uses
  vlo.lib.citect.dispatcher, Types, GraphicsBuilder_TLB, vlo.lib.citect.properties,
  SysUtils, Classes, vlo.lib.citect.element.contract;

type
  TCitectElement = class(TInterfacedObject, ICitectElement)
  private
    FEndLine: TPoint;
    FInitLine: TPoint;
    Fposition: TPoint;
    Fname: string;
    Flibname: string;
    Fparametres: TGroupParamList;
    procedure Setposition(const Value: TPoint);
    procedure Setname(const Value: string);
    procedure Setlibname(const Value: string);
    procedure Setparametres(const Value: TGroupParamList);
    function Getname() : String;
    function Getlibname() : String;
    function GetPosition() : TPoint;
    function GetParametres() : TGroupParamList;
    function GetInitLine() : TPoint;
    function GetEndLine() : TPoint;
  public
    property parametres: TGroupParamList read GetParametres write SetParametres;
    property InitLine: TPoint read GetInitLine;
    property EndLine: TPoint read GetEndLine;
    property position: TPoint read GetPosition write SetPosition;
    property name: string read Getname write Setname;
    property libname: string read Getlibname write Setlibname;
    class function New(name: string; libname: string; position: TPoint) : ICitectElement;
    constructor Create(name: string; libname: string; position: TPoint);
    function AddParam(name: string; param: string) : ICitectElement;
    function SetInitLine(const point: TPoint) : ICitectElement;
    function SetEndLine(const point: TPoint) : ICitectElement;
    destructor Destroy(); override;
  end;

implementation

{ TCitectElement }

function TCitectElement.AddParam(name: string; param: string) : ICitectElement;
var
  parameter: TGroupParam;
begin
  parameter := TGroupParam.Create(name, param);
  Fparametres.Add(parameter);
  result := self;
end;

constructor TCitectElement.Create(name: string; libname: string; position: TPoint);
begin
  self.Fname := name;
  self.Flibname := libname;
  self.Fposition := position;
  Fparametres := TGroupParamList.Create();
end;

destructor TCitectElement.Destroy;
begin
  FreeAndNil(Fparametres);
end;

function TCitectElement.GetEndLine: TPoint;
begin
  Result := FEndLine;
end;

function TCitectElement.GetInitLine: TPoint;
begin
  Result := FInitLine;
end;

function TCitectElement.Getlibname: String;
begin
  Result := Flibname;
end;

function TCitectElement.Getname: String;
begin
  Result := FName;
end;

function TCitectElement.GetParametres: TGroupParamList;
begin
  Result := Fparametres;
end;

function TCitectElement.GetPosition: TPoint;
begin
  result := Fposition;
end;

class function TCitectElement.New(name, libname: string; position: TPoint): ICitectElement;
begin
  Result := Create(name, libname, position);
end;

function TCitectElement.SetEndLine(const point: TPoint) : ICitectElement;
begin
  FEndLine.x := point.X + self.Fposition.x;
  FEndLine.y := point.Y + self.Fposition.Y;
  result := self;
end;

function TCitectElement.SetInitLine(const point: TPoint) : ICitectElement;
begin
  FInitLine.x := point.X + self.Fposition.x;
  FInitLine.y := point.Y + self.Fposition.Y;
  result := self;
end;

procedure TCitectElement.Setlibname(const Value: string);
begin
  Flibname := Value;
end;

procedure TCitectElement.Setname(const Value: string);
begin
  Fname := Value;
end;

procedure TCitectElement.Setparametres(const Value: TGroupParamList);
begin
  Fparametres := Value;
end;

procedure TCitectElement.Setposition(const Value: TPoint);
begin
  Fposition := Value;
end;

end.
