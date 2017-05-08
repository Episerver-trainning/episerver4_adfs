<%@ Page language="c#" Codebehind="CopyPageType.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Admin.CopyPageType" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" > 

<html>
  <head>
    <title>CopyPageType</title>
    <meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
    <meta name="CODE_LANGUAGE" Content="C#">
    <meta name=vs_defaultClientScript content="JavaScript">
    <meta name=vs_targetSchema content="http://schemas.microsoft.com/intellisense/ie5">
	<link rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css">
	<script type='text/javascript' src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/system.js"></script>
  </head>
  <body MS_POSITIONING="GridLayout">
	
    <form id="CopyPageType" method="post" runat="server">    
		<EPiServerSys:systemprefix id="PagePrefix" runat="server"/>
	    <br><br>
		<episerver:translate text="#caption" runat="server"/>&nbsp;<asp:DropDownList ID="pageTypeList" Runat="server"/>
		<br><br>
		<asp:Button Translate="/button/copy" Runat="server" OnClick="Copy"/>
    </form>
	
  </body>
</html>
