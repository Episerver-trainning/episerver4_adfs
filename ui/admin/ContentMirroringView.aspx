<%@ Page language="c#" Codebehind="ContentMirroringView.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Admin.ContentMirroringView" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Import Namespace="EPiServer.Enterprise.Mirroring" %>
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

	<script runat="server">

	protected object GetQueueCount(object dest)
	{
	
		try
		{
			return DataBinder.Eval(dest,"Queue.Length");
		}
		catch(Exception e)
		{
			return "Error! " + e.Message;
		}

	}

	</script>
  </head>
  <body MS_POSITIONING="GridLayout">
    <form id="Cluster" method="post" runat="server">
		<episerversys:systemprefix id="pagePrefix" runat="server" />
		<br /><br />
		<asp:Panel Visible="False" ID="resetPanel" Runat="server">
			<asp:Button Translate="#continuereset" OnClick="ContinueWithReset" Runat="server"/>
			<asp:Button Translate="/button/cancel" OnClick="CancelReset" Runat="server" ID="Button5"/>
		</asp:Panel>
		<asp:Panel ID="defaultPanel" Runat="server">
		
		<div><strong><EPiServer:Translate Text="#lastchanges" runat="server"/></strong>: <asp:Label Runat="server" ID="LastUpdateLabel"/></div>
		<br>
		
		<asp:Repeater ID="list" Runat="server">
		<HeaderTemplate>
			<table width="40%" class="EP-tableGrid">
			<tr>
			<td class="EP-tableHeadingGrid">
				<episerver:translate Text="#name" runat="server" ID="Translate2"/>	
			</td>
			<td class="EP-tableHeadingGrid">
				<episerver:translate Text="#type" runat="server" ID="Translate5"/>	
			</td>
			<td class="EP-tableHeadingGrid">
				<episerver:translate Text="#laststatus" runat="server" ID="Translate3"/>	
			</td>
			<td class="EP-tableHeadingGrid">
				<episerver:translate Text="#lastexecution" runat="server" ID="Translate4"/>	
			</td>
			<td class="EP-tableHeadingGrid">
				<episerver:translate Text="#queuelength" runat="server" ID="Translate1"/>	
			</td>
			<td class="EP-tableHeadingGrid">
			</td>
			</tr>
			
		</HeaderTemplate>
		<ItemTemplate>
			<tr>
			<td class="EP-tableCellGrid">
				<a href="ContentPublisherEdit.aspx?channel=<%#Request.QueryString["id"]%>&id=<%#DataBinder.Eval(Container.DataItem,"ID")%>"><%#DataBinder.Eval(Container.DataItem,"Name")%></a>
			</td>
			<td class="EP-tableGrid">
				<%# EPiServer.Global.EPLang.Translate("#" + ((string)DataBinder.Eval(Container.DataItem,"Type")).ToLower()) %>
			</td>
			<td class="EP-tableCellGrid">
				<%#DataBinder.Eval(Container.DataItem,"Status")%>
			</td>
			<td class="EP-tableCellGrid">
				<%#((DateTime)DataBinder.Eval(Container.DataItem,"LastExecution"))==DateTime.MinValue ? "" : DataBinder.Eval(Container.DataItem,"LastExecution") %>
			</td>
			<td class="EP-tableCellGrid">
				<%#GetQueueCount(Container.DataItem)%>
			</td>
			<td class="EP-tableCellGrid">
				<asp:Button Runat="server" Translate="#editqueue" Enabled='<%# (int)GetQueueCount(Container.DataItem) > 0 %>' OnCommand="EditQueue_Command" CommandArgument='<%#DataBinder.Eval(Container.DataItem,"ID")%>' />
			</td>
			</tr>
		</ItemTemplate>
		<FooterTemplate></table></FooterTemplate>
		</asp:Repeater>
		<br>
		<asp:Button OnClick="CreateDestination" Runat="Server" Translate="#createdestination" ID="CreateButton" />
		<asp:Button OnClick="Settings" Runat="Server" Translate="/button/settings" />
		<asp:Button OnClick="Reset" Runat="Server" Translate="#reset"/>
		<asp:Button OnClick="Cancel" Runat="Server" Translate="/button/cancel"/>
		</asp:Panel>
     </form>
  </body>
</html>