<%@ Page language="c#" Codebehind="LinkGeneric.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Edit.LinkGeneric" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
	<head>
		<title>LinkGeneric</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<link rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/linkeditor.css">
		<script type='text/javascript' src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/system.js"></script>
	</head>
	<body MS_POSITIONING="GridLayout">
		<form id="LinkGeneric" encType="multipart/form-data" method="post" runat="server">
			<div id="titleBar">
				<episerver:translate text="#heading" runat="Server"/>
			</div>
			<table cellpadding=0 cellspacing=0 border=0 width=550 style="margin-top:1px;">
				<tr>
					<td class="linkToolbar">&nbsp;</td>
					<td class="linkToolbar" align=right><asp:DropDownList AutoPostback="False" onchange="location.href=this.value;" runat="server" ID="selectView" /></td>
				</tr>
				<tr>
					<td align=left valign="top">
						<asp:DataGrid Width="100" height=300 borderwidth=0 id="menuList" ShowHeader="false" AutoGenerateColumns="false" runat="server">
							<Columns>
								<asp:HyperLinkColumn DataTextField="Text" DataNavigateUrlFormatString="LinkGeneric.aspx?{0}" DataNavigateUrlField="QueryString" />
							</Columns>
						</asp:DataGrid>
					</td>
					<td align=left valign="top" id="linkSpace" runat="server">
					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td align="right">
						<asp:button ID="insertButton" Text="Infoga" Translate="/button/insert" Runat="server" />
						<input type=button ID="nullButton" Text="Rensa" Translate="/button/clear" Runat="server" onClick='returnValue="|";window.close()'/>
						<asp:button ID="cancelButton" Text="Avbryt" Translate="/button/cancel" Runat="server" />
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>
