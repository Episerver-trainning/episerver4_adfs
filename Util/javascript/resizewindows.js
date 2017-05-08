/*
 * resizewindows.js	- JavaScript support routines for EPiServer
 * Copyright (c) 2003 ElektroPost Stockholm AB
*/

var oDragField;
var oOrgField;
var horizontalDifference;
var verticalDifference;
var leftBoundary;
var rightBoundary;
var topBoundary;
var bottomBoundary;

function findPersonalizedSettings(createSaveFields)
{
	var tables = document.all.tags("table");
	var changedValuesFound = false;
	
	for(var i = 0 ; i < tables.length ; i++)
	{
		var currentTable = tables(i);
		for(var j = 0 ; j < currentTable.rows.length ; j++)
		{
			var currentCell = currentTable.rows(j);
			var resizeKey = currentCell.getAttribute("ResizeID");
			
			if(resizeKey)
			{
				var newValue = currentCell.getAttribute('PersonalizedHeight');
				if(newValue != null)
				{
					if(createSaveFields == true)
						SimulateFormField(resizeKey,newValue);
					changedValuesFound = true;
				}
			}
		}
		for(var k = 0 ; k < currentTable.cells.length ; k++)
		{
			var currentCell = currentTable.cells(k);
			var resizeKey = currentCell.getAttribute("ResizeID");
			
			if(resizeKey)
			{
				var newValue = currentCell.getAttribute('PersonalizedWidth'); 
				if(newValue != null)
				{
					if(createSaveFields == true)
						SimulateFormField(resizeKey,newValue);
					changedValuesFound = true;
				}
			}
		}
	}
	return changedValuesFound;
}
function horizontalDragStart(event)
{
	oOrgField = window.event.srcElement;

	window.document.body.setCapture();
	window.document.body.attachEvent("onmousemove", horizontalDragGo);
	window.document.body.attachEvent("onmouseup",   horizontalDragStop);		

	oDragField					= document.createElement('SPAN');
	oDragField.style.zIndex		= 1000;
	oDragField.style.position	= 'absolute';
	oDragField.style.borderLeft = 'solid 1px #000000';
	oDragField.style.width		= '1px';
	oDragField.style.height		= window.event.srcElement.offsetHeight;
	oDragField.style.pixelTop	= GetTotalOffsetTop(window.event.srcElement);
	oDragField.style.pixelLeft	= GetTotalOffsetLeft(window.event.srcElement);
	
	horizontalDifference = event.x - GetTotalOffsetLeft(oOrgField);
	document.body.appendChild( oDragField );	
	
	if(oOrgField.nextSibling.style.display = 'none')
			oOrgField.nextSibling.style.display = '';//Must be done, otherwise we might get null exceptions
			
	leftBoundary = GetTotalOffsetLeft(oOrgField.previousSibling);
	rightBoundary = GetTotalOffsetLeft(oOrgField.nextSibling) + oOrgField.nextSibling.clientWidth;
	
	horizontalDragGo();

	window.event.cancelBubble = true;
	window.event.returnValue = false;
}

function GetTotalOffsetTop(currentContainer)
{
	var totalOffset = 0;	
	while(currentContainer)
	{
		totalOffset += currentContainer.offsetTop;
		currentContainer = currentContainer.offsetParent;		
	}
	return totalOffset;
}
function GetTotalOffsetLeft(currentContainer)
{
	var totalOffset = 0;	
	while(currentContainer)
	{
		totalOffset += currentContainer.offsetLeft;
		currentContainer = currentContainer.offsetParent;
	}
	return totalOffset;
}

function horizontalDragGo()
{
	if (oDragField)		
		oDragField.style.pixelLeft = getCalculatedXPosition();
}
function verticalDragGo()
{
	if (oDragField)
		oDragField.style.pixelTop = getCalculatedYPosition();
}
function getCalculatedXPosition()
{
	var calculatedNewPosition = event.x - horizontalDifference;
	if(leftBoundary > calculatedNewPosition)
		return leftBoundary;
	else if(rightBoundary < calculatedNewPosition)
		return rightBoundary;
	else
		return calculatedNewPosition;
}
function getCalculatedYPosition()
{
	var calculatedNewPosition = event.y - verticalDifference;
	if(topBoundary > calculatedNewPosition)
		return topBoundary;
	else if(bottomBoundary < calculatedNewPosition)
		return bottomBoundary;
	else
		return calculatedNewPosition;
}

function horizontalDragStop(event) 
{
	window.document.body.detachEvent("onmousemove", horizontalDragGo);
	window.document.body.detachEvent("onmouseup",   horizontalDragStop);		
	window.document.body.releaseCapture();

	var newXPosition = getCalculatedXPosition();
	
	resizeHorizontalFields(newXPosition);
	document.body.removeChild(oDragField);
}
function resizeHorizontalFields(newXPosition)
{
	var newWidth;
	var targetObject;

	if(oOrgField.nextSibling && oOrgField.nextSibling.style.width!='')
	{
		targetObject = oOrgField.nextSibling;
		
		if(targetObject.style.display = 'none')
			targetObject.style.display = '';//Must be done, otherwise we might get null exceptions
		newWidth = (GetTotalOffsetLeft(oOrgField) + targetObject.offsetWidth) - newXPosition;		
	}
	else
	{
		targetObject = oOrgField.previousSibling;
		
		if(targetObject.style.display = 'none')
			targetObject.style.display = '';//Must be done, otherwise we might get null exceptions
		newWidth = newXPosition - GetTotalOffsetLeft(oOrgField.previousSibling);		
	}
	if(!targetObject.getAttribute('DefaultWidth'))
	{
		var defaultWidth = targetObject.style.pixelWidth;
		targetObject.setAttribute('DefaultWidth', defaultWidth);
	}
	handleNewWidth(targetObject, newWidth);
}
function verticalDragStart(event)
{
	oOrgField = window.event.srcElement.parentElement;

	window.document.body.setCapture();
	window.document.body.attachEvent("onmousemove", verticalDragGo);
	window.document.body.attachEvent("onmouseup",   verticalDragStop);		

	oDragField						= document.createElement('SPAN');
	oDragField.style.zIndex			= 1000;
	oDragField.style.position		= 'absolute';
	oDragField.style.borderTop		= 'solid 1px #000000';
	oDragField.style.height			= '1px';
	oDragField.style.width			= window.event.srcElement.offsetWidth;
	oDragField.style.pixelTop		= GetTotalOffsetTop(window.event.srcElement);
	oDragField.style.pixelLeft		= GetTotalOffsetLeft(window.event.srcElement);
	verticalDifference				= event.y - oDragField.style.pixelTop;
	document.body.appendChild( oDragField );
	
	topBoundary		= GetTopBoundary(oOrgField);
	bottomBoundary	= GetBottomBoundary(oOrgField);

	verticalDragGo();

	window.event.cancelBubble = true;
	window.event.returnValue = false;
}
function GetTopBoundary(oOrgField)
{
	var topBoundary		= GetTotalOffsetTop(oOrgField.previousSibling);	
	if(oOrgField.previousSibling.getAttribute('requiredheight') != null)
	{
		var requiredHeight	= new Number(oOrgField.previousSibling.getAttribute('requiredheight'));
		topBoundary = topBoundary + requiredHeight;
	}
	return topBoundary;
}
function GetBottomBoundary(oOrgField)
{
	var bottomBoundary = GetTotalOffsetTop(oOrgField) + oOrgField.nextSibling.clientHeight;
	if(oOrgField.nextSibling.getAttribute('requiredheight') != null)
	{
		var requiredHeight	= new Number(oOrgField.nextSibling.getAttribute('requiredheight'));
		bottomBoundary = bottomBoundary - requiredHeight;
	}
	return bottomBoundary;
}
function verticalDragStop(event) 
{			
	window.document.body.detachEvent("onmousemove", verticalDragGo);
	window.document.body.detachEvent("onmouseup",   verticalDragStop);		
	window.document.body.releaseCapture();

	var newYPosition = getCalculatedYPosition();
	resizeVerticalFields(newYPosition);
	document.body.removeChild(oDragField);
}
function resizeVerticalFields(newYPosition)
{
	var newHeight;
	var targetObject;

	if(oOrgField.nextSibling && oOrgField.nextSibling.style.height!='')
	{
		targetObject = oOrgField.nextSibling;
		if(targetObject.style.display = 'none')
			targetObject.style.display = '';//Must be done, otherwise we might get null exceptions
		newHeight = (GetTotalOffsetTop(oOrgField) + targetObject.offsetHeight) - newYPosition;
	}
	else
	{
		targetObject = oOrgField.previousSibling;
		if(targetObject.style.display = 'none')
			targetObject.style.display = '';//Must be done, otherwise we might get null exceptions
		newHeight = newYPosition - GetTotalOffsetTop(oOrgField.previousSibling);
	}
	if(!targetObject.getAttribute('DefaultHeight'))
	{
		var defaultHeight = targetObject.style.pixelHeight;
		targetObject.setAttribute('DefaultHeight', defaultHeight);
	}
	handleNewHeight(targetObject, newHeight);	
}
function resetHeight(resizeField)
{
	oOrgField = resizeField;
	var targetObject;
	
	if(oOrgField.nextSibling && oOrgField.nextSibling.style.height!='')
		targetObject = oOrgField.nextSibling;
	else if(oOrgField.previousSibling)
		targetObject = oOrgField.previousSibling;

	var defaultHeight = targetObject.getAttribute('DefaultHeight');
	if(defaultHeight != null)
		handleNewHeight(targetObject, defaultHeight);

	oOrgField.removeAttribute('PersonalizedHeight');
}
function resetWidth(resizeField)
{	
	oOrgField = resizeField;
	var targetObject;

	if(oOrgField.nextSibling && oOrgField.nextSibling.style.width!='')
		targetObject = oOrgField.nextSibling;		
	else
		targetObject = oOrgField.previousSibling;
		
	var defaultWidth = targetObject.getAttribute('DefaultWidth');
	if(defaultWidth != null)
		handleNewWidth(targetObject, defaultWidth);

	oOrgField.removeAttribute('PersonalizedWidth');
}
function minimizeHeight(resizeField)
{
	oOrgField = resizeField;
	var targetObject;
	
	if(oOrgField.nextSibling && oOrgField.nextSibling.style.height!='')
		targetObject = oOrgField.nextSibling;
	else if(oOrgField.previousSibling)
		targetObject = oOrgField.previousSibling;
	
	targetObject.setAttribute('DefaultHeight', 0);
	handleNewHeight(targetObject, 0);
}
function giveHeightToAbove(resizeField)
{
	oOrgField = resizeField;
	
	if(oOrgField.nextSibling)
	{
		bottomBoundary	= GetBottomBoundary(oOrgField);
		resizeVerticalFields(bottomBoundary);
	}
}
function stealHeightFromAbove(resizeField)
{
	oOrgField = resizeField;
	
	if(oOrgField.previousSibling)
	{
		topBoundary	= GetTopBoundary(oOrgField);
		resizeVerticalFields(topBoundary);
	}
}
function handleNewWidth(targetObject, newWidth)
{
	if(newWidth<=10)
	{
		targetObject.style.pixelWidth = 1;
		//targetObject.style.display = 'none';
	}
	else
	{
		targetObject.style.pixelWidth = newWidth;
		targetObject.style.display = '';
	}
	oOrgField.setAttribute('PersonalizedWidth', targetObject.style.pixelWidth);
}
function handleNewHeight(targetObject, newHeight)
{
	if(newHeight<=10)
	{
		targetObject.style.pixelHeight = 1;
		//targetObject.style.display = 'none';
	}
	else
	{
		targetObject.style.pixelHeight = newHeight;
		targetObject.style.display = '';
	}
	oOrgField.setAttribute('PersonalizedHeight', targetObject.style.pixelHeight);
}