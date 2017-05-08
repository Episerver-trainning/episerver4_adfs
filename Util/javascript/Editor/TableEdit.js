/*
 * TableEdit.js	- JavaScript support routines for EPiServer HtmlEditor
 * Copyright (c) 2005 ElektroPost Stockholm AB
 */

if (!window.EditorScriptVersions)
	window.EditorScriptVersions = new Array();
window.EditorScriptVersions.push("TableEdit 17");

// TableOperations constructor
function TableOperations()
{
	if (TableOperations.caller == null)
		return;

	this.ResetTable();
}

Object.prototype.IsArray = function() 
{
	return this.constructor == Array;
}

Array.prototype.Contains = function (obj)
{
	var index;

	for(index = 0; index < this.length; index++)
		if (this[index] == obj)
			return true;				

	return false;
}

TableOperations.prototype.ResetTable = function()
{
	this.table = null;
	this.selectionStartCell = null;
	this.selectedCells = [];
	this.lastActiveCell = null;
}

TableOperations.prototype.AddClass = function (source, className)
{
	var classes = source.className.split(" ");
	
	if (!classes.Contains(className))
	{
		classes.push(className);
		source.className = classes.join(" ");
	}
}

TableOperations.prototype.RemoveClass = function (source, className)
{
	if(source.className == null)
		return;
	var index;
	var oldClasses = source.className.split(" ");
	var newClasses = new Array();

	for(index = 0; index < oldClasses.length; index++)				
		if (oldClasses[index] != className)
			newClasses.push(oldClasses[index]);

	if (newClasses.length > 1)			
		source.className = newClasses.join(" ");
	else if (newClasses.length == 1 && newClasses[0].length > 0)
		source.className = newClasses[0];
	else
		source.removeAttribute("className");
}

TableOperations.prototype.DeselectCell = function (cell)
{
	this.RemoveClass(cell, CLASS_SELECTED);
}

TableOperations.prototype.IsSelected = function (source)
{
	return source.className.split(" ").Contains(CLASS_SELECTED);
}

TableOperations.prototype.DeselectAllCellsExcept = function (ignoreCells)
{
	if (this.selectedCells.length > 0 && ignoreCells.length > 0)
	{
		var keepSelected = new Array();
		var index;
		var cell;
		
		for(index = 0; index < this.selectedCells.length; index++)
		{
			cell = this.selectedCells[index];
			
			if (ignoreCells.Contains(cell))
			{
				keepSelected.push(cell);				
			}
			else
			{
				this.RemoveClass(cell, CLASS_SELECTED);
			}
		}
		this.selectedCells = keepSelected;
	}	
}

TableOperations.prototype.DeselectAllCells = function ()
{		
	if (this.selectedCells.length > 0)
	{
		var index;
		for(index = 0; index < this.selectedCells.length; index++)	
			this.RemoveClass(this.selectedCells[index], CLASS_SELECTED);

		this.selectedCells = new Array();
	}
}

TableOperations.prototype.SelectCell = function (cell)
{
	if (!this.IsSelected(cell))
	{	
		this.AddClass(cell, CLASS_SELECTED);
		this.selectedCells.push(cell);
	}
}

TableOperations.prototype.SelectCellByXY = function(cellX, cellY)
{
	var cell = this.GetCellAtXY(cellX, cellY);

	if (cell)
		this.SelectCell(cell);
	else
	{
		var offset;

		// Go up to see if this cell is part of a rowSpan
		for(offset = 1; offset < (cellY + 1) && !cell; offset++)
			cell = this.GetCellAtXY(cellX, cellY - offset);

		if (cell && cell.rowSpan >= offset)
			this.SelectCell(cell);
		else
		{
			// Go left to see if this cell is part of a colSpan
			cell = null;
			
			for(offset = 1; offset < (cellY + 1) && !cell; offset++)
				cell = this.GetCellAtXY(cellX - offset, cellY);

			if (cell && cell.colSpan >= offset)
				this.SelectCell(cell);
		}
	}
}

TableOperations.prototype.HasValidDesignTimeInfo = function (table)
{
	var cells = table.cells;

	if (cells && cells.length > 0)
	{
		var cellIndex;
		var cell;
		
		for(cellIndex = cells.length - 1; cellIndex >= 0; cellIndex--) 
		{
			cell = cells[cellIndex];
			
			if (!cell.y || !cell.x || cell.y.constructor != Number || cell.x.constructor != Number)
				return false;
		}
	}

	return true;
}

// Check if a table has valid design time info. If no table is provided, the active table is checked, if any.
// This function should be called before working with the x,y-properties on cells, to ensure that they are
// numeric (all x,y-logic is optimized for numbers).
// One situation when a table's x,y-properties become strings are when a table is copied and pasted into the editor.
// IE's paste operation converts numeric properties to strings.
TableOperations.prototype.ValidateDesignTimeInfo = function (table)
{
	if (!table)
		table = this.table;
		
	if (!this.HasValidDesignTimeInfo(table))
		this.ReindexTable(table, true);
}

TableOperations.prototype.GetSelectedCellsArea = function ()
{
	var minX = 999;
	var minY = 999;
	var maxX; 
	var maxY;
	var cell;
	var cells = this.selectedCells;
	var cellArea = new Object();

	for(var i = cells.length - 1; i >= 0; i--)
	{
		cell = cells[i];
		minX = Math.min(minX, cell.x);
		minY = Math.min(minY, cell.y);
		maxX = Math.max(maxX, cell.x);
		maxY = Math.max(maxY, cell.y);
	}

	cellArea.minX = minX;
	cellArea.minY = minY;
	cellArea.maxX = maxX;
	cellArea.maxY = maxY;

	return cellArea;	
}

// Select all cells within the area defined by the cell and row indexes
TableOperations.prototype.SelectCells = function (cellX1, cellY1, cellX2, cellY2)
{
	this.editorDocument.selection.empty();				
	this.ValidateDesignTimeInfo();

	var firstCell	= this.GetCellAtXY(cellX1, cellY1);
	var secondCell	= this.GetCellAtXY(cellX2, cellY2);

	var startY	= Math.min(cellY1, cellY2);
	var startX	= Math.min(cellX1, cellX2);
	var stopY;
	var stopX;
	var cellX;
	var cellY;

	if (firstCell != null && secondCell != null)
	{
		stopY	= Math.max(firstCell.y + firstCell.rowSpan - 1, secondCell.y + secondCell.rowSpan - 1);
		stopX	= Math.max(firstCell.x + firstCell.colSpan - 1, secondCell.x + secondCell.colSpan - 1);
	}
	else
	{
		stopY	= Math.max(cellY1, cellY2);
		stopX	= Math.max(cellX1, cellX2);
	}

	for(cellY = startY; cellY <= stopY; cellY++)
		for(cellX = startX; cellX <= stopX; cellX++)
			this.SelectCellByXY(cellX, cellY);
}

TableOperations.prototype.SelectColumns = function (cellIndex1, cellIndex2)
{
	var startCellIndex = Math.min(cellIndex1, cellIndex2);
	var stopCellIndex = Math.max(cellIndex1, cellIndex2);
	var maxCellY = this.GetMaxCellY();
	var cellY;
	var cellX;

	this.editorDocument.selection.empty();
	this.ValidateDesignTimeInfo();
	
	for(cellY = 0; cellY <= maxCellY; cellY++)
		for(cellX = startCellIndex; cellX <= stopCellIndex; cellX++)
			this.SelectCellByXY(cellX, cellY);
}

TableOperations.prototype.SelectRows = function (cellY1, cellY2)
{
	this.SelectCells(0, cellY1, this.GetMaxCellX(), cellY2);	
}

TableOperations.prototype.SelectRow = function (rowIndex)
{
	var cellIndex;
	var cellsCount = this.GetMaxCellX();

	for(cellIndex = 0; cellIndex < cellsCount; cellIndex++)
		this.SelectCellByXY(cellIndex, rowIndex);
}

// Refresh design elements without affecting the undo stack
TableOperations.prototype.RefreshDesignElements = function()
{
	this.RemoveDesignElements();
	this.AddTableDesignElements();
}

TableOperations.prototype.InsertCellAt = function(row, cellIndex)
{
	var cell = row.insertCell(cellIndex);
	cell.className = CLASS_SELECTABLE;
	return cell;
}

TableOperations.prototype.RemoveDesignElementsFromCell = function(cell)
{
	this.RemoveClass(cell, CLASS_SELECTABLE);
	this.RemoveClass(cell, CLASS_SELECTED);
	cell.removeAttribute("y");
	cell.removeAttribute("x");	
}

TableOperations.prototype.TrimContents = function()
{
	var content = this.editorDocument.body.innerHTML;

	if (content == '<P>&nbsp;</P>' || content == '<DIV>&nbsp;</DIV>')
	{
		content = '';
	} 
	else if (this.editorDocument.body.innerText.length == 0)
	{
		// Special check needed because there may be empty A tags cluttering the code (bug 30185)
		var i;
		var tagName;
		var all = this.editorDocument.body.all;
		var isEmpty = true;
		for (i = 0; i < all.length; i ++)
		{
			tagName = all(i).tagName;
			if (tagName != 'P' && tagName != 'DIV' && tagName != 'SPAN' && tagName != 'A')
			{
				isEmpty = false;
				break;
			}
		}
		if (isEmpty)
			content = '';
	}

	return content;
}

// Fast check to see if contents needs repairing. If yes, RepairContent() does actual repairing.
TableOperations.prototype.NeedsRepairing = function(content, repairForDesignMode)
{
	var tagsRegExp = ALL_IMG_AND_A_TAGS_REGEXP;
	var urlWithQuotesRegExp = URL_WITH_QUOTES_REGEXP;
	var urlWithNoQuotesRegExp = URL_WITH_NO_QUOTES_REGEXP;
	var hasZeroVspace = ZERO_VSPACE_REGEXP;
	var hasOrgvspace = ORGVSPACE_WITH_QUOTES_REGEXP;
	var parts;
	var tag;

	while ((parts = tagsRegExp.exec(content)) != null)
	{
		tag = parts[0];
		urlParts = urlWithQuotesRegExp.exec(tag);

		if (urlParts != null)
			url = urlParts[QUOTES_INDEX] + urlParts[ATTRIB_VALUE_INDEX] + urlParts[QUOTES_INDEX];
		else
		{
			urlParts = urlWithNoQuotesRegExp.exec(tag);

			if (urlParts != null)
				url = urlParts[URL_INDEX];
			else
				url = null;
		}

		if (url != null && tag.indexOf("orgurl=" + url) == -1)
		{
			// orgurl does not match with url, so url needs to get repaired
			return true;
		}
		
		if (repairForDesignMode)
		{
			// Check for vspace=0 (workaround for strange IE behavior that removes any "vspace=0" expression)
			if (hasZeroVspace.exec(tag) != null)
			{
				return true;
			}
		}
		else 
		{
			if (hasOrgvspace.test(tag))
				return true;
		}
	}

	return false;
}

// Repair editor contents and do the following:
// Add orgurl to IMG and A tags that do not have it.
// Add empty alt attribute to IMG tags that have no alt attribute.
// Note; this function works with the html as text (not element objects) and is designed to 
// be called from both design and html modes.
TableOperations.prototype.RepairContent = function(content, repairForDesignMode)
{
	var tagsRegExp = ALL_IMG_AND_A_TAGS_REGEXP;
	var hasOrgurl = ALL_ORGURLS_REGEXP;
	var hasAlt = HAS_ALT_REGEXP;
	var isImg = IS_IMG_REGEXP;
	var nullOrgUrl = ALL_NULL_ORGURLS_REGEXP;
	var urlWithQuotesRegExp = URL_WITH_QUOTES_REGEXP;
	var urlWithNoQuotesRegExp = URL_WITH_NO_QUOTES_REGEXP;
	var orgurlWithQuotesRegExp = ORGURL_WITH_QUOTES_REGEXP;
	var orgurlWithNoQuotesRegExp = ORGURL_WITH_NO_QUOTES_REGEXP;
	var hasZeroVspace = ZERO_VSPACE_REGEXP;
	var orgvspaceWithQuotesRegExp = ORGVSPACE_WITH_QUOTES_REGEXP;
	var hasVspace = HAS_VSPACE_REGEXP;
	var urlParts;
	var foundNullOrgurl;
	var originalTag;
	var tag;
	var url;
	var urlHasQuotes;
	var orgurlHasQuotes;
	var orgurl;
	var orgvspace;
	var content;
	var newContent;
	var replaceTag = false;

	newContent = content;

	// Reset regexp for new search
	tagsRegExp.exec("");

    while ((parts = tagsRegExp.exec(content)) != null)
    {
		originalTag = parts[0];
		tag = originalTag;

		foundNullOrgurl = nullOrgUrl.exec(tag);
		if (foundNullOrgurl != null)
			tag = tag.replace(foundNullOrgurl[0], "");
		// Extract url
		if ((urlParts = urlWithQuotesRegExp.exec(tag)) != null)
		{
			url = urlParts[QUOTES_INDEX] + urlParts[ATTRIB_VALUE_INDEX] + urlParts[QUOTES_INDEX];
			urlHasQuotes = true;
		}
		else if ((urlParts = urlWithNoQuotesRegExp.exec(tag)) != null)
		{
			url = urlParts[URL_INDEX];
			urlHasQuotes = false;
		}
		else
			url = null;

		// Extract orgurl
		if ((urlParts = orgurlWithQuotesRegExp.exec(tag)) != null)
		{
			orgurl = urlParts[QUOTES_INDEX] + urlParts[ATTRIB_VALUE_INDEX] + urlParts[QUOTES_INDEX];
			orgurlHasQuotes = true;

			if (!this.UseOldOrgurlLogic)
			{
				if (!repairForDesignMode)
				{
					tag = tag.replace(orgurlWithQuotesRegExp, '');
					replaceTag = true;		
				}
			}
		}
		else if ((urlParts = orgurlWithNoQuotesRegExp.exec(tag)) != null)
		{
			orgurl = urlParts[URL_INDEX];
			orgurlHasQuotes = false;

			if (!this.UseOldOrgurlLogic)
			{
				if (!repairForDesignMode)
				{
					tag = tag.replace(orgurlWithNoQuotesRegExp, '');
					replaceTag = true;		
				}
			}
		}
		else
			orgurl = null;

		if (orgurl != null)
		{
			// Tag has orgurl. Check if url matches. 
			if (orgurl != url)
			{
				tag = tag.replace(url, orgurl);
				replaceTag = true;		
			}
		}
		else if (url != null)
		{
			// Tag has no orgurl, so create one
			replaceTag = true;

			if (urlHasQuotes)
				tag = tag.replace(url, url + " orgurl=" + url);
			else
				tag = tag.replace(url, "\"" + url + "\" orgurl=\"" + url + "\"");
		}

		// Add empty alt attribute on decorative images
		if (isImg.test(tag) && !hasAlt.test(tag))
		{
			// replace '<img' with "<img alt=""'
			tag = '<img alt=""' + tag.substr(4);
			replaceTag = true;
		}

		if (repairForDesignMode)
		{
			if ((parts = hasZeroVspace.exec(tag)) != null)
			{
				// Replace any vspace=0 with orgvspace=0
				tag = tag.replace(parts[0], ' orgvspace="0"');
				replaceTag = true;
			}
		}
		else if ((parts = orgvspaceWithQuotesRegExp.exec(tag)) != null)
		{
			replaceTag = true;
			
			if (hasVspace.test(tag))
			{
				tag = tag.replace(orgvspaceWithQuotesRegExp,'');
			}
			else
			{
				var vspace = ' vspace=' + parts[QUOTES_INDEX] + parts[ATTRIB_VALUE_INDEX] + parts[QUOTES_INDEX];
				tag = tag.replace(orgvspaceWithQuotesRegExp,vspace);
			}
		}

		if (replaceTag)
		{
			newContent = newContent.replace(originalTag, tag);
			replaceTag = false;
		}
	}

	return newContent;
}

// This function makes sure that no references to old invalid elements are left behind, 
// otherwise IE will crash big time when referencing them.
TableOperations.prototype.ClearOldReferences = function()
{
	this.lastEvent.srcElement = null;
	this.lastActiveCell = null;
}

// Add attributes to improve design time visuals.
// Note: attribute changes do not affect the undo stack so this function is safe to
// call when handling mode switch from html to design caused by undo/redo.
TableOperations.prototype.AddTableDesignElements = function()
{
	var tables;
	var table;
	var tableIndex;

	tables = this.editorDocument.all.tags("TABLE");

	for(tableIndex = 0; tableIndex < tables.length; tableIndex++)
	{
		table = tables[tableIndex];		
		this.ReindexTable(table, true);
	}
}

// Clean up the Html from temporary design elements that the editor has added.
TableOperations.prototype.GetContentsWithoutDesignModeInformation = function()
{
	var contents = this.TrimContents();

	// Remove all "borderless" classes
	contents = contents.replace(/(<(TABLE|TD|TH)\s[^>]*class=\"[^\"]*\W)borderless\s*/gi, '$1');

	// Remove all "selected" and "selectable" classes
	contents = contents.replace(/(<(TABLE|TD|TH)\s[^>]*class=\"[^\"]*)selectable\s*/gi, '$1');
	contents = contents.replace(/(<(TD|TH)\s[^>]*class=\"[^\"]*)selected\s*/gi, '$1');

	// Remove all "colheader" and "rowheader" classes
	contents = contents.replace(/(<(TD|TH)\s[^>]*class=\"[^\"]*)colheader\s*/gi, '$1');
	contents = contents.replace(/(<(TD|TH)\s[^>]*class=\"[^\"]*)rowheader\s*/gi, '$1');

	// Remove all empty class attributes 
	contents = contents.replace(/(<(TABLE|TD|TH)[^>]*)(\s+class=\"\s*\")/g, '$1');
	
	// Remove all "y=... x=..." attributes from TD/TH
	contents = contents.replace(/(<(TD|TH)\s+[^>]*)y=\"\d+\"\s+x=\"\d+\"\s*/gi, '$1');

	// Remove any whitespace leftovers at the end of class-attributes
	contents = contents.replace(/(<(TABLE|TD|TH)+[^>]*\sclass="[^"]*)/gi, function($1){ return $1.RTrim();});

	// Remove any whitespace leftovers at the end of elements
	contents = contents.replace(/\s+(\/{0,1}>)/g, '$1');

	if (this.NeedsRepairing(contents))
	{
		return this.RepairContent(contents);
	}	

	return contents;
}

// Clean up the Html from temporary design elements that the editor has added.
// Note; this function does not affect the undo stack in any way, since it only modifies attributes.
TableOperations.prototype.RemoveDesignElements = function()
{
	var tables = this.editorDocument.all.tags("TABLE");
	var table;
	var row;
	var tableIndex;
	var rowIndex;
	var cellIndex;
	var cell;
	var cellCount;
	var index;
	var editorBody = this.editorDocument.body;

	for(tableIndex = 0; tableIndex < tables.length; tableIndex++)
	{
		table = tables[tableIndex];

		table.className = table.className.replace(REMOVE_TABLE_CLASSES_REGEXP, "");    
		if (table.className.length == 0)
			table.removeAttribute("className");

		cellCount = table.cells.length;
		for(cellIndex = 0; cellIndex < cellCount; cellIndex++)
		{
			cell = table.cells[cellIndex];
			if (cell.className)
			{
				cell.className = cell.className.replace(REMOVE_CELL_CLASSES_REGEXP, "");    
				if (cell.className.length == 0)
					cell.removeAttribute("className");
			}
			cell.removeAttribute("y");
			cell.removeAttribute("x");	
		}
	}
}

TableOperations.prototype.RememberRowSpan = function (rowspanArray, cellX, cellY, rowspanCount, colspanCount)
{
	var span = {x: cellX, maxX: cellX + colspanCount - 1, y: cellY, maxY: cellY + rowspanCount - 1};
	rowspanArray.push(span);
}

TableOperations.prototype.RowSpanExists = function(rowspanArray, cellX, cellY)
{
	var i;
	for (i = 0; i < rowspanArray.length; i ++)
	{
		var span = rowspanArray[i];
		if (span.x > cellX || span.maxX < cellX)
			continue;
		if (span.y <= cellY && span.maxY >= cellY)
			return true;
			
		if (span.maxY < cellY)
		{
			// remove current element - has no purpose any more
		}
	}
	
	return false;
}

// Adds x,y-spreadsheet coordinates and design-time classes to a table. Also repairs table if needed.
TableOperations.prototype.ReindexTable = function(table, addDesignElements)
{
	if((!table.border || table.border == 0) && (!table.className || !table.className.match(HAS_CLASS_BORDERLESS)))
		table.className += " " + CLASS_BORDERLESS;
	else if (!table.className.match(HAS_CLASS_SELECTABLE))
		table.className += " " + CLASS_SELECTABLE;

	var maxCellX = -1;

	var rowIndex;
	var cellIndex;
	var reindexDone;
	var rowspanArray;
	var triesLeft = 5;	// just a sanity thing (don't want to get stuck forever incase table is extremely corrupt)

	do
	{	
		reindexDone = true;
		rowspanArray = [];
		var cellY = 0;
		
		for (rowIndex = 0; rowIndex < table.rows.length; rowIndex ++)
		{
			var row		= table.rows(rowIndex);
			var cell	= null;
			var cellX	= 0;
			
			for (cellIndex = 0; cellIndex < row.cells.length; cellIndex ++)
			{
				cell			= row.cells(cellIndex);
				
				// If we have a rowspan on a previous row that expands to this position, skip this column
				while (this.RowSpanExists(rowspanArray, cellX, cellY))
					cellX ++;

				// If we have a rowspan on this column, make sure that we remember it
				if (cell.rowSpan > 1)
					this.RememberRowSpan(rowspanArray, cellX, cellY, cell.rowSpan, cell.colSpan);

				cell.setAttribute("y", cellY);
				cell.setAttribute("x", cellX);
		
				if (addDesignElements)
				{
					var className = cell.className.replace(HEADERS_AND_BORDERLESS_REGEXP,'');
				
					if (!className || !className.match(HAS_CLASS_SELECTABLE))
						className += " " + CLASS_SELECTABLE;

					if(cell.scope == 'row')
						className += " " + CLASS_ROWHEADER;
					else if(cell.scope == 'col')
						className += " " + CLASS_COLHEADER;
					
					if(table.border == 0)
						className += " " + CLASS_BORDERLESS;
					
					if (cell.className != className)
						cell.className = className;
				}
				
				// Take colspan into account when calculating the next cells X position
				if (cell.colSpan > 1)
					cellX += cell.colSpan;
				else
					cellX ++;
			}
			
			// Did we have any cells on that row?
			if (cell == null)
			{
				// The row is corrupt - there are no cells in it, so get rid of the row
				table.deleteRow(rowIndex);
				rowIndex --;
				continue;
			}

			// We may have a rowspan for the last column
			while (this.RowSpanExists(rowspanArray, cellX, cellY))
				cellX ++;
				
			if (maxCellX == -1)
			{
				maxCellX = cellX;
			}
			else if (cellX < maxCellX)
			{
				// The row was too short, increase colspan on last column to make the width add up
				cell.colSpan = cell.colSpan + (maxCellX - cellX);				
			}
			else if (cellX > maxCellX && maxCellX)
			{
				// The row broke past our previous max limit - restart reindex
				maxCellX = cellX;
				reindexDone = false;
				break;
			}
			
			// Move on to next row
			cellY ++;
		}
	} while (!reindexDone && --triesLeft > 0);
}

// Get the cell at the specified table x,y coordinates. If no cell is found null is returned.
// Both x and y are zero-based (first cell has coordinates 0,0).
TableOperations.prototype.GetCellAtXY = function (cellX, cellY, table)
{
	// Convert indexes to spreadsheet coordinates.
	// For example cellIndex 0,1 becomes A2 where A=column and 2=row.
	var spreadsheetCoordinates = String.fromCharCode(cellX + 65) + (cellY + 1);

	if (table)
		return table.cells(spreadsheetCoordinates);
	else
	{
		if (!this.table) ShowMsg('no table in GetCellAtXY, caller: ' + TableOperations.prototype.GetCellAtXY.caller);
		return this.table.cells(spreadsheetCoordinates);
	}
}

// Get the cell at the specified spreadsheet coordinates. If no cell is found, keep searching 
// to the left until a cell is found. If no cell can be found null is returned.
TableOperations.prototype.GetCellToLeft = function (cellX, cellY)
{	
	var cell = null;
	
	for(; cellX >= 0 && cell == null; cellX--)
		cell = this.GetCellAtXY(cellX, cellY);
	
	return cell;
}

// Return the cell whos colspan and rowspan "contains" the provided x,y coordinates.
TableOperations.prototype.GetCellWithinSpans = function (cellX, cellY)
{	
	var cell = null;
	var searchCellY;
	
	for(searchCellY = cellY;searchCellY >= 0; searchCellY--)
	{
		cell = this.GetCellToLeft(cellX, searchCellY);
		
		if (cell && (cellX < cell.x + cell.colSpan) && (cellY < cell.y + cell.rowSpan))
			break;
		else 
			cell = null;
	}

	return cell;
}

// Get maximum x coordinate for cells, for a single row or entire table. 
// Use current table if no table is passed in arguments.
// The maximum x coordinate is calculated by summings colspans for all cells in the row. 
// If no rowIndex is provided, the maximum x coordinate for the entire table is returned.
TableOperations.prototype.GetMaxCellX = function (table, rowIndex)
{
 	var cellIndex; 
 	var cells = null;
	var colSpanSum = 0;

	if (table == null)
		table = this.table;

	if (rowIndex == null)
	{
		var rows = table.rows;

		for(rowIndex = rows.length - 1; rowIndex >= 0; rowIndex--)
		{
			var colSpanSumCurrentRow = 0;

			cells = rows(rowIndex).cells;

			for(cellIndex = cells.length - 1; cellIndex >= 0; cellIndex--)
				colSpanSumCurrentRow += cells[cellIndex].colSpan;

			if (colSpanSum < colSpanSumCurrentRow)
				colSpanSum = colSpanSumCurrentRow;
		}
	}
	else
	{
 		if (table && table.rows.length > rowIndex)
 			cells = table.rows(rowIndex).cells;
		 	
		for(cellIndex = cells.length - 1; cellIndex >= 0; cellIndex--)
			colSpanSum += cells[cellIndex].colSpan;
	}
 	
	return colSpanSum - 1;
}

// Get maximum y coordinate for a column. 
// Use current table if no table is passed in arguments.
// The maximum y coordinate is obtained by calculating the number of rows in the column. 
TableOperations.prototype.GetMaxCellY = function (table, cellIndex)
{
 	var rowIndex; 
 	var rows = null;
 	var rowSpanSum = 0;

	if (!cellIndex)
		cellIndex = 0;

 	// Use current table if no table was passed in arguments.
	rows = (table != null) ? table.rows : this.table.rows;

	if (rows)
	{
		var rowSpan;
		
 		for(rowIndex = 0; rowIndex < rows.length; rowIndex += rowSpan)
 		{
 			var cells = rows[rowIndex].cells;
 			
 			if (cells.length > cellIndex)
 			{
	 			rowSpan = cells[cellIndex].rowSpan; 			
				rowSpanSum += rowSpan; 
			}
			else 
				rowSpan = 1;
		}
	}

 	return rowSpanSum - 1;
}

TableOperations.prototype.GetActiveCell = function()
{
	if (!this.lastActiveCell)
		return null;
		
	if (this.lastActiveCell.y)
		return this.lastActiveCell;

	var source = this.lastActiveCell;		
	while(source)
	{
		if (source.tagName.toUpperCase() == "TABLE")
			break;
		source = source.parentElement;	
	}
	if (!source)
		return null;
		
	this.ReindexTable( source, true );
	
	return this.lastActiveCell;
}

TableOperations.prototype.MergeCells = function ()
{
	this.ValidateDesignTimeInfo();

	if (this.selectedCells.length > 1)
		this.MergeSelectedCells();
}

TableOperations.prototype.SplitCellsHorizontally = function ()
{
	this.ValidateDesignTimeInfo();

	if (this.selectedCells.length > 1)
		this.SplitSelectedCells(this.selectedCells, SPLIT_HORIZONTALLY);
	else if (this.GetActiveCell())
		this.SplitSelectedCells([this.lastActiveCell], SPLIT_HORIZONTALLY);
}

TableOperations.prototype.SplitCellsVertically = function ()
{
	this.ValidateDesignTimeInfo();

	if (this.selectedCells.length > 1)
		this.SplitSelectedCells(this.selectedCells, SPLIT_VERTICALLY);
	else if (this.GetActiveCell())
		this.SplitSelectedCells([this.lastActiveCell], SPLIT_VERTICALLY);
}

TableOperations.prototype.DeleteRows = function ()
{
	this.ValidateDesignTimeInfo();

	if (this.selectedCells.length > 0)
		this.DeleteSelectedRows();
	else if (this.GetActiveCell())
		this.DeleteRow(this.lastActiveCell.parentElement.rowIndex);

	this.lastActiveCell = null; 	
		
	if (this.table)
		this.ReindexTable(this.table);		
}

TableOperations.prototype.DeleteColumns = function ()
{
	this.ValidateDesignTimeInfo();

	if (this.selectedCells.length > 0)
		this.DeleteSelectedColumns();
	else if (this.GetActiveCell())
		this.DeleteColumn(this.lastActiveCell.cellIndex);

	this.lastActiveCell = null; 

	if (this.table)
		this.ReindexTable(this.table);		
}

TableOperations.prototype.InsertColumnBefore = function ()
{
	this.ValidateDesignTimeInfo();

	if (this.GetActiveCell())
	{
		this.InsertColumn(this.lastActiveCell.x);
		this.lastActiveCell.focus();
		this.ReindexTable(this.table, true);		
	}
}

TableOperations.prototype.InsertColumnAfter = function ()
{
	this.ValidateDesignTimeInfo();

	if (this.GetActiveCell())
	{
		this.InsertColumn(this.lastActiveCell.x + this.lastActiveCell.colSpan);
		this.lastActiveCell.focus();
		this.ReindexTable(this.table, true);		
	}
}

TableOperations.prototype.InsertRowBefore = function ()
{
	this.ValidateDesignTimeInfo();

	if (this.GetActiveCell())
	{
		this.InsertRow(this.lastActiveCell.y);
		this.lastActiveCell.focus();
		this.ReindexTable(this.table, true);		
	}
}

TableOperations.prototype.InsertRowAfter = function ()
{
	this.ValidateDesignTimeInfo();

	if (this.GetActiveCell())
	{
		this.InsertRow(this.lastActiveCell.y + this.lastActiveCell.rowSpan);
		this.lastActiveCell.focus();
		this.ReindexTable(this.table, true);		
	}
}

TableOperations.prototype.SplitSelectedCells = function (cells, direction)
{
	var index;
	var cell;

	if (!direction)
		direction = SPLIT_HORIZONTALLY | SPLIT_VERTICALLY; 

	for(index = 0; index < cells.length; index++)
	{
		cell = cells[index];

		if ((direction & SPLIT_HORIZONTALLY) != 0)
				this.SplitColSpan(cell);

		if ((direction & SPLIT_VERTICALLY) != 0 && cell.rowSpan > 1)
			this.SplitRowSpan(cell);		
	}

	this.DeselectAllCells();
	this.ReindexTable(this.table, true);	
}

// Splitting a rowspan is a little more complicated than splitting a colspan. 
// Basically, cells need to be added at some cellIndex in the rows below current cell
// and a reliable cellIndex can only be retrieved using spreadsheet navigation.
TableOperations.prototype.SplitRowSpan = function (cell)
{
	var cellY			= cell.y + 1;
	var cellToLeft;
	var insertedCell;

	cell.rowSpan--;

	// Incase there is only one column we may have to add a row to the table.
	if (cellY > this.GetMaxCellY())
		this.InsertRow(-1);
	else
	{
		cellToLeft = this.GetCellToLeft(cell.x - 1, cellY);
 		
		if (cellToLeft)
			insertedCell = this.InsertCellAt(cellToLeft.parentElement, cellToLeft.cellIndex + 1);
		else
			insertedCell = this.InsertCellAt(this.table.rows[cellY], 0);
		
		insertedCell.colSpan = cell.colSpan;
	}
}

TableOperations.prototype.SplitColSpan = function (splitCell)
{
	var insertedCell;

	if (splitCell.colSpan > 1)
	{
		splitCell.colSpan--;	
		insertedCell = this.InsertCellAt(splitCell.parentElement, splitCell.cellIndex + 1);
		insertedCell.rowSpan = splitCell.rowSpan;
	}
	
//Excluded in 4.22
/*
	var maxCellX = this.GetMaxCellX();
	var maxCellY = this.GetMaxCellY();
	var columnX = splitCell.x;
	var cellY;
	var cell;

	if (splitCell.colSpan > 1)
		splitCell.colSpan--;
		
	insertedCell = this.InsertCellAt(splitCell.parentElement, splitCell.cellIndex + 1);
	insertedCell.rowSpan = splitCell.rowSpan;

	for(cellY = 0; cellY <= maxCellY; cellY += rowSpan)
	{
		cell = this.GetCellWithinSpans(columnX, cellY);
		rowSpan = cell.rowSpan;
		
		if (cell.y != splitCell.y)
			cell.colSpan++;
	}
*/
}

// Sortfunction for array.sort() operation in MergeSelectedCells().
// Sorts cells by y, x in ascending order.
// Returns -1 if cell A should be sorted before B, 1 if B should be sorted before A, 0 if equal.
TableOperations.prototype.SortSelectedCells = function (cellA, cellB)
{
	if (cellA.y < cellB.y)
		return -1;
	else if (cellA.y > cellB.y)
		return 1;
	else if (cellA.x < cellB.x) 
		return -1;
	else if (cellA.x > cellB.x) 
		return 1;
	else 
		return 0;
}

TableOperations.prototype.MergeSelectedCells = function ()
{
	var index;
	var cell;
	var row;
	var contents = [];
	var maxSelectedCellIndex = 0;
	var maxSelectedRowIndex = 0;

	this.selectedCells.sort(this.SortSelectedCells);

	for(index = 1; index < this.selectedCells.length; index++)
	{
		cell = this.selectedCells[index];
		contents.push(this.selectedCells[index].innerHTML);
		
		if (maxSelectedCellIndex < cell.x)
			maxSelectedCellIndex = cell.x;
		if (maxSelectedRowIndex < cell.y)
			maxSelectedRowIndex = cell.y;
		
		row = cell.parentElement;
		
		if (row.cells.length > 1)
			row.deleteCell(cell.cellIndex);	
		else
			row.parentElement.deleteRow(row.rowIndex);
	}
	
	cell = this.selectedCells[0];
	
	if (contents.length > 0)
		cell.innerHTML += "<br/>" + contents.join("<br/>");

	if (maxSelectedCellIndex > 0)
		cell.colSpan = maxSelectedCellIndex - cell.x + 1;

	if (maxSelectedRowIndex > 0)
		cell.rowSpan = maxSelectedRowIndex - cell.y + 1;

	this.DeselectAllCells();
	this.ClearOldReferences();
}

TableOperations.prototype.DeleteSelectedRows = function ()
{
//TODO: use spreadsheet navigation and adjust rowspan/colspan
	var minRowIndex = this.table.rows.length - 1;
	var maxRowIndex = 0;
	var index;
	var row;

	for(index = 0; index < this.selectedCells.length; index++)
	{
		row = this.selectedCells[index].parentElement;
		
		if (row.rowIndex < minRowIndex)
			minRowIndex = row.rowIndex;
		if (row.rowIndex > maxRowIndex)
			maxRowIndex = row.rowIndex;
	}		

	for(index = minRowIndex; index <= maxRowIndex; index++) 
		this.DeleteRow(minRowIndex);
		
	this.selectedCells = [];
}

// Undo stack-friendly table deletion
TableOperations.prototype.DeleteTable = function ()
{
	// Deselect cells first to make sure that the table is pushed to the undo stack without 
	// any selected cells, incase the user undoes the deletion.
	this.DeselectAllCells();

	var parent = this.table.parentElement;
	var range = this.editorDocument.body.createControlRange();
	range.addElement(this.table);
	this.ResetEditor();		
	range.execCommand("Delete");
	this.MoveCursorToElement(parent);
}

TableOperations.prototype.CopyTable = function ()
{
	// See comment about this call in DeleteTable above
	this.DeselectAllCells();
	
	var range = this.editorDocument.body.createControlRange();
	range.addElement(this.table);
	range.execCommand("Copy");	
	this.SelectEntireTable();
}

TableOperations.prototype.CutTable = function ()
{
	// See comment about this call in DeleteTable above
	this.DeselectAllCells();
	
	var parent = this.table.parentElement;
	var range = this.editorDocument.body.createControlRange();
	range.addElement(this.table);
	this.ResetEditor();
	range.execCommand("Cut");
	this.ClearOldReferences();
	this.MoveCursorToElement(parent);
}

TableOperations.prototype.MoveTable = function (destinationRange)
{
	this.CutTable();
	var parent = destinationRange.parentElement();
	destinationRange.execCommand("Paste");
	this.MoveCursorToElement(parent);
}

TableOperations.prototype.IsEntireTableSelected = function ()
{
	return this.table != null && this.selectedCells.length == this.table.cells.length;
}

TableOperations.prototype.DeleteRow = function (rowIndex)
{
//TODO: use spreadsheet navigation and adjust rowspan/colspan
	this.table.deleteRow(rowIndex);

	if (this.table.rows.length == 0)
		this.DeleteTable();

	this.ClearOldReferences();
}

TableOperations.prototype.DeleteSelectedColumns = function ()
{
//TODO: use spreadsheet navigation and adjust rowspan/colspan
	var minCellIndex = this.table.rows[0].cells.length - 1;
	var maxCellIndex = 0;
	var index;
	var cell;

	for(index = 0; index < this.selectedCells.length; index++)
	{
		cell = this.selectedCells[index];
		
		if (cell.cellIndex < minCellIndex)
			minCellIndex = cell.cellIndex;
		if (cell.cellIndex > maxCellIndex)
			maxCellIndex = cell.cellIndex;
	}		

	for(index = minCellIndex; index <= maxCellIndex; index++) 
		this.DeleteColumn(minCellIndex);
		
	this.selectedCells = [];
}

TableOperations.prototype.DeleteColumn = function (cellIndex)
{
//TODO: use spreadsheet navigation and adjust rowspan/colspan
	var rowIndex;
	var cellsCount = 0;
	
	for(rowIndex = 0; rowIndex < this.table.rows.length; rowIndex++)
	{
		this.table.rows[rowIndex].deleteCell(cellIndex);
		cellsCount += this.table.rows[rowIndex].cells.length;
	}

	if (cellsCount == 0)
		this.DeleteTable();

	this.ClearOldReferences();
}

// Insert a new column at column x position
TableOperations.prototype.InsertColumn = function (columnX)
{
	this.ValidateDesignTimeInfo();

	var maxCellX = this.GetMaxCellX();
	var maxCellY = this.GetMaxCellY();
	var cellY;
	var cell;
	var rows = this.table.rows;
	var rowSpan;
	var cellAddIndex;

	for(cellY = 0; cellY <= maxCellY; cellY += rowSpan)
	{
		if (columnX > maxCellX)
		{
			cell = rows[cellY].insertCell();
			rowSpan = 1;
		}
		else
		{
			cell = this.GetCellWithinSpans(columnX, cellY);
			rowSpan = cell.rowSpan;

			if (cell.x != columnX)
				cell.colSpan++;
			else
			{
				for(cellAddIndex = 0; cellAddIndex < rowSpan; cellAddIndex++)
				{
					cell = this.GetCellAtXY(columnX, cellY + cellAddIndex);
					cell.parentElement.insertCell(cell.cellIndex);
				}
			}
		}
	}
}

TableOperations.prototype.SetRowDefaultAttributes = function (row)
{
	row.vAlign = "top";
}

// Insert a new row at row y position
TableOperations.prototype.InsertRow = function (rowY)
{
	this.ValidateDesignTimeInfo();

	var maxCellX = this.GetMaxCellX();
	var maxCellY = this.GetMaxCellY();
	var cellX;
	var cell = null;
	var newRow = null;
	var cellWithMergedRows;

	if (!rowY)
		rowY = 0;

	if (rowY > maxCellY)
	{
		newRow = this.table.insertRow(-1);
		this.SetRowDefaultAttributes(newRow);
	}

	for(cellX = 0; cellX <= maxCellX; cellX += cell.colSpan)
	{
		cellWithMergedRows = false;

		if (rowY <= maxCellY)
		{
			cell = this.GetCellWithinSpans(cellX, rowY);
			if (cell && (cell.y < rowY) && (cell.rowSpan > 1) && (cell.y + cell.rowSpan > rowY))
				cellWithMergedRows = true;
		}

		if (cellWithMergedRows)
			cell.rowSpan++;
		else
		{
			if (newRow == null)
			{
				if (cell == null)
					newRow = this.table.insertRow(rowY);
				else
					newRow = this.table.insertRow(cell.parentElement.rowIndex);
				this.SetRowDefaultAttributes(newRow);
			}
				
			cell = newRow.insertCell();
		}
	}
}

// Find out in which cell the current element is located. Do this by traversing 
// upwards and check if any encountered cells belong to active table.
TableOperations.prototype.FindParentCell = function (source, table)
{	
	var cell = null;
	var parentTable;

	if (!table)
		table = this.table;
	
	do
	{
		if (source.tagName.search(/^(TD|TH)$/i) != -1)
		{
			parentTable = this.GetOwnerTable(source);
			
			if (parentTable == this.table)
			{
				cell = source;
				break;
			}
			
			source = parentTable;
		}
		source = source.parentElement;
	} while (source != null);

	return cell;
}

//---------------------------------------- Start of TableEdit class -----------------------------------


// Inherit TableOperations
TableEdit.prototype = new TableOperations;

// TableEdit constructor
function TableEdit(id, iframeObj,editable)
{
	this.constructor();
	this.Init(id, iframeObj,editable);
}

TableEdit.prototype.Init = function (id, iframeObj,editable)
{
	// Make sure the id string is correct format
	id = getId(id);
	
	this.table					= null;
	this.editor					= getEditor(id);
	this.editorDocument			= this.editor.document;
	this.editorID				= id;
    this.editorHiddenInput		= document.getElementById(this.editorID);
	
	this.editorState			= this.GetValue("State");
	    			
	this.editorArea				= this.GetValue("EditorArea");
	this.editorHtmlArea			= this.GetValue("EditorHtmlArea");
	this.editor.iconsDir		= this.GetValue("IconsDir");
	this.editor.menuID			= this.GetValue("Menu");
	this.ParagraphIsDiv			= parseInt(this.GetValue("ParagraphIsDiv")) == 1;
	this.image					= null;
	this.editable				= editable!=false;//handle undefined

	this.hotkeys				= new Array(256);
	
	// Uncomment to use the callback functions for performing actions after the menu is created
	//RegisterMenuCallbackFunction(this.editor.menuID, this.InitMenu);
}

TableEdit.prototype.Startup = function(iframeObj,editable)
{
	var content = this.editorHiddenInput.value;
	iframeObj.tableEdit = iframeObj.editorAPI;
	document.getElementById(this.editorID + 'TOOLBAR').style.display = 'block';
	document.getElementById(this.editorID + 'EDITOR').style.height = '100%';

	// Remember if the contents had orgurl-attributes or not (old pre-4.51-pages may have those).
	// When saving contents, orgurls will only be removed if there were no orgurls during loading.
	this.UseOldOrgurlLogic = ALL_ORGURLS_REGEXP.test(content);

	var repairForDesignMode = true;

	if (this.NeedsRepairing(content,repairForDesignMode))
	{	
		this.editorDocument.body.innerHTML = this.RepairContent(content,repairForDesignMode);
	}
	else
	{
		this.editorDocument.body.innerHTML = content;
	}

	this.editorDocument.body.contentEditable = editable;
	this.editorHtmlArea.style.height = iframeObj.height;
	this.editorHtmlArea.style.width = iframeObj.width;
	this.editorHtmlArea.style.display = 'none';
	this.editorHtmlArea.className = 'codeview';

	iframeObj.insertAdjacentElement("BeforeBegin",this.editorHtmlArea);
	
	this.OnEditorLoaded();

	eval(this.editorID + '_loadingMsg').style.display = 'none';
	this.editorArea.style.border = '';
	this.editorArea.children(0).style.visibility = 'visible';		
}

TableEdit.prototype.GetValue = function(name)
{
	var param = eval(this.editorID + '_' + name);
	
	// If the param is an object, try to return its value 
	return param.value ? param.value : param;
}

// InitMenu can be used as a callback function to initialize the editor's menu after it is created, register it from TableEdit.Init
/*
TableEdit.prototype.InitMenu = function ()
{
	eval("window." + this.editor.menuID).InitializeMenu();
}
*/

// The OnEditorLoaded is called when everything is setup (including the text in the editor body) and 
// just before the editor is ready to be used.
TableEdit.prototype.OnEditorLoaded = function ()
{
	this.RegisterStartupVersion();
	this.AddClass(this.editorDocument.body, "editmode");
	
	this.InitToolState();
	
	this.ResetEditor();
	if(this.editable)
	{	
		this.InitEventHandlers();
	}
	
	this.InitCommandIdentifierHandler();

	this.AddInstanceToEditorList();
	this.InitChangeDetection();
	this.InitSubmitHandler();
	
	// Switch to design mode, but skip checking if content needs to be repaired, since repairing has already
	// been done once during startup. Also, relative urls have already been changed by IE to absolute urls at
	// this point, so any repair checks against content with urls would always return true.
	var skipContentRefresh = true;
	this.SwitchToDesignMode(skipContentRefresh);

	this.startupHtml = this.GetContentsWithoutDesignModeInformation();
	this.RefreshAllTools();
	
	// Fix graphical glitch that occurs once in a while (invisible text in body)
	this.InitDelayedRefresh(false);	

	this.InitPostOnLoad();
}

TableEdit.prototype.InitPostOnLoad = function ()
{
	var thisObj = this;
	setTimeout(function() { thisObj.PostOnLoad(); },1)
}

// Routines that must execute after the page has loaded, but are sensitive to things
// such as rendering or ActiveX initialization issues, are executed in the editor's
// PostOnLoad method.
TableEdit.prototype.PostOnLoad = function ()
{
	// Call tool onload handlers, if any
	this.ExecuteToolOnLoadHandlers();
}

TableEdit.prototype.HandleGlobalClickEvent = function ()
{
	if (event.srcElement != null && event.srcElement.className == 'EPEdit-tabActive')
		this.InitDelayedRefresh();
}

TableEdit.prototype.InitDelayedRefresh = function (focusEditor)
{
	var thisObj = this;
	setTimeout(function() { thisObj.RefreshBody(focusEditor); },1)
}

// Force a refresh of the editor's GUI by doing a harmless visual change in the body
TableEdit.prototype.RefreshBody = function (focusEditor)
{
	var body = this.editorDocument.body;
	var oldMargin = body.style.margin;
	body.style.margin = (oldMargin == '0px' ? '1px' : '0px');
	body.style.margin = oldMargin;

	if (focusEditor)
	{
		try
		{
			body.focus();
		}
		catch(e){ }
	}

	// The editor may have focus but we do not want to leave the caret visible in the body, 
	// so get rid of it using the following call (works better than blur()).
	this.editorDocument.selection.empty();

	// Ensure that editor's scroll position is always at start of document
	this.editorDocument.parentWindow.scrollTo(0,0);
	
	body = null;
}

TableEdit.prototype.RegisterStartupVersion = function ()
{
	if (!window.EditorVersionNoted)
	{
		window.EditorVersionNoted = true;
		window.EditorScriptVersions.push('StartupScript ' + window.EditorStartupVersion);	
	}
}

TableEdit.prototype.DisplayError = function (errorObject, functionObject)
{	
	ShowMsg('Error: ' + errorObject.description + 
			'\n\n' + GetFunctionName(functionObject.arguments.callee) + 
			'\n       !' + 
			'\n' + GetFunctionName(functionObject.caller));
}

TableEdit.prototype.ResetEditor = function ()
{
	this.ClearActiveTableStatus();
	this.ResetLastEvent();
	this.hoverLocation			= HOVER_NONE;
	this.tableHovering			= false;
	this.resizeActive			= false;	
}

TableEdit.prototype.ResetLastEvent = function()
{
	this.lastEvent				= new Object();
	this.lastEvent.button		= -1;
	this.lastEvent.type			= "";
	this.lastEvent.clientX		= 0;
	this.lastEvent.clientY		= 0;	
}

TableEdit.prototype.ClearActiveTableStatus = function ()
{
	this.DeactivateMouseMoveHandler();
	this.DeselectAllCells();
	this.multiSelect			= MULTISELECT_NONE;
	this.lastCellCheckedInEvent = null;
	this.table					= null;
	this.selectionStartCell		= null;	
	this.lastActiveCell			= null;
}

TableEdit.prototype.InitEventHandlers = function (onlyMouseDown)
{
	var doc = this.editorDocument;
	var eventHandlerThis = this;

	// Encapsulate this-object and create local function objects to catch events.
	this.mouseEventHandler				= function (e) { eventHandlerThis.HandleEvent(e); }
	this.contextMenuEventHandler		= function (e) { eventHandlerThis.HandleContextMenuEvent(e);	}			
	this.controlSelectEventHandler		= function (e) { eventHandlerThis.HandleControlSelectEvent(e); }	
	this.selectionChangeEventHandler	= function (e) { eventHandlerThis.HandleSelectionChangeEvent(e); }	
	this.keydownEventHandler			= function (e) { eventHandlerThis.HandleKeydownEvent(e); }
	this.keyupEventHandler				= function (e) { eventHandlerThis.HandleKeyupEvent(e); }
	this.beforePasteEventHandler		= function (e) { eventHandlerThis.HandleBeforePasteEvent(e); }
	this.pasteEventHandler				= function (e) { eventHandlerThis.HandlePasteEvent(e); }
	this.globalClickEventHandler		= function (e) { eventHandlerThis.HandleGlobalClickEvent(e); }
	this.resizeEventHandler				= function (e) { eventHandlerThis.HandleResizeEvent(e); }
	
	// event handlers on editor's document
	doc.attachEvent("onmouseleave",			this.mouseEventHandler);
	doc.attachEvent("onmouseenter",			this.mouseEventHandler);
	doc.attachEvent("onmousedown",			this.mouseEventHandler);
	doc.attachEvent("onmouseup",			this.mouseEventHandler);
	doc.attachEvent("ondblclick",			this.mouseEventHandler);
	
	doc.attachEvent("oncontrolselect",		this.controlSelectEventHandler);
	doc.attachEvent("onselectionchange",	this.selectionChangeEventHandler);
	doc.attachEvent("onkeydown",			this.keydownEventHandler);
	doc.attachEvent("onkeyup",				this.keyupEventHandler);
	doc.body.attachEvent("onpaste",			this.pasteEventHandler);
	doc.body.attachEvent("onbeforepaste",	this.beforePasteEventHandler);
	doc.body.attachEvent("oncontextmenu",	this.contextMenuEventHandler);
	doc.body.attachEvent("onresizeend",		this.resizeEventHandler);

	document.attachEvent('onclick',			this.globalClickEventHandler);
}

TableEdit.prototype.RemoveEventHandlers = function ()
{
	var doc = this.editorDocument;

	if (this.mouseEventHandler)
	{	
		// touch this and die, IE is very sensitive about order here
		
		doc.onmouseleave = null;
		doc.onmouseenter = null;
		doc.onmousedown = null;
		doc.onmouseup = null;
		doc.ondblclick = null;

		doc.detachEvent("onmouseleave",			this.mouseEventHandler);
		doc.detachEvent("onmouseenter",			this.mouseEventHandler);
		doc.detachEvent("onmousedown",			this.mouseEventHandler);
		doc.detachEvent("onmouseup",			this.mouseEventHandler);
		doc.detachEvent("ondblclick",			this.mouseEventHandler);
		
		doc.oncontrolselect = null;
		doc.onselectionchange = null;
		doc.onkeydown = null;
		doc.onkeyup = null;
		doc.body.onpaste = null;
		doc.body.onbeforepaste = null;
		doc.body.oncontextmenu = null;
		doc.body.onresizeend = null;
		
		doc.detachEvent("oncontrolselect",		this.controlSelectEventHandler);
		doc.detachEvent("onselectionchange",	this.selectionChangeEventHandler);
		doc.detachEvent("onkeydown",			this.keydownEventHandler);
		doc.detachEvent("onkeyup",				this.keyupEventHandler);
		doc.body.detachEvent("onpaste",			this.pasteEventHandler);
		doc.body.detachEvent("onbeforepaste",	this.beforePasteEventHandler);
		doc.body.detachEvent("oncontextmenu",	this.contextMenuEventHandler);
		doc.body.detachEvent("onresizeend",		this.resizeEventHandler);
		
		document.detachEvent('onclick',			this.globalClickEventHandler);		
	}
	
	if (this.mouseMoveEventHandler)
		this.DeactivateMouseMoveHandler();
		
	this.CleanupTools();
}

// Add editor instance to editor list (first one to add itself creates the list).
// The list is used later for things such as change detection and pre-postback handling.
TableEdit.prototype.AddInstanceToEditorList = function()
{
	if (!window.editorList)
		window.editorList = new Array();		

	window.editorList.push(this);		
}

TableEdit.prototype.HandleSubmit = function(soureEvent) 
{
	var returnValue = false;
	var range = this.lastRange;

	try
	{
		saveData(this.editorID);
		
		// Call tool submit handlers, if any
		returnValue = this.ExecuteToolOnSubmitHandlers();

		if (returnValue)
			returnValue = this.defaultSubmit();
	}
	catch(e) 
	{ 
		// The defaultSubmit call fails if user clicks Cancel in the changes dialog, for some 
		// unknown reason. The error is non-fatal so we just ignore it.
	}	

	if (!returnValue && range)
	{
		range.scrollIntoView();
		range.select();		
	}

	return returnValue;
}

TableEdit.prototype.InitChangeDetection = function()
{
	if (window.RegisterToChangeDetection)
	{
		var eventHandlerThis = this;
		var changesHandler = function (e) { return eventHandlerThis.HasChanges(e); }
		window.RegisterToChangeDetection(changesHandler);
	}
}

TableEdit.prototype.InitSubmitHandler = function()
{
	var eventHandlerThis = this;

	// Register this editor instance to the window's submit event by overriding the submit() function for 
	// the form, to enable saving of editor contents.
	RegisterSubmitHandler(function (e) { return eventHandlerThis.HandleSubmit(e); });
}

// This function is executed by the leavePage() function in EditPageControl.ascx to check if any of the
// DHTML editors on this page have any changes.
TableEdit.prototype.HasChanges = function()
{
	var changesDetected = false;

	if (this.editorState.Mode == EDITORMODE_DESIGN)
	{
		var content = this.GetContentsWithoutDesignModeInformation();
		changesDetected = (this.startupHtml != content);
	}
	else if (this.editorState.Mode == EDITORMODE_HTML)
	{
		changesDetected = (this.startupHtml != this.editorHtmlArea.innerText);
	}

	return changesDetected;
}

// The onmousemove handler is only activated when needed.		
TableEdit.prototype.ActivateMouseMoveHandler = function()
{
	if (!this.mouseMoveEventHandler)
	{
		var eventHandlerThis = this;
		this.mouseMoveEventHandler = function (e) { eventHandlerThis.HandleMouseMove(e); }				
		this.editorDocument.attachEvent("onmousemove", this.mouseMoveEventHandler);
	}
}

// It is okay to call this function multiple times
TableEdit.prototype.DeactivateMouseMoveHandler = function()
{
	if (this.mouseMoveEventHandler)
	{
		this.editorDocument.detachEvent("onmousemove",	this.mouseMoveEventHandler);
		this.mouseMoveEventHandler	= null;
	}
}

TableEdit.prototype.InitToolState = function()
{
	var index;
	var toolState;
	var tools;
	
	var toolStateList = eval(this.editorID + "_ToolStateList");

	// Collect tools that are sensitive to selection change events in the following list.
	this.selectionSensitiveTools = [];

	for(index = 0; index < toolStateList.length; index++)
	{
		toolState = toolStateList[index];

		// Note, we fetch the tool object by name (instead of id) since tool elements (usually an IMG) 
		// are identified by name. Should some tools have an id instead of name it will find those aswell.
		var tools = document.getElementsByName(toolState[TOOLSTATE_KEY]);

		if (tools.length == 0)
		{
			document.write("InitToolState: can not find and initialize state for tool " + toolState[TOOLSTATE_KEY] + "<br>");	
			return;
		}

		// Store object over the ID for faster access next time.
		toolState[TOOLSTATE_KEY] = tools[0];

		this.InitSingleToolState(index,
								 toolState[TOOLSTATE_KEY],
								 toolState[TOOLSTATE_KEY_CLICKSCRIPT],
								 toolState[TOOLSTATE_KEY_ENABLEDSCRIPT],
								 toolState[TOOLSTATE_KEY_ONLOADSCRIPT],
								 toolState[TOOLSTATE_KEY_ONSUBMITSCRIPT],
								 toolState[TOOLSTATE_KEY_HOTKEY],
								 toolState[TOOLSTATE_KEY_INFOSTRING]);
	}
}

TableEdit.prototype.RefreshAllTools = function()
{
	var index;
	var toolState;
	var tool;
	
	var toolStateList = eval(this.editorID + "_ToolStateList");

	for(index = 0; index < toolStateList.length; index++)
	{
		toolState = toolStateList[index];
		tool = toolState[TOOLSTATE_KEY];
				
		if (tool.Handle_onmouseout)
			tool.Handle_onmouseout();
	}	
}

TableEdit.prototype.ExecuteToolOnLoadHandlers = function()
{
	var index;
	var toolState;
	var tool;
	
	var toolStateList = eval(this.editorID + "_ToolStateList");

	for(index = 0; index < toolStateList.length; index++)
	{
		toolState = toolStateList[index];
		tool = toolState[TOOLSTATE_KEY];
				
		if (tool.Handle_onload)
			tool.Handle_onload();
	}	
}

TableEdit.prototype.ExecuteToolOnSubmitHandlers = function()
{
	var index;
	var toolState;
	var tool;
	var returnValue = true;
	
	var toolStateList = eval(this.editorID + "_ToolStateList");

	for(index = 0; index < toolStateList.length; index++)
	{
		toolState = toolStateList[index];
		tool = toolState[TOOLSTATE_KEY];
				
		if (tool.Handle_onsubmit)
			if (!tool.Handle_onsubmit())
				returnValue = false;
	}	

	return returnValue;
}

TableEdit.prototype.CleanupTools = function()
{
	var commandIdentifierList = eval(this.editorID + "_CommandIdentifierList");
	var identifierSet;
	var index;
	var toolIndex;
	var tool;

	for(index = 0; index < commandIdentifierList.length; index++)
	{
		identifierSet = commandIdentifierList[index];		

		for(toolIndex = COMMAND_IDENTIFIER_TOOL_STARTINDEX; toolIndex < identifierSet.length; toolIndex++)
		{
			tool = identifierSet[toolIndex];
			
			// Make sure a tool is only cleaned up once. We need to check this, since a tool can have
			// registered itself to several command identifiers.
			if (!tool.IsCleanedUp)
			{
				tool.Handle_onstatechange = null;
				tool.Handle_onmouseout = null;
				
				if (tool.Handle_onunload)
					tool.Handle_onunload(tool);

				tool.Handle_onunload = null;					
				tool.IsCleanedUp = true;
			}
		}
	}	

	for(index = 0; index < this.hotkeys.length; index++)
		this.hotkeys[index] = null;
	this.hotkeys = null;
}

function ValidateTool(menuItem, controlID)
{
	var tool = document.getElementsByName(controlID)[0];
	return tool.IsEnabled();
}

function ExecuteOnClick(menuItem, controlID)
{
	var tool = document.getElementsByName(controlID)[0];
	tool.Handle_onclick();
}


function Tool_HandleMouseDown()
{
	if (this.IsEnabled())
	{
		this.status = TOOLSTATUS_SELECTED; 
		this.Handle_onmouseover();
	}
}

function Tool_HandleMouseUp()
{
	if (this.IsEnabled())
	{
		this.status = TOOLSTATUS_SELECTABLE;
		this.Handle_onmouseover();
	}
}

function Tool_HandleMouseOver()
{
	this.SetToolIcon('over');
}

function Tool_HandleMouseOut()
{
	this.SetToolIcon('off');
}

// Get actual icon for tool. The provided action is the default action, but the real action
// that is used to construct the filename depends on the tool's status.
function Tool_GetToolIcon(action)
{
	if (this.IsEnabled())
	{
		switch(action)
		{
			case "over":
				if (this.status == TOOLSTATUS_SELECTED) 
					action = "selected";
				break;
				
			case "off":
				if (this.status == TOOLSTATUS_SELECTED) 
					action = "selected";
				break;
		}
	}
	else
		action = "disabled";

	return this.iconBaseSrc + "_" + action + "." + this.iconFiletype;	
}

function Tool_SetToolIcon(action)
{
	var iconSrc;

	iconSrc = this.GetToolIcon(action);

	if (iconSrc != this.orgurl)
	{
		this.src = iconSrc;
		this.orgurl = iconSrc;
	}
}

TableEdit.prototype.CreateToolOnClickFunction = function(onclickScript)
{
	return new Function("if (this.IsEnabled()) {this.editor.focus();" + onclickScript + "}");	
}

TableEdit.prototype.CreateToolIsEnabledFunction = function(tool, availability, enabledScript)
{
	var conditions = new Array();

	switch(availability)
	{
		case "always":
			if (enabledScript.length == 0)
				conditions.push("true");
			break;
			
		case "htmlonly":
			conditions.push("this.status != TOOLSTATUS_NOT_SELECTABLE");
			conditions.push("this.editorState.Mode == EDITORMODE_HTML");
			break;
			
		default:	// design mode (which is never sent to client, so availability is null here) is default
			conditions.push("this.status != TOOLSTATUS_NOT_SELECTABLE");
			conditions.push("this.editorState.Mode == EDITORMODE_DESIGN");
	}

	if (enabledScript.length > 0)
	{
		tool.CustomIsEnabled = new Function(enabledScript);
		conditions.push("this.CustomIsEnabled()");
	}
	
	return new Function("return " + conditions.join(" && ") + ";");
}

// About the infoString parameter: a string with the format ";name1=value1;name2=value2;...;". 
// The string can not be empty and it must begin and end with ";" (naive logic by design, optimized for fast lookup).
function GetValueFromInfoString(infoString, name, defaultValue)
{
	var pos = infoString.indexOf(";" + name + "=");
	
	if (pos >= 0)
		return infoString.substring(pos + name.length + 2, infoString.indexOf(";", pos + name.length + 2));
	else
		return defaultValue;
}

TableEdit.prototype.InitSingleToolState = 
					function (index, tool, onclickScript, enabledScript, onloadScript, onsubmitScript, hotkey, infoString)
{
	var availability;

	// Prepare infoString for searches.
	infoString = ";" + infoString + ";";

	if (tool.type != "hidden")
	{
		var iconBaseName = GetValueFromInfoString(infoString, "IconBaseName");	
	
		if (iconBaseName)
		{	
			// Only tools with a GUI have mouseover logic and attributes that define appearance.
			tool.SetToolIcon		= Tool_SetToolIcon;
			tool.GetToolIcon		= Tool_GetToolIcon;
			tool.Handle_onmouseover	= Tool_HandleMouseOver;
			tool.Handle_onmouseout	= Tool_HandleMouseOut;
			tool.onmousedown		= Tool_HandleMouseDown;
			tool.onmouseup			= Tool_HandleMouseUp;
			tool.iconBaseName		= iconBaseName;
			tool.iconBaseSrc		= this.editor.iconsDir + tool.iconBaseName;	
			// No filetype means we use the default filetype "gif".
			tool.iconFiletype		= GetValueFromInfoString(infoString, "IconFileType", "gif");
		}
	}

	tool.status			= TOOLSTATUS_SELECTABLE;
	tool.editorState	= this.editorState;	
	tool.editor			= this.editor;
	tool.editorDocument	= this.editorDocument;
	tool.editorHiddenInput = this.editorHiddenInput;
	
	tool.tableEdit		= this;
	tool.editorAPI		= this;
	
	availability		= GetValueFromInfoString(infoString, "Availability");
	tool.IsEnabled		= this.CreateToolIsEnabledFunction(tool, availability, enabledScript);
	

	if (enabledScript.length > 0)
		this.selectionSensitiveTools.push(index);

	onclickScript		+= "this.tableEdit.RefreshToolBySelection();";
	tool.Handle_onclick	= this.CreateToolOnClickFunction(onclickScript);	

	if (onloadScript.length > 0)
		tool.Handle_onload = new Function(onloadScript);

	if (onsubmitScript.length > 0)
		tool.Handle_onsubmit = new Function(onsubmitScript);

	if (hotkey.length > 0)
	{
		var hotkeyCode = new Number(hotkey);
		this.hotkeys[hotkeyCode] = tool;
	}
}

TableEdit.prototype.InitCommandIdentifierHandler = function()
{
	var index;
	var toolIndex;
	var tool;
	var commandIdentifierList = eval(this.editorID + "_CommandIdentifierList");
	
	for(index = 0; index < commandIdentifierList.length; index++)
	{
		identifierSet = commandIdentifierList[index];

		identifierSet[COMMAND_IDENTIFIER_LAST_STATUS] = TOOLSTATUS_UNKNOWN;
		
		// Store object over the ID for each tool for faster access next time
		for(toolIndex = COMMAND_IDENTIFIER_TOOL_STARTINDEX; toolIndex < identifierSet.length; toolIndex++)
		{
			tool = document.getElementsByName(identifierSet[toolIndex])[0];
			identifierSet[toolIndex] = tool;
		}
	}		
}

TableEdit.prototype.ToggleMode = function()
{
	this.SaveCursor(); 

	if (this.editorState.Mode == EDITORMODE_HTML)
		setDesignMode(this.editorID);
	else
		setHtmlMode(this.editorID);
		
	this.RefreshAllTools();
}

TableEdit.prototype.SwitchToHtmlMode = function()
{
	GetEditorIFrame(this.editorID).style.display = 'none';
	
	this.editorHtmlArea.style.display = '';

	var content = this.GetContentsWithoutDesignModeInformation();
	this.htmlAreaContentBeforeChanges = content;
	this.editorHtmlArea.value = content;
	this.ResetEditor();
	this.editorState.Mode = EDITORMODE_HTML;
	this.RestoreCursor();
}

TableEdit.prototype.SwitchToDesignMode = function(skipContentRefresh)
{
	var content;

	GetEditorIFrame(this.editorID).style.display = '';

	if (this.editorState.Mode == EDITORMODE_HTML)
	{
		this.editorHtmlArea.style.display = 'none';	
		content = this.editorHtmlArea.value;
	}
	else
	{
		content = this.editorDocument.body.innerHTML;
	}

	if (content.length == 0)
	{
		if (this.ParagraphIsDiv)
			content = '<DIV></DIV>';
		else
			content = '<P></P>';
		this.editorDocument.body.innerHTML = content;
	}

	if (!skipContentRefresh)
	{
		var repairForDesignMode = true;
		if (this.NeedsRepairing(content, repairForDesignMode))
		{
			content = this.RepairContent(content, repairForDesignMode);
		}

		if (this.htmlAreaContentBeforeChanges)
		{
			if (this.htmlAreaContentBeforeChanges != content)
				this.editorDocument.body.innerHTML = content;

			this.htmlAreaContentBeforeChanges = null;
		}
		else
			this.editorDocument.body.innerHTML = content;
	}

	this.AddTableDesignElements();
	this.ResetEditor();
	this.editorState.Mode = EDITORMODE_DESIGN;
	this.RestoreCursor();
}

TableEdit.prototype.RestoreCursor = function()
{
	var state = this.editorState;
	if (state.lastSelectionType == null)
		return;

	if (state.Mode == EDITORMODE_DESIGN)
	{
		var doc = this.editorDocument;

		if (state.lastSelectionType == "Control")
		{
			if (state.lastSelectionElement.tagName == "IMG")
			{
				var index;

				for(index = 0; index < doc.images.length; index++)
				{
					if (doc.images[index].src == state.lastSelectionElement.src)
					{
						range = doc.body.createControlRange();
						range.addElement(doc.images[index]);
						range.select();
						break;
					}
				}
			}					
		}
		else
		{
			var range = doc.body.createTextRange();		
			range.collapse();
			range.move("character", state.lastCursorPosition);
			range.select();		
		}
	}
	else
	{
		var range = this.editorHtmlArea.createTextRange();
		range.collapse();
		range.select();		
	}
}

TableEdit.prototype.SaveCursor = function ()
{
	var state = this.editorState;

	if (state.Mode == EDITORMODE_DESIGN)
	{
		var doc = this.editorDocument;

		state.lastSelectionType = doc.selection.type;
		
		if (checkValidTextSelection(this.editor))
		{		
			var range = doc.selection.createRange();
			state.lastCursorPosition = -range.move("character", -0x7FFFFFFF);
		}
		else
		{
			var range = doc.selection.createRange();
			state.lastSelectionElement = range.item(0);
		}
	}
}

TableEdit.prototype.MoveCursorToElement = function (element)
{
	var cursorRange = this.editorDocument.body.createTextRange();	
	cursorRange.moveToElementText(element);
	cursorRange.collapse();
	cursorRange.select();
}

TableEdit.prototype.HandleControlSelectEvent = function (e)
{
	if (e.srcElement.tagName == "IMG")
	{
		// IE's built-in image handler can restructure table cells transparently and without a warning,
		// so make sure we do not hold any references (that could become orphaned) when an image is selected.
		this.ResetEditor();
		
		e.returnValue = true;	
		e.cancelBubble = true;
		return false;
	}

	e.returnValue = false;	
	e.cancelBubble = true;
}

TableEdit.prototype.HandleBeforePasteEvent = function (sourceEvent) 
{
}

TableEdit.prototype.HandlePasteEvent = function (sourceEvent) 
{
	if (this.editorState.Mode == EDITORMODE_HTML)
	{
		var range = this.editorDocument.selection.createRange();
		range.pasteHTML(clipboardData.getData("Text"));
		sourceEvent.returnValue = false;
	}
	else
	{
		// If the clipboard contains a string that holds a link, paste it as html. This avoids a weird
		// IE bug, where IE sometimes inserts a <font color=""> element together with the link.
		if (checkValidTextSelection(this.editor))
		{
			var clipContents = clipboardData.getData("Text");
			if (clipContents.search(/^<a\s/i) != -1)
			{
				var range = this.editorDocument.selection.createRange();
				range.pasteHTML(clipContents);
				sourceEvent.returnValue = false;	
			}
		}
	}
}

TableEdit.prototype.RefreshToolBySelection = function (range)
{
	var index;
	var toolIndex;
	var tool;
	var toolStatus;
	var identifierName;
	var doc = this.editorDocument;

	if (!range)
		range = doc.selection.createRange();

	// The following code makes sure that the case when the cursor is standing at the end of a word
	// is captured and shown correctly. If we did not do this the call to queryCommandState() later would 
	// return false when it in fact should return true.
	if (range.expand)
	{
		range.expand("character");
		if (range.text == " ")
			range.moveStart("character", -1);
	}
	
	var commandIdentifierList = eval(this.editorID + "_CommandIdentifierList");

	for(index = 0; index < commandIdentifierList.length; index++)
	{
		// The identifierSet holds an array with the format [identifier, last_tool_status, tool1, tool2, tool3, ...] 
		// where the tools enlisted are all interested in reacting to the identifier (for example "bold").
		identifierSet = commandIdentifierList[index];		

		identifierName = identifierSet[COMMAND_IDENTIFIER_NAME];

		if (identifierName == 'FormatParagraph')
		{
			if (doc.selection.type.toLowerCase() == 'control')
				toolStatus = range(0).sourceIndex;
			else
				toolStatus = range.parentElement().sourceIndex;
		}
		else if (!range.queryCommandEnabled(identifierName))
			toolStatus = TOOLSTATUS_NOT_SELECTABLE;
		else if (identifierName == 'FontName' || identifierName == 'FontSize' || identifierName == 'ForeColor')
			toolStatus = range.queryCommandValue(identifierName);
		else
			toolStatus = (range.queryCommandState(identifierName) ? TOOLSTATUS_SELECTED : TOOLSTATUS_SELECTABLE);

		if (toolStatus != identifierSet[COMMAND_IDENTIFIER_LAST_STATUS])
		{
			identifierSet[COMMAND_IDENTIFIER_LAST_STATUS] = toolStatus;
			
			for(toolIndex = COMMAND_IDENTIFIER_TOOL_STARTINDEX; toolIndex < identifierSet.length; toolIndex++)
			{
				tool = identifierSet[toolIndex];
				tool.status = toolStatus;

				if (tool.Handle_onstatechange)
					tool.Handle_onstatechange(identifierName);
				else if (tool.Handle_onmouseout)
					tool.Handle_onmouseout();
			}
		}
	}

	var toolStateList = eval(this.editorID + "_ToolStateList");
	for(index = 0; index < this.selectionSensitiveTools.length; index++)
	{
		var objIndex = this.selectionSensitiveTools[index];
		tool = toolStateList[objIndex][0];
		if (tool.Handle_onmouseout)		
			tool.Handle_onmouseout();
	}
}

TableEdit.prototype.HandleSelectionChangeEvent = function (sourceEvent)
{
	if (this.skipNextSelectionEvent)
	{
		this.skipNextSelectionEvent = null;
		this.SaveLastEvent(sourceEvent);
		sourceEvent.returnValue = false;
		sourceEvent.cancelBubble = true;
		this.editorDocument.selection.empty();
		this.RefreshToolBySelection();
		return false;
	}			

	this.event = sourceEvent;
	this.RefreshToolBySelection();
}

TableEdit.prototype.LostFocus = function ()
{
	this.ClearActiveTableStatus();
}

TableEdit.prototype.HandleContextMenuEvent = function (contextMenuEvent)
{
	this.lastActiveCell = this.GetOwnerCell(contextMenuEvent.srcElement);

	if (this.lastActiveCell && !this.IsSelected(this.lastActiveCell))
		this.DeselectAllCells();

	this.InitActiveTable(contextMenuEvent.srcElement);
	this.SaveLastEvent(contextMenuEvent);
}

TableEdit.prototype.HandleResizeEvent = function (sourceEvent)
{
	var srcElement = sourceEvent.srcElement;
	
	if (srcElement.tagName.toLowerCase() == 'img')
	{
		// When resizing images, IE automatically changes width/height in the style object
		// if there already are width and height attributes in the element. 
		// This code handles that case by moving the values from the style object to attributes.
		if (srcElement.style.height.length > 0)
		{
			srcElement.height = parseInt(srcElement.style.height);
			srcElement.style.height = '';
		}

		if (srcElement.style.width.length > 0)
		{
			srcElement.width = parseInt(srcElement.style.width);
			srcElement.style.width = '';
		}
	}

	return true;
}

TableEdit.prototype.CancelEvent = function()
{
	return false;
}

//------------- Implementations of the resizeproperties functions

TableEdit.prototype.GetOwnerElement = function()
{
	return GetEditorIFrame(this.editorID).parentElement;
}

TableEdit.prototype.SetSize = function(width, height)
{
	this.editorArea.originalWidth = this.editorArea.style.width;
	this.editorArea.originalHeight = this.editorArea.style.height;
 	this.editorArea.style.width = width;
 	this.editorArea.style.height = height;
}

TableEdit.prototype.RestoreOriginalSize = function()
{
 	this.editorArea.style.width = this.editorArea.originalWidth;
 	this.editorArea.style.height = this.editorArea.originalHeight; 			
}

//------------- Implementations of the resizeproperties functions END

TableEdit.prototype.GetOwnerTable = function (source)
{
	while(source)
	{
		if (source.tagName.toUpperCase() == "TABLE")
			break;
		source = source.parentElement;	
	}
	
	return source;
}

TableEdit.prototype.GetOwnerCell = function (source)
{
	var isCell = /TD|TH/i;
	
	while(source && !isCell.test(source.tagName))
		source = source.parentElement;	
	
	return source;
}

TableEdit.prototype.SaveLastEvent = function (sourceEvent)
{
	// Event that holds orphaned references (srcElement, for example) must be ignored, or fireworks will occur.
	if (this.ignoreEvent)
	{
		this.ignoreEvent = false;
		this.lastEvent = null;
		return;
	}		

	this.lastEvent = this.editorDocument.createEventObject(sourceEvent);

	try
	{
		this.lastRange = this.editorDocument.selection.createRange();
	}
	catch(e)
	{
		this.lastRange = null;
	}
}

// Check if active table changes. 
// This function is called whenever there is a need to check which table has been selected, if any.
// The source-parameter is an element that may (but does not have to) be included in a table.
TableEdit.prototype.InitActiveTable = function (source)
{
	if (source.tagName.toUpperCase() != "TABLE")	
		source = this.GetOwnerTable(source);
		
	if (source != this.table)
	{
		this.ClearActiveTableStatus();							
		this.table = source;
	}
}	

TableEdit.prototype.CheckCellHovering = function (source)
{
	var x = this.event.offsetX;
	var y = this.event.offsetY;
	var returnValue = true;

	if(this.event.type != "mousemove")
	{
		source.runtimeStyle.cursor = "default";						
		this.hoverLocation = HOVER_NONE;	
	}
	else if (Math.abs(x) <= HOVERMARGIN_CELL)
	{
		// left border
		source.runtimeStyle.cursor = "crosshair";	
		this.hoverLocation = HOVER_CELL_LEFT;	
		returnValue = false;
	}
	else if (Math.abs(x - source.clientWidth) <= HOVERMARGIN_CELL)
	{
		// right border
		source.runtimeStyle.cursor = "crosshair";		
		this.hoverLocation = HOVER_CELL_RIGHT;	
		returnValue = false;
	}
	else if (Math.abs(y) <= HOVERMARGIN_CELL)
	{
		// top border
		source.runtimeStyle.cursor = "crosshair";		
		this.hoverLocation = HOVER_CELL_TOP;	
		returnValue = false;
	}
	else if (Math.abs(y - source.clientHeight) <= HOVERMARGIN_CELL)
	{
		// bottom border
		source.runtimeStyle.cursor = "crosshair";		
		this.hoverLocation = HOVER_CELL_BOTTOM;	
		returnValue = false;
	}
	else
	{
		source.runtimeStyle.cursor = "default";						
		this.hoverLocation = HOVER_NONE;	
	}

	return returnValue;
}

TableEdit.prototype.GetResizeCursor = function(direction)
{
	var cursor = "";

	if (direction & DIRECTION_NORTH)
		cursor = CURSOR_NORTH;
	else if (direction & DIRECTION_SOUTH)
		cursor = CURSOR_SOUTH;

	if (direction & DIRECTION_EAST)
		cursor += CURSOR_EAST;
	else if (direction & DIRECTION_WEST)
		cursor += CURSOR_WEST;

	if (cursor.length == 0)
		cursor = "auto";
	else
		cursor += "-resize";

	return cursor;
}

TableEdit.prototype.CheckResizing = function(source, sourceEvent)
{
	this.resizeDirection = 0;

/*		
	if (sourceEvent.y - HOVERMARGIN_TABLE < source.offsetTop)
		this.resizeDirection = DIRECTION_NORTH;
	else
*/	
	if (sourceEvent.offsetY + HOVERMARGIN_TABLE + parseInt(source.border) > source.offsetHeight)
		this.resizeDirection = DIRECTION_SOUTH;

	if (sourceEvent.offsetX + HOVERMARGIN_TABLE + parseInt(source.border) > source.offsetWidth)
		this.resizeDirection |= DIRECTION_EAST;

/*
	else if (sourceEvent.x - HOVERMARGIN_TABLE < source.offsetLeft)
		this.resizeDirection |= DIRECTION_WEST;
*/
	if (this.resizeDirection)
	{
		this.resizeCursor = this.GetResizeCursor(this.resizeDirection);
		source.runtimeStyle.cursor = this.resizeCursor;

		if (sourceEvent.type == "mousedown")
		{
			this.resizeActive = true;
			this.resizeSource = source;			
			this.ActivateMouseMoveHandler();
		}
	}
	else
		source.runtimeStyle.cursor = "auto";

	return this.resizeDirection != 0;
}

TableEdit.prototype.CheckTableMove = function(source, sourceEvent)
{
	if (sourceEvent.y - HOVERMARGIN_TABLE < source.offsetTop
	    && sourceEvent.x - HOVERMARGIN_TABLE < source.offsetLeft)
	{
		this.table = this.GetOwnerTable(source);
		this.SelectEntireTable();
		this.editorDocument.body.runtimeStyle.cursor = "move";
		
		if (sourceEvent.type == "mousedown")
		{
			this.moveAction = MOVE_ACTION_STARTED;
			this.moveSource = source;			
			this.ActivateMouseMoveHandler();
		}
	}
	else if (this.moveAction == MOVE_ACTION_NOT_ACTIVE)
	{
		this.editorDocument.body.runtimeStyle.cursor = "auto";
	}

	return this.moveAction != MOVE_ACTION_NOT_ACTIVE;
}
	
TableEdit.prototype.CheckTableHovering = function (source)
{
	var x = this.event.offsetX;
	var y = this.event.offsetY;
	var returnValue = true;
	
	if (this.multiSelect == MULTISELECT_COLUMNS)
	{
		source.runtimeStyle.cursor = "hand";		
		this.hoverLocation = HOVER_TABLE_TOP;	
		returnValue = false;	
	}	
	else if (Math.abs(x) <= HOVERMARGIN_TABLE)
	{
		// left border
		source.runtimeStyle.cursor = "hand";	
		this.hoverLocation = HOVER_TABLE_LEFT;	
		returnValue = false;
	}
/*	
	else if (Math.abs(x - source.clientWidth) <= HOVERMARGIN_TABLE)
	{
		// right border
		source.runtimeStyle.cursor = "hand";		
		this.hoverLocation = HOVER_TABLE_RIGHT;	
		returnValue = false;
	}
	else if  (Math.abs(y - source.clientHeight) <= HOVERMARGIN_TABLE)
	{
		// bottom border
		source.runtimeStyle.cursor = "hand";		
		this.hoverLocation = HOVER_TABLE_BOTTOM;	
		returnValue = false;
	}
*/
	else if (Math.abs(y) <= HOVERMARGIN_TABLE)
	{
		// top border
		source.runtimeStyle.cursor = "hand";		
		this.hoverLocation = HOVER_TABLE_TOP;	
		returnValue = false;
	}
	else
	{
		source.runtimeStyle.cursor = "default";						
		this.hoverLocation = HOVER_NONE;	
	}
	return returnValue;
}

TableEdit.prototype.GetClosestCellToEventOffsets = function ()
{
	var cell = null;
	
	if (this.hoverLocation == HOVER_TABLE_TOP)
	{
		var offsetX = this.event.offsetX;
		var cellIndex;
		var cells = this.table.rows(0).cells;

		for(cellIndex = 0; cellIndex < cells.length; cellIndex++)
		{
			cell = cells(cellIndex);
			
			if (offsetX >= cell.offsetLeft && offsetX <= (cell.offsetLeft + cell.clientWidth))
				break;
		}
	}
	else
	{
		var offsetY = this.event.offsetY;
		var rowIndex;
		var rows = this.table.rows;

		for(rowIndex = 0; rowIndex < rows.length; rowIndex++)
		{
			if (rows(rowIndex).cells.length > 0)
			{
				cell = rows(rowIndex).cells(0);
				
				if (offsetY >= cell.offsetTop && offsetY <= (cell.offsetTop + cell.clientHeight))
					break;
			}
		}
	}
	
	return cell;
}

TableEdit.prototype.SelectColumnsUsingNoKeys = function (cell)
{
	this.MultiselectColumns(cell);
}

TableEdit.prototype.SelectColumnsUsingShift = function (cell)
{
	this.MultiselectColumns(cell);
}

TableEdit.prototype.SelectCellsUsingNoKeys = function (cell)
{
	if (this.IsSelected(cell))
	{
		if (this.selectedCells.length > 2)
		{
			this.DeselectAllCellsExcept([cell]);
			this.selectionStartCell = cell;
		}
		else
		{
			this.DeselectCell(cell);
			this.selectionStartCell == null;
		}
	}
	else
	{
		this.DeselectAllCells();	
		this.SelectCell(cell);
		this.selectionStartCell = cell;					
	}
}

// Select all cells from start cell to current cell, in a rectangular pattern
TableEdit.prototype.MultiselectCells = function (cell)
{
	this.DeselectAllCells();

	if (this.selectionStartCell == null)
		this.selectionStartCell = this.table.rows(0).cells(0);

	this.SelectCells(this.selectionStartCell.x, this.selectionStartCell.y, cell.x, cell.y);		
	this.multiSelect = MULTISELECT_CELLS;				
	this.lastActiveCell = null;
}

// Select all cells in columns between start cell and current cell
TableEdit.prototype.MultiselectColumns = function (cell)
{
	this.DeselectAllCells();	
	
	if (this.selectionStartCell == null)
		this.selectionStartCell = cell;
		
	this.SelectColumns(this.selectionStartCell.x, cell.x);	
	this.multiSelect = MULTISELECT_COLUMNS;
	this.lastActiveCell = null;
}

// Select all cells in rows between start cell and current cell
TableEdit.prototype.MultiselectRows = function (cell)
{
	this.DeselectAllCells();
	
	if (this.selectionStartCell == null)
		this.selectionStartCell = cell;

	this.SelectRows(this.selectionStartCell.y, cell.y);	
	this.multiSelect = MULTISELECT_ROWS;
	this.lastActiveCell = null;	
}

TableEdit.prototype.SelectEntireTable = function()
{
	this.SelectCells(0,0, this.GetMaxCellX(), this.GetMaxCellY());
}

TableEdit.prototype.SelectCellsUsingShift = function (cell)
{
	this.MultiselectCells(cell);
	this.CancelTextSelection();
}

TableEdit.prototype.SelectCellsUsingCtrl = function (cell)
{
	this.SelectEntireTable();
	this.CancelTextSelection();
}	
	
TableEdit.prototype.SelectCellsUsingCtrlAndShift = function (cell)
{
	this.SelectEntireTable();
	this.CancelTextSelection();
}

TableEdit.prototype.SelectCellsUsingAlt = function (cell)
{
	this.DeselectAllCells();
	this.SelectColumns(cell.x, cell.x);
	this.multiSelect = MULTISELECT_COLUMNS;
	this.CancelTextSelection();
}

// Operations that combine mouse clicks and special keys (control/shift/alt) can in certain cases cause an 
// unwanted text selection. The only way to clear the selection is to cancel the next selection event, 
// which is what this function does.
TableEdit.prototype.CancelTextSelection = function ()
{
	// The flag skipNextSelectionEvent is checked in HandleSelectionChangeEvent().
	this.skipNextSelectionEvent = true;
}

TableEdit.prototype.GetKeysPressed = function ()
{
	var keyMask = 0;
	var sourceEvent = this.event;
	
	if (sourceEvent.ctrlKey)
		keyMask += KEYBIT_CTRL;
	if (sourceEvent.shiftKey)
		keyMask += KEYBIT_SHIFT;
	if (sourceEvent.altKey)
		keyMask += KEYBIT_ALT;

	return keyMask;
}

// cell is optional (in certain cases not available and therefore calculated using 
// GetClosestCellToEventOffsets below).
TableEdit.prototype.HandleTableDragging = function (cell)
{
	if (!cell)
		cell = this.GetClosestCellToEventOffsets();		

	switch(this.GetKeysPressed())
	{			
		case KEYMASK_CTRL_ONLY:
			this.SelectCellsUsingCtrl(cell);
			break;
		case KEYMASK_ALT_ONLY:
			this.SelectColumnsUsingNoKeys(cell);
			break;
		case KEYMASK_CTRL_ALT:
			this.SelectColumnsUsingNoKeys(cell);
			break;
		case KEYMASK_CTRL_SHIFT:
			this.SelectCellsUsingCtrlAndShift(cell);
			break;
		case KEYMASK_SHIFT_ONLY:
			this.SelectColumnsUsingShift(cell);
			break;
		case KEYMASK_NO_KEYS:
			if (this.hoverLocation == HOVER_TABLE_TOP)
				this.SelectColumnsUsingNoKeys(cell);
			else if (this.hoverLocation == HOVER_TABLE_LEFT)
				this.MultiselectRows(cell);	
			break;
	}

}

TableEdit.prototype.HandleTableEvent = function (source)
{
	var returnValue = true;
	var sourceEvent = this.event;

	if (this.multiSelect != MULTISELECT_NONE)
	{
		if (sourceEvent.button != 0 && this.table.contains(source))	
			this.HandleTableDragging();
		return false;
	}

	if (this.CheckResizing(source, sourceEvent))
		return false;
		
	if (this.CheckTableMove(source, sourceEvent))
		return false;		
		
	returnValue = this.CheckTableHovering(source);

	if (sourceEvent.type == "dblclick")
	{
		this.SelectEntireTable();
	}
	else if (sourceEvent.type == "mousedown")
	{
		this.InitActiveTable(source);
		this.selectionStartCell = null;
		this.HandleTableDragging();
		this.ActivateMouseMoveHandler();
	}
	else if (sourceEvent.type == "mousemove" && this.table.contains(source))
	{
		if (this.multiSelect == MULTISELECT_COLUMNS)		
			this.HandleTableDragging();
		else if (this.selectionStartCell)
		{
			this.MultiselectCells(this.selectionStartCell);	
		}
	}
		
	return returnValue;
}

TableEdit.prototype.HandleCellEventMousedown = function (cell)
{
	var keysPressed = this.GetKeysPressed();

	this.ActivateMouseMoveHandler();
	
	switch(keysPressed)
	{
		case KEYMASK_NO_KEYS:
			this.lastActiveCell = cell;
			this.selectionStartCell = cell;		
			this.DeselectAllCells();
			break;
		case KEYMASK_CTRL_ONLY:
			this.SelectCellsUsingCtrl(cell);
			break;
		case KEYMASK_SHIFT_ONLY:
			this.SelectCellsUsingShift(cell);
			break;
		case KEYMASK_ALT_ONLY:
			this.SelectColumnsUsingNoKeys(cell);
			break;
		case KEYMASK_CTRL_ALT:
			this.SelectCellsUsingAlt(cell);
			break;
		case KEYMASK_CTRL_SHIFT:
			this.SelectCellsUsingCtrlAndShift(cell);
			break;
	}	

	return false;
}

TableEdit.prototype.HandleCellEvent = function (cell)
{
	var returnValue = true;
	var keysPressed;
	var sourceEvent = this.event;
	var ownerTable = this.GetOwnerTable(cell);

	if (this.table != null && this.table != ownerTable)
	{
		cell = this.FindParentCell(cell, ownerTable);
	}
	else
	{	
		if (this.multiSelect == MULTISELECT_COLUMNS || this.multiSelect == MULTISELECT_ROWS)
		{
			this.HandleTableDragging(cell);
			return returnValue;
		}	

		this.hoverLocation == HOVER_NONE;
	}

	this.InitActiveTable(ownerTable);

	if (sourceEvent.type == "dblclick")
	{
		if (this.hoverLocation == HOVER_CELL_LEFT)
		{
			this.selectionStartCell = null;
			this.MultiselectRows(cell);	
		}				
	}
	else if (sourceEvent.type == "mousedown")
	{
		returnValue = this.HandleCellEventMousedown(cell);
	}
	// dragging?
	else if (sourceEvent.type == "mousemove" && sourceEvent.button == 1 && this.table.contains(cell) && this.selectionStartCell != cell)			
	{	
		this.MultiselectCells(cell);
	}
//	else
//		status = "not handling: " + sourceEvent.type;

	if (returnValue)
		this.lastCellCheckedInEvent = cell;

	return returnValue;
}

var _scrolling = false;

TableEdit.prototype.ScrollingComplete = function()
{
	_scrolling = false;
}

TableEdit.prototype.ScrollDown = function()
{
	if (!_scrolling)
	{
		_scrolling = true;
		this.editorDocument.body.doScroll("scrollbarDown");
		setTimeout(this.ScrollingComplete, 400);
	}
}

TableEdit.prototype.ScrollRight = function()
{
	if (!_scrolling)
	{
		_scrolling = true;
		this.editorDocument.body.doScroll("scrollbarRight");
		setTimeout(this.ScrollingComplete, 50);
	}
}

TableEdit.prototype.HandleMouseMove = function(sourceEvent)
{
	var pos;
	var resizeSource;	

	if (this.resizeActive)
	{
		resizeSource = this.resizeSource;
		resizeSource.setCapture();
		resizeSource.runtimeStyle.cursor = this.resizeCursor;

		if (this.resizeDirection & DIRECTION_NORTH)
		{
			// no action (to do: move table position?)
		}
		else if (this.resizeDirection & DIRECTION_SOUTH)
		{
			pos = sourceEvent.clientY + this.editorDocument.body.scrollTop - resizeSource.offsetTop;

			if (!isNaN(pos) && pos > 0)
				resizeSource.height = pos;				

			if (sourceEvent.clientY > this.editorDocument.body.offsetHeight - 30)
				this.ScrollDown();
		}

		if (this.resizeDirection & DIRECTION_EAST)
		{
			pos = sourceEvent.clientX + this.editorDocument.body.scrollLeft - resizeSource.offsetLeft;

			if (!isNaN(pos) && pos > 0)
				resizeSource.width = pos;
				
			if (sourceEvent.clientX > this.editorDocument.body.offsetWidth - 30)
				this.ScrollRight();
				
		}
		else if (this.resizeDirection & DIRECTION_WEST)
		{
			// no action (to do: move table position?)		
		}
	}
	else if (this.moveAction != MOVE_ACTION_NOT_ACTIVE)
	{
		try
		{
			var range = this.editorDocument.body.createTextRange();
			range.moveToPoint(sourceEvent.clientX, sourceEvent.clientY);
			range.select();
			this.moveAction = MOVE_ACTION_MOVING;
		} catch (e)
		{
			// If the returned range is a control range, the method moveToPoint 
			// is not going to be a valid method for this object so we 
			// use the old endpoint instead.
		}
	}
	else
		this.HandleEvent(sourceEvent);
}

TableEdit.prototype.HandleEvent = function (sourceEvent)
{
	var source = sourceEvent.srcElement;
	var returnValue = true;
	this.event = sourceEvent;
/*	
status = 'event: ' + sourceEvent.type + '   button: ' + sourceEvent.button + 
		'  Table? ' + this.GetOwnerTable(source) + '   ' + source.tagName + ' multi: ' + this.multiSelect;
		//'   scrollTop: ' + this.editorDocument.body.scrollTop +
		//'   offsetTop: ' + source.offsetTop;
*/
	if (sourceEvent.button == RIGHT_MOUSE_BUTTON)
	{
		if(this.GetOwnerTable(source)==null)
			this.table = null;
		else if(this.GetOwnerTable(sourceEvent.fromElement)==null)
			this.InitActiveTable(source);
			
		returnValue = false;
	}
	else
	{
		if (this.resizeActive)
		{
			if (sourceEvent.type == "mouseup")
			{
				this.resizeActive = false;
				source.runtimeStyle.cursor = "auto";
				if(this.resizeSource)
					this.resizeSource.releaseCapture();
				this.DeactivateMouseMoveHandler();
			}
			else
			{
				source.runtimeStyle.cursor = this.resizeCursor;
			}
		}
		else if (this.moveAction != MOVE_ACTION_NOT_ACTIVE)
		{
			if (sourceEvent.type == "mouseup")
			{
				try
				{
					this.table = this.GetOwnerTable(this.moveSource);
						
					if (this.moveAction == MOVE_ACTION_MOVING)
					{
						var destinationRange = this.editorDocument.selection.createRange();
						this.MoveTable(destinationRange);
					}
					this.DeselectAllCells();
					this.editorDocument.body.runtimeStyle.cursor = "auto";
					this.moveAction= MOVE_ACTION_NOT_ACTIVE;
					this.DeactivateMouseMoveHandler();
				}
				catch (e)
				{
					window.status = "Can't move table!";
				}
			}
			else
			{
				this.editorDocument.body.runtimeStyle.cursor = "move";
			}
		}
		
		if (sourceEvent.type == "mouseup" && this.table)
		{
			this.multiSelect = MULTISELECT_NONE;
			this.DeactivateMouseMoveHandler();
		}
		else if (this.multiSelect != MULTISELECT_NONE && sourceEvent.type == "mousemove" && sourceEvent.button == 1)
		{
			// Multi-selecting cells - call only cell event handler if the cell that holds
			// the current element belongs to active table.
			var parentCell = this.FindParentCell(source);
			if (parentCell != null && this.table.contains(parentCell))
				returnValue = this.HandleCellEvent(parentCell);
			else
				returnValue = false;
		}
		else
		{
			switch(source.tagName.toUpperCase())
			{
				case "TABLE":
					returnValue = this.HandleTableEvent(source);
					break;

				case "TD":
				case "TH":
					returnValue = this.HandleCellEvent(source);
					break;

				default:
					if (sourceEvent.type == "mousedown")
					{
						this.InitActiveTable(source);
						var sourceCell = this.FindParentCell(source);
						if (sourceCell != null)
							returnValue = this.HandleCellEvent(sourceCell);
					}
					break;							
			}
		}
	}
	
	this.SaveLastEvent(sourceEvent);

	if (!returnValue)
	{
		sourceEvent.cancelBubble = true;
		sourceEvent.returnValue = false;		
	}
	
	return returnValue;
}

TableEdit.prototype.HandleHotkeys = function (sourceEvent)
{
	var returnValue = true;

	switch(sourceEvent.keyCode)
	{
		case KEYCODE_Q:
			// ctrl+shift+Q shows designtime html
			if (confirm("Copy content to clipboard?\n\n" + this.editorDocument.body.innerHTML))
				clipboardData.setData("Text", this.editorDocument.body.innerHTML);
			returnValue = false;
			break;

		default:
			var tool = this.hotkeys[sourceEvent.keyCode];
			if (tool)
			{
				tool.Handle_onclick();
				returnValue = false;
			}
	}
		
	return returnValue;
}

TableEdit.prototype.HandleKeydownEvent = function (sourceEvent)
{
	var keyCode = sourceEvent.keyCode;
	var returnValue = true;
	var source = sourceEvent.srcElement;
	this.event = sourceEvent;

	if (sourceEvent.ctrlKey)
	{
		if (eval(this.editorID + '_DisableCtrl'))
		{
			returnValue = false;
		}
		else if (!sourceEvent.shiftKey && !sourceEvent.altKey)
		{
			switch (sourceEvent.keyCode)
			{
				case KEYCODE_A:
					var fullRange = this.editorDocument.body.createTextRange();
					fullRange.moveToElementText( this.editorDocument.body );
					fullRange.select();
					this.DeselectAllCells();
					returnValue = false;
					break;

				case KEYCODE_K:
					this.ParagraphIsDiv = !this.ParagraphIsDiv;
					break;		

				case KEYCODE_Z:
					this.SaveCursor();
					break;
					
				case KEYCODE_Y:
					this.SaveCursor();
					break;

				case KEYCODE_C:
					if (this.IsEntireTableSelected())
					{
						this.CopyTable();
						returnValue = false;
					}
					else
					{
						if (checkValidTextSelection(this.editor))
						{
							var range = this.editorDocument.selection.createRange();
							
							if (range.htmlText.search(/^<a\s/i) != -1)
							{
								// Copy links as plain text into clipboard (to avoid IE paste bug later)
								clipboardData.setData('Text',range.htmlText);
								returnValue = false;
							}
						}
					}
					break;

				case KEYCODE_X:
					if (this.IsEntireTableSelected())
					{
						this.CutTable();
						returnValue = false;
					}
					break;
			}
		}
		else if (sourceEvent.shiftKey)
			returnValue = this.HandleHotkeys(sourceEvent);
	}			
	else
	{
		switch(sourceEvent.keyCode)
		{		
			case KEYCODE_DELETE:
				// Delete entire table if all cells are selected.
				if (this.IsEntireTableSelected())
				{	
					this.DeleteTable();
					returnValue = false;
				}
				break;
				
			case KEYCODE_TAB:
				this.editorDocument.selection.empty();
				break;
		}	
	}
	
	this.SaveLastEvent(sourceEvent);

	if (!returnValue)
	{
		sourceEvent.cancelBubble = true;
		sourceEvent.returnValue = false; 
	}
		
	return returnValue;
}

TableEdit.prototype.HandleKeyupEvent = function (sourceEvent)
{
	var returnValue = true;
	var source = sourceEvent.srcElement;
	this.event = sourceEvent;

	this.RefreshToolBySelection();

	this.SaveLastEvent(sourceEvent);

	if (!returnValue)
	{
		sourceEvent.cancelBubble = true;
		sourceEvent.returnValue = false; 
	}

	return returnValue;
}

TableEdit.prototype.ExecuteRangeAction = function (callbackFunc)
{
	var cells = this.selectedCells;

	if (cells.length > 0)
	{
		var range = this.editorDocument.body.createTextRange();
		var i;
		for(i = 0; i < cells.length; i++)
		{
			range.moveToElementText(cells[i]);
			range.select();		
			callbackFunc();
		}
		this.editorDocument.selection.empty();
	}
	else
		callbackFunc();
		
	this.editorDocument.body.focus();
}

function AddInfo(list, name, value)
{
	list.push(new Array(name, value));
}

function CreateDefaultFontColorList()
{  
  var fontList =
	{
		names: ['Aqua',  'Black', 'Blue',  'Fuchsia','Gray',  'Green', 'Maroon','Navy',  'Olive', 'Purple','Red',   'Silver','Teal',  'White' ],
		values:['00ffff','000000','0000ff','ff00ff', '808080','008000','800000','000080','808000','800080','ff0000','c0c0c0','008080','ffffff'],
		sizes: ['8','10','12','14','18','24','36']		
	};

  return fontList;
}

function GetActiveFontColorList()
{
	if (!window.fontColorList)
		window.fontColorList = CreateDefaultFontColorList();
	
	return window.fontColorList;	
}

TableEdit.prototype.ShowAbout = function (dialogUrl)
{
	var list = new Array();
	var index;
	var namevalue;

	window.EditorScriptVersions.sort();

	for(index = 0; index < window.EditorScriptVersions.length; index++)
	{
		var namevalue = window.EditorScriptVersions[index].split(' ');
		AddInfo(list, namevalue[0], namevalue[1]);
	}
	
	OpenDialog(dialogUrl, list, 260, 465);
}