<%@ Page language="c#" Codebehind="EditPanel.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Edit.EditPanel" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>EditPanel</title>
		<meta content="Microsoft Visual Studio 7.0" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<link href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css" type="text/css" rel="stylesheet">
		<script language="javascript" src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/system.js" type="text/javascript"></script>
		<script language="javascript" src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/edit.js" type="text/javascript"></script>
		<script language="javascript" src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/contextmenu.js" type="text/javascript"></script>

		<script language="javascript" type="text/javascript">
		<!--
		var currentSrc = window.location.protocol + '//' + window.location.host + '<%= PreviewUrl  %>';
		var fNewVer = <%= EPiServer.DataAccess.PageSaveDB.IsNewVersionRequired(CurrentPage, true) ? 1 : 0 %>;
		
		var baseUrl = '<%=IsNewPage ? "EditPanel.aspx?id=0&type=" + Request.QueryString["type"] + "&parent=" + Request.QueryString["parent"] + "&mode=" + Request.QueryString["mode"] : "EditPanel.aspx?id=" + CurrentPage.PageLink.ID + "&mode=" + Request.QueryString["mode"] + "&SelectedEditPanelTab=" + actionTab.SelectedTab%>';

		function onNavigate(newPageLink)
		{
			return -1;
		}
		
		function onCommand(newCommand)
		{
			return -1;
		}

		function previewNavigate( frame )
		{
			var error;
			var pageLink;
			var currentPageLink;
			var newLocation;
			
			try 
			{
				newLocation = frame.contentWindow.location;
				if (newLocation.href == currentSrc)
					return;
				currentPageLink = pageReferenceFromUrl(currentSrc);
				currentSrc = newLocation.href;
				pageLink = pageReferenceFromUrl(currentSrc);

				if (window.location.protocol != newLocation.protocol || 
					window.location.host != newLocation.host || 
					pageLink == null ||
					currentPageLink == pageLink)
					return;				
			}
			catch (error)
			{
				return;
			}

			this.parent.navigateEventEx(null, pageLink, currentSrc);
		}

		function pageReferenceFromUrl( src )
		{
			var pageLink;
		
			pageLink = extractPageReference(currentSrc, '?id=');
			if (pageLink == null)
				pageLink = extractPageReference(currentSrc, '____');
			if (pageLink == null)
				pageLink = extractPageReference(currentSrc, '&id=');
				
			return pageLink;
		}
		
		function extractPageReference( src, findStr )
		{
			var startPos = src.indexOf(findStr);
			if (startPos > 0)
			{
				var s = src.slice(startPos + findStr.length);
				if (s.indexOf('.') > 0)
					s = s.slice(0, s.indexOf('.'));
				if (s.indexOf('?') > 0)
					s = s.slice(0, s.indexOf('?'));
				if (s.indexOf('&') > 0)
					s = s.slice(0, s.indexOf('&'));
				return s;
			}
			return null;
		}
		
		function ChangeLanguageBranch(newLanguageBranch)
		{
			if(<%=IsNewPage ? "true" : "false"%>)
				document.forms[0].action = baseUrl + '&epslanguage=' + newLanguageBranch;
			else
				window.location.href = baseUrl + '&epslanguage=' + newLanguageBranch;
		}
		
		window.confirmNavigateMessage = '<%= TranslateForScript("/edit/editpanel/confirmnavigate") %>';

		// -->
		</script>
	</HEAD>
	<body class="EPEdit-panelBody" id="bodyTag" runat="server">
		<form id="EditPanel" method="post" runat="server">
			<input id="EPCurrentPageLink" type="hidden" runat="server" NAME="EPCurrentPageLink"/>
			<input id="EPIsNewPage" type="hidden" runat="server" NAME="EPIsNewPage"/>
			<input id="EPsLanguage" Runat="server" type="hidden" NAME="EPsLanguage"/>
			<input id="CompareToLanguageState" Runat="server" type="hidden" />
			
			<table height="100%" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr id="languageSelectorRow" runat="server">
					<td height="25">
						<!-- CUrrent language status: Page.PageLink=<%=CurrentPage.PageLink%> Page.LanguageBranch=<%=CurrentPage.LanguageBranch%> Page.LanguageID=<%=CurrentPage.LanguageID%> LanguageContext.Current.CurrentLanguageBranch=<%=EPiServer.Core.LanguageContext.Current.CurrentLanguageBranch%> LanguageContext.Current.CurrentUILanguageID=<%=EPiServer.Core.LanguageContext.Current.CurrentUILanguageID%>-->
						<div style="float:left;margin-right:15px;margin-top:5px;">
							<EPiServerSys:LanguageDropDownList LanguageSelection="AvailableOnCurrentPage" AutoSelectLanguage="True" JavascriptCallback="ChangeLanguageBranch" RenderBottomAligned="True" runat="server" />
						</div>
						<asp:Panel Runat="server" ID="CompareLanguageArea" style="float:left;margin-top:5px;" Visible="False">
							<span style="display:inline-block;vertical-align:top;margin-top:2px;margin-right:3px;"><episerver:translate Runat="server" Text="#compareto" /></span>
							<EPiServerSys:LanguageDropDownList LanguageSelection="ExistingOnCurrentPage" AutoSelectLanguage="False" RenderBottomAligned="True" runat="server" ID="CompareToLanguageSelection" />
						</asp:Panel>
					</td>
				</tr>
				<tr>
					<td class="EPEdit-EditPanelTitle" height="30">
						<asp:Label CssClass="EPEdit-pageName" id="PageName" runat="server" />
						<asp:Label CssClass="EPEdit-pageType" id="PageTypeName" runat="server" />
						<asp:Label CssClass="EPEdit-pageWorkStatus" ID="PageWorkStatus" Runat="server" />
					</td>
				</tr>
				<tr>
					<td vAlign="bottom" height="27">
						<EPiServerSys:tabstrip id="actionTab" runat="server" AutoPostBack="true" TargetID="tabView" SupportedPlugInArea="EditPanel" SelectedTabQueryString="SelectedEditPanelTab">
							<EPiServerSys:tab Text="#tabview" runat="server" id="PreviewTab"/>
						</EPiServerSys:tabstrip>
					</td>
				</tr>
				<tr>
					<td vAlign="top" height="*">
						<asp:panel id="tabView" runat="server">
							<asp:Panel id="PreviewPanel"  runat="server">
								<table width="100%" height="100%" cellspacing="0" cellpadding="0" border="0">
								<tr valign="top" height="1"><td>
									<EPiServerSys:CommandTool ImageUrl="~/Util/images/Tools/PublishTool.gif"	id="Publish"		Text="/button/publish" ToolTip="/edit/editpanel/tooltipapprove" runat="server"/>
									<EPiServerSys:CommandTool ImageUrl="~/Util/images/Tools/CheckinVersion.gif" id="CheckIn"		Text="/button/checkin" ToolTip="/edit/editpanel/tooltipcheckin" runat="server"/>
								</td></tr>
								<tr height="*"><td>
									<EPiServer:ControlLoader ID="PreviewFrame" runat="Server" Src="~/edit/PreviewControl.ascx" />
								</td></tr>
							</table>								
							</asp:Panel>
						</asp:panel>
					</td>
				</tr>
			</table>			
		</form>
	</body>
</HTML>
