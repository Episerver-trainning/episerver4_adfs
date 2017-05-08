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
using System.Web;
using System.Web.Configuration;
using System.Web.Security;
using System.Security.Principal;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using EPiServer;
using EPiServer.Core;
using EPiServer.Security;

namespace development.Templates.Units
{	
	/// <summary>
	///		Summary description for QuickBar.
	/// </summary>
	public abstract class QuickBar : UserControlBase
	{
		private PageData		_sitemapPage;
		private PageData		_profilePage;
		protected LinkButton	LoginButton;
		protected LinkButton	LogoutButton;
		protected Label			UserName;

		private void Page_Load(object sender, System.EventArgs e)
		{
			HandleLoginStatusButton();
		}

		protected void Login_Click(Object sender, EventArgs e) 
		{
			IPrincipal user = Context.User;
			if (user != null && user.Identity.IsAuthenticated)
				return;

			PageBase.AccessDenied();
		}

		protected void Logout_Click(Object sender, EventArgs e) 
		{
			UnifiedPrincipal user = UnifiedPrincipal.Current;
			if (!user.Identity.IsAuthenticated)
				return;

			if (Configuration.Authentication == AuthenticationMode.Forms)
			{
				FormsAuthentication.SignOut();
			}
			else
			{
				Page.RegisterClientScriptBlock("Logout", "<script type='text/javascript'>document.execCommand('ClearAuthenticationCache');</script>");
			}

			UnifiedPrincipal.RemoveFromCache();
			PageBase.CurrentUser = UnifiedPrincipal.AnonymousUser;

			if(!PageBase.QueryDistinctAccess())
				Response.Redirect(Configuration.RootDir);
			else
				Response.Redirect(PageBase.CurrentPage.LinkURL);

			HandleLoginStatusButton();
		}

		protected void HandleLoginStatusButton()
		{
			HandleLoginStatusButton(Context.User);
		}

		protected void HandleLoginStatusButton(IPrincipal user)
		{
			bool isLoggedOn = user != null && user.Identity.IsAuthenticated;

			// To enable logout, we should be logged on and 
			//		doing forms authentication 
			//			OR
			//		using IE6 SP1 (cannot find a way to check for SP1, so settle for IE6)
			//
			// The final part is because since IE6 SP1 there is a way to clear the current logon
			// from the browser.
			LogoutButton.Visible	= isLoggedOn && (Global.EPConfig.Authentication == AuthenticationMode.Forms || Request.Browser.Type == "IE6");
			LoginButton.Visible		= !isLoggedOn;
			UserName.Visible		= isLoggedOn;
			if (isLoggedOn)
			{
				UserName.Text		= user.Identity.Name;
			}
		}
		protected string SitemapPageLink
		{
			get
			{
				if(_sitemapPage == null)
				{
					if(CurrentPage["Sitemap"] == null)
						return null;
					_sitemapPage = GetPage((PageReference)CurrentPage["Sitemap"]);
				}
				if(_sitemapPage == null)
					return string.Empty;
				return _sitemapPage.LinkURL;
			}
		}
		protected string EditDetailsPageLink
		{
			get
			{
				if(_profilePage == null)
				{
					if(CurrentPage["ProfilePage"] != null)
						_profilePage = GetPage((PageReference)CurrentPage["ProfilePage"]);
					else if (CurrentPage["RegisterPage"] != null)
						_profilePage = GetPage((PageReference)CurrentPage["RegisterPage"]);
					else
						return null;
				}
				if(_profilePage == null)
					return string.Empty;
				if(_profilePage.LinkURL.IndexOf("?") > 0)
					return _profilePage.LinkURL + "&amp;editdetails=true";
				else
					return _profilePage.LinkURL + "?editdetails=true";
			}
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
			LogoutButton.Click += new EventHandler(Logout_Click);
			LoginButton.Click += new EventHandler(Login_Click);
			this.Load += new System.EventHandler(this.Page_Load);
		}
		#endregion
	}
}
