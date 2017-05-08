<%@ Page language="c#" Codebehind="FlashPage.aspx.cs" AutoEventWireup="false" Inherits="development.Templates.FlashPage" %>
<%@ Register TagPrefix="development" TagName="FlashBody"		Src="~/templates/Units/FlashBody.ascx"%>
<%@ Register TagPrefix="development" TagName="DefaultFramework"	Src="~/templates/Frameworks/DefaultFramework.ascx"%>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>

<development:DefaultFramework id=DefaultMode runat="server">
	<EPiServer:Content Region="addRegion" runat="server">
		<development:FlashBody runat="server" />
	</EPiServer:Content>
</development:DefaultFramework>
