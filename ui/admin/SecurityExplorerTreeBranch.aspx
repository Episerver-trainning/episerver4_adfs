<%@ Page language="c#" Codebehind="SecurityExplorerTreeBranch.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Admin.SecurityExplorerTreeBranch" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
	<head>
		<title>ExplorerTreeBranch</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
	</head>
	<body MS_POSITIONING="GridLayout">
		<form id="ExplorerTreeBranch" method="post" runat="server">
		<div runat="server" id="TreeContainer">
			<episerver:ExplorerTree id="explorerTree" runat="server"></episerver:ExplorerTree>
		</div>
		</form>
	</body>
</html>
