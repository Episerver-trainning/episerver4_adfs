<%@ Control Language="c#" AutoEventWireup="false" Codebehind="Menu.ascx.cs" Inherits="development.Templates.Units.Menu" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<episerver:PageTree runat="server" id="PageTreeControl">
	<HeaderTemplate>
		<div class="listheadingcontainer">
			<div class="listheadingleftcorner"></div>
			<episerver:property runat="server" PropertyName="PageLink" CssClass="listheading leftfloating" />
			<div class="listheadingrightcorner"></div>
		</div>
	</HeaderTemplate>

	<ItemTemplate>
		<div class="menuitem<%# (Container.CurrentPage.Indent > 0) ? "child" : ""  %>">
			<div class="leftfloating rightaligned" style="width: <%#Container.CurrentPage.Indent * 6%>%;">
				<img runat="server" Visible='<%# Container.HasChildren %>' src="~/images/closedMenuArrow.gif" width="7" height="7" translate="/templates/common/pagehaschildren" />
			</div>
			<div class="rightfloating" style="width: <%#((100) - Container.CurrentPage.Indent * 6)%>%;">
				<episerver:property runat="server" PropertyName="PageLink" CssClass="menulink" />
			</div>
		</div>
	</ItemTemplate>

	<SelectedItemTemplate>
		<div class="menuitem<%# (Container.CurrentPage.Indent > 0) ? "child" : ""  %>">
			<div class="leftfloating rightaligned" style="width: <%#Container.CurrentPage.Indent * 6%>%;">
				<img runat="server" Visible='<%# Container.HasChildren %>' src="~/images/closedMenuArrow.gif" width="7" height="7" translate="/templates/common/pagehaschildren" />
			</div>
			<div class="rightfloating" style="width: <%#((100) - Container.CurrentPage.Indent * 6)%>%;">
				<episerver:property runat="server" PropertyName="PageLink" CssClass="menulinkactive" />
			</div>
		</div>
	</SelectedItemTemplate>
	
	<TopTemplate>
		<div class="menuitem">
			<div class="leftfloating rightaligned" style="width: <%#Container.CurrentPage.Indent * 6%>%;">
				<img runat="server" Visible='<%# Container.HasChildren %>' src="~/images/closedMenuArrow.gif" width="7" height="7" translate="/templates/common/pagehaschildren" />
			</div>
			<div class="rightfloating" style="width: <%#((100) - Container.CurrentPage.Indent * 6)%>%;">
				<episerver:property runat="server" PropertyName="PageLink" CssClass="menulink" />
			</div>
		</div>
	</TopTemplate>

	<SelectedTopTemplate>
		<div class="menuitemselected">
			<div class="leftfloating rightaligned" style="width: <%#Container.CurrentPage.Indent * 6%>%;">
				<img runat="server" Visible='<%# Container.HasChildren %>' src="~/images/openMenuArrow.gif" width="7" height="7" translate="/templates/common/pagehaschildren" />
			</div>
			<div class="rightfloating" style="width: <%#((100) - Container.CurrentPage.Indent * 6)%>%;">
				<episerver:property runat="server" PropertyName="PageLink" CssClass="menulinkactive" />
			</div>
		</div>
	</SelectedTopTemplate>

	<ExpandedTopTemplate>
		<div class="menuitemexpanded">
			<div class="leftfloating rightaligned" style="width: <%#Container.CurrentPage.Indent * 6%>%;">
				<img runat="server" Visible='<%# Container.HasChildren %>' src="~/images/openMenuArrow.gif" width="7" height="7" translate="/templates/common/pagehaschildren" />
			</div>
			<div class="rightfloating" style="width: <%#((100) - Container.CurrentPage.Indent * 6)%>%;">
				<episerver:property runat="server" PropertyName="PageLink" CssClass="menulink" />
			</div>
		</div>
	</ExpandedTopTemplate>

	<FooterTemplate>
		<br />
	</FooterTemplate>
</episerver:PageTree>