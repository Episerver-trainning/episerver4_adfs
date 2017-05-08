<%@ Page language="c#" Codebehind="SiteMap.aspx.cs" AutoEventWireup="false" Inherits="development.Templates.SiteMap" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="development" TagName="DefaultFramework"	Src="~/templates/Frameworks/DefaultFramework.ascx"%>
<%@ Register TagPrefix="development" TagName="Sitemap"	Src="~/templates/Units/Sitemap.ascx"%>
<development:DefaultFramework ID="defaultframework" runat="server">
	<EPiServer:Content Region="fullRegion" runat="server">
		<development:Sitemap runat="server" />
	</EPiServer:Content>
</development:DefaultFramework>