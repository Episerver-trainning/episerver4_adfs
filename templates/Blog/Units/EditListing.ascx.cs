/*
 * @(#) $Id: EditListing.ascx.cs,v 1.1.2.3 2006/02/28 11:02:46 sl Exp $
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
    public class EditList : EPiServer.UserControlBase
    {
        /// <summary>
        /// Common base clase for in-memory representation of postings and comments
        /// </summary>
        public class EditListBase : BlogUtil.PostedEntryBase 
        {            

            public EditListBase(XFormData blogData) : base(blogData)
            {
            }

            /// <summary>
            /// Init static fields that depend on the current page
            /// </summary>
            /// <param name="page"></param>
            static public void Init(Control page) 
            {
            }

            /// <summary>
            /// Get the text appropriate to toggle the current change publish status of the current item
            /// </summary>
            public string ChangePublishStatusText
            {
                get 
                {
                    if (IsUnPublished) 
                    {
                        return EPiServer.Global.EPLang.TranslateForScript("/button/publish");
                    } 
                    else 
                    {
						return EPiServer.Global.EPLang.TranslateForScript("/button/unpublish");
                    }
                }
            }

            /// <summary>
            /// A display-formatted PostedDate for the post
            /// </summary>
            public string FormattedPostedDate {
                get 
                {
                    return PostedDate.ToString(BlogUtil.DatePostedFormatString);
                }
            }

        }

        /// <summary>
        /// In-memory representation of one comment
        /// </summary>
        public class CommentEntry : EditListBase 
        {
            public CommentEntry(XFormData commentData) : base(commentData)
            {
            }

            /// <summary>
            /// The commenters e-mail
            /// </summary>
            public string Email
            {
                get 
                {
                    return FormData.GetValue("CEmail");
                }
            }
        }

        /// <summary>
        /// In-memory representation of one blog post
        /// </summary>
        public class EditBlogEntry : EditListBase
        {
            static private string _commentHeaderFormatString;

            public EditBlogEntry(XFormData blogData) : base(blogData)
            {
                if (_commentHeaderFormatString == null) 
                {
                    throw new ApplicationException("A call to Init must be made first to initialize static data");
                }
            }

            /// <summary>
            /// Init static fields that depend on the current page
            /// </summary>
            /// <param name="page"></param>
            static public void Init(string commentHeaderFormatString) 
            {
                _commentHeaderFormatString = commentHeaderFormatString;
            }

            /// <summary>
            /// The title of the blog entry 
            /// </summary>
            public string Title 
            {
                get 
                {
                    return FormData.GetValue(BlogUtil.BlogPostTitleFormFieldName);
                }
            }

            /// <summary>
            /// The list of comment entries available for this post, including unpublished - for editing.
            /// </summary>
            public CommentEntry[] CommentEntriesForEdit
            {
                get 
                {
                    Guid[] commentIds = CommentIds;
                    CommentEntry[] commentEntries = new CommentEntry[CommentIds.Length];
                    for (int i = 0; i < commentIds.Length; i++)
                    {
                        commentEntries[i] = new CommentEntry(XFormData.CreateInstance(commentIds[i]));
                    }
                    return commentEntries;
                }
            }

            /// <summary>
            /// Format a comments summary header for edit mode
            /// </summary>
            public string CommentsHeadingForEdit
            {
                get 
                {
                    return string.Format(_commentHeaderFormatString, CommentIds.Length);
                }
            }
       
        }

        protected System.Web.UI.WebControls.DataList blogEntryList;
        protected LinkButton btnShowXForm;
        protected LinkButton btnEditBlogEntry;
        protected Panel pnlList;
        protected Panel pnlXForm;
        protected EditorBlog editorBlog;
        protected EPiServer.WebControls.Property XFormProperty;
        
        #region Properties
        protected DateTime StartDate
        {
            get 
            {
                DateTime dt = DateTime.Now;
                dt = DateTime.Parse(dt.Year+"-"+dt.Month+"-01");
                if (Request[BlogUtil.BlogDisplayBeginDateQueryParameterName]!=null)
                {
                    try
                    {
                        dt = DateTime.Parse(Request[BlogUtil.BlogDisplayBeginDateQueryParameterName]);
                    } 
                    catch 
                    {
                    }
                }
                return dt;
            }
        }
        protected DateTime EndDate
        {
            get 
            {
                return StartDate.AddMonths(1);
            }
        }
        public bool ShowBlogList
        {
            set
            {
                if ( value == true )
                {
                    pnlList.Visible = true;
                    pnlXForm.Visible = false;
                }
                else
                {
                    pnlList.Visible = false;
                    pnlXForm.Visible = true;
                }
            }
        }
        #endregion
        
        private void Page_Load(object sender, System.EventArgs e)
        {
            if (!IsPostBack)
            {
                EditListBase.Init(this);
                EditBlogEntry.Init(EPiServer.Global.EPLang.Translate("/templates/blog/comments") + " ({0})");

                EPiServer.Core.PropertyXForm xf = (EPiServer.Core.PropertyXForm)CurrentPage.Property[BlogUtil.BlogPostFormPropertyName];
                IList list = xf.Form.GetPostedData(CurrentPage.PageLink.ID, StartDate, EndDate);
            
                ArrayList listOfBlogEntries = new ArrayList();

                foreach (XFormData xFormData in list)
                {
                    listOfBlogEntries.Add(new EditBlogEntry(xFormData));
                }
                
                listOfBlogEntries.Sort();
                blogEntryList.DataSource = listOfBlogEntries;
                blogEntryList.DataBind();    
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

            // Subscribe to events from the blog editor control
            editorBlog.PostCancelled += new EventHandler(editorBlog_PostCancelled);
            editorBlog.PostCreated += new development.Templates.Blog.Units.EditorBlog.XFormEditorEventHandler(editorBlog_PostCreated);
            editorBlog.PostUnpublished += new development.Templates.Blog.Units.EditorBlog.XFormEditorEventHandler(editorBlog_PostUnpublished);
        }

        /// <summary>
        ///     Required method for Designer support - do not modify
        ///     the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.Load += new System.EventHandler(this.Page_Load);
            this.btnShowXForm.Click += new EventHandler(btnShowXForm_Click);
            this.blogEntryList.ItemCommand += new DataListCommandEventHandler(blogEntryList_Command);
            this.blogEntryList.ItemCreated += new DataListItemEventHandler(blogEntryList_ItemCreated);
        }
        #endregion

        private void btnShowXForm_Click(object sender, EventArgs e)
        {
            editorBlog.BlogDataId = Guid.Empty;

            pnlList.Visible = false;
            pnlXForm.Visible = true;
        }

        private void ChangePublishedStatus(string formId) 
        {
            XFormData commentData = XFormData.CreateInstance(new Guid(formId));
            if (commentData != null)
            {   
                commentData.SetValue(BlogUtil.IsUnpublishedXFormValueName, (!BlogUtil.IsStringTrue(commentData.GetValue(BlogUtil.IsUnpublishedXFormValueName))).ToString());
                commentData.Send(commentData.FormId);

                //Reload page
                Response.Redirect(BlogUtil.AppendQueryParamToUrl(new StringBuilder(CurrentPage.LinkURL), "edit=true").ToString());
            }
        }

        private void blogEntryList_ItemCreated(object sender, DataListItemEventArgs e)
        {
            // Only attach an ItemCommand handler to the various databound items, not headers, separators etc
            if (e.Item.ItemType == ListItemType.AlternatingItem || e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.SelectedItem) 
            {
                Repeater commentList = (Repeater)e.Item.FindControl("commentEntryList");
                commentList.ItemCommand += new RepeaterCommandEventHandler(commentList_ItemCommand);
            }
        }
    
        private void commentList_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            ChangePublishedStatus(e.CommandName);
        }

        private void blogEntryList_Command(object sender, DataListCommandEventArgs e)
        {
            switch (e.CommandName) 
            {
                case "btnToggleComment":
                    Repeater commentList = (Repeater)e.Item.FindControl("commentEntryList");
                    commentList.Visible = !commentList.Visible;
                    break;

                case "btnEditBlogEntry":
                    // Update the editor-blog property indicating which data to actually edit. This depends on
                    // the editor implementation waiting until prerender to actually get the form data.
                    editorBlog.BlogDataId = new Guid((string)e.CommandArgument);
                    pnlList.Visible = false;
                    pnlXForm.Visible = true;
                    break;

                case "btnChangePostPublishStatusComment":
                    ChangePublishedStatus((string)e.CommandArgument);
                    break;
            }
        }

        private void editorBlog_PostCancelled(object sender, EventArgs e)
        {
            pnlList.Visible = true;
            pnlXForm.Visible = false;
        }

        private void editorBlog_PostCreated(object sender, development.Templates.Blog.Units.EditorBlog.EditorBlogEventArguments e)
        {
            Response.Redirect(BlogUtil.AppendQueryParamToUrl(new StringBuilder(CurrentPage.LinkURL), "edit=true").ToString());
        }

        private void editorBlog_PostUnpublished(object sender, development.Templates.Blog.Units.EditorBlog.EditorBlogEventArguments e)
        {
            Response.Redirect(BlogUtil.AppendQueryParamToUrl(new StringBuilder(CurrentPage.LinkURL), "edit=true").ToString());
        }
    }
}
