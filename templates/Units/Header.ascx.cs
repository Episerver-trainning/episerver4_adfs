/*
Copyright © 1997-2004 ElektroPost Stockholm AB. All Rights Reserved.

This code may only be used according to the EPiServer License Agreement.
The use of this code outside the EPiServer environment, in whole or in
parts, is forbidded without prior written permission from ElektroPost
Stockholm AB.

EPiServer is a registered trademark of ElektroPost Stockholm AB. For
more information see http://www.episerver.com/license or request a
copy of the EPiServer License Agreement by sending an email to info@ep.se
*/
using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.ComponentModel;
using System.Text;
using System.Text.RegularExpressions;
using EPiServer;
using EPiServer.Core;

namespace development.Templates.Units
{	
	/// <summary>
	///		Summary description for Header.
	/// </summary>
	public abstract class Header : UserControlBase
	{
		public string Title = String.Empty;
		public string TitleSeparator = " - ";
		public string CategoryPropertyName = "SearchCategory";
		protected Literal MetaTagGenerator;

		private void Page_Load(object sender, System.EventArgs e)
		{
			StringBuilder sb = new StringBuilder();
            
			// Title
			sb.Append(GetMetaTag("TITLE", GetTitleString() ));
            
			// Description - use MetaDescription property if it exists, otherwise use contents from MainIntro property.
			// Do not display the meta tag if none of these options return values.
			string metaDescription = GetPropertyString("MetaDescription", CurrentPage);
			if (metaDescription.Length == 0)
			{
				metaDescription = GetPropertyString("MainIntro", CurrentPage);
				if (metaDescription.Length > 0)
				{
					// Remove any tags, and make sure it is encoded correctly
					metaDescription = RemoveHTMLTags(metaDescription);
					metaDescription = HttpContext.Current.Server.HtmlEncode(metaDescription);
					// We need to make sure it is not longer than allowed. Typically
					// these texts in EPiServer are limited to 255 chars by default,
					// but a developer could have changed this to a Long String
					if (metaDescription.Length > 255)
						metaDescription = metaDescription.Substring(0, 252) + "...";
				}
			}
			if (metaDescription.Length > 0)
				sb.Append(GetMetaTag("DESCRIPTION", metaDescription));
            
			// Keywords
			sb.Append(GetMetaTag("KEYWORDS", "MetaKeywords", CurrentPage));

			// Author
			sb.Append(GetMetaTag("AUTHOR", GetPropertyString("WriterName", CurrentPage)));
            
			// Rating
			sb.Append(GetMetaTag("RATING", "General"));

			// Revisit each month
			//sb.Append(GetMetaTag("REVISIT-AFTER", "4 weeks"));

			// Generator
			sb.Append(GetMetaTag("GENERATOR", "EPiServer"));

			/// Category
			/// Some search engines uses categories to group results. To use this
			/// create a property (dynamic) of type string (255) and assign different
			/// categories to different parts of the site.
			sb.Append(GetMetaTag("CATEGORY", CategoryPropertyName, CurrentPage));

			/* Different crawlers handle created and modified dates in different ways, 
			 * and recognises different meta tag names. We try to accomdate by using
			 * some of the more general ones */
			
			// Created - GMT format
			if (CurrentPage.Created != DateTime.MinValue)
				sb.Append(GetMetaTag("creation_date", CurrentPage.Created.ToString("R"), false));
			
			// Last modified data, in GMT format - Note, same as revised
			if (CurrentPage.Changed != DateTime.MinValue)
				sb.Append(GetMetaTag("LAST-MODIFIED", CurrentPage.Changed.ToString("R"), false));

			// Revised - GMT format
			if (CurrentPage.Changed != DateTime.MinValue)
				sb.Append(GetMetaTag("REVISED", CurrentPage.Changed.ToString("R"), false));

			// The charset is important for search engines
			sb.Append(GetHttpEquivTag("Content-Type", string.Format("text/html; charset={0}", HttpContext.Current.Response.Charset)));

			MetaTagGenerator.Text = sb.ToString();
		}

		protected string GetTitleString()
		{	// This method decides the appearance of the title tag (as well as the TITLE meta tag).
			// It allows the caller to the control to pass in a specified Title and/or Separator, 
			// otherwise it uses the defaults and the page name.
			try
			{
				if (this.Title.Length > 0)
					return this.Title + this.TitleSeparator + Configuration.SiteName;
				else
					return Server.HtmlEncode(CurrentPage.PageName) + this.TitleSeparator + Configuration.SiteName;
			}
			catch
			{
				return String.Empty;
			}
		}
		
		private string RemoveHTMLTags(string sHtml)
		{
			const string REGEX_REMOVE_TAGS = @"(<[a-z]+[^>]*>)|(</[a-z\d]+>)";
			return Regex.Replace(sHtml, REGEX_REMOVE_TAGS, "", RegexOptions.IgnoreCase | RegexOptions.ExplicitCapture);
		}

		private string GetPropertyString(string PropertyName, PageData pageData)
		{
			return (pageData.Property.Exists(PropertyName)) 
				? pageData.Property[PropertyName].ToString()
				: String.Empty;
		}
        
		// All GetMetaTag(...) versions return empty strings if the corresponding values are null or empty
		private string GetMetaTag(string MetaName, string PropertyName, PageData pageData)
		{
			return (pageData.Property.Exists(PropertyName)) 
				? GetMetaTag(MetaName, pageData.Property[PropertyName].ToString())
				: String.Empty;
		}

		private string GetMetaTag(string Name, string Value)
		{
			return (Value == null || Value.Length == 0) 
				? String.Empty 
				: GetMetaTag(Name, Value, true);
		}

		private string GetMetaTag(string Name, string Value, bool HtmlEncode)
		{
			return (Value == null || Value.Length == 0) 
				? String.Empty
				: String.Format("<meta name=\"{0}\" content=\"{1}\" />\r\n", Name, HttpContext.Current.Server.HtmlEncode(Value));
		}

		private string GetHttpEquivTag(string Name, string Value)
		{
			return (Value == null || Value.Length == 0)
				? String.Empty
				: String.Format("<meta http-equiv=\"{0}\" content=\"{1}\" />\r\n", Name, HttpContext.Current.Server.HtmlEncode(Value));
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
		///	Required method for Designer support - do not modify
		///	the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
			this.Load += new System.EventHandler(this.Page_Load);
		}
		#endregion
	}
}
