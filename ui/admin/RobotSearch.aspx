<%@ Page language="c#" Codebehind="RobotSearch.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Admin.RobotSearch" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
  <HEAD>
    <title>RobotSearch</title>
    <meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
    <meta name="CODE_LANGUAGE" Content="C#">
    <meta name=vs_defaultClientScript content="JavaScript">
    <meta name=vs_targetSchema content="http://schemas.microsoft.com/intellisense/ie5">
	<link rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css">
  </HEAD>
  <body>
	
    <form id="RobotSearch" method="post" runat="server">
		<EPiServerSys:SystemPrefix ID="PagePrefix" runat="server" />
			<br /><br />
			<p>
			<asp:Label Font-Bold="True" Runat="server" Translate="#warning"/>
			</p>
			<table>
				<tr>
					<td>
						<input value="normal" type="radio" name="LinkType" runat="server" id="NormalOption" >
					</td>
					<td>
						<asp:Label Translate="#norobotlinkcaption" runat="server" ID="NoRobotLinkCaption"/>
						(/default.aspx?id=1)
					</td>
				</tr>
				<tr>
					<td>
						<input value="robot" type="radio" name="LinkType" runat="server" id="RobotOption" >
					</td>
					<td>
						<asp:Label Translate="#robotlinkcaption" runat="server" ID="RobotLinkCaption"/>
						(/default____1.aspx)
					</td>
				</tr>
				<tr>
					<td>
						<input value="friendly" type="radio" name="LinkType" runat="server" id="FriendlyOption" >
					</td>
					<td>
						<asp:Label Translate="#friendlylinkcaption" runat="server" ID="Label1"/> <asp:Label Runat="server" ID="friendlyUrlMessage" />
					</td>
				</tr>
			</table>
			<asp:Button translate="/button/save" id="SelectButton" Runat="server" />

     </form>
	
  </body>
</HTML>
