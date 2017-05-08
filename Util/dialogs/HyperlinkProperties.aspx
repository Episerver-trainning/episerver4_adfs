<%@ Page language="c#" Codebehind="HyperlinkProperties.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Editor.Tools.Dialogs.HyperlinkProperties" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
<HEAD>
<meta name="robots" content="noindex,nofollow">
<TITLE><%=EPiServer.Global.EPLang.Translate("/editor/tools/hyperlinkproperties/toolheading")%></TITLE>
<META content="Microsoft Visual Studio 7.0" name=GENERATOR>
<meta content=http://schemas.microsoft.com/intellisense/ie5 name=vs_targetSchema><LINK href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css" type=text/css rel=stylesheet >
<link rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css">
<script type="text/javascript" src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/common.js"></script>
<script type="text/javascript" src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/system.js"></script>
<style>
	.rowContainer				{ float: left; width: 100%;  position: relative; }
	.unitValueContainer			{ float: left; width: 80px;  position: relative; left: 10px; }
	.unitTypesContainer			{ float: left; width: 80px;  position: relative; left: 6px; }
	.unitSingleTypeContainer	{ float: left; width: 80px;  position: relative; }
	.label						{ float: left; width: 110px; position: relative; left: 2px; top: 2px; }
	.labelLarge					{ float: left; width: 137px; position: relative; left: 2px; top: 2px; }
	.labelXLarge				{ float: left; width: 350px; position: relative; left: 2px; top: 2px; }
	.smallButton				{ float: left; width: 24px;  position: relative; margin-left: 3px; top: 2px; }
	.button						{ float: left; width: 92px;  position: relative; }
	.input						{ float: left; width: 80px;  position: relative; top: 2px; }
	.inputSmall					{ float: left; width: 236px; position: relative; top: 2px; }
	.inputMedium				{ float: left; width: 263px; position: relative; top: 2px; }
	.inputLarge					{ float: left; width: 290px; position: relative; top: 2px; }
	.radioButton				{ float: left; position: relative; }
	.radioButtonLabelSmall		{ float: left; position: relative; left: 3px; top: 4px; width: 117px; }
	.radioButtonLabel			{ float: left; position: relative; left: 3px; top: 4px; }
</style>
<base target="_self">
</HEAD>
<script type='text/javascript'>
/*
 * JavaScript support routines for EPiServer
 * Copyright (c) 2005 ElektroPost Stockholm AB
*/

var isImageToolAvailable;

function setImageToolAvailability()
{
	if (startLink.parentWindow && startLink.parentWindow.EditorScriptVersions)
	{
		for(var index = 0; index < startLink.parentWindow.EditorScriptVersions.length; index++)
		{
			if (startLink.parentWindow.EditorScriptVersions[index].indexOf('HyperlinkImageProperties') == 0)
			{
				isImageToolAvailable = true;
				return;
			}
		}
	}
	isImageToolAvailable = false;
}

/* Trim() function duplicated from HtmlTextBox2_API.js */
String.prototype.Trim = new Function("return this.replace(/^\\s+|\\s+$/g,'')");

var startLink;

var baseHyperlinkImagePropertiesUrl = '';
var baseFileManagerBrowserUrl = '';
var editorID;

var returnValueValidationErrorMessage = null;

function GetActiveTab()
{
	if(WebPageTab.IsActive())
		return WebPageTab;
	else if(DocumentTab.IsActive())
		return DocumentTab;
	else if(EmailTab.IsActive())
		return EmailTab;
}

function TabObject() 
{}

var WebPageTab	= new TabObject();
var DocumentTab = new TabObject();
var EmailTab	= new TabObject();

TabObject.prototype.IsActive = function()
{
	return (this.TabElement.className == '<%=TabObjectActiveClass%>');
}
TabObject.prototype.GetActiveUrlFieldValue = function()
{
	if(this.activeUrlField.tagName.toUpperCase() == 'INPUT')
		return this.activeUrlField.value.Trim();
	else if(this.activeUrlField.tagName.toUpperCase() == 'SELECT')
		return this.activeUrlField[this.activeUrlField.selectedIndex].value;
}
TabObject.prototype.GetCompleteUrl = function()
{
	// TODO: Expand logic to handle file:/// and https:// (would get double prefixes now)
	if(this.GetActiveUrlFieldValue().indexOf(this.activeUrlPrefix) == 0)
		return this.GetActiveUrlFieldValue();
	else if(this.GetActiveUrlFieldValue().length > 0)
		return this.activeUrlPrefix + this.GetActiveUrlFieldValue();
	else
		return '';
}
TabObject.prototype.GetDisplayUrl = function()
{
	var displayUrl;
	if(this.isInternalPageLink)
		displayUrl = this.InternalPage.value;
	else if(this.isInternalDocument)
	{
		if (this.GetActiveUrlFieldValue().lastIndexOf('/') > 0)
			displayUrl = '<%=EPiServer.Global.EPLang.TranslateForScript("/editor/tools/hyperlinkproperties/tabs/document")%>: ' + 
						this.GetActiveUrlFieldValue().substring(
							this.GetActiveUrlFieldValue().lastIndexOf('/') + 1, this.GetActiveUrlFieldValue().length);
		else
			displayUrl = this.GetActiveUrlFieldValue();	
	}
	else if(this.activeUrlPrefix == '#')
		displayUrl = '<%=EPiServer.Global.EPLang.TranslateForScript("/editor/tools/hyperlinkproperties/anchor")%> ' + this.GetActiveUrlFieldValue();
	else if(this.activeUrlPrefix == 'mailto:')
		displayUrl = '<%=EPiServer.Global.EPLang.TranslateForScript("/editor/tools/hyperlinkproperties/emailaddress")%> ' + this.GetActiveUrlFieldValue();
	else
		displayUrl = this.GetCompleteUrl();
	if (displayUrl.length == 0)
		displayUrl = ' ';
	return displayUrl;
}
TabObject.prototype.GetDefaultText = function()
{
	if(this.isInternalPageLink)
	{
		if (this.InternalPage.value.indexOf('[') > 0)
			return this.InternalPage.value.substring(0, this.InternalPage.value.indexOf('[') - 1);
		else
			return this.InternalPage.value;
	}
	else if(this.isInternalDocument)
	{
		if (this.GetActiveUrlFieldValue().lastIndexOf('/') > 0)
			return this.GetActiveUrlFieldValue().substring(this.GetActiveUrlFieldValue().lastIndexOf('/') + 1, this.GetActiveUrlFieldValue().length);
		else
			return this.GetActiveUrlFieldValue();
	}
	else if(this.activeUrlPrefix == '#')
		return '#' + this.GetActiveUrlFieldValue();
	else if(this.activeUrlPrefix == 'mailto:')
		return this.GetActiveUrlFieldValue();
	else
		return this.GetCompleteUrl();
}
TabObject.prototype.UseImage = function()
{
	return this.ItemTypeImage.checked;
} 

function CloneObject(obj, deep)
{
	var objectClone = new Object();
	
	for (var property in obj)
	{
		if (!deep)
			objectClone[property] = obj[property];
		else if (typeof obj[property] == 'object')
			objectClone[property] = CloneObject(obj[property], deep);
		else
			objectClone[property] = obj[property];
	}
 
	return objectClone;
}

var _linkinternalurl;
var _linkinternalurlname;
var _linklanguages;
var _linkexternalurl;
var _linktitle;
var _linkframe;
var _linkitemtypetext;
var _linkitemtypeimage;
var _linkdisplaytext;
var _linkdisplayimage;
var _linkdisplayimagebutton;
var _linkanchors;
var _linktypeinternal;
var _linktypeexternal;
var _linktypeanchor;
var _linkInternalAddressContainer;
var _linkLanguageContainer;
var _linkExternalAddressContainer;
var _linkAnchorContainer;

var _documentinternalurl;
var _documentnetworkurl;
var _documentexternalurl;
var _documentinternalurlbutton;
var _documenttitle;
var _documentframe;
var _documentitemtypetext;
var _documentitemtypeimage;
var _documentdisplaytext;
var _documentdisplayimage;
var _documentdisplayimagebutton;
var _documenttypeinternal;
var _documenttypenetwork;
var _documenttypeexternal;
var _documentInternalAddressContainer;
var _documentNetworkAddressContainer;
var _documentExternalAddressContainer;

var _emailaddress;
var _emailtitle;
var _emailitemtypetext;
var _emailitemtypeimage;
var _emaildisplaytext;
var _emaildisplayimage;
var _emaildisplayimagebutton;

function initialize()
{
	startLink = window.dialogArguments;
	
	baseHyperlinkImagePropertiesUrl	= startLink.imageDialogUrl;
	baseFileManagerBrowserUrl		= startLink.fileManagerBrowserUrl;
	editorID						= startLink.editorID;

	initializeElementReferences();
	initializeTabObjects();
	
	if (startLink.href == null || startLink.imageEditingInProgress)
		document.getElementById('deleteButton').disabled = true;

	setDefaultValues();
	
	if ('<%=IsInternalUrl%>' == 'True' || '<%=IsInternalDocument%>' == 'True')
		CheckIfPageRefIsValid();
}

function CheckIfPageRefIsValid()
{
	var errorMessage = '';
	if ('<%=IsInternalUrl%>' == 'True' && '<%=PageNotFound%>' == 'True')
		errorMessage = '<%=EPiServer.Global.EPLang.TranslateForScript("/editor/tools/hyperlinkproperties/pagenotfoundmessage")%>' + '\n\n' + 
						'<%=EPiServer.Global.EPLang.TranslateForScript("/editor/tools/hyperlinkproperties/selectnewpagemessage")%>';
	else if ('<%=IsInternalUrl%>' == 'True' && '<%=PageAccessDenied%>' == 'True')
		errorMessage = '<%=EPiServer.Global.EPLang.TranslateForScript("/editor/tools/hyperlinkproperties/pageaccessdeniedmessage")%>' + '\n\n' + 
						'<%=EPiServer.Global.EPLang.TranslateForScript("/editor/tools/hyperlinkproperties/selectnewpagemessage")%>';
	else if ('<%=IsInternalDocument%>' == 'True' && '<%=DocumentNotFound%>' == 'True')
		errorMessage = '<%=EPiServer.Global.EPLang.TranslateForScript("/editor/tools/hyperlinkproperties/documentnotfoundmessage")%>' + '\n\n' + 
						'<%=EPiServer.Global.EPLang.TranslateForScript("/editor/tools/hyperlinkproperties/selectnewdocumentmessage")%>';
	else if ('<%=IsInternalDocument%>' == 'True' && '<%=DocumentUnauthorizedAccess%>' == 'True')
		errorMessage = '<%=EPiServer.Global.EPLang.TranslateForScript("/editor/tools/hyperlinkproperties/documentaccessdeniedmessage")%>' + '\n\n' + 
						'<%=EPiServer.Global.EPLang.TranslateForScript("/editor/tools/hyperlinkproperties/selectnewdocumentmessage")%>';
	if (errorMessage != '')
	{
		alert(errorMessage);
		startLink.href = '';
	}
}

function initializeTabObjects()
{
	WebPageTab.TabElement		= document.getElementById('<%=WebPagePanel.ClientID%>');
	WebPageTab.TabIndex			= '0';
	DocumentTab.TabElement		= document.getElementById('<%=DocumentPanel.ClientID%>');
	DocumentTab.TabIndex		= '1';
	EmailTab.TabElement			= document.getElementById('<%=EmailPanel.ClientID%>');
	EmailTab.TabIndex			= '2';
	
	WebPageTab.ItemTypeImage	= _linkitemtypeimage;
	WebPageTab.TextField		= _linkdisplaytext;
	WebPageTab.TitleField		= _linktitle;
	WebPageTab.TargetFrame		= _linkframe;
	WebPageTab.LanguageList		= _linklanguages;
	WebPageTab.InternalPage		= _linkinternalurlname;
	WebPageTab.imageSrcField	= _linkdisplayimage;
	WebPageTab.linkObject		= CloneObject(startLink);
	WebPageTab.imageObject		= CloneObject(startLink.imageObject);

	DocumentTab.ItemTypeImage	= _documentitemtypeimage;
	DocumentTab.TextField		= _documentdisplaytext;
	DocumentTab.TitleField		= _documenttitle;
	DocumentTab.TargetFrame		= _documentframe;
	DocumentTab.imageSrcField	= _documentdisplayimage;
	DocumentTab.linkObject		= CloneObject(startLink);
	DocumentTab.imageObject		= CloneObject(startLink.imageObject);

	EmailTab.ItemTypeImage		= _emailitemtypeimage;
	EmailTab.TextField			= _emaildisplaytext;
	EmailTab.TitleField			= _emailtitle;
	EmailTab.TargetFrame		= null;
	EmailTab.imageSrcField		= _emaildisplayimage;
	EmailTab.linkObject			= CloneObject(startLink);
	EmailTab.imageObject		= CloneObject(startLink.imageObject);
}

// Store away references to all interesting elements, for easy access. 
// We can not access the elements directly by their id in code, since they live inside a form element.
function initializeElementReferences()
{
	with(document)
	{
		// Web page tab settings
		_linkinternalurl					= getElementById('<%=PageRefFieldId%>');
		_linkinternalurlname				= getElementById('<%=PageNameFieldId%>');
		_linklanguages						= getElementById('linklanguages');
		_linkexternalurl					= getElementById('linkexternalurl');
		_linktitle							= getElementById('linktitle');
		_linkframe							= getElementById('linkframe');
		_linkitemtypetext					= getElementById('linkitemtypetext');
		_linkitemtypeimage					= getElementById('linkitemtypeimage');
		_linkdisplaytext					= getElementById('linkdisplaytext');
		_linkdisplayimage					= getElementById('linkdisplayimage');
		_linkdisplayimagebutton				= getElementById('linkdisplayimagebutton');
		_linkanchors						= getElementById('linkanchors');
		_linktypeinternal					= getElementById('linktypeinternal');
		_linktypeexternal					= getElementById('linktypeexternal');
		_linktypeanchor						= getElementById('linktypeanchor');
		_linkInternalAddressContainer		= getElementById('linkInternalAddressContainer');
		_linkLanguageContainer				= getElementById('linkLanguageContainer');
		_linkExternalAddressContainer		= getElementById('linkExternalAddressContainer');
		_linkAnchorContainer				= getElementById('linkAnchorContainer');

		// Document tab settings
		_documentinternalurl				= getElementById('documentinternalurl');
		_documentnetworkurl					= getElementById('documentnetworkurl');
		_documentexternalurl				= getElementById('documentexternalurl');
		_documentinternalurlbutton			= getElementById('documentinternalurlbutton');
		_documenttitle						= getElementById('documenttitle');
		_documentitemtypetext				= getElementById('documentitemtypetext');
		_documentitemtypeimage				= getElementById('documentitemtypeimage');
		_documentdisplaytext				= getElementById('documentdisplaytext');
		_documentdisplayimage				= getElementById('documentdisplayimage');
		_documentdisplayimagebutton			= getElementById('documentdisplayimagebutton');
		_documentframe						= getElementById('documentframe');
		_documenttypeinternal				= getElementById('documenttypeinternal');
		_documenttypeexternal				= getElementById('documenttypeexternal');
		_documenttypenetwork				= getElementById('documenttypenetwork');
		_documentInternalAddressContainer	= getElementById('documentInternalAddressContainer');
		_documentNetworkAddressContainer	= getElementById('documentNetworkAddressContainer');
		_documentExternalAddressContainer	= getElementById('documentExternalAddressContainer');

		// E-mail tab settings
		_emailaddress						= getElementById('emailaddress');
		_emailtitle							= getElementById('emailtitle');
		_emailitemtypetext					= getElementById('emailitemtypetext');
		_emailitemtypeimage					= getElementById('emailitemtypeimage');
		_emaildisplaytext					= getElementById('emaildisplaytext');
		_emaildisplayimage					= getElementById('emaildisplayimage');
		_emaildisplayimagebutton			= getElementById('emaildisplayimagebutton');
	}
}

function setDefaultValues()
{
	// Preselect values based on current link configuration
	// Web Page tab
	setTextBoxValue(_linktitle,				startLink.title);
	setTextBoxValue(_linkdisplaytext,		startLink.text);
	if (startLink.imageObject)
		setTextBoxValue(_linkdisplayimage,		startLink.imageObject.src);
	if(_linkdisplayimage.value.length > 0)
		_linkitemtypeimage.checked = true;
	else if (!startLink.onlyUrl)
		_linkitemtypetext.checked = true;
	populateAnchorList(startLink.anchors);
	selectListItem(_linkframe,		startLink.target);

	// Document tab
	setTextBoxValue(_documenttitle,			startLink.title);
	setTextBoxValue(_documentdisplaytext,	startLink.text);
	if (startLink.imageObject)
		setTextBoxValue(_documentdisplayimage,	startLink.imageObject.src);
	if(_documentdisplayimage.value.length > 0)
		_documentitemtypeimage.checked = true;
	else if (!startLink.onlyUrl)
		_documentitemtypetext.checked = true;
	selectListItem(_documentframe,	startLink.target);

	// E-mail tab
	setTextBoxValue(_emailtitle,			startLink.title);
	setTextBoxValue(_emaildisplaytext,		startLink.text);
	if (startLink.imageObject)
		setTextBoxValue(_emaildisplayimage,		startLink.imageObject.src);
	if(_emaildisplayimage.value.length > 0)
		_emailitemtypeimage.checked = true;
	else if (!startLink.onlyUrl)
		_emailitemtypetext.checked = true;

	// Set default radio buttons
	_linktypeinternal.checked = true;
	_documenttypeinternal.checked = true;
	
	// Check link type
	if (startLink.href)
	{
		var url = startLink.href;
		if ('<%=IsInternalDocument%>' == 'True')
		{	// Internal document
			if ('<%=DocumentNotFound%>' != 'True' && '<%=DocumentUnauthorizedAccess%>' != 'True')
				setTextBoxValue(_documentinternalurl, url);
		}
		else if ('<%=IsNetworkDocument%>' == 'True')
		{	// Network document
			_documenttypenetwork.checked = true;
			setTextBoxValue(_documentnetworkurl, url);
		}
		else if ('<%=IsExternalDocument%>' == 'True')
		{	// External document
			_documenttypeexternal.checked = true;
			setTextBoxValue(_documentexternalurl, url);
		}
		else if ('<%=IsMailLink%>' == 'True')
		{	// Email link
			setTextBoxValue(_emailaddress, url.substring(7, url.length));
		}
		else
		{	// Web page link
			if(url != null && url.indexOf('#') == 0)
			{	// Anchor
				var currentAnchor = url.substring(1, url.length);
				_linktypeanchor.checked = true;
				selectListItem(_linkanchors, currentAnchor);
			}
			else if ('<%=IsInternalUrl%>' == 'True')
			{	// Internal page
				selectListItem(_linklanguages, startLink.language);
			}
			else
			{	// External page
				_linktypeexternal.checked = true;
				setTextBoxValue(_linkexternalurl, url);
			}
		}
	}
	else if (startLink.onlyUrl)
	{
		_linktypeexternal.checked = true;
	}

	setImageButtonBehaviour(_linkdisplayimagebutton);
	setImageButtonBehaviour(_documentdisplayimagebutton);
	setImageButtonBehaviour(_emaildisplayimagebutton);

	setImageToolAvailability();
	setEnabledState();
	setFieldVisibility();
}

function setFieldVisibility()
{
	// Web page tab
	if(_linktypeanchor.checked)
	{	// Anchor
		_linkAnchorContainer.style.display = 'inline';
		_linkInternalAddressContainer.style.display = 'none';
		_linkLanguageContainer.style.display = 'none';
		_linkExternalAddressContainer.style.display = 'none';
		WebPageTab.activeUrlField		= _linkanchors;
		WebPageTab.activeUrlPrefix		= '#';
		WebPageTab.isInternalPageLink	= false;
	}
	else if (_linktypeinternal.checked)
	{	// Internal page
		_linkInternalAddressContainer.style.display = 'inline';
		_linkLanguageContainer.style.display = <%=Configuration.EnableGlobalizationSupport ? "'inline'" : "startLink.language!=null ? 'inline' : 'none'"%>;
		_linkAnchorContainer.style.display = 'none';
		_linkExternalAddressContainer.style.display = 'none';
		WebPageTab.activeUrlField		= _linkinternalurl;
		WebPageTab.activeUrlPrefix		= '';
		WebPageTab.isInternalPageLink	= true;
	}
	else if (_linktypeexternal.checked)
	{	// External page
		_linkExternalAddressContainer.style.display = 'inline';
		_linkAnchorContainer.style.display = 'none';
		_linkInternalAddressContainer.style.display = 'none';
		_linkLanguageContainer.style.display = 'none';
		WebPageTab.activeUrlField		= _linkexternalurl;
		WebPageTab.activeUrlPrefix		= '';
		WebPageTab.isInternalPageLink	= false;
	}

	// Document tab
	if (_documenttypeinternal.checked)
	{	// Internal document
		_documentInternalAddressContainer.style.display = 'inline';
		_documentNetworkAddressContainer.style.display = 'none';
		_documentExternalAddressContainer.style.display = 'none';
		DocumentTab.activeUrlField		= _documentinternalurl;
		DocumentTab.activeUrlPrefix		= '';
		DocumentTab.isInternalDocument	= true;
	}
	else if(_documenttypenetwork.checked)
	{	// Network document
		_documentNetworkAddressContainer.style.display = 'inline';
		_documentExternalAddressContainer.style.display = 'none';
		_documentInternalAddressContainer.style.display = 'none';
		DocumentTab.activeUrlField		= _documentnetworkurl;
		DocumentTab.activeUrlPrefix		= '';
		DocumentTab.isInternalDocument	= false;
	}
	else if(_documenttypeexternal.checked)
	{	// External document
		_documentExternalAddressContainer.style.display = 'inline';
		_documentNetworkAddressContainer.style.display = 'none';
		_documentInternalAddressContainer.style.display = 'none';
		DocumentTab.activeUrlField		= _documentexternalurl;
		DocumentTab.activeUrlPrefix		= '';
		DocumentTab.isInternalDocument	= false;
	}

	// Email tab
	EmailTab.activeUrlField	= _emailaddress;
	EmailTab.activeUrlPrefix = 'mailto:';
}

function setEnabledState()
{	
	if (startLink.onlyUrl)
	{
		setImageButtonEnabled(_linkdisplayimagebutton, false);
		_linkitemtypeimage.disabled				= true;
		_linkitemtypetext.disabled				= true;
		_linkdisplaytext.disabled				= true;
		_linktitle.disabled						= true;
		_linkframe.disabled						= true;
		_linktypeanchor.disabled				= true;
		if (WebPageTab.IsActive())
			_linkexternalurl.focus();
		setImageButtonEnabled(_documentdisplayimagebutton, false);
		_documentitemtypeimage.disabled			= true;
		_documentitemtypetext.disabled			= true;
		_documentdisplaytext.disabled			= true;
		_documenttitle.disabled					= true;
		_documentframe.disabled					= true;
		if (DocumentTab.IsActive())
		{
			if (_documenttypeexternal.checked)
				_documentexternalurl.focus();
			else if (_documenttypenetwork.checked)
				_documentnetworkurl.focus();
		}
		setImageButtonEnabled(_emaildisplayimagebutton, false);
		_emailitemtypeimage.disabled			= true;
		_emailitemtypetext.disabled				= true;
		_emaildisplaytext.disabled				= true;
		_emailtitle.disabled					= true;
		if (EmailTab.IsActive())
			_emailaddress.focus();
	}
	else if (!isImageToolAvailable)
	{
		setImageButtonEnabled(_linkdisplayimagebutton, false);
		_linkitemtypeimage.disabled				= true;
		setImageButtonEnabled(_documentdisplayimagebutton, false);
		_documentitemtypeimage.disabled			= true;
		setImageButtonEnabled(_emaildisplayimagebutton, false);
		_emailitemtypeimage.disabled			= true;
	}
	else if (startLink.imageEditingInProgress)
	{
		setImageButtonEnabled(_linkdisplayimagebutton, false);
		_linkitemtypetext.disabled				= true;
		_linkdisplaytext.disabled				= true;
		if (WebPageTab.IsActive())
			_linktitle.focus();
		setImageButtonEnabled(_documentdisplayimagebutton, false);
		_documentitemtypetext.disabled			= true;
		_documentdisplaytext.disabled			= true;
		if (DocumentTab.IsActive())
			_documenttitle.focus();
		setImageButtonEnabled(_emaildisplayimagebutton, false);
		_emailitemtypetext.disabled				= true;
		_emaildisplaytext.disabled				= true;
		if (EmailTab.IsActive())
			_emailtitle.focus();
	}
	else
	{
		if (_linkitemtypeimage.checked)
		{
			setImageButtonEnabled(_linkdisplayimagebutton, true);
			_linkdisplaytext.disabled				= true;
			if (WebPageTab.IsActive())
				_linktitle.focus();
		}
		else
		{
			setImageButtonEnabled(_linkdisplayimagebutton, false);
			_linkdisplaytext.disabled				= false;
			if (WebPageTab.IsActive())
				_linkdisplaytext.focus();
		}
		
		if (_documentitemtypeimage.checked)
		{
			setImageButtonEnabled(_documentdisplayimagebutton, true);
			_documentdisplaytext.disabled			= true;
			if (DocumentTab.IsActive())
				_documenttitle.focus();
		}
		else
		{
			setImageButtonEnabled(_documentdisplayimagebutton, false);
			_documentdisplaytext.disabled			= false;
			if (DocumentTab.IsActive())
				_documentdisplaytext.focus();
		}
		
		if (_emailitemtypeimage.checked)
		{
			setImageButtonEnabled(_emaildisplayimagebutton, true);
			_emaildisplaytext.disabled			= true;
			if (EmailTab.IsActive())
				_emailtitle.focus();
		}
		else
		{
			setImageButtonEnabled(_emaildisplayimagebutton, false);
			_emaildisplaytext.disabled			= false;
			if (EmailTab.IsActive())
				_emaildisplaytext.focus();
		}
	}
}

function setImageButtonBehaviour(img)
{
	img.onmouseover = setImageSrc;
	img.onmousedown = setImageSrc;
	img.onmouseout	= setImageSrc;
	img.onmouseup	= setImageSrc;
}

function setImageButtonEnabled(img, enabled)
{
	img.disabled = !enabled;
	if(enabled)
		img.src			= '<%=EPiServer.Global.EPConfig.RootDir%>Util/images/Editor/image_off.gif';
	else
		img.src			= '<%=EPiServer.Global.EPConfig.RootDir%>Util/images/Editor/image_disabled.gif';
}

function setImageSrc()
{
	if (event.srcElement.disabled)
		return;
		
	switch (event.type)
	{
		case 'mouseover':
			event.srcElement.src='<%=EPiServer.Global.EPConfig.RootDir%>Util/images/Editor/image_over.gif';
			break;
		case 'mousedown':
			event.srcElement.src='<%=EPiServer.Global.EPConfig.RootDir%>Util/images/Editor/image_selected.gif';
			break;
		case 'mouseout':
			event.srcElement.src='<%=EPiServer.Global.EPConfig.RootDir%>Util/images/Editor/image_off.gif';
			break;
		case 'mouseup':
			event.srcElement.src='<%=EPiServer.Global.EPConfig.RootDir%>Util/images/Editor/image_over.gif';
			break;
	}
}

function populateAnchorList(anchorArray)
{
	var newOption;
	
	// Create an empty entry at the beginning of the list
	newOption = document.createElement("OPTION");
	_linkanchors.add(newOption);
	
	// Find all anchors in the anchor array
	if (anchorArray)
	{
		for(i = 0; i < anchorArray.length; i++)
		{
			newOption		= document.createElement("OPTION");
			if (anchorArray[i].length > 40)
				newOption.text	= anchorArray[i].substr(0,40) + '...';
			else
				newOption.text	= anchorArray[i];
			newOption.value	= anchorArray[i];
			_linkanchors.add(newOption);
		}
	}
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
function buildReturnValue()
{
	// For all return values - if they are empty/cleared/undefined, pass back null.
	var returnValue = startLink;
	
	returnValueValidationErrorMessage = null;

	var activeTab = GetActiveTab();
	document.getElementById('activeTab').value = activeTab.TabIndex;
	
	returnValue.href			= activeTab.GetCompleteUrl();
	returnValue.displayUrl		= activeTab.GetDisplayUrl();
	if (returnValue.href.Trim().length == 0 || returnValue.href == "0")
	{	
		returnValueValidationErrorMessage = '<%=EPiServer.Global.EPLang.TranslateForScript("/editor/tools/hyperlinkproperties/nourlvalidationmessage")%>';
	}
	else
	{
		returnValue.isUpdated		= true;
		returnValue.title			= activeTab.TitleField.value;
		returnValue.target			= activeTab.TargetFrame != null ? activeTab.TargetFrame[activeTab.TargetFrame.selectedIndex].value : null;
		returnValue.language		= activeTab.isInternalPageLink ? activeTab.LanguageList[activeTab.LanguageList.selectedIndex].value : null;
		if(activeTab.UseImage())
		{	// Linked image, do not use text
			returnValue.text		= null;
			returnValue.imageObject	= activeTab.imageObject;
			if (!returnValue.imageEditingInProgress && (returnValue.imageObject.src == null || returnValue.imageObject.src.Trim().length == 0))
			{
				returnValueValidationErrorMessage = '<%=EPiServer.Global.EPLang.TranslateForScript("/editor/tools/hyperlinkproperties/noimageinfovalidationmessage")%>' + '\n\n' + 
							'<%=EPiServer.Global.EPLang.TranslateForScript("/editor/tools/hyperlinkproperties/specifyimagemessage")%>';
			}
		}
		else
		{	// Linked text, do not use image
			if(activeTab.TextField.value.Trim().length > 0)
			{
				returnValue.text = activeTab.TextField.value.Trim();
			}
			else // Provide a default text for the link
			{
				returnValue.text = activeTab.GetDefaultText();
			}
			returnValue.imageObject	= null;
		}
	}
	
	if (returnValueValidationErrorMessage != null)
	{	// Override the form's onsubmit to prevent the window from getting submitted 
		// in case of missing info
		document.getElementById('DialogForm').onsubmit = launchErrorMessage;
	}
	else
	{
		document.getElementById('DialogForm').onsubmit = null;
	}
		
	return returnValue;	
}

function LaunchHyperlinkImagePropertiesWindow()
{
	var returnValue;
	var dialogUrl = baseHyperlinkImagePropertiesUrl;
	
	var currentTab = GetActiveTab();
	currentTab.imageObject.linkEditingInProgress = true;
	// Update the current tab's linkObject to reflect the entered URL
	currentTab.linkObject.displayUrl = currentTab.GetDisplayUrl();
	currentTab.imageObject.linkObject = currentTab.linkObject;
	returnValue = OpenDialog(dialogUrl, currentTab.imageObject, 485, 445);

	if(returnValue != null && returnValue != 0)
	{
		currentTab.imageObject			= returnValue;
		currentTab.imageSrcField.value	= currentTab.imageObject.src;
	}
}

function LaunchFileManagerBrowser()
{
	var returnValue;
	var currentTab = GetActiveTab();
	
	var dialogUrl			= baseFileManagerBrowserUrl + '&hideclearbutton=true&browserselectionmode=file&selectedfile=' + encodeURIComponent(_documentinternalurl.value);
	var dialogParameters	= 'dialogWidth:600px;dialogHeight:500px;help=no;resizable:yes;status:no;';
	returnValue				= OpenDialogWithParameters(dialogUrl, null, dialogParameters);

	if(returnValue && returnValue != _documentinternalurl.Value)
	{
		_documentinternalurl.value = returnValue;
	}
}

function launchErrorMessage()
{ 
	alert(returnValueValidationErrorMessage);
	return false; 
}

function OkClick()
{	
	returnValue = buildReturnValue();
}

function CancelClick()
{
	returnValue = 0;
	window.close();
}

</script>

<BODY	bottomMargin=0 leftMargin=0 topMargin=0 scroll=no onload="initialize()" rightMargin=0 style="padding-left: 7px">
<form id="DialogForm" method="post" runat="server">
<div	style="WIDTH: 100%; POSITION: relative; HEIGHT: 100%" ms_positioning="GridLayout">

<!-------------------->
<!-- FOOTER SECTION -->
<!-------------------->
<div class="rowContainer" style="position: absolute; top: 325px;">
	<input id=cancelButton tabindex=32 style="FLOAT: right; margin-right: 5px; WIDTH: 80px; POSITION: relative;" onclick="CancelClick()" type="reset" value="<%=EPiServer.Global.EPLang.Translate("/button/cancel")%>" />
	<input id="deleteButton" tabindex=31 style="FLOAT: right; margin-right: 10px; WIDTH: 80px; POSITION: relative;" onclick='returnValue="-1";window.close()' type="button" value="<%=EPiServer.Global.EPLang.Translate("/button/delete")%>" />
	<input id=okButton tabindex=30 style="FLOAT: right; margin-right: 10px; WIDTH: 80px; POSITION: relative;" onclick="OkClick()" type="submit" value="<%=EPiServer.Global.EPLang.Translate("/button/ok")%>" /> 
	<input id="activeTab" type="hidden" runat="server" value="" />
	<input id="disablePageBrowserSelfLinkButton" type="hidden" value="true" />
</div>

<EPiServerSys:tabstrip id="actionTab" runat="server" AutoPostBack="false" TargetID="tabView">
	<EPiServerSys:tab Text="/editor/tools/hyperlinkproperties/tabs/webpage" runat="server" id="WebPageTab"/>
	<EPiServerSys:tab Text="/editor/tools/hyperlinkproperties/tabs/document" runat="server" id="DocumentTab"/>
	<EPiServerSys:tab Text="/editor/tools/hyperlinkproperties/tabs/email" runat="server" id="EmailTab"/>
</EPiServerSys:tabstrip>

<asp:panel id="tabView" runat="server">

	<!---------------- WEB PAGE TAB ---------------->
	<asp:Panel id="WebPagePanel"  runat="server" >
		<!------------------------->
		<!-- INFORMATION SECTION -->
		<!------------------------->
		<fieldSet id="fieldset_information" style="FLOAT: left; POSITION: relative; WIDTH: 420; TOP: 5px;">
			<legend><%=EPiServer.Global.EPLang.Translate("/editor/tools/hyperlinkproperties/informationheading")%>&nbsp;</legend>

			<!-- Display Text -->
			<div class="rowContainer" style="padding: 3px;">
				<input class="radioButton" id="linkitemtypetext" name="linkitemtype" type="radio" onclick="setEnabledState()" value="text" tabindex="1" />
				<div class="radioButtonLabelSmall"><label for="linkitemtypetext"><%=EPiServer.Global.EPLang.Translate("/editor/tools/hyperlinkproperties/clickabletext")%></label></div>
				<input id="linkdisplaytext" class="inputMedium" type="text" tabindex="2" />
			</div>

			<!-- Display Image -->
			<div class="rowContainer" style="padding: 3px;">
				<input class="radioButton" id="linkitemtypeimage" name="linkitemtype" type="radio" onclick="setEnabledState()" value="image" tabindex="3" />
				<div class="radioButtonLabelSmall"><label for="linkitemtypeimage"><%=EPiServer.Global.EPLang.Translate("/editor/tools/hyperlinkproperties/clickableimage")%></label></div>
				<input id="linkdisplayimage" class="inputSmall" type="text" disabled />
				<img id="linkdisplayimagebutton" onclick="LaunchHyperlinkImagePropertiesWindow();" src="<%=EPiServer.Global.EPConfig.RootDir%>Util/images/Editor/image_off.gif" title="<%=EPiServer.Global.EPLang.Translate("/editor/tools/hyperlinkproperties/editimageproperties")%>">
			</div>

			<!-- Link Title -->
			<div class="rowContainer" style="padding: 3px;">
				<div class="labelLarge"><%=EPiServer.Global.EPLang.Translate("/editor/tools/hyperlinkproperties/linktitle")%></div>
				<input id="linktitle" class="inputMedium" type="text" tabindex="5" />
			</div>

			<!-- Target Frame -->
			<div class="rowContainer" style="padding: 3px;">
				<div class="labelLarge"><%=EPiServer.Global.EPLang.Translate("/editor/tools/hyperlinkproperties/targetframe")%></div>
				<asp:DropDownList id="linkframe" tabindex="6" Runat="server" style="float:left; position:relative;" />
			</div>
			<br/>
			
		</fieldSet><br/>
		<!------------------>
		<!-- LINK SECTION -->
		<!------------------>
		<fieldSet id="fieldset_link" style="FLOAT: left; POSITION: relative; WIDTH: 420; TOP: 10px;">
			<legend><%=EPiServer.Global.EPLang.Translate("/editor/tools/hyperlinkproperties/linktargetheading")%>&nbsp;</legend>

			<!-- Internal Link -->
			<div class="rowContainer" style="padding: 3px;">
				<input class="radioButton" id="linktypeinternal" name="linktype" type="radio" onclick="setFieldVisibility()" value="internal" tabindex="7" runat="server" />
				<div class="radioButtonLabel"><label for="linktypeinternal"><%=EPiServer.Global.EPLang.Translate("/editor/tools/hyperlinkproperties/internallink")%></label></div>
			</div>
			
			<!-- External Link -->
			<div class="rowContainer" style="padding: 3px;">
				<input class="radioButton" id="linktypeexternal" name="linktype" type="radio" onclick="setFieldVisibility()" value="external" tabindex="8" />
				<div class="radioButtonLabel"><label for="linktypeexternal"><%=EPiServer.Global.EPLang.Translate("/editor/tools/hyperlinkproperties/externallink")%></label></div>
			</div>
			
			<!-- Anchor Link -->
			<div class="rowContainer" style="padding: 3px;">
				<input class="radioButton" id="linktypeanchor" name="linktype" type="radio" onclick="setFieldVisibility()" value="anchor" tabindex="9" />
				<div class="radioButtonLabel"><label for="linktypeanchor"><%=EPiServer.Global.EPLang.Translate("/editor/tools/hyperlinkproperties/anchorlink")%></label></div>
			</div>

			<!-- Internal Address -->
			<div class="rowContainer" style="padding: 3px;" id="linkInternalAddressContainer">
				<div class="labelLarge"><%=EPiServer.Global.EPLang.Translate("/editor/tools/hyperlinkproperties/address")%></div>
				<EPiServer:InputPageReference runat="server" id="linkinternalurl" tabindex="10" style="float:left; position:relative;" />
			</div>

			<!-- Language List -->
			<div class="rowContainer" style="padding: 3px;" id="linkLanguageContainer">
				<div class="labelLarge"><%=EPiServer.Global.EPLang.Translate("/editor/tools/hyperlinkproperties/language")%></div>
				<asp:DropDownList id="linklanguages" tabindex="11" Runat="server" style="float:left; position:relative;" />
			</div>

			<!-- External Address --> 
			<div class="rowContainer" style="padding: 3px;" id="linkExternalAddressContainer">
				<div class="labelLarge"><%=EPiServer.Global.EPLang.Translate("/editor/tools/hyperlinkproperties/address")%></div>
				<input id="linkexternalurl" class="inputMedium" type="text" tabindex="10" value="http://" />
			</div>
			
			<!-- Anchor List -->
			<div class="rowContainer" style="padding: 3px;" id="linkAnchorContainer">
				<div class="labelLarge"><%=EPiServer.Global.EPLang.Translate("/editor/tools/hyperlinkproperties/anchor")%></div>
				<select id="linkanchors" tabindex="10">
				</select>
			</div>
			<br/>
		</fieldSet><br/>
	</asp:Panel>

	<!---------------- DOCUMENT TAB ---------------->
	<asp:Panel ID="DocumentPanel" runat="server" >
		<!------------------------->
		<!-- INFORMATION SECTION -->
		<!------------------------->
		<fieldSet id="fieldset_doc_information" style="FLOAT: left; POSITION: relative; WIDTH: 420; TOP: 5px;">
			<legend><%=EPiServer.Global.EPLang.Translate("/editor/tools/hyperlinkproperties/informationheading")%>&nbsp;</legend>

			<!-- Display Text -->
			<div class="rowContainer" style="padding: 3px;">
				<input class="radioButton" id="documentitemtypetext" name="documentitemtype" type="radio" onclick="setEnabledState()" value="text" tabindex="1" />
				<div class="radioButtonLabelSmall"><label for="documentitemtypetext"><%=EPiServer.Global.EPLang.Translate("/editor/tools/hyperlinkproperties/clickabletext")%></label></div>
				<input id="documentdisplaytext" class="inputMedium" type="text" tabindex="2" />
			</div>

			<!-- Display Image -->
			<div class="rowContainer" style="padding: 3px;">
				<input class="radioButton" id="documentitemtypeimage" name="documentitemtype" type="radio" onclick="setEnabledState()" value="image" tabindex="3" />
				<div class="radioButtonLabelSmall"><label for="documentitemtypeimage"><%=EPiServer.Global.EPLang.Translate("/editor/tools/hyperlinkproperties/clickableimage")%></label></div>
				<input id="documentdisplayimage" class="inputSmall" type="text" disabled />
				<img id="documentdisplayimagebutton" onclick="LaunchHyperlinkImagePropertiesWindow();" src="<%=EPiServer.Global.EPConfig.RootDir%>Util/images/Editor/image_off.gif" title="<%=EPiServer.Global.EPLang.Translate("/editor/tools/hyperlinkproperties/editimageproperties")%>">
			</div>

			<!-- Link Title -->
			<div class="rowContainer" style="padding: 3px;">
				<div class="labelLarge"><%=EPiServer.Global.EPLang.Translate("/editor/tools/hyperlinkproperties/linktitle")%></div>
				<input id="documenttitle" class="inputMedium" type="text" tabindex="5" />
			</div>

			<!-- Target Frame -->
			<div class="rowContainer" style="padding: 3px;">
				<div class="labelLarge"><%=EPiServer.Global.EPLang.Translate("/editor/tools/hyperlinkproperties/targetframe")%></div>
				<asp:DropDownList id="documentframe" tabindex="6" Runat="server" style="float:left; position:relative;" />
			</div>
			<br/>
			
		</fieldSet><br/>
		<!------------------>
		<!-- LINK SECTION -->
		<!------------------>
		<fieldSet id="fieldset_doc_link" style="FLOAT: left; POSITION: relative; WIDTH: 420; TOP: 10px;">
			<legend><%=EPiServer.Global.EPLang.Translate("/editor/tools/hyperlinkproperties/linktargetheading")%>&nbsp;</legend>

			<!-- Internal Document Link -->
			<div class="rowContainer" style="padding: 3px;">
				<input class="radioButton" id="documenttypeinternal" name="documenttype" type="radio" onclick="setFieldVisibility()" value="internaldocument" tabindex="7" />
				<div class="radioButtonLabel"><label for="documenttypeinternal"><%=EPiServer.Global.EPLang.Translate("/editor/tools/hyperlinkproperties/internaldocumentlink")%></label></div>
			</div>
			
			<!-- Network Document Link -->
			<div class="rowContainer" style="padding: 3px;">
				<input class="radioButton" id="documenttypenetwork" name="documenttype" type="radio" onclick="setFieldVisibility()" value="externaldocument" tabindex="8" />
				<div class="radioButtonLabel"><label for="documenttypenetwork"><%=EPiServer.Global.EPLang.Translate("/editor/tools/hyperlinkproperties/networkdocumentlink")%></label></div>
			</div>
			
			<!-- External Document Link -->
			<div class="rowContainer" style="padding: 3px;">
				<input class="radioButton" id="documenttypeexternal" name="documenttype" type="radio" onclick="setFieldVisibility()" value="externaldocument" tabindex="8" />
				<div class="radioButtonLabel"><label for="documenttypeexternal"><%=EPiServer.Global.EPLang.Translate("/editor/tools/hyperlinkproperties/externaldocumentlink")%></label></div>
			</div>
			
			<!-- Internal Address -->
			<div class="rowContainer" style="padding: 3px;" id="documentInternalAddressContainer">
				<div class="labelLarge"><%=EPiServer.Global.EPLang.Translate("/editor/tools/hyperlinkproperties/path")%></div>
				<input id="documentinternalurl" class="inputSmall" type="text" disabled />
				<input class="smallButton" id="documentinternalurlbutton" tabindex="9" onclick="LaunchFileManagerBrowser();" type="button" value="..." />
			</div>
			
			<!-- Network Address -->
			<div class="rowContainer" style="padding: 3px;" id="documentNetworkAddressContainer">
				<div class="labelLarge"><%=EPiServer.Global.EPLang.Translate("/editor/tools/hyperlinkproperties/path")%></div>
				<input id="documentnetworkurl" class="inputMedium" type="text" tabindex="9" value="file:///" />
			</div>
			
			<!-- External Address -->
			<div class="rowContainer" style="padding: 3px;" id="documentExternalAddressContainer">
				<div class="labelLarge"><%=EPiServer.Global.EPLang.Translate("/editor/tools/hyperlinkproperties/path")%></div>
				<input id="documentexternalurl" class="inputMedium" type="text" tabindex="9" value="http://" />
			</div>
			<br/>
		</fieldSet><br/>
	</asp:Panel>

	<!---------------- E-MAIL TAB ---------------->
	<asp:Panel id="EmailPanel"  runat="server" >
		<!------------------------->
		<!-- INFORMATION SECTION -->
		<!------------------------->
		<fieldSet id="fieldset_email_information" style="FLOAT: left; POSITION: relative; WIDTH: 420; TOP: 5px;">
			<legend><%=EPiServer.Global.EPLang.Translate("/editor/tools/hyperlinkproperties/informationheading")%>&nbsp;</legend>

			<!-- Display Text -->
			<div class="rowContainer" style="padding: 3px;">
				<input class="radioButton" id="emailitemtypetext" name="emailitemtype" type="radio" onclick="setEnabledState()" value="text" tabindex="1" />
				<div class="radioButtonLabelSmall"><label for="emailitemtypetext"><%=EPiServer.Global.EPLang.Translate("/editor/tools/hyperlinkproperties/clickabletext")%></label></div>
				<input id="emaildisplaytext" class="inputMedium" type="text" tabindex="2" />
			</div>

			<!-- Display Image -->
			<div class="rowContainer" style="padding: 3px;">
				<input class="radioButton" id="emailitemtypeimage" name="emailitemtype" type="radio" onclick="setEnabledState()" value="image" tabindex="3" />
				<div class="radioButtonLabelSmall"><label for="emailitemtypeimage"><%=EPiServer.Global.EPLang.Translate("/editor/tools/hyperlinkproperties/clickableimage")%></label></div>
				<input id="emaildisplayimage" class="inputSmall" type="text" disabled />
				<img id="emaildisplayimagebutton" onclick="LaunchHyperlinkImagePropertiesWindow();" src="<%=EPiServer.Global.EPConfig.RootDir%>Util/images/Editor/image_off.gif" title="<%=EPiServer.Global.EPLang.Translate("/editor/tools/hyperlinkproperties/editimageproperties")%>">
			</div>

			<!-- Link Title -->
			<div class="rowContainer" style="padding: 3px;">
				<div class="labelLarge"><%=EPiServer.Global.EPLang.Translate("/editor/tools/hyperlinkproperties/linktitle")%></div>
				<input id="emailtitle" class="inputMedium" type="text" tabindex="5" />
			</div>
			<br/>
			
		</fieldSet><br/>
		<!------------------>
		<!-- LINK SECTION -->
		<!------------------>
		<fieldSet id="fieldset_email_link" style="FLOAT: left; POSITION: relative; WIDTH: 420; TOP: 10px;">
			<legend><%=EPiServer.Global.EPLang.Translate("/editor/tools/hyperlinkproperties/linktargetheading")%>&nbsp;</legend>

			<!-- Address -->
			<div class="rowContainer" style="padding: 3px;">
				<div class="labelLarge"><%=EPiServer.Global.EPLang.Translate("/editor/tools/hyperlinkproperties/emailaddress")%></div>
				<input id="emailaddress" class="inputMedium" type="text" tabindex="6" />
			</div>
			<br/>
		</fieldSet><br/>
	</asp:Panel>

</asp:Panel>
</DIV>
</form>
</BODY>
</HTML>