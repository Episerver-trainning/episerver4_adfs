<%@ Page language="c#" Codebehind="NewsGroupItem.aspx.cs" AutoEventWireup="false" Inherits="development.Templates.NewsGroupItem" %>
<%@ Register TagPrefix="development" TagName="Header" Src="~/templates/units/header.ascx"%>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" > 

<html>
  <head>
	<development:header ID="pageHeader" runat="server" />
  </head>
  <body class="NewsGroupItem" topmargin="0" leftmargin="0" marginheight="0" marginwidth="0">
	
    <form id="NewsGroupItem" method="post" runat="server">
		<asp:panel runat="server" id="TableHeader" Visible="false">
		<table cellpadding="0" cellspacing="0" border="0" width="100%">
			<tr>
				<td background="../images/bar_background.gif" valign="top" align="right">
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
							<td background valign="top" align="left"><img src="../images/bar_separator_button.gif" class="borderless" alt="" /></td>
							<asp:Panel id="Answer" runat="server" Visible="false">
								<td background valign="middle" align="center"><a class="NewsgroupBarButton" href="NewsGroupItem.aspx?parent=<%=CurrentPageLink%>&amp;type=<%=ItemPageType%>&amp;pagename=<%=Server.UrlEncode(CurrentPage.PageName)%>"><episerver:translate Text="#reply" runat="server" ID="Translate1" /></a></td>
								<td background valign="top" align="left"><img src="../images/bar_separator_button.gif" class="borderless" alt="" /></td>
								<td background valign="middle" align="center"><asp:LinkButton id="Subscribe" runat="server" Class="NewsgroupBarButton" OnClick="ChangeSubscribtion" /></a></td>
								<td background valign="top" align="left"><img src="../images/bar_separator.gif" class="borderless" alt="" /></td>
								<td background valign="top" align="left"><EPiServer:Clear width="10" height="26" /></td>					
							</asp:Panel>
						</tr>
					</table>
				</td>		
			</tr>
		</table>
		</asp:panel>
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
			<tr>
				<td style="padding:5px;" background="../images/heading_background.gif" valign="bottom" align="left">
				<table cellpadding="0" cellspacing="0" border="0">
					<tr>
						<td class="NewsgroupItemHeading" valign="top" align="right"><episerver:translate Text="#name" runat="server" />:&nbsp;</td>
						<td class="NewsgroupItemHeading2" valign="top" align="left">
							<episerver:property id="WriterName" propertyname="WriterName" runat="server" />
						</td>
					</tr>
					<tr>
						<td class="NewsgroupItemHeading" valign="top" align="right"><episerver:translate Text="#email" runat="server" />:&nbsp;</td>
						<td class="NewsgroupItemHeading2" valign="top" align="left">
							<episerver:property id="WriterEmail" propertyname="WriterEmail" runat="server" />
							</td>
					</tr>
					<tr>
						<td class="NewsgroupItemHeading" valign="top" align="right"><episerver:translate Text="#subject" runat="server" />:&nbsp;</td>
						<td class="NewsgroupItemHeading2" valign="top" align="left">
							<episerver:property id="PageName" propertyname="PageName" runat="server" />
						</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td bgcolor="#FFFFFF"><EPiServer:Clear runat="server" /></td>
			</tr>				
		</table>
		<div style="margin-left: 10px;">
			<episerver:property id="pageBody" class="NewsGroupItemMessage" propertyname="MainBody" runat="server" />
		</div>
		<asp:Button name="SaveAndPublish" Runat="server" Translate="/button/publish" ID="publish" Visible="false" />
     </form>
	
  </body>
</html>