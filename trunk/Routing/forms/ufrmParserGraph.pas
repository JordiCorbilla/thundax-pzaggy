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
unit ufrmParserGraph;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, vlo.lib.Graph, vlo.lib.Node, vlo.lib.Edge, SynEdit, SynEditHighlighter,
  SynHighlighterGeneral, Buttons, ExtCtrls, SynHighlighterJava, ComCtrls;

type
  TArg<T> = reference to procedure(const Arg: T);

type
  TfrmParserGraph = class(TForm)
    Memo2: TMemo;
    Memo1: TSynEdit;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SynGeneralSyn1: TSynGeneralSyn;
    StatusBar1: TStatusBar;
    Splitter1: TSplitter;
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Memo1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SpeedButton1Click(Sender: TObject);
    procedure CaptureConsoleOutput(const ACommand, AParameters: String; CallBack: TArg<PAnsiChar>);
    procedure SpeedButton4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure SetupBox(var box: TNode; id: string);
    function GetTypeByName(name: string): TTypeEdge;
    procedure SaveToFile;
    { Private declarations }
  public
    boxManager: TGraph;
  end;

var
  frmParserGraph: TfrmParserGraph;

implementation

uses
  vlo.lib.parser, vlo.lib.Connector, Clipbrd, StrUtils, vlo.lib.Edge.Abstract, vlo.lib.properties.Node, vlo.lib.properties.Edge;

{$R *.dfm}

procedure TfrmParserGraph.Button1Click(Sender: TObject);
var
  i: Integer;
  stringList: TStringList;
  box1, box2: TNode;
  id1, id2: string;
  Conn: TConnector;
  concept: TAbstractEdge;
begin
  for i := 0 to Memo1.Lines.count - 1 do
  begin
    stringList := TStringList.Create;
    TLineParser.Split(Memo1.Lines[i], ' ', stringList);
    if stringList.count = 2 then
    begin
      id1 := stringList[0];
      id2 := stringList[1];
      box1 := boxManager.nodeList.GetNodeByDescription(id1);
      if not Assigned(box1) then
      begin
        box1 := TNode.Create();
        box1.Properties.Description.Text := id1;
        box1.Vertex1 := Point(random(boxManager.Image.Width), random(boxManager.Image.Height));
        box1.Vertex2 := Point(box1.Vertex1.X + 20, box1.Vertex1.Y + 20);
        box1.CalcCenter;
        TNodeProperty(box1.Properties).zOrder := 999999;
        box1.CalcPoints;
        box1.Properties.Assign(boxManager.FDefaultNodeProperty);
        boxManager.nodeList.Add(box1);
        boxManager.nodeList.Sort(@Compare);
      end;
      box2 := boxManager.nodeList.GetNodeByDescription(id2);
      if not Assigned(box2) then
      begin
        box2 := TNode.Create();
        box2.Properties.Description.Text := id2;
        box2.Vertex1 := Point(random(boxManager.Image.Width), random(boxManager.Image.Height));
        box2.Vertex2 := Point(box2.Vertex1.X + 20, box2.Vertex1.Y + 20);
        box2.CalcCenter;
        TNodeProperty(box2.Properties).zOrder := 999999;
        box2.CalcPoints;
        box2.Properties.Assign(boxManager.FDefaultNodeProperty);
        boxManager.nodeList.Add(box2);
        boxManager.nodeList.Sort(@Compare);
      end;
      if not boxManager.ConnectorList.existConnection(box1, box2) then
      begin
        concept := boxManager.getLineFactory(SimpleEdge);
        Conn := TConnector.Create(box1, box2, concept);
        boxManager.ConnectorList.Add(Conn);
        box1.AddNeighBour(box2.id);
        box2.AddNeighBour(box1.id);
      end;
    end;
    FreeAndNil(stringList);
  end;
  boxManager.Draw;
  close;
end;

function TfrmParserGraph.GetTypeByName(name: string): TTypeEdge;
begin
  if AnsiUpperCase(name) = AnsiUpperCase('SimpleEdge') then
    result := SimpleEdge
  else if AnsiUpperCase(name) = AnsiUpperCase('SimpleArrowEdge') then
    result := SimpleArrowEdge
  else if AnsiUpperCase(name) = AnsiUpperCase('SimpleDoubleArrowEdge') then
    result := SimpleDoubleArrowEdge
  else if AnsiUpperCase(name) = AnsiUpperCase('SimpleDoubleLinkedArrowEdge') then
    result := SimpleDoubleLinkedArrowEdge
  else if AnsiUpperCase(name) = AnsiUpperCase('DottedEdge') then
    result := DottedEdge
  else if AnsiUpperCase(name) = AnsiUpperCase('DottedArrowEdge') then
    result := DottedArrowEdge
  else if AnsiUpperCase(name) = AnsiUpperCase('DottedDoubleArrowEdge') then
    result := DottedDoubleArrowEdge
  else if AnsiUpperCase(name) = AnsiUpperCase('DottedDoubleLinkedArrowEdge') then
    result := DottedDoubleLinkedArrowEdge
  else
    result := noEdge;
end;

procedure TfrmParserGraph.Memo1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  lefttext, rightText, copymemory: string;
begin
  if ssCtrl in Shift then
  begin
    if Key = 67 then
    begin
      Clipboard.AsText := Memo1.SelText;
    end;
    if Key = 86 then
    begin
      copymemory := Clipboard.AsText;
      if copymemory <> '' then
      begin
        lefttext := AnsiLeftStr(Memo1.Text, Memo1.SelStart);
        rightText := AnsiRightStr(Memo1.Text, Length(Memo1.Text) - Memo1.SelEnd);
        Memo1.Text := lefttext + copymemory + rightText;
        Memo1.SelStart := Length(Memo1.Text);
        Memo1.SelEnd := Length(Memo1.Text);
        // layout.node(1).toNode(2).parameters := [TLineNode, TNode];
      end;
    end;
  end;
  StatusBar1.Panels[0].Text := Format('Line: %.0d Pos: %.0d', [Memo1.CaretY, Memo1.CaretX]);
end;

procedure TfrmParserGraph.Button3Click(Sender: TObject);
var
  i: Integer;
  s, Palabra, PrevWord: string;
  node1, node2, isFinal, params, isEdge, isSizeBox, isLineColor, isPenwidth: boolean;
  box1, box2: TNode;
  Conn: TConnector;
  concept: TAbstractEdge;
  isLayout: boolean;
begin
  (*
    Example

    layout.node(1).ToNode(2).parameters := [EdgeType = SimpleArrowEdge, SizeBox = 20, LineColor = clRed, PenWidth = 2];

  *)

  for i := 0 to Memo1.Lines.count - 1 do
  begin
    node1 := false;
    node2 := false;
    params := false;
    isEdge := false;
    isSizeBox := false;
    isLineColor := false;
    isPenwidth := false;
    box1 := nil;
    box2 := nil;
    s := Memo1.Lines[i];
    concept := nil;
    isLayout := false;
    Palabra := TLineParser.NextWord(s, PrevWord, isFinal);
    while Palabra <> '' do
    begin
      if TLineParser.IsKeyWord(Palabra) then
      begin
        if AnsiUpperCase(Palabra) = 'LAYOUT' then
          isLayout := true;
        if isLayout then
        begin
          if AnsiUpperCase(Palabra) = 'NODE' then
            node1 := true;
          if AnsiUpperCase(Palabra) = 'TONODE' then
            node2 := true;
          if AnsiUpperCase(Palabra) = 'PARAMETERS' then
            params := true;
          if AnsiUpperCase(Palabra) = AnsiUpperCase('EdgeType') then
            isEdge := true;
          if AnsiUpperCase(Palabra) = AnsiUpperCase('SizeBox') then
            isSizeBox := true;
          if AnsiUpperCase(Palabra) = AnsiUpperCase('LineColor') then
            isLineColor := true;
          if AnsiUpperCase(Palabra) = AnsiUpperCase('PenWidth') then
            isPenwidth := true;
          if params then
          begin
            if isEdge then
            begin
              if GetTypeByName(Palabra) <> noEdge then
              begin
                concept := boxManager.getLineFactory(GetTypeByName(Palabra));
                isEdge := false;
              end;
            end;
            if isLineColor then
            begin
              if AnsiUpperCase(Palabra) <> AnsiUpperCase('LineColor') then
              begin
                if Assigned(concept) then
                  concept.Properties.LineColor := StringToColor(Palabra);
                isLineColor := false;
              end;
            end;
          end;
        end;
      end
      else if TLineParser.IsNumber(Palabra) then
      begin
        if node1 then
        begin
          box1 := boxManager.nodeList.GetNodeByDescription(Palabra);
          SetupBox(box1, Palabra);
          node1 := false;
        end;
        if node2 then
        begin
          box2 := boxManager.nodeList.GetNodeByDescription(Palabra);
          SetupBox(box2, Palabra);
          node2 := false;
        end;
        if params then
        begin
          if isSizeBox then
          begin
            if Assigned(box1) then
            begin
              box1.Vertex2 := Point(box1.Vertex1.X + strtoint(Palabra), box1.Vertex1.Y + strtoint(Palabra));
              box1.CalcCenter;
              TNodeProperty(box1.Properties).zOrder := 999999;
              box1.CalcPoints;
            end;
            if Assigned(box2) then
            begin
              box2.Vertex2 := Point(box2.Vertex1.X + strtoint(Palabra), box2.Vertex1.Y + strtoint(Palabra));
              box2.CalcCenter;
              TNodeProperty(box2.Properties).zOrder := 999999;
              box2.CalcPoints;
            end;
            isSizeBox := false;
          end;
          if isPenwidth then
          begin
            if Assigned(concept) then
              concept.Properties.penWidth := strtoint(Palabra);
            isPenwidth := false;
          end;
        end;
      end
      else
      begin

      end;
      Palabra := TLineParser.NextWord(s, PrevWord, isFinal);
    end;
    if isFinal then
    begin
      if Assigned(box1) and Assigned(box2) then
      begin
        if not boxManager.ConnectorList.existConnection(box1, box2) then
        begin
          if not Assigned(concept) then
            concept := boxManager.getLineFactory(SimpleEdge);
          if box1.id = box2.id then
          begin
            concept.FBendPoint[0] := Point(Round(box1.Center.X), Round((box1.Center.Y - (box1.Center.Y - box1.Vertex1.Y) - (box1.Center.Y - box1.Vertex1.Y))));
            concept.FBendPoint[1] := Point(Round(box1.Center.X + (box1.Vertex2.X - box1.Center.X) + (box1.Vertex2.X - box1.Center.X)),
              Round((box1.Center.Y - (box1.Center.Y - box1.Vertex1.Y) - (box1.Center.Y - box1.Vertex1.Y))));
            concept.FBendPoint[2] := Point(Round(box1.Center.X + (box1.Vertex2.X - box1.Center.X) + (box1.Vertex2.X - box1.Center.X)), Round(box1.Center.Y));
            concept.FBendModified[0] := true;
            concept.FBendModified[1] := true;
            concept.FBendModified[2] := true;
          end;
          Conn := TConnector.Create(box1, box2, concept);
          boxManager.ConnectorList.Add(Conn);
          box1.AddNeighBour(box2.id);
          box2.AddNeighBour(box1.id);
        end;
      end;
      isFinal := false;
    end;
  end;
  boxManager.Draw;
  close;
end;

procedure TfrmParserGraph.CaptureConsoleOutput(const ACommand, AParameters: String; CallBack: TArg<PAnsiChar>);
const
  CReadBuffer = 2400;
var
  saSecurity: TSecurityAttributes;
  hRead: THandle;
  hWrite: THandle;
  suiStartup: TStartupInfo;
  piProcess: TProcessInformation;
  pBuffer: array [0 .. CReadBuffer] of AnsiChar;
  dBuffer: array [0 .. CReadBuffer] of AnsiChar;
  dRead: DWord;
  dRunning: DWord;
begin
  saSecurity.nLength := SizeOf(TSecurityAttributes);
  saSecurity.bInheritHandle := true;
  saSecurity.lpSecurityDescriptor := nil;

  if CreatePipe(hRead, hWrite, @saSecurity, 0) then
  begin
    FillChar(suiStartup, SizeOf(TStartupInfo), #0);
    suiStartup.cb := SizeOf(TStartupInfo);
    suiStartup.hStdInput := hRead;
    suiStartup.hStdOutput := hWrite;
    suiStartup.hStdError := hWrite;
    suiStartup.dwFlags := STARTF_USESTDHANDLES or STARTF_USESHOWWINDOW;
    suiStartup.wShowWindow := SW_HIDE;

    if CreateProcess(nil, pChar(ACommand + ' ' + AParameters), @saSecurity, @saSecurity, true, NORMAL_PRIORITY_CLASS, nil, nil, suiStartup, piProcess) then
    begin
      repeat
        dRunning := WaitForSingleObject(piProcess.hProcess, 100);
        Application.ProcessMessages();
        repeat
          dRead := 0;
          ReadFile(hRead, pBuffer[0], CReadBuffer, dRead, nil);
          pBuffer[dRead] := #0;
          OemToCharA(pBuffer, dBuffer);
          CallBack(dBuffer);
        until (dRead < CReadBuffer);
      until (dRunning <> WAIT_TIMEOUT);
      CloseHandle(piProcess.hProcess);
      CloseHandle(piProcess.hThread);
    end;
    CloseHandle(hRead);
    CloseHandle(hWrite);
  end;
end;

procedure TfrmParserGraph.FormCreate(Sender: TObject);
begin
  // if FileExists(ExtractFilePath(ParamStr(0)) + 'graph.pzy') then
  // begin
  // Memo1.Lines.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'graph.pzy');
  // end;
end;

procedure TfrmParserGraph.SetupBox(var box: TNode; id: string);
begin
  if not Assigned(box) then
  begin
    box := TNode.Create();
    box.options := boxManager.options;
    box.Properties.Description.Text := id;
    box.Vertex1 := Point(random(boxManager.Image.Width), random(boxManager.Image.Height));
    box.Vertex2 := Point(box.Vertex1.X + 20, box.Vertex1.Y + 20);
    box.CalcCenter;
    TNodeProperty(box.Properties).zOrder := 999999;
    box.CalcPoints;
    box.Properties.Assign(boxManager.FDefaultNodeProperty);
    boxManager.nodeList.Add(box);
    boxManager.nodeList.Sort(@Compare);
  end;
end;

procedure TfrmParserGraph.SpeedButton1Click(Sender: TObject);
var
  i: Integer;
  bfound: boolean;
begin
  Memo2.Clear;
  SpeedButton2.Enabled := false;
  if Memo1.Text <> '' then
  begin
    if FileExists(ExtractFilePath(ParamStr(0)) + 'graph.pzy') then
      DeleteFile(ExtractFilePath(ParamStr(0)) + 'graph.pzy');

    SaveToFile();
    Sleep(300);
    if FileExists(ExtractFilePath(ParamStr(0)) + 'graph.pzy') then
    begin
      CaptureConsoleOutput('java parser graph.pzy', '', procedure(const Line: PAnsiChar)begin Memo2.Lines.Add(String(Line)); end);
    end;
  end
  else
    Memo2.Lines.Add('Nothing to compile!');

  bfound := false;
  for i := 0 to Memo2.Lines.count - 1 do
  begin
    if Memo2.Lines[i] = 'Compilation successful 0 errors found' then
      bfound := true;
  end;

  if Memo2.Text = '' then
    Memo2.Lines.Add('Something went wrong during the process, please run "run.bat" in the project folder.');

  SpeedButton2.Enabled := bfound;
end;

procedure TfrmParserGraph.SpeedButton4Click(Sender: TObject);
begin
  close;
end;

procedure TfrmParserGraph.SaveToFile();
var
  LogFile: TextFile;
  Description: string;
  i: Integer;
begin
  for i := 0 to Memo1.Lines.count - 1 do
  begin
    Description := Memo1.Lines[i];
    AssignFile(LogFile, ExtractFilePath(ParamStr(0)) + 'graph.pzy');
    try
      if FileExists(ExtractFilePath(ParamStr(0)) + 'graph.pzy') then
        Append(LogFile) // If existing file
      else
        Rewrite(LogFile); // Create if new
      WRITELN(LogFile, Description);
      CloseFile(LogFile)
    except
    end;
  end;
end;

end.
