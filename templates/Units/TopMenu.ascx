<%@ Control Language="c#" AutoEventWireup="false" Codebehind="TopMenu.ascx.cs" Inherits="development.Templates.Units.TopMenu" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<EPiServer:MenuList runat="server" ID="MenuListControl" PageLink='<%#MenuRoot%>'>
	<HeaderTemplate>
		<div id="topmenucontrol">
	</HeaderTemplate>
	<ItemTemplate>
		<EPiServer:Property CssClass="menuhead" PropertyName="PageLink" runat="server" />&nbsp;
	</ItemTemplate>
	<SelectedTemplate>
		<EPiServer:Property CssClass="activemenuhead" PropertyName="PageLink" runat="server" />&nbsp;
	</SelectedTemplate>
	<FooterTemplate>
		</div> 
	</FooterTemplate>
</EPiServer:MenuList>