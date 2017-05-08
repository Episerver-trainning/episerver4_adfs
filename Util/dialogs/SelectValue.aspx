<%@ Page language="c#" Codebehind="SelectValue.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Util.Dialogs.SelectValue" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
<HEAD>
	<script type='text/javascript'>
		document.write('<TITLE>' + window.dialogArguments[0] + '</TITLE>');
	</script>
	<meta name="robots" content="noindex,nofollow">
	<META content="Microsoft Visual Studio 7.0" name=GENERATOR>
	<meta content=http://schemas.microsoft.com/intellisense/ie5 name=vs_targetSchema>
	<link rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css">
	<script type="text/javascript" src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/common.js"></script>
	<script type="text/javascript" src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/Editor/Constants.js"></script>
	<script type="text/javascript" src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/system.js"></script>
	<style>
		.longInput	{ float: left; width: 210px; position: relative; }
		TD.selected	{ color: white; background-color: #666688; }
	</style>
</HEAD>
<script type="text/c#" runat="server">
	private string TranslateText(string languageKey)
	{
		return EPiServer.Global.EPLang.Translate("/editor/tools/cellproperties/" + languageKey);
	}	
</script>
<script type='text/javascript'>
/*
 * JavaScript support routines for EPiServer
 * Copyright (c) 2003 ElektroPost Stockholm AB
*/

var _selectedCells = [];

Object.prototype.IsArray = function() 
{
	return this.constructor == Array;
}
Array.prototype.Contains = function (obj)
{
	for(var i = 0; i < this.length; i++)
		if (this[i] == obj)
			return true;				

	return false;
}
function initialize()
{
	_separatorChar			= window.dialogArguments[SELECTDLG_ARGS_SEPARATOR_CHAR] ? window.dialogArguments[SELECTDLG_ARGS_SEPARATOR_CHAR] : '|';
	var allValues			= window.dialogArguments[SELECTDLG_ARGS_VALUES];
	var selectedValues		= window.dialogArguments[SELECTDLG_ARGS_SELECTED_VALUE].split(_separatorChar);
	var helpText			= window.dialogArguments[SELECTDLG_ARGS_TEXT];
	var displayInputArea	= window.dialogArguments[SELECTDLG_ARGS_ALLOW_INPUT] ? window.dialogArguments[SELECTDLG_ARGS_ALLOW_INPUT] : true;

	FillValuesList(allValues.sort());
	SelectValues(selectedValues);
	
	// Should this dialog allow input of new values or not?
	if(!displayInputArea)
	{	// Adjust the size of the item list and hide the input field
		itemList.style.height = parseInt(itemList.style.height) + parseInt(inputArea.style.height);
		inputArea.style.display = 'none';
	}

	// Is there a help text to be displayed?
	if(helpText)
		explanatoryText.innerText = helpText;
	else
		explanatoryText.style.display = 'none';
}
function FillValuesList(values)
{
	ClearSelected();
	ClearTable(valuesTable);

	for(var i = 0; i < values.length; i++)
	{		
		var row = valuesTable.insertRow();
		var cell = row.insertCell();			
		cell.innerHTML = values[i];
		cell.width = '100%';
	}
}
function ClearTable(table)
{
	for(var i = table.rows.length - 1; i >= 0; i--)
		table.deleteRow(0);
}
function ClearSelected()
{
	for(var index = _selectedCells.length - 1; index >= 0; index--)
	{
		var cell = _selectedCells[index];
		
		cell.className = cell.className.replace('selected','');
	}
	_selectedCells = [];
}
function SelectValues(valuesToSelect)
{
	var cells = valuesTable.cells;
	
	if (!valuesToSelect.IsArray())
	{
		if (_selectedCells.length == 1 && _selectedCells[0].innerText == valuesToSelect)
		{	// The clicked cell is the only one already selected - deselect it.
			ClearSelected();
			return;
		}

		valuesToSelect = [valuesToSelect];
	}

	if (!event.ctrlKey && _selectedCells.length > 0)
		ClearSelected();
	
	for(var i = 0; i < cells.length; i++)
	{	
		var cell = cells[i];

		if (valuesToSelect.Contains(cell.innerText))
		{
			// Check if the cell was already selected
			if(_selectedCells.Contains(cell))
			{
				// Deselect the cell, leave the rest of the selected cells intact
				var tempArray = [];
				for(var j = 0; j < _selectedCells.length; j++)
				{
					if(_selectedCells[j] != cell)
					{
						tempArray.push(_selectedCells[j]);
					}
				}
				_selectedCells = tempArray;
				cell.className = cell.className.replace('selected','');
			}
			else
			{	// The cell was previously not selected, select it
				_selectedCells.push(cell);
				cell.className = 'selected';
			}
		}
	}
}
function GetSelectedValues()
{
	// If a value is entered in the input textbox, return only that value
	var newVal = newValue.value;
	if(newVal)
		return newVal;
	
	// If not, return all values selected in the table/list
	var values = [];

	for(var i = _selectedCells.length - 1; i >= 0; i--)
		values.push(_selectedCells[i].innerText);
	
	return values.join(_separatorChar);
}
function buildReturnValue()
{
	var returnValues = new Array();	
	returnValues[0] = GetSelectedValues();

	return returnValues;
}
function HandleKeyDown()
{
	if (event.keyCode == 13)
		OkClick();
}
function HandleKeyUp()
{
	var enteredValue = newValue.value.length > 0;
	
	if(enteredValue)
		ClearSelected();

	valuesTable.disabled = enteredValue;
}
function SelectClick()
{
	var element = event.srcElement;

	if (element.tagName.toLowerCase() == 'td')
	{
		SelectValues(element.innerText);	
	}
}
function OkClick()
{
	returnValue = buildReturnValue();
	window.close();
}
function CancelClick()
{
	returnValue = false;
	window.close();
}
</script>

<BODY bottomMargin=0 leftMargin=0 topMargin=0 scroll=no onload="initialize()" rightMargin=0 style="padding-left: 7px">
<div style="WIDTH:100%; POSITION:relative; HEIGHT:100%; PADDING:5px;" ms_positioning="GridLayout">
	
	<div id="explanatoryText" style="width:100%; padding-bottom:10px;"></div>

	<!-------------------->
	<!-- SELECT SECTION -->
	<!-------------------->
	<div id="itemList" style="width:100%; overflow-y:scroll; height:92px; border:1px groove lightgray;">		
		<table id="valuesTable" border="0" style="width:100%;" onclick="SelectClick();">
		</table>
	</div>

	<!------------------->
	<!-- INPUT SECTION -->
	<!------------------->
	<div id="inputArea" style="width:100%; padding-top:10px; height:40px;">
		<div style="padding-bottom:3px;"><%=EPiServer.Global.EPLang.Translate("/editor/tools/selectvalue/newvalue")%></div>
		<input class="longInput" id=newValue tabindex=3 type=text size=46 onkeydown="HandleKeyDown();" onkeyup="HandleKeyUp();">
	</div>
	
	<!-------------------->
	<!-- FOOTER SECTION -->
	<!-------------------->
	<div class="rowContainer" style="position: absolute; top: 220px;">
		<input	id=cancelButton tabindex=23 style="float:right; margin-right:5px; width:80px; position:relative;" onclick="CancelClick()" type=reset value="<%=EPiServer.Global.EPLang.Translate("/button/cancel")%>">
		<input	id=okButton tabindex=22 style="float:right; margin-right:10px; width:80px; position:relative;" onclick="OkClick()" type=submit value="<%=EPiServer.Global.EPLang.Translate("/button/ok")%>"> 
	</div>
</div>
</BODY>
</HTML>