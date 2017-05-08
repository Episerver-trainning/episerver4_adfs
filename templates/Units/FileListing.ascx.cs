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
using EPiServer;
using EPiServer.Core;
using EPiServer.WebControls;
using System;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace development.Templates.Units
{	
	/// <summary>
	///		Summary description for FileListing.
	/// </summary>
	public abstract class FileListing : UserControlBase
	{
		protected Label ErrorMessage;
		protected EPiServer.WebControls.UnifiedFileTree FileList;

		private void Page_Load(object sender, System.EventArgs e)
		{
			if(!IsPostBack)
			{
				if(!IsValue("WebBaseURL"))
				{
					ErrorMessage.Visible	= true;
					FileList.Visible		= false;
				}
				DataBind();
			}
		}
		protected FileSortOrder GetSortOrder()
		{
			try
			{
				return(FileSortOrder)CurrentPage["SortFileBy"];
			}
			catch(Exception)
			{
				return FileSortOrder.None;
			}				
		}
		protected string CreateIndentStructure(int indent)
		{
			string returnString = string.Empty;

			for(int i = 1 ; i < indent ; i++)
			{
				returnString += "<img class=\"borderless\" align=\"absbottom\" src=\"" + Configuration.RootDir + "util/images/filetree/I.gif\" alt=\"\" />";
			}
			return returnString;
		}
		protected string GetExpandImage(bool hasChildren, bool isExpanded, bool isLastInIndent)
		{
			string rootPath = Configuration.RootDir + "util/images/filetree/";
			if(hasChildren)
			{
				if(isLastInIndent)
					return rootPath + (isExpanded?"L-.gif":"L+.gif");
				else
					return rootPath + (isExpanded?"T-.gif":"T+.gif");
			}
			else
			{
				if(isLastInIndent)
					return rootPath + "L.gif";
				else
					return rootPath + "T.gif";
			}
		}
		protected string GetExtensionImage(string extension)
		{
			string rootPath = Configuration.RootDir + "util/images/extensions/";
			switch(extension.ToLower())
			{
				case ".bmp":
				case ".doc":
				case ".gif":
				case ".htm":
				case ".html":
				case ".jpeg":
				case ".jpg":
				case ".pdf":
				case ".ppt":
				case ".tiff":
				case ".xls":
					return rootPath + extension.Substring(1) + ".gif";
				default:
					return rootPath + "default.gif";
			}
		}
		protected string GetFolderImage(bool IsExpanded)
		{
			string rootPath = Configuration.RootDir + "util/images/filetree/";
	
			if (IsExpanded)
				return rootPath + "folder_open.gif";
			return rootPath + "folder.gif";
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
		}
		#endregion
	}
}
