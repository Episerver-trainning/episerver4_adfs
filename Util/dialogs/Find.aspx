<%@ Page language="c#" Codebehind="Find.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Editor.Tools.Dialogs.Find" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
<HEAD>
<meta name="robots" content="noindex,nofollow">
<TITLE><%=EPiServer.Global.EPLang.Translate("/editor/tools/search/toolheading")%></TITLE><META content="Microsoft Visual Studio 7.0" name=GENERATOR><meta content=http://schemas.microsoft.com/intellisense/ie5 name=vs_targetSchema>
<link rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css">
<script type='text/javascript'>
/*
 * JavaScript support routines for EPiServer
 * Copyright (c) 2003 ElektroPost Stockholm AB
*/
var parentWindow, editor, searchText, buttonNext, checkWhole, checkCase, firstSearch;
var initialRange = null, restartConfirmed = false, restartSearch = false;

function initialize()
{
	parentWindow	= dialogArguments[0];
	editor			= parentWindow.getEditor(dialogArguments[1]);
	searchText		= document.getElementById('searchText');
	buttonNext		= document.getElementById('buttonNext');
	checkWhole		= document.getElementById('checkWhole');
	checkCase		= document.getElementById('checkCase');
	firstSearch		= true; // Used to trigger a search WITHIN the selection made in the editor before search begins

	if(editor.document.selection.type == "Control")
	{	// If a control is selected, ignore it and perform a search of the entire document
		currentRange = editor.document.body.createTextRange();
		currentRange.collapse(true);
		currentRange.select();
	}
	else
	{	// Selection is either empty or text, verify the whereabouts in the document
		currentRange = editor.document.selection.createRange();
		if(currentRange.compareEndPoints('StartToStart', editor.document.body.createTextRange()) > 0)
		{	// Text is not selected from the very beginning of the editor - set a bookmark to be able to loop, and store initial range
			initialRange	= currentRange;
			restartSearch	= true;
		}
	}
	
	setButtonState();
}

function findNext()
{
	searchArgs				= 0;
	if(checkWhole.checked)	searchArgs += 2;
	if(checkCase.checked)	searchArgs += 4;
	searchString			= searchText.value;
	stopPointRange			= (restartConfirmed ? initialRange : null);
	searchReturnValue		= parentWindow.FindNextOccurance(editor, searchString, searchArgs, firstSearch, stopPointRange);
	firstSearch				= false;

	if(!searchReturnValue)
	{
		if(restartSearch)
		{
			restartConfirmed = confirm('<%=EPiServer.Global.EPLang.TranslateForScript("/editor/tools/search/reachedend")%>');
			if(restartConfirmed)
			{
				var startOfEditorRange = editor.document.body.createTextRange();
				startOfEditorRange.collapse(true);
				startOfEditorRange.select();
				restartSearch = false;
				findNext();
			}
		}
		else
		{
			alert('<%=EPiServer.Global.EPLang.TranslateForScript("/editor/tools/search/finisheddocument")%>');
			restartSearch = true;
			restartConfirmed = false;
		}
	}
}

function setButtonState()
{
	buttonNext.disabled = (searchText.value.length == 0);
}
</script>
</HEAD>
<BODY bottomMargin=0 leftMargin=0 topMargin=0 scroll=no onload="initialize()" rightMargin=0>
<DIV style="WIDTH: 386px; POSITION: relative; HEIGHT: 74px" ms_positioning="GridLayout">
	<DIV style="DISPLAY: inline; Z-INDEX: 103; LEFT: 6px; WIDTH: 60px; POSITION: absolute; TOP: 3px; HEIGHT: 15px" ms_positioning="FlowLayout"><%=EPiServer.Global.EPLang.Translate("/editor/tools/search/findheading")%></DIV>
	<input id=searchText onkeyup="setButtonState();" onchange="setButtonState();" style="Z-INDEX: 100; LEFT: 70px; WIDTH: 197px; POSITION: absolute; TOP: 3px; HEIGHT: 19px" type=text size=27>

	<input id=checkWhole style="Z-INDEX: 104; LEFT: 3px; POSITION: absolute; TOP: 26px" type=checkbox>
	<DIV style="DISPLAY: inline; Z-INDEX: 107; LEFT: 26px; WIDTH: 222px; POSITION: absolute; TOP: 30px; HEIGHT: 19px" ms_positioning="FlowLayout"><label for="checkWhole"><%=EPiServer.Global.EPLang.Translate("/editor/tools/search/matchwhole")%></label></DIV>

	<input id=checkCase	style="Z-INDEX: 109; LEFT: 3px; POSITION: absolute; TOP: 45px" type=checkbox>
	<DIV style="DISPLAY: inline; Z-INDEX: 108; LEFT: 26px; WIDTH: 222px; POSITION: absolute; TOP: 49px; HEIGHT: 19px" ms_positioning="FlowLayout"><label for="checkCase"><%=EPiServer.Global.EPLang.Translate("/editor/tools/search/matchcase")%></label></DIV>

	<input id=buttonNext	type="submit"	style="Z-INDEX: 101; LEFT: 280px; WIDTH: 80px; POSITION: absolute; TOP:  2px" onclick="findNext();return false;" value="<%=EPiServer.Global.EPLang.Translate("/button/findnext")%>">
	<input id=buttonCancel	type="reset"	style="Z-INDEX: 102; LEFT: 280px; WIDTH: 80px; POSITION: absolute; TOP: 28px" onclick="window.close();" value="<%=EPiServer.Global.EPLang.Translate("/button/cancel")%>">
</DIV>
</BODY>
</HTML>