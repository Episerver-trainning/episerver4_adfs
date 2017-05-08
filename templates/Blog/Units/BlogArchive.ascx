<%-- @(#) $Id: BlogArchive.ascx,v 1.1.2.3 2006/03/13 09:49:00 svante Exp $ --%>
<%-- Copyright © 2006 ElektroPost Stockholm AB. All Rights Reserved. --%>
<%@ Control Language="c#" AutoEventWireup="false" Codebehind="BlogArchive.ascx.cs" Inherits="development.Templates.Blog.Units.BlogArchive" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<asp:Repeater Runat="server" ID="archivePeriodList">
	<HeaderTemplate>
		<p>
	</HeaderTemplate>
	<ItemTemplate>
		<a href="<%# ((BlogArchiveSummary)DataBinder.GetPropertyValue(Container.DataItem, "Value")).UrlToThisPeriod %>">
			<%# ((DateTime)((BlogArchiveSummary)DataBinder.GetPropertyValue(Container.DataItem, "Value")).ThisPeriod).ToString("MMMM, yyyy") %>
		</a>
	</ItemTemplate>
	<SeparatorTemplate>
		<br />
	</SeparatorTemplate>
	<FooterTemplate>
		</p>
	</FooterTemplate>	
</asp:Repeater>
<asp:PlaceHolder Runat="server" ID="noArchiveEntriesMessage" Visible="False">
	<p>
		<%= EPiServer.Global.EPLang.Translate("/templates/blog/noarchiveentries") %>
	</p>
</asp:PlaceHolder>
