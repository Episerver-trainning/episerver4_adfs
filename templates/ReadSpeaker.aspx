<%@ Page language="c#" Codebehind="ReadSpeaker.aspx.cs" AutoEventWireup="false" Inherits="development.Templates.ReadSpeaker" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="development" TagName="DefaultFramework"	Src="~/templates/Frameworks/DefaultFramework.ascx"%>
<%@ Register TagPrefix="development" TagName="ReadSpeaker"	Src="~/templates/Units/ReadSpeaker.ascx"%>
<development:DefaultFramework ID="DefaultFramework" runat="server">
	<EPiServer:Content Region="addRegion" runat="server">		
		<development:ReadSpeaker runat="server" />
	</EPiServer:Content>
</development:DefaultFramework>