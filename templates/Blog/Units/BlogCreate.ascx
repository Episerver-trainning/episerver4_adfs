<%-- @(#) $Id: BlogCreate.ascx,v 1.1.2.2 2006/02/28 11:02:29 sl Exp $ --%>
<%-- Copyright © 2006 ElektroPost Stockholm AB. All Rights Reserved. --%>
<%@ Control Language="c#" AutoEventWireup="false" Codebehind="BlogCreate.ascx.cs" Inherits="development.Templates.Blog.Units.BlogCreate" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<p>
	<asp:Button id="showButton" Translate="/templates/blog/createnewblog" runat="server" /> 
</p>
<p>
    <asp:Label ID="newBlogNameLabel" Translate="/templates/blog/name" Runat=server />
	<asp:TextBox ID="newBlogNameTextBox" Runat="server" Width="20em" />
</p>
<p>
	<asp:Button ID="createButton" Runat="server" Translate="/templates/blog/createblog" />
</p>
