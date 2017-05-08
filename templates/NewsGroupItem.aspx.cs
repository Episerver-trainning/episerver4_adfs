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
using EPiServer.Core;
using EPiServer.Security;
using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace development.Templates
{
	/// <summary>
	/// Summary description for NewsGroupItem.
	/// </summary>
	public class NewsGroupItem : NewsGroup
	{
		protected EPiServer.WebControls.Property		WriterName;
		protected EPiServer.WebControls.Property		WriterEmail;
		protected EPiServer.WebControls.Property		PageName;
		protected EPiServer.WebControls.Property		pageBody;
		protected System.Web.UI.WebControls.Button		publish;
		protected System.Web.UI.WebControls.Panel		TableHeader, Answer;
		protected System.Web.UI.WebControls.LinkButton	Subscribe;

		protected bool _newPost;
		private void Page_Load(object sender, System.EventArgs e)
		{	
			if(CurrentUser.UserData == null)
				Subscribe.Visible = false;
			else if(CurrentUser.UserData["EPSUBSCRIBE",CurrentPage.PageLink] == null ||(bool)CurrentUser.UserData["EPSUBSCRIBE",CurrentPage.PageLink] == false )
				Subscribe.Text = Translate("/templates/newsgrouplist/subscribe");
			else
				Subscribe.Text = Translate("/templates/newsgrouplist/unsubscribe");
			CheckIf_newPost();
			if(!_newPost)
			{
				Answer.Visible = CurrentPage.ACL.QueryDistinctAccess(EPiServer.Security.AccessLevel.Create);
				string fixListUpdate;
				fixListUpdate = @"
					<script type='text/javascript'>
						if(parent.frames.NewsGroupList != null)
							parent.frames.NewsGroupList.location.href = parent.frames.NewsGroupList.location.pathname + '?id=" + CurrentPage.PageLink.ID + @"'
					</script>";
				Page.RegisterStartupScript("UpdateNewsList", fixListUpdate);
				TableHeader.Visible = true;
			}
		}
		protected void CheckIf_newPost()
		{
			if (Request.Params["Parent"] != null)
			{
				_newPost = true;
				WriterName.EditMode = true;
				WriterEmail.EditMode = true;
				PageName.EditMode	= true;
				if(Request.Params["pagename"] != null)
					PageName.InnerProperty.Value = "Re:" + Request.Params["pagename"];
				if(User.Identity.IsAuthenticated)
				{
					string name = string.Empty;
					if(UnifiedPrincipal.Current.UserData.FirstName != null)
						name = UnifiedPrincipal.Current.UserData.FirstName;
					if(UnifiedPrincipal.Current.UserData.LastName != null)
					{
						if(name != string.Empty)
							name += " ";
						name += UnifiedPrincipal.Current.UserData.LastName;
					}

					WriterName.InnerProperty.Value	= name;
					WriterEmail.InnerProperty.Value	= UnifiedPrincipal.Current.UserData.Email;
				}

				pageBody.EditMode	= true;
				publish.Visible		= true;
				PageName.InnerProperty.IsRequired = true;
			}
			else
				_newPost = false;
		}
		protected override void SavePage()
		{	
			if (!CurrentPage.Property.Exists("NewsGroupRoot"))
				CurrentPage.Property.Add("NewsGroupRoot", new PropertyPageReference( CurrentNewsGroup ) );
			else
				CurrentPage.Property["NewsGroupRoot"].Value = CurrentNewsGroup;
			base.SavePage();
			Response.Redirect(Request.Path + "?id=" + this.CurrentPage.PageLink.ID);
		}
		protected void ChangeSubscribtion(object sender, System.EventArgs e)
		{
			if(! CurrentPage.Property.Exists("EPSUBSCRIBE") || (CurrentUser.UserData == null))
				return;
			if(CurrentUser.UserData["EPSUBSCRIBE",CurrentPage.PageLink] == null ||(bool)CurrentUser.UserData["EPSUBSCRIBE",CurrentPage.PageLink] == false )
			{
				Subscribe.Text = Translate("/templates/newsgrouplist/unsubscribe");
				CurrentUser.UserData["EPSUBSCRIBE",CurrentPage.PageLink] = true;
			}
			else
			{
				Subscribe.Text = Translate("/templates/newsgrouplist/subscribe");
				CurrentUser.UserData["EPSUBSCRIBE",CurrentPage.PageLink] = false;
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
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{    
			this.Load += new System.EventHandler(this.Page_Load);
		}
		#endregion
	}
}
