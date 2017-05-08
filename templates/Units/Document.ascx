<%@ Control Language="c#" AutoEventWireup="false" Codebehind="Document.ascx.cs" Inherits="development.Templates.Units.Document" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<div class="fullwidth">
	<div class="DocumentFrameHeader">

	<a href="<%=ParentLinkURL%>"><img class="borderless" src="<%=Configuration.RootDir%>images/list_up.gif" alt=""><EPiServer:Translate Text="/templates/document/backtolist" runat="server"/></a>
	<a href="<%=contentFrame.Attributes["src"]%>" target="_blank"><img alt="" class="borderless" src="<%=Configuration.RootDir%>images/open_in_window.gif"><EPiServer:Translate Text="/templates/document/openinnewwindow" runat="server" ID="Translate1" NAME="Translate1"/></a>
	</div>

	<iframe frameborder="0" name="contentFrame" src="" id="contentFrame" runat="server"></iframe>
</div>