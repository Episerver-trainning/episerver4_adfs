/*
 * Find.js	- JavaScript support routines for EPiServer
 * Copyright (c) 2004 ElektroPost Stockholm AB
*/

if (!window.EditorScriptVersions)
	window.EditorScriptVersions = new Array();
window.EditorScriptVersions.push("Find 1");


function LaunchFindWindow(dialogURL, id)
{
	var dialogArgs = new Array();
	dialogArgs[0] = window;
	dialogArgs[1] = id;

	// Using modeless may be preferable, but results in some complications:
	// - users can selected text outside the editor and continue the search (needs to be handled)
	// - users can trigger another find tool on the same or another editor (needs to be handled)
	//window.showModelessDialog(dialogURL, window, 'dialogWidth:380px;dialogHeight:110px;help=no;resizable:no;scroll:no;status:no;unadorned:yes;');

	// Modal is "safer", consider the usability consequences
	OpenDialog(dialogURL, dialogArgs, 380, 130);
}

// FindNextOccurance is called from the Find and SpellChecker dialogs to perform their functionality
function FindNextOccurance(editor, searchString, searchArgs, firstSearch, stopPointTextRange)
{
	var strFound;
	var args = (searchArgs == null) ? 0 : searchArgs;
	if(firstSearch == null)
		firstSearch = false;

	// create textRange based on focus/selection in the editor
	// this should be limited to the EDITOR - grab it from the window...
	var currentRange = editor.document.selection.createRange();
	// Making the range degenerate (using collapse(false)) lets the search continue (by collapsing to the END of the range) -
	// however it prevents an initial text selection from being searched (the search starts after the selection).
	// The "firstSearch" logic handles an initial selection differently than the recurring "Find Next" button clicks.
	currentRange.collapse(firstSearch);

	// Complement this findText call with searching direction up/down	
	strFound = currentRange.findText(searchString, 1000000, args);
	if (strFound)
	{	// stopPointTextRange is the range delimiting where the search should stop after looping past the end
		if(stopPointTextRange != null && (currentRange.compareEndPoints('StartToStart', stopPointTextRange) > -1) )
			// The text we found is past the stop point of the search, return false and do not mark the text
			strFound = false;
		else
			// We found the text within the search scope, select the text on the screen
			currentRange.select();
	}

	return strFound;
}