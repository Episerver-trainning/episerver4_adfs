<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<%@ Page language="c#" Codebehind="ContentMirroringEdit.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Admin.ContentMirroringEdit" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
  <HEAD>
    <title>ContentMirroringInfo</title>
    <meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
    <meta name="CODE_LANGUAGE" Content="C#">
    <meta name=vs_defaultClientScript content="JavaScript">
    <meta name=vs_targetSchema content="http://schemas.microsoft.com/intellisense/ie5">
    <script type='text/javascript' src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/system.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css">
  </HEAD>
  <script type="text/javascript">
	function onUserNameChange() {
		var userNameTxt = document.getElementById('ImpersonateUserName');
		var domainTxt = document.getElementById('ImpersonateDomain');
		if (userNameTxt && domainTxt) {
			domainTxt.disabled = userNameTxt.value.indexOf('\\') > -1;			
		}
	}
  </script>
  <body MS_POSITIONING="GridLayout">
	
    <form id="ContentMirroringEdit" method="post" runat="server">
	<episerversys:systemprefix id="PagePrefix" runat="server" />
	<episerversys:validationsummary id="Summary" runat="server" />
	<br><br>
	<EPiServerSys:TabStrip AutoPostback="False" TargetID="tabView" runat="server">
		<EPiServerSys:Tab Text="#tabinformation" ID="infoTab" runat="server"/>
		<EPiServerSys:Tab Text="#tabfilter" Sticky="True" ID="filterTab" runat="server"/>
	</EPiServerSys:TabStrip>
	<asp:Panel ID="tabView" Runat="server">
		<asp:Panel ID="infoPanel" Runat="server">
			<table>
			<tr>
			<td Class="EP-tableCaptionCell">
				<episerver:translate Text="#name" runat="server" ID="Translate1"/>
			</td>
			<td>
				<asp:TextBox MaxLength="100" ID="Name" Runat="server"/>
				<asp:RequiredFieldValidator ID="RequiredNameCheck"
							ErrorMessage="*"
							Display="Dynamic"
							ControlToValidate="Name"
							EnableClientScript = "True"
							Runat="server"/>
			</td>
			</tr>
			<tr>
			<td Class="EP-tableCaptionCell">
				<episerver:translate Text="#frompagelink" runat="server" ID="Translate2"/>
			</td>
			<td>
				<EPiServer:InputPageReference id="FromPageLink" runat="server"/>
				<asp:RequiredFieldValidator ID="RequiredUrlCheck"
					ErrorMessage="Must enter a source page link"
					Display="None"
					ControlToValidate="FromPageLink"
					EnableClientScript = "False"
					Runat="server"/>
			</td>
			</tr>
			<tr>
			<td Class="EP-tableCaptionCell">
				<episerver:translate Text="#channeltype" runat="server" ID="Translate9"/>
			</td>
			<td>
				<asp:DropDownList ID="MirrorType" Runat="server"></asp:DropDownList>
			</td>
			</tr>
			<tr>
				<td Class="EP-tableCaptionCell">
					<episerver:translate Text="#globalizationsupport" runat="server" ID="Translate10"/>
				</td>
				<td>
					<asp:DropDownList Runat="server" id="GlobalizationSupport"/>
				</td>
			</tr>
			<tr>
				<td Class="EP-tableCaptionCell">
					<episerver:translate Text="#automaticapproval" runat="server" ID="Translate3"/>
				</td>
				<td>
					<asp:CheckBox Runat="server" id="AutomaticApproval"/>
				</td>
			</tr>
			<tr>
				<td Class="EP-tableCaptionCell">
					<episerver:translate Text="#includeroot" runat="server" ID="Translate11"/>
				</td>
				<td>
					<asp:CheckBox Runat="server" id="IncludeRoot"/>
				</td>
			</tr>
			<tr>
					<td Class="EP-tableCaptionCell">
						<episerver:translate Text="#runasanonymoususer" runat="server" ID="Translate8"/>
					</td>
					<td Class="EP-tableCaptionCell" colspan="2">
						<asp:CheckBox AutoPostBack="True" ID="RunAsAnonymousUser" Checked="True" OnCheckedChanged="RunAsAnonymousUserChanged" Runat="server" />
					</td>
				</tr>
				<tr>
					<td Class="EP-tableCaptionCell">
						<episerver:translate Text="#impersonateusername" runat="server" ID="Translate4"/>
					</td>
					<td>
						<asp:TextBox Enabled="False" MaxLength="100" ID="ImpersonateUserName" Runat="server" onchange="onUserNameChange()" />
					</td>
				</tr>
				<tr>
					<td Class="EP-tableCaptionCell">
						<episerver:translate Text="#impersonatepassword" runat="server" ID="Translate5"/>
					</td>
					<td>
						<asp:TextBox TextMode="Password" Enabled="False" MaxLength="100" ID="ImpersonatePassword" Runat="server"/>
					</td>
				</tr>
				<tr>
					<td Class="EP-tableCaptionCell">
						<episerver:translate Text="#impersonatedomain" runat="server" id="Translate12" />
					</td>
					<td>
						<asp:TextBox Enabled="False" MaxLength="100" ID="ImpersonateDomain" Runat="server"/>
					</td>
				</tr>

			</table>
		</asp:Panel>
		<asp:Panel ID="filterPanel" Runat="server">
			<table>
				<tr>
					<td Class="EP-tableCaptionCell" colspan="2">
						<asp:CheckBox AutoPostBack="True" ID="ActivateFilter" Checked="False" OnCheckedChanged="ActivateFilterChanged" Runat="server" Text=<%#Translate("#activatefilter")%> />
					</td>
				</tr>
				<tr>
					<td Class="EP-tableCaptionCell">
						<episerver:translate Text="#filterpropertyname" runat="server" ID="Translate6"/>
					</td>
					<td>
						<asp:TextBox Enabled="False" MaxLength="100" ID="FilterByPropertyName" Runat="server"/>
					</td>
				</tr>
				<tr>
					<td Class="EP-tableCaptionCell">
						<episerver:translate Text="#filterpropertyvalue" runat="server" ID="Translate7"/>
					</td>
					<td>
						<asp:TextBox Enabled="False" MaxLength="100" ID="FilterByPropertyValue" Runat="server"/>
					</td>
				</tr>
			</table>
		</asp:Panel>
	</asp:Panel>
	<br>
	<asp:Button OnClick="SaveForm" Runat="Server" Translate="/button/save" ID="SaveButton" NAME="SaveButton"/>
	<asp:Button OnClick="DeleteForm" CausesValidation="False" Runat="Server" Translate="/button/delete" ID="DeleteButton" NAME="DeleteButton"/>
	<asp:Button OnClick="CancelForm" CausesValidation="False" Runat="Server" Translate="/button/cancel" ID="CancelButton" NAME="CancelButton"/>
     </form>
	
  </body>
  <script type="text/javascript">
	onUserNameChange();
  </script>
</HTML>
