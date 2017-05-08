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
using System.Collections;
using EPiServer;
using EPiServer.Core;
using EPiServer.WebControls;
using EPiServer.DataAbstraction;

namespace development.Templates.Units
{
	/// <summary>
	///		Summary description for Search.
	/// </summary>
	public abstract class Search : UserControlBase
	{
		protected TextBox				SearchQuery;
		protected CheckBox				SearchFiles;
		protected Label					ErrorMessage;
		protected HtmlGenericControl	SearchHelp;
		protected PageSearch			SearchResults;
		protected Button				SearchButton;
		protected Panel					AllLanguagesPanel;
		protected CheckBox				AllLanguages;

		private void Page_Load(object sender, System.EventArgs e)
		{
			SearchQuery.TabIndex = 1;
			SearchButton.TabIndex = 2;

			Page.RegisterStartupScript("FocusToInput",String.Format("<script type='text/javascript'>document.all['{0}'].focus();</script>",SearchQuery.ClientID));
			SearchHelp.InnerHtml = "<br>" + Translate("/templates/search/help");

			AllLanguagesPanel.Visible = (bool)Global.EPConfig["EPfEnableGlobalizationSupport"] && LanguageBranch.List().Count > 1;

			if ( IsPostBack )
			{
				ErrorMessage.Visible = false;
			}
			else if (SearchQuery.Text.Length == 0 && Request.QueryString["quicksearchquery"] != null)
			{
				SearchQuery.Text = Request.QueryString["quicksearchquery"];
				HandleSearch();
			}
		}

		protected virtual void HandleError(Object sender, EventArgs e)
		{
			HandleError(Server.GetLastError());
		}

		private void HandleError(Exception e)
		{
			string errorMessage;

			if (e.Message.ToLower().IndexOf("index server") > -1)
			{
				errorMessage = Translate("/templates/search/indexservererror");
				SearchFiles.Checked = false;
				SearchFiles.Enabled = false;
			}
			else
			{
				errorMessage = "*** Error: " + e.Message + " (" + e.Source + ")";
			}

			ErrorMessage.Text = errorMessage;
			ErrorMessage.Visible = true;
		}

		private void HandleSearch()
		{
			if (SearchQuery.Text.Length == 0)
				return;
			try
			{
				if ((bool)Global.EPConfig["EPfEnableGlobalizationSupport"] && !AllLanguages.Checked )
				{
					ArrayList languageBranch = new ArrayList();
					languageBranch.Add( LanguageContext.Current.CurrentLanguageBranch );
					SearchResults.LanguageBranches = languageBranch;
				} 
				else 
				{
					SearchResults.LanguageBranches = null;
				}

				SearchResults.DataBind();
			}
			catch (Exception e)
			{
				HandleError(e);
			}
		}

		private void SearchButton_Click(object sender, EventArgs e)
		{
			SearchResults.PagingControl.CurrentPagingItemIndex = 0;
			HandleSearch();
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
			SearchButton.Click += new System.EventHandler(SearchButton_Click);
		}
		#endregion
	}
}
