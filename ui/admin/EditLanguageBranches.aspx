<%@ Page language="c#" Codebehind="EditLanguageBranches.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Admin.EditLanguageBranches" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
	<head>
		<title>EditPageType</title>
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<link rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css">
		<script type='text/javascript' src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/system.js"></script>
	</head>
	<body>
		<form id="EditLanguageBranches" method="post" runat="server">
		
		<EPiServerSys:systemprefix id="PagePrefix" runat="server"/>
		<br /><br />
		<EPiServer:translate Text="#defaultlanguagebranch" runat="server" ID="Translate1" NAME="Translate1"/>:&nbsp;<b><asp:Label ID="defaultBranchLabel" Text="N/A" Runat=server/><asp:DropDownList ID="defaultBranchInput" Visible="False" Runat=server/>&nbsp;<asp:Button OnClick="Change" Translate="/button/edit" ID="ChangeButton" Runat="server"/></b>
		<br /><br />
		<asp:Repeater ID="LanguageList" Runat="server">
			<HeaderTemplate>
				<table class="EP-tableGrid">
					<tr>
						<td class="EP-tableHeadingGrid"><episerver:translate runat="server" text="/admin/categories/moveup" /></td>
						<td class="EP-tableHeadingGrid"><episerver:translate runat="server" text="/admin/categories/movedown" /></td>
						<td class="EP-tableHeadingGrid"><episerver:translate runat="server" text="/admin/editlanguagebranches/namecaption" /></td>
						<td class="EP-tableHeadingGrid"><episerver:translate runat="server" text="/admin/editlanguagebranches/idcaption" /></td>
						<td class="EP-tableHeadingGrid"><episerver:translate runat="server" text="/admin/editlanguagebranches/enabledcaption"/></td>
						<td class="EP-tableHeadingGrid"><episerver:translate runat="server" text="/admin/editlanguagebranches/iconcaption" /></td>
					</tr>	
			</HeaderTemplate>
			<ItemTemplate>
					<tr>
						<td class="EP-tableCellGrid" align="center"><asp:ImageButton OnCommand="MoveUp_Click" CommandName=<%#DataBinder.Eval(Container.DataItem, "languageID") %> ImageUrl="~/Util/Images/UpToolSmall.gif" Runat="server" ID="Imagebutton1" NAME="Imagebutton1"/></td>
						<td class="EP-tableCellGrid" align="center"><asp:ImageButton OnCommand="MoveDown_Click" CommandName=<%#DataBinder.Eval(Container.DataItem, "languageID") %> ImageUrl="~/Util/Images/DownToolSmall.gif" Runat="server"/></td>
						<td class="EP-tableCellGrid">
							<a href="EditLanguageBranch.aspx?languageID=<%# DataBinder.Eval(Container.DataItem, "languageID") %>"><%# DataBinder.Eval(Container.DataItem, "Name") %></a>
						</td>
						<td class="EP-tableCellGrid">
							<%# DataBinder.Eval(Container.DataItem, "LanguageID") %>
						</td>
						<td class="EP-tableCellGrid" align="center">
							<asp:Image ImageUrl="~/util/images/clienttools/check.gif" Runat="server" AlternateText='<%# GetEnabledText() %>' Visible='<%# DataBinder.Eval(Container.DataItem, "Enabled") %>' />
						</td>
						<td class="EP-tableCellGrid">
							<img src="<%# GetIconPath((string)DataBinder.Eval(Container.DataItem, "IconPath")) %>" alt="<%# DataBinder.Eval(Container.DataItem, "Name") %>" />
						</td>
					</tr>
			</ItemTemplate>
			<FooterTemplate>
				</table>
			</FooterTemplate>
		</asp:Repeater>
		<p>
			<asp:Button Runat="Server" ID="NewLanguageBranchButton" Translate="#addlanguage"></asp:Button>
		</p>
		</form>
	</body>
</html>
