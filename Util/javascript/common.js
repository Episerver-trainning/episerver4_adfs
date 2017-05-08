/*
 * common.js - JavaScript support routines for EPiServer
 *             This file holds common functions used by templates, edit mode functions, editor etc.
 * Copyright (c) 2005 ElektroPost Stockholm AB
 *
 * NOTE: This file should only be included using the following codebehind code:
 *
 * ((PageBase) Page).RegisterClientScriptFile("EPiServer:common.js", "Util/javascript/common.js");
*/

if (!window.EditorScriptVersions)
	window.EditorScriptVersions = new Array();
window.EditorScriptVersions.push("common 4");

// Call list of onbeforeUnload functions, if any. Used by webcontrols that must do their
// changes-detection during the onbeforeunload-event (and not before).
// NOTE: This function is only called if it has been set as the onbeforeunload event function.
// If it is called it means that there are no changes detected in webcontrols that would have set the
// leavePage as the onbeforeunload function. It also means that we do not know, at the entry point
// in the function, whether there are changes or not. That question will be resolved when the callback
// function(s) are executed.
function leavePageCallback()
{
	var changesDetected = false;

	var index;
	var onbeforeUnloadFunction;
	
	for(index = 0; index < window.onbeforeUnloadFunctions.length && !changesDetected; index++)
	{
		onbeforeUnloadFunction = window.onbeforeUnloadFunctions[index];
		
		if (onbeforeUnloadFunction)
			changesDetected = onbeforeUnloadFunction();
	}

	if (changesDetected && window.leavePage)
		window.leavePage();
}

// Register your script application to EPiServer's change detection by calling this function.
// The 'func' argument is a function object that will be called before leaving the page, if page
// is left without saving, to find out if there are any changes that would get lost. 
// If there are any unsaved changes the function should return true, otherwise false.
function RegisterToChangeDetection(func)
{
	if (!window.onbeforeUnloadFunctions)
	{
			window.onbeforeUnloadFunctions = new Array();
			window.onbeforeunload = leavePageCallback;
	}
			
		window.onbeforeUnloadFunctions.push(func);
}


// Register your script application to EPiServer's submit-function queue. 
// The 'func' argument is a function object that will be called before the page is submitted.
function RegisterSubmitHandler(func)
{
	if (!window.onbeforeSubmitFunctions)
	{
		window.onbeforeSubmitFunctions = new Array();
		InitSubmitHandler(MasterSubmitHandler);
	}
	window.onbeforeSubmitFunctions.push(func);
}

// For internal use only. Part of the EPiServer submit-function queue.
function MasterSubmitHandler()
{
	if (!window.onbeforeSubmitFunctions)
		return;

	var index;
	var submitHandler;
	var returnValue = false;

	for(index = 0; index < window.onbeforeSubmitFunctions.length; index++)
	{
		submitHandler = window.onbeforeSubmitFunctions[index];
		if (submitHandler() == false)
			return false;
	}
	
	try
	{
		returnValue = window.defaultSubmitHandler();
	}
	catch(e) 
	{ 
		// The defaultSubmit call fails if user clicks Cancel in the changes dialog, for some 
		// unknown reason. The error is non-fatal so we just ignore it.
	}	

	return returnValue;			
}

// Override form's default submit handler with our own handler.
// For internal use only. Part of the EPiServer submit-function queue.
function InitSubmitHandler(func)
{
	// Only initialize once
	if (window.defaultSubmitHandler)
		return;
		
	var submitForm = document.forms[0];

	// Copy reference to original submit method so we can call it later in our own submit handler.
	window.defaultSubmitHandler = submitForm.submit;

	// Define our own submit handler. The handler is executed when somebody calls the form's submit method.
	submitForm.submit = func;

	// Submit buttons will *not* trigger our submit handler (this is by design... go figure),
	// so we need to attach our submit handler to the onsubmit event.
	submitForm.attachEvent("onsubmit", func);
}

// Open the linktool dialog. Use this function to open the dialog from your own code.
function OpenLinkToolDialog(dialogURL, dialogArguments)
{
	dialogURL += (dialogURL.indexOf('?') >= 0 ? '&' : '?') + 'caller=dhtmleditor';

	return OpenDialog(dialogURL, dialogArguments);
}

function OpenDialog(dialogURL, dialogArguments, width, height)
{
	width = (!width) ? 560 : parseInt(width);
	height = (!height) ? 465 : parseInt(height);

	var dialogParameters = 'dialogWidth:' + width + 'px;dialogHeight:' + height + 'px;help=no;resizable:no;scroll:no;status:no;';
	
	return OpenDialogWithParameters(dialogURL, dialogArguments, dialogParameters);
}

function OpenDialogWithParameters(dialogURL, dialogArguments, dialogParameters)
{
	var returnedObject;
	var ex;

	// The following flag is used by the editor to track if focus is lost because of a dialog is being opened.
	// When the flag is true, the caret position is not lost in the editor when the focusout event is triggered.
	window.OpeningDialog = true;

	try
	{
		returnedObject = window.showModalDialog(dialogURL, dialogArguments, dialogParameters);
	}
	catch (ex)
	{
		ShowMsg("Popups are blocked for this site, you need to enable popups to access this function.");
		returnedObject = "";
	}

	window.OpeningDialog = false;
	
	return returnedObject;
}

// Show a message in an alert, but only if Gui interaction is allowed (otherwise an exception with the message is thrown)
function ShowMsg(msg)
{
	if (window.NoGuiInteraction)
		throw new msg;
	else
		alert(msg);
}

function OpenDateBrowser(root,obj,title,noTime)
{
	var ret = null;

	try
	{
		ret = window.showModalDialog(root + 'Util/DateBrowser.aspx?value=' + escape(obj.value),'DateBrowser','status:no; resizable:yes; help:no; dialogWidth:240px; dialogHeight:300px; center:yes;scroll:no;');

		if(ret!=null)
		{
			obj.value=ret;
			obj.fireEvent("onchange");
		}
	}
	catch (ex)
	{
		alert("Popups are blocked for this site, you need to enable popups to access this function.");
	}
	
	return false;
}

// A list class to store key-value pairs, optionally categorized.
function List()
{
	this.Clear();
}

List.prototype.Clear = function()
{
	this.list = [];
}

// Get index of key, -1 if key does not exist
List.prototype.IndexOf = function(keyarg)
{
	if (isNaN(keyarg))
	{
		var index = this.list.length;
	
		while(--index >= 0)
			if (this.list[index].key == keyarg)
				return index;
		return -1;
	}
	else
		return keyarg;
}

// Get value by key name
List.prototype.GetValue = function(keyarg)
{
	var index = this.IndexOf(keyarg);
	if (index == -1)
		throw 'Key ' + keyarg + ' not found in list';

	return this.list[index].value;
}

// Get key name by index
List.prototype.GetKey = function(index)
{
	return this.list[index].key;
}

// Set new value on existing object. Category is optional.
List.prototype.SetValue = function(keyarg, valuearg, categoryarg)
{
	var index = this.IndexOf(keyarg);

	if (index == -1)
	{	
		this.list.push( { key: keyarg, value: valuearg, category: categoryarg ? categoryarg : '' } );		
	}
	else
	{
		this.list[index].value = valuearg;
		if (categoryarg)
			this.list[index].category = categoryarg;
	}
}

List.prototype.IterateValuesByCategory = function(category, callbackFunc)
{
	var index = this.list.length;
	
	while(--index >= 0)
	{
		if (this.list[index].category == category)
			callbackFunc(this.list[index]);
	}
}
