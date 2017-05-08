<%@ Control Language="c#" AutoEventWireup="false" Codebehind="WsrpThreeColumnLayout.ascx.cs" Inherits="development.Templates.WsrpThreeColumnLayout" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<%@ Register tagprefix="development" TagName="WsrpDefaultPortletArea" Src="~/templates/units/WsrpDefaultPortletArea.ascx" %>
<div <%# ViewMode == "Design" ? " class=\"designareacolumn\" " : ""%>> 
	<div Area="0" class="left <%# this.ViewMode == "Design" ? "designcolumn threecolumnwidthdesign" : "viewcolumn threecolumnwidth" %>"><development:WsrpDefaultPortletArea id="Area1" runat="server" ViewMode='<%# this.ViewMode %>' /></div>
	<div Area="1" class="left <%# this.ViewMode == "Design" ? "designcolumn threecolumnwidthdesign" : "viewcolumn threecolumnwidth" %>"><development:WsrpDefaultPortletArea id="Area2" runat="server" ViewMode='<%# this.ViewMode %>' /></div>
	<div Area="2" class="left <%# this.ViewMode == "Design" ? "designcolumn threecolumnwidthdesign" : "viewcolumn threecolumnwidth" %>"><development:WsrpDefaultPortletArea id="Area3" runat="server" ViewMode='<%# this.ViewMode %>' /></div>
</div>