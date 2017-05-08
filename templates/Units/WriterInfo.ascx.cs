/*
Copyright � 1997-2004 ElektroPost Stockholm AB. All Rights Reserved.

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
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using EPiServer;
using EPiServer.Core;

namespace development.Templates.Units
{	

	/// <summary>
	///		Summary description for WriterInfo.
	/// </summary>
	public abstract class WriterInfo : UserControlBase
	{
		protected Panel		WriterArea;

		private void Page_Load(object sender, System.EventArgs e)
		{
			if(!IsValue("WriterName"))
				return;

			Label creator		= new Label();
			creator.Text		= Server.HtmlEncode((string)CurrentPage["WriterName"]) + "&nbsp;";
			
			Label publishedDate	= new Label();
			publishedDate.Text	= CurrentPage.Saved.ToString();

			WriterArea.Controls.Add(creator);
			WriterArea.Controls.Add(publishedDate);
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
