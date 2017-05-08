<%@ Control Language="c#" AutoEventWireup="false" Codebehind="wsrpNewsChannelControl.ascx.cs" Inherits="development.Templates.Wsrp.PortletControls.WsrpNewsChannelControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@	Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>

<!-- "wsrp:view"-markup below -->

<asp:PlaceHolder id="mainview" runat="server">
	<episerver:PageList	MaxCount="6" runat="server"	ID="ContentList">	
		<ItemTemplate> 
			<div class="portlet-section-subheader">
				<b><%# Server.HtmlEncode((string)Container.CurrentPage.PageName)%></b>&nbsp;
				<span	class="portlet-section-text">
				(<%#((DateTime)Container.CurrentPage["PageChanged"]).ToString("yyyy-MM-dd hh:mm")%>)&nbsp;
				</span>
			</div>
			<br/>
			<div class="portlet-section-text">
			<%# Container.CurrentPage["MainIntro"] != null ? Server.HtmlEncode((string)Container.CurrentPage["MainIntro"]) : Container.PreviewText%>
			&nbsp;</div>
		<hr width="100%"/>
		</ItemTemplate>	
	</episerver:PageList> 
</asp:PlaceHolder>


<!-- "wsrp:edit"-markup below -->

<asp:PlaceHolder id="configurationview"	runat="server">
	<div class="portlet-section-header"><EPiServer:Translate Text="/templates/wsrp/common/configuration" runat="server" /></div>
	<form action="thispage.aspx" method="post">
		<div class="portlet-form-label"><EPiServer:Translate Text="/templates/wsrp/newscontrol/selecttitle" runat="server" /></div>
		<input class="portlet-form-input-field"	type="text"	size="40" name="thetitle" value="<%= PortletState["thetitle"] %>"><br />
		<div class="portlet-form-label"><EPiServer:Translate Text="/templates/wsrp/newscontrol/selectchannels" runat="server" /></div>
		<episerver:PageList runat="server"	ID="SourceList">	
		<ItemTemplate> 
			<input id="cbox<%#Container.CurrentPage.PageLink.ID%>" type="checkbox" <%#IsChecked(Container.CurrentPage.PageLink.ID)%> name="cbox<%#Container.CurrentPage.PageLink.ID%>">
			<episerver:property	PropertyName="PageName"	runat="server" ID="Property1" NAME="Property1"/>
			&nbsp;[<%#Container.CurrentPage.PageLink.ID%>]
			<br />
		</ItemTemplate>	
		</episerver:PageList> 
		<br />
		<input class="portlet-form-button" type="submit" name="submit" value=" <EPiServer:Translate Text="/templates/wsrp/infoservicecontrol/save" runat="server" />">
	</form>
</asp:PlaceHolder>
&nbsp;