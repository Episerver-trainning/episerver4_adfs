namespace development.Templates.Units
{
	using System;
	using System.Text;
	using System.Data;
	using System.Drawing;
	using System.Web;
	using System.Web.UI.WebControls;
	using System.Web.UI.HtmlControls;
	using EPiServer;
	using EPiServer.Core;

	/// <summary>
	///		"BreadCrumb" control displaying a link trail from the start page to the current page.
	///		The user of the control can configure several settings to adapt the rendering:
	///		- Separator:		displayed between links
	///		- StartPageName:	to control the name of the start page link, such as "Home"
	///							Also supports xpath strings to translate
	///		- MaxWordLength:	abbreviates words longer than this setting - 0 means no abbreviation
	///		- CssClass:			class to use on the links and text of the breadcrumb
	/// </summary>
	public class BreadCrumbs : EPiServer.UserControlBase
	{
		protected	Label	breadCrumbTrail;
		private		String	_separatorChar	= " / ";
		private		String	_startPageName	= String.Empty;
		private		String	_cssClass		= String.Empty;
		private		int		_maxWordLength	= 30;

		public String Separator
		{
			get { return _separatorChar;  }
			set { _separatorChar = value; }
		}
		public String StartPageName
		{
			get { return _startPageName.StartsWith("/") ? Translate(_startPageName) : _startPageName; }
			set { _startPageName = value; }
		}
		public int MaxWordLength
		{
			get { return _maxWordLength;  }
			set { _maxWordLength = value; }
		}
		public String CssClass
		{
			get 
			{ 
				if(_cssClass.Length > 0)
					return " class=\"" + _cssClass + "\"";
				else return String.Empty;
			}
			set { _cssClass = value; }
		}

		private void Page_Load(object sender, System.EventArgs e)
		{
			// Do not display a breadcrumb trail on the start page
			if(CurrentPage.PageLink == Configuration.StartPage)
				return;
			
			PageData breadCrumbPage;
			StringBuilder htmlString = new StringBuilder(50);

			htmlString.Insert(0, "<span" + this.CssClass + ">" + Server.HtmlEncode(CurrentPage.PageName) + "</span>");

			PageReference parentReference = CurrentPage.ParentLink;
			while(parentReference != PageReference.EmptyReference && parentReference != Configuration.RootPage)
			{
				breadCrumbPage = GetPage(parentReference);
				htmlString.Insert(0, this.Separator);
				htmlString.Insert(0, CreatePageLink(breadCrumbPage));
				parentReference = breadCrumbPage.ParentLink;
			}
			breadCrumbTrail.Text = htmlString.ToString();
		}

		private String CreatePageLink(PageData pageObject)
		{
			String pageDisplayName;
			if(pageObject.PageLink == Configuration.StartPage && this.StartPageName.Length > 0)
				pageDisplayName = this.StartPageName;
			else
				pageDisplayName = Abbreviated(pageObject.PageName);
			return "<a href=\"" + pageObject.LinkURL + "\"" + this.CssClass + ">" + Server.HtmlEncode(pageDisplayName) + "</a>";
		}

		private String Abbreviated(String pageName)
		{	// Abbreviate page names if they are longer than the MaxWordLength attribute (0 disables abbreviation)
			if(MaxWordLength == 0 || pageName.Length <= MaxWordLength)
				return pageName;
			else
				return pageName.Substring(0, this.MaxWordLength-3) + "...";
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
