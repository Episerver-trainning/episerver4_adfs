<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<%@ Control Language="c#" AutoEventWireup="false" Codebehind="PlugInList.ascx.cs" Inherits="EPiServer.Admin.PlugInList" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>

<asp:Repeater ID="typeList" Runat="server">

	<HeaderTemplate>
		<table>
			<tr>
				<td>		
	</HeaderTemplate>

	<ItemTemplate>
		<br>
		<h2><%# DataBinder.Eval(Container.DataItem,"TypeName") %></h2>
		<table class="EP-tableGrid" width="100%">
			<asp:Repeater
				Runat="server"
				dataSource='<%# DataBinder.Eval(Container.DataItem,"MembersTable") %>'
			>
				<HeaderTemplate>
					<tr>
						<td class="EP-tableHeadingGrid">
							<EPiServer:Translate Text="/admin/pluginlist/enabled" runat="server"/>
						</td>
						<td class="EP-tableHeadingGrid">
							<EPiServer:Translate Text="/admin/pluginlist/name" runat="server" ID="Translate1"/>
						</td>
						<td class="EP-tableHeadingGrid">
							<EPiServer:Translate Text="/admin/pluginlist/description" runat="server" ID="Translate2"/>
						</td>
						<!--td class="EP-tableHeadingGrid">
							<EPiServer:Translate Text="/admin/pluginlist/license" runat="server" ID="Translate3"/>
						</td-->
						<asp:PlaceHolder Runat="server" Visible=<%#ShowGroup%> ID="Placeholder1">
						<td class="EP-tableHeadingGrid">
							<EPiServer:Translate Text="/admin/pluginlist/plugin" runat="server" ID="Translate4"/>
						</td>
						</asp:PlaceHolder>
					</tr>				
				</HeaderTemplate>
				<ItemTemplate>
					<tr>
						<td class="EP-tableCellGrid">
							<asp:CheckBox Runat="server" Enabled=<%#Editable%> Checked='<%# DataBinder.Eval(Container.DataItem,"Enabled") %>' Name='<%# DataBinder.Eval(Container.DataItem,"ID").ToString() %>'/>
						</td>
						<td class="EP-tableCellGrid">
							<%# DataBinder.Eval(Container.DataItem,"DisplayName") %>
						</td>
						<td width="300" class="EP-tableCellGrid">
							<%# DataBinder.Eval(Container.DataItem,"Description") %>
						</td>
						<!--td class="EP-tableCellGrid">
							<%# DataBinder.Eval(Container.DataItem,"Licensing") %>
						</td-->
						<asp:PlaceHolder Runat="server" Visible=<%#ShowGroup%>>
						<td class="EP-tableCellGrid">
							<a href="PlugInEdit.aspx?group=<%# Server.UrlEncode(DataBinder.Eval(Container.DataItem,"GroupFullName").ToString()) %>"><%# DataBinder.Eval(Container.DataItem,"Group") %></a>
						</td>
						</asp:PlaceHolder>
					</tr>
				</ItemTemplate>	
			</asp:Repeater>
		</table>
	</ItemTemplate>

	<FooterTemplate>
				</td>
			</tr>
		</table>
	</FooterTemplate>

</asp:Repeater>

