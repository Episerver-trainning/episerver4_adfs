using System;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using EPiServer;
using EPiServer.Core;
using EPiServer.FileSystem;
using EPiServer.Security;
using EPiServer.WebControls;


namespace development.Templates.Units
{	
	/// <summary>
	///		Summary description for DocumentList.
	/// </summary>
	public class Document : UserControlBase
	{
		protected HtmlGenericControl contentFrame;

		private void Page_Load(object sender, System.EventArgs e)
		{
			TemplatePage tp = (TemplatePage)Page;

			string internalPath			= CurrentPage.Property["DocumentInternalPath"].ToString();
			if(internalPath.Length > 0)
			{
				string extension = System.IO.Path.GetExtension(internalPath);
				contentFrame.Attributes["class"] = extension.ToUpper().Substring(1) + "FrameStyle";
			}
			if(CurrentPage["DocumentInternalHtmlPath"]!=null)
				contentFrame.Attributes["src"] = CurrentPage["DocumentInternalHtmlPath"].ToString();
			else
				contentFrame.Attributes["src"] = "about:blank";
				

			if(!IsPostBack)
				DataBind();
			
		}

		public string ParentLinkURL
		{
			get{return GetPage(CurrentPage.ParentLink).LinkURL;}
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
