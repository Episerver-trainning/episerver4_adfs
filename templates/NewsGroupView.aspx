<%@ Page language="c#" Codebehind="NewsGroupView.aspx.cs" AutoEventWireup="false" Inherits="development.Templates.NewsGroupView" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" > 

<html>
	<head>
	</head>
	<frameset rows="50%,50%">
		<frame frameborder="0" scrolling="yes" name="NewsGroupList" src="<%
			if(this.CurrentPage["AllowNewsItem"]==null && this.CurrentPage.PageTypeID != ItemPageType)
				Response.Write("NewsGroupIntro.aspx");
			else
				Response.Write("NewsGroupList.aspx");
		
		%>?id=<%=CurrentPageLink%>" />
		
		<frame frameborder="0" scrolling="yes" name="NewsItem" <%
			if(this.CurrentPage.PageTypeID == ItemPageType)
				Response.Write("src=\"NewsGroupItem.aspx" + "?id=" + CurrentPageLink.ID + "\"");
		
		%> />/>
	</frameset>
</html>
