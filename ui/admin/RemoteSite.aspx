<%@ Page language="c#" Codebehind="RemoteSite.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Admin.RemoteSite" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" > 

<html>
  <head>
    <title>Cluster</title>
    <meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
    <meta name="CODE_LANGUAGE" Content="C#">
    <meta name=vs_defaultClientScript content="JavaScript">
    <meta name=vs_targetSchema content="http://schemas.microsoft.com/intellisense/ie5">
    <script type='text/javascript' src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/system.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css">
  </head>
  <body MS_POSITIONING="GridLayout">
    <form id="Cluster" method="post" runat="server">
		<episerversys:systemprefix id="pagePrefix" runat="server" />
		<br /><br />
		<EPiServer:translate Text="#localsite" runat="server"/>&nbsp;<b><asp:Label ID="localSiteLabel" Runat=server/>
		<asp:TextBox ID="localSite" Runat="server" />
		<asp:Button OnClick="Change" CausesValidation="False" Translate="/button/edit" ID="ChangeButton" Runat="server"/></b>
				<asp:RegularExpressionValidator id="RegularExpressionValidator1" 
                ControlToValidate="localSite"
                ValidationExpression="\w+"
                ErrorMessage="Name can only contain a alphanumerical string"
                runat="server"/>
        <asp:RequiredFieldValidator
				ControlToValidate="localSite"
				ErrorMessage="*"
				runat="server" ID="Requiredfieldvalidator1" NAME="Requiredfieldvalidator1"/>
		<br /><br />
		<asp:Repeater ID="siteList" Runat="server">
		<HeaderTemplate>
			<table>
			<tr>
			<td>
				<episerver:translate Text="#name" runat="server" />	
			</td>
			<td>
				<episerver:translate Text="#url" runat="server" />	
			</td>
			<td>
				
			</td>
			</tr>
			
		</HeaderTemplate>
		<ItemTemplate>
			<tr>
			<td>
				<a href="RemoteSiteEdit.aspx?id=<%#DataBinder.Eval(Container.DataItem,"ID")%>"><%#DataBinder.Eval(Container.DataItem,"Name")%></a>
			</td>
			<td>
				<%#DataBinder.Eval(Container.DataItem,"Url")%>
			</td>
			<td>
				<asp:LinkButton Translate="#ping" OnCommand="PingSite" CommandName=<%#DataBinder.Eval(Container.DataItem,"Name")%> Runat="server"/>
			</td>
			</tr>
		</ItemTemplate>
		<FooterTemplate></table></FooterTemplate>
		</asp:Repeater>
		<br>
		<asp:Button OnClick="CreateSite" Runat="Server" Translate="/button/create"/>
     </form>
  </body>
</html>