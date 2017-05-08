<%@ Control language="c#" Codebehind="FileManagementControl.ascx.cs" AutoEventWireup="false" Inherits="EPiServer.Edit.FileManagementControl" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
 <script type='text/javascript'>
	function onNavigate(newPageLink)
	{
		UpdatePageLink(newPageLink);
	}
	function onCommand(newCommand)
	{
		return 0;
	}
	function UpdatePageLink()
	{
		if(!window.parent.parent.latestVersion)
			window.parent.parent.latestVersion = window.parent.parent.latestNavigate;
			
		if(window.parent.parent.latestVersion!=null && window.parent.parent.latestVersion!='')
		{
			var form = getForm();
			var nQPos = form.action.indexOf('?id=');
			var nAmpPos = form.action.indexOf('&id=');
			if(nQPos>0)
				form.action = form.action.slice(0,nQPos+4) + window.parent.parent.latestVersion + form.action.substring(form.action.indexOf('&',nQPos));
			else if(nAmpPos>0)
			{
				form.action = form.action.slice(0,nAmpPos+4) + window.parent.parent.latestVersion;
				if(form.action.indexOf('&',nAmpPos+1)>0)
				form.action = form.action.substring(form.action.indexOf('&',nAmpPos+1))
			}
			else
				form.action = form.action + "&id=" + window.parent.parent.latestVersion;
			
		}
	}
</script>
<table cellpadding="0" id="mainLayoutTable" cellspacing="2" height="95%" border="0">
	<tbody>
	<tr valign="top">
		<td class="FM-ShortcutCell">
			<div class="FM-ScrollingArea" id="navigatorArea">
				<EPiServer:FileManagerNavigator EnableFavorites="True" OnSelectedActionChanged="ChangeBrowserMode" OnSelectedShortcutChanged="ChangeBrowserRoot" ID="navigator" runat="server"/>
			</div>
		</td>
		<td>&nbsp;</td>
		</asp:PlaceHolder>
		<td class="FM-BrowserCell" width="100%">
			<EPiServer:FileManager OnShortcutCollectionChanged="UpdatedFavorites" DisplayHelpButton="True" ID="browser" runat="server"/>
			<asp:Panel Visible="False" Runat="server" ID="createDirDialog">
				<table width="100%" id="mainTable" runat="server" class="FM-CommandHeading">
					<tr>
						<td class="FM-DirectoryToolbar" align="left" valign="middle" width="1%">
							<asp:Image Runat="server"
								ID="FolderIcon"
								ImageUrl="~/Util/Images/FileManager/folder_open.gif" 
								ImageAlign="Middle"
								hspace="5"/>
						</td>
						<td class="FM-DirectoryToolbar">
							<span class="FM-Title"><%= GetPageName() %></span>
						</td>
					</tr>
				</table>
				<table width="100%">
					<tr>
						<td colspan="2">
							<EPiServer:Translate Text="/filemanager/pagefoldernotcreated" runat="server"/><br /><br />
							<asp:Button Translate="/button/yes" Text="Yes" OnClick="CreatePageDirectory" Runat="server"/>
							<asp:Button Translate="/button/no" Text="No" OnClick="CancelPageDirectory" Runat="server"/>
						</td>
					</tr>
				</table>
			</asp:Panel>
			
			<asp:Panel Visible="False" Runat="server" ID="notAuthorizedPanel">
				<table width="100%" id="Table1" runat="server" class="FM-CommandHeading">
					<tr>
						<td class="FM-DirectoryToolbar" align="left" valign="middle" width="1%">
							<asp:Image Runat="server"
								ID="Image1"
								ImageUrl="~/Util/Images/FileManager/folder_page_closed.gif" 
								ImageAlign="Middle"
								hspace="5"/>
						</td>
						<td class="FM-DirectoryToolbar">
							<span class="FM-Title"><%= GetPageName() %></span>
						</td>
					</tr>
				</table>
				<table width="100%">
					<tr>
						<td colspan="2">
							<EPiServer:Translate Text="/filemanager/unauthorizedpagefoldercreation" runat="server"/>
						</td>
					</tr>
				</table>
			</asp:Panel>
			
		</td>
	</tr>
	</tbody>
</table>
<script type="text/javascript">

window.onload	= ResizeFileManager;
window.onresize = ResizeFileManager;

function ResizeFileManager()
{
	var offsetAreaId = <%=BottomOffsetArea==null ? "null" : "'" + BottomOffsetArea + "'"%>;
	var offsetArea = offsetAreaId!=null ? document.getElementById(offsetAreaId) : null;
	
	var mainLayoutTable = document.getElementById('mainLayoutTable');
	if(mainLayoutTable)
		resizeVerticalDiv(mainLayoutTable,offsetArea,10);
		
	var browseArea = document.getElementById('browseArea');
	if(browseArea)
		resizeVerticalDiv(browseArea,offsetArea,15);
		
	var navigatorArea = document.getElementById('navigatorArea');
	if(navigatorArea)
		resizeVerticalDiv(navigatorArea,offsetArea,15);
		
	if(window.currentSelectedFileObj)
	{
		window.currentSelectedFileObj.click();
		window.currentSelectedFileObj.scrollIntoView(true);
	}
}

function resizeVerticalDiv(oDiv, oBottomNeighbor, extraSpacing) 
{
    var minHeight		= 100;
    var clientHeight	= document.body.clientHeight;

    var absoluteYTop	= oDiv.offsetTop;
    var oParent			= oDiv.offsetParent;
    
    while(oParent.tagName.toUpperCase()!= 'BODY')
    {
        absoluteYTop	+= oParent.offsetTop;
        oParent			= oParent.offsetParent;
    }

    var absoluteYBottom = extraSpacing;
    if (oBottomNeighbor != null) 
    {
        var neighborTop = oBottomNeighbor.offsetTop;
        oParent			= oBottomNeighbor.offsetParent;
        while(oParent.tagName.toUpperCase()!= 'BODY') 
        {
			neighborTop += oParent.offsetTop;
			oParent		= oParent.offsetParent;
        }
        absoluteYBottom = document.body.scrollHeight - neighborTop + extraSpacing;
    } 

    var newHeight			= document.body.clientHeight - absoluteYTop - absoluteYBottom;
    oDiv.style.posHeight	= (newHeight >= minHeight ? newHeight : minHeight);
}


</script>