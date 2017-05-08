<%@ Page language="c#" Codebehind="PageDefinitionType.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Admin.PageDefinitionType" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
	<head>
		<title>PageDefinitionType</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<link rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css">
		<script type='text/javascript' src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/system.js"></script>
	</head>
	<body>
		<form id="PageDefinitionType" method="post" runat="server">
		<episerversys:systemprefix id="pagePrefix" runat="server" />
		<br />
		<br />
		<asp:Repeater ID="typeList" Runat="server">
			<HeaderTemplate>
				<table class="EP-tableGrid">
				<tr>
					<td class="EP-tableHeadingGrid">
						<episerver:translate text="/admin/pagedefinitiontypeedit/namecaption" runat="server" ID="Translate11" />
					</td>
					<td class="EP-tableHeadingGrid">
						<episerver:translate text="/admin/pagedefinitiontypeedit/property" runat="server" ID="Translate3" />
					</td>
					<td class="EP-tableHeadingGrid">
						<episerver:translate text="/admin/pagedefinitiontypeedit/typenamecaption" runat="server" ID="Translate1" />
					</td>
					<td class="EP-tableHeadingGrid">
						<episerver:translate text="/admin/pagedefinitiontypeedit/assemblynamecaption" runat="server" ID="Translate2" />
					</td>
				</tr>
			
			</HeaderTemplate>
			<ItemTemplate>
				<tr>
				<td class="EP-tableCellGrid">
					<a href="PageDefinitionTypeEdit.aspx?id=<%# DataBinder.Eval(Container.DataItem, "ID") %>"><%# DataBinder.Eval(Container.DataItem, "LocalizedName") %></a>
				</td>
				<td class="EP-tableCellGrid">
					<%# DataBinder.Eval(Container.DataItem, "DataType") %>
				</td>
				<td class="EP-tableCellGrid">
					<%# DataBinder.Eval(Container.DataItem, "AssemblyName") %>
				</td>
				<td class="EP-tableCellGrid">
					<%# DataBinder.Eval(Container.DataItem, "TypeName") %>
				</td>
				</tr>
			</ItemTemplate>
			<FooterTemplate></table></FooterTemplate>
		</asp:Repeater>
		<br />
		<asp:Button translate="/button/create" id="createNew" Runat="server" /><br/>
		</form>
	</body>
</html>
