/*
 * SelectTools.js	- JavaScript support routines for EPiServer
 * Copyright (c) 2004 ElektroPost Stockholm AB
*/

if (!window.EditorScriptVersions)
	window.EditorScriptVersions = new Array();
window.EditorScriptVersions.push("SelectTools 1");

/*****************/
/* Table Section */
/*****************/
function selectTable(id)
{
	var iframeObj = eval(id + "_IFrameObj");
	iframeObj.tableEdit.SelectEntireTable();
}

function selectTableCell(id)
{
	var iframeObj	= eval(id + "_IFrameObj");
	var cell		= iframeObj.tableEdit.lastActiveCell;

	iframeObj.tableEdit.DeselectAllCells();

	// Check that we have a cell context. Right-clicking on table borders may give no cell.
	if(!cell)
		return;

	iframeObj.tableEdit.SelectCellsUsingNoKeys(cell);
}

function selectTableRow(id)
{
	var iframeObj	= eval(id + "_IFrameObj");
	var cell		= iframeObj.tableEdit.lastActiveCell;

	iframeObj.tableEdit.DeselectAllCells();

	// Check that we have a cell context. Right-clicking on table borders may give no cell.
	if(!cell)
		return;
	
	iframeObj.tableEdit.SelectRow(cell.y);
}

function selectTableColumn(id)
{
	var iframeObj	= eval(id + "_IFrameObj");
	var cell		= iframeObj.tableEdit.lastActiveCell;

	iframeObj.tableEdit.DeselectAllCells();

	// Check that we have a cell context. Right-clicking on table borders may give no cell.
	if(!cell)
		return;

	iframeObj.tableEdit.SelectColumns(cell.x, cell.x);
}


/*******************/
/* General Section */
/*******************/
// Helper function, returning a text range from the current selection, even if it is a control
function getTextRangeFromSelection(id)
{
	var range;
	var iframeObj = eval(id + "_IFrameObj");
	var selection = iframeObj.tableEdit.editorDocument.selection;
	
	if(selection.type == 'Control')
	{
		range = iframeObj.tableEdit.editorDocument.body.createTextRange();
		var controls = selection.createRange();
		range.moveToElementText(controls(0));
	}
	else
		range = selection.createRange();
		
	return range;
}

// Selects all editor content
function selectAll(id)
{
	var iframeObj	= eval(id + "_IFrameObj");

	// Code duplicated (with minor changes) from TableEdit.js, TableEdit.prototype.HandleKeydownEvent for Ctrl+A.
	var fullRange = iframeObj.tableEdit.editorDocument.body.createTextRange();
	fullRange.moveToElementText( iframeObj.tableEdit.editorDocument.body );
	fullRange.select();
	iframeObj.tableEdit.DeselectAllCells();
}

// Expands the current selection (or cursor position) to the closest surrounding tag.
function selectionExpand(id)
{
	var currentRange	= getTextRangeFromSelection(id);
	var parent			= currentRange.parentElement();

	if(parent == null)
		return;

	var parentRange = currentRange.duplicate();
	parentRange.moveToElementText(parent);

	// Check if we already have the entire parent text selected - if so, expand another element
	// (unless the entire BODY-tag is selected, we cannot move outside that).
	while(parentRange.htmlText == currentRange.htmlText && parent.tagName.toUpperCase() != 'BODY')
	{
		var grandParent = parent.parentElement;	// NOTE: using the parentElement _property_, not the TextRange _method()_
		if(grandParent != null)
		{
			parent = grandParent;
			parentRange.moveToElementText(parent);
		}
		else
			break;
	}
	currentRange.moveToElementText(parent);
	currentRange.select();
}

// Contracts the current selection to the first tag inside the current selection.
function selectionContract(id)
{
	var iframeObj		= eval(id + "_IFrameObj");
	var currentRange	= getTextRangeFromSelection(id);
	var parent			= currentRange.parentElement();

	if(parent == null)
		return;
		
	var tempRange	= iframeObj.tableEdit.editorDocument.body.createTextRange();
	var children	= parent.children;

	// Make this search recursive to avoid missing "grandchildren" tags that are enclosed in the current range.
	// Example: text (SEL START)text <b>text <i>text</i> text(SEL END) text</b> text text
	// In the above example, the italic text will not be found/selected...
	for(i = 0; i < children.length; i++)
	{
		tempRange.moveToElementText(children(i));
		// If the child's range is within the current selection range, we have found our target.
		if(currentRange.inRange(tempRange))
		{
			tempRange.select();
			return;
		}
	}
	
	// We found no tags that were enclosed in the current selection. Collapse the selection into an insertion point.
	// (NOTE: This search method will miss "grandchildren" tags that are enclosed in the current selection.)
	currentRange.collapse(false);
	currentRange.select();
	return;
}

// Moves the selection to the next or previous "sibling" element/tag within the current tag.
// Repeated calls cycle through all tags inside the context tag.
function selectSibling(id, direction)
{
	var iframeObj		= eval(id + "_IFrameObj");
	var currentRange	= getTextRangeFromSelection(id);
	var parent			= currentRange.parentElement();

	if(parent == null)
		return;
	
	var tempRange = iframeObj.tableEdit.editorDocument.body.createTextRange();
	tempRange.moveToElementText(parent);
	
	// Expand the parent element and range if needed, to get past IE's interpretation of <i><b>double tags</b></i>
	while(tempRange.htmlText == currentRange.htmlText && parent.tagName.toUpperCase() != 'BODY')
	{
		var grandParent = parent.parentElement;	// NOTE: using the parentElement _property_, not the TextRange _method()_
		if(grandParent != null)
		{
			parent = grandParent;
			tempRange.moveToElementText(parent);
		}
		else
			break;
	}

	var children = parent.children;

	if(children.length == 0)
	{
		// No tags are enclosed in the current selection (or parent element of the cursor position). 
		// Select the parent element, to be able to start from insertion point and move forward/backward.
		tempRange.select();
		return;
	}
	else
	{
		var searchRange	= iframeObj.tableEdit.editorDocument.body.createTextRange();

		if(direction == 'prev')
		{	// Perform a backward search for the child elements, set up the search range accordingly
			// The search range starts at the start of the parent element and ends at the beginning of the current selection.
			searchRange.setEndPoint('StartToStart', tempRange);
			searchRange.setEndPoint('EndToStart', currentRange);

			for(var j = children.length - 1; j >= 0; j--)
			{
				tempRange.moveToElementText(children(j));
				if(searchRange.inRange(tempRange))
				{	// The child's range is within the current selection range, we have found a match
					tempRange.select();
					return;
				}
				else if(j == 0)
				{	// We have reached the start of the element collection, and no element has been selected.
					// Reset the search range to the entire parent element, to be able to cycle through the tags in it.
					// Also reset the loop variable i to start over... (children.length because of the decrease)
					searchRange.moveToElementText(parent);
					j = children.length;
				}
			}
		}
		else
		{	// Perform a forward search for the child elements, set up the search range accordingly
			// The search range starts at the end of the current selection and encompasses the rest of the parent element.
			searchRange.setEndPoint('StartToEnd', currentRange);
			searchRange.setEndPoint('EndToEnd', tempRange);

			for(var i = 0; i < children.length; i++)
			{
				tempRange.moveToElementText(children(i));
				if(searchRange.inRange(tempRange))
				{	// The child's range is within the current selection range, we have found a match
					tempRange.select();
					return;
				}
				else if(i == children.length - 1)
				{	// We have reached the end of the element collection, and no element has been selected.
					// Reset the search range to the entire parent element, to be able to cycle through the tags in it.
					// Also reset the loop variable i to start over... (-1 because of the increase)
					searchRange.moveToElementText(parent);
					i = -1;
				}
			}
		}
	}	
	return;
}

// Selects the P or DIV that encloses the current cursor position or selection.
function selectSection(id)
{
	var currentRange	= getTextRangeFromSelection(id);
	var parent			= currentRange.parentElement();

	if(parent == null)
		return;

	var parentRange = currentRange.duplicate();
	parentRange.moveToElementText(parent);

	// Keep expanding from the current cursor position or selection until we find a P or DIV.	
	while(parent.tagName.toUpperCase() != 'P' && parent.tagName.toUpperCase() != 'DIV')
	{
		// Stop if we encounter the BODY tag, and don't create a selection...
		if(parent.tagName.toUpperCase() == 'BODY')
			return;
		var grandParent = parent.parentElement;	// NOTE: using the parentElement _property_, not the TextRange _method()_
		if(grandParent != null)
			parent = grandParent;
		else
			break;
	}
	currentRange.moveToElementText(parent);
	currentRange.select();
}
