(*
  * Copyright (c) 2010-2012 Thundax P-Zaggy (VLO Framework)
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
unit GraphicsBuilder_TLB;

// ************************************************************************ //
// WARNING
// -------
// The types declared in this file were generated from data read from a
// Type Library. If this type library is explicitly or indirectly (via
// another type library referring to this type library) re-imported, or the
// 'Refresh' command of the Type Library Editor activated while editing the
// Type Library, the contents of this file will be regenerated and all
// manual modifications will be lost.
// ************************************************************************ //

// $Rev: 16059 $
// File generated on 27/08/2009 17:44:37 from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\Program Files\Citect\CitectSCADA 7\Bin\ctdraw32.tlb (1)
// LIBID: {58792D66-0C1E-4E72-9F6F-BEEEC483B9EF}
// LCID: 9
// Helpfile:
// HelpString: GraphicsBuilder 6.1 Type Library
// DepndLst:
//   (1) v2.0 stdole, (C:\Windows\system32\stdole2.tlb)
// Errors:
//   Hint: TypeInfo 'GraphicsBuilder' changed to 'GraphicsBuilder_'
//   Hint: Parameter 'property' of IGraphicsBuilder.PageEnvironmentFirst changed to 'property_'
//   Hint: Parameter 'property' of IGraphicsBuilder.PageEnvironmentNext changed to 'property_'
//   Hint: Parameter 'property' of IGraphicsBuilder.PageEnvironmentAdd changed to 'property_'
//   Hint: Parameter 'property' of IGraphicsBuilder.PageEnvironmentRemove changed to 'property_'
// ************************************************************************ //
// *************************************************************************//
// NOTE:
// Items guarded by $IFDEF_LIVE_SERVER_AT_DESIGN_TIME are used by properties
// which return objects that may need to be explicitly created via a function
// call prior to any access via the property. These items have been disabled
// in order to prevent accidental use from within the object inspector. You
// may enable them by defining LIVE_SERVER_AT_DESIGN_TIME or by selectively
// removing them from the $IFDEF blocks. However, such items must still be
// programmatically created via a method of the appropriate CoClass before
// they can be used.
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers.
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
{$ALIGN 4}
interface

uses Windows, ActiveX, Classes, Graphics, OleServer, StdVCL, Variants;


// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:
//   Type Libraries     : LIBID_xxxx
//   CoClasses          : CLASS_xxxx
//   DISPInterfaces     : DIID_xxxx
//   Non-DISP interfaces: IID_xxxx
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  GraphicsBuilderMajorVersion = 6;
  GraphicsBuilderMinorVersion = 1;

  LIBID_GraphicsBuilder: TGUID = '{58792D66-0C1E-4E72-9F6F-BEEEC483B9EF}';

  IID_IGraphicsBuilder: TGUID = '{A51AE4EE-3E34-4878-9090-560CBEEF7FF4}';
  IID_IGraphicsBuilder2: TGUID = '{6E6B1CF1-73D9-40FA-BF54-DA82E3B6E01B}';
  IID_IGraphicsBuilderEvents: TGUID = '{61D71BF6-7E41-447C-8A77-9B966B43A0D2}';
  CLASS_GraphicsBuilder_: TGUID = '{EB087A43-4189-46A9-8819-F717B9963C31}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary
// *********************************************************************//
  IGraphicsBuilder = interface;
  IGraphicsBuilderDisp = dispinterface;
  IGraphicsBuilder2 = interface;
  IGraphicsBuilder2Disp = dispinterface;
  IGraphicsBuilderEvents = interface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library
// (NOTE: Here we map each CoClass to its Default Interface)
// *********************************************************************//
  GraphicsBuilder_ = IGraphicsBuilder;


// *********************************************************************//
// Declaration of structures, unions and aliases.
// *********************************************************************//
  PInteger1 = ^Integer; {*}


// *********************************************************************//
// Interface: IGraphicsBuilder
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {A51AE4EE-3E34-4878-9090-560CBEEF7FF4}
// *********************************************************************//
  IGraphicsBuilder = interface(IDispatch)
    ['{A51AE4EE-3E34-4878-9090-560CBEEF7FF4}']
    procedure Set_Visible(retval: WordBool); safecall;
    function Get_Visible: WordBool; safecall;
    procedure PageNew(const bstrProject: WideString; const bstrStyle: WideString;
                      const bstrTemplate: WideString; nResolution: Smallint; bTitlebar: WordBool;
                      bLinked: WordBool); safecall;
    procedure PageNewEx(nPageType: Smallint); safecall;
    procedure PageNewTemplate(const bstrProject: WideString; const bstrStyle: WideString;
                              const bstrTemplate: WideString; nResolution: Smallint;
                              bTitlebar: WordBool; bLinked: WordBool); safecall;
    procedure PageOpen(const bstrProject: WideString; const bstrFile: WideString); safecall;
    procedure PageOpenEx(const bstrProject: WideString; const bstrLibrary: WideString;
                         const bstrElement: WideString; nPageType: Smallint); safecall;
    procedure PageOpenTemplate(const bstrProject: WideString; const bstrStyle: WideString;
                               const bstrTemplate: WideString; nResolution: Smallint;
                               bTitlebar: WordBool); safecall;
    procedure PageSelectFirst; safecall;
    procedure PageSelectNext; safecall;
    procedure PageSave; safecall;
    procedure PageSaveAs(const bstrProject: WideString; const bstrFile: WideString); safecall;
    procedure PageSaveAsEx(const bstrProject: WideString; const bstrLibrary: WideString;
                           const bstrElement: WideString); safecall;
    procedure PageClose; safecall;
    procedure PageDelete(const bstrProject: WideString; const bstrFile: WideString;
                         bDeleteAssociatedRecords: WordBool); safecall;
    procedure PageDeleteEx(const bstrProject: WideString; const bstrLibrary: WideString;
                           const bstrElement: WideString; nPageType: Smallint); safecall;
    procedure PageDeleteTemplate(const bstrProject: WideString; const bstrStyle: WideString;
                                 const bstrTemplate: WideString; nResolution: Smallint;
                                 bTitlebar: WordBool); safecall;
    procedure PageNewLibrary(const bstrProject: WideString; const bstrLibrary: WideString;
                             nPageType: Smallint); safecall;
    procedure PageSelectFirstObject; safecall;
    procedure PageSelectNextObject; safecall;
    procedure PageSelectFirstObjectEx; safecall;
    procedure PageSelectNextObjectEx; safecall;
    procedure PageSelectFirstObjectInGroup; safecall;
    procedure PageSelectNextObjectInGroup; safecall;
    procedure PageSelectObject(nAN: Smallint); safecall;
    procedure PageSelectObjectAdd(nAN: Smallint); safecall;
    procedure PageGroupSelectedObjects; safecall;
    procedure PageUngroupSelectedObject; safecall;
    procedure PageDeleteObject; safecall;
    function PageActiveWindowHandle: Integer; safecall;
    procedure PageConvertWindowCoordinates(var pnXPos: Smallint; var pnYPos: Smallint); safecall;
    procedure PagePrint; safecall;
    procedure PageImport(const bstrFile: WideString); safecall;
    procedure PageThumbnailToClipboard(nSize: Smallint); safecall;
    function PageName: WideString; safecall;
    procedure Set_PageTitle(const retval: WideString); safecall;
    function Get_PageTitle: WideString; safecall;
    procedure Set_PageDescription(const retval: WideString); safecall;
    function Get_PageDescription: WideString; safecall;
    procedure Set_PagePrevious(const retval: WideString); safecall;
    function Get_PagePrevious: WideString; safecall;
    procedure Set_PageNext(const retval: WideString); safecall;
    function Get_PageNext: WideString; safecall;
    procedure Set_PageArea(const retval: WideString); safecall;
    function Get_PageArea: WideString; safecall;
    procedure Set_PageScanTime(const retval: WideString); safecall;
    function Get_PageScanTime: WideString; safecall;
    procedure Set_PageLogDevice(const retval: WideString); safecall;
    function Get_PageLogDevice: WideString; safecall;
    procedure PageAppearanceGet(out pbstrProject: WideString; out pbstrStyle: WideString;
                                out pbstrTemplate: WideString; out pnResolution: Smallint;
                                out pbTitlebar: WordBool; out pnWidth: Smallint;
                                out pnHight: Smallint; out pnColour: Smallint); safecall;
    procedure LibraryObjectPlace(const bstrProject: WideString; const bstrLibrary: WideString;
                                 const bstrElement: WideString; nLibraryObjectType: Smallint;
                                 bLinked: WordBool); safecall;
    procedure LibraryObjectPlaceEx(const bstrProject: WideString; const bstrLibrary: WideString;
                                   const bstrElement: WideString; nLibraryObjectType: Smallint;
                                   bLinked: WordBool; nXPos: Smallint; nYPos: Smallint); safecall;
    procedure LibraryObjectFirstProperty(out pbstrPropertyName: WideString;
                                         out pbstrPropertyValue: WideString); safecall;
    procedure LibraryObjectNextProperty(out pbstrPropertyName: WideString;
                                        out pbstrPropertyValue: WideString); safecall;
    procedure LibraryObjectPutProperty(const bstrPropertyName: WideString;
                                       const bstrPropertyValue: WideString); safecall;
    procedure LibraryObjectFirstPropertyEx(const bstrProject: WideString;
                                           const bstrLibrary: WideString;
                                           const bstrElement: WideString;
                                           out pbstrPropertyName: WideString;
                                           out pbstrPropertyValue: WideString); safecall;
    procedure LibraryObjectNextPropertyEx(out pbstrPropertyName: WideString;
                                          out pbstrPropertyValue: WideString); safecall;
    procedure LibraryObjectName(out bstrProject: WideString; out pbstrLibrary: WideString;
                                out pbstrElement: WideString; out pnLibObjectType: Smallint); safecall;
    procedure LibraryObjectHotspotPut(nXPos: Smallint; nYPos: Smallint); safecall;
    procedure LibraryObjectHotspotGet(out pnXPos: Smallint; out pnYPos: Smallint); safecall;
    procedure LibraryShowPasteDialog(nLibraryObjectType: Smallint); safecall;
    procedure Set_LibrarySelectionHooksEnabled(retval: WordBool); safecall;
    function Get_LibrarySelectionHooksEnabled: WordBool; safecall;
    procedure PositionAt(nXPos: Smallint; nYPos: Smallint); safecall;
    procedure PositionRotate; safecall;
    procedure PositionMirrorVertical; safecall;
    procedure PositionMirrorHorizontal; safecall;
    procedure PositionSendToBack; safecall;
    procedure PositionBringToFront; safecall;
    procedure PositionBringForwards; safecall;
    procedure PositionSendBackwards; safecall;
    procedure DrawLine(nXPos: Smallint; nYPos: Smallint; nXPosEnd: Smallint; nYPosEnd: Smallint); safecall;
    procedure DrawRectangle(nXPos: Smallint; nYPos: Smallint; nXPosEnd: Smallint; nYPosEnd: Smallint); safecall;
    procedure DrawEllipse(nXPos: Smallint; nYPos: Smallint; nXPosEnd: Smallint; nYPosEnd: Smallint); safecall;
    procedure DrawPolygonStart(nXPos: Smallint; nYPos: Smallint); safecall;
    procedure DrawPolygonLine(nXPos: Smallint; nYPos: Smallint); safecall;
    procedure DrawPolygonEnd; safecall;
    procedure DrawPipeStart(nXPos: Smallint; nYPos: Smallint); safecall;
    procedure DrawPipeSection(nXPos: Smallint; nYPos: Smallint); safecall;
    procedure DrawPipeEnd; safecall;
    procedure DrawText(const bstrText: WideString; nXPos: Smallint; nYPos: Smallint); safecall;
    procedure DrawNumber(nXPos: Smallint; nYPos: Smallint); safecall;
    procedure DrawButton(nXPos: Smallint; nYPos: Smallint; nXPosEnd: Smallint; nYPosEnd: Smallint); safecall;
    procedure DrawSymbolSet(nXPos: Smallint; nYPos: Smallint); safecall;
    procedure DrawTrend(nXPos: Smallint; nYPos: Smallint; nXPosEnd: Smallint; nYPosEnd: Smallint); safecall;
    procedure DrawCicodeObject(nXPos: Smallint; nYPos: Smallint); safecall;
    procedure Set_AttributeLineWidth(retval: Smallint); safecall;
    function Get_AttributeLineWidth: Smallint; safecall;
    procedure Set_AttributeLineStyle(retval: Smallint); safecall;
    function Get_AttributeLineStyle: Smallint; safecall;
    procedure Set_AttributeLineColour(retval: Smallint); safecall;
    function Get_AttributeLineColour: Smallint; safecall;
    procedure Set_AttributeSetFill(retval: Smallint); safecall;
    function Get_AttributeSetFill: Smallint; safecall;
    procedure Set_AttributeFillColour(retval: Smallint); safecall;
    function Get_AttributeFillColour: Smallint; safecall;
    procedure Set_Attribute3dEffects(retval: Smallint); safecall;
    function Get_Attribute3dEffects: Smallint; safecall;
    procedure Set_Attribute3dEffectDepth(retval: Smallint); safecall;
    function Get_Attribute3dEffectDepth: Smallint; safecall;
    procedure Set_AttributeShadowColour(retval: Smallint); safecall;
    function Get_AttributeShadowColour: Smallint; safecall;
    procedure Set_AttributeHiLightColour(retval: Smallint); safecall;
    function Get_AttributeHiLightColour: Smallint; safecall;
    procedure Set_AttributeLoLightColour(retval: Smallint); safecall;
    function Get_AttributeLoLightColour: Smallint; safecall;
    procedure Set_AttributeRectangleStyle(retval: Smallint); safecall;
    function Get_AttributeRectangleStyle: Smallint; safecall;
    procedure Set_AttributeStartAngle(retval: Smallint); safecall;
    function Get_AttributeStartAngle: Smallint; safecall;
    procedure Set_AttributeEndAngle(retval: Smallint); safecall;
    function Get_AttributeEndAngle: Smallint; safecall;
    procedure Set_AttributeEllipseStyle(retval: Smallint); safecall;
    function Get_AttributeEllipseStyle: Smallint; safecall;
    procedure Set_AttributePolygonOpen(retval: Smallint); safecall;
    function Get_AttributePolygonOpen: Smallint; safecall;
    function AttributeX: Smallint; safecall;
    function AttributeY: Smallint; safecall;
    function AttributeExtentX: Smallint; safecall;
    function AttributeExtentY: Smallint; safecall;
    procedure AttributeBaseCoordinates(out pnXPos: Smallint; out pnYPos: Smallint;
                                       out pnXPosEnd: Smallint; out pnYPosEnd: Smallint); safecall;
    procedure AttributeTransformationMatrixPut(dA: Double; dB: Double; dC: Double; dD: Double;
                                               dH: Double; dK: Double); safecall;
    procedure AttributeTransformationMatrixGet(out pdA: Double; out pdB: Double; out pdC: Double;
                                               out pdD: Double; out pdH: Double; out pdK: Double); safecall;
    procedure AttributeNodeCoordinatesFirst(out pnXPos: Smallint; out pnYPos: Smallint); safecall;
    procedure AttributeNodeCoordinatesNext(out pnXPos: Smallint; out pnYPos: Smallint); safecall;
    function AttributeAN: Smallint; safecall;
    function AttributeClass: WideString; safecall;
    procedure Set_AttributeText(const retval: WideString); safecall;
    function Get_AttributeText: WideString; safecall;
    procedure Set_AttributeTextStyle(retval: Smallint); safecall;
    function Get_AttributeTextStyle: Smallint; safecall;
    procedure Set_AttributeTextJustification(retval: Smallint); safecall;
    function Get_AttributeTextJustification: Smallint; safecall;
    procedure Set_AttributeTextFont(const retval: WideString); safecall;
    function Get_AttributeTextFont: WideString; safecall;
    procedure Set_AttributeTextFontSize(retval: Smallint); safecall;
    function Get_AttributeTextFontSize: Smallint; safecall;
    procedure Set_AttributeTextColour(retval: Smallint); safecall;
    function Get_AttributeTextColour: Smallint; safecall;
    procedure Set_PropertyVisibility(const retval: WideString); safecall;
    function Get_PropertyVisibility: WideString; safecall;
    procedure PropertiesSymbolSetPut(nType: Smallint; const bstrExpression1: WideString;
                                     const bstrExpression2: WideString;
                                     const bstrExpression3: WideString;
                                     const bstrExpression4: WideString;
                                     const bstrExpression5: WideString); safecall;
    procedure PropertiesSymbolSetGet(out pnType: Smallint; out pbstrExpression1: WideString;
                                     out pbstrExpression2: WideString;
                                     out pbstrExpression3: WideString;
                                     out pbstrExpression4: WideString;
                                     out pbstrExpression5: WideString); safecall;
    procedure PropertiesSymbolSetSymbolPut(nIndex: Smallint; const bstrLibrary: WideString;
                                           const bstrElement: WideString); safecall;
    procedure PropertiesSymbolSetSymbolGet(nIndex: Smallint; out pbstrLibrary: WideString;
                                           out pbstrElement: WideString); safecall;
    procedure PropertiesDisplayValuePut(nType: Smallint; const bstrExpression1: WideString;
                                        const bstrExpression2: WideString;
                                        const bstrExpression3: WideString;
                                        const bstrExpression4: WideString;
                                        const bstrExpression5: WideString); safecall;
    procedure PropertiesDisplayValueGet(out pnType: Smallint; out pbstrExpression1: WideString;
                                        out pbstrExpression2: WideString;
                                        out pbstrExpression3: WideString;
                                        out pbstrExpression4: WideString;
                                        out pbstrExpression5: WideString); safecall;
    procedure PropertiesDisplayValueTextPut(nIndex: Smallint; const bstrText: WideString); safecall;
    procedure PropertiesDisplayValueTextGet(nIndex: Smallint; out pbstrText: WideString); safecall;
    procedure PropertiesButtonPut(nType: Smallint; const bstrText: WideString;
                                  const bstrFont: WideString; const bstrLibrary: WideString;
                                  const bstrElement: WideString); safecall;
    procedure PropertiesButtonGet(out pnType: Smallint; out pbstrText: WideString;
                                  out pbstrFont: WideString; out pbstrLibrary: WideString;
                                  out pbstrElement: WideString); safecall;
    procedure PropertiesTrendPut(nNumberOfSamples: Smallint; nPixelPerSample: Smallint;
                                 const bstrExpression1: WideString; nColour1: Smallint;
                                 const bstrExpression2: WideString; nColour2: Smallint;
                                 const bstrExpression3: WideString; nColour3: Smallint;
                                 const bstrExpression4: WideString; nColour4: Smallint;
                                 const bstrExpression5: WideString; nColour5: Smallint;
                                 const bstrExpression6: WideString; nColour6: Smallint;
                                 const bstrExpression7: WideString; nColour7: Smallint;
                                 const bstrExpression8: WideString; nColour8: Smallint); safecall;
    procedure PropertiesTrendGet(out pnNumberOfSamples: Smallint; out pnPixelPerSample: Smallint;
                                 out pbstrExpression1: WideString; out pnColour1: Smallint;
                                 out pbstrExpression2: WideString; out pnColour2: Smallint;
                                 out pbstrExpression3: WideString; out pnColour3: Smallint;
                                 out pbstrExpression4: WideString; out pnColour4: Smallint;
                                 out pbstrExpression5: WideString; out pnColour5: Smallint;
                                 out pbstrExpression6: WideString; out pnColour6: Smallint;
                                 out pbstrExpression7: WideString; out pnColour7: Smallint;
                                 out pbstrExpression8: WideString; out pnColour8: Smallint); safecall;
    procedure PropertiesCicodeObjectPut(const bstrExpression: WideString;
                                        const bstrLibrary: WideString; const bstrElement: WideString); safecall;
    procedure PropertiesCicodeObjectGet(out pbstrExpression: WideString;
                                        out pbstrLibrary: WideString; out pbstrElement: WideString); safecall;
    procedure PropertiesTransformationPut(nAction: Smallint; const bstrExpression: WideString;
                                          bRangeOrUpdate: WordBool; dRangeMin: Double;
                                          dRangeMax: Double; nOffsetMin: Smallint;
                                          nOffsetMax: Smallint; bCustom: WordBool;
                                          nCentreOffsetRight: Smallint; nCentreOffsetDown: Smallint); safecall;
    procedure PropertiesTransformationGet(nAction: Smallint; out pbstrExpression: WideString;
                                          out pbRangeOrUpdate: WordBool; out pdRangeMin: Double;
                                          out pdRangeMax: Double; out pnOffsetMin: Smallint;
                                          out pnOffsetMax: Smallint; out pbCustom: WordBool;
                                          out pnCentreOffsetRight: Smallint;
                                          out pnCentreOffsetDown: Smallint); safecall;
    procedure PropertiesFillColourPut(nType: Smallint; const bstrExpression1: WideString;
                                      const bstrExpression2: WideString;
                                      const bstrExpression3: WideString;
                                      const bstrExpression4: WideString;
                                      const bstrExpression5: WideString; bRangeOn: WordBool;
                                      dRangeMin: Double; dRangeMax: Double); safecall;
    procedure PropertiesFillColourGet(out pnType: Smallint; out pbstrExpression1: WideString;
                                      out pbstrExpression2: WideString;
                                      out pbstrExpression3: WideString;
                                      out pbstrExpression4: WideString;
                                      out pbstrExpression5: WideString; out pbRangeOn: WordBool;
                                      out pdRangeMin: Double; out pdRangeMax: Double); safecall;
    procedure PropertiesFillColourColourPut(nIndex: Smallint; nColour: Smallint; nLimit: Smallint;
                                            nOperator: Smallint); safecall;
    procedure PropertiesFillColourColourGet(nIndex: Smallint; out pnColour: Smallint;
                                            out pnLimit: Smallint; out pnOperator: Smallint); safecall;
    procedure PropertiesFillLevelPut(const bstrExpression: WideString; bRange: WordBool;
                                     dRangeMin: Double; dRangeMax: Double; nOffsetMin: Smallint;
                                     nOffsetMax: Smallint; nFillDirection: Smallint;
                                     nBackgroundColour: Smallint); safecall;
    procedure PropertiesFillLevelGet(out pbstrExpression: WideString; out pbRange: WordBool;
                                     out pdRangeMin: Double; out pdRangeMax: Double;
                                     out pnOffsetMin: Smallint; out pnOffsetMax: Smallint;
                                     out pnFillDirection: Smallint; out pnBackgroundColour: Smallint); safecall;
    procedure PropertiesInputTouchPut(nAction: Smallint; const bstrExpression: WideString;
                                      const bstrLogging: WideString; nRepeatRate: Smallint); safecall;
    procedure PropertiesInputTouchGet(nAction: Smallint; out pbstrExpression: WideString;
                                      out pbstrLogging: WideString; out pnRepeatRate: Smallint); safecall;
    procedure PropertiesInputKeyboardPut(nIndex: Smallint; const bstrKeySequence: WideString;
                                         const bstrCommand: WideString; nArea: Smallint;
                                         nPrivilege: Smallint; const bstrLogging: WideString); safecall;
    procedure PropertiesInputKeyboardGet(nIndex: Smallint; out pbstrKeySequence: WideString;
                                         out pbstrCommand: WideString; out pnArea: Smallint;
                                         out pnPrivilege: Smallint; out pbstrLogging: WideString); safecall;
    procedure PropertiesAccessGeneralPut(const bstrDescription: WideString;
                                         const bstrTooltip: WideString; nArea: Smallint;
                                         nPrivilege: Smallint; const bstrLogDevice: WideString); safecall;
    procedure PropertiesAccessGeneralGet(out pbstrDescription: WideString;
                                         out pbstrTooltip: WideString; out pnArea: Smallint;
                                         out pnPrivilege: Smallint; out pbstrLogDevice: WideString); safecall;
    procedure PropertiesAccessDisablePut(const bstrExpression: WideString; bInsufficient: WordBool;
                                         nDisableStyle: Smallint); safecall;
    procedure PropertiesAccessDisableGet(out pbstrExpression: WideString;
                                         out pbInsufficient: WordBool; out pnDisableStyle: Smallint); safecall;
    procedure PropertiesShowDialog; safecall;
    procedure Set_OptionDisplayPropertiesOnNew(retval: WordBool); safecall;
    function Get_OptionDisplayPropertiesOnNew: WordBool; safecall;
    procedure Set_OptionSnapToGrid(retval: WordBool); safecall;
    function Get_OptionSnapToGrid: WordBool; safecall;
    procedure Set_OptionSnapToGuidelines(retval: WordBool); safecall;
    function Get_OptionSnapToGuidelines: WordBool; safecall;
    procedure ProjectSelect(const bstrProject: WideString); safecall;
    function ProjectSelected: WideString; safecall;
    function ProjectFirst: WideString; safecall;
    function ProjectNext: WideString; safecall;
    function ProjectFirstInclude: WideString; safecall;
    function ProjectNextInclude: WideString; safecall;
    procedure ProjectUpgrade; safecall;
    procedure ProjectUpgradeAll; safecall;
    procedure ProjectPackLibraries; safecall;
    procedure ProjectUpdatePages(bFastUpdate: WordBool); safecall;
    procedure ProjectPackDatabase; safecall;
    procedure ProjectCompile; safecall;
    procedure ClipboardCut; safecall;
    procedure ClipboardCopy; safecall;
    procedure ClipboardPaste; safecall;
    procedure ConvertToBitmap; safecall;
    procedure Set_SelectionEventEnabled(retval: WordBool); safecall;
    function Get_SelectionEventEnabled: WordBool; safecall;
    procedure Set_BrokenLinkCancelEnabled(retval: WordBool); safecall;
    function Get_BrokenLinkCancelEnabled: WordBool; safecall;
    procedure Quit; safecall;
    procedure DisplayInStatusBar(const bstrStatusText: WideString); safecall;
    procedure PageKeyboardCommandsPut(nIndex: Smallint; const bstrKeySequence: WideString;
                                      const bstrCommand: WideString; const nArea: WideString;
                                      const nPrivilege: WideString; const bstrLogging: WideString); safecall;
    procedure PageKeyboardCommandsGet(nIndex: Smallint; out pbstrKeySequence: WideString;
                                      out pbstrCommand: WideString; out pnArea: WideString;
                                      out pnPrivilege: WideString; out pbstrLogging: WideString); safecall;
    procedure PageSelect(const bstrBase: WideString; const bstrFile: WideString); safecall;
    function AttributeXEx: Smallint; safecall;
    function AttributeYEx: Smallint; safecall;
    procedure PageSelectFirstObjectInGenie; safecall;
    procedure PageSelectNextObjectInGenie; safecall;
    procedure PropertiesTransCentreOffsetExpressGet(out movementRotationalExpress: Smallint;
                                                    out scalingHorizontalExpress: Smallint;
                                                    out scalingVerticalExpress: Smallint;
                                                    out sliderRotationalExpress: Smallint); safecall;
    procedure PropertiesTransCentreOffsetExpressPut(movementRotationalExpress: Smallint;
                                                    scalingHorizontalExpress: Smallint;
                                                    scalingVerticalExpress: Smallint;
                                                    sliderRotationalExpress: Smallint); safecall;
    procedure PageEnvironmentFirst(out property_: WideString; out value: WideString); safecall;
    procedure PageEnvironmentNext(const currentProperty: WideString; out property_: WideString;
                                  out value: WideString); safecall;
    procedure PageEnvironmentAdd(const property_: WideString; const value: WideString); safecall;
    procedure PageEnvironmentRemove(const property_: WideString); safecall;
    procedure PageEventsGet(out pbstrEventOnEntryCommand: WideString;
                            out pbstrEventOnExitCommand: WideString;
                            out pbstrEventWhileShownCommand: WideString;
                            out pbstrEventOnShownCommand: WideString); safecall;
    procedure PageEventsPut(const bstrEventOnEntryCommand: WideString;
                            const bstrEventOnExitCommand: WideString;
                            const bstrEventWhileShownCommand: WideString;
                            const bstrEventOnShownCommand: WideString); safecall;
    procedure PageTemplateSelectFirstObject; safecall;
    procedure PageTemplateSelectNextObject; safecall;
    procedure LockObject; safecall;
    procedure UnLockObject; safecall;
    procedure Set_BreakLockMode(retval: WordBool); safecall;
    function Get_BreakLockMode: WordBool; safecall;
    function Get_AttributeRawOrient: Smallint; safecall;
    procedure PageAppearanceSet(const templateStyle: WideString; const templateName: WideString;
                                resolution: Smallint; titlebar: WordBool; width: Smallint;
                                height: Smallint; colour: Smallint); safecall;
    procedure _Reserved15; safecall;
    procedure _Reserved16; safecall;
    procedure _Reserved17; safecall;
    procedure _Reserved18; safecall;
    procedure _Reserved19; safecall;
    procedure _Reserved20; safecall;
    procedure _Reserved21; safecall;
    procedure _Reserved22; safecall;
    procedure _Reserved23; safecall;
    procedure _Reserved24; safecall;
    procedure _Reserved25; safecall;
    procedure _Reserved26; safecall;
    procedure _Reserved27; safecall;
    procedure _Reserved28; safecall;
    procedure _Reserved29; safecall;
    procedure _Reserved30; safecall;
    property Visible: WordBool read Get_Visible write Set_Visible;
    property PageTitle: WideString read Get_PageTitle write Set_PageTitle;
    property PageDescription: WideString read Get_PageDescription write Set_PageDescription;
    property PagePrevious: WideString read Get_PagePrevious write Set_PagePrevious;
    property PageNext: WideString read Get_PageNext write Set_PageNext;
    property PageArea: WideString read Get_PageArea write Set_PageArea;
    property PageScanTime: WideString read Get_PageScanTime write Set_PageScanTime;
    property PageLogDevice: WideString read Get_PageLogDevice write Set_PageLogDevice;
    property LibrarySelectionHooksEnabled: WordBool read Get_LibrarySelectionHooksEnabled write Set_LibrarySelectionHooksEnabled;
    property AttributeLineWidth: Smallint read Get_AttributeLineWidth write Set_AttributeLineWidth;
    property AttributeLineStyle: Smallint read Get_AttributeLineStyle write Set_AttributeLineStyle;
    property AttributeLineColour: Smallint read Get_AttributeLineColour write Set_AttributeLineColour;
    property AttributeSetFill: Smallint read Get_AttributeSetFill write Set_AttributeSetFill;
    property AttributeFillColour: Smallint read Get_AttributeFillColour write Set_AttributeFillColour;
    property Attribute3dEffects: Smallint read Get_Attribute3dEffects write Set_Attribute3dEffects;
    property Attribute3dEffectDepth: Smallint read Get_Attribute3dEffectDepth write Set_Attribute3dEffectDepth;
    property AttributeShadowColour: Smallint read Get_AttributeShadowColour write Set_AttributeShadowColour;
    property AttributeHiLightColour: Smallint read Get_AttributeHiLightColour write Set_AttributeHiLightColour;
    property AttributeLoLightColour: Smallint read Get_AttributeLoLightColour write Set_AttributeLoLightColour;
    property AttributeRectangleStyle: Smallint read Get_AttributeRectangleStyle write Set_AttributeRectangleStyle;
    property AttributeStartAngle: Smallint read Get_AttributeStartAngle write Set_AttributeStartAngle;
    property AttributeEndAngle: Smallint read Get_AttributeEndAngle write Set_AttributeEndAngle;
    property AttributeEllipseStyle: Smallint read Get_AttributeEllipseStyle write Set_AttributeEllipseStyle;
    property AttributePolygonOpen: Smallint read Get_AttributePolygonOpen write Set_AttributePolygonOpen;
    property AttributeText: WideString read Get_AttributeText write Set_AttributeText;
    property AttributeTextStyle: Smallint read Get_AttributeTextStyle write Set_AttributeTextStyle;
    property AttributeTextJustification: Smallint read Get_AttributeTextJustification write Set_AttributeTextJustification;
    property AttributeTextFont: WideString read Get_AttributeTextFont write Set_AttributeTextFont;
    property AttributeTextFontSize: Smallint read Get_AttributeTextFontSize write Set_AttributeTextFontSize;
    property AttributeTextColour: Smallint read Get_AttributeTextColour write Set_AttributeTextColour;
    property PropertyVisibility: WideString read Get_PropertyVisibility write Set_PropertyVisibility;
    property OptionDisplayPropertiesOnNew: WordBool read Get_OptionDisplayPropertiesOnNew write Set_OptionDisplayPropertiesOnNew;
    property OptionSnapToGrid: WordBool read Get_OptionSnapToGrid write Set_OptionSnapToGrid;
    property OptionSnapToGuidelines: WordBool read Get_OptionSnapToGuidelines write Set_OptionSnapToGuidelines;
    property SelectionEventEnabled: WordBool read Get_SelectionEventEnabled write Set_SelectionEventEnabled;
    property BrokenLinkCancelEnabled: WordBool read Get_BrokenLinkCancelEnabled write Set_BrokenLinkCancelEnabled;
    property BreakLockMode: WordBool read Get_BreakLockMode write Set_BreakLockMode;
    property AttributeRawOrient: Smallint read Get_AttributeRawOrient;
  end;

// *********************************************************************//
// DispIntf:  IGraphicsBuilderDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {A51AE4EE-3E34-4878-9090-560CBEEF7FF4}
// *********************************************************************//
  IGraphicsBuilderDisp = dispinterface
    ['{A51AE4EE-3E34-4878-9090-560CBEEF7FF4}']
    property Visible: WordBool dispid 1610743808;
    procedure PageNew(const bstrProject: WideString; const bstrStyle: WideString;
                      const bstrTemplate: WideString; nResolution: Smallint; bTitlebar: WordBool;
                      bLinked: WordBool); dispid 1610743810;
    procedure PageNewEx(nPageType: Smallint); dispid 1610743811;
    procedure PageNewTemplate(const bstrProject: WideString; const bstrStyle: WideString;
                              const bstrTemplate: WideString; nResolution: Smallint;
                              bTitlebar: WordBool; bLinked: WordBool); dispid 1610743812;
    procedure PageOpen(const bstrProject: WideString; const bstrFile: WideString); dispid 1610743813;
    procedure PageOpenEx(const bstrProject: WideString; const bstrLibrary: WideString;
                         const bstrElement: WideString; nPageType: Smallint); dispid 1610743814;
    procedure PageOpenTemplate(const bstrProject: WideString; const bstrStyle: WideString;
                               const bstrTemplate: WideString; nResolution: Smallint;
                               bTitlebar: WordBool); dispid 1610743815;
    procedure PageSelectFirst; dispid 1610743816;
    procedure PageSelectNext; dispid 1610743817;
    procedure PageSave; dispid 1610743818;
    procedure PageSaveAs(const bstrProject: WideString; const bstrFile: WideString); dispid 1610743819;
    procedure PageSaveAsEx(const bstrProject: WideString; const bstrLibrary: WideString;
                           const bstrElement: WideString); dispid 1610743820;
    procedure PageClose; dispid 1610743821;
    procedure PageDelete(const bstrProject: WideString; const bstrFile: WideString;
                         bDeleteAssociatedRecords: WordBool); dispid 1610743822;
    procedure PageDeleteEx(const bstrProject: WideString; const bstrLibrary: WideString;
                           const bstrElement: WideString; nPageType: Smallint); dispid 1610743823;
    procedure PageDeleteTemplate(const bstrProject: WideString; const bstrStyle: WideString;
                                 const bstrTemplate: WideString; nResolution: Smallint;
                                 bTitlebar: WordBool); dispid 1610743824;
    procedure PageNewLibrary(const bstrProject: WideString; const bstrLibrary: WideString;
                             nPageType: Smallint); dispid 1610743825;
    procedure PageSelectFirstObject; dispid 1610743826;
    procedure PageSelectNextObject; dispid 1610743827;
    procedure PageSelectFirstObjectEx; dispid 1610743828;
    procedure PageSelectNextObjectEx; dispid 1610743829;
    procedure PageSelectFirstObjectInGroup; dispid 1610743830;
    procedure PageSelectNextObjectInGroup; dispid 1610743831;
    procedure PageSelectObject(nAN: Smallint); dispid 1610743832;
    procedure PageSelectObjectAdd(nAN: Smallint); dispid 1610743833;
    procedure PageGroupSelectedObjects; dispid 1610743834;
    procedure PageUngroupSelectedObject; dispid 1610743835;
    procedure PageDeleteObject; dispid 1610743836;
    function PageActiveWindowHandle: Integer; dispid 1610743837;
    procedure PageConvertWindowCoordinates(var pnXPos: Smallint; var pnYPos: Smallint); dispid 1610743838;
    procedure PagePrint; dispid 1610743839;
    procedure PageImport(const bstrFile: WideString); dispid 1610743840;
    procedure PageThumbnailToClipboard(nSize: Smallint); dispid 1610743841;
    function PageName: WideString; dispid 1610743842;
    property PageTitle: WideString dispid 1610743843;
    property PageDescription: WideString dispid 1610743845;
    property PagePrevious: WideString dispid 1610743847;
    property PageNext: WideString dispid 1610743849;
    property PageArea: WideString dispid 1610743851;
    property PageScanTime: WideString dispid 1610743853;
    property PageLogDevice: WideString dispid 1610743855;
    procedure PageAppearanceGet(out pbstrProject: WideString; out pbstrStyle: WideString;
                                out pbstrTemplate: WideString; out pnResolution: Smallint;
                                out pbTitlebar: WordBool; out pnWidth: Smallint;
                                out pnHight: Smallint; out pnColour: Smallint); dispid 1610743857;
    procedure LibraryObjectPlace(const bstrProject: WideString; const bstrLibrary: WideString;
                                 const bstrElement: WideString; nLibraryObjectType: Smallint;
                                 bLinked: WordBool); dispid 1610743858;
    procedure LibraryObjectPlaceEx(const bstrProject: WideString; const bstrLibrary: WideString;
                                   const bstrElement: WideString; nLibraryObjectType: Smallint;
                                   bLinked: WordBool; nXPos: Smallint; nYPos: Smallint); dispid 1610743859;
    procedure LibraryObjectFirstProperty(out pbstrPropertyName: WideString;
                                         out pbstrPropertyValue: WideString); dispid 1610743860;
    procedure LibraryObjectNextProperty(out pbstrPropertyName: WideString;
                                        out pbstrPropertyValue: WideString); dispid 1610743861;
    procedure LibraryObjectPutProperty(const bstrPropertyName: WideString;
                                       const bstrPropertyValue: WideString); dispid 1610743862;
    procedure LibraryObjectFirstPropertyEx(const bstrProject: WideString;
                                           const bstrLibrary: WideString;
                                           const bstrElement: WideString;
                                           out pbstrPropertyName: WideString;
                                           out pbstrPropertyValue: WideString); dispid 1610743863;
    procedure LibraryObjectNextPropertyEx(out pbstrPropertyName: WideString;
                                          out pbstrPropertyValue: WideString); dispid 1610743864;
    procedure LibraryObjectName(out bstrProject: WideString; out pbstrLibrary: WideString;
                                out pbstrElement: WideString; out pnLibObjectType: Smallint); dispid 1610743865;
    procedure LibraryObjectHotspotPut(nXPos: Smallint; nYPos: Smallint); dispid 1610743866;
    procedure LibraryObjectHotspotGet(out pnXPos: Smallint; out pnYPos: Smallint); dispid 1610743867;
    procedure LibraryShowPasteDialog(nLibraryObjectType: Smallint); dispid 1610743868;
    property LibrarySelectionHooksEnabled: WordBool dispid 1610743869;
    procedure PositionAt(nXPos: Smallint; nYPos: Smallint); dispid 1610743871;
    procedure PositionRotate; dispid 1610743872;
    procedure PositionMirrorVertical; dispid 1610743873;
    procedure PositionMirrorHorizontal; dispid 1610743874;
    procedure PositionSendToBack; dispid 1610743875;
    procedure PositionBringToFront; dispid 1610743876;
    procedure PositionBringForwards; dispid 1610743877;
    procedure PositionSendBackwards; dispid 1610743878;
    procedure DrawLine(nXPos: Smallint; nYPos: Smallint; nXPosEnd: Smallint; nYPosEnd: Smallint); dispid 1610743879;
    procedure DrawRectangle(nXPos: Smallint; nYPos: Smallint; nXPosEnd: Smallint; nYPosEnd: Smallint); dispid 1610743880;
    procedure DrawEllipse(nXPos: Smallint; nYPos: Smallint; nXPosEnd: Smallint; nYPosEnd: Smallint); dispid 1610743881;
    procedure DrawPolygonStart(nXPos: Smallint; nYPos: Smallint); dispid 1610743882;
    procedure DrawPolygonLine(nXPos: Smallint; nYPos: Smallint); dispid 1610743883;
    procedure DrawPolygonEnd; dispid 1610743884;
    procedure DrawPipeStart(nXPos: Smallint; nYPos: Smallint); dispid 1610743885;
    procedure DrawPipeSection(nXPos: Smallint; nYPos: Smallint); dispid 1610743886;
    procedure DrawPipeEnd; dispid 1610743887;
    procedure DrawText(const bstrText: WideString; nXPos: Smallint; nYPos: Smallint); dispid 1610743888;
    procedure DrawNumber(nXPos: Smallint; nYPos: Smallint); dispid 1610743889;
    procedure DrawButton(nXPos: Smallint; nYPos: Smallint; nXPosEnd: Smallint; nYPosEnd: Smallint); dispid 1610743890;
    procedure DrawSymbolSet(nXPos: Smallint; nYPos: Smallint); dispid 1610743891;
    procedure DrawTrend(nXPos: Smallint; nYPos: Smallint; nXPosEnd: Smallint; nYPosEnd: Smallint); dispid 1610743892;
    procedure DrawCicodeObject(nXPos: Smallint; nYPos: Smallint); dispid 1610743893;
    property AttributeLineWidth: Smallint dispid 1610743894;
    property AttributeLineStyle: Smallint dispid 1610743896;
    property AttributeLineColour: Smallint dispid 1610743898;
    property AttributeSetFill: Smallint dispid 1610743900;
    property AttributeFillColour: Smallint dispid 1610743902;
    property Attribute3dEffects: Smallint dispid 1610743904;
    property Attribute3dEffectDepth: Smallint dispid 1610743906;
    property AttributeShadowColour: Smallint dispid 1610743908;
    property AttributeHiLightColour: Smallint dispid 1610743910;
    property AttributeLoLightColour: Smallint dispid 1610743912;
    property AttributeRectangleStyle: Smallint dispid 1610743914;
    property AttributeStartAngle: Smallint dispid 1610743916;
    property AttributeEndAngle: Smallint dispid 1610743918;
    property AttributeEllipseStyle: Smallint dispid 1610743920;
    property AttributePolygonOpen: Smallint dispid 1610743922;
    function AttributeX: Smallint; dispid 1610743924;
    function AttributeY: Smallint; dispid 1610743925;
    function AttributeExtentX: Smallint; dispid 1610743926;
    function AttributeExtentY: Smallint; dispid 1610743927;
    procedure AttributeBaseCoordinates(out pnXPos: Smallint; out pnYPos: Smallint;
                                       out pnXPosEnd: Smallint; out pnYPosEnd: Smallint); dispid 1610743928;
    procedure AttributeTransformationMatrixPut(dA: Double; dB: Double; dC: Double; dD: Double;
                                               dH: Double; dK: Double); dispid 1610743929;
    procedure AttributeTransformationMatrixGet(out pdA: Double; out pdB: Double; out pdC: Double;
                                               out pdD: Double; out pdH: Double; out pdK: Double); dispid 1610743930;
    procedure AttributeNodeCoordinatesFirst(out pnXPos: Smallint; out pnYPos: Smallint); dispid 1610743931;
    procedure AttributeNodeCoordinatesNext(out pnXPos: Smallint; out pnYPos: Smallint); dispid 1610743932;
    function AttributeAN: Smallint; dispid 1610743933;
    function AttributeClass: WideString; dispid 1610743934;
    property AttributeText: WideString dispid 1610743935;
    property AttributeTextStyle: Smallint dispid 1610743937;
    property AttributeTextJustification: Smallint dispid 1610743939;
    property AttributeTextFont: WideString dispid 1610743941;
    property AttributeTextFontSize: Smallint dispid 1610743943;
    property AttributeTextColour: Smallint dispid 1610743945;
    property PropertyVisibility: WideString dispid 1610743947;
    procedure PropertiesSymbolSetPut(nType: Smallint; const bstrExpression1: WideString;
                                     const bstrExpression2: WideString;
                                     const bstrExpression3: WideString;
                                     const bstrExpression4: WideString;
                                     const bstrExpression5: WideString); dispid 1610743949;
    procedure PropertiesSymbolSetGet(out pnType: Smallint; out pbstrExpression1: WideString;
                                     out pbstrExpression2: WideString;
                                     out pbstrExpression3: WideString;
                                     out pbstrExpression4: WideString;
                                     out pbstrExpression5: WideString); dispid 1610743950;
    procedure PropertiesSymbolSetSymbolPut(nIndex: Smallint; const bstrLibrary: WideString;
                                           const bstrElement: WideString); dispid 1610743951;
    procedure PropertiesSymbolSetSymbolGet(nIndex: Smallint; out pbstrLibrary: WideString;
                                           out pbstrElement: WideString); dispid 1610743952;
    procedure PropertiesDisplayValuePut(nType: Smallint; const bstrExpression1: WideString;
                                        const bstrExpression2: WideString;
                                        const bstrExpression3: WideString;
                                        const bstrExpression4: WideString;
                                        const bstrExpression5: WideString); dispid 1610743953;
    procedure PropertiesDisplayValueGet(out pnType: Smallint; out pbstrExpression1: WideString;
                                        out pbstrExpression2: WideString;
                                        out pbstrExpression3: WideString;
                                        out pbstrExpression4: WideString;
                                        out pbstrExpression5: WideString); dispid 1610743954;
    procedure PropertiesDisplayValueTextPut(nIndex: Smallint; const bstrText: WideString); dispid 1610743955;
    procedure PropertiesDisplayValueTextGet(nIndex: Smallint; out pbstrText: WideString); dispid 1610743956;
    procedure PropertiesButtonPut(nType: Smallint; const bstrText: WideString;
                                  const bstrFont: WideString; const bstrLibrary: WideString;
                                  const bstrElement: WideString); dispid 1610743957;
    procedure PropertiesButtonGet(out pnType: Smallint; out pbstrText: WideString;
                                  out pbstrFont: WideString; out pbstrLibrary: WideString;
                                  out pbstrElement: WideString); dispid 1610743958;
    procedure PropertiesTrendPut(nNumberOfSamples: Smallint; nPixelPerSample: Smallint;
                                 const bstrExpression1: WideString; nColour1: Smallint;
                                 const bstrExpression2: WideString; nColour2: Smallint;
                                 const bstrExpression3: WideString; nColour3: Smallint;
                                 const bstrExpression4: WideString; nColour4: Smallint;
                                 const bstrExpression5: WideString; nColour5: Smallint;
                                 const bstrExpression6: WideString; nColour6: Smallint;
                                 const bstrExpression7: WideString; nColour7: Smallint;
                                 const bstrExpression8: WideString; nColour8: Smallint); dispid 1610743959;
    procedure PropertiesTrendGet(out pnNumberOfSamples: Smallint; out pnPixelPerSample: Smallint;
                                 out pbstrExpression1: WideString; out pnColour1: Smallint;
                                 out pbstrExpression2: WideString; out pnColour2: Smallint;
                                 out pbstrExpression3: WideString; out pnColour3: Smallint;
                                 out pbstrExpression4: WideString; out pnColour4: Smallint;
                                 out pbstrExpression5: WideString; out pnColour5: Smallint;
                                 out pbstrExpression6: WideString; out pnColour6: Smallint;
                                 out pbstrExpression7: WideString; out pnColour7: Smallint;
                                 out pbstrExpression8: WideString; out pnColour8: Smallint); dispid 1610743960;
    procedure PropertiesCicodeObjectPut(const bstrExpression: WideString;
                                        const bstrLibrary: WideString; const bstrElement: WideString); dispid 1610743961;
    procedure PropertiesCicodeObjectGet(out pbstrExpression: WideString;
                                        out pbstrLibrary: WideString; out pbstrElement: WideString); dispid 1610743962;
    procedure PropertiesTransformationPut(nAction: Smallint; const bstrExpression: WideString;
                                          bRangeOrUpdate: WordBool; dRangeMin: Double;
                                          dRangeMax: Double; nOffsetMin: Smallint;
                                          nOffsetMax: Smallint; bCustom: WordBool;
                                          nCentreOffsetRight: Smallint; nCentreOffsetDown: Smallint); dispid 1610743963;
    procedure PropertiesTransformationGet(nAction: Smallint; out pbstrExpression: WideString;
                                          out pbRangeOrUpdate: WordBool; out pdRangeMin: Double;
                                          out pdRangeMax: Double; out pnOffsetMin: Smallint;
                                          out pnOffsetMax: Smallint; out pbCustom: WordBool;
                                          out pnCentreOffsetRight: Smallint;
                                          out pnCentreOffsetDown: Smallint); dispid 1610743964;
    procedure PropertiesFillColourPut(nType: Smallint; const bstrExpression1: WideString;
                                      const bstrExpression2: WideString;
                                      const bstrExpression3: WideString;
                                      const bstrExpression4: WideString;
                                      const bstrExpression5: WideString; bRangeOn: WordBool;
                                      dRangeMin: Double; dRangeMax: Double); dispid 1610743965;
    procedure PropertiesFillColourGet(out pnType: Smallint; out pbstrExpression1: WideString;
                                      out pbstrExpression2: WideString;
                                      out pbstrExpression3: WideString;
                                      out pbstrExpression4: WideString;
                                      out pbstrExpression5: WideString; out pbRangeOn: WordBool;
                                      out pdRangeMin: Double; out pdRangeMax: Double); dispid 1610743966;
    procedure PropertiesFillColourColourPut(nIndex: Smallint; nColour: Smallint; nLimit: Smallint;
                                            nOperator: Smallint); dispid 1610743967;
    procedure PropertiesFillColourColourGet(nIndex: Smallint; out pnColour: Smallint;
                                            out pnLimit: Smallint; out pnOperator: Smallint); dispid 1610743968;
    procedure PropertiesFillLevelPut(const bstrExpression: WideString; bRange: WordBool;
                                     dRangeMin: Double; dRangeMax: Double; nOffsetMin: Smallint;
                                     nOffsetMax: Smallint; nFillDirection: Smallint;
                                     nBackgroundColour: Smallint); dispid 1610743969;
    procedure PropertiesFillLevelGet(out pbstrExpression: WideString; out pbRange: WordBool;
                                     out pdRangeMin: Double; out pdRangeMax: Double;
                                     out pnOffsetMin: Smallint; out pnOffsetMax: Smallint;
                                     out pnFillDirection: Smallint; out pnBackgroundColour: Smallint); dispid 1610743970;
    procedure PropertiesInputTouchPut(nAction: Smallint; const bstrExpression: WideString;
                                      const bstrLogging: WideString; nRepeatRate: Smallint); dispid 1610743971;
    procedure PropertiesInputTouchGet(nAction: Smallint; out pbstrExpression: WideString;
                                      out pbstrLogging: WideString; out pnRepeatRate: Smallint); dispid 1610743972;
    procedure PropertiesInputKeyboardPut(nIndex: Smallint; const bstrKeySequence: WideString;
                                         const bstrCommand: WideString; nArea: Smallint;
                                         nPrivilege: Smallint; const bstrLogging: WideString); dispid 1610743973;
    procedure PropertiesInputKeyboardGet(nIndex: Smallint; out pbstrKeySequence: WideString;
                                         out pbstrCommand: WideString; out pnArea: Smallint;
                                         out pnPrivilege: Smallint; out pbstrLogging: WideString); dispid 1610743974;
    procedure PropertiesAccessGeneralPut(const bstrDescription: WideString;
                                         const bstrTooltip: WideString; nArea: Smallint;
                                         nPrivilege: Smallint; const bstrLogDevice: WideString); dispid 1610743975;
    procedure PropertiesAccessGeneralGet(out pbstrDescription: WideString;
                                         out pbstrTooltip: WideString; out pnArea: Smallint;
                                         out pnPrivilege: Smallint; out pbstrLogDevice: WideString); dispid 1610743976;
    procedure PropertiesAccessDisablePut(const bstrExpression: WideString; bInsufficient: WordBool;
                                         nDisableStyle: Smallint); dispid 1610743977;
    procedure PropertiesAccessDisableGet(out pbstrExpression: WideString;
                                         out pbInsufficient: WordBool; out pnDisableStyle: Smallint); dispid 1610743978;
    procedure PropertiesShowDialog; dispid 1610743979;
    property OptionDisplayPropertiesOnNew: WordBool dispid 1610743980;
    property OptionSnapToGrid: WordBool dispid 1610743982;
    property OptionSnapToGuidelines: WordBool dispid 1610743984;
    procedure ProjectSelect(const bstrProject: WideString); dispid 1610743986;
    function ProjectSelected: WideString; dispid 1610743987;
    function ProjectFirst: WideString; dispid 1610743988;
    function ProjectNext: WideString; dispid 1610743989;
    function ProjectFirstInclude: WideString; dispid 1610743990;
    function ProjectNextInclude: WideString; dispid 1610743991;
    procedure ProjectUpgrade; dispid 1610743992;
    procedure ProjectUpgradeAll; dispid 1610743993;
    procedure ProjectPackLibraries; dispid 1610743994;
    procedure ProjectUpdatePages(bFastUpdate: WordBool); dispid 1610743995;
    procedure ProjectPackDatabase; dispid 1610743996;
    procedure ProjectCompile; dispid 1610743997;
    procedure ClipboardCut; dispid 1610743998;
    procedure ClipboardCopy; dispid 1610743999;
    procedure ClipboardPaste; dispid 1610744000;
    procedure ConvertToBitmap; dispid 1610744001;
    property SelectionEventEnabled: WordBool dispid 1610744002;
    property BrokenLinkCancelEnabled: WordBool dispid 1610744004;
    procedure Quit; dispid 1610744006;
    procedure DisplayInStatusBar(const bstrStatusText: WideString); dispid 1610744007;
    procedure PageKeyboardCommandsPut(nIndex: Smallint; const bstrKeySequence: WideString;
                                      const bstrCommand: WideString; const nArea: WideString;
                                      const nPrivilege: WideString; const bstrLogging: WideString); dispid 1610744008;
    procedure PageKeyboardCommandsGet(nIndex: Smallint; out pbstrKeySequence: WideString;
                                      out pbstrCommand: WideString; out pnArea: WideString;
                                      out pnPrivilege: WideString; out pbstrLogging: WideString); dispid 1610744009;
    procedure PageSelect(const bstrBase: WideString; const bstrFile: WideString); dispid 1610744010;
    function AttributeXEx: Smallint; dispid 1610744011;
    function AttributeYEx: Smallint; dispid 1610744012;
    procedure PageSelectFirstObjectInGenie; dispid 1610744013;
    procedure PageSelectNextObjectInGenie; dispid 1610744014;
    procedure PropertiesTransCentreOffsetExpressGet(out movementRotationalExpress: Smallint;
                                                    out scalingHorizontalExpress: Smallint;
                                                    out scalingVerticalExpress: Smallint;
                                                    out sliderRotationalExpress: Smallint); dispid 1610744015;
    procedure PropertiesTransCentreOffsetExpressPut(movementRotationalExpress: Smallint;
                                                    scalingHorizontalExpress: Smallint;
                                                    scalingVerticalExpress: Smallint;
                                                    sliderRotationalExpress: Smallint); dispid 1610744016;
    procedure PageEnvironmentFirst(out property_: WideString; out value: WideString); dispid 1610744017;
    procedure PageEnvironmentNext(const currentProperty: WideString; out property_: WideString;
                                  out value: WideString); dispid 1610744018;
    procedure PageEnvironmentAdd(const property_: WideString; const value: WideString); dispid 1610744019;
    procedure PageEnvironmentRemove(const property_: WideString); dispid 1610744020;
    procedure PageEventsGet(out pbstrEventOnEntryCommand: WideString;
                            out pbstrEventOnExitCommand: WideString;
                            out pbstrEventWhileShownCommand: WideString;
                            out pbstrEventOnShownCommand: WideString); dispid 1610744021;
    procedure PageEventsPut(const bstrEventOnEntryCommand: WideString;
                            const bstrEventOnExitCommand: WideString;
                            const bstrEventWhileShownCommand: WideString;
                            const bstrEventOnShownCommand: WideString); dispid 1610744022;
    procedure PageTemplateSelectFirstObject; dispid 1610744023;
    procedure PageTemplateSelectNextObject; dispid 1610744024;
    procedure LockObject; dispid 1610744025;
    procedure UnLockObject; dispid 1610744026;
    property BreakLockMode: WordBool dispid 1610744027;
    property AttributeRawOrient: Smallint readonly dispid 1610744029;
    procedure PageAppearanceSet(const templateStyle: WideString; const templateName: WideString;
                                resolution: Smallint; titlebar: WordBool; width: Smallint;
                                height: Smallint; colour: Smallint); dispid 1610744030;
    procedure _Reserved15; dispid 1610744031;
    procedure _Reserved16; dispid 1610744032;
    procedure _Reserved17; dispid 1610744033;
    procedure _Reserved18; dispid 1610744034;
    procedure _Reserved19; dispid 1610744035;
    procedure _Reserved20; dispid 1610744036;
    procedure _Reserved21; dispid 1610744037;
    procedure _Reserved22; dispid 1610744038;
    procedure _Reserved23; dispid 1610744039;
    procedure _Reserved24; dispid 1610744040;
    procedure _Reserved25; dispid 1610744041;
    procedure _Reserved26; dispid 1610744042;
    procedure _Reserved27; dispid 1610744043;
    procedure _Reserved28; dispid 1610744044;
    procedure _Reserved29; dispid 1610744045;
    procedure _Reserved30; dispid 1610744046;
  end;

// *********************************************************************//
// Interface: IGraphicsBuilder2
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {6E6B1CF1-73D9-40FA-BF54-DA82E3B6E01B}
// *********************************************************************//
  IGraphicsBuilder2 = interface(IGraphicsBuilder)
    ['{6E6B1CF1-73D9-40FA-BF54-DA82E3B6E01B}']
    procedure PageAppearanceGetEx(out pbstrProject: WideString; out pbstrStyle: WideString;
                                  out pbstrTemplate: WideString; out pnResolution: Smallint;
                                  out pbTitlebar: WordBool; out pnWidth: Smallint;
                                  out pnHeight: Smallint; out pBackOnColour: Integer;
                                  out pBackOffColour: Integer); safecall;
    procedure Set_AttributeLineOnColourEx(retval: Integer); safecall;
    function Get_AttributeLineOnColourEx: Integer; safecall;
    procedure Set_AttributeLineOffColourEx(retval: Integer); safecall;
    function Get_AttributeLineOffColourEx: Integer; safecall;
    procedure Set_AttributeFillOnColourEx(retval: Integer); safecall;
    function Get_AttributeFillOnColourEx: Integer; safecall;
    procedure Set_AttributeFillOffColourEx(retval: Integer); safecall;
    function Get_AttributeFillOffColourEx: Integer; safecall;
    procedure Set_AttributeShadowOnColourEx(retval: Integer); safecall;
    function Get_AttributeShadowOnColourEx: Integer; safecall;
    procedure Set_AttributeShadowOffColourEx(retval: Integer); safecall;
    function Get_AttributeShadowOffColourEx: Integer; safecall;
    procedure Set_AttributeHiLightOnColourEx(retval: Integer); safecall;
    function Get_AttributeHiLightOnColourEx: Integer; safecall;
    procedure Set_AttributeHiLightOffColourEx(retval: Integer); safecall;
    function Get_AttributeHiLightOffColourEx: Integer; safecall;
    procedure Set_AttributeLoLightOnColourEx(retval: Integer); safecall;
    function Get_AttributeLoLightOnColourEx: Integer; safecall;
    procedure Set_AttributeLoLightOffColourEx(retval: Integer); safecall;
    function Get_AttributeLoLightOffColourEx: Integer; safecall;
    procedure Set_AttributeTextOnColourEx(retval: Integer); safecall;
    function Get_AttributeTextOnColourEx: Integer; safecall;
    procedure Set_AttributeTextOffColourEx(retval: Integer); safecall;
    function Get_AttributeTextOffColourEx: Integer; safecall;
    procedure PropertiesTrendPutEx(nNumberOfSamples: Smallint; nPixelPerSample: Smallint;
                                   const bstrExpression1: WideString; Pen1OnColour: Integer;
                                   Pen1OffColour: Integer; const bstrExpression2: WideString;
                                   Pen2OnColour: Integer; Pen2OffColour: Integer;
                                   const bstrExpression3: WideString; Pen3OnColour: Integer;
                                   Pen3OffColour: Integer; const bstrExpression4: WideString;
                                   Pen4OnColour: Integer; Pen4OffColour: Integer;
                                   const bstrExpression5: WideString; Pen5OnColour: Integer;
                                   Pen5OffColour: Integer; const bstrExpression6: WideString;
                                   Pen6OnColour: Integer; Pen6OffColour: Integer;
                                   const bstrExpression7: WideString; Pen7OnColour: Integer;
                                   Pen7OffColour: Integer; const bstrExpression8: WideString;
                                   Pen8OnColour: Integer; Pen8OffColour: Integer); safecall;
    procedure PropertiesTrendGetEx(out pnNumberOfSamples: Smallint; out pnPixelPerSample: Smallint;
                                   out pbstrExpression1: WideString; out pPen1OnColour: Integer;
                                   var pPen1OffColour: Integer; out pbstrExpression2: WideString;
                                   out pPen2OnColour: Integer; var pPen2OffColour: Integer;
                                   out pbstrExpression3: WideString; out pPen3OnColour: Integer;
                                   var pPen3OffColour: Integer; out pbstrExpression4: WideString;
                                   out pPen4OnColour: Integer; var pPen4OffColour: Integer;
                                   out pbstrExpression5: WideString; out pPen5OnColour: Integer;
                                   var pPen5OffColour: Integer; out pbstrExpression6: WideString;
                                   out pPen6OnColour: Integer; var pPen6OffColour: Integer;
                                   out pbstrExpression7: WideString; out pPen7OnColour: Integer;
                                   var pPen7OffColour: Integer; out pbstrExpression8: WideString;
                                   out pPen8OnColour: Integer; var pPen8OffColour: Integer); safecall;
    procedure PropertiesFillColourColourPutEx(nIndex: Smallint; OnColour: Integer;
                                              OfColour: Integer; nLimit: Smallint;
                                              nOperator: Smallint); safecall;
    procedure PropertiesFillColourColourGetEx(nIndex: Smallint; out pOnColour: Integer;
                                              out pOffColour: Integer; out pnLimit: Smallint;
                                              out pnOperator: Smallint); safecall;
    procedure PropertiesFillLevelPutEx(const bstrExpression: WideString; bRange: WordBool;
                                       dRangeMin: Double; dRangeMax: Double; nOffsetMin: Smallint;
                                       nOffsetMax: Smallint; nFillDirection: Smallint;
                                       BackOnColour: Integer; BackOffColour: Integer); safecall;
    procedure PropertiesFillLevelGetEx(out pbstrExpression: WideString; out pbRange: WordBool;
                                       out pdRangeMin: Double; out pdRangeMax: Double;
                                       out pnOffsetMin: Smallint; out pnOffsetMax: Smallint;
                                       out pnFillDirection: Smallint; out pBackOnColour: Integer;
                                       out pBackOffColour: Integer); safecall;
    procedure Set_AttributeCornerRadius(retval: Smallint); safecall;
    function Get_AttributeCornerRadius: Smallint; safecall;
    procedure Set_AttributeGradientOnColour(retval: Integer); safecall;
    function Get_AttributeGradientOnColour: Integer; safecall;
    procedure Set_AttributeGradientOffColour(retval: Integer); safecall;
    function Get_AttributeGradientOffColour: Integer; safecall;
    procedure Set_AttributeGradientMode(retval: Smallint); safecall;
    function Get_AttributeGradientMode: Smallint; safecall;
    procedure PageAppearanceSetEx(const templateStyle: WideString; const templateName: WideString;
                                  resolution: Smallint; titlebar: WordBool; width: Smallint;
                                  height: Smallint; BackOnColour: Integer; BackOffColour: Integer); safecall;
    function ClipboardCopyEx: Integer; safecall;
    procedure Set_PageClusterName(const retval: WideString); safecall;
    function Get_PageClusterName: WideString; safecall;
    procedure Set_PageClusterInherit(retval: WordBool); safecall;
    function Get_PageClusterInherit: WordBool; safecall;
    property AttributeLineOnColourEx: Integer read Get_AttributeLineOnColourEx write Set_AttributeLineOnColourEx;
    property AttributeLineOffColourEx: Integer read Get_AttributeLineOffColourEx write Set_AttributeLineOffColourEx;
    property AttributeFillOnColourEx: Integer read Get_AttributeFillOnColourEx write Set_AttributeFillOnColourEx;
    property AttributeFillOffColourEx: Integer read Get_AttributeFillOffColourEx write Set_AttributeFillOffColourEx;
    property AttributeShadowOnColourEx: Integer read Get_AttributeShadowOnColourEx write Set_AttributeShadowOnColourEx;
    property AttributeShadowOffColourEx: Integer read Get_AttributeShadowOffColourEx write Set_AttributeShadowOffColourEx;
    property AttributeHiLightOnColourEx: Integer read Get_AttributeHiLightOnColourEx write Set_AttributeHiLightOnColourEx;
    property AttributeHiLightOffColourEx: Integer read Get_AttributeHiLightOffColourEx write Set_AttributeHiLightOffColourEx;
    property AttributeLoLightOnColourEx: Integer read Get_AttributeLoLightOnColourEx write Set_AttributeLoLightOnColourEx;
    property AttributeLoLightOffColourEx: Integer read Get_AttributeLoLightOffColourEx write Set_AttributeLoLightOffColourEx;
    property AttributeTextOnColourEx: Integer read Get_AttributeTextOnColourEx write Set_AttributeTextOnColourEx;
    property AttributeTextOffColourEx: Integer read Get_AttributeTextOffColourEx write Set_AttributeTextOffColourEx;
    property AttributeCornerRadius: Smallint read Get_AttributeCornerRadius write Set_AttributeCornerRadius;
    property AttributeGradientOnColour: Integer read Get_AttributeGradientOnColour write Set_AttributeGradientOnColour;
    property AttributeGradientOffColour: Integer read Get_AttributeGradientOffColour write Set_AttributeGradientOffColour;
    property AttributeGradientMode: Smallint read Get_AttributeGradientMode write Set_AttributeGradientMode;
    property PageClusterName: WideString read Get_PageClusterName write Set_PageClusterName;
    property PageClusterInherit: WordBool read Get_PageClusterInherit write Set_PageClusterInherit;
  end;

// *********************************************************************//
// DispIntf:  IGraphicsBuilder2Disp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {6E6B1CF1-73D9-40FA-BF54-DA82E3B6E01B}
// *********************************************************************//
  IGraphicsBuilder2Disp = dispinterface
    ['{6E6B1CF1-73D9-40FA-BF54-DA82E3B6E01B}']
    procedure PageAppearanceGetEx(out pbstrProject: WideString; out pbstrStyle: WideString;
                                  out pbstrTemplate: WideString; out pnResolution: Smallint;
                                  out pbTitlebar: WordBool; out pnWidth: Smallint;
                                  out pnHeight: Smallint; out pBackOnColour: Integer;
                                  out pBackOffColour: Integer); dispid 1610809344;
    property AttributeLineOnColourEx: Integer dispid 1610809345;
    property AttributeLineOffColourEx: Integer dispid 1610809347;
    property AttributeFillOnColourEx: Integer dispid 1610809349;
    property AttributeFillOffColourEx: Integer dispid 1610809351;
    property AttributeShadowOnColourEx: Integer dispid 1610809353;
    property AttributeShadowOffColourEx: Integer dispid 1610809355;
    property AttributeHiLightOnColourEx: Integer dispid 1610809357;
    property AttributeHiLightOffColourEx: Integer dispid 1610809359;
    property AttributeLoLightOnColourEx: Integer dispid 1610809361;
    property AttributeLoLightOffColourEx: Integer dispid 1610809363;
    property AttributeTextOnColourEx: Integer dispid 1610809365;
    property AttributeTextOffColourEx: Integer dispid 1610809367;
    procedure PropertiesTrendPutEx(nNumberOfSamples: Smallint; nPixelPerSample: Smallint;
                                   const bstrExpression1: WideString; Pen1OnColour: Integer;
                                   Pen1OffColour: Integer; const bstrExpression2: WideString;
                                   Pen2OnColour: Integer; Pen2OffColour: Integer;
                                   const bstrExpression3: WideString; Pen3OnColour: Integer;
                                   Pen3OffColour: Integer; const bstrExpression4: WideString;
                                   Pen4OnColour: Integer; Pen4OffColour: Integer;
                                   const bstrExpression5: WideString; Pen5OnColour: Integer;
                                   Pen5OffColour: Integer; const bstrExpression6: WideString;
                                   Pen6OnColour: Integer; Pen6OffColour: Integer;
                                   const bstrExpression7: WideString; Pen7OnColour: Integer;
                                   Pen7OffColour: Integer; const bstrExpression8: WideString;
                                   Pen8OnColour: Integer; Pen8OffColour: Integer); dispid 1610809369;
    procedure PropertiesTrendGetEx(out pnNumberOfSamples: Smallint; out pnPixelPerSample: Smallint;
                                   out pbstrExpression1: WideString; out pPen1OnColour: Integer;
                                   var pPen1OffColour: Integer; out pbstrExpression2: WideString;
                                   out pPen2OnColour: Integer; var pPen2OffColour: Integer;
                                   out pbstrExpression3: WideString; out pPen3OnColour: Integer;
                                   var pPen3OffColour: Integer; out pbstrExpression4: WideString;
                                   out pPen4OnColour: Integer; var pPen4OffColour: Integer;
                                   out pbstrExpression5: WideString; out pPen5OnColour: Integer;
                                   var pPen5OffColour: Integer; out pbstrExpression6: WideString;
                                   out pPen6OnColour: Integer; var pPen6OffColour: Integer;
                                   out pbstrExpression7: WideString; out pPen7OnColour: Integer;
                                   var pPen7OffColour: Integer; out pbstrExpression8: WideString;
                                   out pPen8OnColour: Integer; var pPen8OffColour: Integer); dispid 1610809370;
    procedure PropertiesFillColourColourPutEx(nIndex: Smallint; OnColour: Integer;
                                              OfColour: Integer; nLimit: Smallint;
                                              nOperator: Smallint); dispid 1610809371;
    procedure PropertiesFillColourColourGetEx(nIndex: Smallint; out pOnColour: Integer;
                                              out pOffColour: Integer; out pnLimit: Smallint;
                                              out pnOperator: Smallint); dispid 1610809372;
    procedure PropertiesFillLevelPutEx(const bstrExpression: WideString; bRange: WordBool;
                                       dRangeMin: Double; dRangeMax: Double; nOffsetMin: Smallint;
                                       nOffsetMax: Smallint; nFillDirection: Smallint;
                                       BackOnColour: Integer; BackOffColour: Integer); dispid 1610809373;
    procedure PropertiesFillLevelGetEx(out pbstrExpression: WideString; out pbRange: WordBool;
                                       out pdRangeMin: Double; out pdRangeMax: Double;
                                       out pnOffsetMin: Smallint; out pnOffsetMax: Smallint;
                                       out pnFillDirection: Smallint; out pBackOnColour: Integer;
                                       out pBackOffColour: Integer); dispid 1610809374;
    property AttributeCornerRadius: Smallint dispid 1610809375;
    property AttributeGradientOnColour: Integer dispid 1610809377;
    property AttributeGradientOffColour: Integer dispid 1610809379;
    property AttributeGradientMode: Smallint dispid 1610809381;
    procedure PageAppearanceSetEx(const templateStyle: WideString; const templateName: WideString;
                                  resolution: Smallint; titlebar: WordBool; width: Smallint;
                                  height: Smallint; BackOnColour: Integer; BackOffColour: Integer); dispid 1610809383;
    function ClipboardCopyEx: Integer; dispid 1610809384;
    property PageClusterName: WideString dispid 1610809385;
    property PageClusterInherit: WordBool dispid 1610809387;
    property Visible: WordBool dispid 1610743808;
    procedure PageNew(const bstrProject: WideString; const bstrStyle: WideString;
                      const bstrTemplate: WideString; nResolution: Smallint; bTitlebar: WordBool;
                      bLinked: WordBool); dispid 1610743810;
    procedure PageNewEx(nPageType: Smallint); dispid 1610743811;
    procedure PageNewTemplate(const bstrProject: WideString; const bstrStyle: WideString;
                              const bstrTemplate: WideString; nResolution: Smallint;
                              bTitlebar: WordBool; bLinked: WordBool); dispid 1610743812;
    procedure PageOpen(const bstrProject: WideString; const bstrFile: WideString); dispid 1610743813;
    procedure PageOpenEx(const bstrProject: WideString; const bstrLibrary: WideString;
                         const bstrElement: WideString; nPageType: Smallint); dispid 1610743814;
    procedure PageOpenTemplate(const bstrProject: WideString; const bstrStyle: WideString;
                               const bstrTemplate: WideString; nResolution: Smallint;
                               bTitlebar: WordBool); dispid 1610743815;
    procedure PageSelectFirst; dispid 1610743816;
    procedure PageSelectNext; dispid 1610743817;
    procedure PageSave; dispid 1610743818;
    procedure PageSaveAs(const bstrProject: WideString; const bstrFile: WideString); dispid 1610743819;
    procedure PageSaveAsEx(const bstrProject: WideString; const bstrLibrary: WideString;
                           const bstrElement: WideString); dispid 1610743820;
    procedure PageClose; dispid 1610743821;
    procedure PageDelete(const bstrProject: WideString; const bstrFile: WideString;
                         bDeleteAssociatedRecords: WordBool); dispid 1610743822;
    procedure PageDeleteEx(const bstrProject: WideString; const bstrLibrary: WideString;
                           const bstrElement: WideString; nPageType: Smallint); dispid 1610743823;
    procedure PageDeleteTemplate(const bstrProject: WideString; const bstrStyle: WideString;
                                 const bstrTemplate: WideString; nResolution: Smallint;
                                 bTitlebar: WordBool); dispid 1610743824;
    procedure PageNewLibrary(const bstrProject: WideString; const bstrLibrary: WideString;
                             nPageType: Smallint); dispid 1610743825;
    procedure PageSelectFirstObject; dispid 1610743826;
    procedure PageSelectNextObject; dispid 1610743827;
    procedure PageSelectFirstObjectEx; dispid 1610743828;
    procedure PageSelectNextObjectEx; dispid 1610743829;
    procedure PageSelectFirstObjectInGroup; dispid 1610743830;
    procedure PageSelectNextObjectInGroup; dispid 1610743831;
    procedure PageSelectObject(nAN: Smallint); dispid 1610743832;
    procedure PageSelectObjectAdd(nAN: Smallint); dispid 1610743833;
    procedure PageGroupSelectedObjects; dispid 1610743834;
    procedure PageUngroupSelectedObject; dispid 1610743835;
    procedure PageDeleteObject; dispid 1610743836;
    function PageActiveWindowHandle: Integer; dispid 1610743837;
    procedure PageConvertWindowCoordinates(var pnXPos: Smallint; var pnYPos: Smallint); dispid 1610743838;
    procedure PagePrint; dispid 1610743839;
    procedure PageImport(const bstrFile: WideString); dispid 1610743840;
    procedure PageThumbnailToClipboard(nSize: Smallint); dispid 1610743841;
    function PageName: WideString; dispid 1610743842;
    property PageTitle: WideString dispid 1610743843;
    property PageDescription: WideString dispid 1610743845;
    property PagePrevious: WideString dispid 1610743847;
    property PageNext: WideString dispid 1610743849;
    property PageArea: WideString dispid 1610743851;
    property PageScanTime: WideString dispid 1610743853;
    property PageLogDevice: WideString dispid 1610743855;
    procedure PageAppearanceGet(out pbstrProject: WideString; out pbstrStyle: WideString;
                                out pbstrTemplate: WideString; out pnResolution: Smallint;
                                out pbTitlebar: WordBool; out pnWidth: Smallint;
                                out pnHight: Smallint; out pnColour: Smallint); dispid 1610743857;
    procedure LibraryObjectPlace(const bstrProject: WideString; const bstrLibrary: WideString;
                                 const bstrElement: WideString; nLibraryObjectType: Smallint;
                                 bLinked: WordBool); dispid 1610743858;
    procedure LibraryObjectPlaceEx(const bstrProject: WideString; const bstrLibrary: WideString;
                                   const bstrElement: WideString; nLibraryObjectType: Smallint;
                                   bLinked: WordBool; nXPos: Smallint; nYPos: Smallint); dispid 1610743859;
    procedure LibraryObjectFirstProperty(out pbstrPropertyName: WideString;
                                         out pbstrPropertyValue: WideString); dispid 1610743860;
    procedure LibraryObjectNextProperty(out pbstrPropertyName: WideString;
                                        out pbstrPropertyValue: WideString); dispid 1610743861;
    procedure LibraryObjectPutProperty(const bstrPropertyName: WideString;
                                       const bstrPropertyValue: WideString); dispid 1610743862;
    procedure LibraryObjectFirstPropertyEx(const bstrProject: WideString;
                                           const bstrLibrary: WideString;
                                           const bstrElement: WideString;
                                           out pbstrPropertyName: WideString;
                                           out pbstrPropertyValue: WideString); dispid 1610743863;
    procedure LibraryObjectNextPropertyEx(out pbstrPropertyName: WideString;
                                          out pbstrPropertyValue: WideString); dispid 1610743864;
    procedure LibraryObjectName(out bstrProject: WideString; out pbstrLibrary: WideString;
                                out pbstrElement: WideString; out pnLibObjectType: Smallint); dispid 1610743865;
    procedure LibraryObjectHotspotPut(nXPos: Smallint; nYPos: Smallint); dispid 1610743866;
    procedure LibraryObjectHotspotGet(out pnXPos: Smallint; out pnYPos: Smallint); dispid 1610743867;
    procedure LibraryShowPasteDialog(nLibraryObjectType: Smallint); dispid 1610743868;
    property LibrarySelectionHooksEnabled: WordBool dispid 1610743869;
    procedure PositionAt(nXPos: Smallint; nYPos: Smallint); dispid 1610743871;
    procedure PositionRotate; dispid 1610743872;
    procedure PositionMirrorVertical; dispid 1610743873;
    procedure PositionMirrorHorizontal; dispid 1610743874;
    procedure PositionSendToBack; dispid 1610743875;
    procedure PositionBringToFront; dispid 1610743876;
    procedure PositionBringForwards; dispid 1610743877;
    procedure PositionSendBackwards; dispid 1610743878;
    procedure DrawLine(nXPos: Smallint; nYPos: Smallint; nXPosEnd: Smallint; nYPosEnd: Smallint); dispid 1610743879;
    procedure DrawRectangle(nXPos: Smallint; nYPos: Smallint; nXPosEnd: Smallint; nYPosEnd: Smallint); dispid 1610743880;
    procedure DrawEllipse(nXPos: Smallint; nYPos: Smallint; nXPosEnd: Smallint; nYPosEnd: Smallint); dispid 1610743881;
    procedure DrawPolygonStart(nXPos: Smallint; nYPos: Smallint); dispid 1610743882;
    procedure DrawPolygonLine(nXPos: Smallint; nYPos: Smallint); dispid 1610743883;
    procedure DrawPolygonEnd; dispid 1610743884;
    procedure DrawPipeStart(nXPos: Smallint; nYPos: Smallint); dispid 1610743885;
    procedure DrawPipeSection(nXPos: Smallint; nYPos: Smallint); dispid 1610743886;
    procedure DrawPipeEnd; dispid 1610743887;
    procedure DrawText(const bstrText: WideString; nXPos: Smallint; nYPos: Smallint); dispid 1610743888;
    procedure DrawNumber(nXPos: Smallint; nYPos: Smallint); dispid 1610743889;
    procedure DrawButton(nXPos: Smallint; nYPos: Smallint; nXPosEnd: Smallint; nYPosEnd: Smallint); dispid 1610743890;
    procedure DrawSymbolSet(nXPos: Smallint; nYPos: Smallint); dispid 1610743891;
    procedure DrawTrend(nXPos: Smallint; nYPos: Smallint; nXPosEnd: Smallint; nYPosEnd: Smallint); dispid 1610743892;
    procedure DrawCicodeObject(nXPos: Smallint; nYPos: Smallint); dispid 1610743893;
    property AttributeLineWidth: Smallint dispid 1610743894;
    property AttributeLineStyle: Smallint dispid 1610743896;
    property AttributeLineColour: Smallint dispid 1610743898;
    property AttributeSetFill: Smallint dispid 1610743900;
    property AttributeFillColour: Smallint dispid 1610743902;
    property Attribute3dEffects: Smallint dispid 1610743904;
    property Attribute3dEffectDepth: Smallint dispid 1610743906;
    property AttributeShadowColour: Smallint dispid 1610743908;
    property AttributeHiLightColour: Smallint dispid 1610743910;
    property AttributeLoLightColour: Smallint dispid 1610743912;
    property AttributeRectangleStyle: Smallint dispid 1610743914;
    property AttributeStartAngle: Smallint dispid 1610743916;
    property AttributeEndAngle: Smallint dispid 1610743918;
    property AttributeEllipseStyle: Smallint dispid 1610743920;
    property AttributePolygonOpen: Smallint dispid 1610743922;
    function AttributeX: Smallint; dispid 1610743924;
    function AttributeY: Smallint; dispid 1610743925;
    function AttributeExtentX: Smallint; dispid 1610743926;
    function AttributeExtentY: Smallint; dispid 1610743927;
    procedure AttributeBaseCoordinates(out pnXPos: Smallint; out pnYPos: Smallint;
                                       out pnXPosEnd: Smallint; out pnYPosEnd: Smallint); dispid 1610743928;
    procedure AttributeTransformationMatrixPut(dA: Double; dB: Double; dC: Double; dD: Double;
                                               dH: Double; dK: Double); dispid 1610743929;
    procedure AttributeTransformationMatrixGet(out pdA: Double; out pdB: Double; out pdC: Double;
                                               out pdD: Double; out pdH: Double; out pdK: Double); dispid 1610743930;
    procedure AttributeNodeCoordinatesFirst(out pnXPos: Smallint; out pnYPos: Smallint); dispid 1610743931;
    procedure AttributeNodeCoordinatesNext(out pnXPos: Smallint; out pnYPos: Smallint); dispid 1610743932;
    function AttributeAN: Smallint; dispid 1610743933;
    function AttributeClass: WideString; dispid 1610743934;
    property AttributeText: WideString dispid 1610743935;
    property AttributeTextStyle: Smallint dispid 1610743937;
    property AttributeTextJustification: Smallint dispid 1610743939;
    property AttributeTextFont: WideString dispid 1610743941;
    property AttributeTextFontSize: Smallint dispid 1610743943;
    property AttributeTextColour: Smallint dispid 1610743945;
    property PropertyVisibility: WideString dispid 1610743947;
    procedure PropertiesSymbolSetPut(nType: Smallint; const bstrExpression1: WideString;
                                     const bstrExpression2: WideString;
                                     const bstrExpression3: WideString;
                                     const bstrExpression4: WideString;
                                     const bstrExpression5: WideString); dispid 1610743949;
    procedure PropertiesSymbolSetGet(out pnType: Smallint; out pbstrExpression1: WideString;
                                     out pbstrExpression2: WideString;
                                     out pbstrExpression3: WideString;
                                     out pbstrExpression4: WideString;
                                     out pbstrExpression5: WideString); dispid 1610743950;
    procedure PropertiesSymbolSetSymbolPut(nIndex: Smallint; const bstrLibrary: WideString;
                                           const bstrElement: WideString); dispid 1610743951;
    procedure PropertiesSymbolSetSymbolGet(nIndex: Smallint; out pbstrLibrary: WideString;
                                           out pbstrElement: WideString); dispid 1610743952;
    procedure PropertiesDisplayValuePut(nType: Smallint; const bstrExpression1: WideString;
                                        const bstrExpression2: WideString;
                                        const bstrExpression3: WideString;
                                        const bstrExpression4: WideString;
                                        const bstrExpression5: WideString); dispid 1610743953;
    procedure PropertiesDisplayValueGet(out pnType: Smallint; out pbstrExpression1: WideString;
                                        out pbstrExpression2: WideString;
                                        out pbstrExpression3: WideString;
                                        out pbstrExpression4: WideString;
                                        out pbstrExpression5: WideString); dispid 1610743954;
    procedure PropertiesDisplayValueTextPut(nIndex: Smallint; const bstrText: WideString); dispid 1610743955;
    procedure PropertiesDisplayValueTextGet(nIndex: Smallint; out pbstrText: WideString); dispid 1610743956;
    procedure PropertiesButtonPut(nType: Smallint; const bstrText: WideString;
                                  const bstrFont: WideString; const bstrLibrary: WideString;
                                  const bstrElement: WideString); dispid 1610743957;
    procedure PropertiesButtonGet(out pnType: Smallint; out pbstrText: WideString;
                                  out pbstrFont: WideString; out pbstrLibrary: WideString;
                                  out pbstrElement: WideString); dispid 1610743958;
    procedure PropertiesTrendPut(nNumberOfSamples: Smallint; nPixelPerSample: Smallint;
                                 const bstrExpression1: WideString; nColour1: Smallint;
                                 const bstrExpression2: WideString; nColour2: Smallint;
                                 const bstrExpression3: WideString; nColour3: Smallint;
                                 const bstrExpression4: WideString; nColour4: Smallint;
                                 const bstrExpression5: WideString; nColour5: Smallint;
                                 const bstrExpression6: WideString; nColour6: Smallint;
                                 const bstrExpression7: WideString; nColour7: Smallint;
                                 const bstrExpression8: WideString; nColour8: Smallint); dispid 1610743959;
    procedure PropertiesTrendGet(out pnNumberOfSamples: Smallint; out pnPixelPerSample: Smallint;
                                 out pbstrExpression1: WideString; out pnColour1: Smallint;
                                 out pbstrExpression2: WideString; out pnColour2: Smallint;
                                 out pbstrExpression3: WideString; out pnColour3: Smallint;
                                 out pbstrExpression4: WideString; out pnColour4: Smallint;
                                 out pbstrExpression5: WideString; out pnColour5: Smallint;
                                 out pbstrExpression6: WideString; out pnColour6: Smallint;
                                 out pbstrExpression7: WideString; out pnColour7: Smallint;
                                 out pbstrExpression8: WideString; out pnColour8: Smallint); dispid 1610743960;
    procedure PropertiesCicodeObjectPut(const bstrExpression: WideString;
                                        const bstrLibrary: WideString; const bstrElement: WideString); dispid 1610743961;
    procedure PropertiesCicodeObjectGet(out pbstrExpression: WideString;
                                        out pbstrLibrary: WideString; out pbstrElement: WideString); dispid 1610743962;
    procedure PropertiesTransformationPut(nAction: Smallint; const bstrExpression: WideString;
                                          bRangeOrUpdate: WordBool; dRangeMin: Double;
                                          dRangeMax: Double; nOffsetMin: Smallint;
                                          nOffsetMax: Smallint; bCustom: WordBool;
                                          nCentreOffsetRight: Smallint; nCentreOffsetDown: Smallint); dispid 1610743963;
    procedure PropertiesTransformationGet(nAction: Smallint; out pbstrExpression: WideString;
                                          out pbRangeOrUpdate: WordBool; out pdRangeMin: Double;
                                          out pdRangeMax: Double; out pnOffsetMin: Smallint;
                                          out pnOffsetMax: Smallint; out pbCustom: WordBool;
                                          out pnCentreOffsetRight: Smallint;
                                          out pnCentreOffsetDown: Smallint); dispid 1610743964;
    procedure PropertiesFillColourPut(nType: Smallint; const bstrExpression1: WideString;
                                      const bstrExpression2: WideString;
                                      const bstrExpression3: WideString;
                                      const bstrExpression4: WideString;
                                      const bstrExpression5: WideString; bRangeOn: WordBool;
                                      dRangeMin: Double; dRangeMax: Double); dispid 1610743965;
    procedure PropertiesFillColourGet(out pnType: Smallint; out pbstrExpression1: WideString;
                                      out pbstrExpression2: WideString;
                                      out pbstrExpression3: WideString;
                                      out pbstrExpression4: WideString;
                                      out pbstrExpression5: WideString; out pbRangeOn: WordBool;
                                      out pdRangeMin: Double; out pdRangeMax: Double); dispid 1610743966;
    procedure PropertiesFillColourColourPut(nIndex: Smallint; nColour: Smallint; nLimit: Smallint;
                                            nOperator: Smallint); dispid 1610743967;
    procedure PropertiesFillColourColourGet(nIndex: Smallint; out pnColour: Smallint;
                                            out pnLimit: Smallint; out pnOperator: Smallint); dispid 1610743968;
    procedure PropertiesFillLevelPut(const bstrExpression: WideString; bRange: WordBool;
                                     dRangeMin: Double; dRangeMax: Double; nOffsetMin: Smallint;
                                     nOffsetMax: Smallint; nFillDirection: Smallint;
                                     nBackgroundColour: Smallint); dispid 1610743969;
    procedure PropertiesFillLevelGet(out pbstrExpression: WideString; out pbRange: WordBool;
                                     out pdRangeMin: Double; out pdRangeMax: Double;
                                     out pnOffsetMin: Smallint; out pnOffsetMax: Smallint;
                                     out pnFillDirection: Smallint; out pnBackgroundColour: Smallint); dispid 1610743970;
    procedure PropertiesInputTouchPut(nAction: Smallint; const bstrExpression: WideString;
                                      const bstrLogging: WideString; nRepeatRate: Smallint); dispid 1610743971;
    procedure PropertiesInputTouchGet(nAction: Smallint; out pbstrExpression: WideString;
                                      out pbstrLogging: WideString; out pnRepeatRate: Smallint); dispid 1610743972;
    procedure PropertiesInputKeyboardPut(nIndex: Smallint; const bstrKeySequence: WideString;
                                         const bstrCommand: WideString; nArea: Smallint;
                                         nPrivilege: Smallint; const bstrLogging: WideString); dispid 1610743973;
    procedure PropertiesInputKeyboardGet(nIndex: Smallint; out pbstrKeySequence: WideString;
                                         out pbstrCommand: WideString; out pnArea: Smallint;
                                         out pnPrivilege: Smallint; out pbstrLogging: WideString); dispid 1610743974;
    procedure PropertiesAccessGeneralPut(const bstrDescription: WideString;
                                         const bstrTooltip: WideString; nArea: Smallint;
                                         nPrivilege: Smallint; const bstrLogDevice: WideString); dispid 1610743975;
    procedure PropertiesAccessGeneralGet(out pbstrDescription: WideString;
                                         out pbstrTooltip: WideString; out pnArea: Smallint;
                                         out pnPrivilege: Smallint; out pbstrLogDevice: WideString); dispid 1610743976;
    procedure PropertiesAccessDisablePut(const bstrExpression: WideString; bInsufficient: WordBool;
                                         nDisableStyle: Smallint); dispid 1610743977;
    procedure PropertiesAccessDisableGet(out pbstrExpression: WideString;
                                         out pbInsufficient: WordBool; out pnDisableStyle: Smallint); dispid 1610743978;
    procedure PropertiesShowDialog; dispid 1610743979;
    property OptionDisplayPropertiesOnNew: WordBool dispid 1610743980;
    property OptionSnapToGrid: WordBool dispid 1610743982;
    property OptionSnapToGuidelines: WordBool dispid 1610743984;
    procedure ProjectSelect(const bstrProject: WideString); dispid 1610743986;
    function ProjectSelected: WideString; dispid 1610743987;
    function ProjectFirst: WideString; dispid 1610743988;
    function ProjectNext: WideString; dispid 1610743989;
    function ProjectFirstInclude: WideString; dispid 1610743990;
    function ProjectNextInclude: WideString; dispid 1610743991;
    procedure ProjectUpgrade; dispid 1610743992;
    procedure ProjectUpgradeAll; dispid 1610743993;
    procedure ProjectPackLibraries; dispid 1610743994;
    procedure ProjectUpdatePages(bFastUpdate: WordBool); dispid 1610743995;
    procedure ProjectPackDatabase; dispid 1610743996;
    procedure ProjectCompile; dispid 1610743997;
    procedure ClipboardCut; dispid 1610743998;
    procedure ClipboardCopy; dispid 1610743999;
    procedure ClipboardPaste; dispid 1610744000;
    procedure ConvertToBitmap; dispid 1610744001;
    property SelectionEventEnabled: WordBool dispid 1610744002;
    property BrokenLinkCancelEnabled: WordBool dispid 1610744004;
    procedure Quit; dispid 1610744006;
    procedure DisplayInStatusBar(const bstrStatusText: WideString); dispid 1610744007;
    procedure PageKeyboardCommandsPut(nIndex: Smallint; const bstrKeySequence: WideString;
                                      const bstrCommand: WideString; const nArea: WideString;
                                      const nPrivilege: WideString; const bstrLogging: WideString); dispid 1610744008;
    procedure PageKeyboardCommandsGet(nIndex: Smallint; out pbstrKeySequence: WideString;
                                      out pbstrCommand: WideString; out pnArea: WideString;
                                      out pnPrivilege: WideString; out pbstrLogging: WideString); dispid 1610744009;
    procedure PageSelect(const bstrBase: WideString; const bstrFile: WideString); dispid 1610744010;
    function AttributeXEx: Smallint; dispid 1610744011;
    function AttributeYEx: Smallint; dispid 1610744012;
    procedure PageSelectFirstObjectInGenie; dispid 1610744013;
    procedure PageSelectNextObjectInGenie; dispid 1610744014;
    procedure PropertiesTransCentreOffsetExpressGet(out movementRotationalExpress: Smallint;
                                                    out scalingHorizontalExpress: Smallint;
                                                    out scalingVerticalExpress: Smallint;
                                                    out sliderRotationalExpress: Smallint); dispid 1610744015;
    procedure PropertiesTransCentreOffsetExpressPut(movementRotationalExpress: Smallint;
                                                    scalingHorizontalExpress: Smallint;
                                                    scalingVerticalExpress: Smallint;
                                                    sliderRotationalExpress: Smallint); dispid 1610744016;
    procedure PageEnvironmentFirst(out property_: WideString; out value: WideString); dispid 1610744017;
    procedure PageEnvironmentNext(const currentProperty: WideString; out property_: WideString;
                                  out value: WideString); dispid 1610744018;
    procedure PageEnvironmentAdd(const property_: WideString; const value: WideString); dispid 1610744019;
    procedure PageEnvironmentRemove(const property_: WideString); dispid 1610744020;
    procedure PageEventsGet(out pbstrEventOnEntryCommand: WideString;
                            out pbstrEventOnExitCommand: WideString;
                            out pbstrEventWhileShownCommand: WideString;
                            out pbstrEventOnShownCommand: WideString); dispid 1610744021;
    procedure PageEventsPut(const bstrEventOnEntryCommand: WideString;
                            const bstrEventOnExitCommand: WideString;
                            const bstrEventWhileShownCommand: WideString;
                            const bstrEventOnShownCommand: WideString); dispid 1610744022;
    procedure PageTemplateSelectFirstObject; dispid 1610744023;
    procedure PageTemplateSelectNextObject; dispid 1610744024;
    procedure LockObject; dispid 1610744025;
    procedure UnLockObject; dispid 1610744026;
    property BreakLockMode: WordBool dispid 1610744027;
    property AttributeRawOrient: Smallint readonly dispid 1610744029;
    procedure PageAppearanceSet(const templateStyle: WideString; const templateName: WideString;
                                resolution: Smallint; titlebar: WordBool; width: Smallint;
                                height: Smallint; colour: Smallint); dispid 1610744030;
    procedure _Reserved15; dispid 1610744031;
    procedure _Reserved16; dispid 1610744032;
    procedure _Reserved17; dispid 1610744033;
    procedure _Reserved18; dispid 1610744034;
    procedure _Reserved19; dispid 1610744035;
    procedure _Reserved20; dispid 1610744036;
    procedure _Reserved21; dispid 1610744037;
    procedure _Reserved22; dispid 1610744038;
    procedure _Reserved23; dispid 1610744039;
    procedure _Reserved24; dispid 1610744040;
    procedure _Reserved25; dispid 1610744041;
    procedure _Reserved26; dispid 1610744042;
    procedure _Reserved27; dispid 1610744043;
    procedure _Reserved28; dispid 1610744044;
    procedure _Reserved29; dispid 1610744045;
    procedure _Reserved30; dispid 1610744046;
  end;

// *********************************************************************//
// Interface: IGraphicsBuilderEvents
// Flags:     (4096) Dispatchable
// GUID:      {61D71BF6-7E41-447C-8A77-9B966B43A0D2}
// *********************************************************************//
  IGraphicsBuilderEvents = interface(IDispatch)
    ['{61D71BF6-7E41-447C-8A77-9B966B43A0D2}']
    procedure PasteSymbol; stdcall;
    procedure PasteGenie; stdcall;
    procedure SwapObject; stdcall;
    procedure Selection(nXPos: Integer; nYPos: Integer; nXPosEnd: Integer; nYPosEnd: Integer); stdcall;
    procedure ProjectChange; stdcall;
    procedure BrokenLink(const bstrProject: WideString; const bstrLibrary: WideString;
                         const bstrElement: WideString; nLibraryObjectType: Smallint); stdcall;
    procedure PageSaved(const bstrProject: WideString; const bstrPage: WideString;
                        bLstPage: WordBool); stdcall;
    procedure PageUpdated(const bstrProject: WideString; const bstrPage: WideString;
                          bLastPage: WordBool); stdcall;
  end;

// *********************************************************************//
// The Class CoGraphicsBuilder_ provides a Create and CreateRemote method to
// create instances of the default interface IGraphicsBuilder exposed by
// the CoClass GraphicsBuilder_. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoGraphicsBuilder_ = class
    class function Create: IGraphicsBuilder;
    class function CreateRemote(const MachineName: string): IGraphicsBuilder;
  end;

implementation

uses ComObj;

class function CoGraphicsBuilder_.Create: IGraphicsBuilder;
begin
  Result := CreateComObject(CLASS_GraphicsBuilder_) as IGraphicsBuilder;
end;

class function CoGraphicsBuilder_.CreateRemote(const MachineName: string): IGraphicsBuilder;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_GraphicsBuilder_) as IGraphicsBuilder;
end;

end.
