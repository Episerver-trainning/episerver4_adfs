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
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using EPiServer;
using EPiServer.Core;
using EPiServer.WebControls;

namespace development.Templates.Units
{
	/// <summary>
	///		Summary description for Quicksearch.
	/// </summary>
	public abstract class Quicksearch : UserControlBase
	{
		protected TextBox				SearchText;
		protected Label					QuicksearchCaption;
		protected LinkButton			QuickSearchButton;
		protected Label					ErrorInfo;
		protected HtmlGenericControl	QuickSearchSpan;

		private const string MAIN_SEARCH_PAGE = "MainSearchPage";

		private void Page_Load(object sender, System.EventArgs e)
		{
			if(!IsPostBack)
			{
				if (CurrentPage[MAIN_SEARCH_PAGE] == null)
				{
					ErrorInfo.Text				= Translate("/templates/page/notproperlyconfigured");
					ErrorInfo.Visible			= true;
					SearchText.Enabled			= false;
					QuickSearchButton.Enabled	= false;
					return;
				}
				else if ((PageReference)CurrentPage[MAIN_SEARCH_PAGE] == PageBase.CurrentPageLink)
				{
					QuickSearchSpan.Visible		= false;
					return;
				}

				QuickSearchButton.Enabled		= true;
				SearchText.Enabled				= true;
				ErrorInfo.Visible				= false;
			}
		}

		private void QuickSearch()
		{
			try
			{
				PageReference mainSearchPage = (PageReference)CurrentPage[MAIN_SEARCH_PAGE];

				string searchUrl = GetPage(mainSearchPage).LinkURL;
				if(searchUrl.IndexOf("?") > 0)
					searchUrl += "&quicksearchquery=";
				else
					searchUrl += "?quicksearchquery=";

				searchUrl += HttpContext.Current.Server.UrlEncode(SearchText.Text);
				
				Response.Redirect(searchUrl, true);
			}
			catch (Exception exc)
			{
				ErrorInfo.Text = exc.Message;
				ErrorInfo.Visible = true;
			}
		}

		protected void QuickSearchButton_Click(object sender, System.EventArgs e)
		{
			QuickSearch();
		}

		protected void SearchText_TextChanged(object sender, System.EventArgs e)
		{
			QuickSearch();
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
