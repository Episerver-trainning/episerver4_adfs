/*
 * contextmenu.js	- JavaScript support routines for EPiServer
 * Copyright (c) 2004 ElektroPost Stockholm AB
*/

// CONSTANTS
var MENU_ICON_WIDTH			= 14;
var MENU_ICON_HEIGHT		= 14;
var CLEAR_IMAGE_URL			= 'clear.gif';
var ARROW_IMAGE_URL			= 'Arrow.gif';

// NOTE: All context menus need to initialize themselves by adding their setup function pointer
// using the following code:
/*
if (!window.ContextMenuSetupHandlers)
	window.ContextMenuSetupHandlers = new Array();
window.ContextMenuSetupHandlers.push(setupFunction);
*/

window.attachEvent("onload", SetupContextMenus);

function SetupContextMenus()
{
	var index;
	var setupFunction;

	window.detachEvent("onload", SetupContextMenus);
	
	if (!window.ContextMenuSetupHandlers)
		return;
	
	for(index=0; index < window.ContextMenuSetupHandlers.length; index++)
	{
		setupFunction = window.ContextMenuSetupHandlers[index];
		setupFunction();
	}
}

function ContextMenu()
{	
	this.menuItems		= new Array();
	this.itemCount		= 0;
	this.popupWindow	= null;
	this.popupBody		= null;
	this.menuEnabled	= true;
	this.baseMenu		= null;
	this.realHeight		= 0;
	this.sortedMenu		= false;
	this.sortKeyPrefix	= null;
	this.isInitialized  	= false;
	this.renderTopAligned	= false;
	this.renderBottomAligned = false;
	this.alignedElement = null;
	
	// Call back functions
	this.onbeforeopen	= null;
}

ContextMenu.prototype.SortMenuItems = function (firstItem, secondItem)
{
	var sort1 = firstItem.sortKey;
	var sort2 = secondItem.sortKey;
	if (sort1 == sort2)
		return 0;
		
	if (typeof(sort1) == 'string')
		sort1 = parseInt(sort1);
	if (typeof(sort2) == 'string')
		sort2 = parseInt(sort2);
	if (typeof(sort1) != 'number' || typeof(sort2) != 'number' || isNaN(sort1) || isNaN(sort2))
		return (firstItem.sortKey > secondItem.sortKey ? 1 : -1);
	return (sort1 > sort2 ? 1 : -1);
}

ContextMenu.prototype.AddMenuItem = function (sCaption,sURL,sJavascript,sEnabled,sImageURL,sDisabledImageURL,oSubMenu, sortKey)
{
	if (this.sortedMenu)
	{
		if (!sortKey)
			sortKey = sCaption;
			
		if (this.sortKeyPrefix)
			sortKey = this.sortKeyPrefix + sortKey;
	}

	this.menuItems[this.itemCount++] = new MenuItem(sCaption,sURL,sJavascript,sEnabled,sImageURL,sDisabledImageURL,oSubMenu, sortKey);
}

ContextMenu.prototype.AttachContainer = function (obj)
{
	var thisMenu = this;
	this.handleOnContextMenu = function (e) { return thisMenu.Show(e); }
	obj.attachEvent("oncontextmenu", this.handleOnContextMenu);
}

ContextMenu.prototype.DetachContainer = function (obj)
{
	if(obj!=null && this.handleOnContextMenu)
	{
		obj.detachEvent("oncontextmenu", this.handleOnContextMenu);
		this.handleOnContextMenu = null;
	}
		
	if(this.isInitialized)
		this.CleanMenu();
	
}

ContextMenu.prototype.CleanMenu = function ()
{
	if (!this.isInitialized)	// Prevent double cleaning
		return;

	var aItems			= this.menuItems;
	var menu			= this;
	var htmlContainer   = this.popupWindow;
	
	this.alignedElement = null;
			
	for(var i=0;i<aItems.length;i++)
	{
		var oSpan = aItems[i].SpanObject;
		
		if(!aItems[i].sCaption)
			continue;
		
		oSpan.detachEvent('onmouseover',oSpan.handleActiveMenuItem);
		oSpan.detachEvent('onmouseout',oSpan.handleInactiveMenuItem);
		oSpan.detachEvent('onclick',oSpan.handleOpenMenuItem);
		
		oSpan.handleActiveMenuItem = null;
		oSpan.handleInactiveMenuItem = null;
		oSpan.handleOpenMenuItem = null;

		if(aItems[i].oSubMenu)
			aItems[i].oSubMenu.CleanMenu();
	}
	
	htmlContainer.document.body.detachEvent("oncontextmenu",menu.handleCancelEvent);
	menu.handleCancelEvent = null;
	this.popupWindow.document.close();
	this.popupWindow.document.innerHTML = '';	
	this.isInitialized = false;
	return true;
}


/* Show renders the menu by opening the corresponding popupWindow on the correct location */
ContextMenu.prototype.Show = function (sourceEvent, baseMenu, menuOnImgClick)
{
	if(!this.menuEnabled)
		return;

	// Trigger onbeforeopen callback, if used
	if (this.onbeforeopen)
		this.onbeforeopen(this);

	// Make sure the menu is initialized before rendered
	if (!this.isInitialized)
		this.InitializeMenu();
		
	this.baseMenu = baseMenu;
		
	if (!sourceEvent)
		sourceEvent = event;

	if(baseMenu==null && sourceEvent.srcElement.isContentEditable==false && (sourceEvent.ctrlKey || (sourceEvent.srcElement.tagName=='IMG' && !menuOnImgClick) || sourceEvent.srcElement.tagName=='INPUT'))
		return;

	oMenu = this;
	if(oMenu.Enabled==false)
		return;
	if(oMenu.menuItems.length==0)
		return;
		
	this.RenderMenuItems();
	
	oMenu.fVisible = true;

	var oSpan = this.GetSpan(sourceEvent.srcElement);
	
	if (oSpan != null && baseMenu!=null)
	{	// This menu is a submenu - open it at the correct location based on our parent menu
		if((oSpan.document.parentWindow.screenLeft + 300) > window.screen.width)
			this.popupWindow.show(-194,0,200, this.realHeight,oSpan);
		else
			this.popupWindow.show(194,0,200, this.realHeight,oSpan);
	}
	else if (oSpan != null && this.renderTopAligned)
	{
		this.alignedElement = oSpan;
		this.popupWindow.show(0,-this.realHeight+1,200, this.realHeight,oSpan.parentElement);
	}
	else if (oSpan != null && this.renderBottomAligned)
	{
		this.alignedElement = oSpan;
		this.popupWindow.show(0,17,200, this.realHeight,oSpan.parentElement);		
	}
	else
	{
		this.popupWindow.show(sourceEvent.screenX,sourceEvent.screenY,200, this.realHeight);
	}
			
	sourceEvent.cancelBubble = true;
	sourceEvent.returnValue = false;
	return false;
}


/* RenderMenuItems (previously WriteHTML) updates menu item rendering based on their enabled/disabled state */
ContextMenu.prototype.RenderMenuItems = function ()
{
	var aItems = this.menuItems;
	
	for(var i=0;i<aItems.length;i++)
	{
		if(!aItems[i].sCaption)	// Ignore separators
			continue;
		
		// Retrieve the objects making up the visible menu item
		var oSpan	= aItems[i].SpanObject;
		var oImage	= oSpan.children[0];	// The icon is the first child object of the span
		var oNoBr	= aItems[i].NoBrObject;

		// Check enabled state and set correct class and image
		oSpan.fEnabled = eval(aItems[i].sEnabled)
		if( oSpan.fEnabled )
		{
			oSpan.className = 'ContextMenuItem';
			oImage.src		= aItems[i].sImageURL ? aItems[i].sImageURL : CLEAR_IMAGE_URL;
		}
		else
		{
			oSpan.className = 'ContextMenuItemDisabled';
			oImage.src		= aItems[i].sDisabledImageURL ? aItems[i].sDisabledImageURL : CLEAR_IMAGE_URL;
		}
	}
	return true;
}

/* InitializeMenu creates a menu for the ContextMenu instance by filling the popupWindow (created if needed) with the menu's items */
ContextMenu.prototype.InitializeMenu = function ()
{
	if (this.isInitialized)	// Prevent double initializations
		return;

	if (this.sortedMenu)
		this.menuItems.sort(this.SortMenuItems);

	var aItems			= this.menuItems;
	var menu			= this;
	var htmlContainer;

	// Create the popupWindow if it does not already exist
	if (this.popupWindow == null)
		htmlContainer = this.CreatePopupWindow();
	else
		htmlContainer = this.popupWindow;
	
	htmlContainer.document.body.innerHTML = '';
	this.realHeight = 0;
		
	for(var i=0;i<aItems.length;i++)
	{
		var oSpan	= htmlContainer.document.createElement('span');
		var oImage	= htmlContainer.document.createElement('img');
		var oNoBr	= htmlContainer.document.createElement('nobr');

		// Store references for the objects that form the menu item, in the item object (needed when rendering the menu)		
		aItems[i].SpanObject = oSpan;		
		aItems[i].NoBrObject = oNoBr;		
							
		if(!aItems[i].sCaption && (i==0 || i==(aItems.length-1)))
			continue;
			
		oSpan.MenuIndex = parseInt(i.toString());
			
		if(!aItems[i].sCaption)
		{	// This item is a separator
			oSpan.className = "ContextMenuItem-Separator";
			htmlContainer.document.body.appendChild(oNoBr);
			oNoBr.appendChild(oSpan);
			this.realHeight += 6;
		}
		else
		{
			// This is a regular menu item
			this.realHeight += MENU_ICON_HEIGHT + 2;
			
			oSpan.fEnabled = eval(aItems[i].sEnabled);
			
			oSpan.handleActiveMenuItem = function(e){menu.ActiveMenuItem(e);}
			oSpan.handleInactiveMenuItem = function(e){menu.InactiveMenuItem(e);}
			oSpan.handleOpenMenuItem = function(e){menu.OpenMenuItem(e);}
			
			oSpan.attachEvent("onmouseover",oSpan.handleActiveMenuItem );
			oSpan.attachEvent("onmouseout",oSpan.handleInactiveMenuItem);
			oSpan.attachEvent("onclick",oSpan.handleOpenMenuItem);

			oImage.height	= MENU_ICON_HEIGHT;
			oImage.width	= MENU_ICON_WIDTH;
			oImage.valign	= 'middle';
			oImage.align	= 'left';		

			// Insert the configured menu item into the htmlContainer (the popupWindow)
			htmlContainer.document.body.appendChild(oNoBr);
			oNoBr.appendChild(oSpan);
			oSpan.appendChild(oImage);

			if(aItems[i].oSubMenu)
			{	// The menu item has a submenu, add a submenu arrow gif
				var oSubImage =	htmlContainer.document.createElement('img');
				oSubImage.className = 'ArrowMenuImage';
				oSubImage.src = ARROW_IMAGE_URL;
				oSubImage.valign = 'middle';
				oSubImage.align = 'right';
				oSubImage.id = 'arrow' + i;
				oSpan.appendChild(oSubImage);
				
				// Connect the submenu item to this (the parent) menu, and initialize it
				aItems[i].oSubMenu.baseMenu = this;
				aItems[i].oSubMenu.InitializeMenu();
			}
			
			oSpan.innerHTML += aItems[i].sCaption;
		}
	}
	
	this.realHeight += 7;
	this.isInitialized = true;	// Set variable to prevent from initializing again
	return true;
}

/* GetSpan returns the span enclosing the object passed in as an argument */
ContextMenu.prototype.GetSpan = function (obj)
{		
	var curObj = obj;
	
	//Only go 3 levels up at most, it won't be further away
	var i = 0;
	while(curObj != null && curObj.tagName!='SPAN' && i<=3)
	{
		curObj = curObj.parentElement;
		i++;
	}
	
	if(curObj == null || curObj.tagName!='SPAN')
		return null;
		
	return curObj;
}

/* Handling for mouse-over action */
ContextMenu.prototype.ActiveMenuItem = function (sourceEvent)
{
	var oSpan		= this.GetSpan(sourceEvent.srcElement);
	if(oSpan==null)
		return;	

	var nMenuItem	= oSpan.MenuIndex;
	var oMenu		= this;
	var oMenuItem	= oMenu.menuItems[nMenuItem];
	
	if(!oMenuItem.sCaption)
		return;
		
	if(!oMenuItem.sJavascript && !oMenuItem.sURL)
		oSpan.style.cursor = "default";
	
	if( oSpan.fEnabled==1 )
	{		
		oSpan.className = 'ContextMenuItem-Active';
		if(oMenuItem.oSubMenu)
		{
			var arrowImage = this.popupBody.all['arrow'+nMenuItem];
		}
	}
	else
	{
		oSpan.className = 'ContextMenuItemDisabled-Active';
	}

	if(this.openedByMenuItem != nMenuItem)
	{
		if(this.openedByMenuItem!=null)
		{
			var openerItem = oMenu.menuItems[this.openedByMenuItem];
			if(openerItem.oSubMenu)
			{
				openerItem.oSubMenu.Hide();
				var obj = this.popupBody.childNodes(this.openedByMenuItem);
				this.openedByMenuItem = null;
				obj.childNodes(0).fireEvent('onmouseout');
			}
		}
		
		if(oMenuItem.oSubMenu && oSpan.fEnabled==1)
		{
			this.openedByMenuItem = nMenuItem;
			oMenuItem.oSubMenu.Show(sourceEvent,this);
		}
	}
	
	sourceEvent.cancelBubble = true;
	sourceEvent.returnValue = false;
	return false;
}

/* Handling for mouse-out action */
ContextMenu.prototype.InactiveMenuItem = function (sourceEvent)
{
	var oSpan		= this.GetSpan(sourceEvent.srcElement);
	if(oSpan==null)
		return null;
	var nMenuItem	= oSpan.MenuIndex;

	if(this.openedByMenuItem == nMenuItem)
		return;
		
	var oMenu = this;
	var oMenuItem = oMenu.menuItems[nMenuItem];
	
	if(!oMenuItem.sCaption)
		return;
	
	if( oSpan.fEnabled==1 )
		oSpan.className = 'ContextMenuItem';
	else
		oSpan.className = 'ContextMenuItemDisabled';
		
	sourceEvent.cancelBubble = true;
	sourceEvent.returnValue = false;
	return false;
}

/* Handling for click action */
ContextMenu.prototype.OpenMenuItem = function (sourceEvent)
{
	var oSpan		= this.GetSpan(sourceEvent.srcElement);
	var nMenuItem	= oSpan.MenuIndex;
	var oMenu		= this;
	var oMenuItem	= oMenu.menuItems[nMenuItem];

	if((!oMenuItem.oSubMenu || oMenuItem.sJavascript || oMenuItem.sURL) && eval(oMenuItem.sEnabled) && oMenuItem.sCaption )
	{			
		if(oMenuItem.sJavascript)
			eval(oMenuItem.sJavascript);
		if(oMenuItem.sURL)
			window.open(oMenuItem.sURL,'_top');
		
		if(this.alignedElement)
		{	
			this.alignedElement.children[0].src		= oMenuItem.sImageURL ? oMenuItem.sImageURL : CLEAR_IMAGE_URL;
			this.alignedElement.innerHTML = this.alignedElement.children[0].outerHTML + this.alignedElement.children[1].outerHTML + oMenuItem.sCaption;
		}
		
		this.HideRecursive();
	}
	else if (oMenuItem.oSubMenu)
	{	
		this.openedByMenuItem = null;	
		this.ActiveMenuItem(sourceEvent);
	}

	sourceEvent.cancelBubble = true;
	sourceEvent.returnValue = false;
	return false;
}

/* Close current open menu */
ContextMenu.prototype.Hide = function ()
{
	this.popupWindow.hide();
	this.openedByMenuItem = null;
}

/* Close all open menus */
ContextMenu.prototype.HideRecursive = function ()
{
	this.Hide();
	if(this.baseMenu!=null)
		this.baseMenu.Hide();
}

/* CreatePopupWindow (previously known as InitializeMenu) only creates and configures the popupWindow object to render the menu in */
ContextMenu.prototype.CreatePopupWindow = function ()
{
	if(this.baseMenu && this.baseMenu.popupWindow!=null)
		this.popupWindow = this.baseMenu.popupWindow.document.parentWindow.createPopup();
	else
		this.popupWindow = window.createPopup();
		
    for(var i=0;i<document.styleSheets.length;i++)
	{
		if(document.styleSheets[i].href && document.styleSheets[i].href.toLowerCase().indexOf('contextmenu.css')>=0)
		{
			this.popupWindow.document.createStyleSheet(document.styleSheets[i].href);
			break;
		}
	}
	    
	this.openedByMenuItem = null;
	
	this.popupWindow.document.body.className			= 'ContextMenu';
	this.popupWindow.document.body.style.borderStyle	= 'solid';
	this.popupWindow.document.body.style.borderColor	= '#6D8CA8';
	this.popupWindow.document.body.style.borderWidth	= '1px';
	this.popupWindow.document.body.style.padding		= '1px';

	// Attach local function object to event (makes it possible to access 'this' in the event handler)	
	var thisMenu = this;
	thisMenu.handleCancelEvent = function (e) { thisMenu.CancelEvent(e); };
	this.popupWindow.document.body.attachEvent("oncontextmenu",thisMenu.handleCancelEvent);
	
	this.popupBody = this.popupWindow.document.body;
	
	return this.popupWindow;
}

ContextMenu.prototype.CancelEvent = function (sourceEvent)
{
	if(!sourceEvent)
		sourceEvent = event;
		
	var oSpan = this.GetSpan(sourceEvent.srcElement);
	if (oSpan != null)
	{
		var oMenuItem	= this.menuItems[oSpan.MenuIndex];

		// The event causes submenu to close (because popupwindows close on all click-related events), 
		// so reopen it for smooth experience...
		if (oMenuItem.oSubMenu)
		{	
			this.openedByMenuItem = null;	
			this.ActiveMenuItem(sourceEvent);
		}
	}
	
	sourceEvent.cancelBubble = true;
	sourceEvent.returnValue = false;
	return false;
}

ContextMenu.prototype.DisableMenu = function ()
{
	this.Enabled = false;
}

/* Class for menuitem */
function MenuItem(sCaption,sURL,sJavascript,sEnabled,sImageURL,sDisabledImageURL,oSubMenu, sortKey)
{
	this.sCaption			= sCaption;
	this.sURL				= sURL;
	this.sJavascript		= sJavascript;
	this.sEnabled			= sEnabled;
	this.sImageURL			= sImageURL;
	this.sDisabledImageURL	= sDisabledImageURL;
	this.oSubMenu			= oSubMenu;
	
	if (sortKey)
		this.sortKey		= sortKey;
}

/* Callback functions allowing for functions to be called once the menu object is created on the clientside */
function ExecuteMenuCallbackFunctions(menuID)
{
	var callbackFunctions = eval("window." + menuID + "_callbackFunctions");
	
	if (callbackFunctions)
	{
		var index;
		var callbackFunc;
		
		for(index = 0; index < callbackFunctions.length; index++)
		{
			callbackFunc = callbackFunctions[index];
			callbackFunc();
		}
	}
}

function RegisterMenuCallbackFunction(menuID, func)
{
	var callbackArrayName = "window." + menuID + "_callbackFunctions";
	var callbackFunctions = eval(callbackArrayName);

	if (!callbackFunctions)
	{
		execScript(callbackArrayName + " = new Array();");
		callbackFunctions = eval(callbackArrayName);
	}

	callbackFunctions.push(func);		
}
