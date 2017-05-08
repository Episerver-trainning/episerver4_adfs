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
using System.Security.Principal;
using System.Web;
using System.Web.Configuration;
using System.Web.Security;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using EPiServer;
using EPiServer.Security;

namespace development.Templates.Units
{
	/// <summary>
	///		Summary description for LoginStatus.
	/// </summary>
	public abstract class LoginStatus : UserControlBase
	{
		protected System.Web.UI.WebControls.Label UserName;
		protected System.Web.UI.WebControls.LinkButton Login,Logout;

		private void Page_Load(object sender, System.EventArgs e)
		{
			IPrincipal user = Context.User;
			if (user != null && user.Identity.IsAuthenticated)
			{
				UserName.Text		= user.Identity.Name;
				UserName.Visible	= true;
				Logout.Visible		= EPiServer.Global.EPConfig.Authentication == AuthenticationMode.Forms;
				Login.Visible		= false;
			}
			else
			{
				DisplayLoginLink();
			}
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
			if (user.Identity.IsAuthenticated)
			{
				if (Configuration.Authentication != AuthenticationMode.Forms)
					return;
				FormsAuthentication.SignOut();
				UnifiedPrincipal.RemoveFromCache( user.Identity );
				DisplayLoginLink();

				PageBase.CurrentUser = UnifiedPrincipal.AnonymousUser;

				if(!PageBase.QueryDistinctAccess())
					Response.Redirect(Configuration.RootDir);
			}
		}

		private void DisplayLoginLink()
		{
			UserName.Visible = false;
			Login.Visible = true;
			Logout.Visible = false;
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
		
		///		Required method for Designer support - do not modify
		///		the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
			this.Login.Click += new System.EventHandler(this.Login_Click);
			this.Logout.Click += new System.EventHandler(this.Logout_Click);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion
	}
}
