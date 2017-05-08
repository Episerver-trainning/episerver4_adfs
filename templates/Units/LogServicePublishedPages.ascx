<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Control Language="c#" AutoEventWireup="false" Codebehind="LogServicePublishedPages.ascx.cs" Inherits="development.Templates.Units.LogServicePublishedPages" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>

<span class="listheading"><EPiServer:Translate Text="/templates/logservice/publishedpages/heading" id="Heading" runat="server" /></span>
<asp:Label ID="ErrorMsg" Runat="server" />
<episerver:newslist 
	id="PublishedPagesControl" 
	PageLinkProperty="ListingContainer"  
	runat="server" >
	<NewsTemplate>
		<episerver:property runat="server" propertyname="PageLink" /><br/>
	</NewsTemplate>
</episerver:newslist>
