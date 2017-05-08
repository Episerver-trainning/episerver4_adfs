<%@ Control Language="c#" AutoEventWireup="false" Codebehind="LogServiceLastUsers.ascx.cs" Inherits="development.Templates.Units.LogServiceLastUsers" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ OutputCache Duration="10" VaryByParam="none" %>
<span class="listheading"><EPiServer:Translate Text="/templates/logservice/lastusers/heading" id="Heading" runat="server" /></span>
<% =ActiveUsers %>
<% =CountUsers %>
<br/>
