<%@ Control EnableViewState="False" Language="c#" AutoEventWireup="false" Codebehind="BrowseToolBar.ascx.cs" Inherits="EPiServer.Util.FileManager.BrowseToolBar" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="FileManager" TagName="DhtmlSupport"	Src="~/util/FileManager/DhtmlSupport.ascx"%>

<FileManager:DhtmlSupport id="dhtmlHandler" runat="server"></FileManager:DhtmlSupport>
<table width="100%" cellspacing="0" id="mainTable" runat="server">
	<tr id="buttonsRow" runat="server">
		<td class="FM-ButtonBar">
			<EPiServerSys:CommandTool Runat="server" 
				ID="DirectoryUpButton"
				OnClick="DirectoryUpButton_Click"
				AlternateText="Directory up"
				ImageUrl="~/Util/Images/FileManager/Tools/FolderUpTool.gif" />
			<EPiServerSys:CommandTool Runat="server" 
				ID="SearchButton" 
				OnClick="SearchButton_Click"
				AlternateText="Search"
				ImageUrl="~/Util/Images/FileManager/Tools/SearchTool.gif" />
			<EPiServerSys:CommandTool Runat="server" 
				ID="NewDirectoryButton"
				OnClick="NewDirectoryButton_Click"
				AlternateText="New directory"
				ImageUrl="~/Util/Images/FileManager/Tools/NewFolderTool.gif" />
			<EPiServerSys:CommandTool Runat="server" 
				ID="UploadFileButton" 
				OnClick="UploadFileButton_Click"
				AlternateText="Add file"
				ImageUrl="~/Util/Images/FileManager/Tools/NewFileTool.gif" />
			<EPiServerSys:CommandTool Runat="server" 
				ID="SecurityButton" 
				OnClick="SecurityButton_Click"
				AlternateText="Security"
				ImageUrl="~/Util/Images/FileManager/Tools/SecurityTool.gif" />
			<EPiServerSys:CommandTool Runat="server" 
				ID="RenameButton" 
				EnableClientSideScript="True"
				AlternateText="Rename"
				ImageUrl="~/Util/Images/FileManager/Tools/RenameTool.gif" />
			<EPiServerSys:CommandTool Runat="server" 
				ID="DeleteButton"
				EnableClientSideScript="True"
				AlternateText="Delete"
				ImageUrl="~/Util/Images/FileManager/Tools/DelTool.gif" />
			<EPiServerSys:HelpButton Runat="server" 
				ID="HelpButton"
				NavigateUrl="FileManagement.htm" />
		</td>
	</tr>
</table>

