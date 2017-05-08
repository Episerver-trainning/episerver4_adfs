<%@ Page language="c#" SmartNavigation="False" Codebehind="EditCommand.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Edit.EditCommand" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServerSys" TagName="CommandActions" Src="CommandActions.ascx"%>
<%@ Import namespace="EPiServer.Edit" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
	<head>
		<title>EditCommand</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<link rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css">
		<script type='text/javascript' src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/system.js"></script>
		<script type='text/javascript' src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/edit.js"></script>
		<script type='text/javascript'>
		<!--		
		function onNavigate(newPageLink)
		{
			document.forms[0].action = '<%=Configuration.RootDir + Configuration.EditDir%>EditCommand.aspx?id=' + newPageLink;
			var newUrl = document.forms[0].action + "&hidden=true";
			
			if( <%=Actions.CopyPage.ID > 0 || Actions.CutPage.ID > 0 ? "true" : "false"%> || cutPage || copyPage)
			{
				var inputs = document.getElementsByTagName('INPUT');
				var sBody = "";
				sBody += '<form action="' + newUrl + '" method="post">';
				if(cutPage)
					sBody += '<input type="hidden" id="CutPage" name="CutPage" value="' + cutPage + '">';
				else if(copyPage)
					sBody += '<input type="hidden" id="CopyPage" name="CopyPage" value="' + copyPage + '">';
					
				for(var i=0;i<inputs.length;i++)
				{
					sBody += inputs[i].outerHTML;
				}
				sBody += '</form>';
				iconLoader.document.body.innerHTML = sBody;			
				iconLoader.document.forms[0].submit();
			}
			else
				iconLoader.location.href = newUrl;
				
			return 0;
		}
		
		var cutPage;
		var copyPage;
		
		function RefreshIcons()
		{
			if(!iconLoader.document.all['EditCommand'])
				return;
			
			var oldImgs = document.getElementsByTagName('IMG');
			var newImgs = iconLoader.document.getElementsByTagName('IMG');
						
			for(var i=0;i<newImgs.length;i++)
			{
				if(oldImgs[i].src != newImgs[i].src)
				{
					oldImgs[i].src = newImgs[i].src;
				}
				oldImgs[i].onclick = null;
				oldImgs[i].onclick = newImgs[i].onclick;
				newImgs[i].onclick = null;
				newImgs[i].className = '';
			}
		}
		
		function setCopyPage(newPageID)
		{
			copyPage = newPageID;
			cutPage = null;
		}
		function setCutPage(newPageID)
		{
			cutPage = newPageID;
			copyPage = null;
		}
		function onCommand(newCommand)
		{
			switch(newCommand.command)
			{
				case 'cutpage':
					setCutPage(window.parent.latestNavigate);
					break;
				case 'copypage':
					setCopyPage(window.parent.latestNavigate);
					break;
				case 'pastepage':
					if(!cutPage && !copyPage)
						return;
					if(cutPage)
						SimulateFormField('CutPage',cutPage);
					else 
						SimulateFormField('CopyPage',copyPage);
						
					document.forms[0].action = 'EditCommand.aspx?id=' + window.parent.latestNavigate;
					SimulateFormField('Actions:PasteCommandTool','PasteCommandTool');
					__doPostBack('PasteCommandTool','');
					break;
				case 'cutandpastepage':
					var arr = newCommand.data.split(';');
					SimulateFormField('CutPage',arr[0]);
					document.forms[0].action = 'EditCommand.aspx?id=' + arr[1];
					SimulateFormField('Actions:PasteCommandTool','PasteCommandTool');
					__doPostBack('PasteCommandTool','');
					break;
				case 'copyandpastepage':
					var arr = newCommand.data.split(';');
					SimulateFormField('CopyPage',arr[0]);
					document.forms[0].action = 'EditCommand.aspx?id=' + arr[1];
					SimulateFormField('Actions:PasteCommandTool','PasteCommandTool');
					__doPostBack('PasteCommandTool','');
					break;
				case 'systempagenavigate':
					onNavigate(newCommand.data);
					break;
			}
			
			return 0;
		}
		// -->
		</script>
	</head>
	<body class="EPEdit-commandBody">
		<form id="EditCommand" method="post" runat="server">
			<EPiServerSys:CommandActions id="Actions" runat="server"></EPiServerSys:CommandActions>
		</form>
		<asp:PlaceHolder ID="iframeHolder" Runat="server">
			<iframe onload="RefreshIcons()" style="visible: false;" id="iconLoader" src="<%=Configuration.RootDir%>Util/Empty.htm"></iframe>
		</asp:PlaceHolder>
	</body>
</html>
