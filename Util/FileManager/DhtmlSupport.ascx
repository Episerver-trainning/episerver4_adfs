<%@ Control Language="c#" AutoEventWireup="false" Codebehind="DhtmlSupport.ascx.cs" Inherits="EPiServer.Util.FileManager.DhtmlSupport" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<input type="hidden" id="MultiFileSelection" name="MultiFileSelection" value=""/>
<input type="hidden" id="MultiDirectorySelection" name="MultiDirectorySelection" value=""/>

<asp:PlaceHolder Visible="False" ID="OfficeTools" Runat="server">
	<object
		id="oWebTools" tabindex="-1"
		width="0"
		height="0"
		classid="clsid:10DDD8C9-4F48-442B-B499-7901AB28125C"
		VIEWASTEXT>
	</object>
</asp:PlaceHolder>

<script type="text/javascript">

var AccessLevelRead = <%=((int)EPiServer.Security.AccessLevel.Read).ToString()%>;
var AccessLevelCreate = <%=((int)EPiServer.Security.AccessLevel.Create).ToString()%>;
var AccessLevelEdit = <%=((int)EPiServer.Security.AccessLevel.Edit).ToString()%>;
var AccessLevelDelete = <%=((int)EPiServer.Security.AccessLevel.Delete).ToString()%>;
var AccessLevelAdminister = <%=((int)EPiServer.Security.AccessLevel.Administer).ToString()%>;

function QueryNoAccess(requiredAccess)
{
	return true;
}

function QueryAccess(requiredAccess)
{
	var hasAccess = false;
	for(var i=0;i<selectedDirectoriesArray.length;i++)
	{
		for(var x=0;x<dirLookupArray.length;x++)
		{
			if(dirLookupArray[x]==selectedDirectoriesArray[i])
			{
				hasAccess = (dirAclArray[x] & requiredAccess)==requiredAccess;
				if(!hasAccess)
					return false;
			}	
		}
	}
	
	for(var i=0;i<selectedFilesArray.length;i++)
	{
		for(var x=0;x<fileLookupArray.length;x++)
		{
			if(fileLookupArray[x]==selectedFilesArray[i])
			{
				hasAccess = (fileAclArray[x] & requiredAccess)==requiredAccess;
				if(!hasAccess)
					return false;
			}
		}
	}
	return hasAccess;
}

function EditInOffice(evt)
{

	if(<%=EPiServer.Security.UnifiedPrincipal.Current.IsPermitted(EPiServer.Security.Permission.ClientTools) ? "false" : "true"%>)
	{
		alert('<%=EPiServer.Global.EPLang.TranslateForScript("/clienttools/installstatus/officeaddin/noaccess")%>');
		return;
	}

	var obj = document.getElementById('oWebTools');
	var fileName = selectedFilesArray[0];
	var downloadUrl = '<%=EPiServer.Global.EPConfig.HostUrl + EPiServer.Global.EPConfig.RootDir.Substring(0,EPiServer.Global.EPConfig.RootDir.Length-1)%>';

	downloadUrl += '<%=EPiServer.DataAbstraction.Converter.ToScriptSafeString(CurrentFileManager.CurrentDirectory)%>';
	downloadUrl += '/' + fileName;
	downloadUrl += '?action=checkout';
	
	var officeType = GetOfficeType(fileName);
	if(officeType==0)
	{
		alert('This document is not a Microsoft Office document');
		return;
	}
	
	try
	{
		obj.CheckOut(downloadUrl,fileName,officeType,'<%=EPiServer.Global.EPConfig.HostUrl + EPiServer.Global.EPConfig.RootDir.Substring(0,EPiServer.Global.EPConfig.RootDir.Length-1)%>','<%=EPiServer.DataAbstraction.Converter.ToScriptSafeString(CurrentFileManager.CurrentDirectory)%>');
	}
	catch(oErr)
	{
		alert("You need to install the EPiServer 4.50 Office Add-In to use this feature");
	}
}


function IsOfficeDocument()
{
	for(var i=0;i<selectedFilesArray.length;i++)
	{
		if(GetOfficeType(selectedFilesArray[i])==0)
			return false;
	}
	return true;
}

function GetOfficeType(str)
{
    var ext = str.substr(str.length-4,4).toLowerCase();
    if(ext=='.doc')
		return 1;
	if(ext=='.xls')
		return 2;
	if(ext=='.ppt')
		return 3;
		
	return 0;
}

function IsFileCheckedOut()
{
	var isCheckedOut = false;
	
	for(var i=0;i<selectedFilesArray.length;i++)
	{
		for(var x=0;x<fileLookupArray.length;x++)
		{
			if(fileLookupArray[x]==selectedFilesArray[i])
			{
				isCheckedOut = fileCheckedOutArray[x];
				if(!isCheckedOut)
					return false;
			}
		}
	}
	return isCheckedOut;
}

function GetSourceElement(evt)
{
	var srcElement;
	if(evt==null)
		evt = window.event;
	if(evt.srcElement)
		srcElement = evt.srcElement;
	else
		srcElement = evt.target;

	return srcElement;
}

function GetSourceLink(evt)
{
	var srcElement = GetSourceElement(evt);

	if(srcElement.tagName=='IMG')
		return srcElement.parentNode;
	else
		return srcElement;
}

function OpenSaveAsDialog(path)
{

	var w = window.open('about:blank','saveAsWin','width=600,height=500,scrollbars=yes');
	wdoc = w.document;
	wdoc.open();
	wdoc.write( '<html><head>' );
	wdoc.write( '<META HTTP-EQUIV="refresh" content=".5; URL=' + path + '">' );
	wdoc.write( '</head><body></body>' );
	wdoc.close();					

}


function handleDrag(evt)
{
	var dhtmlPath = GetSourceLink(evt).dhtmlPath;
	
	if(dhtmlPath!=null)
	{
		if(evt==null)
			evt = window.event;
			
		evt.dataTransfer.effectAllowed = 'copy';
		evt.dataTransfer.setData('Text',dhtmlPath);
		evt.cancelBubble = true;
	}
}

function handleContextMenu(evt)
{
	if(evt==null)
		evt = window.event;
	handleItemClick(evt,true);
	evt.returnValue=false;
	return false;
}

function handleClick(evt)
{
	if(evt==null)
		evt = window.event;
				
	var srcElement = GetSourceElement(evt);
	if(srcElement.getAttribute('IsToolEnabled')=='true')
		return;
		
	if(!evt.ctrlKey)
		ClearSelectedItems();
	
	handleItemClick(evt,false);
}

function handleItemClick(evt,viewContextMenu)
{

	var sourceElement = GetSourceLink(evt);
	var dhtmlType = sourceElement.getAttribute('dhtmlType');
	var isFavorite = sourceElement.getAttribute('isFavorite');
	
	if(dhtmlType!=null)
	{
		var path = sourceElement.getAttribute('entryName');
		
		if(!isSelected(path,dhtmlType))
		{
			if(viewContextMenu)
				ClearSelectedItems();
			handleSelection(evt,path,dhtmlType);
		}
		
		evt.returnValue		= false;
	    evt.cancelBubble	= true;

	}
	else if(viewContextMenu)
		ClearSelectedItems();
		
	window.IsMultiSelection =		(selectedFilesArray.length + selectedDirectoriesArray.length)>1;
	window.IsMultiFileSelection =		selectedFilesArray.length>1;
	window.IsFileSelection =		dhtmlType=='File' && !window.IsMultiSelection;
	window.IsDirectorySelection =	dhtmlType=='Directory' && !window.IsMultiSelection;
	window.IsAnySelection = (selectedFilesArray.length + selectedDirectoriesArray.length)>0;
	window.IsFavoriteSelection = isFavorite!=null && isFavorite=="true";
	
	UpdateCommandTools();

	if(viewContextMenu)
		<%=menu.ClientID%>.Show(null, null, true);

}

function UpdateCommandTools()
{
	var oDeleteButton = document.getElementById('DeleteButtonImage');
		
	if(window.IsAnySelection && QueryAccess(AccessLevelDelete))
	{
		oDeleteButton.src=oDeleteButton.getAttribute('ToolEnabledSrc');
		oDeleteButton.setAttribute('IsToolEnabled','true');
	}
	else
	{
		oDeleteButton.src=oDeleteButton.getAttribute('ToolDisabledSrc');
		oDeleteButton.setAttribute('IsToolEnabled','false');
	}

	var oRenameButton = document.getElementById('RenameButtonImage');

	if((window.IsFileSelection || window.IsDirectorySelection) && QueryAccess(AccessLevelEdit))
	{
		oRenameButton.src=oRenameButton.getAttribute('ToolEnabledSrc');
		oRenameButton.setAttribute('IsToolEnabled','true');
	}
	else
	{
		oRenameButton.src=oRenameButton.getAttribute('ToolDisabledSrc');
		oRenameButton.setAttribute('IsToolEnabled','false');
	}
}

var selectedFilesArray			= new Array();
var selectedDirectoriesArray	= new Array();
var restoreRows					= new Array();

function isSelected(path,dhtmlType)
{
	if(dhtmlType=='Directory')
	{
		var comparePathFull = "|" + selectedDirectoriesArray.join("|") + "|";
		var comparePathShort = "|" + path + "|";
		return comparePathFull.indexOf(	comparePathShort ) >= 0;
	}
	else
	{
		var comparePathFull = "|" + selectedFilesArray.join("|") + "|";
		var comparePathShort = "|" + path + "|";
		return comparePathFull.indexOf(	comparePathShort ) >= 0;
	}
}

function removeFromArray(item,oldArr)
{
	var newArr = new Array();
	
	for(var i=0;i<oldArr.length;i++)
	{
		if(oldArr[i]!=item)
			newArr[newArr.length] = oldArr[i];
	}
	
	return newArr;
}

function ClearSelectedItems()
{
	for(var i=0;i<restoreRows.length;i++)
		restoreRows[i].className = 'FM-ItemRow';
	restoreRows = new Array();
	selectedDirectoriesArray = new Array();
	selectedFilesArray = new Array();
	
	document.getElementById('MultiDirectorySelection').value = '';
	document.getElementById('MultiFileSelection').value = '';

}

function handleDblClick(evt)
{
	var dhtmlType = GetSourceLink(evt).dhtmlType;
	
	if(dhtmlType==null || dhtmlType!='File')
		return;
	
	if(evt==null)
		evt = window.event;
		
	window.open('<%=EPiServer.Global.EPConfig.RootDir.Substring(0,EPiServer.Global.EPConfig.RootDir.Length-1)%>' + GetSourceLink(evt).dhtmlPath);
	evt.returnValue = false;
	return false;
}

function handleSelection(evt,path,dhtmlType)
{
	var alreadSelected = isSelected(path,dhtmlType);
	
	if(dhtmlType=='File')
	{	
		if(!alreadSelected)
			selectedFilesArray[selectedFilesArray.length] = path;
		else
			selectedFilesArray = removeFromArray(path,selectedFilesArray);
	}
	else if(dhtmlType=='Directory')
	{	
		if(!alreadSelected)
			selectedDirectoriesArray[selectedDirectoriesArray.length] = path;
		else
			selectedDirectoriesArray = removeFromArray(path,selectedDirectoriesArray);
	}
	else
		return false;
	
	var el = GetSourceLink(evt);
	
	while(el.tagName!='TR' && el.tagName!='BODY')
	{
		el = el.parentNode;
	}
	restoreRows[restoreRows.length] = el;
	el.className = alreadSelected ? 'FM-ItemRow' : 'FM-ItemRowSelected';
	
	document.getElementById('MultiDirectorySelection').value = selectedDirectoriesArray.join("|");
	document.getElementById('MultiFileSelection').value = selectedFilesArray.join("|");
	
	return true;
}

function Refresh()
{
	__doPostBack('','');
}

function InitMultiUploadComponent()
{
	if(document.all['MultiUpload'] && document.all['MultiUpload'].object)
		document.all['MultiUpload'].attachEvent('onfinish',Refresh);
}

try
{
	window.attachEvent('onload',InitMultiUploadComponent);
}
catch(oErr)
{
}

</script>

