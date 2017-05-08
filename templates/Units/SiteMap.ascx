<%@ Control Language="c#" AutoEventWireup="false" Codebehind="SiteMap.ascx.cs" Inherits="development.Templates.Units.Sitemap" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<div class="fullwidth leftfloating">
	<episerver:sitemap 
		Runat="server"
		ID="SitemapControl"
		PageLink='<%#CurrentPage["IndexContainer"]%>'
		NumberOfLevels='<%#CurrentPage["IndexLevel"]%>'
		NumberOfColumns='<%#CurrentPage["IndexColumns"]%>'
		Rendering="Tree2"
		TopCssClass="sitemapheader" 
		CssClass="sitemap"
		ImageDirectory="~/images/SiteMap/"
		Width="90%"
		>
		<TopTemplate>
			<nobr><episerver:property runat="server" PropertyName="PageLink" CssClass="linklist" title="<%#GetPagePath(Container.CurrentPage)%>" /></nobr>
		</TopTemplate>
		<ItemTemplate>
			<nobr><episerver:property runat="server" PropertyName="PageLink" CssClass="linklist" title="<%#GetPagePath(Container.CurrentPage)%>" /></nobr>
		</ItemTemplate>
		<EndTemplate>
			<nobr><episerver:property runat="server" PropertyName="PageLink" CssClass="linklist" title="<%#GetPagePath(Container.CurrentPage)%>" /></nobr>
		</EndTemplate>
	</episerver:sitemap>
</div>