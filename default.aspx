<%@ Page language="c#" Codebehind="default.aspx.cs" AutoEventWireup="false" Inherits="development.Default" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="development" TagName="DefaultFramework"	Src="~/templates/Frameworks/DefaultFramework.ascx"%>
<%@ Register TagPrefix="development" TagName="PageHeader"	Src="~/templates/Units/PageHeader.ascx"%>
<%@ Register TagPrefix="development" TagName="PageBody"		Src="~/templates/Units/PageBody.ascx"%>
<%@ Register TagPrefix="development" TagName="CookieInfo"	Src="~/templates/Units/CookieInfo.ascx"%>
<%@ Register TagPrefix="development" TagName="LogServerLastUsers"	Src="~/templates/Units/LogServiceLastUsers.ascx"%>
<%@ Register TagPrefix="development" TagName="LogServerPageHits"	Src="~/templates/Units/LogServicePageHits.ascx"%>
<%@ Register TagPrefix="development" TagName="LogServicePublishedPages"	Src="~/templates/Units/LogServicePublishedPages.ascx"%>
<%@ Register TagPrefix="development" TagName="QuickBar"		Src="~/templates/Units/QuickBar.ascx"%>
<%@ Register TagPrefix="development" TagName="Quicksearch"	Src="~/templates/Units/QuickSearch.ascx"%>
<development:DefaultFramework ID=defaultframework runat="server">

	<EPiServer:Content ID="LeftAndMiddle" Region="fullRegion" runat="server">
		<div id="contentdivStartPage">
			<div id="mainareadiv" class="startpagewidth">
				<a id="content"></a>
				<img class="startpageimage" src="<%=StartPageImage%>" alt="" />
				<br />
				<EPiServer:NewsList ID="MainNewsItem" DataSource="<%# MainNewsItemReference %>" runat="server">
					<NewsTemplate>
						<h1><EPiServer:Property runat="server" PropertyName="PageName" /></h1>
						<development:PageBody ID="pagebody" runat="server" />
					</NewsTemplate>
				</EPiServer:NewsList>

				<EPiServer:Newslist ID="StartPageNews" PageLinkProperty="NewsContainer" Runat="Server" MaxCount='<%# GetNewsCount() %>'>				
					<HeaderTemplate>
						<div>
							<hr class="light"/>
							<episerver:property runat="server" PropertyName="PageLink" CssClass="StartnewsHeading" />
						</div>
					</HeaderTemplate>								
					<Newstemplate>
						<div class="startpageleftnews">
							<span class="datelistingtext"><episerver:property runat="server" PropertyName="PageStartPublish" /></span>
							<br />
							<episerver:property runat="server" PropertyName="PageLink" CssClass="Startnews" />
							<episerver:property runat="server" PropertyName="MainIntro" />
						</div>
					</Newstemplate>
				</EPiServer:Newslist>

			</div>
				
			<div id="rightmenudivStartPage">						
				<div class="listheadingcontainer">
					<div class="listheadingleftcorner"></div>
					<a class="listheading leftfloating" href="<%=EventRootPage.LinkURL%>"><%= EventRootPage.PageName %></a>
					<div class="listheadingrightcorner"></div>
				</div>
				<EPiServer:Calendar ID="Calendar1" Pagelinkproperty="EventsContainer" Runat="Server" MaxCount='<%# GetEventsCount()%>' NumberOfDaysToRender="365">
					<EventTemplate>
						<div class="startpagecalendaritem">
							<span class="datelistingtext">
								<%# String.Format("{0:yyyy-MM-dd HH:mm}", Container.CurrentEventStartTime ) %>&nbsp;-&nbsp;<%# String.Format("{0:HH:mm}",Container.CurrentEventStopTime ) %>
							</span><br/>
							<episerver:property runat="server" PropertyName="PageLink" CssClass="StartCalendar" />
							<span class="Normal"><episerver:property runat="server" PropertyName="MainIntro" /></span>
						</div>
					</EventTemplate>				
				</EPiServer:Calendar>
				<br/><br/>
				<div class="listheadingcontainer">
					<div class="listheadingleftcorner"></div>
					<a class="listheading leftfloating" href="javascript: void 0">
						<EPiServer:Translate runat="server" text="/edit/timespanview/displayname" />
					</a>
					<div class="listheadingrightcorner"></div>
				</div>
				<development:LogServerPageHits id="Logserverpagehits1" runat="server" />
				<br/>
				<development:LogServerLastUsers id="Logserverlastusers1" runat="server" />
				<br/>
				<development:LogServicePublishedPages id="Logservicepublishedpages1" runat="server" />
			</div>
		</div>

	</EPiServer:Content>
	
	<EPiServer:Content Region="footerRightColumnRegion" runat="server">
		<development:CookieInfo id="Cookieinfo" runat="server" />
	</EPiServer:Content>
	
</development:DefaultFramework>	