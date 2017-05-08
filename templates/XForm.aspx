<%@ Page language="c#" Codebehind="XForm.aspx.cs" AutoEventWireup="false" Inherits="development.Templates.XForm" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="development" TagName="DefaultFramework"	Src="~/templates/Frameworks/DefaultFramework.ascx"%>
<%@ Register TagPrefix="development" TagName="XForm" Src="~/templates/Units/XForm.ascx"%>
<development:DefaultFramework ID="DefaultFramework" runat="server">
	<EPiServer:Content Region="addRegion" runat="server">
		<development:XForm runat="server" />
	</EPiServer:Content>
</development:DefaultFramework>