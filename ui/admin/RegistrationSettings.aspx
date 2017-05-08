<%@ Page language="c#" Codebehind="RegistrationSettings.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Admin.RegistrationSettings" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" > 

<html>
  <head>
    <link rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css">
    <meta name=vs_targetSchema content="http://schemas.microsoft.com/intellisense/ie5">
  </head>
  <body>
    <form id="SetDefaultGroup" method="post" runat="server">
		<EPiServerSys:SystemPrefix id="SystemPrefix" runat="server"/>
		<EPiServerSys:ValidationSummary id="Summary" runat="server" />
		<p><asp:Button translate="/button/save" ID="Save" Runat="server" OnClick="Save_Click" /></p>
		<table>
			<tr>
				<td><episerver:Translate Text="#allowselfregistration" runat="server" ID="Translate14"/></td>
				<td><asp:CheckBox ID="AllowFreeRegistring" Runat="server"></asp:CheckBox></td>
			</tr>
			<tr>
				<td><episerver:Translate Text="#setdefaultgroup" runat="server" ID="Translate3"/></td>
				<td><asp:DropDownList ID="GroupList" Runat="server"></asp:DropDownList></td>
			</tr>
			<tr>
				<td><episerver:Translate Text="#requiredpasswordlength" runat="server" ID="Translate11"/></td>
				<td><asp:DropDownList ID="RequiredPasswordLength" Runat="server"></asp:DropDownList></td>
			</tr>
			<tr>
				<td><episerver:Translate Text="#passwordrequirealpha" runat="server" ID="Translate13"/></td>
				<td><asp:CheckBox ID="PasswordRequireAlpha" Runat="server"></asp:CheckBox></td>
			</tr>
			<tr>
				<td><episerver:Translate Text="#passwordrequirenumber" runat="server" ID="Translate15"/></td>
				<td><asp:CheckBox ID="PasswordRequireNumber" Runat="server"></asp:CheckBox></td>
			</tr>
			<tr>
				<td><episerver:Translate Text="#passwordrequiresymbol" runat="server" ID="Translate16"/></td>
				<td><asp:CheckBox ID="PasswordRequireSymbol" Runat="server"></asp:CheckBox></td>
			</tr>
			<tr>
				<td><episerver:Translate Text="#maxfailedattempts" runat="server" ID="Translate12"/></td>
				<td><asp:DropDownList ID="FailedAttempts" Runat="server"></asp:DropDownList></td>
			</tr>
			<tr>
				<td><episerver:Translate Text="#activateusers" runat="server" ID="Translate4"/></td>
				<td><asp:CheckBox ID="AutoActivateUser" Runat="server"></asp:CheckBox></td>
			</tr>
			<tr>
				<td><episerver:Translate Text="#emailfromaddress" runat="server" ID="Translate6"/></td>
				<td>
					<asp:TextBox ID="FromEmailAddress" Runat="server"></asp:TextBox>
					<asp:RequiredFieldValidator ControlToValidate="FromEmailAddress" Runat="server" EnableClientScript="False" />
				</td>
			</tr>
			<tr>
				<td><episerver:Translate Text="#emailtoaddress" runat="server" ID="emailtoaddress"/></td>
				<td>
					<asp:TextBox ID="ToEmailAddress" Runat="server"></asp:TextBox>
					<asp:RequiredFieldValidator ControlToValidate="ToEmailAddress" Runat="server" EnableClientScript="False" />
				</td>				
			</tr>
			<tr>
				<td><episerver:Translate Text="#confirmationsubject" runat="server" ID="Translate7"/></td>
				<td>
					<asp:TextBox ID="ConfirmationEmailSubject" Runat="server" Width="400"></asp:TextBox>
					<asp:RequiredFieldValidator ControlToValidate="ConfirmationEmailSubject" Runat="server" EnableClientScript="False" />
				</td>
			</tr>
			<tr>
				<td valign="top"><episerver:Translate Text="#confirmationbody" runat="server" ID="Translate8"/></td>
				<td>
					<asp:TextBox ID="ConfirmationEmailBody" Runat="server" Rows="8" TextMode="MultiLine" Width="400"></asp:TextBox>
					<asp:RequiredFieldValidator ControlToValidate="ConfirmationEmailBody" Runat="server" EnableClientScript="False" />
				</td>
			</tr>
			<tr>
				<td><episerver:Translate Text="#activationsubject" runat="server" ID="Translate9"/></td>
				<td>
					<asp:TextBox ID="ActivationEmailSubject" Runat="server" Width="400"></asp:TextBox>
					<asp:RequiredFieldValidator ControlToValidate="ActivationEmailSubject" Runat="server" EnableClientScript="False" />
				</td>
			</tr>
			<tr>
				<td valign="top"><episerver:Translate Text="#activationbody" runat="server" ID="Translate10"/></td>
				<td>
					<asp:TextBox ID="ActivationEmailBody" Runat="server" Rows="8" TextMode="MultiLine" Width="400"></asp:TextBox>
					<asp:RequiredFieldValidator ControlToValidate="ActivationEmailBody" Runat="server" EnableClientScript="False" />
				</td>
			</tr>
		</table>
     </form>
  </body>
</html>
