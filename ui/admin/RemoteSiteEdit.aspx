<%@ Page language="c#" Codebehind="RemoteSiteEdit.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Admin.RemoteSiteEdit" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" > 

<html>
  <head>
    <title>RemoteSiteEdit</title>
    <meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
    <meta name="CODE_LANGUAGE" Content="C#">
    <meta name=vs_defaultClientScript content="JavaScript">
    <meta name=vs_targetSchema content="http://schemas.microsoft.com/intellisense/ie5">
    <script type='text/javascript' src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/system.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css">
  </head>
  <body MS_POSITIONING="GridLayout">
	
    <form id="RemoteSiteEdit" method="post" runat="server">
	<episerversys:systemprefix id="PagePrefix" runat="server" />
	<episerversys:validationsummary id="Summary" runat="server" />
	<br><br>
	<table>
	<tr>
	<td Class="EP-tableCaptionCell">
		<episerver:translate Text="#name" runat="server"/>
	</td>
	<td>
		<asp:TextBox MaxLength="100" ID="RemoteSite" Runat="server"/>
        <asp:RequiredFieldValidator ID="RequiredNameCheck"
					ErrorMessage="*"
					Display="Dynamic"
					ControlToValidate="RemoteSite"
					Runat="server"/>
		<asp:RegularExpressionValidator id="RegularExpressionValidator1" 
                     ControlToValidate="RemoteSite"
                     ValidationExpression="\w+"
                     ErrorMessage="Name can only contain a alphanumerical string"
                     runat="server"/>
	</td>
	</tr>
	<tr>
	<td Class="EP-tableCaptionCell">
		<episerver:translate Text="#url" runat="server"/>
	</td>
	<td>
		<asp:TextBox Text="http://" MaxLength="255" Columns="50" ID="RemoteUrl" Runat="server"/>
		<asp:RequiredFieldValidator ID="RequiredUrlCheck"
			ErrorMessage="*"
			Display="Dynamic"
			ControlToValidate="RemoteUrl"
			Runat="server"/>
	</td>
	</tr>
	<tr>
	<td Class="EP-tableCaptionCell">
		<episerver:translate Text="#sharedsecret" runat="server" ID="Translate1" NAME="Translate1"/>
	</td>
	<td>
		<asp:TextBox MaxLength="255" Columns="50" ID="SharedSecret" Runat="server"/>
		<asp:LinkButton OnClick="GenerateSharedSecret" Translate="/button/create" ID="GenerateKey" Runat="server"/>
	</td>
	</tr>
		<tr>
	<td Class="EP-tableCaptionCell">
		<episerver:translate Text="#username" runat="server" ID="Translate3" NAME="Translate1"/>
	</td>
	<td>
		<asp:TextBox MaxLength="255" Columns="25" ID="UserName" Runat="server"/>
	</td>
	</tr>
	<tr>
	<td Class="EP-tableCaptionCell">
		<episerver:translate Text="#password" runat="server" ID="Translate33" NAME="Translate1"/>
	</td>
	<td>
		<input MaxLength="255" Size="25" type="password" ID="Password" Runat="server" runat="server"/>
	</td>
	</tr>
	<tr>
	<td Class="EP-tableCaptionCell">
		<episerver:translate Text="#domain" runat="server" ID="Translate4" NAME="Translate1"/>
	</td>
	<td>
		<asp:TextBox MaxLength="255" Columns="25" ID="Domain" Runat="server"/>
	</td>
	</tr>
	<tr>
	<td Class="EP-tableCaptionCell">
		<episerver:translate Text="#allowurllookup" runat="server" ID="Translate22" NAME="Translate2"/>
	</td>
	<td>
		<input type="checkbox" ID="AllowUrlLookup" Runat="server"/>
	</td>
	</tr>
	<tr>
	<td Class="EP-tableCaptionCell">
		<episerver:translate Text="#istrusted" runat="server" ID="Translate2" NAME="Translate2"/>
	</td>
	<td>
		<input type="checkbox" ID="IsTrusted" Runat="server"/>
	</td>
	</tr>
	</table>
	<br>
	<asp:Button OnClick="SaveForm" Runat="Server" Translate="/button/save" ID="SaveButton" NAME="SaveButton"/>
	<asp:Button OnClick="DeleteForm" CausesValidation="False" Runat="Server" Translate="/button/delete" ID="DeleteButton" NAME="DeleteButton"/>
	<asp:Button OnClick="CancelForm" CausesValidation="False" Runat="Server" Translate="/button/cancel" ID="CancelButton" NAME="CancelButton"/>
     </form>
	
  </body>
</html>
