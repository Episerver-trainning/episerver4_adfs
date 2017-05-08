/*
 * @(#) $Id: Blog.aspx.cs,v 1.1.2.4 2006/03/13 09:48:57 svante Exp $
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

using development.Templates.Blog.Units;


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
    /// This template is representd by the BlogPage page type in EPiServer. The BlogPage must have the
    /// following properties:
    /// 
    /// <list type="bullet">
    /// <item>MainIntro - Unused in this sample, but could be used as a title in the mark-up</item>
    /// <item>MainBody - The introduction to this blog</item>
    /// <item>BlogPostForm - An XForm for the actual blog</item>
    /// <item>BlogCommentForm - An XForm for user comments on a blog entry</item>
    /// <item>BlogContentLayout - A LongString with substitution markers for content from the blog XForm</item>
    /// 
    /// <list type="bullet">
    /// <listheader>The substitution markers are in fact the XForm field names enclosed in curly braces.</listheader>
    /// <item>{BTitle} - The title of the blog entry</item>
    /// <item>{BText} - The main text of the blog entry</item>
    /// <item>{DatePosted} - The date and time the entry was posted</item>
    /// </list>
    /// </list>
    /// 
    /// EPiServer currently does not include a user interface to define and edit an XForm without actually placing it on
    /// a page. The recommended practice is thus to either use the provided defintions of BlogPostForm and BlogCommentForm, or in
    /// a new site to create a dummy page and on that page add, define and editd the XForms.
    /// 
    /// The following are the requirements:
    /// 
    /// The blog XForms are expected to reside in a XForm-folder, the name of which is defined as BlogUtil.BlogFormsFolder,
    /// so you must place them there.
    ///
    /// BlogPostForm property must be set to an XForm, perhaps named BlogPost, with the following data fields:
    /// <list type="bullet">
    /// <item>BTitle - A text field used for the title of the blog entry</item>
    /// <item>BText - A text field used for the main text of the blog entry</item>
    /// </list>
    /// The BlogPostForm is not actually used for data-entry, so it just needs the fields - it does not need formatting
    /// for display with headings etc.
    /// 
    /// BlogCommentForm property must be set to an XForm, perhaps named BlogComment, with the following data fields:
    /// <list type="bullet">
    /// <item>CEmail - A text field used for the commenters e-mail, validated as e-mail, about 70 chars wide</item>
    /// <item>CText - A text area, with the text of the comment, about 70 chars wide, 10 rows</item>
    /// <item>A 'Save' button with the action to "save to database"</item>
    /// </list>
    /// The BlogCommentForm is used as-is for data-entry of the comments, so it needs to be formatted appropriately.
    /// 
    /// The code will programmatically assign the XForm property fields to the correct values, provided that the names
    /// map correctly. Please see the name definitons in Util.cs for exact details.
    /// </remarks>
    public class Blog : EPiServer.TemplatePage
    {
        protected PersonalBlog personalBlog;
        protected BlogArchive archive;
        protected LinkButton btnModeGo2Edit;
        protected LinkButton btnModeGo2View;
        protected PlaceHolder viewModeNavigation;

        private void Page_Load(object sender, System.EventArgs e)
        {
            if (!IsPostBack && personalBlog.HasEditAccess)
            {
                // Trig initial SetViewMode for controls.
                if (SetViewMode != null) 
                {
                    SetViewMode(this, new BlogSetViewEventArguments(personalBlog.pnlEdit.Visible)); 
                }
            }
        }

        /// <summary>
        /// This is subscribed to by BlogArchive.ascx, and is used to keep the BlogArchive control edit mode in sync.
        /// </summary>
        public event BlogSetViewEventHandler SetViewMode;
        public delegate void BlogSetViewEventHandler(object sender, BlogSetViewEventArguments e);

        public bool EditMode
        {
            get
            {
                return ViewState["EditMode"] == null ? false : (bool)ViewState["EditMode"];
            }
            set
            {
                ViewState["EditMode"] = value;
            }
        }

        /// <summary>
        /// Toggle the edit mode setting
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnMode_Click(object sender, EventArgs e)
        {
            // Signal other interested parties that the view mode has changed. Subscribe to this event if you're interested
            // in a change of view mode.
            if (SetViewMode != null) 
            {
                SetViewMode(this, new BlogSetViewEventArguments(!personalBlog.pnlEdit.Visible)); 
            }
        }


        public void OnSetViewMode(object sender, BlogSetViewEventArguments e)
        {
            EditMode = e.EditMode;
            btnModeGo2Edit.Visible = !e.EditMode;
            btnModeGo2View.Visible = e.EditMode;
            viewModeNavigation.Visible = !e.EditMode;
        }

        #region Web Form Designer generated code
        override protected void OnInit(EventArgs e)
        {
            //
            // CODEGEN: This call is required by the ASP.NET Web Form Designer.
            //
            InitializeComponent();
            base.OnInit(e);

            // Subscribed to a change i view-state, and propagate it to the 'archive' listing, so that it can maintain the edit mode
            // in it's links
            SetViewMode += new BlogSetViewEventHandler(archive.OnSetViewMode);
            SetViewMode += new BlogSetViewEventHandler(personalBlog.OnSetViewMode);
            SetViewMode += new BlogSetViewEventHandler(OnSetViewMode);
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
    public class BlogSetViewEventArguments : EventArgs
    {
        private bool _editMode;

        public BlogSetViewEventArguments(bool editMode)
        {
            _editMode = editMode;
        }  

        /// <summary>
        /// The mode you want to change to
        /// </summary>
        public bool EditMode
        {
            get
            {
                return _editMode;
            }
        }
    }
}
