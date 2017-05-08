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
using System.Data;
using System.Web;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Xml;
using EPiServer;

namespace development.Templates.Units
{
	/// <summary>
	///		Summary description for RssListing.
	/// </summary>
	public abstract class RssListing : UserControlBase
	{
		protected DataGrid	RssNewsGrid;
		protected Label		ErrorMessage;

		public String RssHeading
		{
			get 
			{
				return IsValue("RssHeading") ? CurrentPage["RssHeading"].ToString() : "EPiServer Rss Reader";
			}
		}

		private void Page_Load(object sender, System.EventArgs e)
		{
			if(!IsPostBack)
			{
				SetupDataGrid();
			}
		}
		private void SetupDataGrid()
		{
			if(!IsValue("RssUrl"))
				return;

			string url = (string)CurrentPage["RssUrl"];
			if(url.ToLower() == "http://")
				return;
			string cacheName = "RssFeed-" + url;

			int cacheTime = 60;
			if(IsValue("CacheTime"))
				cacheTime = (int)CurrentPage["CacheTime"];
					
			if(Cache[cacheName]==null)
			{
				DataTable feed;
				try
				{	
					feed = LoadFeed(url);
				}
				catch(Exception)
				{
					ErrorMessage.Visible = true;
					ErrorMessage.Text = Translate("/templates/news/errorbindingrsssource");
					return;
				}
				Cache.Insert(cacheName, feed,null,DateTime.Now.AddMinutes(cacheTime),TimeSpan.Zero);
			}
	    
			RssNewsGrid.DataSource = Cache[cacheName];			
			RssNewsGrid.DataBind();			
		}

		private DataTable LoadFeed(string url)
		{
			XmlTextReader reader = new XmlTextReader(url);
			DataSet ds = new DataSet();
			ds.ReadXml(reader);			

			foreach(DataTable table in ds.Tables)
			{
				if(table.TableName == "item")
					return table;
			}

			return null;
		}

		protected void ChangePaging(object sender, DataGridPageChangedEventArgs e)
		{
			RssNewsGrid.CurrentPageIndex = e.NewPageIndex;
			SetupDataGrid();
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
		
		///		Required method for Designer support - do not modify
		///		the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
			this.Load += new System.EventHandler(this.Page_Load);
		}
		#endregion
	}
}
