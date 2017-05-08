namespace development.Templates.Units
{
	using System;
	using System.Web.Configuration;
	using EPiServer;
	using EPiServer.WebControls;

	/// <summary>
	///		Summary description for CookieInfo.
	/// </summary>
	public abstract class CookieInfo : UserControlBase
	{
		public String CookieLoginTypeInfo
		{
			get
			{
				if (Configuration.Authentication == AuthenticationMode.Forms)
					return "/cookie/usageloginform";
				else
					return "/cookie/usageloginwindows";
			}
		}

		private void Page_Load(object sender, System.EventArgs e)
		{
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
