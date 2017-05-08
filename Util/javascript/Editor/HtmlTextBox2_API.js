/*
 * HtmlTextBox2_API.js	- JavaScript support routines for EPiServer
 * Additions made to the below source from Active Up is Copyright (c) 2004 ElektroPost Stockholm AB
*/
// Html TextBox v2.0 Client Side Code
// Copyright (c) 2002 Active Up S.P.R.L. - All Right Reserved
// http://www.activeup.com/?r=htb2.2

// LIB (API)

if (!window.EditorScriptVersions)
	window.EditorScriptVersions = new Array();
window.EditorScriptVersions.push("HtmlTextBox2_API 10");

var EDITORMODE_DESIGN	= false;
var EDITORMODE_HTML		= true;

// Extend the String object with some helper functions
String.prototype.LTrim	=	new Function("return this.replace(/^\\s+/,'')");
String.prototype.RTrim	=	new Function("return this.replace(/\\s+$/,'')");
String.prototype.Trim	=	new Function("return this.replace(/^\\s+|\\s+$/g,'')");

var _editorIconCache = null;                 

function imageHasFocus(id)
{
	var iframeObj	= eval(id + "_IFrameObj");

	//The editorAPI.image object should be null if no image is selected.
	//return (iframeObj.editorAPI.image != null);
	
	//Alternate way to check if an image is selected - should be replaced with above.
	
	try
	{
		var selection	= iframeObj.editorAPI.editorDocument.selection;
		var range		= selection.createRange();
		return (selection.type.toUpperCase() == 'CONTROL' && range.item(0).tagName.toUpperCase() == 'IMG');
	}
	catch(e)
	{
		return false;
	}
}

// Helper function for debugging
function GetFunctionName(functionObject)
{
	var funcName = functionObject + '';	// get the TableEdit.prototype.source code  = function (as string)
	var nameIndex = funcName.indexOf('function') + 'function'.length;
	return funcName.substring(nameIndex, funcName.indexOf('('));
}

function GetParentRange(currentRange)
{
	var range = currentRange.duplicate();
	range.moveToElementText(range.parentElement());	
	return range;
}

// Called by startup script                 
function GetEditorIFrame(id)
{
	return document.getElementById(id + '_Editor');
}                
                 
// EP-MODIFICATION:
function checkValidCopySelection(id)
{
	var currentSelection = getEditor(id).document.selection; 
	return (currentSelection.type == 'Control' || currentSelection.type == 'Text' );
}

// EP-MODIFICATION:
function checkValidTextSelection(editor)
{
	var type = editor.document.selection.type;
	return (type == "None" || type == "Text" );
}

function setSnippet(id, code)
{
	setFocus(id);
	var iframeObj = eval(id + '_IFrameObj');
	var state = iframeObj.tableEdit.editorState;
	var editor = iframeObj.tableEdit.editor;
	
	state.RestoreSelection();

	var selection = editor.document.selection.createRange();
	selection.type = editor.document.selection.type;
	
	if (selection.type == 'Control')
	{
		selection.item(0).outerHTML = code
	}
	else
	{
		setFocus(id);
		selection.pasteHTML(code);
	}
}

function setFocus(id)
{
	getEditor(id).focus();	
}

function getEditor(id)
{
	return eval(getId(id) + '_EdRef');
}

function swap(img, fname) {
	document[img].src = fname;
}

function clear(id)
{
	safeId = getId(id);
	eval(safeId + '_EdRef').document.body.innerHTML = '';
}

function setHtml(id, str)
{
	safeId = getId(id);
	if (GetState(id).Mode == EDITORMODE_HTML)
	{
		toggleMode(safeId, false);
		eval(safeId + '_EdRef').document.body.innerHTML = str;
		toggleMode(safeId, false);
	}
	else
		eval(safeId + '_EdRef').document.body.innerHTML = str;
}

function getHtml(id)
{
	safeId = getId(id);
	if (GetState(id).Mode == EDITORMODE_HTML)
	{
		toggleMode(safeId, false);
		txt = eval(safeId + '_EdRef').document.body.innerHTML;
		toggleMode(safeId, false);
		return txt;
	}
	else
		return eval(safeId + '_EdRef').document.body.innerHTML;
}

function getText(id)
{
	safeId = getId(id);
	if (eval(safeId + '_State').Mode == EDITORMODE_HTML)
	{
		toggleMode(id, false);
		txt = eval(safeId + '_EdRef').document.body.innerText;
		toggleMode(id, false);
		return txt;
	}
	else
		return document.getElementById(id).value = eval(safeId + '_EdRef').document.body.innerText;
}

function toggleMode(id, focus)
{
	if (eval(id + '_State').Mode == EDITORMODE_HTML)
		setDesignMode(id, focus);
	else
		setHtmlMode(id, focus);
}

function setHtmlMode(id, focus)
{
	var editorAPI = eval(id + '_IFrameObj').editorAPI;

	if (editorAPI.editorState.Mode == EDITORMODE_DESIGN)
	{
		showTab(id, '_html', '_design,_html');
		editorAPI.SwitchToHtmlMode();
	}
}

// This function should *only* be called if editor is in html mode (innerHTML contains html as text)
function setDesignMode(id, focus)
{
	// Ignore if we are called by startup code (incase caller has no function, just a call from plain script)
	if (setDesignMode.caller == null)
		return;

	var editorAPI = eval(id + '_IFrameObj').editorAPI;

	if (editorAPI.editorState.Mode == EDITORMODE_HTML)
	{
		showTab(id, '_design', '_design,_html');		
		editorAPI.SwitchToDesignMode();
		
		if (focus)
			setFocus(id);
	}
}

function resetTabs(id, tohide)
{
	if (tohide && tohide.length > 0)
	{
		aTabs = tohide.split(',');
		for(index=0;index<aTabs.length;index++)
			hideTab(id, aTabs[index]);
	}
}

function hideTab(id, name)
{
	tab = getObj(id + name);
	tab.style.borderRight = '';
	tab.style.borderTop = '';
	tab.style.borderLeft = '';
	tab.style.borderBottom = '';
	tab.style.backgroundColor = '';
}

function showTab(id, name, tohide)
{
	try
	{
		resetTabs(id, tohide)
		tab = getObj(id + name);
		tab.style.borderRight = 'black 1px solid';
		tab.style.borderTop = 'black 1px solid';
		tab.style.borderLeft = 'black 1px solid';
		tab.style.borderBottom = 'black 1px solid';
		tab.style.backgroundColor = 'white';
	}
	catch (e)
	{
	}
}

function setBackground(obj, color)
{
	obj.style.backgroundColor = color;
}

function setColor(id, type, color)
{
	if (type == 'f')
		cmd = 'forecolor';
	else
		cmd = 'backcolor';

	commandBuilder(id, cmd, color);
}

function setValue(obj, value)
{
	obj.value = value;
}
	
function getValue(obj)
{
	return obj.value;
}

function GetState(editorID)
{
	return document.getElementById(editorID + '_Editor').editorAPI.editorState;
}

// Make editor contents ready for POST transfer back to server.
// The id parameter is expected to be a getId() result.
function saveData(id)
{
	var state = GetState(id);
	var tableEdit = eval(id + '_IFrameObj').tableEdit;
	var contents;	
	
	state.SaveSelection(id);

	if (state.Mode == EDITORMODE_HTML)
	{
		contents = eval(id + '_EditorHtmlArea').value;
		if (tableEdit.NeedsRepairing(contents))
		{
			contents = tableEdit.RepairContent(contents);
		}
	}
	else
	{
		contents = tableEdit.GetContentsWithoutDesignModeInformation();
	}

	tableEdit.editorHiddenInput.value = contents.Trim();
}

function getId(id)
{
	return stringReplace(id, ':', '_');
}

function decode(str)
{
	str = stringReplace(str, '&lt;', '<');
	str = stringReplace(str, '&gt;', '>');
	return str;
}

function stringReplace(str1, str2, str3)
{
	str1 = str1.split(str2).join(str3);
	return str1;
}

function getObj(id)
{
	return document.getElementById(id);
}

function PreloadIcons()
{
	if (!_editorIconCache)
	{
		var index;
		var iconsLen = EditorIcons.length;
		_editorIconCache = Array(iconsLen);

		for (index = 0;index < iconsLen; index++) 
		{
			_editorIconCache[index] = new Image();
			_editorIconCache[index].src = EditorIcons[index];
		}
	}
}

function commandBuilder(id, name, arg, arg2, arg3)
{
	// EP-MODIFICATION: commented out call to RestoreCollection. REASON: commandBuilder tools could not be
	// accessed correctly by RCA, once focus was lost from the editor.
	//state = eval(id + '_State');
	//state.RestoreSelection();

	// EP-MODIFICATION: allow editor object to be passed in the id argument
	var editor = (id.constructor == String)	? getEditor(id) : id;

	editor.focus();
	if (arg == true)
		editor.document.execCommand(name,true,''); 
	else if (name == 'uploadedimage')
		editor.document.execCommand('insertimage',false,arg);
	else if (arg == null)
		editor.document.execCommand(name); 
	else if (arg == false)
		editor.document.execCommand(name, arg, arg2);
	else
		editor.document.execCommand(name,'',arg);
	editor.focus();
}

function State()
{
	this.selection = null;
	this.Mode = EDITORMODE_DESIGN;
	this.RestoreSelection = State_RestoreSelection;
	this.GetSelection = State_GetSelection;
	this.SaveSelection = State_SaveSelection;
}

function State_RestoreSelection() 
{
	if (this.selection) this.selection.select();
}

function State_GetSelection(id) 
{
	var sel = this.selection;
	var editor = getEditor(id);

	if (!sel) {
		sel = editor.document.selection.createRange();
		sel.type = editor.document.selection.type;
	}
	return sel;
}

function State_SaveSelection(id) 
{
	var editor = getEditor(id);

	try
	{
		state = eval(id + '_State');
		state.selection = editor.document.selection.createRange();
		state.selection.type = editor.document.selection.type;
	}
	catch (e)
	{
	}
}

function updateLength(id)
{
	if (eval(id + '_MaxLength'))
	{
		maxLength = eval(id + '_MaxLength');
		editorLength = getHtml(id).length;
		if (editorLength > maxLength)
			setHtml(id, getHtml(id).substring(0, maxLength));
	}
}

// Encode chars that are forbidden as data entities in html
function EncodeHtml(html)
{
	var encodedHtml;

	if (html == null)
		encodedHtml = "";
	else
	{	
		encodedHtml = html.replace(/&/g, "&amp;");	
		encodedHtml = encodedHtml.replace(/</g, "&lt;");	
		encodedHtml = encodedHtml.replace(/>/g, "&gt;");
		encodedHtml = encodedHtml.replace(/'/g, "&apo;");
		encodedHtml = encodedHtml.replace(/"/g, "&quot;");		
	}
	
	return encodedHtml;
}