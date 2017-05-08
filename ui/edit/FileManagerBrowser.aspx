<%@ Page language="c#" Codebehind="FileManagerBrowser.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Edit.FileManagerBrowser" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServerFM" TagName="FM" Src="FileManagementControl.ascx"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" > 

<html>
  <head>
	<title><%=Title%></title>
    <meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
    <meta name="CODE_LANGUAGE" Content="C#">
    <meta name=vs_defaultClientScript content="JavaScript">
    <meta name=vs_targetSchema content="http://schemas.microsoft.com/intellisense/ie5">
    <link rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css">
    <link rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/linkeditor.css">
    <script type='text/javascript' src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/system.js"></script>
	<base target="_self">
  </head>
  <body MS_POSITIONING="GridLayout">
	
    <form id="LinkImage" encType="multipart/form-data" method="post" runat="server">

		<div class="FMB-DialogContent">
		
			<EPiServerFM:FM ID="FileManager" runat="Server" BottomOffsetArea="ButtonDiv" />
				
			<div id="ButtonDiv">
				<div class="FMB-ButtonArea">
					<asp:Button IsToolEnabled="true" ID="InsertButton" Translate="/button/insert" Runat="server" />
					<asp:Button ID="ClearButton" Translate="/button/clear" Runat="server" />
					<asp:Button ID="CancelButton" Translate="/button/cancel" Runat="server" />
					<br />
					<br />
				</div>
			</div>

		</div>

     </form>
	
  </body>
</html>
