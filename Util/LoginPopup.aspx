<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Page language="c#" Codebehind="LoginPopup.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Util.LoginPopup" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" > 

<html>
  <head>
    <title>LoginPopup</title>
    <meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
    <meta name="CODE_LANGUAGE" Content="C#">
    <meta name=vs_defaultClientScript content="JavaScript">
    <meta name="robots" content="noindex,nofollow">
    <meta name=vs_targetSchema content="http://schemas.microsoft.com/intellisense/ie5">
	<link rel="stylesheet" type="text/css" href="<%= EPiServer.Global.EPConfig.RootDir %>util/styles/login.css">
  </head>
  <body class="loginBoxAlternate">
	<asp:PlaceHolder ID="LoginForm" Runat="server">

    <form id="LoginPopup" method="post" runat="server">
		<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td colspan="2" height="24"><img src="images/loginbackground.gif"></td>
			</tr>
			<tr>
				<td class="loginPopup" colspan="2">
					<h2 class="login"><asp:Label Runat="server" ID="Message" /></h2>
					<asp:RequiredFieldValidator id="RequiredUsernameValidator" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="Username" />
				</td>
			</tr>
			<tr>
				<td class="loginPopup" valign=middle align=left><EPiServer:Translate Text="/login/username" runat="server" ID="UsernameLabel" /></td>
				<td class="loginPopup" valign=middle align=right><asp:TextBox cssClass="loginInput" id="Username" runat="server"></asp:TextBox></td>
			</tr>
			<tr>
				<td class="loginPopup" valign=middle align=left><EPiServer:Translate Text="/login/password" runat="server" ID="PasswordLabel" /></td>
				<td class="loginPopup" valign=middle align=right><asp:TextBox cssClass="loginInput" id="Password" runat="server" TextMode="Password"></asp:TextBox></td>
			</tr>
			<tr>
				<td class="loginPopup" colspan="2"><asp:checkbox cssClass="loginCheckbox" id="PersistCookie" runat="server" /> <EPiServer:Translate Text="/login/persistentlogin" runat="server" ID="PersistentLabel" /></td>
			</tr>
			<tr>
				<td class="loginPopup" align="right" colspan="2"><asp:button cssClass="loginButton" id="LoginButton" runat="server" Translate="/button/login" Text="Login" /></td>
			</tr>
			<tr>
				<td colspan="2">
					&nbsp;<a href="#" onclick="CookieInfoPanel.style.display=CookieInfoPanel.style.display=='' ? 'none' : ''; return false;"><EPiServer:Translate Text="/cookie/logincaption" runat="server" ID="CookieCaption" /></a>
					<div id="CookieInfoPanel" style="display: none;">
						<br>
						<EPiServer:Translate Text="/cookie/logininfo" runat="server" ID="CookieInfo" />
					</div>
				</td>
			</tr>
		</table>
     </form>
		</asp:PlaceHolder>
		<asp:PlaceHolder ID="ModalDialogContainer" Runat="server" Visible="False">
			<iframe src="LoginPopup.aspx?content=1" width="100%" height="100%" scrolling=no frameborder="0"></iframe>
		</asp:PlaceHolder>
  </body>
</html>
