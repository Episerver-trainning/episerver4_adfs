<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<%@ Page language="c#" Codebehind="PlugIn.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Admin.PlugIn" %>
<%@ Register TagPrefix="Admin" TagName="PlugInList"	Src="PlugInList.ascx"%>
<%@ Register TagPrefix="Admin" TagName="PlugInGroupList"	Src="PlugInGroupList.ascx"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
	<head>
		<title>PlugIn</title>
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
		<br>&nbsp;
		<EPiServerSys:tabstrip Sticky="True" runat="server" id="actionTab" AutoPostBack="False" TargetID="tabView">
			<EPiServerSys:tab Text="#plugintab" runat="server" ID="Tab1" />
			<EPiServerSys:tab Text="#overviewtab" runat="server" ID="Tab2" />
		</EPiServerSys:tabstrip>
		
		<asp:Panel id="tabView" runat="Server">
			<asp:Panel id="view1" runat="server">
				<Admin:PlugInGroupList runat="server" ID="groupList"/>
			</asp:Panel>
			<asp:Panel id="view2" runat="server">
				<Admin:PlugInList Editable="False" runat="server" ID="pluginList"/>
			</asp:Panel>
		</asp:Panel>
    </form>
	
  </body>
</html>
