<%@ Control Language="c#" AutoEventWireup="false" Codebehind="CheckInSelection.ascx.cs" Inherits="EPiServer.Util.FileManager.CheckInSelection" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="FileManager" TagName="FileReferenceList"	Src="~/util/FileManager/FileReferenceList.ascx"%>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>

<table class="FM-MarginTable">
	<tr>
		<td>
			<EPiServer:Translate Text="/filemanager/checkinselection/currentfile" runat="server" ID="Translate1"/>
		</td>
		<td>
			<asp:Label Runat="server" ID="currentFile"/>&nbsp;<asp:Label Runat="server" ID="fileCount"/>
		</td>
	</tr>
	<tr>
		<td>
			<EPiServer:Translate Text="/filemanager/checkinselection/selectversion" runat="server" ID="Translate2"/>
		</td>
		<td>
			<input type="file" runat="server" ID="FileUpload" NAME="FileUpload"/>
			<asp:RequiredFieldValidator ID="RequiredCheck" ErrorMessage="*" ControlToValidate="FileUpload" EnableClientScript="True" Runat="server"/>
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<EPiServer:Translate Text="/filemanager/checkinselection/comments" runat="server"/><br />
			<asp:TextBox ID="Comments" Columns="50" Rows="10" TextMode="MultiLine" Runat="server"/>
		</td>
	</tr>
</table>
<table class="FM-MarginTable">
	<tr>
		<td>
			<asp:Button ID="SaveButton" OnClick="SaveButton_Click" Translate="/button/ok" Runat="server"/>
			<asp:Button ID="CancelButton" OnClick="CancelButton_Click" Translate="/button/cancel" CausesValidation="False" Runat="server"/>
		</td>
	</tr>
</table>
