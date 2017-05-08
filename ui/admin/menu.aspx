<%@ Page language="c#" Codebehind="menu.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Admin.Menu" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
	<head>
		<title>menu</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<BASE target="ep_main">
		<link rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css">
		<script type='text/javascript' src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/system.js"></script>
	</head>
	<script type="text/javascript">
		function SortByIndex(a, b)
		{
			var aId = parseInt(a.id);
			var bId = parseInt(b.id);
			if (aId > bId)
			{
				return 1;
			}
			else if (aId == bId)
			{
				return 0;
			}
			else 
			{
				return -1;
			}
		}
		function SortByAlphabet(a, b)
		{
			if (a.innerText > b.innerText)
			{
				return 1;
			}
			else if (a.innerText == b.innerText)
			{
				return 0;
			}
			else 
			{
				return -1;
			}
		}
			
		function changeSortOrder(order)
		{
			var container = document.getElementById('PageTypeListDiv');
			var links = container.all('pLink');
			var linkArray = new Array();
			var sortFunction;

			for (i = 0; i < links.length; i++)
			{
				var link = new Object();
				link.innerText = links(i).innerText;
				link.id = links(i).id;
				link.href = links(i).href;
				linkArray.push(link);
			}

			switch (order)
			{
				case 'index':
					sortFunction = SortByIndex;
					document.getElementById('PageTypeIndexSorting').className	= 'EPEdit-CommandToolClicked';
					document.getElementById('PageTypeIndexSorting').style.cursor = 'default';
					document.getElementById('PageTypeAlphabeticalSorting').className = 'EPEdit-CommandTool';
					document.getElementById('PageTypeAlphabeticalSorting').style.border = '0px';
					document.getElementById('PageTypeAlphabeticalSorting').style.margin = '1px';
					break;
				case 'alphabetical':
					sortFunction = SortByAlphabet;
					document.getElementById('PageTypeAlphabeticalSorting').className = 'EPEdit-CommandToolClicked';
					document.getElementById('PageTypeAlphabeticalSorting').style.cursor = 'default';
					document.getElementById('PageTypeIndexSorting').className	= 'EPEdit-CommandTool';	
					document.getElementById('PageTypeIndexSorting').style.border = '0px';
					document.getElementById('PageTypeIndexSorting').style.margin = '1px';
					break;					
			}
			linkArray.sort(sortFunction);

			for (i = 0; i < linkArray.length; i++)
			{
				var link = linkArray[i];
				links(i).href = link.href;
				links(i).innerText = link.innerText;
				links(i).id = link.id;
			}
		}
	</script>
	<body class="EPEdit-treeBody">
		<form id="menu" method="post" runat="server">
			<EPiServerSys:tabstrip id="menuTab" runat="server" AutoPostBack="false" TargetID="tabView">
				<EPiServerSys:tab Text="/admin/menutabs/admin" runat="server" id="AdminTab"/>
				<EPiServerSys:tab Text="/admin/menutabs/config" runat="server" id="ConfigTab"/>
				<EPiServerSys:tab Text="/admin/menutabs/pagetypes" runat="server" id="PageTypeTab"/>
			</EPiServerSys:tabstrip>
			
			<asp:Panel id="tabView" runat="server">
				<asp:Panel id="adminPanel" Runat="server">
					<div class="EPAdmin-menuHeader">
						<img class="EPAdmin-menuIcon" src="<%=Configuration.RootDir%>util/images/adminmenu/Settings.gif" />
						<div class="EPAdmin-menuHeading"><episerver:Translate Text="/admin/menuheadings/systemadministration" runat="server" /></div>
					</div>
					<div class="EPAdmin-menuItems">
						<div class="EPAdmin-menuItem">
							<a href="CleanupUpload.aspx">
								<episerver:Translate Text="#cleanupupload" runat="server" />
							</a>
						</div>
						<div class="EPAdmin-menuItem">
							<a href="Categories.aspx">
								<episerver:Translate Text="#editcategories" runat="server" />
							</a>
						</div>
					</div>
					<div class="EPAdmin-menuHeader">
						<img class="EPAdmin-menuIcon" src="<%=Configuration.RootDir%>util/images/adminmenu/AccessRights.gif" />
						<div class="EPAdmin-menuHeading"><episerver:Translate Text="/admin/menuheadings/accessrights" runat="server" /></div>
					</div>
					<div class="EPAdmin-menuItems">
						<div class="EPAdmin-menuItem">
							<a href="security.aspx">
								<episerver:Translate Text="#setsecurity" runat="server" />
							</a>
						</div>
						<div class="EPAdmin-menuItem">
							<a href="AdminGroup.aspx">
								<episerver:Translate Text="#admingroups" runat="server" />
							</a>
						</div>
						<div class="EPAdmin-menuItem">
							<a href="SearchUsers.aspx">
								<episerver:Translate Text="#searchuser" runat="server" />
							</a>
						</div>
						<div class="EPAdmin-menuItem">
							<a href="EditUser.aspx">
								<episerver:Translate Text="#createuser" runat="server" />
							</a>
						</div>
					</div>
					<div class="EPAdmin-menuHeader">
						<img class="EPAdmin-menuIcon" src="<%=Configuration.RootDir%>util/images/adminmenu/ScheduledJobs.gif" />
						<div class="EPAdmin-menuHeading"><episerver:Translate Text="/admin/menuheadings/scheduledjobs" runat="server" /></div>
					</div>
					<div class="EPAdmin-menuItems">
						<asp:repeater Runat="server" ID="scheduledJobs">
							<ItemTemplate>
								<div class="EPAdmin-menuItem">
									<a href="DatabaseJob.aspx?id=<%# DataBinder.Eval(Container.DataItem, "ID") %>"
									class="EPAdmin-menuItem">
										<%# DataBinder.Eval(Container.DataItem, "DisplayName") %>
									</a>
								</div>
							</ItemTemplate>
						</asp:repeater>
						<asp:Placeholder Runat="server" ID="NoScheduledJobsInfo" Visible="False">
							<div class="EPAdmin-menuItem">
								<episerver:Translate Text="/admin/menuheadings/noscheduledjobstext" runat="server" />
							</div>
						</asp:Placeholder>
					</div>
					<div class="EPAdmin-menuHeader">
						<img class="EPAdmin-menuIcon" src="<%=Configuration.RootDir%>util/images/adminmenu/Tools.gif" />
						<div class="EPAdmin-menuHeading"><episerver:Translate Text="/admin/menuheadings/tools" runat="server" /></div>
					</div>
					<div class="EPAdmin-menuItems">
						<asp:repeater Runat="server" ID="plugInList">
							<ItemTemplate>
								<div class="EPAdmin-menuItem">
									<a href="<%# ResolveUrl((string)DataBinder.Eval(Container.DataItem, "Url")) %>"
									class="EPAdmin-menuItem">
									<%# DataBinder.Eval(Container.DataItem, "DisplayName") %>
									</a>
								</div>
							</ItemTemplate>
						</asp:repeater>
						<asp:Placeholder Runat="server" ID="NoToolsInfo" Visible="False">
							<div class="EPAdmin-menuItem">
								<episerver:Translate Text="/admin/menuheadings/notoolstext" Runat="server" />
							</div>
						</asp:Placeholder>
					</div>
				</asp:Panel>
				
				<asp:Panel id="configPanel" Runat="server">
					<div class="EPAdmin-menuHeader">
						<img class="EPAdmin-menuIcon" src="<%=Configuration.RootDir%>util/images/adminmenu/Settings.gif" />
						<div class="EPAdmin-menuHeading"><episerver:Translate Text="/admin/menuheadings/systemconfiguration" runat="server" /></div>
					</div>
					<div class="EPAdmin-menuItems">
						<div class="EPAdmin-menuItem">
							<a href="settings.aspx">
								<episerver:Translate Text="#settings" runat="server" />
							</a>
						</div>
						<div class="EPAdmin-menuItem">
							<a href="License.aspx">
								<episerver:Translate Text="#license" runat="server" />
							</a>
						</div>
						<div class="EPAdmin-menuItem">
							<a href="RebuildLinks.aspx">
								<episerver:Translate Text="#rebuildlinks" runat="server" />
							</a>
						</div>
						<div class="EPAdmin-menuItem">
							<a href="RobotSearch.aspx">
								<episerver:Translate Text="#robotsearch" runat="server" />
							</a>
						</div>
						<div class="EPAdmin-menuItem">
							<a href="Frames.aspx">
								<episerver:Translate Text="#editframes" runat="server" />
							</a>
						</div>
						<div class="EPAdmin-menuItem">
							<a href="Languages.aspx">
								<episerver:Translate Text="#editlanguages" runat="server" />
							</a>
						</div>
						<div class="EPAdmin-menuItem">
							<a href="EditlanguageBranches.aspx">
								<episerver:Translate Text="#editlanguagebranches" runat="server" />
							</a>
						</div>
						<div class="EPAdmin-menuItem">
							<a href="RemoteSite.aspx">
								<episerver:Translate Text="#editremotesite" runat="server" />
							</a>
						</div>
						<div class="EPAdmin-menuItem">
							<a href="backup.aspx" runat="server" id="BackupMenuItem">
								<episerver:Translate Text="#backup" runat="server" />
							</a>
						</div>
					</div>
					<div class="EPAdmin-menuHeader">
						<img class="EPAdmin-menuIcon" src="<%=Configuration.RootDir%>util/images/adminmenu/Security.gif" />
						<div class="EPAdmin-menuHeading"><episerver:Translate Text="/admin/menuheadings/security" runat="server" /></div>
					</div>
					<div class="EPAdmin-menuItems">
						<div class="EPAdmin-menuItem">
							<a href="Permission.aspx">
								<episerver:Translate Text="#setpermission" runat="server" />
							</a>
						</div>
						<div class="EPAdmin-menuItem">
							<a href="RegistrationSettings.aspx">
								<episerver:Translate Text="#defaultgroup" runat="server" />
							</a>
						</div>
					</div>
					<div class="EPAdmin-menuHeader">
						<img class="EPAdmin-menuIcon" src="<%=Configuration.RootDir%>util/images/adminmenu/ToolSettings.gif" />
						<div class="EPAdmin-menuHeading"><episerver:Translate Text="/admin/menuheadings/toolsettings" runat="server" /></div>
					</div>
					<div class="EPAdmin-menuItems">
						<asp:repeater Runat="server" ID="plugInSettingsList">
							<ItemTemplate>
								<div class="EPAdmin-menuItem">
									<a href="<%# ResolveUrl((string)DataBinder.Eval(Container.DataItem, "Url")) %>"
									class="EPAdmin-menuItem">
									<%# DataBinder.Eval(Container.DataItem, "DisplayName") %>
									</a>
								</div>
							</ItemTemplate>
						</asp:repeater>
						<asp:Placeholder Runat="server" ID="NoToolSettingsInfo" Visible="False">
							<div class="EPAdmin-menuItem">
								<episerver:Translate Text="/admin/menuheadings/notoolsettingstext" Runat="server" />
							</div>
						</asp:Placeholder>
					</div>
				</asp:Panel>
				
				<asp:Panel id="pageTypePanel" Runat="server">
					<div class="EPAdmin-menuHeader">
						<img class="EPAdmin-menuIcon" src="<%=Configuration.RootDir%>util/images/adminmenu/Settings.gif" />
						<div class="EPAdmin-menuHeading"><episerver:Translate Text="/admin/menuheadings/generalsettings" runat="server" /></div>
					</div>
					<div class="EPAdmin-menuItems">
						<div class="EPAdmin-menuItem">
							<a href="Tabs.aspx">
								<episerver:Translate Text="#editheadings" runat="server" />
							</a>
						</div>
					</div>
					<div class="EPAdmin-menuHeader">
						<img class="EPAdmin-menuIcon" src="<%=Configuration.RootDir%>util/images/adminmenu/ManagePageTypes.gif" />
						<div class="EPAdmin-menuHeading"><episerver:Translate Text="/admin/menuheadings/managepagetypes" runat="server" /></div>
					</div>
					<div class="EPAdmin-menuItems">
						<div class="EPAdmin-menuItem">
							<a href="EditPageTypeBase.aspx?id=0">
								<episerver:Translate Text="#newpagetype" runat="server" />
							</a>
						</div>
						<div class="EPAdmin-menuItem">
							<a href="CopyPageType.aspx">
								<episerver:Translate Text="#copypagetype" runat="server" />
							</a>
						</div>
						<div class="EPAdmin-menuItem">
							<a href="PageDefinitionType.aspx">
								<episerver:Translate Text="#datatypes" runat="server" />
							</a>
						</div>
						<div class="EPAdmin-menuItem">
							<a href="EditDynProp.aspx">
								<episerver:Translate Text="#editdynamicproperty" runat="server" />
							</a>
						</div>
					</div>
					<div class="EPAdmin-menuHeader">
						<img class="EPAdmin-menuIcon" src="<%=Configuration.RootDir%>util/images/adminmenu/PageTypes.gif" />
						<div class="EPAdmin-menuHeading"><episerver:Translate Text="/admin/menuheadings/pagetypes" runat="server" /></div>
						<div class="EPAdmin-menuPageTypeSorting">
							<asp:Placeholder Runat="server" ID="PageTypeSorting" Visible="True">
								<img id="PageTypeIndexSorting" 
									class="EPEdit-CommandToolClicked" valign="absmiddle"
									src="<%=Configuration.RootDir%>util/images/adminmenu/IndexSort.gif"
									title="<%=EPiServer.Global.EPLang.Translate("/admin/menuheadings/pagetypesorting/sortbyindex")%>"
									onclick="changeSortOrder('index')" />
								<img id="PageTypeAlphabeticalSorting" 
									class="EPEdit-CommandTool" valign="absmiddle"
									src="<%=Configuration.RootDir%>util/images/adminmenu/AlphabeticalSort.gif"
									title="<%=EPiServer.Global.EPLang.Translate("/admin/menuheadings/pagetypesorting/sortalphabetically")%>" 
									onclick="changeSortOrder('alphabetical')" />
							</asp:Placeholder>									
						</div>
					</div>
					<div class="EPAdmin-menuItems">
						<div id="PageTypeListDiv">
							<asp:repeater Runat="server" ID="PageTypeList">
								<ItemTemplate>
									<div class="EPAdmin-menuItem">
										<a name="pLink" id="<%# DataBinder.Eval(Container.DataItem, "SortOrder")%>"
										href="EditPageType.aspx?id=<%# DataBinder.Eval(Container.DataItem, "ID") %>">
											<%# DataBinder.Eval(Container.DataItem, "Name") %>
										</a>
									</div>
								</ItemTemplate>
							</asp:repeater>
						</div>
						<asp:Placeholder Runat="server" ID="NoPageTypesInfo" Visible="False">
							<div class="EPAdmin-menuItem">
								<episerver:Translate Text="/admin/menuheadings/nopagetypestext" Runat="server" />
							</div>
						</asp:Placeholder>
					</div>
				</asp:Panel>
				
			</asp:Panel>

		</form>
	</body>
</html>
