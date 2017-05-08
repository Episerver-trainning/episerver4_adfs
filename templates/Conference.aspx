<%@ Page language="c#" Codebehind="Conference.aspx.cs" AutoEventWireup="false" Inherits="development.Templates.Conference" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="development" TagName="DefaultFramework"	Src="~/templates/Frameworks/DefaultFramework.ascx"%>
<%@ Register TagPrefix="development" TagName="Conference"		Src="~/templates/Units/Conference.ascx"%>
<development:DefaultFramework ID="defaultframework" runat="server">
	<EPiServer:Content Region="mainRegion" runat="server">
		<development:Conference runat="server" />
	</EPiServer:Content>
</development:DefaultFramework>