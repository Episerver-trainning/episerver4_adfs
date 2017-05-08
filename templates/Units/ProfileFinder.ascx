<%@ Control Language="c#" AutoEventWireup="false" Codebehind="ProfileFinder.ascx.cs" Inherits="development.Templates.Units.ProfileFinder" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<asp:Panel Runat="server" ID="SearchArea">
	<table width="100%">
		<tr>
			<td align="right">
				<table class="backbutton" id="MyProfileLink" runat="server">
					<tr>
						<td>
							<asp:LinkButton runat="server" OnClick="EditDetails_Click" ID="EditProfileButton">
								<episerver:Translate Text="/templates/profilefinder/myprofile" runat="server" />
							</asp:LinkButton>			
						</td>
					</tr>
				</table>			
			</td>
		</tr>
	</table>
	<table cellpadding="0" cellspacing="0">
		<tr>
			<td>
				<table bgcolor="#F0F0F0" cellpadding="0" cellspacing="1" width="100%" id="SearchHeaderTable">
					<tr class="datarow">
						<td width="150" valign="top">
							<episerver:Translate Text="/admin/secedit/editname" runat="server" />
						</td>
						<td width="140">
							<asp:TextBox runat="server" ID="UserName" maxlength="50" />
						</td>
						<td valign="top">
							<episerver:Translate Text="/admin/secedit/firstname" runat="server" />
						</td>
						<td>
							<asp:TextBox runat="server" ID="FirstName" maxlength="50" />
						</td>
					</tr>			
					<tr class="datarow">
						<td valign="top">
							<episerver:Translate Text="/admin/secedit/editemail" runat="server" />
						</td>
						<td>
							<asp:TextBox runat="server" ID="Email" maxlength="50" />
						</td>
						<td valign="top">
							<episerver:Translate Text="/admin/secedit/lastname" runat="server" />
						</td>
						<td>
							<asp:TextBox runat="server" ID="LastName" maxlength="50" />
						</td>
					</tr>
					<tr class="datarow">
						<td valign="top">
							<episerver:Translate Text="/templates/profile/profile" runat="server" />
						</td>
						<td>
							<asp:TextBox runat="server" ID="ProfileTextBox" maxlength="50" />
						</td>
						<td valign="top">
							<episerver:Translate Text="/admin/secedit/editcompany" runat="server" />
						</td>
						<td>
							<asp:TextBox runat="server" ID="Company" maxlength="50" />
						</td>
					</tr>
					<tr class="datarow">
						<td valign="top">
							<episerver:Translate Text="/templates/profilefinder/limitamountofhits" runat="server" />
						</td>
						<td>
							<asp:TextBox runat="server" ID="LimitAmountOfHits" maxlength="4" Text="20" />
						</td>
						<td valign="top">
						</td>
						<td>
						</td>
					</tr>
				</table>
				<table width="100%">
					<tr>
						<td align="center">
							<asp:Button translate="/button/search" Runat="server" ID="SearchButton" />
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td>
				<hr />
				<asp:Label Runat="server" ID="NumberOfResultsInfo" />
				<EPiServer:PropertySearch PageLinkProperty="ProfileContainer" runat="server" ID="PropertySearchControl">
				</EPiServer:PropertySearch>
				<EPiServer:PageList SortBy="PageName" DataSource='<%#PropertySearchControl%>' runat="server" ID="PageListControl">
					<HeaderTemplate>
						<table class="searchresults" cellpadding="0" cellspacing="1" width="100%" id="SearchResultTable">
							<tr>
								<td></td>
								<td><episerver:Translate Text="/admin/secedit/firstname"	runat="server" /></td>
								<td><episerver:Translate Text="/admin/secedit/lastname"		runat="server" /></td>
								<td><episerver:Translate Text="/admin/secedit/editemail"	runat="server" /></td>
								<td><episerver:Translate Text="/admin/secedit/editcompany"	runat="server" /></td>
							</tr>
					</HeaderTemplate>
					<ItemTemplate>
						<tr class="evenrow">
							<td>
								<input type="checkbox" id="ViewUser<%#Container.CurrentPage.PageLink%>" name="ViewUser<%#Container.CurrentPage.PageLink%>" />
							</td>
							<td>
								<a href="<%#Container.CurrentPage.LinkURL%>">
									<episerver:property PropertyName="FirstName" runat="server" />
								</a>
							</td>
							<td>
								<episerver:property PropertyName="LastName" runat="server" />
							</td>
							<td>
								<%#ConcatEmailAdress((string)Container.CurrentPage["Email"])%>
							</td>
							<td>
								<episerver:property PropertyName="Company" runat="server" />
							</td>
						</tr>
					</ItemTemplate>
					<FooterTemplate>							
						</table>
						<table width="100%">
							<tr>
								<td align="center">
									<asp:Button ID="ViewDetailsButton" Runat="server" OnClick="ViewDetailedList_Click" Translate="#showdetailedlist" />
								</td>
							</tr>
						</table>
					</FooterTemplate>
				</EPiServer:PageList>
			</td>
		</tr>		
	</table>
</asp:Panel>

<asp:Panel ID="DetailedListPanel" runat="server">
	<table width="100%">
		<tr>
			<td align="right">
				<table class="BackButton">
					<tr>
						<td>
							<a href="#" onclick="SwitchSearchVisibility()">
								<episerver:Translate Text="/templates/profilefinder/backtosearch" runat="server" />
							</a>
						</td>
					</tr>
				</table>			
			</td>
		</tr>
	</table>
<EPiServer:PageList runat="server" id="DetailedList">
	<ItemTemplate>
	<br />
	<table class="detailedview borderless" border="0" width="100%">
		<tr>
			<td>
				<h3>
					<episerver:property PropertyName="FirstName" runat="server" />
					<episerver:property PropertyName="LastName" runat="server" />
				</h3>
			</td>
			<td rowspan="4" align="right">
				<img
					class="borderless"
					runat="server"
					Visible='<%#Container.CurrentPage["Image"] != null%>'
					src='<%#Container.CurrentPage["Image"]%>'
					Height="70"
					Width="70"
					translate="" />
				&nbsp;&nbsp;
			</td>
		</tr>
		<tr>
			<td>
				<b><episerver:Translate Text="/admin/secedit/editcompany" runat="server" />:</b> <episerver:property PropertyName="Company" runat="server" />
			</td>
		</tr>
		<tr>
			<td>
				<b><episerver:Translate Text="/templates/profile/department" runat="server" />:</b> <episerver:property PropertyName="AddedPropDepartment" runat="server" />
			</td>
		</tr>
		<tr>
			<td>
				<img class="borderless" runat="server" src="~/images/icon_mail_small.gif" translate="" /> <episerver:property PropertyName="Email" runat="server" />
				<img class="borderless" runat="server" src="~/images/icon_phone_small.gif" translate="" /> <episerver:property PropertyName="Telephone" runat="server" />
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<b><episerver:Translate Text="/templates/profile/profile" runat="server" />:</b> <episerver:property PropertyName="Profile" runat="server" />
			</td>
		</tr>
	</table>				
	</ItemTemplate>
</EPiServer:PageList>
</asp:Panel>

<script type='text/javascript'>
<!--
var da = (document.all) ? 1 : 0;
function SwitchSearchVisibility()
{
	var searchArea;
	var detailedListArea;
	
	if(da)
		searchArea	= document.all['<%=SearchArea.ClientID%>'];
	else
		searchArea	= document.getElementById('<%=SearchArea.ClientID%>');
		
	if(da)
		detailedListArea	= document.all['<%=DetailedListPanel.ClientID%>'];
	else
		detailedListArea	= document.getElementById('<%=DetailedListPanel.ClientID%>');
	
	if(searchArea.style.display == '')
	{
		searchArea.style.display = 'none';
		detailedListArea.style.display = '';
	}
	else
	{
		searchArea.style.display = '';
		detailedListArea.style.display = 'none';
	}
}
-->
</script>