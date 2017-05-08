<%@ Page language="c#" Codebehind="EditUser.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Admin.EditUser" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" > 
<html>
  <head>
    <title>CreateUser</title>
    <script type='text/javascript' src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/system.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css">
  </head>
  <body MS_POSITIONING="GridLayout">
    <form id="CreateUser" method="post" runat="server" onsubmit="SelAllMember()">
		<EPiServer:ControlLoader Runat="Server" Src="~/edit/UserSettings.ascx" />				
	</form>
  </body>
</html>
