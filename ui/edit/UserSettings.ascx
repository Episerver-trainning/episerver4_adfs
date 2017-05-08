<%@ Control Language="c#" AutoEventWireup="false" Codebehind="UserSettings.ascx.cs" Inherits="EPiServer.Edit.UserSettings" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<script type='text/javascript'>
function SelAllMember()
{
	if(selectedSid != null && allSid != null)
	{
		for (var i=0;i<selectedSid.length;i++)
		{
			selectedSid.options(i).selected = true;
		}
		for (var i=0;i<allSid.length;i++)
		{
			allSid.options(i).selected = true;
		}
	}
}
</script>

<EPiServerSys:SystemPrefix id="SystemPrefix" runat="server" />
<EPiServerSys:ValidationSummary id="Summary" runat="server" />
<asp:Button id="ApplyButton" Runat="server" OnClick="ApplyButton_Click" />
<asp:Button id="DeleteButton" CausesValidation="False" Translate="/button/delete" Runat="server" OnClick="DeleteButton_Click" />
<asp:Button id="CancelButton" CausesValidation="False" Translate="/button/cancel" Runat="server"/>
<asp:CheckBox ID="SendConfirmation" Runat="server" style="visibility: hidden" EnableViewState="True"></asp:CheckBox>
<br />
<br />

<EPiServerSys:TabStrip ID="SettingTabs" Runat="Server" AutoPostBack="false" TargetID="SettingsTabView" SupportedPlugInArea="SidSettingsArea">
	<EPiServerSys:Tab Sticky="True" Runat="Server" ID="DefaultTab" />
</EPiServerSys:tabstrip>
		
<asp:Panel ID="SettingsTabView" Runat="Server">
	<asp:Panel ID="DefaultView" Runat="Server">
		<EPiServerSys:propertydataform AutoLoadTabs="False" EnableTabs="False" Runat="Server" ID="EditForm">
			<CaptionTemplate>
				<nobr><%#Container.Property.DisplayName%></nobr>
			</CaptionTemplate>
		</EPiServerSys:propertydataform>
		<asp:Panel Runat="server" ID="Groups" Visible="false">
			<br />
			<table border="0" width="250" cellpadding="0" cellspacing="2">
				<tr>
					<td align=center class="EPEdit-tableColumn">
						<img src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/SIDTypeLocalGroup.gif">
						<episerver:Translate Text="/admin/secedit/listnotmemberof" runat="server" id="Translate1" />
						<br>
						<asp:ListBox Runat="server" ID="AllSid" CssClass="FormNW" Rows="10" style="width=35ex;" SelectionMode="Multiple" ondblclick="SecMoveOption(allSid, selectedSid)">
						</asp:ListBox>
						
					</td>
					<td class="EPEdit-tableColumn">
						
						<input class="button" style="width=5ex;" type="button" value=">" onclick="SecMoveOption(allSid, selectedSid)" language="javascript">
						<br />
						<input class="button" style="width=5ex;" type="button" value="<" onclick="SecMoveOption(selectedSid, allSid)" language="javascript">
					</td>
					<td align=center class="EPEdit-tableColumn">
						<img src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/SIDTypeLocalGroup.gif">
						<episerver:Translate Text="/admin/secedit/listmemberof" runat="server" id="Translate8" />
						<br />
						<asp:ListBox Runat="server" ID="SelectedSid" CssClass="FormNW" Rows="10"  style="width=35ex;" SelectionMode="Multiple" ondblclick="SecMoveOption(selectedSid, allSid)">
						</asp:ListBox>
					</td>
				</tr>
			</table>
		</asp:Panel>
	</asp:Panel>
</asp:Panel>

<script type="text/javascript">
	var selectedSid = document.getElementById('<%=SelectedSid.ClientID%>');
	var allSid = document.getElementById('<%=AllSid.ClientID%>');
</script>