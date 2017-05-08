/*
 * @(#) $Id: BlogArchive.ascx.cs,v 1.1.2.5 2006/03/13 09:49:02 svante Exp $
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
using EPiServer;
using EPiServer.BaseLibrary;
using EPiServer.Core;
using System.Collections;
using System.Collections.Specialized;
using EPiServer.BaseLibrary.Search;
using development.Templates.Blog;
using EPiServer.XForms;


namespace development.Templates.Blog.Units
{
    /// <summary>
    /// User control to display a list of links to sections of a Blog, for example a link per month.
    /// </summary>
    public class BlogArchive : EPiServer.UserControlBase
    {
        /// <summary>
        /// The archive is divided into periods, typically one month. Each instance of this
        /// object represents one such period, and is used to count the number of entries for
        /// display and also to generate the appropriate links.
        /// </summary>
        protected class BlogArchiveSummary
        {
            /// <summary>
            /// The link to the current page, used to build self-referntial links with a parameter set
            /// to indicate which period to display.
            /// </summary>
            private static string _linkUrl;
            /// <summary>
            /// Make the edit mode accessible from inside this class
            /// </summary>
            private static bool _editMode;
            /// <summary>
            /// The period that this archive represents.
            /// </summary>
            private DateTime _thisPeriod = DateTime.Now;
            /// <summary>
            /// The number of entries for this period.
            /// </summary>
            private int _count = 0;

            /// <summary>
            /// Construct an archive-link object for a period. Currently this is always
            /// exactly one month.
            /// </summary>
            /// <param name="thisPeriod">A date in the month that represents this period</param>
            public BlogArchiveSummary(DateTime thisPeriod)
            {
                ThisPeriod = thisPeriod;
            }
            
            /// <summary>
            /// The link to the current page, used to build self-referntial links with a parameter set
            /// to indicate which period to display.
            /// </summary>
            public static string LinkUrl
            {
                get 
                {
                    return _linkUrl;
                }
                set 
                {
                    _linkUrl = value;
                }
            }

            /// <summary>
            /// The current state of the edit mode - view or edit
            /// </summary>
            public static bool EditMode
            {
                get 
                {
                    return _editMode;
                }
                set 
                {
                    _editMode = value;
                }
            }

            /// <summary>
            /// Create an object representing a period from a DateTime. The requirement is that the object.Equals
            /// method will compare to true with two period objects representing the same period.
            /// </summary>
            /// <param name="dt">A DateTime in the period</param>
            /// <returns>An object representing a period</returns>
            public static object PeriodKey(DateTime dt)
            {
                return new DateTime(dt.Year, dt.Month, 1);
            }

            /// <summary>
            /// The period that this archive represents.
            /// </summary>
            public DateTime ThisPeriod 
            {
                get 
                {
                    return _thisPeriod;
                }
                set 
                {
                    _thisPeriod = value;
                }
            }

            /// <summary>
            /// The number of entries for this period.
            /// </summary>
            public int Count 
            {
                get 
                {
                    return _count;
                }
                set 
                {
                    _count = value;
                }
            }

            /// <summary>
            /// Generate a full URL for this period.
            /// </summary>
            public string UrlToThisPeriod 
            {
                get 
                {
                    // Add the  current period-parameter
                    StringBuilder url = BlogUtil.AppendQueryParamToUrl(new StringBuilder(LinkUrl), string.Format("{0}={1:yyyy-MM-01}", BlogUtil.BlogDisplayBeginDateQueryParameterName, ThisPeriod));

                    // Maintain the state of EditMode
                    if (EditMode)
                    {
                        BlogUtil.AppendQueryParamToUrl(url, "edit=true");
                    }
                    return url.ToString();
                }
            }
        }


        #region Fields
        /// <summary>
        /// A list of periods with blog entries, typically one entry per month
        /// </summary>
        protected Repeater archivePeriodList;
        /// <summary>
        /// A message section to display if there are no periods with blog entries
        /// </summary>
        protected PlaceHolder noArchiveEntriesMessage;
        #endregion

        private void Page_Load(object sender, System.EventArgs e)
        {
            // This must be done both for first load and for postback, since the form of the link may change as a result of a postback event

            // Get the xform associated with the page property defined to contain the XForm for blog posting
            EPiServer.Core.PropertyXForm xFormPageProperty = (EPiServer.Core.PropertyXForm)CurrentPage.Property[BlogUtil.BlogPostFormPropertyName];
            
            // Get a list of all posted data, i.e. the blog entries, for this page.
            IList listOfPostedData = xFormPageProperty.Form.GetPostedData(CurrentPage.PageLink.ID, DateTime.MinValue, DateTime.MaxValue);
            
            // Set static properties for the blog archive objects
            BlogArchiveSummary.LinkUrl = CurrentPage.LinkURL;
            BlogArchiveSummary.EditMode = EditMode;

            // Build a hashtable used as the DataSource for the repeater that displays the archive link list.
            // A hashtable is used, since we want to aggregate all entries into groups, and "Contains" is an efficient
            // operation with hashtables - almost constant time.
            Hashtable listOfArchiveSummaries = new Hashtable();
            foreach (XFormData postedXFormData in listOfPostedData)
            {
                if (BlogUtil.IsStringTrue((postedXFormData.GetValue(BlogUtil.IsUnpublishedXFormValueName)))) 
                {
                    // Don't include "unpublished" entries
                    continue;
                }

                // Create an anonymous key with the help of the summary object, so it can
                // decide what is a period.
                object key = BlogArchiveSummary.PeriodKey(postedXFormData.DatePosted);
                // Increment the entry count, or create a new period.
                if (listOfArchiveSummaries.ContainsKey(key))
                {
                    ((BlogArchiveSummary)listOfArchiveSummaries[key]).Count++;
                } 
                else 
                {
                    listOfArchiveSummaries.Add(key, new BlogArchiveSummary(postedXFormData.DatePosted));
                }               
            }
            archivePeriodList.DataSource = listOfArchiveSummaries;
            archivePeriodList.DataBind();

            noArchiveEntriesMessage.Visible = archivePeriodList.Items.Count == 0;
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
        /// The state of the edit flag, used to generate proper links so we stay in edit mode - or not.
        /// </summary>
        public bool EditMode
        {
            set
            {
                ViewState["EditMode"] = value;
            }
            get 
            {
                return ViewState["EditMode"] == null ? false : (bool)ViewState["EditMode"];
            }
        }
        #endregion

        public void OnSetViewMode(object sender, BlogSetViewEventArguments e)
        {
            // Must re-bind, if we have changed the edit mode to view mode
            if (e.EditMode != BlogArchiveSummary.EditMode && !e.EditMode) 
            {
                archivePeriodList.DataBind();
            }
            BlogArchiveSummary.EditMode = EditMode = e.EditMode;
        }
    }
}
