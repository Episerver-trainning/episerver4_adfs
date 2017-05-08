<%@ Control Language="c#" AutoEventWireup="false" Codebehind="Overview.ascx.cs" Inherits="development.Templates.Workrooms.Templates.Units.Overview" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>

<br/>

<asp:Panel Runat="server" ID="OverviewViewPanel">
	<div class="LeftContainer79" >
		<EPiServer:Property ID="MainBodyProperty" runat="server" PropertyName="MainBody" Width="100%" />
	</div>

	<div class="RightContainer19">
		<asp:Button Runat="server" OnClick="EditMainBodyButton_Click" Translate="/button/edit" CssClass="WorkroomButton" ID="EditMainBodyButton" />
	</div>
</asp:Panel>

<asp:Panel Runat="server" ID="OverviewEditPanel">
	<div class="LeftContainer79" >
		<asp:TextBox Runat="Server" TextMode="MultiLine" Rows="20" Height="20em" CssClass="fullwidth inputarea" ID="MainBodyTextBox" />
	</div>

	<div class="RightContainer19">
		<asp:Button Runat="server" OnClick="SaveMainBodyButton_Click" Translate="/button/save" CssClass="WorkroomButton" ID="SaveMainBodyButton" />
		<asp:Button Runat="server" OnClick="CancelMainBodyButton_Click" Translate="/button/cancel" CssClass="WorkroomButton" ID="CancelMainBodyButton" />
	</div>
</asp:Panel>

<br class="NewLine"/>
<br/>

<div runat="server" id="ListPanel" class="WorkroomList LeftContainer" >
	<episerver:newslist id="NewsListControl" PageLinkProperty="ListingContainer"  runat="server" >
		<HeaderTemplate>
			<div class="WorkroomListHeader">
				<%= EPiServer.Global.EPLang.Translate("/templates/workroom/plugins/news/displayname") %>
			</div>
		</HeaderTemplate>
		<FirstNewsTemplate>
			<div class="ListRowUnEven WorkroomPadded">
				<b>
				<a href="<%#CreateNewsLink(Container.CurrentPage)%>" target='<%#Container.CurrentPage["PageTargetFrame"]%>' title='<%#Container.PreviewText%>' class="linklist">
					<img src="<%#Configuration.RootDir%>templates/workroom/images/icons/news.gif" class="WorkroomLinkImage" />
					<%#Container.CurrentPage.PageName%>
				</a>
				</b>&nbsp;<span class="datelistingtext">
					(<%#((DateTime)Container.CurrentPage["PageStartPublish"]).ToString("yyyy-MM-dd hh:mm")%>)</span>
					<br />
					<%#Container.PreviewText%>
			</div>
		</FirstNewsTemplate>
		<SecondNewsTemplate>
			<div class="ListRowEven WorkroomPadded">
				<b>
				<a href="<%#CreateNewsLink(Container.CurrentPage)%>" target='<%#Container.CurrentPage["PageTargetFrame"]%>' title='<%#Container.PreviewText%>' class="linklist">
					<img src="<%#Configuration.RootDir%>templates/workroom/images/icons/news.gif" class="WorkroomLinkImage" />
					<%#Container.CurrentPage.PageName%>
				</a>
				</b>&nbsp;<span class="datelistingtext">
					(<%#((DateTime)Container.CurrentPage["PageStartPublish"]).ToString("yyyy-MM-dd hh:mm")%>)</span>
					<br />
					<%#Container.PreviewText%>
			</div>
		</SecondNewsTemplate>
		<ThirdNewsTemplate>
			<div class="ListRowUnEven WorkroomPadded">
				<b>
				<a href="<%#CreateNewsLink(Container.CurrentPage)%>" target='<%#Container.CurrentPage["PageTargetFrame"]%>' title='<%#Container.PreviewText%>' class="linklist">
					<img src="<%#Configuration.RootDir%>templates/workroom/images/icons/news.gif" class="WorkroomLinkImage" />
					<%#Container.CurrentPage.PageName%>
				</a>
				</b>&nbsp;<span class="datelistingtext">
					(<%#((DateTime)Container.CurrentPage["PageStartPublish"]).ToString("yyyy-MM-dd hh:mm")%>)</span>
					<br />
					<%#Container.PreviewText%>
			</div>
		</ThirdNewsTemplate>
		<FourthNewsTemplate>
			<div class="ListRowEven WorkroomPadded">
				<b>
				<a href="<%#CreateNewsLink(Container.CurrentPage)%>" target='<%#Container.CurrentPage["PageTargetFrame"]%>' title='<%#Container.PreviewText%>' class="linklist">
					<img src="<%#Configuration.RootDir%>templates/workroom/images/icons/news.gif" class="WorkroomLinkImage" />
					<%#Container.CurrentPage.PageName%>
				</a>
				</b>&nbsp;<span class="datelistingtext">
					(<%#((DateTime)Container.CurrentPage["PageStartPublish"]).ToString("yyyy-MM-dd hh:mm")%>)</span>
					<br />
					<%#Container.PreviewText%>
			</div>
		</FourthNewsTemplate>
	</episerver:newslist>
</div>

<div class="RightContainer">

	<div>
		<episerver:calendar
			ID="calendarList" 
			Runat="server" 
			NumberOfDaysToRender='<%#CurrentCalendar["nDaysToRender"]%>'
			PageLinkProperty="CalendarContainer" 
			PageTypeID='<%#CurrentCalendar["CalendarType"]%>'
			ExpandAllDays= "False"
		>
			<DayPrefixTemplate>
				<h1 class="calendardayheading">
					<%#Container.DayName%>, <%#Container.DayOfMonth%> <%#Container.MonthName%>
				</h1>
				<br />
				<hr />
			</DayPrefixTemplate>
			<EventTemplate>
				<div class="NewLine">
					<div class="leftfloating">
						<img src="<%#Configuration.RootDir%>templates/workroom/images/icons/calendar.gif" class="WorkroomLinkImage" />
						<episerver:property runat="server" PropertyName="PageLink" CssClass="linklist" ID="PageLinkProperty"/>
					</div>
					<div class="rightfloating rightaligned">
						<span class="datelistingtext">
						<%#Container.StartTime%>&nbsp;-&nbsp;<%#Container.StopTime%></span>
					</div>
				</div>
				<br />
			</EventTemplate>
			<DaySuffixTemplate>
				<br />
				<br />
			</DaySuffixTemplate>
		</episerver:calendar>
	</div>

</div>
