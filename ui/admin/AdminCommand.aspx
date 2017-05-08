<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Page language="c#" Codebehind="AdminCommand.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Admin.AdminCommand" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
  <HEAD>
		<title>AdminCommand</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<link rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css">
		<script type='text/javascript' src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/system.js"></script>
</HEAD>
	<body MS_POSITIONING="FlowLayout" class="EPEdit-commandBody">
		<form id="EditCommand" method="post" runat="server">
			<table cellpadding=0 cellspacing=0 border=0>
				<tr>
					<td><EPiServerSys:CommandTool ImageUrl="~/util/images/tools/EditTool.gif" ToolTip="/dope/editmode" NavigateUrl="~/Edit"	Target="_top" runat="server"/></td>
					<td><EPiServerSys:CommandTool ImageUrl="~/util/images/tools/ViewTool.GIF" ToolTip="/dope/viewmode" NavigateUrl=<%#Configuration.RootDir%> Target="_top" runat="server"/></td>
					<td><EPiServerSys:HelpButton ToolTip="/button/help" runat="server" id="CommandTool7" /></td>
					<asp:PlaceHolder Runat="server" ID="ExtendedDisplayLogoutCommandTool">	
						<td><EPiServerSys:CommandTool runat="server" id="LogoutCommandTool"	CommandName="logout" ImageUrl="~/util/images/tools/LogoutTool.gif"	ToolTip="/edit/editcommand/logouthelp" /></td>
					</asp:PlaceHolder>
				</tr>
			</table>
		</form>
	</body>
</HTML>
