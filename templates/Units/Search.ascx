<%@ Control Language="c#" AutoEventWireup="false" Codebehind="Search.ascx.cs" Inherits="development.Templates.Units.Search" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>

<script type='text/javascript'>
	function ToggleHelp()
	{ 	
		var helpDiv = document.getElementById('<%=SearchHelp.ClientID%>');
		helpDiv.className = (helpDiv.className == '' ? 'hidden':'');
	}
</script>
<asp:TextBox ID="SearchQuery" TabIndex="1" Runat="server" Text="" Width="250px" />&nbsp;
<asp:Button Translate="/button/search" TabIndex="2" Text="Search" Runat="server" ID="SearchButton" Width="75px" />
&nbsp;&nbsp;&nbsp;&nbsp; <input type="button" Value="?" id="SearchHelpButton" Width="22px" OnClick="ToggleHelp()">
<br />

<asp:CheckBox Runat="server" ID="SearchFiles" Checked="false" />
<label for="<%=SearchFiles.ClientID%>"><episerver:Translate Text="/templates/search/searchfiles" runat="server"/></label>
<br />

<asp:CheckBox Runat="server" ID="OnlyWholeWords" Checked="true" />
<label for="<%=OnlyWholeWords.ClientID%>"><episerver:Translate Text="/templates/search/onlywholewords" runat="server"/></label>
<br />

<asp:Panel ID="AllLanguagesPanel" Runat="server" Visible="False">
	<asp:CheckBox Runat="server" ID="AllLanguages" Visible="True" Checked="False" />
	<label for="<%=AllLanguages.ClientID%>"><episerver:Translate Text="/templates/search/alllanguages" runat="server" /></label>
	<br/>
</asp:Panel>

<div id="SearchHelp" runat="server" class="hidden" />

<asp:Label id="ErrorMessage" Visible="false" runat="server" CssClass="errormessage" />
<!-- Note: PageLink is the default start page for search, used if MainContainer is empty -->
<episerver:PageSearch 
			Runat="server" 
			ID="SearchResults"
			SearchQuery='<%# SearchQuery.Text %>'
			SearchFiles='<%# SearchFiles.Checked %>'
			OnlyWholeWords='<%# OnlyWholeWords.Checked %>'
			MainScope='<%# CurrentPage["MainScope"] %>'
			MainCatalog='<%# CurrentPage["MainCatalog"] %>' 
			PageLink='<%# Configuration.StartPage %>'	
			PageLinkProperty="MainContainer"
>
	<HeaderTemplate>
		<br />
		<b>
			<episerver:Translate runat="server" Text="/templates/search/searchresult"/>
		</b>
		<table cellpadding="0" cellspacing="1" summary='<%=Translate("/templates/search/searchresult")%>'>
			<tr>
				<th><b><episerver:translate runat="server" Text="/templates/search/rank"/></b></th>
				<th><b><episerver:translate runat="server" Text="/templates/search/match"/></b></th>
			</tr>
	</HeaderTemplate>
	<ItemTemplate>
		<tr>
			<td align="left" width="50"><%#(int)Container.CurrentPage["PageRank"]/10%>%</td>
			<td align="left">
				<b>
					<a href='<%#Container.CurrentPage.DetermineAutomaticURL(Container.CurrentPage.LanguageBranch) %>'>
							<%#Container.CurrentPage.PageName%>
					</a>
				</b>
			</td>
		</tr>
		<tr>
			<td></td>
			<td><%#Container.PreviewText%></td>
		</tr>
	</ItemTemplate>
	<FileTemplate>
		<tr>
			<td align="left" width="50"><%#(int)Container.CurrentPage["PageRank"]/10%>%</td>
			<td align="left">
				<img src='<%#Container.CurrentPage["IconPath"]%>' />
				<b>
					<a href='<%#Container.CurrentPage["PageLinkURL"]%>'>
							<%#Container.CurrentPage.PageName%>
					</a>
				</b>
			</td>
		</tr>
	</FileTemplate>
	<FooterTemplate>
		</table>
	</FooterTemplate>
	<NoMatchesTemplate>
		<br />
		<br />
		<episerver:Translate Text="/templates/search/nomatches" runat="server"/>
	</NoMatchesTemplate>
</episerver:PageSearch>