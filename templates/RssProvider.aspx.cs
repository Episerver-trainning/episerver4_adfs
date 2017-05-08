/*
Copyright © 1997-2004 ElektroPost Stockholm AB. All Rights Reserved.

This code may only be used according to the EPiServer License Agreement.
The use of this code outside the EPiServer environment, in whole or in
parts, is forbidden without prior written permission from ElektroPost
Stockholm AB.

EPiServer is a registered trademark of ElektroPost Stockholm AB. For
more information see http://www.episerver.com/license or request a
copy of the EPiServer License Agreement by sending an email to info@ep.se
*/
using EPiServer;
using EPiServer.Core;
using EPiServer.Core.Html;
using EPiServer.Personalization;
using System;
using System.Xml;
using System.Web;

namespace development.Templates
{
	/// <summary>
	/// Summary description for RssProvider.
	/// </summary>
	public class RssProvider : SimplePage
	{
		private void Page_Load(object sender, System.EventArgs e)
		{	
			Response.ContentType = "text/xml";
			Response.Clear();
			if(IsValue("ListingContainer"))
				WriteRssDocument();
			Response.End();
		}

		private void WriteRssDocument()
		{
			XmlDocument doc			= new XmlDocument();
			XmlNode outerNode		= doc.CreateElement("rss");
			XmlAttribute uriInfo	= doc.CreateAttribute("xmlns:dc");
			uriInfo.Value			= "http://purl.org/dc/elements/1.1/";
			outerNode.Attributes.Append(uriInfo);
			doc.AppendChild(outerNode);

			XmlAttribute versionInfo = doc.CreateAttribute("version");
			versionInfo.Value		= "2.0";
			outerNode.Attributes.Append(versionInfo);

			XmlNode channel			= doc.CreateElement("channel");
			outerNode.AppendChild(channel);

			XmlNode title			= doc.CreateElement("title");
			title.InnerText			= EPiServer.Global.EPConfig.SiteName;
			channel.AppendChild(title);

			XmlNode link			= doc.CreateElement("link");
			link.InnerText			= EPiServer.Global.EPConfig.HostUrl + EPiServer.Global.EPConfig.RootDir;
			channel.AppendChild(link);

			XmlNode description		= doc.CreateElement("description");
			description.InnerText	= "Some description.....";
			channel.AppendChild(description);

			XmlNode language		= doc.CreateElement("language");
			language.InnerText	= EPiServer.Core.LanguageContext.Current.CurrentUILanguageID;
			channel.AppendChild(language);

			PageReference listingContainer = (PageReference)CurrentPage["ListingContainer"];
			PageDataCollection children = GetChildren(listingContainer);

			foreach(PageData page in children)
			{
				XmlNode item				= doc.CreateNode(XmlNodeType.Element,"item", null);

				XmlNode itemTitle			= doc.CreateElement("title");
				itemTitle.InnerText			= page.PageName;
				item.AppendChild(itemTitle);

				XmlNode itemLink			= doc.CreateElement("link");
				itemLink.InnerText			= EPiServer.Global.EPConfig.HostUrl + page.LinkURL;
				item.AppendChild(itemLink);

				XmlNode itemDescription		= doc.CreateElement("description");
				itemDescription.InnerText	= CreatePreviewText(page);
				item.AppendChild(itemDescription);

				XmlNode itemCreatedBy		= doc.CreateElement("dc","creator","http://purl.org/dc/elements/1.1/");
				itemCreatedBy.InnerText		= GetCreatedInformation(page);
				item.AppendChild(itemCreatedBy);

				XmlNode itemCreated			= doc.CreateElement("dc","date","http://purl.org/dc/elements/1.1/");
				itemCreated.InnerText		= page.Changed.ToString("yyyy-MM-ddTHH:mm:sszzz");
				item.AppendChild(itemCreated);

				channel.AppendChild(item);
			}

			doc.Save(Response.OutputStream);
		}

		private string GetCreatedInformation(PageData page)
		{
			string writerName = page["WriterName"] as string;
			if (writerName != null && writerName.Length > 0)
				return writerName;

			PersonalizedData userData = PersonalizedData.Load(page.CreatedBy);
			if (userData == null || userData.LastName == null || userData.LastName.Length == 0)
				return page.CreatedBy;

			if (userData.FirstName != null && userData.FirstName.Length > 0)
				return userData.FirstName + " " + userData.LastName;

			return userData.LastName;
		}

		private string CreatePreviewText(PageData page)
		{
			string mainIntro = page["MainIntro"] as string;
			if (mainIntro != null && mainIntro.Length > 0)
				return mainIntro;
		
			string previewText = page["MainBody"] as string;
			if (previewText == null)
				return String.Empty;

			return TextIndexer.StripHtml(previewText, 400);
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
	}
}
