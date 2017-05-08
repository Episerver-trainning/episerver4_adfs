/*
 * explorertree.js	- JavaScript support routines for EPiServer
 * Copyright (c) 2004 ElektroPost Stockholm AB
*/

var _browserIsIE = (navigator.appName == 'Microsoft Internet Explorer' ? true : false);

var TOGGLE_ASYNC_DELAY = 10;	// in milliseconds

var _explorerTree = new Object();
_explorerTree.Toggle = ExplorerTree_Toggle;

var currentACL;
var useTreeRCA = false;

function QueryAccess(requiredAccess)
{
	return ((currentACL & requiredAccess) == requiredAccess);
}

function ExplorerTree_Toggle(source)
{
	try
	{
		this.containerElement = GetContainerElement(source);
		
		var toggle = document.all[this.containerElement.id + '#toggle'];

		if (toggle.expanded == 'True')
			ExplorerTreeCollapse(this.containerElement);
		else
			ExplorerTreeExpand(this.containerElement);
	}
	catch(e)
	{
		alert(	'ExplorerTreeToggle\n\nerror: ' + e.message + 
				'\n\nelement: ' + containerElement.tagName +
				'\n' + (containerElement.outerHTML != null ? containerElement.outerHTML : 'NO outerHTML'));
	}
}

function ExplorerTreeClear(item)
{
	if(typeof(item)=='string' || typeof(item)=='number')
		item = document.all['page#' + item];
		
	if(item==null)
		return;
		
	var data = document.all[item.id + '#children'];
	var toggle = document.all[item.id + '#toggle'];
	
	toggle.expanded = "False";
	var img = toggle.getElementsByTagName('IMG');
	
	for(var i=0;i<img.length;i++)
	{
		img[i].src		= String(img[i].src).replace('+.gif','.gif');
		img[i].src		= String(img[i].src).replace('-.gif','.gif');
	}

	data.style.display = 'none';
	data.innerHTML = '';
	
}

function ExplorerTreeDelete(item,navItem)
{
	if(typeof(item)=='string' || typeof(item)=='number')
		item = document.all['page#' + item];
		
	if(item==null)
		return;
		
	var data = document.all[item.id + '#children'];
		
	var nextItem = ExplorerTreeFindNextSibling(item);
		
	if(nextItem==null)
	{
		var prevItem = ExplorerTreeFindPreviousSibling(item);
		if(prevItem!=null)
		{
			var img = prevItem.getElementsByTagName('IMG');
		
			for(var i=0;i<img.length;i++)
			{
				img[i].src		= String(img[i].src).replace('T.gif','L.gif');
				img[i].src		= String(img[i].src).replace('T+.gif','L+.gif');
				img[i].src		= String(img[i].src).replace('T-.gif','L-.gif');
			}
		}
	}
	
	ExplorerTreeSelect(navItem);
	
	if(item.parentElement.parentElement.childNodes.length==2)
	{
		var itemParent = ExplorerTreeFindParent(item);
		if(itemParent!=null)
			ExplorerTreeClear(itemParent);
		else
		{
			item.parentElement.parentElement.removeChild(item.parentElement);
			data.parentElement.removeChild(data);
		}
	}
	else
	{
			item.parentElement.parentElement.removeChild(item.parentElement);
			data.parentElement.removeChild(data);
	}
}

function ExplorerTreeSelectNext(item)
{
	var next = null;
	next = ExplorerTreeFindNextSibling(item);
	if(next==null)
		next = ExplorerTreeFindPreviousSibling(item);
	if(next==null)
		next = ExplorerTreeFindParent(item);
	
	ExplorerTreeSelect(next);

}

function ExplorerTreeFindParent(item)
{
	if(typeof(item)=='string' || typeof(item)=='number')
		item = document.all['page#' + item];
		
	if(item==null)
		return null;
		
	var nobr = item.parentElement;
	if(nobr==null)
		return null;
		
	var children = nobr.parentElement;
	if(children==null)
		return null;
		
	var parentNobr = children.previousSibling;
	if(parentNobr==null)
		return null;
		
	var parent = parentNobr.childNodes[0];
	if(parent==null)
		return null;
		
	return parent;
}

function ExplorerTreeFindNextSibling(item)
{
	if(typeof(item)=='string' || typeof(item)=='number')
		item = document.all['page#' + item];
		
	if(item==null)
		return null;
		
	var nobr = item.parentElement;
	if(nobr==null)
		return null;

	var children = nobr.nextSibling;
	if(children==null)
		return null;
		
	var nextNoBr = children.nextSibling;
	if(nextNoBr==null)
		return null;
		
	var nextItem = nextNoBr.childNodes[0];
	if(nextItem==null)
		return null;
			
	return nextItem;
}

function ExplorerTreeFindPreviousSibling(item)
{
	if(typeof(item)=='string' || typeof(item)=='number')
		item = document.all['page#' + item];
		
	if(item==null)
		return null;
		
	var nobr = item.parentElement;
	if(nobr==null)
		return null;
			
	var children = nobr.previousSibling;
	if(children==null)
		return null;
		
	var prevNoBr = children.previousSibling;
	if(prevNoBr==null)
		return null;
		
	var prevItem = prevNoBr.childNodes[0];
	if(prevItem==null)
		return null;
		
	return prevItem;
}

function ExplorerTreeCollapse(item)
{
	if(typeof(item)=='string' || typeof(item)=='number')
		item = document.all['page#' + item];
		
	if(item==null)
		return;

	var data = document.all[item.id + '#children'];
	var toggle = document.all[item.id + '#toggle'];

	toggle.expanded = "False";
	var img = toggle.getElementsByTagName('IMG');

	for(var i=0;i<img.length;i++)
	{
		img[i].src		= String(img[i].src).replace('-.gif','+.gif');
	}
		

	data.style.display = 'none';
	data.innerHTML = '';
	
}

function ExplorerTreeExpand(item)
{
	if(typeof(item)=='string' || typeof(item)=='number')
		item = document.all['page#' + item];
	
	if(item==null)
		return;

	var data	= document.all[item.id + '#children'];
	var toggle	= document.all[item.id + '#toggle'];
	var img		= toggle.getElementsByTagName('IMG');
	
	toggle.expanded = "True";
	
	for(var i=0;i<img.length;i++)
		img[i].src		= String(img[i].src).replace('+.gif','-.gif');

	RefreshBodyPart(data.id,item.treenodesrc + '&selected=' + ExplorerTreeGetSelected(),'ExplorerTreeImportViewState',getForm().elements[item.viewstate]);
}

function ExplorerTreeRefresh(item)
{
	if(typeof(item)=='string' || typeof(item)=='number')
		item = document.all['page#' + item];
	
	if(item==null)
		return;
		
	var parent = ExplorerTreeFindParent(item);

	if(parent!=null)
		RefreshBodyPart(item.id,parent.treenodesrc + '&selected=' + ExplorerTreeGetSelected(),'ExplorerTreeImportViewState',getForm().elements[item.viewstate]);
}

function ExplorerTreeSetIcon(item,imageSrc)
{
	if(typeof(item)=='string' || typeof(item)=='number')
		item = document.all['page#' + item];
	
	if(item==null)
		return;

	var ico	= document.all[item.id + '#statusicon'];
	ico.src = imageSrc;
}

function ExplorerTreeSelect(item)
{
	if(typeof(item)=='string' || typeof(item)=='number')
		item = document.all['page#' + item];
	
	if(item==null || item.id==null)
		return;

	var source = item;
	
	if(source.id.indexOf('#link')<0)
		source = document.all[item.id + '#link'];
		
	if(source==null)
		return;
		
	var selectedID = ExplorerTreeGetSelected();
	if(selectedID!='')
	{
		var selectedLink = document.all['page#' + selectedID + '#link'];
		if(selectedLink!=null)
			selectedLink.className = 'ExplorerTreeLink';
	}
	source.className = 'ExplorerTreeSelectedLink';
	ExplorerTreeSetSelected(source.PageLink);

}

function ExplorerTreeSetSelected(selectedID)
{
	window.explorerTreeLatestNavigate = selectedID;
}

function ExplorerTreeGetSelected()
{
	if(window.explorerTreeLatestNavigate)
		return window.explorerTreeLatestNavigate;
	else
		return '';
}

// Search for the first ancestor (parent elements including current element) that has a ContainerToPage
// attribute. The first element we can find is the container for this branch.
function GetContainerElement(element)
{
	while(element != null && element.IsContainer == null)
	{
		element = element.parentElement;
	}

	return element;
}

function ExplorerTreeEventDispatcher()
{
	var source = event.srcElement;
	var parent = source.parentElement;
	var dispatchedEvent = source.tagName.toUpperCase() + '.' + event.type.toLowerCase();
	var statusWindow = (window.parent == null) ? window : window.parent;

	switch(dispatchedEvent)
	{
		case 'IMG.click':
			// If the parent element is a treeview expanded-node, toggle it
			if (parent.expanded != null)
			{
				_currentElement = parent;
				
				if (_browserIsIE)
					_explorerTree.Toggle(parent);				
				else
					__doPostBack(this.id, this.PageLink);
			}
			break;

		case 'A.mouseover':
			statusWindow.status = source.LinkURL;
			break;

		case 'A.mouseout':
			statusWindow.status = statusWindow.defaultStatus;
			break;
		case 'A.contextmenu':
			if(window.ExternalDispatcher)
				return window.ExternalDispatcher(dispatchedEvent);
			break;
		case 'A.click':
			
			ExplorerTreeSelect(source);
			eval(source.Action);
			// Cancel the mouseclick event for this element (since we are overriding the standard functionality)
			event.cancelBubble = true;
			event.returnValue = false;
			return false;
			
			break;
		default:
			if (event.type.toLowerCase() != 'click')
				return true;
				
			while (parent != null && parent.tagName.toUpperCase() != 'A')
				parent = parent.parentElement;
			if (!parent)
				return false;
			if (parent.tagName.toUpperCase() != 'A')
				return false;
			ExplorerTreeSelect(parent);
			eval(parent.Action);
			// Cancel the mouseclick event for this element (since we are overriding the standard functionality)
			event.cancelBubble = true;
			event.returnValue = false;
			return false;
	}
	return true;
}
