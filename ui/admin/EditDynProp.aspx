<%@ Page language="c#" Codebehind="EditDynProp.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Admin.EditDynProp" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
	<head>
		<title>EditPageType</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<link rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css">
		<script type='text/javascript' src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/system.js"></script>
	</head>
	<body>
		<form id="EditDynProp" method="post" runat="server">
		
		<EPiServerSys:systemprefix id="PagePrefix" runat="server"/>
		<br><br>
		<asp:Repeater ID="PropertyList" Runat="server">
			<HeaderTemplate>
			<table class="EP-tableGrid">
				<tr>
					<td class="EP-tableHeadingGrid"><episerver:translate runat="server" text="/admin/categories/moveup" /></td>
					<td class="EP-tableHeadingGrid"><episerver:translate runat="server" text="/admin/categories/movedown" /></td>
					<td class="EP-tableHeadingGrid"><episerver:translate runat="server" text="/admin/editpagetypefield/namecaption" /></td>
					<td class="EP-tableHeadingGrid"><episerver:translate runat="server" text="/admin/editpagetypefield/editcaption" /></td>
					<td class="EP-tableHeadingGrid"><episerver:translate runat="server" text="/admin/editpagetypefield/helpcaption" /></td>
					<td class="EP-tableHeadingGrid"><episerver:translate runat="server" text="/admin/editpagetypefield/typecaption" /></td>
				</tr>	
			</HeaderTemplate>
			<ItemTemplate>
				<tr>
					<td class="EP-tableCellGrid" align="center"><asp:ImageButton OnCommand="MoveUp_Click" CommandName=<%#DataBinder.Eval(Container.DataItem, "ID") %> ImageUrl="~/Util/Images/UpToolSmall.gif" Runat="server" ID="Imagebutton2" NAME="Imagebutton1"/></td>
					<td class="EP-tableCellGrid" align="center"><asp:ImageButton OnCommand="MoveDown_Click" CommandName=<%#DataBinder.Eval(Container.DataItem, "ID") %> ImageUrl="~/Util/Images/DownToolSmall.gif" Runat="server" ID="Imagebutton1"/></td>
					<td class="EP-tableCellGrid">
						<a href="EditPageTypeField.aspx?id=<%# DataBinder.Eval(Container.DataItem, "ID") %>"><%# DataBinder.Eval(Container.DataItem, "Name") %></a>
					</td>
					<td class="EP-tableCellGrid">
						<%# DataBinder.Eval(Container.DataItem, "EditCaption") %>
					</td>
					<td class="EP-tableCellGrid">
						<%# DataBinder.Eval(Container.DataItem, "HelpText") %>
					</td>					
					<td class="EP-tableCellGrid">
						<%# GetPropertyType(Container.DataItem) %>
					</td>					
				</tr>
			</ItemTemplate>
			<FooterTemplate></table></FooterTemplate>
		</asp:Repeater>

		<p>
			<asp:Button Runat="Server" ID="NewDefinitionButton" Translate="/admin/editpagetype/addproperty"></asp:Button>
		</p>
		</form>
	</body>
</html>
