<%@ Page language="c#" Codebehind="EditPageTypeBase.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Admin.EditPageTypeBase" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>EditPageTypeBase</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<link rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css">
		<script type='text/javascript' src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/system.js"></script>
	</HEAD>
	<body>
		<EPiServerSys:refreshframe id="frameUpdater" FrameName="AdminMenu" SelectedTabName="PageTypeTab" runat="server" />
		<EPiServerSys:systemprefix id="SystemPrefix" runat="server" />
		<form id="EditPageTypeBase" method="post" runat="server">
			<p><asp:ValidationSummary ID="Summary" Runat="server" DisplayMode="BulletList" />
			</p>
			<episerversys:tabstrip runat="server" id="actionTab" AutoPostBack="False" TargetID="TabView">
				<episerversys:tab Text="#tabinfo" runat="server" ID="Tab1" sticky="True" />
				<episerversys:tab Text="#tabdefaultvalues" runat="server" ID="Tab2" sticky="True" />
				<episerversys:tab Text="#tabtypetotype" runat="server" ID="Tab3" sticky="True" />
			</episerversys:tabstrip>
			<asp:Panel ID="TabView" Runat="server">
				<asp:Panel id="GeneralSettings" Runat="server">
					<table>
						<tr>
							<td class="EP-tableCaptionCell">
								<EPiServer:Translate id="Translate1" runat="server" Text="#namecaption"></EPiServer:Translate></td>
							<td>
								<asp:TextBox id="PageTypeName" Runat="server" CssClass="EPEdit-inputString" MaxLength="255" Columns="50"></asp:TextBox></td>
						</tr>
						<tr>
							<td class="EP-tableCaptionCell">
								<EPiServer:Translate id="Translate2" runat="server" Text="#descriptioncaption"></EPiServer:Translate></td>
							<td>
								<asp:TextBox id="PageTypeDescription" Runat="server" CssClass="EPEdit-inputString" MaxLength="255"
									Columns="50"></asp:TextBox></td>
						</tr>
						<tr>
							<td class="EP-tableCaptionCell">
								<EPiServer:Translate id="Translate3" runat="server" Text="#filenamecaption"></EPiServer:Translate></td>
							<td>
								<asp:TextBox id="PageTypeFileName" Runat="server" CssClass="EPEdit-inputString" MaxLength="255"
									Columns="50"></asp:TextBox></td>
						</tr>
						<tr>
							<td class="EP-tableCaptionCell">
								<EPiServer:Translate id="Translate4" runat="server" Text="#availablecaption"></EPiServer:Translate></td>
							<td>
								<asp:CheckBox id="PageTypeAvailable" Runat="server" CssClass="EPEdit-inputBoolean"></asp:CheckBox></td>
						</tr>
						<tr>
							<td class="EP-tableCaptionCell">
								<EPiServer:Translate id="Translate5" runat="server" Text="#sortordercaption"></EPiServer:Translate></td>
							<td>
								<asp:TextBox id="PageTypeSortOrder" Runat="server" CssClass="EPEdit-inputNumber" MaxLength="10"
									Columns="5"></asp:TextBox></td>
						</tr>
					</table>
				</asp:Panel>
				<asp:Panel id="DefaultSettings" Runat="server">
					<table>
						<tr>
							<td class="EP-tableCaptionCell">
								<EPiServer:Translate id="Translate6" runat="server" Text="#usecustomdefaultcaption" NAME="Translate6"></EPiServer:Translate></td>
							<td>
								<asp:CheckBox id="PageTypeIsDefault" Runat="server" AutoPostBack="True" CssClass="EPEdit-inputBoolean"></asp:CheckBox></td>
						</tr>
					</table>
					<table id="DefaultValueTable" runat="server">
						<tr>
							<td class="EP-tableCaptionCell">
								<EPiServer:Translate id="Translate7" runat="server" Text="#defaultnamecaption"></EPiServer:Translate></td>
							<td>
								<asp:TextBox id="DefaultName" Runat="server" CssClass="EPEdit-inputString" MaxLength="255" Columns="50"></asp:TextBox></td>
						</tr>
						<tr>
							<td class="EP-tableCaptionCell">
								<EPiServer:Translate id="Translate8" runat="server" Text="#defaultstartpublishcaption"></EPiServer:Translate></td>
							<td>
								<EPiServer:InputTimeSpan id="StartPublishOffset" Runat="server" Displayname="#defaultstartpublishcaption"></EPiServer:InputTimeSpan></td>
						</tr>
						<tr>
							<td class="EP-tableCaptionCell">
								<EPiServer:Translate id="Translate9" runat="server" Text="#defaultstoppublishcaption" NAME="Translate9"></EPiServer:Translate></td>
							<td>
								<EPiServer:InputTimeSpan id="StopPublishOffset" Runat="server" Displayname="#defaultstoppublishcaption"></EPiServer:InputTimeSpan></td>
						</tr>
						<tr>
							<td class="EP-tableCaptionCell">
								<EPiServer:Translate id="Translate10" runat="server" Text="#visibleinmenucaption"></EPiServer:Translate></td>
							<td>
								<asp:CheckBox id="VisibleInMenu" Runat="server" CssClass="EPEdit-inputBoolean" Checked="True"></asp:CheckBox></td>
						</tr>
						<tr>
							<td class="EP-tableCaptionCell">
								<EPiServer:Translate id="Translate11" runat="server" Text="#peerordercaption"></EPiServer:Translate></td>
							<td>
								<asp:TextBox id="PeerOrder" Runat="server" CssClass="EPEdit-inputNumber" MaxLength="10" Columns="5"></asp:TextBox></td>
						</tr>
						<tr>
							<td class="EP-tableCaptionCell">
								<EPiServer:Translate id="Translate12" runat="server" Text="#childorderrulecaption"></EPiServer:Translate></td>
							<td>
								<EPiServer:InputSortOrder id="ChildOrderRule" Runat="server"></EPiServer:InputSortOrder></td>
						</tr>
						<tr>
							<td class="EP-tableCaptionCell">
								<EPiServer:Translate id="Translate13" runat="server" Text="#archivepagelinkcaption"></EPiServer:Translate></td>
							<td>
								<EPiServer:InputPageReference id="ArchivePageLink" Runat="server"></EPiServer:InputPageReference></td>
						</tr>
						<tr>
							<td class="EP-tableCaptionCell">
								<EPiServer:Translate id="Translate14" runat="server" Text="#frameidcaption"></EPiServer:Translate></td>
							<td>
								<EPiServer:InputFrame id="DefaultFrame" Runat="server"></EPiServer:InputFrame></td>
						</tr>
					</table>
				</asp:Panel>
				<asp:Panel id="AllowedPageTypesPanel" Runat="server">
				</asp:Panel>
			</asp:Panel>
			<br />
			<asp:Button id="ApplyButton" Runat="server" translate="/button/save"></asp:Button>
			<asp:Button id="DeleteButton" CausesValidation="False" Runat="server" translate="/button/delete"></asp:Button>
			<asp:Button id="CancelButton" CausesValidation="False" Runat="server" translate="/button/cancel"></asp:Button>
		</form>
	</body>
</HTML>
