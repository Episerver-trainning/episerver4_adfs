<%@ Page language="c#" Codebehind="Register.aspx.cs" AutoEventWireup="false" Inherits="development.Templates.Register" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="development" TagName="DefaultFramework"	Src="~/templates/Frameworks/DefaultFramework.ascx"%>
<%@ Register TagPrefix="development" TagName="Register"	Src="~/templates/Units/Register.ascx"%>
<development:DefaultFramework ID="defaultframework" runat="server">
	<EPiServer:Content Region="addRegion" runat="server">
		<development:Register runat="server" />
	</EPiServer:Content>
</development:DefaultFramework>