<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<%@ Page language="c#" Codebehind="ContentPublisherEdit.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Admin.ContentPublisherEdit" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
  <HEAD>
    <title>ContentPublisherEdit</title>
    <meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
    <meta name="CODE_LANGUAGE" Content="C#">
    <meta name=vs_defaultClientScript content="JavaScript">
    <meta name=vs_targetSchema content="http://schemas.microsoft.com/intellisense/ie5">
    <script type='text/javascript' src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/system.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css">
  </HEAD>
  <body MS_POSITIONING="GridLayout">
	
    <form id="ContentPublisherEdit" method="post" runat="server">
	<episerversys:systemprefix id="PagePrefix" runat="server" />
	<episerversys:validationsummary id="Summary" runat="server" />
	<br><br>
	
	<asp:Panel Visible="False" ID="selectTypePanel" Runat="server">
		<div>
			<EPiServer:Translate Text="#selecttype" runat="server"></EPiServer:Translate> 
			<asp:DropDownList ID="typeSelector" Runat="server">
				<asp:ListItem Value="PageMirroring">EPiServer</asp:ListItem>
				<asp:ListItem Value="HtmlMirroring">HTML</asp:ListItem>
				<asp:ListItem Value="XmlMirroring">XML</asp:ListItem>
			</asp:DropDownList>
		</div>
		<br>
		<div>
			<asp:Button OnClick="OnSelectedType" Translate="/button/ok" Runat="server" />
			<asp:Button CausesValidation="False" OnClick="CancelForm" Translate="/button/cancel" Runat="server" ID="Button1"/>
		</div>
	</asp:Panel>
	<asp:Panel ID="settingsPanel" Runat="server">
		<EPiServerSys:TabStrip AutoPostback="False" TargetID="tabView" runat="server">
			<EPiServerSys:Tab Text="#tabsettings" ID="infoTab" runat="server"/>
			<EPiServerSys:Tab Text="#tabqueue" ID="queueTab" runat="server"/>
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
				<asp:PlaceHolder Runat="server" ID="customEditor"></asp:PlaceHolder>
				</table>
			</asp:Panel>
			<asp:Panel ID="Queue" Runat="server">
				<br>
				<asp:Repeater id="queueList" Runat="server">
				<HeaderTemplate>
					<table class="EP-tableGrid">
						<tr>
							<td class="EP-tableHeadingGrid"><episerver:translate runat="server" text="#queueid" ID="Translate3"/></td>
							<td class="EP-tableHeadingGrid"><episerver:translate runat="server" text="#queuecreated" ID="Translate4"/></td>
						</tr>	
				</HeaderTemplate>
				<ItemTemplate>
					<tr>
						<td class="EP-tableCellGrid">
							#<%#DataBinder.Eval(Container.DataItem,"ID")%>
						</td>
						<td class="EP-tableCellGrid">
							<%#DataBinder.Eval(Container.DataItem,"Created")%>
						</td>
					</tr>
				</ItemTemplate>
				<FooterTemplate></table></FooterTemplate>
				</asp:Repeater>
			</asp:Panel>
		</asp:Panel>
		<br>
		<asp:Button OnClick="SaveForm" Runat="Server" Translate="/button/save" ID="SaveButton" NAME="SaveButton"/>
		<asp:Button OnClick="DeleteForm" CausesValidation="False" Runat="Server" Translate="/button/delete" ID="DeleteButton" NAME="DeleteButton"/>
		<asp:Button OnClick="CancelForm" CausesValidation="False" Runat="Server" Translate="/button/cancel" ID="CancelButton" NAME="CancelButton"/>
	</asp:Panel>
     </form>
	
  </body>
</HTML>
