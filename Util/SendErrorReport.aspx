<%@ Page language="c#" Codebehind="SendErrorReport.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Util.SendErrorReport" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" > 

<html>
  <head>
    <title>Error report</title>
    <meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
    <meta name="CODE_LANGUAGE" Content="C#">
    <meta name=vs_defaultClientScript content="JavaScript">
    <meta name="robots" content="noindex,nofollow">
    <meta name=vs_targetSchema content="http://schemas.microsoft.com/intellisense/ie5">
    <style>
		.Title{color: gray;font-size: 1.5em;font-family: Verdana;}
		body{font-family:Verdana;font-weight:normal;font-size: .7em;color:black;}
	</style>
  </head>
  <body MS_POSITIONING="GridLayout">
    <form id="SendErrorReport" method="post" runat="server">
		<asp:Label CssClass="Title" Runat="server" ID="MessageTitle" Text="Thank you!"/>
		<p>
			<asp:Label Runat="server" ID="MessageDescription" Text=""/>
		</p>
     </form>
	
  </body>
</html>
