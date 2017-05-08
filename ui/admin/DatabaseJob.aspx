<%@ Page language="c#" Codebehind="DatabaseJob.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Admin.DatabaseJob" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>DatabaseJob</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css" type="text/css" rel="stylesheet">
		<script type='text/javascript' src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/system.js"></script>
	</HEAD>
	<body MS_POSITIONING="GridLayout">
		<form id="ArchiveJob" method="post" runat="server">
			<episerversys:systemprefix id="PagePrefix" runat="server" />
			<p>
				<episerversys:validationsummary runat="server" id="Validationsummary1" />
			</p>
			<episerversys:tabstrip runat="server" id="actionTab" AutoPostBack="False" TargetID="TabView">
				<episerversys:tab Text="#tabsettings" runat="server" ID="Tab1" sticky="True" />
				<episerversys:tab Text="#tabhistory" runat="server" ID="Tab2" sticky="True" />
			</episerversys:tabstrip>
			<asp:Panel ID="TabView" Runat="server">
				<asp:Panel ID="GeneralSettings" Runat="server">
					<br>
					<table>
						<tr>
							<td>
								<episerver:translate Text="#schedulecaption" runat="server" id="Translate1" />
							</td>
							<td>
								<asp:TextBox Columns=5 ID="frequencyInput" Runat="server" />
								<asp:DropDownList ID="recurrenceInput" Runat="server"></asp:DropDownList>
								<asp:RangeValidator id="frequencyInputRange" ControlToValidate="frequencyInput" MinimumValue="1" MaximumValue="1440" Type="Integer" EnableClientScript="true" Text="*" runat="server" />
								<asp:RequiredFieldValidator id="frequencyInputRequired" ControlToValidate="frequencyInput" Text="*" runat="server" />
							</td>
						</tr>
						<tr>
							<td>
								<episerver:translate Text="#nextexecution" runat="server" ID="Translate3" NAME="Translate1" />
							</td>
							<td>
								<EPiServer:InputDate ID="nextExecutionInput" runat="server" DisplayName="#nextexecution"/>
							</td>
						</tr>
						<tr>
							<td>
								<episerver:translate Text="#activecaption" runat="server" ID="Translate2" NAME="Translate1" />
							</td>
							<td>
								<asp:CheckBox ID="isActiveInput" Runat="server" />
							</td>
						</tr>
						<tr>
							<td colspan="2">
								&nbsp;
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<asp:Button Translate="/button/save" ID="saveChanges" Runat="server" />
								<asp:Button Translate="#testbutton" ID="startNowButton" CausesValidation="False" Runat="server" />
							</td>
						</tr>
					</table>
				</asp:Panel>
				<asp:Panel ID="Log" Runat="server">
						<br>
						<asp:DataGrid 
							id="logGrid" 
							AutoGenerateColumns="False" 
							runat="server" 
							CssClass="EP-tableGrid"
							PageSize="10"
							OnPageIndexChanged="ChangePaging"
							AllowPaging="True"
							Width="100%"
							EnableViewState="True">
							<PagerStyle Mode="NumericPages" CssClass="EP-tablePager" />
						<Columns>
							<asp:BoundColumn HeaderStyle-CssClass="EP-tableHeadingGrid" ItemStyle-CssClass="EP-tableCellGrid" HeaderText="#logdate" DataField="Exec"></asp:BoundColumn>
							<asp:BoundColumn HeaderStyle-CssClass="EP-tableHeadingGrid" ItemStyle-CssClass="EP-tableCellGrid" HeaderText="#logstatus" DataField="StatusMessage"></asp:BoundColumn>
							<asp:BoundColumn HeaderStyle-CssClass="EP-tableHeadingGrid" ItemStyle-CssClass="EP-tableCellGrid" HeaderText="#logmessage" DataField="Text"></asp:BoundColumn>
						</Columns>
						</asp:DataGrid>
				</asp:Panel>
			</asp:Panel>
		</form>
	</body>
</HTML>
