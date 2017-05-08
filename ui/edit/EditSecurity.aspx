<%@ Import Namespace="EPiServer.Security" %>
<%@ Import Namespace="System.Web.UI.HtmlControls" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<%@ Page language="c#" Codebehind="EditSecurity.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Edit.EditSecurity" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>EditSecurity</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<link rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css">
		<script type='text/javascript' src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/system.js"></script>
		<script type='text/javascript'>
		<!--
		
		//Variables to keep track of unsaved changes to the page
		var button;
		var saveButtonClicked;
		
		function onNavigate(newPageLink)
		{
			return -1;
		}
		function onCommand(newCommand)
		{
			return -1;
		}
		
		function leavePage()
		{
			//If the reload is caused by the save button, do not show the warning
			if (saveButtonClicked)
			{
				return;
			}
			event.returnValue = window.confirmNavigateMessage;
		}
		
		function onClick()
		{
			saveButtonClicked = true;
		}

		window.confirmNavigateMessage = 'You have made changes to the security settings of this page.';
		// -->
		</script>
	</HEAD>
	<body>
		<EPiServerSys:SystemPrefix runat="server" id="SystemPrefix" />
		<form id="EditSecurity" method="post" runat="server">
			<asp:Button id="SaveButton" runat="server" translate="/button/save" CssClass="EP-smallButton" />
			<EPiServerSys:SidAccessLevel CssClass="EPEdit-sidAccessLevel" id="sidList" runat="server" />
			<input type="button" id="AddGroupButton" runat="server" translate="/button/addgroupsid" class="EP-largeButton" onclick="OpenSidBrowser(-1);"/>
			<input type="button" id="AddUserButton" runat="server" translate="/button/addusersid" class="EP-largeButton" onclick="OpenSidBrowser(-2);"/>
			<input type="text" id="SearchText"> <input type="button" id="SearchButton" runat="server" translate="/button/search" class="EP-smallButton" onclick="OpenSidBrowser(0, SearchText.value);"/>
			<hr>
			<episerver:Translate text="#user" id="RoleInfo" runat="server" />
			<ul>
				<asp:repeater id="ListRoles" runat="server">
					<ItemTemplate>
						<li>
							<%# Container.DataItem %>
						</li>
					</ItemTemplate>
				</asp:repeater>
			</ul>
		</form>
	</body>
</HTML>
