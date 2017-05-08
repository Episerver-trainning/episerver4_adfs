<%@ Page language="c#" Codebehind="EmailPage.aspx.cs" AutoEventWireup="false" Inherits="development.Templates.EmailPage" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="development" TagName="Header"		Src="~/templates/Units/Header.ascx"%>
<html>
	<head>
		<development:header ID="Header" runat="server" />
	</head>
	<body bgcolor="#FFFFFF" text="#000000" style="padding: 10px;" xmlns:episerver="http://schemas.episerver.com">
		<form runat="server" id="Default">
			<table>
				<tr>
					<td>
						<EPiServer:Translate runat="server" Text="/templates/emailpage/to" />
					</td>
				</tr>
				<tr>
					<td>
						<asp:TextBox Runat="server" ID="To" />
						<asp:RequiredFieldValidator ControlToValidate="To" ErrorMessage="*" Runat="server" />
					</td>
				</tr>
				<tr>
					<td>
						<EPiServer:Translate runat="server" Text="/templates/emailpage/from" />
					</td>
				</tr>
				<tr>
					<td>
						<asp:TextBox Runat="server" ID="From" />
						<asp:RequiredFieldValidator ControlToValidate="From" ErrorMessage="*" Runat="server" />
					</td>
				</tr>
				<tr>
					<td>
						<EPiServer:Translate runat="server" Text="/templates/emailpage/subject" />
					</td>
				</tr>
				<tr>
					<td>
						<asp:TextBox Runat="server" ID="Subject" />
						<asp:RequiredFieldValidator ControlToValidate="Subject" ErrorMessage="*" Runat="server" />
					</td>
				</tr>
				<tr>
					<td>
						<EPiServer:Translate runat="server" Text="/templates/emailpage/other" />
					</td>
				</tr>
				<tr>
					<td>
						<asp:TextBox Runat="server" ID="Other" Rows="3" TextMode="MultiLine" />
						<asp:RequiredFieldValidator ControlToValidate="Other" ErrorMessage="*" Runat="server" />
					</td>
				</tr>
				<tr>
					<td>
						<asp:Button Runat="server" OnClick="SendEmailButton_Click" ID="SendEmailButton" Translate="/templates/emailpage/send" />
					</td>
				</tr>
			</table>
			<br/><br/>
			<a href="javascript: void 0" onclick="javascript:window.close();"><%= EPiServer.Global.EPLang.TranslateForScript("/button/close") %></a>
		</form>
	</body>
</html>
