<%@ Control Language="c#" AutoEventWireup="false" Codebehind="LogServicePageHits.ascx.cs" Inherits="development.Templates.Units.LogServicePageHits" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<span class="listheading"><EPiServer:Translate Text="/templates/logservice/pagehits/heading" id="Heading" runat="server" /></span>
<% =PageHits %>
<% =RPS %>
<br/>
