<%@ Control Language="c#" AutoEventWireup="false" Codebehind="RssListing.ascx.cs" Inherits="development.Templates.Units.RssListing" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<asp:Label Runat="server" ID="ErrorMessage" Visible="False" />
<asp:DataGrid  
	ID="RssNewsGrid" 
	AutoGenerateColumns="False" 
	Runat="server"
	AlternatingItemStyle-CssClass="rssunevenrow"
	ItemStyle-CssClass="rssevenrow"
	HeaderStyle-CssClass="rssheaderrow"
	PageSize='<%#CurrentPage["PagingSize"] == null ? 5 : (int)CurrentPage["PagingSize"]%>'
	OnPageIndexChanged="ChangePaging"
	AllowPaging="True"
	Width="100%"
	Cellpadding="4"
	Border="0"	>
	<PagerStyle Mode="NumericPages" HorizontalAlign="Right" />
  <Columns>
    <asp:TemplateColumn>
		<HeaderTemplate>
			<span class="NewsListingHeader"><%# RssHeading %></span>
		</HeaderTemplate>
		<ItemTemplate>
			<b>
				<a href="<%# DataBinder.Eval(Container.DataItem, "link")%>" title="<%# Server.HtmlEncode((string)DataBinder.Eval(Container.DataItem, "description")) %>" target="<%#CurrentPage["OpenItemsInNewWindow"] != null ? "_new" : "_self"%>" class="NewsLink">
					<%# DataBinder.Eval(Container.DataItem, "title") %>
				</a>
			</b>
			<span class="datelistingtext"><%# ((System.Data.DataRowView)Container.DataItem).Row.Table.Columns["date"] == null ? "" : "(" + DataBinder.Eval(Container.DataItem, "date") + ")"%></span>
			<br />
			<asp:Label Runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "description") %>' Visible='<%#CurrentPage["OnlyShowHeaders"] == null? true : false%>' />
		</ItemTemplate>
    </asp:TemplateColumn>
  </Columns>
</asp:DataGrid>
