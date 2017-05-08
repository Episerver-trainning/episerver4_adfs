<%@ Page language="c#" Codebehind="Workflow.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Workflow.Admin.Workflow" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" > 

<html>
  <head>
    <title>MultiStepWorkflow</title>
    <meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
    <meta name="CODE_LANGUAGE" Content="C#">
    <meta name=vs_defaultClientScript content="JavaScript">
    <meta name=vs_targetSchema content="http://schemas.microsoft.com/intellisense/ie5">
	<link rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css">
	<script language="JavaScript" src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/system.js"></script>
  </head>
  <body MS_POSITIONING="GridLayout">
	
    <form id="MultiStepWorkflow" method="post" runat="server">
    <EPiServerSys:SystemPrefix id="prefix" runat="server"/><br><br>
    <table>
    <tr>
		<td valign="top" width="20%"><b><EPiServer:Translate Text="#name" runat="server" ID="Translate1" NAME="Translate1"/></b></td>
		<td valign="top" width="60%"><b><EPiServer:Translate Text="#description" runat="server" ID="Translate2" NAME="Translate1"/></b></td>
		<td valign="top" width="20%"><b><EPiServer:Translate Text="#createdby" runat="server" ID="Translate3" NAME="Translate1"/></b></td>
    </tr>
    <asp:Repeater ID="WorkflowList" Runat="server">
    <ItemTemplate>
    <tr>
		<td valign="top">
			<a href="WorkflowItem.aspx?id=<%#DataBinder.Eval(Container.DataItem,"pkID")%>"><%#DataBinder.Eval(Container.DataItem,"Name")%></a>
		</td>
		<td valign="top">
			<%#DataBinder.Eval(Container.DataItem,"Description")%>
		</td>
		<td valign="top">
			<%#GetUserName(Convert.ToInt32(DataBinder.Eval(Container.DataItem,"fkCreatedBySID")))%>
		</td>
	</tr>
    </ItemTemplate>
    </asp:Repeater>
    </table>
     <br>
     <asp:button OnClick="AddWorkflow" Translate="#add" runat="server"/><br>
     </form>
	
  </body>
</html>
