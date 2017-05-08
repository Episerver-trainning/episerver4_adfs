<%@ Page language="c#" Codebehind="ProfileFinder.aspx.cs" AutoEventWireup="false" Inherits="development.Templates.ProfileFinder" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="development" TagName="DefaultFramework"	Src="~/templates/Frameworks/DefaultFramework.ascx"%>
<%@ Register TagPrefix="development" TagName="ProfileFinder"	Src="~/templates/Units/ProfileFinder.ascx"%>
<development:DefaultFramework ID="defaultframework" runat="server">
	<EPiServer:Content Region="addRegion" runat="server">
		<development:ProfileFinder runat="server" />
	</EPiServer:Content>
</development:DefaultFramework>