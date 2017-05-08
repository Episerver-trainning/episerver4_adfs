/*
Copyright © 1997-2004 ElektroPost Stockholm AB. All Rights Reserved.

This code may only be used according to the EPiServer License Agreement.
The use of this code outside the EPiServer environment, in whole or in
parts, is forbidded without prior written permission from ElektroPost
Stockholm AB.

EPiServer is a registered trademark of ElektroPost Stockholm AB. For
more information see http://www.episerver.com/license or request a
copy of the EPiServer License Agreement by sending an email to info@ep.se
*/
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
	/// <summary>
	///		Summary description for Register.
	/// </summary>
	public abstract class Register : PersonalSettings
	{
		private void Page_Load(object sender, System.EventArgs e)
		{
			if(! (bool)Configuration["EPfEnableFreeRegistring"] )
			{
				DenyRegistring.Visible = true;
				CreateEditUser.Visible = false;
			}
			else
				User = new UserSid(SecurityIdentityType.ExtranetUser);
		}
		protected override void InitializeFields()
		{
		}
		protected override bool SaveUser()
		{
			if(Password.FirstPassword == string.Empty)
			{
				ErrorOccured(Translate("/templates/register/invalidpassword"));
				return false;
			}
			if(Email.Text.Length < 6 || Email.Text.IndexOf("@")<0)
			{
				ErrorOccured(Translate("/templates/register/invalidemail"));
				return false;
			}
			if(Configuration["EPfAutoActivateUser"] != null)
				User.Active = (bool)Configuration["EPfAutoActivateUser"];			
			if(Configuration["EPnDefaultGroup"] != null && (int)Configuration["EPnDefaultGroup"] != 0)
			{
				int defaultGroupID = (int)Configuration["EPnDefaultGroup"];
				GroupSid defaultGroup = GroupSid.Load(defaultGroupID);
				if(defaultGroup != null)
					User.MemberOfGroups.Add(defaultGroup);
			}

			if(base.SaveUser())
			{
				SendMail();
				return true;
			}
			else
				return false;
		}
		protected override void ApplyButton_Click(object sender, EventArgs e)
		{		
			SaveUser();
		}
		private void SendMail()
		{
			SendUserActivationRequestToAdmin();
			SendInformationToUser();
		}
		
		private void SendInformationToUser()
		{
			MailMessage msg		= new MailMessage();
			msg.From				= (string)Configuration["EPsRegistryEmailFrom"];
			msg.To					= Email.Text;

			if (msg.From.Length == 0)
			{
				if ((bool)Configuration["EPfAutoActivateUser"])
					// If we allow self-registering with auto-activation, there is no need to send an email
					return;
				// A self-registered user that is not auto-activated MUST generate an email, otherwise he
				// might never get the attention of an admin that can activate the account.
				throw new EPiServerException(Translate("/templates/register/invalidsettings"));
			}

			if((bool)EPiServer.Global.EPConfig["EPfAutoActivateUser"])
			{
				msg.Subject		= (string)Configuration["EPsActivationEmailSubject"];
				msg.Body			= (string)Configuration["EPsActivationEmailBody"];
				SavedMessage.Text	= Translate("/templates/register/usersavedandactivated");
			}
			else
			{
				msg.Subject		= (string)Configuration["EPsRegistryEmailSubject"];
				msg.Body			= (string)Configuration["EPsRegistryEmailBody"];
				SavedMessage.Text	= Translate("/templates/register/usersaved");
			}

			MailUtility.InitSmtpAuthentication(msg);
			SmtpMail.Send(msg);
		}

		private void SendUserActivationRequestToAdmin()
		{
			MailMessage msg = new MailMessage();

			msg.From		= (string)Configuration["EPsRegistryEmailFrom"];
			msg.To			= (string)Configuration["EPsRegistryEmailTo"];

			if (msg.To.Length == 0 || msg.From.Length == 0)
			{
				if ((bool)Configuration["EPfAutoActivateUser"])
					// If we allow self-registering with auto-activation, there is no need to send an email
					return;
				// A self-registered user that is not auto-activated MUST generate an email, otherwise he
				// might never get the attention of an admin that can activate the account.
				throw new EPiServerException(Global.EPLang.Translate("/templates/register/invalidsettings", GetSystemLanguage()));
			}
		
			msg.Subject	= Global.EPLang.Translate("/templates/register/applyemailsubject",GetSystemLanguage());
			msg.Body		= Global.EPLang.Translate("/templates/register/applyemailbodyprefix", GetSystemLanguage()) + " \n" + 
				EPiServer.Global.EPConfig.AbsoluteAdminUrl + 
				"edituser.aspx?id=" + User.ID + "&type=2";

			MailUtility.InitSmtpAuthentication(msg);
			SmtpMail.Send(msg);
		}
		private string GetSystemLanguage()
		{
			if(IsValue("PageLanguageID"))
				return (string)CurrentPage["PageLanguageID"];
			else if(Global.EPConfig["EPsLanguage"] != null)
				return (string)Global.EPConfig["EPsLanguage"];
			return "EN";			
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
		}
		#endregion
	}
}