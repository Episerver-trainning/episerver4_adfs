<%@ Page language="c#" Codebehind="ActionWindow.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Edit.ActionWindow" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" > 

<html>
  <head>
    <title>PlugIn</title>
    <meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
    <meta name="CODE_LANGUAGE" Content="C#">
    <meta name=vs_defaultClientScript content="JavaScript">
    <meta name=vs_targetSchema content="http://schemas.microsoft.com/intellisense/ie5">
	<script type='text/javascript' src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/system.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css">
	<script type='text/javascript'>
		
		function onNavigate(newPageLink)
		{
			return 0;
		}
		
		function onCommand(newCommand)
		{
			switch(newCommand.command)
			{
				case 'actionwindow':
					document.body.innerHTML = 'Loading..';
					window.parent.displayActionWindow();
					window.location.href = newCommand.url;
					break;
			}
			
			return 0;
		}
	
	</script>
  </head>
   <body class="EPEdit-customPanelBody" XmlNs:EPiServer="http://schemas.episerver.com/WebControls">
    <form id="PlugIn" method="post" runat="server">
    <input type="hidden" id="CurrentPlugInID" name="CurrentPlugInID" runat="server" />
 	<asp:PlaceHolder ID="PlugInSpace" Runat="server" />
	<asp:PlaceHolder ID="ListSpace" Runat="server">
			<asp:DataList ID="plugInList" Runat="server" OnItemCommand="SelectPlugIn">
			<ItemTemplate>
					<b><a href="ActionWindow.aspx?plugin=<%#DataBinder.Eval(Container.DataItem,"ID")%>"><%#GetDisplayName(Container.DataItem)%></a></b><br>
					<%#GetDescription(Container.DataItem)%>			
			</ItemTemplate>
			<SeparatorTemplate><hr size="1" color="#6D8CA8"></SeparatorTemplate>	
			</asp:DataList>
	</asp:PlaceHolder>
	
     </form>
	
  </body>
</html>
