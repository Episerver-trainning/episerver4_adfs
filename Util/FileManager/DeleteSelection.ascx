<%@ Control Language="c#" AutoEventWireup="false" Codebehind="DeleteSelection.ascx.cs" Inherits="EPiServer.Util.FileManager.DeleteFile" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="FileManager" TagName="FileReferenceList"	Src="~/util/FileManager/FileReferenceList.ascx"%>

<table class="FM-MarginTable">
	<tr>
		<td>
			<asp:Label runat="server" id="confirmMsg"/>
		</td>
	</tr>
	<tr>
		<td>
			<asp:Label runat="server" ForeColor="red" id="confirmWarning"/>
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
			<asp:Button ID="DeleteButton" Translate="/button/delete" Text="Delete" Runat="server"/>
			<asp:Button ID="CancelButton" Translate="/button/cancel" Text="Cancel" CausesValidation="False" Runat="server"/>
		</td>
	</tr>
</table>
