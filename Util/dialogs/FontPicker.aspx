<%@ Page language="c#" Codebehind="FontPicker.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Editor.Tools.Dialogs.FontPicker" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
<HEAD>
<meta name="robots" content="noindex,nofollow">
<TITLE><%=EPiServer.Global.EPLang.Translate("/editor/tools/font/toolheading")%></TITLE>
<META content="Microsoft Visual Studio 7.0" name=GENERATOR>
<meta content=http://schemas.microsoft.com/intellisense/ie5 name=vs_targetSchema><LINK href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css" type=text/css rel=stylesheet >
<link rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css">
<script type='text/javascript'>
/*
 * JavaScript support routines for EPiServer
 * Copyright (c) 2005 ElektroPost Stockholm AB
*/
var _editor;
var _initialColor	= null;
var _currentColor	= null;
var _initialFont	= null;

function initialize()
{
	var parentWindow	= dialogArguments[0];
	_editor				= parentWindow.getEditor(dialogArguments[1]);
	var fontColorInfo	= dialogArguments[2];

	getSystemFonts();
	populateList(styleList,	['<%=EPiServer.Global.EPLang.TranslateForScript("/editor/tools/font/styleregular")%>','<%=EPiServer.Global.EPLang.TranslateForScript("/editor/tools/font/styleitalic")%>','<%=EPiServer.Global.EPLang.TranslateForScript("/editor/tools/font/stylebold")%>','<%=EPiServer.Global.EPLang.TranslateForScript("/editor/tools/font/stylebolditalic")%>']);
	populateList(sizeList,	fontColorInfo.sizes);
	populateList(colorList,	fontColorInfo.names, fontColorInfo.values);
	selectDefaults();
	ShowPreview();
}

function populateList(list, contentArray, valueArray)
{
	var newOption;
	for(i = 0; i < contentArray.length; i++)
	{
		newOption = document.createElement("OPTION");
		newOption.text = contentArray[i];
		newOption.value = (valueArray == null) ? i : valueArray[i];
		list.add(newOption);
	}
}

function selectDefaults()
{
	// Get the text to sample from the editor
	var currentText = _editor.document.selection.createRange();

	if(currentText.queryCommandState("Underline"))
		checkUnderline.checked = true;
	_initialFont = currentText.queryCommandValue("FontName");
	updateListBox(fontList, _initialFont)
	updateTextBox(inputFont, fontList);
	var currentSize = currentText.queryCommandValue("FontSize");
	sizeList.selectedIndex = (currentSize == null) ? -1 : currentSize-1;
	updateTextBox(inputSize, sizeList);
	
	/* Set the style correctly */
	var styleIndex;
	if(currentText.queryCommandState("Italic"))
		styleIndex = currentText.queryCommandState("Bold") ? 3 : 1;
	else
		styleIndex = currentText.queryCommandState("Bold") ? 2 : 0;
	styleList.selectedIndex = styleIndex;
	updateTextBox(inputStyle, styleList);

	/* Get the current font color */
	// queryCommandValue gives a color that converts to a reversed rrggbb string (as bbggrr) - ConvertBGRToRGB it
	_initialColor = ConvertBGRToRGB(DecimalToHex(currentText.queryCommandValue("ForeColor")));
	SelectColorInList(_initialColor);
}

// Convert decimal value to 6 digit hex string
function DecimalToHex(value)
{	
	if(value == null) return '';
	value = value.toString(16);
	if (value.length < 6) 
	{
		var tempString = "000000".substring(0,6 - value.length);
		value = tempString.concat(value);
	}
	return value;
}

// Convert hex string with the format blue-green-red to red-green-blue
function ConvertBGRToRGB(value)
{
	if(!value) return '';
	return value.substr(4,2) + value.substr(2,2) + value.substr(0,2);
}

function SelectColorInList(color)
{
	var selectedIndex = -1;
	_currentColor = color;

	// If the current color is in the list, select it
	for(i = 0; i < colorList.length; i++)
	{
		if(colorList.options[i].value == color)
		{	
			selectedIndex = i;
			break;
		}
	}

	if (selectedIndex == -1)
	{		
		selectedIndex = HandleUnknownColor(color);	
	}
	
	colorList.selectedIndex = selectedIndex;
	ShowPreview();	
}

function HandleUnknownColor(color)
{
	// Current color is not a predefined color. Check if it's defined in
	// one of the parent elements (except the body)
	var currentText = _editor.document.selection.createRange();
	var elem = currentText.parentElement();
	var compareColor = '#' + color;
	var selectedIndex = -1;

	while(elem != null)
	{
		if (elem.color && elem.color == compareColor)
		{
			// For unknown color, create a new entry and select it
			newOption		= document.createElement("OPTION");
			newOption.text	= compareColor;
			newOption.value = color;
			colorList.add(newOption);
			selectedIndex = colorList.length - 1;
			break;
		}
		elem = elem.parentElement;
	}

	return selectedIndex;
}

function getSystemFonts()
{
	var fontArray = new Array();
	for (i = 1; i < myDialogHelper.fonts.count; i++)
		fontArray[i-1] = myDialogHelper.fonts(i);
	var sortedFonts = fontArray.sort();

	var newOption;
	for (i = 0; i < sortedFonts.length; i++)
	{ 
		newOption = document.createElement("OPTION");
		newOption.text = sortedFonts[i];
		newOption.Value = i;
		fontList.add(newOption);
	}
}

function showColorDialog()
{
	var chosenColor;
	// Handling of a cancelled ChooseColorDlg when no previous color was chosen/set is flawed,
	// as there is no way to separate a cancelled Dlg (returning 0) from a selection in the Dlg
	// of the color black (returning 0). Hence the colorList will automatically select the color
	// "Black" if the ChooseColorDlg is just opened and cancelled...
	if (_currentColor == null) // the color dialog box has not yet been called
		chosenColor = myDialogHelper.ChooseColorDlg();
	else // initialize the color dialog with the color previously chosen
		chosenColor = myDialogHelper.ChooseColorDlg(_currentColor);
	chosenColor = DecimalToHex(chosenColor);

	SelectColorInList(chosenColor);
}

function updateTextBox(textBox, listBox)
{
	if(listBox.selectedIndex == -1)
		return;
	textBox.value = listBox.options[listBox.selectedIndex].text;
}

function updateListBox(listBox, text)
{
	if(text == null || text.length == 0)
	{
		listBox.selectedIndex = -1;
		return;
	}
	for(i = 0; i < listBox.options.length; i++)
	{
		if(similar(text, listBox.options[i].text))
		{	// check for "best match" in the list, in case several items match...
			listBox.selectedIndex = i;
			break;
		}
	}
}

function similar(text1, text2)
{	// Returns true if the beginning of "text1" matches the beginning of "text2"
	if(text1.length == 0) return false;
	var string1 = new String(text1);
	var string2 = new String(text2);
	return string1.toLowerCase() == (string2.toLowerCase()).substr(0, string1.length);
}

function ShowPreview()
{
	fontSettings = getCurrentValues();
	var preview = document.body.createTextRange();
	preview.findText("AaBbYyZz");

	if(fontSettings[0] == null)	// The fontname has been removed - render the initial font
		preview.execCommand("FontName",	false, _initialFont);
	else						// Render the chosen font from the font list
		preview.execCommand("FontName",	false, fontSettings[0]);
	if(fontSettings[1] == '')	// Default (no) color has been chosen in the dropdown - render the initial color
		preview.execCommand("ForeColor",false, fontSettings[4]);
	else						// Render the chosen color from the color picker
		preview.execCommand("ForeColor",false, fontSettings[1]);
	preview.execCommand("FontSize",		false, fontSettings[3]);
	if(fontSettings[5])
	{
		if(!preview.queryCommandState("Underline"))
			preview.execCommand("Underline", false);
	}
	else
	{
		if(preview.queryCommandState("Underline"))
			preview.execCommand("Underline", false);
	}

	// Set the correct format:
	// 0 - regular, 1 - italic, 2 - bold, 3 - bold italic
	var formatSetting = fontSettings[2];
	resetFontFormat(preview);
	if(formatSetting == 1 || formatSetting == 3)
	{
		if(!preview.queryCommandState("Italic"))
			preview.execCommand("Italic", false);
	}
	if(formatSetting == 2 || formatSetting == 3)
	{
		if(!preview.queryCommandState("Bold"))
			preview.execCommand("Bold", false);
	}
}

function resetFontFormat(selection)
{
	if(selection.queryCommandState("Italic"))
		selection.execCommand("Italic", false);
	if(selection.queryCommandState("Bold"))
		selection.execCommand("Bold", false);
}

function getCurrentValues()
{
	var returnValues = new Array();
	returnValues[0] = (fontList.selectedIndex == -1) ? null : fontList.options[fontList.selectedIndex].text;
	returnValues[1] = _currentColor;
	returnValues[2] = styleList.selectedIndex;
	returnValues[3] = (sizeList.selectedIndex == -1) ? null : sizeList.selectedIndex + 1;
	returnValues[4] = _initialColor;
	returnValues[5] = checkUnderline.checked;
	
	return returnValues;
}

function setReturnValue()
{
	returnValue = getCurrentValues();
	window.close();
}
</script>
</HEAD>
<BODY bottomMargin=0 leftMargin=0 topMargin=0 scroll=no onload="initialize()" rightMargin=0>
<DIV style="WIDTH: 539px; POSITION: relative; HEIGHT: 268px" ms_positioning="GridLayout">
	<span id=preview style="BORDER-RIGHT: 1px inset; BORDER-TOP: 1px inset; Z-INDEX: 100; LEFT: 151px; OVERFLOW: hidden; BORDER-LEFT: 1px inset; WIDTH: 162px; BORDER-BOTTOM: 1px inset; POSITION: absolute; TOP: 170px; HEIGHT: 55px; resize: no">AaBbYyZz</span>

	<SELECT id=fontList  tabindex=2 onchange="updateTextBox(inputFont, this);ShowPreview();" style="Z-INDEX: 118; LEFT: 10px; WIDTH: 127px; POSITION: absolute; TOP: 42px;" size=7 name=ListBoxFont></SELECT>
	<SELECT id=styleList tabindex=4 onchange="updateTextBox(inputStyle, this);ShowPreview();" style="Z-INDEX: 113; LEFT: 151px; WIDTH: 90px; POSITION: absolute; TOP: 42px;" size=7 name=ListBoxStyle></SELECT>
	<SELECT id=sizeList  tabindex=6 onchange="updateTextBox(inputSize, this);ShowPreview();" style="Z-INDEX: 114; LEFT: 256px; WIDTH: 57px; POSITION: absolute; TOP: 42px;" size=7 name=ListBoxSize></SELECT>

	<DIV style="DISPLAY: inline; Z-INDEX: 130; LEFT: 152px; WIDTH: 82px; COLOR: #0046D5; POSITION: absolute; TOP: 148px; HEIGHT: 19px" ms_positioning="FlowLayout"><%=EPiServer.Global.EPLang.Translate("/editor/tools/font/samlpeheading")%></DIV>
	<DIV style="DISPLAY: inline; Z-INDEX: 111; LEFT: 10px; WIDTH: 82px; POSITION: absolute; TOP: 189px; HEIGHT: 19px" ms_positioning="FlowLayout"><%=EPiServer.Global.EPLang.Translate("/editor/tools/font/colorheading")%></DIV>
	<DIV style="DISPLAY: inline; Z-INDEX: 110; LEFT: 28px; WIDTH: 82px; POSITION: absolute; TOP: 169px; HEIGHT: 19px" ms_positioning="FlowLayout"><label for="checkUnderline"><%=EPiServer.Global.EPLang.Translate("/editor/tools/font/underline")%></label></DIV>
	<DIV style="DISPLAY: inline; Z-INDEX: 101; LEFT: 11px; WIDTH: 57px; POSITION: absolute; TOP: 5px; HEIGHT: 15px" ms_positioning="FlowLayout"><%=EPiServer.Global.EPLang.Translate("/editor/tools/font/fontheading")%></DIV>
	<DIV style="DISPLAY: inline; Z-INDEX: 104; LEFT: 152px; WIDTH: 56px; POSITION: absolute; TOP: 4px; HEIGHT: 15px" ms_positioning="FlowLayout"><%=EPiServer.Global.EPLang.Translate("/editor/tools/font/styleheading")%></DIV>
	<DIV style="DISPLAY: inline; Z-INDEX: 105; LEFT: 257px; WIDTH: 55px; POSITION: absolute; TOP: 4px; HEIGHT: 15px" ms_positioning="FlowLayout"><%=EPiServer.Global.EPLang.Translate("/editor/tools/font/sizeheading")%></DIV>
	<DIV style="DISPLAY: inline; Z-INDEX: 131; LEFT: 10px; WIDTH: 82px; COLOR: #0046D5; POSITION: absolute; TOP: 149px; HEIGHT: 19px" ms_positioning="FlowLayout"><%=EPiServer.Global.EPLang.Translate("/editor/tools/font/effectheading")%></DIV> 

	<input id=inputFont  tabindex=1 onkeyup="updateListBox(fontList, this.value);ShowPreview();"	style="Z-INDEX: 102; LEFT: 10px; WIDTH: 127px; POSITION: absolute; TOP: 21px; HEIGHT: 22px" type=text size=16> 
	<input id=inputStyle tabindex=3 onkeyup="updateListBox(styleList, this.value);ShowPreview();"	style="Z-INDEX: 103; LEFT: 151px; WIDTH: 90px; POSITION: absolute; TOP: 21px; HEIGHT: 22px" type=text size=9> 
	<input id=inputSize  tabindex=5 onkeyup="updateListBox(sizeList, this.value);ShowPreview();"	style="Z-INDEX: 106; LEFT: 256px; WIDTH: 57px; POSITION: absolute; TOP: 21px; HEIGHT: 22px" type=text size=4> 

	<input	id=checkUnderline	tabindex=7 onclick="ShowPreview();" onchange="ShowPreview();" style="Z-INDEX: 115; LEFT: 7px; POSITION: absolute; TOP: 165px" type=checkbox> 
	<SELECT id=colorList		tabindex=8 onchange="SelectColorInList(this.options[this.selectedIndex].value);" style="Z-INDEX: 116; LEFT: 10px; WIDTH: 85px; POSITION: absolute; TOP: 205px"></SELECT>
	<input	id=colorButton		tabindex=9 onclick="showColorDialog();" type=image onmouseover="this.src='<%=EPiServer.Global.EPConfig.RootDir%>Util/images/Editor/fontColorButton_over.gif'" onmousedown="this.src='<%=EPiServer.Global.EPConfig.RootDir%>Util/images/Editor/fontColorButton_selected.gif'" onmouseout="this.src='<%=EPiServer.Global.EPConfig.RootDir%>Util/images/Editor/fontColorButton_off.gif'" onmouseup="this.src='<%=EPiServer.Global.EPConfig.RootDir%>Util/images/Editor/fontColorButton_over.gif'" src="<%=EPiServer.Global.EPConfig.RootDir%>Util/images/Editor/fontColorButton_off.gif" style="BACKGROUND-POSITION: center center; Z-INDEX: 112; LEFT: 99px; POSITION: absolute; TOP: 204px">
	<input	id=okButton			tabindex=10 style="Z-INDEX: 108; LEFT: 339px; WIDTH: 80px; POSITION: absolute; TOP: 22px" onclick="setReturnValue();" type=submit value=<%=EPiServer.Global.EPLang.Translate("/button/ok")%>> 
	<input	id=cancelButton		tabindex=11 style="Z-INDEX: 109; LEFT: 339px; WIDTH: 80px; POSITION: absolute; TOP: 54px" onclick="returnValue=false;window.close();" type=reset value=<%=EPiServer.Global.EPLang.Translate("/button/cancel")%>>
	
	<HR style="Z-INDEX: 119; LEFT: 60px; WIDTH: 77px; POSITION: absolute; TOP: 156px; HEIGHT: 1px" width="77" SIZE=1>
	<HR style="Z-INDEX: 120; LEFT: 205px; WIDTH: 108px; POSITION: absolute; TOP: 156px; HEIGHT: 1px" width="108" SIZE=1>
</DIV>
<OBJECT id=myDialogHelper tabindex="-1" CLASSID='clsid:3050f819-98b5-11cf-bb82-00aa00bdce0b' width='0px' height='0px' VIEWASTEXT></OBJECT>
</BODY>
</HTML>
