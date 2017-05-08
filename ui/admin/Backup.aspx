<%@ Page language="c#" Codebehind="Backup.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Admin.Backup" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" > 

<html>
  <head>
    <title>Backup database</title>
    <script type='text/javascript' src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/system.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css">
  </head>
  <body>
    <form id="Backup" method="post" runat="server">
		<episerversys:systemprefix id="PagePrefix" runat="server" />
		<p></p>
		<asp:Button Translate="/admin/backup/heading" ID="saveChanges" Runat="server" OnClick="DoBackup" />
     </form>
	
  </body>
</html>
