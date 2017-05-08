<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<%@ Import namespace="EPiServer" %>
<%@ Page language="c#" Codebehind="siteinfo.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Admin.Siteinfo" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>Siteinfo</title>
		<meta name="vs_showGrid" content="False">
		<meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<script type='text/javascript' src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/admin.js"></script>
		<link rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css">
	</HEAD>
	<body onload="validateFrameset()">
		<form id="Siteinfo" method="post" runat="server">
			<table cellpadding="0" cellspacing="0">
				<tr>
					<td>
						<img src="~/util/images/welcome.gif" runat="server" ID="Img1"/>
						<br />
						<br />
					</td>
				</tr>
				<tr>
					<td>
						<table id="DatabaseTable" Runat="server" class="EP-tableGrid" width="100%">
							<tr>
								<td colspan="2" class="EP-tableHeadingGrid">
									<episerver:Translate Text="#dbstatcaption" runat="server" />
								</td>
							</tr>
						</table>
						<br />
						<br />
					</td>
				</tr>
				<tr>
					<td>
						<table id="DataFactoryTable" Runat="server" class="EP-tableGrid" width="100%">
							<tr>
								<td class="EP-tableHeadingGrid" colspan="2">
									<episerver:Translate Text="#dbcachecaption" runat="server" />
								</td>
							</tr>
						</table>
						<br />
						<asp:Button translate="#buttonresetcounters" id="ResetButton" runat="server" />
						<br />
						<br />
						<br />
					</td>
				</tr>
				<tr>
					<td>
						<table width="100%" id="ProcessInfoTable" Runat="server" class="EP-tableGrid">
							<tr>
								<td colspan="2" class="EP-tableHeadingGrid">
									<episerver:Translate Text="#dbsystemprocessinfocaption" runat="server" />
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
	</body>
</HTML>
