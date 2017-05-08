<%@ Page language="c#" Codebehind="HyperlinkImageProperties.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Editor.Tools.Dialogs.HyperlinkImageProperties" %>
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
	.unitValueContainer			{ float: left; width: 100px;  position: relative; left: 10px; }
	.unitTypesContainer			{ float: left; width: 100px;  position: relative; left: 6px; }
	.unitSingleTypeContainer	{ float: left; width: 100px;  position: relative; }
	.label						{ float: left; width: 130px; position: relative; left: 2px; top: 2px; }
	.labelMedium				{ float: left; width: 150px; position: relative; left: 2px; top: 2px; }
	.labelLarge					{ float: left; width: 300px; position: relative; left: 2px; top: 2px; }
	.smallButton				{ float: left; width: 24px;  position: relative; margin-left: 3px; top: 2px; }
	.button						{ float: left; width: 92px;  position: relative; }
	.input						{ float: left; width: 80px;  position: relative; top: 2px; }
	.inputMedium				{ float: left; width: 283px; position: relative; top: 2px; }
	.inputLarge					{ float: left; width: 310px; position: relative; top: 2px; }
	.checkbox					{ float: left; position: relative; }
</style>
</HEAD>
<script type='text/javascript'>
/*
 * JavaScript support routines for EPiServer
 * Copyright (c) 2005 ElektroPost Stockholm AB
*/

var isHyperlinkToolAvailable;

function setHyperlinkToolAvailability()
{
	if (img.linkObject.parentWindow.EditorScriptVersions)
	{
		for(var index = 0; index < img.linkObject.parentWindow.EditorScriptVersions.length; index++)
		{
			if (img.linkObject.parentWindow.EditorScriptVersions[index].indexOf('HyperlinkProperties') == 0)
			{
				isHyperlinkToolAvailable = true;
				return;
			}
		}
	}
	isHyperlinkToolAvailable = false;
}

/* Trim() function duplicated from HtmlTextBox2_API.js */
String.prototype.Trim = new Function("return this.replace(/^\\s+|\\s+$/g,'')");

var img;
var baseHyperlinkPropertiesUrl = '';
var linkDialogReturnValue = null;
var baseFileManagerBrowserUrl = '';
var baseResizeDialogUrl = '';
var editorID;
var fileSizeDisplay;
var widthValue	= new Object();
var heightValue	= new Object();
var proportionRatio = 0;

function initialize()
{
	img = window.dialogArguments;

	baseHyperlinkPropertiesUrl	= img.linkDialogUrl;
	baseFileManagerBrowserUrl	= img.fileManagerBrowserUrl;
	baseResizeDialogUrl			= img.resizeDialogUrl;
	editorID					= img.editorID;

	populateCssList(cssClass, img.parentWindow._cssRules);
	populateList(alignment,	'|<%=EPiServer.Global.EPLang.TranslateForScript("/editor/tools/imageproperties/alignmentleft")%>|<%=EPiServer.Global.EPLang.TranslateForScript("/editor/tools/imageproperties/alignmentright")%>|<%=EPiServer.Global.EPLang.TranslateForScript("/editor/tools/imageproperties/alignmentbottom")%>|<%=EPiServer.Global.EPLang.TranslateForScript("/editor/tools/imageproperties/alignmentmiddle")%>|<%=EPiServer.Global.EPLang.TranslateForScript("/editor/tools/imageproperties/alignmenttop")%>', '|left|right|bottom|middle|top');

	widthValue.checkBox		= checkWidth;
	widthValue.valueField	= width;
	widthValue.unitPixel	= widthUnitPixel;
	widthValue.unitPercent	= widthUnitPercent;
	
	heightValue.checkBox	= checkHeight;
	heightValue.valueField	= height;
	heightValue.unitPixel	= heightUnitPixel;
	heightValue.unitPercent	= heightUnitPercent;

	setImageButtonBehaviour(linkBrowseButton);

	if (img.src == null || img.linkEditingInProgress)
		deleteButton.disabled = true;
	
	if (img.src == null)
		resizeButton.disabled = true;

	setDefaultValues();
}
function populateCssList(list, contentArray)
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
	if ('<%=FriendlyHyperlinkUrl%>' != '')
		setTextBoxValue(link,		'<%=FriendlyHyperlinkUrl%>');
	else if (img.linkObject.displayUrl)
		setTextBoxValue(link,		img.linkObject.displayUrl);
	else
		setTextBoxValue(link,		img.linkObject.href);
	useLink.checked		= (link.value.length > 0 || img.linkEditingInProgress);
	fileSizeDisplay		= (img.fileSize != null && img.fileSize != -1) ? img.fileSize : '0';
	filesize.innerText	= fileSizeDisplay;

	// Check whether there is height/width information to be displayed, even if the attributes were not set
	if(img.width == null && img.src != null)
		widthValue.valueField.value	= img.realwidth;
	if(img.height == null && img.src != null)
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
	
	setHyperlinkToolAvailability();
	// Finally, enable/disable the correct parts of the UI based on checkboxes etc
	setEnabledState();
	
	if(img.src == null)
		LaunchFileManagerBrowser();
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
	if(!value || value == null)
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
	
	if(!isHyperlinkToolAvailable || img.linkObject.isNotPureImageLink || img.linkEditingInProgress)
		useLink.disabled = true;
		
	if(useLink.disabled || !useLink.checked)
	{
		linkBrowseButton.disabled	= true;
		linkBrowseButton.src		= '<%=EPiServer.Global.EPConfig.RootDir%>Util/images/Editor/link_disabled.gif';
	}
	else
	{
		linkBrowseButton.disabled	= false;
		linkBrowseButton.src		= '<%=EPiServer.Global.EPConfig.RootDir%>Util/images/Editor/link_off.gif';
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

function setImageButtonBehaviour(img)
{
	img.onmouseover = setImageSrc;
	img.onmousedown = setImageSrc;
	img.onmouseout	= setImageSrc;
	img.onmouseup	= setImageSrc;
}

function setImageSrc()
{
	if (event.srcElement.disabled)
		return;
		
	switch (event.type)
	{
		case 'mouseover':
			event.srcElement.src='<%=EPiServer.Global.EPConfig.RootDir%>Util/images/Editor/link_over.gif';
			break;
		case 'mousedown':
			event.srcElement.src='<%=EPiServer.Global.EPConfig.RootDir%>Util/images/Editor/link_selected.gif';
			break;
		case 'mouseout':
			event.srcElement.src='<%=EPiServer.Global.EPConfig.RootDir%>Util/images/Editor/link_off.gif';
			break;
		case 'mouseup':
			event.srcElement.src='<%=EPiServer.Global.EPConfig.RootDir%>Util/images/Editor/link_over.gif';
			break;
	}
}

function buildReturnValue()
{
	// For all return values - if they are empty/cleared/undefined, pass back null.
	var returnImg = img;
	
	returnImg.align		= (alignment.selectedIndex > 0)	? alignment.options[alignment.selectedIndex].value : null;
	returnImg.border	= (border.value.length > 0)		? border.value	: null;
	returnImg.hspace	= (hspace.value.length > 0)		? hspace.value	: null;
	returnImg.vspace	= (vspace.value.length > 0)		? vspace.value	: null;
	returnImg.className	= (cssClass.selectedIndex > 0)	? cssClass.options[cssClass.selectedIndex].value : null;
	returnImg.width		= (checkWidth.checked)			? mergeValueAndUnit(widthValue)  : null;
	returnImg.height	= (checkHeight.checked)			? mergeValueAndUnit(heightValue) : null;
	returnImg.alt		= (alt.value.length > 0)		? alt.value		: null;
	returnImg.src		= (src.value.length > 0)		? src.value		: null;
	returnImg.fileSize	= fileSizeDisplay;

	if(useLink.checked)
		returnImg.linkObject = linkDialogReturnValue;
	else
		returnImg.linkObject = -1;

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
	if(!value || value == null)
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

function UpdateImageData()
{
	if(this.readyState == 'complete')
	{
		src.value = this.orgurl;
		fileSizeDisplay = this.fileSize;
		filesize.innerText = fileSizeDisplay;
		if(!widthValue.checkBox.checked)
			widthValue.valueField.value = this.width;
		if(!heightValue.checkBox.checked)
			heightValue.valueField.value = this.height;
			
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
		{
			checkProportions.disabled	= false;
			divProportions.disabled		= false;
			proportionRatio = widthValue.valueField.value / heightValue.valueField.value;
		}
		
		// If we have been supplied with _set_ values (as opposed to IE's supplied size values) for both height 
		// and with, in pixels only, check "lock aspect ratio" by default.
		if( widthValue.checkBox.checked  && widthValue.unitPixel.checked &&
			heightValue.checkBox.checked && heightValue.unitPixel.checked)
			checkProportions.checked = true;

		resizeButton.disabled = false;

	}
}

function UpdateImage(imageSrc)
{
	var t = new Date();
	var image		= document.createElement('IMG');
	image.orgurl	= imageSrc;
	image.onreadystatechange = UpdateImageData;
	image.src		= imageSrc + '?t=' + t.getTime();
}

function LaunchHyperlinkPropertiesWindow()
{
	var dialogUrl = baseHyperlinkPropertiesUrl;
	
	img.linkObject.imageEditingInProgress = true;
	img.linkObject.imageObject = img;
	img.src = src.value.length > 0 ? src.value : ' ';
	if (img.linkObject.href && img.linkObject.href.length > 0)
	{
		dialogUrl += (dialogUrl.indexOf('?') > -1) ? '&' : '?';
		dialogUrl += 'url=' + encodeURIComponent(img.linkObject.href);
	}
	linkDialogReturnValue = OpenDialog(dialogUrl, img.linkObject, 445, 412);

	if(linkDialogReturnValue != null && linkDialogReturnValue != 0)
	{	// The user clicked OK in the link dialog window - update the link data
		img.linkObject	= linkDialogReturnValue;
		link.value		= linkDialogReturnValue.displayUrl;
	}
}

function LaunchFileManagerBrowser()
{
	var returnValue;
	
	var dialogUrl = baseFileManagerBrowserUrl + '&hideclearbutton=true&browserselectionmode=image&selectedfile=' + encodeURIComponent(src.value);
	var dialogParameters = 'dialogWidth:600px;dialogHeight:500px;help=no;resizable:yes;status:no;';
	returnValue =  OpenDialogWithParameters(dialogUrl, null, dialogParameters);
	
	if(returnValue && returnValue != src.Value)
	{
		src.value		= '';
		UpdateImage(returnValue);
		alt.focus();
	}
	else
	{
		src.focus();
	}
}

function ResizeClick()
{
	var dialogUrl = baseResizeDialogUrl + '?resizeimage=' + encodeURIComponent(src.value);	
	var resizeDialogReturnValue = OpenDialog(dialogUrl, src.value, 485, 310);

	if(resizeDialogReturnValue != null && resizeDialogReturnValue != 0)
	{	// The user clicked OK in the resize dialog window - update the image data
		src.value		= '';
		UpdateImage(resizeDialogReturnValue);
	}
}

function OkClick()
{
	var errorMessage = null;
	if (src.value.Trim().length == 0)
	{	// Don't allow saving without specifying an image
		errorMessage = '<%=EPiServer.Global.EPLang.TranslateForScript("/editor/tools/imageproperties/noimagevalidationmessage")%>';

	}
	else if (!img.linkEditingInProgress && useLink.checked && link.value.Trim().length == 0)
	{	// Don't allow saving without specifying the link if link is to be included
		// (unless link is still being edited in the background in the hyperlink properties dialog)
		errorMessage = '<%=EPiServer.Global.EPLang.TranslateForScript("/editor/tools/imageproperties/nolinkinfovalidationmessage")%>' + 
			'\n\n' + '<%=EPiServer.Global.EPLang.TranslateForScript("/editor/tools/imageproperties/specifylinkinfomessage")%>';
	}
	if (errorMessage != null)
	{
		alert(errorMessage);
		return false;
	}
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

<!------------------------->
<!-- INFORMATION SECTION -->
<!------------------------->
<fieldSet id="fieldset_information" style="FLOAT: left; POSITION: relative; WIDTH: 460; HEIGHT: 95px">
	<legend><%=EPiServer.Global.EPLang.Translate("/editor/tools/imageproperties/informationheading")%>&nbsp;</legend>

	<!-- Src Url -->
	<div class="rowContainer" style="padding: 3px;">
		<div class="label"><%=EPiServer.Global.EPLang.Translate("/editor/tools/imageproperties/imagefile")%></div>
		<input id="src" class="inputMedium" type="text" tabindex=1/>
		<input class="smallButton" id=srcBrowseButton tabindex=2 onclick="LaunchFileManagerBrowser();" type=button value="..."/>
	</div>
	
	<!-- File Size -->
	<div class="rowContainer" style="padding: 3px;">
		<div class="label"><%=EPiServer.Global.EPLang.Translate("/editor/tools/imageproperties/filesize")%></div>
		<div class="labelMedium" id="filesizeinfo"><span id="filesize"></span>&nbsp;<%=EPiServer.Global.EPLang.Translate("/editor/tools/imageproperties/unitbytes")%></div>
		<input id="resizeButton" tabindex=3 style="FLOAT: right; POSITION: relative; margin-right: 2px;" onclick="ResizeClick()" type="button" value="<%=EPiServer.Global.EPLang.Translate("/button/resize")%>..." />
	</div>

	<!-- Alt text -->
	<div class="rowContainer" style="padding: 3px; margin-bottom: 1px;">
		<div class="label"><%=EPiServer.Global.EPLang.Translate("/editor/tools/imageproperties/alttext")%></div>
		<input class="inputLarge" type="text" id="alt" tabindex=4/>
	</div>	
	<br/>
	
</fieldSet><br/>


<!-------------------->
<!-- LAYOUT SECTION -->
<!-------------------->
<fieldSet id="fieldset_layout" style="FLOAT: left; POSITION: relative; WIDTH: 230px; TOP: 5px; HEIGHT: 158px">
	<legend><%=EPiServer.Global.EPLang.Translate("/editor/tools/imageproperties/layoutheading")%>&nbsp;</legend>

	<!-- Alignment -->
	<div class="rowContainer" style="padding: 2px; margin-top: 3px; margin-bottom: 4px;">
		<div class="label"><%=EPiServer.Global.EPLang.Translate("/editor/tools/imageproperties/alignment")%></div>
		<select	id=alignment tabindex=5 style="FLOAT: left; POSITION: relative; WIDTH: 80px;"></select>
	</div>

	<!-- Border Width -->
	<div class="rowContainer" style="padding: 2px; margin-bottom: 4px;">
		<div class="label"><%=EPiServer.Global.EPLang.Translate("/editor/tools/imageproperties/borderwidth")%></div>
		<input class="input" type="text" id="border" tabindex=6/>
	</div>

	<!-- Horizontal spacing -->
	<div class="rowContainer" style="padding: 2px; margin-bottom: 4px;">
		<div class="label"><%=EPiServer.Global.EPLang.Translate("/editor/tools/imageproperties/hspace")%></div>
		<input class="input" type="text" id="hspace" tabindex=7/>
	</div>

	<!-- Vertical spacing -->
	<div class="rowContainer" style="padding: 2px; margin-bottom: 4px;">
		<div class="label"><%=EPiServer.Global.EPLang.Translate("/editor/tools/imageproperties/vspace")%></div>
		<input class="input" type="text" id="vspace" tabindex=8/>
	</div>
	
	<!-- Css Class -->
	<div class="rowContainer" style="padding: 2px; margin-bottom: 3px;">
		<div class="label"><%=EPiServer.Global.EPLang.Translate("/editor/tools/imageproperties/cssclass")%></div>
		<select	id=cssClass tabindex=9 style="FLOAT: left; POSITION: relative; WIDTH: 80px;"></select>
	</div>
	<br/>

</fieldSet>


<!------------------>
<!-- SIZE SECTION -->
<!------------------>
<fieldSet id="fieldset_size" style="FLOAT: left; LEFT: 10px; POSITION: relative; WIDTH: 220px; TOP: 5px; HEIGHT: 158px">
	<legend><%=EPiServer.Global.EPLang.Translate("/editor/tools/imageproperties/sizeheading")%>&nbsp;</legend>

	<!-- Constrain proportions -->
	<div class="rowContainer" style="margin-top: 2px; margin-bottom: 5px;">
		<input	id=checkProportions tabindex=10 type=checkbox onclick="constrainChecked();" style="FLOAT: left; POSITION: relative;"/>
		<div	id=divProportions style="FLOAT: left; LEFT: 3px; TOP: 4px; POSITION: relative; WIDTH: 150px"><label for="checkProportions"><%=EPiServer.Global.EPLang.Translate("/editor/tools/imageproperties/lockproportions")%></label></div>
	</div>

	<!-- Width -->
	<div class="rowContainer">
		<input	id=checkWidth tabindex=11 type=checkbox onclick="setEnabledState();" style="FLOAT: left; POSITION: relative;"/>
		<div	style="FLOAT: left; LEFT: 3px; TOP:4px; POSITION: relative; WIDTH: 100px;"><label for="checkWidth"><%=EPiServer.Global.EPLang.Translate("/editor/tools/imageproperties/specifywidth")%></label></div>
	</div>
	<br/>
	<div class="rowContainer">
		<div class="unitValueContainer">
			<input	id=width onkeyup="constrainHeight();" tabindex=12 style="LEFT: 15px; TOP: 3px; POSITION: relative;" type=text size=7/>
		</div>
		<div class="unitTypesContainer">
			<div class="unitSingleTypeContainer" style="margin-top: -5px;">
				<input	id=widthUnitPixel tabindex=13 type=radio value=pixel checked style="FLOAT: left; POSITION: relative;" name="widthUnit"/>
				<div	style="FLOAT: left; LEFT: 2px; POSITION: relative; TOP: 4px;"><label for="widthUnitPixel"><%=EPiServer.Global.EPLang.Translate("/editor/tools/imageproperties/pixels")%></label></div>
			</div>
			<div class="unitSingleTypeContainer" style="margin-top: -4px;">
				<input	id=widthUnitPercent tabindex=14 type=radio value=percent style="FLOAT: left; POSITION: relative;" name="widthUnit"/>
				<div	style="FLOAT: left; LEFT: 2px; POSITION: relative; TOP: 4px;"><label for="widthUnitPercent"><%=EPiServer.Global.EPLang.Translate("/editor/tools/imageproperties/percent")%></label></div>
			</div>
		</div>
	</div>

	<!-- Height -->
	<div class="rowContainer" style="margin-top: 5px;">
		<input	id=checkHeight tabindex=15 type=checkbox onclick="setEnabledState();" style="FLOAT: left; POSITION: relative;"/>
		<div	style="FLOAT: left; LEFT: 3px; TOP: 4px; POSITION: relative; WIDTH: 100px"><label for="checkHeight"><%=EPiServer.Global.EPLang.Translate("/editor/tools/imageproperties/specifyheight")%></label></div>
	</div>
	<div class="rowContainer">
		<div class="unitValueContainer">
			<input	id=height onkeyup="constrainWidth();" tabindex=16 style="LEFT: 15px; TOP: 3px; POSITION: relative;" type=text size=7/>
		</div>
		<div class="unitTypesContainer">
			<div class="unitSingleTypeContainer" style="margin-top: -5px;">
				<input	id=heightUnitPixel tabindex=17 type=radio value=pixel checked style="FLOAT: left; POSITION: relative;" name="heightUnit"/>
				<div	style="FLOAT: left; LEFT: 2px; POSITION: relative; TOP: 4px;"><label for="heightUnitPixel"><%=EPiServer.Global.EPLang.Translate("/editor/tools/imageproperties/pixels")%></label></div>
			</div>
			<div class="unitSingleTypeContainer" style="margin-top: -4px;">
				<input	id=heightUnitPercent tabindex=18 type=radio value=percent style="FLOAT: left; POSITION: relative;" name="heightUnit"/>
				<div	style="FLOAT: left; LEFT: 2px; POSITION: relative; TOP: 4px;"><label for="heightUnitPercent"><%=EPiServer.Global.EPLang.Translate("/editor/tools/imageproperties/percent")%></label></div>
			</div>
		</div>
	</div>

	<!-- Constrain proportions "link" graphic -->
	<div id=divLink style="FLOAT: right; POSITION: relative; margin-right: 2px; margin-top: -74px; WIDTH: 15px; HEIGHT: 58px;"></div>
	
</fieldSet><br/>

<!------------------------->
<!--  HYPERLINK SECTION  -->
<!------------------------->
<fieldSet id="fieldset_hyperlink" style="FLOAT: left; POSITION: relative; WIDTH: 460; TOP: 5px; MARGIN-TOP: 5px;">
	<legend><%=EPiServer.Global.EPLang.Translate("/editor/tools/imageproperties/hyperlinkheading")%>&nbsp;</legend>

	<!-- Link Url -->
	<div class="rowContainer" style="margin-top: 5px;">
		<input class="checkbox" id="useLink" tabindex="19" type="checkbox" onclick="setEnabledState();"/>
		<div class="labelLarge" style="top: 4px;"><label for="useLink"><%=EPiServer.Global.EPLang.Translate("/editor/tools/imageproperties/uselink")%></label></div>
	</div>
	<div class="rowContainer" style="padding: 3px;">
		<div class="label"><%=EPiServer.Global.EPLang.Translate("/editor/tools/imageproperties/hyperlinkaddress")%></div>
		<input id="link" class="inputMedium" type="text" disabled />
		<img id="linkBrowseButton" onclick="LaunchHyperlinkPropertiesWindow();" src="<%=EPiServer.Global.EPConfig.RootDir%>Util/images/Editor/link_off.gif" title="<%=EPiServer.Global.EPLang.Translate("/editor/tools/imageproperties/edithyperlinkproperties")%>">
	</div>
	<br/>
	
</fieldSet><br/>


<!-------------------->
<!-- FOOTER SECTION -->
<!-------------------->
<div class="rowContainer" style="margin-top: 15px;">
	<input id=cancelButton tabindex=32 style="FLOAT: right; margin-right: 5px; WIDTH: 80px; POSITION: relative;" onclick="CancelClick()" type=reset value="<%=EPiServer.Global.EPLang.Translate("/button/cancel")%>">
	<input id="deleteButton" tabindex=31 style="FLOAT: right; margin-right: 10px; WIDTH: 80px; POSITION: relative;" onclick='returnValue="-1";window.close()' type="button" value="<%=EPiServer.Global.EPLang.Translate("/button/delete")%>" />
	<input id=okButton tabindex=30 style="FLOAT: right; margin-right: 10px; WIDTH: 80px; POSITION: relative;" onclick="OkClick()" type=submit value="<%=EPiServer.Global.EPLang.Translate("/button/ok")%>"> 
</div>

</DIV>
</BODY>
</HTML>