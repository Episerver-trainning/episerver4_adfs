using System;
using System.Collections;
using System.Collections.Specialized;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using EPiServer;
using EPiServer.Core;
using EPiServer.DataAbstraction;
using EPiServer.DataAccess;
using EPiServer.Filters;
using EPiServer.PlugIn;
using EPiServer.Security;
using EPiServer.SystemControls;
using EPiServer.Util;

using development.Templates.Workrooms.Core;

namespace development.Templates.Workrooms.Templates.Units
{
	/// <summary>
	///	The Calendar tab.
	/// </summary>
	[GuiPlugIn(	Area=PlugInArea.WorkRoom,
				Url="~/templates/Workroom/Templates/Units/Calendar.ascx",SortIndex=5000, 
				LanguagePath="/templates/workroom/plugins/calendar")]
	public class Calendar : WorkroomControlBase, ICustomPlugInLoader, ICustomPlugInDataLoader, IWorkroomPlugin
	{
		protected EPiServer.WebControls.Calendar				CalendarList;
		protected System.Web.UI.WebControls.Calendar			MonthCalendar;
		protected EPiServer.SystemControls.ValidationSummary	Summary;
		protected System.Web.UI.WebControls.TextBox				Subject;
		protected EPiServer.WebControls.InputDate				StartTime;
		protected EPiServer.WebControls.InputDate				EndTime;
		protected System.Web.UI.WebControls.Button				SaveButton;
		protected System.Web.UI.WebControls.Button				DeleteButton;
		protected System.Web.UI.WebControls.Label				EditViewCaption;
		protected System.Web.UI.WebControls.Panel				DefaultView;
		protected System.Web.UI.WebControls.Panel				EditView;
		protected System.Web.UI.WebControls.Button				CreateEntryButton;

		public void Page_Load(object sender, EventArgs e)
		{
		}

		public void Data_Load(object sender, EventArgs e)
		{
			SetupData();
		}

		protected void SetupData()
		{
			CalendarList.SelectedDates = MonthCalendar.SelectedDates;
			CalendarList.DataBind();
			if(ActivePage == null)
			{
				IEnumerator enumerator = CalendarList.GetEnumerator();
				if (enumerator.MoveNext())
					ActivePage = enumerator.Current as PageData;
			}
			SetViewMode();
		}

		private void SetViewMode()
		{
			DefaultView.Visible = true;
			EditView.Visible	= false;
			CreateEntryButton.Visible = CanEdit;
		}

		private void SetEditMode()
		{
			if (!CanEdit)
			{
				SetViewMode();
				return;
			}

			DefaultView.Visible			= false;
			EditView.Visible			= true;
			SaveButton.Visible			= true;
			DeleteButton.Visible		= ActivePage != null && CanDelete;

			if (ActivePage == null)
			{
				EditViewCaption.Text	= Translate("plugins/calendar/newentry");
				Subject.Text			= String.Empty;
				StartTime.Value			= DateTime.MinValue;
				EndTime.Value			= DateTime.MinValue;
			}
			else
			{
				EditViewCaption.Text	= Translate("plugins/calendar/editentry");
				Subject.Text			= ActivePage.PageName;
				StartTime.Value			= (DateTime) ActivePage["EventStartDate"];
				EndTime.Value			= (DateTime) ActivePage["EventStopDate"];
			}

			FocusToInput(Subject);
		}


		public void SelectItem_Click(object sender, CommandEventArgs e)
		{
			if (!CanEdit)
				return;

			PageReference selectedPage = PageReference.Parse(e.CommandArgument.ToString());
			ActivePage = Global.EPDataFactory.GetPage(selectedPage);
			SetEditMode();			
		}

		protected void CreateEntryButton_Click(object sender, System.EventArgs e)
		{
			ActivePage = null;
			SetEditMode();
		}

		protected void SaveButton_Click(object sender, System.EventArgs e)
		{
			try
			{
				ValidatePage();

				if (!Page.IsValid)
					return;

				int pageTypeID = (int) CurrentCalendar["CalendarType"];

				PageData page;

				if (ActivePage != null)
					page = ActivePage;
				else
					page = Global.EPDataFactory.GetDefaultPageData(CurrentCalendar.PageLink, pageTypeID, AccessControlList.NoAccess);

				page.PageName = Subject.Text;
				page["EventStartDate"] = StartTime.Value;
				page["EventStopDate"] = EndTime.Value;

				Global.EPDataFactory.Save(page, SaveAction.Publish, AccessControlList.NoAccess);
				SetupData();
			}
			catch(Exception exc)
			{
				AddFailedValidator("Unable to create calendar entry: " + exc.Message);
				return;
			}
		}
				
		protected void DeleteButton_Click(object sender, System.EventArgs e)
		{
			try
			{
				Global.EPDataFactory.Delete(ActivePage.PageLink, false, AccessControlList.NoAccess);
				ActivePage = null;
				SetupData();
			}
			catch(Exception exc)
			{
				AddFailedValidator("Unable to delete calendar entry: " + exc.Message);
				return;
			}
		}

		protected void CancelButton_Click(object sender, System.EventArgs e)
		{
			SetViewMode();
		}

		private void ValidatePage()
		{
			Page.Validate();			

			BuildErrorMessages(LanguageBase + "plugins/calendar/");

			if (StartTime.Value == DateTime.MinValue)
				AddFailedValidator(String.Format(Translate("/validation/required"), Translate(StartTime.DisplayName)));

			if (EndTime.Value == DateTime.MinValue)
				AddFailedValidator(String.Format(Translate("/validation/required"), Translate(EndTime.DisplayName)));
			else if (EndTime.Value < StartTime.Value)
				AddFailedValidator(String.Format(Translate("plugins/calendar/startdategreaterthanenddate"), 
						Translate(StartTime.DisplayName), Translate(EndTime.DisplayName)));
		}


		#region CalendarSelectionEvents
		protected void MonthCalendar_SelectionChanged(object sender, System.EventArgs e)
		{
			SetupData();
		}

		protected void MonthCalendar_VisibleMonthChanged(object sender, System.Web.UI.WebControls.MonthChangedEventArgs e)
		{
			MonthCalendar.SelectedDates.Clear();
			
			/* Note: Use this section to select the predifined number of days at month change
			 * 
			 * int nrOfDaysToShow = 0;
			 * if(CurrentPage.Property.Exists("nDaysToRender"))
			 * 	nrOfDaysToShow = (int)CurrentPage["nDaysToRender"];
			 * for(int i = 0 ; i < nrOfDaysToShow ; i++)
			 *	monthCalendar.SelectedDates.Add(monthCalendar.VisibleDate.AddDays(i));
			*/

			TimeSpan selectedDates = MonthCalendar.VisibleDate.AddMonths(1) - MonthCalendar.VisibleDate;

			for(int i = 0 ; i < selectedDates.Days ; i++)
				MonthCalendar.SelectedDates.Add(MonthCalendar.VisibleDate.AddDays(i));

			SetupData();
		}

		protected void MonthCalendar_DayRender(object sender, System.Web.UI.WebControls.DayRenderEventArgs e)
		{
			System.Web.UI.WebControls.TableCell cell = e.Cell;

			cell.BackColor = System.Drawing.Color.Empty;
			cell.ForeColor = System.Drawing.Color.Empty;

			if (CalendarList.DateIsActive(e.Day.Date))
				cell.CssClass += " datecellactive";
		}

		#endregion

		#region IWorkroomPlugin logic
		string IWorkroomPlugin.Name
		{
			get { return DisplayName; }
		}

		Boolean IWorkroomPlugin.IsActive
		{
			get 
			{ 
				return CurrentPage["IsActiveCalendar"] != null && (bool)CurrentPage["IsActiveCalendar"] == true;
			}
			set 
			{ 
				CurrentPage["IsActiveCalendar"] = value;
			}
		}

		Boolean IWorkroomPlugin.IsActiveEditable
		{
			get { return true; }
		}

		Boolean IWorkroomPlugin.IsInitialized
		{
			get { return IsPageRefInitialized("CalendarContainer"); }
		}
		#endregion

		public PlugInDescriptor[] List()
		{
			return GetPlugInDescriptor();
		}


		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
			//
			// CODEGEN: This call is required by the ASP.NET Web Form Designer.
			//
			InitializeComponent();
			base.OnInit(e);
		}
		
		/// <summary>
		///		Required method for Designer support - do not modify
		///		the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
			this.Load += new System.EventHandler(this.Page_Load);
			MonthCalendar.SelectionChanged += new EventHandler(MonthCalendar_SelectionChanged);
			MonthCalendar.VisibleMonthChanged += new System.Web.UI.WebControls.MonthChangedEventHandler(MonthCalendar_VisibleMonthChanged);
			MonthCalendar.DayRender += new System.Web.UI.WebControls.DayRenderEventHandler(MonthCalendar_DayRender);
		}
		#endregion
	}
}