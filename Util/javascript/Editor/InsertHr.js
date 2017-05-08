/*
 * InsertHr.js	- JavaScript support routines for EPiServer
 * Copyright (c) 2004 ElektroPost Stockholm AB
*/

if (!window.EditorScriptVersions)
	window.EditorScriptVersions = new Array();
window.EditorScriptVersions.push("InsertHr 1");

function canInsertHorizontalRule(id)
{
	var iframeObj	= eval(id + '_IFrameObj');	
	
	try
	{
		var range = iframeObj.editorAPI.editorDocument.selection.createRange();
		return range.queryCommandEnabled('InsertHorizontalRule');
	}
	catch(e)
	{
		return false;
	}
}

function InsertHorizontalRule(id)
{
	var iframeObj	= eval(id + '_IFrameObj');	
	var range		= iframeObj.editorAPI.editorDocument.selection.createRange();

	if(range.queryCommandEnabled('InsertHorizontalRule'))
		range.execCommand('InsertHorizontalRule');
}