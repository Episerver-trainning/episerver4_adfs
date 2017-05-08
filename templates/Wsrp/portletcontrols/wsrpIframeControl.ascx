<%@ Control Language="c#" AutoEventWireup="false" Codebehind="wsrpIframeControl.ascx.cs" Inherits="development.Templates.Wsrp.PortletControls.WsrpIframeControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@	Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>

<!-- "wsrp:view"-markup below -->

<asp:PlaceHolder id="mainview" runat="server">
	<iframe 
			src="<%= RenderUrl() %>" 
			height="<%= RenderHeight() %>" 
			frameborder=0 
			width="100%">
	An Iframe should have been shown here.
	</iframe>
</asp:PlaceHolder>

<!-- "wsrp:edit"-markup below -->

<asp:PlaceHolder id="configurationview" runat="server">
	<div class="portlet-section-header"><EPiServer:Translate Text="/templates/wsrp/common/configuration" runat="server" /></div>
	<form action="thispage.aspx" method="post">
		<div class="portlet-form-label"><EPiServer:Translate Text="/templates/wsrp/iframecontrol/selecttitle" runat="server" /></div>
		<input class="portlet-form-input-field" type="text" size="40" name="thetitle" value="<%= PortletState["thetitle"] %>"><br>
		<div class="portlet-form-label"><EPiServer:Translate Text="/templates/wsrp/iframecontrol/selecturl" runat="server" /></div> 
		<input class="portlet-form-input-field" type="text" size="40" name="theurl" value="<%= PortletState["theurl"] %>"><br>
		<div class="portlet-form-label"><EPiServer:Translate Text="/templates/wsrp/iframecontrol/selectheight" runat="server" /></div> 
		<input class="portlet-form-input-field" type="text" size="40" name="theheight" value="<%= PortletState["theheight"] %>"><br>
		<input class="portlet-form-button" type="submit" name="submit" value=" <EPiServer:Translate Text="/templates/wsrp/iframecontrol/save" runat="server" />">
	</form>
</asp:PlaceHolder>