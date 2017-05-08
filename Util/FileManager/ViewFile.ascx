<%@ Control EnableViewState="False" Language="c#" AutoEventWireup="false" Codebehind="ViewFile.ascx.cs" Inherits="EPiServer.Util.FileManager.ViewFile" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="FileManager" TagName="FileReferenceList"	Src="~/util/FileManager/FileReferenceList.ascx"%>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<table class="FM-MarginTable">
	<tr>
		<td>
			<asp:ImageButton Runat="server"
				ID="FolderIcon"
				ImageUrl="~/Util/Images/FileManager/folder_color_back.gif" 
				AlternateText="Up"
				ImageAlign="AbsMiddle"
			/>
			<asp:LinkButton Runat="server"
				ID="FolderLink"
				Text="(Back to folder)"
				Translate="/filemanager/viewfile/backtofolder"
				CssClass="FM-DirectoryShortcut"
			/>
		</td>
	</tr>
</table>

<asp:Table ID="PropertyTable" Runat="server" CssClass="FM-MarginTable">
	<asp:TableRow>
		<asp:TableCell><EPiServer:Translate Text="/filemanager/browse/size" runat="server" ID="Translate7" NAME="Translate1"/>:</asp:TableCell>
		<asp:TableCell><%= SizeString %></asp:TableCell>
	</asp:TableRow>
	<asp:TableRow>
		<asp:TableCell><EPiServer:Translate Text="/filemanager/browse/created" runat="server" ID="Translate8" NAME="Translate1"/>:</asp:TableCell>
		<asp:TableCell><%= CreatedString %></asp:TableCell>
	</asp:TableRow>
	<asp:TableRow>
		<asp:TableCell><EPiServer:Translate Text="/filemanager/browse/modified" runat="server" ID="Translate9" NAME="Translate1"/>:</asp:TableCell>
		<asp:TableCell><%= ModifiedString %></asp:TableCell>
	</asp:TableRow>
	<asp:TableRow>
		<asp:TableCell VerticalAlign="Top"><EPiServer:Translate Text="/filemanager/viewfile/linkingpages" runat="server" ID="Translate10" NAME="Translate1"/>:</asp:TableCell>
		<asp:TableCell>
			<FileManager:FileReferenceList UseSelection="False" id="fileReferenceList" runat="server"/>
		</asp:TableCell>
	</asp:TableRow>
</asp:Table>
<table class="FM-MarginTable">
	<tr>
		<td>
			<asp:Button Runat="server" 
				ID="EditSummaryButton"
				OnClick="EditSummaryButton_Click"
				Translate="/button/edit" />
		</td>
	</tr>
</table>
