/*
 * draganddrop.js	- JavaScript support routines for EPiServer
 * Copyright (c) 2004 ElektroPost Stockholm AB
 *
 * Updated to support MS04-038 security update
*/

var defaultDragAndCopyText = 'Copy "{0}" to "{1}"';
var defaultDragAndMoveText = 'Move "{0}" to "{1}"';
var dragElementText = '';

function RegisterDragAndDrop()
{
	document.body.ondragstart	= pageLinkOnDragStart;
	document.body.ondragover	= pageLinkOnDragOver;
	document.body.ondragenter	= pageLinkOnDragOver;
	document.body.ondrop		= pageLinkOnDrop;
}

function pageLinkOnDragOver()
{	
	var sourcePageLink		= window.event.dataTransfer.getData("Text");
	var destinationPageLink	= ParsePageLinkFromString(window.event.srcElement.getAttribute("PageLink"));
	
	if( isPageLink(destinationPageLink) && isPageLink(sourcePageLink) && sourcePageLink!=destinationPageLink )
	{
		window.event.dataTransfer.dropEffect = "copy";
		var statusText;
		if(!window.dragAndCopyText)
			statusText = window.event.ctrlKey ? defaultDragAndCopyText : defaultDragAndMoveText;
		else
			statusText = window.event.ctrlKey ? window.dragAndCopyText : window.dragAndMoveText;
		
			
		statusText = statusText.replace('{0}',dragElementText + ' [' + sourcePageLink + ']');
		statusText = statusText.replace('{1}',window.event.srcElement.innerText + ' [' + destinationPageLink + ']');
		
		window.status = statusText;
		
		window.event.cancelBubble = true;
	}
	else
	{
		window.status = '';
		window.event.dataTransfer.dropEffect = "none";
	}
		
	event.returnValue = false;
	window.event.dataTransfer.dropEffect = "copy";
}

function isSystemPage(pageLink)
{
	if(pageLink==window.StartPage || pageLink==window.WastebasketPage || pageLink==window.RootPage)
		return true;
	else
		return false;
}

function ParsePageLinkFromString(pageLink)
{
	if(pageLink==null)
		return;
		
	var id = parseFloat(pageLink);
	if(isNaN(id))
		return null;
	else
		return id;
}

function isPageLink(pageLink)
{
	return ParsePageLinkFromString(pageLink)==null ? false : true;
}

function pageLinkOnDrop()
{
	var sourcePageLink		= window.event.dataTransfer.getData("Text");
	var destinationPageLink	= ParsePageLinkFromString(window.event.srcElement.getAttribute("PageLink"));
	
	window.status = '';
	
	if( isPageLink(destinationPageLink) && isPageLink(sourcePageLink) && sourcePageLink!=destinationPageLink )
	{
		if (!window.event.dataTransfer || window.ondroppage==null)
			return;
		
		window.ondroppage(sourcePageLink,destinationPageLink,window.event.ctrlKey)
	}
}

function pageLinkOnDragStart()
{
	var sourcePageLink		= ParsePageLinkFromString(event.srcElement.getAttribute("PageLink"));
	
	if(  isPageLink(sourcePageLink) && !isSystemPage(sourcePageLink)  )
	{	
		if (!event.dataTransfer)
			return;
	
		event.dataTransfer.effectAllowed='copy';
		
		dragElementText = event.srcElement.innerText;

		window.event.dataTransfer.setData("Text",sourcePageLink.toString());
		window.event.dataTransfer.setData("URL",window.event.srcElement.getAttribute("href"));
		
		window.event.cancelBubble = true;
	}
	else
	{
		event.dataTransfer.effectAllowed='copy';
		event.returnValue = false;
	}

}