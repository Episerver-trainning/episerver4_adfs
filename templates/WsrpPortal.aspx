<%@ Register tagprefix="wsrp" namespace="ElektroPost.Wsrp.Consumer.WebControls" assembly="ElektroPost.Wsrp" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="development" TagName="Header" Src="~/templates/Units/Header.ascx"%>
<%@ Register TagPrefix="development" TagName="WsrpPortletList"	Src="~/templates/Units/WsrpPortletList.ascx"%>
<%@ Register TagPrefix="development" TagName="WsrpPortalTabControl"	Src="~/templates/Units/WsrpPortalTabControl.ascx"%>
<%@ Page language="c#" Codebehind="WsrpPortal.aspx.cs" AutoEventWireup="false" Inherits="development.Templates.WsrpPortal" %>
<?xml version="1.0"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
	<head>
		<development:header ID="Header" runat="server" />
		<link href="<%=Configuration.RootDir%>styles/portal_green.css" type="text/css" rel="stylesheet" />
		<script type="text/javascript">
		var dropElement;

		function onLoad() {
			if (isIE()) {
				RegisterDragAndDrop();
			}
			else {
				SetNonIEAbsoluteLayout();
			}
		}

		function SetNonIEAbsoluteLayout() {
			document.getElementsByName('__layoutContainer')[0].className = 'layoutcontainerabsolute';
		}

		function RegisterDragAndDrop()
		{
			document.body.ondragstart	= onDragStart;
			document.body.ondragover	= onDragOver;
			document.body.ondrop		= onDrop;
		}

		function onItemMouseMove (item) {
			if (event.button !=1) return;
			document.selection.empty();
			createDropElement();
			item.dragDrop();
			trace('selection prevented')
		}
		
		function onDragStart()
		{
			if (!event.dataTransfer) {
				return;
			}

			if (! dropElement) {
				createDropElement();				
			}
			event.dataTransfer.effectAllowed='move';
			var data;
			var instanceElement 
			instanceElement = findElementWithAttribute( event.srcElement, 'WindowId' );
			if (instanceElement) {
				data = '_instance|' + instanceElement.getAttribute('WindowId');
			}
			else {
				var portletElement = findElementWithAttribute( event.srcElement, 'PortletId' );
				var producerElement = findElementWithAttribute( portletElement, 'ProducerId' );
				data = producerElement.getAttribute('ProducerId') + '|' + portletElement.getAttribute('PortletId');
				dropElement.innerHTML = portletElement.innerHTML;
			}
			window.event.dataTransfer.setData( "Text", data );
			window.event.cancelBubble = true;
			
		}

		function onDragOver()
		{
			var portletElement = findElementWithAttribute( event.srcElement, 'PortletIndex' );
			var areaElement = findElementWithAttribute( event.srcElement, 'Area' );
			if (!areaElement) {
				return;
			}

			window.event.returnValue = false;
			window.event.cancelBubble = true;

			// avoid messy flickering
			areaElement.ondragleave = onDragLeave;

			document.all._AREA.value = areaElement.getAttribute('Area');
			var idx = findInsertIndex(areaElement.firstChild, portletElement);
			document.all._POS.value = idx;

			if (event.srcElement.name != '_dropElement') {
				setDropElement( areaElement.firstChild, idx );
			}
		}
		
		function onDragLeave() {
			var portletElement = findElementWithAttribute( event.srcElement, 'PortletIndex');
			var areaElement = findElementWithAttribute( event.srcElement, 'Area' );
			if (!areaElement) return;

			window.event.returnValue = false;
			window.event.cancelBubble = true;

			if (! portletElement) {
				dropElement.style.display = 'none';
			}
		}

		function onDrop()
		{
			var source = window.event.dataTransfer.getData("Text").split('|');
			var producer = source[0];
			var portletId = source[1];

			if (producer == '_instance') {
				document.all._PORTLET.value = portletId;
				document.all._ACTION.value = '_MOVEPORTLET';
			}
			else
			{
				document.all._PROD.value = producer;
				document.all._PORTLET.value = portletId;
				document.all._ACTION.value = '_ADDPORTLET';
			}

			dropElement.style.display = 'none';
			
			DoPost();
		}

		function isIE() {
			return window.navigator.appName.toLowerCase().indexOf("microsoft") > -1;
		}

		function DoPost()
		{
			var theform;
			if (isIE()) {
				theform = document.PortalFxForm;
			}
			else {
				theform = document.forms["PortalFxForm"];
			}
			theform.submit();
		}

		function isDropElementAbove(area, idx) {
			for (i = 0; i < idx && i < area.childNodes.length; i++) {
				if ( area.childNodes[i] == dropElement ) {
					return true;
				}
			}
			return false;
		}
		
		function setDropElement(area, idx) {
			dropElement.style.position = 'relative';
			dropElement.style.top= '';
			dropElement.style.left= '';
			try {
				if (area.childNodes) {
					idx = isDropElementAbove(area, idx) ? idx + 1 : idx;
					area.insertBefore(dropElement, area.childNodes[ idx ]);
					dropElement.style.display = '';
				}
			}
			catch (x) {
				area.appendChild(dropElement);
			}
		}
		
		// Recursively searches the chain of parents for an element which defines a specific attribute
		function findElementWithAttribute(element, attribute) {
			try {
				while (!element.getAttribute(attribute)) {
					if (element.parentNode != document.body && element.parentNode) {
						// ok, let's search the parent of element
						return findElementWithAttribute(element.parentNode, attribute);
					}
					else { 
						// where at the root elemenet and haven't found what we were looking for...
						return null; 
					}
				}
			}
			catch (exception) { 
				return null; 
			}
			// we found the element!
			return element;
		}

		function createDropElement() {
			dropElement = document.createElement("DIV");
			dropElement.style.display = 'none';
			dropElement.className = 'dropareahighlight';
			dropElement.ondragover = onDragOver
			dropElement.name = '_dropElement';
			dropElement.innerText = 'x';
		}

		function findAreaOffset(area, portlet, offsetY) {
			if (! portlet) 
			{ 
				return offsetY < 1 ? 1 : offsetY; 
			}
			var i, y = 0;
			for ( i = 0; i < area.childNodes.length; i++ ) {
				if (area.childNodes[i] != portlet) {
					y += area.childNodes[i].offsetHeight;
				}
				else {
					return y + offsetY;
				}
			}
			return 0;
		}
		
		function findInsertIndex(area, portlet) {
			var offset = findAreaOffset( area, portlet, event.offsetY );
			var yi = 0, hi = 0, hj = 0, i;
			var idx = 0;
			for ( i = 0; i < area.childNodes.length; i++ ) {
				if ( area.childNodes[i].getAttribute('PortletIndex') ) { 
					hi = area.childNodes[i].offsetHeight;
					if ((offset >= (yi - hj/2)) && (offset < (yi + hi/2))) {
						return idx;
					}
					
					yi += hi;
					hj = hi;
					idx++;
				}
			}
			return idx;
		}
		
		function removePortlet(src, windowId) {
			var areaElement = findElementWithAttribute( src, 'AREA' );
			document.getElementsByName('_ACTION')[0].value = '_REMOVEPORTLET';
			document.getElementsByName('_PORTLET')[0].value = windowId;
			document.getElementsByName('_AREA')[0].value = areaElement.getAttribute('AREA');
			
			DoPost();
		}
		
		function resetUserSettings() {
			document.getElementsByName('_ACTION')[0].value = '_RESETUSERSETTINGS';
			
			DoPost();
		}
		
		function hideForm() {
			document.getElementById('_FORM').style.display = 'none';
		}
		
		function trace(text) {
			document.all.trace.innerHTML = text + '<br />' + document.all.trace.innerHTML;
		}
		function clearTrace() {
			document.all.trace.innerHTML = '&nbsp;';
		}

		</script>
	</head>
	<body MS_POSITIONING="FlowLayout" onload="onLoad()">
		<div name="trace" id="trace" style="display: none; position:absolute;left:600px;top:300px;overflow:auto;height:300px;width:150px;background-color:white;border:1px solid black">&nbsp;</div>
		<asp:Label id="ErrorMsg" Runat="server" />
		<asp:Panel ID="MainPanel" runat="server">
			<div id="_FORM">
				<form id="PortalFxForm" method="post" runat="server">

					<input type="hidden" name="_TAB" />
					<input type="hidden" name="_AREA" />
					<input type="hidden" name="_POS" />
					<input type="hidden" name="_PROD" />
					<input type="hidden" name="_PORTLET" />
					<input type="hidden" name="_ACTION" />

					<div class="toparea">
						<div class="paddingextra">
							<div class="leftblock"><img runat=server src="~/images/wsrp/EPiServerPortalFramework.gif" alt="EPiServer Portal Framework" /></div>
							<div class="actionbox">
								<a href="<%= this.GetPage( this.Configuration.StartPage ).LinkURL %>"><episerver:Translate runat=server text="/templates/wsrpfx/portal/home" /></a>
								<a style='display: <%= this.CurrentUser.Identity.IsAuthenticated ? "" : "none" %>' href='<%= this.CurrentPage.LinkURL %>' onclick="resetUserSettings()" ><episerver:Translate runat=server text="/templates/wsrpfx/portal/resetportal" ID="Translate1"/></a>&nbsp;<episerver:Translate runat=server text="/templates/wsrpfx/portal/displaymode"/>&nbsp;
								<asp:DropDownList id="ModeSelector" runat="server" AutoPostBack="True">
								</asp:DropDownList>
							</div>
						</div>
					</div>
					<development:WsrpPortalTabControl runat="server" id="TabControl" OnTabChanged="Tab_Changed"></development:WsrpPortalTabControl>

					<div runat="server" Id="SettingsPanel" class="paddingextrasides">
						<div class="settingscolumn">
							<div class="settingsarea">
								<span id="AdminActions" runat="server">
									<asp:LinkButton id="LinkButton1" OnClick="AddTab_Click" Runat="server"><episerver:Translate runat="server" text="/templates/wsrpfx/portal/newtab" /></asp:LinkButton>
									<asp:LinkButton id="LinkButton2" OnClick="RemoveTab_Click" Runat="server"><episerver:Translate runat="server" text="/templates/wsrpfx/portal/deletetab" /></asp:LinkButton></span><br />
									<asp:LinkButton ID="LinkButton3" OnClick="SaveMaster_Click" Runat="server"><episerver:Translate runat="server" text="/templates/wsrpfx/portal/savesource"/></asp:LinkButton>
								<div class="paddingtop">
									<episerver:Translate runat="server" text="/templates/wsrpfx/portal/tabname" /><br />
									<asp:TextBox id="TabName" Runat="server" Text="<%# TabControl.CurrentTabName %>">
									</asp:TextBox><br />
									<episerver:Translate runat="server" text="/templates/wsrpfx/portal/disposition" /><br />
									<asp:DropDownList id="LayoutList" Runat="server"></asp:DropDownList><br />
									<br />
									<asp:Button id="Button1" onclick="SaveTabSettings_Click" Runat="server" Translate="/templates/wsrpfx/portal/savetabsettings"></asp:Button></DIV>
								<development:WsrpPortletList id="PortletList" runat="server"></development:WsrpPortletList>
								<div>
									<EPiServer:Translate runat="Server" text="/templates/wsrpfx/portal/selectedportlet" /><br />
									<input type="text" disabled="disabled" name="_PORTLETTITLE" /><br />
									<EPiServer:Translate runat="Server" text="/templates/wsrpfx/portal/selectedarea" /><br /><select runat=server id="AreaSelect"></select><br />
									<br />
									<input type="button" onclick="document.getElementsByName('_AREA')[0].value=document.getElementsByName('AreaSelect')[0].options[document.getElementsByName('AreaSelect')[0].selectedIndex].value; DoPost()" value="<%= EPiServer.Global.EPLang.Translate("/templates/wsrpfx/portal/addportlet") %>" />
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>

			<div class="paddingextrasides">
				<wsrp:PortletArea runat=server id="LayoutContainer" name="__layoutContainer">

					<PortletHeaderTemplate>
				<div <%# ViewMode == "Design" ? " class=\"designareacolumn\" " : ""%>> 
					<div <%# ViewMode == "View" ? " style=\"display:none;\" " : ""%>>
						<div class="portalpieceheader">
							<div class="portalheadername"><%# Container.ClientPortlet.Title == null ? "---" : Container.ClientPortlet.Title %></div>
							<div class="portalheadericons">&nbsp;
								<nobr>
									<wsrp:PortletButton runat="server" CssClass="portalpieceheadericon" ImageUrl="~/images/wsrp/back_gray.gif" HoverImageUrl="~/images/wsrp/back.gif" PortletMode="view"  ID="Portletbutton3" LinkText='<%# EPiServer.Global.EPLang.Translate("/templates/wsrpfx/button/view") %>' />
									<wsrp:PortletButton runat="server" CssClass="portalpieceheadericon" ImageUrl="~/images/wsrp/edit_gray.gif" HoverImageUrl="~/images/wsrp/edit.gif" PortletMode="edit"  ID="Portletbutton1" LinkText='<%# EPiServer.Global.EPLang.Translate("/templates/wsrpfx/button/edit") %>' />
									<wsrp:PortletButton runat="server" CssClass="portalpieceheadericon" ImageUrl="~/images/wsrp/preview_gray.gif" HoverImageUrl="~/images/wsrp/preview.gif" PortletMode="preview" LinkText='<%# EPiServer.Global.EPLang.Translate("/templates/wsrpfx/button/preview") %>' />
									<wsrp:PortletButton runat="server" CssClass="portalpieceheadericon" ImageUrl="~/images/wsrp/help_gray.gif" HoverImageUrl="~/images/wsrp/help.gif" PortletMode="help" LinkText='<%# EPiServer.Global.EPLang.Translate("/templates/wsrpfx/button/help") %>' />
								</nobr>&nbsp;<nobr>
									<wsrp:PortletButton runat="server" CssClass="portalpieceheadericon" ImageUrl="~/images/wsrp/minimize_gray.gif" HoverImageUrl="~/images/wsrp/minimize.gif" WindowState="Minimized" LinkText='<%# EPiServer.Global.EPLang.Translate("/templates/wsrpfx/button/minimized") %>' />
									<wsrp:PortletButton runat="server" CssClass="portalpieceheadericon" ImageUrl="~/images/wsrp/restore_gray.gif" HoverImageUrl="~/images/wsrp/restore.gif" WindowState="Normal" LinkText='<%# EPiServer.Global.EPLang.Translate("/templates/wsrpfx/button/normal") %>' />
									<wsrp:PortletButton runat="server" CssClass="portalpieceheadericon" ImageUrl="~/images/wsrp/maximize_gray.gif" HoverImageUrl="~/images/wsrp/maximize.gif" WindowState="Maximized" LinkText='<%# EPiServer.Global.EPLang.Translate("/templates/wsrpfx/button/maximized") %>' />
									<wsrp:PortletButton runat="server" CssClass="portalpieceheadericon" ImageUrl="~/images/wsrp/solo_gray.gif" HoverImageUrl="~/images/wsrp/solo.gif" WindowState="Solo" LinkText='<%# EPiServer.Global.EPLang.Translate("/templates/wsrpfx/button/solo") %>' />
								</nobr>
							</div>
						</div>
					</div>
					<div <%# ViewMode == "View" ? "class=\"portalpiece_view\"" : "class=\"portalpiece\"" %>>
						<div <%# ViewMode == "View" ? "class=\"portalpiececontent_view\"" : "class=\"portalpiececontent\"" %>>
							<div  <%# ViewMode == "View" ? "class=\"padding_view\"" : "class=\"padding\"" %>>
					</PortletHeaderTemplate>

					<PortletFooterTemplate>
							</div>
						</div>
					</div>
				</div>
					</PortletFooterTemplate>

				</wsrp:PortletArea>
			</div>
		</asp:Panel>
	</body>
</HTML>
