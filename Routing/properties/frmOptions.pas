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
unit frmOptions;

interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, StdCtrls, Spin, vlo.lib.options, ExtCtrls, Buttons;

type
    TfOptions = class(TForm)
        GroupBox1: TGroupBox;
        CheckBox1: TCheckBox;
        CheckBox2: TCheckBox;
        Label1: TLabel;
        spnPrecision: TSpinEdit;
        Label2: TLabel;
        Label3: TLabel;
        spnGridSize: TSpinEdit;
        Label4: TLabel;
        cbBackColor: TColorBox;
        cbGridColor: TColorBox;
        Label5: TLabel;
        Label6: TLabel;
        chkRewrite: TCheckBox;
        Label7: TLabel;
        cbBackProp: TColorBox;
        Label8: TLabel;
        cbSelection: TColorBox;
        SpeedButton3: TSpeedButton;
        SpeedButton4: TSpeedButton;
        Label9: TLabel;
        spnRounded: TSpinEdit;
        Label10: TLabel;
        procedure Button1Click(Sender: TObject);
        procedure FormShow(Sender: TObject);
        procedure Button2Click(Sender: TObject);
    private
        { Private declarations }
    public
        option: TOptionsApplication;
    end;

var
    fOptions: TfOptions;

implementation

{$R *.dfm}

procedure TfOptions.Button1Click(Sender: TObject);
begin
    if Assigned(option) then
    begin
        option.ShowGrid := CheckBox1.Checked;
        option.SnapToGrid := CheckBox2.Checked;
        option.MovementPrecision := spnPrecision.Value;
        option.gridSize := spnGridSize.Value;
        option.BackGroundColor := cbBackColor.Selected;
        option.GridColor := cbGridColor.Selected;
        option.RewriteOnFilling := chkRewrite.Checked;
        option.BackGroundProperties := cbBackProp.Selected;
        option.SelectionColorMark := cbSelection.Selected;
        option.RoundedIndex := spnRounded.Value;
        option.SaveToFile;
        close;
    end;
end;

procedure TfOptions.Button2Click(Sender: TObject);
begin
    close;
end;

procedure TfOptions.FormShow(Sender: TObject);
begin
    if Assigned(option) then
    begin
        CheckBox1.Checked := option.ShowGrid;
        CheckBox2.Checked := option.SnapToGrid;
        spnPrecision.Value := option.MovementPrecision;
        spnGridSize.Value := option.gridSize;
        cbBackColor.Selected := option.BackGroundColor;
        cbGridColor.Selected := option.GridColor;
        chkRewrite.Checked := option.RewriteOnFilling;
        cbBackProp.Selected := option.BackGroundProperties;
        cbSelection.Selected := option.SelectionColorMark;
        spnRounded.Value := option.RoundedIndex;
    end;
end;

end.
