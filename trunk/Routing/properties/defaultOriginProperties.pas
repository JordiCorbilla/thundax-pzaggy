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
unit defaultOriginProperties;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Spin, vlo.lib.properties.Abstract, inifiles, vlo.lib.options, Buttons;

type
  TfrmOriginProperties = class(TForm)
    Image2: TImage;
    imgBox1: TImage;
    Label6: TLabel;
    penWidth1: TSpinEdit;
    Label2: TLabel;
    cbBoxColor1: TColorBox;
    Label3: TLabel;
    cbLineColor1: TColorBox;
    Label4: TLabel;
    cbSelectedColor1: TColorBox;
    imgBox2: TImage;
    Label1: TLabel;
    penWidth2: TSpinEdit;
    Label5: TLabel;
    cbBoxColor2: TColorBox;
    Label7: TLabel;
    cbLineColor2: TColorBox;
    Label8: TLabel;
    cbSelectedColor2: TColorBox;
    imgBox3: TImage;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    penWidth3: TSpinEdit;
    cbBoxColor3: TColorBox;
    cbLineColor3: TColorBox;
    cbSelectedColor3: TColorBox;
    edFont1: TEdit;
    Button3: TButton;
    Label13: TLabel;
    FontDialog1: TFontDialog;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    edFont2: TEdit;
    Label17: TLabel;
    edFont3: TEdit;
    Label18: TLabel;
    Button4: TButton;
    Button5: TButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    GroupBox1: TGroupBox;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    cbColorFontIfImage1: TColorBox;
    cbColorNodeIfImage1: TColorBox;
    cbColorBorderIfImage1: TColorBox;
    GroupBox2: TGroupBox;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    cbColorFontIfImage2: TColorBox;
    cbColorNodeIfImage2: TColorBox;
    cbColorBorderIfImage2: TColorBox;
    GroupBox3: TGroupBox;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    cbColorFontIfImage3: TColorBox;
    cbColorNodeIfImage3: TColorBox;
    cbColorBorderIfImage3: TColorBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbBoxColor1Change(Sender: TObject);
    procedure penWidth1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    textFont1: TFont;
    textFont2: TFont;
    textFont3: TFont;
    procedure GetSettings;
    procedure SaveSettings;
    procedure drawRectangle;
    procedure Draw;
  public
    DefaultOriginNodeProperty: TAbstractProperty;
    DefaultDestinyNodeProperty: TAbstractProperty;
    DefaultLinkNodeProperty: TAbstractProperty;
    option: TOptionsApplication;
  end;

var
  frmOriginProperties: TfrmOriginProperties;

implementation

uses
  vlo.lib.text, vlo.lib.Math, Math, vlo.lib.font.serializer, vlo.lib.fonts, vlo.lib.properties.Node, types;

{$R *.dfm}
{ TfrmOriginProperties }

procedure TfrmOriginProperties.Button1Click(Sender: TObject);
begin
  SaveSettings;
  Close;
end;

procedure TfrmOriginProperties.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmOriginProperties.Button3Click(Sender: TObject);
begin
  TFontHelper.AssignDialogFont(FontDialog1, DefaultOriginNodeProperty.fontText);
  with FontDialog1 do
    if Execute then
    begin
      TFontHelper.AssignFont(textFont1, font);
      TFontHelper.AssignEditFont(edFont1, textFont1);
      Draw();
    end;
end;

procedure TfrmOriginProperties.Button4Click(Sender: TObject);
begin
  TFontHelper.AssignDialogFont(FontDialog1, DefaultDestinyNodeProperty.fontText);
  with FontDialog1 do
    if Execute then
    begin
      TFontHelper.AssignFont(textFont2, font);
      TFontHelper.AssignEditFont(edFont2, textFont2);
      Draw();
    end;
end;

procedure TfrmOriginProperties.Button5Click(Sender: TObject);
begin
  TFontHelper.AssignDialogFont(FontDialog1, DefaultLinkNodeProperty.fontText);
  with FontDialog1 do
    if Execute then
    begin
      TFontHelper.AssignFont(textFont3, font);
      TFontHelper.AssignEditFont(edFont3, textFont3);
      Draw();
    end;
end;

procedure TfrmOriginProperties.cbBoxColor1Change(Sender: TObject);
begin
  Draw();
end;

procedure TfrmOriginProperties.Draw;
begin
  drawRectangle();
  if Assigned(option) then
  begin
    imgBox1.Canvas.Brush.Style := bsSolid;
    imgBox1.Canvas.Brush.Color := cbBoxColor1.Selected;
    imgBox1.Canvas.Pen.width := penWidth1.Value;
    imgBox1.Canvas.Brush.Color := cbBoxColor1.Selected;
    imgBox1.Canvas.Pen.Color := cbLineColor1.Selected;
    imgBox1.Canvas.RoundRect(40, 20, 90, 70, option.RoundedIndex, option.RoundedIndex);
    imgBox1.Canvas.Pen.Color := cbSelectedColor1.Selected;
    imgBox1.Canvas.RoundRect(75, 55, 125, 105, option.RoundedIndex, option.RoundedIndex);
    TGDIText.DrawTextOrientation(imgBox1.Canvas, Point(40 + 2, 20 + 1), 0, textFont1, '1', false, clwhite, false);

    imgBox2.Canvas.Brush.Style := bsSolid;
    imgBox2.Canvas.Brush.Color := cbBoxColor2.Selected;
    imgBox2.Canvas.Pen.width := penWidth2.Value;
    imgBox2.Canvas.Brush.Color := cbBoxColor2.Selected;
    imgBox2.Canvas.Pen.Color := cbLineColor2.Selected;
    imgBox2.Canvas.RoundRect(40, 20, 90, 70, option.RoundedIndex, option.RoundedIndex);
    imgBox2.Canvas.Pen.Color := cbSelectedColor2.Selected;
    imgBox2.Canvas.RoundRect(75, 55, 125, 105, option.RoundedIndex, option.RoundedIndex);
    TGDIText.DrawTextOrientation(imgBox2.Canvas, Point(40 + 2, 20 + 1), 0, textFont2, '1', false, clwhite, false);

    imgBox3.Canvas.Brush.Style := bsSolid;
    imgBox3.Canvas.Brush.Color := cbBoxColor3.Selected;
    imgBox3.Canvas.Pen.width := penWidth3.Value;
    imgBox3.Canvas.Brush.Color := cbBoxColor3.Selected;
    imgBox3.Canvas.Pen.Color := cbLineColor3.Selected;
    imgBox3.Canvas.RoundRect(40, 20, 90, 70, option.RoundedIndex, option.RoundedIndex);
    imgBox3.Canvas.Pen.Color := cbSelectedColor3.Selected;
    imgBox3.Canvas.RoundRect(75, 55, 125, 105, option.RoundedIndex, option.RoundedIndex);
    TGDIText.DrawTextOrientation(imgBox3.Canvas, Point(40 + 2, 20 + 1), 0, textFont3, '1', false, clwhite, false);
  end;
end;

procedure TfrmOriginProperties.drawRectangle;
begin
  if Assigned(option) then
  begin
    imgBox1.Canvas.Brush.Style := bsSolid;
    imgBox1.Canvas.Brush.Color := option.BackGroundProperties;
    imgBox1.Canvas.Pen.width := 2;
    imgBox1.Canvas.Pen.Color := clBlack;
    imgBox1.Canvas.RoundRect(0, 0, imgBox1.width, imgBox1.height, option.RoundedIndex, option.RoundedIndex);

    imgBox2.Canvas.Brush.Style := bsSolid;
    imgBox2.Canvas.Brush.Color := option.BackGroundProperties;
    imgBox2.Canvas.Pen.width := 2;
    imgBox2.Canvas.Pen.Color := clBlack;
    imgBox2.Canvas.RoundRect(0, 0, imgBox2.width, imgBox2.height, option.RoundedIndex, option.RoundedIndex);

    imgBox3.Canvas.Brush.Style := bsSolid;
    imgBox3.Canvas.Brush.Color := option.BackGroundProperties;
    imgBox3.Canvas.Pen.width := 2;
    imgBox3.Canvas.Pen.Color := clBlack;
    imgBox3.Canvas.RoundRect(0, 0, imgBox3.width, imgBox3.height, option.RoundedIndex, option.RoundedIndex);
  end;
end;

procedure TfrmOriginProperties.FormCreate(Sender: TObject);
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

  textFont1 := TFont.Create;
  textFont1.Name := 'Calibri';
  textFont1.Size := 12;
  textFont2 := TFont.Create;
  textFont2.Name := 'Calibri';
  textFont2.Size := 12;
  textFont3 := TFont.Create;
  textFont3.Name := 'Calibri';
  textFont3.Size := 12;

  sizeText := Image2.Canvas.textWidth('Default Origin, Destiny Properties');
  TGDIText.DrawTextOrientation(Image2.Canvas, Point(1, 120 + (sizeText div 2)), 90, ft, 'Default Origin, Destiny Properties', false, clwhite, false);
  ft.free;
  GetSettings;
end;

procedure TfrmOriginProperties.FormDestroy(Sender: TObject);
begin
  textFont1.free;
  textFont2.free;
  textFont3.free;
end;

procedure TfrmOriginProperties.FormShow(Sender: TObject);
begin
  GetSettings();
  TFontHelper.AssignEditFont(edFont1, DefaultOriginNodeProperty.fontText);
  TFontHelper.AssignEditFont(edFont2, DefaultDestinyNodeProperty.fontText);
  TFontHelper.AssignEditFont(edFont3, DefaultLinkNodeProperty.fontText);
end;

procedure TfrmOriginProperties.GetSettings;
var
  ini: TIniFile;
begin
  ini := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
  try
    penWidth1.Value := StrToInt(ini.ReadString('ORIGINNODE', 'PenWidth', '4'));
    cbBoxColor1.Selected := StrToInt(ini.ReadString('ORIGINNODE', 'BoxColor', '458496'));
    cbLineColor1.Selected := StrToInt(ini.ReadString('ORIGINNODE', 'LineColor', '0'));
    cbSelectedColor1.Selected := StrToInt(ini.ReadString('ORIGINNODE', 'SelectedColor', '255'));
    cbColorFontIfImage1.Selected := StrToInt(ini.ReadString('ORIGINNODE', 'ColorFontifImage', '255'));
    cbColorNodeIfImage1.Selected := StrToInt(ini.ReadString('ORIGINNODE', 'ColorNodeifImage', '255'));
    cbColorBorderIfImage1.Selected := StrToInt(ini.ReadString('ORIGINNODE', 'ColorBorderifImage', '255'));
    if Assigned(DefaultOriginNodeProperty) then
    begin
      TFontParser.Deserializer(ini, 'ORIGINNODE', DefaultOriginNodeProperty);
      TFontHelper.AssignFont(textFont1, DefaultOriginNodeProperty.fontText);
    end;

    penWidth2.Value := StrToInt(ini.ReadString('DESTINYNODE', 'PenWidth', '4'));
    cbBoxColor2.Selected := StrToInt(ini.ReadString('DESTINYNODE', 'BoxColor', '16318719'));
    cbLineColor2.Selected := StrToInt(ini.ReadString('DESTINYNODE', 'LineColor', '0'));
    cbSelectedColor2.Selected := StrToInt(ini.ReadString('DESTINYNODE', 'SelectedColor', '255'));
    cbColorFontIfImage2.Selected := StrToInt(ini.ReadString('DESTINYNODE', 'ColorFontifImage', '255'));
    cbColorNodeIfImage2.Selected := StrToInt(ini.ReadString('DESTINYNODE', 'ColorNodeifImage', '255'));
    cbColorBorderIfImage2.Selected := StrToInt(ini.ReadString('DESTINYNODE', 'ColorBorderifImage', '255'));
    if Assigned(DefaultDestinyNodeProperty) then
    begin
      TFontParser.Deserializer(ini, 'DESTINYNODE', DefaultDestinyNodeProperty);
      TFontHelper.AssignFont(textFont2, DefaultDestinyNodeProperty.fontText);
    end;

    penWidth3.Value := StrToInt(ini.ReadString('LINKNODE', 'PenWidth', '4'));
    cbBoxColor3.Selected := StrToInt(ini.ReadString('LINKNODE', 'BoxColor', '33023'));
    cbLineColor3.Selected := StrToInt(ini.ReadString('LINKNODE', 'LineColor', '0'));
    cbSelectedColor3.Selected := StrToInt(ini.ReadString('LINKNODE', 'SelectedColor', '255'));
    cbColorFontIfImage3.Selected := StrToInt(ini.ReadString('LINKNODE', 'ColorFontifImage', '255'));
    cbColorNodeIfImage3.Selected := StrToInt(ini.ReadString('LINKNODE', 'ColorNodeifImage', '255'));
    cbColorBorderIfImage3.Selected := StrToInt(ini.ReadString('LINKNODE', 'ColorBorderifImage', '255'));
    if Assigned(DefaultLinkNodeProperty) then
    begin
      TFontParser.Deserializer(ini, 'LINKNODE', DefaultLinkNodeProperty);
      TFontHelper.AssignFont(textFont3, DefaultLinkNodeProperty.fontText);
    end;

    Draw();
  finally
    ini.free;
  end;
end;

procedure TfrmOriginProperties.penWidth1Change(Sender: TObject);
begin
  if (Sender as TSpinEdit).text <> '' then
    Draw();
end;

procedure TfrmOriginProperties.SaveSettings;
var
  ini: TIniFile;
begin
  ini := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
  try
    ini.WriteString('ORIGINNODE', 'PenWidth', InttoStr(penWidth1.Value));
    ini.WriteString('ORIGINNODE', 'BoxColor', InttoStr(cbBoxColor1.Selected));
    ini.WriteString('ORIGINNODE', 'LineColor', InttoStr(cbLineColor1.Selected));
    ini.WriteString('ORIGINNODE', 'SelectedColor', InttoStr(cbSelectedColor1.Selected));
    ini.WriteString('ORIGINNODE', 'ColorFontifImage', InttoStr(cbColorFontIfImage1.Selected));
    ini.WriteString('ORIGINNODE', 'ColorNodeifImage', InttoStr(cbColorNodeIfImage1.Selected));
    ini.WriteString('ORIGINNODE', 'ColorBorderifImage', InttoStr(cbColorBorderIfImage1.Selected));

    if Assigned(DefaultOriginNodeProperty) then
    begin
      DefaultOriginNodeProperty.penWidth := penWidth1.Value;
      DefaultOriginNodeProperty.FillColor := cbBoxColor1.Selected;
      DefaultOriginNodeProperty.LineColor := cbLineColor1.Selected;
      DefaultOriginNodeProperty.SelectedColor := cbSelectedColor1.Selected;
      TNodeProperty(DefaultOriginNodeProperty).ColorFontifImage := cbColorFontIfImage1.Selected;
      TNodeProperty(DefaultOriginNodeProperty).ColorNodeifImage := cbColorNodeIfImage1.Selected;
      TNodeProperty(DefaultOriginNodeProperty).ColorBorderIfImage := cbColorBorderIfImage1.Selected;
      DefaultOriginNodeProperty.AssignText(textFont1);
      TFontParser.serializer(ini, 'ORIGINNODE', DefaultOriginNodeProperty.fontText);
    end;

    ini.WriteString('DESTINYNODE', 'PenWidth', InttoStr(penWidth2.Value));
    ini.WriteString('DESTINYNODE', 'BoxColor', InttoStr(cbBoxColor2.Selected));
    ini.WriteString('DESTINYNODE', 'LineColor', InttoStr(cbLineColor2.Selected));
    ini.WriteString('DESTINYNODE', 'SelectedColor', InttoStr(cbSelectedColor2.Selected));
    ini.WriteString('DESTINYNODE', 'ColorFontifImage', InttoStr(cbColorFontIfImage2.Selected));
    ini.WriteString('DESTINYNODE', 'ColorNodeifImage', InttoStr(cbColorNodeIfImage2.Selected));
    ini.WriteString('DESTINYNODE', 'ColorBorderifImage', InttoStr(cbColorBorderIfImage2.Selected));

    if Assigned(DefaultDestinyNodeProperty) then
    begin
      DefaultDestinyNodeProperty.penWidth := penWidth2.Value;
      DefaultDestinyNodeProperty.FillColor := cbBoxColor2.Selected;
      DefaultDestinyNodeProperty.LineColor := cbLineColor2.Selected;
      DefaultDestinyNodeProperty.SelectedColor := cbSelectedColor2.Selected;
      TNodeProperty(DefaultDestinyNodeProperty).ColorFontifImage := cbColorFontIfImage2.Selected;
      TNodeProperty(DefaultDestinyNodeProperty).ColorNodeifImage := cbColorNodeIfImage2.Selected;
      TNodeProperty(DefaultDestinyNodeProperty).ColorBorderIfImage := cbColorBorderIfImage2.Selected;
      DefaultDestinyNodeProperty.AssignText(textFont2);
      TFontParser.serializer(ini, 'DESTINYNODE', DefaultDestinyNodeProperty.fontText);
    end;

    ini.WriteString('LINKNODE', 'PenWidth', InttoStr(penWidth3.Value));
    ini.WriteString('LINKNODE', 'BoxColor', InttoStr(cbBoxColor3.Selected));
    ini.WriteString('LINKNODE', 'LineColor', InttoStr(cbLineColor3.Selected));
    ini.WriteString('LINKNODE', 'SelectedColor', InttoStr(cbSelectedColor3.Selected));
    ini.WriteString('LINKNODE', 'ColorFontifImage', InttoStr(cbColorFontIfImage3.Selected));
    ini.WriteString('LINKNODE', 'ColorNodeifImage', InttoStr(cbColorNodeIfImage3.Selected));
    ini.WriteString('LINKNODE', 'ColorBorderifImage', InttoStr(cbColorBorderIfImage3.Selected));

    if Assigned(DefaultLinkNodeProperty) then
    begin
      DefaultLinkNodeProperty.penWidth := penWidth3.Value;
      DefaultLinkNodeProperty.FillColor := cbBoxColor3.Selected;
      DefaultLinkNodeProperty.LineColor := cbLineColor3.Selected;
      DefaultLinkNodeProperty.SelectedColor := cbSelectedColor3.Selected;
      TNodeProperty(DefaultLinkNodeProperty).ColorFontifImage := cbColorFontIfImage3.Selected;
      TNodeProperty(DefaultLinkNodeProperty).ColorNodeifImage := cbColorNodeIfImage3.Selected;
      TNodeProperty(DefaultLinkNodeProperty).ColorBorderIfImage := cbColorBorderIfImage3.Selected;
      DefaultLinkNodeProperty.AssignText(textFont3);
      TFontParser.serializer(ini, 'LINKNODE', DefaultLinkNodeProperty.fontText);
    end;

  finally
    ini.free;
  end;
end;

end.
