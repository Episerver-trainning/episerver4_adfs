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
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using EPiServer;
using EPiServer.Security;

namespace development.Templates
{
	/// <summary>
	/// Summary description for Login.
	/// </summary>
	public class Login : EPiServer.Util.LoginBase
	{
		private void Page_Load(object sender, System.EventArgs e)
		{
			SetupForm();
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
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{    
			this.LoginButton.Click += new System.EventHandler(this.Login_Click);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

		protected void Login_Click(object sender, System.EventArgs e)
		{
			string url = HandleLogin();
			if (url != null)
				Response.Redirect( url );
		}
	}
}