<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<%@ Page language="c#" Codebehind="PageBrowser.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Edit.PageBrowser" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title><%=EPiServer.Global.EPLang.Translate("/system/pagebrowser/heading")%></title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<link rel="stylesheet" type="text/css" href="<%=EPiServer.Global.EPConfig.RootDir%>util/styles/system.css">
		<base target="_self">
		<script type='text/javascript' src="<%=EPiServer.Global.EPConfig.RootDir%>util/javascript/system.js"></script>		
		<script type='text/javascript'>
		<!--
		function onOK()
		{
			SetValues(document.all['selectedPageLink'].value, document.all['selectedPageName'].value + ' [' + document.all['selectedPageLink'].value + ']');
			window.close();
		}

		function onNothing()
		{
			SetValues('0','');
			window.close();
		}

		function onSelf()
		{
			SetValues('-','<%#TranslateForScript("/system/pagebrowser/infoselflink")%>');
			window.close();
		}

		function onCancel()
		{
			window.close();
		}

		function onLoad()
		{
			window.focus();
			if (this.activeItem) 
			{
				this.activeItem.scrollIntoView(false);
			}
		}
		
		function SetValues(value, info)
		{
			if(window.opener)
			{	
				this.window.opener.document.all['<%#ValueVariable%>'].value = value;
				this.window.opener.document.all['<%#InfoVariable%>'].value = info;
				this.window.opener.document.all['<%#InfoVariable%>'].fireEvent("onchange");
			}
			else
			{
				var doc = window.dialogArguments;
				doc.all['<%#ValueVariable%>'].value = value;
				doc.all['<%#InfoVariable%>'].value = info;
				doc.all['<%#InfoVariable%>'].fireEvent("onchange");
			}
			this.window.returnValue = 1;
		}
		
		function SetLocalValues(value, info)
		{
			document.all['selectedPageLink'].value=value;
			document.all['selectedPageName'].value=info;
		}

		function setEnabledStateOfSelfButton()
		{
			var doc = window.dialogArguments;
			if (doc && doc.all['disablePageBrowserSelfLinkButton'] && doc.all['disablePageBrowserSelfLinkButton'].value == 'true')
				document.getElementById('selfButton').disabled = true;
		}
		
		function handleKeyPressed()
		{
			if(event.keyCode == 13 && event.srcElement.type != 'submit' && event.srcElement.type != 'button')
			{
				if(document.all['<%=searchKey.UniqueID%>'].value!='')
					document.all['<%=searchButton.UniqueID%>'].click();
				return false;
			}
			return true;
		}

		// -->
		</script>
	</HEAD>
	<body onkeydown="return handleKeyPressed()">
		<form id="PageBrowser" method="post" runat="server">
			<input type="hidden" id="selectedPageLink" name="selectedPageLink" runat="server">
			<input type="hidden" id="selectedPageName" name="selectedPageName" runat="server">
			<div style="width: 100%;height: 100%;height: 420px;width: 380px;OVERFLOW: auto">
			<EPiServerSys:tabstrip id="browserActionTab" Runat="server" TargetID="browserTabView">
				<EPiServerSys:tab Text="/edit/editcommand/viewmode"	Runat="server" id="Structure"/>
				<EPiServerSys:tab Text="/edit/editcommand/favoritesmode" Runat="server"	id="Favorites"/>
			</EPiServerSys:tabstrip>
			<asp:Panel ID="browserTabView" Runat="server">
				<asp:Panel ID="TreeViewPanel" Runat="server">
					<episerver:ExplorerTree ShowToolTip="True" PublishedStatus="Ignore" ShowIcons="True" ShowStatusIcons="True" EnableVisibleInMenu="False" PageLink=<%#Configuration.RootPage%> ShowRootPage="True" ClickScript="SetLocalValues('{PageLink}','{PageName}');" id="explorerTree" runat="server" />
				</asp:Panel>
				<asp:Panel ID="FavoriteViewPanel" Runat="server">
					<asp:PlaceHolder Runat="server" ID="CustomExplorerTreePanel"/>
				</asp:Panel>
			</asp:Panel>
			</div>
			<br />
			<input type="button" onclick="onOK();" translate="/button/ok" runat="server" id="okButton">
			<input type="button" onclick="onNothing();" translate="/system/pagebrowser/buttonnolink" runat="server" id="nothingButton">
			<input type="button" onclick="onSelf();" translate="/system/pagebrowser/buttonselflink" runat="server" id="selfButton">
			<input type="button" onclick="onCancel();" translate="/button/cancel" runat="server" id="cancelButton">
			<br />
			<br />
			<asp:TextBox ID="searchKey" Runat="server" />&nbsp;<asp:Button Translate="/button/search" Text="Search" Runat="server" ID="searchButton" />
		</form>
	</body>
	<script type='text/javascript'>
	<!--	
		setEnabledStateOfSelfButton();
	// -->
	</script>
</HTML>
