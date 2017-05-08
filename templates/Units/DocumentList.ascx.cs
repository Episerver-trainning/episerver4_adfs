using System;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Text;
using System.IO;
using EPiServer;
using EPiServer.Core;
using EPiServer.FileSystem;
using EPiServer.Security;


namespace development.Templates.Units
{	
	/// <summary>
	///		Summary description for DocumentList.
	/// </summary>
	public class DocumentList : UserControlBase
	{
		protected EPiServer.WebControls.PageList ListControl;
		private bool _evenRow;

		private void Page_Load(object sender, System.EventArgs e)
		{
			if (!IsPostBack)
				ListControl.DataBind();
		}

		protected string CreateDocumentLink(PageData page)
		{
			if(CurrentPage["DisplayDownloadLink"]==null)
				return String.Empty;

			string internalPath			= page.Property["DocumentInternalPath"].ToString();
			string internalHtmlPath		= page.Property["DocumentInternalHtmlPath"].ToString();
			string externalPath			= page.Property["DocumentExternalPath"].ToString();
			
			HtmlAnchor link = new HtmlAnchor();
			link.HRef = internalPath;
			link.Visible = internalPath.Length > 0;
			link.Title = Translate("/templates/documentlist/download");
			link.Target = "_blank";

			HtmlImage img = new HtmlImage();
			img.Src = Global.EPConfig.RootDir + "Util/Images/Extensions/default.gif";
			img.Attributes.Add("class","borderless");

			string extension = System.IO.Path.GetExtension(internalPath);
			if(extension!=null && extension.Length>0)
			{
				extension = extension.Substring(1);
				string extSrc = Global.EPConfig.RootDir + "Util/Images/Extensions/" + extension + ".gif"; 
				if(System.IO.File.Exists(Page.Server.MapPath(extSrc)))
					img.Src = extSrc;
			}
			link.Controls.Add(img);

			StringWriter w = new StringWriter();
			HtmlTextWriter html = new HtmlTextWriter(w);
			link.RenderControl(html);

			if(internalPath.Length > 0)
			{
				UnifiedFile file = UnifiedFileSystem.GetFile(internalPath);
				if(file!=null)
				{
					return w.ToString() + "  (" + FormatSizeForDisplay(file.Length) + ")";
				}
			}

			return w.ToString();
		}

		private string FormatSizeForDisplay(long byteSize)
		{	   
			if (byteSize < 1024)
				return byteSize.ToString() + " bytes";
			else if (byteSize < (1024*1024))
				return Convert.ToInt32(byteSize / 1024) + " Kb";
			else 
				return Convert.ToInt32(byteSize / (1024*1024)) + " Mb";
		}

		protected string GetClass()
		{
			_evenRow = !_evenRow;
			if(_evenRow)
				return "DocumentListItem";
			else
				return "DocumentListItemAlt";

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
