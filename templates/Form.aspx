<%@ Page language="c#" Codebehind="Form.aspx.cs" AutoEventWireup="false" Inherits="development.Templates.Form" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="development" TagName="DefaultFramework"	Src="~/templates/Frameworks/DefaultFramework.ascx"%>
<%@ Register TagPrefix="development" TagName="Form"				Src="~/templates/Units/Form.ascx"%>
<development:DefaultFramework ID="DefaultFramework" runat="server">
	<EPiServer:Content Region="addRegion" runat="server">
		<development:Form runat="server" />
	</EPiServer:Content>
</development:DefaultFramework>