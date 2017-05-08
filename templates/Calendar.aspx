<%@ Page language="c#" Codebehind="Calendar.aspx.cs" AutoEventWireup="false" Inherits="development.Templates.calendar" Trace="false" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="development" TagName="DefaultFramework"	Src="~/templates/Frameworks/DefaultFramework.ascx"%>
<%@ Register TagPrefix="development" TagName="Calendar"			Src="~/templates/Units/Calendar.ascx"%>

<development:DefaultFramework ID="DefaultFramework" runat="server">
	<EPiServer:Content Region="mainAndRightRegion" runat="server">
		<development:Calendar runat="server" />
	</EPiServer:Content>
</development:DefaultFramework>