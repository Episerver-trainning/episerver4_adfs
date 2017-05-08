<%@ Control Language="c#" AutoEventWireup="false" Codebehind="ClientComponents.ascx.cs" Inherits="EPiServer.Edit.ClientComponents" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<script type="text/javascript">
	function RunComponentInstaller()
	{		
		window.open('ClientInstaller.aspx','InstallWin','width=650,height=440,scrollbars=yes');
	}
	
			
	function TestClientTools()
	{
		if(!document.all['componentTable'])
			return;
		var verifiedSrc = "<%=Configuration.RootDir%>Util/Images/ClientTools/check.gif";
		var notInstalledSrc = "<%=Configuration.RootDir%>Util/Images/ClientTools/delete.gif";
		
		var textInstalled = '<%=TranslateForScript("/clienttools/installstatus/statusinstalled")%>';
		var textNotInstalled = '<%=TranslateForScript("/clienttools/installstatus/statusnotinstalled")%>';
		
		var oClientTools = document.all['oClientTools'];
		var oExcelTools = document.all['oExcelTools'];
		var oWordTools	= document.all['oWordTools'];
		var oMultiUpload = document.all['oMultiUpload'];
		
		document.all['ExcelToolsStatus'].src = oExcelTools.object ? verifiedSrc : notInstalledSrc;
		document.all['ExcelToolsStatus'].alt = oExcelTools.object ? textInstalled : textNotInstalled;
		
		document.all['WordToolsStatus'].src = oWordTools.object ? verifiedSrc : notInstalledSrc;
		document.all['WordToolsStatus'].alt = oWordTools.object ? textInstalled : textNotInstalled;
		
		document.all['MultiUploadStatus'].src = oMultiUpload.object ? verifiedSrc : notInstalledSrc;
		document.all['MultiUploadStatus'].alt = oMultiUpload.object ? textInstalled : textNotInstalled;
					
		var clientVersion;
		var currentMinorVersion = <%=CurrentMinorVersion%>;
		var currentMajorVersion = <%=CurrentMajorVersion%>;
		
		if(oClientTools && oClientTools.MinorVersion!=undefined)
		{
			try
			{
				clientVersion = oClientTools.MajorVersion + '.' + oClientTools.MinorVersion;
				document.all['clientToolsVersion'].innerText = clientVersion;
			}catch(oErr)
			{}
		}
		
		if(!clientVersion || (oClientTools.MajorVersion < currentMajorVersion || (oClientTools.MajorVersion == currentMajorVersion && oClientTools.MinorVersion < currentMinorVersion)))
			document.all['<%=upgradeButton.ClientID%>'].disabled = false;
	
	}
</script>

<EPiServerSys:SystemPrefix id="componentsPrefix" runat="server" />
<br />
<br />
<table id="componentTable" class="EP-tableGrid">
	<tr>
		<td class="EP-tableHeadingGrid"><EPiServer:Translate runat="server" Text="/clienttools/installstatus/componentname" ID="Translate1"/></td>
		<td class="EP-tableHeadingGrid"><EPiServer:Translate runat="server" Text="/clienttools/installstatus/componentdescription" ID="Translate7"/></td>
		<td class="EP-tableHeadingGrid"><EPiServer:Translate runat="server" Text="/clienttools/installstatus/componentstatus" ID="Translate2"/></td>
		
	</tr>
	<tr>
		<td class="EP-tableCellGrid"><EPiServer:Translate runat="server" Text="/clienttools/installstatus/components/componentspellchecker/heading" ID="Translate3" NAME="Translate1"/></td>
		<td class="EP-tableCellGrid"><EPiServer:Translate runat="server" Text="/clienttools/installstatus/components/componentspellchecker/description" ID="Translate9" NAME="Translate1"/></td>
		<td class="EP-tableCellGrid"><img src="<%=EPiServer.Global.EPConfig.RootDir%>util/Images/ClientTools/gear.gif" alt="<%=Translate("/clienttools/installstatus/components/statusloading")%>" id="WordToolsStatus"></td>
	</tr>
	<tr>
		<td class="EP-tableCellGrid"><EPiServer:Translate runat="server" Text="/clienttools/installstatus/components/componentexcelexport/heading" ID="Translate5" NAME="Translate1"/></td>
		<td class="EP-tableCellGrid"><EPiServer:Translate runat="server" Text="/clienttools/installstatus/components/componentexcelexport/description" ID="Translate8" NAME="Translate1"/></td>
		<td class="EP-tableCellGrid"><img src="<%=EPiServer.Global.EPConfig.RootDir%>util/Images/ClientTools/gear.gif" alt="<%=Translate("/clienttools/installstatus/components/statusloading")%>" id="ExcelToolsStatus"></td>
	</tr>
	<tr>
		<td class="EP-tableCellGrid"><EPiServer:Translate runat="server" Text="/clienttools/installstatus/components/componentmultiupload/heading" ID="Translate4" NAME="Translate1"/></td>
		<td class="EP-tableCellGrid"><EPiServer:Translate runat="server" Text="/clienttools/installstatus/components/componentmultiupload/description" ID="Translate6" NAME="Translate1"/></td>
		<td class="EP-tableCellGrid"><img src="<%=EPiServer.Global.EPConfig.RootDir%>util/Images/ClientTools/gear.gif" alt="<%=Translate("/clienttools/installstatus/components/statusloading")%>" id="MultiUploadStatus"></td>
	</tr>
</table>
<br/>
<EPiServer:Translate id="currentVersionText" Text="/clienttools/installstatus/components/currentversion" runat="server"/>
<br />
<br />
<input type="button" id="upgradeButton" disabled onclick="RunComponentInstaller()" value="Uppgradera" runat="server" NAME="upgradeButton">
<object
	id="oClientTools" tabindex="-1"
	width="0"
	height="0"
	classid="clsid:EA76A24C-9D04-4913-9757-96177DE8F744"
	VIEWASTEXT>
<object
	id="oExcelTools" tabindex="-1"
	width="0" 
	height="0" 
	classid="clsid:464A4945-DC7F-425E-8F2D-5E2FD03F622A" 
	VIEWASTEXT>
</object>
<object
	ID="oWordTools" tabindex="-1"
	width="0"
	height="0"
	classid="CLSID:B3F4C498-0C60-442D-A94F-04A36479F620"
	VIEWASTEXT>
<object
	ID="oMultiUpload" tabindex="-1"
	width="0"
	height="0"
	classid="CLSID:10E782A8-54B3-4A8A-96A6-3E09D477EC20"
	VIEWASTEXT>
</object>
