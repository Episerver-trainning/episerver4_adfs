<%@ Control Language="c#" AutoEventWireup="false" Codebehind="WorkflowLogView.ascx.cs" Inherits="EPiServer.Workflow.Util.PlugIns.WorkflowLogView" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServerWorkflow" Namespace="EPiServer.Workflow.WebControls" Assembly="EPiServer.Workflow" %>
<link rel="stylesheet" type="text/css" href="../util/styles/workflow.css">
<script language="javascript">

function OverDD(img)
{
	if(img.src.indexOf('Up.gif')>0)
		img.src = img.src.replace('Up.gif','UpActive.gif');
	if(img.src.indexOf('Down.gif')>0)
		img.src = img.src.replace('Down.gif','DownActive.gif');
}

function OutDD(img)
{
	if(img.src.indexOf('UpActive.gif')>0)
		img.src = img.src.replace('UpActive.gif','Up.gif');
	if(img.src.indexOf('DownActive.gif')>0)
		img.src = img.src.replace('DownActive.gif','Down.gif');
}

function SwitchDD(img)
{
	var parent = img.parentElement;
	while(parent.tagName!='TABLE')
		parent = parent.parentElement;
	
	var sepRow = parent.parentElement.all["SepRow"];
	var logRow = parent.parentElement.all["LogRow"];
	if(sepRow.style.display=='')
	{
		sepRow.style.display = 'none';
		logRow.style.display = 'none';
		img.src = img.src.replace("Up","Down");
	}
	else
	{
		sepRow.style.display = '';
		logRow.style.display = '';
		img.src = img.src.replace("Down","Up");
	}
}

</script>
<asp:Panel ID="Title" runat="server">
<h2><EPiServer:Translate Text="/util/plugins/workflowlogview/heading" runat="server"/></h2>
</asp:Panel>
<asp:DataGrid AutoGenerateColumns="False" GridLines="None" BorderStyle="None" Width="100%" Cellpadding="2" Cellspacing="0" ID="Log" Runat="server">
<Columns>
	<asp:TemplateColumn>
		<ItemTemplate>
				<table class="WF-Heading" border="0" cellpadding="0" cellspacing="0" width="100%">
					<tr>
						<td class="WF-HeadingPrefix">
							<EPiServer:Translate Text="/util/plugins/workflowlogview/logpagename" runat="server"/>:&nbsp;
						</td>
						<td width=100%>
							<EPiServerWorkflow:PageName PageID=<%#Convert.ToInt32(DataBinder.Eval(Container.DataItem,"fkPageID"))%> runat="server" ID="Pagename1"/>
						</td>
						<td class="WF-HeadingIcon">
							<img style="CURSOR: hand" onclick="SwitchDD(this);" OnMouseOver="OverDD(this)" OnMouseOut="OutDD(this)" src="../util/images/Workflow/doubleDown.gif"/>&nbsp;
						</td>
					</tr>
				</table>
			<table cellpadding="0" cellspacing="0" width="100%" class="WF-Table">
			<tr>
				<td colspan="2">
					<table cellpadding="0" cellspacing="0" width="100%">
						<tr>
							<td colspan=2><EPiServer:Translate Text="/util/plugins/workflowlogview/logcreated" runat="server" ID="Translate1"/>:&nbsp;<nobr><%#DataBinder.Eval(Container.DataItem,"Created")%></nobr></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td colspan=2>
					<EPiServerWorkflow:WorkflowStatus LogID=<%#Convert.ToInt32(DataBinder.Eval(Container.DataItem, "pkID")) %> runat="server"/>
				</td>
			</tr>
			<tr>
				<td colspan=2>
					<asp:LinkButton OnCommand="DeleteWorkflowLog" CommandName=<%#Convert.ToInt32(DataBinder.Eval(Container.DataItem,"pkID"))%> Translate="/button/delete" Runat="server" ID="Linkbutton1" NAME="Linkbutton1"/>
				</td>
			</tr>
			<tr id="SepRow" style="display: none;">
				<td colspan="2">
					<table cellpadding=0 cellspacing=0 class="WF-Separator"><tr><td/></tr></table>
				</td>
			</tr>
			<tr id="LogRow" style="display: none;">
				<td>
					<EPiServerWorkflow:CommentHistory LogID=<%#Convert.ToInt32(DataBinder.Eval(Container.DataItem, "pkID")) %> ID="commentHistory" runat="server">
						<ItemTemplate>
									<EPiServerWorkflow:Counter runat="server" ID="Counter1"/><br>
									<asp:Image ImageUrl=<%#DataBinder.Eval(Container.DataItem, "StatusIcon") %> Runat="server"/>
								</td>
								<td>
									<%#DataBinder.Eval(Container.DataItem,"Subject")%><font class="WF-DimText">&nbsp;(<%#DataBinder.Eval(Container.DataItem,"Created")%>)</font><br>
									<%#DataBinder.Eval(Container.DataItem,"Comment")%>
								</td>
							</tr>
							<tr>
								<td colspan="2" class="WF-Address">
									<%#DataBinder.Eval(Container.DataItem,"CreatedBy")%>
							</ItemTemplate>
					</EPiServerWorkflow:CommentHistory>
				</td>
			</tr>
		</table>
		</ItemTemplate>
	</asp:TemplateColumn>
</Columns>
</asp:DataGrid>
