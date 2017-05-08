/*
 * resizeobjects.js	- JavaScript support routines for EPiServer
 * Copyright (c) 2004 ElektroPost Stockholm AB
 *
 * This file contains support routines for resizing properties in edit mode, called by the
 * Html Editor for example.
 *
 * You can add resizing support to your own EPiServer application by following these steps: 
 *
 * 1. Create the following client-side script function to handle resizing in your application:
 *
 *    ResizeObject(callingObject, newWidth, newHeight, keepAllVisible) 
 *       callingObject - a reference to the calling javascript object. The object must implement the callback functions
 *                       described in step 3 below.
 *       newWidth      - the new width of the object, for example '100%' or '120px'. If the width is null or zero,
 *                       the object's width is restored to the original value.
 *       newHeight     - the new height of the object, for example '40%' or '300px'. If the height is null or zero,
 *                       the object's height is restored to the original value.
 *       keepAllVisible- if true, all objects remain visible on the page. If false, all other objects should hide
 *                       (taking no space) and the resizing object gets all the available space.
 *	
 *    See the ResizeObjectDefault() function in this file for a sample of how resizing is done in edit mode.
 *
 * 2. Make sure that this file is loaded on the client, by using the following server-side code:
 *
 *	  ((PageBase) Page).RegisterClientScriptFile("EPiServer:resizeobjects.js", "Util/javascript/resizeobjects.js");
 *
 * 3. To allow your own object to be resized (for example, a plugin or custom property), implement the following
 *    callback functions in the calling object:
 *
 *    GetOwnerElement() - returns the HTML element where the calling object lives (a table cell in edit mode, for example).
 *    SetSize(width,height) - sets the new width and height for the calling object. The original dimensions must be 
 *                            saved internally by the calling object.
 *    RestoreOriginalSize() - set the calling object's width and height back to the original values (saved when SetSize was called).
 *
 *    Hint: to see a sample implementation of the the resizing functions above, take a look at the functions in 
 *    Util/javascript/Editor/TableEdit.js.
 *
 */

function ToggleObjectSize(callingObject)
{
	if (callingObject.maximized)
		ResizeObjectToNormal(callingObject);
	else
		ResizeObjectToMax(callingObject);
}

function ResizeObjectToMax(callingObject)
{
	if (window.ResizeObject)
		ResizeObject(callingObject, '100%', '100%', false);
	else
		ResizeObjectDefault(callingObject, '100%', '100%', false);

	callingObject.maximized = true;
}

function ResizeObjectToNormal(callingObject)
{
	if (window.ResizeObject)
		ResizeObject(callingObject, null, null, true);
	else
		ResizeObjectDefault(callingObject, null, null, true);
		
	callingObject.maximized = false;
}

function ResizeNotImplemented(resizeFunction)
{
	alert(resizeFunction + '() function not implemented by calling object.');
}

function IsResizeEnabledDefault(editorAPI)
{
	if (window.IsResizeEnabled)
		return IsResizeEnabled(editorAPI);
	else
		return document.forms[0].id == 'EditPanel';
}

function ResizeObjectDefault(callingObject, newWidth, newHeight, keepAllVisible)
{
	var ownerRow = null;
	var ownerElement;
	var restoreWidth  = isNaN(parseInt(newWidth));
	var restoreHeight = isNaN(parseInt(newHeight));

	if (!callingObject.GetOwnerElement)
		return ResizeNotImplemented('GetOwnerElement');

	if (document.forms[0].id != 'EditPanel')
		return;
	
	ownerElement = callingObject.GetOwnerElement();

	// Find the row that contains the ownerElement in the parent table
	while (ownerElement != null)
	{
		if (ownerElement.tagName.toUpperCase() == 'TR' && ownerElement.id.length > 0)
		{
			ownerRow = ownerElement;
			break;
		}
		ownerElement = ownerElement.parentElement;
	}

	if (ownerRow != null)
	{
		var editFormTable = ownerRow;
		var rowIndex;
		var rows;

		// Find out outer table that holds all properties
		while(editFormTable)
		{
			if (editFormTable.tagName.toUpperCase() == "TABLE")
				break;
			editFormTable = editFormTable.parentElement;	
		}

		rows = editFormTable.rows;
		
		if (keepAllVisible)
		{
 			for(rowIndex = 0; rowIndex < rows.length; rowIndex++)
 			{
 				if (rows[rowIndex] != ownerRow)
 					rows[rowIndex].className = rows[rowIndex].className.replace('EPEdit-tabObjectInactive','');
 			}
 		}
 		else
 		{
 			for(rowIndex = 0; rowIndex < rows.length; rowIndex++)
 			{
 				if (rows[rowIndex] != ownerRow && rows[rowIndex].className.indexOf('EPEdit-tabObjectInactive','') == -1)
					rows[rowIndex].className = 'EPEdit-tabObjectInactive';
 			}
 		}
		
		if (restoreWidth && restoreHeight)
		{
			// Restore original dimensions
			
 			editFormTable.style.width = editFormTable.originalWidth;
 			editFormTable.style.height = editFormTable.originalHeight;
 			ownerRow.style.width = '';
 			ownerRow.cells[0].style.width = ''; 

			if (!callingObject.RestoreOriginalSize)
				return ResizeNotImplemented('RestoreOriginalSize');

 			callingObject.RestoreOriginalSize();
 			ReleaseResizingResources();
		}
		else		
		{
			// Set max dimensions
			editFormTable.originalWidth = editFormTable.style.width;
			editFormTable.originalHeight = editFormTable.style.height;
 			editFormTable.style.width = '100%';
 			ResizeHeight(editFormTable);
 			window.ResizeHeightEventHandler = function(e) { ResizeHeight(editFormTable);  }
			window.attachEvent('onresize', window.ResizeHeightEventHandler );
 			window.attachEvent('onunload', ReleaseResizingResources );

 			ownerRow.style.width = newWidth;
 			ownerRow.cells[0].style.width = newHeight;

			if (!callingObject.SetSize)
				return ResizeNotImplemented('SetSize');

 			callingObject.SetSize(newWidth,newHeight);
		}

	}
}

function ReleaseResizingResources()
{
	if (window.ResizeHeightEventHandler != null)
	{
		window.detachEvent('onresize', window.ResizeHeightEventHandler );
		window.ResizeHeightEventHandler = null;
		window.detachEvent('onunload', ReleaseResizingResources );
	}
}

function ResizeHeight(oTable) 
{
	var minHeight		= 100;
	var clientHeight	= document.body.clientHeight;

	var absoluteYTop	= oTable.offsetTop;
	var oParent			= oTable.offsetParent;
	
	while(oParent.tagName.toUpperCase()!= 'BODY')
	{
		absoluteYTop	+= oParent.offsetTop;
		oParent			= oParent.offsetParent;
	}

	var absoluteYBottom = 10;

	var newHeight			= document.body.clientHeight - absoluteYTop - absoluteYBottom;
	oTable.style.posHeight	= (newHeight >= minHeight ? newHeight : minHeight);
}