<%@ Page language="c#" Codebehind="DeletePage.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Edit.DeletePage" %>
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
		
		function PageDeleted(id, navId)
		{
			if(window.parent)
			{
				var cmd = new commandNavigateDescriptorEx('pagedeleted','',id,navId);
				window.parent.commandEvent( window, cmd );
			}
		}
		// -->
		</script>
	</head>
	<body>
		<form id="DeletePage" method="post" runat="server">
			<episerversys:systemprefix runat="server" id="pagePrefix" />
			<p></p>
			<asp:Button Translate="/button/delete" id="deleteButton" Runat="server"></asp:Button>
			<asp:Button Translate="/button/cancel" id="cancelButton" Runat="server"></asp:Button>
		</form>
	</body>
</html>
