<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<%@ Page language="c#" Codebehind="EditTree.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Edit.EditTree" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>EditTree</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<link rel="stylesheet" type="text/css" href="<%=Configuration.RootDir%>util/styles/system.css">
		<script type='text/javascript' src="<%=Configuration.RootDir%>util/javascript/system.js"></script>
		<script type='text/javascript' src="<%=Configuration.RootDir%>util/javascript/edit.js"></script>
		<script type='text/javascript' src="<%=Configuration.RootDir%>util/javascript/draganddrop.js"></script>
		<script type='text/javascript'>
		<!--
		var pageCopied	= null;
		var pageCut		= null;
		
		window.attachEvent("onload",RegisterDragAndDrop);
		window.StartPage = <%=Configuration.StartPage.ID%>;
		window.RootPage = <%=Configuration.RootPage.ID%>;
		window.WastebasketPage = <%=Configuration.Wastebasket.ID%>;
		window.dragAndCopyText = '<%=TranslateForScript("#copypage")%>';
		window.dragAndMoveText = '<%=TranslateForScript("#movepage")%>';
		
		function window.ondroppage(source,destination,copy)
		{
			if(copy)
			{
				var cmd = new commandDescriptor('copyandpastepage','',source.toString() + ';' + destination.toString());
				window.parent.commandEvent( window, cmd );		
			}
			else
			{
				if(destination == window.WastebasketPage)
				{
					window.parent.setLatestNavigate(source);
					var deletePageLink = '<%=Configuration.RootDir + Configuration.EditDir%>DeletePage.aspx';
					window.parent.commandEvent(window, new window.parent.commandDescriptor('deletepage',deletePageLink));
				}
				else
				{
					if (!confirm('<%= TranslateForScript("/edit/editcommand/askmove") %>'))
						return;
					var cmd = new commandDescriptor('cutandpastepage','',source.toString() + ';' + destination.toString());
					window.parent.commandEvent( window, cmd );
				}		
			}
		}
		
		function onNavigate(newPageLink)
		{
			window.location.href = GetUrl(newPageLink);
			return 0;
		}
		
		function GetUrl(newPageLink)
		{
			return 'EditTree.aspx?id=' + newPageLink + '<%=actionTab.SelectedTab==1 ? "&TabID=1" : ""%>';
		}
		
		function onCommand(newCommand)
		{
			switch(newCommand.command)
			{
				case 'pagechildrendeleted':
					ExplorerTreeClear(newCommand.data);
					break;
				case 'pagedeleted':
					ExplorerTreeDelete(newCommand.data, newCommand.navData);
					break;
				case 'pagecreated':
					ExplorerTreeExpand(newCommand.data);
					break;
				case 'copypage':
					ClearCutAndCopy();
					pageCopied = newCommand.data;
					ExplorerTreeSetIcon(newCommand.data,'<%=Configuration.RootDir%>Util/images/copypage.gif');
					break;
				case 'cutpage':
					ClearCutAndCopy();
					pageCut = newCommand.data;
					ExplorerTreeSetIcon(newCommand.data,'<%=Configuration.RootDir%>Util/images/cutpage.gif');
					break;
				case 'clearpage':
					ClearCutAndCopy();
					break;
				case 'pastepage':
					ClearCutAndCopy();
					ExplorerTreeSelect(newCommand.data);
					break;
				case 'pagechanged':
					ExplorerTreeRefresh(newCommand.data);
					break;
				case 'newlanguagebranch':
					window.location.href = 'SwitchLanguage.aspx?language=' + newCommand.data + '&returnUrl=' + encodeURIComponent(GetUrl(window.parent.latestNavigate));
					break;
			}
			
			return 0;
		}
		
		function ClearCutAndCopy()
		{
			if(pageCopied!=null)
				ExplorerTreeSetIcon(pageCopied,'<%=Configuration.RootDir%>Util/images/ExplorerTree/blank.gif');
			if(pageCut!=null)
				ExplorerTreeSetIcon(pageCut,'<%=Configuration.RootDir%>Util/images/ExplorerTree/blank.gif');
			
			pageCopied	= null;
			pageCut		= null;
		}
		function ExternalDispatcher(eventType)
		{
			if(eventType == 'A.contextmenu')
			{
				currentACL = parseInt(event.srcElement.PageAcl);
				ExplorerTreeSelect(event.srcElement);
				window.parent.setLatestNavigate(event.srcElement.PageLink);
				<%=Menu.ClientID%>.Show();
			}
			
			return false;
		}
		function LoadPage(pageLink)
		{
			if (pageLink == window.WastebasketPage)
			{
				window.parent.commandEvent(window, new window.parent.commandDescriptor('systempagenavigate','<%=WastebasketPageLink%>',pageLink));
			}
			else if (pageLink == window.RootPage)
			{
				window.parent.commandEvent(window, new window.parent.commandDescriptor('systempagenavigate','<%=RootPageLink%>',pageLink));
			}
			else
			{
				var containerObj = document.all['page#' + pageLink];
				while (containerObj && containerObj.HostUrl == null)
				{
					containerObj = ExplorerTreeFindParent(containerObj);
				}
				if (containerObj != null)
				{
					window.top.navigate(containerObj.HostUrl + '<%=Configuration.RootDir.Substring(1) + Configuration.EditDir%>default.aspx?id=' + pageLink);
					return;
				}
				window.parent.navigateEvent(window, pageLink);
				return;
			}
			window.parent.setLatestNavigate( pageLink );
		}
		// -->
		</script>
	</HEAD>
	<body class="EPEdit-treeBody" OnLoad="useTreeRCA = true;">
		<form id="EditTree" method="post" runat="server">
			<input type="hidden" id="latestNavigate" runat="server" NAME="latestNavigate"/>
			<EPiServerSys:tabstrip id="actionTab" runat="server" AutoPostBack="true" TargetID="tabView" SupportedPlugInArea="EditTree">
				<EPiServerSys:tab Text="/edit/editcommand/viewmode"		runat="server"	id="PreviewTab"/>
				<EPiServerSys:tab Text="/edit/editcommand/favoritesmode" runat="server"	id="CustomViewMode"/>
				<EPiServerSys:tab Text="/edit/editcommand/personalmode"	runat="server"	id="PropertiesTab"/>
			</EPiServerSys:tabstrip>
			<asp:Label ID="tabView" Runat="server">
				<asp:label Runat="server">
					<episerver:ExplorerTree ShowToolTip="True" ShowACL="True" ShowStatusIcons="True" EnableVisibleInMenu="False" PublishedStatus="Ignore" ShowIcons="True" ShowRootPage="True" ClickScript="LoadPage('{PageLink}');" id="ExplorerTree" runat="server" />
					<asp:Button ID="SaveShortcutButton" OnCommand="SaveShortcutClick" Runat="server" Visible="False"/>
				</asp:label>
				<asp:label Runat="server">
					<asp:PlaceHolder Runat="server" ID="CustomExplorerTreePanel"/>
					<asp:Button ID="DeleteShortcutButton" OnCommand="DeleteShortcutClick" Runat="server" Visible="False"/>
				</asp:Label>
				<asp:label Runat="server">
					<episerversys:personalactivity NoActivitiesMessage="#notasksfound" ClickScript="window.parent.navigateEvent(window, '{PageLink}');" runat="server" id="PersonalActivity" />
				</asp:label>
			</asp:Label>
		</form>
	</body>
</HTML>
