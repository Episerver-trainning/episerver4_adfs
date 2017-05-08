<%@ Control EnableViewState="False" Language="c#" AutoEventWireup="false" Codebehind="Security.ascx.cs" Inherits="EPiServer.Util.FileManager.Security" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<table class="FM-MarginTable">
	<tr>
		<td>
			<asp:CheckBox Checked="False" Runat="server" id="isInherited"/>
			<EPiServerSys:SidAccessLevel CssClass="EPEdit-sidAccessLevel" id="sidList" runat="server" />
			<input type="button" id="AddGroupButton" runat="server" translate="/button/addgroupsid" class="EP-largeButton" onclick="OpenSidBrowser(-1)" NAME="AddGroupButton">
			<input type="button" id="AddUserButton" runat="server" translate="/button/addusersid" class="EP-largeButton" onclick="OpenSidBrowser(-2)" NAME="AddUserButton">
			<input type="text" id="SearchText"> <input type="button" id="SearchButton" runat="server" translate="/button/search" class="EP-smallButton" onclick="OpenSidBrowser(0, SearchText.value)" NAME="SearchButton">
		</td>
	</tr>
</table>
<table class="FM-MarginTable">
	<tr>
		<td>
			<asp:Button id="SaveButton" OnClick="SaveSecurity_Click" runat="server" translate="/button/save" />
			<asp:Button id="CancelButton" OnClick="CancelSecurity_Click" runat="server" translate="/button/cancel" />
		</td>
	</tr>
</table>
<script type="text/javascript">
function setInputStatus(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0][i].name.indexOf('<%=UniqueID%>')==0 && document.forms[0][i].name!='<%=SaveButton.UniqueID%>' && document.forms[0][i].name!='<%=CancelButton.UniqueID%>' && document.forms[0][i].name!='<%=isInherited.UniqueID%>')
			document.forms[0][i].disabled = !val;
	}
}
<%=isInherited.Checked ? "setInputStatus(false);" : String.Empty %>
</script>