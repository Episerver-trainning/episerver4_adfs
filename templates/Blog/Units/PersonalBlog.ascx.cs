/*
 * @(#) $Id: PersonalBlog.ascx.cs,v 1.1.2.3 2006/03/13 09:49:05 svante Exp $
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
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using EPiServer;
using EPiServer.BaseLibrary;
using EPiServer.Core;
using System.Collections;
using EPiServer.BaseLibrary.Search;
using EPiServer.XForms;


namespace development.Templates.Blog.Units
{
    /// <summary>
    /// Display view and edit modes, and handle switching between them
    /// </summary>
    public class PersonalBlog : EPiServer.UserControlBase
    {
        protected Panel pnlView;
		public Panel pnlEdit;
        protected EditList editList;

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
        ///     Required method for Designer support - do not modify
        ///     the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.Load += new System.EventHandler(this.Page_Load);
        }
        #endregion

        public bool HasEditAccess
        {
            get
            {
                return CurrentPage.ACL.Creator == EPiServer.Security.UnifiedPrincipal.CurrentSid;
            }
        }

		public void OnSetViewMode(object sender, BlogSetViewEventArguments		 e)
        {
			SetEditOrViewMode(e.EditMode);
        }

		private void SetEditOrViewMode(bool setToEditMode)
		{
			if (setToEditMode && !HasEditAccess) 
				return;

			pnlEdit.Visible = setToEditMode;
            pnlView.Visible = !setToEditMode;			

			editList.ShowBlogList = setToEditMode;
		}

    }
}
