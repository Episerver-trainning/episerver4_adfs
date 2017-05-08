<%@ Control Language="c#" AutoEventWireup="false" Codebehind="wsrpRssControl.ascx.cs" Inherits="development.Templates.Wsrp.PortletControls.WsrpRssControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@	Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>

<!-- "wsrp:view"-markup below -->

<asp:PlaceHolder id="mainview" runat="server">
	<asp:Label Runat="server" ID="ErrorMessage" Visible="False" />

	<asp:Repeater ID="RssNewsGrid" Runat="server">
	<HeaderTemplate>
			<div class="portlet-section-header">RSS Listing<br></div>
	</HeaderTemplate>
	<ItemTemplate>
			<div class="portlet-section-subheader">
				<b>
					<a href='<%# Server.HtmlEncode((string)DataBinder.Eval(Container.DataItem, "link"))%>' target="_new" class="linklist">
						<%# Server.HtmlEncode((string)DataBinder.Eval(Container.DataItem, "title")) %>
					</a>
				</b>
				
				<span class="portlet-section-text">
				<%# ((System.Data.DataRowView)Container.DataItem).Row.Table.Columns["date"] == null ? "" : "&nbsp;(" + DataBinder.Eval(Container.DataItem, "date") + ")"%>
				<%# ((System.Data.DataRowView)Container.DataItem).Row.Table.Columns["pubDate"] == null ? "" : "&nbsp;(" + DataBinder.Eval(Container.DataItem, "pubDate") + ")"%>
				</span>
			</div>
			<br />
			<asp:Label CssClass="portlet-section-text" Runat="server" Text='<%# Server.HtmlEncode((string)DataBinder.Eval(Container.DataItem, "description")) %>' Visible='<%#CurrentPage["OnlyShowHeaders"] == null? true : false%>' />
			<hr>

	</ItemTemplate>
	</asp:Repeater>
</asp:PlaceHolder>


<!-- "wsrp:edit"-markup below -->

<asp:PlaceHolder id="configurationview" runat="server">
	<div class="portlet-section-header"><EPiServer:Translate Text="/templates/wsrp/common/configuration" runat="server" /></div>
	<form action="thispage.aspx" method="post">
		<div class="portlet-form-label"><EPiServer:Translate Text="/templates/wsrp/rsscontrol/selecttitle" runat="server" /></div>
		<input class="portlet-form-input-field" type="text" size="40" name="thetitle" value="<%= PortletState["thetitle"] %>"><br>
		<div class="portlet-form-label"><EPiServer:Translate Text="/templates/wsrp/rsscontrol/selecturl" runat="server" /></div> 
		<input class="portlet-form-input-field" type="text" size="40" name="theurl" value="<%= PortletState["theurl"] %>"><br>
		<div class="portlet-form-label"><EPiServer:Translate Text="/templates/wsrp/rsscontrol/selectnoofitems" runat="server" /></div> 
		<input class="portlet-form-input-field" type="text" size="10" name="themaxcount" value="<%= PortletState["themaxcount"] %>"><br>
		<input class="portlet-form-button" type="submit" name="submit" value=" <EPiServer:Translate Text="/templates/wsrp/rsscontrol/save" runat="server" />">
	</form>
</asp:PlaceHolder>