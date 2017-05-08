<%@ Page language="c#" Codebehind="SearchUsers.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Admin.SearchUsers" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" > 

<html>
  <head>
    <title>SearchUsers</title>
    <script type='text/javascript' src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/system.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css">
  </head>
  <body MS_POSITIONING="GridLayout">
	
    <form id="SearchUsers" method="post" runat="server">
		<EPiServerSys:SystemPrefix runat="server" ID="Systemprefix1"/>
		<br /><br />
		<table border="0" cellpadding="2" cellspacing="1">
			<tr>
				<td class="EPEdit-tableColumn" valign="top">
					<episerver:Translate Text="#typecaption" runat="server" ID="Translate6"/>
				</td>
				<td class="EPEdit-tableColumn">
				<asp:DropDownList ID="GroupSelection" Runat="server"></asp:DropDownList>
				</td>
				<td></td>
				<td></td>
			</tr>					
			<tr>
				<td width="150" class="EPEdit-tableColumn" valign="top">
					<episerver:Translate Text="/admin/secedit/editname" runat="server" ID="Translate15"/>
				</td>
				<td width="140" class="EPEdit-tableColumn">
					<asp:TextBox runat="server" ID="UserName" maxlength="50"></asp:TextBox>
				</td>
				<td class="EPEdit-tableColumn" valign="top">
					<episerver:Translate Text="/admin/secedit/firstname" runat="server" ID="Translate7"/>
				</td>
				<td class="EPEdit-tableColumn">
					<asp:TextBox runat="server" ID="FirstName" maxlength="50"></asp:TextBox>
				</td>
			</tr>			
			<tr>
				<td class="EPEdit-tableColumn" valign="top">
					<episerver:Translate Text="/admin/secedit/editemail" runat="server" ID="Translate4"/>
				</td>
				<td class="EPEdit-tableColumn">
					<asp:TextBox runat="server" ID="Email" maxlength="50"></asp:TextBox>
				</td>
				<td class="EPEdit-tableColumn" valign="top">
					<episerver:Translate Text="/admin/secedit/lastname" runat="server" ID="Translate2"/>
				</td>
				<td class="EPEdit-tableColumn">
					<asp:TextBox runat="server" ID="LastName" maxlength="50"></asp:TextBox>
				</td>
			</tr>
			<tr>
				<td class="EPEdit-tableColumn" valign="top">
					<episerver:Translate Text="#pagingsize" runat="server" ID="Translate3"/>
				</td>
				<td class="EPEdit-tableColumn">
					<asp:TextBox runat="server" ID="PagingSize" maxlength="4" Text="20"></asp:TextBox>
				</td>
				<td class="EPEdit-tableColumn" valign="top">
					<episerver:Translate Text="/admin/secedit/editcompany" runat="server" ID="Translate5"/>
				</td>
				<td class="EPEdit-tableColumn">
					<asp:TextBox runat="server" ID="Company" maxlength="50"></asp:TextBox>
				</td>
			</tr>
		</table>
		<br>
		<asp:Button translate="/button/search" Runat="server" ID="SearchButton" OnClick="Search"></asp:Button>
		<br><br>
		<asp:DataGrid
			Runat="server" 
			ID="Grid"
			AllowPaging="True"
			AllowCustomPaging="True"
			OnDataBinding="SetHeaders"
			AutoGenerateColumns="False"
			OnPageIndexChanged="PageIndexChanged"
			Width="100%"
			CssClass="EP-tableGrid">
			<PagerStyle 
				Mode="NumericPages" 
				CssClass="EP-tablePager" />
			<Columns>
				<asp:TemplateColumn HeaderStyle-CssClass="EP-tableHeadingGrid" ItemStyle-CssClass="EP-tableCellGrid">
					<ItemTemplate>
						<%#GetImageUrl( DataBinder.Eval(Container.DataItem, "Type"))%>
					</ItemTemplate>					
				</asp:TemplateColumn>
				<asp:TemplateColumn HeaderStyle-CssClass="EP-tableHeadingGrid" ItemStyle-CssClass="EP-tableCellGrid">
					<ItemTemplate>
						<asp:CheckBox Runat="server" Enabled="False" Checked='<%#CheckActive(Container)%>'></asp:CheckBox>
					</ItemTemplate>					
				</asp:TemplateColumn>
				<asp:TemplateColumn HeaderStyle-CssClass="EP-tableHeadingGrid" ItemStyle-CssClass="EP-tableCellGrid">
					<ItemTemplate>
						<a href="EditUser.aspx?id=<%#DataBinder.Eval(Container.DataItem, "ID")%>&type=<%#(int)DataBinder.Eval(Container.DataItem, "Type")%>"><%#SafeEncode(DataBinder.Eval(Container.DataItem, "Name"))%></a>
					</ItemTemplate>
				</asp:TemplateColumn>
				<asp:BoundColumn DataField="Description" HeaderStyle-CssClass="EP-tableHeadingGrid" ItemStyle-CssClass="EP-tableCellGrid"></asp:BoundColumn>
				<asp:TemplateColumn HeaderStyle-CssClass="EP-tableHeadingGrid" ItemStyle-CssClass="EP-tableCellGrid">
					<ItemTemplate>
						<%#GetUserProperty(Container, "FirstName")%>
					</ItemTemplate>
				</asp:TemplateColumn>
				<asp:TemplateColumn HeaderStyle-CssClass="EP-tableHeadingGrid" ItemStyle-CssClass="EP-tableCellGrid">
					<ItemTemplate>
						<%#GetUserProperty(Container, "LastName")%>
					</ItemTemplate>
				</asp:TemplateColumn>
				<asp:TemplateColumn HeaderStyle-CssClass="EP-tableHeadingGrid" ItemStyle-CssClass="EP-tableCellGrid">
					<ItemTemplate>
						<%#GetUserProperty(Container, "Email")%>
					</ItemTemplate>
				</asp:TemplateColumn>
				<asp:TemplateColumn HeaderStyle-CssClass="EP-tableHeadingGrid" ItemStyle-CssClass="EP-tableCellGrid">
					<ItemTemplate>
						<%#GetUserProperty(Container, "Company")%>
					</ItemTemplate>
				</asp:TemplateColumn>
			</Columns>
		</asp:DataGrid>
     </form>
  </body>
</html>
