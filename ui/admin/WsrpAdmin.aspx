<%@ Register TagPrefix="EPiServer" TagName="SourceEditor" Src="WsrpSourceEditor.ascx" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<%@ Page language="c#" Codebehind="WsrpAdmin.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Admin.WsrpAdmin" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<link rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css">
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<episerversys:systemprefix id="pagePrefix" runat="server" />
			<episerversys:ValidationSummary runat="server" ID="Summary" />
			<br /><br />
			<table>
			<tr>
			<td>
			<asp:Repeater Runat="server" ID="WsrpSourceList">
				<HeaderTemplate>
					<table class="EP-tableGrid" width="100%">
					<tr>
						<td class="EP-tableHeadingGrid" width="90%"><episerver:translate Text="/templates/wsrpfx/admin/sourcename" runat="server" /></td>
						<td class="EP-tableHeadingGrid">&nbsp;</td>
						<td class="EP-tableHeadingGrid">&nbsp;</td>
					</tr>
				</HeaderTemplate>
				<ItemTemplate>
					<tr>
						<td class="EP-tableCellGrid"><asp:LinkButton Runat=server CssClass="Label" OnCommand="Source_Click" CausesValidation="False" CommandArgument='<%# ((ElektroPost.Wsrp.Consumer.IProducer)Container.DataItem).ProducerId %>'>
							<%# ((ElektroPost.Wsrp.Consumer.IProducer)Container.DataItem).ProducerId %>
						</asp:LinkButton></td>
						<td class="EP-tableCellGrid" ><asp:Button Runat=server CssClass="Label" CausesValidation="False" OnCommand="SourceTest_Click" CommandArgument='<%# ((ElektroPost.Wsrp.Consumer.IProducer)Container.DataItem).ProducerId %>' Translate="/templates/wsrpfx/admin/test" ></asp:Button></td>
						<td class="EP-tableCellGrid" ><asp:Button Runat=server CssClass="Label" CausesValidation="False" OnCommand="SourceDelete_Click" CommandArgument='<%# ((ElektroPost.Wsrp.Consumer.IProducer)Container.DataItem).ProducerId %>' Translate="/templates/wsrpfx/admin/delete" ></asp:Button></td>
					</tr>
				</ItemTemplate>
				<FooterTemplate>
					</table>
				</FooterTemplate>
			</asp:Repeater><br />
			<asp:Button runat="Server" ID=CreateNew CausesValidation=False Translate="/templates/wsrpfx/admin/createnew" OnClick="CreateNew_Click" />
			</td>
			</tr>
			<tr>
			<td>
			<EPiServer:SourceEditor runat="Server" ID="SourceEditor" Visible="false" OnSave="Source_Save" />
			</td>
			</tr>
		</form>
	</body>
</HTML>
