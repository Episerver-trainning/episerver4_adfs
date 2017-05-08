<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<%@ Page language="c#" Codebehind="Settings.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Admin.Settings" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
  <HEAD>
		<title>Settings</title>
		<meta name="vs_showGrid" content="False">
		<meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<link rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css">
		<script type='text/javascript' src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/system.js"></script>
</HEAD>
	<body>
		<EPiServerSys:refreshframe Visible="False" id="frameUpdater" FrameName="AdminMenu" SelectedTabName="AdminTab" runat="server"/>
		<episerversys:SystemPrefix id="SystemPrefix" runat="server" />
		<form id="Settings" method="post" runat="server">
			<p><EPiServerSys:ValidationSummary ID="Summary" Runat="server"/></p>
			<p><asp:Button id="Save" Text="Save" Runat="server"></asp:Button></p>
			<episerversys:tabstrip runat="server" id="actionTab" AutoPostBack="False" TargetID="tabView" SupportedPlugInArea="SystemSettings">
				<episerversys:tab Text="#sitetab" runat="server" ID="Tab1" />
				<episerversys:tab Text="#edittab" runat="server" ID="Tab2" />
				<episerversys:tab Text="#linktooltab" runat="server" ID="Tab7" />
				<episerversys:tab Text="#subscriptiontab" runat="server" ID="SubscriptionTab" />
				<episerversys:tab Text="#licensetab" runat="server" ID="LicenseTab" />
				<episerversys:tab Text="#ldaptab" runat="server" ID="Tab6" />
			</episerversys:tabstrip>
			<asp:Panel runat="server" id="tabView">
				<asp:Table id=GeneralTable Runat="server" Width="100%">
					<asp:TableRow>
						<asp:TableCell CssClass="EP-tableCaptionCell">
							<episerver:Translate Text="#epssitenamecaption" runat="server" />
						</asp:TableCell>
						<asp:TableCell>
							<asp:TextBox Columns="50" ID="EPsSiteName" Runat="server"></asp:TextBox>
						</asp:TableCell>
					</asp:TableRow>
					<asp:TableRow>
						<asp:TableCell CssClass="EP-tableCaptionCell">
							<episerver:Translate Text="#epshosturlcaption" runat="server" />
						</asp:TableCell>
						<asp:TableCell>
							<asp:TextBox Columns="50" ID="EPsHostUrl" Runat="server"></asp:TextBox>
						</asp:TableCell>
					</asp:TableRow>
					<asp:TableRow>
						<asp:TableCell CssClass="EP-tableCaptionCell">
							<episerver:Translate Text="#epslanguagecaption" runat="server" ID="Translate4"/>
						</asp:TableCell>
						<asp:TableCell>
							<asp:DropDownList ID="EPsLanguage" Runat="server"></asp:DropDownList>
						</asp:TableCell>
					</asp:TableRow>
					<asp:TableRow>
						<asp:TableCell CssClass="EP-tableCaptionCell">
							<episerver:Translate Text="#epfencryptsensitiveinformationcaption" runat="server" ID="Translate5"/>
						</asp:TableCell>
						<asp:TableCell>
							<asp:CheckBox ID="EPfEncryptSensitiveInformation" Runat="server"></asp:CheckBox>
						</asp:TableCell>
					</asp:TableRow>
					<asp:TableRow>
					<asp:TableCell CssClass="EP-tableCaptionCell">
							<episerver:Translate Text="#epserrorhandling" runat="server" ID="Translate8"/>
						</asp:TableCell>
						<asp:TableCell>
							<asp:DropDownList ID="EPsErrorHandling" Runat="server"/>
						</asp:TableCell>
					</asp:TableRow>
					<asp:TableRow>
						<asp:TableCell CssClass="EP-tableCaptionCell">
							<episerver:Translate Text="#epserrormail" runat="server" ID="Translate9"/>
						</asp:TableCell>
						<asp:TableCell>
							<asp:TextBox Columns="50" ID="EPsErrorMail" Runat="server"></asp:TextBox>
						</asp:TableCell>
					</asp:TableRow>
					<asp:TableRow>
						<asp:TableCell CssClass="EP-tableCaptionCell">
							<episerver:Translate Text="#epssubscriptionhandler" runat="server" ID="Translate10"/>
						</asp:TableCell>
						<asp:TableCell>
							<EPiServerSys:SubscriptionHandlerInput Columns="50" ID="EPsSubscriptionHandler" Runat="server"/>
						</asp:TableCell>
					</asp:TableRow>
					<asp:TableRow>
						<asp:TableCell CssClass="EP-tableCaptionCell">
							<episerver:Translate Text="#epfenableglobalizationsupportcaption" runat="server" ID="Translate11"/>
						</asp:TableCell>
						<asp:TableCell>
							<asp:CheckBox ID="EPfEnableGlobalizationSupport" Runat="server"></asp:CheckBox>
						</asp:TableCell>
					</asp:TableRow>
					<asp:TableRow>
						<asp:TableCell CssClass="EP-tableCaptionCell">
							<episerver:Translate Text="#epfbrowserlanguagedetectioncaption" runat="server" ID="Translate12"/>
						</asp:TableCell>
						<asp:TableCell>
							<asp:CheckBox ID="EPfBrowserLanguageDetection" Runat="server"></asp:CheckBox>
						</asp:TableCell>
					</asp:TableRow>
					<asp:TableRow ID="EnablePersonalizationRow">
						<asp:TableCell CssClass="EP-tableCaptionCell">
							<episerver:Translate Text="#epfenablepersonalizationcaption" runat="server" />
						</asp:TableCell>
						<asp:TableCell>
							<asp:CheckBox ID="EPfEnablePersonalization" Runat="server"></asp:CheckBox>
						</asp:TableCell>
					</asp:TableRow>
					<asp:TableRow ID="EnableUnicodeRow">
						<asp:TableCell CssClass="EP-tableCaptionCell">
							<episerver:Translate Text="#epfenableunicodecaption" runat="server" />
						</asp:TableCell>
						<asp:TableCell>
							<asp:CheckBox ID="EPfEnableUnicode" Runat="server"></asp:CheckBox>
						</asp:TableCell>
					</asp:TableRow>
				</asp:Table>
				<asp:Table id=EditingTable Runat="server" Width="100%">
					<asp:TableRow>
						<asp:TableCell CssClass="EP-tableCaptionCell">
							<episerver:Translate Text="#editordivonreturncaption" runat="server"/>
						</asp:TableCell>
						<asp:TableCell>
							<asp:CheckBox ID="ParagraphIsDiv" Runat="server"></asp:CheckBox>						
						</asp:TableCell>
					</asp:TableRow>				
					<asp:TableRow>
						<asp:TableCell CssClass="EP-tableCaptionCell">
							<episerver:Translate Text="#epneditorheightcaption" runat="server" />
						</asp:TableCell>
						<asp:TableCell>
							<asp:TextBox Columns="10" ID="EPnEditorHeight" Runat="server"></asp:TextBox>
							<asp:RequiredFieldValidator ControlToValidate="EPnEditorHeight" Runat="server" ID="Requiredfieldvalidator1" EnableClientScript="False" />
							<asp:RangeValidator ControlToValidate="EPnEditorHeight" Type="Integer" MinimumValue="0" MaximumValue="10000" Runat="server" ID="Rangevalidator2" EnableClientScript="False" />
						</asp:TableCell>
					</asp:TableRow>
					<asp:TableRow>
						<asp:TableCell CssClass="EP-tableCaptionCell">
							<episerver:Translate Text="#epneditorwidthcaption" runat="server" />
						</asp:TableCell>
						<asp:TableCell>
							<asp:TextBox Columns="10" ID="EPnEditorWidth" Runat="server"></asp:TextBox>
							<asp:RequiredFieldValidator ControlToValidate="EPnEditorWidth" Runat="server" ID="Requiredfieldvalidator2" EnableClientScript="False" />
							<asp:RangeValidator ControlToValidate="EPnEditorWidth" Type="Integer" MinimumValue="0" MaximumValue="10000" Runat="server" ID="Rangevalidator3" EnableClientScript="False" />
						</asp:TableCell>
					</asp:TableRow>
					<asp:TableRow>
						<asp:TableCell CssClass="EP-tableCaptionCell">
							<episerver:Translate Text="#epnversioncountcaption" runat="server" />
						</asp:TableCell>
						<asp:TableCell>
							<asp:TextBox Columns="10" ID="EPnVersionCount" Runat="server"></asp:TextBox>
							<asp:RequiredFieldValidator ControlToValidate="EPnVersionCount" Runat="server" ID="Requiredfieldvalidator3" EnableClientScript="False" />
							<asp:RangeValidator ControlToValidate="EPnVersionCount" Type="Integer" MinimumValue="0" MaximumValue="100" Runat="server" ID="Rangevalidator4" EnableClientScript="False" />
						</asp:TableCell>
					</asp:TableRow>
					<asp:TableRow>
						<asp:TableCell CssClass="EP-tableCaptionCell">
							<episerver:Translate Text="#epseditcsscaption" runat="server" ID="Translate1"/>
						</asp:TableCell>
						<asp:TableCell>
							<asp:TextBox Columns="50" ID="EPsEditCSS" Runat="server"></asp:TextBox>
						</asp:TableCell>
					</asp:TableRow>
					<asp:TableRow>
						<asp:TableCell CssClass="EP-tableCaptionCell">
							<episerver:Translate Text="#epseditcontrolversion" runat="server" ID="Translate2"/>
						</asp:TableCell>
						<asp:TableCell>
							<asp:TextBox Columns="50" ID="EPsEditControlVersion" Runat="server"></asp:TextBox>
						</asp:TableCell>
					</asp:TableRow>
				</asp:Table>
				
				<asp:Table id="InsertLinkTable" Runat="server" Width="100%">
					<asp:TableRow>
						<asp:TableCell CssClass="EP-tableCaptionCell">
							<episerver:Translate Text="#epsuploaddircaption" runat="server" ID="Translate3"/>
						</asp:TableCell>
						<asp:TableCell>
							<asp:TextBox Columns="50" ID="EPsUploadDir" Runat="server"></asp:TextBox>
						</asp:TableCell>
					</asp:TableRow>
				</asp:Table>
				<asp:Table id=SubscriptionTable Visible="False" Runat="server" Width="100%">
					<asp:TableRow>
						<asp:TableCell CssClass="EP-tableCaptionCell">
							<episerver:Translate Text="#epssubmailfromcaption" runat="server" />
						</asp:TableCell>
						<asp:TableCell>
							<asp:TextBox Columns="50" ID="EPsSubMailFrom" Runat="server"></asp:TextBox>
						</asp:TableCell>
					</asp:TableRow>
					<asp:TableRow>
						<asp:TableCell CssClass="EP-tableCaptionCell">
							<episerver:Translate Text="#epssubmailbcccaption" runat="server" />
						</asp:TableCell>
						<asp:TableCell>
							<asp:TextBox Columns="50" ID="EPsSubMailBcc" Runat="server"></asp:TextBox>
						</asp:TableCell>
					</asp:TableRow>
					<asp:TableRow>
						<asp:TableCell CssClass="EP-tableCaptionCell">
							<episerver:Translate Text="#epssubtemplatecaption" runat="server" />
						</asp:TableCell>
						<asp:TableCell>
							<asp:TextBox Columns="50" ID="EPsSubTemplate" Runat="server"></asp:TextBox>
						</asp:TableCell>
					</asp:TableRow>
				</asp:Table><asp:Table id=LicenseTable Runat="server" Width="100%">
					<asp:TableRow>
						<asp:TableCell CssClass="EP-tableCaptionCell">
							<episerver:Translate Text="#licensedcompanycaption" runat="server" />
						</asp:TableCell>
						<asp:TableCell>
							<asp:TextBox Columns="50" ID="LicensedCompany" Runat="server"></asp:TextBox>
							<asp:RequiredFieldValidator ControlToValidate="LicensedCompany" display="None" runat="server" />
						</asp:TableCell>
					</asp:TableRow>
					<asp:TableRow>
						<asp:TableCell CssClass="EP-tableCaptionCell">
							<episerver:Translate Text="#licensedtocaption" runat="server" />
						</asp:TableCell>
						<asp:TableCell>
							<asp:TextBox Columns="50" ID="LicensedTo" Runat="server"></asp:TextBox>
							<asp:RequiredFieldValidator ControlToValidate="LicensedTo" display="None" runat="server" />
						</asp:TableCell>
					</asp:TableRow>
					<asp:TableRow>
						<asp:TableCell CssClass="EP-tableCaptionCell">
							<episerver:Translate Text="#licensekeycaption" runat="server" />
						</asp:TableCell>
						<asp:TableCell>
							<asp:TextBox Columns="50" ID="LicenseKey" Runat="server"></asp:TextBox>
							<asp:RequiredFieldValidator ControlToValidate="LicenseKey" display="None" runat="server" />
						</asp:TableCell>
					</asp:TableRow>
				</asp:Table>
				<asp:Table id="LdapTable" Runat="server" Width="100%">
					<asp:TableRow>
						<asp:TableCell CssClass="EP-tableCaptionCell">
							<episerver:Translate Text="#epsldapservercaption" runat="server" />
						</asp:TableCell>
						<asp:TableCell>
							<asp:TextBox Columns="50" Runat="server" ID="EPsLdapServer"></asp:TextBox>
						</asp:TableCell>
					</asp:TableRow>
					<asp:TableRow>
						<asp:TableCell CssClass="EP-tableCaptionCell">
							<episerver:Translate Text="#epsldapusercaption" runat="server" />
						</asp:TableCell>
						<asp:TableCell>
							<asp:TextBox Columns="30" Runat="server" ID="EPsLdapUser"></asp:TextBox>
						</asp:TableCell>
					</asp:TableRow>
					<asp:TableRow>
						<asp:TableCell CssClass="EP-tableCaptionCell">
							<episerver:Translate Text="#epsldappasswordcaption" runat="server" ID="Translate6"/>
						</asp:TableCell>
						<asp:TableCell>
							<asp:TextBox Columns="30" TextMode="password" Runat="server" ID="EPsLdapPassword"></asp:TextBox>
						</asp:TableCell>
					</asp:TableRow>
					<asp:TableRow>
						<asp:TableCell CssClass="EP-tableCaptionCell">
							<episerver:Translate Text="#clearldapcache" runat="server" ID="Translate7"/>
						</asp:TableCell>
						<asp:TableCell>
							<asp:Button id="ClearLdapCache" Translate="/button/clear" Runat="server" />
						</asp:TableCell>
					</asp:TableRow>
				</asp:Table>
			</asp:Panel>
		</form>
	</body>
</HTML>
