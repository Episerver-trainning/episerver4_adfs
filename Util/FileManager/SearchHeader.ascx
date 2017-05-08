<%@ Control EnableViewState="False" Language="c#" AutoEventWireup="false" Codebehind="SearchHeader.ascx.cs" Inherits="EPiServer.Util.FileManager.SearchHeader" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<table cellspacing="0" class="FM-CommandHeading">
	<tr>
		<td class="FM-DirectoryToolbar" align="center" valign="middle">
			<asp:Image Runat="server"
				ID="FolderIcon"
				ImageUrl="~/Util/Images/FileManager/folder_color_search.gif" 
				ImageAlign="Middle"
				hspace="5" />
		</td>
		<td class="FM-DirectoryToolbar" width="100%">
			<span class="FM-Title"><EPiServer:Translate Text="/button/search" runat="server"/></span>
		</td>
	</tr>
</table>
