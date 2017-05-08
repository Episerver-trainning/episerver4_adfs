<%@ Page language="c#" Codebehind="SyncGroup.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Admin.SyncGroup" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>SyncGroup</title>
		<meta content="Microsoft Visual Studio 7.0" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css" type="text/css" rel="stylesheet">
	</HEAD>
	<body>
		<episerversys:systemprefix id="SystemPrefix" runat="server" />
		<form id="SyncGroup" method="post" runat="server">
			<asp:datagrid id="LocalGroupList" AutoGenerateColumns="False" Runat="server" OnDataBinding="SetHeaders" CssClass="EP-tableGrid">
				<Columns>
					<asp:TemplateColumn ItemStyle-HorizontalAlign="Center" HeaderStyle-CssClass="EP-tableHeadingGrid" ItemStyle-CssClass="EP-tableCellGrid">
						<ItemTemplate>
							<asp:CheckBox Runat="server" />
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:BoundColumn DataField="IsWindowsGroup" Visible="False" />
					<asp:BoundColumn DataField="Name" HeaderStyle-CssClass="EP-tableHeadingGrid" ItemStyle-CssClass="EP-tableCellGrid" />
					<asp:BoundColumn DataField="Description" HeaderStyle-CssClass="EP-tableHeadingGrid" ItemStyle-CssClass="EP-tableCellGrid" />
					<asp:BoundColumn DataField="GroupType" Visible="False" />
					<asp:BoundColumn DataField="LdapName" HeaderStyle-CssClass="EP-tableHeadingGrid" ItemStyle-CssClass="EP-tableCellGrid" />
				</Columns>
			</asp:datagrid>
			<P>
				<asp:Button id="ApplyButton" runat="server" Translate="/button/save"></asp:Button>
				<asp:Button id="CancelButton" runat="server" Translate="/button/cancel"></asp:Button>
			</P>
		</form>
	</body>
</HTML>
