<%@ Page language="c#" Codebehind="EditXFormFrame.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Edit.EditXFormFrame" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" > 
<html>
	<head>
		<title><%=EPiServer.Global.EPLang.Translate("/edit/editxform/heading")%></title>
	</head>
	<frameset cols="*" FRAMESPACING="0" FRAMEBORDER="0">
		<frame name="EditForm" src="EditXForm.aspx?formid=<%= Request.QueryString["formid"] %>&pageId=<%= Request.QueryString["pageId"] %>&parentId=<%= Request.QueryString["parentId"] %>" FRAMEBORDER="0"></frame>
	</frameset>
</html>
