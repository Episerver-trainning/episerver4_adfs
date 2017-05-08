/*
 * DropLink.js	- Drag and drop images into editor
 * Copyright (c) 2004 ElektroPost Stockholm AB
*/

if (!window.EditorScriptVersions)
	window.EditorScriptVersions = new Array();
window.EditorScriptVersions.push("DropLink 3");

function SetupDropLink(editorAPI)
{
	var editorBody = editorAPI.editorDocument.body;

	editorAPI.dragStartHandler	= function() { editorAPI.isDragging = true; };
	editorAPI.dragEndHandler	= function() { editorAPI.isDragging = false; };
	editorAPI.dragDropHandler	= function() { DropLink_onDrop(editorAPI); };
	editorAPI.unloadHandler		= function() { DropLink_onUnload(editorAPI); };

	editorBody.attachEvent('ondragstart', editorAPI.dragStartHandler);
	editorBody.attachEvent('ondragend',	editorAPI.dragEndHandler);
	editorBody.attachEvent('ondrop', editorAPI.dragDropHandler);
	window.attachEvent('onunload', editorAPI.unloadHandler);
	editorBody = null;
}

function DropLink_onUnload(editorAPI)
{
	var editorBody = editorAPI.editorDocument.body;

	editorBody.detachEvent('ondragstart', editorAPI.dragStartHandler);
	editorBody.detachEvent('ondragend',	editorAPI.dragEndHandler);
	editorBody.detachEvent('ondrop', editorAPI.dragDropHandler);
	window.detachEvent('onunload', editorAPI.unloadHandler);
	
	editorAPI.dragStartHandler	= null;
	editorAPI.dragEndHandler	= null;
	editorAPI.dragDropHandler	= null;
	editorAPI.unloadHandler		= null;
	editorBody = null;
}

function DropLink_onDrop(editorAPI)
{
	var editor = editorAPI.editor;

	if( !editorAPI.isDragging )
	{
		var event = editor.event;
		var sDropText = event.dataTransfer.getData('Text');

		if( sDropText && sDropText.length>0 && sDropText.charAt(0)=='/' )
		{
			var html;
			
			// The global variables that are read here are defined by the EPiServer Dhtml Editor.
			var expression = "^.*(" + ValidEditorFileExtensions + ")+$";
			var rootDir = EPiServerRootDir;

			// prevent default action
			event.cancelBubble = true;
			event.returnValue = false;

			var isImage = new RegExp(expression, "i");

			if(sDropText.match(isImage))
			{
				html = '<img src="' + rootDir + sDropText + '" orgurl="' + rootDir + sDropText + '" alt="">';							
			}
			else
			{
				var sDropDisplayText = sDropText;
				if (sDropText.indexOf("/") != -1)
					sDropDisplayText = sDropText.substr(sDropText.lastIndexOf("/") + 1);
				html = '<a target="_blank" href="' + rootDir + sDropText + '" orgurl="' + rootDir + sDropText + '">' + sDropDisplayText + '</a>';							
			}

			// Encode html if editor is in html mode (the constant EDITORMODE_HTML is defined in editorAPI.js)
			if (editorAPI.editorState.Mode == EDITORMODE_HTML)
				editor.document.selection.createRange().pasteHTML(EncodeHtml(html));
			else
				editor.document.selection.createRange().pasteHTML(html);
		}
	}
}
