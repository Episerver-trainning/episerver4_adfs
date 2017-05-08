<%@ Control Language="c#" AutoEventWireup="false" Codebehind="WorkroomList.ascx.cs" Inherits="development.Templates.Workrooms.Templates.Units.WorkroomList" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>

<asp:panel id="WorkroomListPanel" runat="server" CssClass="WorkroomContainer">

	<h2><%=Translate("common/captionmany")%></h2>

	<asp:CheckBox Runat="server" ID="ShowOnlyActiveWorkroomsCheckBox" AutoPostBack="True" Checked="True" />
	<p/>

	<div class="WorkroomList">

		<div class="ListHeader NewLine">
			<div class="ColSize3"><%=Translate("common/name")%></div>
			<div class="ColSize2"><%=Translate("common/owner")%></div>
			<div class="ColSize2"><%=Translate("common/changed")%></div>
			<div class="ColSize1 Centered"><%=Translate("common/active")%></div>
		</div>

		<EPiServer:PageList id="WorkroomPageList" DataSource='<%#GetValidPages()%>' runat="server" SortBy="PageName" Paging="true">
			<ItemTemplate>
				<a href='<%#Container.CurrentPage.LinkURL%>' class="WorkroomLink NewLine">
					<div class='<%# GetRowCSS(++RowIndex) %>'>
						<div class="ColSize3 TextData" runat="server">
							<img src="<%#Configuration.RootDir%>templates/workroom/images/icons/office.gif" class="WorkroomLinkImage" />
							<episerver:property PropertyName="PageName"  runat="server" />
						</div>
						<div class="ColSize2 TextData" runat="server">
							<episerver:property PropertyName="PageCreatedBy"  runat="server" ID="Property1" NAME="Property1"/>
						</div>
						<div class="ColSize2 TextData" runat="server">
							<%# GetFormattedDate(Container.CurrentPage["PageChanged"]) %> 
						</div>
						<div class="ColSize1 Centered" runat="server">						
							<asp:Image Runat="server" Visible='<%#IsActiveWorkroom(Container.CurrentPage) %>' AlternateText="Active workroom" 
									ImageUrl='<%# EPiServer.Global.EPConfig.RootDir + "templates/Workroom/Images/Icons/active.gif" %>'></asp:Image>
						</div>
					</div>
				</a>
			</ItemTemplate>
		</EPiServer:PageList>
	
	</div>
	
	<p class="NewLine" />
	<asp:Button id="CreateWorkroomButton" onclick="CreateWorkroomButton_Click" runat="server" translate="/templates/workroom/common/createnew" />
</asp:panel>
