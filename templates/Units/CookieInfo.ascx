<%@ Control Language="c#" AutoEventWireup="false" Codebehind="CookieInfo.ascx.cs" Inherits="development.Templates.Units.CookieInfo" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<script type="text/javascript">
<!--
function openCookieInfoDialogue(height, width)
{
	var left = (window.screen.width - width) / 2;
	var top = (window.screen.height - height) / 2;
	var features = 'height=' + height + ',width=' + width + ',left=' + left + ',top=' + top + ',scrollbars=yes';
	var displayHtml = '<html><head>' +
		'<title><%= EPiServer.Global.EPLang.TranslateForScript("/cookie/usagecaption") %></title>' +
		'<link rel="stylesheet" type="text/css" href="<%=Configuration.RootDir%>styles/structure.css" />' +
		'<link rel="stylesheet" type="text/css" href="<%=Configuration.RootDir%>styles/editor.css" />' +
		'<link rel="stylesheet" type="text/css" href="<%=Configuration.RootDir%>styles/units.css" />' + 
		'</head><body style="padding: 10px;">' +
		'<p><%= EPiServer.Global.EPLang.TranslateForScript("/cookie/usageinfo") %></p>' + 
		'<p><%= EPiServer.Global.EPLang.TranslateForScript("/cookie/usageform") %></p>' +
		'<p><%= EPiServer.Global.EPLang.TranslateForScript(CookieLoginTypeInfo) %></p>' +
		'<p><a href="javascript: void 0" onclick="javascript:window.close();">' +
		'<%= EPiServer.Global.EPLang.TranslateForScript("/button/close") %>' +
		'</a></p>' +
		'</body></html>';
	
	var newWindow = window.open('',null,features);
	newWindow.document.write(displayHtml);
	newWindow.document.close();
	return false;
}
//-->
</script>

<a href="javascript: void 0" class="linklist" onclick="javascript:openCookieInfoDialogue(300,300);">
	<EPiServer:Translate Text="/cookie/usagecaption" id="CookieIntro" runat="server" />
</a>