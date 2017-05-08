<%@ Control Language="c#" AutoEventWireup="false" Codebehind="Calendar.ascx.cs" Inherits="development.Templates.Units.Calendar" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<div>
	<div class="calendarlistingarea">
		<episerver:calendar
			ID="calendarList" 
			Runat="server" 
			NumberOfDaysToRender='<%#CurrentPage["nDaysToRender"]%>'
			PageLinkProperty="CalendarContainer" 
			PageTypeID='<%#CurrentPage["CalendarType"]%>'
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
				<div>
					<div class="leftfloating">
						<episerver:property runat="server" PropertyName="PageLink" CssClass="linklist" />
					</div>
					<div class="rightfloating rightaligned">
						<span class="datelistingtext"><%#Container.StartTime%>&nbsp;-&nbsp;<%#Container.StopTime%></span>
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
	<div class="monthcalendararea">
		<asp:Calendar 
			id="monthCalendar" 
			runat="server" 
			SelectionMode="DayWeekMonth" 
			CellSpacing="1" 
			BackColor="#ffffff" 
			NextMonthText="+" 
			PrevMonthText="-"
			CssClass="calendar"
			DayHeaderStyle-CssClass="calendaritem dayweekheader" 
			OtherMonthDayStyle-CssClass="calendaritem datecellothermonth" 
			DayStyle-CssClass="calendaritem"
			SelectedDayStyle-CssClass="calendaritem selecteddatecell"
			WeekendDayStyle-CssClass="calendaritem weekendcell"
			BorderColor="#f0f0f0"
			BorderWidth="1"
		/>
	</div>
</div>