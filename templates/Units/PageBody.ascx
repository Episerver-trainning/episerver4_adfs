<%@ Control Language="c#" AutoEventWireup="false" Codebehind="PageBody.ascx.cs" Inherits="development.Templates.Units.PageBody" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<div>
<EPiServer:Property ID="PageBody" runat="server" PropertyName="MainBody" />
</div>