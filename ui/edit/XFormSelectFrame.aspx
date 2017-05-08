<%@ Page language="c#" Codebehind="XFormSelectFrame.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Edit.XFormSelectFrame" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" > 

<html>
	<head>
		<title><%=EPiServer.Global.EPLang.Translate("/edit/editxformdata/selectform")%></title>
	</head>
	<frameset cols="*" FRAMESPACING="0" FRAMEBORDER="0">
		<frame name="EditForm" src="XFormSelect.aspx?form=<%= Request.QueryString["form"] %>&pageId=<%= Request.QueryString["pageId"] %>&parentId=<%= Request.QueryString["parentId"] %>" FRAMEBORDER="0"></frame>
	</frameset>
</html>
