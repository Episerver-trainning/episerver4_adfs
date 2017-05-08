using System;
using System.Collections;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

using EPiServer;
using EPiServer.Core;
using EPiServer.WebControls;

using ElektroPost.Wsrp;
using ElektroPost.Wsrp.V1.Types;

using EPiServer.DataAbstraction;
using EPiServer.Security;
using EPiServer.SystemControls;
using EPiServer.Util;

using development.Templates.Wsrp.Core;


namespace development.Templates.Wsrp.PortletControls
{
	/// <summary>
	///		Summary description for MyControl.
	/// </summary>
	public class WsrpUserSettingsControl : WsrpUserControlBase
	{
		protected Panel					SaveFailed, SaveSucceded, CreateEditUser, DenyRegistring;
		protected Label					ErrorMessage, SavedMessage;
		protected TextBox				Address, Company, Description, Email, Firstname, 
										Lastname, Mobile, Name, PostalAddress,
										PostalNumber, Telephone, Title;
		protected InputLanguage			Language;
		protected HtmlGenericControl	NameRow, DescriptionRow, AddressRow, CompanyRow, EmailRow, FirstnameRow, 
										MobileRow, LanguageRow, LastnameRow,  
										PostalAddressRow, PostalNumberRow, TitleRow, TelephoneRow;
		private UserSid					_user;

		protected PlaceHolder mainview;
		protected PlaceHolder configurationview;

		public UserSid User
		{
			get
			{
				if (!Page.User.Identity.IsAuthenticated)
				{
					CreateEditUser.Visible = false;
					return null;
				}
				if (_user == null)
					_user = UserSid.Load(UnifiedPrincipal.CurrentSid);
				return _user;
			}
		}

		private void Page_Load(object sender, System.EventArgs e)
		{
		}

		private void WsrpUserSettingsControl_BlockingInteraction(object sender, BlockingInteractionEventArgs e)
		{
			String submit = EmptyAsNull(e.GetParameter("submit"));
			if (submit != null)
			{
				PortletState["thetitle"]	= EmptyAsNull(e.GetParameter("thetitle"));

				if (User != null)
				{
					User.Address		= StripAnyTags(e.GetParameter("Address"));
					User.Company		= StripAnyTags(e.GetParameter("Company"));
					User.Description	= StripAnyTags(e.GetParameter("Description"));
					User.Email			= StripAnyTags(e.GetParameter("Email"));
					User.FirstName		= StripAnyTags(e.GetParameter("Firstname"));
					User.Language		= StripAnyTags(e.GetParameter("Language"));
					User.LastName		= StripAnyTags(e.GetParameter("Lastname"));
					User.Mobile			= StripAnyTags(e.GetParameter("Mobile"));
					User.PostalAddress	= StripAnyTags(e.GetParameter("PostalAddress"));
					User.PostalNumber	= StripAnyTags(e.GetParameter("PostalNumber"));
					User.Telephone		= StripAnyTags(e.GetParameter("Telephone"));
					User.Title			= StripAnyTags(e.GetParameter("Title"));
					try
					{				
						User.Save();
						SaveFailed.Visible		= false;
						SaveSucceded.Visible	= true;
						CreateEditUser.Visible	= false;
					}
					catch (DataAbstractionException error)
					{
						ErrorOccured(error.Message);
					}
				}

				// Always switch to view mode after getting edit mode parameters
				e.Response.updateResponse.newMode	= Constants.ModeView;
			}

			e.ReturnMarkup = true;

		}

		private void WsrpUserSettingsControl_PreRender(object sender, EventArgs e)
		{
			// Show customized portlet title
			// Note that if PortletState contains no information about "thetitle" it will return null.
			// The default  value of preferredTitle is null which means "use regular title"
			CurrentMarkupContext.preferredTitle = (String)PortletState["thetitle"];

			// Select edit or normal view
			SetDisplayMode( mainview, configurationview);
		}

		public string StripAnyTags(string s)
		{
			if (s == null || s.Length == 0)
				return null;

			return s.Replace("<","&lt;").Replace(">","&gt;");
		}

		protected void ErrorOccured(string errorMessage)
		{
			SaveFailed.Visible		= true;
			SaveSucceded.Visible	= false;			
			PortletState["ErrorMessage"]		= errorMessage;
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
			BlockingInteraction += new BlockingInteractionEventHandler(WsrpUserSettingsControl_BlockingInteraction);
			PreRender += new EventHandler(WsrpUserSettingsControl_PreRender);
		}
		#endregion

	}
}
