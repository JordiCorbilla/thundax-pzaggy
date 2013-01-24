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
unit vlo.lib.options;

interface

uses
  graphics;

type
  TOptionsApplication = class(TObject)
  private
    FShowGrid: boolean;
    FMovementPrecision: integer;
    FSnapToGrid: boolean;
    FgridSize: integer;
    FBackGroundColor: TColor;
    FGridColor: TColor;
    FRewriteOnFilling: boolean;
    FBackGroundProperties: TColor;
    FSelectionColorMark: TColor;
    FRoundedIndex: integer;
    procedure SetMovementPrecision(const Value: integer);
    procedure SetShowGrid(const Value: boolean);
    procedure SetSnapToGrid(const Value: boolean);
    procedure SetgridSize(const Value: integer);
    procedure SetBackGroundColor(const Value: TColor);
    procedure SetGridColor(const Value: TColor);
    procedure SetRewriteOnFilling(const Value: boolean);
    procedure SetBackGroundProperties(const Value: TColor);
    procedure SetSelectionColorMark(const Value: TColor);
    procedure SetRoundedIndex(const Value: integer);
  public
    property ShowGrid: boolean read FShowGrid write SetShowGrid;
    property SnapToGrid: boolean read FSnapToGrid write SetSnapToGrid;
    property MovementPrecision: integer read FMovementPrecision write SetMovementPrecision;
    property gridSize: integer read FgridSize write SetgridSize;
    property BackGroundColor: TColor read FBackGroundColor write SetBackGroundColor;
    property GridColor: TColor read FGridColor write SetGridColor;
    property RewriteOnFilling: boolean read FRewriteOnFilling write SetRewriteOnFilling;
    property BackGroundProperties: TColor read FBackGroundProperties write SetBackGroundProperties;
    property SelectionColorMark: TColor read FSelectionColorMark write SetSelectionColorMark;
    property RoundedIndex: integer read FRoundedIndex write SetRoundedIndex;
    constructor Create();
    destructor Destroy(); override;
    procedure LoadFromFile();
    procedure SaveToFile();
  end;

implementation

uses
  inifiles, SysUtils;

{ TOptionsApplication }

constructor TOptionsApplication.Create;
begin
  FShowGrid := true;
  FSnapToGrid := true;
  FMovementPrecision := 10;
  FBackGroundColor := clWhite;
  FGridColor := clgray;
  FRewriteOnFilling := false;
  FBackGroundProperties := clWhite;
  FRoundedIndex := 10;
  LoadFromFile;
end;

destructor TOptionsApplication.Destroy;
begin
  inherited;
end;

procedure TOptionsApplication.LoadFromFile;
var
  ini: TIniFile;
begin
  ini := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'options.ini');
  try
    FShowGrid := StrToBool(ini.ReadString('APP', 'ShowGrid', '1'));
    FSnapToGrid := StrToBool(ini.ReadString('APP', 'SnapToGrid', '1'));
    FMovementPrecision := StrToInt(ini.ReadString('APP', 'MovementPrecision', '10'));
    FgridSize := StrToInt(ini.ReadString('APP', 'GridSize', '10'));
    FBackGroundColor := StrToInt(ini.ReadString('APP', 'BackGroundColor', '16777215')); // clWhite
    FGridColor := StrToInt(ini.ReadString('APP', 'GridColor', '8421504')); // clgray
    FRewriteOnFilling := StrToBool(ini.ReadString('APP', 'RewriteFilling', '0'));
    FBackGroundProperties := StrToInt(ini.ReadString('APP', 'BackGroundProperties', '16777215')); // clWhite
    FSelectionColorMark := StrToInt(ini.ReadString('APP', 'SelectionColorMark', '0')); // clBlack
    FRoundedIndex := StrToInt(ini.ReadString('APP', 'RoundedIndex', '10')); // clBlack
  finally
    ini.free;
  end;
end;

procedure TOptionsApplication.SaveToFile;
var
  ini: TIniFile;
begin
  ini := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'options.ini');
  try
    ini.WriteString('APP', 'ShowGrid', BooltoStr(FShowGrid));
    ini.WriteString('APP', 'SnapToGrid', BooltoStr(FSnapToGrid));
    ini.WriteString('APP', 'MovementPrecision', InttoStr(FMovementPrecision));
    ini.WriteString('APP', 'GridSize', InttoStr(FgridSize));
    ini.WriteString('APP', 'BackGroundColor', InttoStr(FBackGroundColor));
    ini.WriteString('APP', 'GridColor', InttoStr(FGridColor));
    ini.WriteString('APP', 'RewriteFilling', BooltoStr(FRewriteOnFilling));
    ini.WriteString('APP', 'BackGroundProperties', InttoStr(FBackGroundProperties));
    ini.WriteString('APP', 'SelectionColorMark', InttoStr(FSelectionColorMark));
    ini.WriteString('APP', 'RoundedIndex', InttoStr(FRoundedIndex));
  finally
    ini.free;
  end;
end;

procedure TOptionsApplication.SetBackGroundColor(const Value: TColor);
begin
  FBackGroundColor := Value;
end;

procedure TOptionsApplication.SetBackGroundProperties(const Value: TColor);
begin
  FBackGroundProperties := Value;
end;

procedure TOptionsApplication.SetGridColor(const Value: TColor);
begin
  FGridColor := Value;
end;

procedure TOptionsApplication.SetgridSize(const Value: integer);
begin
  FgridSize := Value;
end;

procedure TOptionsApplication.SetMovementPrecision(const Value: integer);
begin
  FMovementPrecision := Value;
end;

procedure TOptionsApplication.SetRewriteOnFilling(const Value: boolean);
begin
  FRewriteOnFilling := Value;
end;

procedure TOptionsApplication.SetRoundedIndex(const Value: integer);
begin
  FRoundedIndex := Value;
end;

procedure TOptionsApplication.SetSelectionColorMark(const Value: TColor);
begin
  FSelectionColorMark := Value;
end;

procedure TOptionsApplication.SetShowGrid(const Value: boolean);
begin
  FShowGrid := Value;
end;

procedure TOptionsApplication.SetSnapToGrid(const Value: boolean);
begin
  FSnapToGrid := Value;
end;

end.
