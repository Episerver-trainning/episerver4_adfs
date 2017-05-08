<%@ Page language="c#" Codebehind="TableEditor.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Editor.Tools.Dialogs.TableEditorCodeBehind" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
<HEAD>
<meta name="robots" content="noindex,nofollow">
<TITLE><%=EPiServer.Global.EPLang.Translate("/editor/tools/inserttable/toolheading")%></TITLE>
<META content="Microsoft Visual Studio 7.0" name=GENERATOR>
<meta content=http://schemas.microsoft.com/intellisense/ie5 name=vs_targetSchema><LINK href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css" type=text/css rel=stylesheet >
<script type='text/javascript'>

var _timeoutID = 0;
var _lastDisplayCol;
var _lastDisplayRow;

/*
 * JavaScript support routines for EPiServer
 * Copyright (c) 2003 ElektroPost Stockholm AB
*/
function initialize()
{
	var arguments = window.dialogArguments;
	c = document.getElementById('columns');
	r = document.getElementById('rows');
	b = document.getElementById('border');
	w = document.getElementById('width');
	if(arguments == null)
	{ // Setup defaults
		c.value = "3";
		r.value = "3";
		b.value = "0";
		w.value = "100%";
	}
	else
	{ // Editing current table, use existing values
		c.value = arguments[0]; // cols
		r.value = arguments[1]; // rows
		b.value = arguments[2]; // border
		w.value = arguments[3]; // width
		c.disabled = true;
		r.disabled = true;
	}
	buildTable();	
}

function buildTable()
{
	var str = "";
	var row;
	var previewElement = document.getElementById('preview');
	
	c = document.getElementById('columns');
	r = document.getElementById('rows');
	b = document.getElementById('border');

	nrOfCols = parseInt(c.value);
	nrOfRows = parseInt(r.value);
	sizeOfBorder = parseInt(b.value);

	displayCol = (nrOfCols == 0) ? '1' : nrOfCols; //(nrOfCols > 39 ? 39-sizeOfBorder : nrOfCols);
	displayRow = (nrOfRows == 0) ? '1' : nrOfRows; //(nrOfRows > 39 ? 39-sizeOfBorder : nrOfRows);

	if (displayCol > 30)
		displayCol = 30;

	if (displayRow > 30)
		displayRow = 30;

	if (_lastDisplayCol == displayCol && _lastDisplayRow == displayRow)
		return;

	_lastDisplayCol = displayCol;
	_lastDisplayRow = displayRow;

	row = '<tr>';
	for(index2=0; index2<displayCol; index2++)
	{	// Should get it's own "pixelsized" image or other element to use to render. // re
		row += '<td nowrap><img src="<%=EPiServer.Global.EPConfig.RootDir%>images/os.gif" width="1" height="1"></td>';
	}
	row += '</tr>';

	for(index=0; index<displayRow; index++)
		str += row;

	str = '<table border="' + (sizeOfBorder == 0 ? 1 : sizeOfBorder) + '" style=" width:110px; height:110px;" bgcolor="#ffffff" cellpadding="0" cellspacing="0" width="110" height="110">' +
			str + '</table>';
	document.getElementById('preview').innerHTML = str;
}

function setReturnValue()
{	// Will always return at least 1 row and 1 column, to prevent "invisible" tables
	var returnValues = new Array();
	nrOfCols = document.getElementById('columns').value;
	nrOfRows = document.getElementById('rows').value;
	returnValues[0] = (nrOfCols == 0) ? 1 : nrOfCols;
	returnValues[1] = (nrOfRows == 0) ? 1 : nrOfRows;
	returnValues[2] = document.getElementById('border').value;
	returnValues[3] = document.getElementById('width').value;
	returnValue = returnValues;
	//id, cols, rows, height, width, border, cellspacing, cellpadding, align, background, bgcolor, preview
}

function OkClick()
{
	setReturnValue();
	window.close();
}
function CancelClick()
{
	returnValue=false;
	window.close();
}

function TableChange()
{
	var previewElement = document.getElementById('preview');
	
	if (_timeoutID != 0)
		clearTimeout(_timeoutID);
		
	_timeoutID = setTimeout(buildTable, 1000);		
}


</script>
<link rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css">
</HEAD>
<BODY class="Normal" bottomMargin=0 leftMargin=0 topMargin=0 scroll=no onload=initialize() rightMargin=0>
<DIV class="Normal"	style="WIDTH: 250px; POSITION: relative; HEIGHT: 200px" ms_positioning="GridLayout">
	<span	id=preview style="Z-INDEX: 101; LEFT: 8px; OVERFLOW: hidden; WIDTH: 110px; POSITION: absolute; TOP: 8px; HEIGHT: 110px; resize: no"></span>
	<DIV	style="DISPLAY: inline; Z-INDEX: 102; LEFT: 132px; WIDTH: 57px; POSITION: absolute; TOP: 10px; HEIGHT: 15px" ms_positioning="FlowLayout"><%=EPiServer.Global.EPLang.Translate("/editor/tools/inserttable/rows")%></DIV>
	<input	id=rows onkeyup=TableChange(); style="Z-INDEX: 103; LEFT: 191px; WIDTH: 40px; POSITION: absolute; TOP: 8px" type=text onchange=TableChange(); name=rows> 
	<input	id=columns onkeyup=TableChange(); style="Z-INDEX: 104; LEFT: 191px; WIDTH: 40px; POSITION: absolute; TOP: 35px" type=text onchange=TableChange(); name=columns> 
	<DIV	style="DISPLAY: inline; Z-INDEX: 105; LEFT: 133px; WIDTH: 56px; POSITION: absolute; TOP: 37px; HEIGHT: 15px" ms_positioning="FlowLayout"><%=EPiServer.Global.EPLang.Translate("/editor/tools/inserttable/columns")%></DIV>
	<DIV 	style="DISPLAY: inline; Z-INDEX: 106; LEFT: 132px; WIDTH: 55px; POSITION: absolute; TOP: 65px; HEIGHT: 15px" ms_positioning="FlowLayout"><%=EPiServer.Global.EPLang.Translate("/editor/tools/inserttable/border")%></DIV>
	<input	id=border onkeyup=TableChange(); style="Z-INDEX: 107; LEFT: 191px; WIDTH: 40px; POSITION: absolute; TOP: 63px" type=text onchange=TableChange(); name=border> 
	<DIV	style="DISPLAY: inline; Z-INDEX: 108; LEFT: 132px; WIDTH: 55px; POSITION: absolute; TOP: 92px; HEIGHT: 15px" ms_positioning="FlowLayout"><%=EPiServer.Global.EPLang.Translate("/editor/tools/inserttable/width")%></DIV>
	<input	id=width onkeyup=TableChange(); style="Z-INDEX: 109; LEFT: 191px; WIDTH: 40px; POSITION: absolute; TOP: 91px" type=text onchange=TableChange(); name=width> 
	<input	type="submit"	id="okButton"		style="Z-INDEX: 110; LEFT: 36px; WIDTH: 80px; POSITION: absolute; TOP: 151px" onclick="OkClick();return false;" value="<%=EPiServer.Global.EPLang.Translate("/button/ok")%>"> 
	<input	type="reset"	id="cancelButton"	style="Z-INDEX: 111; LEFT: 128px; WIDTH: 80px; POSITION: absolute; TOP: 151px" onclick="CancelClick();" value="<%=EPiServer.Global.EPLang.Translate("/button/cancel")%>">
</DIV>
</BODY>
</HTML>
