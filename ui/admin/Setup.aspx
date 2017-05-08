<%@ Page language="c#" Codebehind="Setup.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Admin.Setup" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" > 

<html>
  <head>
    <title>Setup</title>
    <meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
    <meta name="CODE_LANGUAGE" Content="C#">
    <meta name=vs_defaultClientScript content="JavaScript">
    <meta name=vs_targetSchema content="http://schemas.microsoft.com/intellisense/ie5">
    <link rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css">
	<script type='text/javascript' src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/system.js"></script>
	<script type='text/javascript'>
	
	var isClicked = false;
	
	function CanCancelOperation()
	{
		return !isClicked;
	}
	
	function DisplayProgressBar()
	{
		if(isClicked)
			return false;
		isClicked = true;
		
		var oElement = document.createElement('div');
		oElement.style.border = '1px solid black';
		oElement.style.padding = '20 100 20 100';
		oElement.style.background = '#ffffff';
		oElement.style.color = '#000000';
		oElement.innerHTML = '<span id="blinkme"><%=Translate("#progress")%></span>';
		oElement.style.position = 'absolute';
		oElement.style.left = 50;
		oElement.style.top = 50;
		document.body.appendChild(oElement);
		window.setInterval("Blink();",1000);
		
		return true;
	}
	
	function Blink()
	{
		if(document.all['blinkme'].style.color=='#000000')
			document.all['blinkme'].style.color='#ffffff';
		else
			document.all['blinkme'].style.color='#000000';
			
	}
	
	</script>
  </head>
  <body MS_POSITIONING="GridLayout">
	
    <form id="ImportData" method="post" runat="server">
			<EPiServerSys:SystemPrefix id="PagePrefix" runat="server"/>
			<br>&nbsp;<br>
			<table cellpadding=5 cellspacing=5 id="optionTable" runat="server">
				<tr>
					<td valign=top>
						<b><EPiServer:Translate Text="#selectcontent" runat="server" ID="Translate1"/></b>
					</td>
					<td valign=top>
						<asp:RadioButtonList RepeatLayout=Flow ID="selectSampleData" Runat="server"/>
					</td>
				</tr>
				<tr>
					<td valign=top>
						<b><EPiServer:Translate Text="#selectlanguage" runat="server" ID="Translate2"/></b>
					</td>
					<td valign=top>
						<asp:RadioButtonList RepeatLayout=Flow Runat="server" ID="selectLanguage"/>
					</td>
				</tr>
				<tr>
				<td colspan=2>
					<asp:Button runat="server" Translate="#setupbutton" id="SetupButton" OnClick="DoSetup"/>
					<asp:Button runat="server" Translate="/button/cancel" id="CancelButton" OnClick="CancelSetup"/>						
				</td>
				</tr>
			</table>
     </form>
	
  </body>
</html>
