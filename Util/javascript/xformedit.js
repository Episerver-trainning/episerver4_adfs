/* 
 * xformedit.js	- JavaScript support routines for EPiServer
 * Copyright (c) 2005 ElektroPost Stockholm AB
*/
var KEYCODE_C = 67;
var KEYCODE_V = 86;

window.document.attachEvent('onkeydown', xFormKeyHandler);
window.document.attachEvent('onload', focusBody);

function xFormKeyHandler()
{
	var returnValue = true;	

	if (event.shiftKey && event.ctrlKey)
	{
		switch (event.keyCode)
		{
			case KEYCODE_C:
				returnValue = false;
				var formContent = document.getElementById('FormControl').innerHTML;
				if (confirm("Copy content to clipboard?\n\n" + formContent))
					clipboardData.setData("Text", formContent);
				break;
			case KEYCODE_V:
				returnValue = false;
				var formContent = document.getElementById('FormControl').innerHTML;
				var clipBoardContent = clipboardData.getData("Text");
				if (confirm("Paste content from clipboard?\n\n" + clipBoardContent))
					document.getElementById('FormControl').innerHTML = clipBoardContent;
				break;
		}
	}
	return returnValue;
}
function focusBody()
{
	window.document.body.focus();
}


var oDragField = null;
var oActiveField = null;
var oActiveCell = null;
var sCellContent;
var sCellEnd;
var sIdPrefix;
var nId;
var nFieldCount;
var nCellCount;

var sRadioProperties	= '';
var sSelectProperties	= '';
var sCheckboxProperties	= '';
var sFieldExistsAlert	= '';

var oPropertyImage;

function fieldAddRow( oTable )
{
	var oRow;
	var oCell;
	var nCells;
	
	if (oTable.rows.length == 0)
		nCells = 1;
	else
		nCells = oTable.cells.length / oTable.rows.length;
	oRow = oTable.insertRow();
	while (nCells -- > 0)
	{
		oCell = oRow.insertCell();
		fieldSetCell( oCell );
	}
}

function fieldAddColumn( oTable )
{
	var oRow;
	var oCell;
	var nRows;
	
	nRows = oTable.rows.length;
	if (nRows == 0)
	{
		fieldAddRow( oTable );
		return;
	}
	while (nRows -- > 0)
	{
		oCell = oTable.rows( nRows ).insertCell();
		fieldSetCell( oCell );
	}
}

function fieldInsertRow( oTable )
{
	var oRow;
	var oCell;
	var nCells;
	
	if (oTable.rows.length == 0)
		nCells = 1;
	else
		nCells = oTable.cells.length / oTable.rows.length;	
	oRow = oTable.insertRow( fieldRowIndex( oTable, oActiveCell ) );
	while (nCells -- > 0)
	{
		oCell = oRow.insertCell();
		fieldSetCell( oCell );
	}
}

function fieldInsertColumn( oTable )
{
	var oRow;
	var nCol;
	var oCell;
	var nRow;
	var nRows;
	
	if (oTable.rows.length == 0)
	{
		fieldInsertRow( oTable );
		return;
	}
	nRow = fieldRowIndex( oTable, oActiveCell );
	nCol = fieldColumnIndex( oTable, oActiveCell, nRow );
	
	nRows = oTable.rows.length;
	while (nRows -- > 0)
	{
		oCell = oTable.rows( nRows ).insertCell(nCol);
		fieldSetCell( oCell );
	}
}

function fieldDeleteRow( oTable, sConfirm )
{
	var nRow;
	
	if (oActiveCell == null)
		return;
	nRow = fieldRowIndex( oTable, oActiveCell );
	oTable.rows(nRow).style.backgroundColor = 'silver';
	if (confirm(sConfirm))
	{
		fieldPropertiesHideAll();
		oTable.deleteRow( nRow );
	}
	else
	{
		oTable.rows(nRow).style.backgroundColor = '';
	}
}

function fieldDeleteColumn( oTable, sConfirm )
{
	var oRow;
	var nCol;
	var oCell;
	var nRow;
	var nRows;
	var fDelete;
	
	if (oActiveCell == null)
		return;
		
	nRow = fieldRowIndex( oTable, oActiveCell );
	nCol = fieldColumnIndex( oTable, oActiveCell, nRow );
	
	nRows = oTable.rows.length;
	while (nRows -- > 0)
	{
		oTable.rows( nRows).cells(nCol).style.backgroundColor = 'silver';
	}
	if (fDelete = confirm(sConfirm))
	{
		fieldPropertiesHideAll();
	}
	
	nRows = oTable.rows.length;
	while (nRows -- > 0)
	{
		oTable.rows( nRows).cells(nCol).style.backgroundColor = '';
		if (fDelete)
			oCell = oTable.rows( nRows ).deleteCell(nCol);
	}
}

function fieldRowIndex( oTable, oCell )
{
	var nRow=-1;
	var oRows	= oTable.rows;
	
	if(!oCell)
		return 0;
	
	for (nRow = 0; nRow < oRows.length; nRow ++)
		if(oRows(nRow)==oCell.parentElement)
			return nRow;
	
	return -1;
}

function fieldColumnIndex( oTable, oCell, nRow )
{
	var nCol=-1;
	var oRows	= oTable.rows;
	var oCells	= oRows(nRow).cells;
	
	if(!oCell)
		return 0;
	
	for (nCol = 0; nCol < oCells.length; nCol ++)
		if(oCells(nCol)==oCell)
			return nCol;
	
	return -1;
}

function fieldSetCell( oCell )
{
	oCell.innerHTML = sCellContent;
	oCell.vAlign = 'top';
}

function fieldDisplayHTML( oFields )
{
	var s;
	var i;
	var oField;
	
	if (oFields == null)
		return false;

	oField = fieldSingleInstance( oFields, 0 );
	s = oField.parentElement.innerHTML;
	i = s.indexOf( sCellEnd );
}

function fieldCreateTextarea( sName, sValue, sClass, sRows, sCols, bRequired, label, tooltip, type )
{
	var s = createLabelField(label, sName);
	
	s = s + '<textarea name="' + sName + '"';
	if (sClass && sClass.length > 0)
		s = s + ' class="' + sClass + '"';
	if (sRows && sRows.length > 0)
		s = s + ' rows="' + sRows + '"';
	if (sCols && sCols.length > 0)
		s = s + ' cols="' + sCols + '"';
	if (bRequired && bRequired)
		s = s + ' required="true"';
	if(tooltip && tooltip.length > 0)
		s = s + ' title="' + tooltip + '"';
	if(type && type.length > 0)
		s = s + ' xsitype="' + type + '"';
	s = s + '>';
	if (sValue && sValue.length > 0)
		s = s + escape(sValue);	
	s = s + '</textarea>';
	
	return s;
}

function fieldCreateInput( sType, sName, sValue, sClass, sSize, bRequired, label, tooltip, type, horizontalAlign)
{
	var s = createLabelField(label, sName);
	
	s = s + '<input type="' + sType + '"';
	if (sName && sName.length > 0)
		s = s + ' name="' + sName + '"';
	if (sValue && sValue.length > 0)
		s = s + ' value="' + sValue + '"';
	else
		s = s + ' value=""';
	if (sClass && sClass.length > 0)
		s = s + ' class="' + sClass + '"';
	if (sSize && sSize.length > 0)
		s = s + ' size="' + sSize + '"';
	if (bRequired && bRequired)
		s = s + ' required="true"';
	if(tooltip && tooltip.length > 0)
		s = s + ' title="' + tooltip + '"';
	if(type && type.length > 0)
		s = s + ' xsitype="' + type + '"';
	if(horizontalAlign && horizontalAlign.length > 0)
		s = s + ' horizontalalign="true"';
	s = s + ' />';
	
	return s;
}

function createLabelField(label, inputID)
{
	if(label && label.length > 0)
		return '<label for="' + inputID + '">' + label + '</label>';
	return '';
}
function createLegendField(label)
{
	if(label && label.length > 0)
		return '<legend>' + label + '</legend>';
	return '';
}

function fieldCreateSelect( sName, sValue, sClass, bRequired, label, tooltip, type )
{
	var s = createLabelField(label, sName);
	
	s = s + '<select name="' + sName + '"';
	if (sClass && sClass.length > 0)
		s = s + ' class="' + sClass + '"';
	if (bRequired)
		s = s + ' required="true"';
	if(tooltip && tooltip.length > 0)
		s = s + ' title="' + tooltip + '"';
	if(type && type.length > 0)
		s = s + ' xsitype="' + type + '"';
	s = s + '>';
	s = s + sValue;
	s = s + '</select>';
	
	return s;
}

function fieldCreateOption( sValue )
{
	var s;
	
	s = '<option value="' + sValue + '">';
	s = s + sValue;
	s = s + '</option>';
	
	return s;
}

function fieldDeleteCell( oCell, sAlert )
{
	var fConfirm=true;
	
	if(sAlert)
		fConfirm = confirm(sAlert);

	if (fConfirm)
	{
		var oParent = oCell.parentElement;
		oParent.removeChild( oCell );
	}

	return true;
}
function getParentCell(element)
{
	var xFormControl = document.getElementById('FormControl');
	if(!xFormControl.contains(element))
		return null;
	var topCell = element;
	while(element != null && element != xFormControl)
	{
		element = element.parentElement;
		if(element.tagName == 'TD')
			topCell = element;
	}
	return topCell;
}
function getInputElements(element)
{
	var results = [];
	var list = element.all;

	for(i = 0; i < list.length; i++)
	{
		if (list(i).tagName.search(/^(input|textarea|select|button|span)$/i) == 0)
			results.push(list(i));
	}
	return results;
}
function hasFields(element)
{
	var results = getInputElements(element);
	return results.length > 0;
}
function getLabelValue(element)
{
	var parentCell = getParentCell(element);
	if(!parentCell)
		return '';
		
	if(parentCell.all.length < 1)
		return '';
		
	var list = parentCell.all;
	var labelRegEx = /^(LABEL)$/i;
	
	if(element.type != null && (element.type == 'radio' || element.type == 'checkbox'))
		labelRegEx = /^(LEGEND)$/i;

	for(i = 0; i < list.length; i++)
	{
		if (list(i).tagName.search(labelRegEx) == 0)
			return list(i).innerHTML;
	}
	return '';
}

function fieldProperties(parentCell)
{
	if(!parentCell)
		parentCell = getParentCell(event.srcElement);
	if(!parentCell)
		return false;

	var oFields = getInputElements(parentCell);
			
	fieldDisplayProperties(parentCell,oFields)
}

function fieldDisplayProperties(oSrc,oFields)
{
	var oField;

	if(oSrc.tagName == "TABLE")
	{
		return false;
	}
	
	if (oFields.length == 0)
	{
		formActivateCell( oSrc, oField );
		return false;
	}

	fieldPropertiesHideAll();
	fieldDisplayHTML( oFields );

	oField = fieldSingleInstance( oFields, 0 );
	formActivateCell( oSrc, oField );
	
	switch ( fieldType(oField) )
	{
		case 'textarea':
			oActiveField = oField;
			fieldPropertiesTextarea( oField );
			break;
		case 'select':
			oActiveField = oField;
			fieldPropertiesSelect( oFields );
			break;
		case 'text':
			oActiveField = oField;
			fieldPropertiesText( oField );
			break;
		case 'checkbox':
			oActiveField = oFields;
			fieldPropertiesCheckbox( oFields );
			break;
		case 'radio':
			oActiveField = oFields;
			fieldPropertiesRadio( oFields );
			break;
		case 'span':
			oActiveField = oField;
			fieldPropertiesSpan( oField );
			break;
		case 'submit':
			oActiveField = oField;
			fieldPropertiesSubmit( oField );
			break;
	}
	return true;
}

function fieldPropertiesHideAll()
{
	formInactivateCell();
	id_propertiestextarea.style.display = 'none';
	id_propertiestext.style.display		= 'none';
	id_propertiesmultiple.style.display = 'none';
	id_propertiesspan.style.display		= 'none';
	id_propertiesbutton.style.display	= 'none';
	id_verticallayout.style.display		= '';
	oActiveField = null;
	oActiveCell = null;
}

function fieldPropertiesDelete(sAlert)
{
	if (oActiveCell == null)
	{
		return false;
	}
	
	if(sAlert)
	{
		if(!confirm(sAlert))
		{
			return false;
		}
	}
	
	oActiveCell.innerHTML = sCellContent;
	fieldPropertiesHideAll();
}

function fieldPropertiesGetName( oFields )
{
	var oField = fieldSingleInstance( oFields, 0 );
	
	if (oField == null || !oField.name)
		return '';
	return oField.name;
}

function fieldPropertiesTextarea( oField )
{
	document.getElementById('__textareaname').value = oField.name;
	document.getElementById('__textareaclass').value = oField.className;
	document.getElementById('__textarealabel').value = getLabelValue(oField);
	document.getElementById('__textareawidth').value = oField.cols;
	document.getElementById('__textareaheight').value = oField.rows;		
	
	if (oField.required)
		document.getElementById('__textarearequired').checked = true;
	else
		document.getElementById('__textarearequired').checked = false;
	if(oField.title)
		document.getElementById('__textareatooltip').value = oField.title;
	else
		document.getElementById('__textareatooltip').value = '';
	if(oField.xsitype)
		textareaType.value = oField.xsitype;
	else
		textareaType.value = '';
		
	id_propertiestextarea.style.display = 'block';
	setTimeout('focusField("__textareaname")', 10);
}

function fieldPropertiesTextareaSave( )
{
	var id = oActiveField.id;
	var val = oActiveField.value;
	oActiveField.parentElement.innerHTML = fieldCreateTextarea( document.getElementById('__textareaname').value, '', document.getElementById('__textareaclass').value, document.getElementById('__textareaheight').value, document.getElementById('__textareawidth').value,document.getElementById('__textarearequired').checked, document.getElementById('__textarealabel').value, document.getElementById('__textareatooltip').value, textareaType.value);
	fieldPropertiesHideAll();
}

function fieldPropertiesText( oField )
{
	document.getElementById('__textname').value = oField.name;
	document.getElementById('__textsize').value = oField.size;
	document.getElementById('__textlabel').value = getLabelValue(oField);
	document.getElementById('__textclass').value = oField.className;
	
	if (oField.required)
		document.getElementById('__textrequired').checked = true;
	else
		document.getElementById('__textrequired').checked = false;
	if(oField.title)
		document.getElementById('__texttooltip').value = oField.title;
	else
		document.getElementById('__texttooltip').value = '';
	if(oField.xsitype)
		inputType.value = oField.xsitype;
	else
		inputType.value = '';
	
	id_propertiestext.style.display = 'block';
	setTimeout('focusField("__textname")', 10);
	
}
function focusField(fieldIdToFocus)
{
	document.getElementById(fieldIdToFocus).select();
}

function fieldPropertiesTextSave( oField )
{
	oActiveField.parentElement.innerHTML = fieldCreateInput( oActiveField.type, document.getElementById('__textname').value, oActiveField.value, document.getElementById('__textclass').value, document.getElementById('__textsize').value,document.getElementById('__textrequired').checked, document.getElementById('__textlabel').value, document.getElementById('__texttooltip').value, inputType.value);
	fieldPropertiesHideAll();
}

function fieldPropertiesSpan( oField )
{
	document.getElementById('__spanvalue').value = oField.innerHTML;
	document.getElementById('__spanclass').value = oField.className;
	id_propertiesspan.style.display = 'block';
	setTimeout('focusField("__spanvalue")', 10);
}

function fieldPropertiesSubmit( oField )
{
	GetValueString( document.getElementById('__buttonlabel'), oField.value );
	GetValueString( document.getElementById('__buttonclass'), oField.className );
	GetValueString( document.getElementById('__buttontooltip'), oField.title );
	
	var fullAction = oField.action;
	
	if(!fullAction || fullAction == "undefined" || fullAction.length <= 0)
		fullAction = database
		
	var action;
	var options;
	var sender = '';
	var receiver = '';
	var subject = '';
	var indexOfQuestionMark = fullAction.indexOf('?');
	
	if(indexOfQuestionMark > 0)
	{
		action = fullAction.substr(0, fullAction.indexOf('?'));
		options = fullAction.substr(fullAction.indexOf('?to=') + 4);
		if(options && options.length > 0)
		{
			options = options.replace('&amp;', '&');
			var tmp = options.split('&from=');
			receiver = tmp[0];
			tmp =  tmp[1].split('&subject=');
			sender = tmp[0];
			subject = tmp.length > 1 ? tmp[1] : '';
		}
	}
	else
		action = fullAction;
	
	switch (action)
	{
		case mail:
		case mailAndDatabase:
			document.getElementById('FormEmailSender').value = sender;
			document.getElementById('FormEmailRecipient').value = receiver;
			document.getElementById('FormEmailSubject').value = subject;
			submitAction.value = action;
			break;
		case database:
			submitAction.value = action;
			break;
		default:
			document.getElementById('FormCustomUrl').value = action;
			submitAction.value = customUrl;
			break;
	}
		
	formActionChange(submitAction);
	
	id_propertiesbutton.style.display = 'block';
	setTimeout('focusField("__buttonlabel")', 10);
}
function fieldCreateSubmit( cssClass, label, tooltip, action, emailSender, emailRecipient, formCustomUrl, emailSubject )
{
	
	s = '<input type="submit" onclick="return(false)"';
	if (label && label.length > 0)
		s = s + ' value="' + label + '"';
	if (cssClass && cssClass.length > 0)
		s = s + ' class="' + cssClass + '"';
	if(tooltip && tooltip.length > 0)
		s = s + ' title="' + tooltip + '"';
	
	s = s + ' action="' + getActionString(action, emailSender, emailRecipient, formCustomUrl, emailSubject ) + '"';

	s = s + '></input>';	
	
	return s;
}
function getActionString( action, emailSender, emailRecipient, formCustomUrl, emailSubject )
{
	switch (action)
	{
		case mail:
		case mailAndDatabase:
			return action + '?to=' + emailRecipient + '&from=' + emailSender + '&subject=' + emailSubject;
			break;
		case database:
			return action;
			break;
		default:
			return formCustomUrl;
			break;
	}
}
function GetValueString( destination, value )
{
	if(value)
		destination.value = value;
	else
		destination.value = '';
}
function fieldPropertiesSpanSave()
{
	oActiveField.parentElement.innerHTML = '<span ' + fieldGetSavedClassString(document.getElementById('__spanclass')) + '>' + document.getElementById('__spanvalue').value + '</span>';

	fieldPropertiesHideAll();
}

function fieldPropertiesSubmitSave()
{
	var label = document.getElementById('__buttonlabel').value;
	var cssClass = document.getElementById('__buttonclass').value;
	var tooltip = document.getElementById('__buttontooltip').value;
	var emailSender = document.getElementById('FormEmailSender').value;
	var emailRecipient = document.getElementById('FormEmailRecipient').value;
	var customUrl = document.getElementById('FormCustomUrl').value;
	var emailSubject = document.getElementById('FormEmailSubject').value;
	
	oActiveField.parentElement.innerHTML =  fieldCreateSubmit(cssClass, label, tooltip, submitAction.value, emailSender, emailRecipient, customUrl, emailSubject);
	fieldPropertiesHideAll();
}

function fieldPropertiesSelect( oFields )
{
	id_headingmultiple.innerText = sSelectProperties;
	id_verticallayout.style.display = 'none';
	fieldPropertiesMultiple( oFields );
}

function fieldPropertiesSelectSave()
{
	fieldPropertiesMultipleSave(oActiveField);
	fieldPropertiesMultiple( oFields );
}

function fieldPropertiesCheckbox( oFields )
{
	id_headingmultiple.innerText = sCheckboxProperties;
	fieldPropertiesMultiple( oFields );
}

function fieldPropertiesMultiple( oFields )
{
	var i;
	var s;
	var fVertical;
	var oMasterField = fieldSingleInstance( oActiveField, 0 );
	var sTagType = oMasterField.tagName.toLowerCase();
		
	fHorizontal = oMasterField.horizontalalign != null;
	
	document.getElementById('__multipleclass').value = oMasterField.className;
	document.getElementById('__multiplelayoutvertical').checked = !fHorizontal;
	document.getElementById('__multiplelayouthorizontal').checked = fHorizontal;
	document.getElementById('__multiplename').value = fieldPropertiesGetName( oFields );
	document.getElementById('__multiplelabel').value = getLabelValue(oMasterField);
	
	if (oMasterField.required)
		document.getElementById('__multiplerequired').checked = true;
	else
		document.getElementById('__multiplerequired').checked = false;
	if(oMasterField.title)
		document.getElementById('__multipletooltip').value = oMasterField.title;
	else
		document.getElementById('__multipletooltip').value = '';
	if(oMasterField.xsitype)
		multipleType.value = oMasterField.xsitype;
	else
		multipleType.value = '';
	
	if (oFields.length == 1 && oFields[0].tagName.toLowerCase() == "select")
		oFields = oFields[0];

	s = '';
	for (i = 0; i < oFields.length; i ++ )
	{
		s = s + fieldPropertiesMultipleSet( oFields[i] );
	}

	document.getElementById('__multipleoptions').value = s;
	
	id_propertiesmultiple.style.display = 'block';
	setTimeout('focusField("__multiplename")', 10);
}

function fieldPropertiesMultipleSet( oField )
{	
	if (oField.tagName == "OPTION")
	{
		if (oField.text != '')
		{
			return oField.text + '\n';
		}
		else
		{
			return oField.value + '\n';
		}
	}
	else if (oField.tagName == "INPUT")
	{
		if (oField.nextSibling != null 
			&& oField.nextSibling.nodeName == "LABEL"
			&& oField.nextSibling.innerText.length > 0)
		{
			return oField.nextSibling.innerText + '\n';
		}
		else
		{
			return oField.value + '\n';
		}
	}
	else if(oField.nextSibling == null)
	{
		return '';
	}
	
	return oField.nextSibling.innerHTML + '\n';
}

function fieldPropertiesMultipleSave()
{
	// Rebuild radio buttons / checkboxes with selected values
	var sName = document.getElementById('__multiplename').value;
	var oMasterField = fieldSingleInstance( oActiveField, 0 );
	var sTagType = oMasterField.tagName.toLowerCase();
	var s = '';
	
	if (document.getElementById('__multiplelayouthorizontal').checked)
		oMasterField.horizontalalign = '1';
	else
		oMasterField.horizontalalign = null;

	var label = document.getElementById('__multiplelabel').value;
	if(sTagType != 'select')
		s = createLegendField(label);
	a = fieldPropertiesMultipleTokenize(document.getElementById('__multipleoptions').value);
		
	for (i = 0; i < a.length; i ++)
	{
		if(sTagType == 'select')
			s = s + fieldCreateOption(a[i]);
		else
		{
			if(a[i] == '')
				continue;
			s = s + fieldCreateInput(oMasterField.type, sName, a[i], document.getElementById('__multipleclass').value, '',document.getElementById('__multiplerequired').checked, '', document.getElementById('__multipletooltip').value, multipleType.value, oMasterField.horizontalalign);
			s = s + '<label>' + a[i] + '</label>';
			if (document.getElementById('__multiplelayoutvertical').checked && i < a.length - 1)
				s = s + '<br />';
		}
	}
	
	if(a.length == 0 && sTagType != 'select')
		s = s + fieldCreateInput(oMasterField.type, sName, '', document.getElementById('__multipleclass').value, '', document.getElementById('__multiplerequired').checked, document.getElementById('__multiplelabel').value, document.getElementById('__multipletooltip').value, multipleType.value, oMasterField.horizontalalign);

	if(sTagType=='select')
	{
		oActiveCell.innerHTML = fieldCreateSelect(sName, s, document.getElementById('__multipleclass').value,document.getElementById('__multiplerequired').checked, document.getElementById('__multiplelabel').value, document.getElementById('__multipletooltip').value, multipleType.value);
	}
	else
	{
		oActiveCell.innerHTML = '<fieldset>' + s + '</fieldset>';
	}
	fieldPropertiesHideAll();
}

function fieldPropertiesMultipleTokenize(s)
{
	var a = new Array;
	var idx = 0;
	var tmp='';

	for(var i=0;i<s.length;i++)
	{
		if(s.substr(i,1).indexOf('\r')==0)
			continue;
		if(s.substr(i,1).indexOf('\n')<0)
		{
			tmp+=s.substr(i,1);
		}
		else
		{
			a[idx++] = tmp;
			tmp='';
		}
	}
	
	if(tmp.length>0)
		a[idx++] = tmp;
	
	return a;
}

function fieldPropertiesMultipleDelete( nIndex )
{
	var oMasterField;
	
	if (oActiveField.length == null)
		return;
	if (oActiveField.length < 2 || nIndex >= oActiveField.length)
		return;
		
	oMasterField = fieldSingleInstance( oActiveField, 0 );
	oMasterField.parentElement.removeChild( oActiveField(nIndex) );
	fieldPropertiesMultiple( oActiveField );
}

function fieldPropertiesRadio( oFields )
{
	id_headingmultiple.innerText = sRadioProperties;
	if (oFields.Required)
		document.getElementById('__multiplerequired').checked = true;
	else
		document.getElementById('__multiplerequired').checked = false;
	fieldPropertiesMultiple( oFields );
	return;
}

function fieldStartDrag( oField )
{
	oDragField = document.createElement('IMG');
	oDragField.type = oField.type;
	oDragField.src = oField.src;
	document.body.appendChild( oDragField );

	fieldPropertiesHideAll();
	
	oDragField.style.position = 'absolute';
	oDragField.style.cursor = 'move';
	oDragField.onmouseup = fieldDrop;
	oDragField.onmousemove = fieldMove;
	oDragField.setCapture();
	fieldMove();
}

function fieldMove()
{
	if (oDragField)
	{
		var nBodyWidth	= document.body.scrollLeft;
		var nBodyHeight = document.body.scrollTop;

		oDragField.style.pixelLeft = nBodyWidth + event.clientX;
		oDragField.style.pixelTop = nBodyHeight + event.clientY;
	}
}

function cellStartDrag()
{
	var oField = window.event.srcElement;
	if(oField == document.getElementById('__imageactive'))
	{
		oDragField = document.createElement('IMG');
		oDragField.type = oField.type;
		oDragField.src = oField.src;
		document.body.appendChild( oDragField );
		
		oDragField.style.position = 'absolute';
		oDragField.style.cursor = 'move';
		oDragField.onmouseup = fieldDrop;
		oDragField.onmousemove = fieldMove;
		oDragField.setCapture();
		fieldMove();
	}
}

function fieldIdString()
{
	var s = sIdPrefix + nId;
	
	nId ++;
	return s;
}

function fieldGetSavedClassString( textField )
{
	var spanClass = textField.value;
	if (spanClass == null || spanClass.length == 0)
		return '';
	return ' class="' + spanClass + '"';
}

function fieldDrop()
{
	var oCell;
	
	oDragField.releaseCapture();
	document.body.removeChild(oDragField);
	oCell = fieldGetValidTarget( event.srcElement, event.x, event.y );
	
	if ( oCell != null )
	{
		var sDragFieldType = oDragField.type;
		
		if (hasFields(oCell))
		{
			alert(sFieldExistsAlert);
		}
		else if(oActiveField)
		{
			formInactivateCell();
			var sVerticalLayout		= oActiveCell.verticalLayout;
			var sInnerHTML			= oActiveCell.innerHTML;
			
			fieldPropertiesDelete(null);			
			fieldPropertiesHideAll();
			
			oCell.verticalLayout	= sVerticalLayout;
			oCell.innerHTML			= sInnerHTML;
			
			fieldProperties(oCell);
		}
		else
		{
			switch ( sDragFieldType ) 
			{
				case 'textarea':
					oCell.innerHTML = fieldCreateTextarea( '', '', '', '', '',false, '','', '');
					break;
				case 'select':
					oCell.innerHTML = fieldCreateSelect( '' , false, '', false, '', '', '');
					break;
				case 'span':
					oCell.innerHTML = '<span></span>';
					break;
				case 'radio':
				case 'checkbox':
					oCell.innerHTML = fieldCreateInput( sDragFieldType, '', 'on', '','',false, '', '', '');
					break;
				case 'submit':
					oCell.innerHTML = fieldCreateSubmit('', '', '', database, '', '', '', '');
					break;
				default:
					oCell.innerHTML = fieldCreateInput( sDragFieldType, '', '', '', '',false, '', '', '');
					break;
			}
			fieldProperties(oCell);
		}
	}
	
	oDragField = null;
	return false;
}

function fieldType( oField )
{
	var sTagName;
	
	if (oField == null)
		return null;
	
	sTagName = oField.tagName.toLowerCase();
	
	switch (sTagName)
	{
		case 'span':
		case 'textarea':
		case 'select':
		case 'option':
		case 'button':
			return sTagName;
		case 'input':
			return oField.type.toLowerCase();
	}

	return null;
}

function fieldValue( oField )
{
	var sTagName;
	
	if (oField == null)
		return null;
	
	sTagName = oField.tagName.toLowerCase();
	
	switch (sTagName)
	{
		case 'span':
			return oField.innerHTML;
		case 'textarea':
			return oField.innerText;
		case 'option':
		case 'select':
		case 'input':
			return oField.value;
	}

	return null;
}

function fieldSingleInstance( oFields, nIndex )
{
	var oField = null;
	
	if (oFields == null)
		return null;
	
	if (oFields.tagName != null)
	{
		oField = oFields;
	}
	else
	{
		if (oFields.length > nIndex)
			oField = oFields[nIndex];
	}
	return oField;
}

function fieldGetValidTarget( oObject, x, y )
{
	var oElement;
	var oCell;
	var fCellFound = false;
	
	if (oObject == null)
		return null;
	
	oElement = document.elementFromPoint(event.x,event.y);

	while ( (oElement != null) && (oElement.parentElement != oElement) )
	{
		if (oElement.tagName == 'TD')
		{
			oCell = oElement;
			fCellFound = true;
		}
		if ((oElement.id == 'id_matrix') && fCellFound)
		{
			return oCell;
		}
		oElement = oElement.parentElement;
	}
	return null;
}

function formPopulateForSubmit( oForm )
{
	fieldPropertiesHideAll();
	var content = document.getElementById('__formcontent');
	var xFormControl = document.getElementById('FormControl');
	content.value = xformcontrol.innerHTML;
	return true;
}

function formCreateCell( oForm, oCell, nRow, nCol )
{
	var sValue;
	var oPostField;
	var nField;
	var nParentField = 0;
	
	// Check for fields in this cell
	oFields = getInputElements(oCell);
	
	if (oFields.tagName != null)
	{
		oPostField = formCreateField( oFields, nRow, nCol, 0 );
		oForm.appendChild( oPostField );
		nParentField = 1;
	}
	
	if (oFields.length)
	{
		for (nField = 0; nField < oFields.length; nField ++)
		{
			oPostField = formCreateField( oFields[nField], nRow, nCol, nField + nParentField );
			oForm.appendChild( oPostField );
		}
	}

	// Create field for this cell
	sValue = nRow.toString() + '[&]' + nCol.toString() + '[&]';
	if (oCell.verticalLayout != null)
		sValue += '1[&]';
	else
		sValue += '0[&]';
	sValue += escape(oCell.hasField) + '[&]';
	if (oCell.className)
		sValue += escape(oCell.className);
	
	oPostField = document.createElement('input');
	oPostField.type = 'hidden';
	oPostField.name = '__formcell' + nCellCount++;
	oPostField.value = sValue;
	oForm.appendChild( oPostField );
}

function formCreateField( oField, nRow, nCol, nPos )
{
	var sValue;
	var oPostField;
	var sId = oField.id;
	var sName = oField.name;
	
	// We do not have name/id:s on option-tags, use info from parent (=select tag)
	if (sId.length == 0)
	{
		sId = oField.parentElement.id;
		sName = oField.parentElement.name;
	}
	
	sValue = escape(sId) + '[&]' + fieldType( oField ) + '[&]' + sName + '[&]' + nPos;
	sValue += '[&]' + fieldValue(oField) + '[&]' + escape(oField.className);
	if (fieldType( oField ) == 'text')
	{
		sValue += '[&]' + oField.size + '[&]';
	}
	else if (fieldType( oField ) == 'textarea')
	{
		sValue += '[&]' + oField.cols + '[&]' + oField.rows;
	}
	else
		sValue += '[&][&]';
	
	if (oField.getAttribute('Required',0)=='true')
		sValue += '[&]1';
	else
		sValue += '[&]0';
	
	oPostField = document.createElement('input');
	oPostField.type = 'hidden';
	oPostField.name = '__formfield' + nFieldCount++;
	oPostField.value = sValue;
	
	return oPostField;
}

function formActivateCell(oCell,oField)
{	
	if(oCell.tagName == "TABLE")
		return;
		
	if (oField != null)
	{
		oPropertyImage					= new Image();
		oPropertyImage.src				= document.getElementById('__image' + fieldType(oField) ).src;
		oPropertyImage.id				= '__imageactive';
		oPropertyImage.align			= 'left';
		oPropertyImage.style.cursor		= 'move'; 
		oPropertyImage.style.position	= 'relative';
		oPropertyImage.style.left		= -10;
		oPropertyImage.style.top		= 0;
		oPropertyImage.style.zindex		= 10;
		oPropertyImage.attachEvent ('onmousedown',cellStartDrag);
		oCell.insertAdjacentElement('afterbegin',oPropertyImage);
	}
	else
	{
		fieldPropertiesHideAll();
	}
	oCell.style.backgroundColor = 'silver';
	oActiveCell = oCell;
}

function formInactivateCell()
{
	if(oActiveCell)
	{	
		oActiveCell.style.backgroundColor = '';
		if(oPropertyImage!=null)
			if(oPropertyImage.parentElement==oActiveCell)
				oActiveCell.removeChild(oPropertyImage);
			
		oPropertyImage=null;
	}
}