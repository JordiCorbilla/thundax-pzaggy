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
unit defaultSelectProperties;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Spin, vlo.lib.properties.Abstract,
  inifiles, vlo.lib.options, Buttons;

type
  TfrmSelectProperties = class(TForm)
    Image2: TImage;
    imgBox: TImage;
    Label6: TLabel;
    penWidth: TSpinEdit;
    Label2: TLabel;
    cbBoxColor: TColorBox;
    Label3: TLabel;
    cbLineColor: TColorBox;
    Label4: TLabel;
    cbSelectedColor: TColorBox;
    Label1: TLabel;
    spArrowLength: TSpinEdit;
    Label5: TLabel;
    spPenWidth: TSpinEdit;
    Label7: TLabel;
    arrowAngle: TSpinEdit;
    Label8: TLabel;
    ColorBox1: TColorBox;
    chkFilled: TCheckBox;
    Label9: TLabel;
    cbFillColor: TColorBox;
    Label10: TLabel;
    ColorBox2: TColorBox;
    Label13: TLabel;
    Label11: TLabel;
    edFont1: TEdit;
    Button3: TButton;
    edFont2: TEdit;
    Button4: TButton;
    FontDialog1: TFontDialog;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    Label19: TLabel;
    cbColorIfImage: TColorBox;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure spPenWidthChange(Sender: TObject);
    procedure cbBoxColorChange(Sender: TObject);
    procedure chkFilledClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    textFont1: TFont;
    textFont2: TFont;
    procedure GetSettings;
    procedure SaveSettings;
    procedure drawRectangle;
    procedure Draw;
    procedure DrawFashionArrow(Source, Target: TPoint; inside: boolean; default: boolean);
  public
    DefaultEdgeProperty: TAbstractProperty;
    DefaultNodeProperty: TAbstractProperty;
    DefaultOriginNodeProperty: TAbstractProperty;
    DefaultDestinyNodeProperty: TAbstractProperty;
    DefaultSelectedEdgeProperty: TAbstractProperty;
    DefaultSelectedNodeProperty: TAbstractProperty;
    option: TOptionsApplication;
  end;

var
  frmSelectProperties: TfrmSelectProperties;

implementation

uses
  vlo.lib.Math, vlo.lib.text, Math, vlo.lib.font.serializer, vlo.lib.fonts,
  vlo.lib.properties.Node, vlo.lib.properties.Edge, types;

{$R *.dfm}
{ TfrmSelectProperties }

procedure TfrmSelectProperties.Button1Click(Sender: TObject);
begin
  SaveSettings;
  Close;
end;

procedure TfrmSelectProperties.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmSelectProperties.Button3Click(Sender: TObject);
begin
  TFontHelper.AssignDialogFont(FontDialog1, DefaultNodeProperty.fontText);
  with FontDialog1 do
    if Execute then
    begin
      TFontHelper.AssignFont(textFont1, font);
      TFontHelper.AssignEditFont(edFont1, textFont1);
      Draw();
    end;
end;

procedure TfrmSelectProperties.Button4Click(Sender: TObject);
begin
  TFontHelper.AssignDialogFont(FontDialog1, DefaultEdgeProperty.fontText);
  with FontDialog1 do
    if Execute then
    begin
      TFontHelper.AssignFont(textFont2, font);
      TFontHelper.AssignEditFont(edFont2, textFont2);
      Draw();
    end;
end;

procedure TfrmSelectProperties.cbBoxColorChange(Sender: TObject);
begin
  Draw();
end;

procedure TfrmSelectProperties.chkFilledClick(Sender: TObject);
begin
  Draw();
end;

procedure TfrmSelectProperties.Draw;
begin
  drawRectangle();
  if Assigned(option) then
  begin
    // Primer les fletxes
    DrawFashionArrow(Point(184, 35), Point(91, 69), false, false);
    DrawFashionArrow(Point(184, 35), Point(275, 69), false, true);

    DrawFashionArrow(Point(91, 81), Point(47, 115), false, false);
    DrawFashionArrow(Point(91, 81), Point(138, 115), false, true);
    DrawFashionArrow(Point(275, 81), Point(229, 115), false, true);
    DrawFashionArrow(Point(275, 81), Point(320, 115), true, true);

    if Assigned(DefaultOriginNodeProperty) then
    begin
      imgBox.Canvas.Brush.Style := bsSolid;
      imgBox.Canvas.Brush.Color := DefaultOriginNodeProperty.FillColor;
      imgBox.Canvas.Pen.width := 4;
      imgBox.Canvas.Pen.Color := DefaultOriginNodeProperty.LineColor;
    end;

    // Primer rectangle
    imgBox.Canvas.RoundRect(172, 23, 195, 46, option.RoundedIndex, option.RoundedIndex);

    // Segon nivell
    imgBox.Canvas.Brush.Style := bsSolid;
    imgBox.Canvas.Brush.Color := cbBoxColor.Selected;
    imgBox.Canvas.Pen.width := penWidth.Value;
    imgBox.Canvas.Brush.Color := cbBoxColor.Selected;
    imgBox.Canvas.Pen.Color := cbLineColor.Selected;
    imgBox.Canvas.RoundRect(79, 69, 102, 92, option.RoundedIndex, option.RoundedIndex);
    TGDIText.DrawTextOrientation(imgBox.Canvas, Point(79 + 2, 69 + 2), 0, textFont1, '1', false, clWhite, false);

    if Assigned(DefaultNodeProperty) then
    begin
      imgBox.Canvas.Brush.Style := bsSolid;
      imgBox.Canvas.Brush.Color := DefaultNodeProperty.FillColor;
      imgBox.Canvas.Pen.width := DefaultNodeProperty.penWidth;
      imgBox.Canvas.Pen.Color := DefaultNodeProperty.LineColor;
    end;
    imgBox.Canvas.RoundRect(263, 69, 286, 92, option.RoundedIndex, option.RoundedIndex);

    // Tercer nivell
    if Assigned(DefaultDestinyNodeProperty) then
    begin
      imgBox.Canvas.Brush.Style := bsSolid;
      imgBox.Canvas.Brush.Color := DefaultDestinyNodeProperty.FillColor;
      imgBox.Canvas.Pen.width := 4;
      imgBox.Canvas.Pen.Color := DefaultDestinyNodeProperty.LineColor;
    end;

    imgBox.Canvas.RoundRect(35, 115, 58, 138, option.RoundedIndex, option.RoundedIndex);
    imgBox.Canvas.RoundRect(126, 115, 149, 138, option.RoundedIndex, option.RoundedIndex);
    imgBox.Canvas.RoundRect(217, 115, 240, 138, option.RoundedIndex, option.RoundedIndex);
    imgBox.Canvas.RoundRect(308, 115, 331, 138, option.RoundedIndex, option.RoundedIndex);
  end;
end;

procedure TfrmSelectProperties.DrawFashionArrow(Source, Target: TPoint; inside: boolean; default: boolean);
  function CalcPoint(p: TPoint; angle: double; Distance: integer): TPoint;
  var
    X, Y, M: double;
  begin
    if Comparar(Abs(angle), (PI / 2), '<>') then
    begin
      if Comparar(Abs(angle), (PI / 2), '<') then
        Distance := -Distance;
      M := Tan(angle);
      X := p.X + Distance / sqrt(1 + sqr(M));
      Y := p.Y + M * (X - p.X);
      Result := Point(round(X), round(Y));
    end
    else
    begin
      if angle > 0 then
        Distance := -Distance;
      Result := Point(p.X, p.Y + Distance);
    end;
  end;

var
  angle: double;
  PArrow: array [1 .. 4] of TPoint;
  restColor: TColor;
  arrow, arrowlength, penWidth, Color, colorSel, FillColor: integer;
begin
  if default and Assigned(DefaultEdgeProperty) then
  begin
    arrow := TEdgeProperty(DefaultEdgeProperty).InclinationAngle;
    arrowlength := TEdgeProperty(DefaultEdgeProperty).LenArrow;
    penWidth := DefaultEdgeProperty.penWidth;
    Color := DefaultEdgeProperty.LineColor;
    colorSel := DefaultEdgeProperty.SelectedColor;
    FillColor := DefaultEdgeProperty.FillColor;
  end
  else
  begin
    arrow := arrowAngle.Value;
    arrowlength := spArrowLength.Value;
    penWidth := spPenWidth.Value;
    Color := ColorBox1.Selected;
    colorSel := ColorBox2.Selected;
    FillColor := cbFillColor.Selected;
  end;

  angle := ArcTan2((Target.Y - Source.Y), (Target.X - Source.X));
  PArrow[1] := Target;
  PArrow[2] := CalcPoint(Target, angle + degToRad(arrow), arrowlength);
  PArrow[3] := CalcPoint(Target, angle, 2 * arrowlength div 3);
  PArrow[4] := CalcPoint(Target, angle - degToRad(arrow), arrowlength); // pi/9

  imgBox.Canvas.Pen.width := penWidth;
  if inside then
    imgBox.Canvas.Pen.Color := colorSel
  else
    imgBox.Canvas.Pen.Color := Color;
  imgBox.Canvas.Brush.Style := bsSolid;
  restColor := imgBox.Canvas.Brush.Color;
  if chkFilled.Checked then
    imgBox.Canvas.Brush.Color := FillColor;
  imgBox.Canvas.MoveTo(Source.X, Source.Y);
  imgBox.Canvas.LineTo(Target.X, Target.Y);
  TGDIText.DrawTextOrientation(imgBox.Canvas, Point(Source.X - 20, Source.Y + 20), 0, textFont2, '1', false, clWhite, false);
  imgBox.Canvas.Polygon(PArrow);
  imgBox.Canvas.Brush.Color := restColor;
end;

procedure TfrmSelectProperties.drawRectangle;
begin
  if Assigned(option) then
  begin
    imgBox.Canvas.Brush.Style := bsSolid;
    imgBox.Canvas.Brush.Color := option.BackGroundProperties;
    imgBox.Canvas.Pen.width := 2;
    imgBox.Canvas.Pen.Color := clBlack;
    imgBox.Canvas.RoundRect(0, 0, imgBox.width, imgBox.height, option.RoundedIndex, option.RoundedIndex);
  end;
end;

procedure TfrmSelectProperties.FormCreate(Sender: TObject);
var
  ft: TFont;
  sizeText: integer;
begin
  TGDIText.GradienteVertical(Image2, clWhite, clgray);
  drawRectangle();
  ft := TFont.Create;
  ft.Name := 'Calibri';
  ft.Size := 12;
  ft.Style := ft.Style + [fsBold];
  sizeText := Image2.Canvas.textWidth('Default Selected Properties');
  TGDIText.DrawTextOrientation(Image2.Canvas, Point(1, 170 + (sizeText div 2)), 90, ft, 'Default Selected Properties', false, clWhite, false);
  ft.free;

  textFont1 := TFont.Create;
  textFont1.Name := 'Calibri';
  textFont1.Size := 12;
  textFont2 := TFont.Create;
  textFont2.Name := 'Calibri';
  textFont2.Size := 12;

  GetSettings;
end;

procedure TfrmSelectProperties.FormDestroy(Sender: TObject);
begin
  textFont1.free;
  textFont2.free;
end;

procedure TfrmSelectProperties.FormShow(Sender: TObject);
begin
  GetSettings();
  TFontHelper.AssignEditFont(edFont1, DefaultNodeProperty.fontText);
  TFontHelper.AssignEditFont(edFont2, DefaultEdgeProperty.fontText);
end;

procedure TfrmSelectProperties.GetSettings;
var
  ini: TIniFile;
begin
  ini := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
  try
    penWidth.Value := StrToInt(ini.ReadString('SELECTEDNODE', 'PenWidth', '1'));
    cbBoxColor.Selected := StrToInt(ini.ReadString('SELECTEDNODE', 'BoxColor', '16777215'));
    cbLineColor.Selected := StrToInt(ini.ReadString('SELECTEDNODE', 'LineColor', '0'));
    cbSelectedColor.Selected := StrToInt(ini.ReadString('SELECTEDNODE', 'SelectedColor', '255'));
    cbColorIfImage.Selected := StrToInt(ini.ReadString('SELECTEDNODE', 'ColorifImage', '255'));
    if Assigned(DefaultSelectedNodeProperty) then
    begin
      TFontParser.Deserializer(ini, 'SELECTEDNODE', DefaultSelectedNodeProperty);
      TFontHelper.AssignFont(textFont1, DefaultSelectedNodeProperty.fontText);
    end;

    spArrowLength.Value := StrToInt(ini.ReadString('SELECTEDEDGE', 'ArrowLength', '12'));
    spPenWidth.Value := StrToInt(ini.ReadString('SELECTEDEDGE', 'PenWidth', '1'));
    arrowAngle.Value := StrToInt(ini.ReadString('SELECTEDEDGE', 'ArrowAngle', '30'));
    ColorBox1.Selected := StrToInt(ini.ReadString('SELECTEDEDGE', 'LineColor', '0'));
    chkFilled.Checked := StrToBool(ini.ReadString('SELECTEDEDGE', 'Filled', '0'));
    cbFillColor.Selected := StrToInt(ini.ReadString('SELECTEDEDGE', 'FillColor', '0'));
    ColorBox2.Selected := StrToInt(ini.ReadString('SELECTEDEDGE', 'SelectedColor', '255'));
    if Assigned(DefaultSelectedEdgeProperty) then
    begin
      TFontParser.Deserializer(ini, 'SELECTEDEDGE', DefaultSelectedEdgeProperty);
      TFontHelper.AssignFont(textFont2, DefaultSelectedEdgeProperty.fontText);
    end;
    Draw();
  finally
    ini.free;
  end;
end;

procedure TfrmSelectProperties.SaveSettings;
var
  ini: TIniFile;
begin
  ini := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
  try
    ini.WriteString('SELECTEDNODE', 'PenWidth', InttoStr(penWidth.Value));
    ini.WriteString('SELECTEDNODE', 'BoxColor', InttoStr(cbBoxColor.Selected));
    ini.WriteString('SELECTEDNODE', 'LineColor', InttoStr(cbLineColor.Selected));
    ini.WriteString('SELECTEDNODE', 'SelectedColor', InttoStr(cbSelectedColor.Selected));
    ini.WriteString('SELECTEDNODE', 'ColorifImage', InttoStr(cbColorIfImage.Selected));

    if Assigned(DefaultSelectedNodeProperty) then
    begin
      DefaultSelectedNodeProperty.penWidth := penWidth.Value;
      DefaultSelectedNodeProperty.FillColor := cbBoxColor.Selected;
      DefaultSelectedNodeProperty.LineColor := cbLineColor.Selected;
      DefaultSelectedNodeProperty.SelectedColor := cbSelectedColor.Selected;
      DefaultSelectedNodeProperty.AssignText(textFont1);
      TFontParser.serializer(ini, 'SELECTEDNODE', DefaultSelectedNodeProperty.fontText);
    end;

    ini.WriteString('SELECTEDEDGE', 'ArrowLength', InttoStr(spArrowLength.Value));
    ini.WriteString('SELECTEDEDGE', 'PenWidth', InttoStr(spPenWidth.Value));
    ini.WriteString('SELECTEDEDGE', 'ArrowAngle', InttoStr(arrowAngle.Value));
    ini.WriteString('SELECTEDEDGE', 'LineColor', InttoStr(ColorBox1.Selected));
    ini.WriteString('SELECTEDEDGE', 'Filled', BoolToStr(chkFilled.Checked));
    ini.WriteString('SELECTEDEDGE', 'FillColor', InttoStr(cbFillColor.Selected));
    ini.WriteString('SELECTEDEDGE', 'SelectedColor', InttoStr(ColorBox2.Selected));

    if Assigned(DefaultSelectedEdgeProperty) then
    begin
      TEdgeProperty(DefaultSelectedEdgeProperty).LenArrow := spArrowLength.Value;
      DefaultSelectedEdgeProperty.penWidth := spPenWidth.Value;
      TEdgeProperty(DefaultSelectedEdgeProperty).InclinationAngle := arrowAngle.Value;
      DefaultSelectedEdgeProperty.LineColor := ColorBox1.Selected;
      DefaultSelectedEdgeProperty.Filled := chkFilled.Checked;
      DefaultSelectedEdgeProperty.FillColor := cbFillColor.Selected;
      DefaultSelectedEdgeProperty.SelectedColor := ColorBox2.Selected;
      DefaultSelectedEdgeProperty.AssignText(textFont2);
      TFontParser.serializer(ini, 'SELECTEDEDGE', DefaultSelectedEdgeProperty.fontText);
    end;

  finally
    ini.free;
  end;
end;

procedure TfrmSelectProperties.spPenWidthChange(Sender: TObject);
begin
  if (Sender as TSpinEdit).text <> '' then
    Draw();
end;

end.
