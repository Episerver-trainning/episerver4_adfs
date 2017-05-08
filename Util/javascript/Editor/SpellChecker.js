/*
 * SpellChecker.js	- JavaScript support routines for EPiServer
 * Copyright (c) 2004 ElektroPost Stockholm AB
*/

if (!window.EditorScriptVersions)
	window.EditorScriptVersions = new Array();
window.EditorScriptVersions.push("SpellChecker 1");

function ReplaceWord(editor, newText)
{
	editor.document.selection.createRange().text = newText;
}

function LaunchSpellChecker(dialogURL, id, locale,langName)
{
	var dialogArgs = new Array();
	dialogArgs[DLG_ARGS_PARENT_WINDOW] = window;
	dialogArgs[DLG_ARGS_EDITOR_ID] = id;
	dialogArgs[DLG_ARGS_FONTCOLORLIST] = locale;
	dialogArgs[DLG_ARGS_CUSTOM_ARGS_BASE] = langName;

	// Using a modeless window is easily doable, but requires a more robust find function as the context
	// can change at any time, if the user changes words or moves the cursor within the editor.
	OpenDialog(dialogURL, dialogArgs, 436, 220);
}