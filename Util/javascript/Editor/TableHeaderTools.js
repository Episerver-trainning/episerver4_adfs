/*
 * TableHeaderTools.js	- JavaScript support routines for EPiServer
 * Copyright (c) 2004 ElektroPost Stockholm AB
*/

if (!window.EditorScriptVersions)
	window.EditorScriptVersions = new Array();
window.EditorScriptVersions.push("TableHeaderTools 1");

// Convert all selected cells to row header cells
function ConvertDataCellToRowHeader(tool)
{	
	var editorAPI = tool.editorAPI;
	
	if (editorAPI.selectedCells.length == 0 && editorAPI.lastActiveCell)
		editorAPI.SelectCell(editorAPI.lastActiveCell);
		
	RebuildTable(tool.editorAPI.table, ['scope'], ['rows'], 'th');
}

// Convert all selected cells to column header cells
function ConvertDataCellToColumnHeader(tool)
{
	var editorAPI = tool.editorAPI;
	
	if (editorAPI.selectedCells.length == 0 && editorAPI.lastActiveCell)
		editorAPI.SelectCell(editorAPI.lastActiveCell);

	RebuildTable(tool.editorAPI.table, ['scope'], ['cols'], 'th');
}

// Convert all selected cells to data cells
function ConvertHeaderToDataCell(tool)
{
	var editorAPI = tool.editorAPI;
	
	if (editorAPI.selectedCells.length == 0 && editorAPI.lastActiveCell)
		editorAPI.SelectCell(editorAPI.lastActiveCell);

	RebuildTable(tool.editorAPI.table, null, null, 'td');
}

