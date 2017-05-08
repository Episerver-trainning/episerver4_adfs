<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Control Language="c#" AutoEventWireup="false" Codebehind="AlphanumericListing.ascx.cs" Inherits="development.Templates.Units.AlphanumericListing" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<asp:PlaceHolder ID="AlphanumericLinks" Runat="server"></asp:PlaceHolder>
<p>
	<episerver:PropertySearch PageLink='<%# StartingPoint %>' runat="server" ID="PropertySearchControl">
	</episerver:PropertySearch>
	<episerver:PageList SortBy="PageName" DataSource='<%#PropertySearchControl%>' runat="server" ID="PageListControl">
		<ItemTemplate>
			<episerver:property runat="server" CssClass="linklist" PropertyName="PageLink" />
			<br/>
		</ItemTemplate>
	</episerver:PageList>
</p>
