<%@ Page language="c#" Codebehind="AlphanumericListing.aspx.cs" AutoEventWireup="false" Inherits="development.Templates.AlphanumericListing" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="development" TagName="DefaultFramework"	Src="~/templates/Frameworks/DefaultFramework.ascx"%>
<%@ Register TagPrefix="development" TagName="AlphanumericListing"	Src="~/templates/Units/AlphanumericListing.ascx"%>
<development:DefaultFramework ID="defaultframework" runat="server">
	<EPiServer:Content Region="addRegion" runat="server">
		<development:AlphanumericListing runat="server" />
	</EPiServer:Content>
</development:DefaultFramework>