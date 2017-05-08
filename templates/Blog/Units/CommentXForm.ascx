<%-- @(#) $Id: CommentXForm.ascx,v 1.1.2.2 2006/02/28 11:02:39 sl Exp $ --%>
<%-- Copyright © 2006 ElektroPost Stockholm AB. All Rights Reserved. --%>
<%@ Control Language="c#" AutoEventWireup="false" Codebehind="CommentXForm.ascx.cs" Inherits="development.Templates.Blog.Units.CommentXForm" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="XForms" Namespace="EPiServer.XForms.WebControls" Assembly="EPiServer.XForms" %>
<p>
	<asp:LinkButton Runat="server" ID="buttonShowComments" />
</p>
<asp:Repeater Runat="server" id="commentList" Visible="False">
	<ItemTemplate>
		<h3><%# DataBinder.GetPropertyValue(Container.DataItem, "PosterEmail") %> <%# DataBinder.GetPropertyValue(Container.DataItem, "PostedDate") %></h3>
		<p><%# DataBinder.GetPropertyValue(Container.DataItem, "PostedText") %></p>
	</ItemTemplate>
	<SeparatorTemplate>
		<hr class="light" />
	</SeparatorTemplate>
</asp:Repeater>
<p>
	<asp:LinkButton Runat="server" ID="buttonShowCommentXForm" Translate="/templates/blog/postcomment" />
</p>
<XForms:XFormControl runat="server" ID="submitCommentXForm" Visible="false" />
