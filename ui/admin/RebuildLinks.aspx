<%@ Page language="c#" Codebehind="RebuildLinks.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Admin.RebuildLinks" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
	<head>
		<title>RebuildLinks</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<link rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css">
		<script type='text/javascript' src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/system.js"></script>
	</head>
	<body>
		<form id="RebuildLinks" method="post" runat="server">
		<EPiServerSys:SystemPrefix ID="pagePrefix" runat="server"></EPiServerSys:SystemPrefix>
			<table>
				<tr>
					<td>
						<asp:Label Translate="#normalrebuild" runat="server" ID="NormalRebuildCaption"/>
					</td>
					<td>
						<input value="1" type="radio" OnClick="OldDirectory.disabled=true" name="RebuildType" runat="server" id="NormalOption" />
					</td>
				</tr>
				<tr>
					<td>
						<asp:Label Translate="#newdirectoryrebuild" runat="server" ID="NewDirCaption"/>
					</td>
					<td>
						<input value="2" type="radio" OnClick="OldDirectory.disabled=false" name="RebuildType" runat="server" id="NewDirectoryOption" /><asp:TextBox runat="server" id="OldDirectory" />
					</td>
				</tr>
			</table>
			<asp:Button translate="/button/ok" id="RebuildButton" Text="Rebuild" Runat="server"></asp:Button>
		</form>
	</body>
</html>
