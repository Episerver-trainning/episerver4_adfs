<%@ Control language="c#" Codebehind="EditTask.ascx.cs" AutoEventWireup="false" Inherits="EPiServer.Util.PlugIns.EditTask" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<table>
		<tr>
			<td>
				<EPiServer:translate text="/personalization/task/subject" runat="server"/>
				<br>
				<asp:TextBox ID="subject" Runat="server"/>
				<asp:RequiredFieldValidator ID="RequiredCheck"
					ErrorMessage="*"
					Display="Dynamic"
					ControlToValidate="subject"
					Runat="server"/>	
			</td>
		</tr>
		<tr>
			<td>
				<EPiServer:translate text="/personalization/task/duedate" runat="server" ID="Translate1" NAME="Translate1"/>
				<br>
				<asp:TextBox ID="duedate" Runat="server"/></td>
		</tr>
		<tr>
			<td>
				<EPiServer:translate text="/personalization/task/assignto" runat="server" ID="Translate2" NAME="Translate1"/>
				<br>
				<asp:DropDownList ID="assignedTo" runat="server"/>
			</td>
		</tr>
		<tr>
			<td>
				<EPiServer:translate text="/personalization/task/description" runat="server"/>
				<br>
				<asp:TextBox ID="description" TextMode="MultiLine" Runat="server"/></td>
		</tr>
		<tr>
			<td colspan=2>&nbsp;</td>
		</tr>
		<tr>
			<td>
				<asp:Button Translate="/button/save" OnClick="SaveTask" ID="saveTask" Runat="server"/>
				<asp:Button Translate="/button/delete" OnClick="DeleteTask" ID="deleteTask" Runat="server"/>
			</td>
		</tr>
</table>
