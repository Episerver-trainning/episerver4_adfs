<%@ Page language="c#" Codebehind="TableProperties.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Editor.Tools.Dialogs.TableProperties" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
<HEAD>
<meta name="robots" content="noindex,nofollow">
<TITLE><%=TranslateTableText("toolheading")%></TITLE>
<META content="Microsoft Visual Studio 7.0" name=GENERATOR>
<meta content=http://schemas.microsoft.com/intellisense/ie5 name=vs_targetSchema><LINK href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css" type=text/css rel=stylesheet >
<link rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css">
<script type="text/javascript" src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/common.js"></script>
<script type="text/javascript" src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/Editor/Constants.js"></script>
<script type="text/javascript" src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/system.js"></script>
<style>
	.halfRowContainer			{ float: left; width: 50%;	 position: relative; }
	.rowContainer				{ float: left; width: 100%;  position: relative; }
	.longLabel					{ float: left; width: 150px; position: relative; left: 2px; top: 2px; }
	.mediumLabel				{ float: left; width: 100px;  position: relative; left: 2px; top: 2px; }
	.shortLabel					{ float: left; width: 80px;  position: relative; left: 2px; top: 2px; }
	.smallDropdown				{ float: left; width: 80px;	 position: relative; }
	.dropdown					{ float: left; width: 100px; position: relative; }
	.unitValueContainer			{ float: left; width: 80px;  position: relative; left: 10px; }
	.unitTypesContainer			{ float: left; width: 110px;  position: relative; left: 6px; }
	.unitSingleTypeContainer	{ float: left; width: 110px;  position: relative; }
	.smallButton				{ float: left; width: 24px;  position: relative; margin-left: 3px; }
	.button						{ float: left; width: 92px;  position: relative; }
	.input						{ float: left; width: 80px;  position: relative; }
	.longInput					{ float: left; width: 300px; position: relative; }
	.checkbox					{ float: left; position: relative; }
</style>
</HEAD>

<script language="csharp" runat="server">
	private string TranslateTableText(string languageKey)
	{
		return EPiServer.Global.EPLang.Translate("/editor/tools/tableproperties/" + languageKey);
	}	
	private string TranslateTableTextForScript(string languageKey)
	{
		return EPiServer.Global.EPLang.TranslateForScript("/editor/tools/tableproperties/" + languageKey);
	}	
</script>

<script type='text/javascript'>
/*
 * JavaScript support routines for EPiServer
 * Copyright (c) 2003 ElektroPost Stockholm AB
*/
/* Trim() function duplicated from HtmlTextBox2_API.js */
String.prototype.Trim = new Function("return this.replace(/^\\s+|\\s+$/g,'')");

var _linkEditorUrl = '';
/* This codeblock somewhat duplicates some of the code from LinkEditor.js */
function LaunchLinkEditor()
{
	var DIALOG_ARGUMENT_INSERT_IMAGE = 0;
	var returnValue;
	var dialogUrl = _linkEditorUrl;

	if(_bgImageSrc.value && _bgImageSrc.value.length > 0)
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

var borderColorValue		= new Object();
var lightBorderColorValue	= new Object();
var darkBorderColorValue	= new Object();
var bgColorValue			= new Object();
var widthValue				= new Object();
var heightValue				= new Object();

// General tab settings
var _cssClass;
var _alignment;
var _cellpadding, _cellspacing;
var _borderSize, _borderColorList, _lightBorderColorList, _darkBorderColorList;
var _checkWidth, _width, _widthUnitPixel, _widthUnitPercent;
var _checkHeight, _height, _heightUnitPixel, _heightUnitPercent;
var _checkBgImage, _bgColorList, _bgImageSrc, _bgImageButton;	
// Advanced tab settings
var _caption, _summary;
		
// Use the same object that was passed to us, because methods in the object will be called
// after the dialog has closed (objects created in the dialog will terminate when dialog closes).
var _tableProps;

function initialize()
{
	var parentWindow	= dialogArguments[DLG_ARGS_PARENT_WINDOW];
	var editor			= parentWindow.getEditor(dialogArguments[DLG_ARGS_EDITOR_ID]);
	var fontColorInfo	= dialogArguments[DLG_ARGS_FONTCOLORLIST];

	_tableProps			= dialogArguments[DLG_ARGS_CUSTOM_ARGS_BASE];

	initializeElementReferences();

	populateCssList(_cssClass, parentWindow._cssRules, dialogArguments[DLG_ARGS_EDITOR_ID]);
	populateList(_alignment, ['<%=TranslateTableTextForScript("alignmentcenter")%>','<%=TranslateTableTextForScript("alignmentleft")%>','<%=TranslateTableTextForScript("alignmentright")%>'], ['center','left','right']);
	populateList(_borderColorList, fontColorInfo.names, fontColorInfo.values);
	populateList(_lightBorderColorList, fontColorInfo.names, fontColorInfo.values);
	populateList(_darkBorderColorList, fontColorInfo.names, fontColorInfo.values);
	populateList(_bgColorList, fontColorInfo.names, fontColorInfo.values);

	widthValue.checkBox		= _checkWidth;
	widthValue.valueField	= _width;
	widthValue.unitPixel	= _widthUnitPixel;
	widthValue.unitPercent	= _widthUnitPercent;
	heightValue.checkBox	= _checkHeight;
	heightValue.valueField	= _height;
	heightValue.unitPixel	= _heightUnitPixel;
	heightValue.unitPercent	= _heightUnitPercent;
	
	setDefaultValues();

	// Cancel the dialog's submit event
	document.forms[0].attachEvent("onsubmit", CancelSubmit);
}
function CancelSubmit()
{
	document.forms[0].detachEvent('onsubmit', CancelSubmit);
	return false;
}
// Store away references to all interesting elements, for easy access. 
// We can not access the elements directly by their id in code, since they live inside a form element.
function initializeElementReferences()
{
	with(document)
	{
		// General tab settings
		_cssClass				= getElementById('cssclass');
		_alignment				= getElementById('alignment');
		_cellpadding			= getElementById('cellpadding');
		_cellspacing			= getElementById('cellspacing');
		_borderSize				= getElementById('borderSize');
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
		_caption				= getElementById('caption');
		_summary				= getElementById('summary');
	}
}
function populateList(list, contentArray, valueArray)
{
	var newOption;

	// Always add an empty element (unselected value)
	newOption		= document.createElement("OPTION");
	newOption.text	= '';
	newOption.value	= '';
	list.add(newOption);
	
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
		if (cssDescriptor.TagName != 'TABLE' || contentArray[i].Id != editorID)
			continue;
		newOption		= document.createElement("OPTION");
		newOption.text	= contentArray[i].MenuName;
		newOption.value	= contentArray[i].ClassName;
		list.add(newOption);
	}
}
function setDefaultValues()
{
	// First, set values from the selected table
	_caption.value		= GetStringValue('caption');
	_summary.value		= GetStringValue('summary');
	_cellpadding.value	= GetStringValue('cellPadding');
	_cellspacing.value	= GetStringValue('cellSpacing');
	_borderSize.value	= GetStringValue('border');
	_linkEditorUrl		= GetStringValue('insertImageURL');

	with(_tableProps)
	{
		selectListItem(_alignment,				GetValue('align'));
		splitValueAndUnit(widthValue,			GetValue('width'));
		splitValueAndUnit(heightValue,			GetValue('height'));
		selectListItem(_borderColorList,		GetValue('borderColor'));
		selectListItem(_lightBorderColorList,	GetValue('borderColorLight'));
		selectListItem(_darkBorderColorList,	GetValue('borderColorDark'));
		selectListItem(_bgColorList,			GetValue('bgColor'));
		selectCssItem(_cssClass,				GetValue('class'));

		if (GetValue('background'))
		{
			_checkBgImage.checked	= true;
			_bgImageSrc.value		= GetValue('background');
		}
	}
	
	
	// Finally, enable/disable the correct parts of the UI based on checkboxes etc
	setEnabledState();
}
function GetStringValue(itemName)
{
	var val = _tableProps.GetValue(itemName);
	if (!val)
		val = '';
	return val;
}
function selectListItem(list, itemValue)
{
	if(!itemValue)
	{
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
	if(!itemValue)
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
	widthDisabled				= !_checkWidth.checked;
	_width.disabled				= widthDisabled;
	_widthUnitPixel.disabled	= widthDisabled;
	_widthUnitPercent.disabled	= widthDisabled;

	heightDisabled				= !_checkHeight.checked;
	_height.disabled			= heightDisabled;
	_heightUnitPixel.disabled	= heightDisabled;
	_heightUnitPercent.disabled	= heightDisabled;
	
	bgImageDisabled				= !_checkBgImage.checked;
	_bgImageSrc.disabled		= bgImageDisabled;
	_bgImageButton.disabled		= bgImageDisabled;
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
function GetTablePropertiesReturnValue()
{
	with(_tableProps)
	{
		SetValue('align', 			_alignment.value		? _alignment.value : null);
		SetValue('cellPadding', 	_cellpadding.value		? _cellpadding.value.Trim() : null);
		SetValue('cellSpacing', 	_cellspacing.value		? _cellspacing.value.Trim() : null);
		SetValue('width',			_checkWidth.checked		? mergeValueAndUnit(widthValue) : '');
		SetValue('height',			_checkHeight.checked	? mergeValueAndUnit(heightValue) : '');
		SetValue('border', 			_borderSize.value		? _borderSize.value.Trim() : null);
		SetValue('borderColor', 	_borderColorList.value	? _borderColorList.value : null);
		SetValue('borderColorLight',_lightBorderColorList.value ? _lightBorderColorList.value : null);
		SetValue('borderColorDark', _darkBorderColorList.value ? _darkBorderColorList.value : null);
		SetValue('bgColor', 		_bgColorList.value		? _bgColorList.value : null);
		SetValue('background',		_checkBgImage.checked	? _bgImageSrc.value.Trim() : null);
		SetValue('caption',			_caption.value			? _caption.value.Trim() : null);
		SetValue('summary',			_summary.value			? _summary.value.Trim() : null);
		SetValue('class',			_cssClass.value			? _cssClass.value.Trim() : null);
	}
	
	return _tableProps;
}
function buildReturnValue()
{
	var returnValues = new Array();	
	returnValues[0] = GetTablePropertiesReturnValue();

	return returnValues;
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
function splitValueAndUnit(object, value)
{
	if(!value)
		return;
		
	stringValue = new String(value);
	if(stringValue.indexOf('%',0) != -1)
	{
		object.valueField.value = stringValue.substr(0, stringValue.length-1);
		object.unitPercent.checked = true;
	}
	else
	{
		object.valueField.value = value;
		object.unitPixel.checked = true;
	}
	object.checkBox.checked = true;
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
	<input	id=cancelButton tabindex=27 style="FLOAT: right; margin-right: 5px; WIDTH: 80px; POSITION: relative;" onclick="CancelClick()" type=reset value="<%=EPiServer.Global.EPLang.Translate("/button/cancel")%>">
	<input	id=okButton tabindex=26 style="FLOAT: right; margin-right: 10px; WIDTH: 80px; POSITION: relative;" onclick="OkClick()" type=submit value="<%=EPiServer.Global.EPLang.Translate("/button/ok")%>"> 
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
		<fieldSet id="fieldset_layout" style="FLOAT: left; POSITION: relative; WIDTH: 205px; HEIGHT: 127px; TOP: 5px">
			<legend><%=TranslateTableText("layoutheading")%>&nbsp;</legend>

			<!-- Alignment -->
			<div class="rowContainer" style="padding-top: 7px;">
				<div class="mediumLabel"><%=TranslateTableText("alignmentheading")%></div>
				<select class="smallDropdown" id=alignment tabindex=1></select>
			</div>

			<!-- Cellpadding -->
			<div class="rowContainer" style="padding-top: 7px;">
				<div class="mediumLabel"><%=TranslateTableText("cellpadding")%></div>
				<input class="input" id=cellpadding tabindex=2/>
			</div>

			<!-- Cellspacing -->
			<div class="rowContainer" style="padding-top: 7px;">
				<div class="mediumLabel"><%=TranslateTableText("cellspacing")%></div>
				<input class="input" id=cellspacing tabindex=3/>
			</div>

			<!-- Class -->
			<div class="rowContainer" style="padding-top: 7px;">
				<div class="mediumLabel"><%=EPiServer.Global.EPLang.Translate("/editor/tools/imageproperties/cssclass")%></div>
				<select class="smallDropdown" id=cssclass tabindex=4></select>
			</div>
			<br/>
		</fieldSet>

		<!------------------>
		<!-- SIZE SECTION -->
		<!------------------>
		<fieldSet id="fieldset_size" style="FLOAT: left; LEFT: 10px; POSITION: relative; WIDTH: 205px; HEIGHT: 127px; TOP: 5px">
			<legend><%=TranslateTableText("sizeheading")%>&nbsp;</legend>

			<!-- Width -->
			<div class="rowContainer">
				<input	id=checkWidth tabindex=6 type=checkbox onclick="setEnabledState();" style="FLOAT: left; POSITION: relative;"/>
				<div	style="FLOAT: left; LEFT: 3px; TOP:4px; POSITION: relative; WIDTH: 100px;"><label for="checkWidth"><%=TranslateTableText("specifywidth")%></label></div>
			</div>
			<br/>
			<div class="rowContainer">
				<div class="unitValueContainer">
					<input	id=width tabindex=7 style="LEFT: 15px; TOP: 3px; POSITION: relative;" type=text size=7/>
				</div>
				<div class="unitTypesContainer">
					<div class="unitSingleTypeContainer" style="margin-top: -5px;">
						<input	id=widthUnitPixel tabindex=8 type=radio value=pixel checked style="FLOAT: left; POSITION: relative;" name="widthUnit"/>
						<div	style="FLOAT: left; LEFT: 2px; POSITION: relative; TOP: 4px;"><label for="widthUnitPixel"><%=TranslateTableText("pixels")%></label></div>
					</div>
					<div class="unitSingleTypeContainer" style="margin-top: -4px;">
						<input	id=widthUnitPercent tabindex=9 type=radio value=percent style="FLOAT: left; POSITION: relative;" name="widthUnit"/>
						<div	style="FLOAT: left; LEFT: 2px; POSITION: relative; TOP: 4px;"><label for="widthUnitPercent"><%=TranslateTableText("percent")%></label></div>
					</div>
				</div>
			</div>

			<!-- Height -->
			<div class="rowContainer" style="margin-top: 5px;">
				<input	id=checkHeight tabindex=10 type=checkbox onclick="setEnabledState();" style="FLOAT: left; POSITION: relative;"/>
				<div	style="FLOAT: left; LEFT: 3px; TOP: 4px; POSITION: relative; WIDTH: 100px"><label for="checkHeight"><%=TranslateTableText("specifyheight")%></label></div>
			</div>
			<div class="rowContainer">
				<div class="unitValueContainer">
					<input	id=height tabindex=11 style="LEFT: 15px; TOP: 3px; POSITION: relative;" type=text size=7/>
				</div>
				<div class="unitTypesContainer">
					<div class="unitSingleTypeContainer" style="margin-top: -5px;">
						<input	id=heightUnitPixel tabindex=12 type=radio value=pixel checked style="FLOAT: left; POSITION: relative;" name="heightUnit"/>
						<div	style="FLOAT: left; LEFT: 2px; POSITION: relative; TOP: 4px;"><label for="heightUnitPixel"><%=TranslateTableText("pixels")%></label></div>
					</div>
					<div class="unitSingleTypeContainer" style="margin-top: -4px;">
						<input	id=heightUnitPercent tabindex=13 type=radio value=percent style="FLOAT: left; POSITION: relative;" name="heightUnit"/>
						<div	style="FLOAT: left; LEFT: 2px; POSITION: relative; TOP: 4px;"><label for="heightUnitPercent"><%=TranslateTableText("percent")%></label></div>
					</div>
				</div>
			</div>
			<br/>
		</fieldSet><br/>

		<!--------------------->
		<!-- BORDERS SECTION -->
		<!--------------------->
		<fieldSet id="fieldset_borders" style="POSITION: relative; WIDTH: 420; HEIGHT: 72px; TOP: 10px;">
			<legend><%=TranslateTableText("borderheading")%>&nbsp;</legend>

			<!-- Border Width -->
			<div class="halfRowContainer" style="margin-top: 3px;">
				<div class="shortLabel"><%=TranslateTableText("bordersize")%></div>
				<input class="input" id=borderSize tabindex=14 type=text align=right/>
			</div>
			
			<!-- Light border -->
			<div class="halfRowContainer" style="margin-top: 3px; padding-left: 10px;">
				<div	class="shortLabel"><%=TranslateTableText("borderlight")%></div>
				<select	class="smallDropdown" id=lightBorderColorList tabindex=15 ColorVariable="lightBorderColorValue" onchange="setSelectedColor(this);"></select>
				<input	class="smallButton" id=lightBorderColorButton tabindex=16 onclick="showColorDialog(lightBorderColorValue, lightBorderColorList)" type=button value="..."/>
			</div>
			<br/>

			<!-- Border Color -->
			<div class="halfRowContainer" style="margin-top: 8px;">
				<div	class="shortLabel"><%=TranslateTableText("bordercolor")%></div>
				<select	class="smallDropdown" id=borderColorList tabindex=17 ColorVariable="borderColorValue" onchange="setSelectedColor(this);"></select>
				<input	class="smallButton" id=borderColorButton tabindex=18 onclick="showColorDialog(borderColorValue, borderColorList)" type=button value="..."/>
			</div>

			<!-- Dark border -->
			<div class="halfRowContainer" style="margin-top: 8px; padding-left: 10px;">
				<div	class="shortLabel"><%=TranslateTableText("borderdark")%></div>
				<select	class="smallDropdown" id=darkBorderColorList tabindex=19 ColorVariable="darkBorderColorValue" onchange="setSelectedColor(this);"></select>
				<input	class="smallButton" id=darkBorderColorButton tabindex=20 onclick="showColorDialog(darkBorderColorValue, darkBorderColorList)" type=button value="..."/>
			</div>
			<br/>
		</fieldSet><br/>

		<!------------------------>
		<!-- BACKGROUND SECTION -->
		<!------------------------>
		<fieldSet id="fieldset_background" style="POSITION: relative; WIDTH: 420; HEIGHT: 89px; TOP: 15px;">
			<legend><%=TranslateTableText("backgroundheading")%>&nbsp;</legend>

			<!-- Color -->
			<div class="rowContainer" style="margin-top: 3px;">
				<div class="shortLabel"><%=TranslateTableText("backgroundcolor")%></div>
				<select class="smallDropdown" id=bgColorList tabindex=21 ColorVariable="bgColorValue" onchange="setSelectedColor(this);"></select>
				<input class="smallButton" id=bgColorButton tabindex=22 onclick="showColorDialog(bgColorValue, bgColorList)" type=button value="...">
			</div>

			<!-- Background image -->
			<div class="rowContainer" style="margin-top: 5px;">
				<input class="checkbox" style="left: -3px;" id=checkBgImage tabindex=23 type=checkbox onclick="setEnabledState();"/>
				<div class="longLabel"><label for="checkBgImage"><%=TranslateTableText("usepicture")%></label></div>
			</div>
			<div class="rowContainer">
				<input class="longInput" id=bgImageSrc tabindex=24 type=text align=right size=46 name=BgPictureTextBox>
				<input class="button" style="left: 9px;" id=bgImageButton tabindex=25 onclick="LaunchImageBrowser();" type=button value="<%=EPiServer.Global.EPLang.Translate("/button/browse")%>">
			</div>
			<br/>	
		</fieldSet><br/>
	</asp:Panel>
	
	<!---------------- ADVANCED TAB ---------------->
	<asp:Panel id="AdvancedPropertiesPanel"  runat="server">
		<!------------------------->
		<!-- DESCRIPTION SECTION -->
		<!------------------------->
		<fieldSet id="fieldset_desc" style="POSITION: relative; WIDTH: 420; HEIGHT: 92px; TOP: 5px; padding-bottom:10px;">
			<legend><%=TranslateTableText("descriptionheading")%>&nbsp;</legend>

			<!-- Caption -->
			<div class="rowContainer" style="padding-top: 10px;">
				<div class="mediumLabel"><%=TranslateTableText("caption")%></div>
				<input class="longInput" id=caption type=text align=right size=46 tabindex=1>
			</div>

			<!-- Summary -->
			<div class="rowContainer" style="padding-top: 16px;">
				<div class="mediumLabel"><%=TranslateTableText("summary")%></div>
				<textarea class="longInput" style="left:-2px;height:60px;" tabindex=2 id=summary cols=46 rows=4></textarea>
			</div>
			<br/>
		</fieldSet>
	</asp:Panel> 
</asp:Panel>
<OBJECT id=myDialogHelper tabindex="-1" CLASSID='clsid:3050f819-98b5-11cf-bb82-00aa00bdce0b' width='0px' height='0px' VIEWASTEXT></OBJECT>
</form>
</DIV>
</BODY>
</HTML>