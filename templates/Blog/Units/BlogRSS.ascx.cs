/*
 * @(#) $Id: BlogRSS.ascx.cs,v 1.1.2.1 2006/02/09 15:10:42 svante Exp $
 * 
 * Copyright © 2006 ElektroPost Stockholm AB. All Rights Reserved.
 * 
 * This code may only be used according to the EPiServer License Agreement.
 * The use of this code outside the EPiServer environment, in whole or in
 * parts, is forbidden without prior written permission from ElektroPost
 * Stockholm AB.
 * 
 * EPiServer is a registered trademark of ElektroPost Stockholm AB. For
 * more information see http://www.episerver.com/license or request a
 * copy of the EPiServer License Agreement by sending an email to info@ep.se .
*/

using System;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Collections;


namespace development.Blog.Units
{
	/// <summary>
	///	User control to provide a RSS feed for blogs
	/// </summary>
	public class BlogRSS : EPiServer.UserControlBase
	{

        private void Page_Load(object sender, System.EventArgs e)
		{
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
    
        #region Properties
        /// <summary>
        /// The URL to the RSS-provider page for this page.
        /// </summary>
        protected string UrlToRSS
        {
            get
            {
                // Return a root-relative URL including the parameter to the RSS-Provider code
                return ResolveUrl(string.Format("~/templates/Blog/BlogRssProvider.aspx?id={0}", CurrentPage.PageLink.ID.ToString()));
            }
        }
        #endregion
        
    }
}
