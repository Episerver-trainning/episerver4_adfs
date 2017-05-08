<%@ Page language="c#" Codebehind="WastebasketPage.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Edit.WastebasketPage" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>EmptyWastebasket</title>
		<meta content="Microsoft Visual Studio 7.0" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css" type="text/css" rel="stylesheet">
		<script src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/edit.js" type="text/javascript"></script>
		<script type="text/javascript">
		<!--
		function onNavigate(newPageLink)
		{
			return -1;
		}
		function onCommand(newCommand)
		{
			return -1;
		}
		
		function WastebasketEmptied(id)
		{
			if(window.parent)
			{
				var cmd = new commandDescriptor('pagechildrendeleted','',id);
				window.parent.commandEvent( window, cmd );
			}
		}
		
		function ConfirmWastebasketClearing()
		{
			if (window.confirm('<%=TranslateForScript("#askemptywastebasket")%>'))
			{
				var button = document.all['<%=emptyWastebasketButton.UniqueID %>'];
				PleaseWaitMessage.innerText = '<%=TranslateForScript("/pleasewait")%>...';
				return true;
			}
			else
				return false;
		}
		
		function Init()
		{
			var button = document.all['<%=emptyWastebasketButton.UniqueID %>'];
			button.attachEvent("onclick", ConfirmWastebasketClearing);
		}

		// -->
		</script>
	</HEAD>
	<body onload="Init()">
		<form id="EmptyWastebasket" method="post" runat="server">
			<episerversys:systemprefix id="pagePrefix"
					runat="server"></episerversys:systemprefix>
			<br>
			&nbsp; <%=EPiServer.Global.EPLang.Translate("#numdeletedpages")%>: &nbsp;&nbsp;&nbsp;    <%# PagesInWastebasketCount %>
			<br>
			<br>
			&nbsp; <span id="PleaseWaitMessage">&nbsp;</span>
			<br>
			<br>
			<asp:Button Translate="#emptywastebasket" id="emptyWastebasketButton" Runat="server" /></form>
	</body>
</HTML>
