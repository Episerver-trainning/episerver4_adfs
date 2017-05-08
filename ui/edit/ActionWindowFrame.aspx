<%@ Page language="c#" Codebehind="ActionWindowFrame.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Edit.ActionWindowFrame" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>Custom</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name=vs_targetSchema content="http://schemas.microsoft.com/intellisense/ie5">
		<link rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css">
	</HEAD>
	<script type='text/javascript'>
		function onNavigate(newPageLink)
		{
			if (document.all['__epCustomPanelFrame'])
			{
				if (__epCustomPanelFrame.onNavigate)
					return __epCustomPanelFrame.onNavigate(newPageLink);
			}
			return 0;
		}
		
		function onCommand(newCommand)
		{
			if (newCommand.command == 'toggleactionwindow')
			{
				if(newCommand.data!=null && newCommand.data!='')
				{
					if(__epCustomPanelFrame.document.all['CurrentPlugInID'].value!=newCommand.data)
					{
						__epCustomPanelFrame.document.body.innerHTML = '<b>Loading...</b>';
						__epCustomPanelFrame.location.href = 'ActionWindow.aspx?id=' + parent.latestNavigate +'&plugin=' + newCommand.data;
						displayActionWindow();
					}
					else
					{
						toggleActionWindow();
					}
				}
				else
				{
					toggleActionWindow();
				}
				return 0;
			}
			if (document.all['__epCustomPanelFrame'])
			{
				if (__epCustomPanelFrame.onCommand)
					return __epCustomPanelFrame.onCommand(newCommand);
			}
			return 0;
		}
		
		function toggleActionWindow() 
		{
			if (window.parent.document.all['epCustomDIV'])
			{
				if (window.parent.document.all['epCustomDIV'].parentElement.style.display == "none") 
				{
					displayActionWindow();
				}
				else 
				{
					hideActionWindow();
				}
			}
		}
		
		function displayActionWindow()
		{
			var actionWindow = window.parent.document.all['epCustomDIV'];
			if(!actionWindow)
				return;
			if(actionWindow.parentElement.style.display == 'none')
			{
				actionWindow.parentElement.style.display = '';
				if(actionWindow.parentElement.getAttribute('DefaultWidth'))
					actionWindow.parentElement.style.pixelWidth = actionWindow.parentElement.getAttribute('DefaultWidth');
				else
					actionWindow.parentElement.style.pixelWidth = 200;
			}
		}
		
		function hideActionWindow()
		{
			var actionWindow = window.parent.document.all['epCustomDIV'];
			if(!actionWindow)
				return;
			actionWindow.parentElement.style.display = 'none';
			actionWindow.parentElement.setAttribute('DefaultWidth', actionWindow.parentElement.style.pixelWidth);
			actionWindow.parentElement.style.pixelWidth = 1;
		}
		function ChangeWidth(newWidth)
		{
			var actionWindow = window.parent.document.all['epCustomDIV'];
			if(!actionWindow)
				return;
			actionWindow.parentElement.style.pixelWidth = newWidth;		
		}
	</script>
	<body scroll=no class="EPEdit-customBody">
		<table cellpadding=0 cellspacing=0 border=0 width=100% height="100%">
			<tr>
				<td width=5 valign=top align=left><img src="<%=EPiServer.Global.EPConfig.RootDir%>util/images/ActionWindow/cw_tab_top.gif" border=0></td>
				<td bgcolor="#7F9DB9" valign=middle align=left>

					<table cellpadding=2 cellspacing=0 border=0 width=100%>
						<tr>
							<td valign=middle><a class="" href="ActionWindow.aspx" target="__epCustomPanelFrame"><EPiServer:Translate Text="/edit/actionwindow/heading" runat="server" ID="Translate1" NAME="Translate1"/></a></td>
							<td width=13><a href="javascript:hideActionWindow();"><EPiServer:Translate Text="/edit/actionwindow/hide" runat="server" ID="Translate2" NAME="Translate1" /></span></td>
							<td width=13>&nbsp;</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td colspan="2" height="100%">
					<iframe height="100%" width="100%" scrolling="auto" name="__epCustomPanelFrame" id="__epCustomPanelFrame" class="EPEdit-customPanelFrame" src="ActionWindow.aspx" runat="server"></iframe>
				</td>
			</tr>
		</table>
	</body>
</HTML>