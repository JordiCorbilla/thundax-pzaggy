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
unit vlo.lib.treeLayout.helper;

interface

uses
  Generics.Collections, sysutils;

type
  TLayeredTreeInfo = class(TObject)
  private
    Fnode: TObject;
    FlstPosLeftBoundaryRelativeToRoot: TList<Double>;
    FpxFromTop: Double;
    FpxFromLeft: Double;
    FlstPosRightBoundaryRelativeToRoot: TList<Double>;
    FpxToLeftSibling: Double;
    FpxLeftPosRelativeToBoundingBox: Double;
    FpxLeftPosRelativeToParent: Double;
    FSubTreeWidth: Double;
    procedure SetlstPosLeftBoundaryRelativeToRoot(const Value: TList<Double>);
    procedure SetlstPosRightBoundaryRelativeToRoot(const Value: TList<Double>);
    procedure Setnode(const Value: TObject);
    procedure SetpxFromLeft(const Value: Double);
    procedure SetpxFromTop(const Value: Double);
    procedure SetpxLeftPosRelativeToBoundingBox(const Value: Double);
    procedure SetpxLeftPosRelativeToParent(const Value: Double);
    procedure SetpxToLeftSibling(const Value: Double);
    procedure SetSubTreeWidth(const Value: Double);
  public
    property SubTreeWidth: Double read FSubTreeWidth write SetSubTreeWidth;
    property pxLeftPosRelativeToParent: Double read FpxLeftPosRelativeToParent write SetpxLeftPosRelativeToParent;
    property pxLeftPosRelativeToBoundingBox: Double read FpxLeftPosRelativeToBoundingBox write SetpxLeftPosRelativeToBoundingBox;
    property pxToLeftSibling: Double read FpxToLeftSibling write SetpxToLeftSibling;
    property pxFromTop: Double read FpxFromTop write SetpxFromTop;
    property pxFromLeft: Double read FpxFromLeft write SetpxFromLeft;
    property node: TObject read Fnode write Setnode;
    property lstPosLeftBoundaryRelativeToRoot: TList<Double>read FlstPosLeftBoundaryRelativeToRoot write SetlstPosLeftBoundaryRelativeToRoot;
    property lstPosRightBoundaryRelativeToRoot: TList<Double>read FlstPosRightBoundaryRelativeToRoot write SetlstPosRightBoundaryRelativeToRoot;
    constructor Create(SubTreeWidth: Double; node: TObject);
    destructor Destroy(); override;
  end;

implementation

{ TLayeredTreeInfo }

constructor TLayeredTreeInfo.Create(SubTreeWidth: Double; node: TObject);
begin
  FlstPosLeftBoundaryRelativeToRoot := TList<Double>.Create();
  FlstPosRightBoundaryRelativeToRoot := TList<Double>.Create();
  SetSubTreeWidth(SubTreeWidth);
  SetpxLeftPosRelativeToParent(0.0);
  SetpxFromTop(0.0);
  Setnode(node);
end;

destructor TLayeredTreeInfo.Destroy;
begin
  FreeAndNil(FlstPosLeftBoundaryRelativeToRoot);
  FreeAndNil(FlstPosRightBoundaryRelativeToRoot);
  inherited;
end;

procedure TLayeredTreeInfo.SetlstPosLeftBoundaryRelativeToRoot(const Value: TList<Double>);
begin
  FlstPosLeftBoundaryRelativeToRoot := Value;
end;

procedure TLayeredTreeInfo.SetlstPosRightBoundaryRelativeToRoot(const Value: TList<Double>);
begin
  FlstPosRightBoundaryRelativeToRoot := Value;
end;

procedure TLayeredTreeInfo.Setnode(const Value: TObject);
begin
  Fnode := Value;
end;

procedure TLayeredTreeInfo.SetpxFromLeft(const Value: Double);
begin
  FpxFromLeft := Value;
end;

procedure TLayeredTreeInfo.SetpxFromTop(const Value: Double);
begin
  FpxFromTop := Value;
end;

procedure TLayeredTreeInfo.SetpxLeftPosRelativeToBoundingBox(const Value: Double);
begin
  FpxLeftPosRelativeToBoundingBox := Value;
end;

procedure TLayeredTreeInfo.SetpxLeftPosRelativeToParent(const Value: Double);
begin
  FpxLeftPosRelativeToParent := Value;
end;

procedure TLayeredTreeInfo.SetpxToLeftSibling(const Value: Double);
begin
  FpxToLeftSibling := Value;
end;

procedure TLayeredTreeInfo.SetSubTreeWidth(const Value: Double);
begin
  FSubTreeWidth := Value;
end;

end.
