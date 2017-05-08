using System;
using System.Collections;
using System.Collections.Specialized;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using EPiServer;
using EPiServer.Core;
using EPiServer.DataAbstraction;
using EPiServer.PlugIn;
using EPiServer.Security;
using EPiServer.WebControls;
using EPiServer.Util;
using development.Templates.Workrooms.Core;

namespace development.Templates.Workrooms.Templates.Units
{
	/// <summary>
	///	The Document tab.
	/// </summary>
	[GuiPlugIn(	Area=PlugInArea.WorkRoom,
				Url="~/templates/Workroom/Templates/Units/Document.ascx",SortIndex=2000, 
				LanguagePath="/templates/workroom/plugins/document")]
	public class Document : WorkroomControlBase, ICustomPlugInLoader, ICustomPlugInDataLoader, IWorkroomPlugin
	{
		protected FileManager	Browser;

		private void Page_Load(object sender, EventArgs e)
		{
			if(!IsPostBack)
				DataBind();
		}

		#region IWorkroomPlugin implementation
		string IWorkroomPlugin.Name
		{
			get { return DisplayName; }
		}

		Boolean IWorkroomPlugin.IsActive
		{
			get
			{
				return CurrentPage["IsActiveFileList"] != null && (bool)CurrentPage["IsActiveFileList"] == true;
			}
			set
			{
				if (!CurrentPage.Property.Exists("IsActiveFileList"))
				{
					CurrentPage.Property.Add("IsActiveFileList", new PropertyBoolean(value));
				}
				else
					CurrentPage["IsActiveFileList"] = value;
			}
		}

		Boolean IWorkroomPlugin.IsActiveEditable
		{
			get { return true; }
		}

		Boolean IWorkroomPlugin.IsInitialized
		{
			get { return CurrentPage["FileRoot"] != null; }
		}
		#endregion

		public void Data_Load(object sender, EventArgs e)
		{
			Browser.RootDirectory = CurrentWorkroom.FileRoot;
			Browser.DataBind();
		}

		public PlugInDescriptor[] List()
		{
			return GetPlugInDescriptor();
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