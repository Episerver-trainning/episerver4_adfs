<%@ Control Language="c#" AutoEventWireup="false" Codebehind="DocumentList.ascx.cs" Inherits="development.Templates.Units.DocumentList" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="development" TagName="PageBody"		Src="~/templates/Units/PageBody.ascx"%>
<%@ Register TagPrefix="development" TagName="PageHeader"	Src="~/templates/Units/PageHeader.ascx"%>
<development:PageHeader ID=pageheader runat="server" />
<development:PageBody ID=pagebody runat="server" />
<div class="DocumentListBox">
<episerver:PageList id="ListControl" PageLink="<%#CurrentPage.PageLink%>" runat="server">	
	<ItemTemplate>
		<div class="<%#GetClass()%>">
			<b><img src="<%=Configuration.RootDir%>images/closedMenuArrow.gif" alt=""><EPiServer:Property PropertyName="PageLink" runat="server"/>&nbsp;&nbsp;<%#CreateDocumentLink(Container.CurrentPage)%></b>
			<div class="DocumentMainIntro"><EPiServer:Property PropertyName="MainIntro" runat="server"/></div>
		</div>
	</ItemTemplate>
</episerver:PageList>
</div>