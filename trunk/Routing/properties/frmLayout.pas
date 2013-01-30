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
 unit frmLayout;

interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, StdCtrls, vlo.lib.Layout, Buttons;

type
    TfLayout = class(TForm)
        GroupBox1: TGroupBox;
        repEpsilon: TEdit;
        Label1: TLabel;
        GroupBox2: TGroupBox;
        Label2: TLabel;
        attEpsilon: TEdit;
        Label3: TLabel;
        repLyEpsilon: TEdit;
        repLyOffset: TEdit;
        Label4: TLabel;
        Label5: TLabel;
        attlyEpsilon: TEdit;
        Label6: TLabel;
        attLyOffset: TEdit;
        GroupBox3: TGroupBox;
        Label7: TLabel;
        Label8: TLabel;
        Label9: TLabel;
        speed: TEdit;
        friction: TEdit;
        changelimit: TEdit;
        Label10: TLabel;
        maxSpeed: TEdit;
        MaxSteps: TEdit;
        Label11: TLabel;
        chkStop: TCheckBox;
        chkEnergy: TCheckBox;
        chkCenter: TCheckBox;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton1: TSpeedButton;
        procedure FormShow(Sender: TObject);
        procedure Button2Click(Sender: TObject);
        procedure Button1Click(Sender: TObject);
        procedure Button3Click(Sender: TObject);
    private
        { Private declarations }
    public
        layout: TLayoutApplication;
    end;

const
    mask = '#0.##########';

var
    fLayout: TfLayout;

implementation

{$R *.dfm}

procedure TfLayout.Button1Click(Sender: TObject);
begin
    if Assigned(layout) then
    begin
        layout.epsilon_repulsive_force := StrToFloat(repEpsilon.Text);
        layout.epsilon_repulsive_lying_nodes := StrToFloat(repLyEpsilon.Text);
        layout.epsilon_repulsive_lying_nodes_offset := StrToFloat(repLyOffset.Text);

        layout.epsilon_attractive_force := StrToFloat(attEpsilon.Text);
        layout.epsilon_attractive_lying_nodes := StrToFloat(attlyEpsilon.Text);
        layout.epsilon_attractive_lying_nodes_offset := StrToFloat(attLyOffset.Text);

        layout.speed_offset := StrToFloat(speed.Text);
        layout.friction := StrToFloat(friction.Text);
        layout.energy_change_limit := StrToFloat(changelimit.Text);
        layout.maximum_speed := StrToFloat(maxSpeed.Text);
        layout.max_steps_to_stop := StrToInt(MaxSteps.Text);
        layout.show_every_step := chkStop.Checked;
        layout.showEnergy := chkEnergy.Checked;
        layout.centerGraph := chkCenter.Checked;
        layout.SaveToFile;
        close;
    end;
end;

procedure TfLayout.Button2Click(Sender: TObject);
begin
    close;
end;

procedure TfLayout.Button3Click(Sender: TObject);
begin
    repEpsilon.Text := FormatFloat(mask, 100);
    repLyEpsilon.Text := FormatFloat(mask, 1);
    repLyOffset.Text := FormatFloat(mask, 0.5);

    attEpsilon.Text := FormatFloat(mask, 100);
    attlyEpsilon.Text := FormatFloat(mask, 10);
    attLyOffset.Text := FormatFloat(mask, 0.5);

    speed.Text := FormatFloat(mask, 0.1);
    friction.Text := FormatFloat(mask, 5);
    changelimit.Text := FormatFloat(mask, 0.000001);
    maxSpeed.Text := FormatFloat(mask, 1);
    MaxSteps.Text := InttoStr(2000);
    chkStop.Checked := true;
    chkEnergy.Checked := true;
    chkCenter.Checked := true;
end;

procedure TfLayout.FormShow(Sender: TObject);
begin
    if Assigned(layout) then
    begin
        repEpsilon.Text := FormatFloat(mask, layout.epsilon_repulsive_force);
        repLyEpsilon.Text := FormatFloat(mask, layout.epsilon_repulsive_lying_nodes);
        repLyOffset.Text := FormatFloat(mask, layout.epsilon_repulsive_lying_nodes_offset);

        attEpsilon.Text := FormatFloat(mask, layout.epsilon_attractive_force);
        attlyEpsilon.Text := FormatFloat(mask, layout.epsilon_attractive_lying_nodes);
        attLyOffset.Text := FormatFloat(mask, layout.epsilon_attractive_lying_nodes_offset);

        speed.Text := FormatFloat(mask, layout.speed_offset);
        friction.Text := FormatFloat(mask, layout.friction);
        changelimit.Text := FormatFloat(mask, layout.energy_change_limit);
        maxSpeed.Text := FormatFloat(mask, layout.maximum_speed);
        MaxSteps.Text := InttoStr(layout.max_steps_to_stop);
        chkStop.Checked := layout.show_every_step;
        chkEnergy.Checked := layout.showEnergy;
        chkCenter.Checked := layout.centerGraph;
    end;
end;

end.
