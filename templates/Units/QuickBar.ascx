<%@ Control Language="c#" AutoEventWireup="false" Codebehind="QuickBar.ascx.cs" Inherits="development.Templates.Units.QuickBar" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<%@ Register TagPrefix="development" TagName="Quicksearch"		Src="~/templates/Units/QuickSearch.ascx"%>
<%@ Register TagPrefix="development" TagName="LanguageSelector"	Src="~/templates/Units/LanguageSelector.ascx"%>
<script type="text/javascript">
function openEmailDialogue(height, width)
{
	var left = (window.screen.width - width) / 2;
	var top = (window.screen.height - height) / 2;
	var features = 'height=' + height + ',width=' + width + ",left=" + left + ",top=" + top;
	window.open('<%=Configuration.RootDir%>templates/emailpage.aspx?id=<%=CurrentPage.PageLink.ID%>',null,features);
}
</script>

<div class="quickbarupperdiv">
	<div class="languagecontainer"><development:LanguageSelector runat="server" /></div>
	<asp:Label Runat="server" ID="UserName" CssClass="usernamelabel" />
</div>
<div class="quickbarlowerdiv">
	<div class="leftfloating">
		<a href="javascript: void 0" onclick="javascript:printPage();"><img class="quickbaricon" runat="server" src="~/images/ico_print.gif" translate="/templates/common/printpage" ID="Img2"/></a>
		<img class="quickbariconseparator" src="<%=EPiServer.Global.EPConfig.RootDir%>images/ico_separator.gif" alt="" />
		<a href="javascript: void 0" onclick="javascript:openEmailDialogue(300,200);"><img class="quickbaricon" runat="server" src="~/images/ico_send.gif" translate="/templates/common/emailpage" /></a>
		<img class="quickbariconseparator" src="<%=EPiServer.Global.EPConfig.RootDir%>images/ico_separator.gif" alt="" />
		<a href='<%=SitemapPageLink%>' accesskey="3"><img class="quickbaricon" runat="server" src="~/images/ico_sitemap.gif" translate="/templates/common/sitemap" /></a>
		<img class="quickbariconseparator" src="<%=EPiServer.Global.EPConfig.RootDir%>images/ico_separator.gif" alt="" />
		<a href='<%=EditDetailsPageLink%>'><img class="quickbaricon" runat="server" src="~/images/ico_register.gif" translate="/templates/common/editdetails" ID="Img1"/></a>
		<img class="quickbariconseparator" src="<%=EPiServer.Global.EPConfig.RootDir%>images/ico_separator.gif" alt="" />
		<asp:LinkButton Runat="server" ID="LoginButton">
			<img class="quickbaricon" runat="server" ID="LoginStatusImage" src="~/images/ico_access.gif" translate="/templates/common/login" />
		</asp:LinkButton>
		<asp:LinkButton Runat="server" ID="LogoutButton">
			<img class="quickbaricon" runat="server" ID="LogoutStatusImage" src="~/images/ico_access.gif" translate="/templates/common/logout" />
		</asp:LinkButton>
		<img class="quickbariconseparator" src="<%=EPiServer.Global.EPConfig.RootDir%>images/ico_separator.gif" alt="" />
	</div>
	<div class="rightfloating">
		<development:quicksearch runat="server" ID="quicksearch" />
	</div>
</div>
