<%@ Control Language="c#" AutoEventWireup="false" Codebehind="Members.ascx.cs" Inherits="development.Templates.Workrooms.Templates.Units.Members" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>

<br />
<EPiServerSys:ValidationSummary id="Summary" runat="server" />

<asp:panel id="ActiveMembersArea" runat="server">
	<asp:Button Runat="Server" OnClick="SwitchView_Click" Translate="/templates/workroom/members/addmembercaption" />
	<br />
	<br />
	<asp:DataGrid
		Runat="server" 
		ID="WorkroomMembers"
		OnPageIndexChanged="ChangeMemberPaging"
		AllowPaging="True"
		OnDataBinding="SetMemberHeaders"		 
		AutoGenerateColumns="False"
		Width="100%"
		AlternatingItemStyle-CssClass="ListRowEven"
		ItemStyle-CssClass="ListRowUneven"
		HeaderStyle-CssClass="WorkroomListHeader">
		<PagerStyle Mode="NumericPages" HorizontalAlign="Right" />
		<Columns>
			<asp:TemplateColumn>
				<ItemTemplate>
					<asp:LinkButton Runat="server" OnCommand="EditMember_Click" CssClass="WorkroomLink" 
									CommandArgument="<%#GetSid(Container).ID%>" >
						<img src="<%#Configuration.RootDir%>templates/workroom/images/icons/<%#GetSid(Container) is EPiServer.DataAbstraction.UserSid ? "member" : "groupmember"%>.gif" class="WorkroomLinkImage" />
					</asp:LinkButton>
				</ItemTemplate>
			</asp:TemplateColumn>
			<asp:TemplateColumn>
				<ItemTemplate>		
					<asp:LinkButton Runat="server" OnCommand="EditMember_Click" CssClass="WorkroomLink" 
									CommandArgument="<%#GetSid(Container).ID%>">
						<%#GetUserDisplayName(GetSid(Container))%>
					</asp:LinkButton>		
				</ItemTemplate>	
			</asp:TemplateColumn>
			<asp:TemplateColumn>
				<ItemTemplate>		
					<asp:LinkButton Runat="server" OnCommand="EditMember_Click" CssClass="WorkroomLink" 
									CommandArgument="<%#GetSid(Container).ID%>" >
						<%#GetUserEmail(GetSid(Container))%>
					</asp:LinkButton>		
				</ItemTemplate>	
			</asp:TemplateColumn>
			<asp:TemplateColumn>
				<ItemTemplate>		
					<asp:LinkButton Runat="server" OnCommand="EditMember_Click" CssClass="WorkroomLink" 
									CommandArgument="<%#GetSid(Container).ID%>" >
						<%#GetUserTelephone(GetSid(Container))%>&nbsp;
					</asp:LinkButton>		
				</ItemTemplate>	
			</asp:TemplateColumn>
			<asp:TemplateColumn>
				<ItemTemplate>
					<asp:LinkButton Runat="server" OnCommand="EditMember_Click" CssClass="WorkroomLink" 
									CommandArgument="<%#GetSid(Container).ID%>" >
						<%#GetMemberStatusString(GetSid(Container))%>
					</asp:LinkButton>		
				</ItemTemplate>	
			</asp:TemplateColumn>
			<asp:TemplateColumn>
				<ItemTemplate>					
					<asp:Button Runat="server" OnCommand="RemoveMember_Click"  CssClass="WorkroomButton"
						CommandArgument="<%#GetSid(Container).ID%>" 
						Translate="/templates/workroom/members/removemembercaption"/>
				</ItemTemplate>
			</asp:TemplateColumn>
		</Columns>
	</asp:DataGrid>
</asp:panel>
<asp:panel id="AddMembersArea" runat="server" Visible="False">	
	<div>
		<div class="leftfloating">
			<episerver:Translate Text="/templates/workroom/members/searchdescription" Runat="server" />:
			&nbsp;&nbsp;<asp:TextBox Runat="server" ID="SearchText" CssClass="medium" />
			<asp:Button Runat="server" OnClick="SearchUser_Click" Translate="/templates/workroom/members/searchbuttoncaption" CssClass="WorkroomButton"/>
			<asp:Button Runat="Server" OnClick="SwitchView_Click" Translate="/filemanager/browse/goback" CssClass="WorkroomButton"/>
		</div>
	</div>
	<br/>
	<br/>
	<asp:DataGrid
		Runat="server"
		DataSource='<%#SearchResults%>'
		ID="SearchHits"
		OnPageIndexChanged="ChangeSearchPaging"
		AllowPaging="True"
		OnDataBinding="SetSearchHitsHeaders"
		AutoGenerateColumns="False"
		Width="100%"
		AlternatingItemStyle-CssClass="ListRowEven"
		ItemStyle-CssClass="ListRowUneven"
		HeaderStyle-CssClass="WorkroomListHeader">
		<PagerStyle Mode="NumericPages" HorizontalAlign="Right" />
		<Columns>
			<asp:TemplateColumn>
				<ItemTemplate>
					<img src="<%#Configuration.RootDir%>templates/workroom/images/icons/<%#GetSidMemberIcon(Container)%>.gif" class="WorkroomLinkImage" />
				</ItemTemplate>
			</asp:TemplateColumn>
			<asp:TemplateColumn>
				<ItemTemplate>		
					<%#GetUserDisplayName(GetSid(Container))%>		
				</ItemTemplate>	
			</asp:TemplateColumn>
			<asp:TemplateColumn>
				<ItemTemplate>
					<%#GetUserEmail(GetSid(Container))%>	
				</ItemTemplate>	
			</asp:TemplateColumn>
			<asp:TemplateColumn>
				<ItemTemplate>		
					<%#GetUserTelephone(GetSid(Container))%>
				</ItemTemplate>	
			</asp:TemplateColumn>
			<asp:TemplateColumn>
				<ItemTemplate>
					<%#GetMemberStatusString(GetSid(Container))%>
				</ItemTemplate>
			</asp:TemplateColumn>
			<asp:TemplateColumn>
				<ItemTemplate>
					<asp:Button Runat="Server" OnCommand="AddMember_Click" 
							Enabled="<%#!CurrentWorkroom.UserIsDistinctMember(GetSid(Container))%>" 
							CommandArgument="<%#GetSid(Container).ID%>" 
							Translate="/templates/workroom/members/addmembercaption" />
				</ItemTemplate>
			</asp:TemplateColumn>
		</Columns>
	</asp:DataGrid>
</asp:panel>
<asp:Panel Runat="server" ID="EditUserArea" Visible="False">	
	<div>
		<div class="descriptionsmall">
			<%=EPiServer.Global.EPLang.Translate("/admin/secedit/editname")%>:&nbsp;
		</div>
		<div class="content">
			<%=GetUserDisplayName(SelectedSid)%>
		</div>
	</div>
	<br/>
	<br/>
	<asp:RadioButtonList Runat="server" ID="EditMemberStatus" />
	<br/>
	<asp:Button Runat="server" OnClick="SaveUserSettings_Click" Translate="/button/save" CssClass="WorkroomButton"/>
	<asp:Button Runat="server" OnClick="SwitchView_Click" Translate="/templates/workroom/members/canceleditcaption" CssClass="WorkroomButton"/>
</asp:Panel>