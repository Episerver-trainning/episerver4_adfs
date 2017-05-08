<%@ Control EnableViewState="False" Language="c#" AutoEventWireup="false" Codebehind="VersionListToolBar.ascx.cs" Inherits="EPiServer.Util.FileManager.VersionListToolBar" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="FileManager" TagName="DhtmlSupport"	Src="~/util/FileManager/DhtmlSupport.ascx"%>
<table class="FM-MarginTable">
	<tr>
		<td>
			<asp:ImageButton Runat="server"
				ID="FolderIcon"
				ImageUrl="~/Util/Images/FileManager/folder_color_back.gif" 
				AlternateText="Up"
				ImageAlign="AbsMiddle"
				OnClick="FolderIcon_Click"
			/>
			<asp:LinkButton Runat="server"
				ID="FolderLink"
				Text="(Back to folder)"
				Translate="/filemanager/viewfile/backtofolder"
				CssClass="FM-DirectoryShortcut"
				OnClick="FolderLink_Click"
			/>
		</td>
	</tr>
</table>
<table width="100%" cellspacing="0" id="mainTable" runat="server">
	<tr id="buttonsRow" runat="server">
		<td class="FM-ButtonBar">
			<EPiServerSys:CommandTool Runat="server" 
				ID="RestoreButton"
				EnableClientSideScript="True"
				AlternateText="Restore"
				ImageUrl="~/Util/Images/FileManager/Tools/RestoreTool.gif" />
			<EPiServerSys:CommandTool Runat="server" 
				ID="DeleteButton" 
				EnableClientSideScript="True"
				AlternateText="Delete"
				ImageUrl="~/Util/Images/FileManager/Tools/DelTool.gif" />
			<EPiServerSys:CommandTool Runat="server" 
				ID="AddVersionButton" 
				EnableClientSideScript="True"
				AlternateText="Delete"
				ImageUrl="~/Util/Images/FileManager/Tools/NewFileTool.gif" />
			<EPiServerSys:HelpButton Runat="server" 
				ID="HelpButton"
				NavigateUrl="VersionHistory.htm" />
		</td>
	</tr>
</table>
<input type="hidden" value="" name="SelectedVersion" id="SelectedVersion"/>
<br />
<script type="text/javascript">

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

	if(srcElement.tagName=='TD')
		return srcElement.parentNode;
	else
		return srcElement;
}

function handleContextMenu(evt)
{
	if(evt==null)
		evt = window.event;
	handleItemClick(evt,true);
	evt.returnValue=false;
	return false;
}

function handleDblClick(evt)
{
	if(evt==null)
		evt = window.event;
	evt.returnValue		= false;
	evt.cancelBubble	= true;
}

function handleSelectStart()
{
	return false;
}

function handleClick(evt)
{
	if(evt==null)
		evt = window.event;
				
	var srcElement = GetSourceElement(evt);
	if(srcElement.getAttribute('IsToolEnabled')=='true')
		return;
	
	handleItemClick(evt,false);
}

function CopyToClipboard(data)
{
	if( window.clipboardData) 
		window.clipboardData.setData("Text", data);
	else 
		alert("Internet Explorer required"); 
}

function handleItemClick(evt,viewContextMenu)
{
	var sourceElement = GetSourceLink(evt);
	var versionId = sourceElement.getAttribute('versionId');
	var isCurrentPublic = sourceElement.getAttribute('isCurrentPublic')=='true';
	
	var selectedVersionInput = document.getElementById('SelectedVersion');
	
	if(window.IsVersionSelected)
	{
		var collection = document.getElementsByTagName('TR');
		for(var i=0;i<collection.length;i++)
		{
			if(collection[i].getAttribute('versionId') == selectedVersionInput.value)
				collection[i].className = 'FM-ItemRow';
		}
	}
	window.IsVersionSelected = versionId!=null;
	window.IsCurrentPublicSelected = isCurrentPublic;
	selectedVersionInput.value = versionId==null ? '' : versionId;
	
	if(versionId!=null)
	{	
		sourceElement.className = 'FM-ItemRowSelected';
		evt.returnValue		= false;
		evt.cancelBubble	= true;
	}
		
	UpdateCommandTools();

	if(viewContextMenu)
		<%=menu.ClientID%>.Show();

}

function UpdateCommandTools()
{
	UpdateCommandTool('DeleteButton',true);
	UpdateCommandTool('RestoreButton',true);
	UpdateCommandTool('AddVersionButton',false);
}

function UpdateCommandTool(name,requireVersion)
{
	var oButton = document.getElementById(name + 'Image');

	if((window.IsVersionSelected && requireVersion && !window.IsCurrentPublicSelected) || (!window.IsVersionSelected && !requireVersion))
	{
		if(!oButton.getAttribute('ToolEnabledSrc'))
			return;
		oButton.src=oButton.getAttribute('ToolEnabledSrc');
		oButton.setAttribute('IsToolEnabled','true');
	}
	else
	{
		if(!oButton.getAttribute('ToolDisabledSrc'))
			return;
		oButton.src=oButton.getAttribute('ToolDisabledSrc');
		oButton.setAttribute('IsToolEnabled','false');
	}
}

</script>
