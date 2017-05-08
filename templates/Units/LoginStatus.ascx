<%@ Control Language="c#" AutoEventWireup="false" Codebehind="LoginStatus.ascx.cs" Inherits="development.Templates.Units.LoginStatus" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<asp:Label Runat="server" ID="UserName" CssClass="loginuser" />
<asp:LinkButton Runat="server" ID="Login" CssClass="loginbutton">
	<EPiServer:Translate Text="/templates/page/login" runat="server" />
</asp:LinkButton>
<asp:LinkButton Runat="server" ID="Logout" CssClass="loginbutton">
	<EPiServer:Translate Text="/templates/page/logout" runat="server" />
</asp:LinkButton>