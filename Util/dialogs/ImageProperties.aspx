<%@ Page language="c#" Codebehind="ImageProperties.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Editor.Tools.Dialogs.ImageProperties" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
<HEAD>
<meta name="robots" content="noindex,nofollow">
<TITLE><%=EPiServer.Global.EPLang.Translate("/editor/tools/imageproperties/toolheading")%></TITLE>
<META content="Microsoft Visual Studio 7.0" name=GENERATOR>
<meta content=http://schemas.microsoft.com/intellisense/ie5 name=vs_targetSchema><LINK href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css" type=text/css rel=stylesheet >
<link rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css">
<script type="text/javascript" src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/common.js"></script>
<style>
	.rowContainer				{ float: left; width: 100%;  position: relative; }
	.unitValueContainer			{ float: left; width: 80px;  position: relative; left: 10px; }
	.unitTypesContainer			{ float: left; width: 80px;  position: relative; left: 6px; }
	.unitSingleTypeContainer	{ float: left; width: 80px;  position: relative; }
	.label						{ float: left; width: 110px; position: relative; left: 2px; top: 2px; }
	.smallButton				{ float: left; width: 24px;  position: relative; margin-left: 3px; }
	.button						{ float: left; width: 92px;  position: relative; }
	.input						{ float: left; width: 80px;  position: relative; }
	.inputMedium				{ float: left; width: 263px; position: relative; }
	.inputLarge					{ float: left; width: 290px; position: relative; }
</style>
</HEAD>
<script type='text/javascript'>
/*
 * JavaScript support routines for EPiServer
 * Copyright (c) 2003 ElektroPost Stockholm AB
*/
var baseLinkEditorUrl = '';

/* This codeblock somewhat duplicates some of the code from LinkEditor.js */
function LaunchLinkEditor()
{
	var DIALOG_ARGUMENT_INSERT_IMAGE = 0;
	var returnValue;
	
	var linkEditorUrl = baseLinkEditorUrl;
	if (src.value && src.value.length > 0)
		linkEditorUrl += '&url=' + encodeURIComponent(src.value);
	if (alt.value && alt.value.length > 0)
		linkEditorUrl += '&alt=' + encodeURIComponent(alt.value);

	// OpenLinkToolDialog is defined in common.js
	returnValue = OpenLinkToolDialog(linkEditorUrl, DIALOG_ARGUMENT_INSERT_IMAGE);
					
	if(returnValue)
	{
		var params	= returnValue.split('|');
		var srcUrl	= params[0];
		var altText	= params[1];
		
		src.value	= srcUrl;
		setTextBoxValue(alt, altText);
	}
}
/* END of code from LinkEditor.js */

var img;
var widthValue	= new Object();
var heightValue	= new Object();
var proportionRatio = 0;

function initialize()
{
	img = window.dialogArguments;

	populateCssList(cssClass, img.parentWindow._cssRules, img.editorID);
	populateList(alignment,	'|<%=EPiServer.Global.EPLang.Translate("/editor/tools/imageproperties/alignmentleft")%>|<%=EPiServer.Global.EPLang.Translate("/editor/tools/imageproperties/alignmentright")%>|<%=EPiServer.Global.EPLang.Translate("/editor/tools/imageproperties/alignmentbottom")%>|<%=EPiServer.Global.EPLang.Translate("/editor/tools/imageproperties/alignmentmiddle")%>|<%=EPiServer.Global.EPLang.Translate("/editor/tools/imageproperties/alignmenttop")%>', '|left|right|bottom|middle|top');

	widthValue.checkBox		= checkWidth;
	widthValue.valueField	= width;
	widthValue.unitPixel	= widthUnitPixel;
	widthValue.unitPercent	= widthUnitPercent;
	
	heightValue.checkBox	= checkHeight;
	heightValue.valueField	= height;
	heightValue.unitPixel	= heightUnitPixel;
	heightValue.unitPercent	= heightUnitPercent;

	setDefaultValues();
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
		if(contentArray[i].TagName != 'IMG' || contentArray[i].Id != editorID)
			continue;
		newOption		= document.createElement("OPTION");
		newOption.text	= contentArray[i].MenuName;
		newOption.value	= contentArray[i].ClassName;
		list.add(newOption);
	}
}
function populateList(list, contentString, valueString)
{
	var newOption;
	var contentArray	= contentString.split('|');
	var valueArray		= (valueString == null) ? null : valueString.split('|');
	for(i = 0; i < contentArray.length; i++)
	{
		newOption		= document.createElement("OPTION");
		newOption.text	= contentArray[i];
		newOption.value	= (valueArray == null) ? i : valueArray[i];
		list.add(newOption);
	}
}
function setDefaultValues()
{
	// First, set up the initial values
	baseLinkEditorUrl	= img.linkEditorUrl;

	// Preselect values based on current image configuration
	selectListItem(alignment,		img.align);
	setTextBoxValue(border,			img.border);
	setTextBoxValue(hspace,			img.hspace);
	setTextBoxValue(vspace,			img.vspace);
	selectListItem(cssClass,		img.className);
	splitValueAndUnit(widthValue,	img.width);
	splitValueAndUnit(heightValue,	img.height);
	setTextBoxValue(alt,			img.alt);
	setTextBoxValue(src,			img.src);
	filesize.insertAdjacentText('afterBegin', img.fileSize + ' ');

	// Check whether there is height/width information to be displayed, even if the attributes were not set
	if(img.width == null)
		widthValue.valueField.value	= img.realwidth;
	if(img.height == null)
		heightValue.valueField.value = img.realheight;

	// Constrain proportions can only be used if the following criteria are met:
	// - Both height and width have values (to get a ratio)
	// - None of those values are percentages.
	if(widthValue.valueField.value.length == 0 || heightValue.valueField.value.length == 0 || 
	   widthValue.unitPercent.checked || heightValue.unitPercent.checked)
	{
		checkProportions.disabled	= true;
		divProportions.disabled		= true;
	}
	else
		proportionRatio = widthValue.valueField.value / heightValue.valueField.value;
	
	// If we have been supplied with _set_ values (as opposed to IE's supplied size values) for both height 
	// and with, in pixels only, check "lock aspect ratio" by default.
	if( widthValue.checkBox.checked  && widthValue.unitPixel.checked &&
		heightValue.checkBox.checked && heightValue.unitPixel.checked)
		checkProportions.checked = true;
	
	// Finally, enable/disable the correct parts of the UI based on checkboxes etc
	setEnabledState();
}
function selectListItem(list, itemValue)
{
	if(!itemValue)
	{
		list.selectedIndex = 0;
		return;
	}
	for(i = 0; i < list.length; i++)
	{
		if(list.options[i].value == itemValue)
		{
			list.selectedIndex = i;
			return;
		}
	}
	// A value has been set, but was not found in the list. Create a (temporary) list item for the
	// value, to avoid clearing values set in HTML-mode by just opening and closing the dialog.
	var newOption	= document.createElement("OPTION");
	newOption.text	= itemValue;
	newOption.value	= itemValue;
	list.add(newOption);
	list.selectedIndex = list.options.length-1;
}
function setTextBoxValue(textBox, value)
{
	if(!value)
		value = '';
	textBox.value = value;
}
function constrainChecked()
{
	// When using "constrain proportions", both heigth and width will be supplied using pixel values
	if(checkProportions.checked)
	{
		widthValue.checkBox.checked		= true;
		widthValue.unitPixel.checked	= true;

		heightValue.checkBox.checked	= true;
		heightValue.unitPixel.checked	= true;
	}

	setEnabledState();
}
function setEnabledState()
{
	widthDisabled				= !checkWidth.checked;
	heightDisabled				= !checkHeight.checked;

	if(checkProportions.checked)
		checkProportions.checked = !widthDisabled && !heightDisabled;

	widthValue.valueField.disabled	 = widthDisabled;
	widthValue.unitPixel.disabled	 = widthDisabled;
	widthValue.unitPercent.disabled	 = widthDisabled || checkProportions.checked;

	heightValue.valueField.disabled	 = heightDisabled;
	heightValue.unitPixel.disabled	 = heightDisabled;
	heightValue.unitPercent.disabled = heightDisabled || checkProportions.checked;
	
	if(checkProportions.checked)
	{
		divLink.style.borderRight	= "2px solid black";
		divLink.style.borderTop		= "2px solid black";
		divLink.style.borderBottom	= "2px solid black";
	}
	else
	{
		divLink.style.borderRight	= "0px solid black";
		divLink.style.borderTop		= "0px solid black";
		divLink.style.borderBottom	= "0px solid black";
	}

}
function constrainHeight()
{
	if(!checkProportions.checked)
		return;
		
	heightValue.valueField.value = Math.round(widthValue.valueField.value / proportionRatio);
}
function constrainWidth()
{
	if(!checkProportions.checked)
		return;
		
	widthValue.valueField.value = Math.round(heightValue.valueField.value * proportionRatio);
}
function buildReturnValue()
{
	// For all return values - if they are empty/cleared/undefined, pass back null.
	var returnImg = new Object();
	returnImg.align		= (alignment.selectedIndex > 0)	? alignment.options[alignment.selectedIndex].value : null;
	returnImg.border	= (border.value.length > 0)		? border.value	: null;
	returnImg.hspace	= (hspace.value.length > 0)		? hspace.value	: null;
	returnImg.vspace	= (vspace.value.length > 0)		? vspace.value	: null;
	returnImg.className	= (cssClass.selectedIndex > 0)	? cssClass.options[cssClass.selectedIndex].value : null;
	returnImg.width		= (checkWidth.checked)			? mergeValueAndUnit(widthValue)  : null;
	returnImg.height	= (checkHeight.checked)			? mergeValueAndUnit(heightValue) : null;
	returnImg.alt		= (alt.value.length > 0)		? alt.value		: null;
	returnImg.src		= (src.value.length > 0 && src.value != img.src) ? src.value : null;

	return returnImg;	
}
function mergeValueAndUnit(object)
{
	if(!object.checkBox.checked)
		return;
	retVal = object.valueField.value;
	if(object.unitPercent.checked)
		retVal = retVal + '%';
	else // Format the value to be used for the "style" attribute on the receiving end.
		retVal = retVal + 'px';
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
		object.valueField.value	= stringValue.toUpperCase().replace('PX', '');
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

<!-------------------->
<!-- LAYOUT SECTION -->
<!-------------------->
<fieldSet id="fieldset_layout" style="FLOAT: left; POSITION: relative; WIDTH: 210px; HEIGHT: 153px">
	<legend><%=EPiServer.Global.EPLang.Translate("/editor/tools/imageproperties/layoutheading")%>&nbsp;</legend>

	<!-- Alignment -->
	<div class="rowContainer" style="padding: 2px; margin-top: 3px; margin-bottom: 4px;">
		<div class="label"><%=EPiServer.Global.EPLang.Translate("/editor/tools/imageproperties/alignment")%></div>
		<select	id=alignment tabindex=1 style="FLOAT: left; POSITION: relative; WIDTH: 80px;"></select>
	</div>

	<!-- Border Width -->
	<div class="rowContainer" style="padding: 2px; margin-bottom: 4px;">
		<div class="label"><%=EPiServer.Global.EPLang.Translate("/editor/tools/imageproperties/borderwidth")%></div>
		<input class="input" type="text" id="border" tabindex=2/>
	</div>

	<!-- Horizontal spacing -->
	<div class="rowContainer" style="padding: 2px; margin-bottom: 4px;">
		<div class="label"><%=EPiServer.Global.EPLang.Translate("/editor/tools/imageproperties/hspace")%></div>
		<input class="input" type="text" id="hspace" tabindex=3/>
	</div>

	<!-- Vertical spacing -->
	<div class="rowContainer" style="padding: 2px; margin-bottom: 4px;">
		<div class="label"><%=EPiServer.Global.EPLang.Translate("/editor/tools/imageproperties/vspace")%></div>
		<input class="input" type="text" id="vspace" tabindex=4/>
	</div>
	
	<!-- Css Class -->
	<div class="rowContainer" style="padding: 2px; margin-bottom: 3px;">
		<div class="label"><%=EPiServer.Global.EPLang.Translate("/editor/tools/imageproperties/cssclass")%></div>
		<select	id=cssClass tabindex=5 style="FLOAT: left; POSITION: relative; WIDTH: 80px;"></select>
	</div>
	<br/>

</fieldSet>


<!------------------>
<!-- SIZE SECTION -->
<!------------------>
<fieldSet id="fieldset_size" style="FLOAT: left; LEFT: 10px; POSITION: relative; WIDTH: 200px; HEIGHT: 153px">
	<legend><%=EPiServer.Global.EPLang.Translate("/editor/tools/imageproperties/sizeheading")%>&nbsp;</legend>

	<!-- Constrain proportions -->
	<div class="rowContainer" style="margin-top: 2px; margin-bottom: 5px;">
		<input	id=checkProportions tabindex=9 type=checkbox onclick="constrainChecked();" style="FLOAT: left; POSITION: relative;"/>
		<div	id=divProportions style="FLOAT: left; LEFT: 3px; TOP: 4px; POSITION: relative; WIDTH: 150px"><%=EPiServer.Global.EPLang.Translate("/editor/tools/imageproperties/lockproportions")%></div>
	</div>

	<!-- Width -->
	<div class="rowContainer">
		<input	id=checkWidth tabindex=10 type=checkbox onclick="setEnabledState();" style="FLOAT: left; POSITION: relative;"/>
		<div	style="FLOAT: left; LEFT: 3px; TOP:4px; POSITION: relative; WIDTH: 100px;"><%=EPiServer.Global.EPLang.Translate("/editor/tools/imageproperties/specifywidth")%></div>
	</div>
	<br/>
	<div class="rowContainer">
		<div class="unitValueContainer">
			<input	id=width onkeyup="constrainHeight();" tabindex=11 style="LEFT: 15px; TOP: 3px; POSITION: relative;" type=text size=7/>
		</div>
		<div class="unitTypesContainer">
			<div class="unitSingleTypeContainer" style="margin-top: -5px;">
				<input	id=widthUnitPixel tabindex=12 type=radio value=pixel checked style="FLOAT: left; POSITION: relative;" name="widthUnit"/>
				<div	style="FLOAT: left; LEFT: 2px; POSITION: relative; TOP: 4px;"><%=EPiServer.Global.EPLang.Translate("/editor/tools/imageproperties/pixels")%></div>
			</div>
			<div class="unitSingleTypeContainer" style="margin-top: -4px;">
				<input	id=widthUnitPercent tabindex=13 type=radio value=percent style="FLOAT: left; POSITION: relative;" name="widthUnit"/>
				<div	style="FLOAT: left; LEFT: 2px; POSITION: relative; TOP: 4px;"><%=EPiServer.Global.EPLang.Translate("/editor/tools/imageproperties/percent")%></div>
			</div>
		</div>
	</div>

	<!-- Height -->
	<div class="rowContainer" style="margin-top: 5px;">
		<input	id=checkHeight tabindex=14 type=checkbox onclick="setEnabledState();" style="FLOAT: left; POSITION: relative;"/>
		<div	style="FLOAT: left; LEFT: 3px; TOP: 4px; POSITION: relative; WIDTH: 100px"><%=EPiServer.Global.EPLang.Translate("/editor/tools/imageproperties/specifyheight")%></div>
	</div>
	<div class="rowContainer">
		<div class="unitValueContainer">
			<input	id=height onkeyup="constrainWidth();" tabindex=15 style="LEFT: 15px; TOP: 3px; POSITION: relative;" type=text size=7/>
		</div>
		<div class="unitTypesContainer">
			<div class="unitSingleTypeContainer" style="margin-top: -5px;">
				<input	id=heightUnitPixel tabindex=16 type=radio value=pixel checked style="FLOAT: left; POSITION: relative;" name="heightUnit"/>
				<div	style="FLOAT: left; LEFT: 2px; POSITION: relative; TOP: 4px;"><%=EPiServer.Global.EPLang.Translate("/editor/tools/imageproperties/pixels")%></div>
			</div>
			<div class="unitSingleTypeContainer" style="margin-top: -4px;">
				<input	id=heightUnitPercent tabindex=17 type=radio value=percent style="FLOAT: left; POSITION: relative;" name="heightUnit"/>
				<div	style="FLOAT: left; LEFT: 2px; POSITION: relative; TOP: 4px;"><%=EPiServer.Global.EPLang.Translate("/editor/tools/imageproperties/percent")%></div>
			</div>
		</div>
	</div>

	<!-- Constrain proportions "link" graphic -->
	<div id=divLink style="FLOAT: right; POSITION: relative; margin-right: 2px; margin-top: -74px; WIDTH: 15px; HEIGHT: 58px;"></div>
	
</fieldSet><br/>


<!------------------------->
<!-- INFORMATION SECTION -->
<!------------------------->
<fieldSet id="fieldset_information" style="FLOAT: left; POSITION: relative; WIDTH: 420; TOP: 10px; HEIGHT: 95px">
	<legend><%=EPiServer.Global.EPLang.Translate("/editor/tools/imageproperties/informationheading")%>&nbsp;</legend>

	<!-- File Size -->
	<div class="rowContainer" style="padding: 3px;">
		<div class="label"><%=EPiServer.Global.EPLang.Translate("/editor/tools/imageproperties/filesize")%></div>
		<div class="inputLarge" style="padding: 3px;" id="filesize"> <%=EPiServer.Global.EPLang.Translate("/editor/tools/imageproperties/unitbytes")%></div>
	</div>

	<!-- Src Url -->
	<div class="rowContainer" style="padding: 3px;">
		<div class="label"><%=EPiServer.Global.EPLang.Translate("/editor/tools/imageproperties/filename")%></div>
		<input id="src" class="inputMedium" type="text" id="src" tabindex=20/>
		<input class="smallButton" id=srcBrowseButton tabindex=21 onclick="LaunchLinkEditor();" type=button value="..."/>
	</div>

	<!-- Alt text -->
	<div class="rowContainer" style="padding: 3px; margin-bottom: 1px;">
		<div class="label"><%=EPiServer.Global.EPLang.Translate("/editor/tools/imageproperties/alttext")%></div>
		<input class="inputLarge" type="text" id="alt" tabindex=22/>
	</div>	
	<br/>
	
</fieldSet><br/>


<!-------------------->
<!-- FOOTER SECTION -->
<!-------------------->
<div class="rowContainer" style="margin-top: 20px;">
	<input	id=cancelButton tabindex=31 style="FLOAT: right; margin-right: 5px; WIDTH: 80px; POSITION: relative;" onclick="CancelClick()" type=reset value="<%=EPiServer.Global.EPLang.Translate("/button/cancel")%>">
	<input	id=okButton tabindex=30 style="FLOAT: right; margin-right: 10px; WIDTH: 80px; POSITION: relative;" onclick="OkClick()" type=submit value="<%=EPiServer.Global.EPLang.Translate("/button/ok")%>"> 
</div>

</DIV>
</BODY>
</HTML>