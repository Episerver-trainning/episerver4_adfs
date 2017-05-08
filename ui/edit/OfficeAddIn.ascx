<%@ Control Language="c#" AutoEventWireup="false" Codebehind="OfficeAddIn.ascx.cs" Inherits="EPiServer.Edit.OfficeAddIn" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<script type="text/javascript">

	var RegUserName = '<%=RegUserName%>';
	var RegActivationKey = '<%=RegActivationKey%>';
	
	function RunOfficeInstaller()
	{		
		window.location.href = '<%=Configuration.RootDir%>Util/ActiveX/EPiServerOfficeAddIn.msi';
	}
	
	function TestOfficeAddIn()
	{
		if(document.all['<%=upgradeButton.UniqueID%>'])
			TestInstaller();
		else
			TestActivate();
	}
	
	function RemoveSite()
	{
		document.all['oClientInstaller'].RemoveSite('<%=Configuration.HostUrl + Configuration.RootDir.Substring(0,Configuration.RootDir.Length-1)%>');
		TestActivate();
	}
	
	function AddSite()
	{
		document.all['oClientInstaller'].AddSite('<%=Configuration.HostUrl + Configuration.RootDir.Substring(0,Configuration.RootDir.Length-1)%>',RegUserName,RegActivationKey);
		TestActivate();
	}
	
	function TestActivate()
	{
		var oClientInstaller = document.all['oClientInstaller'];
		var deActivateButton = document.all['<%=deActivateButton.ClientID%>'];
		var activateButton = document.all['<%=activateButton.ClientID%>'];
		if(!oClientInstaller.object || oClientInstaller.IsSiteRegistered==undefined)
		{
			deActivateButton.disabled=true;
			activateButton.disabled=true;
			document.all['activateStatus'].innerText = '<%=TranslateForScript("/clienttools/installstatus/statusnotinstalled")%>';
			return;
		}
		
		if(oClientInstaller.IsSiteRegistered)
		{
			deActivateButton.disabled=false;
			activateButton.disabled=true;
			document.all['activateStatus'].innerText = '<%=TranslateForScript("/clienttools/installstatus/officeaddin/activated")%>';
		
		}
		else
		{
			deActivateButton.disabled=true;
			activateButton.disabled=false;
			document.all['activateStatus'].innerText = '<%=TranslateForScript("/clienttools/installstatus/officeaddin/notactivated")%>';
		}
	}
	
	function TestInstaller()
	{
		
		var verifiedSrc = "<%=Configuration.RootDir%>Util/Images/ClientTools/check.png";
		var notInstalledSrc = "<%=Configuration.RootDir%>Util/Images/ClientTools/delete.png";
		
		var textInstalled = '<%=TranslateForScript("/clienttools/installstatus/statusinstalled")%>';
		var textNotInstalled = '<%=TranslateForScript("/clienttools/installstatus/statusnotinstalled")%>';
		
		var oWebTools = document.all['oWebTools'];
							
		var clientVersion;
		var currentMinorVersion = <%=CurrentMinorVersion%>;
		var currentMajorVersion = <%=CurrentMajorVersion%>;
		
		if(oWebTools && oWebTools.MinorVersion!=undefined)
		{
			try
			{
				clientVersion = oWebTools.MajorVersion + '.' + oWebTools.MinorVersion;
				document.all['clientToolsVersion'].innerText = clientVersion;
			}catch(oErr)
			{}
		}
		
		if(!clientVersion || (oWebTools.MajorVersion < currentMajorVersion || (oWebTools.MajorVersion == currentMajorVersion && oWebTools.MinorVersion < currentMinorVersion)))
			document.all['<%=upgradeButton.ClientID%>'].disabled = false;
	
	}
</script>
<EPiServerSys:SystemPrefix id="officePrefix" runat="server" />
<br><br>
<EPiServerSys:tabstrip id="officeTab" OnTabClicked="HandleActivationTab" runat="server" AutoPostBack="true" TargetID="officeTabView">
	<EPiServerSys:tab Sticky="True" Text="1. " runat="server" id="Tab1"/>
	<EPiServerSys:tab Sticky="True" Text="2. " runat="server" id="Tab2"/>
</EPiServerSys:tabstrip>
<asp:Panel ID="officeTabView" Runat="server">
<asp:Panel ID="installTab" Runat="server">
<br>
<EPiServer:Translate id="currentVersionText" Text="/clienttools/installstatus/components/currentversion" for runat="server"/>
<br><br>
<input type="button" id="upgradeButton" disabled onclick="RunOfficeInstaller()" value="Uppgradera" runat="server" NAME="upgradeButton">
<object
	id="oWebTools" tabindex="-1"
	width="0"
	height="0"
	classid="clsid:10DDD8C9-4F48-442B-B499-7901AB28125C"
	VIEWASTEXT>
</object>
</asp:Panel>
<asp:Panel ID="activateTab" Runat="server">
<br><div id="activateStatus">(loading)</div><br>
<input type="button" id="activateButton" Translate="/button/activate" runat="server" onclick="AddSite()" value="Aktivera" />
<input type="button" id="deActivateButton" Translate="/button/deactivate" runat="server" onclick="RemoveSite()" value="Inaktivera" />
<object
	id="oClientInstaller" tabindex="-1"
	width="0"
	height="0"
	classid="clsid:28C29E1D-648C-44F4-848C-6FAEE0B12C9A"
	VIEWASTEXT>
</object>
</asp:Panel>
</asp:Panel>
