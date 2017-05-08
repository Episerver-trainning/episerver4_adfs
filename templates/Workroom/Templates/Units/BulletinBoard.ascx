<%@ Control Language="c#" AutoEventWireup="false" Codebehind="BulletinBoard.ascx.cs" Inherits="development.Templates.Workrooms.Templates.Units.BulletinBoard" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>

<br />
<br />
<div class="workroomoverviewcolumn leftfloating">
	<episerver:PageList Runat="server" ID="PageList" PageLink='<%#CurrentWorkroom.BulletinBoardRoot%>' Paging="true" PagesPerPagingItem="8">
		<HeaderTemplate>
			<div class="WorkroomList">
				<%ResetRows();%>
				<div class="WorkroomListHeader">
					<%=Translate("plugins/bulletinboard/displayname")%>
				</div>
		</HeaderTemplate>
		<ItemTemplate>
			<div class='WorkroomPadded <%#GetCssClass(true)%>'>
				<b>
					<asp:LinkButton Runat="server" CssClass="linklist" OnCommand="SelectItem_Click" CommandArgument='<%#Container.CurrentPage.PageLink.ID%>'>
						<img src="<%#Configuration.RootDir%>templates/workroom/images/icons/information.gif" class="WorkroomLinkImage" />
						<episerver:property Runat="server" PropertyName="PageName"/>
					</asp:LinkButton>
				</b>
				<span class="datelistingtext"><%#((DateTime)Container.CurrentPage["PageCreated"]).ToString("g")%></span>
				<br />
				<episerver:property Runat="server" PropertyName="MainIntro" />
			</div>
		</ItemTemplate>
		<FooterTemplate>
			</div>
		</FooterTemplate>
	</episerver:PageList>
</div>
<div class="workroomoverviewcolumnseparator">			
</div>
<div class="workroomoverviewcolumn">
	<asp:Panel Runat="server" ID="DetailsView">
		<h2><%=ActivePage == null ? "" : ActivePage.PageName%></h2>
		<p><%=ActivePage == null ? "" : ActivePage["MainBody"]%></p>
	</asp:Panel>

	<asp:Panel Runat="server" ID="DetailsViewButtonPanel">
		<asp:Button Runat="server" ID="CreateButton" OnClick="CreateButton_Click" Translate="/button/create" CssClass="WorkroomButton" />
		<asp:Button Runat="server" ID="EditButton" OnClick="EditButton_Click" Translate="/button/edit" CssClass="WorkroomButton" />
		<asp:Button Runat="server" ID="DeleteButton" OnClick="DeleteButton_Click" Translate="/button/delete" CssClass="WorkroomButton" />
	</asp:Panel>
	
	<asp:Panel Runat="server" ID="EditView">
		<h2><asp:Label ID="EditLabel" Runat="server"></asp:Label></h2>
		<div class="fullwidth">
			<div>
				<div class="leftfloating narrowcolumn">
					<%=Translate("plugins/news/title")%>:
				</div>
				<div class="leftfloating">
					<asp:TextBox Runat="Server" CssClass="fullwidth" ID="PageName" />
					<asp:RequiredFieldValidator Runat="server" ControlToValidate="PageName" ErrorMessage="*" />
				</div>
			</div>
			<br />
			<br />
			<div>
				<div class="leftfloating narrowcolumn">
					<%=Translate("plugins/news/mainintro")%>:
				</div>
				<div class="leftfloating">
					<asp:TextBox Runat="Server" CssClass="fullwidth" ID="MainIntro" />
				</div>
			</div>
			<br />
			<div>
				<div class="leftfloating narrowcolumn">
					<%=Translate("plugins/news/mainbody")%>:
				</div>
				<div class="leftfloating">
					<asp:TextBox Runat="Server" TextMode="MultiLine" CssClass="fullwidth inputarea" ID="MainBody" />
					<asp:RequiredFieldValidator Runat="server" ControlToValidate="MainBody" ErrorMessage="*" />
				</div>
			</div>
		</div>
		<br />
		<asp:Button Runat="server" OnClick="SaveButton_Click" Translate="/button/save" CssClass="WorkroomButton" ID="SaveButton"/>
		<asp:Button Runat="server" OnClick="CancelButton_Click" Translate="/button/cancel" CausesValidation="False" CssClass="WorkroomButton" ID="CancelButton"/>
	</asp:Panel>
</div>