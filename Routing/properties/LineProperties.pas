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
 unit LineProperties;

interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, StdCtrls, ExtCtrls, Spin, vlo.lib.Edge, Buttons, vlo.lib.Edge.Abstract;

type
    TfrmLineProp = class(TForm)
        Label2: TLabel;
        cbLineColor: TColorBox;
        Label3: TLabel;
        cbFillColor: TColorBox;
        Label4: TLabel;
        cbSelectedColor: TColorBox;
        Label1: TLabel;
        spArrowLength: TSpinEdit;
        chkFilled: TCheckBox;
        Image2: TImage;
        GroupBox1: TGroupBox;
        Image1: TImage;
        rbNormal: TRadioButton;
        Image3: TImage;
        rbDotted: TRadioButton;
        GroupBox2: TGroupBox;
        Image4: TImage;
        rbStraight: TRadioButton;
        rbArrowRight: TRadioButton;
        rbDobleArrow: TRadioButton;
        GroupBox3: TGroupBox;
        Image5: TImage;
        Image6: TImage;
        rbNormalArrow: TRadioButton;
        rbFashionArrow: TRadioButton;
        Label5: TLabel;
        edFont: TEdit;
        Button3: TButton;
        Memo1: TMemo;
        FontDialog1: TFontDialog;
        rbNoArrow: TRadioButton;
        penwidth: TSpinEdit;
        Label6: TLabel;
        Label7: TLabel;
        arrowAngle: TSpinEdit;
        lClassname: TLabel;
        SpeedButton3: TSpeedButton;
        SpeedButton4: TSpeedButton;
        procedure FormCreate(Sender: TObject);
        procedure FormShow(Sender: TObject);
        procedure Button3Click(Sender: TObject);
        procedure Button2Click(Sender: TObject);
        procedure Button1Click(Sender: TObject);
    private
        { Private declarations }
    public
        line: TAbstractEdge;
        textfont: TFont;
        validate: boolean;
    end;

var
    frmLineProp: TfrmLineProp;

implementation

uses
    vlo.lib.text, vlo.lib.Edge.Adapter, vlo.lib.fonts, vlo.lib.properties.Edge,
    vlo.lib.Edge.Dotted, vlo.lib.Edge.Simple, types;

{$R *.dfm}

procedure TfrmLineProp.Button1Click(Sender: TObject);
begin
    TEdgeProperty(line.Properties).LenArrow := spArrowLength.Value;
    line.Properties.lineColor := cbLineColor.Selected;
    line.Properties.Filled := chkFilled.Checked;
    line.Properties.FillColor := cbFillColor.Selected;
    line.Properties.SelectedColor := cbSelectedColor.Selected;
    if rbNormalArrow.Checked then
        line.ArrowKind := Normal;
    if rbFashionArrow.Checked then
        line.ArrowKind := Fashion;
    line.Properties.Description.Text := Memo1.lines.Text;
    line.Properties.AssignText(textfont);
    line.Properties.penwidth := penwidth.Value;
    TEdgeProperty(line.Properties).InclinationAngle := arrowAngle.Value;

    if rbNormal.Checked then
    begin
        if rbStraight.Checked then
            line := getAdaptedLine(SimpleEdge, line);
        if rbArrowRight.Checked then
            line := getAdaptedLine(SimpleArrowEdge, line);
        if rbDobleArrow.Checked then
            line := getAdaptedLine(SimpleDoubleArrowEdge, line);
    end;
    if rbDotted.Checked then
    begin
        if rbStraight.Checked then
            line := getAdaptedLine(DottedEdge, line);
        if rbArrowRight.Checked then
            line := getAdaptedLine(DottedArrowEdge, line);
        if rbDobleArrow.Checked then
            line := getAdaptedLine(DottedDoubleArrowEdge, line);
    end;
    validate := true;
    close;
end;

procedure TfrmLineProp.Button2Click(Sender: TObject);
begin
    close;
end;

procedure TfrmLineProp.Button3Click(Sender: TObject);
begin
    TFontHelper.AssignDialogFont(FontDialog1, line.Properties.fontText);
    with FontDialog1 do
        if Execute then
        begin
            TFontHelper.AssignFont(textfont, Font);
            TFontHelper.AssignEditFont(edFont, textfont);
        end;
end;

procedure TfrmLineProp.FormCreate(Sender: TObject);
begin
    TGDIText.GradienteVertical(Image2, clwhite, clgray);
    validate := false;
end;

procedure TfrmLineProp.FormShow(Sender: TObject);
var
    ft: TFont;
    sizeText: integer;
begin
    ft := TFont.Create;
    ft.Name := 'Calibri';
    ft.Size := 12;
    ft.Style := ft.Style + [fsBold];
    sizeText := Image2.Canvas.textWidth('Edge Properties ' + line.Id);
    TGDIText.DrawTextOrientation(Image2.Canvas, Point(1, 235 + (sizeText div 2)), 90, ft, 'Edge Properties ' + line.Id, false, clwhite, false);
    ft.free;

    spArrowLength.Value := TEdgeProperty(line.Properties).LenArrow;
    cbLineColor.Selected := line.Properties.lineColor;
    chkFilled.Checked := line.Properties.Filled;
    cbFillColor.Selected := line.Properties.FillColor;
    cbSelectedColor.Selected := line.Properties.SelectedColor;
    rbNormalArrow.Checked := (line.ArrowKind = Normal);
    rbFashionArrow.Checked := (line.ArrowKind = Fashion);

    if (line is TAbstractSimpleEdge) or (line is TAbstractSimpleArrowEdge) or (line is TAbstractSimpleDoubleArrowEdge) then
        rbNormal.Checked := true
    else
        rbDotted.Checked := true;

    if (line is TAbstractSimpleEdge) or (line is TAbstractDottedEdge) then
        rbStraight.Checked := true;

    if (line is TAbstractSimpleArrowEdge) or (line is TAbstractDottedArrowEdge) then
        rbArrowRight.Checked := true;

    if (line is TAbstractSimpleDoubleArrowEdge) or (line is TAbstractDottedDoubleArrowEdge) then
        rbDobleArrow.Checked := true;

    lClassname.Caption := line.ClassName;
    Memo1.lines.Text := line.Properties.Description.Text;
    TFontHelper.AssignEditFont(edFont, line.Properties.fontText);
    textfont := line.Properties.fontText;
    penwidth.Value := line.Properties.penwidth;
    arrowAngle.Value := TEdgeProperty(line.Properties).InclinationAngle;
end;

end.
