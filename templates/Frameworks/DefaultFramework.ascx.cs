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
using System.Drawing;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using EPiServer;

namespace development.Frameworks
{
	/// <summary>
	///		Summary description for DefaultFramework.
	/// </summary>
	public abstract class DefaultFramework : EPiServer.WebControls.ContentFramework
	{
		protected development.Templates.Units.TopMenu	TopMenu;
		protected development.Templates.Units.Menu		LeftMenu;

		protected string HeaderImage
		{
			get
			{
				PageBase page = (PageBase)Page;

				if (page.CurrentPage.Property.Exists("HeaderImage"))
					return (string)page.CurrentPage["HeaderImage"];
				return page.Configuration.RootDir + "images/header.gif";
			}
		}
		protected string HeaderImageDescription
		{
			get
			{
				PageBase page = (PageBase)Page;

				if (page.CurrentPage.Property.Exists("HeaderImageDescription"))
					return (string)page.CurrentPage["HeaderImageDescription"];
				return Translate("/common/headerimagedescription");
			}
		}
		private void Page_Init(object sender, System.EventArgs e)
		{
			if(TopMenu != null && LeftMenu != null)
			{
				LeftMenu.MenuListControl = TopMenu.MenuListControl;
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
		
		///		Required method for Designer support - do not modify
		///		the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
			this.Init += new System.EventHandler(this.Page_Init);
		}
		#endregion
	}
}
