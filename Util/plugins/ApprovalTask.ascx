<%@ Control language="c#" Codebehind="ApprovalTask.ascx.cs" AutoEventWireup="false" Inherits="EPiServer.Workflow.Util.PlugIns.ApprovalTask" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServerWorkflow" Namespace="EPiServer.Workflow.WebControls" Assembly="EPiServer.Workflow" %>
<script language="JavaScript" src="../util/javascript/workflow.js"></script>
<link rel="stylesheet" type="text/css" href="../util/styles/workflow.css">
<table width="100%" border=0 cellpadding=4 cellspacing=0 id="Tab">
<tr>
	<td colspan=2>
		<b><asp:Label id="headerText" Text="<%#CurrentTask.Status!=EPiServer.Personalization.TaskStatus.NotStarted ? (Approved ? ApprovedText : NotApprovedText) : String.Empty%>" runat="server"/></b>
	</td>
</tr>
<tr>
	<td style="height: 25px;width: 1px;border-color: gray;cursor:hand;border-style: solid;border-width:0 0 1 0;">&nbsp;</td>
	<td OnClick="OpenTab(1)" WIDTH="5" ID="Tab1" class="WF-LeftTabSelected" ALIGN="MIDDLE" VALIGN="MIDDLE"><EPiServer:Translate Text="/util/plugins/approvaltask/commontab" runat="server"/></td>
	<td OnClick="OpenTab(2)" WIDTH="5" ID="Tab2" class="WF-RightTab" ALIGN="MIDDLE" VALIGN="MIDDLE"><EPiServer:Translate Text="/personalization/task/comments" runat="server"/></td>
	<td style="height: 25px;border-color: gray;cursor:hand;border-style: solid;border-width:0 0 1 0;">&nbsp;</td>
</tr>
</table>
<br>
<span id="Tab1Body">
	<table cellpadding=2 cellspacing=2 width=100%>
		<tr>
			<td>
				<b><EPiServer:translate text="/personalization/task/subject" runat="server" ID="Translate1"/></b>
				<br>
				<%#CurrentTask.Subject%></td>
		</tr>
		<tr>
			<td>
				<b><EPiServer:translate text="/personalization/task/owner" runat="server" ID="Translate44"/></b>
				<br>
				<%#EPiServer.Personalization.PersonalizedData.Load(CurrentTask.Owner).DisplayName%></td>
		</tr>
		<tr runat="server" Visible=<%#CurrentTask.DueDate==DateTime.MaxValue ? false : true%>>
			<td>
				<b><EPiServer:translate text="/personalization/task/duedate" runat="server" ID="Translate2" NAME="Translate1"/></b>
				<br>
				<%#CurrentTask.DueDate==DateTime.MaxValue ? String.Empty : CurrentTask.DueDate.ToString()%></td>
		</tr>
		<tr>
			<td>
				<b><EPiServer:translate text="/personalization/task/description" runat="server" ID="Translate4"/></b>
				<br>
				<%#CurrentTask.Description%></td>
		</tr>
		<tr id="CommentsRow" runat="server">
			<td>
				<b>
					<EPiServer:translate text="/personalization/task/comments" runat="server" ID="Translate5"/>
				</b>
				<br>
				<asp:textbox id="comments" Rows="5" Cols="15" TextMode="MultiLine" Text="<%#Comments%>" runat="server"/>
			</td>
		</tr>
		<tr>
			<td colspan=2>&nbsp;</td>
		</tr>
		<tr>
			<td colspan=2>
				<b><asp:Label id="questionText" Text="<%#Title%>" runat="server"/></b>
			</td>
		</tr>
		<tr>
			<td>
				<asp:Button Translate="/button/yes" Runat="server" OnClick="Yes" ID="yesBtn"/>
				<asp:Button Translate="/button/no" Runat="server" OnClick="No" ID="noBtn"/>
				<asp:Button runat="server" Visible="False" Translate="/button/delete" OnClick="DeleteOrphan" id="deleteOrphanButton" />
				<input type="button" Translate="/button/cancel" Runat="server" OnClick="window.location.href='ActionWindow.aspx'" ID="cancelBtn"/>
				<br><br>
				<asp:LinkButton Translate="/button/settings" Runat="server" OnClick="EditSettings" ID="settingsButton"/>
			</td>
		</tr>
	</table>
	</span>
	<span id="Tab2Body">
	<table>
	<tr id="ActivityRow" runat="server">
			<td>
					<EPiServerWorkflow:CommentHistory ID="commentHistory" runat="server">
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
	</span>
	<script language="javascript">OpenTab(1);</script>