/* 
 * formedit.js	- JavaScript support routines for EPiServer
 * Copyright (c) 2001-2003 ElektroPost Stockholm AB
*/
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
		if (nRows == 0)
			oCell.width = 100;
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
		if (nRows == 0)
			oCell.width = 100;
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
	oCell.height = 10;
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
	id_htmlsource.innerText = s.slice( i + sCellEnd.length );
	//id_propertieshtml.style.display = 'block';
}

function fieldCreateTextarea( sId, sName, sValue, sClass, sRows, sCols, bRequired )
{
	var s;
	
	s = '<textarea id="' + sId + '"';
	if (sName.length > 0)
		s = s + ' name="' + sName + '"';
	if (sClass.length > 0)
		s = s + ' class="' + sClass + '"';
	if (sRows.length > 0)
		s = s + ' rows="' + sRows + '"';
	if (sCols.length > 0)
		s = s + ' cols="' + sCols + '"';
	if (bRequired)
		s = s + ' Required="1"';
	s = s + '>';
	if (sValue.length > 0)
		s = s + escape(sValue);
	s = s + '</textarea>';
	
	return s;
}

function fieldCreateInput( sType, sId, sName, sValue, sClass, sSize, bRequired )
{
	var s;
	
	s = '<input type="' + sType + '" id="' + sId + '"';
	if (sName.length > 0)
		s = s + ' name="' + sName + '"';
	if (sValue.length > 0)
		s = s + ' value="' + sValue + '"';
	if (sClass.length > 0)
		s = s + ' class="' + sClass + '"';
	if (sSize.length > 0)
		s = s + ' size="' + sSize + '"';
	if (bRequired)
		s = s + ' Required="1"';
	s = s + '>';
	
	if(sType=='radio' || sType=='checkbox')
		s = s + sValue;
	
	return s;
}

function fieldCreateSelect( sId, sName, sValue, sClass, bRequired )
{
	var s;
	
	s = '<select id="' + sId + '"';
	if (sName.length > 0)
		s = s + ' name="' + sName + '"';
	if (sClass.length > 0)
		s = s + ' class="' + sClass + '"';
	if (bRequired)
		s = s + ' Required="1"';
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

function fieldProperties()
{
	var oSrc;
	var oField;
	var oFields;
	
	if(event.srcElement.tagName!='TD')
		oSrc = event.srcElement.parentElement;
	else
		oSrc = event.srcElement;
	
	oFields = document.all[oSrc.hasField];
	
	if (oFields == null)
		return false;
		
	fieldDisplayProperties(oSrc,oFields)
}

function fieldDisplayProperties(oSrc,oFields)
{
	var oField;	
	
	if (oFields == null)
		return false;
	
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
			fieldPropertiesSelect( oField );
			break;
		case 'text':
			oActiveField = oField;
			fieldPropertiesText( oField );
			break;
		case 'span':
			oActiveField = oField;
			fieldPropertiesSpan( oField );
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
	}
	return true;
}

function fieldPropertiesHideAll()
{
	formInactivateCell();
	id_propertiestextarea.style.display = 'none';
	id_propertiestext.style.display = 'none';
	id_propertiesmultiple.style.display = 'none';
	id_propertieshtml.style.display = 'none';
	id_propertiesspan.style.display = 'none';
	id_verticallayout.style.display = '';
	oActiveField = null;
	oActiveCell = null;
}

function fieldPropertiesDelete(sAlert)
{
	var oMasterField;
	
	if (oActiveField == null)
		return false;

	oMasterField = fieldSingleInstance( oActiveField, 0 );	
	
	if(sAlert)
	{
		if(!confirm(sAlert + ' ' + oMasterField.name + '?'))
			return false;
	}
		
	fieldPropertiesHideAll();
	oMasterField.parentElement.hasField = null;
	oMasterField.parentElement.innerHTML = sCellContent;
}

function fieldPropertiesGetName( oFields )
{
	var oField = fieldSingleInstance( oFields, 0 );
	
	if (oField == null)
		return '';
	return oField.name;
}

function fieldPropertiesTextarea( oField )
{
	__textareawidth.value = oField.cols;
	__textareaheight.value = oField.rows;
	__textareaname.value = oField.name;
	if (oField.Required)
		__textarearequired.checked = true;
	else
		__textarearequired.checked = false;
	__textareaclass.value = oField.className;
	id_propertiestextarea.style.display = 'block';
}

function fieldPropertiesTextareaSave( )
{
	var id = oActiveField.id;
	var val = oActiveField.value;
	oActiveField.parentElement.innerHTML = fieldCreateTextarea( oActiveField.id, __textareaname.value, '', __textareaclass.value, __textareaheight.value, __textareawidth.value,__textarearequired.checked);
	fieldPropertiesHideAll();
	document.all[id].value = val;
}

function fieldPropertiesText( oField )
{
	__textname.value = oField.name;
	__textsize.value = oField.size;
	if (oField.Required)
		__textrequired.checked = true;
	else
		__textrequired.checked = false;
	__textclass.value = oField.className;
	id_propertiestext.style.display = 'block';
}

function fieldPropertiesTextSave( oField )
{
	oActiveField.parentElement.innerHTML = fieldCreateInput( oActiveField.type, oActiveField.id, __textname.value, oActiveField.value, __textclass.value, __textsize.value,__textrequired.checked);
	fieldPropertiesHideAll();
}

function fieldPropertiesSpan( oField )
{
	__spanvalue.value = oField.innerHTML;
	__spanclass.value = oField.className;
	id_propertiesspan.style.display = 'block';
}

function fieldPropertiesSpanSave()
{
	oActiveField.parentElement.innerHTML = '<span name="' + oActiveField.id + '" id="' + oActiveField.id + '"' + fieldGetSavedClassString(__spanclass) + '>' + __spanvalue.value + '</span>';

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
	var oSingle = fieldSingleInstance( oFields, 0 );
		
	fVertical = oSingle.parentElement.verticalLayout != null;
	
	__multipleclass.value = '';
	__multiplelayoutvertical.checked = fVertical;
	__multiplelayouthorizontal.checked = !fVertical;
	__multiplename.value = fieldPropertiesGetName( oFields );
	if (oFields.Required)
		__multiplerequired.checked = true;
	else
		__multiplerequired.checked = false;
	
	if (oFields.length == null)
	{
		s = fieldPropertiesMultipleSet( oFields );
		__multipleclass.value = oFields.className;
	}
	else
	{
		s = '';
		for (i = 0; i < oFields.length; i ++ )
		{
			s = s + fieldPropertiesMultipleSet( oFields(i), i );
			__multipleclass.value = oFields(i).className;
		}
	}
	__multipleoptions.value = s;
	
	id_propertiesmultiple.style.display = 'block';
}

function fieldPropertiesMultipleSet( oField, i )
{
	return oField.value + '\n';
}

function fieldPropertiesMultipleSave()
{
	// Rebuild radio buttons / checkboxes with selected values
	var sName = __multiplename.value;
	var oMasterField = fieldSingleInstance( oActiveField, 0 );
	var sTagType = oMasterField.tagName.toLowerCase();
	
	if (__multiplelayoutvertical.checked)
		oMasterField.parentElement.verticalLayout = '1';
	else
		oMasterField.parentElement.verticalLayout = null;

	s = '';
	a=fieldPropertiesMultipleTokenize(__multipleoptions.value);
		
	for (i = 0; i < a.length; i ++)
	{
		if(sTagType=='select')
			s = s + fieldCreateOption(a[i]);
		else
		{
			s = s + fieldCreateInput(oMasterField.type, oMasterField.id, sName, a[i], __multipleclass.value, '',false);
			if (__multiplelayoutvertical.checked && i < a.length - 1)
				s = s + '<br>';
		}
	}
	
	if(a.length==0 && sTagType!='select')
		s = s + fieldCreateInput(oMasterField.type, oMasterField.id, sName, '', __multipleclass.value, '', false);

	if(sTagType=='select')
		oMasterField.parentElement.innerHTML = fieldCreateSelect(oMasterField.id, sName,s, __multipleclass.value,__multiplerequired.checked);
	else
		oMasterField.parentElement.innerHTML = s;
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
		__multiplerequired.checked = true;
	else
		__multiplerequired.checked = false;
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
	if(oField==document.all['__imageactive'])
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
	var sId;
	var sName;
	
	oDragField.releaseCapture();
	document.body.removeChild(oDragField);
	oCell = fieldGetValidTarget( event.srcElement, event.x, event.y );
	
	if ( oCell != null )
	{	
		var oExistingField = fieldSingleInstance(document.all[oCell.hasField], 0);
		var sDragFieldType = oDragField.type;
		
		oCell.attachEvent('onclick',fieldProperties);
		
		if (oCell.hasField)
		{
			alert(sFieldExistsAlert);
		}
		else if(oActiveField)
		{
			formInactivateCell();
			var sHasField			= oActiveCell.hasField;
			var sVerticalLayout		= oActiveCell.verticalLayout;
			var sInnerHTML			= oActiveCell.innerHTML;
			
			fieldPropertiesDelete(null);			
			fieldPropertiesHideAll();
			
			oCell.hasField			= sHasField;
			oCell.verticalLayout	= sVerticalLayout;
			oCell.innerHTML			= sInnerHTML;
			
			fieldDisplayProperties(oCell,document.all[oCell.hasField]); 
		
		}
		else
		{
			sId = fieldIdString();
			oCell.hasField = sId;
			switch ( sDragFieldType ) 
			{
				case 'textarea':
					oCell.innerHTML = fieldCreateTextarea(sId, sId, '', '', '', '',false);
					break;
				case 'select':
					oCell.innerHTML = '<select id="' + sId + '" name="' + sId + '"></select>';
					break;
				case 'span':
					oCell.innerHTML = '<span id="' + sId + '"></span>';
					break;
				case 'radio':
				case 'checkbox':
					oCell.innerHTML = fieldCreateInput( sDragFieldType, sId, sId, 'on', '','',false);
					break;
				default:
					oCell.innerHTML = fieldCreateInput( sDragFieldType, sId, sId, '', '', '',false);
					break;
			}
			fieldDisplayProperties(oCell,document.all[oCell.hasField]);
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
			oField = oFields(nIndex);
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
	var oRows = id_matrix.rows;
	var oCells;
	var oCell;
	var nRow;
	var nCol;
	var fAtLeastOneField = false;
	
	nFieldCount = 0;
	nCellCount = 0;
	for (nRow = 0; nRow < oRows.length; nRow ++)
	{
		oCells = oRows(nRow).cells;
		for (nCol = 0; nCol < oCells.length; nCol ++)
		{
			oCell = oCells(nCol);
			if (oCell.hasField == null)
				continue;
			formCreateCell( oForm, oCell, nRow, nCol );
			fAtLeastOneField = true;
		}
	}
	return fAtLeastOneField;
}

function formCreateCell( oForm, oCell, nRow, nCol )
{
	var sValue;
	var oPostField;
	var nField;
	var nParentField = 0;
	
	// Check for fields in this cell
	oFields = document.all[oCell.hasField];
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
			oPostField = formCreateField( oFields( nField ), nRow, nCol, nField + nParentField );
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
	
	if (oField.getAttribute('Required',0)==1)
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
	oCell.style.borderStyle='solid';
	oCell.style.borderWidth='2px';
	oCell.style.borderColor='#888888';

	oPropertyImage					= new Image();
	oPropertyImage.src				= document.all['__image' + fieldType(oField) ].src;
	oPropertyImage.id				= '__imageactive';
	oPropertyImage.align			= 'left';
	oPropertyImage.style.cursor		= 'move'; 
	oPropertyImage.style.position	= 'relative';
	oPropertyImage.style.left		= -10;
	oPropertyImage.style.top		= 0;
	oPropertyImage.style.zindex		= 10;
	oPropertyImage.attachEvent ('onmousedown',cellStartDrag);
	oCell.insertAdjacentElement('afterbegin',oPropertyImage);
	
	oActiveCell = oCell;
}

function formInactivateCell()
{
	if(oActiveCell)
	{
		oActiveCell.style.borderStyle	='';
		oActiveCell.style.borderWidth	='1px';
		oActiveCell.style.borderColor	='';
		
		if(oPropertyImage!=null)
			if(oPropertyImage.parentElement==oActiveCell)
				oActiveCell.removeChild(oPropertyImage);
			
		oPropertyImage=null;
	}
}