<%@ Page language="c#" Codebehind="ChangedPages.aspx.cs" AutoEventWireup="false" Inherits="development.Templates.ChangedPages" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="development" TagName="DefaultFramework"	Src="~/templates/Frameworks/DefaultFramework.ascx"%>
<%@ Register TagPrefix="development" TagName="ChangedPages"		Src="~/templates/Units/ChangedPages.ascx"%>
<development:DefaultFramework ID="defaultframework" runat="server">
	<EPiServer:Content Region="addRegion" runat="server">
		<development:ChangedPages runat="server" />
	</EPiServer:Content>
</development:DefaultFramework>