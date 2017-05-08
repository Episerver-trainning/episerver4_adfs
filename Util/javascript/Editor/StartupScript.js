/* --------------------------------------------------------------------------------------
   NOTE, IF YOU CHANGE THIS FILE: 
   1) Remember to increase the EditorStartupVersion below.
   2) Also remember to change the EditorStartupVersion in \Test\Testdata\StaticEditor.html, 
      or else... tests will fail.
   
   Another note: 
   This comment will NOT show up on the client. All c-style comments in this file are 
   removed runtime, when the file is read and cached.
   -------------------------------------------------------------------------------------- */
if (!window.EditorStartupVersion) window.EditorStartupVersion = '4';
var $CLIENTID$_EdRef = $CLIENTID$_Editor;
var $CLIENTID$_ParagraphIsDiv = document.getElementById('$CLIENTID$_ParagraphIsDiv');
var $CLIENTID$_State;
var $CLIENTID$_IFrameObj = document.getElementById('$CLIENTID$_Editor');
var $CLIENTID$_DisableCtrl = $CTRLDISABLED$;
var $CLIENTID$_MaxLength = $MAXLENGTH$;
var $CLIENTID$_editor = $CLIENTID$_Editor;
var $CLIENTID$_EditorArea = document.all['$CLIENTID$AREA'];
var	$CLIENTID$_EditorHtmlArea = document.createElement('textarea');
var $CLIENTID$_loadingMsg = document.createElement('span');	

with($CLIENTID$_loadingMsg) {
	innerHTML = '$LOADINGEDITOR$';
	style.position = 'relative';
	style.top = '30%';
	style.left = '20%';
	style.zIndex = 99;
}
with($CLIENTID$_EditorArea) {
	children(0).style.visibility = 'hidden';
	style.border = '1px solid black';
	insertAdjacentElement("BeforeBegin",$CLIENTID$_loadingMsg);
}

$CLIENTID$_IFrameObj.designMode='$EDITABLE$';

function $CLIENTID$_InitEditorMain()
{	
	var editorID	= '$CLIENTID$';
	var iframeObj	= $CLIENTID$_IFrameObj;
	$CLIENTID$_State = new State();
	iframeObj.frameWindow = document.frames[iframeObj.id];
	iframeObj.editorAPI = new TableEdit(editorID, iframeObj,'$EDITABLE$'=='on');
	iframeObj.editorAPI.Startup(iframeObj,'$CONTENTEDITABLE$');
}

function $CLIENTID$_UnloadEditorMain()
{
	GetEditorIFrame('$CLIENTID$').editorAPI.RemoveEventHandlers();
	window.detachEvent("onunload",$CLIENTID$_UnloadEditorMain);
}

window.attachEvent("onload",$CLIENTID$_InitEditorMain);
window.attachEvent("onunload",$CLIENTID$_UnloadEditorMain);
