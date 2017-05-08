<%@ Control Language="c#" AutoEventWireup="false" Codebehind="EditorGuide.ascx.cs" Inherits="EPiServer.Edit.EditorGuide" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<script type='text/javascript'>
	function displaySection(sectionid)
	{
		document.getElementById('DisplayText').innerHTML = document.getElementById(sectionid).innerHTML;
	}	
	function showOrHideSubSection(subsectionid, imageid, linkid)
	{
		var subsection = document.getElementById(subsectionid);
		var image = document.getElementById(imageid);
		var link = document.getElementById(linkid);
		if (subsection.className == 'hidden')
		{
			subsection.className = 'visible subsection';
			image.src = image.src.replace('arrowdown.gif', 'arrowup.gif');
			link.title = '<%= EPiServer.Global.EPLang.TranslateForScript("/edit/editorguide/hidesection") %>';
		}
		else if (subsection.className == 'visible subsection')
		{
			subsection.className = 'hidden';
			image.src = image.src.replace('arrowup.gif', 'arrowdown.gif');
			link.title = '<%= EPiServer.Global.EPLang.TranslateForScript("/edit/editorguide/showsection") %>';
		}	
	}
</script>
<asp:Panel ID="Content" Runat="server" />