<%@ Page language="c#" Codebehind="FileBrowser.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Admin.FileBrowser" %>
<%@ Register TagPrefix="UC" TagName="FileSelector"	Src="FileSelector.ascx"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" > 

<html>
  <head>
    <title><%=EPiServer.Global.EPLang.Translate("/admin/filebrowser/heading")%></title>
    <script type='text/javascript' src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/system.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css">
  </head>
  <body MS_POSITIONING="GridLayout">
	
    <form id="FileBrowser" method="post" runat="server">
		<UC:FileSelector runat="Server" ID="Fileselector1" NAME="Fileselector1"/>
     </form>
	
  </body>
</html>
