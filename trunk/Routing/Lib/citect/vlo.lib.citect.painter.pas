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
unit vlo.lib.citect.painter;

interface

uses
  GraphicsBuilder_TLB, vlo.lib.citect.element.contract, vlo.lib.citect.painter.contract;

type
  TCitectPainter = class(TInterfacedObject, ICitectPainter)
  private
    FTemplate: string;
    FProject: string;
    FStyle: string;
    procedure SetComObject(const Value: IGraphicsBuilder2);
    procedure SetProject(const Value: string);
    procedure SetStyle(const Value: string);
    procedure SetTemplate(const Value: string);
  public
    FComObject: IGraphicsBuilder2;
    property Project: string read FProject write SetProject;
    property Template: string read FTemplate write SetTemplate;
    property Style: string read FStyle write SetStyle;
    property ComObject: IGraphicsBuilder2 read FComObject write SetComObject;
    function Draw(obj: ICitectElement): ICitectPainter;
    function DrawPipe(SourceObj, DestinationObj: ICitectElement): ICitectPainter;
    function InsertProperties(obj: ICitectElement): ICitectPainter;
    constructor Create(ComObject: IGraphicsBuilder2; Project, Style, Template: String);
    function Save(): ICitectPainter;
    class function New(ComObject: IGraphicsBuilder2; Project, Style, Template: String): ICitectPainter;
  end;

implementation

uses
  vlo.lib.citect.properties;

{ TCitectPainter }

constructor TCitectPainter.Create(ComObject: IGraphicsBuilder2; Project, Style, Template: String);
begin
  FComObject := ComObject;
  FComObject.Visible := True;
  FProject := Project;
  FStyle := Style;
  FTemplate := Template;
  FComObject.PageNew(FProject, FStyle, FTemplate, 0, True, True);
end;

function TCitectPainter.Draw(obj: ICitectElement): ICitectPainter;
begin
  FComObject.LibraryObjectPlace('include', obj.libname, obj.name, 0, True);
  FComObject.PositionAt(obj.position.x, obj.position.y);
  result := Self;
end;

function TCitectPainter.DrawPipe(SourceObj, DestinationObj: ICitectElement): ICitectPainter;
begin
  FComObject.DrawPipeStart(SourceObj.InitLine.x, SourceObj.InitLine.y);
  FComObject.DrawPipeSection(DestinationObj.EndLine.x, SourceObj.InitLine.y);
  FComObject.DrawPipeSection(DestinationObj.EndLine.x, DestinationObj.EndLine.y);
  FComObject.DrawPipeEnd;
  result := Self;
end;

function TCitectPainter.InsertProperties(obj: ICitectElement): ICitectPainter;
var
  parameter: TGroupParam;
begin
  for parameter in obj.parametres do
    FComObject.LibraryObjectPutProperty(parameter.Id, parameter.Name);
  result := Self;
end;

class function TCitectPainter.New(ComObject: IGraphicsBuilder2; Project, Style, Template: String): ICitectPainter;
begin
  result := Create(ComObject, Project, Style, Template);
end;

function TCitectPainter.Save: ICitectPainter;
begin
  FComObject.PageSaveAs('Example', 'TEST');
  result := Self;
end;

procedure TCitectPainter.SetComObject(const Value: IGraphicsBuilder2);
begin
  FComObject := Value;
end;

procedure TCitectPainter.SetProject(const Value: string);
begin
  FProject := Value;
end;

procedure TCitectPainter.SetStyle(const Value: string);
begin
  FStyle := Value;
end;

procedure TCitectPainter.SetTemplate(const Value: string);
begin
  FTemplate := Value;
end;

end.
