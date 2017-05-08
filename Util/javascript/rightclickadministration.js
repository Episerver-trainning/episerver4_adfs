/*
 * rightclickadministration.js	- JavaScript support routines for EPiServer
 * Copyright (c) 2003 ElektroPost Stockholm AB
*/

var propInfo = new Array();
var isDopeEditing = false;

function InitDopeMode()
{
	for(var i=0;i<propInfo.length;i++)
		propInfo[i].EnableEditing();
}

function OnDopeEdit()
{
	input = document.createElement('<input type="hidden" name="DopeMode" value="enable">');
	document.forms[0].appendChild(input);
	DoPostback();
}

function OnDopePreview()
{
	isDopeEditing = false;
	PreparePostback();
	DoPostback();
}

function OnDopeCancel()
{
	isDopeEditing = false;
	window.location.href = window.location.href;
}

function OnDopeSave()
{
	isDopeEditing = false;
	input = document.createElement('<input type="hidden" name="DopeMode" value="saving">');
	document.forms[0].appendChild(input);
	PreparePostback();
	SetDopeAction('Publish')
	DoPostback();
}

function DoPostback()
{
	var form = getMainForm();
	DoEmptyPostback();
}

function SetDopeAction(action)
{
	var form = getMainForm();
	input = form.elements[action];
	if(input==null)
	{
		input = document.createElement('<input type="hidden" name="' + action + '" value="true">');
		form.appendChild(input);
	}
}

function PreparePostback()
{
	var form = getMainForm();

	var input = null;
	for(var i=0;i<propInfo.length;i++)
	{
		input = form.elements[propInfo[i].PostbackReference];
		if(input==null)
		{
			input = document.createElement('<input type="hidden" name="' + propInfo[i].PostbackReference + '">');
			form.appendChild(input);
		}
		var realElement = document.getElementById(propInfo[i].id);
		if(propInfo[i].IsHtmlContent=="True")
			input.value=realElement.innerHTML;
		else
			input.value=realElement.innerText;
	}
}

function RegisterProperty(element)
{
	for(var i=0;i<propInfo.length;i++)
	{
		if(element.PostbackReference==propInfo[i].PostbackReference)
		{
			propInfo[i]=element;
			return;
		}
	}
	
	propInfo[propInfo.length] = element;
}

function OnDopeCopySelection()
{
	var sel=document.selection.createRange();
	sel.select();
	document.execCommand('Copy');
	
	return false;
}

function OnDopeNavigateEvent(name,url)
{
	var wnd = getEditWindow();
	if(wnd!=null)
		wnd.commandEvent(window, new wnd.commandDescriptor(name,url));

}

function isEditMode()
{
	var frame;
	var wnd = this.window;
	
	while (wnd != null)
	{
		try
		{
			if(wnd.commandEvent && wnd.latestNavigate!=null && wnd.latestNavigate!='')
				return true;
		} 
		catch (e)
		{
			return false;
		}
		if (wnd == wnd.parent)
			break;
		wnd = wnd.parent;
	}
	return false;
}

function getEditWindow()
{
	var frame;
	var wnd = this.window;
	
	while (wnd != null)
	{
		try
		{
			if(wnd.commandEvent && wnd.latestNavigate!=null && wnd.latestNavigate!='')
				return wnd;
		}
		catch (e)
		{
			return null;
		}

		if (wnd == wnd.parent)
			break;
		wnd = wnd.parent;
	}
	return null;
}
function getMainForm()
{
	if(event!=null)
		var form = getParentForm(event.srcElement);
	else
		return document.forms[0];
	
	if(!form && document.forms.length>0)
	{
		form=document.forms[0];
	}
		
	return form;
}

function getParentForm(obj)
{
	var tag = obj;
	while(tag=tag.parentElement)
	{
		if(tag.tagName.toLowerCase()=='form')
			return tag;
	}
	
	return null;
}