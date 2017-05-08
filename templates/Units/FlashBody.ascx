<%@ Control Language="c#" AutoEventWireup="false" Codebehind="FlashBody.ascx.cs" Inherits="development.Templates.Units.FlashBody" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>

<object 
	classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" 
	codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=5,0,0,0" 
	width="<%=CurrentPage["Width"]%>"
	height="<%=CurrentPage["Height"]%>"
	id="flash"
	ALIGN=""
>
	<param name=movie value="<%=CurrentPage["EmbeddedURL"]%>">
	<param name=quality value=high>
	<param name=bgcolor value=#FFFFFF>
	<embed 
		src="<%=CurrentPage["EmbeddedURL"]%>"
		quality=high
		pluginspage="http://www.macromedia.com/go/getflashplayer"
		type="application/x-shockwave-flash"
		align=""
		bgcolor=#FFFFFF
		width="<%=CurrentPage["Width"]%>"
		height="<%=CurrentPage["Height"]%>">
	</embed> 
</object>