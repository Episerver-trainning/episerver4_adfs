<%-- @(#) $Id: BlogStart.aspx,v 1.1.2.2 2006/02/28 11:02:22 sl Exp $ --%>
<%-- Copyright © 2006 ElektroPost Stockholm AB. All Rights Reserved. --%>
<%@ Page language="c#" Codebehind="BlogStart.aspx.cs" AutoEventWireup="false" Inherits="development.Templates.Blog.BlogStart" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="development" TagName="DefaultFramework" Src="~/templates/Frameworks/DefaultFramework.ascx"%>
<%@ Register TagPrefix="development" TagName="PageBody" Src="~/templates/Units/PageBody.ascx"%>
<%@ Register TagPrefix="development" TagName="BlogCreate" Src="~/templates/Blog/Units/BlogCreate.ascx"%>
<development:DefaultFramework ID="DefaultMode" runat="server">
    <EPiServer:Content Region="mainAndRightRegion" runat="server">
        <h1><EPiServer:Property propertyname="PageName" runat="server" /></h1>
        <development:PageBody runat="server"/>
        <development:BlogCreate runat="server" id="create" />
    </EPiServer:Content>
</development:DefaultFramework>