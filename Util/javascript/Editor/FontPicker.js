/*
 * FontPicker.js	- JavaScript support routines for EPiServer
 * Copyright (c) 2005 ElektroPost Stockholm AB
*/

if (!window.EditorScriptVersions)
	window.EditorScriptVersions = new Array();
window.EditorScriptVersions.push("FontPicker 4");

function GetSystemFonts()
{
	var dialogHelper = document.getElementById('DialogHelper');
	var systemFonts = new Array( dialogHelper.fonts.count );
	
	for (i = 1; i <= dialogHelper.fonts.count; i++)
		systemFonts[i-1] = dialogHelper.fonts(i);
	return systemFonts.sort();
}

function InitializeFontPickerDropdown( tool )
{
	if (!document.getElementById('DialogHelper'))
		return;
	
	CreateFontDropdown(tool);
	tool.appendChild(document.createTextNode(' '));
	CreateSizeDropdown(tool);	
	tool.appendChild(document.createTextNode(' '));
	CreateForeColorDropdown(tool);	

	tool.IgnoreNullEvent = false;
	tool.Handle_onstatechange = function(id) { FontPickerDropdown_onstatechange(id,tool); };
	tool.style.height = '1.9em';

	tool.Handle_onunload = CleanupFontPicker;
}

function CleanupFontPicker(tool)
{
	var i;

	// Clean up onchange handlers on the dropdowns (important -- the are all closure functions
	// that would eat up piles of memory if we did not clear them).
	for(i=0; i < tool.children.length; i++)
	{
		var element = tool.children.item(i);

		if (element.onchange)	
			element.onchange = null;
	}
}

function CreateFontDropdown(tool)
{
	var fontSelect = document.createElement('select');
	var i;
	var sortedFonts = GetSystemFonts();
	
	for (i = 0; i < sortedFonts.length; i ++)
	{
		var opt = document.createElement('option');
		opt.text = sortedFonts[i];
		opt.value = opt.text;
		fontSelect.options.add(opt);
	}
	fontSelect.id = tool.id + '_font';
	fontSelect.onchange = function() { FontPickerDropdown_onchange(tool) };
	fontSelect.disabled = !tool.editorAPI.editable;
	tool.appendChild(fontSelect);
}

function CreateSizeDropdown(tool)
{
	var sizeSelect = document.createElement('select');
	var sizeList = GetActiveFontColorList().sizes;
	var i;

	for (i = 0; i < sizeList.length; i ++)
	{
		var opt = document.createElement('option');
		opt.text = sizeList[i];
		opt.value = i + 1;
		sizeSelect.options.add(opt);
	}
	sizeSelect.id = tool.id + '_size';
	sizeSelect.onchange = function() { SizePickerDropdown_onchange(tool) };
	sizeSelect.disabled = !tool.editorAPI.editable;
	tool.appendChild(sizeSelect);
}

function CreateForeColorDropdown(tool)
{
	var colorSelect = document.createElement('select');
	var fontInfo = GetActiveFontColorList();
	var i;

	for (i = 0; i < fontInfo.names.length; i ++)
	{
		var opt = document.createElement('option');
		var value = fontInfo.values[i].toString();
		opt.value = (value.indexOf('#') >= 0) ? value : '#' + value;		
		opt.text = fontInfo.names[i];
		opt.style.color = value;
		if (fontInfo.names[i] == 'White')
		{
			opt.style.backgroundColor = 'Black';
			opt.text += '      ';
 		}
		colorSelect.options.add(opt);
	}

	colorSelect.customColorOption = document.createElement('option');
	colorSelect.options.add(colorSelect.customColorOption);

	colorSelect.id = tool.id + '_forecolor';
	colorSelect.onchange = function() { ForeColorPickerDropdown_onchange(tool) };
	colorSelect.disabled = !tool.editorAPI.editable;
	tool.appendChild(colorSelect);
	colorSelect.value = colorSelect.customColorOption.value;
}

function FontPickerDropdown_onstatechange(id,tool)
{
	var fontSelect = document.getElementById(tool.id + '_font');
	var sizeSelect = document.getElementById(tool.id + '_size');
	var foreColorSelect = document.getElementById(tool.id + '_forecolor');

	if (id == 'FontName')
	{
		var disabledTools = tool.status == TOOLSTATUS_NOT_SELECTABLE;
		fontSelect.disabled = disabledTools;
		sizeSelect.disabled = disabledTools;
		foreColorSelect.disabled = disabledTools;		
		if (!disabledTools && (tool.status != null || !tool.IgnoreNullEvent))
			fontSelect.value = tool.status;
		tool.IgnoreNullEvent = false;
		return;
	}
	
	if (id == 'FontSize')
	{
		if (!sizeSelect.disabled)
		{
			sizeSelect.value = tool.status;
		}
		return;
	}

	if (id == 'ForeColor')
	{
		if (!foreColorSelect.disabled)
		{
			if (tool.status)
			{
				var remappedColor = ConvertBGRToRGB(DecimalToHex(tool.status));
				var customColorOption = foreColorSelect.customColorOption;

				customColorOption.text = '';
				customColorOption.value = '';
				
				// Setting the value property will automatically change the selectedIndex *IF* the value
				// matches the value of one of the options in our select. If no match, then selectedIndex
				// will be -1
				foreColorSelect.value = remappedColor;
			}
			else
				foreColorSelect.value = null;
		}
		return;
	}
}

function FontPickerDropdown_onchange(tool)
{	
	var fontSelect = document.getElementById(tool.id + '_font');
	var callbackFunc = function() {	tool.editorDocument.execCommand('FontName', false, fontSelect.value); }
	tool.IgnoreNullEvent = true;
	tool.editorAPI.ExecuteRangeAction(callbackFunc);
}

function SizePickerDropdown_onchange(tool)
{
	var sizeSelect = document.getElementById(tool.id + '_size');
	var callbackFunc = function() {	tool.editorDocument.execCommand('FontSize', false, sizeSelect.value); }
	tool.editorAPI.ExecuteRangeAction(callbackFunc);
}

function ForeColorPickerDropdown_onchange(tool)
{
	var colorSelect = document.getElementById(tool.id + '_forecolor');
	var selectedColor = colorSelect.options[colorSelect.selectedIndex].value;	
	var callbackFunc = function() {	tool.editorDocument.execCommand('ForeColor', false, selectedColor); }
	tool.editorAPI.ExecuteRangeAction(callbackFunc);
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

function ApplyFont(id, fontSettings)
{
	selection = getEditor(id).document;
	
	// Only update the FontName if the user has selected a font. No font means no change...
	if(fontSettings[0])
		selection.execCommand("FontName", false, fontSettings[0]);
	// Only update the ForeColor if it has changed, to avoid setting <font> tags in text
	// that has a certain color from the current style sheet...
	if(fontSettings[1] != fontSettings[4])
		selection.execCommand("ForeColor", false, fontSettings[1]);
	selection.execCommand("FontSize", false, fontSettings[3]);
	if(fontSettings[5])
	{
		if(!selection.queryCommandState("Underline"))
			selection.execCommand("Underline", false);
	}
	else
	{
		if(selection.queryCommandState("Underline"))
			selection.execCommand("Underline", false);
	}

	// Set the correct format:
	// 0 - regular, 1 - italic, 2 - bold, 3 - bold italic
	var formatSetting = fontSettings[2];
	ResetFontFormat(selection);
	if(formatSetting == 1 || formatSetting == 3)
	{
		if(!selection.queryCommandState("Italic"))
			selection.execCommand("Italic", false);
	}
	if(formatSetting == 2 || formatSetting == 3)
	{
		if(!selection.queryCommandState("Bold"))
			selection.execCommand("Bold", false);
	}
}

function ResetFontFormat(selection)
{
	if(selection.queryCommandState("Italic"))
		selection.execCommand("Italic", false);
	if(selection.queryCommandState("Bold"))
		selection.execCommand("Bold", false);
}

function LaunchFontPicker(dialogURL, id)
{ 
	var returnValue;

	var dialogArgs = new Array();
	dialogArgs[DLG_ARGS_PARENT_WINDOW] = window;
	dialogArgs[DLG_ARGS_EDITOR_ID] = id;	
	dialogArgs[DLG_ARGS_FONTCOLORLIST] = GetActiveFontColorList();

	returnValue = OpenDialog(dialogURL, dialogArgs, 440, 290);
	
	if(returnValue)
		ApplyFont(id, returnValue);
}