<%@ Control EnableViewState="False" Language="c#" AutoEventWireup="false" Codebehind="EditCustomFileSummary.ascx.cs" Inherits="EPiServer.Util.FileManager.EditCustomFileSummary" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="XForms" Namespace="EPiServer.XForms.WebControls" Assembly="EPiServer.XForms" %>

<asp:Table ID="PropertyTable" Runat="server" CssClass="FM-MarginTable">
	<asp:TableRow>
		<asp:TableCell>
			<episerver:TranslatedValidationSummary Runat="server" />
		</asp:TableCell>
	</asp:TableRow>
	<asp:TableRow>
		<asp:TableCell>
			<XForms:XFormControl id="XFormCtrl" runat="server"/>
		</asp:TableCell>
	</asp:TableRow>
</asp:Table>
<table class="FM-MarginTable">
	<tr>
		<td>
			<asp:Button ID="SaveButton" Runat="server" Translate="/button/save" Text="Save"/>
			<asp:Button ID="CancelButton" Runat="server" Translate="/button/cancel" Text="Cancel" CausesValidation="False"/>
		</td>
	</tr>
</table>
