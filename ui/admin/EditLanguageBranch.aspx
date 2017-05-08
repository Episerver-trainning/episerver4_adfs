<%@ Page language="c#" Codebehind="EditLanguageBranch.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Admin.EditLanguageBranch" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>EditLanguageBranch</title>
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<link rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css">
		<script type='text/javascript' src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/system.js"></script>
	</HEAD>
	<body>
		<EPiServerSys:systemprefix id="SystemPrefix" runat="server" />
		<episerversys:validationsummary runat="server"/>
		<form id="EditPageTypeBase" method="post" runat="server">
			<table>
				<tr>
					<td class="EP-tableCaptionCell">
						<EPiServer:Translate id="Translate1" runat="server" Text="#namecaption"></EPiServer:Translate></td>
					<td>
						<asp:TextBox id="LanguageBranchName" Runat="server" CssClass="EPEdit-inputString" MaxLength="255" Columns="50"></asp:TextBox></td>
						<asp:RequiredFieldValidator Display="None" ID="requiredNameValidator" Runat="server" EnableClientScript="False" ControlToValidate="LanguageBranchName" ErrorMessage="*"/>
				</tr>
				<tr>
					<td class="EP-tableCaptionCell">
						<EPiServer:Translate id="Translate6" runat="server" Text="#enabledcaption"></EPiServer:Translate></td>
					<td>
						<asp:CheckBox id="LanguageBranchEnabled" Checked="True" Runat="server" CssClass="EPEdit-inputBool"></asp:CheckBox></td>
				</tr>
				<tr>
					<td class="EP-tableCaptionCell">
						<EPiServer:Translate id="Translate2" runat="server" Text="#idcaption"></EPiServer:Translate></td>
					<td>
						<asp:DropDownList id="LanguageBranchID" Runat="server" CssClass="EPEdit-inputString"/>
					</td>
				</tr>
				<tr>
					<td class="EP-tableCaptionCell">
						<EPiServer:Translate id="Translate3" runat="server" Text="#iconcaption"></EPiServer:Translate></td>
					<td>
						<asp:TextBox id="LanguageBranchIcon" Runat="server" CssClass="EPEdit-inputString" MaxLength="255" Columns="50"></asp:TextBox></td>
					</td>
				</tr>
				<tr>
					<td class="EP-tableCaptionCell">
						<EPiServer:Translate id="Translate5" runat="server" Text="#urlsegmentcaption"></EPiServer:Translate></td>
					<td>
						<asp:TextBox id="LanguageBranchURLSegment" Runat="server" CssClass="EPEdit-inputString" MaxLength="255" Columns="50"></asp:TextBox></td>
						<asp:RegularExpressionValidator Display="None" EnableClientScript="False" Runat="server" ID="urlSegmentValidator" ErrorMessage="*" ControlToValidate="LanguageBranchURLSegment" ValidationExpression="^[a-z0-9\-\._~]+$" />
					</td>
				</tr>
				<tr>
					<td class="EP-tableCaptionCell">
						<EPiServer:Translate id="Translate4" runat="server" Text="#sortindexcaption"></EPiServer:Translate></td>
					<td>
						<asp:TextBox id="LanguageBranchSortIndex" Runat="server" CssClass="EPEdit-inputString" MaxLength="5" Columns="5"></asp:TextBox></td>
				</tr>
			</table>
			<br />
			<asp:Button id="ApplyButton" Runat="server" translate="/button/save"></asp:Button>
			<asp:Button id="DeleteButton" CausesValidation="False" Runat="server" translate="/button/delete"></asp:Button>
			<asp:Button id="CancelButton" CausesValidation="False" Runat="server" translate="/button/cancel"></asp:Button>
		</form>
	</body>
</HTML>
