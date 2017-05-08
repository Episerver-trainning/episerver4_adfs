<%@ Control Language="c#" AutoEventWireup="false" Codebehind="Conference.ascx.cs" Inherits="development.Templates.Units.Conference" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<div class="conferance">
<asp:Panel ID="StartPage" Runat="server" Visible="false">
	<div class="leftfloating">
		<div class="conferanceheadingarea">
			<h1><episerver:property runat="server" PropertyName="PageName" /></h1>
		</div>
		<div class="conferancelinkbuttonsarea">
			<asp:LinkButton ID="CreateNew" Runat="server" OnClick="CreatePost">
				[<episerver:translate Text="/templates/conference/createnew" runat="server" />]
			</asp:LinkButton>
		</div>
	</div>
	<br />
	<br />
	<episerver:property id="pageBody" runat="server" propertyname="MainBody" />
	<br />
	<hr />
	<b><episerver:translate Text="/templates/conference/post" runat="server" /></b>
</asp:Panel>
<asp:Panel ID="EditPanel" runat="server" Visible="false">
	<div class="inputlabel"><episerver:translate Text="/templates/conference/heading" runat="server" />:</div>
	<episerver:property id="PageName" propertyname="PageName" runat="server" EditMode="true" />
	<br />
	<div class="inputlabel"><episerver:translate Text="/templates/conference/author" runat="server" />:</div>
	<episerver:property id="WriterName" propertyname="WriterName" runat="server" EditMode="true" />
	<br />
	<episerver:property id="MainBody" PropertyName="MainBody" runat="server" EditMode="true" />
	<br />
	<asp:Button Runat="server" Translate="/button/publish" ID="SaveAndPublish" OnClick="SavePost" />
	<asp:Button Runat="server" Translate="/button/cancel" ID="CancelButton" OnClick="CancelEdit" />
</asp:Panel>
<asp:Panel ID="ViewPanel" Runat="server" Visible="false">
	<div class="conferanceheader">
		<div class="leftfloating">
			<h1><episerver:property runat="server" PropertyName="PageName" /></h1>
			<br />
			<b><episerver:property runat="server" PropertyName="WriterName" /></b>
		</div>
		<div class="conferancelinkbuttonsarea">
			<asp:HyperLink ID="PreviousPageLink"	Runat="server">[<episerver:translate Text="/templates/conference/previous" runat="server" />]</asp:HyperLink>
			<asp:HyperLink ID="NextPageLink"		Runat="server">[<episerver:translate Text="/templates/conference/next" runat="server" />]</asp:HyperLink>
			<asp:LinkButton ID="Reply"				Runat="server" OnClick="CreatePost">[<episerver:translate Text="/templates/conference/reply" runat="server" />]</asp:LinkButton>
			<asp:LinkButton ID="Change"				Runat="server" OnClick="ChangePost">[<episerver:translate Text="/templates/conference/change" runat="server" />]</asp:LinkButton>
			<asp:LinkButton ID="DeleteButton"		Runat="server" OnClick="DeletePost">[<episerver:translate Text="/templates/conference/delete" runat="server" />]</asp:LinkButton>
		</div>
	</div>
	<br />
	<episerver:property runat="server" propertyname="MainBody" />
	<hr />
	<b><episerver:translate Text="/templates/conference/replies" runat="server" /> </b>(<a href="<%=GetPage(CurrentPage.ParentLink).LinkURL%>"><episerver:translate Text="/templates/conference/uponelevel" runat="server" /></a>)				
</asp:Panel>
<episerver:ExplorerTree EnableVisibleInMenu="False" ShowRootPage="False" PageLink='<%#TreeRoot%>' ShowIcons="True" ClickScript="window.location.href = '{PageLinkURL}'" id="ExplorerTree" runat="server" />
</div>