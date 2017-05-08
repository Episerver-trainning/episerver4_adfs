<%@ Control EnableViewState="False" Language="c#" AutoEventWireup="false" Codebehind="EditFileSummary.ascx.cs" Inherits="EPiServer.Util.FileManager.EditFileSummary" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<asp:Table ID="PropertyTable" Runat="server" CssClass="FM-MarginTable">
	<asp:TableRow>
		<asp:TableCell><EPiServer:Translate Text="/filemanager/editfilesummary/inputtitle" runat="server"/>:</asp:TableCell>
		<asp:TableCell>
			<asp:TextBox ID="TitleTextBox" Runat="server"/>
		</asp:TableCell>
	</asp:TableRow>
	<asp:TableRow>
		<asp:TableCell><EPiServer:Translate Text="/filemanager/editfilesummary/inputsubject" runat="server" ID="Translate1" NAME="Translate1"/>:</asp:TableCell>
		<asp:TableCell>
			<asp:TextBox ID="SubjectTextBox" Runat="server"/>
		</asp:TableCell>
	</asp:TableRow>
	<asp:TableRow>
		<asp:TableCell><EPiServer:Translate Text="/filemanager/editfilesummary/inputauthor" runat="server" ID="Translate2" NAME="Translate2"/>:</asp:TableCell>
		<asp:TableCell>
			<asp:TextBox ID="AuthorTextBox" Runat="server"/>
		</asp:TableCell>
	</asp:TableRow>
	<asp:TableRow>
		<asp:TableCell><EPiServer:Translate Text="/filemanager/editfilesummary/inputcategory" runat="server" ID="Translate3" NAME="Translate3"/>:</asp:TableCell>
		<asp:TableCell>
			<asp:TextBox ID="CategoryTextBox" Runat="server"/>
		</asp:TableCell>
	</asp:TableRow>
	<asp:TableRow>
		<asp:TableCell><EPiServer:Translate Text="/filemanager/editfilesummary/inputcomments" runat="server" ID="Translate4" NAME="Translate4"/>:</asp:TableCell>
		<asp:TableCell>
			<asp:TextBox ID="CommentsTextBox" Runat="server"/>
		</asp:TableCell>
	</asp:TableRow>
	<asp:TableRow>
		<asp:TableCell><EPiServer:Translate Text="/filemanager/editfilesummary/inputkeywords" runat="server" ID="Translate5" NAME="Translate5"/>:</asp:TableCell>
		<asp:TableCell>
			<asp:TextBox ID="KeywordsTextBox" Runat="server"/>
		</asp:TableCell>
	</asp:TableRow>
</asp:Table>
<table class="FM-MarginTable">
	<tr>
		<td>
			<asp:Button ID="SaveButton" Runat="server" Translate="/button/save" Text="Save"/>&nbsp;
			<asp:Button ID="CancelButton" Runat="server" Translate="/button/cancel" Text="Cancel" CausesValidation="False"/>
		</td>
	</tr>
</table>
