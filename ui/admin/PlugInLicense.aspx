<%@ Page language="c#" Codebehind="PlugInLicense.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Admin.PlugInLicense" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
	<head>
		<title>EditPageType</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<link rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css">
		<script type='text/javascript' src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/system.js"></script>
	</head>
	<body>
		<form id="EditPageType" encType="multipart/form-data" method="post" runat="server">
		
		<EPiServerSys:refreshframe id="frameUpdater" FrameName="AdminMenu" SelectedTabName="ConfigTab" runat="server"/>
		
		<EPiServerSys:systemprefix id="pagePrefix" runat="server"/>
		
		<episerversys:tabstrip runat="server" id="actionTab" AutoPostBack="False" TargetID="TabView">
			<episerversys:tab Text="#tabinfo" runat="server" ID="Tab1" sticky="True" />
			<episerversys:tab Text="#tabinstallnew" runat="server" ID="Tab2" sticky="True" />
		</episerversys:tabstrip>
		
		<asp:Panel ID="TabView" Runat="server">
			<asp:Panel ID="Info" Runat="server">
			<table cellspacing=5 cellpadding=0>
			<tr>
				<td>&nbsp;</td>
				<td></td>
			</tr>
			<tr>
				<td style="font-weight:bold" valign="top">Restrictions</td>
				<td>
					<asp:Repeater DataSource=<%#CurrentLicense.Restrictions%> Runat="server">
						<ItemTemplate>
							<asp:Repeater DataSource=<%#((ElektroPost.Licensing.Restriction)Container.DataItem).Entries%> Runat="server" ID="Repeater1">
								<ItemTemplate>
									<asp:Label Text=<%#DataBinder.Eval(Container.DataItem,"Description")%> Runat="server" ID="Label1" NAME="Label1"/><br>
								</ItemTemplate>
							</asp:Repeater>
						</ItemTemplate>
					</asp:Repeater>
				</td>
			</tr>
			</table>
			</asp:Panel>
			<asp:Panel ID="New" Runat="server">
			<table cellspacing=5 cellpadding=5>
			<tr>
				<td>&nbsp;</td>
				<td></td>
			</tr>
			<tr>
				<td style="font-weight:bold" valign="top"><episerver:translate Text="#selectfile" runat="server" ID="Translate5" NAME="Translate1"/></td>
				<td>
				<input type="file" runat="server"/>
				</td>
			</tr>
			</table><br>
			<asp:Button OnClick="UploadLicense" Text="Upload license" Runat="server"/>
			</asp:Panel>
		</asp:Panel>
		</form>
	</body>
</html>
