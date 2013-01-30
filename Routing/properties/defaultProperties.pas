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
unit defaultProperties;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Spin, inifiles, vlo.lib.properties.Abstract,
  vlo.lib.options;

type
  TfrmDefault = class(TForm)
    penWidth: TSpinEdit;
    Label6: TLabel;
    Label2: TLabel;
    cbBoxColor: TColorBox;
    Label3: TLabel;
    cbLineColor: TColorBox;
    Label4: TLabel;
    cbSelectedColor: TColorBox;
    imgBox: TImage;
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
    imgLine: TImage;
    Image2: TImage;
    Label13: TLabel;
    edFont1: TEdit;
    Button3: TButton;
    Label11: TLabel;
    edFont2: TEdit;
    Button4: TButton;
    FontDialog1: TFontDialog;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    GroupBox1: TGroupBox;
    Label19: TLabel;
    cbColorFontIfImage: TColorBox;
    Label14: TLabel;
    cbColorNodeIfImage: TColorBox;
    Label15: TLabel;
    cbColorBorderIfImage: TColorBox;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure penWidthChange(Sender: TObject);
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
    procedure DrawFashionArrow(Source, Target: TPoint; inside: boolean);
    { Private declarations }
  public
    DefaultEdgeProperty: TAbstractProperty;
    DefaultNodeProperty: TAbstractProperty;
    option: TOptionsApplication;
  end;

var
  frmDefault: TfrmDefault;

implementation

uses
  vlo.lib.text, vlo.lib.Math, Math, vlo.lib.font.serializer, vlo.lib.fonts, vlo.lib.properties.Node,
  vlo.lib.properties.Edge, types;
{$R *.dfm}

procedure TfrmDefault.Button1Click(Sender: TObject);
begin
  SaveSettings;
  Close;
end;

procedure TfrmDefault.FormCreate(Sender: TObject);
var
  ft: TFont;
  sizeText: integer;
begin
  TGDIText.GradienteVertical(Image2, clwhite, clgray);
  drawRectangle();
  ft := TFont.Create;
  ft.Name := 'Calibri';
  ft.Size := 12;
  ft.Style := ft.Style + [fsBold];
  sizeText := Image2.Canvas.textWidth('Default Properties');
  TGDIText.DrawTextOrientation(Image2.Canvas, Point(1, 170 + (sizeText div 2)), 90, ft, 'Default Properties', False, clwhite, False);
  ft.free;

  textFont1 := TFont.Create;
  textFont1.Name := 'Calibri';
  textFont1.Size := 12;
  textFont2 := TFont.Create;
  textFont2.Name := 'Calibri';
  textFont2.Size := 12;

  GetSettings;
end;

procedure TfrmDefault.FormDestroy(Sender: TObject);
begin
  textFont1.free;
  textFont2.free;
end;

procedure TfrmDefault.FormShow(Sender: TObject);
begin
  GetSettings();
  TFontHelper.AssignEditFont(edFont1, DefaultNodeProperty.fontText);
  TFontHelper.AssignEditFont(edFont2, DefaultEdgeProperty.fontText);
end;

procedure TfrmDefault.GetSettings;
var
  ini: TIniFile;
begin
  ini := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
  try
    penWidth.Value := StrToInt(ini.ReadString('NODE', 'PenWidth', '1'));
    cbBoxColor.Selected := StrToInt(ini.ReadString('NODE', 'BoxColor', '16777215'));
    cbLineColor.Selected := StrToInt(ini.ReadString('NODE', 'LineColor', '0'));
    cbSelectedColor.Selected := StrToInt(ini.ReadString('NODE', 'SelectedColor', '255'));
    cbColorFontIfImage.Selected := StrToInt(ini.ReadString('NODE', 'ColorFontifImage', '255'));
    cbColorNodeIfImage.Selected := StrToInt(ini.ReadString('NODE', 'ColorNodeifImage', '255'));
    cbColorBorderIfImage.Selected := StrToInt(ini.ReadString('NODE', 'ColorBorderifImage', '255'));

    if Assigned(DefaultNodeProperty) then
    begin
      TFontParser.Deserializer(ini, 'NODE', DefaultNodeProperty);
      TFontHelper.AssignFont(textFont1, DefaultNodeProperty.fontText);
    end;

    spArrowLength.Value := StrToInt(ini.ReadString('EDGE', 'ArrowLength', '12'));
    spPenWidth.Value := StrToInt(ini.ReadString('EDGE', 'PenWidth', '1'));
    arrowAngle.Value := StrToInt(ini.ReadString('EDGE', 'ArrowAngle', '30'));
    ColorBox1.Selected := StrToInt(ini.ReadString('EDGE', 'LineColor', '0'));
    chkFilled.Checked := StrToBool(ini.ReadString('EDGE', 'Filled', '0'));
    cbFillColor.Selected := StrToInt(ini.ReadString('EDGE', 'FillColor', '0'));
    ColorBox2.Selected := StrToInt(ini.ReadString('EDGE', 'SelectedColor', '255'));
    if Assigned(DefaultEdgeProperty) then
    begin
      TFontParser.Deserializer(ini, 'EDGE', DefaultEdgeProperty);
      TFontHelper.AssignFont(textFont2, DefaultEdgeProperty.fontText);
    end;
    Draw();
  finally
    ini.free;
  end;
end;

procedure TfrmDefault.penWidthChange(Sender: TObject);
begin
  if (Sender as TSpinEdit).text <> '' then
    Draw();
end;

procedure TfrmDefault.SaveSettings;
var
  ini: TIniFile;
begin
  ini := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
  try
    ini.WriteString('NODE', 'PenWidth', InttoStr(penWidth.Value));
    ini.WriteString('NODE', 'BoxColor', InttoStr(cbBoxColor.Selected));
    ini.WriteString('NODE', 'LineColor', InttoStr(cbLineColor.Selected));
    ini.WriteString('NODE', 'SelectedColor', InttoStr(cbSelectedColor.Selected));
    ini.WriteString('NODE', 'ColorFontifImage', InttoStr(cbColorFontIfImage.Selected));
    ini.WriteString('NODE', 'ColorNodeifImage', InttoStr(cbColorNodeIfImage.Selected));
    ini.WriteString('NODE', 'ColorBorderifImage', InttoStr(cbColorBorderIfImage.Selected));

    if Assigned(DefaultNodeProperty) then
    begin
      DefaultNodeProperty.penWidth := penWidth.Value;
      DefaultNodeProperty.FillColor := cbBoxColor.Selected;
      DefaultNodeProperty.LineColor := cbLineColor.Selected;
      DefaultNodeProperty.SelectedColor := cbSelectedColor.Selected;
      TNodeProperty(DefaultNodeProperty).ColorFontifImage := cbColorFontIfImage.Selected;
      TNodeProperty(DefaultNodeProperty).ColorNodeifImage := cbColorNodeIfImage.Selected;
      TNodeProperty(DefaultNodeProperty).ColorBorderIfImage := cbColorBorderIfImage.Selected;
      DefaultNodeProperty.AssignText(textFont1);
      TFontParser.serializer(ini, 'NODE', DefaultNodeProperty.fontText);
    end;

    ini.WriteString('EDGE', 'ArrowLength', InttoStr(spArrowLength.Value));
    ini.WriteString('EDGE', 'PenWidth', InttoStr(spPenWidth.Value));
    ini.WriteString('EDGE', 'ArrowAngle', InttoStr(arrowAngle.Value));
    ini.WriteString('EDGE', 'LineColor', InttoStr(ColorBox1.Selected));
    ini.WriteString('EDGE', 'Filled', BoolToStr(chkFilled.Checked));
    ini.WriteString('EDGE', 'FillColor', InttoStr(cbFillColor.Selected));
    ini.WriteString('EDGE', 'SelectedColor', InttoStr(ColorBox2.Selected));

    if Assigned(DefaultEdgeProperty) then
    begin
      TEdgeProperty(DefaultEdgeProperty).LenArrow := spArrowLength.Value;
      DefaultEdgeProperty.penWidth := spPenWidth.Value;
      TEdgeProperty(DefaultEdgeProperty).InclinationAngle := arrowAngle.Value;
      DefaultEdgeProperty.LineColor := ColorBox1.Selected;
      DefaultEdgeProperty.Filled := chkFilled.Checked;
      DefaultEdgeProperty.FillColor := cbFillColor.Selected;
      DefaultEdgeProperty.SelectedColor := ColorBox2.Selected;
      DefaultEdgeProperty.AssignText(textFont2);
      TFontParser.serializer(ini, 'EDGE', DefaultEdgeProperty.fontText);
    end;

  finally
    ini.free;
  end;
end;

procedure TfrmDefault.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmDefault.Button3Click(Sender: TObject);
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

procedure TfrmDefault.Button4Click(Sender: TObject);
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

procedure TfrmDefault.cbBoxColorChange(Sender: TObject);
begin
  Draw();
end;

procedure TfrmDefault.chkFilledClick(Sender: TObject);
begin
  Draw();
end;

procedure TfrmDefault.drawRectangle();
begin
  if Assigned(option) then
  begin
    imgBox.Canvas.Brush.Style := bsSolid;
    imgBox.Canvas.Brush.Color := option.BackGroundProperties;
    imgBox.Canvas.Pen.width := 2;
    imgBox.Canvas.Pen.Color := clBlack;
    imgBox.Canvas.RoundRect(0, 0, imgBox.width, imgBox.height, option.RoundedIndex, option.RoundedIndex);

    imgLine.Canvas.Brush.Style := bsSolid;
    imgLine.Canvas.Brush.Color := option.BackGroundProperties;
    imgLine.Canvas.Pen.width := 2;
    imgLine.Canvas.Pen.Color := clBlack;
    imgLine.Canvas.RoundRect(0, 0, imgLine.width, imgLine.height, option.RoundedIndex, option.RoundedIndex);
  end;
end;

procedure TfrmDefault.Draw();
begin
  drawRectangle();
  if Assigned(option) then
  begin
    imgBox.Canvas.Brush.Style := bsSolid;
    imgBox.Canvas.Brush.Color := cbBoxColor.Selected;
    imgBox.Canvas.Pen.width := penWidth.Value;
    imgBox.Canvas.Brush.Color := cbBoxColor.Selected;
    imgBox.Canvas.Pen.Color := cbLineColor.Selected;
    imgBox.Canvas.RoundRect(40, 20, 90, 70, option.RoundedIndex, option.RoundedIndex);
    imgBox.Canvas.Pen.Color := cbSelectedColor.Selected;
    imgBox.Canvas.RoundRect(75, 55, 125, 105, option.RoundedIndex, option.RoundedIndex);
    TGDIText.DrawTextOrientation(imgBox.Canvas, Point(40 + 2, 20 + 1), 0, textFont1, '1', False, clwhite, False);

    DrawFashionArrow(Point(10, 30), Point(160, 30), False);
    DrawFashionArrow(Point(10, 70), Point(160, 70), true);
    TGDIText.DrawTextOrientation(imgLine.Canvas, Point(30, 10), 0, textFont2, '1', False, clwhite, False);
  end;
end;

procedure TfrmDefault.DrawFashionArrow(Source, Target: TPoint; inside: boolean);
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
begin
  angle := ArcTan2((Target.Y - Source.Y), (Target.X - Source.X));
  PArrow[1] := Target;
  PArrow[2] := CalcPoint(Target, angle + degToRad(arrowAngle.Value), spArrowLength.Value);
  PArrow[3] := CalcPoint(Target, angle, 2 * spArrowLength.Value div 3);
  PArrow[4] := CalcPoint(Target, angle - degToRad(arrowAngle.Value), spArrowLength.Value); // pi/9

  imgLine.Canvas.Pen.width := spPenWidth.Value;
  if inside then
    imgLine.Canvas.Pen.Color := ColorBox2.Selected
  else
    imgLine.Canvas.Pen.Color := ColorBox1.Selected;
  imgLine.Canvas.Brush.Style := bsSolid;
  restColor := imgLine.Canvas.Brush.Color;
  if chkFilled.Checked then
    imgLine.Canvas.Brush.Color := cbFillColor.Selected;
  imgLine.Canvas.MoveTo(Source.X, Source.Y);
  imgLine.Canvas.LineTo(Target.X, Target.Y);
  imgLine.Canvas.Polygon(PArrow);
  imgLine.Canvas.Brush.Color := restColor;
end;

end.
