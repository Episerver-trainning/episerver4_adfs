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
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using EPiServer;
using EPiServer.Core;

namespace development
{
	/// <summary>
	/// Summary description for Default.
	/// </summary>
	public class Default : TemplatePage
	{
		private readonly string _startPageImage = "images/startpage_image.jpg";
		private		PageData _eventRootPage;
		private		PageData mainNewsItem;
		protected	EPiServer.WebControls.NewsList StartPageNews;

		private void Page_Load(object sender, System.EventArgs e)
		{
			if(!IsPostBack)
				DataBind();
		}

		protected PageDataCollection MainNewsItemReference
		{
			get
			{
				PageDataCollection newsPage = new PageDataCollection();
				if(CurrentPage["MainNewsItem"] == null)
				{
					if(CurrentPage["NewsContainer"] != null)
					{
						PageReference newsContainerReference = PageReference.Parse(CurrentPage["NewsContainer"].ToString());
						PageDataCollection allNews = GetChildren(newsContainerReference);
						if(allNews.Count > 0)
							mainNewsItem = allNews[0];
					}
				}
				else
				{
					mainNewsItem = GetPage(PageReference.Parse(CurrentPage["MainNewsItem"].ToString()));
				}
				if(mainNewsItem != null)
					newsPage.Add(mainNewsItem);
				return newsPage;
			}
		}

		protected int GetNewsCount()
		{
			if (CurrentPage["NewsCount"] == null)
				return -1;
			return (int)CurrentPage["NewsCount"];
		}

		protected int GetEventsCount()
		{
			if(CurrentPage["EventsCount"] == null)
				return -1;
			return (int)CurrentPage["EventsCount"];
		}

		protected string StartPageImage
		{
			get
			{
				if(CurrentPage["MainImage"] != null)
					return (string)CurrentPage["MainImage"];
				return Global.EPConfig.RootDir + _startPageImage;
			}
		}
		protected PageData EventRootPage
		{
			get
			{
				if(_eventRootPage == null)
				{
					if(CurrentPage["EventsContainer"] == null)
						return null;
					_eventRootPage = GetPage((PageReference)CurrentPage["EventsContainer"]);
				}

				return _eventRootPage;
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
		}
		
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{    
			this.Load += new System.EventHandler(this.Page_Load);
			StartPageNews.Filter += new EPiServer.WebControls.FilterEventHandler(StartPageNews_Filter);
		}
		#endregion

		private void StartPageNews_Filter(object sender, EPiServer.Filters.FilterEventArgs e)
		{	// Filter that checks if a page from the news list is currently displayed as the "main"
			// news item, in which case it is removed from the news list
			if(mainNewsItem != null)
			{
				int indexOfMainNewsItem = e.Pages.Find(mainNewsItem.PageLink);
				if(indexOfMainNewsItem != -1)
					e.Pages.RemoveAt(indexOfMainNewsItem);
			}
		}
	}
}
