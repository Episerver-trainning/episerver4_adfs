<%@ Page language="c#" Codebehind="workspace.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Edit.Workspace" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" > 

<html>
  <head>
    <title>workspace</title>
    <meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
    <meta name="CODE_LANGUAGE" Content="C#">
    <meta name=vs_defaultClientScript content="JavaScript">
    <meta name=vs_targetSchema content="http://schemas.microsoft.com/intellisense/ie5">
    <link rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css">
    <script type='text/javascript' src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/system.js"></script>
    <script type='text/javascript'>
		<!--
		function onNavigate(newPageLink)
		{
			return -1;
		}
		function onCommand(newCommand)
		{
			return -1;
		}
		
		function RunOfficeInstaller()
		{		
			window.open('<%=Configuration.RootDir%>util/ActiveX/EPiServerOfficeAddin.msi');
		}

		function TestOfficeAddin()
		{
			if(!document.all['componentTable'])
					return;
		}
	
		// -->
	</script>
  </head>
  <body onload="if(window.TestClientTools) TestClientTools();if(window.TestOfficeAddIn) TestOfficeAddIn();">
	
    <form id="workspace" method="post" runat="server">
    	
    	<EPiServerSys:tabstrip id="actionTab" runat="server" AutoPostBack="true" TargetID="tabView">
			<EPiServerSys:tab Sticky="True" Text="#welcome" runat="server" id="PersonalActivityTab"/>
			<EPiServerSys:tab Sticky="True" Text="#mysettings" runat="server" id="SettingsTab"/>
			<EPiServerSys:tab Sticky="True" Text="/clienttools/installstatus/officeaddin/heading" runat="server" id="Tab2"/>
			<EPiServerSys:tab Sticky="True" Text="/clienttools/installstatus/components/heading" runat="server" id="Tab1"/>
			<EPiServerSys:tab Sticky="True" Text="#license" runat="server" id="LicenseTab"/>
		</EPiServerSys:tabstrip>
		
		<asp:Panel ID="tabView" Runat="server">
			<asp:Panel runat="server" ID="PersonalActivityView">
			<div class="EPEdit-WorkspaceTabContent">
				<img src="~/util/images/welcome.gif" runat="server" ID="Img1"/>
				<EPiServerSys:PersonalActivity runat="server" ID="Personalactivity1"/>
			</div>
			</asp:Panel>
			<asp:Panel runat="server" ID="SettingsView">
			<div class="EPEdit-WorkspaceTabContent">
				<EPiServer:ControlLoader ID="UserSettings" Runat="Server" Src="~/edit/UserSettings.ascx" />				
			</div>
			</asp:Panel>
			<asp:Panel runat="server" ID="Panel3">
				<EPiServer:ControlLoader ID="OfficeAddIn" runat="Server" Src="~/edit/OfficeAddIn.ascx" />				
			</asp:Panel>
			<asp:Panel runat="server" ID="Panel2">
				<EPiServer:ControlLoader ID="ClientComponents" runat="Server" Src="~/edit/ClientComponents.ascx" />				
			</asp:Panel>
			<asp:Panel runat="server" ID="LicenseView">
				<div class="EPEdit-WorkspaceTabContent" runat="server" ID="LicenseText"/>
			</asp:Panel>
		</asp:Panel>

     </form>
	
  </body>
</html>
