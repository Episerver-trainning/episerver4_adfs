<%@ Page language="c#" Codebehind="ResizeImage.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Editor.Tools.Dialogs.ResizeImage" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
<HEAD>
<meta name="robots" content="noindex,nofollow">
<TITLE><%=EPiServer.Global.EPLang.Translate("/editor/tools/resizeimage/toolheading")%></TITLE>
<META content="Microsoft Visual Studio 7.0" name=GENERATOR>
<meta content=http://schemas.microsoft.com/intellisense/ie5 name=vs_targetSchema><LINK href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css" type=text/css rel=stylesheet >
<link rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css">
<script type="text/javascript" src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/common.js"></script>
<style>
	.rowContainer				{ float: left; width: 100%;  position: relative; }
	.unitValueContainer			{ float: left; position: relative; left: 2px; }
	.unitContainer				{ float: left; width: 100px;  position: relative; left: 6px; top: 10px;}
	.label						{ float: left; width: 130px; position: relative; left: 2px; top: 2px; }
</style>
<base target="_self">
</HEAD>
<script type='text/javascript'>
/*
 * JavaScript support routines for EPiServer
 * Copyright (c) 2005 ElektroPost Stockholm AB
*/

var img;
var proportionRatio = 0;
var validationErrorMessage = null;

var _checkProportions;
var _width;
var _height;
var _divLink;
var _quality;
var _selectedqualityinfo;
var _saveAsCopy;
var _saveAsOriginal;
var _imageFileName;

// Store away references to all interesting elements, for easy access. 
// We can not access the elements directly by their id in code, since they live inside a form element.
function initializeElementReferences()
{
	with(document)
	{
		_checkProportions		= getElementById('checkProportions');
		_width					= getElementById('width');
		_height					= getElementById('height');
		_divLink				= getElementById('divLink');
		_quality				= getElementById('quality');
		_selectedquality		= getElementById('selectedquality');
		_selectedqualityinfo	= getElementById('selectedqualityinfo');
		_saveAsCopy				= getElementById('saveAsCopy');
		_saveAsOriginal			= getElementById('saveAsOriginal');
		_imageFileName			= getElementById('imageFileName');
	}
}
function initialize()
{
	initializeElementReferences();

	var t = new Date();
	img						= document.createElement('IMG');
	img.onreadystatechange	= UpdateImageData;
	img.src					= window.dialogArguments + '?t=' + t.getTime();
	
	_imageFileName.value	= window.dialogArguments;	
}

function setDefaultValues()
{
	_width.value = img.width;
	_height.value = img.height;
	_checkProportions.disabled	= false;
	_checkProportions.checked = true;
	setEnabledState();
	proportionRatio = _width.value / _height.value;
	
	selectListItem(_quality, '100');
	setQualityInfo();
	
	_saveAsCopy.checked = true;
	var imageSrc = window.dialogArguments;
	_saveAsOriginal.disabled = imageSrc.substring(imageSrc.length - 4).toLowerCase() != '.jpg';
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
}

function setQualityInfo()
{
	_selectedquality.innerHTML = _quality.options[_quality.selectedIndex].text;
	var selected = _quality.options[_quality.selectedIndex].value;
	if (selected == '30')
		_selectedqualityinfo.innerHTML = '<%=EPiServer.Global.EPLang.TranslateForScript("/editor/tools/resizeimage/qualityinfo/low")%>';
	else if (selected == '60')
		_selectedqualityinfo.innerHTML = '<%=EPiServer.Global.EPLang.TranslateForScript("/editor/tools/resizeimage/qualityinfo/medium")%>';
	else if (selected == '80')
		_selectedqualityinfo.innerHTML = '<%=EPiServer.Global.EPLang.TranslateForScript("/editor/tools/resizeimage/qualityinfo/high")%>';
	else if (selected == '100')
		_selectedqualityinfo.innerHTML = '<%=EPiServer.Global.EPLang.TranslateForScript("/editor/tools/resizeimage/qualityinfo/maximum")%>';
}

function constrainChecked()
{
	setEnabledState();
}

function setEnabledState()
{
	if(_checkProportions.checked)
	{
		_divLink.style.borderRight	= "2px solid black";
		_divLink.style.borderTop		= "2px solid black";
		_divLink.style.borderBottom	= "2px solid black";
	}
	else
	{
		_divLink.style.borderRight	= "0px solid black";
		_divLink.style.borderTop		= "0px solid black";
		_divLink.style.borderBottom	= "0px solid black";
	}
}

function constrainHeight()
{
	if(!_checkProportions.checked)
		return;
		
	_height.value = Math.round(_width.value / proportionRatio);
}

function constrainWidth()
{
	if(!_checkProportions.checked)
		return;
		
	_width.value = Math.round(_height.value * proportionRatio);
}

function UpdateImageData()
{
	if(this.readyState == 'complete')
	{
		setDefaultValues();			
	}
}

function OkClick()
{
	validationErrorMessage = null;
	if(_width.value <= 0 || _height.value <= 0 || _width.value.length == 0 || _height.value.length == 0 || isNaN(_width.value) || isNaN(_height.value))
	{	// Don't allow saving without specifying new size
		validationErrorMessage = '<%=EPiServer.Global.EPLang.TranslateForScript("/editor/tools/resizeimage/nosizevalidationmessage")%>';
	}
	if (validationErrorMessage != null)
	{	// Override the form's onsubmit to prevent the window from getting submitted 
		// in case of missing info
		document.getElementById('DialogForm').onsubmit = launchErrorMessage;
	}
	else
	{
		document.getElementById('DialogForm').onsubmit = null;
	}
}

function launchErrorMessage()
{
	alert(validationErrorMessage);
	return false;
}

function CancelClick()
{
	returnValue = false;
	window.close();
}

function ResetClick()
{
	setDefaultValues();
}

</script>

<BODY	bottomMargin=0 leftMargin=0 topMargin=0 scroll=no onload="initialize()" rightMargin=0 style="padding-left: 7px">
<form id="DialogForm" method="post" runat="server">
<input type="hidden" id="imageFileName" runat="server" value="" />
<div	style="WIDTH: 100%; POSITION: relative; HEIGHT: 100%" ms_positioning="GridLayout">

<!------------------>
<!-- SIZE SECTION -->
<!------------------>
<fieldSet id="fieldset_size" style="FLOAT: left; POSITION: relative; WIDTH: 220px; HEIGHT: 140px">
	<legend><%=EPiServer.Global.EPLang.Translate("/editor/tools/resizeimage/sizeheading")%>&nbsp;</legend>

	<!-- Constrain proportions -->
	<div class="rowContainer" style="margin-top: 2px; margin-bottom: 5px;">
		<input id="checkProportions" tabindex="1" type="checkbox" onclick="constrainChecked();" style="FLOAT: left; POSITION: relative;"/>
		<div id="divProportions" style="FLOAT: left; LEFT: 3px; TOP: 4px; POSITION: relative; WIDTH: 150px"><label for="checkProportions"><%=EPiServer.Global.EPLang.Translate("/editor/tools/resizeimage/lockproportions")%></label></div>
	</div>

	<!-- Width -->
	<div class="rowContainer">
		<div style="FLOAT: left; LEFT: 3px; TOP:5px; POSITION: relative; WIDTH: 100px;"><label for="width"><%=EPiServer.Global.EPLang.Translate("/editor/tools/resizeimage/specifywidth")%></label></div>
	</div>
	<br/>
	<div class="rowContainer">
		<div class="unitValueContainer">
			<input id="width" onkeyup="constrainHeight();" tabindex="2" runat="server" style="TOP: 7px; POSITION: relative;" type="text" size="7" />
		</div>
		<div class="unitContainer">
			<%=EPiServer.Global.EPLang.Translate("/editor/tools/resizeimage/pixels")%>
		</div>
	</div>

	<!-- Height -->
	<div class="rowContainer" style="margin-top: 5px;">
		<div style="FLOAT: left; LEFT: 3px; TOP: 5px; POSITION: relative; WIDTH: 100px"><label for="height"><%=EPiServer.Global.EPLang.Translate("/editor/tools/imageproperties/specifyheight")%></label></div>
	</div>
	<div class="rowContainer">
		<div class="unitValueContainer">
			<input	id="height" onkeyup="constrainWidth();" tabindex="3" runat="server" style="TOP: 7px; POSITION: relative;" type="text" size="7" />
		</div>
		<div class="unitContainer">
			<%=EPiServer.Global.EPLang.Translate("/editor/tools/resizeimage/pixels")%>
		</div>
	</div>

	<!-- Constrain proportions "link" graphic -->
	<div id="divLink" style="FLOAT: right; POSITION: relative; margin-right: 2px; margin-top: -45px; WIDTH: 15px; HEIGHT: 43px;"></div>
	
	<br/>
	
</fieldSet>


<!--------------------->
<!-- QUALITY SECTION -->
<!--------------------->
<fieldSet id="fieldset_layout" style="FLOAT: left; LEFT: 10px; POSITION: relative; WIDTH: 230px; HEIGHT: 140px">
	<legend><%=EPiServer.Global.EPLang.Translate("/editor/tools/resizeimage/qualityheading")%>&nbsp;</legend>

	<!-- Quality -->
	<div class="rowContainer" style="padding: 2px; margin-top: 3px; margin-bottom: 4px;">
		<div class="label"><label for="quality"><%=EPiServer.Global.EPLang.Translate("/editor/tools/resizeimage/quality")%></label></div>
		<select	id="quality" onchange="setQualityInfo()" tabindex="4" runat="server" style="FLOAT: left; POSITION: relative; WIDTH: 80px;"></select>
	</div>

	<!-- Information -->
	<div class="rowContainer" style="padding: 2px; left: 2px;">
		<%=EPiServer.Global.EPLang.Translate("/editor/tools/resizeimage/qualityinfo/info")%> 
		<span id="selectedquality"></span>
	</div>
	<div id="selectedqualityinfo" class="rowContainer" style="padding: 2px; margin-bottom: 4px; left: 2px;">
	</div>
	
</fieldSet><br/>

<!------------------------->
<!-- SAVE OPTION SECTION -->
<!------------------------->
<fieldSet id="fieldset_saveoption" style="FLOAT: left; POSITION: relative; WIDTH: 460; TOP: 5px;">
	<legend><%=EPiServer.Global.EPLang.Translate("/editor/tools/resizeimage/alternativesheading")%>&nbsp;</legend>

	<div class="rowContainer" style="margin-top: 2px;">
		<input id="saveAsCopy" tabindex="5" type="radio" value="copy" checked runat="server" style="FLOAT: left; POSITION: relative;" name="saveOption" />
		<div style="FLOAT: left; LEFT: 3px; TOP: 4px; POSITION: relative;"><label for="saveAsCopy"><%=EPiServer.Global.EPLang.Translate("/editor/tools/resizeimage/saveoption/saveascopy")%></label></div>
	</div>
	<div class="rowContainer" style="margin-top: 2px; margin-bottom: 5px;">
		<input id="saveAsOriginal" tabindex="6" type="radio" value="original" runat="server" style="FLOAT: left; POSITION: relative;" name="saveOption" />
		<div style="FLOAT: left; LEFT: 3px; TOP: 4px; POSITION: relative;"><label for="saveAsOriginal"><%=EPiServer.Global.EPLang.Translate("/editor/tools/resizeimage/saveoption/replaceoriginal")%></label></div>
	</div>
	<br/>
	
</fieldSet><br/>

<!-------------------->
<!-- FOOTER SECTION -->
<!-------------------->
<div class="rowContainer" style="margin-top: 15px;">
	<input id="cancelButton" tabindex="32" style="FLOAT: right; margin-right: 5px; WIDTH: 80px; POSITION: relative;" onclick="CancelClick()" type="reset" value="<%=EPiServer.Global.EPLang.Translate("/button/cancel")%>">
	<input id="resetButton" tabindex="31" style="FLOAT: right; margin-right: 10px; WIDTH: 80px; POSITION: relative;" onclick="ResetClick()" type="button" value="<%=EPiServer.Global.EPLang.Translate("/button/reset")%>" />
	<input id="okButton" tabindex="30" style="FLOAT: right; margin-right: 10px; WIDTH: 80px; POSITION: relative;" onclick="OkClick()" type="submit" value="<%=EPiServer.Global.EPLang.Translate("/button/ok")%>"> 
</div>

</DIV>
</form>
</BODY>
</HTML>