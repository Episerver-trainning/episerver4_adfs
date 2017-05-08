<%-- @(#) $Id: EditorBlog.ascx,v 1.1.2.3 2006/03/24 15:16:57 ft Exp $ --%>
<%-- Copyright © 2006 ElektroPost Stockholm AB. All Rights Reserved. --%>
<%@ Control Language="c#" AutoEventWireup="false" Codebehind="EditorBlog.ascx.cs" Inherits="development.Templates.Blog.Units.EditorBlog" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<p>
    <%= EPiServer.Global.EPLang.Translate("/templates/blog/title") %>
	<asp:TextBox ID="txtTitle" Runat="server" Width="20em" />
</p>
<EPiServer:Property PropertyName="_Content" runat="server" id="BlogPost" EditMode="True" height="300px" width="550px"/>
<br />
<asp:Button Runat=server ID="btnPublish" Translate="/button/publish" />
<asp:Button Runat=server ID="btnUnpublish" Translate="/button/unpublish" />
<asp:Button Runat=server ID="btnCancel" Translate="/button/cancel" />
