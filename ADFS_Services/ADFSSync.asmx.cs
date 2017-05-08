using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Web;
using System.Web.Services;
using EPiServer.DataAbstraction;
using EPiServer.Security;
using EPiServer.Util;
using System.Security.Principal;

namespace development.ADFS_Services
{
	/// <summary>
	/// Summary description for ADFSSync.
	/// </summary>
	public class ADFSSync : System.Web.Services.WebService
	{
		public ADFSSync()
		{
			//CODEGEN: This call is required by the ASP.NET Web Services Designer
			InitializeComponent();
		}

		#region Component Designer generated code
		
		//Required by the Web Services Designer 
		private IContainer components = null;
				
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
		}

		/// <summary>
		/// Clean up any resources being used.
		/// </summary>
		protected override void Dispose( bool disposing )
		{
			if(disposing && components != null)
			{
				components.Dispose();
			}
			base.Dispose(disposing);		
		}
		
		#endregion
		
		[WebMethod]
		public string SaveUser(string username, string password, string roles)
		{						 
			UserSid userSid = new UserSid(SecurityIdentityType.ExtranetUser);
			userSid.Name = username;
			userSid.SetPassword(password);
		    GroupSid groupSid = GroupSid.Load("WebAdmins");
			userSid.MemberOfGroups.Add(groupSid);
			userSid.Active = true;
			userSid.Save();			
		
			return username + " " + password;
		}

		[WebMethod]
		public string VerifyPassword(string username, string password)
		{
			UserSid userSid = UserSid.Load(username);
			UnifiedPrincipal unifiedPrincipal = new UnifiedPrincipal(userSid);
			return unifiedPrincipal.CheckPassword(password).ToString();
		}
	}
}
