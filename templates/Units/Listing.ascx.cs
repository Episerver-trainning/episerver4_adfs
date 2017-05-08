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
using EPiServer;
using EPiServer.Core;

namespace development.Templates.Units
{
	/// <summary>
	///		Summary description for Listing.
	/// </summary>
	public abstract class Listing : UserControlBase
	{
		protected EPiServer.WebControls.NewsList NewsListControl;
		private readonly string _evenCssClass = "evenrow", _unevenCssClass = "unevenrow";
		private bool _evenRow;

		private void Page_Load(object sender, System.EventArgs e)
		{
			if (!IsValue("ListingContainer"))
			{
				Controls.Clear();
				return;
			}

			if (IsValue("ListingType"))
				NewsListControl.PageTypeID = (int)CurrentPage["ListingType"];

			if (!IsPostBack)
				NewsListControl.DataBind();
		}

		protected int GetCount()
		{
			if (!IsValue("ListingCount"))
				return -1;
			return (int)CurrentPage["ListingCount"];
		}

		protected string GetCssClass(bool changeClass)
		{
			if (changeClass)
				_evenRow = !_evenRow;

			return _evenRow ? _evenCssClass : _unevenCssClass;
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
