<%@ Control language="c#" Codebehind="StartWorkflow.ascx.cs" AutoEventWireup="false" Inherits="EPiServer.Workflow.Util.PlugIns.StartWorkflow" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<script language="JavaScript" src="../util/javascript/workflow.js"></script>
<link rel="stylesheet" type="text/css" href="../util/styles/workflow.css">
<table id="Step1" runat="server">
	<tr>
		<td valign="top" align="left">
		<b><EPiServer:Translate Text="/util/plugins/startworkflow/availableworkflows" runat="server"/></b>
		</td>
	</tr>
	<tr>
		<td valign="top" align="left">
			&nbsp;
		</td>
	</tr>
	<tr>
		<td valign="top" align="left">
			<asp:DataList ID="WorkflowList" Runat="server">
			<ItemTemplate>
				<asp:LinkButton Font-Bold=True OnCommand="SelectWorkflowClicked" CommandArgument=<%#DataBinder.Eval(Container.DataItem,"pkID")%> CommandName=<%#DataBinder.Eval(Container.DataItem,"Name")%> Text=<%#DataBinder.Eval(Container.DataItem,"Name")%> Runat="server"/>
					<br>
				<asp:Label Text=<%#DataBinder.Eval(Container.DataItem,"Description")%> Runat="server"/>
			</ItemTemplate>			
			</asp:DataList>
		</td>
	</tr>
	<tr>
		<td colspan="2">
		</td>
	</tr>
</table>
<table id="Step2" runat="server">
	<tr>
		<td valign="top" align="left" style="font-weight:bold">
			<asp:Label Text=<%#WorkflowName%> Runat="server" ID="Label1" NAME="Label1"/>
		</td>
	</tr>
	<tr>
		<td valign="top" align="left">
			&nbsp;
		</td>
	</tr>
	<tr>
		<td valign="top" align="left">
			<EPiServer:Translate Text="/util/plugins/startworkflow/comments" runat="server" ID="Translate1"/>
		</td>
	</tr>
	<tr>
		<td valign="top" align="left">
			<asp:TextBox TextMode="MultiLine" Rows="5" Cols="15" Runat="server" ID="Comments"></asp:TextBox>
		</td>
	</tr>
	<tr>
		<td colspan="2" align="left">
			<asp:Button OnClick="StartWorkflowClicked" Translate="/button/ok" Runat="server" ID="Button1"></asp:Button>
			<input type="button" onclick="window.location.href='ActionWindow.aspx';" Translate="/button/cancel" Runat="server" ID="Button2">
		</td>
	</tr>
</table>