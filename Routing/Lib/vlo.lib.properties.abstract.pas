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
unit vlo.lib.properties.abstract;

interface

uses
  uCLoner, uXMLSerializer, XMLDoc, XMLIntf, Graphics, Classes;

type
  TAbstractProperty = class(TInterfacedObject, ISerializable, IAssignable)
  private
    FFillColor: TColor;
    FLineColor: TColor;
    FSelectedColor: TColor;
    FFontText: TFont;
    FFilled: boolean;
    FDescription: TStringList;
    FpenWidth: integer;
    procedure SetDescription(const Value: TStringList);
    procedure SetFillColor(const Value: TColor);
    procedure SetFilled(const Value: boolean);
    procedure SetFontText(const Value: TFont);
    procedure SetLineColor(const Value: TColor);
    procedure SetSelectedColor(const Value: TColor);
    procedure SetpenWidth(const Value: integer);
  public
    property penWidth: integer read FpenWidth write SetpenWidth;
    property Description: TStringList read FDescription write SetDescription;
    property FillColor: TColor read FFillColor write SetFillColor;
    property LineColor: TColor read FLineColor write SetLineColor;
    property Filled: boolean read FFilled write SetFilled;
    property SelectedColor: TColor read FSelectedColor write SetSelectedColor;
    property FontText: TFont read FFontText write SetFontText;
    function MarshalToXML(XMLDoc: IXMLDocument; iXMLRootNode: IXMLNode; sNode: string): IXMLNode; virtual;
    function UnMarshalFromXML(XMLDoc: IXMLDocument; iXMLRootNode: IXMLNode; sNode: string): IXMLNode; virtual;
    procedure Assign(obj: TObject); virtual;
    function getText(): string;
    constructor Create();
    procedure AssignText(FontText: TFont);
    destructor Destroy(); override;
  end;

implementation

uses
  SysUtils, StrUtils, Variants;

{ TAbstractProperty }

procedure TAbstractProperty.Assign(obj: TObject);
var
  absObj: TAbstractProperty;
begin
  absObj := (obj as TAbstractProperty);
  Self.FFillColor := absObj.FillColor;
  Self.FLineColor := absObj.FLineColor;
  Self.FSelectedColor := absObj.FSelectedColor;
  Self.FFontText.Name := absObj.FFontText.Name;
  Self.FFontText.Size := absObj.FFontText.Size;
  Self.FFontText.Color := absObj.FFontText.Color;
  Self.FFontText.Style := absObj.FFontText.Style;
  Self.FFilled := absObj.FFilled;
  if Self.FDescription.Text = '' then
    Self.FDescription.Text := absObj.Description.Text;
  Self.FpenWidth := absObj.penWidth;
end;

procedure TAbstractProperty.AssignText(FontText: TFont);
begin
  Self.FFontText.Name := FontText.Name;
  Self.FFontText.Size := FontText.Size;
  Self.FFontText.Style := FontText.Style;
  Self.FFontText.Color := FontText.Color;
end;

constructor TAbstractProperty.Create;
begin
  FFilled := false;
  FFillColor := clWhite;
  FLineColor := clBlack;
  FSelectedColor := clRed;
  FDescription := TStringList.Create;
  FFontText := TFont.Create;
  FFontText.Name := 'Calibri';
  FFontText.Size := 12;
  FpenWidth := 1;
end;

destructor TAbstractProperty.Destroy;
begin
  FreeAndNil(FFontText);
  FreeAndNil(FDescription);
  inherited;
end;

function TAbstractProperty.getText: string;
begin
  result := AnsiReplaceStr(FDescription.Text, sLineBreak, '');
end;

function TAbstractProperty.MarshalToXML(XMLDoc: IXMLDocument; iXMLRootNode: IXMLNode; sNode: string): IXMLNode;
begin
  iXMLRootNode.attributes['FFilled'] := BoolToStr(Self.FFilled);
  iXMLRootNode.attributes['FLineColor'] := IntToStr(Self.FLineColor);
  iXMLRootNode.attributes['FSelectedColor'] := IntToStr(Self.FSelectedColor);
  iXMLRootNode.attributes['FFillColor'] := IntToStr(Self.FFillColor);
  iXMLRootNode.attributes['FDescription'] := Self.FDescription.Text;
  iXMLRootNode.attributes['FPenWidth'] := IntToStr(Self.FpenWidth);
  FontSerializer(Self.FFontText, XMLDoc, iXMLRootNode, 'Font');
end;

procedure TAbstractProperty.SetDescription(const Value: TStringList);
begin
  FDescription := Value;
end;

procedure TAbstractProperty.SetFillColor(const Value: TColor);
begin
  FFillColor := Value;
end;

procedure TAbstractProperty.SetFilled(const Value: boolean);
begin
  FFilled := Value;
end;

procedure TAbstractProperty.SetFontText(const Value: TFont);
begin
  FFontText := Value;
end;

procedure TAbstractProperty.SetLineColor(const Value: TColor);
begin
  FLineColor := Value;
end;

procedure TAbstractProperty.SetpenWidth(const Value: integer);
begin
  FpenWidth := Value;
end;

procedure TAbstractProperty.SetSelectedColor(const Value: TColor);
begin
  FSelectedColor := Value;
end;

function TAbstractProperty.UnMarshalFromXML(XMLDoc: IXMLDocument; iXMLRootNode: IXMLNode; sNode: string): IXMLNode;
begin
  Self.FFilled := StrToBool(iXMLRootNode.attributes['FFilled']);
  Self.FLineColor := StrToInt(iXMLRootNode.attributes['FLineColor']);
  Self.FSelectedColor := StrToInt(iXMLRootNode.attributes['FSelectedColor']);
  Self.FFillColor := StrToInt(iXMLRootNode.attributes['FFillColor']);
  Self.FDescription.Text := iXMLRootNode.attributes['FDescription'];
  Self.FpenWidth := StrToInt(iXMLRootNode.attributes['FPenWidth']);
  FontDeserializer(Self.FFontText, XMLDoc, iXMLRootNode, 'Font');
end;

end.
