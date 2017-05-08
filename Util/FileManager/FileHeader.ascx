<%@ Control EnableViewState="False" Language="c#" AutoEventWireup="false" Codebehind="FileHeader.ascx.cs" Inherits="EPiServer.Util.FileManager.FileHeader" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<table width="100%" cellspacing="0" runat="server" id="mainTable" class="FM-CommandHeading">
	<tr id="headingRow" runat="server">
		<td class="FM-DirectoryToolbar" align="center" valign="middle" width="1%">
			<asp:Image Runat="server"
				ID="FileIcon"
				ImageUrl="~/Util/Images/FileManager/file.gif" 
				ImageAlign="Middle"
				hspace="5"
			/>
		</td>
		<td class="FM-DirectoryToolbar">
			<span class="FM-Title"><%= HeadingName %></span>
		</td>
	</tr>
</table>

