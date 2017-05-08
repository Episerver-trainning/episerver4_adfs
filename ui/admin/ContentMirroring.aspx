<%@ Page language="c#" Codebehind="ContentMirroring.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Admin.ContentMirroring" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" > 
<html>
  <head>
    <title>MirroringInfo</title>
    <meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
    <meta name="CODE_LANGUAGE" Content="C#">
    <meta name=vs_defaultClientScript content="JavaScript">
    <meta name=vs_targetSchema content="http://schemas.microsoft.com/intellisense/ie5">
    <script type='text/javascript' src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/system.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css">
  </head>
  <body MS_POSITIONING="GridLayout">
    <form id="Cluster" method="post" runat="server">
		<episerversys:systemprefix id="pagePrefix" runat="server" />
		<br /><br />
		<asp:Repeater ID="list" Runat="server" OnItemCreated="ListRepeater_ItemCreated">
		<HeaderTemplate>
			<table width="40%" class="EP-tableGrid">
			<tr>
			<td class="EP-tableHeadingGrid">
				<episerver:translate Text="#name" runat="server" ID="Translate2"/>	
			</td>
			<td class="EP-tableHeadingGrid">
				<episerver:translate Text="#order" runat="server" ID="Translate1"/>	
			</td>
			</tr>
			
		</HeaderTemplate>
		<ItemTemplate>
			<tr>
			<td class="EP-tableCellGrid">
				<a href="ContentMirroringView.aspx?id=<%#DataBinder.Eval(Container.DataItem,"ID")%>"><%#DataBinder.Eval(Container.DataItem,"Name")%></a>
			</td>
			<td class="EP-tableCellGrid">
				<asp:LinkButton ID="moveUpLinkButton" Runat="server" text='<%# Translate("#moveup") %>' OnCommand="MoveUpLinkButton_Command" CommandArgument='<%#DataBinder.Eval(Container.DataItem,"ID")%>' />
				&nbsp;&nbsp;
				<asp:LinkButton ID="moveDownLinkbutton" Runat="server" text='<%# Translate("#movedown") %>' OnCommand="MoveDownLinkButton_Command" CommandArgument='<%#DataBinder.Eval(Container.DataItem,"ID")%>' />
			</td>
			</tr>
		</ItemTemplate>
		<FooterTemplate></table></FooterTemplate>
		</asp:Repeater>
		<br>
		<asp:Button OnClick="CreateSite" Runat="Server" Translate="/button/create" ID="Button1"/>
     </form>
  </body>
</html>