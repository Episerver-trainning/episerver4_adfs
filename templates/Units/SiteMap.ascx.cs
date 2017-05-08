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
using System.Text;
using System.Web;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using EPiServer;
using EPiServer.Core;

namespace development.Templates.Units
{	
	/// <summary>
	///		Summary description for SiteMap.
	/// </summary>
	public abstract class Sitemap : UserControlBase
	{
		protected EPiServer.WebControls.SiteMap SitemapControl;
		private readonly string PAGE_DELIMITER = " - ";
		private PageReference _pathRoot;

		private void Page_Load(object sender, System.EventArgs e)
		{
			if(!IsPostBack)
			{
				if (!IsValue("IndexLevel"))
					throw new EPiServerException("IndexLevel is not set. ");
				if (!IsValue("IndexColumns"))
					throw new EPiServerException("IndexColumns is not set. ");

				_pathRoot = IsValue("IndexContainer") ? (PageReference)CurrentPage["IndexContainer"] : Configuration.StartPage;
				SitemapControl.DataBind();				
			}			
		}
		protected string GetPagePath(PageData page)
		{
			PageData parent = page;
			StringBuilder path = new StringBuilder();

			path.Append(parent.PageName);

			while(parent.ParentLink != _pathRoot)
			{
				parent = GetPage(parent.ParentLink);
				path.Insert(0, PAGE_DELIMITER);
				path.Insert(0, parent.PageName);
			}
			return path.ToString();
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
		///	Required method for Designer support - do not modify
		///	the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
			this.Load += new System.EventHandler(this.Page_Load);
		}
		#endregion
	}
}
