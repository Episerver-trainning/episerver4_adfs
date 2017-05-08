<%@ Page language="c#" Codebehind="EmptyWastebasket.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Edit.EmptyWastebasket" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" > 

<html>
  <head>
    <title>EmptyWastebasket</title>
    <meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
    <meta name="CODE_LANGUAGE" Content="C#">
    <meta name=vs_defaultClientScript content="JavaScript">
    <meta name=vs_targetSchema content="http://schemas.microsoft.com/intellisense/ie5">
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
		
		function WastebasketEmptied(id)
		{
			if(window.parent)
			{
				var cmd = new commandDescriptor('pagechildrendeleted','',id);
				window.parent.commandEvent( window, cmd );
			}
		}
		// -->
	</script>
  </head>
  <body>
	
    <form id="EmptyWastebasket" method="post" runat="server">
    <episerversys:systemprefix runat="server" id="pagePrefix" />
		<p></p><asp:Button Translate="/button/ok" id="deleteButton" Runat="server" /></p>
     </form>
	
  </body>
</html>
