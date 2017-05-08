<%@ Control EnableViewState="False" Language="c#" AutoEventWireup="false" Codebehind="CreateDirectory.ascx.cs" Inherits="EPiServer.Util.FileManager.CreateDirectory" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<table class="FM-MarginTable">
	<tr>
		<td>
			<EPiServer:Translate Text="/filemanager/createdirectory/name" runat="server"/>
		</td>
		<td>
			<asp:TextBox ID="DirName" Runat="server"/>
			<asp:RequiredFieldValidator ID="RequiredCheck"
					ErrorMessage="*"
					Display="Dynamic"
					ControlToValidate="DirName"
					Runat="server"/>
			<asp:CustomValidator id="CustomValidator1"
					ControlToValidate="DirName"
					OnServerValidate="ValidateNewDirectory"
					Display="Dynamic"
					ErrorMessage="Directory already exists"
					Translate="/filemanager/createdirectory/alreadyexists"
					runat="server"/>
			<asp:CustomValidator id="Customvalidator2"
					ControlToValidate="DirName"
					OnServerValidate="ValidateFileSystemName"
					Display="Dynamic"
					ErrorMessage="Invalid characters in name"
					Translate="/filemanager/invalidcharacters"
					runat="server"/>
		</td>
	</tr>
</table>
<table class="FM-MarginTable">
	<tr>
		<td>
			<asp:Button ID="SaveButton" Translate="/button/save" Runat="server"/>
			<asp:Button ID="CancelButton" Translate="/button/cancel" CausesValidation="False" Runat="server"/>
		</td>
	</tr>
</table>
<script type="text/javascript">

document.forms[0].<%=DirName.ClientID%>.focus();
document.body.attachEvent("onkeydown",handleKeyPressed);

function handleKeyPressed()
{
	if(event.keyCode == 13 && event.srcElement.type == 'text')
	{
		document.forms[0].<%=SaveButton.ClientID%>.click();
		return false;
	}
	return true;
}
</script>