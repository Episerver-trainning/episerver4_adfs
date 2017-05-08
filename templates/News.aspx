<%@ Page language="c#" Codebehind="News.aspx.cs" AutoEventWireup="false" Inherits="development.Templates.News" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="development" TagName="DefaultFramework"	Src="~/templates/Frameworks/DefaultFramework.ascx"%>
<%@ Register TagPrefix="development" TagName="PageBody"			Src="~/templates/Units/PageBody.ascx"%>
<%@ Register TagPrefix="development" TagName="RssListing"		Src="~/templates/Units/RssListing.ascx"%>
<%@ Register TagPrefix="development" TagName="Listing"			Src="~/templates/Units/Listing.ascx"%>
<development:DefaultFramework ID="DefaultFramework" runat="server">		
	<EPiServer:Content Region="mainRegion" runat="server">
		<development:PageBody runat="server" />
			<development:Listing runat="server" /><br />
			<development:RssListing runat="server" />
	</EPiServer:Content>
</development:DefaultFramework>