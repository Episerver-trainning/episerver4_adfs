<%@ Control Language="c#" AutoEventWireup="false" Codebehind="WsrpDefaultPortletArea.ascx.cs" Inherits="development.Templates.Units.WsrpDefaultPortletArea" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<%@ Register tagprefix="wsrp" namespace="ElektroPost.Wsrp.Consumer.WebControls" assembly="ElektroPost.Wsrp" %>
<wsrp:PortletArea id="ThePortletArea" runat="server" PortalConfigurationMode='<%# ViewMode == "Design" %>' >
	<DesignHeaderTemplate>
		<div PortletIndex='<%# Container.ControlOrdinal %>'>
			<div>
				<div class="portalpieceheader">
					<div class="portalheadername"><%# Container.ClientPortlet.Title == null ? "---" : Container.ClientPortlet.Title %>
					</div>
					<div class="portalheadericons"><img onclick="removePortlet(this,'<%# ((PortletData)Container.ClientPortlet).WindowId.ToString() %>')" class="portalpieceheadericon"  src="<%# EPiServer.Global.EPConfig.RootDir %>images/wsrp/delete_gray.gif" onmouseover="this.src='../images/wsrp/delete.gif';" onmouseout="this.src='../images/wsrp/delete_gray.gif';" alt='<%# EPiServer.Global.EPLang.Translate("/button/delete") %>' />
					</div>
				</div>
			</div>
			<div class="portalpiece">
				<div class="portalpiececontent">
					<div class="padding">
	</DesignHeaderTemplate>
	<PortletHeaderTemplate>
		<div>
			<div <%# ViewMode == "View" ? " style=\"display:none;\" " : ""%>>
				<div class="portalpieceheader">
					<div class="portalheadername"><%# Container.ClientPortlet.Title == null ? "---" : Container.ClientPortlet.Title %></div>
					<div class="portalheadericons">&nbsp;
						<nobr>
							<wsrp:PortletButton runat="server" CssClass="portalpieceheadericon" ImageUrl="~/images/wsrp/back_gray.gif" HoverImageUrl="~/images/wsrp/back.gif" PortletMode="view" LinkText='<%# EPiServer.Global.EPLang.Translate("/templates/wsrpfx/button/view") %>' />
							<wsrp:PortletButton runat="server" CssClass="portalpieceheadericon" ImageUrl="~/images/wsrp/edit_gray.gif" HoverImageUrl="~/images/wsrp/edit.gif" PortletMode="edit" LinkText='<%# EPiServer.Global.EPLang.Translate("/templates/wsrpfx/button/edit") %>' />
							<wsrp:PortletButton runat="server" CssClass="portalpieceheadericon" ImageUrl="~/images/wsrp/preview_gray.gif" HoverImageUrl="~/images/wsrp/preview.gif" PortletMode="preview" LinkText='<%# EPiServer.Global.EPLang.Translate("/templates/wsrpfx/button/preview") %>' />
							<wsrp:PortletButton runat="server" CssClass="portalpieceheadericon" ImageUrl="~/images/wsrp/help_gray.gif" HoverImageUrl="~/images/wsrp/help.gif" PortletMode="help" LinkText='<%# EPiServer.Global.EPLang.Translate("/templates/wsrpfx/button/help") %>' />
						</nobr>&nbsp;
						<nobr>
							<wsrp:PortletButton runat="server" CssClass="portalpieceheadericon" ImageUrl="~/images/wsrp/minimize_gray.gif" HoverImageUrl="~/images/wsrp/minimize.gif" WindowState="Minimized" LinkText='<%# EPiServer.Global.EPLang.Translate("/templates/wsrpfx/button/minimized") %>' />
							<wsrp:PortletButton runat="server" CssClass="portalpieceheadericon" ImageUrl="~/images/wsrp/restore_gray.gif" HoverImageUrl="~/images/wsrp/restore.gif" WindowState="Normal" LinkText='<%# EPiServer.Global.EPLang.Translate("/templates/wsrpfx/button/normal") %>' />
							<wsrp:PortletButton runat="server" CssClass="portalpieceheadericon" ImageUrl="~/images/wsrp/maximize_gray.gif" HoverImageUrl="~/images/wsrp/maximize.gif" WindowState="Maximized" LinkText='<%# EPiServer.Global.EPLang.Translate("/templates/wsrpfx/button/maximized") %>' />
							<wsrp:PortletButton runat="server" CssClass="portalpieceheadericon" ImageUrl="~/images/wsrp/solo_gray.gif" HoverImageUrl="~/images/wsrp/solo.gif" WindowState="Solo" LinkText='<%# EPiServer.Global.EPLang.Translate("/templates/wsrpfx/button/solo") %>' />
						</nobr>
					</div>
				</div>
			</div>
			<div <%# ViewMode == "View" ? "class=\"portalpiece_view\"" : "class=\"portalpiece\"" %>>
				<div <%# ViewMode == "View" ? "class=\"portalpiececontent_view\"" : "class=\"portalpiececontent\"" %>>
					<div  <%# ViewMode == "View" ? "class=\"padding_view\"" : "class=\"padding\"" %>>
	</PortletHeaderTemplate>
	<ErrorTemplate>
		<div PortletIndex='<%# Container.ControlOrdinal %>'>
			<div>
				<div class="portalpieceheader">
					<div class="portalheadername"><%# Container.ClientPortlet.Title == null ? "---" : Container.ClientPortlet.Title %>
					</div>
					<div class="portalheadericons"><img onclick="removePortlet(this, '<%# ((ErrorPortlet)Container.ClientPortlet).WindowId %>')" class="portalpieceheadericon" src="<%# EPiServer.Global.EPConfig.RootDir %>images/wsrp/delete_gray.gif" onmouseover="this.src='../images/wsrp/delete.gif';" onmouseout="this.src='../images/wsrp/delete_gray.gif';" alt='<%# EPiServer.Global.EPLang.Translate("/button/delete") %>' ID="Img1"/>
					</div>
				</div>
			</div>
			<div class="portalpiece">
				<div class="portalpiececontent">
					<div class="padding">
	</ErrorTemplate>
	<PortletFooterTemplate>
					</div>
				</div>
			</div>
		</div>
	</PortletFooterTemplate>
	<DesignFooterTemplate>
					</div>
				</div>
			</div>
		</div>
	</DesignFooterTemplate>
	
</wsrp:PortletArea>
