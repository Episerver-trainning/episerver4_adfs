<%@ Page language="c#" Codebehind="InsertAnchor.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Editor.Tools.Dialogs.InsertAnchor" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
<HEAD>
<meta name="robots" content="noindex,nofollow">
<TITLE><%=EPiServer.Global.EPLang.Translate("/editor/tools/insertanchor/toolheading")%></TITLE><META content="Microsoft Visual Studio 7.0" name=GENERATOR><meta content=http://schemas.microsoft.com/intellisense/ie5 name=vs_targetSchema>
<link rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css">
<script type='text/javascript'>
/*
 * JavaScript support routines for EPiServer
 * Copyright (c) 2003 ElektroPost Stockholm AB
*/
function initialize()
{
	// Name of current anchor may be passed in to the dialog, to allow editing of existing anchors (new feature)
	// Possible TODO: add option to "clear" current anchor.
	if(dialogArguments != null)
		anchorName.value = dialogArguments;

	setButtonState();
}

function setButtonState()
{	// Only disable the button IF we are creating a new anchor AND the name is currently empty
	// (Allow empty name when we are editing an existing anchor - empty name means removing the anchor)
	if(dialogArguments == null)
		buttonOK.disabled = (anchorName.value.length == 0);
}

function OkClick()
{
	returnValue = anchorName.value;
	window.close();
}
function CancelClick()
{
	window.close();
}
</script>
</HEAD>
<BODY bottomMargin=0 leftMargin=0 topMargin=0 scroll=no onload="initialize();" rightMargin=0>
<DIV style="WIDTH: 386px; POSITION: relative; HEIGHT: 60px" ms_positioning="GridLayout">
	<DIV style="DISPLAY: inline; Z-INDEX: 103; LEFT: 6px; WIDTH: 60px; POSITION: absolute; TOP: 3px; HEIGHT: 15px" ms_positioning="FlowLayout"><%=EPiServer.Global.EPLang.Translate("/editor/tools/insertanchor/anchorname")%></DIV>
	<input id=anchorName onkeyup="setButtonState();" onchange="setButtonState();" style="Z-INDEX: 100; LEFT: 70px; WIDTH: 197px; POSITION: absolute; TOP: 3px; HEIGHT: 19px" type=text size=27>

	<input id=buttonOK		type="submit"	style="Z-INDEX: 101; LEFT: 280px; WIDTH: 80px; POSITION: absolute; TOP:  2px" onclick="OkClick();" value="<%=EPiServer.Global.EPLang.Translate("/button/ok")%>">
	<input id=buttonCancel	type="reset"	style="Z-INDEX: 102; LEFT: 280px; WIDTH: 80px; POSITION: absolute; TOP: 28px" onclick="CancelClick();" value="<%=EPiServer.Global.EPLang.Translate("/button/cancel")%>">
</DIV>
</BODY>
</HTML>