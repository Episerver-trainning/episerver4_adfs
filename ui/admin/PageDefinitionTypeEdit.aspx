<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<%@ Page language="c#" Codebehind="PageDefinitionTypeEdit.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Admin.PageDefinitionTypeEdit" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>PageDefinitionType</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<link rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css">
		<script type='text/javascript' src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/system.js"></script>
	</HEAD>
	<body>
		<form id="EditPageTypeBase" method="post" runat="server">
			<EPiServerSys:SystemPrefix id="pagePrefix" runat="server" />
			<p><EPiServerSys:ValidationSummary ID="Summary" Runat="server" />
			</p>
			<table>
				<tr>
					<td><episerver:translate text="#property" runat="server" id="Translate1" /></td>
					<td><asp:DropDownList id="typeProperty" Runat="server" /></td>
				</tr>
				<tr>
					<td><episerver:translate text="#namecaption" runat="server" ID="Translate11" /></td>
					<td><asp:TextBox ID="typeName" Columns="25" Runat="server" />
					<asp:RequiredFieldValidator ControlToValidate="typeName" ErrorMessage="*" Runat="server"/>
					<EPiServer:XmlNameValidator ControlToValidate="typeName" Runat="server" DisplayName="#namecaption" ID="Xmlnamevalidator1"/>
					</td>
				</tr>
				<tr>
					<td><episerver:translate text="#typenamecaption" runat="server" ID="Translate2" /></td>
					<td><asp:TextBox id="typeTypeName" Columns="50" Runat="server" /></td>
				</tr>
				<tr>
					<td><episerver:translate text="#assemblynamecaption" runat="server" ID="Translate3" /></td>
					<td><asp:TextBox id="typeAssembly" Columns="50" Runat="server" /></td>
				</tr>
			</table>
			<asp:Button id="ApplyButton" Runat="server" translate="/button/save"></asp:Button>
			<asp:Button id="DeleteButton" CausesValidation="False" Runat="server" translate="/button/delete"></asp:Button>
			<asp:Button id="CancelButton" CausesValidation="False" Runat="server" translate="/button/cancel"></asp:Button>
		</form>
	</body>
</HTML>
