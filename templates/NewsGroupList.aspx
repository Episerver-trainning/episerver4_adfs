<%@ Page language="c#" Codebehind="NewsGroupList.aspx.cs" AutoEventWireup="false" Inherits="development.Templates.NewsGroupList" %>
<%@ Register TagPrefix="development" TagName="Header" Src="~/templates/units/header.ascx"%>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" > 
<html>
  <head>
    <development:header ID="pageHeader" runat="server" />
  </head>
  <body class="NewsGroupList" topmargin=0 leftmargin=0 marginheight=0 marginwidth=0 bottommargin=0>
    <form id="NewsGroupList" method="post" runat="server">
		<table cellpadding="0" cellspacing="0" border="0" width="100%">
			<tr>
				<td class="NewsgroupBarTitle" background="../images/bar_background.gif" valign="middle" align="left">&nbsp;&nbsp;<EPiServer:Property PageLink=<%#CurrentNewsGroup%> PropertyName="PageName" runat="server"/></td>
				<td background="../images/bar_background.gif" valign="top" align="right">
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
							<td valign="top" align="left"><img src="../images/bar_separator_button.gif" alt="" class="borderless" /></td>
							<td valign="middle" align="center" runat="server" id="CreateEntry"><a class="NewsgroupBarButton" href="NewsGroupItem.aspx?parent=<%=CurrentNewsGroup%>&type=<%=ItemPageType%>" target="NewsItem"><episerver:translate Text="#newpost" runat="server" ID="Translate3" /></a></td>
							<td valign="top" align="left"><img src="../images/bar_separator_button.gif" class="borderless" alt="" /></td>
							<asp:panel id="PersonalSettings" runat="server">
							<td valign="middle" align="center"><a class="NewsgroupBarButton" href="NewsGroupSettings.aspx" target="NewsItem"><episerver:translate Text="#settings" runat="server" ID="Translate11" /></a></td>
							<td valign="top" align="left"><img src="../images/bar_separator_button.gif" alt="" class="borderless" /></td>
							<td valign="middle" align="center"><asp:LinkButton id="Subscribe" runat="server" Class="NewsgroupBarButton" OnClick="ChangeSubscribtion"/></a></td>
							<td valign="top" align="left"><img src="../images/bar_separator_button.gif" alt="" class="borderless" /></td>
							</asp:panel>
							<td valign="middle" align="center"><a class="NewsgroupBarButton" href="NewsGroupSearch.aspx?id=<%=NewsGroupRoot%>" target="NewsGroupView"><episerver:translate Text="#search" runat="server" ID="Translate12" /></a></td>
							<td valign="top" align="left"><img src="../images/bar_separator.gif" alt="" class="borderless" /></td>
							<td valign="top" align="left"><EPiServer:Clear width="10" height="26" runat="server" /></td>					
						</tr>
					</table>
				</td>		
			</tr>
		</table>
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
			<tr>
				<td background="../images/heading_background.gif" class="NewsgroupTableheading" valign="middle" align="left"><episerver:translate Text="#subject" runat="server" ID="Translate5" /></td>
				<td background="../images/heading_background.gif" class="NewsgroupTableheading" valign="middle" align="left"><episerver:translate Text="#author" runat="server" ID="Translate6" /></td>
				<td background="../images/heading_background.gif" class="NewsgroupTableheading" valign="middle" align="left"><episerver:translate Text="#created" runat="server" ID="Translate7" /></td>										
			</tr>
			<tr>
				<td colspan="3" bgcolor="#333333"><EPiServer:Clear runat="server" /></td>
			</tr>
			
			<episerver:PageTree 
			runat="server" 
			id="Pagedatatree1"
			PageLink=<%#CurrentNewsGroup%>
			EnableVisibleInMenu="false"
			ExpandAll="True"
			>
				<ItemTemplate>
					<tr class="NewsGroupRow">
						<td>
							<EPiServer:Clear width='<%#(Container.CurrentPage.Indent - 1)*10%>' runat="server" />
							<a class="MenuLink" href="NewsGroupItem.aspx?id=<%#Container.CurrentPage.PageLink%>" target="NewsItem"><%#Container.CurrentPage.Property["PageName"].ToWebString()%></a>
						</td>
						<td>
							<%#Container.CurrentPage.Property["WriterName"].ToWebString()%>
							<%#Container.CurrentPage["WriterEmail"] != null?"&lt;":""%><%#Container.CurrentPage.Property["WriterEmail"].ToWebString()%><%#Container.CurrentPage["WriterEmail"] != null?"&gt;":""%>
						</td>
						<td>
							<episerver:property runat="server" PropertyName="PageStartPublish"/>
						</td>
					</tr>
					<tr>
						<td colspan="3" background="../images/dotline.gif"><EPiServer:Clear runat="server" /></td>
					</tr>
				</ItemTemplate>
				<SelectedItemTemplate>
					<tr class="NewsGroupRowActive">
						<td>
							<EPiServer:Clear width='<%#(Container.CurrentPage.Indent - 1)*10%>' runat="server" />
							<a class="MenuLink" href="NewsGroupItem.aspx?id=<%#Container.CurrentPage.PageLink%>" target="NewsItem"><%#Container.CurrentPage.Property["PageName"].ToWebString()%></a>
						</td>
						<td>
							<%#Container.CurrentPage.Property["WriterName"].ToWebString()%>
							<%#Container.CurrentPage["WriterEmail"] != null?"&lt;":""%><%#Container.CurrentPage.Property["WriterEmail"].ToWebString()%><%#Container.CurrentPage["WriterEmail"] != null?"&gt;":""%>
						</td>
						<td>
							<episerver:property runat="server" PropertyName="PageStartPublish"/>
						</td>
					</tr>
					<tr>
						<td colspan="3" background="../images/dotline.gif"><EPiServer:Clear runat="server" /></td>
					</tr>
				</SelectedItemTemplate>
				
				<SelectedTopTemplate>
					<tr class="NewsGroupRowActive">
						<td>
							<EPiServer:Clear width="<%#(Container.CurrentPage.Indent - 1)*10%>" runat="server" />
							<a class="MenuLink" href="NewsGroupItem.aspx?id=<%#Container.CurrentPage.PageLink%>" target="NewsItem"><%#Container.CurrentPage.Property["PageName"].ToWebString()%></a>
						</td>
						<td>
							<%#Container.CurrentPage.Property["WriterName"].ToWebString()%>
							<%#Container.CurrentPage["WriterEmail"] != null?"&lt;":""%><%#Container.CurrentPage.Property["WriterEmail"].ToWebString()%><%#Container.CurrentPage["WriterEmail"] != null?"&gt;":""%>
						</td>
						<td>
							<episerver:property runat="server" PropertyName="PageStartPublish" ID="Property1" NAME="Property1"/>
						</td>
					</tr>
					<tr>
						<td colspan="3" background="../images/dotline.gif"><EPiServer:Clear runat="server" /></td>
					</tr>
				</SelectedTopTemplate>
			</episerver:PageTree>
		</table>
     </form>
  </body>
</html>
