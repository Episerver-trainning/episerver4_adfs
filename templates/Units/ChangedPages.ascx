<%@ Control Language="c#" AutoEventWireup="false" Codebehind="ChangedPages.ascx.cs" Inherits="development.Templates.Units.ChangedPages" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<EPiServer:ChangedPages 
	Runat="server" 
	ID="RecentList" 
	PageLink='<%#CurrentPage["RecentContainer"] != null ? CurrentPage["RecentContainer"] : Configuration.StartPage %>'
	ChangedSince='<%#TimeSpan.FromHours((int)CurrentPage["RecentHours"])%>'
>
	<HeaderTemplate>
		<table>
			<tr>
				<th scope="col"><b><episerver:Translate runat="server" Text="/templates/changedpages/lastmodified" /></b></th>
				<th scope="col"><b><episerver:Translate runat="server" Text="/templates/changedpages/page" /></b></th>
			</tr>
	</HeaderTemplate>
	<ItemTemplate>
		<tr>
			<td class="changedpages datelistingtext"><%#((DateTime)Container.CurrentPage["PageChanged"]).ToString("yyyy-MM-dd hh:mm")%></td>
			<td><episerver:property runat="server" PropertyName="PageLink" CssClass="linklist" /></td>
		</tr>
	</ItemTemplate>
	<FooterTemplate>
		</table>
	</FooterTemplate>
</EPiServer:ChangedPages>
	