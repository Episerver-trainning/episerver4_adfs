<%@ Page language="c#" Codebehind="ModeSelector.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Edit.ModeSelector" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" > 

<html>
  <head>
    <title>ModeSelector</title>
    <meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
    <meta name="CODE_LANGUAGE" Content="C#">
    <meta name=vs_defaultClientScript content="JavaScript">
    <meta name=vs_targetSchema content="http://schemas.microsoft.com/intellisense/ie5">
    <link rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css">
  </head>
  <body class="EPEdit-searchBody">
	
    <form id="ModeSelector" method="post" runat="server">
		<table width="100%" height="30" cellpadding="0" cellspacing="0">
			<tr>
				<td align="center">
					<a href="Default.aspx?mode=defaultmode" target="_parent">Default mode</a>
				</td>
				<td align="center">
					<a href="Default.aspx?mode=simpleeditmode" target="_parent">Simple mode</a>
				</td>
				<td align="center">
					<a href="Default.aspx?mode=advancededitmode" target="_parent">Advanced mode</a>
				</td>
			</tr>
		</table>					
     </form>
  </body>
</html>
