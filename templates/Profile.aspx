<%@ Page language="c#" Codebehind="Profile.aspx.cs" AutoEventWireup="false" Inherits="development.Templates.Profile" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="development" TagName="DefaultFramework"	Src="~/templates/Frameworks/DefaultFramework.ascx"%>
<%@ Register TagPrefix="development" TagName="Profile"	Src="~/templates/Units/Profile.ascx"%>
<development:DefaultFramework ID="defaultframework" runat="server">
	<EPiServer:Content Region="mainAndRightRegion" runat="server">
		<development:Profile runat="server" />
	</EPiServer:Content>
</development:DefaultFramework>