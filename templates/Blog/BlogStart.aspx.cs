/*
 * @(#) $Id: BlogStart.aspx.cs,v 1.1.2.1 2006/02/09 15:10:22 svante Exp $
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
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;


namespace development.Templates.Blog
{
    /// <remarks>
    /// The blog-sample is also a sample on a programmatic use of XForms, and contains examples
    /// of various techniques to work with EPiServer.
    /// 
    /// DISCLAIMER: This is a sample intended to serve as a template for further work. It may not
    /// scale to very large numbers of blogs, or blog entries, or comments. If you use this as a
    /// starting point for a production site, you are responsible for testing performance and
    /// functionality in it's intended usage scenario.
    /// 
    /// There are two PageType's that must be defined, they are here assumed to be called
    /// 'BlogStartPage' and 'BlogPage', which are mapped to 'BlogStart.aspx' and 'Blog.aspx' respectively.
    /// 
    /// This is the BlogStartPage markup and code-behind. The markup BlogStart.aspx is the starting-point
    /// for all blogs, and the page type must as mentioned be BlogStartPage. Use the markup to present the
    /// blog-section of the site for example. This we were we have placed the functionality to create new
    /// blogs via the BlogCreate user control.
    /// 
    /// No work is done here, check:
    /// <list type="bullet">
    /// <item>BlogCreate.ascx for info on how a blog is created.</item>
    /// <item>Blog.aspx for the markup related to a single blog, as well as documentation of how blogs are persisted.</item>
    /// </list>
    /// 
    /// The order of work, when setting up from scratch, is:
    /// <list type="number">
    /// <item>Define blog page type, i.e. "BlogPage" (see Blog.aspx)</item>
    /// <item>Define properties for "BlogPage" (XForms, ContentLayout etc see Blog.aspx)</item>
    /// <item>Create a dummy page so you can define the XForms (See Util.cs for names, i.e. "BlogPostForm" and "BlogCommentForm", and see Blog.aspx)</item>
    /// <item>Define blog start page type, i.e. "BlogStartPage"</item>
    /// </list>
    /// 
    /// First of all, you need to establish the XForms which are used for Blogs and Comments. These have the names defined in
    /// Util.cs, for example BlogPostFormPropertyName is set to "BlogPostForm", and BlogCommentFormPropertyName is set to "BlogCommentForm".
    /// See Blog.aspx for details about the requirements of these XForms. Do that now...
    /// 
    /// BlogPostForm
    /// 
    /// The BlogStartPage EPiServer page type must correspond to BlogStart.aspx and should contain at least two LongString properties:
    /// <list type="bullet">
    /// <item>MainIntro - The heading/title of the start page</item>
    /// <item>MainBody - An introductory text describing the blog-section of the site</item>
    /// </list>
    /// </remarks>
    public class BlogStart : EPiServer.TemplatePage
    {
        private void Page_Load(object sender, System.EventArgs e)
        {
            // Put user code to initialize the page here
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
