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
unit vlo.lib.logging;

interface

uses
  StdCtrls, ComCtrls;

type
  TLogObject = class(TObject)
  private
    FMemo: TMemo;
    FListView: TListView;
    FSaveToDisk: Boolean;
    FaddTimeStamp: Boolean;
    procedure SetaddTimeStamp(const Value: Boolean);
    procedure SetSaveToDisk(const Value: Boolean);
    procedure SaveToFile(description: string);
  public
    property SaveToDisk: Boolean read FSaveToDisk write SetSaveToDisk;
    property addTimeStamp: Boolean read FaddTimeStamp write SetaddTimeStamp;
    constructor Create(memo: TMemo); overload;
    constructor Create(ListView: TListView); overload;
    destructor Destroy; Override;
    procedure add(s: string);
    procedure Clear;
  end;

implementation

uses
  Windows, SysUtils;

{ TLogObject }

procedure TLogObject.add(s: string);
var
  sText: string;
begin
  sText := '';
  if FaddTimeStamp and (s <> '') then
    sText := sText + DateTimeToStr(Now) + ' ';
  sText := sText + s;
  if Assigned(FMemo) then
    FMemo.Lines.add(sText);
  if Assigned(FListView) then
    FListView.Items.add.Caption := sText;
  SaveToFile(sText);
end;

procedure TLogObject.Clear;
begin
  if Assigned(FMemo) then
    Self.FMemo.Clear;
  if Assigned(FListView) then
    FListView.Items.Clear;
  if FileExists(ExtractFilePath(ParamStr(0)) + '\app.log') then
    DeleteFile(ExtractFilePath(ParamStr(0)) + '\app.log');
end;

constructor TLogObject.Create(ListView: TListView);
begin
  Self.FListView := ListView;
end;

constructor TLogObject.Create(memo: TMemo);
begin
  Self.FMemo := memo;
end;

destructor TLogObject.Destroy;
begin
  Self.FMemo := nil;
  inherited;
end;

procedure TLogObject.SaveToFile(description: string);
var
  LogFile: TextFile;
begin
  if not FSaveToDisk then
    Exit;
  AssignFile(LogFile, ExtractFilePath(ParamStr(0)) + '\app.log');
  try
    if FileExists(ExtractFilePath(ParamStr(0)) + '\app.log') then
      Append(LogFile)
    else
      Rewrite(LogFile);
    WRITELN(LogFile, description);
    CloseFile(LogFile)
  except
  end;
end;

procedure TLogObject.SetaddTimeStamp(const Value: Boolean);
begin
  FaddTimeStamp := Value;
end;

procedure TLogObject.SetSaveToDisk(const Value: Boolean);
begin
  FSaveToDisk := Value;
end;

end.
