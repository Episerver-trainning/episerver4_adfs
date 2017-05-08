<%@ Page language="c#" Codebehind="FileManagement.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Edit.FileManagement" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" > 

<html>
  <head>
    <title>File Management</title>
    <meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
    <meta name="CODE_LANGUAGE" Content="C#">
    <meta name=vs_defaultClientScript content="JavaScript">
    <meta name=vs_targetSchema content="http://schemas.microsoft.com/intellisense/ie5">
    <script type='text/javascript' src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/system.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css">
  </head>
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
	// -->
  </script>
  <body MS_POSITIONING="GridLayout">
    <form id="FileArchive" encType="multipart/form-data" method="post" runat="server">

		<EPiServer:ControlLoader runat="Server" Src="~/edit/FileManagementControl.ascx" />

    </form>
  </body>
</html>
