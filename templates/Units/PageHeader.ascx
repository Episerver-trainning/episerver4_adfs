<%@ Control Language="c#" AutoEventWireup="false" Codebehind="PageHeader.ascx.cs" Inherits="development.Templates.Units.PageHeader" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<asp:Panel ID="PageNameContainer" Runat="server">
	<episerver:property PropertyName="PageName" CssClass="heading1" runat="server" />
</asp:Panel>