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
using EPiServer;
using EPiServer.Core;
using EPiServer.WebControls;
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
	/// Summary description for NewsGroupSearch.
	/// </summary>
	public class NewsGroupSearch : NewsGroup
	{
		protected TextBox				SearchQuery;
		protected CheckBox				SearchFiles;
		protected HtmlGenericControl	SearchHelp,Message;
		protected PageSearch			SearchResults;
		protected UserControl			pageHeader;

		private void Page_Load(object sender, System.EventArgs e)
		{
			try 
			{
				Page.RegisterStartupScript("FocusToInput",String.Format("<script type='text/javascript'>document.all['{0}'].focus();</script>",SearchQuery.ClientID));
				Page.RegisterClientScriptBlock("SearchHelp", "<script type='text/javascript'>function ToggleHelp(){" + SearchHelp.ClientID + ".style.display=(" + SearchHelp.ClientID + ".style.display=='none' ? 'block':'none');}</script>");
				SearchHelp.InnerHtml = Global.EPLang.Translate("/templates/search/help");

				if ( IsPostBack )
				{
					SearchHelp.Style["display"] = "none";
					Message.Style["display"] = "none";
					HandleSearch();
				}
			}
			catch (Exception exc)
			{
				HandleError(exc);
			}
			if(!IsPostBack)
			{
				pageHeader.DataBind();
				SearchResults.Visible = false;
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
				errorMessage = Global.EPLang.Translate("/templates/search/indexservererror");
				SearchFiles.Checked = false;
				SearchFiles.Enabled = false;
			}
			else
			{
				errorMessage = "*** Error: " + e.Message + " (" + e.Source + ")";

				//throw new Exception(errorMessage, e);
			}

			Message.InnerHtml = String.Format("<font size=\"2\"color=\"aa0000\"><b>{0}</b></font>", errorMessage);
			Message.Style["display"] = "block";
		}

		private void HandleSearch()
		{
			try
			{
				SearchResults.DataBind();
				SearchResults.Visible = true;
			}
			catch (Exception e)
			{
				HandleError(e);
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
