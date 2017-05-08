<%@ Control Language="c#" AutoEventWireup="false" Codebehind="LanguageSelector.ascx.cs" Inherits="development.templates.Units.LanguageSelector" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>

<EPiServer:PageList ID="languageList" Runat="server">
	<ItemTemplate>
		<a href="<%#Container.CurrentPage.DetermineAutomaticURL(Container.CurrentPage.LanguageBranch)%>" title="<%#GetAlt(Container.CurrentPage)%>"><img class="languageicon" src="<%#GetIcon(Container.CurrentPage)%>" alt="<%#GetAlt(Container.CurrentPage)%>" /></a>
	</ItemTemplate>
</EPiServer:PageList>
