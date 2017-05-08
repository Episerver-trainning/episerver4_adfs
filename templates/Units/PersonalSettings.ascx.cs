using System;
using System.Web.Mail;
using System.Web;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using EPiServer;
using EPiServer.Core;
using EPiServer.DataAbstraction;
using EPiServer.Security;
using EPiServer.SystemControls;
using EPiServer.Util;
using EPiServer.WebControls;

namespace development.Templates.Units
{	
	public abstract class PersonalSettings : UserControlBase
	{

		protected Panel					SaveFailed, SaveSucceded, CreateEditUser, DenyRegistring;
		protected Label					ErrorMessage, SavedMessage;
		protected TextBox				Address, Company, Description, Email, Firstname, 
										Lastname, Mobile, Name, PostalAddress,
										PostalNumber, Telephone, Title;
		protected InputLanguage			Language;
		protected InputPassword			Password;
		protected HtmlGenericControl	NameRow, DescriptionRow, AddressRow, CompanyRow, EmailRow, FirstnameRow, 
										MobileRow, LanguageRow, LastnameRow, PasswordRow, 
										PostalAddressRow, PostalNumberRow, TitleRow, TelephoneRow;
		private UserSid					_user;

		private void Page_Load(object sender, System.EventArgs e)
		{
			if(!IsPostBack)				
				HideFields();
			InitializeFields();
		}
		protected virtual void InitializeFields()
		{
			if(!Page.User.Identity.IsAuthenticated)
			{
				CreateEditUser.Visible = false;
				return;
			}
			_user = UserSid.Load(UnifiedPrincipal.CurrentSid);
			if(!IsPostBack)	
				LoadUserData();
			if(_user.Type != SecurityIdentityType.ExtranetUser)
				PasswordRow.Visible = false;
			else
				Password.Collapsed = true;
		}

		protected virtual void ApplyButton_Click(object sender, EventArgs e)
		{
			if(!Page.User.Identity.IsAuthenticated)
			{
				ErrorOccured(Translate("/templates/personalsettings/expiredidentity"));
				CreateEditUser.Visible	= false;
				return;
			}			
			SaveUser();
		}
		protected virtual bool SaveUser()
		{
			if (!Page.IsValid)
				return false;
			if(!IsValue("DisablePassword") && _user.Type == SecurityIdentityType.ExtranetUser)
			{
				if(Password.FirstPassword != Password.SecondPassword)
				{
					ErrorOccured(Translate("/admin/edituser/passwordmismatch"));
					return false;
				}
				else if(Password.FirstPassword.Length > 0)
				{
					try					
					{
						_user.SetPassword(Password.FirstPassword);
					}
					catch(InvalidPasswordException error)
					{
						ErrorOccured(error.Message);
						return false;
					}
				}
			}
			SetPostedData(_user);
			try
			{				
				_user.Save();
				SaveFailed.Visible		= false;
				SaveSucceded.Visible	= true;
				CreateEditUser.Visible	= false;
			}
			catch(DataAbstractionException error)
			{
				ErrorOccured(error.Message);
				return false;
			}
			return true;
		}

		protected void ErrorOccured(string errorMessage)
		{
			SaveFailed.Visible		= true;
			SaveSucceded.Visible	= false;			
			ErrorMessage.Text		= errorMessage;
		}
		private void LoadUserData()
		{
			if(UnifiedPrincipal.Current.Identity.IsAuthenticated)
			{
				UserSid user				= UserSid.Load(UnifiedPrincipal.CurrentSid);
				
				Address.Text				= user.Address;
				Company.Text				= user.Company;				
				Description.Text			= user.Description;
				Email.Text					= user.Email;
				Firstname.Text				= user.FirstName;
				if(user.Language != string.Empty)
					Language.SelectedLanguage	= EPiServer.DataAbstraction.Language.Load(user.Language);
				Lastname.Text				= user.LastName;
				Mobile.Text					= user.Mobile;
				Name.Text					= user.Name;
				PostalAddress.Text			= user.PostalAddress;
				PostalNumber.Text			= user.PostalNumber;
				Telephone.Text				= user.Telephone;
				Title.Text					= user.Title;
			}			
		}
		protected void SetPostedData(UserSid user)
		{
			user.Address		= StripAnyTags(Address.Text);
			user.Company		= StripAnyTags(Company.Text);
			user.Description	= StripAnyTags(Description.Text);
			user.Email			= StripAnyTags(Email.Text);
			user.FirstName		= StripAnyTags(Firstname.Text);
			user.Language		= StripAnyTags(Language.SelectedLanguage == null? user.Language : Language.SelectedLanguage.ID);
			user.LastName		= StripAnyTags(Lastname.Text);
			user.Mobile			= StripAnyTags(Mobile.Text);
			user.Name			= StripAnyTags(Name.Text);
			user.PostalAddress	= StripAnyTags(PostalAddress.Text);
			user.PostalNumber	= StripAnyTags(PostalNumber.Text);
			user.Telephone		= StripAnyTags(Telephone.Text);
			user.Title			= StripAnyTags(Title.Text);
		}
		
		protected string StripAnyTags(string s)
		{
			return s==null ? null : s.Replace("<","").Replace(">","");
		}

		protected void HideFields()
		{
			AddressRow.Visible			= !IsValue("DisableAddress");
			CompanyRow.Visible			= !IsValue("DisableCompany");
			DescriptionRow.Visible		= !IsValue("DisableDescription");
			EmailRow.Visible			= !IsValue("DisableEmail");
			FirstnameRow.Visible		= !IsValue("DisableFirstname");
			MobileRow.Visible			= !IsValue("DisableMobile");
			LanguageRow.Visible			= !IsValue("DisableLanguage");
			LastnameRow.Visible			= !IsValue("DisableLastname");
			NameRow.Visible				= !IsValue("DisableName");
			PasswordRow.Visible			= !IsValue("DisablePassword");
			PostalAddressRow.Visible	= !IsValue("DisablePostalAddress");
			PostalNumberRow.Visible		= !IsValue("DisablePostalNumber");
			TelephoneRow.Visible		= !IsValue("DisableTelephone");
			TitleRow.Visible			= !IsValue("DisableTitle");
		}
		#region Accessors
		public UserSid User
		{
			get
			{
				return _user;
			}
			set
			{
				_user = value;
			}
		}
		#endregion
		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
			//
			// CODEGEN: This call is required by the ASP.NET Web Form Designer.
			//
			InitializeComponent();
			base.OnInit(e);
		}
		
		///		Required method for Designer support - do not modify
		///		the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
			this.Load += new System.EventHandler(this.Page_Load);
		}
		#endregion
	}
}