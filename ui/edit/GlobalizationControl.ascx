<%@ Control Language="c#" AutoEventWireup="false" Codebehind="GlobalizationControl.ascx.cs" Inherits="EPiServer.Edit.GlobalizationControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
 <script type='text/javascript'>
	
	var currentID = <%=CurrentPage==null ? "null" : CurrentPage.PageLink.ID.ToString()%>;
	
	function onNavigate(newPageLink)
	{
		if(newPageLink!=currentID)
			UpdatePageLink(newPageLink);
	}
	function onCommand(newCommand)
	{
		UpdatePageLink(currentID);
	}
	function UpdatePageLink(newPageLink)
	{
		document.forms[0].action = 'ActionWindow.aspx?id=' + newPageLink + '&plugin=<%=Request.QueryString["plugin"]%>';
		<%=Page.GetPostBackClientEvent(RefreshButton,"")%>
	}
</script>
<b><asp:Literal ID="heading" Runat="server" /></b>
<br /><br />
<%#EPiServer.Global.EPLang.Translate("/edit/globalizationcontrol/description")%>
<br /><br />
<table class="pagelanguagestable">
	<asp:Repeater ID="list" Runat="server">
		<ItemTemplate>
			<asp:Panel Runat="server" Visible=<%#!IsLanguageCreated(Container.DataItem)%> ID="Panel1">
				<tr>
					<td>
						<a href="javascript:void(0);" onclick="window.parent.parent.commandEvent(window.parent.parent,new window.parent.parent.commandDescriptor('edit','<%#EPiServer.Global.EPConfig.RootDir + EPiServer.Global.EPConfig.EditDir + "EditPanel.aspx?id=" + CurrentPage.PageLink + "&epslanguage=" + DataBinder.Eval(Container.DataItem,"LanguageID")%>'))">
							<img src="<%#GetBranchIcon(Container.DataItem)%>" alt="" />
						</a>
					</td>
					<td>
						<a href="javascript:void(0);" onclick="window.parent.parent.commandEvent(window.parent.parent,new window.parent.parent.commandDescriptor('edit','<%#EPiServer.Global.EPConfig.RootDir + EPiServer.Global.EPConfig.EditDir + "EditPanel.aspx?id=" + CurrentPage.PageLink + "&epslanguage=" + DataBinder.Eval(Container.DataItem,"LanguageID")%>'))">
							<%#DataBinder.Eval(Container.DataItem,"Name")%>
						</a>
					</td>
					<td>
						<asp:Panel Visible=<%#CanEdit()%> Runat="server">
							<a href="javascript:void(0);" onclick="window.parent.parent.commandEvent(window.parent.parent,new window.parent.parent.commandDescriptor('edit','<%#EPiServer.Global.EPConfig.RootDir + EPiServer.Global.EPConfig.EditDir + "EditPanel.aspx?id=" + CurrentPage.PageLink + "&epslanguage=" + DataBinder.Eval(Container.DataItem,"LanguageID")%>'))">
								<%#EPiServer.Global.EPLang.Translate("/button/create")%>
							</a>
						</asp:Panel>
					</td>
				</tr>
			</asp:Panel>
			<asp:Panel Runat="server" Visible=<%#IsLanguageCreated(Container.DataItem)%>>
				<tr class="pagelanguagerow">
					<td>
						<a href="javascript:void(0);" onclick="window.parent.parent.commandEvent(window.parent.parent,new window.parent.parent.commandDescriptor('edit','<%#EPiServer.Global.EPConfig.RootDir + EPiServer.Global.EPConfig.EditDir + "EditPanel.aspx?id=" + CurrentPage.PageLink + "&epslanguage=" + DataBinder.Eval(Container.DataItem,"LanguageID")%>'))">
							<img src="<%#GetBranchIcon(Container.DataItem)%>" alt="" />
						</a>
					</td>
					<td>
						<a href="javascript:void(0);" onclick="window.parent.parent.commandEvent(window.parent.parent,new window.parent.parent.commandDescriptor('edit','<%#EPiServer.Global.EPConfig.RootDir + EPiServer.Global.EPConfig.EditDir + "EditPanel.aspx?id=" + CurrentPage.PageLink + "&epslanguage=" + DataBinder.Eval(Container.DataItem,"LanguageID")%>'))">
							<%#DataBinder.Eval(Container.DataItem,"Name")%>
						</a>
					</td>
					<td>
						<asp:Panel Visible=<%#CanEdit()%> Runat="server">
							<a href="javascript:void(0);" onclick="window.parent.parent.commandEvent(window.parent.parent,new window.parent.parent.commandDescriptor('edit','<%#EPiServer.Global.EPConfig.RootDir + EPiServer.Global.EPConfig.EditDir + "EditPanel.aspx?id=" + CurrentPage.PageLink + "&epslanguage=" + DataBinder.Eval(Container.DataItem,"LanguageID") + "&SelectedEditPanelTab=1"%>'))">
								<%#EPiServer.Global.EPLang.Translate("/edit/editpanel/tabedit/displayname")%>
							</a>
						</asp:Panel>
					</td>
				</tr>
				<tr class="pageinforow">
					<td>
					</td>
					<td colspan="2">
						<%#GetPageInfo(Container.DataItem)%>
					</td>
				</tr>
			</asp:Panel>
		</ItemTemplate>
	</asp:Repeater>
	<asp:Button ID="RefreshButton" Runat="server" Visible="False" />
</table>
