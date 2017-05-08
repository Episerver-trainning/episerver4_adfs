/*
 * @(#) $Id: EditorBlog.ascx.cs,v 1.1.2.4 2006/03/24 15:17:00 ft Exp $
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

using EPiServer;
using EPiServer.Core;
using EPiServer.XForms;


namespace development.Templates.Blog.Units
{
    /// <summary>
    /// Edit an blog entry, a thin wrapper around an EPiServer property to edit and a title
    /// in a text-box, persisted as XForm data.
    /// </summary>
    public class EditorBlog : EPiServer.UserControlBase
    {
        /// <summary>
        /// Helper class to keep the in-memory representation of the current blog data being edited/created
        /// </summary>
        private class PostedEntry : BlogUtil.PostedEntryBase 
        {
            public PostedEntry(XFormData formData) : base(formData)
            {
            }

            /// <summary>
            /// Actually send the form data to the database
            /// </summary>
            public void Send() 
            {
                FormData.Send(FormData.FormId);
            }
        }


        /// <summary>
        /// The EPiServer control used to edit the actual blog posting, persisted in the XForm data
        /// </summary>
        protected EPiServer.WebControls.Property BlogPost;
        /// <summary>
        /// The title of the post, persisted in the XForm data
        /// </summary>
        protected TextBox txtTitle;
        /// <summary>
        /// Cancel the current edit, throwing away changes
        /// </summary>
        protected Button btnCancel;
        /// <summary>
        /// Persist new or changed to XForm data and publish
        /// </summary>
        protected Button btnPublish;
        /// <summary>
        /// Discard edit changes, but set as unpublished
        /// </summary>
        protected Button btnUnpublish;
        /// <summary>
        /// Persist new or changed, but do not modify published status
        /// </summary>
        protected Button btnSave;
        /// <summary>
        /// The in-memory representation of the current blog entry being edited
        /// </summary>
        private PostedEntry _blogPostEntry;

        public class EditorBlogEventArguments : EventArgs
        {
            private Guid _xFormDataID;

            public EditorBlogEventArguments(Guid id)
            {
                _xFormDataID = id;
            }  

            public Guid XFormDataId
            {
                get
                {
                    return _xFormDataID;
                }
            }
        }

        /// <summary>
        /// A delegate for blog events that require data to be sent to the subscribers
        /// </summary>
        public delegate void XFormEditorEventHandler(object sender, EditorBlogEventArguments e);
        /// <summary>
        /// Signal that a new blog post has been created. Subscribed to by the EditListing control.
        /// </summary>
        public event XFormEditorEventHandler PostCreated;
        /// <summary>
        /// Signal that a blog posting has been unpublished. Subscribed to by the EditListing control.
        /// </summary>
        public event XFormEditorEventHandler PostUnpublished;
        /// <summary>
        /// Signal that editing a blog posting was cancelled. Subscribed to by the EditListing control.
        /// </summary>
        public event EventHandler PostCancelled;

        #region Properties
        /// <summary>
        /// The in-memory representation of the current blog entry, lazy get from database when required.
        /// This is always kept in sync with BlogDataId, and depends on it.
        /// </summary>
        private PostedEntry BlogPostEntry 
        {
            get
            {
                // We actually do a lazy evaluation of the _blogPostEntry, so we only create the
                // instance when we actually need it. This is pretty ok semantically, since it's quite ok
                // to get it any number times with the same result. get methods should not have side effects,
                // but in this case it's motivated.
                if (BlogDataId != Guid.Empty && _blogPostEntry == null) 
                {
                    _blogPostEntry = new PostedEntry(XFormData.CreateInstance(BlogDataId));
                }
                return _blogPostEntry;
            }
            set
            {
                if (value != null) 
                {
                    BlogDataId = value.FormDataId;
                }
                _blogPostEntry = value;
            }
        }

        /// <summary>
        /// The GUID of the current blog entry data, backed by ViewState and keeps BlogPostEntry in sync.
        /// </summary>
        public Guid BlogDataId
        {
            get
            {
                // It's ok to be null here.
                object guid = ViewState["BlogDataId"];
                return guid == null ? Guid.Empty : (Guid)guid;
            }
            set
            {
                ViewState["BlogDataId"] = value;
                // BlogPostEntry is evaluted lazy, so here we just reset it to null to ensure that it's in sync
                BlogPostEntry = null;
            }
        }

        /// <summary>
        /// true if the current blog entyr is a new one, not yet saved/published
        /// </summary>
        protected bool IsNewBlog
        {
            get
            {
                return BlogPostEntry == null;
            }
        }
        #endregion

        /// <summary>
        /// EditorBlog is a very thin wrapper around an XForm control with a few buttons attached, so
        /// there's not really anything to do here. All work is done via events and in OnPreRender
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
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

            PropertyLongString editor = new PropertyLongString();
            editor.Name = "_Content";
            editor.EditorSettings = Configuration.HasEditAccess ? EPiServer.SystemControls.EditorOption.All ^ EPiServer.SystemControls.EditorOption.ToggleHtml : (EPiServer.SystemControls.EditorOption)0;
            this.CurrentPage.Property.Add(editor);
        }
        
        /// <summary>
        ///     Required method for Designer support - do not modify
        ///     the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.Load += new System.EventHandler(this.Page_Load);
            this.btnCancel.Click += new EventHandler(btnCancel_Click);
            this.btnPublish.Click += new EventHandler(btnPublish_Click);
            this.btnUnpublish.Click += new EventHandler(btnUnpublish_Click);
            //this.btnSave.Click += new EventHandler(btnSave_Click); 
        }
        #endregion

        #region Overrides
        /// <summary>
        /// Since this control is dependent on the value of the BlogDataId property, which is set
        /// by events in other controls on the page, we need to wait until here to actually load the
        /// data, and set the state of buttons etc. The only thing that should be done here in PreRender
        /// is just that - things that control the actual rendering. The code executed in Page_Load and
        /// in events cannot depend on what happens here - since it has not happened yet!
        /// </summary>
        /// <param name="e"></param>
        protected override void OnPreRender(EventArgs e)
        {
            // There's no need to do anything here if we're not visible anyway
            if (Visible) 
            {
                // If it's not a new blog, set the title and contents fields on the form to the proper values
                // so the user can see and edit the existing data.
                if (IsNewBlog) 
                {
                    txtTitle.Text = "";
                    BlogPost.InnerProperty.ParseToSelf("");

                    btnUnpublish.Enabled = false;
                }
                else
                {
                    txtTitle.Text = BlogPostEntry.GetValue(BlogUtil.BlogPostTitleFormFieldName);
                    BlogPost.InnerProperty.ParseToSelf(BlogPostEntry.GetValue(BlogUtil.BlogPostTextFormFieldName));

                    btnUnpublish.Enabled = !BlogPostEntry.IsUnPublished;
                }
            }

            base.OnPreRender(e);
        }
        #endregion

        #region Methods
        private void SaveAndSendPost(bool isUnPublished)
        {
            if (IsNewBlog) 
            {
                EPiServer.Core.PropertyXForm xf = (EPiServer.Core.PropertyXForm)CurrentPage.Property[BlogUtil.BlogPostFormPropertyName];

                if (xf == null)
                {
                    throw new ApplicationException(string.Format("Could not get the XForm property ({0})", BlogUtil.BlogPostFormPropertyName));
                }

                // Create an instance of form data, and initialize to teh current values from the form
                BlogPostEntry = new PostedEntry(xf.Form.CreateFormData());

                // For some reason, the channel options needs to be manuall set
                BlogPostEntry.FormData.ChannelOptions = ChannelOptions.Database;
            }

            // Now add the actual data
            BlogPostEntry.SetValue(BlogUtil.BlogPostTitleFormFieldName, Server.HtmlEncode(txtTitle.Text));
			// Replace various possible combinations representing new line as HTML <br/> or equivalent.
			string postedText = BlogPost.PropertyValue as String;
			if( !EPiServer.Util.EditorUtility.IsUplevel || !Global.EPConfig.HasEditAccess ) 
				postedText = BlogUtil.Text2Html(postedText);

            BlogPostEntry.SetValue(BlogUtil.BlogPostTextFormFieldName,postedText);
            BlogPostEntry.IsUnPublished = isUnPublished;

            BlogPostEntry.Send();
        }
        #endregion

        #region Events
        private void btnCancel_Click(object sender, EventArgs e)
        {
            if (PostCancelled != null) 
            {
                PostCancelled(this, new EventArgs()); 
            }
        }

        private void btnPublish_Click(object sender, EventArgs e)
        {
            // Save with IsUnPublished == false, i.e. published. Makes sense since this is the "Publish" event-handler
            SaveAndSendPost(false);

            if (PostCreated != null) 
            {
                PostCreated(this, new EditorBlogEventArguments(BlogDataId));    
            }
        }

        private void btnUnpublish_Click(object sender, EventArgs e)
        {
            if (IsNewBlog) 
            {
                throw new ApplicationException("Internal error, Unpublish button should not be active for a new post");
            }

            BlogPostEntry.IsUnPublished = true;
            BlogPostEntry.Send();

            if (PostUnpublished != null) 
            {
                PostUnpublished(this, new EditorBlogEventArguments(BlogDataId));  
            }
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            SaveAndSendPost(BlogPostEntry.IsUnPublished);

            if (PostUnpublished != null) 
            {
                PostUnpublished(this, new EditorBlogEventArguments(BlogDataId)); 
            }
        }
        #endregion
    }
}
