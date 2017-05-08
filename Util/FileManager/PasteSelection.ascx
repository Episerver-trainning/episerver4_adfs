<%@ Control Language="c#" AutoEventWireup="false" Codebehind="PasteSelection.ascx.cs" Inherits="EPiServer.Util.FileManager.PasteSelection" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="FileManager" TagName="FileReferenceList"	Src="~/util/FileManager/FileReferenceList.ascx"%>
<table class="FM-MarginTable">
	<tr>
		<td>
			<asp:Label Runat="server" ID="msgLabel"/>
		</td>
	</tr>
	<tr>
		<td>
			<FileManager:FileReferenceList UseWarningStyle="True" id="fileReferenceList" runat="server"/>
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
