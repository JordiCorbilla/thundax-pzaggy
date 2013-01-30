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
unit vlo.lib.Math3D;

interface

uses
  Contnrs, math, sysutils;

type
  T3DPoint = class(TObject)
  private
    Fz: Double;
    Fx: Double;
    Fy: Double;
    procedure Setx(const Value: Double);
    procedure Sety(const Value: Double);
    procedure Setz(const Value: Double);
  public
   property x : Double read Fx write Setx;
   property y : Double read Fy write Sety;
   property z : Double read Fz write Setz;
   constructor Create(x, y, z : double);
  end;

  T2DPoint = class(TObject)
  private
    Fx: Double;
    Fy: Double;
    procedure Setx(const Value: Double);
    procedure Sety(const Value: Double);
  public
   property x : Double read Fx write Setx;
   property y : Double read Fy write Sety;
   constructor Create(x, y : Double);
  end;

  T3DMesh = class(TObject)
  public
    listPoint2 : TObjectList;
    procedure CalcPoints();
    destructor Destroy(); override;
  end;


implementation

//uses
//  fMain;

procedure T3DMesh.CalcPoints();

function d3Dto2D (panx, pany, panz, centrex, centrey : Double; position : T3DPoint) : T2DPoint;
var
//  x, y, z : Double;
//  newx, newy, newz : double;
//  screenx, screeny : double;
  d2d : T2DPoint;
begin
//TODO
//  x := StrToFloat(frmMain.Edit9.Text)+position.x;
//  y := StrToFloat(frmMain.Edit10.Text)+position.y;
//  z := StrToFloat(frmMain.Edit11.Text)+ position.z;
//
//  newx := (x*cos(panx)) - (z*sin(panx));
//  newz := (x*sin(panx)) + (z*cos(panx));
//  newy := (y*cos(pany)) - (newz*sin(pany));
//  z := (newy*cos(pany)) - (newz*sin(pany));
//  x := (newx*cos(panz)) - (newy*sin(panz));
//  y := (newx*sin(panz)) + (newy*cos(panz));
//  d2d := nil;
//  if z > 0 then
//  begin
//      screenx := ((x / z) * StrToFloat(frmMain.Edit13.Text)) + centrex;
//      screeny := ((y / z) * StrToFloat(frmMain.Edit13.Text)) + centrey;
//      d2d := T2DPoint.Create(screenx, screeny);
//  end;
  result := d2d;
end ;


var
  listPoint : TObjectList;
  i: Integer;
  j: Integer;
  x, y, z, subx, suby: Double;
  //d3dpoint : T3DPoint;
  d2dpoint : T2DPoint;
begin
  listPoint := TObjectList.Create;
  listPoint2 := TObjectList.Create;

//  x := 0.0;
//  y := 0.0;
//  z := 0.0;
//  for i := 0 to 71 do
//  begin
//    y := 0;
//    for j := 0 to 71 do
//    begin
//      z := Cos(x)*cos(y);
////      if z >= 0 then
////      begin
//      listPoint.Add(T3DPoint.Create(x,y,z));
//      frmMain.mmOutput.Lines.Add(floattostr(x) + ' ' + floattostr(y) + ' ' + floattostr(z));
////      end;
//      y := y + 0.1;
//    end;
//    x := x + 0.1;
//  end;

//  x :=-5.0;
//  y := -5.0;
//  z := 0.0;
//  for i := 0 to 100 do
//  begin
//    y := -5.0;
//    for j := 0 to 100 do
//    begin
//      //z := x*X*y*y;
////      z:= sin(x)*cos(y);
//      z := cos((x*x+y*y)*2) * exp((x*x)+(y*y));
////      if z >= 0 then
////      begin
//      listPoint.Add(T3DPoint.Create(x,y,z));
//      frmMain.mmOutput.Lines.Add(floattostr(x) + ' ' + floattostr(y) + ' ' + floattostr(z));
////      end;
//      y := y + 0.1;
//    end;
//    x := x + 0.1;
//  end;

//TODO
//  x :=StrToFloat(frmMain.Edit12.Text);
//  y := StrToFloat(frmMain.Edit14.Text);
//  subx := (Abs(x)+Abs(y)) / StrToFloat(frmMain.Edit15.Text);
//  suby := subx;
  z := 0.0;
  //for i := 0 to Round(subx) do
  //begin
//TODO
//    y := StrToFloat(frmMain.Edit12.Text);
    //for j := 0 to Round(suby) do
    //begin
      //z := x*X*y*y;
//      z:= sin(x)*cos(y);
      z:= x*x*exp(-x*x)*y*y*exp(-y*y);
//      z := cos((x*x+y*y)*2) * exp(-1*((x*x)+(y*y)));
//      if z >= 0 then
//      begin
      listPoint.Add(T3DPoint.Create(x,y,z));
      //TODO
      //      frmMain.mmOutput.Lines.Add(floattostr(x) + ' ' + floattostr(y) + ' ' + floattostr(z));
//      end;

//TODO
//      y := y + StrToFloat(frmMain.Edit15.Text);
    //end;
//TODO
//    x := x + StrToFloat(frmMain.Edit15.Text);
  //end;

  for i := 0 to listPoint.count - 1 do
  begin
//TODO
//    d2dpoint := d3Dto2D(StrToFloat(frmMain.Edit4.Text),StrToFloat(frmMain.Edit5.Text),StrToFloat(frmMain.Edit6.Text),StrToFloat(frmMain.Edit7.Text),StrToFloat(frmMain.Edit8.Text), T3DPoint(listPoint[i]));


    if Assigned(d2dpoint) then
      listPoint2.Add(d2dpoint);
//    x := (T3DPoint(listPoint[i]).x*StrToInt(frmMain.Edit4.Text)) / T3DPoint(listPoint[i]).z + StrToInt(frmMain.Edit6.Text);
//    y := (T3DPoint(listPoint[i]).y*StrToInt(frmMain.Edit5.Text))/ T3DPoint(listPoint[i]).z + StrToInt(frmMain.Edit7.Text);

//    x := ((T3DPoint(listPoint[i]).x) / T3DPoint(listPoint[i]).z) * StrToInt(frmMain.Edit4.Text);
//    y := ((T3DPoint(listPoint[i]).y)/ T3DPoint(listPoint[i]).z) * StrToInt(frmMain.Edit5.Text);

    //X' = ((X - Xc) * (F/Z)) + Xc
    //Y' = ((Y - Yc) * (F/Z)) + Yc

//    x := (T3DPoint(listPoint[i]).x-StrToInt(frmMain.Edit4.Text)) * (T3DPoint(listPoint[i]).z - StrToInt(frmMain.Edit6.Text) / T3DPoint(listPoint[i]).z) + T3DPoint(listPoint[i]).x;
//    y := (T3DPoint(listPoint[i]).y-StrToInt(frmMain.Edit5.Text)) * (T3DPoint(listPoint[i]).z - StrToInt(frmMain.Edit6.Text) / T3DPoint(listPoint[i]).z) + T3DPoint(listPoint[i]).y;

//    x := (T3DPoint(listPoint[i]).x);
//    y := (T3DPoint(listPoint[i]).y);

//    x := (x * Cos(StrToFloat(frmMain.Edit8.Text))) - (y * Sin(StrToFloat(frmMain.Edit8.Text)));
//    y := (x * sin(StrToFloat(frmMain.Edit8.Text))) + (y * cos(StrToFloat(frmMain.Edit8.Text)));

//    x := (T3DPoint(listPoint[i]).x);
//    y := (T3DPoint(listPoint[i]).y);
//    listPoint2.Add(T2DPoint.Create(x,y));
  end;
  listPoint.Free;
end;

{ T3DPoint }

constructor T3DPoint.Create(x, y, z: double);
begin
  Setx(x);
  Sety(y);
  Setz(z);
end;

procedure T3DPoint.Setx(const Value: Double);
begin
  Fx := Value;
end;

procedure T3DPoint.Sety(const Value: Double);
begin
  Fy := Value;
end;

procedure T3DPoint.Setz(const Value: Double);
begin
  Fz := Value;
end;

{ T2DPoint }

constructor T2DPoint.Create(x, y: Double);
begin
  Setx(x);
  Sety(y);
end;

procedure T2DPoint.Setx(const Value: Double);
begin
  Fx := Value;
end;

procedure T2DPoint.Sety(const Value: Double);
begin
  Fy := Value;
end;

destructor T3DMesh.Destroy;
begin
  listPoint2.Free;
  inherited;
end;

end.
