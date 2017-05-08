/*
 * edit.js	- JavaScript support routines for EPiServer
 * Copyright (c) 2004 ElektroPost Stockholm AB
*/
var frameInfo = new Array();
var latestNavigate	= '';
var latestVersion	= '';
var latestMode		= '';
var latestUrl		= '';
var defaultEventAction = -1;
var latestLogin = new Date();

var LOGIN_TIMEOUT = null;
var LOGIN_URL = null;

function commandDescriptor(cmd,url,data)
{
	this.command	= cmd;
	this.baseUrl	= url;
	this.url		= '';
	this.data		= data;
}

function commandNavigateDescriptor(cmd,url,data)
{
	this.command	= cmd;
	this.baseUrl	= url;
	this.url		= '';
	this.data		= data;
	this.navData	= data;
	this.isNavigate	= true;
}

function commandNavigateDescriptorEx(cmd,url,data,navData)
{
	this.command	= cmd;
	this.baseUrl	= url;
	this.url		= '';
	this.data		= data;
	this.navData	= navData;
	this.isNavigate	= true;
}

function setLatestNavigate(newPageLink)
{
	latestNavigate = newPageLink;
	if (latestVersion.indexOf(newPageLink + '_')<0)
		latestVersion = latestNavigate.toString();
}

function setLatestVersion(newPageLink)
{
	latestVersion = newPageLink;
}

function navigateEventEx(sender, newPageLink, newUrl)
{
	latestUrl = newUrl;
	navigateEvent(sender, newPageLink);
	latestUrl = '';
}

function navigateEvent(sender, newPageLink)
{
	var oFrame;
	var i;
	var exitCode;
	setLatestNavigate(newPageLink);

	for (i=0; i < window.frames.length; i++)
	{
		oFrame = window.frames[i];
		if (oFrame == sender)
			continue;
		if (oFrame.onNavigate == null)
			continue;
		exitCode = oFrame.onNavigate(newPageLink);
		if (exitCode == defaultEventAction)
			baseOnNavigate(oFrame, newPageLink);
	}
}

function baseOnNavigate(oFrame, newPageLink)
{
	var baseUrl = oFrame.location.pathname;
	var i;
	for (i = 0; i < frameInfo.length; i ++)
	{
		if (frameInfo[i][0] == oFrame.name)
		{
			baseUrl = frameInfo[i][1];
			break;
		}
	}
	oFrame.location.href=buildUrl(baseUrl, newPageLink);
}

function commandEvent(sender, newCommand)
{
	var oFrame;
	var i;
	var exitCode;
	if (newCommand.isNavigate != null)
		setLatestNavigate(newCommand.navData);
	
	for (i=0; i < window.frames.length; i++)
	{
		oFrame = window.frames[i];
		if (oFrame == sender)
			continue;
		if (oFrame.onCommand == null)
			continue;
		newCommand.url = buildUrl(newCommand.baseUrl,latestNavigate);
		exitCode = oFrame.onCommand(newCommand);
		if (exitCode == defaultEventAction)
			if (newCommand.isNavigate != null)
				baseOnNavigate(oFrame, latestNavigate);
			else
				baseOnCommand(oFrame, newCommand);		
	}
	return false;
}

function baseOnCommand(oFrame, newCommand)
{
	if (newCommand.command == 'actionwindow')
		return;
		
	try
	{
		if (newCommand.command == 'administration')
			window.location.href = newCommand.baseUrl;
		else if(newCommand.baseUrl!='')
			oFrame.location.href = newCommand.url;
	}
	catch(e)
	{
		//Action can be canceled by "navigate away from changes" feature on editpanel
	}
}

function registerDefaultPage(frameName, url)
{
	var i;
	for (i = 0; i < frameInfo.length; i ++)
	{
		if (frameInfo[i][0] == frameName)
		{
			frameInfo[i][1] = url;
			return;
		}
	}
	frameInfo[frameInfo.length] = new Array(frameName, url);
}

function addQueryString( qs, name, val )
{	
	// Check if name exists
	var nName = qs.indexOf(name);
	var nPos;
	if (nName >= 0)
	{	
		// Exists, replace it
		nPos = qs.indexOf('&', nName + name.length);
		if (nPos >= 0)
		{	
			// There is a parameter following it, just replace the value
			qs = qs.slice(0, nName + name.length) + val + qs.slice(nPos);
		}
		else
		{	
			// Simply insert the value
			qs = qs.slice(0, nName + name.length) + val;
		}
	}
	else
	{
		nName = qs.indexOf('____');
		if (nName >= 0 && (name == '?id=' || name == '@id'))
		{	
			// Special case for ?id / @id
			nPos = qs.indexOf('.', nName);
			if (nPos >= nName)
			{
				qs = qs.slice(0, nName + 4) + val + qs.slice(nPos);
			}
		}
		else
		{	
			if(qs.indexOf('?')>=0 && name.indexOf('?')>=0)
				qs = qs + '&' + name.substring(1) + val;
			else
				qs = qs + name + val;
		}
	}
	return qs;
}

function buildUrl( url, link )
{
	var newUrl = addQueryString( url, '?id=', link );
	if (latestMode.length > 0)
		newUrl = addQueryString(newUrl, '&amp;mode=', latestMode);
	if (latestUrl.length > 0)
		newUrl = addQueryString(newUrl, '&amp;latesturl=', encodeURIComponent(latestUrl));
	return newUrl;
}

function maintainLoginStatus( loginTimeout, loginUrl )
{
	var now = new Date();
	if ((now.getTime() - latestLogin.getTime()) > (loginTimeout * 60 * 1000 - 30000))
	{
		var retVal = window.showModalDialog(loginUrl, '', 'dialogWidth:350px;dialogHeight:250px;resizable:yes;status:no;scroll:no;');
		if(retVal!=1)
			window.location.reload(true);
	}
	latestLogin = new Date();
}

function HidePostbackError()
{
	event.cancelBubble = true;
	event.returnValue = true;
}

function SelectNewLanguage(newLanguage)
{
	commandEvent(null,new commandDescriptor('newlanguagebranch','',newLanguage));

}

