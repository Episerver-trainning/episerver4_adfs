/*
 * InsertAnchor.js	- JavaScript support routines for EPiServer
 * Copyright (c) 2005 ElektroPost Stockholm AB
*/

if (!window.EditorScriptVersions)
	window.EditorScriptVersions = new Array();
window.EditorScriptVersions.push("InsertAnchor 3");

function GetBookmarkInRange(editorAPI)
{
	var bookmark = null;
	var range	= editorAPI.editorDocument.selection.createRange();

	if(range.queryCommandEnabled('UnBookmark'))
	{	
		var selType	= editorAPI.editorDocument.selection.type.toUpperCase();
		var parent = null;
		
		if(selType == 'TEXT' || selType == 'NONE')
			parent = range.parentElement(); 
		else if(selType == 'CONTROL')
			parent = range.item(0).parentElement;
			
		if(parent)
			bookmark = parent.getAttribute('name');
	}
	
	return bookmark;
}

function InsertAnchor(editorAPI, anchorName)
{
	var range = editorAPI.editorDocument.selection.createRange();
	range.execCommand('CreateBookmark', false, anchorName);
}

function RemoveAnchor(editorAPI)
{
	var range = editorAPI.editorDocument.selection.createRange();
	range.execCommand('UnBookmark', false, '');
}

function LaunchAnchorWindow(dialogURL, id)
{
	var editorAPI	= eval(id + '_IFrameObj').editorAPI;	
	var bookmark	= GetBookmarkInRange(editorAPI);
	var returnValue = null;
	
	if (!window.NoGuiInteraction)
		returnValue = OpenDialog(dialogURL, bookmark, 380, 110);	

	if(returnValue)
	{
		InsertAnchor(editorAPI, returnValue);
	}
	else if(returnValue == '')
	{
		RemoveAnchor(editorAPI);
	}
}
