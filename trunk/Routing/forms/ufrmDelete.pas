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
 unit ufrmDelete;

interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, StdCtrls, StrUtils, ShellAPI, Buttons;

type
    TFormDelete = class(TForm)
        Label1: TLabel;
        ListBox1: TListBox;
    Label2: TLabel;
    SpeedButton4: TSpeedButton;
        procedure Button1Click(Sender: TObject);
        procedure FormCreate(Sender: TObject);
        procedure ListBox1DblClick(Sender: TObject);
    private
        procedure SearchFolder(Dir, Folder: string);
        function DelTree(DirName: string): Boolean;
        { Private declarations }
    public
        sPathLoad: string;
    end;

var
    FormDelete: TFormDelete;

implementation

uses
    vlo.lib.resources;

{$R *.dfm}

procedure TFormDelete.Button1Click(Sender: TObject);
begin
    Close;
end;

procedure TFormDelete.FormCreate(Sender: TObject);
begin
    sPathLoad := '';
    SearchFolder(ExtractFilePath(ParamStr(0)) + 'files\', rsExtension);
end;

procedure TFormDelete.ListBox1DblClick(Sender: TObject);
var
    project, current: string;
    res: integer;
begin
    project := ExtractFilePath(ParamStr(0)) + 'files\';
    current := project + ListBox1.Items[ListBox1.ItemIndex] + rsExtension;
    if sPathLoad <> current then
    begin
        res := MessageDlg('Are you sure of deleting the project ' + ListBox1.Items[ListBox1.ItemIndex] + ' ?', mtConfirmation, mbOKCancel, 0);
        if res = 1 then
            if DelTree(project + ListBox1.Items[ListBox1.ItemIndex] + rsExtension) then
            begin
                ShowMessage('Project ' + ListBox1.Items[ListBox1.ItemIndex] + ' deleted successfully!');
                Close;
            end
            else
                ShowMessage('Error deleting the file, try again!');
    end
    else
        ShowMessage('This project is already opened');
end;

procedure TFormDelete.SearchFolder(Dir: string; Folder: string);
var
    SearchRec: TSearchRec;
    Separator: string;
begin
    if Copy(Dir, Length(Dir), 1) = '\' then
        Separator := ''
    else
        Separator := '\';

    if FindFirst(Dir + Separator + '*.*', faAnyFile, SearchRec) = 0 then
    begin
        if DirectoryExists(Dir + Separator + SearchRec.Name) then
        begin
            if (SearchRec.Name <> '.') and (SearchRec.Name <> '..') then
            begin
                if SearchRec.Name = Folder then
                begin
                    ListBox1.AddItem(Dir + Separator + SearchRec.Name, nil);
                end;
                SearchFolder(Dir + Separator + SearchRec.Name, Folder);
            end;
        end;
        while FindNext(SearchRec) = 0 do
        begin
            if DirectoryExists(Dir + Separator + SearchRec.Name) then
            begin
                if (SearchRec.Name <> '.') and (SearchRec.Name <> '..') then
                begin
                    if AnsiRightStr(SearchRec.Name, 4) = Folder then
                    begin
                        ListBox1.AddItem(AnsiLeftStr(SearchRec.Name, Length(SearchRec.Name) - 4), nil);
                    end;
                    SearchFolder(Dir + Separator + SearchRec.Name, Folder);
                end;
            end;
        end;
    end;
    FindClose(SearchRec);
end;

Function TFormDelete.DelTree(DirName: string): Boolean;
var
    SHFileOpStruct: TSHFileOpStruct;
    DirBuf: array [0 .. 255] of char;
begin
    try
        Fillchar(SHFileOpStruct, Sizeof(SHFileOpStruct), 0);
        Fillchar(DirBuf, Sizeof(DirBuf), 0);
        StrPCopy(DirBuf, DirName);
        with SHFileOpStruct do
        begin
            Wnd := 0;
            pFrom := @DirBuf;
            wFunc := FO_DELETE;
            fFlags := FOF_ALLOWUNDO;
            fFlags := fFlags or FOF_NOCONFIRMATION;
            fFlags := fFlags or FOF_SILENT;
        end;
        Result := (SHFileOperation(SHFileOpStruct) = 0);
    except
        Result := False;
    end;
end;

end.
