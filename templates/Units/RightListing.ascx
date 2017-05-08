<%@ Control Language="c#" AutoEventWireup="false" Codebehind="RightListing.ascx.cs" Inherits="development.Templates.Units.RightListing" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<EPiServer:NewsList id="NewsListControl" PageLinkProperty="RightListingContainer" runat="server">
	<HeaderTemplate>
		<div class="listheadingcontainer">
			<div class="listheadingleftcorner"></div>
			<episerver:property runat="server" PropertyName="PageLink" CssClass="listheading leftfloating" />
			<div class="listheadingrightcorner"></div>
		</div>
	</HeaderTemplate>
	<NewsTemplate>
			<episerver:property runat="server" PropertyName="PageLink" CssClass="RightListingItem" />&nbsp;
	</NewsTemplate>
</EPiServer:NewsList>