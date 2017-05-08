<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<%@ Page language="c#" Codebehind="GlobalizationMatrix.aspx.cs" AutoEventWireup="false" Inherits="EPiServerGUI.edit.GlobalizationMatrix" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>LanguageBranchMatrix</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<script type='text/javascript' src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/system.js"></script>
		<link rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css">
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
	</HEAD>
	<body MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<EPiServerSys:SystemPrefix runat="server" ID="prefix" NAME="Systemprefix1" />
			<div>
				<asp:Table CssClass="EP-tableGrid" CellSpacing="0" BorderStyle="Solid" Runat="server" ID="matrix"></asp:Table>
			</div>
		</form>
	</body>
</HTML>
