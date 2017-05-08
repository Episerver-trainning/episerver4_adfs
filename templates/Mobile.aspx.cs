/*
Copyright © 1997-2002 ElektroPost Stockholm AB. All Rights Reserved.

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
using System.Configuration;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.Mobile;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.MobileControls;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using EPiServer;
using EPiServer.Core;
using EPiServer.Security;

namespace development.Templates
{
	/// <summary>
	/// Summary description for Mobile.
	/// </summary>
	public class Mobile : System.Web.UI.MobileControls.MobilePage,IPageSource
	{
		private void Page_Load(object sender, System.EventArgs e)
		{
			if(!IsPostBack)
				DataBind();	
		}

		#region EPiServer Member
		private PageReference _pageLink;
		protected System.Web.UI.HtmlControls.HtmlInputHidden	EPCurrentPageLink;
		#endregion
		#region EPiServer GetData
		public PageData CurrentPage
		{
			get
			{
				
				return GetPage(CurrentPageLink);
			} 
		}
		#endregion
		#region EPiServer PageData
		public PageReference CurrentPageLink
		{
			get
			{
				ParseParameters();
				return _pageLink;
			}
			set
			{
				_pageLink = value;
				if (EPCurrentPageLink != null)
					EPCurrentPageLink.Value = _pageLink.ToString();
			}
		}

		public virtual PageData GetPage(PageReference pageLink) 
		{
			return ( Global.EPDataFactory.GetPage( pageLink, RequiredAccess() ) );
		}
		
		public virtual PageDataCollection GetChildren(PageReference pageLink)
		{
			
			EPiServer.Core.PageDataCollection pageCollection= Global.EPDataFactory.GetChildren(pageLink,  RequiredAccess() );
			
			return (  pageCollection );
		}

		#endregion
		#region EPiServer Help function
		public ApplicationConfiguration Configuration
		{
			get { return Global.EPConfig; }
		}

		public virtual AccessLevel RequiredAccess()
		{
			return AccessLevel.Read;
		}
		protected virtual void ParseParameters()
		{
			try
			{
				string pageLinkString = String.Empty;

				if (EPCurrentPageLink != null)
				{
					if (EPCurrentPageLink.Value.Length == 0 && Request.Form[EPCurrentPageLink.ClientID] != null)
					{
						EPCurrentPageLink.Value = Request.Form[EPCurrentPageLink.ClientID];
					}
					pageLinkString = EPCurrentPageLink.Value;
				}
				if (pageLinkString.Length == 0)
					pageLinkString = Request.QueryString["id"];

				_pageLink	= PageReference.Parse( pageLinkString );
			}
			catch
			{
			}

			if (_pageLink.IsEmpty())
			{
				if (Configuration != null)
				{
					_pageLink = Configuration.StartPage;
				}
			}
			else
				CurrentPageLink = _pageLink;

		}

		#endregion
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
