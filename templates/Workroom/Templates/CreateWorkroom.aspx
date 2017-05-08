<%@ Page language="c#" Codebehind="CreateWorkroom.aspx.cs" AutoEventWireup="false" Inherits="development.Templates.Workrooms.Templates.CreateWorkroom" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="development" TagName="DefaultFramework"	Src="~/templates/Frameworks/DefaultFramework.ascx"%>
<%@ Register TagPrefix="workroom" TagName="CreateWorkroom" Src="~/templates/Workroom/Templates/Units/CreateWorkroom.ascx"%>

<development:DefaultFramework ID="DefaultFramework" runat="server">		
	<EPiServer:Content Region="fullRegion" runat="server">

		<workroom:CreateWorkroom runat="server"/>	

	</EPiServer:Content>
</development:DefaultFramework>