/*
 * @(#) $Id: CommentXForm.ascx.cs,v 1.1.2.3 2006/02/28 11:02:41 sl Exp $
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
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Collections;

using EPiServer;
using EPiServer.BaseLibrary;
using EPiServer.Core;

using EPiServer.BaseLibrary.Search;
using EPiServer.XForms;
using EPiServer.XForms.WebControls; 


namespace development.Templates.Blog.Units
{
    /// <summary>
    /// Summary description for BlogList.
    /// </summary>
    public class CommentXForm : EPiServer.UserControlBase
    {
        /// <summary>
        /// Internal representation of a comment entry, used by the DataList
        /// control to display the list of current comments
        /// </summary>
        internal class CommentEntry : BlogUtil.PostedEntryBase
        {
            #region Properties
            /// <summary>
            /// The e-mail of the comment poster
            /// </summary>
            public string PosterEmail
            {
                get 
                {
                    return FormData.GetValue("CEmail");
                }
            }
            /// <summary>
            /// The posted comment text
            /// </summary>
            new public string PostedText
            {
                get
                {
                    return FormData.GetValue("CText");
                }
            }
            #endregion
        
            #region Methods
            internal CommentEntry(XFormData formData) : base(formData)
            {
            }
            #endregion
        }


        #region Fields

        #region Protected Fields
        /// <summary>
        /// Toggle the visibility of the list of previous comments
        /// </summary>
        protected System.Web.UI.WebControls.LinkButton buttonShowComments;
        /// <summary>
        /// Toggle the display state of the comment entry form
        /// </summary>
        protected System.Web.UI.WebControls.LinkButton buttonShowCommentXForm;
        /// <summary>
        /// The Repeater control which displays the list of previous comments for this blog entry
        /// </summary>
        protected Repeater commentList;
        /// <summary>
        /// An instance of a XForm used to submit comments for a blog entry
        /// </summary>
        protected EPiServer.XForms.WebControls.XFormControl submitCommentXForm;
        #endregion

        #endregion

        private void Page_Load(object sender, System.EventArgs e)
        {
            if (!IsPostBack) 
            {
                DataBindCommentList();
            } 
        }


        #region Web Form Designer generated code
        protected override void OnInit(EventArgs e)
        {
            //
            // CODEGEN: This call is required by the ASP.NET Web Form Designer.
            //
            InitializeComponent();
            base.OnInit(e);

            // Get the GUID of the XForm definition set to be used for entering comments, and create an instance,
            // set this to be the instance used for the submit-a-comment form.
            submitCommentXForm.FormDefinition = EPiServer.XForms.XForm.CreateInstance(new Guid((string)CurrentPage.Property[BlogUtil.BlogCommentFormPropertyName].Value));
            submitCommentXForm.AfterSubmitPostedData += new SaveFormDataEventHandler(AfterSubmitPostedDataEventHandler);
        }
        
        /// <summary>
        ///     Required method for Designer support - do not modify
        ///     the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.buttonShowComments.Click += new System.EventHandler(this.buttonShowComments_Click);
            this.buttonShowCommentXForm.Click += new System.EventHandler(this.buttonShowCommentXForm_Click);
            this.Load += new System.EventHandler(this.Page_Load);
        }
        #endregion

        #region Methods
        /// <summary>
        /// Starting with the XFormDataId property containing the GUID of the blog entry,
        /// get the list of comments and build a list of them, finally binding that list
        /// to the DataList control which displays them.
        /// </summary>
        private void DataBindCommentList() 
        {
            // Get the XFormData for the selected blog entry, and from that the list of comments, as a Guid-array
            Guid[] commentIds = BlogUtil.GetCommentGuids(XFormData.CreateInstance(XFormDataId));

            // Build the list of published comments
            ArrayList comments = new ArrayList();
            foreach (Guid commentId in commentIds)
            {
                CommentEntry commentEntry = new CommentEntry(XFormData.CreateInstance(commentId));
                if (!commentEntry.IsUnPublished) {
                    comments.Add(commentEntry);
                }
            }
            comments.Sort();
            commentList.DataSource = comments;
            commentList.DataBind();

            // Now we know how many published comments there really are, so we format a message for the link button
            // used to show/hide the comments.
            buttonShowComments.Text = string.Format(EPiServer.Global.EPLang.Translate("/templates/blog/comments") + " ({0})", comments.Count);
        }
        #endregion

        #region Properties
        /// <summary>
        /// The caller is assumed to set the property XFormDataId to the string value of the
        /// GUID used to identify the XForm instance data for the selected blog entry. Since
        /// the property needs to be available after a postback we use ViewState as the persistance
        /// medium.
        /// </summary>
        public Guid XFormDataId
        {
            get
            {
                // There's no need for a backing cache field, since this is a very infrequent operation.
                return (Guid)ViewState["XFormDataId"];
            }
            set
            {
                ViewState["XFormDataId"] = value;
            }
        }
        #endregion

        #region Events
        /// <summary>
        /// Toggle the visibility of the comments listing
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void buttonShowComments_Click(object sender, System.EventArgs e)
        {
            commentList.Visible = !commentList.Visible;
            DataBindCommentList();
        }


        /// <summary>
        /// Toggle the visibility state of the "post a comment"-XForm
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void buttonShowCommentXForm_Click(object sender, System.EventArgs e)
        {
            submitCommentXForm.Visible = !submitCommentXForm.Visible;
        }


        /// <summary>
        /// Triggered after submission of a new comment. We must now
        /// add the guid of this form data to the list of comments that the blog form knows about. To make this
        /// possible, we must find a reference to the blog form, for this we use the XFormDataId property that
        /// we keep around in the ViewState.
        /// </summary>
        /// <param name="sender">The XFormControl that is submitting the new data</param>
        /// <param name="e">Event arguments containg the instance data etc</param>
        private void AfterSubmitPostedDataEventHandler(object sender, SaveFormDataEventArgs e) 
        {
            XFormData blogData = XFormData.CreateInstance(XFormDataId);
            if (blogData != null)
            {
                string commentIds = blogData.GetValue(BlogUtil.CommentIdsXFormValueName);
                if (commentIds != string.Empty) 
                {
                    commentIds = commentIds + ";" + ((Guid)e.FormData.Id).ToString();
                }
                else 
                {
                    commentIds = ((Guid)e.FormData.Id).ToString();
                }
                blogData.SetValue(BlogUtil.CommentIdsXFormValueName, commentIds);
                blogData.Send(blogData.FormId);

                DataBindCommentList();

                // Always hide the post-a-comment form after a successful posting
                submitCommentXForm.Visible = false;
            }
        }
        #endregion
    }
}
