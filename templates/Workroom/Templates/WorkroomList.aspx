<%@ Page language="c#" Codebehind="WorkroomList.aspx.cs" AutoEventWireup="false" Inherits="development.Templates.Workrooms.Templates.WorkroomList" %>
<%@ Register TagPrefix="development" TagName="DefaultFramework"	Src="~/templates/Frameworks/DefaultFramework.ascx"%>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="workroom" TagName="WorkroomList" Src="~/templates/Workroom/Templates/Units/WorkroomList.ascx"%>

<development:DefaultFramework ID="DefaultFramework" runat="server">
	<EPiServer:Content Region="fullRegion" runat="server">
	
		<workroom:WorkroomList runat="server" />		
			
	</EPiServer:Content>
</development:DefaultFramework>
