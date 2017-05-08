<%@ Page language="c#" Codebehind="EditFormFrame.aspx.cs" AutoEventWireup="false" Inherits="EPiServer.Edit.EditFormFrame" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" > 

<html>
<frameset cols="*" FRAMESPACING="0" FRAMEBORDER="0">
	<frame name="EditForm" src="EditForm.aspx?form=<%= Request.QueryString["form"] %>&newver=<%= Request.QueryString["newver"] %>" FRAMEBORDER="0"></frame>
</frameset>
</html>
