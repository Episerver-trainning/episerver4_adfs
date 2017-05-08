<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<%@ Page language="c#" Codebehind="Permission.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Admin.Permission_Page" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
	<head>
		<title>Permission</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<script type='text/javascript' src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/system.js"></script>
		<link rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css">
		
		<script type='text/javascript'>
		<!--
		function addSids( oSelect )
		{
			SecHandleSids( oSelect, addSidTableRow );
		}
		function addSidTableRow( nSID, nType, sName )
		{
			var oRow,oCell,oOption;
			if ( ! document.all['row_' + nSID]) {
				oRow = SidTable.insertRow();
				oRow.id = 'row_' + nSID;
				oCell = oRow.insertCell();
				oCell.innerHTML = '<img align=\"absmiddle\" src=' + sidTypeUrls[nType] + '>&nbsp;' + sName;

				oCell = oRow.insertCell();
				//oCell.setAttribute('className', 'EPEdit-sidAccessLevel', 0);
				//oCell.setAttribute('align','center',0);
				oCell.innerHTML = '<input type="checkbox" name="SID" value="' + nSID + '" checked>';
			}
		}
		// -->
		</script>		
	</head>
	<body>
		<form id="Permission" method="post" runat="server">
			<EPiServerSys:SystemPrefix id="SystemPrefix" runat="server" />
			<p />
			<asp:Table Runat="server" ID="PermissionTable" />
			<asp:Panel Runat="server" ID="CommandGroup" Visible="False">
				<h2 id="PermissionName" runat="server" />
				<br>
				<asp:Table id="SidTable" Runat="server"></asp:Table>
				<br>
				<input class="EP-largeButton" id="AddGroupButton" onclick="OpenSidBrowser(-1)" type="button" name="AddGroupButton" runat="server" translate="/button/addgroupsid">
				<input class="EP-largeButton" id="AddUserButton" onclick="OpenSidBrowser(-2)" type="button" name="AddUserButton" runat="server" translate="/button/addusersid">
				<input id="SearchText" type="text"> <input class="EP-smallButton" id="SearchButton" onclick="OpenSidBrowser(0, SearchText.value)" type="button" name="SearchButton" runat="server" translate="/button/search">
				<br>
				<asp:Button id="Save" Runat="server" Translate="/button/save" CssClass="largeButton"></asp:Button>
				<asp:Button id="Cancel" Runat="server" Translate="/button/cancel" CssClass="largeButton"></asp:Button>
			</asp:Panel>
		</form>
	</body>
</html>
