<%@ Control EnableViewState="False" Language="c#" AutoEventWireup="false" Codebehind="DirectoryHeader.ascx.cs" Inherits="EPiServer.Util.FileManager.DirectoryHeader" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="FileManager" TagName="NavigationPath"	Src="~/util/FileManager/NavigationPath.ascx"%>
<table width="100%" cellspacing="0" id="headerTable" runat="server">
	<tr>
		<td class="FM-DirectoryToolbar" align="left" valign="middle" width="1%">
			<asp:Image Runat="server"
				ID="FolderIcon"
				ImageUrl="~/Util/Images/FileManager/folder_open.gif" 
				ImageAlign="Middle"
				hspace="5"/>
		</td>
		<td class="FM-DirectoryToolbar">
			<span class="FM-Title"><%= HeadingName %></span>
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<FileManager:NavigationPath id="navigationPath" runat="server"/>
		</td>
	</tr>
</table>

