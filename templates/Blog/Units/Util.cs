/*
 * @(#) $Id: Util.cs,v 1.1.2.6 2006/03/20 13:47:55 per Exp $
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
using System.Text;
using System.Web;

using EPiServer.XForms;


namespace development.Templates.Blog.Units
{
    /// <summary>
    /// A collection of static utility methods, and base-classes etc. For silly build-reasons, the
    /// more appropriate name "Util" collides with EPiServer.Util namespace, so we just call it BlogUtil...
    /// </summary>
    public class BlogUtil 
    {
        /// <summary>
        /// Internal representation of a posted date, also implementing
        /// IComparable to make it sortable. Intended as base class for
        /// blog and comment entries which share this property and have
        /// the same sorting requirements.
        /// </summary>
        public class PostedEntryBase : IComparable
        {
            #region Fields
            /// <summary>
            /// The underlying XFormData instance
            /// </summary>
            private XFormData _formData;
            /// <summary>
            /// The posted text, as a HTML-encoded string
            /// </summary>
            private string _postedText;
            #endregion

            #region Properties
            /// <summary>
            /// The base XFormData that this entry is based on
            /// </summary>
            public XFormData FormData 
            {
                get 
                {
                    return _formData;
                }
                set
                {
                    _formData = value;
                }
            }
            /// <summary>
            /// Get form data value associated with a form field key
            /// </summary>
            /// <param name="key">The form field name/key</param>
            /// <returns>The value associated with the form field</returns>
            public string GetValue(string key) 
            {
                return FormData.GetValue(key);
            }

            /// <summary>
            /// Set form data value associated with a form field key
            /// </summary>
            /// <param name="key">The form field name/key</param>
            /// <param name="value">The value associated with the form field</param>
            public void SetValue(string key, string val) 
            {
                FormData.SetValue(key, val);
            }

            /// <summary>
            /// Date and time of the comment
            /// </summary>
            public DateTime PostedDate
            {
                get 
                {
                    return FormData == null ? DateTime.MinValue : FormData.DatePosted;
                }
            }
            /// <summary>
            /// The comment, as a HTML-encoded string
            /// </summary>
            public string PostedText 
            {
                get 
                {
                    return _postedText;
                }
                set 
                {
                    _postedText = value;
                }
            }
            /// <summary>
            /// The id of our form data, i.e. the actual blog entry posting
            /// </summary>
            public Guid FormDataId 
            {
                get 
                {
                    return (Guid)FormData.Id;
                }
                set 
                {
                    FormData.Id = value;
                }
            }
            /// <summary>
            /// The list of comment Id's as an array of GUIDs
            /// </summary>
            public Guid[] CommentIds 
            {
                get 
                {
                    return BlogUtil.GetCommentGuids(FormData);
                }
            }
            /// <summary>
            /// true if this entry has been actively unpublished
            /// </summary>
            public bool IsUnPublished 
            {
                get 
                {
                    return BlogUtil.IsStringTrue(FormData.GetValue(BlogUtil.IsUnpublishedXFormValueName));
                }
                set 
                {
                    FormData.SetValue(BlogUtil.IsUnpublishedXFormValueName, value.ToString());
                }
            }
            #endregion
        
            #region Methods
            public PostedEntryBase(XFormData formData)
            {
                FormData = formData;
            }

            /// <summary>
            /// Objects of type CommentEntry are ordered according to date posted,
            /// in reverse order of entry i.e. latest first.
            /// </summary>
            /// <param name="x">The CommentEntry-object to compare with</param>
            /// <returns></returns>
            int IComparable.CompareTo(object x)
            {
                PostedEntryBase peb = x as PostedEntryBase;
                if (peb == null)
                {
                    throw new ArgumentException("Object is not a PostedEntryBase");
                }
                // We want the sort to operation in reverse order...
                return -PostedDate.CompareTo(peb.PostedDate);
            }
            #endregion
        }


        /// <summary>
        /// This class should never be instantiated, so define a private constructor
        /// </summary>
        private BlogUtil() 
        {
        }

        static BlogUtil() 
        {
            foreach (EPiServer.XForms.XForm xForm in EPiServer.XForms.XFormFolder.GetForms(BlogFormsFolder))
            {
                switch (xForm.FormName) 
                {
                    case BlogPostFormName:
                        BlogPostFormId = (Guid)xForm.Id;
                        break;
                    case BlogCommentFormName:
                        BlogCommentFormId = (Guid)xForm.Id;
                        break;
                }
            }
            // Some extra insurance that we don't get very far if we haven't defined the appropriate XForms
            if (BlogPostFormId == Guid.Empty || BlogCommentFormId == Guid.Empty) 
            {
                throw new ApplicationException("The necessary XForms are not defined for the blog");
            }
        }

        /// <summary>
        /// The GUID of the BlogPostForm as found in the data layer
        /// </summary>
        public static Guid BlogPostFormId;

        /// <summary>
        /// The GUID of the BlogCommentForm as found in the data layer
        /// </summary>
        public static Guid BlogCommentFormId;

        /// <summary>
        /// The URL query parameter name used to set the start of the blog period to display
        /// </summary>
        public const string BlogDisplayBeginDateQueryParameterName = "BlogBeginDate";

        /// <summary>
        /// The XForms folder where the blog XForms reside
        /// </summary>
        private const string BlogFormsFolder = "/";

        /// <summary>
        /// The name of the EPiServer page property denoting the XForm used for entering a blog entry.
        /// Use the EPiServer admin mod to set this property to the proper XForm for the page type used for a blog list.
        /// </summary>
        public const string BlogPostFormPropertyName = "BlogPostForm";

        /// <summary>
        /// The name of the XForm used to enter a blog post. See Blog.aspx for more details.
        /// </summary>
        public const string BlogPostFormName = "BlogPostForm";

        /// <summary>
        /// The name of the EPiServer page property denoting the XForm used for commenting a blog entry. Use the EPiServer
        /// admin mode to set this property to the proper XForm for the page type used for a blog entry.
        /// </summary>
        public const string BlogCommentFormPropertyName = "BlogCommentForm";

        /// <summary>
        /// The name of the XForm used to enter a blog comment. See Blog.aspx for more details.
        /// </summary>
        public const string BlogCommentFormName = "BlogCommentForm";

        /// <summary>
        /// The name of the EPiServer Page Type used to hold one blog. EPiServer must be configured to have a page type of
        /// this name, with the appropriate content and properties.
        /// </summary>
        public const string BlogPageTypeName = "BlogPage";

        /// <summary>
        /// The XForm value name of the published/unpublished flag. The value is set to "true" or "false", appropriately.
        /// </summary>
        public const string IsUnpublishedXFormValueName = "unpublished";

        /// <summary>
        /// The XForm value name of a list of comment id guids, separated by ";"
        /// </summary>
        public const string CommentIdsXFormValueName = "commentIds";
        
        /// <summary>
        /// The XForm field-name containing the blog title
        /// </summary>
        public const string BlogPostTitleFormFieldName = "BTitle";

        /// <summary>
        /// The XForm field-name containg the blog text
        /// </summary>
        public const string BlogPostTextFormFieldName = "BText";

        /// <summary>
        /// Our standard format for presenting the time and date of a post: General (short date and short time).
        /// </summary>
        public const string DatePostedFormatString = "g";

        /// <summary>
        /// The name of the property where we store the blog listing layout
        /// </summary>
        public const string BlogListLayoutPropertyName = "BlogListLayout";

        /// <summary>
        /// This is the default blog content, which is used if there is no default value set in the property
        /// using EPiServer. It's also a way to set a value that is longer than what the EPiServer user interface
        /// allows, currently 100 characters.
        /// </summary>
        public const string BlogListLayout = "<h2>{BTitle} ({DatePosted})</h2>{BText}";

        /// <summary>
        /// Replace {key} style occurrences in a template string using XFormData as the source. The form value
        /// collection is iterated over, and replacements are made.
        /// </summary>
        /// <param name="xformData">The source of the data</param>
        /// <param name="template">A string where field-codes will be substituted</param>
        /// <returns>A substitued result</returns>
        static public System.Text.StringBuilder FieldCodeReplace(XFormData xformData, string template) 
        {
            // Use a StringBuilder for multiple replaces since it's so much more efficient
            StringBuilder result = new StringBuilder(template);

            // Get the names and values of each data field in the XForm, so we can substitute in these at the
            // placeholder locations in the template provided
            NameValueCollection nvc = xformData.GetValues();
            foreach (string key in nvc.AllKeys)
            {
                result.Replace(new StringBuilder("{").Append(key).Append("}").ToString(), nvc[key]);
            }

            // Substitute the date posted into the posting also, this must unfortunately be special-cased.
            result.Replace("{DatePosted}", xformData.DatePosted.ToString(DatePostedFormatString));
            
            return result;
        }

        /// <summary>
        /// Extract the list of comments from a blog entry xform data instance
        /// </summary>
        /// <param name="xFormData">The XFormdata for the selected blog entry</param>
        /// <returns>An array of GUID's representing the XForm Data Id's for the comments</returns>
        static public Guid[] GetCommentGuids(XFormData xFormData) 
        {
            Guid[] commentGuids = new Guid[0];

            if (xFormData != null)
            {
                // Get the string representation of comments associated with a blog entry,
                // in the form of guid;guid;...;guid
                string commentIdsString = xFormData.GetValue(CommentIdsXFormValueName);
                if (commentIdsString != string.Empty)
                {
                    string[] ids = commentIdsString.Split(';'); 
                    commentGuids = new Guid[ids.Length];
                    for (int i = 0; i < ids.Length; i++)
                    {
                        commentGuids[i] = new Guid(ids[i]);
                    }
                }
            }
            return commentGuids;
        }

        /// <summary>
        /// A bool-parser that handles empty strings as well
        /// </summary>
        /// <param name="s">Something parseable as a bool, or null or empty (both are considered "false")</param>
        /// <returns>true if bool.Parse says so</returns>
        static public bool IsStringTrue(string s) 
        {
            return s != null && s != "" && bool.Parse(s);
        }

        /// <summary>
        /// Append either '?' or '&' depending on if there already is a '?' there or not
        /// </summary>
        /// <param name="url">An URL to start with</param>
        /// <param name="param">A parameter like key=value</param>
        /// <returns>The concatenated URL</returns>
        static public StringBuilder AppendQueryParamToUrl(StringBuilder url, string param) 
        {
            // Append either '?' or '&' depending on if there already is a '?' there or not
            url.Append(url.ToString().IndexOf('?') > 0 ? '&' : '?');
            url.Append(param);
            return url;
        }

        /// <summary>
        /// The HTML representation of a new-line that we use in Text2Html
        /// </summary>
        private const string newLineAsHtml = "<br />";

        /// <summary>
        /// Filter text to HTML, catching common constructs such as "&", "<", ">" and new line.
        /// </summary>
        /// <param name="nonHtml">The text to be converted</param>
        /// <returns>A converted string</returns>
        public static string Text2Html(string text)
        {
			System.Text.StringBuilder sb = new System.Text.StringBuilder(HttpUtility.HtmlEncode(text));
			sb.Replace("\r\n", newLineAsHtml);
			sb.Replace("\n\r", newLineAsHtml);
			sb.Replace("\r", newLineAsHtml);
			sb.Replace("\n", newLineAsHtml);
			return sb.ToString();
       }
    }
}
