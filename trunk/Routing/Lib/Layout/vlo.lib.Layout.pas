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
unit vlo.lib.Layout;

interface

uses
  Classes;

type
  TForce = record
    r0: extended;
    r1: extended;
    procedure SetVal(r0, r1: extended);
    procedure sR0(r0: extended);
    procedure sR1(r1: extended);
  end;

  TminMax = record
    p0: extended;
    p1: extended;
    p2: extended;
    p3: extended;
  end;

  TArrMinMax = array of TminMax;

  TPointE = record
    x: extended;
    y: extended;
  end;

  TCenter = array of TPointE;
  TStrings = array of String;

  TLayoutApplication = Class(TObject)
  private
    Fepsilon_attractive_lying_nodes: double;
    Fepsilon_attractive_force: double;
    Fspeed_offset: double;
    Fepsilon_repulsive_lying_nodes: double;
    Fepsilon_attractive_lying_nodes_offset: double;
    Ffriction: double;
    Fepsilon_repulsive_force: double;
    Fenergy_change_limit: double;
    Fmaximum_speed: double;
    Fepsilon_repulsive_lying_nodes_offset: double;
    Fmax_steps_to_stop: integer;
    Fshow_every_step: boolean;
    FcenterGraph: boolean;
    FshowEnergy: boolean;
    procedure Setenergy_change_limit(const Value: double);
    procedure Setepsilon_attractive_force(const Value: double);
    procedure Setepsilon_attractive_lying_nodes(const Value: double);
    procedure Setepsilon_attractive_lying_nodes_offset(const Value: double);
    procedure Setepsilon_repulsive_force(const Value: double);
    procedure Setepsilon_repulsive_lying_nodes(const Value: double);
    procedure Setfriction(const Value: double);
    procedure Setmaximum_speed(const Value: double);
    procedure Setspeed_offset(const Value: double);
    procedure Setepsilon_repulsive_lying_nodes_offset(const Value: double);
    procedure Setmax_steps_to_stop(const Value: integer);
    procedure Setshow_every_step(const Value: boolean);
    procedure SetcenterGraph(const Value: boolean);
    procedure SetshowEnergy(const Value: boolean);
  public
    property energy_change_limit: double read Fenergy_change_limit write Setenergy_change_limit;
    property maximum_speed: double read Fmaximum_speed write Setmaximum_speed;
    property friction: double read Ffriction write Setfriction;
    property epsilon_repulsive_force: double read Fepsilon_repulsive_force write Setepsilon_repulsive_force;
    property epsilon_repulsive_lying_nodes: double read Fepsilon_repulsive_lying_nodes write Setepsilon_repulsive_lying_nodes;
    property epsilon_attractive_force: double read Fepsilon_attractive_force write Setepsilon_attractive_force;
    property epsilon_attractive_lying_nodes: double read Fepsilon_attractive_lying_nodes write Setepsilon_attractive_lying_nodes;
    property epsilon_attractive_lying_nodes_offset: double read Fepsilon_attractive_lying_nodes_offset write Setepsilon_attractive_lying_nodes_offset;
    property speed_offset: double read Fspeed_offset write Setspeed_offset;
    property epsilon_repulsive_lying_nodes_offset: double read Fepsilon_repulsive_lying_nodes_offset write Setepsilon_repulsive_lying_nodes_offset;
    property show_every_step: boolean read Fshow_every_step write Setshow_every_step;
    property max_steps_to_stop: integer read Fmax_steps_to_stop write Setmax_steps_to_stop;
    property showEnergy: boolean read FshowEnergy write SetshowEnergy;
    property centerGraph: boolean read FcenterGraph write SetcenterGraph;
    constructor Create();
    destructor Destroy(); override;
    procedure LoadFromFile();
    procedure SaveToFile();
  End;

procedure AppendMinMax(var a: TArrMinMax; p0, p1, p2, p3: extended);
procedure AppendCenter(var a: TCenter; x, y: extended);
procedure AppendString(var a: TStrings; s: string);
procedure DeleteArrayItem(var x: TStrings; const Index: integer);
function ExistsItem(var x: TStringList; id: string): boolean;
procedure RemoveItem(var x: TStringList; const id: string);

implementation

uses
  inifiles, SysUtils;

{ TForce }

procedure TForce.SetVal(r0, r1: extended);
begin
  Self.r0 := r0;
  Self.r1 := r1;
end;

procedure TForce.sR0(r0: extended);
begin
  Self.r0 := r0;
end;

procedure TForce.sR1(r1: extended);
begin
  Self.r1 := r1;
end;

procedure AppendMinMax(var a: TArrMinMax; p0, p1, p2, p3: extended);
var
  iPosArray: integer;
begin
  iPosArray := Length(a);
  SetLength(a, iPosArray + 1);
  a[iPosArray].p0 := p0;
  a[iPosArray].p1 := p1;
  a[iPosArray].p2 := p2;
  a[iPosArray].p3 := p3;
end;

procedure AppendCenter(var a: TCenter; x, y: extended);
var
  iPosArray: integer;
begin
  iPosArray := Length(a);
  SetLength(a, iPosArray + 1);
  a[iPosArray].x := x;
  a[iPosArray].y := y;
end;

procedure AppendString(var a: TStrings; s: string);
var
  iPosArray: integer;
begin
  iPosArray := Length(a);
  SetLength(a, iPosArray + 1);
  a[iPosArray] := s;
end;

procedure DeleteArrayItem(var x: TStrings; const Index: integer);
begin
  if Index > High(x) then
    Exit;
  if Index < Low(x) then
    Exit;
  if Index = High(x) then
  begin
    SetLength(x, Length(x) - 1);
    Exit;
  end;
  Finalize(x[Index]);
  System.Move(x[Index + 1], x[Index], (Length(x) - Index - 1) * SizeOf(string) + 1);
  SetLength(x, Length(x) - 1);
end;

procedure RemoveItem(var x: TStringList; const id: string);
var
  i: integer;
  found: boolean;
begin
  found := false;
  i := 0;
  while (not found) and (i < x.Count) do
  begin
    found := (x[i] = id);
    inc(i);
  end;
  if found then
    x.Delete(i - 1);
end;

function ExistsItem(var x: TStringList; id: string): boolean;
var
  found: boolean;
  i: integer;
begin
  found := false;
  i := 0;
  while (not found) and (i < x.Count) do
  begin
    found := (x[i] = id);
    inc(i);
  end;
  result := found;
end;

{ TLayoutApplication }

constructor TLayoutApplication.Create;
begin
  Fepsilon_repulsive_force := 100;
  Fepsilon_repulsive_lying_nodes := 1;
  Fepsilon_repulsive_lying_nodes_offset := 0.5;

  Fepsilon_attractive_force := 100;
  Fepsilon_attractive_lying_nodes := 10;
  Fepsilon_attractive_lying_nodes_offset := 0.5;

  Fspeed_offset := 0.1;
  Ffriction := 5;
  Fenergy_change_limit := 0.000001;
  Fmaximum_speed := 1;

  Fmax_steps_to_stop := 2000;
  Fshow_every_step := true;

  FshowEnergy := true;
  FcenterGraph := true;
  LoadFromFile;
end;

destructor TLayoutApplication.Destroy;
begin
  inherited;
end;

procedure TLayoutApplication.LoadFromFile;
var
  ini: TIniFile;
begin
  ini := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'layout.ini');
  try
    Fepsilon_repulsive_force := StrToFloat(ini.ReadString('APP', 'epsilon_repulsive_force', '100'));
    Fepsilon_repulsive_lying_nodes := StrToFloat(ini.ReadString('APP', 'epsilon_repulsive_lying_nodes', '1'));
    Fepsilon_repulsive_lying_nodes_offset := StrToFloat(ini.ReadString('APP', 'epsilon_repulsive_lying_nodes_offset', '0.5'));

    Fepsilon_attractive_force := StrToFloat(ini.ReadString('APP', 'epsilon_attractive_force', '100'));
    Fepsilon_attractive_lying_nodes := StrToFloat(ini.ReadString('APP', 'epsilon_attractive_lying_nodes', '10'));
    Fepsilon_attractive_lying_nodes_offset := StrToFloat(ini.ReadString('APP', 'epsilon_attractive_lying_nodes_offset', '0.5'));

    Fspeed_offset := StrToFloat(ini.ReadString('APP', 'speed_offset', '0.1'));
    Ffriction := StrToFloat(ini.ReadString('APP', 'friction', '5'));
    Fenergy_change_limit := StrToFloat(ini.ReadString('APP', 'energy_change_limit', '0.000001'));
    Fmaximum_speed := StrToFloat(ini.ReadString('APP', 'maximum_speed', '1'));

    Fmax_steps_to_stop := StrToInt(ini.ReadString('APP', 'max_steps_to_stop', '5000'));
    Fshow_every_step := StrToBool(ini.ReadString('APP', 'show_every_step', '1'));
    FshowEnergy := StrToBool(ini.ReadString('APP', 'show_energy', '1'));
    FcenterGraph := StrToBool(ini.ReadString('APP', 'center_graph', '1'));
  finally
    ini.free;
  end;
end;

procedure TLayoutApplication.SaveToFile;
var
  ini: TIniFile;
begin
  ini := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'layout.ini');
  try
    ini.WriteString('APP', 'epsilon_repulsive_force', FloattoStr(Fepsilon_repulsive_force));
    ini.WriteString('APP', 'epsilon_repulsive_lying_nodes', FloattoStr(Fepsilon_repulsive_lying_nodes));
    ini.WriteString('APP', 'epsilon_repulsive_lying_nodes_offset', FloattoStr(Fepsilon_repulsive_lying_nodes_offset));

    ini.WriteString('APP', 'epsilon_attractive_force', FloattoStr(Fepsilon_attractive_force));
    ini.WriteString('APP', 'epsilon_attractive_lying_nodes', FloattoStr(Fepsilon_attractive_lying_nodes));
    ini.WriteString('APP', 'epsilon_attractive_lying_nodes_offset', FloattoStr(Fepsilon_attractive_lying_nodes_offset));

    ini.WriteString('APP', 'speed_offset', FloattoStr(Fspeed_offset));
    ini.WriteString('APP', 'friction', FloattoStr(Ffriction));
    ini.WriteString('APP', 'energy_change_limit', FloattoStr(Fenergy_change_limit));
    ini.WriteString('APP', 'maximum_speed', FloattoStr(Fmaximum_speed));

    ini.WriteString('APP', 'max_steps_to_stop', inttoStr(Fmax_steps_to_stop));
    ini.WriteString('APP', 'show_every_step', BooltoStr(Fshow_every_step));
    ini.WriteString('APP', 'show_energy', BooltoStr(FshowEnergy));
    ini.WriteString('APP', 'center_graph', BooltoStr(FcenterGraph));
  finally
    ini.free;
  end;
end;

procedure TLayoutApplication.SetcenterGraph(const Value: boolean);
begin
  FcenterGraph := Value;
end;

procedure TLayoutApplication.Setenergy_change_limit(const Value: double);
begin
  Fenergy_change_limit := Value;
end;

procedure TLayoutApplication.Setepsilon_attractive_force(const Value: double);
begin
  Fepsilon_attractive_force := Value;
end;

procedure TLayoutApplication.Setepsilon_attractive_lying_nodes(const Value: double);
begin
  Fepsilon_attractive_lying_nodes := Value;
end;

procedure TLayoutApplication.Setepsilon_attractive_lying_nodes_offset(const Value: double);
begin
  Fepsilon_attractive_lying_nodes_offset := Value;
end;

procedure TLayoutApplication.Setepsilon_repulsive_force(const Value: double);
begin
  Fepsilon_repulsive_force := Value;
end;

procedure TLayoutApplication.Setepsilon_repulsive_lying_nodes(const Value: double);
begin
  Fepsilon_repulsive_lying_nodes := Value;
end;

procedure TLayoutApplication.Setepsilon_repulsive_lying_nodes_offset(const Value: double);
begin
  Fepsilon_repulsive_lying_nodes_offset := Value;
end;

procedure TLayoutApplication.Setfriction(const Value: double);
begin
  Ffriction := Value;
end;

procedure TLayoutApplication.Setmaximum_speed(const Value: double);
begin
  Fmaximum_speed := Value;
end;

procedure TLayoutApplication.Setmax_steps_to_stop(const Value: integer);
begin
  Fmax_steps_to_stop := Value;
end;

procedure TLayoutApplication.SetshowEnergy(const Value: boolean);
begin
  FshowEnergy := Value;
end;

procedure TLayoutApplication.Setshow_every_step(const Value: boolean);
begin
  Fshow_every_step := Value;
end;

procedure TLayoutApplication.Setspeed_offset(const Value: double);
begin
  Fspeed_offset := Value;
end;

end.
