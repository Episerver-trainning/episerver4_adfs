<%@ Control EnableViewState="False" Language="c#" AutoEventWireup="false" Codebehind="UploadFile.ascx.cs" Inherits="EPiServer.Util.FileManager.UploadFile" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="XForms" Namespace="EPiServer.XForms.WebControls" Assembly="EPiServer.XForms" %>
<asp:PlaceHolder ID="PropertyTable" Runat="server">
<br />
<EPiServer:TranslatedValidationSummary runat="server"/>

<table class="FM-MarginTable">
	<tr>
		<td><EPiServer:Translate Text="/filemanager/uploadfile/selectfile" runat="server" ID="Translate7" NAME="Translate1"/>:</td>
		<td>
			<input type="file" runat="server" ID="FileUpload" NAME="FileUpload"/>
		</td>
	</tr>
	<asp:PlaceHolder runat="server" id="defaultSummary">
		<tr>
			<td><EPiServer:Translate Text="/filemanager/editfilesummary/inputtitle" runat="server" ID="Translate1" NAME="Translate1"/>:</td>
			<td>
				<asp:TextBox ID="TitleTextBox" Runat="server"/>
			</td>
		</tr>
		<tr>
			<td><EPiServer:Translate Text="/filemanager/editfilesummary/inputsubject" runat="server" ID="Translate2" NAME="Translate1"/>:</td>
			<td>
				<asp:TextBox ID="SubjectTextBox" Runat="server"/>
			</td>
		</tr>
		<tr>
			<td><EPiServer:Translate Text="/filemanager/editfilesummary/inputauthor" runat="server" ID="Translate3" NAME="Translate2"/>:</td>
			<td>
				<asp:TextBox ID="AuthorTextBox" Runat="server"/>
			</td>
		</tr>
		<tr>
			<td><EPiServer:Translate Text="/filemanager/editfilesummary/inputcategory" runat="server" ID="Translate4" NAME="Translate3"/>:</td>
			<td>
				<asp:TextBox ID="CategoryTextBox" Runat="server"/>
			</td>
		</tr>
		<tr>
			<td><EPiServer:Translate Text="/filemanager/editfilesummary/inputcomments" runat="server" ID="Translate5" NAME="Translate4"/>:</td>
			<td>
				<asp:TextBox ID="CommentsTextBox" Runat="server"/>
			</td>
		</tr>
		<tr>
			<td><EPiServer:Translate Text="/filemanager/editfilesummary/inputkeywords" runat="server" ID="Translate6" NAME="Translate5"/>:</td>
			<td>
				<asp:TextBox ID="KeywordsTextBox" Runat="server"/>
			</td>
		</tr>
	</asp:PlaceHolder>
	<asp:PlaceHolder ID="rowXForm" runat="server" >
			<XForms:XFormControl id="XFormCtrl" runat="server"/>
	</asp:PlaceHolder>
</table>
</asp:PlaceHolder>
<asp:Table ID="PropertyTableButtons" Runat="server" CssClass="FM-MarginTable">
	<asp:TableRow>
		<asp:TableCell>
			<asp:Button ID="UploadButton" OnClick="UploadButton_Click" Translate="/button/add" Runat="server"/>&nbsp;
			<asp:Button ID="CancelButton" OnClick="CancelButton_Click" Translate="/button/cancel" CausesValidation="False" Runat="server"/>
		</asp:TableCell>
	</asp:TableRow>
</asp:Table>
<asp:Table Visible="False" ID="ConfirmTable" CssClass="FM-MarginTable" Runat="server">
	<asp:TableRow>
		<asp:TableCell><EPiServer:Translate Text="/filemanager/uploadfile/confirmreplacefile" runat="server" ID="Translate8" NAME="Translate1"/></asp:TableCell>
	</asp:TableRow>
</asp:Table>
<asp:Table Visible="False" ID="ConfirmTableButtons" CssClass="FM-MarginTable" Runat="server">
	<asp:TableRow>
		<asp:TableCell>
			<asp:Button ID="ConfirmReplaceButton" OnClick="ConfirmReplaceButton_Click" Translate="/button/ok" Runat="server"/>&nbsp;
			<asp:Button ID="CancelReplaceButton" OnClick="CancelReplaceButton_Click" Translate="/button/cancel" CausesValidation="False" Runat="server"/>
		</asp:TableCell>
	</asp:TableRow>
</asp:Table>