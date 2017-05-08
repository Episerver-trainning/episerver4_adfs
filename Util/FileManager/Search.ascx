<%@ Control EnableViewState="True" Language="c#" AutoEventWireup="false" Codebehind="Search.ascx.cs" Inherits="EPiServer.Util.FileManager.Search" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="XForms" Namespace="EPiServer.XForms.WebControls" Assembly="EPiServer.XForms" %>
<EPiServerSys:ValidationSummary ID="Summary" Runat="server"/>
<table class="FM-MarginTable">
	<tr>
		<td>
			<EPiServer:Translate Text="/filemanager/search/filenamepattern" runat="server" ID="Translate5" NAME="Translate1"/>:
		</td>
		<td>
			<asp:Textbox Runat="server" Text="" ID="SearchFileNamePattern"/>
		</td>
	</tr>
	<tr>
		<td>
			<EPiServer:Translate Text="/filemanager/search/query" runat="server" ID="Translate1" NAME="Translate1"/>:
		</td>
		<td>
			<asp:Textbox Runat="server" ID="SearchQuery"/>
		</td>
	</tr>
	<tr>
		<td>
			<EPiServer:Translate Text="/filemanager/search/modifiedfrom" runat="server" ID="Translate3" NAME="Translate1"/>:
		</td>
		<td>
			<EPiServer:InputDate runat="server" id="fromDate" DisplayName="/filemanager/search/modifiedfrom" ValidateInput="True"/>
		</td>
	</tr>
	<tr>
		<td>
			<EPiServer:Translate Text="/filemanager/search/modifiedto" runat="server" ID="Translate4" NAME="Translate1"/>:
		</td>
		<td>
			<EPiServer:InputDate runat="server" ID="toDate" DisplayName="/filemanager/search/modifiedto" ValidateInput="True"/>
		</td>
	</tr>
	<tr id="advancedRow" runat="server">
		<td colspan="2">
			<asp:LinkButton Translate="/filemanager/search/advancedoptions" OnClick="SwitchAdvancedSearch" Runat="server" ID="switchAdvancedButton" />&nbsp;>>
		</td>
	</tr>
	<XForms:XFormControl Visible="False" ID="XFormCtrl" Runat="server"/>
	<tr>
		<td valign="top">
			<EPiServer:Translate Text="/filemanager/search/locations" runat="server" ID="Translate2" NAME="Translate2"/>:<br/>
		</td>
		<td>
			<asp:CheckBoxList RepeatLayout="Table" Runat="server" ID="SearchLocations"/>
		</td>
	</tr>
</table>
<table class="FM-MarginTable">
	<tr>
		<td>
			<asp:Button Runat="server"
				ID="SearchButton"
				Text="Search"
				Translate="/button/search"
			/>
			<asp:Button Runat="server"
				ID="CancelButton"
				Text="Search"
				Translate="/button/cancel"
			/>
		</td>
	</tr>
</table>
<hr size="1"/>
<table class="FM-MarginTable">
	<tr>
		<td>
			<asp:Label runat="server" ID="NrOfHits"/>
		</td>
	</tr>
	<tr>
		<td>
			<asp:Label runat="server" ID="SearchMessage"/>
		</td>
	</tr>
	<tr>
		<td>
			<asp:Table ID="SearchResultTable" runat="server">
			</asp:Table>
		</td>
	</tr>
</table>
<script type="text/javascript">

document.forms[0].<%=SearchQuery.ClientID%>.focus();
document.body.attachEvent("onkeydown",handleKeyPressed);

function handleKeyPressed()
{
	if(event.keyCode == 13 && event.srcElement.type == 'text')
	{
		document.forms[0].<%=SearchButton.ClientID%>.click();
		return false;
	}
	return true;
}
</script>

