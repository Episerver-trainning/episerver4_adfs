<%@ Page language="c#" Codebehind="Default.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Util.ClientTools.Wizard.Default" %>
<%@ Register TagPrefix="ClientTools" Namespace="EPiServer.ClientTools" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>Wiz</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css" type="text/css" rel="stylesheet">
		<script language="javascript" src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/system.js" type="text/javascript"></script>
		<script>
		
		var amIClickedYet = false;
		
		function window.PreviousClicked()
		{
		}
		
		function window.EnableButtons(isPageTypeSelection,state)
		{
			try
			{
				window.external.EnableButtons(isPageTypeSelection,state);
			}catch(oErr)
			{}
		}
						
		function window.FinishClicked()
		{
		}
		
		function window.NextClicked()
		{
			<%=GetPostBackClientEvent(nextButton,"")%>
		}
		
		</script>
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<input type="hidden" style="display: none" id="PostbackConversionDone" name="PostbackConversionDone" value="">
			<input type="hidden" style="display: none" id="MainHtmlFile" name="MainHtmlFile" value="">
			<asp:Button Visible="False" Runat="server" Text="Test Next" OnClick="Next" ID="nextButton" />
			<asp:PlaceHolder ID="languageSelectorPlaceHolder" Runat="server">
				<EPiServer:Translate Text="/clienttools/wizard/selectpagelanguage" runat="server" ID="Translate1"/>:&nbsp;&nbsp;&nbsp;&nbsp;<asp:DropDownList ID="languageList" Runat="server"></asp:DropDownList>
			</asp:PlaceHolder>
			<p>
				<EPiServer:Translate Text="/clienttools/wizard/createpage" runat="server" ID="Translate2"/>
			</p>
			<Asp:PlaceHolder runat="server" id="placeHolder" />
		</form>
	</body>
</HTML>
