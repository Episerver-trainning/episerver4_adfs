<%@ Page language="c#" Codebehind="NewsGroupTree.aspx.cs" AutoEventWireup="false" Inherits="development.Templates.NewsGroupTree" %>
<%@ Register TagPrefix="development" TagName="Header" Src="~/templates/units/header.ascx"%>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" > 

<html>
	<HEAD>
		<development:header ID="pageHeader" runat="server"></development:header>
	</HEAD>
  <body topmargin=0 leftmargin=0 marginheight=0 marginwidth=0 bgcolor="#FFFFFF">
    <form id="NewsGroupTree" method="post" runat="server">
		<a href="<%=((EPiServer.PageBase)Page).Configuration.RootDir%>" target="_parent">
		<img src="../images/news_logo.jpg" alt="EPiServer NewsGroup" class="borderless" /></a>
	<table border="0" cellspacing="0" cellpadding="0" width="100%">
		<tr>
			<td class="NewsGroupBarTitle" background="../images/bar_background.gif" valign=middle align=left>
				<EPiServer:Property PageLink=<%#NewsGroupRoot%> PropertyName="PageName" runat="server"/>&nbsp;&nbsp;&nbsp;
					<a class="Linklist" href="<%=EPiServer.Global.EPConfig.RootDir%>" target="_parent">
						<episerver:Translate Text="#back" runat="server" ID="Translate3" />
					</a>
			</td>
			<td background="../images/bar_background.gif" valign="top" align="left"><EPiServer:Clear width="5" height="26" runat="server" /></td>				
		</tr>
		<tr>
			<td colspan=2 height="1" valign=top align=left><EPiServer:Clear width="10" height="2" runat="server" /></td>
		</tr>
	</table>
	<table border="0" cellspacing="0" cellpadding="0" width="100%">
		</tr>
		<episerver:PageTree 
			runat="server" 
			id="Pagedatatree1"
			PageLink='<%#NewsGroupRoot%>'
		>
			<ItemTemplate>
				<tr>
					<td>
						<table cellpadding="0" cellspacing="0" border="0" bgcolor="#FFFFFF" width="100%">
							<tr>
								<td width="1" bgcolor="#F0F0F0"></td>
								<td class="MenuLink" valign="middle">
									<nobr>
										<EPiServer:Clear width='<%#(Container.CurrentPage.Indent - 1)*10%>' height="15" runat="server" />									
										<a class="MenuLink" href="NewsGroup.aspx?id=<%#Container.CurrentPage.PageLink%>" target="_parent">
											<img src="../images/<%# Container.CurrentPage["AllowNewsItem"]==null ? "newsgroup_item.gif" : "newsgroup_group.gif"%>" width="14" height="14" alt="" class="borderless" />
											<%#Container.CurrentPage.PageName%>
										</a>
									</nobr>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td width="100%" height="1" bgcolor="#F0F0F0"></td>
				</tr>
			</ItemTemplate>
			<SelectedItemTemplate>
				<tr>
					<td>
						<table cellpadding="0" cellspacing="0" border="0" bgcolor="#F0F0F0" width="100%">
							<tr>
								<td width="1" bgcolor="#F0F0F0"></td>
								<td class="MenuLink" valign="middle">
									<nobr>
										<EPiServer:Clear width='<%#(Container.CurrentPage.Indent - 1)*10%>' height="15" runat="server" />
										<a class="MenuLink" href="NewsGroup.aspx?id=<%#Container.CurrentPage.PageLink%>" target="_parent">
											<img src="../images/newsgroup_active.gif" width="14" height="14" alt="" class="borderless" />
											<%#Container.CurrentPage.PageName%>
										</a>
									</nobr>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td width="100%" height="1" bgcolor="#F0F0F0"></td>
				</tr>
			</SelectedItemTemplate>
			<TopTemplate>
				<tr>
					<td>
						<table cellpadding="0" cellspacing="0" border="0" bgcolor="#FFFFFF" width="100%">
							<tr>
								<td width="1" bgcolor="#F0F0F0"></td>
								<td class="MenuLink" valign="middle">
									<nobr>
										<EPiServer:Clear width='<%#(Container.CurrentPage.Indent - 1)*10%>' height="15" runat="server" />																			
										<a class="MenuLink" href="NewsGroup.aspx?id=<%#Container.CurrentPage.PageLink%>" target="_parent">
											<img src="../images/<%# Container.CurrentPage["AllowNewsItem"]==null ? "newsgroup_category.gif" : "newsgroup_group.gif"%>" width="14" height="14" alt="" class="borderless" />
											<%#Container.CurrentPage.PageName%>
										</a>
									</nobr>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td width="100%" height="1" bgcolor="#F0F0F0"></td>
				</tr>
			</TopTemplate>
		</episerver:PageTree>
		</table>
     </form>
  </body>
</html>
