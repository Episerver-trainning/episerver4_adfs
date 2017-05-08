using System;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using development.Templates.Wsrp.Core;

using EPiServer.FileSystem;

namespace development.Templates.Wsrp.PortletControls
{
	/// <summary>
	///		Summary description for wsrpImageViewer.
	/// </summary>
	public class wsrpImageViewer : development.Templates.Wsrp.Core.WsrpUserControlBase
	{

		protected PlaceHolder Edit, View;
		protected Repeater ImageList;
		protected HtmlImage Image;

		protected int ThumbnailSize 
		{
			get { return this.PortletState["thumbSize"] != null ? (int) this.PortletState["thumbSize"] : 50; }
		}
		protected string SelectedPath 
		{
			get { return this.PortletState["path"] != null ? (string) this.PortletState["path"] : "/upload/"; }
		}

		protected EPiServer.FileSystem.UnifiedFile SelectedImage 
		{
			get 
			{ 
				string path = PortletState["selectedImage"] != null ? (string) PortletState["selectedImage"] : ImageFiles[0].Path;
				foreach (UnifiedFile file in ImageFiles) 
				{
					if (file.Path == path) return file;
				}
				return null;
			}
		}

		protected EPiServer.FileSystem.UnifiedFile NextImage 
		{
			get 
			{ 
				System.Collections.ArrayList list = new System.Collections.ArrayList(ImageFiles);
				int idx = list.IndexOf( SelectedImage );
				return (UnifiedFile) list[(idx + 1)%list.Count];
			}
		}


		UnifiedFile[] _imageFiles;
		protected UnifiedFile[] ImageFiles
		{
			get 
			{
				if (_imageFiles == null) 
				{
					UnifiedDirectory directory = UnifiedDirectory.Get( SelectedPath );
					_imageFiles = directory.GetFiles("*.jpg");
				}
				return _imageFiles;
			}
		}

		private void Page_Load(object sender, System.EventArgs e)
		{
			SetDisplayMode(View, Edit);
			ImageList.DataSource = ImageFiles;
			ImageList.DataBind();
		}

		private void wsrpImageViewer_BlockingInteraction(object sender, BlockingInteractionEventArgs e)
		{
			if ( e.GetParameter("submit") != null ) 
			{
				PortletState["path"] = e.GetParameter("path");
				PortletState["thumbSize"] = Int32.Parse(e.GetParameter("thumbSize"));
				PortletState["selectedImage"] = null;
				_imageFiles = null;
			}
			else if (e.GetParameter("ep-orgUrl") != null) 
			{
				PortletState["selectedImage"] = e.GetParameter("ep-orgUrl");
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
		///		Required method for Designer support - do not modify
		///		the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
			this.Load += new System.EventHandler(this.Page_Load);
			this.BlockingInteraction +=new development.Templates.Wsrp.Core.BlockingInteractionEventHandler(wsrpImageViewer_BlockingInteraction);
		}
		#endregion
	}
}
