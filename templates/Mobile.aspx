<%@ Page language="c#" Codebehind="Mobile.aspx.cs" Inherits="development.Templates.Mobile" AutoEventWireup="false" %>
<%@ Register TagPrefix="mobile" Namespace="System.Web.UI.MobileControls" Assembly="System.Web.Mobile" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<body Xmlns:mobile="http://schemas.microsoft.com/Mobile/WebForm">
	<mobile:Form id="_default" runat="server" Title='<%#CurrentPage.PageName%>' Paginate=true>
		<mobile:TextView id="MainBody" Runat=server><%#CurrentPage["MainBody"]%></mobile:TextView>
		<p />
		<mobile:Panel Runat=server>
			<episerver:newslist runat=server id="NewsList" PageLinkProperty="ListingContainer">				
				<NewsTemplate>
					<mobile:link runat=server NavigateUrl='<%#Configuration.RootDir + "templates/mobile.aspx?id=" + Container.CurrentPage.PageLink.ID %>' ID="Link1"><%#Container.CurrentPage.PageName%></mobile:link><br />
				</NewsTemplate>				
			</episerver:newslist>
		</mobile:Panel>
	</mobile:Form>	
</body>
