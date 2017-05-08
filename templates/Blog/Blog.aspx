<%-- @(#) $Id: Blog.aspx,v 1.1.2.3 2006/03/13 09:48:54 svante Exp $ --%>
<%-- Copyright © 2006 ElektroPost Stockholm AB. All Rights Reserved. --%>
<%@ Page language="c#" Codebehind="Blog.aspx.cs" AutoEventWireup="false" Inherits="development.Templates.Blog.Blog" trace="false" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="development" TagName="DefaultFramework" Src="~/templates/Frameworks/DefaultFramework.ascx"%>
<%@ Register TagPrefix="development" TagName="PersonalBlog" Src="~/templates/Blog/Units/PersonalBlog.ascx"%>
<%@ Register TagPrefix="development" TagName="Archive" Src="~/templates/Blog/Units/BlogArchive.ascx"%>
<%@ Register TagPrefix="development" TagName="Rss" Src="~/templates/Blog/Units/BlogRSS.ascx"%>
<development:DefaultFramework ID="DefaultMode" runat="server">
	<EPiServer:Content Region="mainAndRightRegion" runat="server">
		<div id="mainareadiv" class='<%= EditMode ? "rightpadded" : "normalwidth" %>'>
			<a id="content"></a>
			<div>
				<div id="voicearea">
					<div class="rightpadded">
						<div class="leftfloating">
							<h1><EPiServer:Property propertyname="PageName" runat="server" /></h1>
						</div>
						<div class="rightfloating">
							<asp:LinkButton ID="btnModeGo2View" Runat="server" Visible="False" Translate="/admin/menu/tooltipview" OnClick="btnMode_Click" />
						</div>
					</div>
					<div class="clear">
						<development:PersonalBlog runat="server" ID="personalBlog" />
					</div>
				</div>
			</div>
		</div>
		<asp:Placeholder id="viewModeNavigation" runat="server">		
			<div id="rightmenudiv">
				<asp:LinkButton ID="btnModeGo2Edit" Runat="server" Visible="False" Translate="/admin/menu/tooltipedit" OnClick="btnMode_Click" />
				<h2><%= EPiServer.Global.EPLang.Translate("/templates/blog/archive") %></h2>
				<development:Archive runat="server" ID="archive" />
				<h2><%= EPiServer.Global.EPLang.Translate("/templates/blog/rsssource") %></h2>
				<development:Rss runat="server" ID="rss" />
			</div>
		</asp:Placeholder>
	</EPiServer:Content>
</development:DefaultFramework>
