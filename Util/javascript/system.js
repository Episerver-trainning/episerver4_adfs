/* 
 * system.js	- JavaScript support routines for EPiServer
 * Copyright (c) 2004 ElektroPost Stockholm AB
*/

function clickedTab( oTab, oBody, oInput, oActiveTab )
{
	if (oActiveTab)
		oActiveTab.Close();
	oActiveTab.oTab = oTab;
	oActiveTab.oBody = oBody;
	oActiveTab.oInput = oInput;
	oActiveTab.Open();
}

function TabControl(oTab,oBody,oInput)
{
	this.oTab	= oTab;
	this.oBody	= oBody;
	this.oInput	= oInput;
	this.Close = function()
	{
		if(typeof(this.oBody)=='string')
		{
			document.all[this.oBody].className='EPEdit-tabObjectInactive';
		}
		else
		{
			this.oBody.className='EPEdit-tabObjectInactive';
		}
		//this.oTab.className='EPEdit-tabInactive';
		SwitchTabClass(this.oTab,false);
		this.oInput.value='';
	}
	this.Open = function()
	{
		if(typeof(this.oBody)=='string')
		{
			document.all[this.oBody].className='EPEdit-tabObjectActive';
		}
		else
		{
			this.oBody.className='EPEdit-tabObjectActive';
		}
		
		//this.oTab.className='EPEdit-tabActive';
		SwitchTabClass(this.oTab,true);
		this.oInput.value='TabClicked';
	}
}

function SwitchTabClass(oTab,active)
{
		for(var i=0;i<oTab.children.length;i++)
		{
			if(active)
			{
				switch(oTab.children[i].className)
				{
					case 'EPEdit-tabInactiveLeft':
						oTab.children[i].className = 'EPEdit-tabActiveLeft';
						break;
					case 'EPEdit-tabInactiveRight':
						oTab.children[i].className = 'EPEdit-tabActiveRight';
						break;					
					case 'EPEdit-tabInactive':
						oTab.children[i].className = 'EPEdit-tabActive';
						break;
				}
			}
			else
			{
				switch(oTab.children[i].className)
				{
					case 'EPEdit-tabActiveLeft':
						oTab.children[i].className = 'EPEdit-tabInactiveLeft';
						break;
					case 'EPEdit-tabActiveRight':
						oTab.children[i].className = 'EPEdit-tabInactiveRight';
						break;					
					case 'EPEdit-tabActive':
						oTab.children[i].className = 'EPEdit-tabInactive';
						break;
				}
			
			}
		
		}
}

var _refreshPart=null;

function RefreshBodyPart(refreshPart,loadFromUrl,postName,postValue)
{		
	var frame = document.frames['__epLoaderFrame'];

	if(frame==null)
	{
		frame		= document.createElement("IFRAME");
		frame.id	= '__epLoaderFrame';
		frame.name	= '__epLoaderFrame';
		frame.attachEvent("onload",RefreshBodyPartOnLoad);
		frame.style.display = 'none';
		document.body.appendChild(frame);
	}
	_refreshPart		= refreshPart;
	
	if(loadFromUrl==null)
		loadFromUrl = document.location.href;
	
	if(postName!=null && postValue!=null)
	{
		if(frame.document.body!=null)
			frame.document.body.innerHTML = "";
		else
			frame.document.write('<HTML><BODY></BODY></HTML>');
			
		var form = document.createElement('<form name="form" method="post" action="' + loadFromUrl + '"></form>');
		var input = document.createElement('<input type="hidden" name="' + postName + '" value="">');
		form.appendChild(input);
		frame.document.body.innerHTML = form.outerHTML;
		if(postValue.value)
			frame.document.form.elements[postName].value = postValue.value;
		else
			frame.document.form.elements[postName].value = postValue;
		frame.document.form.submit();
	}
	else
		frame.document.location.href = loadFromUrl;
}

function RefreshBodyPartOnLoad()
{
	var frame	= document.frames['__epLoaderFrame'];
	var source	= this.document.all[_refreshPart];
	var target	= frame.document.all[_refreshPart];
		
	if(source!=null && target!=null)
	{
		source.insertAdjacentElement('beforeBegin',target);
		source.parentElement.removeChild(source);
	}
}

function DeleteRow( oRow )
{
	oRow.parentElement.deleteRow(oRow.rowIndex);
	return false;
}

function SecEnableAccess(sFieldPrefix, nAccess)
{
	var i;
	var oField;
	for (i = 1; i <= 32; i *= 2)
	{
		oField = document.all[sFieldPrefix + '_' + i];
		if (oField)
		{
			oField.checked = (oField.value <= nAccess);
		}
	}
	return false;
}

function SecMoveOption( oSelectFrom, oSelectTo )
{
	var oOption = document.createElement("OPTION");
	var nIndex = oSelectFrom.selectedIndex;
	
	if (nIndex >= 0)
	{
		oOption.text = oSelectFrom.options(nIndex).text;
		oOption.value = oSelectFrom.options(nIndex).value;
		oSelectTo.add(oOption);
		oSelectFrom.remove(nIndex);
	}
}

function ShowPopupBlockedInfo()
{
	alert("Popups are blocked for this site, you need to enable popups to access this function.");
}

function SecOpenSidBrowser( securityType, search, editDir, allowMultiple )
{
	var search = (search == '' ? '' : '&search=' + encodeURIComponent(search));
	var url = editDir + 'SidBrowser.aspx?type=' + securityType + search + '&AllowMultiple=' + allowMultiple;
	var dialogHeight = 260;
	var dialogWidth = 450;
	var top = (screen.height * 0.45) - (dialogHeight / 2);
	var left = (screen.width / 2) - (dialogWidth / 2);

	try
	{
		var dialogParameters = 'dialogLeft:' + left + 'dialogTop:' + top + 'dialogWidth:' + dialogWidth + 'px;dialogHeight:' + dialogHeight + 'px;help=no;resizable:yes;status=no;';
		var dialogArguments = window;
		window.showModalDialog(url, dialogArguments, dialogParameters);
	}
	catch (ex)
	{
		ShowPopupBlockedInfo();
	}

	return false;
}

function SecHandleSids( oSelect, func )
{
	var i,sValue,nSID,nType,sName,oOption;
	for (i=0; i<oSelect.length; i++) 
	{
		oOption = oSelect.item(i);
		sValue = oOption.value;
		nSID = parseInt(sValue.slice(0, sValue.indexOf(';')));
		nType = parseInt(sValue.slice(sValue.indexOf(';') + 1));
		sName = oOption.text;
		func(nSID, nType, sName);
	}
}

function onPageBrowser(root,id,info,value,language)
{
	try
	{
		var ret;
		ret = window.showModalDialog(root + 'Util/PageBrowser.aspx?id=' + id + '&info=' + info + '&value=' + value + '&epslanguage=' + language,window.document,'status:no; resizable:yes; help:no; dialogWidth:400px; dialogHeight: 550px; center:yes;scroll:no;');
		if (ret == 1) {
		    document.all[value].fireEvent('onchange');
		}
	}
	catch (ex)
	{
		ShowPopupBlockedInfo();
	}
}

// This function not used by EPiServer 4.51 and later (only left for backwards compatibility reasons).
function onGetDate(root, obj, title, noTime)
{
	if (!window.OpenDateBrowser)
	{
		alert('Cannot open date browser, the onGetDate function requires common.js');
		return false;
	}

	return OpenDateBrowser(root, obj, title, noTime);
}

function ToggleElementsInContainer(container,source)
{
	var form = getForm();
	for(var i=0;i<form.elements.length;i++)
	{
		if(IsElementInContainer(container,form.elements[i]) && form.elements[i]!=source)
			form.elements[i].disabled = !(form.elements[i].disabled);
	}
	
}

function SimulateFormField(name,value)
{
	var form = getForm();
	
	if(!form.elements[name])
	{
		var input = document.createElement('input');
		input.type = 'hidden';
		input.name = name;
		input.id = name;
		input.value = value;
		form.appendChild(input);
	}
}

function getForm()
{
	if(window.event==null)
		return document.forms[0];
	
	var form = findParentForm(window.event.srcElement);	
	
	if(!form && document.forms.length>0)
	{
		form=document.forms[0];
	}
		
	return form;
}

function findParentForm(obj)
{
	var tag = obj;
	while(tag=tag.parentElement)
	{
		if(tag.tagName.toLowerCase()=='form')
			return tag;
	}
	
	return null;
}

function IsElementInContainer(container,element)
{
	var tag = element;
	while(tag=tag.parentElement)
	{
		if(tag==container)
			return true;
	}
	
	return false;
}
