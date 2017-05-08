<%@ Page language="c#" Codebehind="Edit.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Util.ClientTools.Wizard.Edit" %>
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
			if(!amIClickedYet)
			{
				amIClickedYet = true;
				<%=GetPostBackClientEvent(previousButton,"")%>
			}
		}
		
		function window.EnableButtons(isPageTypeSelection,state)
		{
			try
			{
				window.external.EnableButtons(isPageTypeSelection,state);
			}catch(oErr)
			{}
		}
		
		function window.FinishCompleted(newPageID,newWorkID,pageName,access)
		{
			try
			{
				window.external.FinishCompleted(newPageID,newWorkID,pageName,access);
			}catch(oErr)
			{}
		}
		
		function window.FinishClicked()
		{
			if(!amIClickedYet)
			{
				amIClickedYet = true;
				<%=GetPostBackClientEvent(finishButton,"")%>
			}
		}
		
		function window.NextClicked()
		{
			if(!amIClickedYet)
			{
				amIClickedYet = true;
				<%=GetPostBackClientEvent(nextButton,"")%>
			}
		}
		
		function ViewDebugArea()
		{
			debugArea.style.display = '';
			window.document.selection.empty();
			event.cancelBubble = true;
			return false;
		}
		
		</script>
	</HEAD>
	<body ondblclick="if(window.event.ctrlKey) return ViewDebugArea();">
		<form id="Form1" method="post" runat="server">
			<span id="debugArea" style="display: none;background:yellow;color:red;width:100%">
				<b>== OFFICE SHELL TOOLS DEBUG WINDOW ==</b><br>
				<asp:Label ID="buttonState" Runat="server" /><br>
				<asp:Label ID="currentStepDbg" Runat="server" /><br>
				<asp:Label ID="lastStepDbg" Runat="server" /><br>
				<asp:Label ID="fileDbg" Runat="server" /><br>
				<asp:Label ID="dataDbg" Runat="server" /><br>
				<asp:button id="previousButton" onclick="Prev" Text="Test Previous" Runat="server"></asp:button>
				<asp:Button Runat="server" Text="Test Next" OnClick="Next" ID="nextButton" />
				<asp:Button Runat="server" Text="Test Finish" OnClick="Finish" ID="finishButton" /><br>
				
			</span>
			<ClientTools:WizardManager PageTypeID="3" runat="server" id="WizardManager1" />
		</form>
	</body>
</HTML>
