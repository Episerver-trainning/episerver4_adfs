<%@ Page language="c#" Codebehind="CleanupUpload.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Admin.CleanupUpload" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" > 

<html>
  <head>
    <title>Clear upload</title>
    <script type='text/javascript' src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/system.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css">
  </head>
  <body>
    <form id="Backup" method="post" runat="server">
		<episerversys:systemprefix id="PagePrefix" runat="server" />
		<p></p>
		<asp:Button Translate="/button/ok" ID="saveChanges" Runat="server" OnClick="EmptyUpload" />
     </form>
  </body>
</html>
