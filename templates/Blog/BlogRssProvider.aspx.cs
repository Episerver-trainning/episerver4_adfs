/*
 * @(#) $Id: BlogRssProvider.aspx.cs,v 1.1.2.3 2006/02/09 16:20:53 svante Exp $
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
using System.Collections.Specialized;
using System.ComponentModel;
using System.Data;
using System.Text;
using System.Xml;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

using EPiServer.BaseLibrary;
using EPiServer.BaseLibrary.Search;
using EPiServer.XForms;

using development.Templates.Blog.Units;


namespace development.Templates.Blog
{
    /// <summary>
    /// Generate a complete listing of all published blog entries for a given blog
    /// </summary>
    public class BlogRssProvider : EPiServer.TemplatePage
    {
        /// <summary>
        /// The in-memory representation of a blog-entry
        /// </summary>
        private class RSSBlogEntry : BlogUtil.PostedEntryBase
        {
            private string _link;
        
            public RSSBlogEntry(XFormData formData, string description, string link) : base(formData)
            {
                PostedText = description;
                Link = link;
            }

            /// <summary>
            /// The absolute link to the period containing this entry
            /// </summary>
            public string Link
            {
                get 
                {
                    return _link;
                }
                set 
                {
                    _link = value;
                }
            }
        }
 

        #region Overrides
        /// <summary>
        /// Since we use this page, but with the EPiServer pageid as the parameter, EPiServer will complain about
        /// the page type being wrong unless we override this method, and do our own validation here.
        /// </summary>
        public override void ValidatePageTemplate()
        {
            if (CurrentPage.PageTypeName != BlogUtil.BlogPageTypeName) 
            {
                throw new EPiServer.Core.EPiServerException("The BlogRssProvider can only handle pages of the correct type");
            }
        }
        #endregion

        private void Page_Load(object sender, System.EventArgs e)
        {
            Response.ContentType = "text/xml";
            Response.Clear();
            BuildRssDocument().Save(Response.OutputStream);
            Response.End();
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

        #region Methods
        /// <summary>
        /// Build an XML document representing the rss feed according to the appropriate standard.
        /// </summary>
        /// <returns>A reference to the built XML document</returns>
        private XmlDocument BuildRssDocument()
        {
            XmlDocument doc = new XmlDocument();
            XmlNode outerNode = doc.CreateElement("rss");
            XmlAttribute uriInfo = doc.CreateAttribute("xmlns:dc");
            uriInfo.Value = "http://purl.org/dc/elements/1.1/";
            outerNode.Attributes.Append(uriInfo);
            doc.AppendChild(outerNode);

            XmlAttribute versionInfo = doc.CreateAttribute("version");
            versionInfo.Value = "2.0";
            outerNode.Attributes.Append(versionInfo);

            XmlNode channel = doc.CreateElement("channel");
            outerNode.AppendChild(channel);

            XmlNode title = doc.CreateElement("title");
            title.InnerText = CurrentPage.PageName;
            channel.AppendChild(title);

            XmlNode link = doc.CreateElement("link");
            link.InnerText = EPiServer.Global.EPConfig.HostUrl + CurrentPage.LinkURL;
            channel.AppendChild(link);

            XmlNode description = doc.CreateElement("description");
            description.InnerText = CurrentPage["BlogRSSDescription"] != null ? (string)CurrentPage["BlogRSSDescription"] : string.Empty;
            channel.AppendChild(description);

            XmlNode language = doc.CreateElement("language");
            language.InnerText = "";
            channel.AppendChild(language);

            // Generate an entry for each published blog post. (Yes, it's quite ok to have the implicit cast from
            // the objects in the ArrayList like this, and it's also quite ok to use the reference returned from the
            // function as the collection to base the iteration on).
            foreach (RSSBlogEntry post in GetBlogPosts())
            {
                XmlNode item = doc.CreateNode(XmlNodeType.Element, "item", null);

                XmlNode itemTitle = doc.CreateElement("title");
                itemTitle.InnerText = post.GetValue(BlogUtil.BlogPostTitleFormFieldName);
                item.AppendChild(itemTitle);

                XmlNode itemLink = doc.CreateElement("link");
                itemLink.InnerText = post.Link;
                item.AppendChild(itemLink);

                XmlNode itemDescription = doc.CreateElement("description");
                itemDescription.InnerText = post.PostedText;
                item.AppendChild(itemDescription);

                XmlNode itemCreatedBy = doc.CreateElement("dc", "creator", "http://purl.org/dc/elements/1.1/");
                itemCreatedBy.InnerText = CurrentPage.CreatedBy;
                item.AppendChild(itemCreatedBy);

                XmlNode itemCreated = doc.CreateElement("dc", "date", "http://purl.org/dc/elements/1.1/");
                itemCreated.InnerText = post.PostedDate.ToString();
                item.AppendChild(itemCreated);

                channel.AppendChild(item);
            }

            return doc;
        }

        /// <summary>
        /// Get a list of published posts
        /// </summary>
        /// <returns>A list of RSSBlogEntry objects</returns>
        private ArrayList GetBlogPosts()
        {
            // Get the xform associated with the page property defined to contain the XForm for blog posting
            EPiServer.Core.PropertyXForm xFormPageProperty = (EPiServer.Core.PropertyXForm)CurrentPage.Property[BlogUtil.BlogPostFormPropertyName];
            
            // Get a list of posted data, i.e. the blog entries, for the given range
            IList listOfPostedData = xFormPageProperty.Form.GetPostedData(CurrentPage.PageLink.ID, DateTime.MinValue, DateTime.MaxValue);
                
            // Build filtered and formatted ArrayList of blogs to sort and subsequently use as DataSource for the DataList control
            ArrayList listOfRSSBlogs = new ArrayList();

            // This gets to be re-used, so we cache it in a string
            string contentTemplate = "<![CDATA[{BText}]]>";

            foreach (XFormData xformData in listOfPostedData)
            {
                if (BlogUtil.IsStringTrue(xformData.GetValue(BlogUtil.IsUnpublishedXFormValueName))) 
                {
                    // Don't add unpublished blogs to the list
                    continue;
                }

                listOfRSSBlogs.Add(new RSSBlogEntry(xformData, BlogUtil.FieldCodeReplace(xformData, contentTemplate).ToString(), GetLink(xformData.DatePosted)));
            }
            listOfRSSBlogs.Sort(); 

            return listOfRSSBlogs;
        }

        /// <summary>
        /// Get an absolute URL to a month-collection of postings
        /// </summary>
        /// <param name="datePosted">The time of post for a particular post</param>
        /// <returns>A link to the blog period this post is in</returns>
        private string GetLink(DateTime datePosted)
        {
            StringBuilder url = new StringBuilder(EPiServer.Global.EPConfig.HostUrl);

            // get the root-relative url
            url.Append(ResolveUrl("~/templates/Blog/Blog.aspx"));

            // Add the page-id parameter.
            BlogUtil.AppendQueryParamToUrl(url, string.Format("id={0}", CurrentPage.PageLink.ID));

            // Add the  current period-parameter
            BlogUtil.AppendQueryParamToUrl(url, string.Format("{0}={1:yyyy-MM-01}", BlogUtil.BlogDisplayBeginDateQueryParameterName, datePosted));

            return url.ToString();
        }
        #endregion

    }
}
