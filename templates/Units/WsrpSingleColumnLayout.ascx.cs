namespace development.Templates
{
	using System;
	using System.Data;
	using System.Drawing;
	using System.Web;
	using System.Web.UI.WebControls;
	using System.Web.UI.HtmlControls;

	using ElektroPost.Wsrp.Consumer.WebControls;

	using development.Templates.Wsrp.Consumer;

	/// <summary>
	///		Summary description for WsrpSingleColumnLayout.
	/// </summary>
	public class WsrpSingleColumnLayout : System.Web.UI.UserControl, IPortalLayout
	{
		protected Units.WsrpDefaultPortletArea MainPortletArea;

		private void Page_Load(object sender, System.EventArgs e)
		{
			// Put user code to initialize the page here
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

		#region IPortalLayout Members

		public PortletArea[] PortletAreas
		{
			get
			{
				return new PortletArea[] { MainPortletArea.PortletArea };
			}
		}

		string _viewMode;
		public string ViewMode
		{
			get
			{
				return _viewMode;
			}
			set
			{
				_viewMode = value;
			}
		}

		public string LayoutName 
		{
			get 
			{
				return EPiServer.Global.EPLang.Translate("/templates/wsrpfx/layouts/wsrpsinglecolumnlayout/layoutname");
			}
		}

		#endregion
	}
}
