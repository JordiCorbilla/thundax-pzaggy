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
 unit ufrmAbout;

interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, jpeg, ExtCtrls, StdCtrls;

type
    TfrmAbout = class(TForm)
        Image1: TImage;
        Label1: TLabel;
        Label2: TLabel;
        procedure Label2Click(Sender: TObject);
        procedure Label2MouseEnter(Sender: TObject);
        procedure Label2MouseLeave(Sender: TObject);
    private
        { Private declarations }
    public
        { Public declarations }
    end;

var
    frmAbout: TfrmAbout;

implementation

uses
    ShellApi;
{$R *.dfm}

procedure TfrmAbout.Label2Click(Sender: TObject);
begin
    ShellExecute(self.WindowHandle, 'open', 'www.thundaxsoftware.org', nil, nil, SW_SHOWNORMAL);
end;

procedure TfrmAbout.Label2MouseEnter(Sender: TObject);
begin
    label2.Font.Color := clBlue;
end;

procedure TfrmAbout.Label2MouseLeave(Sender: TObject);
begin
    label2.Font.Color := clBlack;
end;

end.
