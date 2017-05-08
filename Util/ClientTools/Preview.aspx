<%@ Page language="c#" Codebehind="Preview.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Util.ClientTools.Preview" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>Preview</title>
		<meta content="Microsoft Visual Studio 7.0" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<link href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css" type="text/css" rel="stylesheet">
		<style type="text/css">
		.EPEdit-CommandTool
		{
			behavior:url(<%=EPiServer.Global.EPConfig.RootDir%>Util/javascript/mouseover.htc);
			margin:1px;
		}
		</style>
		<script language="javascript" src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/system.js" type="text/javascript"></script>
		<script language="javascript" src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/edit.js" type="text/javascript"></script>
		<script language="javascript" type="text/javascript">
		<!--
		var currentSrc = window.location.protocol + '//' + window.location.host + '<%= PreviewUrl  %>';
		var fNewVer = <%= EPiServer.DataAccess.PageSaveDB.IsNewVersionRequired(CurrentPage, true) ? 1 : 0 %>;

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
			var newLocation;
			
			try 
			{
				newLocation = frame.contentWindow.location;
				if (newLocation.href == currentSrc)
					return;
				currentSrc = newLocation.href;

				if (window.location.protocol != newLocation.protocol || window.location.host != newLocation.host)
					return;				
			}
			catch (error)
			{
				return;
			}

			pageLink = extractPageReference(currentSrc, '?id=');
			if (pageLink == null)
				pageLink = extractPageReference(currentSrc, '____');
			if (pageLink == null)
				pageLink = extractPageReference(currentSrc, '&id=');
			if (pageLink != null)
				this.parent.navigateEventEx(null, pageLink, currentSrc);
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
		window.confirmNavigateMessage = '<%= TranslateForScript("/edit/editpanel/confirmnavigate") %>';

		// -->
		</script>
	</HEAD>
	<body class="EPEdit-panelBody" id="bodyTag" runat="server">
		<form id="EditPanel" method="post" runat="server">
			<input id="EPCurrentPageLink" type="hidden" runat="server" />
			<input id="EPIsNewPage" type="hidden" runat="server" />
			<input id="EPsLanguage" Runat="server" type="hidden" />
			<table height="100%" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td class="EPEdit-EditPanelTitle" height="30">
						<asp:Label CssClass="EPEdit-pageName" id="PageName" runat="server" />
						<asp:Label CssClass="EPEdit-pageType" id="PageTypeName" runat="server" />
						<asp:Label CssClass="EPEdit-pageWorkStatus" ID="PageWorkStatus" Runat="server" />
					</td>
				</tr>
				<tr>
					<td vAlign="top" height="*" colspan="2">
						<asp:Panel id="PreviewPanel"  runat="server">
							<table width="100%" height="100%" cellspacing="0" cellpadding="0" border="0">
							<tr valign="top" height="1"><td>
								<EPiServerSys:CommandTool ImageUrl="~/Util/images/Tools/PublishTool.gif"	id="Publish"		Text="/button/publish" ToolTip="/edit/editpanel/tooltipapprove" runat="server"/>
								<EPiServerSys:CommandTool ImageUrl="~/Util/images/Tools/CheckinVersion.gif" id="CheckIn"		Text="/button/checkin" ToolTip="/edit/editpanel/tooltipcheckin" runat="server"/>
								<EPiServerSys:CommandTool ImageUrl="~/Util/Images/PageRCA/quickedit.gif"	id="QuickEdit"		Text="/button/edit" ToolTip="/edit/editpanel/tooltipedit" runat="server"/>
								<EPiServerSys:CommandTool ImageUrl="~/Util/Images/Tools/DelTool.gif"		id="Delete"			Text="/button/cancel" ToolTip="/clienttools/preview/tooltipclose" runat="server"/>
							</td></tr>
							<tr height="*"><td>
								<iframe id="PreviewFrame" width="100%" height="100%" frameborder="0" style="border: solid black 1px;" Name="PreviewFrame" runat="server" />
							</td></tr>
						</table>								
						</asp:Panel>
					</td>
				</tr>
			</table>			
		</form>
	</body>
</HTML>
