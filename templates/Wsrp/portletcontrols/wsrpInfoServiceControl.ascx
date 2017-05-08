<%@	Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Control Language="c#" AutoEventWireup="false" Codebehind="wsrpInfoServiceControl.ascx.cs" Inherits="development.Templates.Wsrp.PortletControls.WsrpInfoServiceControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>



<asp:PlaceHolder id="mainview" runat="server">

	<div width=100%>

	<asp:PlaceHolder id="pagelist" runat="server">
		<div style="float:left;<%=GetStyle()%>">
			<div class="portlet-section-body">

			<episerver:PageList	runat="server" ID="ContentList">	
				<ItemTemplate> 
					<b><a  
						title='<%#Container.CurrentPage["MainIntro"] != null ? Container.CurrentPage["MainIntro"]	: Container.PreviewText%>' 
						href="<%#Container.CurrentPage.StaticLinkURL%>" 
						><%#Container.CurrentPage.PageName%></a></b>&nbsp;
					<span class="datelistingtext">
					(<%#((DateTime)Container.CurrentPage["PageStartPublish"]).ToString("yyyy-MM-dd hh:mm")%>)
					</span>
					<br/>
					<%#Container.CurrentPage["MainIntro"] != null ?	Container.CurrentPage["MainIntro"] : Container.PreviewText%>
					<hr width="100%"/>
				</ItemTemplate>	
			</episerver:PageList> 
			
			</div>
		</div>
	</asp:PlaceHolder>

	<asp:PlaceHolder id="content" runat="server">
		<div style="float:left">&nbsp;
			<div class="portlet-section-header"><%= CurrentPage["PageName"] %></div>
			<div class="portlet-section-body">
			<%#	CurrentPage["MainBody"] != null ? CurrentPage["MainBody"] : ""%>
			<br/>
			User: <%= EPiServer.Security.UnifiedPrincipal.Current.Identity.Name	%><br/>
			</div>
		</div>
	</asp:PlaceHolder>

	</div>
</asp:PlaceHolder>



<asp:PlaceHolder id="configurationview"	runat="server">
	<div class="portlet-section-header"><EPiServer:Translate Text="/templates/wsrp/common/configuration" runat="server" /></div>

	<form action="thispage.aspx" method="post">
		<div class="portlet-form-label"><EPiServer:Translate Text="/templates/wsrp/infoservicecontrol/selecttitle" runat="server" /></div>
		<input class="portlet-form-input-field"	type="text"	size="40" name="thetitle" value="<%= PortletState["thetitle"] %>"><br>
		<div class="portlet-form-label"><EPiServer:Translate Text="/templates/wsrp/infoservicecontrol/selectwidth" runat="server" /></div>
		<input class="portlet-form-input-field"	type="text"	size="10" name="listwidth" value="<%= PortletState["listwidth"] %>"><br>
		<div class="portlet-form-label"><EPiServer:Translate Text="/templates/wsrp/infoservicecontrol/selectsinglepage" runat="server" /></div>
		<input class="portlet-form-input-field"	type="checkbox"  name="showsinglepage" <%#IsChecked()%>><br>
		<div class="portlet-form-label"><EPiServer:Translate Text="/templates/wsrp/infoservicecontrol/selectchannel" runat="server" /></div>

		<episerver:PageList	 runat="server"	ID="SourceList">
			<ItemTemplate> 
				<INPUT id="cbox<%#Container.CurrentPage.PageLink%>"	type="radio"  name="selectedpageid" <%#IsSelected(Container.CurrentPage.PageLink.ID)%> value="<%#Container.CurrentPage.PageLink%>">
				<episerver:property	PropertyName="PageName"	runat="server" ID="PageNameId"/>
				&nbsp;[<%#Container.CurrentPage.PageLink%>]
				<br/>
			</ItemTemplate>	
		</episerver:PageList> 

		<br/>
		<input class="portlet-form-button" type="submit" name="submit" value=" <EPiServer:Translate Text="/templates/wsrp/infoservicecontrol/save" runat="server" />">
	</form>
</asp:PlaceHolder>