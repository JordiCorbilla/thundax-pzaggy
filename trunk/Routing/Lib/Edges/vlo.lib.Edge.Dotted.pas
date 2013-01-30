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
unit vlo.lib.Edge.Dotted;

interface

uses
  vlo.lib.Edge.Abstract, types;

type
  TAbstractDottedEdge = class(TAbstractEdge)
    procedure Draw(Source, Target: TPoint; SourceI, TargetI: TPoint); override;
  end;

  TAbstractDottedArrowEdge = class(TAbstractEdge)
    procedure Draw(Source, Target: TPoint; SourceI, TargetI: TPoint); override;
  end;

  TAbstractDottedDoubleArrowEdge = class(TAbstractEdge)
    procedure Draw(Source, Target: TPoint; SourceI, TargetI: TPoint); override;
  end;

  TAbstractDottedDoubleLinkedArrowEdge = class(TAbstractEdge)
    procedure Draw(Source, Target: TPoint; SourceI, TargetI: TPoint); override;
  end;

implementation

uses
  vlo.lib.Edge;

{ TAbstractDottedArrowLine }

procedure TAbstractDottedArrowEdge.Draw(Source, Target: TPoint; SourceI, TargetI: TPoint);
begin
  FSource := Point(Source.X, Source.Y);
  FTarget := Point(Target.X, Target.Y);
  FSourceInterSection := SourceI;
  FTargetInterSection := TargetI;
  DrawDottedEdge(Source, Target, SourceI, TargetI);
  case ArrowKind of
    Normal:
      DrawArrow(GetLastModified, TargetI);
    Fashion:
      DrawFashionArrow(GetLastModified, TargetI);
  end;
  DrawText(Source, Target);
end;

{ TAbstractDottedDoubleArrowLine }

procedure TAbstractDottedDoubleArrowEdge.Draw(Source, Target: TPoint; SourceI, TargetI: TPoint);
begin
  FSource := Point(Source.X, Source.Y);
  FTarget := Point(Target.X, Target.Y);
  FSourceInterSection := SourceI;
  FTargetInterSection := TargetI;
  DrawDottedEdge(Source, Target, SourceI, TargetI);

  case ArrowKind of
    Normal:
      begin
        DrawArrow(GetLastModified, TargetI);
        DrawArrow(GetFirstModified, SourceI);
      end;
    Fashion:
      begin
        DrawFashionArrow(GetLastModified, TargetI);
        DrawFashionArrow(GetFirstModified, SourceI);
      end;
  end;
  DrawText(Source, Target);
end;

{ TAbstractDottedLine }

procedure TAbstractDottedEdge.Draw(Source, Target: TPoint; SourceI, TargetI: TPoint);
begin
  FSource := Point(Source.X, Source.Y);
  FTarget := Point(Target.X, Target.Y);
  FSourceInterSection := SourceI;
  FTargetInterSection := TargetI;
  DrawDottedEdge(Source, Target, SourceI, TargetI);
  DrawText(Source, Target);
end;

{ TAbstractDottedDoubleLinkedArrowLine }

procedure TAbstractDottedDoubleLinkedArrowEdge.Draw(Source, Target, SourceI, TargetI: TPoint);
begin
  FSource := Point(Source.X, Source.Y);
  FTarget := Point(Target.X, Target.Y);
  FSourceInterSection := SourceI;
  FTargetInterSection := TargetI;
  DrawDottedEdge(Source, Target, SourceI, TargetI);

  case ArrowKind of
    Normal:
      begin
        DrawArrow(GetLastModified, TargetI);
        DrawArrow(GetFirstModified, SourceI);
      end;
    Fashion:
      begin
        DrawFashionArrow(GetLastModified, TargetI);
        DrawFashionArrow(GetFirstModified, SourceI);
      end;
  end;
  DrawImageLink(Source, Target);
  DrawTextOrientation(Source, Target);
end;

end.
