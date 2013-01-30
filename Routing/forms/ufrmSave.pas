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
 unit ufrmSave;

interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, StdCtrls, Buttons;

type
    TfrmSave = class(TForm)
        Edit1: TEdit;
        Label1: TLabel;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
        procedure Button1Click(Sender: TObject);
        procedure FormCreate(Sender: TObject);
        procedure Button2Click(Sender: TObject);
    private
        { Private declarations }
    public
        sPathSave: string;
    end;

var
    frmSave: TfrmSave;

implementation

uses
    vlo.lib.resources;

{$R *.dfm}

procedure TfrmSave.Button1Click(Sender: TObject);
begin
    if Edit1.Text = '' then
    begin
        showMessage('You must enter a valid project name!');
        exit;
    end
    else
    begin
        if DirectoryExists(ExtractFilePath(ParamStr(0)) + 'files\' + AnsiUpperCase(Edit1.Text) + rsExtension) then
        begin
            showMessage('The project name : ' + Edit1.Text + ' already exists!');
            exit;
        end
        else
        begin
            CreateDir(ExtractFilePath(ParamStr(0)) + 'files\' + Edit1.Text + rsExtension);
            sPathSave := ExtractFilePath(ParamStr(0)) + 'files\' + Edit1.Text + rsExtension;
            close;
        end;
    end;
end;

procedure TfrmSave.Button2Click(Sender: TObject);
begin
    sPathSave := '';
    Close;
end;

procedure TfrmSave.FormCreate(Sender: TObject);
begin
    sPathSave := '';
end;

end.

