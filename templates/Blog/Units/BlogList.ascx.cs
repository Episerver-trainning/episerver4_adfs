/*
 * @(#) $Id: BlogList.ascx.cs,v 1.1.2.4 2006/03/06 13:35:17 svante Exp $
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
using System.Collections.Specialized;
using System.Data;
using System.Drawing;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using EPiServer;
using EPiServer.BaseLibrary;
using EPiServer.Core;
using System.Collections;
using EPiServer.BaseLibrary.Search;
using EPiServer.XForms;
using EPiServer.XForms.WebControls;


namespace development.Templates.Blog.Units
{
    /// <summary>
    ///     Summary description for BlogList.
    /// </summary>
    public class BlogList : EPiServer.UserControlBase
    {
        /// <summary>
        /// Internal helper class to hold a together a Blog Entry
        /// </summary>
        internal class BlogEntry : BlogUtil.PostedEntryBase
        {
            internal BlogEntry(XFormData formData, string output) : base(formData)
            {
                PostedText = output;
            }

            public Guid XFormDataId 
            {
                get 
                {
                    return (Guid)FormData.Id;
                }
            }
        }


        #region Fields
        protected System.Web.UI.WebControls.Repeater dataRepeater;
        #endregion
        
        private void Page_Load(object sender, System.EventArgs e)
        {
            if (!IsPostBack)
            {
                // Get the xform associated with the page property defined to contain the XForm for blog posting
                EPiServer.Core.PropertyXForm xFormPageProperty = (EPiServer.Core.PropertyXForm)CurrentPage.Property[BlogUtil.BlogPostFormPropertyName];
            
                // Get a list of posted data, i.e. the blog entries, for the given range
                IList listOfPostedData = xFormPageProperty.Form.GetPostedData(CurrentPage.PageLink.ID, BeginDate, EndDate);
                
                // Build filtered and formatted ArrayList of blogs to sort and subsequently use as DataSource for the Repeater control
                ArrayList listOfFormattedBlogs = new ArrayList();

                // This gets to be re-used, so we cache it in a string
                string blogListLayoutTemplate = (string)CurrentPage[BlogUtil.BlogListLayoutPropertyName];

                foreach (XFormData xformData in listOfPostedData)
                {
                    if (BlogUtil.IsStringTrue(xformData.GetValue(BlogUtil.IsUnpublishedXFormValueName))) 
                    {
                        // Don't add unpublished blogs to the list
                        continue;
                    }

                    // Get and substitute the standard XForm fields found in the data
                    System.Text.StringBuilder posting = BlogUtil.FieldCodeReplace(xformData, blogListLayoutTemplate);

                    listOfFormattedBlogs.Add(new BlogEntry(xformData, posting.ToString()));
                }
                listOfFormattedBlogs.Sort(); 
                dataRepeater.DataSource = listOfFormattedBlogs;
                dataRepeater.DataBind();    
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
        }
        #endregion

        #region Properties
        /// <summary>
        /// The start of the date range to display blogs for. This is either the current
        /// month, or a month specified via a query parameter.
        /// </summary>
        protected DateTime BeginDate
        {
            get 
            {
                DateTime startDate = DateTime.Now;
                if (Request[BlogUtil.BlogDisplayBeginDateQueryParameterName] != null)
                {
                    startDate = DateTime.Parse(Request[BlogUtil.BlogDisplayBeginDateQueryParameterName]);
                }
                return new DateTime(startDate.Year, startDate.Month, 1);
            }
        }
        
        /// <summary>
        /// The end of the data range to display blogs for. This is one month from 
        /// BeginDate.
        /// </summary>
        protected DateTime EndDate
        {
            get 
            {
                return BeginDate.AddMonths(1);
            }
        }
        #endregion

//        #region Methods
//        public void AddCommentToBlog(Guid commentXFormId, Guid commentId) 
//        {
//            XFormData blogData = XFormData.CreateInstance(commentXFormId);
//            if (blogData != null)
//            {
//                StringBuilder commentIds = new StringBuilder(blogData.GetValue(BlogUtil.CommentIdsXFormValueName));
//                // If we already have a list of comment ids, we separate this from the next with a ";"
//                if (commentIds.Length > 0) 
//                {
//                    commentIds.Append(";");
//                }
//                commentIds.Append(commentId.ToString());
//
//                blogData.SetValue(BlogUtil.CommentIdsXFormValueName, commentIds.ToString());
//                blogData.Send(blogData.FormId);
//            }
//        }
//        #endregion
    }
}
