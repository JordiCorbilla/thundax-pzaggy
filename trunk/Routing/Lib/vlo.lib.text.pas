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
unit vlo.lib.text;

interface

uses
  Graphics, Types, Windows, ExtCtrls, Math;

type
  TGDIText = class(TObject)
    class procedure DrawTextOrientation(canvas: TCanvas; position: TPoint; epsilon: integer; font: TFont; text: string; ExistImage: Boolean; ifImageColor: TColor; enableZoom: Boolean);
    class procedure GradienteVertical(image: TImage; ColorOrigen, ColorDestino: TColor);
  end;

implementation

uses
  vlo.lib.zoom;

class procedure TGDIText.DrawTextOrientation(canvas: TCanvas; position: TPoint; epsilon: integer; font: TFont; text: string; ExistImage: Boolean; ifImageColor: TColor; enableZoom: Boolean);
  function iif(condition: Boolean; resultTrue: integer; resultFalse: integer): integer;
  begin
    result := resultFalse;
    if condition then
      result := resultTrue
  end;

var
  newFont, FontSelected: integer;
  FontSize: integer;
begin
  if text = '' then
    exit;

  if enableZoom then
    FontSize := MulDiv(font.Size, 100, globalZoom)
  else
    FontSize := font.Size;

  SetBkMode(canvas.handle, transparent);
  newFont := CreateFont(-FontSize, 0, epsilon * 10, 0, iif(fsBold in font.Style, FW_BOLD, FW_NORMAL), iif(fsItalic in font.Style, 1, 0), iif(fsUnderline in font.Style, 1, 0),
    iif(fsStrikeOut in font.Style, 1, 0), ANSI_CHARSET, OUT_TT_PRECIS, CLIP_DEFAULT_PRECIS, ANTIALIASED_QUALITY { PROOF_QUALITY } , FF_DONTCARE, PChar(font.Name));

  if ExistImage then
    canvas.font.Color := ifImageColor
  else
    canvas.font.Color := font.Color;
  FontSelected := SelectObject(canvas.handle, newFont);
  TextOut(canvas.handle, position.x, position.y, PChar(text), length(text));
  SelectObject(canvas.handle, FontSelected);
  DeleteObject(newFont);
end;

class procedure TGDIText.GradienteVertical(image: TImage; ColorOrigen, ColorDestino: TColor);
  procedure ColorToRGB(iColor: TColor; var R, G, B: Byte);
  begin
    R := GetRValue(iColor);
    G := GetGValue(iColor);
    B := GetBValue(iColor);
  end;

var
  dif, dr, dg, db: Extended;
  r1, r2, g1, g2, b1, b2: Byte;
  R, G, B: Byte;
  i, j: integer;
begin
  ColorToRGB(ColorOrigen, r1, g1, b1);
  ColorToRGB(ColorDestino, r2, g2, b2);

  dif := image.ClientRect.Right - image.ClientRect.Left;
  dr := (r2 - r1) / dif;
  dg := (g2 - g1) / dif;
  db := (b2 - b1) / dif;

  j := 0;
  for i := image.ClientRect.Top to image.ClientRect.Bottom - 1 do
  begin
    R := r1 + Ceil(dr * j);
    G := g1 + Ceil(dg * j);
    B := b1 + Ceil(db * j);
    image.canvas.Pen.Color := RGB(R, G, B);
    image.canvas.MoveTo(i, image.ClientRect.Top);
    image.canvas.LineTo(i, image.ClientRect.Bottom);
    j := j + 1;
  end;
end;

end.
