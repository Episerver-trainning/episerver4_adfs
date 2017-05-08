<%@ Control EnableViewState="False" Language="c#" AutoEventWireup="false" Codebehind="NavigationPath.ascx.cs" Inherits="EPiServer.Util.FileManager.NavigationPath" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<div class="FM-BreadCrumb">
		<EPiServer:Translate Text="/filemanager/path" runat="server"/>: <asp:PlaceHolder ID="Path" Runat="server"/>
</div>
