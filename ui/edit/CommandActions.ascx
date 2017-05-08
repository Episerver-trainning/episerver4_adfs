<%@ Control Language="c#" AutoEventWireup="false" Codebehind="CommandActions.ascx.cs" Inherits="EPiServer.Edit.CommandActions"%>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<table cellpadding=0 cellspacing=0 border="0">
	<tr>
		<td><EPiServerSys:CommandTool runat="server" id="NewCommandTool"									CommandName="new"				ImageUrl="~/util/images/tools/NewTool.gif"				ToolTip="#createnewpagehelp"	NavigateUrl="~/edit/NewPage.aspx"  /></td>
		<td><img src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/command_toolseparator.gif"></td>
		<td><EPiServerSys:CommandTool runat="server" id="CutCommandTool"		RequiredAccess="Delete"		CommandName="cutpage"			ImageUrl="~/util/images/tools/CutTool.GIF"				ToolTip="#cutpagehelp" /></td>
		<td><EPiServerSys:CommandTool runat="server" id="CopyCommandTool"		RequiredAccess="Read"		CommandName="copypage"			ImageUrl="~/util/images/tools/CopyTool.GIF"			ToolTip="#copypagehelp" /></td>
		<td><EPiServerSys:CommandTool runat="server" id="PasteCommandTool"		RequiredAccess="Create"		CommandName="pastepage"			ImageUrl="~/util/images/tools/PasteTool.gif"			ToolTip="#pastepagehelp"		Available="False" /></td>
		<td><EPiServerSys:CommandTool runat="server" id="DeleteCommandTool"		RequiredAccess="Delete"		CommandName="deletepage"		ImageUrl="~/util/images/tools/DelTool.GIF"				ToolTip="#deletepagehelp"		NavigateUrl="~/edit/DeletePage.aspx" /></td>
		<td><img src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/command_toolseparator.gif"></td>
		<td><EPiServerSys:CommandTool runat="server" id="DynPropCommandTool"	RequiredAccess="Administer"	CommandName="dynamicproperties"	ImageUrl="~/util/images/tools/EditDynPropTool.gif"		ToolTip="#editdynprophelp"		NavigateUrl="~/edit/EditDynProp.aspx"  /></td>
		<td><EPiServerSys:CommandTool runat="server" id="SecurityCommandTool"	RequiredAccess="Administer"	CommandName="security"			ImageUrl="~/util/images/tools/AclTool.GIF"				ToolTip="#setaccesshelp"		NavigateUrl="~/edit/EditSecurity.aspx"  /></td>
		<td><img src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/command_toolseparator.gif"></td>
		<td><EPiServerSys:CommandTool runat="server" id="ActionWindowCommandTool"							CommandName="toggleactionwindow" ImageUrl="~/util/images/tools/ActionWindowTool.gif"	ToolTip="#actionwindowhelp"		NavigateUrl="" /></td>
		<td><EPiServerSys:CommandTool runat="server" id="FileManagementTool"									CommandName="toggleactionwindow"	ImageUrl="~/util/images/tools/FileManagementTool.gif"		ToolTip="#filemanagementhelp" NavigateUrl="" /></td>
		<asp:PlaceHolder Runat="server" ID="ExtendedDisplayRowBreak">	
			</tr>
		</table>
		<table cellpadding=0 cellspacing=0 border="0" width="100%" class="EPEdit-commandRowSep">
			<tr height="6">
				<td><img src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/command_toolrowseparator.gif"></td>
			</tr>
		</table>
		<table cellpadding=0 cellspacing=0 border="0">
			<tr>
		</asp:PlaceHolder>
		<asp:PlaceHolder Runat="server" ID="ExtendedDisplaySettingsCommandTool">	
			<td><EPiServerSys:CommandTool runat="server" id="SettingsCommandTool"									CommandName="settings"	ImageUrl="~/util/images/tools/SettingsTool.gif"			ToolTip="#settingshelp"		NavigateUrl="~/edit/workspace.aspx?SelectedTabName=SettingsTab"  /></td>
			<td><img src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/command_toolseparator.gif"></td>
		</asp:PlaceHolder>
		<td><EPiServerSys:CommandTool runat="server" id="AdminCommandTool"									CommandName="administration"	ImageUrl="~/util/images/tools/AdminTool.gif"			ToolTip="#adminmodehelp"		NavigateUrl="~/admin/default.aspx"  /></td>
		<asp:PlaceHolder Runat="server" ID="ExtendedDisplayViewCommandTool">	
			<td><EPiServerSys:CommandTool runat="server" id="ViewCommandTool"									CommandName="view"	ImageUrl="~/util/images/tools/ViewTool.gif"			ToolTip="#viewmodehelp" /></td>
		</asp:PlaceHolder>
		<td><EPiServerSys:HelpButton ToolTip="/button/help" runat="server" id="CommandTool7" /></td>			
		<asp:PlaceHolder Runat="server" ID="ExtendedDisplayLogoutCommandTool">	
			<td><EPiServerSys:CommandTool runat="server" id="LogoutCommandTool"							CommandName="logout" ImageUrl="~/util/images/tools/LogoutTool.gif"	ToolTip="#logouthelp" /></td>
		</asp:PlaceHolder>
		<asp:PlaceHolder Runat="server" ID="ExtendedDisplayGlobalizationCommandTools">	
			<td><img src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/command_toolseparator.gif"></td>
			<td><EPiServerSys:CommandTool runat="server" id="LanguagePageCommandTool"									CommandName="toggleactionwindow"	ImageUrl="~/util/images/tools/LanguagePageTool.gif"		ToolTip="#languagepagehelp" NavigateUrl="" /></td>
			<td><EPiServerSys:CommandTool runat="server" id="LanguageOverviewCommandTool"									CommandName="languageoverview"	ImageUrl="~/util/images/tools/LanguageOverviewTool.gif"		ToolTip="#languageoverviewhelp" NavigateUrl="~/edit/GlobalizationMatrix.aspx" /></td>
			<td><EPiServerSys:CommandTool runat="server" id="LanguageSettingsCommandTool"									CommandName="languagesettings"	ImageUrl="~/util/images/tools/LanguageSettingsTool.gif"		ToolTip="#languagesettingshelp" NavigateUrl="~/edit/LanguageSettings.aspx" /></td>
		</asp:PlaceHolder>
	</tr>
</table>