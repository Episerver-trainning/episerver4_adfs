<%@ Page language="c#" Codebehind="Document.aspx.cs" AutoEventWireup="false" Inherits="development.Templates.Document" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="development" TagName="DefaultFramework"	Src="~/templates/Frameworks/DefaultFramework.ascx"%>
<%@ Register TagPrefix="development" TagName="Document"		Src="~/templates/Units/Document.ascx"%>
<development:DefaultFramework ID="defaultframework" runat="server">
	<EPiServer:Content Region="fullRegion" ID="conferenceContent" runat="server">
				<a id="content"></a>
				<div class="DocumentArea">
					<development:Document ID="Listing" runat="server"></development:Document>		
				</div>
	</EPiServer:Content>
</development:DefaultFramework>