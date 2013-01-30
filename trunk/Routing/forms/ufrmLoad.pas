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
 unit ufrmLoad;

interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, StdCtrls, StrUtils, ExtCtrls, Buttons;

type
    TfrmLoad = class(TForm)
        Label1: TLabel;
        ListBox1: TListBox;
        Label2: TLabel;
        Image1: TImage;
        Label3: TLabel;
    SpeedButton4: TSpeedButton;
        procedure FormCreate(Sender: TObject);
        procedure ListBox1DblClick(Sender: TObject);
        procedure Button1Click(Sender: TObject);
        procedure ListBox1Click(Sender: TObject);
    private
        procedure SearchFolder(Dir, Folder: string);
        procedure drawRectangle(backgroundColor, ExternalColor: TColor);
        { Private declarations }
    public
        sPathLoad: string;
        sCaption: String;
    end;

var
    frmLoad: TfrmLoad;

implementation

uses
    vlo.lib.resources;

{$R *.dfm}

procedure TfrmLoad.Button1Click(Sender: TObject);
begin
    Close;
end;

procedure TfrmLoad.FormCreate(Sender: TObject);
begin
    sPathLoad := '';
    SearchFolder(ExtractFilePath(ParamStr(0)) + 'files\', rsExtension);
end;

procedure TfrmLoad.ListBox1Click(Sender: TObject);
var
    loadImage: string;
begin
    loadImage := ExtractFilePath(ParamStr(0)) + 'files\';
    loadImage := loadImage + ListBox1.Items[ListBox1.ItemIndex];
    loadImage := loadImage + rsExtension;
    sCaption := loadImage;
    if FileExists(loadImage + '\preview.jpg') then
    begin
        Image1.Picture := nil;
        drawRectangle(clwhite, clwhite);
        Image1.Picture.LoadFromFile(loadImage + '\preview.jpg');
        Image1.Stretch := true;
    end
    else
    begin
        Image1.Picture := nil;
        drawRectangle(clwhite, clwhite);
    end;
end;

procedure TfrmLoad.drawRectangle(backgroundColor, ExternalColor: TColor);
begin
    Image1.Canvas.Brush.Style := bsSolid;
    Image1.Canvas.Brush.Color := backgroundColor;
    Image1.Canvas.Pen.Width := 3;
    Image1.Canvas.Pen.Color := ExternalColor;
    Image1.Canvas.Rectangle(0, 0, 150, 120);
end;

procedure TfrmLoad.ListBox1DblClick(Sender: TObject);
begin
    sPathLoad := ExtractFilePath(ParamStr(0)) + 'files\';
    sCaption := ListBox1.Items[ListBox1.ItemIndex] + rsExtension;
    sPathLoad := sPathLoad + ListBox1.Items[ListBox1.ItemIndex];
    sPathLoad := sPathLoad + rsExtension;
    Close;
end;

procedure TfrmLoad.SearchFolder(Dir: string; Folder: string);
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

end.
