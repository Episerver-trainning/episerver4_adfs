<%@ Page language="c#" Codebehind="PersonalSettings.aspx.cs" AutoEventWireup="false" Inherits="development.Templates.PersonalSettings" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="development" TagName="DefaultFramework"	Src="~/templates/Frameworks/DefaultFramework.ascx"%>
<%@ Register TagPrefix="development" TagName="PersonalSettings"	Src="~/templates/Units/PersonalSettings.ascx"%>
<development:DefaultFramework ID="defaultframework" runat="server">
	<EPiServer:Content Region="addRegion" runat="server">
		<development:PersonalSettings runat="server" />
	</EPiServer:Content>
</development:DefaultFramework>