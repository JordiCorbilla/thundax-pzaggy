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
unit vlo.lib.GDI.Bitmaps;

interface

uses
  Windows, Classes, SysUtils, Graphics, Forms;

Const
  PixelMax = 32768;

Type
  pPixelArray = ^TPixelArray;
  TPixelArray = Array [0 .. PixelMax - 1] Of TRGBTriple;

  TBitmapRotator = class(TObject)
    class Procedure Rotate(SourceBitmap: TBitmap; out DestBitmap: TBitmap; Center: TPoint; Angle: Double);
  end;

implementation

class Procedure TBitmapRotator.Rotate(SourceBitmap: TBitmap; out DestBitmap: TBitmap; Center: TPoint; Angle: Double);
Var
  cosRadians: Double;
  inX: Integer;
  inXOriginal: Integer;
  inXPrime: Integer;
  inXPrimeRotated: Integer;
  inY: Integer;
  inYOriginal: Integer;
  inYPrime: Integer;
  inYPrimeRotated: Integer;
  OriginalRow: pPixelArray;
  Radians: Double;
  RotatedRow: pPixelArray;
  sinRadians: Double;
begin
  DestBitmap.Width := SourceBitmap.Width;
  DestBitmap.Height := SourceBitmap.Height;
  DestBitmap.PixelFormat := pf24bit;
  Radians := -(Angle) * PI / 180;
  sinRadians := Sin(Radians);
  cosRadians := Cos(Radians);
  For inX := DestBitmap.Height - 1 Downto 0 Do
  Begin
    RotatedRow := DestBitmap.Scanline[inX];
    inXPrime := 2 * (inX - Center.y) + 1;
    For inY := DestBitmap.Width - 1 Downto 0 Do
    Begin
      inYPrime := 2 * (inY - Center.x) + 1;
      inYPrimeRotated := Round(inYPrime * cosRadians - inXPrime * sinRadians);
      inXPrimeRotated := Round(inYPrime * sinRadians + inXPrime * cosRadians);
      inYOriginal := (inYPrimeRotated - 1) Div 2 + Center.x;
      inXOriginal := (inXPrimeRotated - 1) Div 2 + Center.y;
      If (inYOriginal >= 0) And (inYOriginal <= SourceBitmap.Width - 1) And (inXOriginal >= 0) And (inXOriginal <= SourceBitmap.Height - 1) Then
      Begin
        OriginalRow := SourceBitmap.Scanline[inXOriginal];
        RotatedRow[inY] := OriginalRow[inYOriginal]
      End
      Else
      Begin
        RotatedRow[inY].rgbtBlue := 255;
        RotatedRow[inY].rgbtGreen := 0;
        RotatedRow[inY].rgbtRed := 0
      End;
    End;
  End;
End;

end.
