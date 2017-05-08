<%@ Import Namespace="EPiServer.Security" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<%@ Page language="c#" Codebehind="Security.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Admin.Security" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>Security</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<link rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css">
		<script type='text/javascript' src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/system.js"></script>
		<script type='text/javascript'>
			function handleKeyPressed()
			{
				if(event.keyCode == 13 && event.srcElement.type != 'submit')
				{
					document.getElementById('SearchButton').click();
					return false;
				}
				return true;
			}
		</script>
	</HEAD>
	<body onkeydown="return handleKeyPressed()">
		<EPiServerSys:SystemPrefix runat="server" id="SystemPrefix" />
		<form id="Security" method="post" runat="server">
			<asp:Button id="SaveButton" runat="server" translate="/button/save" CssClass="EP-largeButton"></asp:Button>
			<asp:Button id="RecursiveButton" runat="server" translate="#buttonrecursive" CssClass="EP-largeButton"></asp:Button>
			<asp:Button id="RecursiveAddButton" runat="server" translate="#buttonrecursiveadd" CssClass="EP-largeButton"></asp:Button>
			<asp:Button id="RecursiveRemoveButton" runat="server" translate="#buttonrecursiveremove" CssClass="EP-largeButton"></asp:Button>
			<EPiServerSys:SidAccessLevel CssClass="EPEdit-sidAccessLevel" id="sidList" runat="server" />
			<input type="button" id="AddGroupButton" runat="server" translate="/button/addgroupsid" class="EP-largeButton" onclick="OpenSidBrowser(-1)" NAME="AddGroupButton">
			<input type="button" id="AddUserButton" runat="server" translate="/button/addusersid" class="EP-largeButton" onclick="OpenSidBrowser(-2)" NAME="AddUserButton">
			<input type="text" id="SearchText"> <input type="button" id="SearchButton" runat="server" translate="/button/search" class="EP-smallButton" onclick="OpenSidBrowser(0, SearchText.value)" NAME="SearchButton">
			<br>
			<hr>
			<episerver:ExplorerTree EnableVisibleInMenu="False" PublishedStatus="Ignore" ShowRootPage="True" ClickScript="window.location.href='security.aspx?id={PageLink}'" id="explorerTree" runat="server" />
		</form>
	</body>
</HTML>
