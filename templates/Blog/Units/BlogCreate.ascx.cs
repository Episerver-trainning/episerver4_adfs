/*
 * @(#) $Id: BlogCreate.ascx.cs,v 1.1.2.3 2006/03/06 13:35:15 svante Exp $
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
using System.Text;
using System.Web;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Collections;

using EPiServer;
using EPiServer.Core;


namespace development.Templates.Blog.Units
{
    /// <summary>
    /// User control to display input fields, accept the name of a new Blog Page, and create it.
    /// </summary>
    public class BlogCreate : UserControlBase
    {
        #region Fields
        /// <summary>
        /// This is where the user will enter the name of the new blog
        /// </summary>
        protected TextBox newBlogNameTextBox;
        /// <summary>
        /// Click on this to show the input fields for a new blog
        /// </summary>
        protected Button showButton;
        /// <summary>
        /// Click here to actually create a new blog
        /// </summary>
        protected Button createButton;
        /// <summary>
        /// The prompt-text for the blog name input field
        /// </summary>
        protected Label newBlogNameLabel;
        #endregion

        private void Page_Load(object sender, System.EventArgs e)
        {
            if (!IsPostBack) 
            {
                // There's a button that is disabled if we don't have the proper rights. If it is enabled,
                // it's used to show the actual input fields which is why they're false at first load
                newBlogNameTextBox.Visible = false;
                createButton.Visible = false;
                newBlogNameLabel.Visible = false;

                // Enable the button if we have the appropriate rights
                showButton.Enabled = HasCreateRights;
                
                DataBind();
            }
        }


        #region Web Form Designer generated code
        /// <summary>
        /// 
        /// </summary>
        /// <param name="e"></param>
        override protected void OnInit(EventArgs e)
        {
            //
            // CODEGEN: This call is required by the ASP.NET Web Form Designer.
            //
            InitializeComponent();
            base.OnInit(e);
        }
        
        /// <summary>
        ///     Required method for Designer support - do not modify
        ///     the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.Load += new System.EventHandler(this.Page_Load);
            this.createButton.Click += new EventHandler(createButton_Click);
            this.showButton.Click += new EventHandler(showButton_Click);
        }
        #endregion

        #region Properties
        /// <summary>
        /// true if the currently logged on user has the right to create pages here - i.e. create blogs.
        /// </summary>
        protected bool HasCreateRights
        {
            get
            {
                EPiServer.Security.AccessLevel level = CurrentPage.QueryAccess();
                EPiServer.Security.AccessLevel requiredLevel = (EPiServer.Security.AccessLevel.Publish | EPiServer.Security.AccessLevel.Create);
                return (requiredLevel == (requiredLevel & level));
            }
        }
        #endregion

        #region Methods
        /// <summary>
        /// Show the input fields to create a new Blog Page
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void showButton_Click(object sender, EventArgs e) 
        {
            newBlogNameTextBox.Visible = true;
            createButton.Visible = true;
            newBlogNameLabel.Visible = true;
            showButton.Visible = false;
        }

        /// <summary>
        /// Actually create a new Blog Page with a provided name
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void createButton_Click(object sender, EventArgs e)
        {
            // Always check permissions - don't trust that just not displaying the button is secure
            if (!HasCreateRights) 
            {
                return;
            }
            // If it's empty do nothing
            if (newBlogNameTextBox.Text == "") 
            {
                return;
            }

            // Create a new Blog Page
            PageData newBlog = EPiServer.Global.EPDataFactory.GetDefaultPageData(CurrentPage.PageLink, BlogUtil.BlogPageTypeName);

            // Since we have difficulty using the EPiServer interface to specify default vaules for XForm properties,
            // we do this programatically here. It's quite possible, if you know the string representation of the GUID, to
            // do it in the admin-interface, but very inconvenient...
            newBlog[BlogUtil.BlogPostFormPropertyName] = new PropertyXForm(BlogUtil.BlogPostFormId.ToString());
            newBlog[BlogUtil.BlogCommentFormPropertyName] = new PropertyXForm(BlogUtil.BlogCommentFormId.ToString());

            // If the page type does not have a default value, use a programmatic default
            if (newBlog[BlogUtil.BlogListLayoutPropertyName] == null || (string)newBlog[BlogUtil.BlogListLayoutPropertyName] == "") 
            {
                newBlog[BlogUtil.BlogListLayoutPropertyName] = BlogUtil.BlogListLayout;
            }

            newBlog.PageName = newBlogNameTextBox.Text;

            // Now save and publish the new blog, and use the new pagereference...
            PageReference pageReference = EPiServer.Global.EPDataFactory.Save(newBlog, EPiServer.DataAccess.SaveAction.Publish);

            // ...to go to the new Blog Page, with edit mode enabled
            Response.Redirect(BlogUtil.AppendQueryParamToUrl(new StringBuilder(PageBase.GetPage(pageReference).LinkURL), "edit=true").ToString());
        }
        #endregion
    }
}
