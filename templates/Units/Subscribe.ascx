<%@ Control Language="c#" AutoEventWireup="false" Codebehind="Subscribe.ascx.cs" Inherits="development.Templates.Units.Subscribe" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<asp:Panel ID="SubscribeArea" Runat="server">
	<div class="inputlabelwide">
		<episerver:translate Text="/admin/secedit/editemail" runat="server" />
	</div>
	<asp:TextBox ID="Email" Runat="server" />
	
	<br />
	<div class="inputlabelwide">
		<episerver:translate Text="/templates/subscribe/interval" runat="server" />
	</div>
	<asp:DropDownList ID="Interval" Runat="Server">
		<asp:ListItem Value="0">#fastaspossible</asp:ListItem>
		<asp:ListItem Value="1">#daily</asp:ListItem>
		<asp:ListItem Value="2">#everysecondday</asp:ListItem>
		<asp:ListItem Value="7">#weekly</asp:ListItem>
		<asp:ListItem Value="14">#everysecondweek</asp:ListItem>
		<asp:ListItem Value="28">#everyfourthweek</asp:ListItem>
	</asp:DropDownList>
	<br />
	<br />
	<div class="inputlabelwide">
	<episerver:translate Text="/templates/subscribe/subscriptions" runat="server" CssClass="inputlabel" />
	</div>
	<EPiServer:SubscriptionList ID="SubList" runat="server" language="<%#CurrentPage.LanguageID%>" />
	<br />
	<div class="inputlabelwide"></div>
	<asp:Button ID="saveSub" Translate="/button/save" Runat="server" OnClick="Save_Click" />
</asp:Panel>