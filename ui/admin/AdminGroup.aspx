<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<%@ Page language="c#" Codebehind="AdminGroup.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Admin.AdminGroup" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
  <HEAD>
		<title>SyncGroup</title>
		<meta content="Microsoft Visual Studio 7.0" name=GENERATOR>
		<meta content=C# name=CODE_LANGUAGE>
		<meta content=JavaScript name=vs_defaultClientScript>
		<meta content=http://schemas.microsoft.com/intellisense/ie5 name=vs_targetSchema><LINK href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css" type=text/css rel=stylesheet >
  </HEAD>
	<body MS_POSITIONING="FlowLayout"><EPiServerSys:systemprefix id=SystemPrefix runat="server"/>
		<form id=AdminGroup method=post runat="server">
			<asp:datagrid id=GroupList AutoGenerateColumns="False" Runat="server" OnPreRender="SetButtonText" OnDataBinding="SetHeaders" CssClass="EP-tableGrid">
				<Columns>
					<asp:BoundColumn Visible="False" DataField="ID"></asp:BoundColumn>
					<asp:BoundColumn DataField="Type">
						<HeaderStyle CssClass="EP-tableHeadingGrid">
						</HeaderStyle>
						<ItemStyle CssClass="EP-tableCellGrid">
						</ItemStyle>
					</asp:BoundColumn>
					<asp:TemplateColumn>
						<ItemTemplate>
							<a href="EditUser.aspx?id=<%# DataBinder.Eval(Container.DataItem, "ID")%>&type=<%# (int)DataBinder.Eval(Container.DataItem, "Type")%>"><%# DataBinder.Eval(Container.DataItem, "Name")%></a>
						</ItemTemplate>
						<HeaderStyle CssClass="EP-tableHeadingGrid">
						</HeaderStyle>
						<ItemStyle CssClass="EP-tableCellGrid">
						</ItemStyle>
					</asp:TemplateColumn>
					<asp:BoundColumn DataField="Description">
						<HeaderStyle CssClass="EP-tableHeadingGrid">
						</HeaderStyle>
						<ItemStyle CssClass="EP-tableCellGrid">
						</ItemStyle>
					</asp:BoundColumn>
					<asp:BoundColumn DataField="ADsPath">
						<HeaderStyle CssClass="EP-tableHeadingGrid">
						</HeaderStyle>
						<ItemStyle CssClass="EP-tableCellGrid">
						</ItemStyle>
					</asp:BoundColumn>
					<asp:ButtonColumn ButtonType="PushButton" CommandName="Delete">
						<HeaderStyle CssClass="EP-tableHeadingGrid">
						</HeaderStyle>
						<ItemStyle CssClass="EP-tableCellGrid">
						</ItemStyle>
					</asp:ButtonColumn>
				</Columns>
			</asp:datagrid>
			<asp:Panel ID="CreateGroupPanel" Runat="Server" Visible="false">
			<TABLE>
			<TR>
				<TD>
					<episerver:Translate id=Translate8 runat="server" Text="#group"></episerver:Translate>
				</TD>
				<TD>
					<asp:TextBox id=GroupName Runat="server"></asp:TextBox>
				</TD>
			</TR>
			<TR>
				<TD>
					<episerver:Translate id=Translate1 runat="server" Text="#description"></episerver:Translate>
				</TD>
				<TD>
					<asp:TextBox id=GroupDescription Runat="server"></asp:TextBox>
				</TD>
			</TR>
			<TR>
				<TD>
					<asp:button id=SaveGroup onclick=SaveGroup_Click runat="server" Translate="/button/addgroupsid"></asp:button>
				</TD>
			</TR>
			</TABLE>
			<script type="text/javascript">
			function handleKeyPressed()
			{
				if(event.keyCode == 13 && event.srcElement.type != 'submit')
				{
					document.all['<%=SaveGroup.ClientID%>'].click();
					return false;
				}
				return true;
			}
			document.body.attachEvent("onkeydown",handleKeyPressed);
			</script>
			</asp:Panel>
			<br />
			<table runat="server" id="CommandTable">
				<tr>
					<td><episerver:Translate runat="server" text="#newgroupinfo" /></td>
					<td><asp:button id=AddGroupButton Translate="/admin/secedit/newgroupheading" runat="server" OnClick="AddGroupButton_Click" /></td>
				</tr>
				<tr>
					<td><episerver:Translate runat="server" text="#syncinfo" ID="Translate2" NAME="Translate2"/></td>
					<td><asp:button id=SyncLocalGroupsButton Translate="/admin/admingroup/syncbutton" runat="server" /></td>
				</tr>
				<tr runat="server" id="SyncLdapGroups">
					<td><episerver:Translate runat="server" text="#ldapinfo" ID="Translate3" NAME="Translate2"/></td>
					<td>
						<asp:TextBox ID="LdapSearchString" Runat="server" />
						<asp:Button ID="SyncLdapGroupsButton" Runat="server" translate="/admin/admingroup/syncldapbutton" OnClick="SyncLdapGroupsButton_Click" />
					</td>
				</tr>
			</table>
		</form>
	</body>
</HTML>
