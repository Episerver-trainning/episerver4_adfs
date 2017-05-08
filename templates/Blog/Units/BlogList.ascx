<%-- @(#) $Id: BlogList.ascx,v 1.1.2.2 2006/02/28 11:02:32 sl Exp $ --%>
<%-- Copyright © 2006 ElektroPost Stockholm AB. All Rights Reserved. --%>
<%@ Control Language="c#" AutoEventWireup="false" Codebehind="BlogList.ascx.cs" Inherits="development.Templates.Blog.Units.BlogList" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="development" TagName="CommentXForm" Src="~/templates/Blog/Units/CommentXForm.ascx"%>
<asp:Repeater runat="server" id="dataRepeater">
	<ItemTemplate>
		<%# DataBinder.GetPropertyValue(Container.DataItem, "PostedText") %>
		<development:CommentXForm runat="server" XFormDataId='<%# DataBinder.GetPropertyValue(Container.DataItem, "XFormDataId") %>'  />
	</ItemTemplate>
	<SeparatorTemplate>
		<hr/>
	</SeparatorTemplate> 
</asp:Repeater>
