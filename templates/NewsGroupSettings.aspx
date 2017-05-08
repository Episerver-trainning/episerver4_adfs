<%@ Page language="c#" Codebehind="NewsGroupSettings.aspx.cs" AutoEventWireup="false" Inherits="development.Templates.NewsGroupSettings" %>
<%@ Register TagPrefix="development" TagName="Header" Src="~/templates/units/header.ascx"%>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" > 

<html>
  <head>
    <development:header ID="pageHeader" runat="server"></development:header>
  </head>
  <body class="NewsGroupItem" topmargin=0 leftmargin=0 marginheight=0 marginwidth=0>
    <form id="NewsGroupSettings" method="post" runat="server">
		<table cellpadding="0" cellspacing="0" border="0" width="100%">
			<tr>
				<td background="../images/bar_background.gif" valign="top" align="left" width="100%">
					<table cellpadding="0" cellspacing="0" border="0" width="100%">
						<tr>
							<td align="left"><b><episerver:translate Text="#personalsettings" runat="server" ID="Translate3" /></b></td>
							<td align="right"><img src="../images/bar_separator_button.gif" class="borderless" alt="" /></td>
						</tr>
					</table>
				</td>		
			</tr>
		</table>
		<table cellpadding="4" cellspacing="0" border="0">
			<tr>
				<td>
					<episerver:translate Text="#firstname" runat="server" ID="Translate1" />
				</td>
				<td>
					<asp:TextBox ID="FirstName" Runat="server"></asp:TextBox>
				</td>
			</tr>
			<tr>
				<td>
					<episerver:translate Text="#lastname" runat="server" ID="Translate2" />
				</td>
				<td>
					<asp:TextBox ID="LastName" Runat="server"></asp:TextBox>
				</td>
			</tr>
			<tr>
				<td>
					<episerver:translate Text="#email" runat="server" ID="Translate4" Class="NewsGroupItemMessage" />
				</td>
				<td>
					<asp:TextBox ID="Email" Runat="server"></asp:TextBox>
				</td>
			</tr>
			<tr>
				<td>
					<episerver:translate Text="#interval" runat="server" ID="Translate5" />
				</td>
				<td>
					<asp:DropDownList ID="Interval" Runat="Server" CssClass="NewsGroupItem">
						<asp:listitem Value="0">#fastaspossible</asp:listitem>
						<asp:listitem Value="1">#daily</asp:listitem>
						<asp:listitem Value="2">#everysecondday</asp:listitem>
						<asp:listitem Value="7">#weekly</asp:listitem>
						<asp:listitem Value="14">#everysecondweek</asp:listitem>
						<asp:listitem Value="28">#everyfourthweek</asp:listitem>
					</asp:DropDownList>
				</td>
			</tr>
			<tr>
				<td>
					<asp:Button id="ApplyButton" Runat="server" OnClick="ApplyButton_Click" Translate="/button/save" />
				</td>
			</tr>
		</table>
     </form>
  </body>
</html>
