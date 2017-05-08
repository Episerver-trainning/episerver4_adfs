<%@ Page language="c#" Codebehind="TableCellProperties.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Editor.Tools.Dialogs.TableCellProperties" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
<HEAD>
<meta name="robots" content="noindex,nofollow">
<TITLE><%=TranslateCellText("toolheading")%></TITLE>
<META content="Microsoft Visual Studio 7.0" name=GENERATOR>
<meta content=http://schemas.microsoft.com/intellisense/ie5 name=vs_targetSchema>
<link rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css">
<script type="text/javascript" src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/common.js"></script>
<script type="text/javascript" src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/Editor/Constants.js"></script>
<script type="text/javascript" src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/system.js"></script>
<style>
	.halfRowContainer			{ float: left; width: 50%;	 position: relative; }
	.rowContainer				{ float: left; width: 100%;  position: relative; }
	.longLabel					{ float: left; width: 150px; position: relative; left: 2px; top: 2px; }
	.mediumLabel				{ float: left; width: 110px; position: relative; left: 2px; top: 2px; }
	.shortLabel					{ float: left; width: 80px;  position: relative; left: 2px; top: 2px; }
	.smallDropdown				{ float: left; width: 80px;	 position: relative; }
	.dropdown					{ float: left; width: 100px; position: relative; }
	.unitValueContainer			{ float: left; width: 80px;  position: relative; left: 10px; }
	.unitTypesContainer			{ float: left; width: 110px;  position: relative; left: 6px; }
	.unitSingleTypeContainer	{ float: left; width: 110px;  position: relative; }
	.smallButton				{ float: left; width: 24px;  position: relative; margin-left: 3px; }
	.button						{ float: left; width: 92px;  position: relative; }
	.input						{ float: left; width: 80px;  position: relative; }
	.smallInput					{ float: left; width: 90px; position: relative; }
	.mediumInput				{ float: left; width: 120px; position: relative; }
	.longInput					{ float: left; width: 300px; position: relative; }
	.checkbox					{ float: left; position: relative; }
	.indentrow					{ float: left; left: 183px; height: 30px; top: 4px; position: relative; }
	.disabled					{ background-color: #ddddda; }
</style>
</HEAD>

<script type="text/c#" runat="server">
	private string TranslateCellText(string languageKey)
	{
		return EPiServer.Global.EPLang.Translate("/editor/tools/cellproperties/" + languageKey);
	}	
	private string TranslateCellTextForScript(string languageKey)
	{
		return EPiServer.Global.EPLang.TranslateForScript("/editor/tools/cellproperties/" + languageKey);
	}	
</script>

<script type='text/javascript'>
/*
 * JavaScript support routines for EPiServer
 * Copyright (c) 2003 ElektroPost Stockholm AB
*/
/* Trim() function duplicated from HtmlTextBox2_API.js */
String.prototype.Trim = new Function("return this.replace(/^\\s+|\\s+$/g,'')");
Object.prototype.IsArray = function() 
{
	return this.constructor == Array;
}
Array.prototype.Contains = function (obj)
{
	for(var i = 0; i < this.length; i++)
		if (this[i] == obj)
			return true;				

	return false;
}

var _linkEditorUrl = '';
/* This codeblock somewhat duplicates some of the code from LinkEditor.js */
function LaunchLinkEditor()
{
	var DIALOG_ARGUMENT_INSERT_IMAGE = 0;
	var returnValue;
	var dialogUrl = _linkEditorUrl;

	if(_bgImageValue.valueField.value && _bgImageValue.valueField.value.length > 0)
		dialogUrl += '&url=' + encodeURIComponent(_bgImageSrc.value);

	// OpenLinkToolDialog is defined in common.js
	returnValue = OpenLinkToolDialog(dialogUrl, DIALOG_ARGUMENT_INSERT_IMAGE);
					
	if (returnValue)
	{
		var params			= returnValue.split('|');
		_bgImageSrc.value	= params[0];
	}
}
/* END of code from LinkEditor.js */

function LaunchImageBrowser()
{
	// Use new link tool's browser function
	if (_linkEditorUrl.indexOf('FileManagerBrowser.aspx') > 0)
		LaunchFileManagerBrowser();
	// Use old link tool's browser function
	else
		LaunchLinkEditor();
}

function LaunchFileManagerBrowser()
{
	var returnValue;
	
	var dialogUrl = _linkEditorUrl + '&hideclearbutton=true&browserselectionmode=image';
	if(_bgImageSrc.value && _bgImageSrc.value.length > 0)
		dialogUrl += '&selectedfile=' + encodeURIComponent(_bgImageSrc.value);
	var dialogParameters = 'dialogWidth:600px;dialogHeight:500px;help=no;resizable:yes;status:no;';
	returnValue =  OpenDialogWithParameters(dialogUrl, null, dialogParameters);
					
	if(returnValue)
	{
		_bgImageSrc.value = returnValue;
	}
}

var _borderColorValue		= new Object();
var _lightBorderColorValue	= new Object();
var _darkBorderColorValue	= new Object();
var _bgColorValue			= new Object();
var _bgImageValue			= new Object();
var _widthValue				= new Object();
var _heightValue			= new Object();
var _axisValue				= new Object();
var _headersValue			= new Object();

// General tab settings
var	_horizontalAlignment, _verticalAlignment, _cssClass;
var _borderColorList, _lightBorderColorList, _darkBorderColorList;
var _checkWidth, _width, _widthUnitPixel, _widthUnitPercent;
var _checkHeight, _height, _heightUnitPixel, _heightUnitPercent;
var _bgColorList, _checkBgImage, _bgImageButton, _bgImageSrc;
// Advanced tab settings
var _cellType, _cellScope, _cellAxis, _cellHeaders, _cellID;

// Use the same object that was passed to us, because methods in the object will be called
// after the dialog has closed (objects created in the dialog will terminate when dialog closes).
var _cellProps;

function initialize()
{
	var parentWindow	= dialogArguments[DLG_ARGS_PARENT_WINDOW];
	var editor			= parentWindow.getEditor(dialogArguments[DLG_ARGS_EDITOR_ID]);
	var fontColorInfo	= dialogArguments[DLG_ARGS_FONTCOLORLIST];

	_cellProps			= dialogArguments[DLG_ARGS_CUSTOM_ARGS_BASE];
	
	initializeElementReferences();

	// Prepare the font color list with a leading blank option for use in the lists...
	var colorNames	= [''].concat(fontColorInfo.names);
	var colorValues	= [''].concat(fontColorInfo.values);

	// Fill the various lists with options
	populateCssList(_cssClass, parentWindow._cssRules, dialogArguments[DLG_ARGS_EDITOR_ID]);
	populateList(_horizontalAlignment,	['','<%=TranslateCellTextForScript("halignmentcenter")%>','<%=TranslateCellTextForScript("halignmentleft")%>','<%=TranslateCellTextForScript("halignmentright")%>'], ['','center','left','right']);
	populateList(_verticalAlignment, ['','<%=TranslateCellTextForScript("valignmentbaseline")%>','<%=TranslateCellTextForScript("valignmentbottom")%>','<%=TranslateCellTextForScript("valignmentmiddle")%>','<%=TranslateCellTextForScript("valignmenttop")%>'], ['','baseline','bottom','middle','top']);
	populateList(_borderColorList, colorNames, colorValues);
	populateList(_lightBorderColorList, colorNames, colorValues);
	populateList(_darkBorderColorList, colorNames, colorValues);
	populateList(_bgColorList, colorNames, colorValues);
	populateList(_cellType, ['<%=TranslateCellTextForScript("datacell")%>','<%=TranslateCellTextForScript("headercell")%>'], ['td','th']);
	populateList(_cellScope, ['','<%=TranslateCellTextForScript("scoperow")%>','<%=TranslateCellTextForScript("scopecol")%>'], ['','row','col']);

	setDefaultValues();

	// Cancel the dialog's submit event
	document.forms[0].attachEvent("onsubmit", CancelSubmit);
}
function CancelSubmit()
{
	document.forms[0].detachEvent("onsubmit", CancelSubmit);
	return false;
}
// Store away references to all interesting elements, for easy access. 
// We can not access the elements directly by their id in code, since they live inside a form element.
function initializeElementReferences()
{
	with(document)
	{
		// General tab settings
		_horizontalAlignment	= getElementById('horizontalAlignment');
		_verticalAlignment		= getElementById('verticalAlignment');
		_cssClass				= getElementById('cssClass');
		_borderColorList		= getElementById('borderColorList');
		_lightBorderColorList	= getElementById('lightBorderColorList');
		_darkBorderColorList	= getElementById('darkBorderColorList');
		_bgColorList			= getElementById('bgColorList');
		_checkWidth				= getElementById('checkWidth');	
		_width					= getElementById('width');	
		_widthUnitPixel			= getElementById('widthUnitPixel');	
		_widthUnitPercent		= getElementById('widthUnitPercent');	
		_checkHeight			= getElementById('checkHeight');	
		_height					= getElementById('height');	
		_heightUnitPixel		= getElementById('heightUnitPixel');
		_heightUnitPercent		= getElementById('heightUnitPercent');	
		_checkBgImage			= getElementById('checkBgImage');	
		_bgImageSrc				= getElementById('bgImageSrc');	
		_bgImageButton			= getElementById('bgImageButton');	

		// Advanced tab settings
		_cellType				= getElementById('cellType');
		_cellScope				= getElementById('cellScope');
		_cellAxis				= getElementById('cellAxis');
		_cellHeaders			= getElementById('cellHeaders');
		_cellID					= getElementById('cellID');
		
		// Values that are set through multiple input objects need some linking...
		_axisValue.valueField		= _cellAxis;
		_headersValue.valueField	= _cellHeaders;
				
		_widthValue.checkBox		= _checkWidth;
		_widthValue.valueField		= _width;
		_widthValue.unitPixel		= _widthUnitPixel;
		_widthValue.unitPercent		= _widthUnitPercent;
		_widthValue.multipleValues	= false;
		
		_heightValue.checkBox		= _checkHeight;
		_heightValue.valueField		= _height;
		_heightValue.unitPixel		= _heightUnitPixel;
		_heightValue.unitPercent	= _heightUnitPercent;
		_heightValue.multipleValues = false;
		
		_bgImageValue.checkBox		= _checkBgImage;
		_bgImageValue.valueField	= _bgImageSrc;
		_bgImageValue.button		= _bgImageButton;
		_bgImageValue.multipleValues = false;
	}
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
function populateCssList(list, contentArray, editorID)
{
	var newOption;
	
	// Create an empty entry at the beginning of the list
	newOption = document.createElement("OPTION");
	list.add(newOption);
	
	// Find all classes defined for IMG elements from the parentWindow's _cssRules array
	for(i = 0; i < contentArray.length; i++)
	{
		var cssDescriptor = contentArray[i];
		if ((cssDescriptor.TagName != 'TD' && cssDescriptor.TagName != 'TH') || contentArray[i].Id != editorID)
			continue;
		newOption		= document.createElement("OPTION");
		newOption.text	= contentArray[i].MenuName;
		newOption.value	= contentArray[i].ClassName;
		list.add(newOption);
	}
}
function setDefaultValues()
{
	// First, set values from the selected cell(s)


	// Handle both single and multiple cells the same currently - with multiple, all values are passed in as null
	with(_cellProps)
	{
		selectListItem(_horizontalAlignment,	GetValue('align'));
		selectListItem(_verticalAlignment,		GetValue('vAlign'));
		selectCssItem(_cssClass,				GetValue('class'));
		setupValueWithUnit(_widthValue,			GetValue('width'));
		setupValueWithUnit(_heightValue,		GetValue('height'));
		selectListItem(_borderColorList,		GetValue('borderColor'));
		selectListItem(_lightBorderColorList,	GetValue('borderColorLight'));
		selectListItem(_darkBorderColorList,	GetValue('borderColorDark'));
		selectListItem(_bgColorList,			GetValue('bgColor'));
		selectListItem(_cellType,				GetValue('celltype'));
		selectListItem(_cellScope,				GetValue('scope'));
		setupInputField(_axisValue,				GetValue('axis'));
		setupInputField(_headersValue,			GetValue('headers'));
		_linkEditorUrl	=						GetValue('insertImageURL');
		
		// Check if several cells are selected: means the ID field should be disabled
		var cellIDcheck = GetValue('id');
		if(cellIDcheck == MULTIPLE_VALUES)
			_cellID.disabled = true;
		else
			_cellID.value = cellIDcheck == null ? "" : cellIDcheck;
	}
	
	var bgImage = _cellProps.GetValue('background');
	if(bgImage == MULTIPLE_VALUES)
	{
		_bgImageValue.checkBox.checked			 = false;
		_bgImageValue.valueField.value			 = '<%=TranslateCellTextForScript("multiplevalues")%>';
		_bgImageValue.valueField.style.fontStyle = 'italic';
		_bgImageValue.multipleValues			 = true;
	}
	else if(bgImage)
	{
		_bgImageValue.checkBox.checked = true;
		_bgImageValue.valueField.value = _cellProps.GetValue('background');
	}
	
	// Finally, enable/disable the correct parts of the UI based on checkboxes etc
	setEnabledState();
}
function setupInputField(object, value)
{
	if(!value)
		return;
	
	object.multipleValues = (value == MULTIPLE_VALUES);
	
	if(object.multipleValues)
	{
		object.valueField.value				= '<%=TranslateCellTextForScript("multiplevalues")%>';
		object.valueField.style.fontStyle	= 'italic';
		object.valueField.style.color		= '#ACA899';
		object.valueField.attachEvent("onkeydown", keyDownInInputField);
		object.valueField.attachEvent("onmousedown", keyDownInInputField);
	}
	else
	{
		object.valueField.value = value;
	}
}
function keyDownInInputField()
{
	// Ignore the Enter and Tab keys.
	if(event.keyCode == 13 || event.keyCode == 9)
		return;

	var objectValue;
	if(event.srcElement == _axisValue.valueField)
		objectValue = _axisValue;
	else if(event.srcElement == _headersValue.valueField)
		objectValue = _headersValue;

	resetInputField(objectValue);
}
function resetInputField(objectValue)
{
	if(objectValue.multipleValues)
	{
		objectValue.multipleValues	 = false;
		objectValue.valueField.value = '';
		objectValue.valueField.style.removeAttribute('fontStyle', 0);
		objectValue.valueField.style.removeAttribute('color', 0);
		objectValue.valueField.detachEvent("onkeydown", keyDownInInputField);
		objectValue.valueField.detachEvent("onmousedown", keyDownInInputField);
	}
}
function selectListItem(list, itemValue)
{
	if(!itemValue)
	{
		list.selectedIndex = 0;
		return;
	}
	else if(itemValue == MULTIPLE_VALUES)
	{	// Multiple cells are being edited, and they have different values for this attribute
		var newOption	= document.createElement("OPTION");
		newOption.text	= '<%=TranslateCellTextForScript("multiplevalues")%>';
		newOption.value = MULTIPLE_VALUES;
		newOption.style.color = '#ACA899';
		list.add(newOption, 0);
		list.selectedIndex = 0;
		return;
	}
	for(i = 0; i < list.length; i++)
		if(list.options[i].value == itemValue || ('#' + list.options[i].value) == itemValue)
		{
			list.selectedIndex = i;
			return;
		}
		
	addUnknownColorToList(itemValue, list);
}
function selectCssItem(list, itemValue)
{
	if(!itemValue || itemValue == -1)
	{
		list.selectedIndex = 0;
		return;
	}
	for(i = 0; i < list.length; i++)
		if(list.options[i].value == itemValue)
		{
			list.selectedIndex = i;
			return;
		}

	// For unknown css classes, create a new entry and select it
	var newOption = document.createElement("OPTION");
	newOption.text	= itemValue;
	newOption.value = itemValue;
	list.add(newOption);
	list.selectedIndex = list.length - 1;
}
function setEnabledState()
{
	var widthDisabled					= !_widthValue.checkBox.checked;
	_widthValue.valueField.disabled		= widthDisabled;
	_widthValue.unitPixel.disabled		= widthDisabled;
	_widthValue.unitPercent.disabled	= widthDisabled;

	var heightDisabled					= !_heightValue.checkBox.checked;
	_heightValue.valueField.disabled	= heightDisabled;
	_heightValue.unitPixel.disabled		= heightDisabled;
	_heightValue.unitPercent.disabled	= heightDisabled;
	
	var bgImageDisabled					= !_checkBgImage.checked;
	_bgImageValue.valueField.disabled	= bgImageDisabled;
	_bgImageValue.button.disabled		= bgImageDisabled;

	// Special conditions check for multiple values passed in from different cells, when the user
	// checks the checkbox, clear the "multiple" indicator from the input fields and clear the flag.
	if(!widthDisabled && _widthValue.multipleValues)
		resetInputField(_widthValue);
	if(!heightDisabled && _heightValue.multipleValues)
		resetInputField(_heightValue);
	if(!bgImageDisabled && _bgImageValue.multipleValues)
		resetInputField(_bgImageValue);
}
function showColorDialog(colorVariable, colorList)
{
	// Handling of a cancelled ChooseColorDlg when no previous color was chosen/set is flawed,
	// as there is no way to separate a cancelled Dlg (returning 0) from a selection in the Dlg
	// of the color black (returning 0). Hence the colorList will automatically select the color
	// "Black" if the ChooseColorDlg is just opened and cancelled...
	if (colorVariable.color == null) // the color dialog box has not yet been called
		color = document.forms[0].myDialogHelper.ChooseColorDlg();
	else // initialize the color dialog with the color previously chosen
		color = document.forms[0].myDialogHelper.ChooseColorDlg(colorVariable.color);
	color = convertColor(color);

	setColor(colorVariable, color, colorList);
}
function setSelectedColor(colorList)
{
	setColor(colorList.ColorVariable, colorList.options[colorList.selectedIndex].value, colorList);
}
function setColor(colorVariable, colorString, colorList)
{
	colorVariable.color = colorString;
	selectPredefinedColor(colorString, colorList);
}
function convertColor(color)
{	//change from decimal to 6 digit hex value to represent the RRGGBB schema required by the color table
	if(color == null) return null;
	color = color.toString(16);
	if (color.length < 6) 
	{
		var tempString = "000000".substring(0,6-color.length);
		color = tempString.concat(color);
	}
	return color;
}
function swap(argumentString)
{
	if(!argumentString) return '';
	return argumentString.substr(4,2) + argumentString.substr(2,2) + argumentString.substr(0,2);
}
function addUnknownColorToList(colorString, colorList)
{
	// For unknown colors, create a new entry and select it
	var newOption = document.createElement("OPTION");
	if (colorString.charAt(0) != '#')
		colorString = '#' + colorString;
	newOption.text	= colorString;
	newOption.value = colorString;
	colorList.add(newOption);

	colorList.selectedIndex = colorList.length - 1;
}
function selectPredefinedColor(colorString, colorList)
{
	for(i = 0; i < colorList.length; i++)
		if(colorList.options[i].value == colorString)
		{	// If the current color is in the list, select it
			colorList.selectedIndex = i;
			return;
		}
		
	addUnknownColorToList(colorString, colorList);
}
function mergeValueAndUnit(object)
{
	if(!object.checkBox.checked)
		return;
	retVal = object.valueField.value;
	if(object.unitPercent.checked)
		retVal = retVal + '%';
	return retVal;
}
// Makes sure all items in the newValuesArray appear in baseArray (or adds them if needed)
function mergeArrays(baseArray, newValuesArray)
{
	for(var i=0; i<newValuesArray.length; i++)
	{	// Ignore empty values
		if(newValuesArray[i] && !baseArray.Contains(newValuesArray[i]))
			baseArray.push(newValuesArray[i]);
	}

	return baseArray;
}
function PickAxisInDialog()
{
	resetInputField(_axisValue);

	var windowTitle			= '<%=TranslateCellTextForScript("axiswindowtitle")%>';
	var separatorChar		= ','; // The specification demands that "axis" is a _comma_ separated list.
	var currentAxis			= _cellAxis.value;
	var allAxis				= mergeArrays(_cellProps.GetValue('existing_axis'), currentAxis.split(separatorChar));
	var helpText			= '<%=TranslateCellTextForScript("axiswindowtext")%>';
	
	var userSelection = OpenValueDialog(windowTitle, separatorChar, allAxis, currentAxis, helpText, true);

	// Returned "null" means the user cancelled the dialog (empty value can be returned if nothing is selected)
	if (userSelection != null)
		_cellAxis.value = userSelection;
}
function PickHeadersInDialog()
{
	resetInputField(_headersValue);

	var windowTitle			= '<%=TranslateCellTextForScript("headerswindowtitle")%>';
	var separatorChar		= ' '; // The specification demands that "headers" is a _space_ separated list.
	var currentHeaders		= _cellHeaders.value;
	var allHeaders			= mergeArrays(_cellProps.GetValue('existing_headers'), currentHeaders.split(separatorChar));
	var helpText			= '<%=TranslateCellTextForScript("headerswindowtext")%>';

	var userSelection = OpenValueDialog(windowTitle, separatorChar, allHeaders, currentHeaders, helpText);
	
	// Returned "null" means the user cancelled the dialog (empty value can be returned if nothing is selected)
	if (userSelection != null)
		_cellHeaders.value = userSelection;
}
function setupValueWithUnit(object, value)
{
	if(!value)
		return;
	if(value == MULTIPLE_VALUES)
	{
		object.multipleValues		= true;
		object.valueField.value		= '<%=TranslateCellTextForScript("multiplevalues")%>';
		object.valueField.style.fontStyle = 'italic';
		object.unitPixel.checked	= true;
		object.checkBox.checked		= false;
	}
	else
		splitValueAndUnit(object, value);
}
function splitValueAndUnit(object, value)
{
	stringValue = new String(value);
	
	if(stringValue.indexOf('%',0) != -1)
	{
		object.valueField.value		= stringValue.substr(0, stringValue.length-1);
		object.unitPercent.checked	= true;
	}
	else
	{
		object.valueField.value		= value;
		object.unitPixel.checked	= true;
	}
	object.checkBox.checked	= true;
}
function OpenValueDialog(windowTitle, separatorChar, valueArray, selectedValue, helpText, displayInputArea)
{
	var dialogArgs	= new Array();

	dialogArgs[SELECTDLG_ARGS_WINDOW_TITLE]		= windowTitle;
	dialogArgs[SELECTDLG_ARGS_SEPARATOR_CHAR]	= separatorChar;
	dialogArgs[SELECTDLG_ARGS_VALUES]			= valueArray;
	dialogArgs[SELECTDLG_ARGS_SELECTED_VALUE]	= selectedValue;
	dialogArgs[SELECTDLG_ARGS_TEXT]				= helpText;
	dialogArgs[SELECTDLG_ARGS_ALLOW_INPUT]		= displayInputArea;
	
	var returnValue = OpenDialog('SelectValue.aspx', dialogArgs, 240, 305);
	
	if (!returnValue)
		return null;
	else
		return returnValue[0];	
}
function buildReturnValue()
{
	var returnValues = new Array();	
	returnValues[0] = GetCellPropertiesReturnValue();

	return returnValues;
}
function GetCellPropertiesReturnValue()
{
	with(_cellProps)
	{
		SetValue('align',			_horizontalAlignment.value	? _horizontalAlignment.value : null);
		SetValue('vAlign',			_verticalAlignment.value	? _verticalAlignment.value : null);
		SetValue('width', 			_checkWidth.checked			? mergeValueAndUnit(_widthValue) : (_widthValue.multipleValues  ? MULTIPLE_VALUES : ''));
		SetValue('height', 			_checkHeight.checked		? mergeValueAndUnit(_heightValue) : (_heightValue.multipleValues ? MULTIPLE_VALUES : ''));
		SetValue('borderColor', 	_borderColorList.value		? _borderColorList.value : null);
		SetValue('borderColorLight',_lightBorderColorList.value	? _lightBorderColorList.value : null);
		SetValue('borderColorDark',	_darkBorderColorList.value	? _darkBorderColorList.value : null);
		SetValue('bgColor', 		_bgColorList.value			? _bgColorList.value : null);
		SetValue('background',		_checkBgImage.checked		? _bgImageSrc.value.Trim() : (_bgImageValue.multipleValues ? MULTIPLE_VALUES : null));		
		SetValue('celltype',		_cellType.value); //Should always be a value, no empty option
		SetValue('scope',			_cellScope.value			? _cellScope.value : null);
		SetValue('axis',			_axisValue.multipleValues	? MULTIPLE_VALUES : (_cellAxis.value		? _cellAxis.value		: null));
		SetValue('headers',			_headersValue.multipleValues? MULTIPLE_VALUES : (_cellHeaders.value	? _cellHeaders.value	: null));
		SetValue('id',				_cellID.value				? _cellID.value	: (_cellID.disabled ? MULTIPLE_VALUES : null));
		SetValue('class',			_cssClass.value				? _cssClass.value : null);
	}
	
	return _cellProps;
}
function OkClick()
{
	returnValue = buildReturnValue();
	window.close();
}
function CancelClick()
{
	returnValue = false;
	window.close();
}
</script>

<BODY	bottomMargin=0 leftMargin=0 topMargin=0 scroll=no onload="initialize()" rightMargin=0 style="padding-left: 7px">
<div	style="WIDTH: 100%; POSITION: relative; HEIGHT: 100%" ms_positioning="GridLayout">
<form id="DialogForm" method="post" runat="server">

<!-------------------->
<!-- FOOTER SECTION -->
<!-------------------->
<div class="rowContainer" style="position: absolute; top: 340px;">
	<input	id=cancelButton tabindex=23 style="FLOAT: right; margin-right: 5px; WIDTH: 80px; POSITION: relative;" onclick="CancelClick()" type=reset value="<%=EPiServer.Global.EPLang.Translate("/button/cancel")%>">
	<input	id=okButton tabindex=22 style="FLOAT: right; margin-right: 10px; WIDTH: 80px; POSITION: relative;" onclick="OkClick()" type=submit value="<%=EPiServer.Global.EPLang.Translate("/button/ok")%>"> 
</div>

<EPiServerSys:tabstrip id="actionTab" runat="server" AutoPostBack="false" TargetID="tabView">
	<EPiServerSys:tab Text="/headings/heading[@name='General']/description" runat="server" id="GeneralTab"/>
	<EPiServerSys:tab Text="/headings/heading[@name='Advanced_short']/description" runat="server" id="AdvancedTab"/>
</EPiServerSys:tabstrip>

<asp:panel id="tabView" runat="server">
	<!---------------- GENERAL TAB ---------------->
	<asp:Panel id="PropertiesPanel"  runat="server" >
		<!-------------------->
		<!-- LAYOUT SECTION -->
		<!-------------------->
		<fieldSet id="fieldset_layout" style="FLOAT: left; POSITION: relative; WIDTH: 205px; HEIGHT: 127px; TOP: 5px;">
			<legend><%=TranslateCellText("layoutheading")%>&nbsp;</legend>

			<!-- Horizontal Alignment -->
			<div class="rowContainer" style="padding-top: 11px;">
				<div class="mediumLabel"><%=TranslateCellText("halignmentheading")%></div>
				<select class="smallDropdown" id=horizontalAlignment tabindex=1></select>
			</div>

			<!-- Vertical Alignment -->
			<div class="rowContainer" style="padding-top: 13px;">
				<div class="mediumLabel"><%=TranslateCellText("valignmentheading")%></div>
				<select class="smallDropdown" id=verticalAlignment tabindex=2></select>
			</div>

			<!-- Class -->
			<div class="rowContainer" style="padding-top: 13px;">
				<div class="mediumLabel"><%=EPiServer.Global.EPLang.Translate("/editor/tools/imageproperties/cssclass")%></div>
				<select class="smallDropdown" id=cssClass tabindex=3></select>
			</div>
			<br/>
		</fieldSet>

		<!------------------>
		<!-- SIZE SECTION -->
		<!------------------>
		<fieldSet id="fieldset_size" style="FLOAT: left; LEFT: 10px; POSITION: relative; WIDTH: 205px; HEIGHT: 127px; TOP: 5px;">
			<legend><%=TranslateCellText("sizeheading")%>&nbsp;</legend>

			<!-- Width -->
			<div class="rowContainer">
				<input	id=checkWidth tabindex=4 type=checkbox onclick="setEnabledState();" style="FLOAT: left; POSITION: relative;"/>
				<div	style="FLOAT: left; LEFT: 3px; TOP:4px; POSITION: relative; WIDTH: 100px;"><label for="checkWidth"><%=TranslateCellText("specifywidth")%></label></div>
			</div>
			<br/>
			<div class="rowContainer">
				<div class="unitValueContainer">
					<input	id=width tabindex=5 style="LEFT: 15px; TOP: 3px; POSITION: relative;" type=text size=7/>
				</div>
				<div class="unitTypesContainer">
					<div class="unitSingleTypeContainer" style="margin-top: -5px;">
						<input	id=widthUnitPixel tabindex=6 type=radio value=pixel checked style="FLOAT: left; POSITION: relative;" name="widthUnit"/>
						<div	style="FLOAT: left; LEFT: 2px; POSITION: relative; TOP: 4px;"><label for="widthUnitPixel"><%=TranslateCellText("pixels")%></label></div>
					</div>
					<div class="unitSingleTypeContainer" style="margin-top: -4px;">
						<input	id=widthUnitPercent tabindex=7 type=radio value=percent style="FLOAT: left; POSITION: relative;" name="widthUnit"/>
						<div	style="FLOAT: left; LEFT: 2px; POSITION: relative; TOP: 4px;"><label for="widthUnitPercent"><%=TranslateCellText("percent")%></label></div>
					</div>
				</div>
			</div>

			<!-- Height -->
			<div class="rowContainer" style="margin-top: 5px;">
				<input	id=checkHeight tabindex=8 type=checkbox onclick="setEnabledState();" style="FLOAT: left; POSITION: relative;"/>
				<div	style="FLOAT: left; LEFT: 3px; TOP: 4px; POSITION: relative; WIDTH: 100px"><label for="checkHeight"><%=TranslateCellText("specifyheight")%></label></div>
			</div>
			<div class="rowContainer">
				<div class="unitValueContainer">
					<input	id=height tabindex=9 style="LEFT: 15px; TOP: 3px; POSITION: relative;" type=text size=7/>
				</div>
				<div class="unitTypesContainer">
					<div class="unitSingleTypeContainer" style="margin-top: -5px;">
						<input	id=heightUnitPixel tabindex=10 type=radio value=pixel checked style="FLOAT: left; POSITION: relative;" name="heightUnit"/>
						<div	style="FLOAT: left; LEFT: 2px; POSITION: relative; TOP: 4px;"><label for="heightUnitPixel"><%=TranslateCellText("pixels")%></label></div>
					</div>
					<div class="unitSingleTypeContainer" style="margin-top: -4px;">
						<input	id=heightUnitPercent tabindex=11 type=radio value=percent style="FLOAT: left; POSITION: relative;" name="heightUnit"/>
						<div	style="FLOAT: left; LEFT: 2px; POSITION: relative; TOP: 4px;"><label for="heightUnitPercent"><%=TranslateCellText("percent")%></label></div>
					</div>
				</div>
			</div>
			<br/>
		</fieldSet><br/>

		<!--------------------->
		<!-- BORDERS SECTION -->
		<!--------------------->
		<fieldSet id="fieldset_borders" style="POSITION: relative; WIDTH: 420; HEIGHT: 72px; TOP: 10px;">
			<legend><%=TranslateCellText("borderheading")%>&nbsp;</legend>

			<!-- Border Color -->
			<div class="halfRowContainer" style="margin-top: 3px;">
				<div	class="shortLabel"><%=TranslateCellText("bordercolor")%></div>
				<select	class="smallDropdown" id=borderColorList tabindex=12 ColorVariable="_borderColorValue" onchange="setSelectedColor(this);"></select>
				<input	class="smallButton" id=borderColorButton tabindex=13 onclick="showColorDialog(_borderColorValue, borderColorList)" type=button value="..."/>
			</div>
			
			<!-- Light border -->
			<div class="halfRowContainer" style="margin-top: 3px; padding-left: 10px;">
				<div	class="shortLabel"><%=TranslateCellText("borderlight")%></div>
				<select	class="smallDropdown" id=lightBorderColorList tabindex=14 ColorVariable="_lightBorderColorValue" onchange="setSelectedColor(this);"></select>
				<input	class="smallButton" id=lightBorderColorButton tabindex=15 onclick="showColorDialog(_lightBorderColorValue, lightBorderColorList)" type=button value="..."/>
			</div>

			<!-- Dark border -->
			<div class="halfRowContainer" style="margin-top: 8px;">&nbsp;</div>
			<div class="halfRowContainer" style="margin-top: 8px; padding-left: 10px;">
				<div	class="shortLabel"><%=TranslateCellText("borderdark")%></div>
				<select	class="smallDropdown" id=darkBorderColorList tabindex=16 ColorVariable="_darkBorderColorValue" onchange="setSelectedColor(this);"></select>
				<input	class="smallButton" id=darkBorderColorButton tabindex=17 onclick="showColorDialog(_darkBorderColorValue, darkBorderColorList)" type=button value="..."/>
			</div>
			<br/>
		</fieldSet><br/>

		<!------------------------>
		<!-- BACKGROUND SECTION -->
		<!------------------------>
		<fieldSet id="fieldset_background" style="POSITION: relative; WIDTH: 420; HEIGHT: 89px; TOP: 15px;">
			<legend><%=TranslateCellText("backgroundheading")%>&nbsp;</legend>

			<!-- Color -->
			<div class="rowContainer" style="margin-top: 3px;">
				<div class="shortLabel"><%=TranslateCellText("backgroundcolor")%></div>
				<select class="smallDropdown" id=bgColorList tabindex=18 ColorVariable="_bgColorValue" onchange="setSelectedColor(this);"></select>
				<input class="smallButton" id=bgColorButton tabindex=19 onclick="showColorDialog(_bgColorValue, bgColorList)" type=button value="...">
			</div>

			<!-- Background image -->
			<div class="rowContainer" style="margin-top: 5px;">
				<input class="checkbox" style="left: -3px;" id=checkBgImage tabindex=20 type=checkbox onclick="setEnabledState();"/>
				<div class="longLabel"><label for="checkBgImage"><%=TranslateCellText("usepicture")%></label></div>
			</div>
			<div class="rowContainer">
				<input class="longInput" id=bgImageSrc tabindex=21 type=text align=right/>
				<input class="button" style="left: 9px;" id=bgImageButton tabindex=22 onclick="LaunchImageBrowser();" type=button value="<%=EPiServer.Global.EPLang.Translate("/button/browse")%>"/>
			</div>
			<br/>
		</fieldSet><br/>
	</asp:Panel> 

	<!---------------- ADVANCED TAB ---------------->
	<asp:Panel id="AdvancedPropertiesPanel"  runat="server">
		<!--------------------->
		<!-- HEADERS SECTION -->
		<!--------------------->
		<fieldSet id="fieldset_layout" style="FLOAT: left; POSITION: relative; WIDTH: 420px; HEIGHT: 107px; TOP: 5px;">
			<legend><%=TranslateCellText("headersheading")%>&nbsp;</legend>

			<div class="halfRowContainer" style="padding-top: 10px;">
				<!-- Cell type -->
				<div style="height:26px;">
					<div class="shortLabel"><%=TranslateCellText("type")%></div>
					<select class="dropdown" id=cellType tabindex=1></select>
				</div>
				<!-- Scope -->
				<div style="height:26px;">
					<div class="shortLabel"><%=TranslateCellText("scope")%></div>
					<select class="dropdown" id=cellScope tabindex=2></select>
				</div>
			</div>
			<div class="halfRowContainer" style="padding-top: 10px;">
				<!-- Axis -->
				<div style="height:26px;">
					<div class="shortLabel"><%=TranslateCellText("axis")%></div>
					<input class="smallInput" id=cellAxis tabindex=5 type=text align=right/>
					<input type="button" id=picxAxisInDialogButton tabindex=6 class="smallbutton" onclick="PickAxisInDialog()" value="..."/>
				</div>

				<!-- Headers -->
				<div style="height:26px;">
					<div class="shortLabel"><%=TranslateCellText("headers")%></div>
					<input class="smallInput" id=cellHeaders tabindex=7 type=text align=right/>
					<input type="button" id=pickHeadersInDialogButton tabindex=8 class="smallButton" onclick="PickHeadersInDialog()" value="..."/>
				</div>

				<!-- ID -->
				<div style="height:26px;">
					<div class="shortLabel" id=cellIDLabel><%=TranslateCellText("id")%></div>
					<input class="smallInput" id=cellID tabindex=9 type=text align=right/>
				</div>
			</div>
		</fieldSet>
	</asp:Panel>

</asp:Panel>
<OBJECT id=myDialogHelper tabindex="-1" CLASSID='clsid:3050f819-98b5-11cf-bb82-00aa00bdce0b' width='0px' height='0px' VIEWASTEXT></OBJECT>
</form>
</DIV>
</BODY>
</HTML>