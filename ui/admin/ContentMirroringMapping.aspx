<%@ Page language="c#" AutoEventWireup="false" Inherits="EPiServer.Admin.ContentMirroringMapping" CodeBehind="ContentMirroringMapping.aspx.cs" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Import Namespace="System.Data" %>
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
		<h1><%= String.Format(EPiServer.Global.EPLang.Translate("#title"), ChannelName) %></h1>
		<span class="EP-systemInfo">
			<episerver:Translate runat="server" Text="#message" />
		</span><br /><br />
		<EPiServerSys:ConfirmButton Function="confirmDeleteAll()" Runat="server" Translate="#deleteall" OnClick="DeleteState" /><br /><br />
		<h2><episerver:Translate runat="server" Text="#pagemapping" /></h2>
		<asp:Repeater Runat="server" ID="pageLookup">
			<HeaderTemplate>
				<table class="EP-tableGrid">
					<tr>
						<td class="EP-tableHeadingGrid"><episerver:Translate runat="server" Text="#sourceid" /></td>
						<td class="EP-tableHeadingGrid"><episerver:Translate runat="server" Text="#targetid" /></td>
						<td class="EP-tableHeadingGrid"><episerver:Translate runat="server" Text="#pagename"/></td>
						<td class="EP-tableHeadingGrid"></td>
					</tr>
			</HeaderTemplate>
			<ItemTemplate>
					<tr>
						<td class="EP-tableCellGrid"><%#((DataRowView)Container.DataItem)["SourceId"]%></td>
						<td class="EP-tableCellGrid"><%#((DataRowView)Container.DataItem)["TargetId"]%></td>
						<td class="EP-tableCellGrid"><%#((EPiServer.Core.PageData)((DataRowView)Container.DataItem)["PageData"]).PageName%></td>
						<td class="EP-tableCellGrid"><EPiServerSys:ConfirmButton Function="confirmDelete()" runat="server" OnCommand="DeleteMappingCommand" CommandArgument='<%#((DataRowView)Container.DataItem)["SourceId"]%>' Translate="#delete" /></td>
					</tr>
			</ItemTemplate>
			<FooterTemplate>
				</table>
			</FooterTemplate>
		</asp:Repeater>
					
		<h2><episerver:Translate runat="server" Text="#foldermapping" /></h2>
		<asp:Repeater Runat="server" ID="folderLookup">
			<HeaderTemplate>
				<table class="EP-tableGrid">
					<tr>
						<td class="EP-tableHeadingGrid"><episerver:Translate runat="server" Text="#sourceid" /></td>
						<td class="EP-tableHeadingGrid"><episerver:Translate runat="server" Text="#targetid" /></td>
						<td class="EP-tableHeadingGrid"><episerver:Translate runat="server" Text="#pagename" /></td>
						<td class="EP-tableHeadingGrid"></td>
					</tr>
			</HeaderTemplate>
			<ItemTemplate>
					<tr>
						<td class="EP-tableCellGrid"><%#((DataRowView)Container.DataItem)["SourceId"]%></td>
						<td class="EP-tableCellGrid"><%#((DataRowView)Container.DataItem)["SourceId"]%></td>
						<td class="EP-tableCellGrid"></td>
						<td class="EP-tableCellGrid"><EPiServerSys:ConfirmButton Function="confirmDelete()" runat="server" OnCommand="DeleteFolderMappingCommand" CommandArgument='<%#((DataRowView)Container.DataItem)["SourceId"]%>' Translate="#delete" /></td>
					</tr>
			</ItemTemplate>
			<FooterTemplate>
				</table>
			</FooterTemplate>
		</asp:Repeater>	
			
     </form>
     <script type="text/javascript" language="javascript">
		function confirmDelete() {
			return confirm('<%= EPiServer.Global.EPLang.TranslateForScript("#deletemessage") %>');
		}
		function confirmDeleteAll() {
			return confirm('<%= EPiServer.Global.EPLang.TranslateForScript("#deleteallmessage") %>');
		}
     </script>
  </body>
</html>