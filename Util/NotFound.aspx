<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Page language="c#" Codebehind="NotFound.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Util.NotFound" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" > 
<html>
  <head>
    <title>Not found</title>
    <meta name="robots" content="noindex">
  </head>
  <body>
    <form id="NotFound" method="post" runat="server">

		<h2>The requested resource was not found</h2>

		<p>The file or script you asked for cannot be found. Please check the URL to ensure that the path is correct.</p>
		<p>Please contact the server's administrator if this problem persists.</p>
		
		<a href='<%=EPiServer.Global.EPConfig.RootDir%>'>Click here for the start page</a>
	</form>
  </body>
</html>
