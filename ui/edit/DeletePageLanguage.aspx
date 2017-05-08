<%@ Page language="c#" Codebehind="DeletePageLanguage.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Edit.DeletePageLanguage" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
	<head>
		<title>DeletePage</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<link rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css">
		<script type='text/javascript' src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/edit.js"></script>
		<script type='text/javascript'>
		<!--
		function onNavigate(newPageLink)
		{
			return -1;
		}
		function onCommand(newCommand)
		{
			return -1;
		}
		function confirmDelete() {
			var select = document.getElementById('<%= languageList.ClientID %>');
			if (select && select.selectedIndex == 0) {
				alert('<%= EPiServer.Global.EPLang.TranslateForScript("/edit/deletepagelanguage/alertlangnotselected") %>');
				return false;
			}
			else if (select) {
				return confirm('<%= EPiServer.Global.EPLang.TranslateForScript("/edit/deletepagelanguage/confirmdeletemessage") %>\n\n<%= EPiServer.Global.EPLang.TranslateForScript("/edit/deletepagelanguage/confirmdeletequestion") %>');
			}
			return false;
		}
		// -->
		</script>
	</head>
	<body>
		<form id="DeletePage" method="post" runat="server">
			<episerversys:systemprefix runat="server" id="pagePrefix" />
			<p>
				<asp:Label Runat="server" ID="languageListLabel" ></asp:Label> <asp:DropDownList Runat="server" ID="languageList"></asp:DropDownList>
			</p>
			<EPiServerSys:ConfirmButton Function="confirmDelete()" Runat="server" id="deleteButton"  Translate="/button/delete" />
			<asp:Button Translate="/button/cancel" id="cancelButton" Runat="server"></asp:Button>
		</form>
	</body>
</html>
