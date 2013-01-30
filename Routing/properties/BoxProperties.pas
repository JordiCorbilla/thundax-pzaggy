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
unit BoxProperties;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, Spin, vlo.lib.Node, ExtDlgs, Buttons, ComCtrls,
  ImgList, vlo.lib.Node.list;

type
  TfrmBoxProp = class(TForm)
    sgVertex: TStringGrid;
    Image1: TImage;
    Image2: TImage;
    Memo1: TMemo;
    Label5: TLabel;
    FontDialog1: TFontDialog;
    edFont: TEdit;
    Button3: TButton;
    imagepath: TEdit;
    Button4: TButton;
    OpenPictureDialog1: TOpenPictureDialog;
    SpeedButton1: TSpeedButton;
    ScrollBox1: TScrollBox;
    Image3: TImage;
    sgComponents: TStringGrid;
    Label7: TLabel;
    tvNeighbour: TTreeView;
    Label10: TLabel;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    Label13: TLabel;
    ImageList1: TImageList;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    GroupBox1: TGroupBox;
    Label8: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    spMass: TSpinEdit;
    edtConnections: TEdit;
    nodeType: TEdit;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    spzOrder: TSpinEdit;
    Label6: TLabel;
    penWidth: TSpinEdit;
    Label2: TLabel;
    cbBoxColor: TColorBox;
    Label3: TLabel;
    cbLineColor: TColorBox;
    Label4: TLabel;
    cbSelectedColor: TColorBox;
    GroupBox3: TGroupBox;
    Label12: TLabel;
    cbColorfontIfImage: TColorBox;
    cbColorNodeIfImage: TColorBox;
    Label14: TLabel;
    cbColorBorderIfImage: TColorBox;
    Label15: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure sgVertexDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure sgComponentsDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure SpeedButton2Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
  private
    procedure FillImageIcon;
    procedure drawRectangle(backgroundColor, ExternalColor: TColor);
    procedure LoadTreeNeighbour;
    { Private declarations }
  public
    Node: TNode;
    nodeList: TNodeList;
    textfont: TFont;
  end;

var
  frmBoxProp: TfrmBoxProp;

implementation

uses
  vlo.lib.text, StrUtils, vlo.lib.fonts, vlo.lib.Properties.Node;

{$R *.dfm}

procedure TfrmBoxProp.Button1Click(Sender: TObject);
begin
  if AnsiContainsStr(imagepath.text, ExtractFilePath(ParamStr(0))) or (imagepath.text = '') then
    Node.Image := AnsiRightStr(imagepath.text, length(imagepath.text) - length(ExtractFilePath(ParamStr(0))))
  else
  begin
    showMessage('This is not a valid path!, it must start with' + ExtractFilePath(ParamStr(0)));
    exit;
  end;
  Node.mass := spMass.value;
  Node.vertex1 := Point(StrToInt(sgVertex.Cells[1, 1]), StrToInt(sgVertex.Cells[2, 1]));
  Node.vertex2 := Point(StrToInt(sgVertex.Cells[1, 2]), StrToInt(sgVertex.Cells[2, 2]));
  Node.vertex3 := Point(StrToInt(sgVertex.Cells[1, 3]), StrToInt(sgVertex.Cells[2, 3]));
  Node.vertex4 := Point(StrToInt(sgVertex.Cells[1, 4]), StrToInt(sgVertex.Cells[2, 4]));
  Node.Center.X := StrToFloat(sgVertex.Cells[1, 5]);
  Node.Center.Y := StrToFloat(sgVertex.Cells[2, 5]);
  Node.Properties.FillColor := cbBoxColor.Selected;
  Node.Properties.lineColor := cbLineColor.Selected;
  Node.Properties.selectedColor := cbSelectedColor.Selected;
  Node.Properties.Description.text := Memo1.lines.text;
  Node.Properties.AssignText(textfont);
  Node.Properties.penWidth := penWidth.value;
  TNodeProperty(Node.Properties).ColorFontifImage := cbColorfontIfImage.Selected;
  TNodeProperty(Node.Properties).ColorNodeifImage := cbColorNodeIfImage.Selected;
  TNodeProperty(Node.Properties).ColorBorderifImage := cbColorBorderIfImage.Selected;
  close;
end;

procedure TfrmBoxProp.Button2Click(Sender: TObject);
begin
  close;
end;

procedure TfrmBoxProp.Button3Click(Sender: TObject);
begin
  TFontHelper.AssignDialogFont(FontDialog1, Node.Properties.fontText);
  with FontDialog1 do
    if Execute then
    begin
      TFontHelper.AssignFont(textfont, Font);
      TFontHelper.AssignEditFont(edFont, textfont);
    end;
end;

procedure TfrmBoxProp.Button4Click(Sender: TObject);
var
  filename: string;
begin
  if OpenPictureDialog1.Execute then
  begin
    filename := OpenPictureDialog1.filename;
    if filename <> '' then
    begin
      imagepath.text := filename;
      Image3.Picture.Bitmap.LoadFromFile(filename);
    end;
  end;
end;

procedure TfrmBoxProp.FormCreate(Sender: TObject);
begin
  TGDIText.GradienteVertical(Image2, clwhite, clgray);
  OpenPictureDialog1.InitialDir := ExtractFilePath(ParamStr(0)) + 'resources\images';
  FillImageIcon();
end;

procedure TfrmBoxProp.FillImageIcon();
begin
  drawRectangle(clwhite, clwhite);
end;

procedure TfrmBoxProp.drawRectangle(backgroundColor, ExternalColor: TColor);
begin
  Image3.Canvas.Brush.Style := bsSolid;
  Image3.Canvas.Brush.Color := backgroundColor;
  Image3.Canvas.Pen.Width := 3;
  Image3.Canvas.Pen.Color := ExternalColor;
  Image3.Canvas.Rectangle(0, 0, 175, 75);
end;

procedure TfrmBoxProp.FormShow(Sender: TObject);
var
  ft: TFont;
  sizeText: Integer;
begin
  ft := TFont.Create;
  ft.Name := 'Calibri';
  ft.Size := 12;
  ft.Style := ft.Style + [fsBold];
  sizeText := Image2.Canvas.textWidth('Node Properties ' + Node.Id);
  TGDIText.DrawTextOrientation(Image2.Canvas, Point(1, 235 + (sizeText div 2)), 90, ft, 'Node Properties ' + Node.Id, False, clwhite, False);
  ft.free;

  spzOrder.value := TNodeProperty(Node.Properties).zOrder;
  sgVertex.Cells[0, 1] := 'Vertex 1';
  sgVertex.Cells[0, 2] := 'Vertex 2';
  sgVertex.Cells[0, 3] := 'Vertex 3';
  sgVertex.Cells[0, 4] := 'Vertex 4';
  sgVertex.Cells[0, 5] := 'Center';
  sgVertex.Cells[1, 0] := 'x';
  sgVertex.Cells[2, 0] := 'y';

  sgVertex.Cells[1, 1] := IntToStr(Node.vertex1.X);
  sgVertex.Cells[2, 1] := IntToStr(Node.vertex1.Y);

  sgVertex.Cells[1, 2] := IntToStr(Node.vertex2.X);
  sgVertex.Cells[2, 2] := IntToStr(Node.vertex2.Y);

  sgVertex.Cells[1, 3] := IntToStr(Node.vertex3.X);
  sgVertex.Cells[2, 3] := IntToStr(Node.vertex3.Y);

  sgVertex.Cells[1, 4] := IntToStr(Node.vertex4.X);
  sgVertex.Cells[2, 4] := IntToStr(Node.vertex4.Y);

  sgVertex.Cells[1, 5] := FormatFloat('#.###', Node.Center.X);
  sgVertex.Cells[2, 5] := FormatFloat('#.###', Node.Center.Y);

  sgComponents.Cells[0, 1] := 'Hooke';
  sgComponents.Cells[0, 2] := 'Coulomb';
  sgComponents.Cells[0, 3] := 'Speed';
  sgComponents.Cells[1, 0] := 'r0';
  sgComponents.Cells[2, 0] := 'r1';

  sgComponents.Cells[1, 1] := FormatFloat('#0.###', Node.HookeForce.r0);
  sgComponents.Cells[2, 1] := FormatFloat('#0.###', Node.HookeForce.r1);

  sgComponents.Cells[1, 2] := FormatFloat('#0.###', Node.CoulombForce.r0);
  sgComponents.Cells[2, 2] := FormatFloat('#0.###', Node.CoulombForce.r1);

  sgComponents.Cells[1, 3] := FormatFloat('#0.###', Node.Speed.r0);
  sgComponents.Cells[2, 3] := FormatFloat('#0.###', Node.Speed.r1);

  edtConnections.text := IntToStr(Node.connections);
  spMass.value := Round(Node.mass);

  LoadTreeNeighbour();

  cbBoxColor.Selected := Node.Properties.FillColor;
  cbLineColor.Selected := Node.Properties.lineColor;
  cbColorfontIfImage.Selected := TNodeProperty(Node.Properties).ColorFontifImage;
  cbColorNodeIfImage.Selected := TNodeProperty(Node.Properties).ColorNodeifImage;
  cbColorBorderIfImage.Selected := TNodeProperty(Node.Properties).ColorBorderifImage;
  cbSelectedColor.Selected := Node.Properties.selectedColor;
  Memo1.lines.text := Node.Properties.Description.text;

  TFontHelper.AssignEditFont(edFont, Node.Properties.fontText);

  textfont := Node.Properties.fontText;
  penWidth.value := Node.Properties.penWidth;
  nodeType.text := Node.nodeTypeToStr(Node.nodeType);
  if Node.Image <> '' then
  begin
    imagepath.text := ExtractFilePath(ParamStr(0)) + Node.Image;
    if FileExists(imagepath.text) then
      Image3.Picture.Bitmap.LoadFromFile(imagepath.text);
  end;
end;

procedure TfrmBoxProp.LoadTreeNeighbour();
var
  father, child: TTreeNode;
  i: Integer;
  NeighBourNode: TNode;
begin
  tvNeighbour.Items.Clear;
  father := tvNeighbour.Items.Add(nil, 'Node ' + Node.DefaultDescription(RadioButton2.Checked));
  father.ImageIndex := 0;
  father.SelectedIndex := 0;
  for i := 0 to Node.Neighbour.Count - 1 do
  begin
    NeighBourNode := nodeList.GetNode(Node.Neighbour[i]);
    if Assigned(NeighBourNode) then
    begin
      child := tvNeighbour.Items.AddChild(father, NeighBourNode.DefaultDescription(RadioButton2.Checked));
      child.ImageIndex := 1;
      child.SelectedIndex := 1;
    end;
  end;
  father.Expanded := true;
end;

procedure TfrmBoxProp.RadioButton2Click(Sender: TObject);
begin
  SpeedButton2.Enabled := not RadioButton2.Checked;
  LoadTreeNeighbour();
end;

procedure TfrmBoxProp.sgComponentsDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
//var
//  S: string;
//  SavedAlign: word;
begin
//  if (ACol >= 1) and (ARow >= 1) then
//  begin
//    S := sgComponents.Cells[ACol, ARow];
//    SavedAlign := SetTextAlign(sgComponents.Canvas.Handle, TA_CENTER);
//    sgComponents.Canvas.TextRect(Rect, Rect.Left + (Rect.Right - Rect.Left) div 2, Rect.Top + 2, S);
//    SetTextAlign(sgComponents.Canvas.Handle, SavedAlign);
//  end;
end;

procedure TfrmBoxProp.sgVertexDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
//var
//  S: string;
//  SavedAlign: word;
begin
//  if (ACol >= 1) and (ARow >= 1) then
//  begin
//    S := sgVertex.Cells[ACol, ARow];
//    SavedAlign := SetTextAlign(sgVertex.Canvas.Handle, TA_CENTER);
//    sgVertex.Canvas.TextRect(Rect, Rect.Left + (Rect.Right - Rect.Left) div 2, Rect.Top + 2, S);
//    SetTextAlign(sgVertex.Canvas.Handle, SavedAlign);
//  end;
end;

procedure TfrmBoxProp.SpeedButton1Click(Sender: TObject);
begin
  imagepath.text := '';
  FillImageIcon();
end;

procedure TfrmBoxProp.SpeedButton2Click(Sender: TObject);
var
  treenode: TTreeNode;
begin
  treenode := tvNeighbour.Selected;
  if not treenode.HasChildren then
  begin
    if MessageDlg('Are you sure that you want to delete this node?', mtInformation, mbOKCancel, 0) = 1 then
    begin
      Node.DeleteNeighBour(treenode.text);
      LoadTreeNeighbour();
    end;
  end;
end;

end.
