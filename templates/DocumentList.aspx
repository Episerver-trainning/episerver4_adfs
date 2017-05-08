<%@ Page language="c#" Codebehind="DocumentList.aspx.cs" AutoEventWireup="false" Inherits="development.Templates.DocumentList" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="development" TagName="DefaultFramework"	Src="~/templates/Frameworks/DefaultFramework.ascx"%>
<%@ Register TagPrefix="development" TagName="DocumentList"		Src="~/templates/Units/DocumentList.ascx"%>

<development:DefaultFramework ID="defaultframework" runat="server">
	<EPiServer:Content Region="mainAndRightRegion" ID="conferenceContent" runat="server">
				<a id="content"></a>
				<div class="leftfloating leftaligned">
					<development:DocumentList ID="Listing" runat="server"></development:DocumentList>
				</div>
	</EPiServer:Content>
</development:DefaultFramework>