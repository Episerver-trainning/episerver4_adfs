<%@ Page language="c#" Codebehind="FileListing.aspx.cs" AutoEventWireup="false" Inherits="development.Templates.FileListing" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="development" TagName="DefaultFramework"	Src="~/templates/Frameworks/DefaultFramework.ascx"%>
<%@ Register TagPrefix="development" TagName="FileListing"		Src="~/templates/Units/FileListing.ascx"%>
<development:DefaultFramework ID="defaultframework" runat="server">
	<EPiServer:Content Region="addRegion" runat="server">
		<development:FileListing runat="server" />
	</EPiServer:Content>
</development:DefaultFramework>