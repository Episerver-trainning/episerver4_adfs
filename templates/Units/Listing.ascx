<%@ Control Language="c#" AutoEventWireup="false" Codebehind="Listing.ascx.cs" Inherits="development.Templates.Units.Listing" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<episerver:newslist id="NewsListControl" PageLinkProperty="ListingContainer"  runat="server" MaxCount='<%#GetCount()%>'>
	<HeaderTemplate>
		<div class="NewsListingHeader">
			<EPiServer:Property PropertyName="PageName" runat="server"/>
		</div>
	</HeaderTemplate>
	<NewsTemplate>
		<div class="NewsListingItem">
			<a href="<%#Container.CurrentPage.LinkURL%>" target="<%#Container.CurrentPage["PageTargetFrame"]%>" title="<%#Container.PreviewText%>" class="NewsLink">
				<%#Container.CurrentPage.PageName%>
			</a>&nbsp;
			<span class="datelistingtext">(<%#((DateTime)Container.CurrentPage["PageStartPublish"]).ToString("yyyy-MM-dd hh:mm")%>)</span>
			<br />
			<%#Container.PreviewText%>
		</div>
	</NewsTemplate>
</episerver:newslist>