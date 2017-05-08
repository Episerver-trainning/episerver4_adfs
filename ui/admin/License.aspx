<%@ Page language="c#" Codebehind="License.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Admin.License" %>
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
				<td style="font-weight:bold"><episerver:translate Text="#licenseid" runat="server" ID="Translate4" NAME="Translate4"/></td>
				<td><%#CurrentLicense.MetaData["LicenseNumber"]%>-<%#CurrentLicense.MetaData["LicenseRevision"]%></td>
			</tr>
			<tr>
				<td style="font-weight:bold"><episerver:translate Text="#licensedto" runat="server"/></td>
				<td><%#CurrentLicense.MetaData["LicensedTo"]%></td>
			</tr>
			<tr>
				<td style="font-weight:bold"><episerver:translate Text="#licensedcompany" runat="server" ID="Translate1" NAME="Translate1"/></td>
				<td><%#CurrentLicense.MetaData["LicensedCompany"]%></td>
			</tr>		
			<tr style="display: none;">
				<td style="font-weight:bold"><episerver:translate Text="#licensedescription" runat="server" ID="Translate2" NAME="Translate1"/></td>
				<td><%#CurrentLicense.MetaData["LicenseDescription"]%></td>
			</tr>		
			<tr>
				<td style="font-weight:bold" valign="top"><episerver:translate Text="#licenserestrictions" runat="server" ID="Translate3" NAME="Translate1"/></td>
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
			<asp:Button OnClick="UploadLicense" Translate="#uploadlicense" Runat="server"/>
			</asp:Panel>
		</asp:Panel>
		</form>
	</body>
</html>
