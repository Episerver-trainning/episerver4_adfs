<%@ Control Language="c#" AutoEventWireup="false" Codebehind="Calendar.ascx.cs" Inherits="development.Templates.Workrooms.Templates.Units.Calendar" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>

<br />
<br />
<div class="workroomoverviewcolumn leftfloating">
	<episerver:calendar
		ID="CalendarList" 
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
					<asp:LinkButton Runat="server" CssClass="linklist" CausesValidation="False" OnCommand="SelectItem_Click" CommandArgument='<%#Container.CurrentPage.PageLink.ID%>'>
						<img src="<%#Configuration.RootDir%>templates/workroom/images/icons/calendar.gif" class="WorkroomLinkImage" />
						<episerver:property Runat="server" PropertyName="PageName"/>
					</asp:LinkButton>
				</div>
				<div class="rightfloating rightaligned datelistingtext">
					<%#Container.StartTime%>&nbsp;-&nbsp;<%#Container.StopTime%>
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
<div class="workroomoverviewcolumnseparator">			
</div>
<div class="workroomoverviewcolumn">

	<asp:Panel Runat="server" ID="DefaultView">

		<asp:Calendar 
			id="MonthCalendar" 
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
		<br/>
		<asp:Button ID="CreateEntryButton" CssClass="WorkroomButton" Runat="server" Translate="/button/create" OnClick="CreateEntryButton_Click" />

	</asp:Panel>
	<asp:Panel Runat="server" ID="EditView">

		<div class="fullwidth">		
			<h2>
				<asp:Label Runat="server" ID="EditViewCaption"></asp:Label>				
			</h2>
			<EPiServerSys:ValidationSummary id="Summary" runat="server" />

			<div class="tablerow">
				<div class="descriptionxsmall TextData">
					<%=Translate("plugins/calendar/subject")%>:
				</div>
				<div class="content">
					<asp:TextBox ID="Subject" Runat="server" CssClass="medium" />
					<asp:RequiredFieldValidator Runat="server" ControlToValidate="Subject" EnableClientScript="False" />
				</div>
			</div>
			<div class="tablerow">
				<div class="descriptionxsmall TextData">			
					<%=Translate("plugins/calendar/starttime")%>:
				</div>
				<div class="content">
					<EPiServer:InputDate ID="StartTime" runat="server" ValidateInput="True" DisplayName="/templates/workroom/plugins/calendar/starttime"/>
				</div>
			</div>
			<div class="tablerow">
				<div class="descriptionxsmall TextData">				
					<%=Translate("plugins/calendar/endtime")%>:
				</div>
				<div class="content">
					<EPiServer:InputDate ID="EndTime" runat="server" ValidateInput="True" DisplayName="/templates/workroom/plugins/calendar/endtime"/>
				</div>
			</div>
			<br/>
			<asp:Button id="SaveButton" CssClass="WorkroomButton" Runat="server" Translate="/button/save" OnClick="SaveButton_Click" />
			<asp:Button id="DeleteButton" CssClass="WorkroomButton" Runat="server" Translate="/button/delete" OnClick="DeleteButton_Click" />			
			<asp:Button id="CancelButton" CssClass="WorkroomButton" Runat="server" Translate="/button/cancel" OnClick="CancelButton_Click" />
		</div>
	</asp:Panel>
</div>						


