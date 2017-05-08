using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using EPiServer;
using EPiServer.Core;
using EPiServer.PlugIn;
using EPiServer.Security;
using EPiServer.WebControls;

using development.Templates.Workrooms.Templates;

namespace development.Templates.Workrooms.Core
{
	/// <summary>
	/// Base class for Workroom user controls.
	/// </summary>
	public class WorkroomControlBase : UserControlBase
	{
		private string			_languageBase;
		private Workroom		_workroom;
		private readonly String _evenCssClass = "ListRowUneven";
		private readonly String _unevenCssClass = "ListRowEven";
		private bool			_evenRow = false;
		private bool			_activePageLinkParsed;
		private PageData		_activePage;

		public WorkroomControlBase()
		{
			_languageBase = "/templates/workroom/";
		}

		private void ThrowNotDefinedException(string undefinedResourceName)
		{
			throw new EPiServerException(undefinedResourceName + " not defined for workroom " + CurrentWorkroom.Page.PageName);
		}

		#region Current accessors
		protected Workroom CurrentWorkroom
		{
			get
			{
				if(_workroom == null)
					_workroom = new Workroom(CurrentPage);
				return _workroom;
			}
		}

		protected PageData CurrentCalendar
		{
			get	
			{ 
				PageReference pageRef = CurrentWorkroom.CalendarRoot;
				if (pageRef == PageReference.EmptyReference)
					ThrowNotDefinedException("Calendar");
				return GetPage(pageRef);
			}
		}

		protected PageData CurrentNewsList
		{
			get	
			{ 
				PageReference pageRef = CurrentWorkroom.NewsListRoot;
				if (pageRef == PageReference.EmptyReference)
					ThrowNotDefinedException("News list");
				return GetPage(pageRef);
			}
		}

		protected PageData CurrentForum
		{
			get	
			{ 
				PageReference pageRef = CurrentWorkroom.ForumRoot;
				if (pageRef == PageReference.EmptyReference)
					ThrowNotDefinedException("Forum");
				return GetPage(pageRef);
			}
		}

		protected PageData CurrentBulletinBoard
		{
			get	
			{ 
				PageReference pageRef = CurrentWorkroom.BulletinBoardRoot;
				if (pageRef == PageReference.EmptyReference)
					ThrowNotDefinedException("Bulletin board");
				return GetPage(pageRef);
			}
		}
		#endregion

		/// <summary>
		/// Default language base used in translations, for example "/templates/workroom/".
		/// </summary>
		public string LanguageBase
		{
			get 
			{ 
				return _languageBase; 
			}
			set 
			{ 
				if (_languageBase == null)
					return;

				_languageBase = value; 

				if (!_languageBase.EndsWith("/"))
					_languageBase += "/";
			}
		}

		public PageData ActivePage
		{
			get
			{
				if(_activePage == null && ActivePageLink != PageReference.EmptyReference)
					_activePage = Global.EPDataFactory.GetPage(ActivePageLink);
				return _activePage;
			}
			set
			{
				_activePage = value;
				if(_activePage != null)
					ActivePageLink = _activePage.PageLink;
				else
					ActivePageLink = PageReference.EmptyReference;
			}
		}

		public PageReference ActivePageLink
		{
			get
			{
				if(ViewState["activepagelink"] == null && !_activePageLinkParsed)
				{
					_activePageLinkParsed = true;
					if(Request.QueryString["activepagelink"] != null)
					{
						ViewState["ActivePageLink"] = PageReference.Parse(Request.QueryString["activepage"]);
					}
				}
				return ViewState["ActivePageLink"] == null ? PageReference.EmptyReference : (PageReference)ViewState["ActivePageLink"];
			}
			set
			{
				ViewState["ActivePageLink"] = value;
			}
		}

		#region Security related

		private Boolean HasPublishRights(PageData pageData)
		{
			return pageData.ACL.QueryDistinctAccess(AccessLevel.Create) && pageData.ACL.QueryDistinctAccess(AccessLevel.Publish);	
		}

		private Boolean HasDeleteRights(PageData pageData)
		{
			return pageData.ACL.QueryDistinctAccess(AccessLevel.Delete) && pageData.ACL.QueryDistinctAccess(AccessLevel.Publish);	
		}

		public Boolean CanEdit
		{
			get 
			{ 
				if (IsAdministrator)
					return true;

				PageData pageData = (ActivePage != null) ? ActivePage : CurrentPage;

				return	HasPublishRights(pageData) && IsUser;
			}
		}

		public Boolean CanDelete
		{
			get 
			{ 
				if (IsAdministrator)
					return true;

				// If there is an active page of some kind, only allow the page creator to delete it.
				PageData pageData = (ActivePage != null) ? ActivePage : CurrentPage;

				return	HasDeleteRights(pageData) && IsUser;
			}
		}

		public Boolean IsAdministrator
		{
			get { return CurrentWorkroom.GetMemberStatus(UnifiedPrincipal.CurrentSid) == MemberStatus.Administrator; }
		}

		public Boolean IsUser
		{
			get { return CurrentWorkroom.GetMemberStatus(UnifiedPrincipal.CurrentSid) == MemberStatus.User; }
		}

		public Boolean IsGuest
		{
			get { return CurrentWorkroom.GetMemberStatus(UnifiedPrincipal.CurrentSid) == MemberStatus.Guest; }
		}

		public Boolean IsNotAuthorized
		{
			get { return CurrentWorkroom.GetMemberStatus(UnifiedPrincipal.CurrentSid) == MemberStatus.None; }
		}

		#endregion

		#region Page validation
		/// <summary>
		/// Build error messages by looping thru and creating error messages for all validators that failed page validation.
		/// </summary>
		/// <param name="controls">The controls that are processed, recursively.</param>
		virtual protected void BuildErrorMessages(ControlCollection controls, ref string languageBase)
		{
			foreach (Control control in controls)
			{			
				if (control.HasControls())
					BuildErrorMessages(control.Controls, ref languageBase);

				RequiredFieldValidator validator = control as RequiredFieldValidator;

				if (validator != null)
				{
					string caption	 = languageBase + validator.ControlToValidate.ToLower();
					validator.ErrorMessage = CreateFailedValidationErrorMsg(caption);
					validator.Text = "*";
				}		
			}
		}

		/// <summary>
		/// Build error messages by looping thru and creating error messages for all validators that failed page validation.
		/// </summary>
		virtual protected void BuildErrorMessages()
		{
			BuildErrorMessages(LanguageBase);
		}

		/// <summary>
		/// Build error messages by looping thru and creating error messages for all validators that failed page validation.
		/// </summary>
		virtual protected void BuildErrorMessages(string languageBase)
		{
			BuildErrorMessages(Controls, ref languageBase);
		}

		/// <summary>
		/// Create the error message used by BuildErrorMessages().
		/// </summary>
		/// <param name="caption">The language key that is translated, for example "/epibookingsample/units/bookinggroup/subject"</param>
		/// <returns>Translated error message for a failed validation</returns>
		virtual protected string CreateFailedValidationErrorMsg(string caption)
		{
			return string.Format( Translate( "/validation/required" ), Translate(caption) );
		}

		/// <summary>
		/// Creates a custom validator on the page, assigns an error message to the validator and marks it as already failed.
		/// The failed validator will show up in any validation summary controls on the page.
		/// </summary>
		/// <param name="controlToValidate">ID of control that is responsible for the failed validation</param>
		/// <param name="errorMessage">Error message</param>
		virtual protected void AddFailedValidator(string controlToValidate, string errorMessage)
		{
			CustomValidator validator			= new CustomValidator();
			validator.ID						= "ParseValidator-" + controlToValidate;
			validator.Text						= "*";
			if (controlToValidate != null)
				validator.ControlToValidate		= controlToValidate;
			validator.IsValid					= false;	
			validator.EnableClientScript		= false;
			validator.ErrorMessage				= errorMessage;
			Page.Validators.Add(validator);
		}

		virtual protected void AddFailedValidator(string errorMessage)
		{
			AddFailedValidator(null, errorMessage);
		}
		#endregion

		#region Helper functions
		protected string GetFormattedDate(Object obj)
		{
			return ((DateTime) obj).ToString("g");
		}

		protected Boolean IsActiveWorkroom(PageData page)
		{
			return Workroom.Load(page).IsActiveWorkroom;
		}

		/// <summary>
		/// Translate provided string. 
		/// </summary>
		/// <param name="textToTranslate">String to translate</param>
		/// <returns>Translated string</returns>
		/// <remarks>
		/// If the textToTranslate parameter begins with the "/" character, a default EPiServer translation is being made.
		/// Otherwise, the <see cref="development.Templates.Workrooms.CoreWorkroomControlBase.LanguageBase"/> value is inserted 
		/// in front of the parameter and the whole expression is translated. For example, if the parameter is "title" and the
		/// LanguageBase is "/templates/workroom", the expression to translate would be "/templates/workroom/title".
		/// </remarks>
		new public string Translate(string textToTranslate)
		{
			if (textToTranslate.StartsWith("/"))
				return base.Translate(textToTranslate);
			else
				return base.Translate(LanguageBase + textToTranslate);
		}

		protected String GetCssClass(bool changeClass)
		{
			if (changeClass)
				_evenRow = !_evenRow;

			return _evenRow ? _evenCssClass : _unevenCssClass;
		}

		protected void ResetRows()
		{
			_evenRow = false;
		}

		protected Boolean IsPageRefInitialized(string propertyName)
		{
			return CurrentPage[propertyName] != null && ((PageReference) CurrentPage[propertyName]) != PageReference.EmptyReference;
		}

		protected void FocusToInput(TextBox textbox)
		{
			if (!Page.IsClientScriptBlockRegistered("FocusToInput"))
			{
				Page.RegisterStartupScript("FocusToInput",
					"<script type='text/javascript'>try{document.all['" + textbox.ClientID +"'].focus();}catch(e){}</script>");
			}
		}

		protected Tab GetTab(string displayName)
		{
			TabStrip tabStrip = ((WorkroomPage)Page).WorkRoomTabStrip;

			// Search by ID
			foreach(Control control in tabStrip.Controls)
			{
				Tab tab = control as Tab;
				if (tab != null && tab.Text.Equals(displayName))
						return tab;
			}
			return null;
		}

		protected GuiPlugInAttribute CurrentGuiPluginAttribute
		{
			get 
			{
				return Attribute.GetCustomAttribute(this.GetType(), typeof(GuiPlugInAttribute),true) as GuiPlugInAttribute;
			}

		}

		protected String DisplayName
		{
			get { return CurrentGuiPluginAttribute.DisplayName; }
		}

		protected virtual PlugInDescriptor[] GetPlugInDescriptor()
		{
			IWorkroomPlugin plugin = (IWorkroomPlugin) this;

			if(plugin.IsActive && plugin.IsInitialized)
				return new PlugInDescriptor[]{PlugInDescriptor.Load(this.GetType())};
			else
				return new PlugInDescriptor[]{};
		}

		#endregion 
	}

}
