<%-- @(#) $Id: PersonalBlog.ascx,v 1.1.2.3 2006/03/13 13:49:47 sl Exp $ --%>
<%-- Copyright © 2006 ElektroPost Stockholm AB. All Rights Reserved. --%>
<%@ Control Language="c#" AutoEventWireup="false" Codebehind="PersonalBlog.ascx.cs" Inherits="development.Templates.Blog.Units.PersonalBlog" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="development" TagName="PageBody" Src="~/templates/Units/PageBody.ascx"%>
<%@ Register TagPrefix="development" TagName="Listing" Src="~/templates/Blog/Units/BlogList.ascx"%>
<%@ Register TagPrefix="development" TagName="EditList" Src="~/templates/Blog/Units/EditListing.ascx"%>
<asp:Panel ID="pnlView" Runat="server">
    <development:Listing runat="server" /><br/>
</asp:Panel>
<asp:Panel ID="pnlEdit" Runat="server" Visible="False">
    <development:EditList runat="server" id="editList" />
</asp:Panel>
