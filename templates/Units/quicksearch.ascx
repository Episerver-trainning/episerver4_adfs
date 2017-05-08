<%@ Control Language="c#" AutoEventWireup="false" Codebehind="QuickSearch.ascx.cs" Inherits="development.Templates.Units.Quicksearch" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<span id="QuickSearchSpan" runat="server">
	<asp:Label ID="ErrorInfo" runat="server" Visible="False" ForeColor="Red" />
	<asp:textbox ID="SearchText" runat="server" AccessKey="4" OnTextChanged="SearchText_TextChanged" CssClass="quicksearchinput" ToolTip='<%#Translate("/templates/search/quicksearch")%>' />
	<asp:LinkButton runat="server" ID="QuickSearchButton" OnClick="QuickSearchButton_Click" CausesValidation="False">
		<img Runat="server" align="absmiddle" src="~/images/ico_find.gif" class="quicksearch" translate="/templates/search/quicksearch" />
	</asp:LinkButton>
</span>