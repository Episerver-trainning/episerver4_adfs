using System;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

using EPiServer;
using EPiServer.Core;
using EPiServer.WebControls;
using EPiServer.Util;

using ElektroPost.Wsrp;
using ElektroPost.Wsrp.V1.Types;

using development.Templates.Wsrp.Core;

namespace development.Templates.Wsrp.PortletControls
{
	/// <summary>
	///		Summary description for MyControl.
	/// </summary>
	public abstract class WsrpInfoServiceControl : WsrpUserControlBase
	{
		protected Label namelabel;
		protected PlaceHolder mainview;
		protected PlaceHolder configurationview;
		protected PlaceHolder content;
		protected PlaceHolder singlepage;
		protected PlaceHolder pagelist;

		protected PageDataCollection _pages;
		protected PageDataCollection _pageSources;

		protected PageList			ContentList;
		protected PageList			SourceList;

		private void Page_Load(object sender, System.EventArgs e)
		{
		}

		private void WsrpInfoServiceControl_BlockingInteraction(object sender, BlockingInteractionEventArgs e)
		{
			// Check if the configuration has been saved
			String submit = EmptyAsNull(e.GetParameter("submit"));
			if (submit != null)
			{
				try
				{
					Int32 pageId					= Int32.Parse(e.GetParameter("selectedpageid"));
					PortletState["selectedpageid"]	= pageId;

					// Remember this as the nav state for our portlet
					e.Response.updateResponse.navigationalState = pageId.ToString();
				}
				catch (SystemException)
				{
					PortletState["selectedpageid"]	= null;
				}

				PortletState["showsinglepage"]		= EmptyAsNull(e.GetParameter("showsinglepage"));
				PortletState["thetitle"]			= EmptyAsNull(e.GetParameter("thetitle"));
				PortletState["listwidth"]			= EmptyAsNull(e.GetParameter("listwidth"));

				// Always switch to view mode after saving edit mode parameters
				e.Response.updateResponse.newMode	= Constants.ModeView;
			}

			// Signal the currently selected page to other portlets in the same group via GroupSession
			if (CurrentMarkupParams.navigationalState != null && CurrentMarkupParams.navigationalState.Length > 0)
			{
				PageData p = GetPage(new PageReference(CurrentMarkupParams.navigationalState));
				GroupSession["showpage"] = UrlUtility.ResolveHostUrl() + p.LinkURL;
			}

			e.ReturnMarkup = true;
		}

		private void WsrpInfoServiceControl_PreRender(object sender, EventArgs e)
		{
			// Show customized portlet title
			// Note that if PortletState contains no information about "thetitle" it will return null.
			// The default  value of preferredTitle is null which means "use regular title"
			CurrentMarkupContext.preferredTitle = (String)PortletState["thetitle"];

			// Determine if we should show the settings or not (show if edit mode or no start page is set)
			configurationview.Visible = PortletState["selectedpageid"] == null || CurrentDisplayMode == Constants.ModeEdit;
			mainview.Visible = !configurationview.Visible;

			// If edit mode displayed
			if (configurationview.Visible)
			{
				SourceList.DataSource = PageListSources;
				configurationview.DataBind();
				return;
			}

			// Determine which parts in regular mode will be displayed
			pagelist.Visible	= true;
			content.Visible		= true;

			// Normal state (the default) will show either list or content
			if (CurrentMarkupParams.windowState == Constants.WindowStateNormal)
			{
				// In normal state, show content if Show single page is enabled, otherwise show list
				content.Visible = (String)PortletState["showsinglepage"] == "on";
				pagelist.Visible = !content.Visible;
			}

			// If no navigational state is set, pretend that selectedpageid is the current navstate
			if (content.Visible && CurrentMarkupParams.navigationalState == null)
			{
				CurrentPage = GetPage(new PageReference((Int32)PortletState["selectedpageid"]));
			}

			// Do data binding
			if (ContentList.Visible)
			{
				ContentList.DataSource = Pages;	
			}
			mainview.DataBind();
		}

		// Get the list of potential start pages for edit mode
		public PageDataCollection PageListSources
		{
			get
			{
				if (_pageSources == null)
				{
					_pageSources	= new PageDataCollection();

					PropertyCriteria criteria = new PropertyCriteria();

					criteria.Type = PropertyDataType.Boolean;
					criteria.Name = "InformationChannel";
					criteria.Value = "true";
					criteria.Condition = EPiServer.Filters.CompareCondition.Equal;

					PropertyCriteriaCollection col = new PropertyCriteriaCollection();
					col.Add(criteria);
					_pageSources = Global.EPDataFactory.FindPagesWithCriteria(Global.EPConfig.StartPage, col);
				}
				return _pageSources;
			}
		}

		// Get pages to be displayed
		public PageDataCollection Pages
		{
			get
			{ 
				if (_pages == null)
				{
					_pages	= new PageDataCollection();
					if (PortletState["selectedpageid"] != null)
					{
						// Validation of contents was done when setting the data. If something is wrong - just let it blow up
						int id = (Int32)PortletState["selectedpageid"];
						_pages.Add(Global.EPDataFactory.GetPage( new PageReference( id ) ));
						_pages.Add(Global.EPDataFactory.GetChildren( new PageReference( id ) ));
					}				
				}
				return _pages; 
			}
		}

		public string GetStyle()
		{
			if (CurrentMarkupParams.windowState == Constants.WindowStateNormal)
				return " width:100%; ";

			string width = (String)PortletState["listwidth"];
			if (width == null || width.Length == 0)
				width = "300";

			return " width:" + width + "px; padding-right:0.8em; margin-right:0.8em ; border-right: gray 1px solid; ";
		}

		public string IsSelected(int id)
		{
            if (ShowPageAsSelected(id))
            {
                return " checked=\"true\" ";
            }
            return String.Empty;
		}

        private bool ShowPageAsSelected(int id)
        { 
            object portletState = PortletState["selectedpageid"];

            // If testing the page stored in portlet state it should be selected (result of previous selection)
            if (id.Equals(portletState))
                return true;

            // If no previous selection (portletState is null) and it is the first page in the list, set it as default selection
            return portletState == null && PageListSources[0].PageLink.ID == id;
        }

		
		public string IsChecked()
		{
			if ((String)PortletState["showsinglepage"] == "on")
				return " checked=\"true\" ";
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
			BlockingInteraction += new BlockingInteractionEventHandler(WsrpInfoServiceControl_BlockingInteraction);
			PreRender += new EventHandler(WsrpInfoServiceControl_PreRender);
		}
		#endregion
	}
}
