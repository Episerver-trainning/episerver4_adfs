<%@ Page language="c#" Codebehind="SpellChecker.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Editor.Tools.Dialogs.SpellChecker" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
  <HEAD>
<meta name="robots" content="noindex,nofollow">
<TITLE><%=EPiServer.Global.EPLang.Translate("/editor/tools/spellcheck/toolheading")%></TITLE>
<META content="Microsoft Visual Studio 7.0" name=GENERATOR><meta content=http://schemas.microsoft.com/intellisense/ie5 name=vs_targetSchema>
<link rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css">
<script type='text/javascript'>
/*
 * JavaScript support routines for EPiServer
 * Copyright (c) 2003 ElektroPost Stockholm AB
*/
var suggestions, misspelledWord;
var ignoreButton, ignoreAllButton, changeButton;
var errorIndex, errorList, domResults, ignoreTheseWords;
var parentWindow, editor;
var wordTool;
var finishedMessage;
var locale = 0;
var langName = '';

// The logic of how the spell check is performed is based on the current selection in the editor
//	- text is selected: check only selection
//	- no text selected: check the entire body

function initialize()
{
	parentWindow		= dialogArguments[0];
	editor				= parentWindow.getEditor(dialogArguments[1]);
	locale				= dialogArguments[2];
	langName			= dialogArguments[3];
	editorSelection		= editor.document.selection;
	selectionType		= editorSelection.type.toUpperCase();
	
	suggestions			= document.getElementById('suggestionList');
	misspelledWord		= document.getElementById('misspelledWord');
	ignoreButton		= document.getElementById('buttonIgnore');
	ignoreAllButton		= document.getElementById('buttonIgnoreAll');
	changeButton		= document.getElementById('buttonChange');
	ignoreTheseWords	= new Array();
	wordTool			= document.getElementById('wordTools');

	if(selectionType == 'TEXT')
	{	// A text selection was made - limit the spell check to the selected contents
		finishedMessage				= '<%=EPiServer.Global.EPLang.TranslateForScript("/editor/tools/spellcheck/finishedselection")%>';
		formattingObject.innerHTML	= editorSelection.createRange().htmlText;
	}
	else
	{	// No text selection was made (though an image could have focus) - we will default to the entire editor body
		finishedMessage				= '<%=EPiServer.Global.EPLang.TranslateForScript("/editor/tools/spellcheck/finisheddocument")%>';
		formattingObject.innerHTML	= editor.document.body.innerHTML;
		// Move the cursor to the start of the editor document
		setCursorRange				= editor.document.body.createTextRange();
		setCursorRange.collapse();
		setCursorRange.select();
	}

	// Check the formatting object for table cells and format them
	tdArray = formattingObject.getElementsByTagName('td');
	for(i=0; i < tdArray.length; i++)
		tdArray[i].insertAdjacentText('beforeEnd',' ');

	// Perform a spell check after a delay of 50 ms to render the window
	document.body.style.cursor = 'wait';
	disableButtons(true);
	misspelledWord.value = '<%=EPiServer.Global.EPLang.TranslateForScript("/editor/tools/spellcheck/initializing")%>';
	setTimeout('spellcheckText()', 50);
}

function spellcheckText()
{	// Spellchecks a given range, resetting the errorList and errorIndex, but keeping the ignoreTheseWords collection
	try
	{
		wordTool.LanguageID = locale;
		domResults	= wordTool.SpellcheckText(formattingObject.innerText);
		errorList	= domResults.getElementsByTagName('UnknownWord');
		var logicError  = domResults.selectSingleNode('//error');
		
		if(logicError!=null)
		{
			var error = logicError.getAttribute("message");
			if(error=='OfficeNotInstalled')
				alert('Microsoft Office is not installed on this computer.');
			if(error=='MissingDictionary')
				alert('Microsoft Office does not have a dictionary installed for "' + langName + '".');
			window.close();
			return;
		}
		errorIndex	= -1;
	}
	catch(e)
	{
		alert('Error calling SpellcheckText in : ' + e.message);
	}
	document.body.style.cursor = 'auto';
	
	// Jump to the first error found
	findNextError();
}

function disableButtons(bool)
{
	ignoreButton.disabled		= bool;
	ignoreAllButton.disabled	= bool;
	changeButton.disabled		= bool;
}

function ignoreWord()
{
	findNextError();
}

function ignoreAll()
{	// Stores the current word in a list to ignore all following occurances of it
	ignoreTheseWords[ignoreTheseWords.length] = errorList[errorIndex].getAttribute("Word");
	ignoreWord();
}

function changeWord()
{	// Replace the currently highlighted word in the editor
	var newText = suggestions.options[suggestions.selectedIndex].text;
	parentWindow.ReplaceWord(editor, newText);
	findNextError();
}

function findNextError()
{
    var result;
	misspelledWord.value = '';
	errorIndex = errorIndex + 1;
	
	if(errorIndex >= errorList.length)
	{	// No more text to search based on the current logic
		suggestions.innerHTML = '';	// Clear the "suggestions" select-box
		disableButtons(true);
		alert(finishedMessage);
		window.close();
		return;
	}
	
	text = errorList[errorIndex].getAttribute('Word');
	if(contains(ignoreTheseWords, text))
	{	// The current text to look for should be ignored - look for the next error instead
		findNextError();
		return;
	}

	text = unescape(text);	// Attempt to fix encoding problems in the XML
	
	// Check to be able to search WITHIN the initial selection of text - passes a parameter that
	// forces the "search" to be performed differently for the first occurance (errorIndex == 0)...
	// Enables a spellcheck of just the current selection in the editor, avoiding a search of the entire contents.
	result	= parentWindow.FindNextOccurance(editor, text, null, (errorIndex == 0));

	if(result)
		setUpWord(text);
	else
	{	// This should not happen - indication that there is a mismatch between the list of errors and the
		// text in the editor body (possibly based on charset or similar)
		alert('"' + text + '" <%=EPiServer.Global.EPLang.TranslateForScript("/editor/tools/spellcheck/textnotfound")%>');
		findNextError();
	}
}

function contains(array, string)
{
	for(i = 0; i < array.length; i++)
		if(array[i] == string) return true;
	return false;
}

function setUpWord(text)
{
	misspelledWord.value = text;
	displaySuggestions();
}

function displaySuggestions()
{
	var suggestion;
	var newOption;
	suggestions.innerHTML = '';	// Clear the "suggestions" select-box

	wordKey = errorList[errorIndex].getAttribute('Key');
	if(wordKey == '-1')	// No suggestions - set up UI accordingly
	{
		newOption = document.createElement('OPTION');
		newOption.text = '<%=EPiServer.Global.EPLang.TranslateForScript("/editor/tools/spellcheck/nosuggestions")%>';
		newOption.Value = 0;
		suggestions.add(newOption);
		disableButtons(false);
		changeButton.disabled = true;
		return;
	}
	//domResults.setProperty("SelectionLanguage", "XPath");
	suggestionList = domResults.selectSingleNode('//SuggestionList["' + wordKey + '" = @Key]').childNodes;

	for(i = 0; i < suggestionList.length; i++)
	{
		suggestion = suggestionList.nextNode;
		if(suggestion != null)
		{
			newOption = document.createElement('OPTION');
			newOption.text = suggestion.getAttribute('Word');
			newOption.Value = i;
			suggestions.add(newOption);
		}
	}
	suggestions.selectedIndex = 0;
	disableButtons(false);
}
</script>
</HEAD>
<BODY bottomMargin=0 leftMargin=0 topMargin=0 scroll=no rightMargin=0 onload="initialize();">
<form id="spellchecker">
	<DIV style="WIDTH: 439px; POSITION: relative; HEIGHT: 268px" ms_positioning="GridLayout">
	<input	id=buttonIgnore		tabindex=1 type="submit" style="Z-INDEX: 105; LEFT: 338px; WIDTH: 80px; POSITION: absolute; TOP:  14px" value="<%=EPiServer.Global.EPLang.Translate("/button/ignore")%>" onclick="ignoreWord();return false;">
	<input	id=buttonIgnoreAll	tabindex=2 type="button" style="Z-INDEX: 106; LEFT: 338px; WIDTH: 80px; POSITION: absolute; TOP: 39px" value="<%=EPiServer.Global.EPLang.Translate("/button/ignoreall")%>" onclick="ignoreAll();"> 
	<input	id=buttonChange		tabindex=4 type="button" style="Z-INDEX: 101; LEFT: 338px; WIDTH: 80px; POSITION: absolute; TOP: 90px" value="<%=EPiServer.Global.EPLang.Translate("/button/change")%>" onclick="changeWord();">
	<input	id=buttonClose		tabindex=5 type="reset" style="Z-INDEX: 102; LEFT: 338px; WIDTH: 80px; POSITION: absolute; TOP: 142px" value="<%=EPiServer.Global.EPLang.Translate("/button/close")%>" onclick="window.close();">
	<DIV style="DISPLAY: inline; Z-INDEX: 107; LEFT: 7px; WIDTH: 249px; POSITION: absolute; TOP: 0px; HEIGHT: 19px" ms_positioning="FlowLayout"><%=EPiServer.Global.EPLang.Translate("/editor/tools/spellcheck/notindictionary")%></DIV>
	<textarea id=misspelledWord tabindex="-1" style="font:normal 11px tahoma; Z-INDEX: 104; LEFT: 6px; WIDTH: 318px; POSITION: absolute; TOP: 14px" readonly rows=4></textarea>
	<DIV style="DISPLAY: inline; Z-INDEX: 108; LEFT: 7px; WIDTH: 249px; POSITION: absolute; TOP: 76px; HEIGHT: 19px" ms_positioning="FlowLayout"><%=EPiServer.Global.EPLang.Translate("/editor/tools/spellcheck/suggestions")%></DIV>
	<select id=suggestionList	tabindex=3 size=5 style="Z-INDEX: 103; LEFT: 5px; WIDTH: 318px; POSITION: absolute; TOP: 90px"></select>
	</DIV>
	<OBJECT ID="wordTools" tabindex="-1"
		CLASSID="CLSID:B3F4C498-0C60-442D-A94F-04A36479F620"
		CODEBASE='<%= Configuration.RootDir%>util/activex/EPiServerClientComponents.cab#Version=1,0,0,19' VIEWASTEXT>
		<DIV STYLE="WIDTH: 439px; POSITION: relative; HEIGHT: 268px; color:red; Z-INDEX: 500;">
			<hr>
				EPiOfficeIntegration.dll failed to load
				-- Please check browser security settings.
			<hr>
		</DIV>
	</OBJECT>
	<div id="formattingObject" style="visibility:none"></div>
</form>
</BODY>
</HTML>
