using System;
using System.Collections;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

using EPiServer;
using EPiServer.Core;
using EPiServer.DataAbstraction;
using EPiServer.Filters;
using EPiServer.WebControls;

using ElektroPost.Wsrp;
using ElektroPost.Wsrp.V1.Types;

using development.Templates.Wsrp.Core;

namespace development.Templates.Wsrp.PortletControls
{
	/// <summary>
	///		Summary description for MyControl.
	/// </summary>
	public class WsrpNewsChannelControl : WsrpUserControlBase
	{
		protected EPiServer.WebControls.NewsList NewsListControl;
		protected PageList SourceList;
		protected PageList ContentList;
		protected PlaceHolder mainview;
		protected PlaceHolder configurationview;
		private PageDataCollection _pagelist;

		private void Page_Load(object sender, System.EventArgs e)
		{
		}

		private void WsrpNewsChannelControl_BlockingInteraction(object sender, BlockingInteractionEventArgs e)
		{
			String submit = EmptyAsNull(e.GetParameter("submit"));
			if (submit != null)
			{
				// Get a list of the selected pages for our news channel
				ArrayList selectedPages = new ArrayList();
				NamedString[] parameters = e.Request.interactionParams.formParameters;
				for (int i = 0; i < parameters.Length ; i++)
				{
					if (parameters[i].name.StartsWith("cbox"))
					{
						try
						{
							// Get the page id as an integer
							Int32 pageId = Int32.Parse(parameters[i].name.Remove(0, 4));
							selectedPages.Add(pageId);
						}
						catch (SystemException)
						{
							// Invalid number - ignore it
						}
					}				
				}

				// Save the new settings
				PortletState["selectedpages"]		= selectedPages.ToArray(typeof(Int32));
				PortletState["thetitle"]			= EmptyAsNull(e.GetParameter("thetitle"));
				PortletState["themaxcount"]			= EmptyAsNull(e.GetParameter("themaxcount"));

				// Always switch to view mode after saving edit mode parameters
				e.Response.updateResponse.newMode	= Constants.ModeView;
			}

			e.ReturnMarkup = true;
		}

		private void WsrpNewsChannelControl_PreRender(object sender, EventArgs e)
		{
			// Show customized portlet title
			// Note that if PortletState contains no information about "thetitle" it will return null.
			// The default  value of preferredTitle is null which means "use regular title"
			CurrentMarkupContext.preferredTitle = (String)PortletState["thetitle"];

			// Select parts to show based on CurrentDisplayMode
			SetDisplayMode(mainview, configurationview);

			// If normal mode
			if (mainview.Visible)
			{
				// Set up our sort filter
				ContentList.Filter  += new FilterEventHandler(SortPagesFilter);
				ContentList.DataSource = NewsListContent;

				// Databind the view
				mainview.DataBind();
				return;
			}

			// Is edit mode
			SourceList.DataSource = NewsListSource;
			configurationview.DataBind();
		}

		public PageDataCollection NewsListSource
		{
			get
			{
				PropertyCriteria criteria = new PropertyCriteria();

				criteria.Type = PropertyDataType.PageType;
				criteria.Name = "PageTypeID";
				criteria.Value = PageType.Load("News list").ID.ToString();
				criteria.Condition = EPiServer.Filters.CompareCondition.Equal;

				PropertyCriteriaCollection col = new PropertyCriteriaCollection();
				col.Add(criteria);

				return Global.EPDataFactory.FindPagesWithCriteria(Global.EPConfig.StartPage, col);
			}
		}

		public PageDataCollection NewsListContent
		{
			get
			{
				if (_pagelist == null)
				{
					_pagelist = new PageDataCollection();
					foreach (int pageId in SelectedPages)
					{
						_pagelist.Add(GetChildren(new PageReference(pageId)));
					}
				}
				return _pagelist;
			}
		}

		public Int32[] SelectedPages
		{
			get
			{
				Int32[] selectedPages = (Int32[])PortletState["selectedpages"];
				if (selectedPages != null)
					return selectedPages;
				return new Int32[0];
			}
		}

		private class SortPagesComparer : IComparer
		{
			public int Compare(object firstObject, object secondObject)
			{
				PageData firstPage = (PageData)firstObject;
				PageData secondPage = (PageData)secondObject;
				return secondPage.Changed.CompareTo(firstPage.Changed);
			}
		}

		private void SortPagesFilter(object sender, FilterEventArgs e)
		{
			PageDataCollection pages = e.Pages;
			pages.Sort(new SortPagesComparer());
		}

		public string IsChecked(object iid)
		{
			int id = (Int32)iid;
			foreach (int pageId in SelectedPages)
			{
				if (pageId == id)
					return " checked=\"true\" ";
			}
			return String.Empty;
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
		///		Required method for Designer support - do not modify
		///		the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
			this.Load += new System.EventHandler(this.Page_Load);
			BlockingInteraction += new BlockingInteractionEventHandler(WsrpNewsChannelControl_BlockingInteraction);
			PreRender += new EventHandler(WsrpNewsChannelControl_PreRender);
		}
		#endregion

	}
}
