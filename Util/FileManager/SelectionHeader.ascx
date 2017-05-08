<%@ Control EnableViewState="False" Language="c#" AutoEventWireup="false" Codebehind="SelectionHeader.ascx.cs" Inherits="EPiServer.Util.FileManager.DirectorySelection" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<table width="100%" cellspacing="0" class="FM-CommandHeading" id="mainTable" runat="server">
	<tr>
		<td class="FM-DirectoryToolbar" align="left" valign="middle" width="1%">
			<asp:Image Runat="server"
				ID="SelectionIcon"
				ImageUrl="~/Util/Images/FileManager/folder_open.gif" 
				ImageAlign="Middle"
				hspace="5"/>
		</td>
		<td class="FM-DirectoryToolbar">
			<span class="FM-Title"><%= HeadingName %></span>
		</td>
	</tr>
</table>

