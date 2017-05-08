<%@ Page language="c#" Codebehind="PageRoller.aspx.cs" AutoEventWireup="false" Inherits="development.Templates.PageRoller" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="development" TagName="DefaultFramework"	Src="~/templates/Frameworks/DefaultFramework.ascx"%>
<%@ Register TagPrefix="development" TagName="PageRoller"	Src="~/templates/Units/PageRoller.ascx"%>

<development:DefaultFramework ID="defaultframework" runat="server">
	<EPiServer:Content Region="mainRegion" runat="server">
		<development:PageRoller runat="server" />
	</EPiServer:Content>
</development:DefaultFramework>