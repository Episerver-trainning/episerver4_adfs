<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Page language="c#" Codebehind="CTLogin.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Util.CTLogin" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
	<head>
		<title>Login</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<meta name="robots" content="noindex,nofollow">
		<link rel="stylesheet" type="text/css" href="<%= EPiServer.Global.EPConfig.RootDir %>util/styles/login.css">
	</head>
	<body>
		<table width="100%" height="100%">
			<tr>
				<td valign="middle" align="center">
		
					<form id="Login" method="post" runat="server">
						<div class="loginBox">
							<table width="100%" height="100%" border="0">
								<tr>
									<td class="login" colspan="2">
										<h2 class="login"><asp:Label Runat="server" ID="Message" /></h2>
										<asp:RequiredFieldValidator id="RequiredUsernameValidator" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="Username" />
									</td>
								</tr>
								<tr>
									<td class="login" valign=middle align=left><EPiServer:Translate Text="/login/username" runat="server" ID="UsernameLabel" /></td>
									<td class="login" valign=middle align=right><asp:TextBox cssClass="loginInput" id="Username" runat="server"></asp:TextBox></td>
								</tr>
								<tr>
									<td class="login" valign=middle align=left><EPiServer:Translate Text="/login/password" runat="server" ID="PasswordLabel" /></td>
									<td class="login" valign=middle align=right><asp:TextBox cssClass="loginInput" id="Password" runat="server" TextMode="Password"></asp:TextBox></td>
								</tr>
								<tr>
									<td class="login" colspan="2"><asp:checkbox cssClass="loginCheckbox" id="PersistCookie" runat="server" /> <EPiServer:Translate Text="/login/persistentlogin" runat="server" ID="PersistentLabel" /></td>
								</tr>
								<tr>
									<td class="login" align="right" colspan="2"><asp:button cssClass="loginButton" id="LoginButton" runat="server" Translate="/button/login" Text="Login" /></td>
								</tr>
							</table>
						</div>
						<div class="cookieBox">
							<table width="100%" height="100%" border="0">
								<tr>
									<td>
										<a href="#" onclick="CookieInfoPanel.style.display=CookieInfoPanel.style.display=='' ? 'none' : ''; return false;"><EPiServer:Translate Text="/cookie/logincaption" runat="server" ID="CookieCaption" /></a>
										<div id="CookieInfoPanel" style="display: none;">
											<br>
											<EPiServer:Translate Text="/cookie/logininfo" runat="server" ID="CookieInfo" />
										</div>
									</td>
								</tr>
							</table>
						</div>
					</form>
				
				</td>
			</tr>
		</table>
	</body>
</html>
