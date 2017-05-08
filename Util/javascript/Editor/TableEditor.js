/*
 * TableEditor.js	- JavaScript support routines for EPiServer
 * Copyright (c) 2004 ElektroPost Stockholm AB
*/

if (!window.EditorScriptVersions)
	window.EditorScriptVersions = new Array();
window.EditorScriptVersions.push("TableEditor 7");

function tableHasFocus(id)
{
	var iframeObj	= eval(id + "_IFrameObj");
	var table		= iframeObj.tableEdit.table;
	if(table)
		return true;
	else
		return false;
}

function cellCanMerge(id)
{
	var iframeObj	= eval(id + "_IFrameObj");
	if (!iframeObj || !iframeObj.tableEdit)
		return false;
	return iframeObj.tableEdit.selectedCells.length > 1;
}

function cellCanSplitHorizontal(id)
{
	var currentCell = getCellToSplit(id);
	return currentCell && currentCell.colSpan > 1;
}

function cellCanSplitVertical(id)
{
	var currentCell = getCellToSplit(id);
	return currentCell && currentCell.rowSpan > 1;
}

function getCellToSplit(id)
{
	var iframeObj	= eval(id + "_IFrameObj");
	if (!iframeObj || !iframeObj.tableEdit)
		return null;
	var cells = iframeObj.tableEdit.selectedCells;
	if (cells && cells.length == 1)
		return cells[0];
	return iframeObj.tableEdit.lastActiveCell;
}

function insertTable(id, cols, rows, width, border)
{
	var table = '<table ';
	var row;

	if(width)
		table += ' width=' + width;
	if(border)
		table += ' border=' + border;
	table += ' border=' + border;
	table += '>';
	
	row = '<tr valign="top">';
	for(index=0;index<cols;index++)
		row += '<td></td>';
	row += '</tr>';
	
	for(index=0;index<rows;index++)
		table += row;
	table += '</table>';

	setSnippet(id, table);
}

function LaunchTableEditor(dialogURL, id)
{
	var returnValue = null;

	if (!window.NoGuiInteraction)
	{
		returnValue = OpenDialog(dialogURL, null, 250, 240);		
	}

	if (window.PreTableCreationFunction)
	{
		returnValue = window.PreTableCreationFunction(returnValue);
	}

	if (returnValue)
	{

		var cols	= returnValue[0];
		var rows	= returnValue[1];
		var border	= returnValue[2];
		var width	= returnValue[3];

		insertTable(id, cols, rows, width,border);

		var editorAPI = eval(id + "_IFrameObj").editorAPI;
		editorAPI.RefreshDesignElements();
	}
}

function GetSelectedCellsArea(cells)
{
	var minX = 999, minY = 999, maxX, maxY;

	for(var i = 0; i < cells.length; i++)
	{
		minX = Math.min(minX, cell.x);
		minY = Math.min(minY, cell.y);
		maxX = Math.max(maxX, cell.x);
		maxY = Math.max(maxY, cell.y);
	}
}

function CreateDefaultDialogArgs(editorID, customArgs)
{
	var dialogArgs	= new Array();

	dialogArgs[DLG_ARGS_PARENT_WINDOW]		= window;
	dialogArgs[DLG_ARGS_EDITOR_ID]			= editorID;	
	dialogArgs[DLG_ARGS_FONTCOLORLIST]		= GetActiveFontColorList();
	
	if (customArgs)
		dialogArgs[DLG_ARGS_CUSTOM_ARGS_BASE] = customArgs;
		
	return dialogArgs;
}

function LaunchTableCellProperties(dialogURL, id, insertImageURL)
{
	var editorAPI	= eval(id + "_IFrameObj").editorAPI;
	var cell		= editorAPI.lastActiveCell;
	var cells		= editorAPI.selectedCells;
	var table		= editorAPI.table;
	var cellArea	= editorAPI.GetSelectedCellsArea();
	var dialogArgs	= new Array();
	var props;
	var deselectCellsUponLeave = false;

	var arguments	= new Array();

	singleCell = (cells.length == 1 ? cells[0] : cell);
	if(cells.length > 1)
	{	// Multiple cells were selected
		// Create a list containing the values that are common to all the cells, and null values for the rest
		// First populate the arguments according to the first cell...			
		props = GetCellProperties(cells[0], insertImageURL);
			
		for(var c = 1; c < cells.length; c++) // ...then look through the remaining cells' attributes, and remove all that don't match
		{
			var currentProps = GetCellProperties(cells[c], insertImageURL);

			for(var i = props.list.length - 1; i >= 0; i--)
			{
				currentCellAttributeValue = currentProps.GetValue(props.GetKey(i));
				if(currentCellAttributeValue != props.GetValue(i))
					props.SetValue(i, MULTIPLE_VALUES); // Set a flag to indicate multiple cells have different values
			}
		}
		
		// The id attribute can never be set for more than one cell, make sure it is disabled in the dialog
		props.SetValue('id', MULTIPLE_VALUES);
	}
	else if(singleCell != null)
	{	// One table cell was selected (or the cursor is inside a cell) - send in the cell properties as arguments...
		// Set up the argument array, passing in all attribute values
		props = GetCellProperties(singleCell, insertImageURL);
		editorAPI.SelectCell(singleCell);
		deselectCellsUponLeave = true;
	}
	else
	{	// No cell was selected, do nothing...
		return;
	}

	props.SetValue('existing_axis', GetExistingAttributeValues(editorAPI.table, 'axis', ','));
	props.SetValue('existing_headers', GetExistingAttributeValues(editorAPI.table, 'id', ' '));

	var dialogArgs = CreateDefaultDialogArgs(id, props);
	var returnValue = OpenDialog(dialogURL, dialogArgs, 445, 425);

	if(!returnValue)
	{
		if (deselectCellsUponLeave)
			editorAPI.DeselectAllCells();
		return;
	}

	var sourceIndex = table.sourceIndex;

	// The props list contains the returned properties that applies for the selected cell(s)
	RebuildTable(editorAPI, table, props, props.GetValue('celltype'));

	editorAPI.editorDocument.selection.empty();
	editorAPI.ResetTable();
	editorAPI.ResetEditor();
	editorAPI.InitActiveTable(editorAPI.editorDocument.all(sourceIndex));
	
	if (deselectCellsUponLeave)
		editorAPI.DeselectAllCells();
	else
		editorAPI.SelectCells(cellArea.minX, cellArea.minY, cellArea.maxX, cellArea.maxY);
}

function LaunchTableProperties(dialogURL, id, insertImageURL)
{
	var iframeObj	= eval(id + "_IFrameObj");
	var table		= iframeObj.tableEdit.table;

	if (table)
	{	
		var dialogArgs = CreateDefaultDialogArgs(id, GetTableProperties(table, insertImageURL));
		var returnValue = OpenDialog(dialogURL, dialogArgs, 445, 425);
		
		if(!returnValue)
			return;

		SetTableProperties(table, returnValue[0]);
		iframeObj.tableEdit.RefreshDesignElements();
	}
}

function RebuildTable(editorAPI, table, props, newTagNameOfSelectedCells)
{
	// Rebuild html for entire table
	var newTableHtml = StartTagHtml(table);
	var selectedRegExp = new RegExp('(?:\\W|^)selected(?=\\W|$)', 'gi'); 
	
	// If the original table has a caption value, make sure it is transferred to the new table
	var captionText = GetCaptionValue(table);
	if (captionText && captionText != '')
		newTableHtml += '<caption>' + captionText + '</caption>';
	
	for (var i = 0; i < table.rows.length; i++)
	{
		var row = table.rows[i];
		if (!row.cells)
			continue;
			
		newTableHtml += StartTagHtml(row);
		for (var j = 0; j < row.cells.length; j ++)
		{
			var cell = row.cells[j];
			if (cell.className.search(selectedRegExp) != -1)
			{
				// Modify attributes for cell tags that were selected
				cell.className = cell.className.replace(selectedRegExp, '');

				if (newTagNameOfSelectedCells && newTagNameOfSelectedCells != MULTIPLE_VALUES)
					newTableHtml += StartTagHtmlCustomAttributes(cell, props, newTagNameOfSelectedCells) + 
									cell.innerHTML + '</' + newTagNameOfSelectedCells + '>';
				else
					newTableHtml += StartTagHtmlCustomAttributes(cell, props) + cell.innerHTML + EndTagHtml(cell);
			}
			else
			{
				// non-selected cells simply retain their old information
				newTableHtml += cell.outerHTML;
			}
		}
		newTableHtml += EndTagHtml(row);
	}
	newTableHtml += EndTagHtml(table);

	var sourceIndex = table.sourceIndex;

	// Setting outerHTML is an undo-friendly way to change this information
	table.outerHTML = newTableHtml;

	editorAPI.ReindexTable(editorAPI.editorDocument.all(sourceIndex), true);
}

function StartTagHtmlCustomAttributes(object, props, newTagName)
{
	var html = '<' + (newTagName ? newTagName : object.tagName);
	
	for (var i = 0; i < object.attributes.length; i++)
	{
		var attribute = object.attributes[i];
		var attributeIsSet = false;
		
		if (props)
		{
			for (var index = 0; index < props.list.length; index++)
			{
				if (props.GetKey(index).toLowerCase() == attribute.nodeName.toLowerCase())
				{
					var propValue = props.GetValue(index);
					if (propValue != null && propValue != MULTIPLE_VALUES)
						html += ' ' + attribute.nodeName + '="' + propValue + '"';
					// Set the flag only if multiple values are not conflicting
					attributeIsSet = (propValue != MULTIPLE_VALUES); 
					break;
				}
			}
		}
		
		if (attributeIsSet || !attribute.specified || !attribute.nodeValue)
			continue;
		html += ' ' + attribute.nodeName + '="' + attribute.nodeValue + '"';
	}

	if (object.style)
	{
		html += ' style="' + object.style.cssText + '"';
	}
	
	return html + '>';
}

function StartTagHtml(object)
{
	var html = '<' + object.tagName;
	
	for (var i = 0; i < object.attributes.length; i++)
	{
		var attribute = object.attributes[i];
		if (!attribute.specified || !attribute.nodeValue)
			continue;
		html += ' ' + attribute.nodeName + '="' + attribute.nodeValue + '"';
	}

	if (object.style)
	{
		html += ' style="' + object.style.cssText + '"';
	}
	
	return html + '>';
}

function EndTagHtml(object)
{
	return '</' + object.tagName + '>';
}
function GetExistingAttributeValues(table, attributeName, separatorChar)
{
	var cells = table.cells;
	var values = [];
	
	for(var i = cells.length - 1; i >= 0; i--)
	{
		var value = cells[i].getAttribute(attributeName);
		
		if (value)
		{
			if(separatorChar == null || value.indexOf(separatorChar) == -1)
			{	// Don't look for possible multi-value
				addToArray(values, value);
			}
			else 
			{	// The value consists of several values, separated by separatorChar
				var multipleValues = value.split(separatorChar);
				for(var j = 0; j < multipleValues.length; j++)
					addToArray(values, multipleValues[j]);
			}
		}
	}
	return values;
}
// Helper function to avoid inserting duplicates
function addToArray(valueArray, newValue)
{
	for(var i = 0; i < valueArray.length; i++)
		if(valueArray[i] == newValue)
			return;
	valueArray.push(newValue);
}

function GetElementProperties(attributes, requiredAttributes)
{
	var filteredClasses = [ CLASS_SELECTED, CLASS_SELECTABLE, CLASS_BORDERLESS, CLASS_ROWHEADER, CLASS_COLHEADER ];
	var props	= new List();
	
	// Collect all required attributes
	for (var i = requiredAttributes.length - 1; i >= 0; i--)
	{
		var attrName = requiredAttributes[i];
		var attr = attributes[attrName];
		var attrValue = null;
		if (attr && attr.specified)
		{
			attrValue = attr.nodeValue;
			
			// Special handling of class - remove special classes
			if (attrName == 'class')
			{
				var found;
				var valueArray = attrValue.split(' ');	// Get all class names into array
				
				attrValue = null;
				for (var j = 0; j < valueArray.length; j ++)
				{
					if (valueArray[j].length == 0)
						continue;
						
					// Check if class name is present in the filteredClasses array
					found = false;
					for (var k = 0; k < filteredClasses.length; k ++)
					{
						if (valueArray[j] == filteredClasses[k])
						{
							found = true;
							break;
						}
					}
					
					// This class should not be filtered, add it back to attrValue
					if (!found)
					{
						if (attrValue)
							attrValue += ' ' + valueArray[j];
						else
							attrValue = valueArray[j];
					}
				}
			}
		}
		
		props.SetValue(attrName, attrValue, 'attr');
	}
	
	// Get all remaining attributes
	for (var i = attributes.length -1; i >= 0; i--)
	{
		var attr = attributes[i];
		if (!attr.specified)
			continue;
		if (props.IndexOf(attr.nodeName) >= 0)
			continue;
			
		props.SetValue(attr.nodeName, attr.nodeValue, 'attr');
	}

	return props;
}

// Returns a List with cell properties
function GetCellProperties(cell, insertImageURL)
{
	var requiredAttributes = [	'align','vAlign','cellPadding','cellSpacing','width','height','border','borderColor',
						'borderColorLight','borderColorDark','bgColor','background','axis','headers','id', 'scope','class'];
	var props = GetElementProperties(cell.attributes, requiredAttributes);

	props.SetValue('insertImageURL', insertImageURL);	
	props.SetValue('celltype', cell.tagName.toLowerCase());
	
	return props;
}

// Returns a List with table properties
function GetTableProperties(table, insertImageURL)
{
	var requiredAttributes	= [	'align','cellPadding','cellSpacing','width','height','border','borderColor',
						'borderColorLight','borderColorDark','bgColor','background','summary', 'class'];
	var tableProps	= GetElementProperties(table.attributes, requiredAttributes);
	
	// Find table caption, if any
	var captionvalue = GetCaptionValue(table);
			
	// Add non-attribute info
	tableProps.SetValue('insertImageURL', insertImageURL);	
	tableProps.SetValue('caption', captionvalue);

	return tableProps;
}

function GetCaptionValue(table)
{
	var children = table.children;
	for(var i = 0; i < children.length; i++)
		if (children[i].tagName.toLowerCase() == 'caption')
			return children[i].innerText;
	return '';
}

function SetTableProperties(table, tableProps)
{
	var tableAttributes = '';
	var newCaptionString = '';
	var captionText = tableProps.GetValue('caption');
	var innerHTML = table.innerHTML;

	// Callback-func for the IterateValuesByCategory calls
	function SetTableProperty(tableProp)
	{
		if (tableProp.value)
			tableAttributes += tableProp.key + '="' + tableProp.value + '" ';
	}
		
	// Fill tableAttributes with the html for all table attributes
	tableProps.IterateValuesByCategory('attr', SetTableProperty);
	
	if (captionText && captionText != '')
		newCaptionString = '<caption>' + captionText + '</caption>';

	innerHTML = newCaptionString + innerHTML.replace(/<caption>.*?>/gi,'');

	table.outerHTML = '<table ' + tableAttributes + '>' + innerHTML + '</table>';		
}

