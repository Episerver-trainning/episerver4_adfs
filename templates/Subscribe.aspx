<%@ Page language="c#" Codebehind="Subscribe.aspx.cs" AutoEventWireup="false" Inherits="development.Templates.Subscribe" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="development" TagName="DefaultFramework"	Src="~/templates/Frameworks/DefaultFramework.ascx"%>
<%@ Register TagPrefix="development" TagName="Subscribe"	Src="~/templates/Units/Subscribe.ascx"%>
<development:DefaultFramework ID="DefaultFramework" runat="server">
	<EPiServer:Content Region="addRegion" runat="server">
		<development:Subscribe runat="server" />
	</EPiServer:Content>
</development:DefaultFramework>