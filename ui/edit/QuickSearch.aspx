<%@ Page language="c#" Codebehind="QuickSearch.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Edit.QuickSearch" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>QuickSearch</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<link rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css">
	</HEAD>
	<body class="EPEdit-searchBody">
		<form id="QuickSearch" method="post" runat="server">
			<table width="100%" cellpadding="2" cellspacing="0">
				<tr>
					<td align="center" valign="middle"><asp:TextBox ID="searchKey" Runat="server" />&nbsp;<asp:Button Translate="/button/search" Text="Search" Runat="server" ID="searchButton" /></td>
				</tr>
				<tr>
					<td align="center" valign="middle"><asp:Image ImageUrl="~/Util/Images/EPiServer4Small.gif" Runat="server" id="Image1" /></td>
				</tr>
			</table>
		</form>
	</body>
</HTML>
