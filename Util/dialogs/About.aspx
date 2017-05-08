<%@ Page language="c#" Codebehind="About.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Editor.Tools.Dialogs.About" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
  <HEAD>
      <meta name="robots" content="noindex,nofollow">
<TITLE>EPiServer DHTML Editor</TITLE>
<meta content=http://schemas.microsoft.com/intellisense/ie5 name=vs_targetSchema>
<link rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css">
<STYLE>
	body 
	{ 
		font-size: 0.7em;
		font-family: tahoma;
	}

	td   
	{ 
		color:#444488; 
		font-size: 0.7em; 
	}

	.header 
	{ 
		font-weight: bold;
	}
	
	.disclaimer
	{ 
		font-size: 0.85em;
		LEFT: 8px; 
		POSITION: absolute; 
		TOP: 92px;
		color: #555588;
	}
	
	#infoTable
	{
		width: 100%;
		border-collapse:collapse;
		margin-left: 2px;
		margin-right: 2px;
	}
	
	tr.evenInfoRow
	{
		background-color: #eaeaea;
	}
</STYLE>
<script type='text/javascript'>
/*
 * JavaScript support routines for EPiServer
 * Copyright (c) 2003 ElektroPost Stockholm AB
*/

// Turn on conditinal compilation, so we can get the javascript version number. 
/*@cc_on @*/

var _versionInfo = "";

function GetJavaScriptVersion()
{
	try
	{
		return @_jscript_version + "." + @_jscript_build;
	}
	catch(e)
	{
		return "n/a";
	}
}

function GetBrowserVersion()
{
	var browser = null;
	var list;
	var versionFound = "??";
	var version;
	var pos;
	var index;
	
	if (navigator.appName.indexOf("Microsoft Internet Explorer") >= 0)
		browser = "IE";

	if (browser == null)
		return "n/a";

	list = navigator.appVersion.split(";");
	for(index = 0; index < list.length; index++)
	{
		version = list[index];
		pos = version.indexOf("MSIE");
		
		if (pos >= 0)
		{
			versionFound = version.substr(pos + 4);
			break;
		}
	}

	return browser + " " + versionFound;			
}

function initialize()
{	
	if (window.dialogArguments)
	{
		var list = window.dialogArguments;
		var row;
		var cell;
		var valuePair;
		var index;
		var leftWidth = "70%";
		var rightWidth = "30%";

		row = infoTable.insertRow();

		cell = row.insertCell();			
		cell.innerHTML = "<b>Editor resource list</b>";
		cell.width = leftWidth;
		cell.width = rightWidth;

		cell = row.insertCell();			
		cell.innerHTML = "<b>Version</b>";
		cell.align = "right";
		
		list.push(new Array("JavaScript version", GetJavaScriptVersion()));
		list.push(new Array("Browser", GetBrowserVersion()));
		list.push(new Array("Platform", navigator.platform));
	
		_versionInfo = "";
	
		for(index = 0; index < list.length; index++)
		{		
			valuePair = list[index];
			row = infoTable.insertRow();

			if (index % 2 != 0)
				row.className = "evenInfoRow";

			cell = row.insertCell();			
			cell.innerHTML = valuePair[0];
			cell.width = leftWidth;

			cell = row.insertCell();			
			cell.innerHTML = valuePair[1];
			cell.align = "right";
			cell.width = rightWidth;
			
			_versionInfo += valuePair[0] + ": " + valuePair[1] + "\r\n";
		}
	}
	okButton.focus();
}

function CopyInfo()
{
	clipboardData.setData("Text", _versionInfo);
	CopyInfoLabel.style.display = "inline";
	setTimeout(HideCopyInfo, 3000);
}

function HideCopyInfo()
{
	CopyInfoLabel.style.display = "none";
}

</script>

</HEAD>

<BODY bottomMargin=0 leftMargin=0 topMargin=0 scroll=no onload="initialize()" rightMargin=0>
	<div style="DISPLAY: inline; LEFT: 0px; WIDTH: 240px; POSITION: absolute; TOP: 8px; HEIGHT: 40px" align="right">
		<div class="header">EPiServer DHTML Editor</div>
		<br>		
		<div><a href="http://www.episerver.com" title="EPiServer">http://www.episerver.com</a></div>
	</div>
	<div style="DISPLAY: inline; LEFT: 8px; WIDTH: 120px; POSITION: absolute; TOP: 30px; HEIGHT: 110px" align="left">
		<a href="http://www.ep.se" title="ElektroPost">
			<img src="<%=EPiServer.Global.EPConfig.RootDir%>Util/images/Editor/elektropost.gif" border=0>
		</a>
	</div>
	<div class="disclaimer">
		The EPiServer DHTML Editor is based on a modified version of Html TextBox 2.0 © Active Up SPRL. All rights reserved.
	</div>
	<div style="DISPLAY: inline; LEFT: 8px; WIDTH: 235px; overflow-y: scroll; POSITION: absolute; TOP: 135px; HEIGHT: 230px; border: 1px groove lightgray;" align="left" ms_positioning="FlowLayout">		
		<table id="infoTable" border="0">
		</table>
	</div>
	<div style="LEFT: 8px; WIDTH: 235px; height:40px;POSITION: absolute; TOP: 372px;">
		<input type="button" style="WIDTH: 120px; POSITION: absolute; LEFT:  0px; TOP: 18px;" onclick="CopyInfo()" value="Copy to clipboard"> 
		<input type="submit" style="WIDTH:  80px; POSITION: absolute; LEFT:153px; TOP: 18px;"  id="okButton"  onclick="window.close();return false;" value="<%=EPiServer.Global.EPLang.Translate("/button/ok")%>"> 
		<div ID="CopyInfoLabel" style="WIDTH: 228px; POSITION: absolute; TOP: 0px; HEIGHT: 20px; color:#aa0000;font-size:xx-small; z-index:4;DISPLAY: none;" align="left" ms_positioning="FlowLayout">		
			Version info copied to clipboard
		<div>
	</div>
</BODY>
</HTML>
