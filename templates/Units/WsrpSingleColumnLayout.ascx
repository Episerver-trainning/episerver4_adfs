<%@ Control Language="c#" AutoEventWireup="false" Codebehind="WsrpSingleColumnLayout.ascx.cs" Inherits="development.Templates.WsrpSingleColumnLayout" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<%@ Register tagprefix="development" TagName="WsrpDefaultPortletArea" Src="~/templates/units/WsrpDefaultPortletArea.ascx" %>
<div <%# ViewMode == "Design" ? " class=\"designareacolumn\" " : ""%>> 
	<div Area="0" class="left <%# this.ViewMode == "Design" ? "designcolumn singlecolumnwidth" : "viewcolumn singlecolumnwidth" %>"><development:WsrpDefaultPortletArea id="MainPortletArea" runat="server" ViewMode='<%# this.ViewMode %>' /></div>
</div>
