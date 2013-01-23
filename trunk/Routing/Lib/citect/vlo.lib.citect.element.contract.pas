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
unit vlo.lib.citect.element.contract;

interface

uses
  Types, vlo.lib.citect.properties;

type
  ICitectElement = Interface
    procedure SetName(const Value: string);
    procedure SetLibName(const Value: string);
    procedure SetPosition(const Value: TPoint);
    procedure Setparametres(const Value: TGroupParamList);
    function GetName(): String;
    function GetLibName(): String;
    function GetPosition(): TPoint;
    function GetParametres(): TGroupParamList;
    function GetInitLine(): TPoint;
    function GetEndLine(): TPoint;
    property name: string read GetName write SetName;
    property libname: string read GetLibName write SetLibName;
    property position: TPoint read GetPosition write SetPosition;
    property parametres: TGroupParamList read GetParametres write Setparametres;
    property InitLine: TPoint read GetInitLine;
    property EndLine: TPoint read GetEndLine;
    function AddParam(name: string; param: string): ICitectElement;
    function SetInitLine(const point: TPoint): ICitectElement;
    function SetEndLine(const point: TPoint): ICitectElement;
  End;

implementation

end.
