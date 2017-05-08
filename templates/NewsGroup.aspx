<%@ Page language="c#" Codebehind="NewsGroup.aspx.cs" AutoEventWireup="false" Inherits="development.Templates.NewsGroup" %>
<%@ Register TagPrefix="development" TagName="Header" Src="~/templates/units/header.ascx"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" > 

<html>
	<head>
		<development:header ID="pageHeader" runat="server" />
	</head>
  <frameset cols="23%,*" FRAMESPACING="1" FRAMEBORDER="1" BORDERCOLOR="#95632F">
	<frame frameborder="0" scrolling="yes" name="NewsGroupTree" src="NewsGroupTree.aspx?id=<%=CurrentPageLink%>" id="NewsGroupTree" />
	<frame frameborder="0" scrolling="yes" name="NewsGroupView" src="NewsGroupView.aspx?id=<%=CurrentPageLink%>" id="NewsGroupView" />
  </frameset>
</html>