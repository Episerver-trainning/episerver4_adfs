<%@ Page language="c#" AutoEventWireup="false" Inherits="EPiServer.Admin.ContentMirroringQueue" CodeBehind="ContentMirroringQueue.aspx.cs" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="EPiServer.Core" %>
<html>
  <head>
    <title>Mirroring Queue Editor</title>
    <meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
    <meta name="CODE_LANGUAGE" Content="C#">
    <meta name=vs_defaultClientScript content="JavaScript">
    <meta name=vs_targetSchema content="http://schemas.microsoft.com/intellisense/ie5">
    <script type='text/javascript' src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/system.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css">
  </head>
  <body MS_POSITIONING="GridLayout">
    <form id="Cluster" method="post" runat="server">
		<EPiServerSys:SystemPrefix ID="SystemPageHead" MessageStyle="Warning" runat="server"/>
		
		<asp:Repeater Runat="server" ID="PackageRepeater">

			<ItemTemplate>
				<br />
				<b><asp:Label Runat="server" Translate="#packagetitle" /> '<%# DataBinder.Eval(Container.DataItem, "ItemId") %>'</b>&nbsp;<EPiServerSys:ConfirmButton Function="confirmDelete()" Runat="server" OnCommand="Delete_Command" CommandArgument='<%# ((DataRowView)Container.DataItem)["ItemId"]%>' Translate="#deletepackage" /><br />
				<asp:Label Runat="server" Translate="#created" />: <%# DataBinder.Eval(Container.DataItem, "Created") %><br /><br />
				<asp:Repeater Runat="server" ID="DiffRepeater" 
					DataSource='<%# ((DataRowView)Container.DataItem).Row.GetChildRows("PackageDiff") %>'>

					<HeaderTemplate>
						<table class="EP-tableGrid">
							<tr>
								<td class="EP-tableHeadingGrid"><EPiServer:Translate runat="server" Text="#type" /></td>
								<td class="EP-tableHeadingGrid"><EPiServer:Translate runat="server" Text="#pagename" /></td>
								<td class="EP-tableHeadingGrid"><EPiServer:Translate runat="server" Text="#pageid" /></td>
								<td class="EP-tableHeadingGrid"></td>
							</tr>
					</HeaderTemplate>

					<ItemTemplate>
							<tr>
								<td class="EP-tableCellGrid"><%# ((DataRow)Container.DataItem)["ChangeType"]%></td>
								<td class="EP-tableCellGrid"><%# ((DataRow)Container.DataItem)["PageName"] %></td>
								<td class="EP-tableCellGrid"><%# ((DataRow)Container.DataItem)["PageId"] %></td>
								<td class="EP-tableCellGrid"><EPiServerSys:ConfirmButton Function="confirmDelete()" Runat="server" OnCommand="Delete_Command" CommandArgument='<%# ((DataRow)Container.DataItem)["ItemId"]%>' Translate="/button/delete" /></td>
							</tr>
					</ItemTemplate>

					<FooterTemplate>
						</table>
					</FooterTemplate>

				</asp:Repeater><br /><br />
			</ItemTemplate>

		</asp:Repeater><br />
		<asp:Button Runat="server" OnClick="Cancel_Command" Translate="/button/cancel" />
     </form>
     <script type="text/javascript" language="javascript">
		function confirmDelete() {
			return confirm('<%= EPiServer.Global.EPLang.TranslateForScript("#deletewarningi0") %>\n\n - <%= EPiServer.Global.EPLang.TranslateForScript("#deletewarningi1") %>\n - <%= EPiServer.Global.EPLang.TranslateForScript("#deletewarningi2") %>');
		}
     </script>
  </body>
</html>