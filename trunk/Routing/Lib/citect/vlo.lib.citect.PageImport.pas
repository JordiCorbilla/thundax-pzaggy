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
unit vlo.lib.citect.PageImport;

interface

uses
  uNode, uLog;

type
  TCitectPageImport = class(TObject)
  private
    NodeList: TNodeList;
    log: TLogObject;
  public
    constructor Create(NodeList: TNodeList; log: TLogObject);
    destructor Destroy(); override;
    procedure LoadDiagram();
  end;

implementation

uses
  GraphicsBuilder_TLB, SysUtils, ComObj, Classes, Graphics;

{ TCitectPageImport }

constructor TCitectPageImport.Create(NodeList: TNodeList; log: TLogObject);
begin
  Self.NodeList := NodeList;
  Self.log := log;
end;

destructor TCitectPageImport.Destroy;
begin
  Self.NodeList := nil;
  Self.log := nil;
  inherited;
end;

procedure TCitectPageImport.LoadDiagram;
var
  Node: TNode;
  MyComObject: IGraphicsBuilder;
  notError, Error2: Boolean;
  an: Integer;
  libraryText, ElementText, textProject, PropName, PropValue: WideString;
  libObjectType: smallint;
  X, Y: Integer;
begin
  MyComObject := CoGraphicsBuilder_.Create;
  MyComObject.PageSelectFirstObject;
  notError := True;

  log.add('Importing citect objects...');
  while notError do
  begin
    sleep(100);
    try
      try
        MyComObject.LibraryObjectName(textProject, libraryText, ElementText, libObjectType);
        log.add('Project ->' + textProject);
        log.add('libraryText ->' + libraryText);
        log.add('ElementText ->' + ElementText);
        log.add('libObjectType ->' + IntToStr(libObjectType));
      except
        try
          MyComObject.PropertiesCicodeObjectGet(textProject, libraryText, ElementText);
          log.add('Project ->' + textProject);
          log.add('libraryText ->' + libraryText);
          log.add('ElementText ->' + ElementText);
        except
          //
        end;
        notError := True;

      end;

      an := MyComObject.AttributeAN;
      X := MyComObject.AttributeX;
      Y := MyComObject.AttributeY;
      Error2 := false;

      PropName := '';
      PropValue := '';
      try
        MyComObject.LibraryObjectFirstProperty(PropName, PropValue);
      except
        on E: EOleException do
          Error2 := True;
      end;
      if (PropName <> '') and (PropValue <> '') then
      begin
        if FileExists(ExtractFilePath(ParamStr(0)) + 'resources\images\' + ElementText + '.bmp') then
        begin
          Node := TNode.CreateExternal(Point(X, Y), ElementText + '.bmp');
          log.add('Creating Object -> ' + ElementText + ' with AN:' + IntToStr(an) + ' in position X:' + IntToStr(X) + 'Y:' + IntToStr(Y));
          Node.properties.Description.add('AN: ' + IntToStr(an));
          Node.properties.Description.add('TAG: ' + PropValue);
          Node.properties.FontText.Color := clWhite;
          NodeList.add(Node);
        end
        else
          log.add('Image doesn''t exists into resources -> ' + ElementText);
      end
      else
        log.add('Properties missing [Name or tag]');

      while not Error2 do
      begin
        try
          MyComObject.LibraryObjectNextProperty(PropName, PropValue);
        except
          on E: EOleException do
            Error2 := True;
        end;
      end;

      MyComObject.PageSelectNextObject;
    except
      on E: EOleException do
        notError := false;
    end;
  end;
end;

end.
