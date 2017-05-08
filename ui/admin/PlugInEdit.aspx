<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<%@ Page language="c#" Codebehind="PlugInEdit.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Admin.PlugInEdit" %>
<%@ Register TagPrefix="Admin" TagName="PlugInList"	Src="PlugInList.ascx"%>
<%@ Register TagPrefix="Admin" TagName="PlugInAdminSettings"	Src="PlugInAdminSettings.ascx"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
	<head>
		<title>PlugIn Group Properties</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<script type='text/javascript' src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/system.js"></script>
		<link rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css">
  </head>
  <body MS_POSITIONING="GridLayout">
	
    <form id="PlugIn" method="post" runat="server">
		<EPiServerSys:SystemPrefix id="SystemPrefix" runat="server" />
		&nbsp;<br>&nbsp;<br>
		<asp:Button ID="SaveButton" Runat="server" Translate="/button/save" OnClick="Save"/>
		<asp:Button ID="CancelButton" Runat="server" Translate="/button/cancel" OnClick="Cancel"/>
		<br>&nbsp;
		<episerversys:tabstrip runat="server" id="actionTab" AutoPostBack="False" TargetID="tabView">
			<episerversys:tab Text="#configurationtab" runat="server" ID="Tab2" />
			<episerversys:tab Text="#overviewtab" runat="server" ID="Tab1" />
		</episerversys:tabstrip>
		
		<asp:Panel id="tabView" runat="Server">
			<asp:Panel id="view2" runat="server">
				<Admin:PlugInAdminSettings runat="server" ID="pluginSettings"/>
			</asp:Panel>
			<asp:Panel id="view1" runat="server">
				<Admin:PlugInList runat="server" ID="pluginList" ShowGroup="False"/>
			</asp:Panel>
		</asp:Panel>		
    </form>
	
  </body>
</html>
